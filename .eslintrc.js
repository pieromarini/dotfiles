module.exports = {
  env: {
    browser: true,
    jquery: true
  },
  extends: "eslint:recommended",
  rules: {
    indent: ["error", 4],
    "linebreak-style": ["error", "unix"],
    quotes: ["error", "single"],
    semi: ["error", "never"],
      'no-console': 'off',
  },
  "parser": "babel-eslint"
};
