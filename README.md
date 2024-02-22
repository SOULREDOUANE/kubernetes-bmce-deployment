kubectl -n bmce create secret generic postgresql
--from-literal=POSTGRES_USER="soul-redouane"
--from-literal=POSTGRES_PASSWORD='soul'
--from-literal=POSTGRES_DB="mydatabase"
--from-literal=REPLICATION_USER="replicationuser"
--from-literal=REPLICATION_PASSWORD='replicationPassword'