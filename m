Return-Path: <dmaengine+bounces-2753-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D88493ECEB
	for <lists+dmaengine@lfdr.de>; Mon, 29 Jul 2024 07:21:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC835281D6C
	for <lists+dmaengine@lfdr.de>; Mon, 29 Jul 2024 05:21:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E53FC8061C;
	Mon, 29 Jul 2024 05:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cXRsqslY"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A905E163;
	Mon, 29 Jul 2024 05:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722230504; cv=none; b=t2jJ61MtdtArIqTZa47faN9Ew/qM/b23YsDGd0SQoFhN+HZ/N/nDr1h/L221XkzVs8YCs2JNSb5RCprQWe9jTR2YWdxT8cufgS9tmweoaqzEL0RxnTD+xcJL/v5p5+kZMs5CQ8M7IWT11Ckn1kRb3jXdQ4Y67AGujHL0DkqucTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722230504; c=relaxed/simple;
	bh=KruHvoHH42zwDU1xGJ3PkJoXwnikfd0WtTHCdlVyxtM=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=MeHliD4O/Y0cawUHxSPzqo9VA5h/E/Vu9C6tkFZowZcbjBanLw3wQm6e8NNVBollcXEBVZ79xmhs5Ry5Kho/tepM1ryGSoDKmI4KjAHXztkw/yprwkSAuVu09fF2la+wY8x+r5C7j31s83Mwvqgw7YTkkTtufnz9Gp/1E3RlPk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cXRsqslY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07B1EC32786;
	Mon, 29 Jul 2024 05:21:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722230504;
	bh=KruHvoHH42zwDU1xGJ3PkJoXwnikfd0WtTHCdlVyxtM=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=cXRsqslYpi8b2/pM30oSUMlqF+vLezHFJPViUlcz/TYJ0YmJSAOoKWYGEKYOQ5/Te
	 nzaZ1t9jRXAcaNTDI2ld0oDP/Jl5juLPDIvluplad0WCiL4Ajhxte63YLpMqx/lWoa
	 tfOLUFfqs2+nEpPpGX5lF6cUpaMTC1DfuPu8bJC/pT4pkDhmjQ7KXhiCQ2MIQ606OS
	 mSWy3n0jENFeJJrrn+mhagS7LNx+cuKonx0U+VR8vTFduO2dp7M26R12SMTq4ok2Fv
	 mib9WriSAVJWyI+k/JpUNTTMhH+R5HHvXjA425eEa7TbTRJelZdjCxtnQLRZVo60oZ
	 9Mzc+wWcxdRWw==
Date: Mon, 29 Jul 2024 00:21:42 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Inochi Amaoto <inochiama@outlook.com>
Cc: Albert Ou <aou@eecs.berkeley.edu>, devicetree@vger.kernel.org, 
 Palmer Dabbelt <palmer@dabbelt.com>, 
 Paul Walmsley <paul.walmsley@sifive.com>, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 dmaengine@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>, 
 Liu Gui <kenneth.liu@sophgo.com>, linux-riscv@lists.infradead.org, 
 Chen Wang <unicorn_wang@outlook.com>, Vinod Koul <vkoul@kernel.org>
In-Reply-To: 
 <IA1PR20MB4953865775FA926B2BA4580CBBB72@IA1PR20MB4953.namprd20.prod.outlook.com>
References: <IA1PR20MB49535EC188F8EE3F8FD0B68DBBB72@IA1PR20MB4953.namprd20.prod.outlook.com>
 <IA1PR20MB4953865775FA926B2BA4580CBBB72@IA1PR20MB4953.namprd20.prod.outlook.com>
Message-Id: <172223050278.2763977.11180028101195359000.robh@kernel.org>
Subject: Re: [PATCH v8 RESEND 1/3] dt-bindings: dmaengine: Add dma
 multiplexer for CV18XX/SG200X series SoC


On Mon, 29 Jul 2024 12:36:51 +0800, Inochi Amaoto wrote:
> The DMA IP of Sophgo CV18XX/SG200X is based on a DW AXI CORE, with
> an additional channel remap register located in the top system control
> area. The DMA channel is exclusive to each core.
> 
> In addition, the DMA multiplexer is a subdevice of system controller,
> so this binding only contains necessary properties for the multiplexer
> itself.
> 
> Add the dmamux binding for CV18XX/SG200X series SoC.
> 
> Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../bindings/dma/sophgo,cv1800-dmamux.yaml    | 51 +++++++++++++++++++
>  1 file changed, 51 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/dma/sophgo,cv1800-dmamux.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/dma/sophgo,cv1800-dmamux.example.dtb: dma-router@154: dma-masters: 4294967295 is not of type 'array'
	from schema $id: http://devicetree.org/schemas/dma/sophgo,cv1800-dmamux.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/dma/sophgo,cv1800-dmamux.example.dtb: dma-router@154: dma-masters: 4294967295 is not of type 'array'
	from schema $id: http://devicetree.org/schemas/dma/sophgo,cv1800-dmamux.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/dma/sophgo,cv1800-dmamux.example.dtb: dma-router@154: dma-masters: 4294967295 is not of type 'array'
	from schema $id: http://devicetree.org/schemas/dma/dma-router.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/dma/sophgo,cv1800-dmamux.example.dtb: dma-router@154: dma-masters: 4294967295 is not of type 'array'
	from schema $id: http://devicetree.org/schemas/dma/dma-router.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/IA1PR20MB4953865775FA926B2BA4580CBBB72@IA1PR20MB4953.namprd20.prod.outlook.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


