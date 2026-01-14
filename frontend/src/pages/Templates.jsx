import { useState, useEffect } from 'react';
import { Link } from 'react-router-dom';
import { templates } from '../api/client';
import Layout from '../components/Layout';

export default function Templates() {
  const [list, setList] = useState([]);
  const [loading, setLoading] = useState(true);

  useEffect(() => { templates.list().then((r) => setList(r.data)).finally(() => setLoading(false)); }, []);

  return (
    <Layout>
      <div className="space-y-6">
        <h1 className="text-2xl font-bold text-gray-900">Project Templates</h1>
        {loading ? <div className="text-center py-8">Loading...</div> : (
          <div className="grid gap-4 md:grid-cols-2 lg:grid-cols-3">
            {list.map((t) => (
              <div key={t.id} className="bg-white p-6 rounded-lg shadow hover:shadow-md transition-shadow">
                <h3 className="text-lg font-medium text-gray-900">{t.name}</h3>
                <p className="text-sm text-gray-500 mt-2">{t.description}</p>
                <Link to={`/generate/${t.id}`} className="mt-4 inline-block text-purple-600 hover:text-purple-500">Use Template &rarr;</Link>
              </div>
            ))}
          </div>
        )}
      </div>
    </Layout>
  );
}
