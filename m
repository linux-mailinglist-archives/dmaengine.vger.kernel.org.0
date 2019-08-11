Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 104E389383
	for <lists+dmaengine@lfdr.de>; Sun, 11 Aug 2019 22:03:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726011AbfHKUDm (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 11 Aug 2019 16:03:42 -0400
Received: from bmailout2.hostsharing.net ([83.223.78.240]:48589 "EHLO
        bmailout2.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725900AbfHKUDm (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 11 Aug 2019 16:03:42 -0400
X-Greylist: delayed 389 seconds by postgrey-1.27 at vger.kernel.org; Sun, 11 Aug 2019 16:03:40 EDT
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout2.hostsharing.net (Postfix) with ESMTPS id 203112800B3C8;
        Sun, 11 Aug 2019 21:57:10 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id E5F5D23EF6F; Sun, 11 Aug 2019 21:57:09 +0200 (CEST)
Date:   Sun, 11 Aug 2019 21:57:09 +0200
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
Subject: Re: [PATCH 05/10] spi: bcm2835: Work around DONE bit erratum
Message-ID: <20190811195709.u5gkllkfxutufvt7@wunner.de>
References: <cover.1564825752.git.lukas@wunner.de>
 <edb004dff4af6106f6bfcb89e1a96391e96eb857.1564825752.git.lukas@wunner.de>
 <35aab039-17a2-ca22-5567-4088c98400f0@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <35aab039-17a2-ca22-5567-4088c98400f0@gmx.net>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Sun, Aug 11, 2019 at 09:45:09PM +0200, Stefan Wahren wrote:
> Am 03.08.19 um 12:10 schrieb Lukas Wunner:
> > Commit 3bd7f6589f67 ("spi: bcm2835: Overcome sglist entry length
> > limitation") amended the BCM2835 SPI driver with support for DMA
> > transfers whose buffers are not aligned to 4 bytes and require more than
> > one sglist entry.
> >
> > When testing this feature with upcoming commits to speed up TX-only and
> > RX-only transfers, I noticed that SPI transmission sometimes breaks.
> > A function introduced by the commit, bcm2835_spi_transfer_prologue(),
> > performs one or two PIO transmissions as a prologue to the actual DMA
> > transmission.  It turns out that the breakage goes away if the DONE bit
> > in the CS register is set when ending such a PIO transmission.
> >
> > The DONE bit signifies emptiness of the TX FIFO.  According to the spec,
> > the bit is of type RO, so writing it should never have any effect.
> > Perhaps the spec is wrong and the bit is actually of type RW1C.
> > E.g. the I2C controller on the BCM2835 does have an RW1C DONE bit which
> > needs to be cleared by the driver.  Another, possibly more likely
> > explanation is that it's a hardware erratum since the issue does not
> > occur consistently.
> >
> > Either way, amend bcm2835_spi_transfer_prologue() to always write the
> > DONE bit.
> >
> > Usually a transmission is ended by bcm2835_spi_reset_hw().  If the
> > transmission was successful, the TX FIFO is empty and thus the DONE bit
> > is set when bcm2835_spi_reset_hw() reads the CS register.  The bit is
> > then written back to the register, so we happen to do the right thing.
> >
> > However if DONE is not set, e.g. because transmission is aborted with
> > a non-empty TX FIFO, the bit won't be written by bcm2835_spi_reset_hw()
> > and it seems possible that transmission might subsequently break.  To be
> > on the safe side, likewise amend bcm2835_spi_reset_hw() to always write
> > the bit.
> 
> has the issue already reported to Raspberry Pi Trading?

You mean to fix such errata in future revisions?

I wouldn't know who to report this to, Roger Thornton or James Adams perhaps?

I'm not sure if the SPI controller isn't just an IP block licensed from
a third party, that might make it difficult to get errata fixed.

Thanks,

Lukas
