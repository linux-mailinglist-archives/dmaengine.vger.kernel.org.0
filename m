Return-Path: <dmaengine+bounces-1483-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 96F7D88AB20
	for <lists+dmaengine@lfdr.de>; Mon, 25 Mar 2024 18:15:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36A3E1FA0F67
	for <lists+dmaengine@lfdr.de>; Mon, 25 Mar 2024 17:15:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D5DA6AFB6;
	Mon, 25 Mar 2024 15:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HTVOnG9e"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2611B3DAC1B;
	Mon, 25 Mar 2024 15:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711382115; cv=none; b=nstMcoF4mNVnOvCkdzv0nl3wrUBoIdeDBJN7KJIho8WLtSBRiqY6Z4fuEZgrIetBnrTOUi7vrY5e1tUN7LIK1fQ8XOjmwIzcYX1LY4g7unfNpvg6S/yEQ5Ymtk6gvYMK8Ni1xlAysnJ6GsQYLR97m8q+dR6CPvI0H8xko2TeHts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711382115; c=relaxed/simple;
	bh=Qrm85A8Diw5Gs2yIB6OBv4B2K3mJND/QD/+WwIzJCi4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JPl+iJAaiyg4iNNlRkWi3KfWxuvsxPy3GnHflfVA8PWkzNFDeydTxqNSSSRq1s1/r/6Fd1O7iN1BveD26Nyu9xlkOcu1O47Oj69fkQ5dU8IpXkqBJq2NYwUktcvGqKtlk2oURp+IKotKiPziUAta/ObfzinERbV5XHSrS0nLQOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HTVOnG9e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84908C433F1;
	Mon, 25 Mar 2024 15:55:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711382114;
	bh=Qrm85A8Diw5Gs2yIB6OBv4B2K3mJND/QD/+WwIzJCi4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HTVOnG9eZEmLxIFYr1M3r3MIu+sGS9zMpH9+XHc3RXu87d4DM6FB9T7VL5ubdvx+J
	 mbFCn5vtYqfoK3Xqsup3qBq2vjBIT58NflajB/Fo4LLDbL8zcb8F8+G/eKLasa3QS5
	 /OSDIdLRfTtROM3FtHwAztk/mieNKuxye+N8b9V5zlZbn/xniUiGH96Tod7aFtLTV7
	 rY7hPOo9lyxVfym0p9eapPz2BJAoddFVNLO2pTaRupHawPoyb4ZhK5OnTRrw37dpaa
	 ei2rZwk3fEOy5wXhPkMtTTcpMmOXqogDi6tAmNtzrJJFfNswl7GDWmETexBGjn1Hx+
	 v+vkg82MM0H6Q==
Date: Mon, 25 Mar 2024 10:55:12 -0500
From: Rob Herring <robh@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Vinod Koul <vkoul@kernel.org>, linux-kernel@vger.kernel.org,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	imx@lists.linux.dev, dmaengine@vger.kernel.org,
	Joy Zou <joy.zou@nxp.com>, Peng Fan <peng.fan@nxp.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [PATCH v3 4/5] dt-bindings: dma: fsl-edma: add fsl,imx8ulp-edma
 compatible string
Message-ID: <171138211122.4034960.14889461643514509727.robh@kernel.org>
References: <20240323-8ulp_edma-v3-0-c0e981027c05@nxp.com>
 <20240323-8ulp_edma-v3-4-c0e981027c05@nxp.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240323-8ulp_edma-v3-4-c0e981027c05@nxp.com>


On Sat, 23 Mar 2024 11:34:53 -0400, Frank Li wrote:
> From: Joy Zou <joy.zou@nxp.com>
> 
> Introduce the compatible string 'fsl,imx8ulp-edma' to enable support for
> the i.MX8ULP's eDMA, alongside adjusting the clock numbering. The i.MX8ULP
> eDMA architecture features one clock for each DMA channel and an additional
> clock for the core controller. Given a maximum of 32 DMA channels, the
> maximum clock number consequently increases to 33.
> 
> Signed-off-by: Joy Zou <joy.zou@nxp.com>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
> 
> Notes:
>      Changes in v3:
>         - Change clock name form CHXX-CLK to chxx
>         - Fix typeo 'clock'
>         - Add dma-cell description
>         - About clock-names:
>           items:
>             oneOf:
>               - const: dma
>               - pattern: ...
> 
>         Which already detect naming wrong, for example:
> 
>         clock-names = "dma", "ch00", "ch01", "ch02", "ch03",
>                       ....
>                       "ch28", "ch29", "ch30", "abcc";
> 
>         arch/arm64/boot/dts/freescale/imx8ulp-evk.dtb: dma-controller@29010000: clock-names:32: 'oneOf' conditional failed, one must be fixed:
>                 'dma' was expected
>                 'abcc' does not match '^ch(0[0-9]|[1-2][0-9]|3[01])$'
> 
>         Only lose order check, such as ch00, dma, ch03, ch02, can pass check.
>         I think it is good enough.
> 
>         I tried rob's suggestion, but met some technology issue. Detail see
> 
>         https://lore.kernel.org/imx/20240229-8ulp_edma-v2-0-9d12f883c8f7@nxp.com/T/#mc5767dd505d4b7cfc66586a0631684a57e735476
> 
>  .../devicetree/bindings/dma/fsl,edma.yaml          | 40 ++++++++++++++++++++--
>  1 file changed, 38 insertions(+), 2 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>


