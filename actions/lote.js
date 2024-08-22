async function criarLote() {
  const lote = {
    data_criacao: document.getElementById("dataCriacao").value,
    numero_plantas: document.getElementById("numeroPlantas").value,
  };
  const response = await fetch("http://localhost:3000/lote", {
    method: "POST",
    headers: {
      "Content-Type": "application/json",
    },
    body: JSON.stringify(lote),
  });
  alert(await response.text());
}

async function verLotes() {
  const listaLotesDiv = document.getElementById("listaLotes");
  if (
    listaLotesDiv.style.display === "none" ||
    listaLotesDiv.innerHTML === ""
  ) {
    const response = await fetch("http://localhost:3000/lote");
    const lotes = await response.json();
    const lista = lotes
      .map(
        (lote) => `
          <div class="p-4 mb-4 bg-white rounded shadow-md">
            <p><strong>ID:</strong> ${lote.ID_Lote}</p>
            <p><strong>Data de Criação:</strong> ${new Date(
              lote.Data_Criacao
            ).toLocaleDateString()}</p>
            <p><strong>Número de Plantas:</strong> ${lote.Numero_Plantas}</p>
          </div>
          `
      )
      .join("");
    listaLotesDiv.innerHTML = lista;
    listaLotesDiv.style.display = "block";
  } else {
    listaLotesDiv.style.display = "none";
  }
}

async function listarLotes() {
  const removerLoteDiv = document.getElementById("removerLoteDiv");
  if (
    removerLoteDiv.style.display === "none" ||
    removerLoteDiv.innerHTML === ""
  ) {
    const response = await fetch("http://localhost:3000/lote");
    const lotes = await response.json();
    const options = lotes
      .map(
        (lote) =>
          `<option value="${lote.ID_Lote}" class="p-2 text-gray-700">ID: ${lote.ID_Lote}</option>`
      )
      .join("");
    const select = `
      <p class="mb-2 text-sm text-gray-600"><strong>Nota:</strong> Certifique-se de excluir todas as plantas associadas antes de remover o lote.</p>
      <select id="loteSelect" class="p-2 mb-4 border border-gray-300 rounded">ID: ${options}</select>
      <button onclick="removerLote()" class="px-4 py-2 bg-red-600 text-white rounded hover:bg-red-700">Remover</button>
      `;
    removerLoteDiv.innerHTML = select;
    removerLoteDiv.style.display = "block";
  } else {
    removerLoteDiv.style.display = "none";
  }
}

async function removerLote() {
  const id = document.getElementById("loteSelect").value;
  const response = await fetch(`http://localhost:3000/lote/${id}`, {
    method: "DELETE",
  });
  alert(await response.text());
  listarLotes();
}

// Função para atualizar as informações do Lote
async function atualizarLote() {
  const idLote = document.getElementById("idLote").value;
  const lote = {
    data_criacao: document.getElementById("dataCriacaoAtualizar").value,
    numero_plantas: document.getElementById("numeroPlantasAtualizar").value,
  };

  try {
    const response = await fetch(`http://localhost:3000/lote/${idLote}`, {
      method: "PUT",
      headers: {
        "Content-Type": "application/json",
      },
      body: JSON.stringify(lote),
    });

    if (!response.ok) {
      const erro = await response.text();
      throw new Error(erro);
    }

    const resultado = await response.json();
    const mensagem = resultado[0]?.Mensagem || "Erro ao atualizar o lote.";
    alert(mensagem);
  } catch (error) {
    alert(error.message);
  }
}