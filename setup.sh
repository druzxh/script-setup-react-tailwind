#!/bin/bash

# Initial project name
get_project_name() {
  if [ -z "$1" ]; then
    basename "$PWD"
  else
    echo "$1"
  fi
}

# Read input name project
read -p "Masukkan nama proyek (biarkan kosong untuk menggunakan nama folder saat ini): " project_input

# Mendapatkan nama proyek yang akan digunakan
project_name=$(get_project_name "$project_input")

# Build React app with Vite in the root folder
echo "Creating React app with Vite..."
npm init -y vite@latest $project_name -- --template react

# Install Tailwind CSS and required dependencies
echo "Installing Tailwind CSS and PostCSS..."
cd $project_name
npm install -D tailwindcss@latest postcss@latest autoprefixer@latest

# Create Tailwind configuration file
echo "Creating Tailwind CSS configuration..."
npx tailwindcss init -p

# Install React Router
echo "Installing React Router..."
npm install react-router-dom

# Testing App with tailwind css

cat <<EOF > src/App.jsx
import './App.css'

function App() {
  return (
    <>
      <div className="flex justify-center">
        <h1 className="font-bold text-2xl text-blue-900">
          React and Tailwind with Vitejs!
        </h1> 
      </div>
    </>
  )
}

export default App
EOF

# Update tailwind config
# echo "Updating Tailwind config..."

cat <<EOF > tailwind.config.js
/** @type {import('tailwindcss').Config} */
export default {
  content: [
    "./index.html",
    "./src/**/*.{vue,js,ts,jsx,tsx}"
  ],
  theme: {
    extend: {},
  },
  plugins: [],
}
EOF

# Update src/App.css to include Tailwind directives
cd src
echo "Updating src/index.css with Tailwind directives..."
cat <<EOF > index.css
@tailwind base;
@tailwind components;
@tailwind utilities;
EOF

npm install
echo "Finished"
