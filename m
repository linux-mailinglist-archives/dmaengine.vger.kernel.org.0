Return-Path: <dmaengine+bounces-1465-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 55E88885660
	for <lists+dmaengine@lfdr.de>; Thu, 21 Mar 2024 10:23:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EB56DB21457
	for <lists+dmaengine@lfdr.de>; Thu, 21 Mar 2024 09:23:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 617C53FB84;
	Thu, 21 Mar 2024 09:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GnCq9nYc"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 342CE3BBC4;
	Thu, 21 Mar 2024 09:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711013028; cv=none; b=NT35skb7vOIWbIlBJP34CRTYbfWOHikI810qJb8uQ9iclTFRK4uWRhDwNP0Oq7U3YHSG3yUOEM109AaldcPDMaq7kcrJD2CbDCQFfp6IbL3/5e1tWbmXthM1jJ+N+IRQq9AA6oPYbFM9sggz0j1uu0o542h+bEYoIqflIHMrIc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711013028; c=relaxed/simple;
	bh=3NjON48WB6AnmqYupVeImJldwilHG24aGFY7ALDC3cE=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=b3rKTYUqlvhep3PBp4vjI9IYu4ZIN1dLHsbXTX2Vu9cEeOI646ZCP6qkkG8S9G5JHNGftq+Qy3NV22ksJuM7fWXWzPuJVnnnBpKbXjuQpWiTV8guz5WxkmCvGvQcF+7joMHI3Y/EeNDyYrAxxjMh/zOoANG4EowOwiH+RC1JdvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GnCq9nYc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BDA3C433C7;
	Thu, 21 Mar 2024 09:23:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711013027;
	bh=3NjON48WB6AnmqYupVeImJldwilHG24aGFY7ALDC3cE=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=GnCq9nYcuA22HPUCPKf1XeWJmRr7E8jvA2yKqXu03PNWn+nKSyeI0KVXltr6zdvOC
	 hybhbmTH9g//W3tQHIpEQM42fpfzPVNMQ9cxgfIcqcUFehrkT0aBV2k0XYAEesPh+G
	 UvKw1ATRQuAcGzz+Zp8uPkvHnthL3hSwaa1cJFXGhMrCRKN6ZmB9iUuxxT768NLInj
	 dOyZG2quHbu1+m6cRxaGhP1nG94ETFWfEFBX7bq9R1JK6fpE1gcJJBWWSoNeGZisi1
	 oRtMaxDqKKDPfR59mTwJa5L/d5CndaQlgU3PdFEOJJ4tIBK1OhcRLVEgmtQiHMQkNy
	 I9LMe4xSOFEyA==
Date: Thu, 21 Mar 2024 04:23:46 -0500
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Rob Herring <robh@kernel.org>
To: bin.yao@ingenic.com
Cc: krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org, 
 dmaengine@vger.kernel.org, conor+dt@kernel.org, robh+dt@kernel.org, 
 linux-kernel@vger.kernel.org, vkoul@kernel.org, 1587636487@qq.com
In-Reply-To: <20240321080228.24147-2-bin.yao@ingenic.com>
References: <20240321080228.24147-1-bin.yao@ingenic.com>
 <20240321080228.24147-2-bin.yao@ingenic.com>
Message-Id: <171101302544.1214225.13077812930159228555.robh@kernel.org>
Subject: Re: [PATCH 2/2] dt-bindings: dma: Convert ingenic-pdma doc to YAML


On Thu, 21 Mar 2024 16:02:28 +0800, bin.yao@ingenic.com wrote:
> From: "bin.yao" <bin.yao@ingenic.com>
> 
> Convert the textual documentation for the Ingenic SoCs PDMA Controller
> devicetree binding to YAML.
> 
> Signed-off-by: bin.yao <bin.yao@ingenic.com>
> ---
>  .../devicetree/bindings/dma/ingenic,pdma.yaml | 67 +++++++++++++++++++
>  include/dt-bindings/dma/ingenic-pdma.h        | 45 +++++++++++++
>  2 files changed, 112 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/dma/ingenic,pdma.yaml
>  create mode 100644 include/dt-bindings/dma/ingenic-pdma.h
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/dma/ingenic,pdma.example.dtb: dma@13420000: $nodename:0: 'dma@13420000' does not match '^dma-controller(@.*)?$'
	from schema $id: http://devicetree.org/schemas/dma/ingenic,pdma.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/dma/ingenic,pdma.example.dtb: dma@13420000: 'interrupts-names' is a required property
	from schema $id: http://devicetree.org/schemas/dma/ingenic,pdma.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/dma/ingenic,pdma.example.dtb: dma@13420000: Unevaluated properties are not allowed ('interrupt-names' was unexpected)
	from schema $id: http://devicetree.org/schemas/dma/ingenic,pdma.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240321080228.24147-2-bin.yao@ingenic.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


