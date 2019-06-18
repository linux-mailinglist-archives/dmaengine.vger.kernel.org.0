Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4EE144ADCE
	for <lists+dmaengine@lfdr.de>; Wed, 19 Jun 2019 00:22:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729982AbfFRWW6 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 18 Jun 2019 18:22:58 -0400
Received: from imap1.codethink.co.uk ([176.9.8.82]:55121 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730176AbfFRWW5 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 18 Jun 2019 18:22:57 -0400
Received: from business-176-094-080-062.static.arcor-ip.net ([176.94.80.62] helo=[172.29.8.33])
        by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
        id 1hdMVC-0006RF-LJ; Tue, 18 Jun 2019 23:22:54 +0100
Subject: Re: [PATCH v1] dmaengine: tegra-apb: Support per-burst residue
 granularity
To:     Dmitry Osipenko <digetx@gmail.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Vinod Koul <vkoul@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     dmaengine@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190613210849.10382-1-digetx@gmail.com>
From:   Ben Dooks <ben.dooks@codethink.co.uk>
Organization: Codethink Limited.
Message-ID: <f2290604-12f4-019b-47e7-4e4e29a433d4@codethink.co.uk>
Date:   Tue, 18 Jun 2019 23:22:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190613210849.10382-1-digetx@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 13/06/2019 22:08, Dmitry Osipenko wrote:
> Tegra's APB DMA engine updates words counter after each transferred burst
> of data, hence it can report transfer's residual with more fidelity which
> may be required in cases like audio playback. In particular this fixes
> audio stuttering during playback in a chromiuim web browser. The patch is
> based on the original work that was made by Ben Dooks [1]. It was tested
> on Tegra20 and Tegra30 devices.
> 
> [1] https://lore.kernel.org/lkml/20190424162348.23692-1-ben.dooks@codethink.co.uk/
> 
> Inspired-by: Ben Dooks <ben.dooks@codethink.co.uk>
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>   drivers/dma/tegra20-apb-dma.c | 35 ++++++++++++++++++++++++++++-------
>   1 file changed, 28 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/dma/tegra20-apb-dma.c b/drivers/dma/tegra20-apb-dma.c
> index 79e9593815f1..c5af8f703548 100644
> --- a/drivers/dma/tegra20-apb-dma.c
> +++ b/drivers/dma/tegra20-apb-dma.c
> @@ -797,12 +797,36 @@ static int tegra_dma_terminate_all(struct dma_chan *dc)
>   	return 0;
>   }
>   
> +static unsigned int tegra_dma_update_residual(struct tegra_dma_channel *tdc,
> +					      struct tegra_dma_sg_req *sg_req,
> +					      struct tegra_dma_desc *dma_desc,
> +					      unsigned int residual)
> +{
> +	unsigned long status, wcount = 0;
> +
> +	if (!list_is_first(&sg_req->node, &tdc->pending_sg_req))
> +		return residual;
> +
> +	if (tdc->tdma->chip_data->support_separate_wcount_reg)
> +		wcount = tdc_read(tdc, TEGRA_APBDMA_CHAN_WORD_TRANSFER);
> +
> +	status = tdc_read(tdc, TEGRA_APBDMA_CHAN_STATUS);
> +
> +	if (!tdc->tdma->chip_data->support_separate_wcount_reg)
> +		wcount = status;
> +
> +	if (status & TEGRA_APBDMA_STATUS_ISE_EOC)
> +		return residual - sg_req->req_len;
> +
> +	return residual - get_current_xferred_count(tdc, sg_req, wcount);
> +}

I am unfortunately nowhere near my notes, so can't completely
review this. I think the complexity of my patch series is due
to an issue with the count being updated before the EOC IRQ
is actually flagged (and most definetly before it gets to the
CPU IRQ handler).

The test system I was using, which i've not really got any
access to at the moment would show these internal inconsistent
states every few hours, however it was moving 48kHz 8ch 16bit
TDM data.

Thanks for looking into this, I am not sure if I am going to
get any time to look into this within the next couple of
months.

>   static enum dma_status tegra_dma_tx_status(struct dma_chan *dc,
>   	dma_cookie_t cookie, struct dma_tx_state *txstate)
>   {
>   	struct tegra_dma_channel *tdc = to_tegra_dma_chan(dc);
> +	struct tegra_dma_sg_req *sg_req = NULL;
>   	struct tegra_dma_desc *dma_desc;
> -	struct tegra_dma_sg_req *sg_req;
>   	enum dma_status ret;
>   	unsigned long flags;
>   	unsigned int residual;
> @@ -838,6 +862,8 @@ static enum dma_status tegra_dma_tx_status(struct dma_chan *dc,
>   		residual = dma_desc->bytes_requested -
>   			   (dma_desc->bytes_transferred %
>   			    dma_desc->bytes_requested);
> +		residual = tegra_dma_update_residual(tdc, sg_req, dma_desc,
> +						     residual);
>   		dma_set_residue(txstate, residual);
>   	}
>   
> @@ -1441,12 +1467,7 @@ static int tegra_dma_probe(struct platform_device *pdev)
>   		BIT(DMA_SLAVE_BUSWIDTH_4_BYTES) |
>   		BIT(DMA_SLAVE_BUSWIDTH_8_BYTES);
>   	tdma->dma_dev.directions = BIT(DMA_DEV_TO_MEM) | BIT(DMA_MEM_TO_DEV);
> -	/*
> -	 * XXX The hardware appears to support
> -	 * DMA_RESIDUE_GRANULARITY_BURST-level reporting, but it's
> -	 * only used by this driver during tegra_dma_terminate_all()
> -	 */
> -	tdma->dma_dev.residue_granularity = DMA_RESIDUE_GRANULARITY_SEGMENT;
> +	tdma->dma_dev.residue_granularity = DMA_RESIDUE_GRANULARITY_BURST;
>   	tdma->dma_dev.device_config = tegra_dma_slave_config;
>   	tdma->dma_dev.device_terminate_all = tegra_dma_terminate_all;
>   	tdma->dma_dev.device_tx_status = tegra_dma_tx_status;
> 


-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius

https://www.codethink.co.uk/privacy.html
