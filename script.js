/**
 * Digital Portfolio - Lê Gia Bảo
 * MSV: 25021648 | K70I-CS3 | Khoa học Máy tính
 * Đại học Công nghệ, ĐHQGHN
 */

document.addEventListener('DOMContentLoaded', () => {
  const navItems = document.querySelectorAll('.nav-item');
  const sections = document.querySelectorAll('.section');

  function activateSection(targetId) {
    sections.forEach(s => s.classList.remove('active'));
    navItems.forEach(n => n.classList.remove('active'));

    const targetSection = document.getElementById(targetId);
    if (targetSection) targetSection.classList.add('active');

    const targetNav = document.getElementById('nav-' + targetId);
    if (targetNav) targetNav.classList.add('active');

    window.scrollTo({ top: 0, behavior: 'smooth' });
  }

  navItems.forEach(item => {
    item.addEventListener('click', (e) => {
      e.preventDefault();
      const href = item.getAttribute('href');
      if (href && href.startsWith('#')) {
        activateSection(href.substring(1));
      }
    });
  });

  // Keyboard navigation (arrow keys)
  const sectionIds = ['intro','task-1','task-2','task-3','task-4','task-5','task-6','reflection'];
  document.addEventListener('keydown', (e) => {
    const activeSection = document.querySelector('.section.active');
    if (!activeSection) return;
    const currentIdx = sectionIds.indexOf(activeSection.id);
    if (e.key === 'ArrowRight' || e.key === 'ArrowDown') {
      const nextIdx = Math.min(currentIdx + 1, sectionIds.length - 1);
      activateSection(sectionIds[nextIdx]);
    } else if (e.key === 'ArrowLeft' || e.key === 'ArrowUp') {
      const prevIdx = Math.max(currentIdx - 1, 0);
      activateSection(sectionIds[prevIdx]);
    }
  });

  // Matrix-style console greeting
  console.log('%c⚡ Portfolio Lê Gia Bảo | K70I-CS3 | UET-ĐHQGHN', 
    'color: #00D4FF; font-size: 14px; font-family: monospace; font-weight: bold;');
  console.log('%c// Initialized successfully', 'color: #00E676; font-family: monospace;');
});
