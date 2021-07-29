Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 034F63D9F7C
	for <lists+dmaengine@lfdr.de>; Thu, 29 Jul 2021 10:25:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235072AbhG2IZe (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 29 Jul 2021 04:25:34 -0400
Received: from relmlor2.renesas.com ([210.160.252.172]:58501 "EHLO
        relmlie6.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S234795AbhG2IZd (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 29 Jul 2021 04:25:33 -0400
X-IronPort-AV: E=Sophos;i="5.84,278,1620658800"; 
   d="scan'208";a="89101705"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 29 Jul 2021 17:25:30 +0900
Received: from localhost.localdomain (unknown [10.226.92.2])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 53B144208C40;
        Thu, 29 Jul 2021 17:25:28 +0900 (JST)
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>, dmaengine@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH v5 2/3] dmaengine: Extend the dma_slave_width for 128 bytes
Date:   Thu, 29 Jul 2021 09:25:19 +0100
Message-Id: <20210729082520.26186-3-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210729082520.26186-1-biju.das.jz@bp.renesas.com>
References: <20210729082520.26186-1-biju.das.jz@bp.renesas.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Add DMA_SLAVE_BUSWIDTH_128_BYTES to dma_slave_width for DMA engines
and users to select 128 bytes as bus width.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
v1:-
 * New patch
---
 include/linux/dmaengine.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
index 93c3ca5fdafd..e5c2c9e71bf1 100644
--- a/include/linux/dmaengine.h
+++ b/include/linux/dmaengine.h
@@ -380,6 +380,7 @@ enum dma_slave_buswidth {
 	DMA_SLAVE_BUSWIDTH_16_BYTES = 16,
 	DMA_SLAVE_BUSWIDTH_32_BYTES = 32,
 	DMA_SLAVE_BUSWIDTH_64_BYTES = 64,
+	DMA_SLAVE_BUSWIDTH_128_BYTES = 128,
 };
 
 /**
@@ -398,7 +399,7 @@ enum dma_slave_buswidth {
  * @src_addr_width: this is the width in bytes of the source (RX)
  * register where DMA data shall be read. If the source
  * is memory this may be ignored depending on architecture.
- * Legal values: 1, 2, 3, 4, 8, 16, 32, 64.
+ * Legal values: 1, 2, 3, 4, 8, 16, 32, 64, 128.
  * @dst_addr_width: same as src_addr_width but for destination
  * target (TX) mutatis mutandis.
  * @src_maxburst: the maximum number of words (note: words, as in
-- 
2.17.1

