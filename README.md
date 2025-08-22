# 📡 5G Core Network & Network Slicing

## 5G Core (Standalone Mode)

<img src="5GC.png" alt="5G Core (Standalone Mode)" width="600">

### Core Functions

- **AMF (Access & Mobility Management Function)**  
  Handles registration, mobility, access authentication, and connection management.

- **SMF (Session Management Function)**  
  Manages PDU sessions, allocates UE IP, and controls user-plane traffic steering at UPF.

- **UPF (User Plane Function)**  
  Forwards and routes user data packets, manages QoS, and acts as a mobility anchor.

- **UDM (Unified Data Management)**  
  Stores and manages subscriber data and authentication credentials.

- **AUSF (Authentication Server Function)**  
  Authenticates devices and users in coordination with UDM.

- **PCF (Policy Control Function)**  
  Enforces policies for QoS, slicing, roaming, mobility, and billing.

---

## 5G Network Slicing

<img src="Network Slicing.png" alt="Network Slicing" width="600">

Network slicing enables the creation of isolated, end-to-end logical networks that can run concurrently over a shared 5G infrastructure.  
Each slice can be tailored with different performance characteristics such as **latency, bandwidth, and reliability** depending on the use case.

### 🔹 Importance of Network Slicing
- **Customization**: Different services have different requirements.  
- **Efficiency**: Optimal use of resources by allocating only what's needed.  
- **Scalability**: Easy to scale or deploy new slices for emerging use cases.  
- **Security**: Slices are isolated from each other, reducing security risks.  

### 🔹 Challenges in Network Slicing
- Complex orchestration and management  
- Interoperability between vendors  
- Security and isolation between slices  
- Dynamic resource allocation  

### 🔹 Applications of Network Slicing
- Smart cities  
- Autonomous vehicles  
- Telemedicine  
- Virtual Reality (VR) & Augmented Reality (AR)  
- Industrial automation  

---

## Registration Procedure

<img src="Registration.png" alt="Registration procedure" width="600">

## 🔹 Steps Explained
1. **UE → RAN** : UE sends an initial registration request.  
2. **RAN → AMF1** : Registration signaling is forwarded to AMF1.  
3. **AMF1 → UDM** : AMF1 queries UDM to fetch subscription data.  
4. **UDM → AMF1** : UDM responds with UE subscription and slice info.  
5. **AMF1 → NSSF** : Requests slice selection information.  
6. **NSSF → AMF1** : Provides slice selection details.  
7. **AMF1 → AMF2 (Optional)** : If the slice requires a different AMF, reallocation takes place.  
8. **AMF1/AMF2 Coordination** :  
   - **8a**: AMF1 identifies slice mismatch.  
   - **8b**: Redirects UE context to AMF2.  
   - **8c**: RAN updates its mapping to new AMF.  
   - **8d**: UE continues signaling via AMF2.  
9. **UE ← RAN** : Final registration response is delivered back to UE.

---

## Signalling Flow

<img src="signalling.png" alt="Signalling flow graph" width="600">


## 🔹 Procedure
1. **Registration Request (UE → RAN → AMF):**  
   - UE sends registration request including:  
     - **Requested NSSAI** (Network Slice Selection Assistance Information).  
     - **Network slicing indication**.  

2. **Slice Information Exchange (AMF ↔ NSSF):**  
   - **AMF → NSSF:** Slice Information Request.  
   - **NSSF → AMF:** Slice Information Response (allowed slice options).  

3. **Slice Selection Request/Response:**  
   - **AMF → NSSF:** Sends UE capabilities for slice selection.  
   - **NSSF → AMF:** Returns **Service-specific schema** for slice allocation.  

4. **Authentication & Security:**  
   - AMF interacts with **UDM** and **AUSF** to authenticate the UE and secure the connection.  

5. **Registration Accept (AMF → UE):**  
   - Final message includes:  
     - Allowed NSSAI  
     - Configured NSSAI  
     - Network Slicing Indication  
     - NSSAI Inclusion Mode  

---

## Example Command

```bash
sudo apt update
