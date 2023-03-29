/** @type {import('tailwindcss').Config} */
module.exports = {
  content: {
    relative: true,
    files: ["./src/**/*.{html,js,jsx,ts,tsx}", "./purs/**/*.purs"]
  },
  theme: {
    extend: {}
  },
  plugins: []
};
