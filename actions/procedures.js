async function gerarRelatorioProducao() {
  try {
    const relatorioDiv = document.getElementById("relatorioProducao");

    // Verifica se o relatório já está sendo exibido
    if (
      relatorioDiv.style.display === "none" ||
      relatorioDiv.innerHTML === ""
    ) {
      // Se não estiver, faz a requisição e exibe o relatório
      const response = await fetch("http://localhost:3000/relatorio/producao");
      if (!response.ok) {
        throw new Error("Erro ao gerar o relatório de produção");
      }

      const relatorio = await response.json();
      relatorioDiv.innerHTML = "";

      // Formata o relatório para exibição
      relatorio.forEach((item) => {
        const relatorioItem = document.createElement("div");
        relatorioItem.classList.add(
          "p-4",
          "mb-4",
          "bg-white",
          "rounded",
          "shadow-md"
        );

        relatorioItem.innerHTML = `
          <p><strong>Estufa:</strong> ${item.Estufa}</p>
          <p><strong>Lote:</strong> ${item.Lote}</p>
          <p><strong>Planta:</strong> ${item.Planta}</p>
          <p><strong>Quantidade Total:</strong> ${item.Quantidade_Total}</p>
          <p><strong>Média de Qualidade:</strong> ${item.Media_Qualidade}</p>
        `;

        relatorioDiv.appendChild(relatorioItem);
      });

      // Exibe o relatório
      relatorioDiv.style.display = "block";
    } else {
      // Se já estiver sendo exibido, oculta o relatório
      relatorioDiv.style.display = "none";
    }
  } catch (error) {
    console.error("Erro:", error);
    alert(error.message);
  }
}
