�{"header":{"stageCreator":"HadoopFS_01","sourceId":"event:file-closed:1:1586506950424","stagesPath":"HadoopFS_01","trackingId":"event:file-closed:1:1586506950424::HadoopFS_01","previousTrackingId":null,"raw":null,"rawMimeType":null,"errorDataCollectorId":"73c64506-6fa2-11ea-80c6-d162cc9dd014","errorPipelineName":"BronzeLaye487379fc-eab3-4ca4-bec2-52c57421a5ba","errorStage":"HTTPClient_02","errorStageLabel":"HTTP Client To Call Spark Pipeline","errorCode":"HTTP_41","errorMessage":"HTTP_41 - Error sending resource. Reason: javax.ws.rs.ProcessingException: java.net.ConnectException: Connection refused (Connection refused)","errorTimestamp":1586506950545,"errorStackTrace":"com.streamsets.pipeline.api.StageException: HTTP_41 - Error sending resource. Reason: javax.ws.rs.ProcessingException: java.net.ConnectException: Connection refused (Connection refused)\n\tat com.streamsets.pipeline.stage.destination.http.HttpClientTarget.writeOneRequestPerBatch(HttpClientTarget.java:163)\n\tat com.streamsets.pipeline.stage.destination.http.HttpClientTarget.write(HttpClientTarget.java:96)\n\tat com.streamsets.pipeline.api.base.configurablestage.DTarget.write(DTarget.java:34)\n\tat com.streamsets.datacollector.runner.StageRuntime.lambda$execute$2(StageRuntime.java:303)\n\tat com.streamsets.pipeline.api.impl.CreateByRef.call(CreateByRef.java:40)\n\tat com.streamsets.datacollector.runner.StageRuntime.execute(StageRuntime.java:244)\n\tat com.streamsets.datacollector.runner.StageRuntime.execute(StageRuntime.java:311)\n\tat com.streamsets.datacollector.runner.StagePipe.process(StagePipe.java:220)\n\tat com.streamsets.datacollector.execution.runner.common.ProductionPipelineRunner.lambda$destroy$2(ProductionPipelineRunner.java:736)\n\tat com.streamsets.datacollector.runner.PipeRunner.acceptConsumer(PipeRunner.java:221)\n\tat com.streamsets.datacollector.runner.PipeRunner.executeBatch(PipeRunner.java:142)\n\tat com.streamsets.datacollector.execution.runner.common.ProductionPipelineRunner.destroy(ProductionPipelineRunner.java:727)\n\tat com.streamsets.datacollector.runner.Pipeline.destroy(Pipeline.java:420)\n\tat com.streamsets.datacollector.execution.runner.common.ProductionPipeline.run(ProductionPipeline.java:167)\n\tat com.streamsets.datacollector.execution.runner.common.ProductionPipelineRunnable.run(ProductionPipelineRunnable.java:75)\n\tat com.streamsets.datacollector.execution.runner.standalone.StandaloneRunner.start(StandaloneRunner.java:718)\n\tat com.streamsets.datacollector.execution.runner.common.AsyncRunner.lambda$start$3(AsyncRunner.java:151)\n\tat com.streamsets.pipeline.lib.executor.SafeScheduledExecutorService$SafeCallable.lambda$call$0(SafeScheduledExecutorService.java:226)\n\tat com.streamsets.datacollector.security.GroupsInScope.execute(GroupsInScope.java:33)\n\tat com.streamsets.pipeline.lib.executor.SafeScheduledExecutorService$SafeCallable.call(SafeScheduledExecutorService.java:222)\n\tat com.streamsets.pipeline.lib.executor.SafeScheduledExecutorService$SafeCallable.lambda$call$0(SafeScheduledExecutorService.java:226)\n\tat com.streamsets.datacollector.security.GroupsInScope.execute(GroupsInScope.java:33)\n\tat com.streamsets.pipeline.lib.executor.SafeScheduledExecutorService$SafeCallable.call(SafeScheduledExecutorService.java:222)\n\tat java.util.concurrent.FutureTask.run(FutureTask.java:266)\n\tat java.util.concurrent.ScheduledThreadPoolExecutor$ScheduledFutureTask.access$201(ScheduledThreadPoolExecutor.java:180)\n\tat java.util.concurrent.ScheduledThreadPoolExecutor$ScheduledFutureTask.run(ScheduledThreadPoolExecutor.java:293)\n\tat com.streamsets.datacollector.metrics.MetricSafeScheduledExecutorService$MetricsTask.run(MetricSafeScheduledExecutorService.java:100)\n\tat java.util.concurrent.ThreadPoolExecutor.runWorker(ThreadPoolExecutor.java:1149)\n\tat java.util.concurrent.ThreadPoolExecutor$Worker.run(ThreadPoolExecutor.java:624)\n\tat java.lang.Thread.run(Thread.java:748)\nCaused by: javax.ws.rs.ProcessingException: java.net.ConnectException: Connection refused (Connection refused)\n\tat org.glassfish.jersey.client.internal.HttpUrlConnector.apply(HttpUrlConnector.java:287)\n\tat org.glassfish.jersey.client.ClientRuntime.invoke(ClientRuntime.java:252)\n\tat org.glassfish.jersey.client.JerseyInvocation$1.call(JerseyInvocation.java:684)\n\tat org.glassfish.jersey.client.JerseyInvocation$1.call(JerseyInvocation.java:681)\n\tat org.glassfish.jersey.internal.Errors.process(Errors.java:315)\n\tat org.glassfish.jersey.internal.Errors.process(Errors.java:297)\n\tat org.glassfish.jersey.internal.Errors.process(Errors.java:228)\n\tat org.glassfish.jersey.process.internal.RequestScope.runInScope(RequestScope.java:444)\n\tat org.glassfish.jersey.client.JerseyInvocation.invoke(JerseyInvocation.java:681)\n\tat org.glassfish.jersey.client.JerseyInvocation$Builder.method(JerseyInvocation.java:437)\n\tat com.streamsets.pipeline.stage.destination.http.HttpClientTarget.writeOneRequestPerBatch(HttpClientTarget.java:127)\n\t... 29 more\nCaused by: java.net.ConnectException: Connection refused (Connection refused)\n\tat java.net.PlainSocketImpl.socketConnect(Native Method)\n\tat java.net.AbstractPlainSocketImpl.doConnect(AbstractPlainSocketImpl.java:350)\n\tat java.net.AbstractPlainSocketImpl.connectToAddress(AbstractPlainSocketImpl.java:206)\n\tat java.net.AbstractPlainSocketImpl.connect(AbstractPlainSocketImpl.java:188)\n\tat java.net.SocksSocketImpl.connect(SocksSocketImpl.java:392)\n\tat java.net.Socket.connect(Socket.java:589)\n\tat sun.net.NetworkClient.doConnect(NetworkClient.java:175)\n\tat sun.net.www.http.HttpClient.openServer(HttpClient.java:463)\n\tat sun.net.www.http.HttpClient.openServer(HttpClient.java:558)\n\tat sun.net.www.http.HttpClient.<init>(HttpClient.java:242)\n\tat sun.net.www.http.HttpClient.New(HttpClient.java:339)\n\tat sun.net.www.http.HttpClient.New(HttpClient.java:357)\n\tat sun.net.www.protocol.http.HttpURLConnection.getNewHttpClient(HttpURLConnection.java:1220)\n\tat sun.net.www.protocol.http.HttpURLConnection.plainConnect0(HttpURLConnection.java:1156)\n\tat sun.net.www.protocol.http.HttpURLConnection$6.run(HttpURLConnection.java:1040)\n\tat sun.net.www.protocol.http.HttpURLConnection$6.run(HttpURLConnection.java:1038)\n\tat java.security.AccessController.doPrivileged(Native Method)\n\tat java.security.AccessController.doPrivilegedWithCombiner(AccessController.java:782)\n\tat sun.net.www.protocol.http.HttpURLConnection.plainConnect(HttpURLConnection.java:1037)\n\tat sun.net.www.protocol.http.HttpURLConnection.connect(HttpURLConnection.java:984)\n\tat sun.net.www.protocol.http.HttpURLConnection.getOutputStream0(HttpURLConnection.java:1334)\n\tat sun.net.www.protocol.http.HttpURLConnection.access$100(HttpURLConnection.java:91)\n\tat sun.net.www.protocol.http.HttpURLConnection$8.run(HttpURLConnection.java:1301)\n\tat sun.net.www.protocol.http.HttpURLConnection$8.run(HttpURLConnection.java:1299)\n\tat java.security.AccessController.doPrivileged(Native Method)\n\tat java.security.AccessController.doPrivilegedWithCombiner(AccessController.java:782)\n\tat sun.net.www.protocol.http.HttpURLConnection.getOutputStream(HttpURLConnection.java:1298)\n\tat org.glassfish.jersey.client.internal.HttpUrlConnector$4.getOutputStream(HttpUrlConnector.java:390)\n\tat org.glassfish.jersey.message.internal.CommittingOutputStream.commitStream(CommittingOutputStream.java:200)\n\tat org.glassfish.jersey.message.internal.CommittingOutputStream.commitStream(CommittingOutputStream.java:194)\n\tat org.glassfish.jersey.message.internal.CommittingOutputStream.write(CommittingOutputStream.java:228)\n\tat org.glassfish.jersey.message.internal.WriterInterceptorExecutor$UnCloseableOutputStream.write(WriterInterceptorExecutor.java:299)\n\tat sun.nio.cs.StreamEncoder.writeBytes(StreamEncoder.java:221)\n\tat sun.nio.cs.StreamEncoder.implFlushBuffer(StreamEncoder.java:291)\n\tat sun.nio.cs.StreamEncoder.implFlush(StreamEncoder.java:295)\n\tat sun.nio.cs.StreamEncoder.flush(StreamEncoder.java:141)\n\tat java.io.OutputStreamWriter.flush(OutputStreamWriter.java:229)\n\tat com.fasterxml.jackson.core.json.WriterBasedJsonGenerator.flush(WriterBasedJsonGenerator.java:836)\n\tat com.streamsets.datacollector.json.JsonRecordWriterImpl.flush(JsonRecordWriterImpl.java:68)\n\tat com.streamsets.pipeline.lib.generator.json.JsonCharDataGenerator.flush(JsonCharDataGenerator.java:61)\n\tat com.streamsets.pipeline.stage.destination.http.HttpClientTarget.lambda$writeOneRequestPerBatch$0(HttpClientTarget.java:122)\n\tat org.glassfish.jersey.message.internal.StreamingOutputProvider.writeTo(StreamingOutputProvider.java:78)\n\tat org.glassfish.jersey.message.internal.StreamingOutputProvider.writeTo(StreamingOutputProvider.java:60)\n\tat org.glassfish.jersey.message.internal.WriterInterceptorExecutor$TerminalWriterInterceptor.invokeWriteTo(WriterInterceptorExecutor.java:265)\n\tat org.glassfish.jersey.message.internal.WriterInterceptorExecutor$TerminalWriterInterceptor.aroundWriteTo(WriterInterceptorExecutor.java:250)\n\tat org.glassfish.jersey.message.internal.WriterInterceptorExecutor.proceed(WriterInterceptorExecutor.java:162)\n\tat org.glassfish.jersey.message.internal.MessageBodyFactory.writeTo(MessageBodyFactory.java:1130)\n\tat org.glassfish.jersey.client.ClientRequest.doWriteEntity(ClientRequest.java:517)\n\tat org.glassfish.jersey.client.ClientRequest.writeEntity(ClientRequest.java:499)\n\tat org.glassfish.jersey.client.internal.HttpUrlConnector._apply(HttpUrlConnector.java:393)\n\tat org.glassfish.jersey.client.internal.HttpUrlConnector.apply(HttpUrlConnector.java:285)\n\t... 39 more\n","errorJobId":null,"values":{"sdc.event.version":"1","sdc.event.creation_timestamp":"1586506950424","sdc.event.type":"file-closed"}},"value":{"type":"MAP","value":{"filename":{"type":"STRING","value":"file_9353b589-53be-4784-8716-6bfff631374e.json","sqpath":"/filename","dqpath":"/filename"},"filepath":{"type":"STRING","value":"/out/bronze/weather/file_9353b589-53be-4784-8716-6bfff631374e.json","sqpath":"/filepath","dqpath":"/filepath"},"length":{"type":"LONG","value":"182343","sqpath":"/length","dqpath":"/length"}},"sqpath":"","dqpath":""}}