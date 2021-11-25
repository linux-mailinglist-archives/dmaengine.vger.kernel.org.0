Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4B8945D6AA
	for <lists+dmaengine@lfdr.de>; Thu, 25 Nov 2021 10:02:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353725AbhKYJFw (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 25 Nov 2021 04:05:52 -0500
Received: from esa.microchip.iphmx.com ([68.232.154.123]:24985 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353523AbhKYJDu (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 25 Nov 2021 04:03:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1637830839; x=1669366839;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wegADxIWSHuMAOObITo7ccUCJ8XjO9VrO3nutuF9azU=;
  b=kUw4UQT+kAjL0XlCti/RBnMQViqfgFPNPdcfhDngUacVBnOljnWRm8co
   h+ogLziO5++0V5l8Nh8q3K0zTJOnvfhn/Dq4A8yZjuoQbfbjQsptle7Kd
   UllATOq9hB+/GZAdMWK+BQneMCaKujut44EiEm4SAzpXamtlp/2pIBRJH
   tD1zSktqENbB/kQBI0xrNi07RahD3iUJUX9yMeiAlLGbp06SHC/bE7Eb6
   xatO4r/MaAbr24Jq36qXsn9EP4oIAeohJB2EPVefHxAWe785ePdQ0/3hP
   l01EcEhWngADWvExlfIt4YifmX5oQitOtqMwSdVziNbGjTNqiD1Xj2kkm
   A==;
IronPort-SDR: coeHxv+G7dVW9oV0lE43DmnhXnDqzzmr3cmn6ZJEif15+SwtjIVT1I/ffKpmx0Hn4wQr0+Saum
 5vZ+6ddqNasZQEcLslbMBhfWgP5uUPeUNyql89chGXWPDvjl7VUV36XGcDWBPT736MOQjmEhTm
 f8txXdQkRpTvrC+kSQ0JTV9o0NUOU8VJR5OyVym1JXWET8CB0aTSHHEgrtGdpF9FzMI2tocviK
 xoKmMIJQHsORMORxZQ95xH6X030N29DvWaGHLno+XH990LXVWatlyd5Z9m1cGp2RJiuxvvl7lR
 MwX9O8yFJuvWD4vR5fXBjAK/
X-IronPort-AV: E=Sophos;i="5.87,262,1631602800"; 
   d="scan'208";a="77555990"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 25 Nov 2021 02:00:36 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Thu, 25 Nov 2021 02:00:36 -0700
Received: from ROB-ULT-M18064N.mchp-main.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Thu, 25 Nov 2021 02:00:33 -0700
From:   Tudor Ambarus <tudor.ambarus@microchip.com>
To:     <ludovic.desroches@microchip.com>, <vkoul@kernel.org>,
        <richard.genoud@gmail.com>, <gregkh@linuxfoundation.org>,
        <jirislaby@kernel.org>
CC:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <mripard@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-serial@vger.kernel.org>,
        Tudor Ambarus <tudor.ambarus@microchip.com>
Subject: [PATCH v2 01/13] dmaengine: at_xdmac: Don't start transactions at tx_submit level
Date:   Thu, 25 Nov 2021 11:00:16 +0200
Message-ID: <20211125090028.786832-2-tudor.ambarus@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211125090028.786832-1-tudor.ambarus@microchip.com>
References: <20211125090028.786832-1-tudor.ambarus@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

tx_submit is supposed to push the current transaction descriptor
to a pending queue, waiting for issue_pending() to be called.
issue_pending() must start the transfer, not tx_submit().
As the at_xdmac_start_xfer() is now called only from
at_xdmac_advance_work() when !at_xdmac_chan_is_enabled(),
the at_xdmac_chan_is_enabled() check is no longer needed in
at_xdmac_start_xfer(), thus remove it.

Clients of at_xdmac that assume that tx_submit() starts the transfer
must be updated and call dma_async_issue_pending() if they miss to
call it (one example is atmel_serial).

Fixes: e1f7c9eee707 ("dmaengine: at_xdmac: creation of the atmel eXtended DMA Controller driver")
Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 drivers/dma/at_xdmac.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/dma/at_xdmac.c b/drivers/dma/at_xdmac.c
index 275a76f188ae..ccf796a3b9f3 100644
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

