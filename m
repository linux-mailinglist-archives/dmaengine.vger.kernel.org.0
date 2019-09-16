Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1560DB3C75
	for <lists+dmaengine@lfdr.de>; Mon, 16 Sep 2019 16:22:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388621AbfIPOWY (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 16 Sep 2019 10:22:24 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:60917 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388541AbfIPOWY (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 16 Sep 2019 10:22:24 -0400
Received: from kresse.hi.pengutronix.de ([2001:67c:670:100:1d::2a])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1i9rtQ-0002pr-RC; Mon, 16 Sep 2019 16:22:16 +0200
Message-ID: <2f1f94e9d373378a94ed88fe583f7cbead531875.camel@pengutronix.de>
Subject: Re: [PATCH 2/4] dmaengine: imx-sdma: fix dma freezes
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Philipp Puschmann <philipp.puschmann@emlix.com>,
        linux-kernel@vger.kernel.org
Cc:     linux-serial@vger.kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, jslaby@suse.com, vkoul@kernel.org,
        linux-imx@nxp.com, kernel@pengutronix.de,
        gregkh@linuxfoundation.org, dmaengine@vger.kernel.org,
        dan.j.williams@intel.com, festevam@gmail.com,
        linux-arm-kernel@lists.infradead.org
Date:   Mon, 16 Sep 2019 16:22:15 +0200
In-Reply-To: <20190911144943.21554-3-philipp.puschmann@emlix.com>
References: <20190911144943.21554-1-philipp.puschmann@emlix.com>
         <20190911144943.21554-3-philipp.puschmann@emlix.com>
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
> For some years and since many kernel versions there are reports that the
> RX UART SDMA channel stops working at some point. The workaround was to
> disable DMA for RX. This commit tries to fix the problem itself.
> 
> Due to its license i wasn't able to debug the sdma script itself but it
> somehow leads to blocking the scheduling of the channel script when a
> running sdma script does not find any usable destination buffer to put its
> data into.
> 
> If we detect such a potential case we manually retrigger the sdma script
> for this channel and by this reenable the scipt being run by scheduler.
> 
> As sdmac->desc is constant we can move desc out of the loop.
> 
> Signed-off-by: Philipp Puschmann <philipp.puschmann@emlix.com>
> ---
>  drivers/dma/imx-sdma.c | 22 ++++++++++++++++++----
>  1 file changed, 18 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
> index 1abb14ff394d..6a5a84504858 100644
> --- a/drivers/dma/imx-sdma.c
> +++ b/drivers/dma/imx-sdma.c
> @@ -775,21 +775,23 @@ static void sdma_start_desc(struct sdma_channel *sdmac)
>  static void sdma_update_channel_loop(struct sdma_channel *sdmac)
>  {
>  	struct sdma_buffer_descriptor *bd;
> -	int error = 0;
> -	enum dma_status	old_status = sdmac->status;
> +	struct sdma_desc *desc = sdmac->desc;
> +	int error = 0, cnt = 0;
> +	enum dma_status old_status = sdmac->status;
>  
>  	/*
>  	 * loop mode. Iterate over descriptors, re-setup them and
>  	 * call callback function.
>  	 */
> -	while (sdmac->desc) {
> -		struct sdma_desc *desc = sdmac->desc;
> +	while (desc) {
>  
>  		bd = &desc->bd[desc->buf_tail];
>  
>  		if (bd->mode.status & BD_DONE)
>  			break;
>  
> +		cnt++;
> +
>  		if (bd->mode.status & BD_RROR) {
>  			bd->mode.status &= ~BD_RROR;
>  			sdmac->status = DMA_ERROR;
> @@ -821,6 +823,18 @@ static void sdma_update_channel_loop(struct sdma_channel *sdmac)
>  		if (error)
>  			sdmac->status = old_status;
>  	}
> +
> +	/* In some situations it happens that the sdma stops serving
> +	 * dma interrupt requests. It happens when running dma script
> +	 * does not find any usable destination buffer to put its data into.
> +	 *

This part of the comment is slightly confusing, as what happens is that
the SDMA channel is stopped when there are no free descriptors in the
ring anymore. After the channel is stopped it needs to be kicked back
to life after there are descriptors available again.

But apart from this nitpick the change looks good to me:
Reviewed-by: Lucas Stach <l.stach@pengutronix.de>

Regards,
Lucas

> +	 * While there is no specific error condition we can check for, a
> +	 * necessary condition is that all available buffers for the current
> +	 * channel have been written to by the sdma script. In such a case we
> +	 * will trigger the sdma script manually.
> +	 */
> +	if (cnt >= desc->num_bd)
> +		sdma_enable_channel(sdmac->sdma, sdmac->channel);
>  }
>  
>  static void mxc_sdma_handle_channel_normal(struct sdma_channel *data)

