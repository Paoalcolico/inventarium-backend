# Migração de SQLite para MySQL - Inventarium

## Pré-requisitos

### 1. Instalar MySQL Server

**Ubuntu/Debian:**
```bash
sudo apt update
sudo apt install mysql-server
sudo mysql_secure_installation
```

**CentOS/RHEL/Fedora:**
```bash
sudo dnf install mysql-server
sudo systemctl start mysqld
sudo systemctl enable mysqld
sudo mysql_secure_installation
```

**macOS (com Homebrew):**
```bash
brew install mysql
brew services start mysql
mysql_secure_installation
```

**Windows:**
Baixe e instale o MySQL Installer do site oficial.

### 2. Configurar o banco de dados

```sql
-- Conectar ao MySQL como root
mysql -u root -p

-- Criar o banco de dados (opcional, pois está configurado para criar automaticamente)
CREATE DATABASE inventarium CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- Criar usuário específico para a aplicação (recomendado)
CREATE USER 'inventarium_user'@'localhost' IDENTIFIED BY 'sua_senha_aqui';
GRANT ALL PRIVILEGES ON inventarium.* TO 'inventarium_user'@'localhost';
FLUSH PRIVILEGES;

-- Sair
EXIT;
```

## Configuração do application.properties

As seguintes alterações já foram feitas no arquivo `application.properties`:

- ✅ URL do banco alterada para MySQL
- ✅ Driver JDBC configurado para MySQL
- ✅ Dialeto do Hibernate alterado para MySQL

### Configuração atual:
```properties
spring.datasource.url=jdbc:mysql://localhost:3306/inventarium?createDatabaseIfNotExist=true&useSSL=false&serverTimezone=UTC
spring.datasource.driver-class-name=com.mysql.cj.jdbc.Driver
spring.datasource.username=root
spring.datasource.password=
```

### Configuração recomendada para produção:
```properties
spring.datasource.url=jdbc:mysql://localhost:3306/inventarium?createDatabaseIfNotExist=true&useSSL=true&serverTimezone=UTC
spring.datasource.username=inventarium_user
spring.datasource.password=sua_senha_aqui
```

## Alterações no pom.xml

As seguintes alterações já foram feitas:

- ✅ Removida dependência do SQLite
- ✅ Removida dependência do hibernate-community-dialects
- ✅ Adicionada dependência do MySQL Connector/J

## Migração de dados (opcional)

Se você quiser migrar os dados existentes do SQLite para MySQL, siga estes passos:

### 1. Exportar dados do SQLite
```bash
# No diretório do projeto backend
sqlite3 inventory.db ".dump" > sqlite_dump.sql
```

### 2. Limpar o dump para MySQL
```bash
# Remover comandos específicos do SQLite
sed -i 's/PRAGMA.*;//g' sqlite_dump.sql
sed -i 's/BEGIN TRANSACTION;/START TRANSACTION;/g' sqlite_dump.sql
sed -i 's/COMMIT;/COMMIT;/g' sqlite_dump.sql
```

### 3. Importar para MySQL
```bash
mysql -u root -p inventarium < sqlite_dump.sql
```

## Teste da aplicação

1. **Parar a aplicação** se estiver rodando
2. **Certificar-se que o MySQL está rodando:**
   ```bash
   sudo systemctl status mysql  # Linux
   brew services list | grep mysql  # macOS
   ```

3. **Iniciar a aplicação:**
   ```bash
   mvn spring-boot:run
   ```

4. **Verificar logs** para confirmar conexão com MySQL
5. **Testar endpoints** da API

## Possíveis problemas e soluções

### Erro de conexão MySQL
- Verificar se o MySQL está rodando
- Verificar usuário/senha no application.properties
- Verificar se o banco 'inventarium' existe ou se createDatabaseIfNotExist=true está configurado

### Erro de fuso horário
- Adicionar `serverTimezone=UTC` na URL de conexão (já configurado)

### Erro de SSL
- Para desenvolvimento local, usar `useSSL=false` (já configurado)
- Para produção, configurar SSL adequadamente

### Problemas de caracteres especiais
- Certificar-se que o banco está usando charset utf8mb4

## Benefícios da migração

- ✅ Melhor performance em aplicações com múltiplos usuários
- ✅ Suporte nativo a transações ACID
- ✅ Melhor suporte para aplicações em produção
- ✅ Ferramentas avançadas de backup e recuperação
- ✅ Escalabilidade horizontal com replicação
