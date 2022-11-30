Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16F0163D19F
	for <lists+dmaengine@lfdr.de>; Wed, 30 Nov 2022 10:21:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbiK3JU6 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 30 Nov 2022 04:20:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbiK3JU5 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 30 Nov 2022 04:20:57 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59904450B0
        for <dmaengine@vger.kernel.org>; Wed, 30 Nov 2022 01:20:56 -0800 (PST)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1p0JGw-0001OK-KW; Wed, 30 Nov 2022 10:20:54 +0100
Received: from sha by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1p0JGw-0001Xx-6o; Wed, 30 Nov 2022 10:20:54 +0100
Date:   Wed, 30 Nov 2022 10:20:54 +0100
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     Hui Wang <hui.wang@canonical.com>
Cc:     dmaengine@vger.kernel.org, vkoul@kernel.org, shawnguo@kernel.org
Subject: Re: [PATCH v2] dmaengine: imx-sdma: Fix a possible memory leak in
 sdma_transfer_init
Message-ID: <20221130092054.GG29728@pengutronix.de>
References: <20221130090800.102035-1-hui.wang@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221130090800.102035-1-hui.wang@canonical.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: dmaengine@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Wed, Nov 30, 2022 at 05:08:00PM +0800, Hui Wang wrote:
> If the function sdma_load_context() fails, the sdma_desc will be
> freed, but the allocated desc->bd is forgot to be freed.
> 
> We already met the sdma_load_context() failure case and the log as
> below:
> [ 450.699064] imx-sdma 30bd0000.dma-controller: Timeout waiting for CH0 ready
> ...
> 
> In this case, the desc->bd will not be freed without this change.
> 
> Signed-off-by: Hui Wang <hui.wang@canonical.com>
> ---
>  drivers/dma/imx-sdma.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Reviewed-by: Sascha Hauer <s.hauer@pengutronix.de>

Sascha

> 
> diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
> index fbea5f62dd98..b926abe4fa43 100644
> --- a/drivers/dma/imx-sdma.c
> +++ b/drivers/dma/imx-sdma.c
> @@ -1521,10 +1521,12 @@ static struct sdma_desc *sdma_transfer_init(struct sdma_channel *sdmac,
>  		sdma_config_ownership(sdmac, false, true, false);
>  
>  	if (sdma_load_context(sdmac))
> -		goto err_desc_out;
> +		goto err_bd_out;
>  
>  	return desc;
>  
> +err_bd_out:
> +	sdma_free_bd(desc);
>  err_desc_out:
>  	kfree(desc);
>  err_out:
> -- 
> 2.34.1
> 
> 

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
