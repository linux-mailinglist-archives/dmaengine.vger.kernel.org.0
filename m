Return-Path: <dmaengine+bounces-4211-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DEDB1A1D095
	for <lists+dmaengine@lfdr.de>; Mon, 27 Jan 2025 06:09:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4554B3A630C
	for <lists+dmaengine@lfdr.de>; Mon, 27 Jan 2025 05:09:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB0E1154C1D;
	Mon, 27 Jan 2025 05:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dCXssLii"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91D02282EE;
	Mon, 27 Jan 2025 05:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737954543; cv=none; b=dg0meGMIPcPobJdikZjSfxBC+lsZnqt38pDga2AkWnKSLed8XmvkYDpa2UUomAFrE1SzEM7SYwguCUZcC0jpXLja5NlCX+OKEO2/iW964zj6rJClbdJhaA9cULXf5G5jRm20VqA0rqN3EGnwiZ0B0n1R4b7oJKR8rHUx3/2/E1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737954543; c=relaxed/simple;
	bh=SRnaJ7NOhy1yqtMSuRpVYvCRnbZCyG9ICmKcrEhZu1c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X8H8YSQ9Cf4EauD0WoVJvNy0eW6ZMCUZFi5/CXrDHQ+4oaG4sHSxL2uP/nCw+37WSmdjKiC3OpPPdYGSsdnLuZLqyeXL1pXhiUlPIJYq82BLhcX04UldmRmOycSV1Yp+lr/Gz8rMdSVo/GnJmxXzsRidEZAT+mvH7kQbVvJMGEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dCXssLii; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1EBCC4CED2;
	Mon, 27 Jan 2025 05:09:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737954543;
	bh=SRnaJ7NOhy1yqtMSuRpVYvCRnbZCyG9ICmKcrEhZu1c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dCXssLii/zSRuNLuQUKKGyPENsQBo8Sn5CnYY3O3FxYVAjvruFGyZ57EqKUguv/ra
	 S1h9azhs45cKCSaEPcpsFRa1xKUdQaiOE1O3mn5BZdEeVFQfTlDF7bD3TDraPrBc+3
	 nPr1oEW2dfuaWfsgk5bejmSntOo7SnDsTmo+1COoCYTPp06T7kKbcFbJdDA8zzvyNe
	 x/H0vNeh34Ov9EMHHnfnz+3OUzplGfUJFvMSQcKI5nvKJbwxbMBt6ha/ffzx8jCdb9
	 hCqZ+eanBhx2pBGe+B8aQ+DqKIv74Gk+cWfnDnM6BJFAzTM3tPgAH3xzHh4Ww7eGxN
	 yKnd77AdR7MFA==
Date: Sun, 26 Jan 2025 23:09:01 -0600
From: Rob Herring <robh@kernel.org>
To: =?iso-8859-1?Q?J=2E_Neusch=E4fer?= <j.ne@posteo.net>
Cc: devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	Scott Wood <oss@buserror.net>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Naveen N Rao <naveen@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>, Lee Jones <lee@kernel.org>,
	Vinod Koul <vkoul@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	=?iso-8859-1?Q?J=2E_Neusch=E4fer?= <j.neuschaefer@gmx.net>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>, Mark Brown <broonie@kernel.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>, linux-kernel@vger.kernel.org,
	linux-ide@vger.kernel.org, linux-crypto@vger.kernel.org,
	dmaengine@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-watchdog@vger.kernel.org, linux-spi@vger.kernel.org,
	linux-mtd@lists.infradead.org
Subject: Re: [PATCH 8/9] dt-bindings: spi: Convert Freescale SPI bindings to
 YAML
Message-ID: <20250127050901.GB3127337-robh@kernel.org>
References: <20250126-ppcyaml-v1-0-50649f51c3dd@posteo.net>
 <20250126-ppcyaml-v1-8-50649f51c3dd@posteo.net>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250126-ppcyaml-v1-8-50649f51c3dd@posteo.net>

