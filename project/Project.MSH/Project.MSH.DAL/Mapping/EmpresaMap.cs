using Project.MSH.BEL.Entity;
using System;
using System.Collections.Generic;
using System.Data.Entity.ModelConfiguration;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Project.MSH.DAL.Mapping
{
    public class EmpresaMap : EntityTypeConfiguration<Empresa>
    {
        public EmpresaMap()
        {
            /*O método ToTable define qual o nome que será
            dado a tabela no banco de dados*/
            ToTable("tb_empresa");
            
            HasKey(x => x.id);
            
            Property(x => x.nm_empresa).HasColumnName("nm_empresa").HasMaxLength(300).IsRequired();
            Property(x => x.nm_fantasia).HasColumnName("nm_fantasia").HasMaxLength(500).IsOptional();

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
