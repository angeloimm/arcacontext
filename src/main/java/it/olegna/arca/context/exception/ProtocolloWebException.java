package it.olegna.arca.context.exception;

public class ProtocolloWebException extends Exception {

	private static final long serialVersionUID = -8445028957099703191L;

	public ProtocolloWebException() {
		super();
	}

	public ProtocolloWebException(String message, Throwable cause) {
		super(message, cause);
	}

	public ProtocolloWebException(String message) {
		super(message);
	}

	public ProtocolloWebException(Throwable cause) {
		super(cause);
	}
}
