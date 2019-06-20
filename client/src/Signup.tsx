import * as React from 'react'
import axios from 'axios'
import { makeStyles, createStyles } from '@material-ui/core/styles'
import Modal from '@material-ui/core/Modal'
import Paper from '@material-ui/core/Paper'
import TextField from '@material-ui/core/TextField'
import Typography from '@material-ui/core/Typography'
import Button from '@material-ui/core/Button'

const EMAIL_REGEX = /\S+@\S+\.\S+/

const useStyles = makeStyles(theme =>
  createStyles({
    root: {
      width: '100%',
      height: '100%',
      display: 'flex',
      alignItems: 'center',
      justifyContent: 'center'
    },
    paper: {
      display: 'flex',
      flexDirection: 'column',
      width: 350,
      padding: theme.spacing(2)
    },
    error: {
      color: theme.palette.danger.main
    }
  })
)

interface IProps {
  open: boolean
  onClose: () => any
  onCreateSuccess: (email: string, token: string) => any
}

const Signup: React.FC<IProps> = ({ open, onClose, onCreateSuccess }) => {
  const classes = useStyles({})
  const [email, setEmail] = React.useState('')
  const [password, setPassword] = React.useState('')
  const [passwordConfirm, setPasswordConfirm] = React.useState('')
  const [error, setError] = React.useState('')
  const [submitting, setSubmitting] = React.useState(false)

  const handleSubmit = () => {
    if (!email.length) {
      setError('Email cannot be blank')
      return
    }

    if (!EMAIL_REGEX.test(email)) {
      setError('Enter a valid email')
      return
    }

    if (!password.length) {
      setError('Password cannot be blank')
      return
    }

    if (!passwordConfirm.length) {
      setError('Password confirmation cannot be blank')
      return
    }

    if (password !== passwordConfirm) {
      setError('Passwords do not match')
      return
    }

    axios
      .post('/users', {
        user: { email, password, password_confirmation: passwordConfirm }
      })
      .then(res => {
        setSubmitting(false)
        // TODO use real token
        onCreateSuccess(email, 'this should be a token')
        onClose()
      })
      .catch(err => {
        setSubmitting(false)
        setError('Unexpected error')
      })
  }

  return (
    <Modal className={classes.root} open={open} onClose={onClose}>
      <Paper className={classes.paper}>
        <Typography variant="h4">Create an account</Typography>
        {error && (
          <Typography className={classes.error} variant="body2">
            {error}
          </Typography>
        )}
        <TextField
          required
          value={email}
          label="Email"
          margin="normal"
          onChange={e => setEmail(e.target.value)}
        />
        <TextField
          required
          value={password}
          label="Password"
          margin="normal"
          type="password"
          onChange={e => setPassword(e.target.value)}
        />
        <TextField
          required
          value={passwordConfirm}
          label="Password Confirmation"
          margin="normal"
          type="password"
          onChange={e => setPasswordConfirm(e.target.value)}
        />
        <Button
          disabled={submitting}
          onClick={handleSubmit}
          color="primary"
          variant="contained"
        >
          Submit
        </Button>
      </Paper>
    </Modal>
  )
}

export default Signup
