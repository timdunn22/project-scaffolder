import { Link, useNavigate } from 'react-router-dom';
import { useAuth } from '../contexts/AuthContext';

export default function Layout({ children }) {
  const { user, logout } = useAuth();
  const navigate = useNavigate();
  return (
    <div className="min-h-screen bg-gray-50">
      <nav className="bg-white shadow-sm">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
          <div className="flex justify-between h-16">
            <div className="flex items-center gap-6">
              <Link to="/" className="text-xl font-bold text-purple-600">Project Scaffolder</Link>
              {user && <><Link to="/templates" className="text-gray-600 hover:text-gray-900">Templates</Link><Link to="/history" className="text-gray-600 hover:text-gray-900">History</Link></>}
            </div>
            {user && <div className="flex items-center gap-4"><span className="text-gray-600">{user.email}</span><button onClick={() => { logout(); navigate('/login'); }} className="text-gray-600 hover:text-gray-900">Logout</button></div>}
          </div>
        </div>
      </nav>
      <main className="max-w-7xl mx-auto py-6 px-4 sm:px-6 lg:px-8">{children}</main>
    </div>
  );
}
