Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06DB647FC71
	for <lists+dmaengine@lfdr.de>; Mon, 27 Dec 2021 13:06:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236579AbhL0MGd (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 27 Dec 2021 07:06:33 -0500
Received: from mout.kundenserver.de ([212.227.126.135]:44001 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236568AbhL0MGc (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 27 Dec 2021 07:06:32 -0500
Received: from localhost.localdomain ([37.4.249.169]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MCsLo-1nAaBz1wDQ-008rfU; Mon, 27 Dec 2021 13:06:15 +0100
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
Subject: [PATCH RFC 05/11] dmaengine: bcm2835: move CB final extra info generation into function
Date:   Mon, 27 Dec 2021 13:05:39 +0100
Message-Id: <1640606743-10993-6-git-send-email-stefan.wahren@i2se.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1640606743-10993-1-git-send-email-stefan.wahren@i2se.com>
References: <1640606743-10993-1-git-send-email-stefan.wahren@i2se.com>
X-Provags-ID: V03:K1:UT61IjKwl0DbobMULXOCOAAWeiIa6jN616fv3vRUKt5uXE7XPa+
 V+HQ17CrbavcwDYN9f80AS++6dV1zaASSyohTOfndC19yrqlaWku863uHLG8GyFxtV00Dog
 Cxce5hLXBQFBq/yeb0TxcGozg/ovjCgeJLqqRX022/ynWDb1ZIvWK1AqLDWllwrfRvmicpO
 PcmSkMF4VLhx1zNyjFIwA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:sBWknKLJQQQ=:7cVpLUapyEQLtqfYq11Ktb
 oCvuuMFwaZuKMYd8QO0NaSTYiYnwfO45VMEwjVCOke+hu/k4ZXe6zu13ClL64U/zPh3bkiQsP
 uhy2/U9yR9uesiHUzjpPdeW1MveoXvp330v3GTd2f48ugdY5inKNkac00vr0OMfUpLkjh/9xq
 b93R4BKNLciGJBgnS8Bqwdweg/O+EOQR+KAA9wT+YhbnYCgx7ml+u5CkiKvZcw9AKPWN3p8Vu
 qzj/GOKANFMolTy26inh59khhUvxw2DQpz55VgfHLxhwXJ8k+PBSqoCNZ+rUOjRT2aI06MJ7w
 7joqeivFXAKefp6KCSVCwF//ocmr3GsUJxDu3Zn19Woa9v0Cn98yJRmOvxEs7ppl1H2e1x3CS
 skrm6V3z8okFK4NIl6ouENGovvj6XQ9yKDN4jGeqKaINIjL8waY3tYiIXZlL68SwL9FzvfHlf
 Wd0khgFSmVZlLE8ssJextQVWNwvJLfcNoHWbiK4fK6Zw4lntmkXUKlt0OA61C26tsPsx+gWOg
 txaO2gDkSwNOEOCv7Zq3Daude5Go+YjKbCPoRK6ti8NFdDThlj3PKXzhOVD2ZnvyOEk2LDv2z
 QCRaDUMZB/aDUGXRwABlViJ/YPPs2F1h0SJgQ+i7AmZkLNmSrBsYISALKsuv0T2hWjLfm/uDG
 FzEmPDCSZhLO42RnXSPg6WJ9Zkkff8Nr0LvmYxoCXtLrtKkEc2rCltdtgrNgJ9uOCSkD8E6DN
 o3Xtd7uRCgGnahXT
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Similar to the info generation, generate the final extra info with a
separate function. This is necessary to introduce other platforms
with different info bits.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 drivers/dma/bcm2835-dma.c | 34 ++++++++++++++++++++++++++++------
 1 file changed, 28 insertions(+), 6 deletions(-)

diff --git a/drivers/dma/bcm2835-dma.c b/drivers/dma/bcm2835-dma.c
index 10c9ba2..863792e 100644
--- a/drivers/dma/bcm2835-dma.c
+++ b/drivers/dma/bcm2835-dma.c
@@ -230,6 +230,29 @@ static u32 bcm2835_dma_prepare_cb_info(struct bcm2835_chan *c,
 	return result;
 }
 
+static u32 bcm2835_dma_prepare_cb_extra(struct bcm2835_chan *c,
+					enum dma_transfer_direction direction,
+					bool cyclic, bool final,
+					unsigned long flags)
+{
+	u32 result = 0;
+
+	if (cyclic) {
+		if (flags & DMA_PREP_INTERRUPT)
+			result |= BCM2835_DMA_INT_EN;
+	} else {
+		if (!final)
+			return 0;
+
+		result |= BCM2835_DMA_INT_EN;
+
+		if (direction == DMA_MEM_TO_MEM)
+			result |= BCM2835_DMA_WAIT_RESP;
+	}
+
+	return result;
+}
+
 static void bcm2835_dma_free_cb_chain(struct bcm2835_desc *desc)
 {
 	size_t i;
@@ -645,7 +668,8 @@ static struct dma_async_tx_descriptor *bcm2835_dma_prep_dma_memcpy(
 	struct bcm2835_chan *c = to_bcm2835_dma_chan(chan);
 	struct bcm2835_desc *d;
 	u32 info = bcm2835_dma_prepare_cb_info(c, DMA_MEM_TO_MEM, false);
-	u32 extra = BCM2835_DMA_INT_EN | BCM2835_DMA_WAIT_RESP;
+	u32 extra = bcm2835_dma_prepare_cb_extra(c, DMA_MEM_TO_MEM, false,
+						 true, 0);
 	size_t max_len = bcm2835_dma_max_frame_length(c);
 	size_t frames;
 
@@ -676,7 +700,7 @@ static struct dma_async_tx_descriptor *bcm2835_dma_prep_slave_sg(
 	struct bcm2835_desc *d;
 	dma_addr_t src = 0, dst = 0;
 	u32 info = bcm2835_dma_prepare_cb_info(c, direction, false);
-	u32 extra = BCM2835_DMA_INT_EN;
+	u32 extra = bcm2835_dma_prepare_cb_extra(c, direction, false, true, 0);
 	size_t frames;
 
 	if (!is_slave_direction(direction)) {
@@ -724,7 +748,7 @@ static struct dma_async_tx_descriptor *bcm2835_dma_prep_dma_cyclic(
 	dma_addr_t src, dst;
 	u32 info = bcm2835_dma_prepare_cb_info(c, direction,
 					       buf_addr == od->zero_page);
-	u32 extra = 0;
+	u32 extra = bcm2835_dma_prepare_cb_extra(c, direction, true, true, 0);
 	size_t max_len = bcm2835_dma_max_frame_length(c);
 	size_t frames;
 
@@ -740,9 +764,7 @@ static struct dma_async_tx_descriptor *bcm2835_dma_prep_dma_cyclic(
 		return NULL;
 	}
 
-	if (flags & DMA_PREP_INTERRUPT)
-		extra |= BCM2835_DMA_INT_EN;
-	else
+	if (!(flags & DMA_PREP_INTERRUPT))
 		period_len = buf_len;
 
 	/*
-- 
2.7.4

