Return-Path: <dmaengine+bounces-4351-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FF94A2D1B2
	for <lists+dmaengine@lfdr.de>; Sat,  8 Feb 2025 00:45:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 512EA16C331
	for <lists+dmaengine@lfdr.de>; Fri,  7 Feb 2025 23:45:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C1E01DED73;
	Fri,  7 Feb 2025 23:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G8ojqiQ5"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28F921DE890;
	Fri,  7 Feb 2025 23:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738971902; cv=none; b=qfUkFS6UFjbecIOB3jiNpF/UGr34tmFhTznypx+QYUCEqlwMpC/T5ukP3YpnNufOBlpPI5e3W5iODprO2+tUhbpbX4mF+ZTb27KWO5MdqChE4R790ZNFBAAzMTLfc/hNazLKobbc95umMwZA5z8gdnjmrbgjKl8SnbvUSn13o8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738971902; c=relaxed/simple;
	bh=tBmrobeWDK6+aWiDeO0VVX8TfLiyt8/pAlurKL5A7RE=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=OSc+GhtG8kFnTWWO1uHtcKpOIy24Xlz8+IkroBRrPvjt8kdxDA3htfPFGBysh7RDW559BBc02UF+gyLx0h40bP5B6hnibJXz8MnPDXW9rEjIpCqqpxYQbNzFtyo041FP21TyBDH6yPmdFxusYmQt0f4mYnPhmTVFyT6ubrR6F/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G8ojqiQ5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1BB2C4CEE7;
	Fri,  7 Feb 2025 23:45:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738971902;
	bh=tBmrobeWDK6+aWiDeO0VVX8TfLiyt8/pAlurKL5A7RE=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=G8ojqiQ5opUcLh9s5PIYTf2xPkT83yWsGUUHMXZl5lHvU6Mn89nnfv1wXOW49TcSk
	 35SMUuUZOOgoJLT1UHJm98Nw4GgaIdcRaplBWxiW/VtIYdY+P/3lZT6Jz1vLQF/gwj
	 svxuttRP4HEgFQyLjnmsLgdlQ5bdZOjF91Twr0GobeyOz0U6GD0yldmMLdu7tdpkor
	 CpqoqihaNPN8X+975ECarsF0RKSWGwgPsmlC82hEz5wGp7SdFyUWd36Ps+rMzrTvTC
	 qmr/9q3CQmDhFTduB9v0s+gIIMBo+p73n2Liv87lB/04iL03xko1aXY72hB7noSMrT
	 AodCA/oLktTDA==
Date: Fri, 07 Feb 2025 17:45:00 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Nicholas Piggin <npiggin@gmail.com>, Naveen N Rao <naveen@kernel.org>, 
 Vinod Koul <vkoul@kernel.org>, linux-kernel@vger.kernel.org, 
 =?utf-8?q?J=2E_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Guenter Roeck <linux@roeck-us.net>, 
 Michael Ellerman <mpe@ellerman.id.au>, linux-ide@vger.kernel.org, 
 Krzysztof Kozlowski <krzk@kernel.org>, linux-watchdog@vger.kernel.org, 
 Christophe Leroy <christophe.leroy@csgroup.eu>, 
 Richard Weinberger <richard@nod.at>, Lee Jones <lee@kernel.org>, 
 Madhavan Srinivasan <maddy@linux.ibm.com>, linux-pci@vger.kernel.org, 
 Mark Brown <broonie@kernel.org>, imx@lists.linux.dev, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, linux-spi@vger.kernel.org, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 Herbert Xu <herbert@gondor.apana.org.au>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Scott Wood <oss@buserror.net>, devicetree@vger.kernel.org, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Damien Le Moal <dlemoal@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, linux-crypto@vger.kernel.org, 
 dmaengine@vger.kernel.org, linux-mtd@lists.infradead.org, 
 linuxppc-dev@lists.ozlabs.org, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Wim Van Sebroeck <wim@linux-watchdog.org>, 
 Niklas Cassel <cassel@kernel.org>
To: =?utf-8?q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>
In-Reply-To: <20250207-ppcyaml-v2-11-8137b0c42526@posteo.net>
References: <20250207-ppcyaml-v2-0-8137b0c42526@posteo.net>
 <20250207-ppcyaml-v2-11-8137b0c42526@posteo.net>
Message-Id: <173897189774.2630698.330205726613217230.robh@kernel.org>
Subject: Re: [PATCH v2 11/12] dt-bindings: nand: Add fsl,elbc-fcm-nand


On Fri, 07 Feb 2025 22:30:28 +0100, J. Neuschäfer wrote:
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
> ---
>  .../devicetree/bindings/mtd/fsl,elbc-fcm-nand.yaml | 68 ++++++++++++++++++++++
>  1 file changed, 68 insertions(+)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mtd/fsl,elbc-fcm-nand.example.dtb: nand@1,0: $nodename:0: 'nand@1,0' does not match '^nand@[a-f0-9]$'
	from schema $id: http://devicetree.org/schemas/mtd/fsl,elbc-fcm-nand.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/memory-controllers/fsl,elbc.example.dtb: nand@1,0: $nodename:0: 'nand@1,0' does not match '^nand@[a-f0-9]$'
	from schema $id: http://devicetree.org/schemas/mtd/fsl,elbc-fcm-nand.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20250207-ppcyaml-v2-11-8137b0c42526@posteo.net

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


