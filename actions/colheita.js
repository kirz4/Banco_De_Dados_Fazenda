async function criarColheita() {
  const colheita = {
    data_colheita: document.getElementById("dataColheita").value,
    quantidade_colhida: document.getElementById("quantidadeColhida").value,
    qualidade: document.getElementById("qualidade").value,
    id_planta: document.getElementById("idPlantaColheita").value,
  };
  const response = await fetch("http://localhost:3000/colheita", {
    method: "POST",
    headers: {
      "Content-Type": "application/json",
    },
    body: JSON.stringify(colheita),
  });
  alert(await response.text());
}

async function verColheitas() {
  const listaColheitasDiv = document.getElementById("listaColheitas");
  if (
    listaColheitasDiv.style.display === "none" ||
    listaColheitasDiv.innerHTML === ""
  ) {
    const response = await fetch("http://localhost:3000/colheita");
    const colheitas = await response.json();
    const lista = colheitas
      .map(
        (colheita) => `
          <div class="p-4 mb-4 bg-white rounded shadow-md">
            <p><strong>ID:</strong> ${colheita.ID_Colheita}</p>
            <p><strong>Data de Colheita:</strong> ${new Date(
              colheita.Data_Colheita
            ).toLocaleDateString()}</p>
            <p><strong>Quantidade Colhida:</strong> ${
              colheita.Quantidade_Colhida
            }</p>
            <p><strong>Qualidade:</strong> ${colheita.Qualidade}</p>
            <p><strong>ID Planta:</strong> ${colheita.ID_Planta}</p>
          </div>
          `
      )
      .join("");
    listaColheitasDiv.innerHTML = lista;
    listaColheitasDiv.style.display = "block";
  } else {
    listaColheitasDiv.style.display = "none";
  }
}

async function listarColheitas() {
  const removerColheitaDiv = document.getElementById("removerColheitaDiv");
  if (
    removerColheitaDiv.style.display === "none" ||
    removerColheitaDiv.innerHTML === ""
  ) {
    const response = await fetch("http://localhost:3000/colheita");
    const colheitas = await response.json();
    const options = colheitas
      .map(
        (colheita) =>
          `<option value="${colheita.ID_Colheita}" class="p-2 text-gray-700">ID: ${colheita.ID_Colheita}</option>`
      )
      .join("");
    const select = `
      <p class="mb-2 text-sm text-gray-600"><strong>Nota:</strong> Certifique-se de que todas as operações relacionadas estejam finalizadas antes de remover a colheita.</p>
      <select id="colheitaSelect" class="p-2 mb-4 border border-gray-300 rounded">ID: ${options}</select>
      <button onclick="removerColheita()" class="px-4 py-2 bg-red-600 text-white rounded hover:bg-red-700">Remover</button>
      `;
    removerColheitaDiv.innerHTML = select;
    removerColheitaDiv.style.display = "block";
  } else {
    removerColheitaDiv.style.display = "none";
  }
}

async function removerColheita() {
  const id = document.getElementById("colheitaSelect").value;
  const response = await fetch(`http://localhost:3000/colheita/${id}`, {
    method: "DELETE",
  });
  alert(await response.text());
  listarColheitas();
}
