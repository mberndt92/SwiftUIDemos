//
//  FallingSnowProject.swift
//  ProSwiftUIProject
//
//  Created by Maximilian Berndt on 01.06.23.
//

import SwiftUI

struct FallingSnowProject: View {
    
    class Particle {
        var x: Double
        var y: Double
        let xSpeed: Double
        let ySpeed: Double
        let deathDate = Date.now.timeIntervalSinceReferenceDate + 2 // 2 seconds from now
        
        init(x: Double, y: Double, xSpeed: Double, ySpeed: Double) {
            self.x = x
            self.y = y
            self.xSpeed = xSpeed
            self.ySpeed = ySpeed
        }
    }
    
    class ParticleSystem {
        var particles = [Particle]()
        var lastUpdate = Date.now.timeIntervalSinceReferenceDate
        
        func update(date: TimeInterval, size: CGSize) {
            // delta is used for frame independent movement
            // basically if 0.5 seconds passed, we want half of the speed added only
            let delta = date - lastUpdate
            lastUpdate = date
            
            // update all particles here
            for (index, particle) in particles.enumerated() {
                if particle.deathDate < date {
                    particles.remove(at: index)
                } else {
                    particle.x += particle.xSpeed * delta
                    particle.y += particle.ySpeed * delta
                }
            }
            
            let newParticle = Particle(
                x: .random(in: -32...size.width),
                y: -32,
                xSpeed: .random(in: -50...50),
                ySpeed: .random(in: 100...500)
            )
            particles.append(newParticle)
        }
    }
    
    @State private var particleSystem = ParticleSystem()
    
    var body: some View {
        LinearGradient(colors: [.red, .indigo], startPoint: .top, endPoint: .bottom).mask {
            TimelineView(.animation) { timeline in
                Canvas { ctx, size in
                    let timelineDate = timeline.date.timeIntervalSinceReferenceDate
                    particleSystem.update(date: timelineDate, size: size)
                    
                    // Make them metaballs
                    ctx.addFilter(.alphaThreshold(min: 0.5, color: .white))
                    ctx.addFilter(.blur(radius: 10))
                    
                    
                    ctx.drawLayer { ctx in
                        for particle in particleSystem.particles {
                            ctx.opacity = particle.deathDate - timelineDate
                            ctx.fill(
                                Circle().path(in:
                                                CGRect(
                                                    x: particle.x,
                                                    y: particle.y,
                                                    width: 32,
                                                    height: 32)
                                             ), with: .color(.white)
                            )
                        }
                    }
                }
            }
        }
        .ignoresSafeArea()
        .background(.black)
    }
}

struct FallingSnowProject_Previews: PreviewProvider {
    static var previews: some View {
        FallingSnowProject()
    }
}
