Return-Path: <dmaengine+bounces-4446-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CFB7A32FE2
	for <lists+dmaengine@lfdr.de>; Wed, 12 Feb 2025 20:38:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A6AB167F55
	for <lists+dmaengine@lfdr.de>; Wed, 12 Feb 2025 19:38:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 805CA1FF612;
	Wed, 12 Feb 2025 19:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mQBWoZm9"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BC721DC07D;
	Wed, 12 Feb 2025 19:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739389098; cv=none; b=rmJXBazaqWiYx4T5EEn2sxpmSrZg73Js9fTC9dptS41gwQgezXwGAM/t+z2v7SP9vMe2AFgMzbABPzqs1vXiNz3pMcKbsE1gqEHTeuK+4BaLXleX1BdFL9GbIlKaArvUyC7E4tQb9R6Gz+4NYqqT0/z+n0SspH0q8IY4+Xxw5xU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739389098; c=relaxed/simple;
	bh=pq9uKQvjFYwDm1Q4B6BmedrGAyc5w91dQwDdbRZBMW8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a3wvq3TdJxI6pIQTqXR8U20vG5ICcNADUXT5OT5jFkDun7vOjr9xT//SI/5Kj3g0DB9IvshgGNGOfcbdF42COKeXM4fe1rPeUKdQAO94aMvlCIUyU798V70m86XUhfm05IvlxtTZ9/lA1NxCielloy1941pSEhTQsXMdk0HEChY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mQBWoZm9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 642E5C4CEDF;
	Wed, 12 Feb 2025 19:38:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739389096;
	bh=pq9uKQvjFYwDm1Q4B6BmedrGAyc5w91dQwDdbRZBMW8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mQBWoZm9pBkAJzBWRz85ZCMTj9IvaY3BA0rxBDDYNpPHMJZ17i09UNxwChFyw0hVZ
	 mbBIuzakROKILvDV5vGDjyN1gMB2TYRWqQYBR/NF21saMN5npe5HC205R2hRIW+xEJ
	 WNMFsM4kAklYkc3yn8/eKUkVaJUPLrYOT0ROBS+XvncYTfQTtAvKtOISkDXenE24NQ
	 6wa3y+6po0NoVWWK2jUywFmF+27+PJBC6jKh0tBUWtlCctbBKKTKQ7EMqk3FyYliyM
	 C7NHhBicFH74iUz86RYpL6uWHOkMzY1SyHEKxjDgogi/QjGlEPpfqSM/yW6mc8gl9J
	 kGVNNVKgf+GQQ==
Date: Wed, 12 Feb 2025 13:38:15 -0600
From: Rob Herring <robh@kernel.org>
To: =?iso-8859-1?Q?J=2E_Neusch=E4fer?= <j.ne@posteo.net>
Cc: devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	Krzysztof Kozlowski <krzk@kernel.org>, imx@lists.linux.dev,
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
Subject: Re: [PATCH v2 05/12] dt-bindings: dma: Convert fsl,elo*-dma to YAML
Message-ID: <20250212193815.GA113049-robh@kernel.org>
References: <20250207-ppcyaml-v2-0-8137b0c42526@posteo.net>
 <20250207-ppcyaml-v2-5-8137b0c42526@posteo.net>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250207-ppcyaml-v2-5-8137b0c42526@posteo.net>

