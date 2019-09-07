Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B59DCAC579
	for <lists+dmaengine@lfdr.de>; Sat,  7 Sep 2019 11:06:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733030AbfIGJGk (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 7 Sep 2019 05:06:40 -0400
Received: from bmailout1.hostsharing.net ([83.223.95.100]:38477 "EHLO
        bmailout1.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728315AbfIGJGk (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 7 Sep 2019 05:06:40 -0400
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout1.hostsharing.net (Postfix) with ESMTPS id 06F003000618E;
        Sat,  7 Sep 2019 11:06:38 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id D2B7DA0C; Sat,  7 Sep 2019 11:06:37 +0200 (CEST)
Date:   Sat, 7 Sep 2019 11:06:37 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        dmaengine@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com
Cc:     Eric Anholt <eric@anholt.net>, Nuno Sa <nuno.sa@analog.com>,
        Martin Sperl <kernel@martin.sperl.org>,
        Noralf Tronnes <noralf@tronnes.org>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Florian Kauer <florian.kauer@koalo.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Vinod Koul <vkoul@kernel.org>, Stefan Wahren <wahrenst@gmx.net>
Subject: Re: [PATCH 00/10] Raspberry Pi SPI speedups
Message-ID: <20190907090637.macdahajrzjepluc@wunner.de>
References: <cover.1564825752.git.lukas@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1564825752.git.lukas@wunner.de>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Dear Mark,

On Sat, Aug 03, 2019 at 12:10:00PM +0200, Lukas Wunner wrote:
> So far the BCM2835 SPI driver cannot cope with TX-only and RX-only
> transfers (rx_buf or tx_buf is NULL) when using DMA:  It relies on
> the SPI core to convert them to full-duplex transfers by allocating
> and DMA-mapping a dummy rx_buf or tx_buf.  This costs performance.
> 
> Resolve by pre-allocating reusable DMA descriptors which cyclically
> clear the RX FIFO (for TX-only transfers) or zero-fill the TX FIFO
> (for RX-only transfers).  Patch [07/10] provides some numbers for
> the achieved latency improvement and CPU time reduction with an
> SPI Ethernet controller.  SPI displays should see a similar speedup.
> I've also made an effort to reduce peripheral and memory bus accesses.

Just a gentle ping, this patch set was posted to the list 5 weeks ago,
has all necessary acks and has been tested successfully by 2 people
besides myself.

Do you have any thoughts on it?  Any objections?

In case the patches no longer apply cleanly I've prepared this branch
based on your for-next branch of Aug 23 from which you can merge if
you prefer that:

https://github.com/l1k/linux/commits/bcm2835_spi_simplex_v1

However I can also repost if necessary.

(PS: Apologies for misspelling your name as "Marc" in my e-mail of Aug 24.)

Thanks,

Lukas

> Lukas Wunner (10):
>   dmaengine: bcm2835: Allow reusable descriptors
>   dmaengine: bcm2835: Allow cyclic transactions without interrupt
>   spi: Guarantee cacheline alignment of driver-private data
>   spi: bcm2835: Drop dma_pending flag
>   spi: bcm2835: Work around DONE bit erratum
>   spi: bcm2835: Cache CS register value for ->prepare_message()
>   spi: bcm2835: Speed up TX-only DMA transfers by clearing RX FIFO
>   dmaengine: bcm2835: Document struct bcm2835_dmadev
>   dmaengine: bcm2835: Avoid accessing memory when copying zeroes
>   spi: bcm2835: Speed up RX-only DMA transfers by zero-filling TX FIFO
> 
>  drivers/dma/bcm2835-dma.c |  38 +++-
>  drivers/spi/spi-bcm2835.c | 408 ++++++++++++++++++++++++++++++++------
>  drivers/spi/spi.c         |  18 +-
>  3 files changed, 390 insertions(+), 74 deletions(-)
> 
> -- 
> 2.20.1
