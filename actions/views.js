async function exibirPlantaEstufa() {
  const listaPlantaEstufaDiv = document.getElementById("listaPlantaEstufa");
  if (
    listaPlantaEstufaDiv.style.display === "none" ||
    listaPlantaEstufaDiv.innerHTML === ""
  ) {
    const response = await fetch("http://localhost:3000/vw_PlantaEstufa");
    const dados = await response.json();
    const lista = dados
      .map(
        (item) => `
            <div class="p-4 mb-4 bg-white rounded shadow-md">
              <p><strong>ID Planta:</strong> ${item.ID_Planta}</p>
              <p><strong>Variedade:</strong> ${item.Variedade}</p>
              <p><strong>Localização Estufa:</strong> ${item.Localizacao}</p>
              <p><strong>Temperatura Estufa:</strong> ${item.Temperatura}°C</p>
            </div>
          `
      )
      .join("");
    listaPlantaEstufaDiv.innerHTML = lista;
    listaPlantaEstufaDiv.style.display = "block";
  } else {
    listaPlantaEstufaDiv.style.display = "none";
  }
}

async function exibirPlantaLote() {
  const listaPlantaLoteDiv = document.getElementById("listaPlantaLote");
  if (
    listaPlantaLoteDiv.style.display === "none" ||
    listaPlantaLoteDiv.innerHTML === ""
  ) {
    const response = await fetch("http://localhost:3000/vw_PlantaLote");
    const dados = await response.json();
    const lista = dados
      .map(
        (item) => `
            <div class="p-4 mb-4 bg-white rounded shadow-md">
              <p><strong>ID Planta:</strong> ${item.ID_Planta}</p>
              <p><strong>Variedade:</strong> ${item.Variedade}</p>
              <p><strong>ID Lote:</strong> ${item.ID_Lote}</p>
              <p><strong>Data de Criação do Lote:</strong> ${item.Data_Criacao}</p>
            </div>
          `
      )
      .join("");
    listaPlantaLoteDiv.innerHTML = lista;
    listaPlantaLoteDiv.style.display = "block";
  } else {
    listaPlantaLoteDiv.style.display = "none";
  }
}
