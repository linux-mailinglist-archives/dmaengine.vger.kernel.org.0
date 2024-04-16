Return-Path: <dmaengine+bounces-1844-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EE078A6C06
	for <lists+dmaengine@lfdr.de>; Tue, 16 Apr 2024 15:19:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B6BE28181A
	for <lists+dmaengine@lfdr.de>; Tue, 16 Apr 2024 13:19:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 489A212C46C;
	Tue, 16 Apr 2024 13:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hFbmB18r"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 187E43BB30;
	Tue, 16 Apr 2024 13:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713273583; cv=none; b=C3BYylojKRcZjH2bE8YnxipoNydDLhaC4Sl61tsMSn+nBsYmy/Jw0Uv6XMFj2CDJAG2QRPy0M7PrIgrBt0MHNrqCMH9A3W+SFwKhB1HDZcb7dMBzTAV97K2Oxga6dueIsXGdZrBFICBwZg6b66EtAB8hlOGIj6u7dHV7k5Tz6QA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713273583; c=relaxed/simple;
	bh=BPjpllDPHaBuORONW/QmDln6MN91/EoL0La9ZnXvYe0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rDNYOJmyV8ZJ49PuL2sM/Tj64KOOuswOck246x2/BfCthIsUX+/VtOj8yP2PVHM/Q+5Tz6N4smsznBqhkPf5+hNjgE1DBtVJfRK5EmfO/6QeqoLikF23yXadpViq1cH/af10Lr7s3Cr+ISosV39i1s5JScA6yAx5BJZ0V6Ng0Tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hFbmB18r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64FF6C113CE;
	Tue, 16 Apr 2024 13:19:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713273582;
	bh=BPjpllDPHaBuORONW/QmDln6MN91/EoL0La9ZnXvYe0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hFbmB18rIKIhsAmwQxX+oKqS+gZprFcE5OUMuuPiGpAT0tN6iKa8Lvu+cRbHJllcu
	 mICK1UJzwOYVjG15lcogv6jNc2U1HQd6s91OgZ4qoTkgA4HBGULDkjYN33Z87QmF2E
	 WFMcCzVyr1vgDqkwyAYVcTwcd4+qMOc+VPuuI34wcl0QS/2GE5qMx1GYpApCSsmIUg
	 lVBzPLx1P25KVOMc0K1p4ZYI+23fWh3H8W8/X1m+prDM/MNSVsQ56952geE7eCBOHL
	 /Dm3mZzP2t2mDXZf3i2hOHtpjeBYCJ6bRX/XKjNNO9kQKNqtqGzHK/BNZB7mV1lTwy
	 2FF/YQsPzF04A==
Date: Tue, 16 Apr 2024 08:19:40 -0500
From: Rob Herring <robh@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: krzk@kernel.org, 20240409185416.2224609-1-Frank.Li@nxp.com,
	conor+dt@kernel.org, devicetree@vger.kernel.org,
	dmaengine@vger.kernel.org, imx@lists.linux.dev,
	krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org,
	pankaj.gupta@nxp.com, peng.fan@nxp.com, shengjiu.wang@nxp.com,
	shenwei.wang@nxp.com, vkoul@kernel.org, xu.yang_2@nxp.com
Subject: Re: [PATCH v4 2/2] dt-bindings: dma: fsl-edma: allow 'power-domains'
 property
Message-ID: <20240416131940.GA2138646-robh@kernel.org>
References: <20240412154208.881836-1-Frank.Li@nxp.com>
 <20240412154208.881836-2-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240412154208.881836-2-Frank.Li@nxp.com>

On Fri, Apr 12, 2024 at 11:42:08AM -0400, Frank Li wrote:
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
>  .../devicetree/bindings/dma/fsl,edma.yaml     | 77 ++++++++++---------
>  1 file changed, 39 insertions(+), 38 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/dma/fsl,edma.yaml b/Documentation/devicetree/bindings/dma/fsl,edma.yaml
> index fb5fbe4b9f9d4..012522612dc96 100644
> --- a/Documentation/devicetree/bindings/dma/fsl,edma.yaml
> +++ b/Documentation/devicetree/bindings/dma/fsl,edma.yaml
> @@ -71,6 +71,10 @@ properties:
>      minItems: 1
>      maxItems: 33
>  
> +  power-domains:
> +    minItems: 1
> +    maxItems: 64

Please state here that number of power-domains are equal to number of 
channels and in ascending order.

Rob

