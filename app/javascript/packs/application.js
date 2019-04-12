import "bootstrap";
import "../plugins/flatpickr";
import 'select2/dist/css/select2.css';

import { initSelect2 } from '../components/init_select2';

initSelect2();


flatpickr(".datepicker", {
  allowInput: true,
  enableTime: true
})




document.getElementById("btn-link").addEventListener("click", linkToYoutube);

function linkToYoutube() {
  document.getElementById("demo").innerHTML = Date();
}
