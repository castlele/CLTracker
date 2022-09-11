import CLArgumentsParser

public final class CLRegister: BaseCLRegister<CLCommand> {
    public func configure(with commands: [CLCommand]) {
        commands.forEach { command in
            register(command: command)
            
            command.availableOptions.values.forEach { option in
                register(option: option)
            }
        }
    }
}
