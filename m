Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D916675203
	for <lists+dmaengine@lfdr.de>; Fri, 20 Jan 2023 11:06:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230478AbjATKGv (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 20 Jan 2023 05:06:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230303AbjATKGu (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 20 Jan 2023 05:06:50 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27D89A258E;
        Fri, 20 Jan 2023 02:06:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1674209208; x=1705745208;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=s8RVOfsWfXmS7vuK9YlhjZHo4/cTdmhqpji15rJG740=;
  b=ERBYlyKn1jXKVcB9EXZ0j+1fBhQ9idCwTWNM+Zmnr60LQ0PwOKxeyb7v
   0/nY0mYXh62sYuOl6Em/xQICSApgDL+tTbS0Uuo5KZNj2VzZRFp7xk/Hh
   8N2YilcB1cusE3+etvWA22VB+7GvTrsQYX8UIv5Q3I+J0hxhS5ouJVF+2
   U2rO0bWIRVUThNxem5bgMlr2ISin4TY6wJmF4j9P1P/l02AfUNk3eauQ5
   2NkBYpAydNspQriK1JKNeGgwPx/Ya88NhWDmurApNVFSjwi83Q5dtMapD
   Z/vkEpaHh0c7jwGi6MmArAw9GzSdEBRvmaoZQVArPyZrOa+N4rw8dkP1P
   w==;
X-IronPort-AV: E=Sophos;i="5.97,231,1669100400"; 
   d="scan'208";a="196675868"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 20 Jan 2023 03:06:47 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 20 Jan 2023 03:06:47 -0700
Received: from microchip1-OptiPlex-9020.microchip.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.16 via Frontend Transport; Fri, 20 Jan 2023 03:06:44 -0700
From:   shravan kumar <shravan.chippa@microchip.com>
To:     <green.wan@sifive.com>, <vkoul@kernel.org>, <palmer@dabbelt.com>,
        <paul.walmsley@sifive.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        <dmaengine@vger.kernel.org>, <shravan.chippa@microchip.com>
Subject: [PATCH v1] dmaengine: sf-pdma: pdma_desc memory leak fix
Date:   Fri, 20 Jan 2023 15:36:23 +0530
Message-ID: <20230120100623.3530634-1-shravan.chippa@microchip.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Shravan Chippa <shravan.chippa@microchip.com>

Commit b2cc5c465c2c ("dmaengine: sf-pdma: Add multithread support for a
DMA channel") changed sf_pdma_prep_dma_memcpy() to unconditionally
allocate a new sf_pdma_desc each time it is called.

The driver previously recycled descs, by checking the in_use flag, only
allocating additional descs if the existing one was in use. This logic
was removed in commit b2cc5c465c2c ("dmaengine: sf-pdma: Add multithread
support for a DMA channel"), but sf_pdma_free_desc() was not changed to
handle the new behaviour.

As a result, each time sf_pdma_prep_dma_memcpy() is called, the previous
descriptor is leaked, over time leading to memory starvation:

  unreferenced object 0xffffffe008447300 (size 192):
  comm "irq/39-mchp_dsc", pid 343, jiffies 4294906910 (age 981.200s)
  hex dump (first 32 bytes):
    00 00 00 ff 00 00 00 00 b8 c1 00 00 00 00 00 00  ................
    00 00 70 08 10 00 00 00 00 00 00 c0 00 00 00 00  ..p.............
  backtrace:
    [<00000000064a04f4>] kmemleak_alloc+0x1e/0x28
    [<00000000018927a7>] kmem_cache_alloc+0x11e/0x178
    [<000000002aea8d16>] sf_pdma_prep_dma_memcpy+0x40/0x112

Add the missing kfree() to sf_pdma_free_desc(), and remove the redundant
in_use flag.

Fixes: b2cc5c465c2c ("dmaengine: sf-pdma: Add multithread support for a DMA channel")
Signed-off-by: Shravan Chippa <shravan.chippa@microchip.com>
---
 drivers/dma/sf-pdma/sf-pdma.c | 3 +--
 drivers/dma/sf-pdma/sf-pdma.h | 1 -
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/dma/sf-pdma/sf-pdma.c b/drivers/dma/sf-pdma/sf-pdma.c
index 6b524eb6bcf3..e578ad556949 100644
--- a/drivers/dma/sf-pdma/sf-pdma.c
+++ b/drivers/dma/sf-pdma/sf-pdma.c
@@ -96,7 +96,6 @@ sf_pdma_prep_dma_memcpy(struct dma_chan *dchan,	dma_addr_t dest, dma_addr_t src,
 	if (!desc)
 		return NULL;
 
-	desc->in_use = true;
 	desc->dirn = DMA_MEM_TO_MEM;
 	desc->async_tx = vchan_tx_prep(&chan->vchan, &desc->vdesc, flags);
 
@@ -290,7 +289,7 @@ static void sf_pdma_free_desc(struct virt_dma_desc *vdesc)
 	struct sf_pdma_desc *desc;
 
 	desc = to_sf_pdma_desc(vdesc);
-	desc->in_use = false;
+	kfree(desc);
 }
 
 static void sf_pdma_donebh_tasklet(struct tasklet_struct *t)
diff --git a/drivers/dma/sf-pdma/sf-pdma.h b/drivers/dma/sf-pdma/sf-pdma.h
index dcb3687bd5da..5c398a83b491 100644
--- a/drivers/dma/sf-pdma/sf-pdma.h
+++ b/drivers/dma/sf-pdma/sf-pdma.h
@@ -78,7 +78,6 @@ struct sf_pdma_desc {
 	u64				src_addr;
 	struct virt_dma_desc		vdesc;
 	struct sf_pdma_chan		*chan;
-	bool				in_use;
 	enum dma_transfer_direction	dirn;
 	struct dma_async_tx_descriptor *async_tx;
 };
-- 
2.34.1

