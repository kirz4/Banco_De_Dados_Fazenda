async function criarEstufa() {
  const estufa = {
    localizacao: document.getElementById("localizacao").value,
    temperatura: document.getElementById("temperatura").value,
    umidade: document.getElementById("umidade").value,
    tamanho: document.getElementById("tamanho").value,
  };
  const response = await fetch("http://localhost:3000/estufa", {
    method: "POST",
    headers: {
      "Content-Type": "application/json",
    },
    body: JSON.stringify(estufa),
  });
  alert(await response.text());
}

async function verEstufas() {
  const listaEstufasDiv = document.getElementById("listaEstufas");
  if (
    listaEstufasDiv.style.display === "none" ||
    listaEstufasDiv.innerHTML === ""
  ) {
    const response = await fetch("http://localhost:3000/estufa");
    const estufas = await response.json();
    const lista = estufas
      .map(
        (estufa) => `
        <div class="p-4 mb-4 bg-white rounded shadow-md">
          <p><strong>ID:</strong> ${estufa.ID_Estufa}</p>
          <p><strong>Localização:</strong> ${estufa.Localizacao}</p>
          <p><strong>Temperatura:</strong> ${estufa.Temperatura}°C</p>
          <p><strong>Umidade:</strong> ${estufa.Umidade}%</p>
          <p><strong>Tamanho:</strong> ${estufa.Tamanho}m²</p>
        </div>
        `
      )
      .join("");
    listaEstufasDiv.innerHTML = lista;
    listaEstufasDiv.style.display = "block";
  } else {
    listaEstufasDiv.style.display = "none";
  }
}

async function listarEstufas() {
  const removerEstufaDiv = document.getElementById("removerEstufaDiv");
  if (
    removerEstufaDiv.style.display === "none" ||
    removerEstufaDiv.innerHTML === ""
  ) {
    const response = await fetch("http://localhost:3000/estufa");
    const estufas = await response.json();
    const options = estufas
      .map(
        (estufa) =>
          `<option value="${estufa.ID_Estufa}" class="p-2 text-gray-700">ID: ${estufa.ID_Estufa}</option>`
      )
      .join("");
    const select = `
    <p class="mb-2 text-sm text-gray-600"><strong>Nota:</strong> Certifique-se de excluir todas as plantas associadas antes de remover a estufa.</p>
    <select id="estufaSelect" class="p-2 mb-4 border border-gray-300 rounded">${options}</select>
    <button onclick="removerEstufa()" class="px-4 py-2 bg-red-600 text-white rounded hover:bg-red-700">Remover</button>
    `;
    removerEstufaDiv.innerHTML = select;
    removerEstufaDiv.style.display = "block";
  } else {
    removerEstufaDiv.style.display = "none";
  }
}

async function removerEstufa() {
  const id = document.getElementById("estufaSelect").value;
  const response = await fetch(`http://localhost:3000/estufa/${id}`, {
    method: "DELETE",
  });
  alert(await response.text());
  listarEstufas();
}
