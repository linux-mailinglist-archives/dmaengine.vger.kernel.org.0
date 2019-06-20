Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4A8134C99A
	for <lists+dmaengine@lfdr.de>; Thu, 20 Jun 2019 10:38:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725925AbfFTIi5 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 20 Jun 2019 04:38:57 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:4459 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725875AbfFTIi5 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 20 Jun 2019 04:38:57 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d0b46200000>; Thu, 20 Jun 2019 01:38:56 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Thu, 20 Jun 2019 01:38:55 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Thu, 20 Jun 2019 01:38:55 -0700
Received: from [10.21.132.148] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 20 Jun
 2019 08:38:53 +0000
Subject: Re: [PATCH v2] dmaengine: tegra-apb: Support per-burst residue
 granularity
To:     Dmitry Osipenko <digetx@gmail.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Vinod Koul <vkoul@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Ben Dooks <ben.dooks@codethink.co.uk>
CC:     <dmaengine@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20190618115035.29250-1-digetx@gmail.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <8f48fcba-df7c-a313-2f84-0fa896e4ccec@nvidia.com>
Date:   Thu, 20 Jun 2019 09:38:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190618115035.29250-1-digetx@gmail.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1561019936; bh=nQvnNwEb/0AS1u5wJ+D2+BiSKwyKhWqsMSEAYqzh9+U=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=lxsxiE9HLYXwpTyKW6c4pa7jfnu0cvdAHB6oruIxyrfLx/XlCxnsCF28w0IWc2OYk
         jyLQpncsUWbcqwVbfA46/jvshwaq//6tkEo7foWL8MLmWEyqDlwxpXmmGuicrJ0GcT
         RKn6s3AJIK9Z8WLA/PADKhUvN9JvUiFV3IVLOuNN+WAicor4EfbuR+XWUW5cYjECmB
         bafYo4iYjRI9iAr+cZ6rmW3PSvqrvgFWV/I8NF8DqFw2mS8XIkZTqal+dU6XSC4ViV
         cL7a+ITD+++IldKTVneKMdkSIKtRiRtc3zSdBAqflRzasGaMfdAbmgDkrKLPobFawg
         Ot95NTTCs3LZg==
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On 18/06/2019 12:50, Dmitry Osipenko wrote:
> Tegra's APB DMA engine updates words counter after each transferred burst
> of data, hence it can report transfer's residual with more fidelity which
> may be required in cases like audio playback. In particular this fixes
> audio stuttering during playback in a chromiuim web browser. The patch is
> based on the original work that was made by Ben Dooks. It was tested on
> Tegra20 and Tegra30 devices.
> 
> Link: https://lore.kernel.org/lkml/20190424162348.23692-1-ben.dooks@codethink.co.uk/
> Inspired-by: Ben Dooks <ben.dooks@codethink.co.uk>
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
> 
> Changelog:
> 
> v2:  Addressed review comments made by Jon Hunter to v1. We won't try
>      to get words count if dma_desc is on free list as it will result
>      in a NULL dereference because this case wasn't handled properly.
> 
>      The residual value is now updated properly, avoiding potential
>      integer overflow by adding the "bytes" to the "bytes_transferred"
>      instead of the subtraction.
> 
>  drivers/dma/tegra20-apb-dma.c | 33 ++++++++++++++++++++++++++-------
>  1 file changed, 26 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/dma/tegra20-apb-dma.c b/drivers/dma/tegra20-apb-dma.c
> index 79e9593815f1..fed18bc46479 100644
> --- a/drivers/dma/tegra20-apb-dma.c
> +++ b/drivers/dma/tegra20-apb-dma.c
> @@ -797,6 +797,28 @@ static int tegra_dma_terminate_all(struct dma_chan *dc)
>  	return 0;
>  }
>  
> +static unsigned int tegra_dma_sg_bytes_xferred(struct tegra_dma_channel *tdc,
> +					       struct tegra_dma_sg_req *sg_req)
> +{
> +	unsigned long status, wcount = 0;
> +
> +	if (!list_is_first(&sg_req->node, &tdc->pending_sg_req))
> +		return 0;
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
> +		return sg_req->req_len;
> +
> +	return get_current_xferred_count(tdc, sg_req, wcount);
> +}
> +
>  static enum dma_status tegra_dma_tx_status(struct dma_chan *dc,
>  	dma_cookie_t cookie, struct dma_tx_state *txstate)
>  {
> @@ -806,6 +828,7 @@ static enum dma_status tegra_dma_tx_status(struct dma_chan *dc,
>  	enum dma_status ret;
>  	unsigned long flags;
>  	unsigned int residual;
> +	unsigned int bytes = 0;
>  
>  	ret = dma_cookie_status(dc, cookie, txstate);
>  	if (ret == DMA_COMPLETE)
> @@ -825,6 +848,7 @@ static enum dma_status tegra_dma_tx_status(struct dma_chan *dc,
>  	list_for_each_entry(sg_req, &tdc->pending_sg_req, node) {
>  		dma_desc = sg_req->dma_desc;
>  		if (dma_desc->txd.cookie == cookie) {
> +			bytes = tegra_dma_sg_bytes_xferred(tdc, sg_req);
>  			ret = dma_desc->dma_status;
>  			goto found;
>  		}
> @@ -836,7 +860,7 @@ static enum dma_status tegra_dma_tx_status(struct dma_chan *dc,
>  found:
>  	if (dma_desc && txstate) {
>  		residual = dma_desc->bytes_requested -
> -			   (dma_desc->bytes_transferred %
> +			   ((dma_desc->bytes_transferred + bytes) %
>  			    dma_desc->bytes_requested);
>  		dma_set_residue(txstate, residual);
>  	}
> @@ -1441,12 +1465,7 @@ static int tegra_dma_probe(struct platform_device *pdev)
>  		BIT(DMA_SLAVE_BUSWIDTH_4_BYTES) |
>  		BIT(DMA_SLAVE_BUSWIDTH_8_BYTES);
>  	tdma->dma_dev.directions = BIT(DMA_DEV_TO_MEM) | BIT(DMA_MEM_TO_DEV);
> -	/*
> -	 * XXX The hardware appears to support
> -	 * DMA_RESIDUE_GRANULARITY_BURST-level reporting, but it's
> -	 * only used by this driver during tegra_dma_terminate_all()
> -	 */
> -	tdma->dma_dev.residue_granularity = DMA_RESIDUE_GRANULARITY_SEGMENT;
> +	tdma->dma_dev.residue_granularity = DMA_RESIDUE_GRANULARITY_BURST;
>  	tdma->dma_dev.device_config = tegra_dma_slave_config;
>  	tdma->dma_dev.device_terminate_all = tegra_dma_terminate_all;
>  	tdma->dma_dev.device_tx_status = tegra_dma_tx_status;
> 

Looks good to me. Thanks for fixing!

Reviewed-by: Jon Hunter <jonathanh@nvidia.com>

Cheers
Jon

-- 
nvpublic
