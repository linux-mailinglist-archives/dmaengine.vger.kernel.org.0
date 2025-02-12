Return-Path: <dmaengine+bounces-4447-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C1B1A32FF5
	for <lists+dmaengine@lfdr.de>; Wed, 12 Feb 2025 20:43:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 328961645E9
	for <lists+dmaengine@lfdr.de>; Wed, 12 Feb 2025 19:43:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5B1B1FF7AE;
	Wed, 12 Feb 2025 19:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l3nluVDj"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 791391FF615;
	Wed, 12 Feb 2025 19:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739389429; cv=none; b=pPZhC/o4M9de+Ds0n2KSzTRbJULRzKzE1WzeXYwoCV8e/EYbrcKuNh8nAAQHF19Jzud3fjQad7NtCzNlz8D/8kvcQQKR4FY6ucgCUO+toEzu+qTunBzUXOI4KfPBB+NN/InMgFrwdieA8ehP1UW1aqeKTlKDK8MzQ+lwej1SjL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739389429; c=relaxed/simple;
	bh=J53gut3FCEvv7QNmL9a0iiaxDFCqQSjC2O6Ihu/AJ84=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kA6lTbUVgydKQL1hxX7S6vgR5B7N0A6OFejvu9UNI4G9ZdbUNIqr2UcuMBuKNTvpebdLeXUlEhuHEsJbh4UalkH0cZrAtbkuf06yiPQp8hjXTiTHwdJh25f57bVXOtWy/b87xoJXwTqAUm9C1yR5WO28LNueH1FPOrjBLCpOqP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l3nluVDj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6EEFC4CEDF;
	Wed, 12 Feb 2025 19:43:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739389428;
	bh=J53gut3FCEvv7QNmL9a0iiaxDFCqQSjC2O6Ihu/AJ84=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=l3nluVDjmkhujiS09PDYmKWR8ZpL1NvZ673ie95nbqovNihUcry7wp4RhxDaIcW4C
	 WzALgu8RqrEf8AEKXJa1NQN36127tWGpqtfMt+ceF8qkKxFUatwJV8mWOCXDA7c8U6
	 5c6mvpzQn7EtvSK26FGhsTxvo9nA5pW5qx8gSDuBJ7zl/wl5WF+1A0qzlo/GtstEyq
	 UpvxdrPQwjDAE3IeNXfcspWaobaAE2jMqkTwrZPDdD8R5k2k0xPPuMTtHZRy6guNwr
	 J6A5CGOXSwgZePq4BouABSV8KVXF9QiPXKh5Adk1Oyuh6/Hd8f5WNo1Hpr1RY3Eam1
	 dqgSlb5voTSKg==
Date: Wed, 12 Feb 2025 13:43:47 -0600
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
Subject: Re: [PATCH v2 08/12] dt-bindings: spi: Convert Freescale SPI
 bindings to YAML
Message-ID: <20250212194347.GA119448-robh@kernel.org>
References: <20250207-ppcyaml-v2-0-8137b0c42526@posteo.net>
 <20250207-ppcyaml-v2-8-8137b0c42526@posteo.net>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250207-ppcyaml-v2-8-8137b0c42526@posteo.net>

On Fri, Feb 07, 2025 at 10:30:25PM +0100, J. Neuschäfer wrote:
> fsl-spi.txt contains the bindings for the fsl,spi and fsl,espi
> contollers. Convert them to YAML.
> 
> Signed-off-by: J. Neuschäfer <j.ne@posteo.net>
> ---
> 
> V2:
> - add missing end-of-document ("...") markers
> - add missing constraints to interrupts, fsl,espi-num-chipselects,
>   fsl,csbef and fsl,csaft properties
> - remove unnecessary type from clock-frequency property
> - fix property order to comply with dts coding style
> ---
>  .../devicetree/bindings/spi/fsl,espi.yaml          | 64 +++++++++++++++++++
>  Documentation/devicetree/bindings/spi/fsl,spi.yaml | 73 ++++++++++++++++++++++
>  Documentation/devicetree/bindings/spi/fsl-spi.txt  | 62 ------------------
>  3 files changed, 137 insertions(+), 62 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/spi/fsl,espi.yaml b/Documentation/devicetree/bindings/spi/fsl,espi.yaml
> new file mode 100644
> index 0000000000000000000000000000000000000000..c504b7957dde39086ef7d7a7550d6169cf5ec407
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/spi/fsl,espi.yaml
> @@ -0,0 +1,64 @@
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
> +  interrupts:
> +    maxItems: 1
> +
> +  fsl,espi-num-chipselects:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [ 1, 4 ]
> +    description: The number of the chipselect signals.
> +
> +  fsl,csbef:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    minimum: 0
> +    maximum: 15
> +    description: Chip select assertion time in bits before frame starts
> +
> +  fsl,csaft:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    minimum: 0
> +    maximum: 15
> +    description: Chip select negation time in bits after frame ends
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
> +        compatible = "fsl,mpc8536-espi";
> +        reg = <0x110000 0x1000>;
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +        interrupts = <53 0x2>;
> +        interrupt-parent = <&mpic>;

Drop interrupt-parent. Otherwise,

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

> +        fsl,espi-num-chipselects = <4>;
> +        fsl,csbef = <1>;
> +        fsl,csaft = <1>;
> +    };
> +
> +...

