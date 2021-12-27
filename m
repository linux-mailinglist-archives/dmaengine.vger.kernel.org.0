Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF6D747FC70
	for <lists+dmaengine@lfdr.de>; Mon, 27 Dec 2021 13:06:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236569AbhL0MGc (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 27 Dec 2021 07:06:32 -0500
Received: from mout.kundenserver.de ([212.227.126.134]:35123 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230075AbhL0MGa (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 27 Dec 2021 07:06:30 -0500
Received: from localhost.localdomain ([37.4.249.169]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1M1Yl9-1mzt5p3y0p-00332R; Mon, 27 Dec 2021 13:06:15 +0100
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
Subject: [PATCH RFC 04/11] dmaengine: bcm2835: move CB info generation into separate function
Date:   Mon, 27 Dec 2021 13:05:38 +0100
Message-Id: <1640606743-10993-5-git-send-email-stefan.wahren@i2se.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1640606743-10993-1-git-send-email-stefan.wahren@i2se.com>
References: <1640606743-10993-1-git-send-email-stefan.wahren@i2se.com>
X-Provags-ID: V03:K1:CPNybPgRYx20mRrC3A4iHHfAsiqMRd/Kohw8QKQNFQ7exA6MA50
 PZwl/W//j7iPMWCobsSSe4ImlyfCf5cE1v9nUpc/atYVpV0n0J9qYJnsOfsAgPkdFS5mqfA
 Vb7my7BxeTVQR2CU4JBZH0itf1t4zZSJGqqcoyDz5DXzeT7r6IwcRi7fpUFyySasHiY+1pe
 ItIc16jro99YaA1MVYgFg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:i6dd0S8v7SI=:KRnssHz/fO2BLDgQFq7bkL
 3ggxaBXrA4SzrrxzEpzmHwQlSszb+tXB8UZ5oKaocWdcurVFMnysD69X2QcOWnoMBXU8hRXhv
 NBH6F/2He7oGthIzyrbSuoRpmBRhiI61Iivd8lOJHOy0N28k7ZYg5fKLXqEUTN6493ThLBHiL
 4LYg/ENQTyuhspeAuoClnETUN90aZyRc+IbKmcOqTHz+K4Vdcn5pxtZqFVDM7H94xcfFKPna/
 IJVU0vdHex4WnLOzv53lxBTPATT+7awJFX+IYNPL0Im6sS9SvSBIz7WF6hF2rmWdHOiJrL5Z4
 PnlmpUmdDWNt1h9HkVmnYKFqqvSc6v0Dq+mhTUDsrHwNbFAo5n0bO25mkgSqynWqqsn4qdwgV
 TNZoqheTQXDLLHceop/uiJaHt2WMj4Ozuw5WbQcsFiofFfXCLqqlAuJFoVyWoCoCgfaGCTfZ3
 uzhG5yZQEPtL6WMrAvutxt6jiQUIWab+ECX9NMVvpHD1lDYQhoxC55+1O5iMeycOlosV1d90Z
 uW3cxBb3gNmnAN0/sbB+Y7/WTDTsfHQQcW6CDXOsTT5hyzvzgaYDVeVt960O5yK3z7nllW2ke
 Zy7tdKdmCIncvgWMFDkj/xS4GLSe+V1KzbsYgNuQxbBrIJzIZSJyESfjlWKIS4omkxae94Sff
 noJEgNeCEWOSwZGhMrIgaX9MI8aje+ruKOL+5u761jI824UZ/1w5Rm8q8EF1mSbh3oEcQ9QZC
 3uX8lFn0Wz1Zwmid
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Actually the generation of the Control Block info follows some simple
rules. So handle this with a separate function to avoid open coding
for every DMA operation. Another advantage is that we can easier
introduce other platforms with different info bits.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 drivers/dma/bcm2835-dma.c | 51 ++++++++++++++++++++++++++++++-----------------
 1 file changed, 33 insertions(+), 18 deletions(-)

diff --git a/drivers/dma/bcm2835-dma.c b/drivers/dma/bcm2835-dma.c
index adfe6bc..10c9ba2 100644
--- a/drivers/dma/bcm2835-dma.c
+++ b/drivers/dma/bcm2835-dma.c
@@ -201,6 +201,35 @@ static inline struct bcm2835_desc *to_bcm2835_dma_desc(
 	return container_of(t, struct bcm2835_desc, vd.tx);
 }
 
+static u32 bcm2835_dma_prepare_cb_info(struct bcm2835_chan *c,
+				       enum dma_transfer_direction direction,
+				       bool zero_page)
+{
+	u32 result;
+
+	if (direction == DMA_MEM_TO_MEM)
+		return BCM2835_DMA_D_INC | BCM2835_DMA_S_INC;
+
+	result = BCM2835_DMA_WAIT_RESP;
+
+	/* Setup DREQ channel */
+	if (c->dreq != 0)
+		result |= BCM2835_DMA_PER_MAP(c->dreq);
+
+	if (direction == DMA_DEV_TO_MEM) {
+		result |= BCM2835_DMA_S_DREQ | BCM2835_DMA_D_INC;
+	} else {
+		result |= BCM2835_DMA_D_DREQ | BCM2835_DMA_S_INC;
+
+		/* non-lite channels can write zeroes w/o accessing memory */
+		if (zero_page && !c->is_lite_channel) {
+			result |= BCM2835_DMA_S_IGNORE;
+		}
+	}
+
+	return result;
+}
+
 static void bcm2835_dma_free_cb_chain(struct bcm2835_desc *desc)
 {
 	size_t i;
@@ -615,7 +644,7 @@ static struct dma_async_tx_descriptor *bcm2835_dma_prep_dma_memcpy(
 {
 	struct bcm2835_chan *c = to_bcm2835_dma_chan(chan);
 	struct bcm2835_desc *d;
-	u32 info = BCM2835_DMA_D_INC | BCM2835_DMA_S_INC;
+	u32 info = bcm2835_dma_prepare_cb_info(c, DMA_MEM_TO_MEM, false);
 	u32 extra = BCM2835_DMA_INT_EN | BCM2835_DMA_WAIT_RESP;
 	size_t max_len = bcm2835_dma_max_frame_length(c);
 	size_t frames;
@@ -646,7 +675,7 @@ static struct dma_async_tx_descriptor *bcm2835_dma_prep_slave_sg(
 	struct bcm2835_chan *c = to_bcm2835_dma_chan(chan);
 	struct bcm2835_desc *d;
 	dma_addr_t src = 0, dst = 0;
-	u32 info = BCM2835_DMA_WAIT_RESP;
+	u32 info = bcm2835_dma_prepare_cb_info(c, direction, false);
 	u32 extra = BCM2835_DMA_INT_EN;
 	size_t frames;
 
@@ -656,19 +685,14 @@ static struct dma_async_tx_descriptor *bcm2835_dma_prep_slave_sg(
 		return NULL;
 	}
 
-	if (c->dreq != 0)
-		info |= BCM2835_DMA_PER_MAP(c->dreq);
-
 	if (direction == DMA_DEV_TO_MEM) {
 		if (c->cfg.src_addr_width != DMA_SLAVE_BUSWIDTH_4_BYTES)
 			return NULL;
 		src = c->cfg.src_addr;
-		info |= BCM2835_DMA_S_DREQ | BCM2835_DMA_D_INC;
 	} else {
 		if (c->cfg.dst_addr_width != DMA_SLAVE_BUSWIDTH_4_BYTES)
 			return NULL;
 		dst = c->cfg.dst_addr;
-		info |= BCM2835_DMA_D_DREQ | BCM2835_DMA_S_INC;
 	}
 
 	/* count frames in sg list */
@@ -698,7 +722,8 @@ static struct dma_async_tx_descriptor *bcm2835_dma_prep_dma_cyclic(
 	struct bcm2835_chan *c = to_bcm2835_dma_chan(chan);
 	struct bcm2835_desc *d;
 	dma_addr_t src, dst;
-	u32 info = BCM2835_DMA_WAIT_RESP;
+	u32 info = bcm2835_dma_prepare_cb_info(c, direction,
+					       buf_addr == od->zero_page);
 	u32 extra = 0;
 	size_t max_len = bcm2835_dma_max_frame_length(c);
 	size_t frames;
@@ -729,26 +754,16 @@ static struct dma_async_tx_descriptor *bcm2835_dma_prep_dma_cyclic(
 			      "%s: buffer_length (%zd) is not a multiple of period_len (%zd)\n",
 			      __func__, buf_len, period_len);
 
-	/* Setup DREQ channel */
-	if (c->dreq != 0)
-		info |= BCM2835_DMA_PER_MAP(c->dreq);
-
 	if (direction == DMA_DEV_TO_MEM) {
 		if (c->cfg.src_addr_width != DMA_SLAVE_BUSWIDTH_4_BYTES)
 			return NULL;
 		src = c->cfg.src_addr;
 		dst = buf_addr;
-		info |= BCM2835_DMA_S_DREQ | BCM2835_DMA_D_INC;
 	} else {
 		if (c->cfg.dst_addr_width != DMA_SLAVE_BUSWIDTH_4_BYTES)
 			return NULL;
 		dst = c->cfg.dst_addr;
 		src = buf_addr;
-		info |= BCM2835_DMA_D_DREQ | BCM2835_DMA_S_INC;
-
-		/* non-lite channels can write zeroes w/o accessing memory */
-		if (buf_addr == od->zero_page && !c->is_lite_channel)
-			info |= BCM2835_DMA_S_IGNORE;
 	}
 
 	/* calculate number of frames */
-- 
2.7.4

