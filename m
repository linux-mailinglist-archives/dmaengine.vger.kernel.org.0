Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 281DD245C0B
	for <lists+dmaengine@lfdr.de>; Mon, 17 Aug 2020 07:46:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726381AbgHQFpd (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 17 Aug 2020 01:45:33 -0400
Received: from mail2.skidata.com ([91.230.2.91]:36143 "EHLO mail2.skidata.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726308AbgHQFpd (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 17 Aug 2020 01:45:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=skidata.com; i=@skidata.com; q=dns/txt; s=selector1;
  t=1597643132; x=1629179132;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=iq6E0tROTvyWLYPqPO1Jep0gNCBrkGzldGCPeMg+7YQ=;
  b=TiQa2LaC6eg/8+EgVhdWz+/BS136xFBuZa7mM9clCoGr+VaF0NJ81RC6
   l1YY4PERPYIct8aW7qt60fHqYW77KzNLZCkr1RONk1befRqCcXmOQhqst
   rynS6YSA7V4SIMCbyTPi5Hc+Xg+aYA5QZ5Kmv+BvmckHPo2p0j17CMwNo
   ESf+24whxtcLrLALVFu7c3P//l2A0VY5gLtcwZqiGBulWLJIOIu3cZq1k
   LqRRe2KXSgIWwzRZ22Itv976yeYXlp9DnpHVhCY199+vBibkeyI6SYacT
   A4tOFYCCu5SMRN35loVB7RnW23pqNHCFtc/ee+JDyr9dTO3yB7EjntMqI
   g==;
IronPort-SDR: rZkcM47agA66V7rz7feaMdOluzUqk0bpZwPNFBS4nRIuINpiwtoyuu5PvhKvd7GxTCNDYB6kXY
 q+8aPl4488YU/sH1xOfKWdB3CMlyy7Wmb9WhpewAqI8mDDklAMKIou3zPjCur2Svcz1ng1Oj8Z
 Zy7WxGnwP3YJWucu6wpo6YHFvYGa5JHGgsVwTkK/rDs/Q9q8+zXUyPiuiSF72FTDQ+I8JVsk45
 na+58Ifn3fOwiZaehwKqTEjAYKrWjacs9o1T8V1VGA9ce2sOYhvzzUx0Gd/5S3O54kP7NGQAU7
 SbE=
X-IronPort-AV: E=Sophos;i="5.76,322,1592863200"; 
   d="scan'208";a="2642498"
Date:   Mon, 17 Aug 2020 07:38:20 +0200
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
Subject: Re: [PATCH v12 04/12] dmaengine: imx-sdma: remove duplicated
 sdma_load_context
Message-ID: <20200817053820.GB551027@pcleri>
References: <1597161231-32303-1-git-send-email-yibin.gong@nxp.com>
 <1597161231-32303-5-git-send-email-yibin.gong@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1597161231-32303-5-git-send-email-yibin.gong@nxp.com>
X-Originating-IP: [192.168.111.252]
X-ClientProxiedBy: sdex6srv.skidata.net (192.168.111.84) To
 sdex5srv.skidata.net (192.168.111.83)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Tue, Aug 11, 2020 at 11:53:43PM +0800, Robin Gong wrote:
> Since sdma_transfer_init() will do sdma_load_context before any
> sdma transfer, no need once more in sdma_config_channel().
> 
> Signed-off-by: Robin Gong <yibin.gong@nxp.com>
> Acked-by: Vinod Koul <vkoul@kernel.org>

Hi Robin,
thanks for the pointer to this patch.

As you suggested I've tested the two patches on my custom i.MX6DL
board. Therefore please feel free to add:

Tested-by: Richard Leitner <richard.leitner@skidata.com>

regards;rl

> ---
>  drivers/dma/imx-sdma.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
> index d305b80..5411e01e 100644
> --- a/drivers/dma/imx-sdma.c
> +++ b/drivers/dma/imx-sdma.c
> @@ -1137,7 +1137,6 @@ static void sdma_set_watermarklevel_for_p2p(struct sdma_channel *sdmac)
>  static int sdma_config_channel(struct dma_chan *chan)
>  {
>  	struct sdma_channel *sdmac = to_sdma_chan(chan);
> -	int ret;
>  
>  	sdma_disable_channel(chan);
>  
> @@ -1177,9 +1176,7 @@ static int sdma_config_channel(struct dma_chan *chan)
>  		sdmac->watermark_level = 0; /* FIXME: M3_BASE_ADDRESS */
>  	}
>  
> -	ret = sdma_load_context(sdmac);
> -
> -	return ret;
> +	return 0;
>  }
>  
>  static int sdma_set_channel_priority(struct sdma_channel *sdmac,
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
