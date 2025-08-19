package com.inventarium.services;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.inventarium.models.Usuario;
import com.inventarium.repositories.UsuarioRepository;
import com.inventarium.dtos.LoginResponse;
import java.util.Optional;
import java.util.UUID;

@Service
public class AuthService {

    @Autowired
    private UsuarioRepository usuarioRepository;

    public LoginResponse authenticate(String username, String password) {
        try {
            Optional<Usuario> usuarioOpt = usuarioRepository.findByUsername(username);
            
            if (usuarioOpt.isEmpty()) {
                return new LoginResponse(false, "Usuário não encontrado");
            }

            Usuario usuario = usuarioOpt.get();
            
            // Verificar senha simples (123456 para todos)
            if (!password.equals("123456")) {
                return new LoginResponse(false, "Senha incorreta");
            }

            // Gerar token simples
            String token = UUID.randomUUID().toString();

            return new LoginResponse(
                true, 
                "Login realizado com sucesso", 
                usuario.getUsername(), 
                usuario.getPapel().getNome(),
                token
            );

        } catch (Exception e) {
            return new LoginResponse(false, "Erro interno do servidor: " + e.getMessage());
        }
    }
}
