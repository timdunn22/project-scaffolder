import { createContext, useContext, useState, useEffect } from 'react';
import { auth } from '../api/client';
const AuthContext = createContext(null);

export function AuthProvider({ children }) {
  const [user, setUser] = useState(null);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    const token = localStorage.getItem('token');
    if (token) { auth.me().then((r) => setUser(r.data.user)).catch(() => localStorage.removeItem('token')).finally(() => setLoading(false)); }
    else setLoading(false);
  }, []);

  const login = async (email, password) => { const r = await auth.login({ email, password }); localStorage.setItem('token', r.data.token); setUser(r.data.user); };
  const register = async (email, password, pc) => { const r = await auth.register({ email, password, password_confirmation: pc }); localStorage.setItem('token', r.data.token); setUser(r.data.user); };
  const logout = () => { localStorage.removeItem('token'); setUser(null); };

  return <AuthContext.Provider value={{ user, loading, login, register, logout }}>{children}</AuthContext.Provider>;
}
export function useAuth() { return useContext(AuthContext); }
