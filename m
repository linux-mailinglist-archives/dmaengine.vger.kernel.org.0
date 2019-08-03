Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B19F8805CF
	for <lists+dmaengine@lfdr.de>; Sat,  3 Aug 2019 12:38:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388325AbfHCKih (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 3 Aug 2019 06:38:37 -0400
Received: from mailout2.hostsharing.net ([83.223.78.233]:49753 "EHLO
        mailout2.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727123AbfHCKih (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 3 Aug 2019 06:38:37 -0400
X-Greylist: delayed 593 seconds by postgrey-1.27 at vger.kernel.org; Sat, 03 Aug 2019 06:38:36 EDT
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by mailout2.hostsharing.net (Postfix) with ESMTPS id B366510189B93;
        Sat,  3 Aug 2019 12:28:41 +0200 (CEST)
Received: from localhost (unknown [89.246.108.87])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by h08.hostsharing.net (Postfix) with ESMTPSA id 707BC618EDF5;
        Sat,  3 Aug 2019 12:28:41 +0200 (CEST)
X-Mailbox-Line: From 7b67f8d95154d25b3a360f580f1ca61f83f79a6f Mon Sep 17 00:00:00 2001
Message-Id: <7b67f8d95154d25b3a360f580f1ca61f83f79a6f.1564825752.git.lukas@wunner.de>
In-Reply-To: <cover.1564825752.git.lukas@wunner.de>
References: <cover.1564825752.git.lukas@wunner.de>
From:   Lukas Wunner <lukas@wunner.de>
Date:   Sat, 3 Aug 2019 12:10:00 +0200
Subject: [PATCH 01/10] dmaengine: bcm2835: Allow reusable descriptors
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

The DMA engine API requires DMA drivers to explicitly allow that
descriptors are prepared once and reused multiple times. Only a
single driver makes use of this functionality so far (pxa_dma.c,
to speed up pxa_camera.c).

We're about to add another use case for reusable descriptors in
the BCM2835 SPI driver, so allow that in the BCM2835 DMA driver.

Tested-by: Nuno Sá <nuno.sa@analog.com>
Signed-off-by: Lukas Wunner <lukas@wunner.de>
Cc: Martin Sperl <kernel@martin.sperl.org>
Cc: Florian Kauer <florian.kauer@koalo.de>
Cc: Robert Jarzmik <robert.jarzmik@free.fr>
---
 drivers/dma/bcm2835-dma.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/dma/bcm2835-dma.c b/drivers/dma/bcm2835-dma.c
index 8101ff2f05c1..523c507ad69e 100644
--- a/drivers/dma/bcm2835-dma.c
+++ b/drivers/dma/bcm2835-dma.c
@@ -907,6 +907,7 @@ static int bcm2835_dma_probe(struct platform_device *pdev)
 	od->ddev.directions = BIT(DMA_DEV_TO_MEM) | BIT(DMA_MEM_TO_DEV) |
 			      BIT(DMA_MEM_TO_MEM);
 	od->ddev.residue_granularity = DMA_RESIDUE_GRANULARITY_BURST;
+	od->ddev.descriptor_reuse = true;
 	od->ddev.dev = &pdev->dev;
 	INIT_LIST_HEAD(&od->ddev.channels);
 
-- 
2.20.1

