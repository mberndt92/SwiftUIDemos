//
//  GlowingParticlesProject.swift
//  ProSwiftUIProject
//
//  Created by Maximilian Berndt on 31.05.23.
//

import SwiftUI

struct Particle {
    let position: CGPoint
    let deathDate = Date.now.timeIntervalSinceReferenceDate + 1
}

class ParticleSystem {
    var particles = [Particle]()
    var position = CGPoint.zero
    
    func update(date: TimeInterval) {
        particles = particles.filter { $0.deathDate > date }
        particles.append(Particle(position: position))
    }
}

struct GlowingParticlesProject: View {
    
    @State private var particleSystem = ParticleSystem()
    
    let circleDimensions = 32.0
    
    var body: some View {
        TimelineView(.animation) { timeline in
            Canvas { ctx, size in
                let timelineDate = timeline.date.timeIntervalSinceReferenceDate
                particleSystem.update(date: timelineDate)
                
                ctx.blendMode = .plusLighter
                ctx.addFilter(.blur(radius: 10))
                
                for particle in particleSystem.particles {
                    ctx.opacity = particle.deathDate - timelineDate
                    
                    ctx.fill(Circle().path(in: CGRect(x: particle.position.x - (circleDimensions / 2), y: particle.position.y - (circleDimensions / 2), width: circleDimensions, height: circleDimensions)), with: .color(.cyan))
                }
            }
        }
        .gesture (
        DragGesture(minimumDistance: 0)
            .onChanged { drag in
                particleSystem.position = drag.location
            }
        )
        .ignoresSafeArea()
        .background(.black)
    }
}

struct GlowingParticlesProject_Previews: PreviewProvider {
    static var previews: some View {
        GlowingParticlesProject()
    }
}
