Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DE9B245C0E
	for <lists+dmaengine@lfdr.de>; Mon, 17 Aug 2020 07:46:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726647AbgHQFpg (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 17 Aug 2020 01:45:36 -0400
Received: from mail1.skidata.com ([91.230.2.99]:13562 "EHLO mail1.skidata.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726303AbgHQFpd (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 17 Aug 2020 01:45:33 -0400
X-Greylist: delayed 435 seconds by postgrey-1.27 at vger.kernel.org; Mon, 17 Aug 2020 01:45:30 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=skidata.com; i=@skidata.com; q=dns/txt; s=selector1;
  t=1597643131; x=1629179131;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=VYLBjYz9lx/nrXI3opLlz8j0PHFlXG1/ZEX5YI80V6Y=;
  b=WtYTGKnTmQpZ5x95Mjrtm4Z+2r4cq1cDd4zgMaFbUmYw5ZqfFVAKLzsI
   qFMORePP4Gm3U+CNyiGicy7oL6ogX3Shsjcl+URUA6xGu8mcbahuL4oRU
   fdgjOu+5nNVI7245a8TPs2fM4UieXVIEjfi4AE/b0FdGAqsqe8NYmkJUA
   nthQDLkrZxTZRGIEMZtFqJBToNg7WTfD0bkcCUFGarDQUC0RzjpGkOC7O
   KXoRR04L6AuDM8ODMnRS3mS2OTjVYsB03pJj3UZ4XOhPeDu9QO4hs1gvC
   N/49SAq8YcLIyBj61grb/nqm4tfYDqlxVljsYtJAjXneGA++SmP9ykayO
   Q==;
IronPort-SDR: svI9QV3IU5oopAVv5yamxDgdlocA1iJY3YSUF4EoHghv0pgx7rr8qYaXkKz5Omkxq2uybaSfdj
 1dD7IDxYChlmXsW52gUikLfeYy0fDPtToSUvTzOiSLEDrAr1H5ycWGdiqrHMmlVmzVGFcjGjCn
 vyiYzbUfXj4k21HYamaZ92VvdFf1lutJUyxZ0kD6RwOaFA6yq59RZ3P9gLdmKUd6AbU7Ummw4D
 Y2lkzlC6cjdyZtDG5ddHSKZVBFRj2gbaypEpl+VvtyBmVS+EJKOQQZ0r5NVceKThI+XQuyf8Qn
 3/U=
X-IronPort-AV: E=Sophos;i="5.76,322,1592863200"; 
   d="scan'208";a="26161391"
Date:   Mon, 17 Aug 2020 07:38:13 +0200
From:   Richard Leitner <richard.leitner@skidata.com>
To:     Robin Gong <yibin.gong@nxp.com>
CC:     <mark.rutland@arm.com>, <broonie@kernel.org>, <robh+dt@kernel.org>,
        <catalin.marinas@arm.com>, <vkoul@kernel.org>,
        <will.deacon@arm.com>, <shawnguo@kernel.org>, <festevam@gmail.com>,
        <s.hauer@pengutronix.de>, <martin.fuzzey@flowbird.group>,
        <u.kleine-koenig@pengutronix.de>, <dan.j.williams@intel.com>,
        <matthias.schiffer@ew.tq-group.com>, <frieder.schrempf@kontron.de>,
        <r.schwebel@pengutronix.de>, <linux-spi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <kernel@pengutronix.de>,
        <dmaengine@vger.kernel.org>, <linux-imx@nxp.com>
Subject: Re: [PATCH v12 03/12] Revert "dmaengine: imx-sdma: refine to load
 context only once"
Message-ID: <20200817053813.GA551027@pcleri>
References: <1597161231-32303-1-git-send-email-yibin.gong@nxp.com>
 <1597161231-32303-4-git-send-email-yibin.gong@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1597161231-32303-4-git-send-email-yibin.gong@nxp.com>
X-Originating-IP: [192.168.111.252]
X-ClientProxiedBy: sdex6srv.skidata.net (192.168.111.84) To
 sdex5srv.skidata.net (192.168.111.83)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Tue, Aug 11, 2020 at 11:53:42PM +0800, Robin Gong wrote:
> This reverts commit ad0d92d7ba6aecbe2705907c38ff8d8be4da1e9c, because
> in spi-imx case, burst length may be changed dynamically.
> 
> Signed-off-by: Robin Gong <yibin.gong@nxp.com>
> Acked-by: Sascha Hauer <s.hauer@pengutronix.de>

Hi Robin,
thanks for the pointer to this patch.

As you suggested I've tested the two patches on my custom i.MX6DL
board. Therefore please feel free to add:

Tested-by: Richard Leitner <richard.leitner@skidata.com>

regards;rl

> ---
>  drivers/dma/imx-sdma.c | 8 --------
>  1 file changed, 8 deletions(-)
> 
> diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
> index 270992c..d305b80 100644
> --- a/drivers/dma/imx-sdma.c
> +++ b/drivers/dma/imx-sdma.c
> @@ -377,7 +377,6 @@ struct sdma_channel {
>  	unsigned long			watermark_level;
>  	u32				shp_addr, per_addr;
>  	enum dma_status			status;
> -	bool				context_loaded;
>  	struct imx_dma_data		data;
>  	struct work_struct		terminate_worker;
>  };
> @@ -984,9 +983,6 @@ static int sdma_load_context(struct sdma_channel *sdmac)
>  	int ret;
>  	unsigned long flags;
>  
> -	if (sdmac->context_loaded)
> -		return 0;
> -
>  	if (sdmac->direction == DMA_DEV_TO_MEM)
>  		load_address = sdmac->pc_from_device;
>  	else if (sdmac->direction == DMA_DEV_TO_DEV)
> @@ -1029,8 +1025,6 @@ static int sdma_load_context(struct sdma_channel *sdmac)
>  
>  	spin_unlock_irqrestore(&sdma->channel_0_lock, flags);
>  
> -	sdmac->context_loaded = true;
> -
>  	return ret;
>  }
>  
> @@ -1069,7 +1063,6 @@ static void sdma_channel_terminate_work(struct work_struct *work)
>  	vchan_get_all_descriptors(&sdmac->vc, &head);
>  	spin_unlock_irqrestore(&sdmac->vc.lock, flags);
>  	vchan_dma_desc_free_list(&sdmac->vc, &head);
> -	sdmac->context_loaded = false;
>  }
>  
>  static int sdma_terminate_all(struct dma_chan *chan)
> @@ -1337,7 +1330,6 @@ static void sdma_free_chan_resources(struct dma_chan *chan)
>  
>  	sdmac->event_id0 = 0;
>  	sdmac->event_id1 = 0;
> -	sdmac->context_loaded = false;
>  
>  	sdma_set_channel_priority(sdmac, 0);
>  
> -- 
> 2.7.4
> 
> 

-- 
Richard Leitner
Hardware R&D / Senior Embedded Linux Engineer

SKIDATA | Driving Your Digital Future

SKIDATA GmbH
Untersbergstraße 40 | 5083 Grödig/Salzburg | Austria
[t] +43-6246-888-4245 | [m] +43-664-88616370
[w] www.skidata.com
