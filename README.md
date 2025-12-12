# AQUAVAULT (WRTN)

Proyecto ecológico basado en Binance Smart Chain (BEP-20) para la **creación y mantenimiento de reservas de agua potable**, con un token diseñado para financiar infraestructura hídrica real y, en fases posteriores, soluciones de **enfriamiento sostenible** para servidores y criptominería.

---

## ⚙️ Descripción general

AQUAVAULT (WRTN) conecta la inversión digital con la protección de un recurso crítico: el agua potable.

- **Ticker:** `WRTN`  
- **Red:** Binance Smart Chain (BEP-20)  
- **Supply máximo fijo:** `200.000.000 WRTN`  
- **Emisión adicional:** no existe función de mint posterior al despliegue  
- **Fee ecológico:** 0–2 % (tope duro 2 %) dirigido a la billetera de reservas de agua (`feeRecipient`)  
- **Límite por wallet:** 0–30 % del supply (tope duro 30 %) para wallets externas  
- **Quema:** cualquier holder puede quemar voluntariamente sus WRTN (`burn()`)  
- **Rol de emergencia:** una billetera separada (`emergencyManager`) es la única autorizada para pausar y reanudar transfers  

El contrato es **no actualizable (no proxy)** y está pensado para pasar, tras una fase inicial de ajuste, a un estado **totalmente inmutable** mediante `renounceOwnership()`.

---

## 📄 Whitepaper

### Versión descargable (PDF)

- `docs/whitepaper_aquavault_wrtn_v2.pdf`  
  Whitepaper actualizado con:
  - supply fijo de 200M,
  - fee configurable 0–2 %,
  - límite por wallet 0–30 %,
  - rol de emergencia separado,
  - modelo de gobernanza en dos fases (fase ajustable + renuncia a la propiedad).

### Versión online

- Sitio oficial: **https://tokenaquavault.com**  
  Sección “Whitepaper – AQUAVAULT (WRTN)” con la misma información principal del documento PDF.

---

## 🔑 Características principales del token

### Datos básicos

- **Nombre:** AQUAVAULT  
- **Símbolo:** WRTN  
- **Decimales:** 18  
- **Supply máximo:** `200.000.000 WRTN`  
- **Tipo de contrato:** BEP-20 estándar, no upgradeable  
- **Suministro inicial:** todo el supply se acuña una sola vez en el deploy; no existe `mint()` posterior.

---

### Límite por wallet (anti-ballenas)

Para reducir riesgos de manipulación y concentración extrema:

- Ninguna **wallet externa** puede superar el **30 %** del suministro total (tope duro on-chain).
- El parámetro `maxWalletPercent` permite ajustar el límite entre 0 % y 30 % del supply.
- El switch `walletLimitEnabled` permite activar o desactivar la lógica de límite por wallet.
- Están excluidas del límite (mapeo `isWalletLimitExempt`):
  - Owner (mientras exista),
  - Billetera de reservas de agua (`feeRecipient`),
  - Pools de liquidez y otras wallets técnicas que el proyecto marque como exentas.

Si una transferencia haría que el balance del receptor supere el máximo permitido, la transacción revierte.

---

### Fee ecológico (0–2 %)

Cada transferencia de WRTN puede incluir un **fee ecológico** destinado al Fondo de Reservas de Agua:

- Parámetro `feeBasisPoints` en basis points (`100 = 1 %`, `200 = 2 %`).
- **Rango permitido en el contrato:** `0–200 bps` (0–2 %).  
  El código **impide** establecer un fee mayor al 2 %.
- El fee recaudado se envía a la billetera `feeRecipient`.
- Determinadas wallets pueden marcarse como **exentas de fee** (`isFeeExempt`) para no penalizar:
  - pools de liquidez,
  - billeteras internas del proyecto,
  - operaciones técnicas.

Cuando el fee está configurado en `0`, el token se comporta como un BEP-20 estándar sin comisión.

---

### Quema (burn) y deflación

- No existe mint posterior al despliegue: el supply se fija en **200M**.
- Cualquier holder puede llamar a `burn(uint256 amount)` para destruir sus propios tokens.
- El suministro total (`totalSupply`) se reduce con cada quema, volviendo el token **potencialmente deflacionario**.

---

### Rol de emergencia y pausa global

El contrato incorpora un mecanismo de pausa para situaciones de emergencia:

- Variable pública `emergencyManager`:
  - Es la **única dirección** autorizada para llamar a `pause()` y `unpause()`.
- Mientras el token está en pausa:
  - Las transferencias y operaciones que mueven WRTN quedan bloqueadas (salvo las permitidas por el propio estándar Pausable).
- El owner **no puede** pausar ni reanudar directamente; solo puede:
  - asignar o cambiar la dirección de `emergencyManager` mediante `setEmergencyManager(address)`.

Este diseño separa el control económico (owner) del control operativo de emergencia, permitiendo, por ejemplo, usar una multisig diferente para el botón de pausa.

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

Mientras el contrato tenga un `owner` activo (no renunciado):

El owner puede ajustar **solo parámetros específicos y limitados por código**:

- `feeBasisPoints`: fee de transacción entre `0` y `200` bps (0–2 %).  
- `feeRecipient`: billetera que recibe el fee ecológico.  
- `walletLimitEnabled`: activar o desactivar el límite por wallet.  
- `maxWalletPercent`: límite por wallet entre `0` y `30` % del supply.  
- `emergencyManager`: dirección con permiso para pausar/reanudar.  
- Listas de exenciones:
  - `isFeeExempt[address]`: cuentas exentas de fee.
  - `isWalletLimitExempt[address]`: cuentas exentas del límite por wallet.

No se puede:

- Incrementar el supply (no hay función de `mint`).  
- Superar el 2 % de fee ni el 30 % de límite por wallet (validaciones on-chain).

Todos los cambios administrativos generan eventos y quedan registrados on-chain y se comunicarán por los canales oficiales del proyecto.

### 2. Renuncia a la propiedad e inmutabilidad

Una vez validados en producción:

- el fee ecológico,
- el límite por wallet,
- la configuración de exenciones y rol de emergencia,

el equipo ejecutará `renounceOwnership()`:

- `owner` pasa a ser `address(0)`.
- Ninguna función `onlyOwner` podrá volver a ejecutarse.
- Quedan **congelados de forma definitiva**:
  - fee (`feeBasisPoints`),
  - límite por wallet (`walletLimitEnabled` y `maxWalletPercent`),
  - billetera de fee (`feeRecipient`),
  - listas de exentos y la dirección asignada como `emergencyManager` (tal como estén en ese momento).

A partir de ese punto, el contrato se considera **no modificable**, manteniendo únicamente:

- Transferencias estándar de WRTN.  
- Quema voluntaria por parte de los holders.  
- Cobro automático del fee según el valor fijado antes de la renuncia.  
- Uso del rol de emergencia según la última configuración (si se decide conservar).

---

## 📁 Estructura del repositorio

```text
.
├── assets/                         # Logotipos, imágenes y elementos visuales del proyecto
├── contracts/
│   └── AquaVaultToken.sol          # Implementación principal del token BEP-20 (WRTN)
└── docs/
    ├── whitepaper_aquavault_wrtn_v2.md   # Whitepaper técnico en Markdown
    └── whitepaper_aquavault_wrtn_v2.pdf  # Whitepaper para descarga (PDF)
