import React from 'react';
import './App.css';

function App() {
  const ideas = [
    {
      id: '1',
      title: 'AI-Powered Startup Idea Generator',
      description: 'A platform that generates startup ideas using AI and trend analysis.',
      tags: ['AI Powered', 'Growing Market']
    }
  ];

  return (
    <div className="min-h-screen bg-white">
      <header className="bg-white border-b border-gray-100 py-4">
        <div className="max-w-7xl mx-auto px-4">
          <div className="flex items-center">
            <div className="w-8 h-8 bg-gradient-to-br from-purple-500 to-pink-600 rounded-lg flex items-center justify-center mr-3">
              <span className="text-white font-bold text-sm">IS</span>
            </div>
            <span className="text-xl font-semibold text-gray-900">IdeaSpot.ai</span>
          </div>
        </div>
      </header>
      
      <main className="max-w-4xl mx-auto px-4 py-12">
        <h1 className="text-4xl font-bold text-center mb-8 text-blue-600">
          Idea of the Day
        </h1>
        
        {ideas.map(idea => (
          <div key={idea.id} className="bg-white border border-gray-200 rounded-lg p-6">
            <h2 className="text-2xl font-bold mb-4">{idea.title}</h2>
            <p className="text-gray-700 mb-4">{idea.description}</p>
            <div className="flex gap-2">
              {idea.tags.map((tag, index) => (
                <span key={index} className="px-3 py-1 rounded-full text-sm font-medium bg-blue-100 text-blue-800">
                  {tag}
                </span>
              ))}
            </div>
          </div>
        ))}
      </main>
    </div>
  );
}

export default App;
