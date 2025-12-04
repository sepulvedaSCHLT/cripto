# AQUAVAULT (WRTN) – Smart Contract (BEP-20)

AQUAVAULT (WRTN) es un token BEP-20 desplegado sobre BNB Smart Chain cuyo objetivo es financiar
reservas de agua potable y, en fases posteriores, sistemas de enfriamiento sostenible para
infraestructura tecnológica y minería de criptomonedas.

Este repositorio contiene el código fuente del smart contract, la documentación técnica y los
scripts de despliegue/pruebas.

---

## Especificaciones básicas

- Red: BNB Smart Chain (BEP-20)
- Nombre del token: AQUAVAULT
- Símbolo: `WRTN`
- Decimales: `18`
- Suministro inicial: `100,000,000 WRTN`
- Lenguaje: Solidity 0.8.x
- Librerías: OpenZeppelin (ERC20, Ownable, Pausable, etc.)
- Contrato **no upgradable** (lógica fija una vez desplegado)

---

## Mecanismos principales del contrato

### 1. Límite máximo por wallet (maxWallet)

El contrato implementa un límite máximo de tokens que puede mantener una wallet, expresado como
porcentaje del suministro total (`maxWalletPercent`), con un **tope duro del 30%**.

- Variable clave:
  - `maxWalletPercent` – porcentaje máximo permitido por wallet.
  - `maxWalletEnabled` – booleano que activa o desactiva el límite.

- Regla de negocio:
  - Ninguna wallet (salvo las exentas) puede superar el porcentaje configurado.
  - **Nuevo comportamiento** (versión actual):  
    `setMaxWalletPercent(uint16 newPercent)` permite:
    - Subir o bajar el valor de `maxWalletPercent`.
    - `newPercent` **nunca puede ser mayor que 30** (30% del supply).
  - Tope estructural: `maxWalletPercent <= 30`.

- Exclusiones:
  - Algunas direcciones pueden estar exentas del límite, por ejemplo:
    - Owner / multisig del proyecto.
    - Wallets técnicas (contratos, pools, etc.).
  - Se gestionan con:
    - `setMaxWalletExemption(address account, bool excluded)`

- Activación / desactivación:
  - Activar el límite:
    - `setMaxWalletEnabled(true)`
  - Desactivar el límite:
    - `setMaxWalletEnabled(false)`

Este mecanismo sirve para evitar concentraciones excesivas, pero manteniendo flexibilidad para adaptar
el límite a las necesidades del proyecto sin superar nunca el 30%.

---

### 2. Fee del 2% para el fondo de agua

El contrato implementa un fee fijo del **2%** sobre el monto transferido cuando la función de fee está
activada. Este porcentaje se envía a una wallet específica denominada `waterFundWallet`.

- Variables clave:
  - `feeEnabled` – activa/desactiva el fee global.
  - `feeBps` – 200 basis points (2%).
  - `waterFundWallet` – dirección que recibe el 2%.

- Regla:
  - Si `feeEnabled == true` y **ninguna** de las dos direcciones (`from`, `to`) está exenta:
    - Se calcula el 2% del `amount`.
    - Se envía el 2% a `waterFundWallet`.
    - El 98% restante llega al destinatario.
  - Si el fee está desactivado o alguna de las partes es exenta, no se cobra comisión.

- Funciones de control:
  - Activar / desactivar fee:
    - `setFeeEnabled(bool enabled)`
      - `true` → se cobra 2%.
      - `false` → no se cobra fee.
  - Exenciones:
    - `setFeeExemption(address account, bool excluded)`
      - `true` → la dirección queda exenta (no paga ni cobra fee).
      - `false` → vuelve a estar sujeta al fee.
  - Wallet del fondo de agua:
    - `setWaterFundWallet(address newWallet)`

Todas estas funciones son `onlyOwner`.

---

### 3. Pausa global (Pausable)

El contrato permite pausar todas las transferencias en caso de emergencia:

- `pause()` – solo owner.
  - Bloquea transferencias (y, según configuración, otras operaciones sensibles).
- `unpause()` – solo owner.
  - Restaura el funcionamiento normal.

Mientras el contrato está pausado, las operaciones sujetas a `whenNotPaused` se revierten.

---

### 4. Mint y Burn

#### Mint

- Función: `mint(address to, uint256 amount)`
- Acceso: solo `owner`.
- Efecto:
  - Incrementa el balance de `to`.
  - Incrementa `totalSupply` en `amount`.
- Notas:
  - `amount` se expresa en unidades con 18 decimales.
  - Ejemplo: 10,000 WRTN → `10_000 * 10^18`.

Opcionalmente, el contrato puede incluir `finishMinting()` para deshabilitar permanentemente nuevos
mint (según la versión final).

#### Burn (por usuario)

- Función: `burn(uint256 amount)`
- Acceso: cualquier holder.
- Efecto:
  - Quema tokens del **propio balance** de `msg.sender`.
  - Reduce `totalSupply` en esa cantidad.
- No permite al owner quemar tokens de otras wallets.

---

### 5. Propiedad (Owner) y seguridad

- El owner controla:
  - `setFeeEnabled`, `setFeeExemption`.
  - `setMaxWalletEnabled`, `setMaxWalletPercent`, `setMaxWalletExemption`.
  - `setWaterFundWallet`.
  - `pause` / `unpause`.
  - `mint` (y `finishMinting` si aplica).
  - `transferOwnership`.

- Cambio de owner:
  - `transferOwnership(address newOwner)` – solo owner.
  - Recomendado: migrar a una wallet multisig para despliegue en mainnet.

---

## Cambio clave respecto a versiones anteriores

En versiones anteriores, `setMaxWalletPercent` solo permitía **reducir** el límite, nunca aumentarlo.
Tras la modificación:

- El límite sigue teniendo un **tope duro del 30%** del suministro total por wallet.
- El owner puede **subir o bajar** el porcentaje, siempre `<= 30`.
- Todo lo demás (2% de fee, pausa, mint/burn, exenciones) se mantiene sin cambios.

Este README refleja el comportamiento actual del contrato en testnet y será la base para la versión
final destinada a mainnet.
