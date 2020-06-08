Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8378E1F13E6
	for <lists+dmaengine@lfdr.de>; Mon,  8 Jun 2020 09:49:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729078AbgFHHtw (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 8 Jun 2020 03:49:52 -0400
Received: from lucky1.263xmail.com ([211.157.147.134]:44848 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729008AbgFHHtq (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 8 Jun 2020 03:49:46 -0400
Received: from localhost (unknown [192.168.167.16])
        by lucky1.263xmail.com (Postfix) with ESMTP id 0965EB9497;
        Mon,  8 Jun 2020 15:49:39 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-ABS-CHECKED: 0
Received: from localhost.localdomain (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P760T139944219621120S1591602577688290_;
        Mon, 08 Jun 2020 15:49:40 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <30efeeb53ac81d42f22810353786f083>
X-RL-SENDER: sugar.zhang@rock-chips.com
X-SENDER: zxg@rock-chips.com
X-LOGIN-NAME: sugar.zhang@rock-chips.com
X-FST-TO: vkoul@kernel.org
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
X-System-Flag: 0
From:   Sugar Zhang <sugar.zhang@rock-chips.com>
To:     Vinod Koul <vkoul@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc:     linux-rockchip@lists.infradead.org,
        Sugar Zhang <sugar.zhang@rock-chips.com>,
        Dan Williams <dan.j.williams@intel.com>,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 01/13] dmaengine: pl330: Remove the burst limit for quirk 'NO-FLUSHP'
Date:   Mon,  8 Jun 2020 15:49:15 +0800
Message-Id: <1591602567-43788-2-git-send-email-sugar.zhang@rock-chips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1591602567-43788-1-git-send-email-sugar.zhang@rock-chips.com>
References: <1591602567-43788-1-git-send-email-sugar.zhang@rock-chips.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

There is no reason to limit the performance on the 'NO-FLUSHP' SoCs,
cuz these platforms are just that the 'FLUSHP' instruction is broken.
so, remove the limit to improve the efficiency.

Signed-off-by: Sugar Zhang <sugar.zhang@rock-chips.com>
---

 drivers/dma/pl330.c | 34 ++++++++++++++++++++++------------
 1 file changed, 22 insertions(+), 12 deletions(-)

diff --git a/drivers/dma/pl330.c b/drivers/dma/pl330.c
index 6a158ee..ff0a91f 100644
--- a/drivers/dma/pl330.c
+++ b/drivers/dma/pl330.c
@@ -1183,9 +1183,6 @@ static inline int _ldst_peripheral(struct pl330_dmac *pl330,
 {
 	int off = 0;
 
-	if (pl330->quirks & PL330_QUIRK_BROKEN_NO_FLUSHP)
-		cond = BURST;
-
 	/*
 	 * do FLUSHP at beginning to clear any stale dma requests before the
 	 * first WFP.
@@ -1231,8 +1228,9 @@ static int _bursts(struct pl330_dmac *pl330, unsigned dry_run, u8 buf[],
 }
 
 /*
- * transfer dregs with single transfers to peripheral, or a reduced size burst
- * for mem-to-mem.
+ * only the unaligned bursts transfers have the dregs.
+ * transfer dregs with a reduced size burst to peripheral,
+ * or a reduced size burst for mem-to-mem.
  */
 static int _dregs(struct pl330_dmac *pl330, unsigned int dry_run, u8 buf[],
 		const struct _xfer_spec *pxs, int transfer_length)
@@ -1247,8 +1245,23 @@ static int _dregs(struct pl330_dmac *pl330, unsigned int dry_run, u8 buf[],
 	case DMA_MEM_TO_DEV:
 		/* fall through */
 	case DMA_DEV_TO_MEM:
-		off += _ldst_peripheral(pl330, dry_run, &buf[off], pxs,
-			transfer_length, SINGLE);
+		/*
+		 * dregs_len = (total bytes - BURST_TO_BYTE(bursts, ccr)) /
+		 *             BRST_SIZE(ccr)
+		 * the dregs len must be smaller than burst len,
+		 * so, for higher efficiency, we can modify CCR
+		 * to use a reduced size burst len for the dregs.
+		 */
+		dregs_ccr = pxs->ccr;
+		dregs_ccr &= ~((0xf << CC_SRCBRSTLEN_SHFT) |
+			(0xf << CC_DSTBRSTLEN_SHFT));
+		dregs_ccr |= (((transfer_length - 1) & 0xf) <<
+			CC_SRCBRSTLEN_SHFT);
+		dregs_ccr |= (((transfer_length - 1) & 0xf) <<
+			CC_DSTBRSTLEN_SHFT);
+		off += _emit_MOV(dry_run, &buf[off], CCR, dregs_ccr);
+		off += _ldst_peripheral(pl330, dry_run, &buf[off], pxs, 1,
+					BURST);
 		break;
 
 	case DMA_MEM_TO_MEM:
@@ -2221,9 +2234,7 @@ static bool pl330_prep_slave_fifo(struct dma_pl330_chan *pch,
 
 static int fixup_burst_len(int max_burst_len, int quirks)
 {
-	if (quirks & PL330_QUIRK_BROKEN_NO_FLUSHP)
-		return 1;
-	else if (max_burst_len > PL330_MAX_BURST)
+	if (max_burst_len > PL330_MAX_BURST)
 		return PL330_MAX_BURST;
 	else if (max_burst_len < 1)
 		return 1;
@@ -3128,8 +3139,7 @@ pl330_probe(struct amba_device *adev, const struct amba_id *id)
 	pd->dst_addr_widths = PL330_DMA_BUSWIDTHS;
 	pd->directions = BIT(DMA_DEV_TO_MEM) | BIT(DMA_MEM_TO_DEV);
 	pd->residue_granularity = DMA_RESIDUE_GRANULARITY_BURST;
-	pd->max_burst = ((pl330->quirks & PL330_QUIRK_BROKEN_NO_FLUSHP) ?
-			 1 : PL330_MAX_BURST);
+	pd->max_burst = PL330_MAX_BURST;
 
 	ret = dma_async_device_register(pd);
 	if (ret) {
-- 
2.7.4



