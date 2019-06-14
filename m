Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D73646290
	for <lists+dmaengine@lfdr.de>; Fri, 14 Jun 2019 17:21:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725867AbfFNPVZ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 14 Jun 2019 11:21:25 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:13877 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725858AbfFNPVZ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 14 Jun 2019 11:21:25 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d03bb740000>; Fri, 14 Jun 2019 08:21:25 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 14 Jun 2019 08:21:24 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 14 Jun 2019 08:21:24 -0700
Received: from [10.26.11.12] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 14 Jun
 2019 15:21:21 +0000
Subject: Re: [PATCH v1] dmaengine: tegra-apb: Support per-burst residue
 granularity
To:     Dmitry Osipenko <digetx@gmail.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Vinod Koul <vkoul@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Ben Dooks <ben.dooks@codethink.co.uk>
CC:     <dmaengine@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20190613210849.10382-1-digetx@gmail.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <5fbe4374-cc9a-8212-017e-05f4dee64443@nvidia.com>
Date:   Fri, 14 Jun 2019 16:21:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190613210849.10382-1-digetx@gmail.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL108.nvidia.com (172.18.146.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1560525685; bh=ChyGWWSYjmKoWF8tWjEMpyKAPQ9uG6r41B9x6LOa0XI=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=MBEXdHoW3FybXZSsLR7YS39vMA9Sr8hLUPJRtNqRZD2bHVCZovc4kyhoOqquD61gh
         oFZ8rOJeo0d/+9rVSWLC0RbLPi4KY0+Mcu3LWE4rl5A8jFgK348HOzwo/zODKQsIk1
         Ef9qTTnMhQtj5ZK8YMU1NDd/Kqj3IHbPrcZRPk0MW1RYisRFSjHExTAPlxHiPCnfjQ
         Sd1RFs02d9c4gV/rirHM6MoqyLQc6AXuJj8hci7jYBh3hjN3Jonk3V8GdM9CgCBIPV
         kId6Y8pEEW+dLlheKwMOit8ZLIG/ceYxHTM6Oi4mCPYW1ATKNr3078DMmCQLiWtdi4
         9zXthMCEs1C4g==
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
>  drivers/dma/tegra20-apb-dma.c | 35 ++++++++++++++++++++++++++++-------
>  1 file changed, 28 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/dma/tegra20-apb-dma.c b/drivers/dma/tegra20-apb-dma.c
> index 79e9593815f1..c5af8f703548 100644
> --- a/drivers/dma/tegra20-apb-dma.c
> +++ b/drivers/dma/tegra20-apb-dma.c
> @@ -797,12 +797,36 @@ static int tegra_dma_terminate_all(struct dma_chan *dc)
>  	return 0;
>  }
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
> +
>  static enum dma_status tegra_dma_tx_status(struct dma_chan *dc,
>  	dma_cookie_t cookie, struct dma_tx_state *txstate)
>  {
>  	struct tegra_dma_channel *tdc = to_tegra_dma_chan(dc);
> +	struct tegra_dma_sg_req *sg_req = NULL;
>  	struct tegra_dma_desc *dma_desc;
> -	struct tegra_dma_sg_req *sg_req;
>  	enum dma_status ret;
>  	unsigned long flags;
>  	unsigned int residual;
> @@ -838,6 +862,8 @@ static enum dma_status tegra_dma_tx_status(struct dma_chan *dc,
>  		residual = dma_desc->bytes_requested -
>  			   (dma_desc->bytes_transferred %
>  			    dma_desc->bytes_requested);
> +		residual = tegra_dma_update_residual(tdc, sg_req, dma_desc,
> +						     residual);

I had a quick look at this, I am not sure that we want to call
tegra_dma_update_residual() here for cases where the dma_desc is on the
free_dma_desc list. In fact, couldn't this be simplified a bit for case
where the dma_desc is on the free list? In that case I believe that the
residual should always be 0.

Cheers
Jon

-- 
nvpublic
