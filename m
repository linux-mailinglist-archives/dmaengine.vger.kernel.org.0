Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82B63475732
	for <lists+dmaengine@lfdr.de>; Wed, 15 Dec 2021 12:01:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241926AbhLOLBk (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 15 Dec 2021 06:01:40 -0500
Received: from esa.microchip.iphmx.com ([68.232.154.123]:16372 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241904AbhLOLBh (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 15 Dec 2021 06:01:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1639566096; x=1671102096;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=AQkjKqLl7OD/SJ7eimyxbgKCIhwnCiF/+RQW769Dfrw=;
  b=RDJzpaYHu8W6yBF72KDStwXeMayMN4UpW1iZuoSfQ70oLyQeyX5i4r3/
   qFEFbJX4avAy7e2eSSwrT1NEoUSwHbQR4+5tgzIH7SNKKAWwHfZoO+xHo
   Wqu9hqtewJqWRyvQWu65t5qrTA4w+2hWMUgrr4lUSp/HwPDF+7mqTAhgr
   4/KveMB7tlR8YUNYjJtGqwORIWax+s+toHsXxguEBkiuVT/c/NfETLfXk
   UsKapSQTnvQRbiw8Hu0pfdyoJQWM1kDlLfbpqswlJMRY7etNqB+lZ8//g
   CGwrn/Y0S4kgA4qiHr/3DwEFqC3TVsYg3kNZ8ijvWjYJ+9YZ01fmowztj
   w==;
IronPort-SDR: IWPwniik5XjRmTKPGMzxA9VRlDdA8LRdxQu6ieEFAgRq1o+ye3q1HuxGh1VrkZFuaFkDrBnr6e
 2rqN2HJ/zok3wNZpHGYcEKm6PTAKzXThiMfGi2ndA1aRnYCjvH5/X2QHu3+U1RkSRbyFyLR9ni
 AWtTYG0vquk5AeEKgc+axKI2JdtZjRNjoRNUfWcye9H670x1eNt+qwHcq4LtQ/TxulnVBRM5lY
 zQKsYcI6K73/qKTEqyjXwozfIfmZndyS2C4Em+IOPjaLb2YOco36IpC6maTQzmbtNMLw1BjOLY
 Pef7TKZM4lmnte+mNmDTaEWP
X-IronPort-AV: E=Sophos;i="5.88,207,1635231600"; 
   d="scan'208";a="139842698"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 15 Dec 2021 04:01:36 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Wed, 15 Dec 2021 04:01:35 -0700
Received: from ROB-ULT-M18064N.mchp-main.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Wed, 15 Dec 2021 04:01:33 -0700
From:   Tudor Ambarus <tudor.ambarus@microchip.com>
To:     <vkoul@kernel.org>
CC:     <ludovic.desroches@microchip.com>, <nicolas.ferre@microchip.com>,
        <mripard@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Tudor Ambarus <tudor.ambarus@microchip.com>
Subject: [PATCH v3 06/12] dmaengine: at_xdmac: Move the free desc to the tail of the desc list
Date:   Wed, 15 Dec 2021 13:01:09 +0200
Message-ID: <20211215110115.191749-7-tudor.ambarus@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211215110115.191749-1-tudor.ambarus@microchip.com>
References: <20211215110115.191749-1-tudor.ambarus@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Move the free desc to the tail of the list, so that the sequence of
descriptors is more track-able in case of debug. One would know which
descriptor should come next and could easier catch concurrency over
descriptors for example. virt-dma uses list_splice_tail_init() as well,
follow the core driver.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 drivers/dma/at_xdmac.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/drivers/dma/at_xdmac.c b/drivers/dma/at_xdmac.c
index d5b37459f906..b6547f1b5645 100644
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

