const ajax = (function () {

  function generateParams(params) {
    let queryString = '';

    for (let key in params) {
      if (params.hasOwnProperty(key)) {
        let value = params[key];

        if (Array.isArray(value)) {
          value.forEach(val => {
            queryString += `${encodeURIComponent(key)}[]=${encodeURIComponent(val)}&`;
          });

        } else {
          queryString += `${encodeURIComponent(key)}=${encodeURIComponent(value)}&`;
        }
      }
    }

    return queryString.slice(0, -1);
  }

  function request(method, url, params = {}, timeout = 5000) {
    return new Promise((resolve, reject) => {
      const xhr = new XMLHttpRequest();
      xhr.open(method, url, true);
      xhr.timeout = timeout;
      xhr.responseType = 'json';

      xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');

      xhr.onload = function () {
        if (xhr.status >= 200 && xhr.status < 300) {
          resolve({ status: xhr.status, php: xhr.response });
        } else {
          reject({ status: xhr.status, error: xhr.statusText });
        }
      };

      xhr.ontimeout = function () {
        reject({ error: 'Request Timeout' });
      };

      xhr.onerror = function () {
        reject({ error: xhr.statusText });
      };

      if (method === 'GET') {
        url += '?' + generateParams(params);
        xhr.open(method, url, true);
        xhr.send();
      } else if (method === 'POST') {
        const post_body = generateParams(params);
        xhr.send(post_body);
      }
    });
  }

  function get(url, params = {}, timeout = 5000) {
    return request('GET', url, params, timeout);
  }

  function post(url, params = {}, timeout = 5000) {
    return request('POST', url, params, timeout);
  }

  return {
    get,
    post
  };
})();

export { ajax };
先幫我截取get或post到資料的部分就好
function ajax('get or post', url, {postpay:value})
return datatype(css or json), data(json object or csv strings)