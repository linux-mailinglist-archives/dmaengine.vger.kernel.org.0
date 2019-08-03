Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7F906805B4
	for <lists+dmaengine@lfdr.de>; Sat,  3 Aug 2019 12:27:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388371AbfHCK1l (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 3 Aug 2019 06:27:41 -0400
Received: from mailout3.hostsharing.net ([176.9.242.54]:55409 "EHLO
        mailout3.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388201AbfHCK1l (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 3 Aug 2019 06:27:41 -0400
X-Greylist: delayed 432 seconds by postgrey-1.27 at vger.kernel.org; Sat, 03 Aug 2019 06:27:40 EDT
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by mailout3.hostsharing.net (Postfix) with ESMTPS id 763041033E0D3;
        Sat,  3 Aug 2019 12:20:26 +0200 (CEST)
Received: from localhost (unknown [89.246.108.87])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by h08.hostsharing.net (Postfix) with ESMTPSA id 1BD6A618EDF5;
        Sat,  3 Aug 2019 12:20:26 +0200 (CEST)
X-Mailbox-Line: From fe12893a7521a162001a1f52d2a98f07592c811c Mon Sep 17 00:00:00 2001
Message-Id: <cover.1564825752.git.lukas@wunner.de>
From:   Lukas Wunner <lukas@wunner.de>
Date:   Sat, 3 Aug 2019 12:10:00 +0200
Subject: [PATCH 00/10] Raspberry Pi SPI speedups
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

So far the BCM2835 SPI driver cannot cope with TX-only and RX-only
transfers (rx_buf or tx_buf is NULL) when using DMA:  It relies on
the SPI core to convert them to full-duplex transfers by allocating
and DMA-mapping a dummy rx_buf or tx_buf.  This costs performance.

Resolve by pre-allocating reusable DMA descriptors which cyclically
clear the RX FIFO (for TX-only transfers) or zero-fill the TX FIFO
(for RX-only transfers).  Patch [07/10] provides some numbers for
the achieved latency improvement and CPU time reduction with an
SPI Ethernet controller.  SPI displays should see a similar speedup.
I've also made an effort to reduce peripheral and memory bus accesses.

The series is meant to be applied on top of broonie/for-next.
It can be applied to Linus' current tree if commit
8d8bef503658 ("spi: bcm2835: Fix 3-wire mode if DMA is enabled")
is cherry-picked from broonie's repo beforehand.

Please review and test.  Thank you.

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

 drivers/dma/bcm2835-dma.c |  38 +++-
 drivers/spi/spi-bcm2835.c | 408 ++++++++++++++++++++++++++++++++------
 drivers/spi/spi.c         |  18 +-
 3 files changed, 390 insertions(+), 74 deletions(-)

-- 
2.20.1

