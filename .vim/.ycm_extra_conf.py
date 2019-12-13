from distutils.sysconfig import get_python_inc
import platform
import os.path as p
import subprocess
import ycm_core


flags = [
    '-Wall',
    '-Wextra',
    '-Wshadow',
    '-Wpedantic',
    '-Wold-style-cast',
    '-Wcast-align',
    '-Wunused',
    '-Wnull-dereference',
    '-Wdouble-promotion',
    '-Wformat=2',
    '-Wduplicated-cond',
    '-Wduplicated-branches',
    '-Wuseless-cast',
    '-Wnon-virtual-dtor',
    '-Woverloaded-virtual',
    '-Wno-variadic-macros',
    '-fexceptions',
    '-ferror-limit=10000',
    '-DNDEBUG',
    '-std=c++17',
    '-xc++',
    '-isystem', '/usr/local/include',
    '-isystem', '/usr/local/include/eigen3',
    '-isystem', '/usr/include/c++/',
    '-I',
    'include',
    '-I.',
    '-I/usr/lib/',
    '-I/usr/local/include/',
    '-I/usr/lib/clang/6.0.0/include',
    '-I/usr/include/'
]

DIR_OF_THIS_SCRIPT = p.abspath(p.dirname( __file__))
DIR_OF_THIRD_PARTY = p.join(DIR_OF_THIS_SCRIPT, 'third_party')
SOURCE_EXTENSIONS = [ '.cpp', '.cxx', '.cc', '.c', '.m', '.mm' ]

if platform.system() != 'Windows':
  flags.append('-std=c++11')


compilation_database_folder = ''

if p.exists(compilation_database_folder):
  database = ycm_core.CompilationDatabase(compilation_database_folder)
else:
  database = None


def IsHeaderFile(filename):
  extension = p.splitext(filename)[ 1 ]
  return extension in [ '.h', '.hxx', '.hpp', '.hh' ]


def FindCorrespondingSourceFile(filename):
  if IsHeaderFile(filename):
    basename = p.splitext(filename)[ 0 ]
    for extension in SOURCE_EXTENSIONS:
      replacement_file = basename + extension
      if p.exists(replacement_file):
        return replacement_file
  return filename


def PathToPythonUsedDuringBuild():
  try:
    filepath = p.join(DIR_OF_THIS_SCRIPT, 'PYTHON_USED_DURING_BUILDING')
    with open(filepath) as f:
      return f.read().strip()
  # We need to check for IOError for Python 2 and OSError for Python 3.
  except (IOError, OSError):
    return None


def Settings(**kwargs):
  language = kwargs[ 'language' ]

  if language == 'cfamily':
    # If the file is a header, try to find the corresponding source file and
    # retrieve its flags from the compilation database if using one. This is
    # necessary since compilation databases don't have entries for header files.
    # In addition, use this source file as the translation unit. This makes it
    # possible to jump from a declaration in the header file to its definition
    # in the corresponding source file.
    filename = FindCorrespondingSourceFile(kwargs[ 'filename' ])

    if not database:
      return {
        'flags': flags,
        'include_paths_relative_to_dir': DIR_OF_THIS_SCRIPT,
        'override_filename': filename
      }

    compilation_info = database.GetCompilationInfoForFile(filename)
    if not compilation_info.compiler_flags_:
      return {}

    # Bear in mind that compilation_info.compiler_flags_ does NOT return a
    # python list, but a "list-like" StringVec object.
    final_flags = list(compilation_info.compiler_flags_)

    # NOTE: This is just for YouCompleteMe; it's highly likely that your project
    # does NOT need to remove the stdlib flag. DO NOT USE THIS IN YOUR
    # ycm_extra_conf IF YOU'RE NOT 100% SURE YOU NEED IT.
    try:
      final_flags.remove('-stdlib=libc++')
    except ValueError:
      pass

    return {
      'flags': final_flags,
      'include_paths_relative_to_dir': compilation_info.compiler_working_dir_,
      'override_filename': filename
    }

  if language == 'python':
    return {
      'interpreter_path': PathToPythonUsedDuringBuild()
    }

  return {}


def GetStandardLibraryIndexInSysPath(sys_path):
  for index, path in enumerate(sys_path):
    if p.isfile(p.join( path, 'os.py')):
      return index
  raise RuntimeError('Could not find standard library path in Python path.')


def PythonSysPath(**kwargs):
  sys_path = kwargs[ 'sys_path' ]

  interpreter_path = kwargs[ 'interpreter_path' ]
  major_version = subprocess.check_output([
    interpreter_path, '-c', 'import sys; print(sys.version_info[ 0 ])' ]
).rstrip().decode( 'utf8')

  sys_path.insert(GetStandardLibraryIndexInSysPath( sys_path) + 1,
                   p.join(DIR_OF_THIRD_PARTY, 'python-future', 'src'))
  sys_path[ 0:0 ] = [ p.join(DIR_OF_THIS_SCRIPT),
                      p.join(DIR_OF_THIRD_PARTY, 'bottle'),
                      p.join(DIR_OF_THIRD_PARTY, 'cregex',
                              'regex_{}'.format(major_version)),
                      p.join(DIR_OF_THIRD_PARTY, 'frozendict'),
                      p.join(DIR_OF_THIRD_PARTY, 'jedi_deps', 'jedi'),
                      p.join(DIR_OF_THIRD_PARTY, 'jedi_deps', 'numpydoc'),
                      p.join(DIR_OF_THIRD_PARTY, 'jedi_deps', 'parso'),
                      p.join(DIR_OF_THIRD_PARTY, 'requests_deps', 'requests'),
                      p.join(DIR_OF_THIRD_PARTY, 'requests_deps',
                                                  'urllib3',
                                                  'src'),
                      p.join(DIR_OF_THIRD_PARTY, 'requests_deps',
                                                  'chardet'),
                      p.join(DIR_OF_THIRD_PARTY, 'requests_deps',
                                                  'certifi'),
                      p.join(DIR_OF_THIRD_PARTY, 'requests_deps',
                                                  'idna'),
                      p.join(DIR_OF_THIRD_PARTY, 'waitress') ]

  return sys_path
