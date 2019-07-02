Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3C63A5D2DD
	for <lists+dmaengine@lfdr.de>; Tue,  2 Jul 2019 17:29:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726457AbfGBP3U (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 2 Jul 2019 11:29:20 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:14115 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726930AbfGBP3U (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 2 Jul 2019 11:29:20 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d1b784a0002>; Tue, 02 Jul 2019 08:29:14 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 02 Jul 2019 08:29:17 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 02 Jul 2019 08:29:17 -0700
Received: from [10.21.132.148] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 2 Jul
 2019 15:29:15 +0000
Subject: Re: [PATCH v3] dmaengine: tegra-apb: Support per-burst residue
 granularity
To:     Dmitry Osipenko <digetx@gmail.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Vinod Koul <vkoul@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Ben Dooks <ben.dooks@codethink.co.uk>
CC:     <dmaengine@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20190627194728.8948-1-digetx@gmail.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <f60059ec-c9ed-7294-f975-25e71a273f69@nvidia.com>
Date:   Tue, 2 Jul 2019 16:29:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190627194728.8948-1-digetx@gmail.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL108.nvidia.com (172.18.146.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1562081354; bh=x3KM9V9YhmSlG4yMJ8Mw1XHf+gB0G0vidlYB4QwG7aU=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=sG9XQqeb9hZ6qI0FC0XhpB2PaAsgi+Wiv/FhKRMdX7CAvC3tqVXNHwo2HDcMWsFhN
         uxpa31vD0GnnhCMNO0T77wXFjOoFi5hsTqQAMr0kZE4WyGepPbMVD7Q06cTinboOXP
         ThJy4T85o/nNSTPIMBMIFuKEUGI1uqB75vMX8Ig8G8F3a7k+RDW21C5xS8psZ7tte3
         nk85BucH9pmqWFp7gWMUFBs+cmMEe7bZk+mdAd5LObWP4DwG/capxPWzhQpvWxRTzU
         jRqO6IHknA+NWg4VrFAhVoF9rTbK3PqRZ/rhHFz2l/oY8LI0SEuaeI8qvQASL6NiBq
         iyjeJ9hoIt2hQ==
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On 27/06/2019 20:47, Dmitry Osipenko wrote:
> Tegra's APB DMA engine updates words counter after each transferred burst
> of data, hence it can report transfer's residual with more fidelity which
> may be required in cases like audio playback. In particular this fixes
> audio stuttering during playback in a chromium web browser. The patch is
> based on the original work that was made by Ben Dooks and a patch from
> downstream kernel. It was tested on Tegra20 and Tegra30 devices.
> 
> Link: https://lore.kernel.org/lkml/20190424162348.23692-1-ben.dooks@codethink.co.uk/
> Link: https://nv-tegra.nvidia.com/gitweb/?p=linux-4.4.git;a=commit;h=c7bba40c6846fbf3eaad35c4472dcc7d8bbc02e5
> Inspired-by: Ben Dooks <ben.dooks@codethink.co.uk>
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
> 
> Changelog:
> 
> v3:  Added workaround for a hardware design shortcoming that results
>      in a words counter wraparound before end-of-transfer bit is set
>      in a cyclic mode.
> 
> v2:  Addressed review comments made by Jon Hunter to v1. We won't try
>      to get words count if dma_desc is on free list as it will result
>      in a NULL dereference because this case wasn't handled properly.
> 
>      The residual value is now updated properly, avoiding potential
>      integer overflow by adding the "bytes" to the "bytes_transferred"
>      instead of the subtraction.
> 
>  drivers/dma/tegra20-apb-dma.c | 69 +++++++++++++++++++++++++++++++----
>  1 file changed, 62 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/dma/tegra20-apb-dma.c b/drivers/dma/tegra20-apb-dma.c
> index 79e9593815f1..71473eda28ee 100644
> --- a/drivers/dma/tegra20-apb-dma.c
> +++ b/drivers/dma/tegra20-apb-dma.c
> @@ -152,6 +152,7 @@ struct tegra_dma_sg_req {
>  	bool				last_sg;
>  	struct list_head		node;
>  	struct tegra_dma_desc		*dma_desc;
> +	unsigned int			words_xferred;
>  };
>  
>  /*
> @@ -496,6 +497,7 @@ static void tegra_dma_configure_for_next(struct tegra_dma_channel *tdc,
>  	tdc_write(tdc, TEGRA_APBDMA_CHAN_CSR,
>  				nsg_req->ch_regs.csr | TEGRA_APBDMA_CSR_ENB);
>  	nsg_req->configured = true;
> +	nsg_req->words_xferred = 0;
>  
>  	tegra_dma_resume(tdc);
>  }
> @@ -511,6 +513,7 @@ static void tdc_start_head_req(struct tegra_dma_channel *tdc)
>  					typeof(*sg_req), node);
>  	tegra_dma_start(tdc, sg_req);
>  	sg_req->configured = true;
> +	sg_req->words_xferred = 0;
>  	tdc->busy = true;
>  }
>  
> @@ -797,6 +800,61 @@ static int tegra_dma_terminate_all(struct dma_chan *dc)
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
> +	wcount = get_current_xferred_count(tdc, sg_req, wcount);
> +
> +	if (!wcount) {
> +		/*
> +		 * If wcount wasn't ever polled for this SG before, then
> +		 * simply assume that transfer hasn't started yet.
> +		 *
> +		 * Otherwise it's the end of the transfer.
> +		 *
> +		 * The alternative would be to poll the status register
> +		 * until EOC bit is set or wcount goes UP. That's so
> +		 * because EOC bit is getting set only after the last
> +		 * burst's completion and counter is less than the actual
> +		 * transfer size by 4 bytes. The counter value wraps around
> +		 * in a cyclic mode before EOC is set(!), so we can't easily
> +		 * distinguish start of transfer from its end.
> +		 */
> +		if (sg_req->words_xferred)
> +			wcount = sg_req->req_len - 4;
> +
> +	} else if (wcount < sg_req->words_xferred) {

Minor comment, why not ...

	} else if WARN_ON_ONCE(wcount < sg_req->words_xferred) {

Otherwise ...

Reviewed-by: Jon Hunter <jonathanh@nvidia.com>

Cheers
Jon

-- 
nvpublic
