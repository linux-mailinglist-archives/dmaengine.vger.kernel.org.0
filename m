Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 331C8B3C5A
	for <lists+dmaengine@lfdr.de>; Mon, 16 Sep 2019 16:17:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388590AbfIPORK (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 16 Sep 2019 10:17:10 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:43379 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388589AbfIPORK (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 16 Sep 2019 10:17:10 -0400
Received: from kresse.hi.pengutronix.de ([2001:67c:670:100:1d::2a])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1i9roM-0002Kc-Go; Mon, 16 Sep 2019 16:17:02 +0200
Message-ID: <9bcf315369449a025828410396935b679aae14bf.camel@pengutronix.de>
Subject: Re: [PATCH 1/4] dmaengine: imx-sdma: fix buffer ownership
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Philipp Puschmann <philipp.puschmann@emlix.com>,
        linux-kernel@vger.kernel.org
Cc:     linux-serial@vger.kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, jslaby@suse.com, vkoul@kernel.org,
        linux-imx@nxp.com, kernel@pengutronix.de,
        gregkh@linuxfoundation.org, dmaengine@vger.kernel.org,
        dan.j.williams@intel.com, festevam@gmail.com,
        linux-arm-kernel@lists.infradead.org
Date:   Mon, 16 Sep 2019 16:17:00 +0200
In-Reply-To: <20190911144943.21554-2-philipp.puschmann@emlix.com>
References: <20190911144943.21554-1-philipp.puschmann@emlix.com>
         <20190911144943.21554-2-philipp.puschmann@emlix.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::2a
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: dmaengine@vger.kernel.org
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Mi, 2019-09-11 at 16:49 +0200, Philipp Puschmann wrote:
> BD_DONE flag marks ownership of the buffer. When 1 SDMA owns the buffer,
> when 0 ARM owns it. When processing the buffers in
> sdma_update_channel_loop the ownership of the currently processed buffer
> was set to SDMA again before running the callback function of the the
> buffer and while the sdma script may be running in parallel. So there was
> the possibility to get the buffer overwritten by SDMA before it has been
> processed by kernel leading to kind of random errors in the upper layers,
> e.g. bluetooth.
> 
> It may be further a good idea to make the status struct member volatile or
> access it using writel or similar to rule out that the compiler sets the
> BD_DONE flag before the callback routine has finished.
> 
> Signed-off-by: Philipp Puschmann <philipp.puschmann@emlix.com>
> ---
>  drivers/dma/imx-sdma.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
> index a01f4b5d793c..1abb14ff394d 100644
> --- a/drivers/dma/imx-sdma.c
> +++ b/drivers/dma/imx-sdma.c
> @@ -802,7 +802,6 @@ static void sdma_update_channel_loop(struct sdma_channel *sdmac)
>  		*/
>  
>  		desc->chn_real_count = bd->mode.count;
> -		bd->mode.status |= BD_DONE;
>  		bd->mode.count = desc->period_len;
>  		desc->buf_ptail = desc->buf_tail;
>  		desc->buf_tail = (desc->buf_tail + 1) % desc->num_bd;
> @@ -817,6 +816,8 @@ static void sdma_update_channel_loop(struct sdma_channel *sdmac)
>  		dmaengine_desc_get_callback_invoke(&desc->vd.tx, NULL);
>  		spin_lock(&sdmac->vc.lock);

To address your comment from the second paragraph of the commit message
there should be a dma_wmb() here before changing the status flag.

Regards,
Lucas

> +		bd->mode.status |= BD_DONE;
> +
>  		if (error)
>  			sdmac->status = old_status;
>  	}

