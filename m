Return-Path: <dmaengine+bounces-4736-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 26855A5F86D
	for <lists+dmaengine@lfdr.de>; Thu, 13 Mar 2025 15:35:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9EA33188B758
	for <lists+dmaengine@lfdr.de>; Thu, 13 Mar 2025 14:34:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9867126869E;
	Thu, 13 Mar 2025 14:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i/5mtUAa"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64337267B78;
	Thu, 13 Mar 2025 14:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741876271; cv=none; b=AWzdbw3wLVn8dAPW0Z0vVWbKube/8ZI9rIIQTM/HL+HkuUiLlzj9UwzjXyhnRNyK++9Xhs88WdvlJatowvzorYuiq7nCfK8ZwVHFsiu4IF5ZU3ajz+N7n4T/6WQJUoRctd2y6tFbkNynr9YegVQzjv+X824uOJSgA09TwdAPURE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741876271; c=relaxed/simple;
	bh=q7tcXhM/G+j/VE2KX9E2hy+pT9MDKbegYTC6EBQh5HM=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=VGsB6+f1pwxiZldFcj8S8BO4t2My0AdFKSBv7h5DOF2gscJWrLdZMNm7nUv3G4P8KFnk2QrX+40g5/ZXaqrMNCABIgMsC/d3hlobOXXCHHy/rklyZg7GYfhQn7jjKxRFaju5JNl0JBt+xBeUTyZBlHsd1yWVZa7aqfpehVtGe4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i/5mtUAa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BFB4C4CEDD;
	Thu, 13 Mar 2025 14:31:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741876270;
	bh=q7tcXhM/G+j/VE2KX9E2hy+pT9MDKbegYTC6EBQh5HM=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=i/5mtUAaLkbWg/nIPtp5cJInyu+dncYZuqJPUOt9jcMookYcqt4XIZ6IupkOaDuHm
	 uLFMF6c4mBtyc5IAXD1F4vO0BBjIaKTk7c9o36jMBCa2H1Q0ZgJjtNYxtkQ2Mp2bJQ
	 gtQF5ysN0QNxgTZI2w5SeC886c7/LLH/qOtsHJKtnsC9I69Bp+KQYSm00/ngLcduB4
	 Qyt3kP20zJhSTir8Kj2uH96DEiJO8IV/u2apvPw4SMBF0ztztAWtIQ/VOt0gn+6Cf2
	 cn1TpIXuLRH+gi1JRC3OqzkArMfgqQNtH6easUrn+/p5MXvwkyYvHtUp4ZJA1XBVAf
	 yoFuBsIbwuXfg==
Date: Thu, 13 Mar 2025 09:31:09 -0500
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: vigneshr@ti.com, andersson@kernel.org, linux-mtd@lists.infradead.org, 
 miquel.raynal@bootlin.com, conor+dt@kernel.org, agross@kernel.org, 
 krzk+dt@kernel.org, linux-arm-msm@vger.kernel.org, richard@nod.at, 
 dmaengine@vger.kernel.org, vkoul@kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, konradybcio@kernel.org, 
 manivannan.sadhasivam@linaro.org
To: Kaushal Kumar <quic_kaushalk@quicinc.com>
In-Reply-To: <20250313130918.4238-2-quic_kaushalk@quicinc.com>
References: <20250313130918.4238-1-quic_kaushalk@quicinc.com>
 <20250313130918.4238-2-quic_kaushalk@quicinc.com>
Message-Id: <174187626948.2759710.10340632443652482523.robh@kernel.org>
Subject: Re: [PATCH 1/6] dt-bindings: mtd: qcom,nandc: Document the SDX75
 NAND


On Thu, 13 Mar 2025 18:39:13 +0530, Kaushal Kumar wrote:
> Document the QPIC NAND controller v2.1.1 being used in
> SDX75 SoC and it uses BAM DMA.
> 
> SDX75 NAND controller has DMA-coherent and iommu support
> so define them in the properties section, without which
> 'dtbs_check' reports the following error:
> 
>   nand-controller@1cc8000: Unevaluated properties are not
>   allowed ('dma-coherent', 'iommus' were unexpected)
> 
> Signed-off-by: Kaushal Kumar <quic_kaushalk@quicinc.com>
> ---
>  .../devicetree/bindings/mtd/qcom,nandc.yaml   | 23 ++++++++++++++-----
>  1 file changed, 17 insertions(+), 6 deletions(-)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mtd/qcom,nandc.yaml: properties:compatible: 'anyOf' conditional failed, one must be fixed:
	'OneOf' is not one of ['$ref', 'additionalItems', 'additionalProperties', 'allOf', 'anyOf', 'const', 'contains', 'default', 'dependencies', 'dependentRequired', 'dependentSchemas', 'deprecated', 'description', 'else', 'enum', 'exclusiveMaximum', 'exclusiveMinimum', 'items', 'if', 'minItems', 'minimum', 'maxItems', 'maximum', 'multipleOf', 'not', 'oneOf', 'pattern', 'patternProperties', 'properties', 'required', 'then', 'typeSize', 'unevaluatedProperties', 'uniqueItems']
	'type' was expected
	from schema $id: http://devicetree.org/meta-schemas/keywords.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mtd/qcom,nandc.yaml: properties:compatible: Additional properties are not allowed ('OneOf' was unexpected)
	from schema $id: http://devicetree.org/meta-schemas/string-array.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20250313130918.4238-2-quic_kaushalk@quicinc.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


