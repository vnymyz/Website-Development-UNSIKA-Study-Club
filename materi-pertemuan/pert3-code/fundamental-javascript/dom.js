// ======================================================
// 8. DOM (Document Object Model)
// ======================================================
// document.querySelector("selector") -> mencari elemen pertama yang
// cocok dengan selector CSS (tag, .class, atau #id).
// .textContent -> membaca/mengubah teks di dalam elemen.
// .style -> mengubah CSS elemen langsung lewat JavaScript.

const targetDom = document.querySelector("#target-dom");

targetDom.textContent = "Teks ini SUDAH diubah oleh dom.js";
targetDom.style.color = "#33422b";
targetDom.style.fontWeight = "bold";
