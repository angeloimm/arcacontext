package it.olegna.arca.context.test;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Profile;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.support.AnnotationConfigContextLoader;

@Configuration
@ComponentScan(basePackages= {"com.stack.overflow"})
@ContextConfiguration(loader=AnnotationConfigContextLoader.class)
public class GizmoConfiguration {

  @Bean("fooGizmoBean")
  @Profile("no-dependencies")
  public Gizmo fooGizmoBean() {
    return new FooGizmo();
  }

  @Bean("barGizmoBean")
  @Profile("!no-dependencies")
  public Gizmo barGizmoBean() {
    return new BarGizmo();
  }

  public class FooGizmo implements Gizmo {
    @Override
    public void whirr() {
    }
  }

  public class BarGizmo implements Gizmo {
    @Override
    public void whirr() {
    }
  }
}