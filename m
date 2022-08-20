Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE6DB59AE0B
	for <lists+dmaengine@lfdr.de>; Sat, 20 Aug 2022 15:01:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346799AbiHTM7z (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 20 Aug 2022 08:59:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347234AbiHTM7M (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 20 Aug 2022 08:59:12 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0482760C3;
        Sat, 20 Aug 2022 05:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1661000328; x=1692536328;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VvRp4J5b4pfuF6ob3cwUeC9Yje9+cBiF+Xci2ftgcDY=;
  b=F7Vs43bcqfrPWt55K059WRJGDDX1Anuok6K2V0LHHszV16H9Iqub+5h+
   ezBnIfLjeUsDn/TPCfxZtEzWYYZ5CXwgPOcmcOUOXKvPatqJYep4/ampo
   2eotc8rJJ4nkZc8h1HH5EqriPlT3cKuBT9vKsuePeBezCHYg+18xoQpVE
   J+wBcuPGD89auTfhTHnlScSMQDsdNZOhTHNSQHQqThp05zWQMbZpGzPGI
   P89gWKMUtmcATVXq6BOA95iDBMxsznfHLXPwyLatCVIy77s64aVbGpDUv
   dEeILUGP4oIydXc5R8SdmNgzcQ9im8Q/inBAo6CZoB2x0nA6mC1VhMU2o
   w==;
X-IronPort-AV: E=Sophos;i="5.93,251,1654585200"; 
   d="scan'208";a="177042908"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 20 Aug 2022 05:58:47 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Sat, 20 Aug 2022 05:58:45 -0700
Received: from ROB-ULT-M18064N.mchp-main.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.12 via Frontend Transport; Sat, 20 Aug 2022 05:58:43 -0700
From:   Tudor Ambarus <tudor.ambarus@microchip.com>
To:     <vkoul@kernel.org>, <peda@axentia.se>, <du@axentia.se>,
        <regressions@leemhuis.info>
CC:     <ludovic.desroches@microchip.com>, <maciej.sosnowski@intel.com>,
        <tudor.ambarus@microchip.com>, <dan.j.williams@intel.com>,
        <nicolas.ferre@microchip.com>, <mripard@kernel.org>,
        <torfl6749@gmail.com>, <linux-kernel@vger.kernel.org>,
        <dmaengine@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 24/33] dmaengine: at_hdmac: Introduce atc_get_llis_residue()
Date:   Sat, 20 Aug 2022 15:57:08 +0300
Message-ID: <20220820125717.588722-25-tudor.ambarus@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220820125717.588722-1-tudor.ambarus@microchip.com>
References: <20220820125717.588722-1-tudor.ambarus@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Introduce a method to get the residue for a hardware linked list transfer.
It makes the code easier to read.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 drivers/dma/at_hdmac.c | 221 ++++++++++++++++++++---------------------
 1 file changed, 110 insertions(+), 111 deletions(-)

diff --git a/drivers/dma/at_hdmac.c b/drivers/dma/at_hdmac.c
index daf2a3af25d4..4cd3293887f2 100644
--- a/drivers/dma/at_hdmac.c
+++ b/drivers/dma/at_hdmac.c
@@ -742,6 +742,109 @@ static inline u32 atc_calc_bytes_left(u32 current_len, u32 ctrla)
 	return current_len - (btsize << src_width);
 }
 
