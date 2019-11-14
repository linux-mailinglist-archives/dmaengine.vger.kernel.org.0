Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 19EBFFC056
	for <lists+dmaengine@lfdr.de>; Thu, 14 Nov 2019 07:45:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726098AbfKNGpg (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 14 Nov 2019 01:45:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:37160 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725807AbfKNGpf (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 14 Nov 2019 01:45:35 -0500
Received: from localhost (unknown [223.226.110.181])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5F6E120715;
        Thu, 14 Nov 2019 06:45:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573713935;
        bh=NI0BNW4CQQr9LgH0Ss7MkLNdKC1BPofEObcRVGKZmt4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bqXeNC0DK2IP2Jbg/fJB5IV14pqzVRXIiibVY2ax6OzPt/nNx3u8jEjUnYXiHyFRi
         LJJoi5dih3QXTuvxshKCSXPDKgGTMDaq0RJ/wINppuudc93MHdLusa1tISYkw5YiCM
         tUAOCCa9eTvSR9vyXZRtMWEZV95l6c9DidPLzLWA=
Date:   Thu, 14 Nov 2019 12:15:31 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Pan Bian <bianpan2016@163.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>, dmaengine@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dmaengine: sun6i: Fix use after free
Message-ID: <20191114064514.GO952516@vkoul-mobl>
References: <1573126013-17609-1-git-send-email-bianpan2016@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1573126013-17609-1-git-send-email-bianpan2016@163.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 07-11-19, 19:26, Pan Bian wrote:
> The members in the LLI list is released in an incorrect way. Read and
> store the next member before releasing it to avoid accessing the freed
> memory.
> 
> Fixes: a90e173f3faf ("dmaengine: sun6i: Add cyclic capability")
> 
> Signed-off-by: Pan Bian <bianpan2016@163.com>
> ---
>  drivers/dma/sun6i-dma.c | 20 ++++++++++++++------
>  1 file changed, 14 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/dma/sun6i-dma.c b/drivers/dma/sun6i-dma.c
> index 06cd7f867f7c..096aad7e75bb 100644
> --- a/drivers/dma/sun6i-dma.c
> +++ b/drivers/dma/sun6i-dma.c
> @@ -687,7 +687,7 @@ static struct dma_async_tx_descriptor *sun6i_dma_prep_slave_sg(
>  	struct sun6i_dma_dev *sdev = to_sun6i_dma_dev(chan->device);
>  	struct sun6i_vchan *vchan = to_sun6i_vchan(chan);
>  	struct dma_slave_config *sconfig = &vchan->cfg;
> -	struct sun6i_dma_lli *v_lli, *prev = NULL;
> +	struct sun6i_dma_lli *v_lli, *next, *prev = NULL;
>  	struct sun6i_desc *txd;
>  	struct scatterlist *sg;
>  	dma_addr_t p_lli;
> @@ -752,8 +752,12 @@ static struct dma_async_tx_descriptor *sun6i_dma_prep_slave_sg(
>  	return vchan_tx_prep(&vchan->vc, &txd->vd, flags);
>  
>  err_lli_free:
> -	for (prev = txd->v_lli; prev; prev = prev->v_lli_next)
> -		dma_pool_free(sdev->pool, prev, virt_to_phys(prev));
> +	v_lli = txd->v_lli;
> +	while (v_lli) {
> +		next = v_lli->v_lli_next;
> +		dma_pool_free(sdev->pool, v_lli, virt_to_phys(v_lli));
> +		v_lli = next;

Have you seen this issue, a panic trace? Has some static checker flagged
this?

I see the code *seems* equivalent. The prev is assigned to txd->v_lli,
checked and then code block will be executed and updated. When do you
see the case when we access freed memory?

-- 
~Vinod
