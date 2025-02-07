Return-Path: <dmaengine+bounces-4350-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DA12A2D1A9
	for <lists+dmaengine@lfdr.de>; Sat,  8 Feb 2025 00:45:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD8EA188C0CA
	for <lists+dmaengine@lfdr.de>; Fri,  7 Feb 2025 23:45:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 438781DE2C3;
	Fri,  7 Feb 2025 23:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cskSHgtk"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAD9E1DE2A4;
	Fri,  7 Feb 2025 23:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738971901; cv=none; b=UwnReOAZJPJNjEJXow3peXhdAm6RKJL16/2fPuD8dEh41r/9WOT01xzoPMbz1Bcc84UixbLkTxuG+KlABn+g37XHW/MT3aa3YUf7NRqe/mHEyptIAQ+iXL1mReqBtrjXxo8xSnO5+TpCexPSGA9xMm02C/EAqRO4dmN/+Ja7DwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738971901; c=relaxed/simple;
	bh=oxDEJrSuRw9jHuBedmerkRKEsabLePL5ItoY++NvcWI=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=mAyAMuZiaeNjthTvvyLoa3Xn1E2xpMbBBvM8sYRAC80L6Fw1M4AiBuikU7TxS3Cw5CBrnXgrBQt5kuMr/zReZybfNqfuJAYGdNhrp6wZxh1lIAfXm0DOwzuIj/B1WY2nEJcGPSljRCbk0FErdNI6oO506FfKRHuG4XkrPOS20Oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cskSHgtk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28EBCC4CEED;
	Fri,  7 Feb 2025 23:45:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738971900;
	bh=oxDEJrSuRw9jHuBedmerkRKEsabLePL5ItoY++NvcWI=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=cskSHgtkDNZpjrroSTdfIB2pBrFWA/I8lyqrwRM3VEsMsQJ8xJ8HgHGrqbX3gKw8p
	 uxzQNr1B8LTK0QWKcrCpaseaC5vB6Bb8PaNk9IeKqu1/r7oLuL7Zz9L9+Eg+NlKvsi
	 YXjY65GMCfwsS4caD9gupEyizInImvIclQf6R+0epDHm0rRw5hBOartRJHhiMeCSTs
	 3KGvQS+zSo92/eXSV7+l1PwvSUyLoI358WwuktySbalbHOg+XnYGZKWgTA/IeFP+Bh
	 X2pRORuLGKSwryBQvt56Ldi77izopX6xGKBTIQVbndi6y7PsSQnjFMS04O38gPVaNA
	 HPK4MwWUSENUw==
Date: Fri, 07 Feb 2025 17:44:59 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Mark Brown <broonie@kernel.org>, Damien Le Moal <dlemoal@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, linux-ide@vger.kernel.org, 
 "David S. Miller" <davem@davemloft.net>, linux-crypto@vger.kernel.org, 
 Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org, 
 Herbert Xu <herbert@gondor.apana.org.au>, linuxppc-dev@lists.ozlabs.org, 
 linux-spi@vger.kernel.org, 
 =?utf-8?q?J=2E_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>, 
 Guenter Roeck <linux@roeck-us.net>, Nicholas Piggin <npiggin@gmail.com>, 
 Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Bjorn Helgaas <bhelgaas@google.com>, Naveen N Rao <naveen@kernel.org>, 
 Vignesh Raghavendra <vigneshr@ti.com>, imx@lists.linux.dev, 
 Niklas Cassel <cassel@kernel.org>, Scott Wood <oss@buserror.net>, 
 Michael Ellerman <mpe@ellerman.id.au>, Richard Weinberger <richard@nod.at>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Lee Jones <lee@kernel.org>, 
 linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-mtd@lists.infradead.org, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Christophe Leroy <christophe.leroy@csgroup.eu>, 
 Wim Van Sebroeck <wim@linux-watchdog.org>, linux-kernel@vger.kernel.org, 
 Miquel Raynal <miquel.raynal@bootlin.com>, linux-pci@vger.kernel.org
To: =?utf-8?q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>
In-Reply-To: <20250207-ppcyaml-v2-9-8137b0c42526@posteo.net>
References: <20250207-ppcyaml-v2-0-8137b0c42526@posteo.net>
 <20250207-ppcyaml-v2-9-8137b0c42526@posteo.net>
Message-Id: <173897189669.2630636.11579554304003668196.robh@kernel.org>
Subject: Re: [PATCH v2 09/12] dt-bindings: memory-controllers: Convert
 fsl,elbc to YAML


On Fri, 07 Feb 2025 22:30:26 +0100, J. Neuschäfer wrote:
> Convert the Freescale localbus controller bindings from text form to
> YAML. The updated list of compatible strings reflects current usage
> in arch/powerpc/boot/dts/, except that many existing device trees
> erroneously specify "simple-bus" in addition to fsl,*elbc.
> 
> Changes compared to the txt version:
>  - removed the board-control (fsl,mpc8272ads-bcsr) node because it only
>    appears in this example and nowhere else
>  - added a new example with NAND flash
>  - updated list of compatible strings
> 
> Signed-off-by: J. Neuschäfer <j.ne@posteo.net>
> ---
> 
> V2:
> - fix order of properties in examples, according to dts coding style
> - move to Documentation/devicetree/bindings/memory-controllers
> - clarify the commit message a tiny bit
> - remove unnecessary multiline markers (|)
> - define address format in patternProperties
> - trim subject line (remove "binding")
> - remove use of "simple-bus", because it's technically incorrect
> ---
>  .../bindings/memory-controllers/fsl,elbc.yaml      | 146 +++++++++++++++++++++
>  .../devicetree/bindings/powerpc/fsl/lbc.txt        |  43 ------
>  2 files changed, 146 insertions(+), 43 deletions(-)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/memory-controllers/fsl,elbc.example.dtb: /example-0/localbus@f0010100/simple-periph@2,0: failed to match any schema with compatible: ['fsl,elbc-gpcm-uio']
Documentation/devicetree/bindings/memory-controllers/fsl,elbc.example.dtb: /example-1/localbus@e0005000/nand@1,0: failed to match any schema with compatible: ['fsl,mpc8315-fcm-nand', 'fsl,elbc-fcm-nand']
Documentation/devicetree/bindings/memory-controllers/fsl,elbc.example.dtb: /example-1/localbus@e0005000/nand@1,0: failed to match any schema with compatible: ['fsl,mpc8315-fcm-nand', 'fsl,elbc-fcm-nand']

doc reference errors (make refcheckdocs):
Warning: Documentation/devicetree/bindings/display/ssd1289fb.txt references a file that doesn't exist: Documentation/devicetree/bindings/powerpc/fsl/lbc.txt
Documentation/devicetree/bindings/display/ssd1289fb.txt: Documentation/devicetree/bindings/powerpc/fsl/lbc.txt

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20250207-ppcyaml-v2-9-8137b0c42526@posteo.net

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


