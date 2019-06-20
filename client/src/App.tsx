import React from 'react'
import axios from 'axios'

import TopBar from './TopBar'

export interface ISession {
  email: string
  token: string
}

const initialSessionState = { email: '', token: '' }

const App: React.FC = () => {
  const [session, setSession] = React.useState(initialSessionState)

  React.useEffect(() => {
    axios.get('/sessions').then(res => {
      const { email } = res.data as ISession
      setSession({ email, token: 'dummy' })
    })
  }, [])

  return (
    <div>
      <TopBar session={session} setSession={setSession} />
    </div>
  )
}

export default App
