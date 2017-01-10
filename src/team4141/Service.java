package team4141;
import org.apache.commons.daemon.Daemon;
import org.apache.commons.daemon.DaemonContext;
import org.apache.commons.daemon.DaemonInitException;

public class Service implements Daemon{
    private boolean stopped = true;
    private Thread myThread; 

	@Override
	public void init(DaemonContext daemonContext) throws DaemonInitException, Exception {
        /*
         * Construct objects and initialize variables here.
         * You can access the command line arguments that would normally be passed to your main() 
         * method as follows:
         */
		String[] args = daemonContext.getArguments(); 
	        
		myThread = new Thread(){
            private boolean lastTick = false;
            
            @Override
            public synchronized void start() {
                stopped = false;
                super.start();
            }

            @Override
            public void run() {             
                while(!stopped){
                    System.out.println(lastTick ? "tock" : "tick");
                    try {
						Thread.sleep(1000);
					} catch (InterruptedException e) {
						System.err.println("Unexpected Thread Error.  Aborting!");
						System.exit(1);
					}
                    lastTick = !lastTick; 
                }
            }
        };		
	}
	
	@Override
	public void destroy() {
		myThread = null;	
	}



	@Override
	public void start() throws Exception {
		myThread.start();
	}

	@Override
	public void stop() throws Exception {
		stopped = true;
        try{
            myThread.join(1000);
        }catch(InterruptedException e){
            System.err.println(e.getMessage());
            throw e;
        }
	}

}
