Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 057851D06EB
	for <lists+dmaengine@lfdr.de>; Wed, 13 May 2020 08:07:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729159AbgEMGHY (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 13 May 2020 02:07:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726220AbgEMGHY (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 13 May 2020 02:07:24 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09D39C061A0C
        for <dmaengine@vger.kernel.org>; Tue, 12 May 2020 23:07:24 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1jYkWG-0000uB-3T; Wed, 13 May 2020 08:05:28 +0200
Received: from sha by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1jYkWD-0003jr-LK; Wed, 13 May 2020 08:05:25 +0200
Date:   Wed, 13 May 2020 08:05:25 +0200
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     Robin Gong <yibin.gong@nxp.com>
Cc:     vkoul@kernel.org, shawnguo@kernel.org,
        u.kleine-koenig@pengutronix.de, robh+dt@kernel.org,
        festevam@gmail.com, dan.j.williams@intel.com, mark.rutland@arm.com,
        catalin.marinas@arm.com, will.deacon@arm.com,
        l.stach@pengutronix.de, martin.fuzzey@flowbird.group,
        kernel@pengutronix.de, linux-spi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v7 RESEND 03/13] Revert "dmaengine: imx-sdma: fix context
 cache"
Message-ID: <20200513060525.GJ5877@pengutronix.de>
References: <1589218356-17475-1-git-send-email-yibin.gong@nxp.com>
 <1589218356-17475-4-git-send-email-yibin.gong@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1589218356-17475-4-git-send-email-yibin.gong@nxp.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 08:04:32 up 83 days, 13:35, 87 users,  load average: 0.05, 0.22,
 0.17
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: dmaengine@vger.kernel.org
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Tue, May 12, 2020 at 01:32:26AM +0800, Robin Gong wrote:
> This reverts commit d288bddd8374e0a043ac9dde64a1ae6a09411d74, since
> 'context_loaded' finally removed.
> 
> Signed-off-by: Robin Gong <yibin.gong@nxp.com>
> ---
>  drivers/dma/imx-sdma.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
> index 4d4477d..3d4aac9 100644
> --- a/drivers/dma/imx-sdma.c
> +++ b/drivers/dma/imx-sdma.c
> @@ -1338,7 +1338,6 @@ static void sdma_free_chan_resources(struct dma_chan *chan)
>  
>  	sdmac->event_id0 = 0;
>  	sdmac->event_id1 = 0;
> -	sdmac->context_loaded = false;
>  
>  	sdma_set_channel_priority(sdmac, 0);

I think this can safely be folded into the next patch which makes it
more clear what is happening.

Sascha

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
