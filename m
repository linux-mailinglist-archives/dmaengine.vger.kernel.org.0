Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1833B59D75
	for <lists+dmaengine@lfdr.de>; Fri, 28 Jun 2019 16:04:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726770AbfF1OEe (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 28 Jun 2019 10:04:34 -0400
Received: from smtp1.de.adit-jv.com ([93.241.18.167]:37201 "EHLO
        smtp1.de.adit-jv.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726617AbfF1OEd (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 28 Jun 2019 10:04:33 -0400
Received: from localhost (smtp1.de.adit-jv.com [127.0.0.1])
        by smtp1.de.adit-jv.com (Postfix) with ESMTP id 623EA3C00C6;
        Fri, 28 Jun 2019 16:04:31 +0200 (CEST)
Received: from smtp1.de.adit-jv.com ([127.0.0.1])
        by localhost (smtp1.de.adit-jv.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id v0SS_07b2FWL; Fri, 28 Jun 2019 16:04:25 +0200 (CEST)
Received: from HI2EXCH01.adit-jv.com (hi2exch01.adit-jv.com [10.72.92.24])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp1.de.adit-jv.com (Postfix) with ESMTPS id D41973C00BB;
        Fri, 28 Jun 2019 16:04:25 +0200 (CEST)
Received: from vmlxhi-102.adit-jv.com (10.72.93.184) by HI2EXCH01.adit-jv.com
 (10.72.92.24) with Microsoft SMTP Server (TLS) id 14.3.439.0; Fri, 28 Jun
 2019 16:04:25 +0200
Date:   Fri, 28 Jun 2019 16:04:25 +0200
From:   Eugeniu Rosca <erosca@de.adit-jv.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        <linux-serial@vger.kernel.org>,
        <linux-renesas-soc@vger.kernel.org>, <dmaengine@vger.kernel.org>,
        Eugeniu Rosca <erosca@de.adit-jv.com>,
        Eugeniu Rosca <roscaeugeniu@gmail.com>
Subject: Re: [PATCH 2/2] serial: sh-sci: Terminate TX DMA during buffer
 flushing
Message-ID: <20190628140425.GB11231@vmlxhi-102.adit-jv.com>
References: <20190624123540.20629-1-geert+renesas@glider.be>
 <20190624123540.20629-3-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20190624123540.20629-3-geert+renesas@glider.be>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.72.93.184]
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Mon, Jun 24, 2019 at 02:35:40PM +0200, Geert Uytterhoeven wrote:
[..]
> diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
> index d4504daff99263f5..d18c680aa64b3427 100644
> --- a/drivers/tty/serial/sh-sci.c
> +++ b/drivers/tty/serial/sh-sci.c
> @@ -1656,11 +1656,18 @@ static void sci_free_dma(struct uart_port *port)
>  
>  static void sci_flush_buffer(struct uart_port *port)
>  {
> +	struct sci_port *s = to_sci_port(port);
> +
>  	/*
>  	 * In uart_flush_buffer(), the xmit circular buffer has just been
> -	 * cleared, so we have to reset tx_dma_len accordingly.
> +	 * cleared, so we have to reset tx_dma_len accordingly, and stop any
> +	 * pending transfers
>  	 */
> -	to_sci_port(port)->tx_dma_len = 0;
> +	s->tx_dma_len = 0;
> +	if (s->chan_tx) {
> +		dmaengine_terminate_async(s->chan_tx);
> +		s->cookie_tx = -EINVAL;
> +	}

I am seeing a similar solution being employed by other tty/serial
drivers [1]. One major difference is that those drivers make use of
dmaengine_terminate_all(). Since the latter is deprecated starting
with commit [2], the API choice looks reasonable to me.

Reviewed-by: Eugeniu Rosca <erosca@de.adit-jv.com>
Tested-by: Eugeniu Rosca <erosca@de.adit-jv.com>

[1] git grep -W "static void.*flush_buffer" -- drivers/tty/serial/ | grep dmaengine_terminate
drivers/tty/serial/fsl_lpuart.c-		dmaengine_terminate_all(sport->dma_tx_chan);
drivers/tty/serial/imx.c-	dmaengine_terminate_all(sport->dma_chan_tx);
drivers/tty/serial/serial-tegra.c-		dmaengine_terminate_all(tup->tx_dma_chan);

[2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=b36f09c3c441a6
    ("dmaengine: Add transfer termination synchronization support")

-- 
Best Regards,
Eugeniu.
