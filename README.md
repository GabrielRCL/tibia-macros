# tibia-macros

Macro/bot de automação para o MMORPG **Tibia**, escrito em **AutoHotkey v1.1 (Unicode 64-bit)**. Projeto originalmente comercial, agora liberado como open-source após o encerramento do suporte.

> ⚠️ **Projeto descontinuado pelo autor original. Sinta-se à vontade para fork e contribuir.**
>
> O código é disponibilizado *as-is*, para fins educacionais e de referência. Toda a infraestrutura original (API de licenças, CDN de auto-update) foi removida — o macro agora roda 100% localmente.

---

## O que este macro faz

Automação por **captura de tela + pattern matching (OCR)**: detecta barras de HP/MP, battle list, cooldowns, capacidade e condições por comparação de imagens e cores, reagindo com hotkeys, cliques e `ControlSend`.

### Features

- **CaveBot** — walker com waypoints, targeting e pathfinding
- **Auto-Healing** — cura automática baseada em OCR das barras de HP/MP
- **Looter** — coleta automática de drops
- **Heal Friend** — cura de aliados via party/hotkey
- **PvP** — sequências de combate (flower-kite, ghost mouse, combo attack)
- **Tank Mode** — healing passivo e verificação de escudo
- **Combo / Spells** — sequências de feitiços encadeadas
- **Support** — troca dinâmica de rings/amulets, buffs (Haste, Utamo Vita…)
- **OCR de Capacidade** — leitura numérica do cap do personagem
- **Detecção de condições** — Paralyze, Haste, PZ, etc.
- **Alarmes, Anti-kick, Timers**
- Interface bilíngue (PT-BR / EN)

---

## Como usar

1. Instale o **[AutoHotkey v1.1 Unicode 64-bit](https://www.autohotkey.com/download/ahk-v1.1.zip)** (v2 é incompatível)
2. Clone o repositório:
   ```bash
   git clone https://github.com/GabrielRCL/tibia-macros.git
   cd tibia-macros
   ```
3. Rode [loader.ahk](loader.ahk) **como administrador** (privilégios são exigidos para `ControlSend` e hooks):
   ```
   AutoHotkey.exe loader.ahk
   ```
4. Selecione vocação, servidor e idioma na tela inicial e clique em **Start**.

O loader salva a configuração em `conf/Login.ini` e executa o script da versão selecionada.

---

## Arquitetura

MVC informal em AutoHotkey. Cada servidor suportado vive em sua própria pasta em [versions/](versions/):

```
versions/<Servidor>/
├── main.ahk          # ponto de entrada, hotkeys globais, inicialização
├── models/           # lógica de negócio (cavebot, healing, pvp, looter...)
├── views/            # GUIs (Gui, Add, Tab, DropDownList, etc.)
└── controllers/      # orquestração, I/O de config .ini, carregamento de imagens
```

Exemplos concretos:
- **Model**: [versions/OtServer/models/cavebot.ahk](versions/OtServer/models/cavebot.ahk)
- **View**: [versions/OtServer/views/cavebot.ahk](versions/OtServer/views/cavebot.ahk)
- **Controller**: [versions/OtServer/controllers/core.ahk](versions/OtServer/controllers/core.ahk)

### Fluxo de execução

```
loader.ahk
  ↓ (usuário escolhe servidor + vocação + idioma)
conf/Login.ini
  ↓
versions/<Servidor>/main.ahk
  ↓
#Include dos models, views e controllers
  ↓
EngineLoop (SetTimer a cada 50ms)
  ↓
Captura de tela → OCR → ação
```

---

## Servidores suportados

| Versão | Pasta | Status |
|---|---|---|
| OtServer (genérico) | [versions/OtServer/](versions/OtServer/) | Mais completo — 13 modelos, controllers com validação, MVC completo |
| [NTSW](https://ntsw.pl/) (Naruto Tibia Otserver) | [versions/NTSW/](versions/NTSW/) | Legado — estrutura em arquivo único |
| PvP Only | [versions/PvP%20Only/](versions/PvP%20Only/) | Especializado em combate (flower, trash, push item) |
| v7.4 | [versions/v7.4/](versions/v7.4/) | Cliente antigo 7.x — runemaker, healing minimal |

O **OtServer** também detecta automaticamente `Shadow-Illusion` e `DeusOT` pela classe da janela e carrega assets específicos.

---

## Estrutura do repositório

```
.
├── loader.ahk              # tela de login inicial
├── libs/                   # bibliotecas compartilhadas
│   ├── GDIP.ahk            # wrapper GDI+ (captura de tela, pattern matching)
│   ├── JSON.ahk
│   ├── bcrypt.ahk
│   ├── PrintScreen.ahk     # captura pixel-perfect (PrintPW / PrintDC)
│   └── Download_File_Progress.ahk
├── versions/               # um diretório por servidor suportado
│   ├── OtServer/
│   ├── NTSW/
│   ├── PvP Only/
│   └── v7.4/
├── assets/
│   ├── images/             # templates de OCR (HP bar, battle list, cooldowns, etc.)
│   └── sounds/             # alertas sonoros
├── LICENSE                 # MIT
└── README.md
```

---

## Dependências

| Dependência | Uso |
|---|---|
| AutoHotkey **v1.1 Unicode 64-bit** | Interpretador (v2 é incompatível) |
| Windows 7 / 10 / 11 | DllCalls e WMI são específicos do Windows |
| Privilégios de admin | `ControlSend` e hooks exigem elevação |
| GDI+ (nativo do Windows) | Captura + pattern matching via [GDIP.ahk](libs/GDIP.ahk) |

---

## Aviso legal

O uso de macros/bots **pode violar os Termos de Serviço** do Tibia Global (CipSoft) e resultar em **banimento permanente** da conta. Este código é disponibilizado **apenas para fins educacionais e de estudo**. Os autores e contribuidores **não se responsabilizam** por qualquer penalidade, perda de conta ou dano decorrente do uso deste software.

Em OTServers (Open Tibia), verifique as regras específicas de cada servidor — cada admin define sua própria política sobre automação.

---

## Contribuindo

**Projeto descontinuado pelo autor original. Sinta-se à vontade para fork e contribuir.**

Issues e PRs podem não ser respondidos no repositório original. Se você quer manter o projeto vivo, **faça um fork** — sob a [licença MIT](LICENSE) você pode continuar o desenvolvimento livremente.

Áreas que precisam de trabalho para quem quiser continuar:
- Port para AutoHotkey v2 (atualmente só roda em v1.1)
- Unificar a estrutura de config entre os servidores (atualmente cada um salva em pastas diferentes)
- Substituir pattern matching por OCR mais robusto (Tesseract, por ex.)

---

## Licença

[MIT](LICENSE)
