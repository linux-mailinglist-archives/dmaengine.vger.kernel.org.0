Return-Path: <dmaengine+bounces-4580-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E60CA4681B
	for <lists+dmaengine@lfdr.de>; Wed, 26 Feb 2025 18:30:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 121433A9133
	for <lists+dmaengine@lfdr.de>; Wed, 26 Feb 2025 17:29:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96489224B10;
	Wed, 26 Feb 2025 17:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LvuRHUyz"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67FD7224AF8;
	Wed, 26 Feb 2025 17:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740590997; cv=none; b=gyypa4cDEiPa8sIdSJqAIAj+vjbeIQXB7wxslD7ULW5o1eAq0p1+8I+gBNP3tb91K3DJcBMtTgGca3N4n6I+LDcEcB+n1/FhGrxqj31kjOXzZH2fdoi/E+tzOfNykW3k2PnbXCLLEO/MRW1wTjDQ5kDmMJ7hSzk/1/ApICoAO+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740590997; c=relaxed/simple;
	bh=B7w6kz3z2eZZW+849CoU9pf/lvE0LeYWzWllU/FXywM=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=F7S52V3mnxCDmojPCA3LjOt2azDIPKeApjFLCsD8n3mT/L1G/LVlt4GscTYJ7qAtW2tJykYGrSLxt563Mdri1WWRQvdch3eY+iYYavNOGy9ded3ooWi39THI/lZmk5W3/Nw+lVmxX6Eq4X+YBRMLXkT+cTe5TOSpP/Y1KmSigd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LvuRHUyz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1288C4CEE8;
	Wed, 26 Feb 2025 17:29:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740590996;
	bh=B7w6kz3z2eZZW+849CoU9pf/lvE0LeYWzWllU/FXywM=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=LvuRHUyzsDWBTphzSY4cpGJheves2OjCoffnc3zD1Cs3/7s9gDHGbCtO7REggRQHT
	 AI/MP3MumtyjhM1PsyE4/MBrWPyHkdXlnJYkNmcJz5XXpy7pIvhg1M+32QCSOizCC5
	 WycR9PU0apuL+WalxZdhnQCiglQ9C+E+Iwt4VKRv1OxHXjL+FPaSmlpOXQ3nQfq6Pa
	 4HibuZPCwt4hN5y/MLqcTV4mPBorAnabrbhKYjwtpoqoxT3PCAjeh3dbctv6Eud3Ak
	 cCqUEu1xn0TbvlZQvWjYiNBhQtjqkgSJ3Nvt+KLGtUswtYxweYIfAUHtQnD4x5yDuN
	 jIho7uCRXlAbQ==
Date: Wed, 26 Feb 2025 11:29:54 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Conor Dooley <conor+dt@kernel.org>, 
 Michael Ellerman <mpe@ellerman.id.au>, 
 Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Christophe Leroy <christophe.leroy@csgroup.eu>, dmaengine@vger.kernel.org, 
 Crystal Wood <oss@buserror.net>, linuxppc-dev@lists.ozlabs.org, 
 Nicholas Piggin <npiggin@gmail.com>, Vinod Koul <vkoul@kernel.org>, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Naveen N Rao <naveen@kernel.org>
To: =?utf-8?q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>
In-Reply-To: <20250226-ppcyaml-dma-v3-1-79ce3133569f@posteo.net>
References: <20250226-ppcyaml-dma-v3-1-79ce3133569f@posteo.net>
Message-Id: <174059099427.2999773.4836262903761680275.robh@kernel.org>
Subject: Re: [PATCH v3] dt-bindings: dma: Convert fsl,elo*-dma to YAML


On Wed, 26 Feb 2025 16:57:17 +0100, J. Neuschäfer wrote:
> The devicetree bindings for Freescale DMA engines have so far existed as
> a text file. This patch converts them to YAML, and specifies all the
> compatible strings currently in use in arch/powerpc/boot/dts.
> 
> Signed-off-by: J. Neuschäfer <j.ne@posteo.net>
> ---
> I considered referencing dma-controller.yaml, but that requires
> the #dma-cells property (via dma-common.yaml), and I'm now sure which
> value it should have, if any. Therefore I did not reference
> dma-controller.yaml.
> 
> V3:
> - split out as a single patch
> - restructure "description" definitions to use "items:" as much as possible
> - remove useless description of interrupts in fsl,elo3-dma
> - rename DMA controller nodes to dma-controller@...
> - use IRQ_TYPE_* constants in examples
> - define unit address format for DMA channel nodes
> - drop interrupts-parent properties from examples
> 
> V2:
> - part of series [PATCH v2 00/12] YAML conversion of several Freescale/PowerPC DT bindings
>   Link: https://lore.kernel.org/lkml/20250207-ppcyaml-v2-5-8137b0c42526@posteo.net/
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
>  .../devicetree/bindings/dma/fsl,elo-dma.yaml       | 137 ++++++++++++++
>  .../devicetree/bindings/dma/fsl,elo3-dma.yaml      | 125 +++++++++++++
>  .../devicetree/bindings/dma/fsl,eloplus-dma.yaml   | 132 +++++++++++++
>  .../devicetree/bindings/powerpc/fsl/dma.txt        | 204 ---------------------
>  4 files changed, 394 insertions(+), 204 deletions(-)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/dma/fsl,elo-dma.example.dtb: dma-controller@82a8: '#dma-cells' is a required property
	from schema $id: http://devicetree.org/schemas/dma/dma-controller.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/dma/fsl,eloplus-dma.example.dtb: dma-controller@21300: '#dma-cells' is a required property
	from schema $id: http://devicetree.org/schemas/dma/dma-controller.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/dma/fsl,elo3-dma.example.dtb: dma-controller@100300: '#dma-cells' is a required property
	from schema $id: http://devicetree.org/schemas/dma/dma-controller.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20250226-ppcyaml-dma-v3-1-79ce3133569f@posteo.net

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


