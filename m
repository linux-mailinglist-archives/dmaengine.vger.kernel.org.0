Return-Path: <dmaengine+bounces-2579-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D95691B867
	for <lists+dmaengine@lfdr.de>; Fri, 28 Jun 2024 09:31:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40AB61F22ADE
	for <lists+dmaengine@lfdr.de>; Fri, 28 Jun 2024 07:31:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A53F13AA51;
	Fri, 28 Jun 2024 07:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pp7W09Jb"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CCA254BD4;
	Fri, 28 Jun 2024 07:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719559902; cv=none; b=XdsbN4JtpvhtjsH1FWALmqBNh1+0n0eGLK5nTOm9U2DN6dms6A1/plMcfyQLEzcZQ47WsJ7iH+HImPggJN16UIw/KNPJySw4eNbkqhaxd086ZaczD6xEFazQZgod0WEhjSis4eEho+BKuYd2oNHsUcjrdt/AFyaz0XP77StwOAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719559902; c=relaxed/simple;
	bh=KWadJWEycDJn9mnW33hPUERovexnNMMEh2BaERDMNlg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fhb1xSnOh2ZStyOVsiY+Z6y7FtyUzGnHgmSxtYh24TgKvfheLUOg1XHFozw7wYRz6rVmw/AH070axCsUh19fqlf2YUjBa430GOztvXt9ooNyU5Ep1CWNQw/pYdHu9r3pnXOsJQiF3sW7h46hdFficWxlnssfP/ix8Iu5YRNImJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pp7W09Jb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E465C116B1;
	Fri, 28 Jun 2024 07:31:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719559901;
	bh=KWadJWEycDJn9mnW33hPUERovexnNMMEh2BaERDMNlg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pp7W09JbAdaZP67OFGIThO5eVticdeiin8hft557ABXV9bysa2nvWOSNqnpjAe1Jg
	 gju2po4CemZTbJiJZFGzHtXMR3160Vf+EV04e4LwuK8EAMhQwu6cT05sLMDtjpiKbT
	 fELnygZXm8+Zb1FLP1xeDt96RoJ7+EZxOptnsU2KS9S8WX9UiUZ1BNXdc+zkOpH4+9
	 cu8z4PBJ1uqMC6+Qbc9UZE6fAOrNtYsOYaCdvvz2zRsJRZNk/1eFipAPrdq3ITcq4M
	 Z2a3Kus1K6HkqqvujizOCmPloTSTAX3EDaLVuka5I/bVtlC52aIsr9237yf72R9G31
	 DCCtxq1cfVoEQ==
Date: Fri, 28 Jun 2024 13:01:37 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Joy Zou <joy.zou@nxp.com>
Cc: Frank.Li@nxp.com, imx@lists.linux.dev, dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/2] dmaengine: fsl-edma: add edma src ID check at
 request channel
Message-ID: <Zn5m2Wadskni-4az@matsya>
References: <20240621104932.4116137-1-joy.zou@nxp.com>
 <20240621104932.4116137-3-joy.zou@nxp.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240621104932.4116137-3-joy.zou@nxp.com>

On 21-06-24, 18:49, Joy Zou wrote:
> Check src ID to detect misuse of same src ID for multiple DMA channels.
> 
> Signed-off-by: Joy Zou <joy.zou@nxp.com>
> ---
>  drivers/dma/fsl-edma-main.c | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> diff --git a/drivers/dma/fsl-edma-main.c b/drivers/dma/fsl-edma-main.c
> index d4f29ece69f5..47939d010e59 100644
> --- a/drivers/dma/fsl-edma-main.c
> +++ b/drivers/dma/fsl-edma-main.c
> @@ -100,6 +100,22 @@ static irqreturn_t fsl_edma_irq_handler(int irq, void *dev_id)
>  	return fsl_edma_err_handler(irq, dev_id);
>  }
>  
> +static bool fsl_edma_srcid_in_use(struct fsl_edma_engine *fsl_edma, u32 srcid)
> +{
> +	struct fsl_edma_chan *fsl_chan;
> +	int i;
> +
> +	for (i = 0; i < fsl_edma->n_chans; i++) {
> +		fsl_chan = &fsl_edma->chans[i];
> +
> +		if (fsl_chan->srcid && srcid == fsl_chan->srcid) {
> +			dev_err(&fsl_chan->pdev->dev, "The srcid is using! Can't use repeatly.");

Better message would be: "The srcid is in use, cant use!"

wdyt?

> +			return true;
> +		}
> +	}
> +	return false;
> +}
> +
>  static struct dma_chan *fsl_edma_xlate(struct of_phandle_args *dma_spec,
>  		struct of_dma *ofdma)
>  {
> @@ -117,6 +133,10 @@ static struct dma_chan *fsl_edma_xlate(struct of_phandle_args *dma_spec,
>  	list_for_each_entry_safe(chan, _chan, &fsl_edma->dma_dev.channels, device_node) {
>  		if (chan->client_count)
>  			continue;
> +
> +		if (fsl_edma_srcid_in_use(fsl_edma, dma_spec->args[1]))
> +			return NULL;
> +
>  		if ((chan->chan_id / chans_per_mux) == dma_spec->args[0]) {
>  			chan = dma_get_slave_channel(chan);
>  			if (chan) {
> @@ -161,6 +181,8 @@ static struct dma_chan *fsl_edma3_xlate(struct of_phandle_args *dma_spec,
>  			continue;
>  
>  		fsl_chan = to_fsl_edma_chan(chan);
> +		if (fsl_edma_srcid_in_use(fsl_edma, dma_spec->args[0]))
> +			return NULL;
>  		i = fsl_chan - fsl_edma->chans;
>  
>  		fsl_chan->priority = dma_spec->args[1];
> -- 
> 2.37.1

-- 
~Vinod

