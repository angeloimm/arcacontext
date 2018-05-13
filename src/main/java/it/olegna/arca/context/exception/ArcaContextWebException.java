package it.olegna.arca.context.exception;

public class ArcaContextWebException extends Exception {

	private static final long serialVersionUID = -8445028957099703191L;

	public ArcaContextWebException() {
		super();
	}

	public ArcaContextWebException(String message, Throwable cause) {
		super(message, cause);
	}

	public ArcaContextWebException(String message) {
		super(message);
	}

	public ArcaContextWebException(Throwable cause) {
		super(cause);
	}
}
