package it.olegna.arca.context.exception;

public class ArcaContextDbException extends Exception {

	private static final long serialVersionUID = -8445028957099703191L;

	public ArcaContextDbException() {
		super();
	}

	public ArcaContextDbException(String message, Throwable cause) {
		super(message, cause);
	}

	public ArcaContextDbException(String message) {
		super(message);
	}

	public ArcaContextDbException(Throwable cause) {
		super(cause);
	}
}
