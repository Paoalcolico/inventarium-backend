package com.inventarium.repositories;

import com.inventarium.models.Marca;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface MarcaRepository extends JpaRepository<Marca, Long> {
    Marca findByNome(String nome);
}
