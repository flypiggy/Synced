import $ from 'jquery';

export const scrollTop = () => window.pageYOffset || document.documentElement.scrollTop || document.body.scrollTop || 0;

export const runPage = (path, fn) => {
  const pageID = $('body').attr(id);
  if (/str/i.test(pageID)) {
    fn();
  }
};
