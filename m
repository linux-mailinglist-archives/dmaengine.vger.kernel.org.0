Return-Path: <dmaengine+bounces-1891-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D74A78A9AE8
	for <lists+dmaengine@lfdr.de>; Thu, 18 Apr 2024 15:10:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D25E1F217BF
	for <lists+dmaengine@lfdr.de>; Thu, 18 Apr 2024 13:10:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16924145337;
	Thu, 18 Apr 2024 13:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S9QxW8Im"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D80B013C3FF;
	Thu, 18 Apr 2024 13:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713445827; cv=none; b=SAkQQu96gXxYI6/B6nsL7bX1RKslAhXdI3nwyo4+sFsTzgkud/2WV5H3nbU6+Psyji7zSXmM6I30cF5gDwOyvu66p9qhlslMwml+TU1YLTxZ+/cAa4NMriiB3SFVHpkEvW5eiJAlS8+Jg/Q4V8VHvnYl9c8LG692c0jpc7hxUrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713445827; c=relaxed/simple;
	bh=fPZ9DpCJk3Y2zRw5kWl7PSP4OLa6YCUAoXfziirfp8I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XvXd5N3Ow+amln1drfTBG0HGmzLbsKQvk7DxAr1oBJBaooxEEYkBNTZ9lVPs8e41w+RRlSjxdXPvKuuBntICD4N/u5POYjuqBTvqluHOIwvqqlUJFnL67Wb3ZlIBqQY23wSYTp7HVCb3YcKdjFacBLjoD0XM3ksdFwXr4bMoAh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S9QxW8Im; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B5ABC113CC;
	Thu, 18 Apr 2024 13:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713445826;
	bh=fPZ9DpCJk3Y2zRw5kWl7PSP4OLa6YCUAoXfziirfp8I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=S9QxW8ImvY08pMZCQGTLd+TE9QQh3W/q9gYW7iXhIMlQ6GZcjFBRt8XAjY37tbLCm
	 5WhVJQk24NcORuoWGmUJQAZOlhefsBAWWm8M5IGLnTTTmKmRaeULkl2rdkdqRE4SuK
	 x6aFmJ/ykArb53DNCok15aNCYytV84gmJDiFKni8Nl9AN8O6SlLz+n5ZRE3kEWp4C1
	 cc1IxmwwGFYKNqRKRvd3lUUHJHIrSw+sgJNuXdqpXxhoLlQbH9weGr34ZjuBGNoYou
	 hJqDbuH1yzpqubp76DF1CmbgQnAFx89uQXCi5td469G1zm8rMc8RkKzm6NidwTe3zu
	 s4sDzv0CVx4oA==
Date: Thu, 18 Apr 2024 08:10:24 -0500
From: Rob Herring <robh@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: vkoul@kernel.org, pankaj.gupta@nxp.com,
	20240409185416.2224609-1-Frank.Li@nxp.com, shenwei.wang@nxp.com,
	xu.yang_2@nxp.com, shengjiu.wang@nxp.com,
	devicetree@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
	krzk@kernel.org, linux-kernel@vger.kernel.org, peng.fan@nxp.com,
	imx@lists.linux.dev, conor+dt@kernel.org, dmaengine@vger.kernel.org
Subject: Re: [PATCH v5 2/2] dt-bindings: dma: fsl-edma: allow 'power-domains'
 property
Message-ID: <171344580514.1090639.5974994638297885495.robh@kernel.org>
References: <20240417152457.361340-1-Frank.Li@nxp.com>
 <20240417152457.361340-2-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240417152457.361340-2-Frank.Li@nxp.com>


On Wed, 17 Apr 2024 11:24:57 -0400, Frank Li wrote:
> Allow 'power-domains' property because i.MX8DXL i.MX8QM and i.MX8QXP need
> it. EDMA supports each power-domain for each dma channel. So minItems and
> maxItems align 'dma-channels'.
> 
> Change fsl,imx93-edma3 example to fsl,imx8qm-edma to reflect this variants.
> 
> Fixed below DTB_CHECK warning:
>   dma-controller@599f0000: Unevaluated properties are not allowed ('power-domains' was unexpected)
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
> 
> Notes:
>     Change from v4 to v5
>     - Add description according to rob's suggest.
> 
>      "The number of power domains matches the number of channels, arranged
>      in ascending order according to their associated DMA channels."
> 
>     Change from v3 to v4
>     - Remove 'contains' change should be belong to first patch when rebase.
> 
>     make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- -j8  dt_binding_check DT_SCHEMA_FILES=fsl,edma.yaml
>       LINT    Documentation/devicetree/bindings
>       DTEX    Documentation/devicetree/bindings/dma/fsl,edma.example.dts
>       CHKDT   Documentation/devicetree/bindings/processed-schema.json
>       SCHEMA  Documentation/devicetree/bindings/processed-schema.json
>       DTC_CHK Documentation/devicetree/bindings/dma/fsl,edma.example.dtb
> 
>     After this patch no warning for imx8dxl-evk.dtb.
> 
>     touch arch/arm64/boot/dts/freescale/imx8dxl.dtsi
>     make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- -j8  CHECK_DTBS=y freescale/imx8dxl-evk.dtb
>       DTC_CHK arch/arm64/boot/dts/freescale/imx8dxl-evk.dtb
> 
>     Change from v2 to v3
>     - set 'power-domains' false for other compatitble string
>     - change imx93 example to 8qm example to affect this change according to
>     Krzysztof Kozlowski's suggestion, choose least channel number edma
>     instance to reduce code copy. max channel number is 64.
> 
>     - Rebase to latest dmaengine/next, fixes conflicts.
> 
>     Change from v1 to v2
>     - using maxitem: 64. Each channel have one power domain. Max 64 dmachannel.
>     - add power-domains to 'required' when compatible string is fsl,imx8qm-adma
>         or fsl,imx8qm-edma
> 
>  .../devicetree/bindings/dma/fsl,edma.yaml     | 80 ++++++++++---------
>  1 file changed, 42 insertions(+), 38 deletions(-)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


