Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C5E0D5E954
	for <lists+dmaengine@lfdr.de>; Wed,  3 Jul 2019 18:37:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726550AbfGCQhl (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 3 Jul 2019 12:37:41 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:8478 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbfGCQhl (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 3 Jul 2019 12:37:41 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d1cd9d10000>; Wed, 03 Jul 2019 09:37:37 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 03 Jul 2019 09:37:38 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 03 Jul 2019 09:37:38 -0700
Received: from [10.21.132.148] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 3 Jul
 2019 16:37:36 +0000
Subject: Re: [PATCH v4] dmaengine: tegra-apb: Support per-burst residue
 granularity
To:     Dmitry Osipenko <digetx@gmail.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Vinod Koul <vkoul@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Ben Dooks <ben.dooks@codethink.co.uk>
CC:     <dmaengine@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20190703012836.16568-1-digetx@gmail.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <b0a0b110-61c8-ae8b-22a0-3311f70b428a@nvidia.com>
Date:   Wed, 3 Jul 2019 17:37:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190703012836.16568-1-digetx@gmail.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL106.nvidia.com (172.18.146.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1562171857; bh=+hij/D6gVD7l9xuZhS70byu/Uv6XOjg3bl4uM9oJDT8=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=FSF187M8c+wiVdHpa4JRJXMBeHA7V+nYPo8TEmvT2Ppbkmch1h7l76edg1gLKCOf5
         IAoGnrB0mHKjCEqUfK3gARBkkFD2EHCfKhXtHd5mTnWdoe3ruoL3Sa9trX5lkGnzo+
         0dmIAobjC0MxtaOX0a88USkYxnNhBIiaIt44Gn9hwBJ+fq6fCiIOcqEOyM4EEaqko2
         oNiRvb8/makgmb4K0ugZjytIhU7WWlHGtGAgHkjCTjkyhQC8M9oowPG2av1xyGCjcQ
         EdK43Ce2W5Bs1EPgQadGi9MX/uLNQZ3w1003fgIoAerKbphz6PJ59JG/aN/8qhZUyD
         H6s30HkbEIiqQ==
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On 03/07/2019 02:28, Dmitry Osipenko wrote:
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
> Reviewed-by: Jon Hunter <jonathanh@nvidia.com>
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
> 
> Changelog:
> 
> v4: The words_xferred is now also reset on a new iteration of a cyclic
>     transfer by ISR, so that dmaengine_tx_status() won't produce a
>     misleading warning splat on TX status re-checking after a cycle
>     completion when cyclic transfer consists of a single SG.
> 
> v3: Added workaround for a hardware design shortcoming that results
>     in a words counter wraparound before end-of-transfer bit is set
>     in a cyclic mode.
> 
> v2: Addressed review comments made by Jon Hunter to v1. We won't try
>     to get words count if dma_desc is on free list as it will result
>     in a NULL dereference because this case wasn't handled properly.
> 
>     The residual value is now updated properly, avoiding potential
>     integer overflow by adding the "bytes" to the "bytes_transferred"
>     instead of the subtraction.
> 
>  drivers/dma/tegra20-apb-dma.c | 72 +++++++++++++++++++++++++++++++----
>  1 file changed, 65 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/dma/tegra20-apb-dma.c b/drivers/dma/tegra20-apb-dma.c
> index 79e9593815f1..148d136191d7 100644
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
> @@ -638,6 +641,8 @@ static void handle_cont_sngl_cycle_dma_done(struct tegra_dma_channel *tdc,
>  		list_add_tail(&dma_desc->cb_node, &tdc->cb_desc);
>  	dma_desc->cb_count++;
>  
> +	sgreq->words_xferred = 0;
> +
>  	/* If not last req then put at end of pending list */
>  	if (!list_is_last(&sgreq->node, &tdc->pending_sg_req)) {
>  		list_move_tail(&sgreq->node, &tdc->pending_sg_req);
> @@ -797,6 +802,62 @@ static int tegra_dma_terminate_all(struct dma_chan *dc)
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
> +		/*
> +		 * This case shall not ever happen because EOC bit
> +		 * must be set once next cyclic transfer is started.

Should this still be cyclic here?

Cheers
Jon

-- 
nvpublic
