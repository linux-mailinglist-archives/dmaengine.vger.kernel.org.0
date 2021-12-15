Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7712E475729
	for <lists+dmaengine@lfdr.de>; Wed, 15 Dec 2021 12:01:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241870AbhLOLBZ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 15 Dec 2021 06:01:25 -0500
Received: from esa.microchip.iphmx.com ([68.232.153.233]:24908 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233928AbhLOLBY (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 15 Dec 2021 06:01:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1639566084; x=1671102084;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7qVcImxGBTHjFh5448/P7RQSE1s+vXFl/SCN0Q3y0cQ=;
  b=TP7heWgyQ3jxvC5IBc0No5hS/mmhzjgyGDbHJ1cwuWoLTsz2oI45Lwug
   V3xPC5qNosojcm2aIvmHaZQfUhBz5gPbmkR/Mc6wSmJAxN+nLfM+rmSPm
   hmnyTjeR5noFUwixPZhAP7c5cEcmf1ug96D5CoK/R5TWxYoj0eIu/3VXL
   oHOjVlArM7zur0kIL0SNBuWbdIKehwzhWalg2lC8J6dzKzPc4IqrY7O01
   ybaa5xt0Aojsr0fQ1dKfJ5Y/LyAx8SJ3vrNKdKHK0XKRuIhO75JN6xTcf
   hJ8FW455bMJ4QWpjZOfGYEejNAR0scRHTxeQq5SjKgWTwNKAoWBpd8lg4
   w==;
IronPort-SDR: LZPjOc+QbtJc7YRYwDKlCAlUIbmb2qmil+NdK+LW2Kbr9NF/jT+M0HUal27EU+/fJoMiK7IdrA
 9tNZPy1eTSgygCEsN2yfcnO4RPn56aCMyhpmIIDgICAWtA3riX5W4IvlqVCOn94yJyLh0EjXZL
 LZ2zKl/afmRwm6AVmBcWBlII4TqYe0+z28lYXz38FdFc+Tv5m4J2Ta+TuvZpYJ+uk16lhNSVaG
 0Lze1GVFliVh/13fY5KHVhsijoZlKYkgDmMl4WE39dz/SweVvmirt22Oa1/msPJeQ4xrxJxhIh
 Ef/7RTQ3mHRlYNBsBzMDI663
X-IronPort-AV: E=Sophos;i="5.88,207,1635231600"; 
   d="scan'208";a="147304259"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 15 Dec 2021 04:01:23 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Wed, 15 Dec 2021 04:01:22 -0700
Received: from ROB-ULT-M18064N.mchp-main.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Wed, 15 Dec 2021 04:01:20 -0700
From:   Tudor Ambarus <tudor.ambarus@microchip.com>
To:     <vkoul@kernel.org>
CC:     <ludovic.desroches@microchip.com>, <nicolas.ferre@microchip.com>,
        <mripard@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Tudor Ambarus <tudor.ambarus@microchip.com>
Subject: [PATCH v3 01/12] dmaengine: at_xdmac: Don't start transactions at tx_submit level
Date:   Wed, 15 Dec 2021 13:01:04 +0200
Message-ID: <20211215110115.191749-2-tudor.ambarus@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211215110115.191749-1-tudor.ambarus@microchip.com>
References: <20211215110115.191749-1-tudor.ambarus@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

tx_submit is supposed to push the current transaction descriptor to a
pending queue, waiting for issue_pending() to be called. issue_pending()
must start the transfer, not tx_submit(), thus remove
at_xdmac_start_xfer() from at_xdmac_tx_submit(). Clients of at_xdmac that
assume that tx_submit() starts the transfer must be updated and call
dma_async_issue_pending() if they miss to call it (one example is
atmel_serial).

As the at_xdmac_start_xfer() is now called only from
at_xdmac_advance_work() when !at_xdmac_chan_is_enabled(), the
at_xdmac_chan_is_enabled() check is no longer needed in
at_xdmac_start_xfer(), thus remove it.

Fixes: e1f7c9eee707 ("dmaengine: at_xdmac: creation of the atmel eXtended DMA Controller driver")
Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 drivers/dma/at_xdmac.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/dma/at_xdmac.c b/drivers/dma/at_xdmac.c
index e42dede5b243..4ff12b083136 100644
--- a/drivers/dma/at_xdmac.c
+++ b/drivers/dma/at_xdmac.c
@@ -385,9 +385,6 @@ static void at_xdmac_start_xfer(struct at_xdmac_chan *atchan,
 
 	dev_vdbg(chan2dev(&atchan->chan), "%s: desc 0x%p\n", __func__, first);
 
-	if (at_xdmac_chan_is_enabled(atchan))
-		return;
-
 	/* Set transfer as active to not try to start it again. */
 	first->active_xfer = true;
 
@@ -479,9 +476,6 @@ static dma_cookie_t at_xdmac_tx_submit(struct dma_async_tx_descriptor *tx)
 	dev_vdbg(chan2dev(tx->chan), "%s: atchan 0x%p, add desc 0x%p to xfers_list\n",
 		 __func__, atchan, desc);
 	list_add_tail(&desc->xfer_node, &atchan->xfers_list);
-	if (list_is_singular(&atchan->xfers_list))
-		at_xdmac_start_xfer(atchan, desc);
-
 	spin_unlock_irqrestore(&atchan->lock, irqflags);
 	return cookie;
 }
-- 
2.25.1

