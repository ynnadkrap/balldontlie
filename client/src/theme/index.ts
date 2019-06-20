// Material helpers
import { createMuiTheme } from '@material-ui/core'

import palette from './palette'
import typography from './typography'

interface IPalette {
  contrastText: string
  main: string
  light: string
  dark: string
}

declare module '@material-ui/core/styles/createPalette' {
  // tslint:disable-next-line:interface-name
  interface Palette {
    success: IPalette
    info: IPalette
    warning: IPalette
    danger: IPalette
  }
  // tslint:disable-next-line:interface-name
  interface PaletteOptions {
    success?: IPalette
    info?: IPalette
    warning?: IPalette
    danger?: IPalette
  }
}

const theme = createMuiTheme({
  palette,
  typography,
  zIndex: {
    appBar: 1200,
    drawer: 1100
  }
})

export default theme
