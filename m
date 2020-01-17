Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0F552140DDD
	for <lists+dmaengine@lfdr.de>; Fri, 17 Jan 2020 16:29:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729015AbgAQP3l (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 17 Jan 2020 10:29:41 -0500
Received: from michel.telenet-ops.be ([195.130.137.88]:35878 "EHLO
        michel.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728816AbgAQP3l (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 17 Jan 2020 10:29:41 -0500
Received: from ramsan ([84.195.182.253])
        by michel.telenet-ops.be with bizsmtp
        id rTVe210065USYZQ06TVehv; Fri, 17 Jan 2020 16:29:38 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1isTZ4-0002FG-07; Fri, 17 Jan 2020 16:29:38 +0100
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1isTZ3-00087j-VF; Fri, 17 Jan 2020 16:29:37 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Matt Porter <mporter@konsulko.com>,
        Arnd Bergmann <arnd@arndb.de>, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 3/3] dmaengine: Move dma_get_{,any_}slave_channel() to private dmaengine.h
Date:   Fri, 17 Jan 2020 16:29:33 +0100
Message-Id: <20200117152933.31175-4-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200117152933.31175-1-geert+renesas@glider.be>
References: <20200117152933.31175-1-geert+renesas@glider.be>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The functions dma_get_slave_channel() and dma_get_any_slave_channel()
are called from DMA engine drivers only.  Hence move their declarations
from the public header file <linux/dmaengine.h> to the private header
file drivers/dma/dmaengine.h.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/dma/dmaengine.h   | 3 +++
 drivers/dma/of-dma.c      | 2 ++
 include/linux/dmaengine.h | 2 --
 3 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/dmaengine.h b/drivers/dma/dmaengine.h
index 501c0b063f852d9a..488c8a5cbd3b1a4a 100644
--- a/drivers/dma/dmaengine.h
+++ b/drivers/dma/dmaengine.h
@@ -171,4 +171,7 @@ dmaengine_desc_callback_valid(struct dmaengine_desc_callback *cb)
 	return (cb->callback) ? true : false;
 }
 
+struct dma_chan *dma_get_slave_channel(struct dma_chan *chan);
+struct dma_chan *dma_get_any_slave_channel(struct dma_device *device);
+
 #endif
diff --git a/drivers/dma/of-dma.c b/drivers/dma/of-dma.c
index c2d779daa4b51ac8..b2c2b5e8093cf0d7 100644
--- a/drivers/dma/of-dma.c
+++ b/drivers/dma/of-dma.c
@@ -15,6 +15,8 @@
 #include <linux/of.h>
 #include <linux/of_dma.h>
 
+#include "dmaengine.h"
+
 static LIST_HEAD(of_dma_list);
 static DEFINE_MUTEX(of_dma_lock);
 
diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
index 8318645ddc1289c9..2cd1d6d7ef0fcce5 100644
--- a/include/linux/dmaengine.h
+++ b/include/linux/dmaengine.h
@@ -1411,8 +1411,6 @@ int dma_async_device_register(struct dma_device *device);
 int dmaenginem_async_device_register(struct dma_device *device);
 void dma_async_device_unregister(struct dma_device *device);
 void dma_run_dependencies(struct dma_async_tx_descriptor *tx);
-struct dma_chan *dma_get_slave_channel(struct dma_chan *chan);
-struct dma_chan *dma_get_any_slave_channel(struct dma_device *device);
 #define dma_request_channel(mask, x, y) \
 	__dma_request_channel(&(mask), x, y, NULL)
 
-- 
2.17.1

