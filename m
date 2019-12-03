Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A7B3B10FB08
	for <lists+dmaengine@lfdr.de>; Tue,  3 Dec 2019 10:48:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726214AbfLCJsC (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 3 Dec 2019 04:48:02 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:50709 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725773AbfLCJsC (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 3 Dec 2019 04:48:02 -0500
Received: from kresse.hi.pengutronix.de ([2001:67c:670:100:1d::2a])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1ic4mb-0003Hm-Py; Tue, 03 Dec 2019 10:47:49 +0100
Message-ID: <9e210702979c45c11d16bf5df97b75863da587d0.camel@pengutronix.de>
Subject: Re: [PATCH v5 1/3] dmaengine: imx-sdma: fix buffer ownership
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Philipp Puschmann <philipp.puschmann@emlix.com>,
        linux-kernel@vger.kernel.org
Cc:     jlu@pengutronix.de, yibin.gong@nxp.com, fugang.duan@nxp.com,
        dan.j.williams@intel.com, vkoul@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, dmaengine@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Date:   Tue, 03 Dec 2019 10:47:48 +0100
In-Reply-To: <20190923135808.815-2-philipp.puschmann@emlix.com>
References: <20190923135808.815-1-philipp.puschmann@emlix.com>
         <20190923135808.815-2-philipp.puschmann@emlix.com>
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

On Mo, 2019-09-23 at 15:58 +0200, Philipp Puschmann wrote:
> BD_DONE flag marks ownership of the buffer. When 1 SDMA owns the
> buffer, when 0 ARM owns it. When processing the buffers in
> sdma_update_channel_loop the ownership of the currently processed
> buffer was set to SDMA again before running the callback function of
> the buffer and while the sdma script may be running in parallel. So
> there was the possibility to get the buffer overwritten by SDMA
> before
> it has been processed by kernel leading to kind of random errors in
> the
> upper layers, e.g. bluetooth.
> 
> Fixes: 1ec1e82f2510 ("dmaengine: Add Freescale i.MX SDMA support")
> Signed-off-by: Philipp Puschmann <philipp.puschmann@emlix.com>

Reviewed-by: Lucas Stach <l.stach@pengutronix.de>

> ---
> 
> Changelog v5:
>  - no changes
> 
> Changelog v4:
>  - fixed the fixes tag
>  
> Changelog v3:
>  - use correct dma_wmb() instead of dma_wb()
>  - add fixes tag
> 
> Changelog v2:
>  - add dma_wb()
>  
>  drivers/dma/imx-sdma.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
> index 9ba74ab7e912..b42281604e54 100644
> --- a/drivers/dma/imx-sdma.c
> +++ b/drivers/dma/imx-sdma.c
> @@ -802,7 +802,6 @@ static void sdma_update_channel_loop(struct
> sdma_channel *sdmac)
>  		*/
>  
>  		desc->chn_real_count = bd->mode.count;
> -		bd->mode.status |= BD_DONE;
>  		bd->mode.count = desc->period_len;
>  		desc->buf_ptail = desc->buf_tail;
>  		desc->buf_tail = (desc->buf_tail + 1) % desc->num_bd;
> @@ -817,6 +816,9 @@ static void sdma_update_channel_loop(struct
> sdma_channel *sdmac)
>  		dmaengine_desc_get_callback_invoke(&desc->vd.tx, NULL);
>  		spin_lock(&sdmac->vc.lock);
>  
> +		dma_wmb();
> +		bd->mode.status |= BD_DONE;
> +
>  		if (error)
>  			sdmac->status = old_status;
>  	}

