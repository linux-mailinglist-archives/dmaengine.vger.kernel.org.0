Return-Path: <dmaengine+bounces-2834-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E0F0094DBEF
	for <lists+dmaengine@lfdr.de>; Sat, 10 Aug 2024 11:22:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F9D51C209CE
	for <lists+dmaengine@lfdr.de>; Sat, 10 Aug 2024 09:22:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DFFA14D715;
	Sat, 10 Aug 2024 09:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uWc8zMTK"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5257D4436E;
	Sat, 10 Aug 2024 09:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723281743; cv=none; b=SndlVpxMHD+BHtL5uleHQbHaLjU9Buym/rETiYZCZ2NLMID7kq3heMi3aktMC4kZQmIFIo2787D8dZecc1yCf4XACXdnMsPT7kB48BWfqnhJZ55R13Vo9dPB6tgG8hABE6WB2NCFKJmBSUqXC+APeHiSutqdFH1Ld5Hv8PxrTcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723281743; c=relaxed/simple;
	bh=Wggb/KQ1jKzObVCEvDWxIY7sWLOyIi04ajTFUixFNFk=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=o7iMdn1jizzViI3+N1xfX5fl9nSgViiXCkhW0YivsOmGNfTzdwvZv8WwvXH4LTM5BvJv5plOJRmCqdw76clJdzO5s7nOsWOvHagepWol2rhkSIjgc3xJaiPJxhO+NBS14ZNRSTuD15JaRkZT+/N1q0IEU/wYghkTUcYPQB9aHnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uWc8zMTK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F99FC32781;
	Sat, 10 Aug 2024 09:22:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723281742;
	bh=Wggb/KQ1jKzObVCEvDWxIY7sWLOyIi04ajTFUixFNFk=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=uWc8zMTK3+JFSfRE4Upg+8OwemqhRtOApSPiIGfMsxKKNajedEje03C/BxPMpMlek
	 fUdIesxdzg2OD0Y7oJFKxYGIU/FJcf6QsoApcw3eiqSzUVjk8QlAXDi4GBoaqTgZaK
	 nR8IY6MskxFW1JH44tJQ1W5Pd6VMFGiXpMGCxu2b0EVssNkWnjYuxbhdZC62ke7qOa
	 pMAQGMBVDNXpu0Y9B1NNIFUFMK2L0ncp1ZJTO+i0hiNIBd8R7NIH3n7d7BzNzvjxec
	 mfh1b/XaO2VBiRH76hPIbA5QtspnIk1CtBz+Eqd8eI7UkmxGgwXqGXl2D2KylBKu1+
	 CAanTqeZMfr1A==
Date: Sat, 10 Aug 2024 03:22:21 -0600
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
Cc: dmaengine@vger.kernel.org, devicetree@vger.kernel.org, 
 Palmer Dabbelt <palmer@dabbelt.com>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Chen Wang <unicorn_wang@outlook.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-riscv@lists.infradead.org, 
 Vinod Koul <vkoul@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 linux-kernel@vger.kernel.org, Albert Ou <aou@eecs.berkeley.edu>
In-Reply-To: 
 <IA1PR20MB4953DBA230FF57B2F78F7283BBBB2@IA1PR20MB4953.namprd20.prod.outlook.com>
References: <IA1PR20MB49530ABC137B465548817077BBBB2@IA1PR20MB4953.namprd20.prod.outlook.com>
 <IA1PR20MB4953DBA230FF57B2F78F7283BBBB2@IA1PR20MB4953.namprd20.prod.outlook.com>
Message-Id: <172328174147.2924175.10204174788649625539.robh@kernel.org>
Subject: Re: [PATCH v10 1/3] dt-bindings: dmaengine: Add dma multiplexer
 for CV18XX/SG200X series SoC


On Sat, 10 Aug 2024 16:38:53 +0800, Inochi Amaoto wrote:
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
> ---
>  .../bindings/dma/sophgo,cv1800b-dmamux.yaml   | 51 +++++++++++++++++++
>  1 file changed, 51 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/dma/sophgo,cv1800b-dmamux.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/dma/sophgo,cv1800b-dmamux.yaml: $id: Cannot determine base path from $id, relative path/filename doesn't match actual path or filename
 	 $id: http://devicetree.org/schemas/dma/sophgo,cv1800-dmamux.yaml
 	file: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/dma/sophgo,cv1800b-dmamux.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/IA1PR20MB4953DBA230FF57B2F78F7283BBBB2@IA1PR20MB4953.namprd20.prod.outlook.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


