/** @type {import("prettier").Config} */
const config = {
  tabWidth: 2,
  useTabs: false,
  goTemplateBracketSpacing: true,
  tailwindConfig: "./themes/blowfish/tailwind.config.js",
  plugins: [
    import("prettier-plugin-tailwindcss"),
    import("prettier-plugin-go-template"),
  ],
  overrides: [
    {
      files: ["layouts/**/*.html", "layouts/**/*.json"],
      options: {
        parser: "go-template",
      },
    },
  ],
};

module.exports = config;
