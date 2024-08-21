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
    alert(mensagem);
  } catch (error) {
    alert(error.message);
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
    alert(mensagem);
  } catch (error) {
    alert(error.message);
  }
}
