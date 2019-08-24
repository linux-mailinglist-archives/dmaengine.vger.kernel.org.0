Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D6229BD08
	for <lists+dmaengine@lfdr.de>; Sat, 24 Aug 2019 12:33:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726950AbfHXKdk (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 24 Aug 2019 06:33:40 -0400
Received: from bmailout2.hostsharing.net ([83.223.78.240]:40433 "EHLO
        bmailout2.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725616AbfHXKdj (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 24 Aug 2019 06:33:39 -0400
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout2.hostsharing.net (Postfix) with ESMTPS id 40EC728000DF1;
        Sat, 24 Aug 2019 12:33:37 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 0F24316F35; Sat, 24 Aug 2019 12:33:37 +0200 (CEST)
Date:   Sat, 24 Aug 2019 12:33:36 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Mark Brown <broonie@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Stefan Wahren <wahrenst@gmx.net>, linux-spi@vger.kernel.org,
        dmaengine@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com
Cc:     Eric Anholt <eric@anholt.net>, Nuno Sa <nuno.sa@analog.com>,
        Martin Sperl <kernel@martin.sperl.org>,
        Noralf Tronnes <noralf@tronnes.org>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Florian Kauer <florian.kauer@koalo.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>
Subject: Re: [PATCH 00/10] Raspberry Pi SPI speedups
Message-ID: <20190824103336.splslj4jqihzfi23@wunner.de>
References: <cover.1564825752.git.lukas@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1564825752.git.lukas@wunner.de>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Dear Marc,

to alleviate you of having to add all the Acked-by and Tested-by tags
to this series, I've prepared a "prêt-à-porter" branch complete with
all tags which you can cherry-pick or merge from.

If you decide to instead apply the patches yourself, you can double-check
the result by comparing it to my branch with "git range-diff".

If you have any comments on the series or would like to have anything
changed, please let me know.

Thanks!

----------------------------------------------------------------

The following changes since commit c55be305915974db160ce6472722ff74f45b8d4e:

  spi: spi-fsl-dspi: Use poll mode in case the platform IRQ is missing (2019-08-23 12:01:44 +0100)

are available in the git repository at:

  https://github.com/l1k/linux bcm2835_spi_simplex_v1

for you to fetch changes up to 37ad33d4bee27d9a24f1deffd675e327d1bb899e:

  spi: bcm2835: Speed up RX-only DMA transfers by zero-filling TX FIFO (2019-08-24 11:54:11 +0200)

----------------------------------------------------------------
So far the BCM2835 SPI driver cannot cope with TX-only and RX-only
transfers (rx_buf or tx_buf is NULL) when using DMA:  It relies on
the SPI core to convert them to full-duplex transfers by allocating
and DMA-mapping a dummy rx_buf or tx_buf.  This costs performance.

Resolve by pre-allocating reusable DMA descriptors which cyclically
clear the RX FIFO (for TX-only transfers) or zero-fill the TX FIFO
(for RX-only transfers).  Commit fecf4ba3f248 provides some numbers
for the achieved latency improvement and CPU time reduction with an
SPI Ethernet controller.  SPI displays should see a similar speedup.
I've also made an effort to reduce peripheral and memory bus accesses.
----------------------------------------------------------------
Lukas Wunner (10):
      dmaengine: bcm2835: Allow reusable descriptors
      dmaengine: bcm2835: Allow cyclic transactions without interrupt
      spi: Guarantee cacheline alignment of driver-private data
      spi: bcm2835: Drop dma_pending flag
      spi: bcm2835: Work around DONE bit erratum
      spi: bcm2835: Cache CS register value for ->prepare_message()
      spi: bcm2835: Speed up TX-only DMA transfers by clearing RX FIFO
      dmaengine: bcm2835: Document struct bcm2835_dmadev
      dmaengine: bcm2835: Avoid accessing memory when copying zeroes
      spi: bcm2835: Speed up RX-only DMA transfers by zero-filling TX FIFO

 drivers/dma/bcm2835-dma.c |  38 ++++-
 drivers/spi/spi-bcm2835.c | 408 ++++++++++++++++++++++++++++++++++++++--------
 drivers/spi/spi.c         |  18 +-
 3 files changed, 390 insertions(+), 74 deletions(-)
