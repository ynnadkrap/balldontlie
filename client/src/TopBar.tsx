import * as React from 'react'
import { makeStyles } from '@material-ui/core/styles'
import AppBar from '@material-ui/core/AppBar'
import Toolbar from '@material-ui/core/Toolbar'
import Typography from '@material-ui/core/Typography'
import Button from '@material-ui/core/Button'
import axios from 'axios'

import Signup from './Signup'
import Login from './Login'
import { ISession } from './App'

const useStyles = makeStyles(theme => ({
  title: {
    flexGrow: 1
  },
  loginButton: {
    marginRight: theme.spacing(1)
  }
}))

interface IProps {
  session: ISession
  setSession: any // Be better about this type
}

const TopBar: React.FC<IProps> = ({ session, setSession }) => {
  const classes = useStyles()
  const [signupOpen, setSignupOpen] = React.useState(false)
  const [loginOpen, setLoginOpen] = React.useState(false)

  const handleLoginOrSignupSuccess = (email: string, token: string) =>
    setSession({ email, token })
  const handleLogout = () => {
    axios.post('/logout').then(() => {
      setSession({ token: '', email: '' })
    })
  }

  return (
    <div>
      <AppBar position="static">
        <Toolbar>
          <Typography className={classes.title}>Balldontlie</Typography>
          {session.token ? (
            <React.Fragment>
              <Typography>{session.email}</Typography>
              <Button variant="contained" onClick={handleLogout}>
                Logout
              </Button>
            </React.Fragment>
          ) : (
            <React.Fragment>
              <Button
                onClick={() => setLoginOpen(true)}
                className={classes.loginButton}
              >
                Login
              </Button>
              <Button variant="contained" onClick={() => setSignupOpen(true)}>
                Signup
              </Button>
            </React.Fragment>
          )}
        </Toolbar>
      </AppBar>
      <Signup
        open={signupOpen}
        onClose={() => setSignupOpen(false)}
        onCreateSuccess={handleLoginOrSignupSuccess}
      />
      <Login
        open={loginOpen}
        onClose={() => setLoginOpen(false)}
        onLoginSuccess={handleLoginOrSignupSuccess}
      />
    </div>
  )
}

export default TopBar
