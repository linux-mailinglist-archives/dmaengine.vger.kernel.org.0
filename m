Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF7D628D956
	for <lists+dmaengine@lfdr.de>; Wed, 14 Oct 2020 06:39:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729977AbgJNEji (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 14 Oct 2020 00:39:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:43102 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729963AbgJNEji (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 14 Oct 2020 00:39:38 -0400
Received: from localhost (unknown [122.171.171.75])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 37366221FE;
        Wed, 14 Oct 2020 04:39:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602650378;
        bh=1azwGwgJIoAi0xVFIaaiz2gJCf5ZHRzEtaRTH36qKYo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mPj3jGbqbiin6+NFXsI5GaYoTPC7Rw4mzsEpg9uB9hxlJ8lZgVJEszHkaS44OqqV0
         RhhNwhiwpOjzcEc+Z+dZUROgUrY+AE+DK1ysx5jBEOEze+eWO/LBZY2H7WSS1fn19A
         nK4k6hMhnv6NjYjhhFFiaEu+fEEk8OJAiNFL3pGY=
Date:   Wed, 14 Oct 2020 10:09:33 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Surendran K <surendran.k@samsung.com>
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        shaik.ameer@samsung.com, alim.akhtar@samsung.com,
        pankaj.dubey@samsung.com
Subject: Re: [PATCH] DMA: PL330: Remove unreachable code
Message-ID: <20201014043933.GQ2968@vkoul-mobl>
References: <CGME20201013122030epcas5p2e576d5a2ebfaf9df8078e6ee70f3765c@epcas5p2.samsung.com>
 <20201013114713.28754-1-surendran.k@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201013114713.28754-1-surendran.k@samsung.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 13-10-20, 17:17, Surendran K wrote:
> _setup_req(..) never returns negative value.
> Hence the condition ret < 0 is never met

The subsystem is "dmaengine", git log would tell you the tags to use


> 
> Signed-off-by: Surendran K <surendran.k@samsung.com>
> ---
>  drivers/dma/pl330.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/dma/pl330.c b/drivers/dma/pl330.c
> index e9f0101d92fa..8355586c9788 100644
> --- a/drivers/dma/pl330.c
> +++ b/drivers/dma/pl330.c
> @@ -1527,8 +1527,6 @@ static int pl330_submit_req(struct pl330_thread *thrd,
>  
>  	/* First dry run to check if req is acceptable */
>  	ret = _setup_req(pl330, 1, thrd, idx, &xs);
> -	if (ret < 0)
> -		goto xfer_exit;
>  
>  	if (ret > pl330->mcbufsz / 2) {
>  		dev_info(pl330->ddma.dev, "%s:%d Try increasing mcbufsz (%i/%i)\n",
> -- 
> 2.17.1

-- 
~Vinod
