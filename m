Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5A879805D9
	for <lists+dmaengine@lfdr.de>; Sat,  3 Aug 2019 12:43:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388848AbfHCKnw (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 3 Aug 2019 06:43:52 -0400
Received: from mailout1.hostsharing.net ([83.223.95.204]:46141 "EHLO
        mailout1.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388809AbfHCKnv (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 3 Aug 2019 06:43:51 -0400
X-Greylist: delayed 471 seconds by postgrey-1.27 at vger.kernel.org; Sat, 03 Aug 2019 06:43:49 EDT
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by mailout1.hostsharing.net (Postfix) with ESMTPS id 0B87C101A7220;
        Sat,  3 Aug 2019 12:35:57 +0200 (CEST)
Received: from localhost (unknown [89.246.108.87])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by h08.hostsharing.net (Postfix) with ESMTPSA id B9C94618F189;
        Sat,  3 Aug 2019 12:35:56 +0200 (CEST)
X-Mailbox-Line: From 69faaeb305582ab7dca65fa08635edfa1a39b3fa Mon Sep 17 00:00:00 2001
Message-Id: <69faaeb305582ab7dca65fa08635edfa1a39b3fa.1564825752.git.lukas@wunner.de>
In-Reply-To: <cover.1564825752.git.lukas@wunner.de>
References: <cover.1564825752.git.lukas@wunner.de>
From:   Lukas Wunner <lukas@wunner.de>
Date:   Sat, 3 Aug 2019 12:10:00 +0200
Subject: [PATCH 03/10] spi: Guarantee cacheline alignment of driver-private
 data
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

__spi_alloc_controller() uses a single allocation to accommodate struct
spi_controller and the driver-private data, but places the latter behind
the former.  This order does not guarantee cacheline alignment of the
driver-private data.  It does guarantee cacheline alignment of struct
spi_controller but the structure doesn't make any use of that property.

Reverse the order.  A forthcoming commit leverages this to grant DMA
access to driver-private data of the BCM2835 SPI master.

An alternative approach would be to round up struct spi_controller to
cacheline size, at the expense of some wasted memory.

Tested-by: Nuno Sá <nuno.sa@analog.com>
Signed-off-by: Lukas Wunner <lukas@wunner.de>
---
 drivers/spi/spi.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 8e83c9567353..8f692f657690 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -2071,9 +2071,11 @@ static inline void acpi_register_spi_devices(struct spi_controller *ctlr) {}
 static void spi_controller_release(struct device *dev)
 {
 	struct spi_controller *ctlr;
+	void *devdata;
 
 	ctlr = container_of(dev, struct spi_controller, dev);
-	kfree(ctlr);
+	devdata = spi_controller_get_devdata(ctlr);
+	kfree(devdata);
 }
 
 static struct class spi_master_class = {
@@ -2187,8 +2189,10 @@ extern struct class spi_slave_class;	/* dummy */
  * __spi_alloc_controller - allocate an SPI master or slave controller
  * @dev: the controller, possibly using the platform_bus
  * @size: how much zeroed driver-private data to allocate; the pointer to this
- *	memory is in the driver_data field of the returned device,
- *	accessible with spi_controller_get_devdata().
+ *	memory is in the driver_data field of the returned device, accessible
+ *	with spi_controller_get_devdata(); the memory is cacheline aligned;
+ *	drivers granting DMA access to portions of their private data need to
+ *	round up @size using ALIGN(size, dma_get_cache_alignment()).
  * @slave: flag indicating whether to allocate an SPI master (false) or SPI
  *	slave (true) controller
  * Context: can sleep
@@ -2210,14 +2214,16 @@ struct spi_controller *__spi_alloc_controller(struct device *dev,
 					      unsigned int size, bool slave)
 {
 	struct spi_controller	*ctlr;
+	void *devdata;
 
 	if (!dev)
 		return NULL;
 
-	ctlr = kzalloc(size + sizeof(*ctlr), GFP_KERNEL);
-	if (!ctlr)
+	devdata = kzalloc(size + sizeof(*ctlr), GFP_KERNEL);
+	if (!devdata)
 		return NULL;
 
+	ctlr = devdata + size;
 	device_initialize(&ctlr->dev);
 	ctlr->bus_num = -1;
 	ctlr->num_chipselect = 1;
@@ -2228,7 +2234,7 @@ struct spi_controller *__spi_alloc_controller(struct device *dev,
 		ctlr->dev.class = &spi_master_class;
 	ctlr->dev.parent = dev;
 	pm_suspend_ignore_children(&ctlr->dev, true);
-	spi_controller_set_devdata(ctlr, &ctlr[1]);
+	spi_controller_set_devdata(ctlr, devdata);
 
 	return ctlr;
 }
-- 
2.20.1

