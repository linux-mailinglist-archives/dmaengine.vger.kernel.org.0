Return-Path: <dmaengine+bounces-7125-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1565BC4763D
	for <lists+dmaengine@lfdr.de>; Mon, 10 Nov 2025 16:03:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C76A43A723A
	for <lists+dmaengine@lfdr.de>; Mon, 10 Nov 2025 15:03:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57FD22D5A14;
	Mon, 10 Nov 2025 15:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZShMrxCg"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29E1C32C8B;
	Mon, 10 Nov 2025 15:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762786992; cv=none; b=a+GyLlaACoRW5aUmR1FQS63k0bQ52BZs0M9JpN33vcgXmQEYJmGQ70XjIs8yO7ktw2t7sQavNNtiX12mBNdr851jR2HpETgxcM/RMXpnLVVEAvcDM/Onysxd3qC+he471vWHcZYsgcjFaD6riY2TlD3W/rikoCvAIQTdfNj1dXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762786992; c=relaxed/simple;
	bh=PGVjyNwZo45ZtDA9pDb5Hj7UUNqVxTVZ/YFcQGSojTM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KaOBfiwMcxtlPMPFMRMCx5OH4jHUbre35zpvfC9UYBC0JPJwBQxVen9fI4BAU6r3OQG76WtKiQHaZEMXozvnLjJ39jncKT3NE/BWmnEoqtgDBu62GfDoQYE/cUhz7LQ2dGp9pf1bS8oTbIFgTDlFEQiKtokMU2l32mm5UbXC74c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZShMrxCg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08A06C4CEF5;
	Mon, 10 Nov 2025 15:03:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762786990;
	bh=PGVjyNwZo45ZtDA9pDb5Hj7UUNqVxTVZ/YFcQGSojTM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZShMrxCgzncx/j0Eb64AiWxYjenENvTq9Mx8U3xbRFOcDtKq/bNfA0x1UHXU0t1s6
	 svBn50q58WNISZkpLZqf4Bwk6lGsZg8JSRt47IB1HRPhFU8txcF+jUDycNBBYdLOLn
	 cMvQEbf6NrRRJtxI8v6DSiNuU4kp1LuTOD6ClchIGyy6ConTsporu3TDCIoImwn4gh
	 H+BRa3IqlB9EII1UOH39yL5jdzHd6XXNn9H2ycV3/SoiM3TRCZq2JiFqzSniFXeM5I
	 WzVqT3L0+OyCo8PafeDIhHQCIEI55gQXUJcVTw+yyGsZJbawHTy1M7fF3SJI+XiTGk
	 UOLrm1akYevRg==
Date: Mon, 10 Nov 2025 09:07:16 -0600
From: Bjorn Andersson <andersson@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Stefan Wahren <wahrenst@gmx.net>, Vinod Koul <vkoul@kernel.org>, 
	Thomas Andreatta <thomasandreatta2000@gmail.com>, Caleb Sander Mateos <csander@purestorage.com>, 
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-arm-msm@vger.kernel.org, Olivier Dautricourt <olivierdautricourt@gmail.com>, 
	Stefan Roese <sr@denx.de>, Florian Fainelli <florian.fainelli@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Ray Jui <rjui@broadcom.com>, 
	Scott Branden <sbranden@broadcom.com>, Lars-Peter Clausen <lars@metafoo.de>, 
	Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, Daniel Mack <daniel@zonque.org>, 
	Haojian Zhuang <haojian.zhuang@gmail.com>, Robert Jarzmik <robert.jarzmik@free.fr>, 
	Lizhi Hou <lizhi.hou@amd.com>, Brian Xu <brian.xu@amd.com>, 
	Raj Kumar Rampelli <raj.kumar.rampelli@amd.com>, Michal Simek <michal.simek@amd.com>, 
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2 09/13] dmaengine: qcom: adm: use sg_nents_for_dma()
 helper
Message-ID: <6h44m3aoqaitosivcbnuz2ynhon2de3vpxk6egz54vgfqxnsgi@ykhk73irtfcv>
References: <20251110103805.3562136-1-andriy.shevchenko@linux.intel.com>
 <20251110103805.3562136-10-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251110103805.3562136-10-andriy.shevchenko@linux.intel.com>

On Mon, Nov 10, 2025 at 11:23:36AM +0100, Andy Shevchenko wrote:
> Instead of open coded variant let's use recently introduced helper.
> 

Reviewed-by: Bjorn Andersson <andersson@kernel.org>

> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/dma/qcom/qcom_adm.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/dma/qcom/qcom_adm.c b/drivers/dma/qcom/qcom_adm.c
> index 6be54fddcee1..490edad20ae6 100644
> --- a/drivers/dma/qcom/qcom_adm.c
> +++ b/drivers/dma/qcom/qcom_adm.c
> @@ -390,16 +390,15 @@ static struct dma_async_tx_descriptor *adm_prep_slave_sg(struct dma_chan *chan,
>  	}
>  
>  	/* iterate through sgs and compute allocation size of structures */
> -	for_each_sg(sgl, sg, sg_len, i) {
> -		if (achan->slave.device_fc) {
> +	if (achan->slave.device_fc) {
> +		for_each_sg(sgl, sg, sg_len, i) {
>  			box_count += DIV_ROUND_UP(sg_dma_len(sg) / burst,
>  						  ADM_MAX_ROWS);
>  			if (sg_dma_len(sg) % burst)
>  				single_count++;
> -		} else {
> -			single_count += DIV_ROUND_UP(sg_dma_len(sg),
> -						     ADM_MAX_XFER);
>  		}
> +	} else {
> +		single_count = sg_nents_for_dma(sgl, sg_len, ADM_MAX_XFER);
>  	}
>  
>  	async_desc = kzalloc(sizeof(*async_desc), GFP_NOWAIT);
> -- 
> 2.50.1
> 
> 

