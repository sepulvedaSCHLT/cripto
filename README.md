# AQUAVAULT (WRTN)

**AQUAVAULT (WRTN)** es un token BEP-20 desplegado en **BNB Smart Chain (BSC)**, diseñado para financiar la creación de reservas de agua potable y, en fases posteriores, soluciones de enfriamiento sostenible para infraestructura tecnológica (data centers, minería, etc.).

El objetivo del proyecto es combinar **impacto ambiental real** con **transparencia on-chain**, utilizando un token con lógica de gobernanza y protección para la comunidad.

---

## 1. Descripción general

- **Nombre del token**: AQUAVAULT  
- **Ticker**: `WRTN`  
- **Red de referencia**: BNB Smart Chain (estándar BEP-20)  
- **Estándar**: BEP-20 (equivalente a ERC-20 en BSC)  
- **Decimales**: 18  
- **Suministro inicial**: `100,000,000 WRTN`  

La lógica del contrato se ha diseñado para:

- Financiar un **fondo de agua** mediante un pequeño fee en las transacciones.
- Evitar concentraciones excesivas de tokens en una sola wallet (“anti-ballena”).
- Permitir la expansión controlada del suministro en función de las necesidades del proyecto.

---

## 2. Funcionalidades principales del smart contract

### 2.1 Fee ecológico (hasta 2 %)

El contrato puede aplicar un **fee del 2 %** sobre las transferencias de WRTN.  
Este fee se dirige a una **wallet de fondo de agua** controlada por el proyecto y destinada a:

- Creación y mantenimiento de reservas de agua potable.
- Desarrollo futuro de infraestructura de enfriamiento sostenible.

Características clave:

- El fee se puede activar o desactivar globalmente.
- Determinadas direcciones pueden ser exentas de fee (por ejemplo, contratos de liquidez o integraciones específicas).
- Cuando el fee está activado y la operación no está exenta:
  - El 2 % del monto se envía al fondo de agua.
  - El 98 % restante se transfiere al destinatario.

### 2.2 Límite máximo por wallet (anti-ballena)

Para reducir riesgos de manipulación y concentración extrema, el contrato implementa un **límite máximo de tokens por wallet**, expresado como **porcentaje del suministro total**:

- El porcentaje máximo es **configurable por el owner**, con un **tope duro del 30 %** del suministro total.
- Ninguna wallet (salvo excepciones explícitas dentro del contrato) puede superar ese límite.
- Este límite se aplica principalmente a:
  - Transferencias entre usuarios.
  - Recepción de tokens vía mint hacia direcciones no exentas.

Este mecanismo busca proteger a los holders frente a acumulaciones extremas y posibles movimientos de “ballenas”.

### 2.3 Minting controlado

El contrato permite **crear nuevos tokens** (`mint`) bajo control del **owner**:

- Solo el owner puede ejecutar `mint`.
- Cada operación de mint:
  - Aumenta el balance de la dirección de destino.
  - Aumenta el `totalSupply` del token.
- Su uso está orientado a fases futuras del proyecto (por ejemplo, expansión de infraestructura o acuerdos estratégicos), siempre sujeto a una política transparente.

### 2.4 Quema voluntaria de tokens (burn)

Cualquier usuario puede **quemar sus propios tokens**:

- La función `burn` reduce el balance del usuario y el suministro total.
- La quema es voluntaria y definitiva (los tokens quemados no pueden recuperarse).
- Todas las operaciones de burn quedan registradas on-chain, aportando transparencia a la evolución del suministro.

### 2.5 Pausa global de transfers

El contrato es **pausable**:

- En caso de incidente grave, vulnerabilidad o evento crítico, el owner puede pausar las transferencias.
- Mientras el contrato está pausado, las operaciones sujetas a esta condición son rechazadas.
- Una vez resuelto el incidente, se puede reanudar el funcionamiento normal mediante la función de “unpause”.

Este mecanismo añade una capa adicional de seguridad ante escenarios imprevistos.

### 2.6 Gestión de propiedad (ownership)

El contrato sigue el patrón clásico de propiedad (`Ownable`):

- El owner puede **transferir la propiedad** a otra dirección.
- La propiedad del contrato controla:
  - Configuración del fee.
  - Configuración del límite por wallet.
  - Pausa/unpause.
  - Operaciones de mint.
- A futuro, el proyecto puede evaluar:
  - Migrar el ownership a una **wallet multi-firma**.
  - Renunciar a la propiedad para avanzar hacia modelos de gobernanza más descentralizados, según lo defina la hoja de ruta.

---

## 3. Especificaciones técnicas

- **Lenguaje**: Solidity `^0.8.20`  
- **Estándar**: BEP-20 (compatibilidad ERC-20 en BNB Smart Chain).  
- **Patrones utilizados**:
  - `Ownable` para la gestión de propiedad.
  - Mecanismo de **pausabilidad** (pause/unpause).
  - Validaciones para **límite máximo por wallet**.
  - Lógica de **fee** integrada en la función de transferencia.

Se recomienda revisar el código fuente directamente en el archivo del contrato principal antes de cualquier integración o despliegue en producción.

---

## 4. Uso y desarrollo

### 4.1 Revisión del contrato

1. Clonar el repositorio:

   ```bash
   git clone https://github.com/sepulvedaSCHLT/aquavault-wrtn.git
   cd aquavault-wrtn

