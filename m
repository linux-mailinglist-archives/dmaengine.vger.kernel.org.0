Return-Path: <dmaengine+bounces-4349-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94F8DA2D19A
	for <lists+dmaengine@lfdr.de>; Sat,  8 Feb 2025 00:45:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC4E93ACCA1
	for <lists+dmaengine@lfdr.de>; Fri,  7 Feb 2025 23:44:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D58C21D958E;
	Fri,  7 Feb 2025 23:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FcFD7E6x"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 819AB1D90C5;
	Fri,  7 Feb 2025 23:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738971899; cv=none; b=psAjnaS8c9LSd/PMTikhIyLN1t2rPrdeNiqAPD+MJrP7UP9fJOOlk9qjyQWa+2uMurhgmaYlvXUxmixBxiWGdKODFBJes5S3affzuSRzWJMQgF949OdGHomH+s0/TJ6LfhARDFcmn169Scnw267S+jVbK9XYTwA0qPUxID40Nh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738971899; c=relaxed/simple;
	bh=0OcYIgMuhOEeKZ02PL/wKdLJvCr/x2GC0bB/FCHa3js=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=Q51Tm/BbbGJDF8bfy8IxVtHzCWywLPm0f8o1D1q2EYMItRrBk8V/Pe1ihxPlL52rzducqKNwNd2W4x2CiX1fd6ng5EMUYY+/66uNabJiojZJVDOUrcFYi0Y1/YvIWC6daE+97Hbn5wnHLf3hTNpQ5IQZhrG4jL1deqLhgJUqH9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FcFD7E6x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7666C4CED1;
	Fri,  7 Feb 2025 23:44:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738971899;
	bh=0OcYIgMuhOEeKZ02PL/wKdLJvCr/x2GC0bB/FCHa3js=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=FcFD7E6x/lq9R9GSbnFWQ84X6jA3wHn8MV9k9BwUEU5Jy3GduQqYEh0TAxZg84hd6
	 U/1mtO4DOlNDyWNaUYLvCvf330mxj9hdZo3Ap9AdXSFLJzN989NVrfwM7hrblNq5Vg
	 rBgXMw5MXP4WKs2vld+G4/TK0CCvjuFMv45Pt2rv7LGomPO/wwwhXgaUbVlAhiwJ0k
	 FKpaEdfJWr8j/V+qutaVdWXkjF/AlONGhMFLYgFT7+ApRz3JHy5WCCZbmTdYAil683
	 nEtQYHSdNFhl0ynU/NrzOmE9kS6c2Mv3qEwGLvCA6rIlaSL+WsaycsHH/XLRHNOch/
	 7FrFsFlmciVrg==
Date: Fri, 07 Feb 2025 17:44:57 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Richard Weinberger <richard@nod.at>, linux-pci@vger.kernel.org, 
 Nicholas Piggin <npiggin@gmail.com>, 
 Herbert Xu <herbert@gondor.apana.org.au>, 
 Christophe Leroy <christophe.leroy@csgroup.eu>, 
 Mark Brown <broonie@kernel.org>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-crypto@vger.kernel.org, 
 imx@lists.linux.dev, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 linuxppc-dev@lists.ozlabs.org, linux-spi@vger.kernel.org, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 linux-kernel@vger.kernel.org, Miquel Raynal <miquel.raynal@bootlin.com>, 
 =?utf-8?q?J=2E_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>, 
 Vinod Koul <vkoul@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 Wim Van Sebroeck <wim@linux-watchdog.org>, 
 Niklas Cassel <cassel@kernel.org>, linux-ide@vger.kernel.org, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Naveen N Rao <naveen@kernel.org>, 
 Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Damien Le Moal <dlemoal@kernel.org>, devicetree@vger.kernel.org, 
 dmaengine@vger.kernel.org, Scott Wood <oss@buserror.net>, 
 Guenter Roeck <linux@roeck-us.net>, "David S. Miller" <davem@davemloft.net>, 
 Bjorn Helgaas <bhelgaas@google.com>, Conor Dooley <conor+dt@kernel.org>, 
 linux-watchdog@vger.kernel.org, Lee Jones <lee@kernel.org>, 
 linux-mtd@lists.infradead.org
To: =?utf-8?q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>
In-Reply-To: <20250207-ppcyaml-v2-6-8137b0c42526@posteo.net>
References: <20250207-ppcyaml-v2-0-8137b0c42526@posteo.net>
 <20250207-ppcyaml-v2-6-8137b0c42526@posteo.net>
Message-Id: <173897189562.2630598.5483742714479681257.robh@kernel.org>
Subject: Re: [PATCH v2 06/12] dt-bindings: pci: Convert fsl,mpc83xx-pcie to
 YAML


On Fri, 07 Feb 2025 22:30:23 +0100, J. Neuschäfer wrote:
> Formalise the binding for the PCI controllers in the Freescale MPC8xxx
> chip family. Information about PCI-X-specific properties was taken from
> fsl,pci.txt. The examples were taken from mpc8315erdb.dts and
> xpedite5200_xmon.dts.
> 
> Signed-off-by: J. Neuschäfer <j.ne@posteo.net>
> ---
> 
> V2:
> - merge fsl,pci.txt into fsl,mpc8xxx-pci.yaml
> - regroup compatible strings, list single-item values in one enum
> - trim subject line (remove "binding")
> - fix property order to comply with dts coding style
> ---
>  .../devicetree/bindings/pci/fsl,mpc8xxx-pci.yaml   | 115 +++++++++++++++++++++
>  Documentation/devicetree/bindings/pci/fsl,pci.txt  |  27 -----
>  2 files changed, 115 insertions(+), 27 deletions(-)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:


doc reference errors (make refcheckdocs):
Warning: Documentation/devicetree/bindings/pci/fsl,mpc8xxx-pci.yaml references a file that doesn't exist: Documentation/devicetree/bindings/pci/fsl,pci.txt
Documentation/devicetree/bindings/pci/fsl,mpc8xxx-pci.yaml: Documentation/devicetree/bindings/pci/fsl,pci.txt

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20250207-ppcyaml-v2-6-8137b0c42526@posteo.net

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


