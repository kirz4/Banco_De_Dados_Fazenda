// Função para exibir pop-ups de mensagens
function mostrarMensagemPopup(mensagem, tipo = "success") {
  const popup = document.createElement("div");
  popup.innerText = mensagem;
  popup.className = `fixed top-4 right-4 px-4 py-2 rounded shadow-lg z-50 ${
    tipo === "success" ? "bg-green-500 text-white" : "bg-red-500 text-white"
  }`;
  document.body.appendChild(popup);

  // Remove o pop-up após 3 segundos
  setTimeout(() => {
    popup.remove();
  }, 3000);
}

// Função para atualizar a temperatura de uma estufa
async function atualizarTemperaturaEstufa() {
  const idEstufa = document.getElementById("idEstufaTemperatura").value;
  const novaTemperatura = document.getElementById("novaTemperatura").value;

  try {
    const response = await fetch(
      `http://localhost:3000/estufa/${idEstufa}/temperatura`,
      {
        method: "PUT",
        headers: {
          "Content-Type": "application/json",
        },
        body: JSON.stringify({ temperatura: novaTemperatura }),
      }
    );

    if (!response.ok) {
      const erro = await response.text();
      throw new Error(erro);
    }

    const resultado = await response.json();
    const mensagem =
      resultado[0]?.Mensagem || "Erro ao atualizar a temperatura.";
    mostrarMensagemPopup(mensagem, "success");
  } catch (error) {
    mostrarMensagemPopup(error.message, "error");
  }
}

// Função para atualizar o estágio de crescimento de uma planta
async function atualizarEstagioCrescimentoPlanta() {
  const idPlanta = document.getElementById("idPlantaEstagio").value;
  const novoEstagio = document.getElementById("novoEstagioCrescimento").value;

  try {
    const response = await fetch(
      `http://localhost:3000/planta/${idPlanta}/estagio`,
      {
        method: "PUT",
        headers: {
          "Content-Type": "application/json",
        },
        body: JSON.stringify({ estagio: novoEstagio }),
      }
    );

    if (!response.ok) {
      const erro = await response.text();
      throw new Error(erro);
    }

    const resultado = await response.json();
    const mensagem =
      resultado[0]?.Mensagem || "Erro ao atualizar o estágio de crescimento.";
    mostrarMensagemPopup(mensagem, "success");
  } catch (error) {
    mostrarMensagemPopup(error.message, "error");
  }
}
