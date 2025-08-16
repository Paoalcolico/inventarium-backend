# Banco de Dados Inventarium - MySQL

## 🗄️ **Schema Criado com Sucesso!**

### **Estrutura do Banco:**

#### 📋 **Tabelas Criadas:**
1. **`papel`** - Papéis/roles dos usuários (ADMIN, GERENTE, OPERADOR, VISUALIZADOR)
2. **`usuario`** - Usuários com hierarquia e controle de acesso
3. **`marca`** - Marcas dos produtos (Samsung, Apple, Xiaomi, etc.)
4. **`produto`** - Produtos com marca, preço, estoque, etc.
5. **`transacao`** - Cabeçalho das transações (ENTRADA/SAIDA)
6. **`transacao_item`** - Itens detalhados de cada transação
7. **`log_usuario`** - Auditoria de ações dos usuários

---

## 🔑 **Dados Iniciais Inseridos:**

### **Papéis (4 registros):**
- **ADMIN** - Administrador do sistema (nível 1)
- **GERENTE** - Gerente com relatórios (nível 2)  
- **OPERADOR** - Operador básico (nível 3)
- **VISUALIZADOR** - Apenas leitura (nível 4)

### **Usuários (5 registros):**
- **admin** - Administrador principal (senha: admin123)
- **joao.silva** - Gerente
- **maria.santos** - Operadora
- **pedro.costa** - Operador
- **ana.oliveira** - Visualizadora

### **Marcas (8 registros):**
Samsung, Apple, Xiaomi, LG, Sony, Dell, HP, Lenovo

### **Produtos (8 registros):**
- Galaxy S24 Ultra - R$ 1.299,99 (25 unid.)
- iPhone 15 Pro - R$ 1.899,99 (15 unid.)
- Redmi Note 13 - R$ 449,99 (50 unid.)
- OLED CX 55" - R$ 2.299,99 (8 unid.)
- E mais...

---

## 📊 **Comandos Úteis:**

### **Listar produtos por marca:**
```sql
SELECT p.nome, m.nome AS marca, p.valor_unitario, p.quantidade 
FROM produto p 
JOIN marca m ON p.marca_id = m.id 
ORDER BY m.nome, p.nome;
```

### **Ver transações com detalhes:**
```sql
SELECT t.id, t.tipo, t.valor_total, t.data_transacao, u.nome AS usuario
FROM transacao t
JOIN usuario u ON t.usuario_id = u.id
ORDER BY t.data_transacao DESC;
```

### **Auditoria de usuário:**
```sql
SELECT l.data_hora, l.acao, l.tabela_afetada, u.nome AS usuario
FROM log_usuario l
JOIN usuario u ON l.usuario_id = u.id
ORDER BY l.data_hora DESC
LIMIT 10;
```

### **Estoque baixo (menos de 20 unidades):**
```sql
SELECT p.nome, m.nome AS marca, p.quantidade, p.localizacao
FROM produto p
JOIN marca m ON p.marca_id = m.id
WHERE p.quantidade < 20
ORDER BY p.quantidade;
```

---

## 🔧 **Recursos Implementados:**

### **🔒 Segurança:**
- Constraints de integridade referencial
- Índices para otimização de consultas
- Campo de auditoria em todas as tabelas principais
- Controle hierárquico de usuários

### **📈 Performance:**
- Índices em campos de busca frequente
- Campo calculado para valor total nos itens
- Timestamps automáticos
- Constraints CHECK para validação

### **🔍 Auditoria:**
- Log completo de ações dos usuários
- Rastreamento de mudanças
- Controle de data/hora automático

---

## 🚀 **Como usar:**

### **1. Conectar ao banco:**
```bash
mysql -u root -proot inventarium
```

### **2. Comandos de teste:**
```sql
-- Ver todos os produtos
SELECT * FROM produto;

-- Ver usuários e seus papéis
SELECT u.nome, u.username, p.nome AS papel 
FROM usuario u 
JOIN papel p ON u.papel_id = p.id;

-- Ver transações recentes
SELECT * FROM transacao ORDER BY data_transacao DESC LIMIT 5;
```

### **3. Backup do banco:**
```bash
mysqldump -u root -proot inventarium > backup_inventarium.sql
```

---

## ✅ **Status:**
- ✅ Banco criado e funcional
- ✅ Todas as tabelas criadas
- ✅ Dados iniciais inseridos
- ✅ Constraints configuradas
- ✅ Índices otimizados
- ✅ Pronto para uso!

O banco está 100% operacional e pronto para ser integrado com sua aplicação!
