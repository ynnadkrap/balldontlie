import React from 'react'
import ReactDOM from 'react-dom'
import 'typeface-roboto'

import './App.css'
import App from './App'
import { ThemeProvider } from '@material-ui/styles'
import theme from './theme'

ReactDOM.render(
  <ThemeProvider theme={theme}>
    <App />
  </ThemeProvider>,
  document.getElementById('root')
)
