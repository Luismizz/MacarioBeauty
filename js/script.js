document.addEventListener("DOMContentLoaded", () => {
    const menuToggle = document.getElementById("menuToggle");
    const navLinks = document.getElementById("navLinks");
    if (menuToggle && navLinks) {
        menuToggle.addEventListener("click", () => {
            navLinks.classList.toggle("open");
        });
    }

    const inputTelefone = document.getElementById("telefone");
    if (inputTelefone) {
        inputTelefone.addEventListener("input", (e) => {
            let v = e.target.value.replace(/\D/g, "");
            if (v.length > 11) v = v.slice(0, 11);
            if (v.length > 6) {
                e.target.value = `(${v.slice(0, 2)}) ${v.slice(2, 7)}-${v.slice(7)}`;
            } else if (v.length > 2) {
                e.target.value = `(${v.slice(0, 2)}) ${v.slice(2)}`;
            } else if (v.length > 0) {
                e.target.value = `(${v}`;
            }
        });
    }

    const selectServico = document.getElementById("id_servico");
    const inputData = document.getElementById("data_agendamento");
    const selectHora = document.getElementById("hora_agendamento");

    function atualizarResumo() {
        if (!selectServico) return;
        const opcao = selectServico.options[selectServico.selectedIndex];
        const resumoServico = document.getElementById("resumoServico");
        const resumoPreco = document.getElementById("resumoPreco");
        const resumoDuracao = document.getElementById("resumoDuracao");

        if (opcao && opcao.value !== "") {
            resumoServico.textContent = opcao.text.split(" (R$")[0];
            resumoPreco.textContent = opcao.getAttribute("data-preco") || "--,--";
            resumoDuracao.textContent = opcao.getAttribute("data-duracao") || "--";
        } else {
            resumoServico.textContent = "Não selecionado";
            resumoPreco.textContent = "--,--";
            resumoDuracao.textContent = "--";
        }

        const resumoData = document.getElementById("resumoData");
        if (inputData && inputData.value) {
            const partes = inputData.value.split("-");
            resumoData.textContent = `${partes[2]}/${partes[1]}/${partes[0]}`;
        }

        const resumoHora = document.getElementById("resumoHora");
        if (selectHora && selectHora.value) {
            resumoHora.textContent = selectHora.value;
        }
    }

    if (selectServico) {
        selectServico.addEventListener("change", atualizarResumo);
        atualizarResumo();
    }
    if (inputData) {
        const hoje = new Date().toISOString().split("T")[0];
        inputData.setAttribute("min", hoje);
        inputData.addEventListener("change", atualizarResumo);
    }
    if (selectHora) {
        selectHora.addEventListener("change", atualizarResumo);
    }

    const formAgendamento = document.getElementById("formAgendamento");
    if (formAgendamento) {
        formAgendamento.addEventListener("submit", (e) => {
            let valido = true;

            const nome = document.getElementById("nome").value.trim();
            const telefone = document.getElementById("telefone").value.replace(/\D/g, "");
            const email = document.getElementById("email").value.trim();
            const servico = selectServico.value;
            const data = inputData.value;
            const hora = selectHora.value;

            document.getElementById("erroNome").textContent = "";
            document.getElementById("erroTelefone").textContent = "";
            document.getElementById("erroEmail").textContent = "";
            document.getElementById("erroServico").textContent = "";
            document.getElementById("erroData").textContent = "";
            document.getElementById("erroHora").textContent = "";

            if (nome.length < 3) {
                document.getElementById("erroNome").textContent = "Por favor, informe seu nome completo.";
                valido = false;
            }
            if (telefone.length < 10) {
                document.getElementById("erroTelefone").textContent = "Informe um WhatsApp/telefone válido com DDD.";
                valido = false;
            }
            const regexEmail = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
            if (!regexEmail.test(email)) {
                document.getElementById("erroEmail").textContent = "Informe um endereço de e-mail válido.";
                valido = false;
            }
            if (!servico) {
                document.getElementById("erroServico").textContent = "Selecione um serviço do catálogo.";
                valido = false;
            }
            if (!data) {
                document.getElementById("erroData").textContent = "Escolha a data desejada.";
                valido = false;
            }
            if (!hora) {
                document.getElementById("erroHora").textContent = "Escolha um horário disponível.";
                valido = false;
            }

            if (!valido) {
                e.preventDefault();
            }
        });
    }
});
