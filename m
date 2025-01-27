Return-Path: <dmaengine+bounces-4205-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9609BA1D040
	for <lists+dmaengine@lfdr.de>; Mon, 27 Jan 2025 05:38:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E010F3A67B3
	for <lists+dmaengine@lfdr.de>; Mon, 27 Jan 2025 04:37:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7317815852E;
	Mon, 27 Jan 2025 04:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uJ9lfx76"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11B6E5464E;
	Mon, 27 Jan 2025 04:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737952675; cv=none; b=VKlB6ItLsIamWHZJ7VWQX+OUjrabBSRZww0oh344/UMu+jIXMRFqzGmSZortIMro3HljrB8TmG2z4ZZ31yrtcQ9XL21U/hG4AlmOTWYHBd2g5+68QzjJHOLY6FJo1F1lneMZxlI6Gpjprp1ELcFTXXjbWn2lBXdRIgnhSNDDGs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737952675; c=relaxed/simple;
	bh=F9bBtsJ1KzgqRgAbiENeTT+ePJ6pc5Uo5r/32gnqo28=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mvuEJ/UrH5Fb9phMljNjM/n81UVrMOWPPtCfuTso06OiLMwYhdphOBMxlfU7Vo0s9M4qFByaXzR0syj8qOBGG5RdYCn78BeLUvmFay8x4c8lKNqnaO69eda04Y7lwRRUToJaEOp4t1ncD1CgMC5RBsg0AMNXrUwWjOjF3YO+4Lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uJ9lfx76; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E5ECC4CED2;
	Mon, 27 Jan 2025 04:37:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737952674;
	bh=F9bBtsJ1KzgqRgAbiENeTT+ePJ6pc5Uo5r/32gnqo28=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uJ9lfx76rD0U07xq8rbih+/wr60rWK8TxZPR5e+pLbFiBv03167ZPvDRf90EzUhyn
	 rNSLC5Hve6b+hN58lF98zDv5XLEfmRNDGBiYlfrwKLULuhCAqDMy3y4CwwbLTfVGz8
	 450Vqhn2L2E+dVj0xpa9Z0LrvRxrEaWO5eCaQ03lbRb9ug1YOsdxJZsG6y/KhNyTlX
	 msGBmtnecHgGa8SKyGigtvf8R/4DueQRCtuOa7jsKX7X9bAn81zX36GA+MCQcZnGyY
	 t0NbE55uvlNOCzRxbyp21R1kfT0TQsKY9kNnzeC9xpNZv4NgXScgNh6KMAbWiu5NBE
	 xpiBxfHM1Auvg==
Date: Sun, 26 Jan 2025 22:37:53 -0600
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
Subject: Re: [PATCH 2/9] dt-bindings: ata: Convert fsl,pq-sata binding to YAML
Message-ID: <20250127043753.GA3106458-robh@kernel.org>
References: <20250126-ppcyaml-v1-0-50649f51c3dd@posteo.net>
 <20250126-ppcyaml-v1-2-50649f51c3dd@posteo.net>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250126-ppcyaml-v1-2-50649f51c3dd@posteo.net>

On Sun, Jan 26, 2025 at 07:58:57PM +0100, J. Neuschäfer wrote:
> Convert the Freescale PowerQUICC SATA controller binding from text form
> to YAML. The list of compatible strings reflects current usage.
> 
> Signed-off-by: J. Neuschäfer <j.ne@posteo.net>
> ---
>  .../devicetree/bindings/ata/fsl,pq-sata.yaml       | 59 ++++++++++++++++++++++
>  Documentation/devicetree/bindings/ata/fsl-sata.txt | 28 ----------
>  2 files changed, 59 insertions(+), 28 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/ata/fsl,pq-sata.yaml b/Documentation/devicetree/bindings/ata/fsl,pq-sata.yaml
> new file mode 100644
> index 0000000000000000000000000000000000000000..6af31ffbcad5e9cc83118a0bd8eaf45351a2823f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/ata/fsl,pq-sata.yaml
> @@ -0,0 +1,59 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/ata/fsl,pq-sata.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Freescale 8xxx/3.0 Gb/s SATA nodes
> +
> +maintainers:
> +  - J. Neuschäfer <j.ne@posteo.net>
> +
> +description: |

Don't need '|'

Otherwise,

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

> +  SATA nodes are defined to describe on-chip Serial ATA controllers.
> +  Each SATA port should have its own node.
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - items:
> +          - enum:
> +              - fsl,mpc8377-sata
> +              - fsl,mpc8536-sata
> +              - fsl,mpc8315-sata
> +              - fsl,mpc8379-sata
> +          - const: fsl,pq-sata
> +      - const: fsl,pq-sata-v2
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  cell-index:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [1, 2, 3, 4]
> +    description: |
> +      1 for controller @ 0x18000
> +      2 for controller @ 0x19000
> +      3 for controller @ 0x1a000
> +      4 for controller @ 0x1b000
> +
> +required:
> +  - compatible
> +  - interrupts
> +  - cell-index
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    sata@18000 {
> +        compatible = "fsl,mpc8379-sata", "fsl,pq-sata";
> +        reg = <0x18000 0x1000>;
> +        cell-index = <1>;
> +        interrupts = <44 IRQ_TYPE_LEVEL_LOW>;
> +        interrupt-parent = <&ipic>;
> +    };
> diff --git a/Documentation/devicetree/bindings/ata/fsl-sata.txt b/Documentation/devicetree/bindings/ata/fsl-sata.txt
> deleted file mode 100644
> index fd63bb3becc9363c520a8fd06629fdc52c4d4299..0000000000000000000000000000000000000000
> --- a/Documentation/devicetree/bindings/ata/fsl-sata.txt
> +++ /dev/null
> @@ -1,28 +0,0 @@
> -* Freescale 8xxx/3.0 Gb/s SATA nodes
> -
> -SATA nodes are defined to describe on-chip Serial ATA controllers.
> -Each SATA port should have its own node.
> -
> -Required properties:
> -- compatible        : compatible list, contains 2 entries, first is
> -		 "fsl,CHIP-sata", where CHIP is the processor
> -		 (mpc8315, mpc8379, etc.) and the second is
> -		 "fsl,pq-sata"
> -- interrupts        : <interrupt mapping for SATA IRQ>
> -- cell-index        : controller index.
> -                          1 for controller @ 0x18000
> -                          2 for controller @ 0x19000
> -                          3 for controller @ 0x1a000
> -                          4 for controller @ 0x1b000
> -
> -Optional properties:
> -- reg               : <registers mapping>
> -
> -Example:
> -	sata@18000 {
> -		compatible = "fsl,mpc8379-sata", "fsl,pq-sata";
> -		reg = <0x18000 0x1000>;
> -		cell-index = <1>;
> -		interrupts = <2c 8>;
> -		interrupt-parent = < &ipic >;
> -	};
> 
> -- 
> 2.48.0.rc1.219.gb6b6757d772
> 

