package com.stack.overflow;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Component;

import it.olegna.arca.context.test.Gizmo;

@Component
public class TestComponent {

	@Autowired
	@Qualifier("fooGizmoBean")
	private Gizmo gizmo;

	public Gizmo getGizmo()
	{
		return gizmo;
	}

	public void setGizmo(Gizmo gizmo)
	{
		this.gizmo = gizmo;
	}


}