On Fri, Feb 07, 2025 at 10:30:22PM +0100, J. Neuschäfer wrote:
> The devicetree bindings for Freescale DMA engines have so far existed as
> a text file. This patch converts them to YAML, and specifies all the
> compatible strings currently in use in arch/powerpc/boot/dts.
> 
> Signed-off-by: J. Neuschäfer <j.ne@posteo.net>
> ---
> 
> V2:
> - remove unnecessary multiline markers
> - fix additionalProperties to always be false
> - add description/maxItems to interrupts
> - add missing #address-cells/#size-cells properties
> - convert "Note on DMA channel compatible properties" to YAML by listing
>   fsl,ssi-dma-channel as a valid compatible value
> - fix property ordering in examples: compatible and reg come first
> - add missing newlines in examples
> - trim subject line (remove "bindings")
> ---
>  .../devicetree/bindings/dma/fsl,elo-dma.yaml       | 140 ++++++++++++++
>  .../devicetree/bindings/dma/fsl,elo3-dma.yaml      | 123 +++++++++++++
>  .../devicetree/bindings/dma/fsl,eloplus-dma.yaml   | 134 ++++++++++++++
>  .../devicetree/bindings/powerpc/fsl/dma.txt        | 204 ---------------------
>  4 files changed, 397 insertions(+), 204 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/dma/fsl,elo-dma.yaml b/Documentation/devicetree/bindings/dma/fsl,elo-dma.yaml
> new file mode 100644
> index 0000000000000000000000000000000000000000..3d8be9973fb98891a73cb701c1f983a63f444837
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/dma/fsl,elo-dma.yaml
> @@ -0,0 +1,140 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/dma/fsl,elo-dma.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Freescale Elo DMA Controller
> +
> +maintainers:
> +  - J. Neuschäfer <j.ne@posteo.net>
> +
> +description:
> +  This is a little-endian 4-channel DMA controller, used in Freescale mpc83xx
> +  series chips such as mpc8315, mpc8349, mpc8379 etc.
> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - fsl,mpc8313-dma
> +          - fsl,mpc8315-dma
> +          - fsl,mpc8323-dma
> +          - fsl,mpc8347-dma
> +          - fsl,mpc8349-dma
> +          - fsl,mpc8360-dma
> +          - fsl,mpc8377-dma
> +          - fsl,mpc8378-dma
> +          - fsl,mpc8379-dma
> +      - const: fsl,elo-dma
> +
> +  reg:
> +    maxItems: 1
> +    description:
> +      DMA General Status Register, i.e. DGSR which contains status for
> +      all the 4 DMA channels.
> +
> +  cell-index:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: Controller index. 0 for controller @ 0x8100.
> +
> +  ranges: true
> +
> +  "#address-cells":
> +    const: 1
> +
> +  "#size-cells":
> +    const: 1
> +
> +  interrupts:
> +    maxItems: 1
> +    description: Controller interrupt.
> +
> +required:
> +  - compatible
> +  - reg
> +
> +patternProperties:
> +  "^dma-channel@.*$":

You need to define the unit-address format.

> +    type: object
> +    additionalProperties: false
> +
> +    properties:
> +      compatible:
> +        oneOf:
> +          # native DMA channel
> +          - items:
> +              - enum:
> +                  - fsl,mpc8315-dma-channel
> +                  - fsl,mpc8323-dma-channel
> +                  - fsl,mpc8347-dma-channel
> +                  - fsl,mpc8349-dma-channel
> +                  - fsl,mpc8360-dma-channel
> +                  - fsl,mpc8377-dma-channel
> +                  - fsl,mpc8378-dma-channel
> +                  - fsl,mpc8379-dma-channel
> +              - const: fsl,elo-dma-channel
> +
> +          # audio DMA channel, see fsl,ssi.yaml
> +          - const: fsl,ssi-dma-channel
> +
> +      reg:
> +        maxItems: 1
> +
> +      cell-index:
> +        description: DMA channel index starts at 0.
> +
> +      interrupts:
> +        maxItems: 1
> +        description:
> +          Per-channel interrupt. Only necessary if no controller interrupt has
> +          been provided.
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    dma@82a8 {

dma-controller@...

> +        compatible = "fsl,mpc8349-dma", "fsl,elo-dma";
> +        reg = <0x82a8 4>;
> +        #address-cells = <1>;
> +        #size-cells = <1>;
> +        ranges = <0 0x8100 0x1a4>;
> +        interrupt-parent = <&ipic>;

Drop interrupt-parent everywhere.

> +        interrupts = <71 8>;
> +        cell-index = <0>;
> +
> +        dma-channel@0 {
> +            compatible = "fsl,mpc8349-dma-channel", "fsl,elo-dma-channel";
> +            reg = <0 0x80>;
> +            cell-index = <0>;
> +            interrupt-parent = <&ipic>;
> +            interrupts = <71 8>;
> +        };
> +
> +        dma-channel@80 {
> +            compatible = "fsl,mpc8349-dma-channel", "fsl,elo-dma-channel";
> +            reg = <0x80 0x80>;
> +            cell-index = <1>;
> +            interrupt-parent = <&ipic>;
> +            interrupts = <71 8>;
> +        };
> +
> +        dma-channel@100 {
> +            compatible = "fsl,mpc8349-dma-channel", "fsl,elo-dma-channel";
> +            reg = <0x100 0x80>;
> +            cell-index = <2>;
> +            interrupt-parent = <&ipic>;
> +            interrupts = <71 8>;
> +        };
> +
> +        dma-channel@180 {
> +            compatible = "fsl,mpc8349-dma-channel", "fsl,elo-dma-channel";
> +            reg = <0x180 0x80>;
> +            cell-index = <3>;
> +            interrupt-parent = <&ipic>;
> +            interrupts = <71 8>;
> +        };
> +    };
> +
> +...

Similar comments on the others.

Rob

