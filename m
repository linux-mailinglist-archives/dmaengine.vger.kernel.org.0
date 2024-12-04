Return-Path: <dmaengine+bounces-3878-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E25E79E3A07
	for <lists+dmaengine@lfdr.de>; Wed,  4 Dec 2024 13:32:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5045DB36A0D
	for <lists+dmaengine@lfdr.de>; Wed,  4 Dec 2024 12:30:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27F951B21B9;
	Wed,  4 Dec 2024 12:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YLHP9E1i"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2C5919F475;
	Wed,  4 Dec 2024 12:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733315422; cv=none; b=Hbhk4jgd9trE8RdgkJbQG6K1RnBzCfKN6mnu58VcP5G0DufHWBE4MFCkG3sGBUMre72XfE5dtyAnemuc8E5yxFtnjmmJoIpRF0XJDmAA14leBXWgRy3E7pIS6I6WcOoLpX884V33xRo3+ITyfiWElmt9R0Dbv7Djqp/pWfyhFbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733315422; c=relaxed/simple;
	bh=9eXfoMW90qUkMCd8PB4s1IZLPRKdwA5Uo9N7wSUezic=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DkQ5tQZkK8nIO6eoSxaI1PzsuJvT1L3BtMAPqIXLrEpB8ZJA7+cBUxiiGy2NjLLCvha0gKGTW8yj/8FIosvDBmGH9ltfSM/VBBnOMLE0RQvM3stJPVMnAQe3rh1rwFjyjME8yLkmA/B2a1CWgVpe8SO5z4h6sEmKq6sq4II/OI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YLHP9E1i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3203C4CED1;
	Wed,  4 Dec 2024 12:30:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733315421;
	bh=9eXfoMW90qUkMCd8PB4s1IZLPRKdwA5Uo9N7wSUezic=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YLHP9E1ilKkb5b/js9GkK+0QO4RJKJy7Ie06FdBX7VxDg7v6fAtdqaY1Xa7tRsb9K
	 S1gGNgvoI+uqFINbRzwCbnwrPMh2THSOnD8R6SmSe1CG8ZrIqptKE+LV8ufhRFrDiA
	 5AaJcWSksLaj0fimhuM8fkOumVJjzdNhYbhCIvjnIPPjVdXcsve3nkqRzYv66D/bkS
	 oiy43qe5c8K5piLHora63ZD1cpjQWIrlRUDNVRZi18hgsotZEaasbTDUQ/J2dAY3P8
	 rmWxlj+W7f3RVMzz5bHzCLVTDXYHylQcsKTglDbdyY8qgvhvRsXGtRK6cOKl0NK6oi
	 KNijLrrJHWJyA==
Date: Wed, 4 Dec 2024 18:00:17 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Vaishnav Achath <vaishnav.a@ti.com>
Cc: peter.ujfalusi@gmail.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	u-kumar1@ti.com, j-choudhary@ti.com, vigneshr@ti.com
Subject: Re: [PATCH v3 2/2] dmaengine: ti: k3-udma: Add support for J722S CSI
 BCDMA
Message-ID: <Z1BLWYY8/eVXZxVu@vaman>
References: <20241127101627.617537-1-vaishnav.a@ti.com>
 <20241127101627.617537-3-vaishnav.a@ti.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241127101627.617537-3-vaishnav.a@ti.com>

On 27-11-24, 15:46, Vaishnav Achath wrote:
> J722S CSI BCDMA is similar to J721S2 CSI BCDMA but there are slight
> integration differences like different PSIL thread base ID which is
> currently handled in the driver based on udma_of_match data. Add an
> entry to support J722S CSIRX.
> 
> Signed-off-by: Vaishnav Achath <vaishnav.a@ti.com>
> ---
> 
> V2->V3 : Minor edit in commit message.
> 
> V1->V2:
> 	* Add new compatible for J722S instead of modifying AM62A
> 
>  drivers/dma/ti/k3-udma.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
> index b3f27b3f9209..7ed1956b4642 100644
> --- a/drivers/dma/ti/k3-udma.c
> +++ b/drivers/dma/ti/k3-udma.c
> @@ -4404,6 +4404,18 @@ static struct udma_match_data j721s2_bcdma_csi_data = {
>  	.soc_data = &j721s2_bcdma_csi_soc_data,
>  };
>  
> +static struct udma_match_data j722s_bcdma_csi_data = {
> +	.type = DMA_TYPE_BCDMA,
> +	.psil_base = 0x3100,
> +	.enable_memcpy_support = false,
> +	.burst_size = {
> +		TI_SCI_RM_UDMAP_CHAN_BURST_SIZE_64_BYTES, /* Normal Channels */
> +		0, /* No H Channels */
> +		0, /* No UH Channels */

Why are these zeros? we expect valid size...

> +	},
> +	.soc_data = &j721s2_bcdma_csi_soc_data,
> +};
> +
>  static const struct of_device_id udma_of_match[] = {
>  	{
>  		.compatible = "ti,am654-navss-main-udmap",
> @@ -4435,6 +4447,10 @@ static const struct of_device_id udma_of_match[] = {
>  		.compatible = "ti,j721s2-dmss-bcdma-csi",
>  		.data = &j721s2_bcdma_csi_data,
>  	},
> +	{
> +		.compatible = "ti,j722s-dmss-bcdma-csi",
> +		.data = &j722s_bcdma_csi_data,
> +	},
>  	{ /* Sentinel */ },
>  };
>  MODULE_DEVICE_TABLE(of, udma_of_match);
> -- 
> 2.34.1

-- 
~Vinod

