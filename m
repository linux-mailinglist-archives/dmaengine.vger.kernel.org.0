Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15D0D3C21FC
	for <lists+dmaengine@lfdr.de>; Fri,  9 Jul 2021 11:55:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232059AbhGIJ6j (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 9 Jul 2021 05:58:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231991AbhGIJ6h (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 9 Jul 2021 05:58:37 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C307EC0613E8
        for <dmaengine@vger.kernel.org>; Fri,  9 Jul 2021 02:55:54 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1m1nES-0001nB-OP; Fri, 09 Jul 2021 11:55:40 +0200
Message-ID: <e32fab57681a54cab609f0130b474b2c08c31e5f.camel@pengutronix.de>
Subject: Re: [PATCH v14 12/12] dmaengine: imx-sdma: add terminated list for
 freed descriptor in worker
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Robin Gong <yibin.gong@nxp.com>, vkoul@kernel.org,
        mark.rutland@arm.com, broonie@kernel.org, robh+dt@kernel.org,
        catalin.marinas@arm.com, will.deacon@arm.com, shawnguo@kernel.org,
        festevam@gmail.com, s.hauer@pengutronix.de,
        martin.fuzzey@flowbird.group, u.kleine-koenig@pengutronix.de,
        dan.j.williams@intel.com, matthias.schiffer@ew.tq-group.com,
        frieder.schrempf@kontron.de, m.felsch@pengutronix.de,
        xiaoning.wang@nxp.com
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-imx@nxp.com,
        kernel@pengutronix.de, dmaengine@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Date:   Fri, 09 Jul 2021 11:55:39 +0200
In-Reply-To: <1617809456-17693-13-git-send-email-yibin.gong@nxp.com>
References: <1617809456-17693-1-git-send-email-yibin.gong@nxp.com>
         <1617809456-17693-13-git-send-email-yibin.gong@nxp.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.1 (3.40.1-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: dmaengine@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Am Mittwoch, dem 07.04.2021 um 23:30 +0800 schrieb Robin Gong:
> Add terminated list for keeping descriptor so that it could be freed in
> worker without any potential involving next descriptor raised up before
> this descriptor freed, because vchan_get_all_descriptors get all
> descriptors including the last terminated descriptor and the next
> descriptor, hence, the next descriptor maybe freed unexpectly when it's
> done in worker without this patch.
> https://www.spinics.net/lists/dmaengine/msg23367.html
> 
> Signed-off-by: Robin Gong <yibin.gong@nxp.com>
> Reported-by: Richard Leitner <richard.leitner@skidata.com>

Reviewed-by: Lucas Stach <l.stach@pengutronix.de>

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


