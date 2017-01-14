package team4141;

import org.apache.commons.daemon.DaemonContext;
import org.apache.commons.daemon.DaemonController;
import org.apache.commons.daemon.DaemonInitException;

public class Main {

	public static void main(String[] args) throws DaemonInitException, Exception {
		Service service = new Service();
		DaemonContext ctx = new DaemonContext() {
			
			@Override
			public DaemonController getController() {
				// TODO Auto-generated method stub
				return null;
			}
			
			@Override
			public String[] getArguments() {
				// TODO Auto-generated method stub
				return null;
			}
		};
		service.init(ctx);
		service.start();
	}

}
