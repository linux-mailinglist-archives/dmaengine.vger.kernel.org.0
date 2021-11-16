Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42832453047
	for <lists+dmaengine@lfdr.de>; Tue, 16 Nov 2021 12:21:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234943AbhKPLYg (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 16 Nov 2021 06:24:36 -0500
Received: from esa.microchip.iphmx.com ([68.232.154.123]:9426 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234935AbhKPLYJ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 16 Nov 2021 06:24:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1637061673; x=1668597673;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nuxqXU7uniwAlyc6jwMoADsVym2af+0HTfirATPA/GM=;
  b=YBFyF7yxYb3gVywzh2QsgfE++Xs8g2pofXks4p8HHDH5+pRDplN2xohu
   xOINff+NSuOJSsrHTnyjTk8areoKYHUo9QO0FnRzjR4gNgAATYMnMjwHz
   YR2kQUauIExV0XUxxzOD14TDu6Rb9LjuIjQ8TeYxudTBWcBN3xCjgXpK7
   7Ibfo9MgSBY0ern1eIHMEBT5Mjh2dlqocxfOLWsUs6ebfFwWkNScXRU5z
   S7KcQKEFj7waSCwzoyqykW9mUqy3C9KazLGdTGBJwIIUFc+9DdxoOBMU/
   n9vIWXxeGlOaY9Sq7lCmMxUc4kyfCrTsIAYthmQEqH+r16cYdwFfQ7F4k
   Q==;
IronPort-SDR: nYmFBRiKC1haK3E1yCJFyEOWjdqELDKd7e+MEJJXZ11YKZTRoOv2116NmR9droqPzBC6kS0vy4
 TUHmh2jqVC5fWh2zFZoBUtOY3tg/4k4TxCX/5T+DuNIuYPpWHs4lCIgdNnnU5U8NVbM/7cVB2G
 BKNIeQD+nsIZ/nQjlSN/CFTCBGb41LhJUd43ZTcsSh2ARC0XPjgiCBBJx+4Pp1cPDi9Uelt23c
 0xtLNwQojK4KSwLxh0CUXh+4WQYfPjnnt8WpN0QQY3SggjCpBTfMyGxsT39L8458KLAgHl4JnG
 orimeoQwmXIHKN9cwT9xvV/U
X-IronPort-AV: E=Sophos;i="5.87,239,1631602800"; 
   d="scan'208";a="139278003"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 16 Nov 2021 04:21:11 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Tue, 16 Nov 2021 04:21:11 -0700
Received: from ROB-ULT-M18064N.mchp-main.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Tue, 16 Nov 2021 04:21:07 -0700
From:   Tudor Ambarus <tudor.ambarus@microchip.com>
To:     <ludovic.desroches@microchip.com>, <vkoul@kernel.org>,
        <richard.genoud@gmail.com>, <gregkh@linuxfoundation.org>,
        <jirislaby@kernel.org>
CC:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <mripard@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-serial@vger.kernel.org>,
        Tudor Ambarus <tudor.ambarus@microchip.com>
Subject: [PATCH 08/13] dmaengine: at_xdmac: Move the free desc to the tail of the desc list
Date:   Tue, 16 Nov 2021 13:20:31 +0200
Message-ID: <20211116112036.96349-9-tudor.ambarus@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211116112036.96349-1-tudor.ambarus@microchip.com>
References: <20211116112036.96349-1-tudor.ambarus@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

So that we don't use the same desc over and over again.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 drivers/dma/at_xdmac.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/drivers/dma/at_xdmac.c b/drivers/dma/at_xdmac.c
index 2cc9af222681..8804a86a9bcc 100644
--- a/drivers/dma/at_xdmac.c
+++ b/drivers/dma/at_xdmac.c
@@ -729,7 +729,8 @@ at_xdmac_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
 		if (!desc) {
 			dev_err(chan2dev(chan), "can't get descriptor\n");
 			if (first)
-				list_splice_init(&first->descs_list, &atchan->free_descs_list);
+				list_splice_tail_init(&first->descs_list,
+						      &atchan->free_descs_list);
 			goto spin_unlock;
 		}
 
@@ -817,7 +818,8 @@ at_xdmac_prep_dma_cyclic(struct dma_chan *chan, dma_addr_t buf_addr,
 		if (!desc) {
 			dev_err(chan2dev(chan), "can't get descriptor\n");
 			if (first)
-				list_splice_init(&first->descs_list, &atchan->free_descs_list);
+				list_splice_tail_init(&first->descs_list,
+						      &atchan->free_descs_list);
 			spin_unlock_irqrestore(&atchan->lock, irqflags);
 			return NULL;
 		}
@@ -1051,8 +1053,8 @@ at_xdmac_prep_interleaved(struct dma_chan *chan,
 							       src_addr, dst_addr,
 							       xt, chunk);
 			if (!desc) {
-				list_splice_init(&first->descs_list,
-						 &atchan->free_descs_list);
+				list_splice_tail_init(&first->descs_list,
+						      &atchan->free_descs_list);
 				return NULL;
 			}
 
@@ -1132,7 +1134,8 @@ at_xdmac_prep_dma_memcpy(struct dma_chan *chan, dma_addr_t dest, dma_addr_t src,
 		if (!desc) {
 			dev_err(chan2dev(chan), "can't get descriptor\n");
 			if (first)
-				list_splice_init(&first->descs_list, &atchan->free_descs_list);
+				list_splice_tail_init(&first->descs_list,
+						      &atchan->free_descs_list);
 			return NULL;
 		}
 
@@ -1308,8 +1311,8 @@ at_xdmac_prep_dma_memset_sg(struct dma_chan *chan, struct scatterlist *sgl,
 						   sg_dma_len(sg),
 						   value);
 		if (!desc && first)
-			list_splice_init(&first->descs_list,
-					 &atchan->free_descs_list);
+			list_splice_tail_init(&first->descs_list,
+					      &atchan->free_descs_list);
 
 		if (!first)
 			first = desc;
@@ -1701,7 +1704,8 @@ static void at_xdmac_tasklet(struct tasklet_struct *t)
 
 		spin_lock_irq(&atchan->lock);
 		/* Move the xfer descriptors into the free descriptors list. */
-		list_splice_init(&desc->descs_list, &atchan->free_descs_list);
+		list_splice_tail_init(&desc->descs_list,
+				      &atchan->free_descs_list);
 		at_xdmac_advance_work(atchan);
 		spin_unlock_irq(&atchan->lock);
 	}
@@ -1850,7 +1854,8 @@ static int at_xdmac_device_terminate_all(struct dma_chan *chan)
 	/* Cancel all pending transfers. */
 	list_for_each_entry_safe(desc, _desc, &atchan->xfers_list, xfer_node) {
 		list_del(&desc->xfer_node);
-		list_splice_init(&desc->descs_list, &atchan->free_descs_list);
+		list_splice_tail_init(&desc->descs_list,
+				      &atchan->free_descs_list);
 	}
 
 	clear_bit(AT_XDMAC_CHAN_IS_PAUSED, &atchan->status);
-- 
2.25.1

