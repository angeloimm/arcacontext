package it.olegna.arca.context.test;

import static org.junit.Assert.assertNotNull;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ActiveProfiles;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.stack.overflow.TestComponent;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(classes={GizmoConfiguration.class})
@ActiveProfiles("no-dependencies")
public class StackTest
{
	@Autowired
	private GizmoConfiguration.FooGizmo gizmo;
	@Autowired
	private TestComponent tc;
	@Test
	public void test() {
		assertNotNull(gizmo);
		assertNotNull(tc.getGizmo());
	}
}
