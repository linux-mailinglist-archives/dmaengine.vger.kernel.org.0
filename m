Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B18D947FC77
	for <lists+dmaengine@lfdr.de>; Mon, 27 Dec 2021 13:06:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236584AbhL0MGf (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 27 Dec 2021 07:06:35 -0500
Received: from mout.kundenserver.de ([212.227.126.187]:54491 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236580AbhL0MGe (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 27 Dec 2021 07:06:34 -0500
Received: from localhost.localdomain ([37.4.249.169]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MkYkI-1magg545FO-00m2RS; Mon, 27 Dec 2021 13:06:16 +0100
From:   Stefan Wahren <stefan.wahren@i2se.com>
To:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>
Cc:     Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com, dmaengine@vger.kernel.org,
        Phil Elwell <phil@raspberrypi.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Lukas Wunner <lukas@wunner.de>,
        linux-rpi-kernel@lists.infradead.org,
        Stefan Wahren <stefan.wahren@i2se.com>
Subject: [PATCH RFC 06/11] dmaengine: bcm2835: make address increment platform independent
Date:   Mon, 27 Dec 2021 13:05:40 +0100
Message-Id: <1640606743-10993-7-git-send-email-stefan.wahren@i2se.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1640606743-10993-1-git-send-email-stefan.wahren@i2se.com>
References: <1640606743-10993-1-git-send-email-stefan.wahren@i2se.com>
X-Provags-ID: V03:K1:HrffKyC4m6ikFaJSkU6yeCuvlOClCWXEx4SVySiaZWR2sYV95iQ
 BgBYtZxP6knwrhszIG5N6afpgRnMTzau0G6fS+Rs2DMd+Nvrh2Ca4bN4EAr1jKTIbnGtbjo
 7hjfBm4WQrOfcoyiaPR1jV0MXBqj8/GplXipQ21YhDGLi9hjg+mV1WWEFzdO6dL4Cadlgb9
 /rP2OAS/q/m0PBs5YvyUA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:DXG1JcMei24=:cHwkAopfBiYzTK5pSHm0yY
 X+TUWkiYWFgzoqiAzMyAPovCn5PbMF25gZ7ZHvRRqtnE2zGAwSdKfWzWqdAnERAYG6oLjCHsU
 2S4DIfiY2ja3/ge87akcdohMjqEwr1H7dZOpooqquDc2mh595daLKhSXt8yAzKTU4AZpQfg7W
 M8gfpr8J12DSvW1I9EkUGU9f0dIyz4X3qJMcDEVoObxb8PuEUaegm02X25OOz2vBnoE+fUtcA
 vjYBgStX9c/Nn1RV2DPJzVXiHV77IJndmOoluNbQLWlIdc7qFqk5yvvXsZllcaduGHt/bW4Nb
 1cQRlmHxz0AuL4tlDPRxseqnvHQ2jM6MaO3T93oVXpiO4INTn0YWh+m7L3RKjBFnjv3qMptPF
 H+xoMKe41G5U5pHYiTK1eOULP1OCfOf3Tj+BHxATBjWMGOH1P+WGCV1blJnB4f3gw0HmpT9oK
 8xCf0xAYp+tMW7BULKTp4PBrLPTpXUQWibyL+oxOd3UgoqWWZZ6Zp4jhulMJ4ZEP1vKi3/stG
 TbYsqEwEvJbmM1dMR1aU44HvUaKYCMnudI5tv2YbUPvFBPTP51NRtoCKtkGcL6hddzcOvhEvP
 RIi+8Lb+fLpetYfbTJpNGN2twEqhCftDfh9ZP5i/CuOYsfl8IBWGxoK9cNp/n/E7PJ45//HSZ
 dvtYgSegso+lH9H9+Jjk6h1SH5KJiTZHYmyoADlj2ugLawP59TZiHQbCtodgtT7fzrtdhuuUY
 WpzY5n2GEqgzrlXS
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Actually the criteria to increment source & destination address doesn't
based on platform specific bits. It's just the DMA transfer direction which
is translated into the info bits. So introduce two new helper functions
and get the rid of these platform specifics.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 drivers/dma/bcm2835-dma.c | 28 ++++++++++++++++++++++------
 1 file changed, 22 insertions(+), 6 deletions(-)

diff --git a/drivers/dma/bcm2835-dma.c b/drivers/dma/bcm2835-dma.c
index 863792e..a7b9f88 100644
--- a/drivers/dma/bcm2835-dma.c
+++ b/drivers/dma/bcm2835-dma.c
@@ -253,6 +253,24 @@ static u32 bcm2835_dma_prepare_cb_extra(struct bcm2835_chan *c,
 	return result;
 }
 
+static inline bool need_src_incr(enum dma_transfer_direction direction)
+{
+	return direction != DMA_DEV_TO_MEM;
+}
+
+static inline bool need_dst_incr(enum dma_transfer_direction direction)
+{
+	switch (direction) {
+	case DMA_MEM_TO_MEM:
+	case DMA_DEV_TO_MEM:
+		return true;
+	default:
+		break;
+	}
+
+	return false;
+}
+
 static void bcm2835_dma_free_cb_chain(struct bcm2835_desc *desc)
 {
 	size_t i;
@@ -337,10 +355,8 @@ static inline size_t bcm2835_dma_count_frames_for_sg(
  * @cyclic:         it is a cyclic transfer
  * @info:           the default info bits to apply per controlblock
  * @frames:         number of controlblocks to allocate
- * @src:            the src address to assign (if the S_INC bit is set
- *                  in @info, then it gets incremented)
- * @dst:            the dst address to assign (if the D_INC bit is set
- *                  in @info, then it gets incremented)
+ * @src:            the src address to assign
+ * @dst:            the dst address to assign
  * @buf_len:        the full buffer length (may also be 0)
  * @period_len:     the period length when to apply @finalextrainfo
  *                  in addition to the last transfer
@@ -409,9 +425,9 @@ static struct bcm2835_desc *bcm2835_dma_create_cb_chain(
 			d->cb_list[frame - 1].cb->next = cb_entry->paddr;
 
 		/* update src and dst and length */
-		if (src && (info & BCM2835_DMA_S_INC))
+		if (src && need_src_incr(direction))
 			src += control_block->length;
-		if (dst && (info & BCM2835_DMA_D_INC))
+		if (dst && need_dst_incr(direction))
 			dst += control_block->length;
 
 		/* Length of total transfer */
-- 
2.7.4