+/**
+ * atc_get_llis_residue - Get residue for a hardware linked list transfer
+ *
+ * Calculate the residue by removing the length of the child descriptors already
+ * transferred from the total length. To get the current child descriptor we can
+ * use the value of the channel's DSCR register and compare it against the value
+ * of the hardware linked list structure of each child descriptor.
+ *
+ * The CTRLA register provides us with the amount of data already read from the
+ * source for the current child descriptor. So we can compute a more accurate
+ * residue by also removing the number of bytes corresponding to this amount of
+ * data.
+ *
+ * However, the DSCR and CTRLA registers cannot be read both atomically. Hence a
+ * race condition may occur: the first read register may refer to one child
+ * descriptor whereas the second read may refer to a later child descriptor in
+ * the list because of the DMA transfer progression inbetween the two reads.
+ *
+ * One solution could have been to pause the DMA transfer, read the DSCR and
+ * CTRLA then resume the DMA transfer. Nonetheless, this approach presents some
+ * drawbacks:
+ * - If the DMA transfer is paused, RX overruns or TX underruns are more likey
+ *   to occur depending on the system latency. Taking the USART driver as an
+ *   example, it uses a cyclic DMA transfer to read data from the Receive
+ *   Holding Register (RHR) to avoid RX overruns since the RHR is not protected
+ *   by any FIFO on most Atmel SoCs. So pausing the DMA transfer to compute the
+ *   residue would break the USART driver design.
+ * - The atc_pause() function masks interrupts but we'd rather avoid to do so
+ * for system latency purpose.
+ *
+ * Then we'd rather use another solution: the DSCR is read a first time, the
+ * CTRLA is read in turn, next the DSCR is read a second time. If the two
+ * consecutive read values of the DSCR are the same then we assume both refers
+ * to the very same child descriptor as well as the CTRLA value read inbetween
+ * does. For cyclic tranfers, the assumption is that a full loop is "not so
+ * fast". If the two DSCR values are different, we read again the CTRLA then the
+ * DSCR till two consecutive read values from DSCR are equal or till the
+ * maximum trials is reach. This algorithm is very unlikely not to find a stable
+ * value for DSCR.
+ * @atchan: pointer to an atmel hdmac channel.
+ * @desc: pointer to the descriptor for which the residue is calculated.
+ * @residue: residue to be set to dma_tx_state.
+ * Returns 0 on success, -errno otherwise.
+ */
+static int atc_get_llis_residue(struct at_dma_chan *atchan,
+				struct at_desc *desc, u32 *residue)
+{
+	struct at_desc *child;
+	u32 len, ctrla, dscr;
+	unsigned int i;
+
+	len = desc->total_len;
+	dscr = channel_readl(atchan, DSCR);
+	rmb(); /* ensure DSCR is read before CTRLA */
+	ctrla = channel_readl(atchan, CTRLA);
+	for (i = 0; i < ATC_MAX_DSCR_TRIALS; ++i) {
+		u32 new_dscr;
+
+		rmb(); /* ensure DSCR is read after CTRLA */
+		new_dscr = channel_readl(atchan, DSCR);
+
+		/*
+		 * If the DSCR register value has not changed inside the DMA
+		 * controller since the previous read, we assume that both the
+		 * dscr and ctrla values refers to the very same descriptor.
+		 */
+		if (likely(new_dscr == dscr))
+			break;
+
+		/*
+		 * DSCR has changed inside the DMA controller, so the previouly
+		 * read value of CTRLA may refer to an already processed
+		 * descriptor hence could be outdated. We need to update ctrla
+		 * to match the current descriptor.
+		 */
+		dscr = new_dscr;
+		rmb(); /* ensure DSCR is read before CTRLA */
+		ctrla = channel_readl(atchan, CTRLA);
+	}
+	if (unlikely(i == ATC_MAX_DSCR_TRIALS))
+		return -ETIMEDOUT;
+
+	/* For the first descriptor we can be more accurate. */
+	if (desc->lli.dscr == dscr) {
+		*residue = atc_calc_bytes_left(len, ctrla);
+		return 0;
+	}
+
+	len -= desc->len;
+	list_for_each_entry(child, &desc->tx_list, desc_node) {
+		if (child->lli.dscr == dscr)
+			break;
+		len -= child->len;
+	}
+
+	/*
+	 * For the current descriptor in the chain we can calculate the
+	 * remaining bytes using the channel's register.
+	 */
+	*residue = atc_calc_bytes_left(len, ctrla);
+	return 0;
+}
+
 /**
  * atc_get_residue - get the number of bytes residue for a cookie.
  * The residue is passed by address and updated on success.
@@ -756,8 +859,7 @@ static int atc_get_residue(struct dma_chan *chan, dma_cookie_t cookie,
 	struct at_dma_chan      *atchan = to_at_dma_chan(chan);
 	struct at_desc *desc_first = atc_first_active(atchan);
 	struct at_desc *desc;
-	u32 len, ctrla, dscr;
-	unsigned int i;
+	u32 len, ctrla;
 
 	/*
 	 * If the cookie doesn't match to the currently running transfer then
@@ -770,117 +872,14 @@ static int atc_get_residue(struct dma_chan *chan, dma_cookie_t cookie,
 	else if (desc != desc_first)
 		return desc->total_len;
 
-	/* cookie matches to the currently running transfer */
-	len = desc_first->total_len;
-
-	if (desc_first->lli.dscr) {
+	if (desc_first->lli.dscr)
 		/* hardware linked list transfer */
+		return atc_get_llis_residue(atchan, desc_first, residue);
 
-		/*
-		 * Calculate the residue by removing the length of the child
-		 * descriptors already transferred from the total length.
-		 * To get the current child descriptor we can use the value of
-		 * the channel's DSCR register and compare it against the value
-		 * of the hardware linked list structure of each child
-		 * descriptor.
-		 *
-		 * The CTRLA register provides us with the amount of data
-		 * already read from the source for the current child
-		 * descriptor. So we can compute a more accurate residue by also
-		 * removing the number of bytes corresponding to this amount of
-		 * data.
-		 *
-		 * However, the DSCR and CTRLA registers cannot be read both
-		 * atomically. Hence a race condition may occur: the first read
-		 * register may refer to one child descriptor whereas the second
-		 * read may refer to a later child descriptor in the list
-		 * because of the DMA transfer progression inbetween the two
-		 * reads.
-		 *
-		 * One solution could have been to pause the DMA transfer, read
-		 * the DSCR and CTRLA then resume the DMA transfer. Nonetheless,
-		 * this approach presents some drawbacks:
-		 * - If the DMA transfer is paused, RX overruns or TX underruns
-		 *   are more likey to occur depending on the system latency.
-		 *   Taking the USART driver as an example, it uses a cyclic DMA
-		 *   transfer to read data from the Receive Holding Register
-		 *   (RHR) to avoid RX overruns since the RHR is not protected
-		 *   by any FIFO on most Atmel SoCs. So pausing the DMA transfer
-		 *   to compute the residue would break the USART driver design.
-		 * - The atc_pause() function masks interrupts but we'd rather
-		 *   avoid to do so for system latency purpose.
-		 *
-		 * Then we'd rather use another solution: the DSCR is read a
-		 * first time, the CTRLA is read in turn, next the DSCR is read
-		 * a second time. If the two consecutive read values of the DSCR
-		 * are the same then we assume both refers to the very same
-		 * child descriptor as well as the CTRLA value read inbetween
-		 * does. For cyclic tranfers, the assumption is that a full loop
-		 * is "not so fast".
-		 * If the two DSCR values are different, we read again the CTRLA
-		 * then the DSCR till two consecutive read values from DSCR are
-		 * equal or till the maxium trials is reach.
-		 * This algorithm is very unlikely not to find a stable value for
-		 * DSCR.
-		 */
-
-		dscr = channel_readl(atchan, DSCR);
-		rmb(); /* ensure DSCR is read before CTRLA */
-		ctrla = channel_readl(atchan, CTRLA);
-		for (i = 0; i < ATC_MAX_DSCR_TRIALS; ++i) {
-			u32 new_dscr;
-
-			rmb(); /* ensure DSCR is read after CTRLA */
-			new_dscr = channel_readl(atchan, DSCR);
-
-			/*
-			 * If the DSCR register value has not changed inside the
-			 * DMA controller since the previous read, we assume
-			 * that both the dscr and ctrla values refers to the
-			 * very same descriptor.
-			 */
-			if (likely(new_dscr == dscr))
-				break;
-
-			/*
-			 * DSCR has changed inside the DMA controller, so the
-			 * previouly read value of CTRLA may refer to an already
-			 * processed descriptor hence could be outdated.
-			 * We need to update ctrla to match the current
-			 * descriptor.
-			 */
-			dscr = new_dscr;
-			rmb(); /* ensure DSCR is read before CTRLA */
-			ctrla = channel_readl(atchan, CTRLA);
-		}
-		if (unlikely(i == ATC_MAX_DSCR_TRIALS))
-			return -ETIMEDOUT;
-
-		/* for the first descriptor we can be more accurate */
-		if (desc_first->lli.dscr == dscr) {
-			*residue = atc_calc_bytes_left(len, ctrla);
-			return 0;
-		}
-
-		len -= desc_first->len;
-		list_for_each_entry(desc, &desc_first->tx_list, desc_node) {
-			if (desc->lli.dscr == dscr)
-				break;
-
-			len -= desc->len;
-		}
-
-		/*
-		 * For the current descriptor in the chain we can calculate
-		 * the remaining bytes using the channel's register.
-		 */
-		*residue = atc_calc_bytes_left(len, ctrla);
-	} else {
-		/* single transfer */
-		ctrla = channel_readl(atchan, CTRLA);
-		*residue = atc_calc_bytes_left(len, ctrla);
-	}
-
+	/* single transfer */
+	len = desc_first->total_len;
+	ctrla = channel_readl(atchan, CTRLA);
+	*residue = atc_calc_bytes_left(len, ctrla);
 	return 0;
 }
 
-- 
2.25.1

