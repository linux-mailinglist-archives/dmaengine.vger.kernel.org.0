Return-Path: <dmaengine+bounces-4414-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CE02A2FEBE
	for <lists+dmaengine@lfdr.de>; Tue, 11 Feb 2025 01:02:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDF551888C78
	for <lists+dmaengine@lfdr.de>; Tue, 11 Feb 2025 00:02:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DE2A3EA83;
	Tue, 11 Feb 2025 00:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q1j87QGs"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CA932CA8;
	Tue, 11 Feb 2025 00:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739232119; cv=none; b=orpFdI33HLmsABVyv6jrgt3/YwVn5flWOq3fJWFpL5RRJGnLl+TQ8E6gPsiGGgZ/2G8+ypw4gQPe8rwVUKKTqrykFqCkLSykJKDHnFWu5BCvufLLgaIgcwRrsF7nFE1dsvPJDKJ1mC9vJvLTKJSqdhOIznBK0ZyGyWdvgH9TR4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739232119; c=relaxed/simple;
	bh=rAzkLZM09qQrVfb6++qtL1NVW6ye9kBKxmsecVL8AX0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=phFMG2lITeO1sBiL+tcqCk0YYkqm300xsFdDUTlBNXXmTtVx7kSlclcHARSB33E1tkr315T1J3OVjOWqTkv+tADy74Jl61o83S+/0SbuKzt4Xd07mom6QSY79N0nAhb/jWhrd3q/+sbcVeuEHT0xFVW+lGeczAdrU16k1YssuLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q1j87QGs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C868C4CEDF;
	Tue, 11 Feb 2025 00:01:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739232118;
	bh=rAzkLZM09qQrVfb6++qtL1NVW6ye9kBKxmsecVL8AX0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=q1j87QGsjnUkqkcVlg2v4gnZWuuz2UEGFoQfFx8S5hm6OD3/mp8QI0dCwQT4YmTEr
	 IB2Hu3/xsA738TjmL9hvDacqP3Cn1fn1l38WTUXKf4SHgxcaaqcmtfDjrQUDk9eoqE
	 gB6wCJ5myKFPgBwelHmsgcxfai/gZhPdUPy8zVu8z/cx9kuD9+RM3Bb/ajecRTWHax
	 fVRq4VYORDNdvHY/BD15McfYj6CkfxzLNVClI1u8/Pfa9FJn4JqDpQ7Nyn/Fr2156J
	 CGUj1Kbf4bjxLul7s2ASKdEhbPJl+pwIxxn70nR5a5VyWkDiXJ4SybO3o/a5i5XUEL
	 d5paRyJt5qYuQ==
Date: Mon, 10 Feb 2025 18:01:57 -0600
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
Subject: Re: [PATCH v2 11/12] dt-bindings: nand: Add fsl,elbc-fcm-nand
Message-ID: <20250211000157.GA240011-robh@kernel.org>
References: <20250207-ppcyaml-v2-0-8137b0c42526@posteo.net>
 <20250207-ppcyaml-v2-11-8137b0c42526@posteo.net>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250207-ppcyaml-v2-11-8137b0c42526@posteo.net>

On Fri, Feb 07, 2025 at 10:30:28PM +0100, J. Neuschäfer wrote:
> Formalize the binding already supported by the fsl_elbc_nand.c driver
> and used in several device trees in arch/powerpc/boot/dts/.
> 
> Signed-off-by: J. Neuschäfer <j.ne@posteo.net>
> ---
> 
> V2:
> - split out from fsl,elbc binding patch
> - constrain #address-cells and #size-cells
> - add a general description
> - use unevaluatedProperties=false instead of additionalProperties=false
> - fix property order to comply with dts coding style
> - include raw-nand-chip.yaml instead of nand-chip.yaml

Why? Doesn't look like you use anything from it. I think the correct 
thing to use here is just mtd.yaml to pick up partitions.

> ---
>  .../devicetree/bindings/mtd/fsl,elbc-fcm-nand.yaml | 68 ++++++++++++++++++++++
>  1 file changed, 68 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mtd/fsl,elbc-fcm-nand.yaml b/Documentation/devicetree/bindings/mtd/fsl,elbc-fcm-nand.yaml
> new file mode 100644
> index 0000000000000000000000000000000000000000..1de97bb24fa4a83e2ea5d94ab822dd0e37baa102
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mtd/fsl,elbc-fcm-nand.yaml
> @@ -0,0 +1,68 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mtd/fsl,elbc-fcm-nand.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: NAND flash attached to Freescale eLBC
> +
> +description:
> +  The Freescale Enhanced Local Bus controller (eLBC) contains logic to
> +  interface with NAND flash, called the NAND Flash Control Machine (FCM).
> +  This binding describes flash attached to an eLBC using the FCM.
> +
> +maintainers:
> +  - J. Neuschäfer <j.ne@posteo.net>
> +
> +allOf:
> +  - $ref: raw-nand-chip.yaml#
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - items:
> +          - enum:
> +              - fsl,mpc8313-fcm-nand
> +              - fsl,mpc8315-fcm-nand
> +              - fsl,mpc8377-fcm-nand
> +              - fsl,mpc8378-fcm-nand
> +              - fsl,mpc8379-fcm-nand
> +              - fsl,mpc8536-fcm-nand
> +              - fsl,mpc8569-fcm-nand
> +              - fsl,mpc8572-fcm-nand
> +              - fsl,p1020-fcm-nand
> +              - fsl,p1021-fcm-nand
> +              - fsl,p1025-fcm-nand
> +              - fsl,p2020-fcm-nand
> +          - const: fsl,elbc-fcm-nand
> +      - const: fsl,elbc-fcm-nand
> +
> +  reg:
> +    maxItems: 1
> +
> +  "#address-cells":
> +    const: 1
> +
> +  "#size-cells":
> +    const: 1
> +
> +required:
> +  - compatible
> +  - reg
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    localbus {
> +        #address-cells = <2>;
> +        #size-cells = <1>;
> +
> +        nand@1,0 {
> +            compatible = "fsl,mpc8315-fcm-nand",
> +                         "fsl,elbc-fcm-nand";
> +            reg = <0x1 0x0 0x2000>;
> +            #address-cells = <1>;
> +            #size-cells = <1>;
> +        };
> +    };
> 
> -- 
> 2.48.0.rc1.219.gb6b6757d772
> 

