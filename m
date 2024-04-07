Return-Path: <dmaengine+bounces-1754-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 616CD89B094
	for <lists+dmaengine@lfdr.de>; Sun,  7 Apr 2024 13:21:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92E171C20BD8
	for <lists+dmaengine@lfdr.de>; Sun,  7 Apr 2024 11:21:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 822E4210FF;
	Sun,  7 Apr 2024 11:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KoJRwYp4"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C125200DB;
	Sun,  7 Apr 2024 11:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712488897; cv=none; b=pac3jtBL+yRQEXwGijhxcLLEprxvq94hEEUXp9O6Qhk4+4iFLhXDCFeVyeDumhnF8dsqSF89zkIjWoUXmSb1Srp04DoGZxW/q3dOUeqN5l8aOSS6V8A1C2EdQfz69A5QRpGAxyueNC+svMvZP5oOQH6B1vyvVMKVLfIwFNHB458=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712488897; c=relaxed/simple;
	bh=vbkEV9dGzA1pSMAmtFgYtFM5LG7Uh6sD9Ys6xO+KE+s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c4hApArSEqmYfzCCV4T/oWCx94cjcphfDgQJRgVtGOgZZaIygHV3s1bO+MCoP53EUemiv7z2Fz5Fvn6XPcipuwjMucsn3Mf5hBk5/TtLQvOhMnbALzovEYU8ee1cyP76GRBeUksyYZ2UA/EGt70LI9BgIPHy49n/MHZDBIwPTuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KoJRwYp4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D56A8C433F1;
	Sun,  7 Apr 2024 11:21:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712488896;
	bh=vbkEV9dGzA1pSMAmtFgYtFM5LG7Uh6sD9Ys6xO+KE+s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KoJRwYp4XCZNHWxSkLkxpeUWVzYwEI6l+bMRd+phcytwTjjGV4+8ZgHnVQILGGl34
	 sEn6narY2SkoddVwz+IbLO/5nhUOxFzyPlsH5Kc4IcTwCUk22gDaXqUdIFymtNjY4L
	 2VovWWnJ4geRocYVkYjQ+HbQgDRszX+gZEMJA0XaWFscfVEtdOBl6pn2XOHHgUIQKu
	 iAdUl7p5WXSh/lrsTOFMYnvuiLkSqxQb5AAl/iUDKLkNWCseILExHWtxnKVdUY3dax
	 cpmbTIri/liDK96hevwHTpBcCduVoik65/ke8Vd5/oIiAIsSgWtZyhb4k1GJcnAvP2
	 YPK2EX1f1TjlQ==
Date: Sun, 7 Apr 2024 16:51:32 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Joy Zou <joy.zou@nxp.com>,
	dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	imx@lists.linux.dev
Subject: Re: [PATCH v4 4/5] dt-bindings: fsl-imx-sdma: Add I2C peripheral
 types ID
Message-ID: <ZhKBvOJAhInVaucD@matsya>
References: <20240329-sdma_upstream-v4-0-daeb3067dea7@nxp.com>
 <20240329-sdma_upstream-v4-4-daeb3067dea7@nxp.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240329-sdma_upstream-v4-4-daeb3067dea7@nxp.com>

On 29-03-24, 10:34, Frank Li wrote:
> Add peripheral types ID 26 for I2C because sdma firmware (sdma-6q: v3.6,
> sdma-7d: v4.6) support I2C DMA transfer.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  Documentation/devicetree/bindings/dma/fsl,imx-sdma.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/dma/fsl,imx-sdma.yaml b/Documentation/devicetree/bindings/dma/fsl,imx-sdma.yaml
> index b95dd8db5a30a..80bcd3a6ecaf3 100644
> --- a/Documentation/devicetree/bindings/dma/fsl,imx-sdma.yaml
> +++ b/Documentation/devicetree/bindings/dma/fsl,imx-sdma.yaml
> @@ -93,6 +93,7 @@ properties:
>            - Shared ASRC: 23
>            - SAI: 24
>            - HDMI Audio: 25
> +          - I2C: 26

Sorry comment was for this patch, I have skipped these two now

>  
>         The third cell: transfer priority ID
>           enum:
> 
> -- 
> 2.34.1

-- 
~Vinod

