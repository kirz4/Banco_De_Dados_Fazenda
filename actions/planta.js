async function criarPlanta() {
  const planta = {
    variedade: document.getElementById("variedade").value,
    data_plantio: document.getElementById("dataPlantio").value,
    estagio_crescimento: document.getElementById("estagioCrescimento").value,
    id_lote: document.getElementById("idLotePlanta").value,
    id_estufa: document.getElementById("idEstufaPlanta").value,
  };
  const response = await fetch("http://localhost:3000/planta", {
    method: "POST",
    headers: {
      "Content-Type": "application/json",
    },
    body: JSON.stringify(planta),
  });
  alert(await response.text());
}

async function verPlantas() {
  const listaPlantasDiv = document.getElementById("listaPlantas");
  if (
    listaPlantasDiv.style.display === "none" ||
    listaPlantasDiv.innerHTML === ""
  ) {
    const response = await fetch("http://localhost:3000/planta");
    const plantas = await response.json();
    const lista = plantas
      .map(
        (planta) => `
          <div class="p-4 mb-4 bg-white rounded shadow-md">
            <p><strong>ID:</strong> ${planta.ID_Planta}</p>
            <p><strong>Variedade:</strong> ${planta.Variedade}</p>
            <p><strong>Data de Plantio:</strong> ${planta.Data_Plantio}</p>
            <p><strong>Estágio de Crescimento:</strong> ${planta.Estagio_Crescimento}</p>
            <p><strong>ID Lote:</strong> ${planta.ID_Lote}</p>
            <p><strong>ID Estufa:</strong> ${planta.ID_Estufa}</p>
          </div>
          `
      )
      .join("");
    listaPlantasDiv.innerHTML = lista;
    listaPlantasDiv.style.display = "block";
  } else {
    listaPlantasDiv.style.display = "none";
  }
}

async function listarPlantas() {
  const removerPlantaDiv = document.getElementById("removerPlantaDiv");
  if (
    removerPlantaDiv.style.display === "none" ||
    removerPlantaDiv.innerHTML === ""
  ) {
    const response = await fetch("http://localhost:3000/planta");
    const plantas = await response.json();
    const options = plantas
      .map(
        (planta) =>
          `<option value="${planta.ID_Planta}" class="p-2 text-gray-700">ID: ${planta.ID_Planta}</option>`
      )
      .join("");
    const select = `
      <p class="mb-2 text-sm text-gray-600"><strong>Nota:</strong> Certifique-se de excluir todas as colheitas associadas antes de remover a planta.</p>
      <select id="plantaSelect" class="p-2 mb-4 border border-gray-300 rounded">ID: ${options}</select>
      <button onclick="removerPlanta()" class="px-4 py-2 bg-red-600 text-white rounded hover:bg-red-700">Remover</button>
      `;
    removerPlantaDiv.innerHTML = select;
    removerPlantaDiv.style.display = "block";
  } else {
    removerPlantaDiv.style.display = "none";
  }
}

async function removerPlanta() {
  const id = document.getElementById("plantaSelect").value;
  const response = await fetch(`http://localhost:3000/planta/${id}`, {
    method: "DELETE",
  });
  alert(await response.text());
  listarPlantas();
}
