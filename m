Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF86A35C280
	for <lists+dmaengine@lfdr.de>; Mon, 12 Apr 2021 12:03:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237949AbhDLJpV (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 12 Apr 2021 05:45:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:56020 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241785AbhDLJjc (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 12 Apr 2021 05:39:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BDEB26120B;
        Mon, 12 Apr 2021 09:39:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618220354;
        bh=aPImZCrgJujvvKf1wVXHwFUAAvYaRgDhpRe+X56AdfI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=INfHcv6K4T5EPreapejD3JkX/41eszO4nsjC/osCjhYV8BjhUV3lHEcemYgEXx7OF
         n7xE7VI+TcsLQDkoN6qJzluyveUoI0/xxQ38xXcBRWQhY4sstGGwVzJLlnkHUg4v6J
         AQqqGaVC4ZB0H9Mvr1uTHgGERU2aQK9Idm/mqgiP0OpBNc58LQ34vXTsbbLeexjU+O
         OiVVKVY/0sjcQ4qQabSh/YYB57GFJRn+sT6++bYN0Z8ZxPY4+zyabRpt0tF+ouPnjf
         eMg+St1PeMyZy4+YagkdsTPL5ss6PjPdX1EpV91wOi/pEuWpNQfbKP9oy4S6BDr6+6
         sEnQ5QHwoLdJQ==
Date:   Mon, 12 Apr 2021 15:09:10 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Robin Gong <yibin.gong@nxp.com>
Cc:     mark.rutland@arm.com, broonie@kernel.org, robh+dt@kernel.org,
        catalin.marinas@arm.com, will.deacon@arm.com, shawnguo@kernel.org,
        festevam@gmail.com, s.hauer@pengutronix.de,
        martin.fuzzey@flowbird.group, u.kleine-koenig@pengutronix.de,
        dan.j.williams@intel.com, matthias.schiffer@ew.tq-group.com,
        frieder.schrempf@kontron.de, m.felsch@pengutronix.de,
        xiaoning.wang@nxp.com, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de,
        dmaengine@vger.kernel.org, linux-imx@nxp.com
Subject: Re: [PATCH v14 12/12] dmaengine: imx-sdma: add terminated list for
 freed descriptor in worker
Message-ID: <YHQVPoQAYVuHL3/S@vkoul-mobl.Dlink>
References: <1617809456-17693-1-git-send-email-yibin.gong@nxp.com>
 <1617809456-17693-13-git-send-email-yibin.gong@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1617809456-17693-13-git-send-email-yibin.gong@nxp.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 07-04-21, 23:30, Robin Gong wrote:
> Add terminated list for keeping descriptor so that it could be freed in
> worker without any potential involving next descriptor raised up before
> this descriptor freed, because vchan_get_all_descriptors get all
> descriptors including the last terminated descriptor and the next
> descriptor, hence, the next descriptor maybe freed unexpectly when it's
> done in worker without this patch.
> https://www.spinics.net/lists/dmaengine/msg23367.html

Sound like you should implement .device_synchronize() and do the actual
work there..?

> 
> Signed-off-by: Robin Gong <yibin.gong@nxp.com>
> Reported-by: Richard Leitner <richard.leitner@skidata.com>
> ---
>  drivers/dma/imx-sdma.c | 17 ++++++++++-------
>  1 file changed, 10 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
> index 9519b41..4174580 100644
> --- a/drivers/dma/imx-sdma.c
> +++ b/drivers/dma/imx-sdma.c
> @@ -381,6 +381,7 @@ struct sdma_channel {
>  	enum dma_status			status;
>  	struct imx_dma_data		data;
>  	struct work_struct		terminate_worker;
> +	struct list_head                terminated;
>  	bool				is_ram_script;
>  };
>  
> @@ -1041,9 +1042,6 @@ static void sdma_channel_terminate_work(struct work_struct *work)
>  {
>  	struct sdma_channel *sdmac = container_of(work, struct sdma_channel,
>  						  terminate_worker);
> -	unsigned long flags;
> -	LIST_HEAD(head);
> -
>  	/*
>  	 * According to NXP R&D team a delay of one BD SDMA cost time
>  	 * (maximum is 1ms) should be added after disable of the channel
> @@ -1052,10 +1050,7 @@ static void sdma_channel_terminate_work(struct work_struct *work)
>  	 */
>  	usleep_range(1000, 2000);
>  
> -	spin_lock_irqsave(&sdmac->vc.lock, flags);
> -	vchan_get_all_descriptors(&sdmac->vc, &head);
> -	spin_unlock_irqrestore(&sdmac->vc.lock, flags);
> -	vchan_dma_desc_free_list(&sdmac->vc, &head);
> +	vchan_dma_desc_free_list(&sdmac->vc, &sdmac->terminated);
>  }
>  
>  static int sdma_terminate_all(struct dma_chan *chan)
> @@ -1069,6 +1064,13 @@ static int sdma_terminate_all(struct dma_chan *chan)
>  
>  	if (sdmac->desc) {
>  		vchan_terminate_vdesc(&sdmac->desc->vd);
> +		/*
> +		 * move out current descriptor into terminated list so that
> +		 * it could be free in sdma_channel_terminate_work alone
> +		 * later without potential involving next descriptor raised
> +		 * up before the last descriptor terminated.
> +		 */
> +		vchan_get_all_descriptors(&sdmac->vc, &sdmac->terminated);
>  		sdmac->desc = NULL;
>  		schedule_work(&sdmac->terminate_worker);
>  	}
> @@ -2075,6 +2077,7 @@ static int sdma_probe(struct platform_device *pdev)
>  
>  		sdmac->channel = i;
>  		sdmac->vc.desc_free = sdma_desc_free;
> +		INIT_LIST_HEAD(&sdmac->terminated);
>  		INIT_WORK(&sdmac->terminate_worker,
>  				sdma_channel_terminate_work);
>  		/*
> -- 
> 2.7.4

-- 
~Vinod
