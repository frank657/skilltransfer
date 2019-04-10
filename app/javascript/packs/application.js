import "bootstrap";
import "../plugins/flatpickr";



flatpickr(".datepicker", {
  allowInput: true,
  enableTime: true
})

let dropdownItem = document.querySelectorAll('.dropdown-menu li');
dropdownItem.forEach(d => {
  d.addEventListener('click', function() {
    console.log(d.getAttribute('data-tags'))
  })
})
