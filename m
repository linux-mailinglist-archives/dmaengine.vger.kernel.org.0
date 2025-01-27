Return-Path: <dmaengine+bounces-4209-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DE10A1D07F
	for <lists+dmaengine@lfdr.de>; Mon, 27 Jan 2025 05:50:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F3527A26FF
	for <lists+dmaengine@lfdr.de>; Mon, 27 Jan 2025 04:50:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6C9F1DB55C;
	Mon, 27 Jan 2025 04:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PWYqiZrY"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 743DC1FC3;
	Mon, 27 Jan 2025 04:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737953407; cv=none; b=WkGLmhgsz/EdKUyI0NjUG5vU1NX+r4h5UKvWMMHDwJE1DzTwTHiExz/vN6yQW3EWdQpz7ORZtI3HwSoXIW2lAx+lE88c00m/5wPrP+XgdireiZI/eiXryZAMrhQohIFAEyiNa+Dfb80ywWRop4fzM8JJmFe8la2PqwknuA2p2uU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737953407; c=relaxed/simple;
	bh=2rLaEDPfSm/lD1nBxwCCwk3Yv0BG6rIKmqNgHO3hz5A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GZU77vMZ10/H9Y0z7xbFvZEjQpIweDsDcaIVaXeS2ix5yXNZ2mJQjf/Gbh9yih+0ZCMrqAskxO5cL8rI2NLEeI3tpCkLTO1d5Fv3xncti0QXQ0GoPqqLm9GFAaCIDSssxXGmmwqpF7q2QaX9tWVnjK41fKeBW2idZP+rGUpGHmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PWYqiZrY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF808C4CED2;
	Mon, 27 Jan 2025 04:50:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737953405;
	bh=2rLaEDPfSm/lD1nBxwCCwk3Yv0BG6rIKmqNgHO3hz5A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PWYqiZrY+ksbAukgBdboA4rOwSDA7l9d0vK5NMllSgNphdmB4L8Ft8u3pveYKT9mj
	 tWDtm2DwGmqOrTEVyUtSMBVneEU+O8mOz+phBh9ynODjnHUUEuOtnEpZg5oWWNsDx8
	 KD+mru9ihYDAqIbMWA6/6mLuAQMyVafqABUL8Mrpmljgisn40M2gHd2eeIMltsVq0Y
	 IYzCI+YRYSyWQ8ANrG2oM9vcjCYR4VdIx7b+UMAB0tUvIbEqx6iDYFdWrn5+WyOdmk
	 O5CzfmfhSy94avSidgCA1x2o1IDX7bGQlVZZiaI23jXiF+cvyVh/6MdCVgsl2W64t1
	 d+tntyEwJohSQ==
Date: Sun, 26 Jan 2025 22:50:04 -0600
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
Subject: Re: [PATCH 6/9] dt-bindings: pci: Add fsl,mpc83xx-pcie bindings
Message-ID: <20250127045004.GE3106458-robh@kernel.org>
References: <20250126-ppcyaml-v1-0-50649f51c3dd@posteo.net>
 <20250126-ppcyaml-v1-6-50649f51c3dd@posteo.net>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250126-ppcyaml-v1-6-50649f51c3dd@posteo.net>

On Sun, Jan 26, 2025 at 07:59:01PM +0100, J. Neuschäfer wrote:
> Supplement Documentation/devicetree/bindings/pci/fsl,pci.txt with a more
> formal binding in YAML format.
> 
> Signed-off-by: J. Neuschäfer <j.ne@posteo.net>
> ---
>  .../devicetree/bindings/pci/fsl,mpc8xxx-pci.yaml   | 83 ++++++++++++++++++++++
>  1 file changed, 83 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pci/fsl,mpc8xxx-pci.yaml b/Documentation/devicetree/bindings/pci/fsl,mpc8xxx-pci.yaml
> new file mode 100644
> index 0000000000000000000000000000000000000000..12e86a9c20dfe2362d11f085bd9ae47238c4a37f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/fsl,mpc8xxx-pci.yaml
> @@ -0,0 +1,83 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +
> +$id: http://devicetree.org/schemas/pci/fsl,mpc8xxx-pci.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Freescale MPC83xx PCI/PCI-X/PCIe controllers
> +
> +description: |
> +  Binding for the PCI/PCI-X/PCIe host bridges on MPC8xxx SoCs.
> +  See also: Documentation/devicetree/bindings/pci/fsl,pci.txt

Can you move that information here.

> +
> +maintainers:
> +  - J. Neuschäfer <j.neuschaefer@gmx.net>
> +
> +allOf:
> +  - $ref: /schemas/pci/pci-host-bridge.yaml#
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - items:
> +          - enum:
> +              - fsl,mpc8308-pcie
> +              - fsl,mpc8315-pcie
> +              - fsl,mpc8377-pcie
> +              - fsl,mpc8378-pcie
> +          - const: fsl,mpc8314-pcie
> +      - const: fsl,mpc8314-pcie
> +      - items:
> +          - const: fsl,mpc8360-pci
> +          - const: fsl,mpc8349-pci
> +      - const: fsl,mpc8349-pci
> +      - items:
> +          - const: fsl,mpc8540-pcix
> +          - const: fsl,mpc8540-pci
> +      - const: fsl,mpc8540-pci
> +      - items:
> +          - const: fsl,mpc8540-pcix
> +          - const: fsl,mpc8540-pci
> +      - const: fsl,mpc8548-pcie
> +      - const: fsl,mpc8548-pcie
> +      - const: fsl,mpc8641-pcie

Move all the single 'const' to 1 enum entry.

> +
> +  reg:
> +    minItems: 1
> +    items:
> +      - description: internal registers
> +      - description: config space access registers
> +
> +  clock-frequency:
> +    $ref: /schemas/types.yaml#/definitions/uint32

Don't need a type for this.

> +
> +required:
> +  - reg
> +  - compatible
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +    pci1: pcie@e0009000 {
> +        #address-cells = <3>;
> +        #size-cells = <2>;
> +        #interrupt-cells = <1>;
> +        device_type = "pci";
> +        compatible = "fsl,mpc8315-pcie", "fsl,mpc8314-pcie";
> +        reg = <0xe0009000 0x00001000>;
> +        ranges = <0x02000000 0 0xa0000000 0xa0000000 0 0x10000000
> +                  0x01000000 0 0x00000000 0xb1000000 0 0x00800000>;
> +        bus-range = <0 255>;
> +        interrupt-map-mask = <0xf800 0 0 7>;
> +        interrupt-map = <0 0 0 1 &ipic 1 IRQ_TYPE_LEVEL_LOW
> +                         0 0 0 2 &ipic 1 IRQ_TYPE_LEVEL_LOW
> +                         0 0 0 3 &ipic 1 IRQ_TYPE_LEVEL_LOW
> +                         0 0 0 4 &ipic 1 IRQ_TYPE_LEVEL_LOW>;
> +        clock-frequency = <0>;
> +    };
> +
> +...
> 
> -- 
> 2.48.0.rc1.219.gb6b6757d772
> 

