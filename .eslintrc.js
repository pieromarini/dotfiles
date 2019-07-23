module.exports = {
    env: {
        browser: true,
        jquery: true,
		amd: true,
		es6: true
    },
    extends: "eslint:recommended",
    rules: {
        indent: ["error", "tab"],
        "linebreak-style": ["error", "unix"],
        quotes: ["error", "single"],
        semi: ["error", "never"],
        'no-console': 'off',
    },
    "parser": "babel-eslint"
};
