Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 606588936D
	for <lists+dmaengine@lfdr.de>; Sun, 11 Aug 2019 21:52:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726011AbfHKTwi (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 11 Aug 2019 15:52:38 -0400
Received: from bmailout1.hostsharing.net ([83.223.95.100]:47537 "EHLO
        bmailout1.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725870AbfHKTwi (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 11 Aug 2019 15:52:38 -0400
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout1.hostsharing.net (Postfix) with ESMTPS id 1B83B30000CC1;
        Sun, 11 Aug 2019 21:52:36 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id DB4F2233E81; Sun, 11 Aug 2019 21:52:35 +0200 (CEST)
Date:   Sun, 11 Aug 2019 21:52:35 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Stefan Wahren <wahrenst@gmx.net>
Cc:     Mark Brown <broonie@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        linux-spi@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        Eric Anholt <eric@anholt.net>, Nuno Sa <nuno.sa@analog.com>,
        Martin Sperl <kernel@martin.sperl.org>,
        Noralf Tronnes <noralf@tronnes.org>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Florian Kauer <florian.kauer@koalo.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>
Subject: Re: [PATCH 00/10] Raspberry Pi SPI speedups
Message-ID: <20190811195235.gojfdgubq7zheino@wunner.de>
References: <cover.1564825752.git.lukas@wunner.de>
 <fc10f730-6916-7f24-3185-5bdb39a965c9@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fc10f730-6916-7f24-3185-5bdb39a965c9@gmx.net>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Sun, Aug 11, 2019 at 09:50:17PM +0200, Stefan Wahren wrote:
> Am 03.08.19 um 12:10 schrieb Lukas Wunner:
> > So far the BCM2835 SPI driver cannot cope with TX-only and RX-only
> > transfers (rx_buf or tx_buf is NULL) when using DMA:  It relies on
> > the SPI core to convert them to full-duplex transfers by allocating
> > and DMA-mapping a dummy rx_buf or tx_buf.  This costs performance.
> >
> > Resolve by pre-allocating reusable DMA descriptors which cyclically
> > clear the RX FIFO (for TX-only transfers) or zero-fill the TX FIFO
> > (for RX-only transfers).  Patch [07/10] provides some numbers for
> > the achieved latency improvement and CPU time reduction with an
> > SPI Ethernet controller.  SPI displays should see a similar speedup.
> > I've also made an effort to reduce peripheral and memory bus accesses.
> 
> i know the BCM2711 / Raspberry Pi 4 isn't upstreamed yet, but this
> series hasn't been tested with RPi 4?

No, I only have the CM1 and CM3 at my disposal for testing,
the series seemed to work fine on both.

Thanks,

Lukas
