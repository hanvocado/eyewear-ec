document.addEventListener('DOMContentLoaded', () => {
    fetch('/auth/protected-resource', {
        method: 'GET',
        headers: {
            'Authorization': `Bearer ${localStorage.getItem('authToken')}`
        }
    })
        .then(response => {
            if (response.ok) {
                return response.json();
            }
            throw new Error('Unauthorized');
        })
        .then(data => console.log(data))
        .catch(error => console.error(error));
});
