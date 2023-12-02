/** @type {import('tailwindcss').Config} */

import generated from "@tailwindcss/forms";

import generated0 from "@tailwindcss/aspect-ratio";

import generated01 from "@tailwindcss/typography";

import generated012 from "@tailwindcss/container-queries";

import defaultTheme from "tailwindcss/defaultTheme";

module.exports = {
  content: [
    './app/views/**/*.html.erb',
    './app/helpers/**/*.rb',
    './app/assets/stylesheets/**/*.css',
    './app/javascript/**/*.js'
  ],
  safelist: [
  'bg-green-500',
  'text-white',
  'px-4',
  'py-2',
  'fixed',
  'w-full',
  'top-0',
  'left-0',
  'z-50',
  'hidden'
],
    theme: {
  extend: {
    fontFamily: {
      sans: ['Inter var', ...defaultTheme.fontFamily.sans],
    },
  },
},
plugins: [
  generated,
  generated0,
  generated01,
  generated012
],
  variants: {
    extend: {
      backgroundColor: ['disabled']
    }
  }
}
