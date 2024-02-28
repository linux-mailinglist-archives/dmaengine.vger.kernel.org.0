Return-Path: <dmaengine+bounces-1142-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C1D986A675
	for <lists+dmaengine@lfdr.de>; Wed, 28 Feb 2024 03:20:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 416D61F24701
	for <lists+dmaengine@lfdr.de>; Wed, 28 Feb 2024 02:20:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C4FB567A;
	Wed, 28 Feb 2024 02:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HP8xkFrH"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3903200AC;
	Wed, 28 Feb 2024 02:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709086806; cv=none; b=MH0j2OuNDjNIO4XDGd/+C6yVQBYxQ8Or5iZe/sOH0gcaBasiY/SEiEtL9mbRG7BmxVcdzgfdNRTwL+54n3UmKVuSlGT73YPuZG4GcYaoPVIJigK3KkyHzfNxrhoaVoifcu7H2Rzxj4EJ2d74vGclAHm5jK5JTMa2JwqwaY9xc2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709086806; c=relaxed/simple;
	bh=lJG3aTHGtCVWptDrBThnLbI1+ODgtKQWqoZmvVMLOSg=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=dlDoiT8bO7Gjo31JKZh/u78EQTFOJPOhwpkJ/N43e0UQacd6iZwnRxG9XeuKFpsLBsRWmm2BuqKkMEfNAILqt3q6pI1gYNvz9K9/hQKD/IXjXV2B0E6anRHJ0kikOVhtEkjZBmAMIg8NpVSmT/2OoRDuTBe9vHMppBQaBqEfrbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HP8xkFrH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28014C433C7;
	Wed, 28 Feb 2024 02:20:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709086805;
	bh=lJG3aTHGtCVWptDrBThnLbI1+ODgtKQWqoZmvVMLOSg=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=HP8xkFrHXhoj/I0aymmEanUuG+6MLtTII1VdaJGfEjM+t4qA2NafQETdZ0dswwzUp
	 kWW1qYuGyREuxWPXFOx5yBFacTitNjfVJig7FHvnXML15yQ1poK997igLyZqxewp6j
	 a7PQ3IQIuR2tUOo3tMTOUR+dM5bI0Muj3bkWRDBb9KJn7/dtVkpLsfgyAW1fFK0MX1
	 wg7byitAfNGDPvL1DBP2P8W6R30jiqkJCFBL2+PL5hDb3XvsdPW3dbKySSFVKxZxzz
	 r9pN2jvX1ajhZc+HCO33tKmvN2TZRA5cj5hpPljsreg0GXv3g78kerHCaIQUDVfQhy
	 KxbiDynpQjSBg==
Date: Tue, 27 Feb 2024 20:20:04 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Rob Herring <robh@kernel.org>
To: "bin.yao" <bin.yao@ingenic.com>
Cc: linux-kernel@vger.kernel.org, broonie@kernel.org, 
 quic_bjorande@quicinc.com, dmaengine@vger.kernel.org, 
 devicetree@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org, 
 vkoul@kernel.org, conor+dt@kernel.org, rick <rick.tyliu@ingenic.com>, 
 robh+dt@kernel.org
In-Reply-To: <20240228012420.4223-1-bin.yao@ingenic.com>
References: <20240228012420.4223-1-bin.yao@ingenic.com>
Message-Id: <170908680304.1284859.7968137931176555362.robh@kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: dma: Ingenic: DT bindings for Ingenic
 PDMA


On Wed, 28 Feb 2024 06:24:19 +0500, bin.yao wrote:
> From: byao <bin.yao@ingenic.com>
> 
> Convert the textual documentation for the Ingenic SoCs PDMA
> Controller devicetree binding to YAML.
> 
> Add a dt-bindings header, and convert the device trees to it.
> 
> Signed-off-by: byao <bin.yao@ingenic.com>
> Signed-off-by: rick <rick.tyliu@ingenic.com>
> ---
>  .../devicetree/bindings/dma/ingenic,pdma.yaml | 77 +++++++++++++++++++
>  include/dt-bindings/dma/ingenic-pdma.h        | 51 ++++++++++++
>  2 files changed, 128 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/dma/ingenic,pdma.yaml
>  create mode 100644 include/dt-bindings/dma/ingenic-pdma.h
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:
./Documentation/devicetree/bindings/dma/ingenic,pdma.yaml:13:11: [error] string value is redundantly quoted with any quotes (quoted-strings)

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/dma/ingenic,pdma.yaml: title: 'Ingenic SoCs DMA Controller DT bindings' should not be valid under {'pattern': '([Bb]inding| [Ss]chema)'}
	hint: Everything is a binding/schema, no need to say it. Describe what hardware the binding is for.
	from schema $id: http://devicetree.org/meta-schemas/base.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/dma/ingenic,pdma.yaml: $id: Cannot determine base path from $id, relative path/filename doesn't match actual path or filename
 	 $id: http://devicetree.org/schemas/dma/ingenic,dma.yaml
 	file: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/dma/ingenic,pdma.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/dma/ingenic,dma.yaml: warning: ignoring duplicate '$id' value 'http://devicetree.org/schemas/dma/ingenic,dma.yaml#'
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/dma/ingenic,pdma.yaml: interrupts-parent: missing type definition
Documentation/devicetree/bindings/dma/ingenic,dma.example.dtb: /example-0/dma-controller@13420000: failed to match any schema with compatible: ['ingenic,jz4780-dma']
Documentation/devicetree/bindings/dma/ingenic,pdma.example.dts:24:18: fatal error: dt-bindings/clock/ingenic,t33-cgu.h: No such file or directory
   24 |         #include <dt-bindings/clock/ingenic,t33-cgu.h>
      |                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
compilation terminated.
make[2]: *** [scripts/Makefile.lib:419: Documentation/devicetree/bindings/dma/ingenic,pdma.example.dtb] Error 1
make[2]: *** Waiting for unfinished jobs....
make[1]: *** [/builds/robherring/dt-review-ci/linux/Makefile:1428: dt_binding_check] Error 2
make: *** [Makefile:240: __sub-make] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240228012420.4223-1-bin.yao@ingenic.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


