# AQUAVAULT (WRTN)

Proyecto ecológico basado en Binance Smart Chain (BEP-20) para la **creación y mantenimiento de reservas de agua potable**, con un token diseñado para financiar infraestructura hídrica real y, en fases posteriores, soluciones de **enfriamiento sostenible** para servidores y criptominería.

---

## ⚙️ Descripción general

AQUAVAULT (WRTN) conecta la inversión digital con la protección de un recurso crítico: el agua potable.

- **Ticker:** `WRTN`  
- **Red:** Binance Smart Chain (BEP-20)  
- **Supply máximo fijo:** `200.000.000 WRTN`  
- **Emisión adicional:** no existe función de mint posterior al despliegue  
- **Fee ecológico:** 0–2 % (tope duro 2 %) dirigido al Fondo de Reservas de Agua  
- **Límite por wallet:** 0–30 % del supply (tope duro 30 %) para wallets externas  
- **Quema:** cualquier holder puede quemar voluntariamente sus WRTN (`burn()`)  

El contrato es **no actualizable (no proxy)** y está pensado para pasar, tras una fase inicial de ajuste, a un estado **totalmente inmutable** mediante `renounceOwnership()`.

---

## 📄 Whitepaper

### Versión descargable (PDF)

- `docs/whitepaper_aquavault_wrtn_v2.pdf`  
  (Whitepaper actualizado con supply de 200M, fee 0–2 %, límite 30 % y modelo de gobernanza en dos fases).

### Versión online

- Sitio oficial: **https://tokenaquavault.com**  
  Sección “Whitepaper – AQUAVAULT (WRTN)” con la misma información del documento PDF.

---

## 🔑 Características principales del token

### Datos básicos

- **Nombre:** AQUAVAULT  
- **Símbolo:** WRTN  
- **Decimales:** 18  
- **Supply máximo:** `200.000.000 WRTN`  
- **Tipo de contrato:** BEP-20 estándar, no upgradeable

### Límite por wallet (anti-ballenas)

Para reducir riesgos de manipulación y concentración extrema:

- Ninguna **wallet externa** puede superar el **30 %** del suministro total (tope duro on-chain).
- El parámetro `maxWalletBps` permite ajustar el límite entre 0 % y 30 % del supply.
- Están excluidas del límite:
  - Owner (mientras exista),
  - Wallet de reserva de agua,
  - Pool de liquidez principal,
  - Otras wallets internas marcadas por el proyecto.

### Fee ecológico (0–2 %)

Cada transferencia de WRTN puede incluir un **fee ecológico** destinado al Fondo de Reservas de Agua:

- Parámetro `feeBasisPoints` en basis points (`100 = 1 %`, `200 = 2 %`).
- **Rango permitido en el contrato:** `0–200 bps` (0–2 %).  
  El código **impide** establecer un fee mayor al 2 %.
- El fee se envía a una `reserveWallet` dedicada al fondo ecológico.
- Determinadas wallets (reserva, liquidez, internas) pueden ser marcadas como **exentas de fee**.

Cuando el fee está configurado en `0`, el token se comporta como un BEP-20 sin comisión.

### Quema (burn) y deflación

- No existe mint posterior al despliegue: el supply se fija en 200M.
- Cualquier holder puede llamar a `burn(uint256 amount)` para destruir sus propios tokens.
- El suministro total se reduce con cada quema, volviendo el token **potencialmente deflacionario**.

---

## 📊 Tokenomics (distribución del supply)

Tokenomics base sobre el supply máximo de **200.000.000 WRTN**:

- **50 % – Fondo de Reserva de Agua**  
  Financia proyectos de agua potable, sostenibilidad ambiental y mantenimiento de infraestructuras.

- **20 % – Liquidez inicial**  
  Provisión de liquidez en DEX/CEX para facilitar la negociación y reducir volatilidad extrema.

- **15 % – Marketing y promoción**  
  Campañas, listados, partnerships y crecimiento de la comunidad.

- **10 % – Desarrollo tecnológico**  
  Evolución del contrato, integraciones Web3, herramientas de monitoreo y soluciones de enfriamiento sostenible.

- **5 % – Fondo de emergencia**  
  Auditorías, seguridad y contingencias operativas.

Los detalles operativos y movimientos relevantes se documentarán en el whitepaper, la web oficial y este repositorio.

---

## 🏛️ Gobernanza del contrato inteligente

AQUAVAULT (WRTN) utiliza un **modelo de gobernanza en dos fases**:

### 1. Fase ajustable inicial

Mientras el contrato tenga un `owner` activo:

- Se pueden ajustar solo parámetros específicos y **limitados por código**:

  - `feeBasisPoints`: fee de transacción entre `0` y `200` bps (0–2 %).  
  - `maxWalletBps`: límite por wallet entre `0` y `3.000` bps (0–30 %).  
  - `reserveWallet`: wallet de reserva de agua.  
  - `liquidityPool`: dirección de la pool de liquidez principal.  
  - Listas de wallets excluidas de fee y/o límite por wallet.

- No se puede:
  - Incrementar el supply (no hay función de mint).  
  - Superar el 2 % de fee ni el 30 % de límite por wallet.

Todos los cambios administrativos se registran on-chain y se comunicarán por los canales oficiales del proyecto.

### 2. Renuncia a la propiedad e inmutabilidad

Una vez validados en producción:

- El fee ecológico,
- El límite por wallet,
- La configuración de liquidez y wallets internas,

el equipo ejecutará `renounceOwnership()`:

- `owner` pasa a ser `address(0)`.
- Ninguna función `onlyOwner` podrá volver a ejecutarse.
- Quedan **congelados de forma definitiva** el fee, el límite por wallet, la wallet de reserva y la configuración de exclusiones.

A partir de ese punto, el contrato se considera **no modificable**, manteniendo únicamente:

- Transferencias estándar de WRTN.  
- Quema voluntaria por parte de los holders.  
- Cobro automático del fee según el valor fijado antes de la renuncia.

---

## 📁 Estructura del repositorio

```text
.
├── assets/                 # Logotipos, imágenes y elementos visuales del proyecto
├── contracts/              # Contratos inteligentes de AQUAVAULT (WRTN)
│   └── AquaVaultToken.sol  # Implementación principal del token BEP-20
└── docs/                   # Documentación del proyecto
    ├── whitepaper_aquavault_wrtn_v1.pdf  # Versión histórica (no vigente)
    └── whitepaper_aquavault_wrtn_v2.pdf  # Whitepaper actualizado (versión vigente)
