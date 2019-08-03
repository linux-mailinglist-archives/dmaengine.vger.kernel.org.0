Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 18CDB805DB
	for <lists+dmaengine@lfdr.de>; Sat,  3 Aug 2019 12:44:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388889AbfHCKov (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 3 Aug 2019 06:44:51 -0400
Received: from mailout3.hostsharing.net ([176.9.242.54]:47313 "EHLO
        mailout3.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388809AbfHCKov (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 3 Aug 2019 06:44:51 -0400
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by mailout3.hostsharing.net (Postfix) with ESMTPS id ECC4510340734;
        Sat,  3 Aug 2019 12:44:48 +0200 (CEST)
Received: from localhost (unknown [89.246.108.87])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by h08.hostsharing.net (Postfix) with ESMTPSA id 992D8618F189;
        Sat,  3 Aug 2019 12:44:48 +0200 (CEST)
X-Mailbox-Line: From f2a812b579c0b99d7fadf61a30a6263a9cc19bc4 Mon Sep 17 00:00:00 2001
Message-Id: <f2a812b579c0b99d7fadf61a30a6263a9cc19bc4.1564825752.git.lukas@wunner.de>
In-Reply-To: <cover.1564825752.git.lukas@wunner.de>
References: <cover.1564825752.git.lukas@wunner.de>
From:   Lukas Wunner <lukas@wunner.de>
Date:   Sat, 3 Aug 2019 12:10:00 +0200
Subject: [PATCH 08/10] dmaengine: bcm2835: Document struct bcm2835_dmadev
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

Document the BCM2835 DMA driver's device data structure so that upcoming
commits may add further members with proper kerneldoc.

Tested-by: Nuno Sá <nuno.sa@analog.com>
Signed-off-by: Lukas Wunner <lukas@wunner.de>
Cc: Martin Sperl <kernel@martin.sperl.org>
Cc: Florian Kauer <florian.kauer@koalo.de>
---
 drivers/dma/bcm2835-dma.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/dma/bcm2835-dma.c b/drivers/dma/bcm2835-dma.c
index a65514fcb7f2..14358faf3bff 100644
--- a/drivers/dma/bcm2835-dma.c
+++ b/drivers/dma/bcm2835-dma.c
@@ -37,6 +37,12 @@
 #define BCM2835_DMA_MAX_DMA_CHAN_SUPPORTED 14
 #define BCM2835_DMA_CHAN_NAME_SIZE 8
 
+/**
+ * struct bcm2835_dmadev - BCM2835 DMA controller
+ * @ddev: DMA device
+ * @base: base address of register map
+ * @dma_parms: DMA parameters (to convey 1 GByte max segment size to clients)
+ */
 struct bcm2835_dmadev {
 	struct dma_device ddev;
 	void __iomem *base;
-- 
2.20.1

