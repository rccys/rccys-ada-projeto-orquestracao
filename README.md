# Como executar o projeto
Execute os passos abaixo em ordem sequencial.

Faça o download do projeto ou um git pull.

## Definição de Fraude
Se houve transação em outro estado em menos de uma hora, significa que ocorreu fraude.

Obs.: se for identificada um fraude a transação fraudulenta não será enviada para o cache, isso evita que transações válidas sejam consideradas como fraudulentas, pois a comparação entre os estados onde foram realizadas as transações teria o estado onde ocorreu a fraude devido à consulta ao cache.


## Ferramentas que devem ser instaladas
[Docker]https://www.docker.com/products/docker-desktop/

[Minikube]https://minikube.sigs.k8s.io/docs/start/

[kubectl]https://kubernetes.io/pt-br/docs/tasks/tools/

## Execução dos códigos

```BASH
# Abra o docker desktop, em seguida abra um terminal, navegue até a pasta onde foi realizado o dowloand do projeto.

# 1. Execute os comandos abaixo de forma sequencial para inicar o cluster, habilitar o ingress do minikube e aplicar os recursos no cluster:
docker context use default
minikube start
minikube addons enable ingress
kubectl apply -f namespace.yaml
kubectl apply -f .

# 2. Abra um outro terminal e execute o comando abaixo:
minikube tunnel

# 3. No terminal aberto no item 1 execute o comando abaixo:
kubectl get po -n finance --watch

# 4. Quando o STATUS dos pods redis-0, minio-0 e rabbitmq-0 estiver como running execute o comando abaixo:
ctrl+c

# 5. Ainda no terminal aberto no item 1, copie os nomes completos dos pods fraud-detector-consumer e transaction-producer (resultado do comando anterior) e execute os comandos abaixo:
kubectl -n finance logs -f <nome completo do transaction-producer> # logs das transações efetuadas (pode demorar alguns segundos para aparecer algo, basta esperar)
# para sair do log digite ctrl+C

# 6. Abra um outro terminal e execute o comando abaixo:
kubectl -n finance logs -f <nome completo do fraud-detector-consumer> # logs das transações fraudulentas (pode demorar alguns segundos para aparecer algo, basta esperar)
# para sair do log digite ctrl+C

# 7. Para visualizar o conteúdo do relatório basta copiar o link para dowloand do arquivo desejado e executar os comandos abaixo:
k -n finance exec -it minio-0 -- sh -c "curl <link para dowloand do arquivo desejado>"

# Para parar a aplicação e apagar o cluster execute os comandos abaixo de forma sequencial:
ctrl+c # no terminal aonde foi executado minikube tunnel
minikube stop
minikube delete --all

```

### Obs.:
Queria implementar o download do relatório de fraudes pelo browser.

Queria implementar o HPA nas minhas aplicações, mas não consegui deixar o projeto 100% funcional devido ao mencionado anteriormente e como conversado na apresentação achei melhor entregar algo funcional que trazer mais uma complexidade e comprometer a entrega do projeto.
