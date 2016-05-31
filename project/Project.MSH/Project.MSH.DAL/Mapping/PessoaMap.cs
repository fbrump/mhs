using Project.MSH.BEL.Entity;
using System;
using System.Collections.Generic;
using System.Data.Entity.ModelConfiguration;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Project.MSH.DAL.Mapping
{
    public class PessoaMap : EntityTypeConfiguration<Pessoa>
    {
        public PessoaMap()
        {
            /*O método ToTable define qual o nome que será
            dado a tabela no banco de dados*/
            ToTable("tb_pessoa");

            //Definimos a propriedade CursoId como chave primária
            HasKey(x => x.id);

            //Descricao terá no máximo 150 caracteres e será um campo "NOT NULL"
            Property(x => x.nome).HasColumnName("nm_pessoa").HasMaxLength(255).IsRequired();
            Property(x => x.sobrenome).HasColumnName("nm_sobrenome").HasMaxLength(400).IsOptional();
            Property(x => x.dataNascimento).HasColumnName("dt_nascimento").IsOptional();

            //HasMany(x => x.ProfessorLista)
            //          .WithMany(x => x.CursoLista)
            //          .Map(m =>
            //          {
            //              m.MapLeftKey("CursoId");
            //              m.MapRightKey("ProfessorId");
            //              m.ToTable("CursoProfessor");
            //          });
        }
    }
}
