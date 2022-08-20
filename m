Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84E4459AE12
	for <lists+dmaengine@lfdr.de>; Sat, 20 Aug 2022 15:02:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347392AbiHTM7m (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 20 Aug 2022 08:59:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346612AbiHTM7G (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 20 Aug 2022 08:59:06 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9C2D4AD70;
        Sat, 20 Aug 2022 05:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1661000320; x=1692536320;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=m4hrpVvvRpXK7W72kK9BK/X7aYaVC0K41tIyOC2xvJA=;
  b=s2UOu2DdEITspadaxdipUbW8bPNjN5T0V9dNdH2w3reGgV16kaWZsO/+
   6aq8lPqKZpy7A68BUucbd5Tx5xlE9Ebfc15gqSbMltZQKSrKi4NTX1kge
   i4StkMB+JD5GtD2SzWEExNOfecIYGllpS+hHG97ZPwVmixEMCIwQZtnSd
   vBKICdrwhkM9nrI76tFLkSV3h7prn7hDcTw4hVM3MC1Vy7hq899WRLwjq
   JvGVuElpLoqW9e0Pi4FEnJcU1Fm0jNs0aakkFyHrMXCKQudTemZxzpi3v
   miYWXG9pFX0K6sEKc7OeBs915UOX6TmHKKAW7PyaUQBsE+LAyX8SGNuN6
   g==;
X-IronPort-AV: E=Sophos;i="5.93,251,1654585200"; 
   d="scan'208";a="109911742"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 20 Aug 2022 05:58:40 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Sat, 20 Aug 2022 05:58:39 -0700
Received: from ROB-ULT-M18064N.mchp-main.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.12 via Frontend Transport; Sat, 20 Aug 2022 05:58:36 -0700
From:   Tudor Ambarus <tudor.ambarus@microchip.com>
To:     <vkoul@kernel.org>, <peda@axentia.se>, <du@axentia.se>,
        <regressions@leemhuis.info>
CC:     <ludovic.desroches@microchip.com>, <maciej.sosnowski@intel.com>,
        <tudor.ambarus@microchip.com>, <dan.j.williams@intel.com>,
        <nicolas.ferre@microchip.com>, <mripard@kernel.org>,
        <torfl6749@gmail.com>, <linux-kernel@vger.kernel.org>,
        <dmaengine@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 22/33] dmaengine: at_hdmac: Pass residue by address to avoid unneccessary implicit casts
Date:   Sat, 20 Aug 2022 15:57:06 +0300
Message-ID: <20220820125717.588722-23-tudor.ambarus@microchip.com>
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

struct dma_tx_state defines residue as u32. atc_get_bytes_left() returned
an int which could be either an error or the value of the residue. This
could cause problems if the controller supported a u32 buffer transfer size
and the u32 value was past the max int can hold. Our controller does not
support u32 buffer transfer size, but even so, improve the code and pass
the residue by address to avoid unnecessary implicit casts and make
atc_get_bytes_left() return 0 on success or -errno on errors.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 drivers/dma/at_hdmac.c | 54 +++++++++++++++++++++++-------------------
 1 file changed, 30 insertions(+), 24 deletions(-)

diff --git a/drivers/dma/at_hdmac.c b/drivers/dma/at_hdmac.c
index c72c796d58bc..abb884a08bd4 100644
--- a/drivers/dma/at_hdmac.c
+++ b/drivers/dma/at_hdmac.c
@@ -728,7 +728,7 @@ static struct at_desc *atc_get_desc_by_cookie(struct at_dma_chan *atchan,
  * @current_len: the number of bytes left before reading CTRLA
  * @ctrla: the value of CTRLA
  */
-static inline int atc_calc_bytes_left(int current_len, u32 ctrla)
+static inline u32 atc_calc_bytes_left(u32 current_len, u32 ctrla)
 {
 	u32 btsize = FIELD_GET(ATC_BTSIZE, ctrla);
 	u32 src_width = FIELD_GET(ATC_SRC_WIDTH, ctrla);
@@ -743,17 +743,20 @@ static inline int atc_calc_bytes_left(int current_len, u32 ctrla)
 }
 
 /**
- * atc_get_bytes_left - get the number of bytes residue for a cookie
+ * atc_get_bytes_left - get the number of bytes residue for a cookie.
+ * The residue is passed by address and updated on success.
  * @chan: DMA channel
  * @cookie: transaction identifier to check status of
+ * @residue: residue to be updated.
+ * Return 0 on success, -errono otherwise.
  */
-static int atc_get_bytes_left(struct dma_chan *chan, dma_cookie_t cookie)
+static int atc_get_bytes_left(struct dma_chan *chan, dma_cookie_t cookie,
+			      u32 *residue)
 {
 	struct at_dma_chan      *atchan = to_at_dma_chan(chan);
 	struct at_desc *desc_first = atc_first_active(atchan);
 	struct at_desc *desc;
-	int ret;
-	u32 ctrla, dscr;
+	u32 len, ctrla, dscr;
 	unsigned int i;
 
 	/*
@@ -768,7 +771,7 @@ static int atc_get_bytes_left(struct dma_chan *chan, dma_cookie_t cookie)
 		return desc->total_len;
 
 	/* cookie matches to the currently running transfer */
-	ret = desc_first->total_len;
+	len = desc_first->total_len;
 
 	if (desc_first->lli.dscr) {
 		/* hardware linked list transfer */
@@ -854,29 +857,31 @@ static int atc_get_bytes_left(struct dma_chan *chan, dma_cookie_t cookie)
 			return -ETIMEDOUT;
 
 		/* for the first descriptor we can be more accurate */
-		if (desc_first->lli.dscr == dscr)
-			return atc_calc_bytes_left(ret, ctrla);
+		if (desc_first->lli.dscr == dscr) {
+			*residue = atc_calc_bytes_left(len, ctrla);
+			return 0;
+		}
 
-		ret -= desc_first->len;
+		len -= desc_first->len;
 		list_for_each_entry(desc, &desc_first->tx_list, desc_node) {
 			if (desc->lli.dscr == dscr)
 				break;
 
-			ret -= desc->len;
+			len -= desc->len;
 		}
 
 		/*
 		 * For the current descriptor in the chain we can calculate
 		 * the remaining bytes using the channel's register.
 		 */
-		ret = atc_calc_bytes_left(ret, ctrla);
+		*residue = atc_calc_bytes_left(len, ctrla);
 	} else {
 		/* single transfer */
 		ctrla = channel_readl(atchan, CTRLA);
-		ret = atc_calc_bytes_left(ret, ctrla);
+		*residue = atc_calc_bytes_left(len, ctrla);
 	}
 
-	return ret;
+	return 0;
 }
 
 /**
@@ -1899,31 +1904,32 @@ atc_tx_status(struct dma_chan *chan,
 {
 	struct at_dma_chan	*atchan = to_at_dma_chan(chan);
 	unsigned long		flags;
-	enum dma_status		ret;
-	int bytes = 0;
+	enum dma_status		dma_status;
+	u32 residue;
+	int ret;
 
-	ret = dma_cookie_status(chan, cookie, txstate);
-	if (ret == DMA_COMPLETE || !txstate)
-		return ret;
+	dma_status = dma_cookie_status(chan, cookie, txstate);
+	if (dma_status == DMA_COMPLETE || !txstate)
+		return dma_status;
 
 	spin_lock_irqsave(&atchan->lock, flags);
 
 	/*  Get number of bytes left in the active transactions */
-	bytes = atc_get_bytes_left(chan, cookie);
+	ret = atc_get_bytes_left(chan, cookie, &residue);
 
 	spin_unlock_irqrestore(&atchan->lock, flags);
 
-	if (unlikely(bytes < 0)) {
+	if (unlikely(ret < 0)) {
 		dev_vdbg(chan2dev(chan), "get residual bytes error\n");
 		return DMA_ERROR;
 	} else {
-		dma_set_residue(txstate, bytes);
+		dma_set_residue(txstate, residue);
 	}
 
-	dev_vdbg(chan2dev(chan), "tx_status %d: cookie = %d residue = %d\n",
-		 ret, cookie, bytes);
+	dev_vdbg(chan2dev(chan), "tx_status %d: cookie = %d residue = %u\n",
+		 dma_status, cookie, residue);
 
-	return ret;
+	return dma_status;
 }
 
 /**
-- 
2.25.1

