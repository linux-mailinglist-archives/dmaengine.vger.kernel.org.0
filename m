Return-Path: <dmaengine+bounces-4201-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9479AA1CF36
	for <lists+dmaengine@lfdr.de>; Mon, 27 Jan 2025 00:23:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDFDA1662A3
	for <lists+dmaengine@lfdr.de>; Sun, 26 Jan 2025 23:23:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B198678F58;
	Sun, 26 Jan 2025 23:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lj+Vkk+v"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60FF238389;
	Sun, 26 Jan 2025 23:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737933781; cv=none; b=W+nfHsLPna9uboQ8I6ddb+0lzF+T2hBI+vwLyAIGO/tDiu4KO1uqPLKINW2TKoUF93PhrYXRSdcfE5Jc58oExadNwEGbr7R4P0bgsZ03IN8CXvGrG67txE3F4U3L0z8v/ADAmoNu+HTJiHIWJ61tkvDOcnOzEX3nGxBMHtsTkoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737933781; c=relaxed/simple;
	bh=Da9tXyLwkD2V/78EX2AhOGNwi0AShsbcsReVhEPDEw8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jXnHgUHzqrgOQpHduAKPVC6B+PVLjB3trEv6GiBSzWm2Nbvk+PU4xgRhfgpqHtVmEpDVWgCLyKafZlkvv1aUFQ4S3rx33/nTz+y6cfUgqX9ielBEf+CkoymjCyVnlzmwRBIrZKG77SWRVSmIDKuR+3naMBd89h8aXsa1q5DlUyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lj+Vkk+v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57D0BC4CED3;
	Sun, 26 Jan 2025 23:22:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737933780;
	bh=Da9tXyLwkD2V/78EX2AhOGNwi0AShsbcsReVhEPDEw8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=lj+Vkk+vGxtjTS6EwdKU1jCUNvNvHFlIxXGAUR41Ztm2bT9SCao1tnEn7EC7CLGtd
	 w+jtJmbIIuCJ5FL+fSDbLf5mLVDCrj9H5WBC9CrqjTCE60bbYBpyJb0zb/G31MLLJB
	 AVohD5ONtpThjzmrIAFkrzdu/Jk0Iu+hNd0m3Dijszk8bBrPT/6dNrMy2+lwzTeHYc
	 OTaKo6NqvTWN9JBqnWIi00M602F730+lnrwNgO6i9tNbQGruumcaMfEi5pFhdEgezb
	 BnL8NHlzXJ9ohaIZxzMzDzk23J9GUNqrrKcbvQVI6FBqMLPEYJy5pNxg8NnNrbe9m6
	 oBhAqEEod6YOA==
Message-ID: <a9df1ae6-8779-4dc0-8f03-eda939c0e533@kernel.org>
Date: Mon, 27 Jan 2025 08:22:55 +0900
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/9] dt-bindings: ata: Convert fsl,pq-sata binding to YAML
To: j.ne@posteo.net, devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: Scott Wood <oss@buserror.net>, Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Naveen N Rao <naveen@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Niklas Cassel <cassel@kernel.org>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 "David S. Miller" <davem@davemloft.net>, Lee Jones <lee@kernel.org>,
 Vinod Koul <vkoul@kernel.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Bjorn Helgaas <bhelgaas@google.com>, =?UTF-8?Q?J=2E_Neusch=C3=A4fer?=
 <j.neuschaefer@gmx.net>, Wim Van Sebroeck <wim@linux-watchdog.org>,
 Guenter Roeck <linux@roeck-us.net>, Mark Brown <broonie@kernel.org>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>,
 linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org,
 linux-crypto@vger.kernel.org, dmaengine@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-watchdog@vger.kernel.org,
 linux-spi@vger.kernel.org, linux-mtd@lists.infradead.org
References: <20250126-ppcyaml-v1-0-50649f51c3dd@posteo.net>
 <20250126-ppcyaml-v1-2-50649f51c3dd@posteo.net>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20250126-ppcyaml-v1-2-50649f51c3dd@posteo.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 1/27/25 03:58, J. Neuschäfer via B4 Relay wrote:
> From: "J. Neuschäfer" <j.ne@posteo.net>
> 
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
> +  SATA nodes are defined to describe on-chip Serial ATA controllers.
> +  Each SATA port should have its own node.

Very unclear. The SATA nodes define ports or controllers ? Normally, a single
controller can have multiple ports, so the distinction is important.

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

Are you sure these are different controllers ? Are they not different ports of
the same controller ? Given that the previous text description define this as
"controller index", I suspect these are the port offsets and you SATA nodes
define ports, and not controllers.

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


-- 
Damien Le Moal
Western Digital Research