On Sun, Jan 26, 2025 at 07:59:03PM +0100, J. Neuschäfer wrote:
> fsl-spi.txt contains the bindings for the fsl,spi and fsl,espi
> contollers. Convert them to YAML.
> 
> Signed-off-by: J. Neuschäfer <j.ne@posteo.net>
> ---
>  .../devicetree/bindings/spi/fsl,espi.yaml          | 56 +++++++++++++++++
>  Documentation/devicetree/bindings/spi/fsl,spi.yaml | 71 ++++++++++++++++++++++
>  Documentation/devicetree/bindings/spi/fsl-spi.txt  | 62 -------------------
>  3 files changed, 127 insertions(+), 62 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/spi/fsl,espi.yaml b/Documentation/devicetree/bindings/spi/fsl,espi.yaml
> new file mode 100644
> index 0000000000000000000000000000000000000000..350275760210c5763af0c7b1e1522ccbfb97eec7
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/spi/fsl,espi.yaml
> @@ -0,0 +1,56 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/spi/fsl,espi.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Freescale eSPI (Enhanced Serial Peripheral Interface) controller
> +
> +maintainers:
> +  - J. Neuschäfer <j.ne@posteo.net>
> +
> +properties:
> +  compatible:
> +    const: fsl,mpc8536-espi
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts: true

How many?

> +
> +  fsl,espi-num-chipselects:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: The number of the chipselect signals.

Constraints?

> +
> +  fsl,csbef:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: Chip select assertion time in bits before frame starts

Constraints?

> +
> +  fsl,csaft:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: Chip select negation time in bits after frame ends

Constraints?

> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - fsl,espi-num-chipselects
> +
> +allOf:
> +  - $ref: spi-controller.yaml#
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    spi@110000 {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +        compatible = "fsl,mpc8536-espi";
> +        reg = <0x110000 0x1000>;
> +        interrupts = <53 0x2>;
> +        interrupt-parent = <&mpic>;
> +        fsl,espi-num-chipselects = <4>;
> +        fsl,csbef = <1>;
> +        fsl,csaft = <1>;
> +    };
> diff --git a/Documentation/devicetree/bindings/spi/fsl,spi.yaml b/Documentation/devicetree/bindings/spi/fsl,spi.yaml
> new file mode 100644
> index 0000000000000000000000000000000000000000..8efa971b5954a93665cb624345774f2966bb5648
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/spi/fsl,spi.yaml
> @@ -0,0 +1,71 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/spi/fsl,spi.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Freescale SPI (Serial Peripheral Interface) controller
> +
> +maintainers:
> +  - J. Neuschäfer <j.ne@posteo.net>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - fsl,spi
> +      - aeroflexgaisler,spictrl
> +
> +  reg:
> +    maxItems: 1
> +
> +  cell-index:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: |
> +      QE SPI subblock index.
> +      0: QE subblock SPI1
> +      1: QE subblock SPI2
> +
> +  mode:
> +    description: SPI operation mode
> +    enum:
> +      - cpu
> +      - cpu-qe
> +
> +  interrupts: true
> +
> +  clock-frequency:
> +    $ref: /schemas/types.yaml#/definitions/uint32

Don't need a type.

> +    description: input clock frequency to non FSL_SOC cores
> +
> +  cs-gpios: true
> +
> +  fsl,spisel_boot:
> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description:
> +      For the MPC8306 and MPC8309, specifies that the SPISEL_BOOT signal is used
> +      as chip select for a slave device. Use reg = <number of gpios> in the
> +      corresponding child node, i.e. 0 if the cs-gpios property is not present.
> +
> +required:
> +  - compatible
> +  - reg
> +  - mode
> +  - interrupts
> +
> +allOf:
> +  - $ref: spi-controller.yaml#
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    spi@4c0 {
> +        cell-index = <0>;
> +        compatible = "fsl,spi";
> +        reg = <0x4c0 0x40>;
> +        interrupts = <82 0>;
> +        interrupt-parent = <&intc>;
> +        mode = "cpu";
> +        cs-gpios = <&gpio 18 1          // device reg=<0>
> +                    &gpio 19 1>;        // device reg=<1>
> +    };

