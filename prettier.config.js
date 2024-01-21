/** @type {import("prettier").Config} */
const config = {
  tabWidth: 2,
  useTabs: false,
  goTemplateBracketSpacing: true,
  tailwindConfig: "./themes/blowfish/tailwind.config.js",
  plugins: ["prettier-plugin-tailwindcss", "prettier-plugin-go-template"],
  overrides: [
    {
      files: ["layouts/**/*.html", "layouts/**/*.json"],
      options: {
        parser: "go-template",
      },
    },
    {
      files: ["content/**/*.md"],
      options: {
        proseWrap: "always",
      },
    },
  ],
};

module.exports = config;
