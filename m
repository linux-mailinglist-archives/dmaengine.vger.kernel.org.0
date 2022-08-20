Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0FDC59AE16
	for <lists+dmaengine@lfdr.de>; Sat, 20 Aug 2022 15:02:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346912AbiHTM7o (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 20 Aug 2022 08:59:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346954AbiHTM7I (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 20 Aug 2022 08:59:08 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B59AD6E2C5;
        Sat, 20 Aug 2022 05:58:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1661000324; x=1692536324;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0GY7OSxCkPIEHcqNFjBIA4X/HK0yiPvOyvY0nEo/IVA=;
  b=ZU4sehaEfvNAsJplWjLM8W6hwhKnIPemZcJ7WevahuH5qqpDWCk7Ckrc
   7RD7wp0/ajYDAF7r9G4/UaAi2vmLE/hdw9M3k/XA+yVHoL/ORoo5/3i4U
   Ub+nKHtnnST2d6GY8eVaDN26fL81NDJsEwn0X7t/XMvGARmTPW6QR1r+9
   EKDxFgmR+zzkCRoptxvQXgzWXBguF3mslJlnjL9Ezfv9WuCRRCm3e8I6z
   1U0E3r+vRMXfChwSQOAY3aNR0WGKICOMOIAZ3pcRpReXohqxJBsCi7s4a
   Bup29xcRSP8bkMbFuPFwSZcx4HVb1f6KCTPdKuCN9THr/6LBb2XuEXLXl
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,251,1654585200"; 
   d="scan'208";a="187325772"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 20 Aug 2022 05:58:43 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Sat, 20 Aug 2022 05:58:42 -0700
Received: from ROB-ULT-M18064N.mchp-main.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.12 via Frontend Transport; Sat, 20 Aug 2022 05:58:39 -0700
From:   Tudor Ambarus <tudor.ambarus@microchip.com>
To:     <vkoul@kernel.org>, <peda@axentia.se>, <du@axentia.se>,
        <regressions@leemhuis.info>
CC:     <ludovic.desroches@microchip.com>, <maciej.sosnowski@intel.com>,
        <tudor.ambarus@microchip.com>, <dan.j.williams@intel.com>,
        <nicolas.ferre@microchip.com>, <mripard@kernel.org>,
        <torfl6749@gmail.com>, <linux-kernel@vger.kernel.org>,
        <dmaengine@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 23/33] dmaengine: at_hdmac: s/atc_get_bytes_left/atc_get_residue
Date:   Sat, 20 Aug 2022 15:57:07 +0300
Message-ID: <20220820125717.588722-24-tudor.ambarus@microchip.com>
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

Use dmaengine terminology and rename the method to better indicate what it
does: it gets the residue value which will be later on set with
dma_set_residue().

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 drivers/dma/at_hdmac.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/dma/at_hdmac.c b/drivers/dma/at_hdmac.c
index abb884a08bd4..daf2a3af25d4 100644
--- a/drivers/dma/at_hdmac.c
+++ b/drivers/dma/at_hdmac.c
@@ -743,15 +743,15 @@ static inline u32 atc_calc_bytes_left(u32 current_len, u32 ctrla)
 }
 
 /**
- * atc_get_bytes_left - get the number of bytes residue for a cookie.
+ * atc_get_residue - get the number of bytes residue for a cookie.
  * The residue is passed by address and updated on success.
  * @chan: DMA channel
  * @cookie: transaction identifier to check status of
  * @residue: residue to be updated.
  * Return 0 on success, -errono otherwise.
  */
-static int atc_get_bytes_left(struct dma_chan *chan, dma_cookie_t cookie,
-			      u32 *residue)
+static int atc_get_residue(struct dma_chan *chan, dma_cookie_t cookie,
+			   u32 *residue)
 {
 	struct at_dma_chan      *atchan = to_at_dma_chan(chan);
 	struct at_desc *desc_first = atc_first_active(atchan);
@@ -1913,10 +1913,7 @@ atc_tx_status(struct dma_chan *chan,
 		return dma_status;
 
 	spin_lock_irqsave(&atchan->lock, flags);
-
-	/*  Get number of bytes left in the active transactions */
-	ret = atc_get_bytes_left(chan, cookie, &residue);
-
+	ret = atc_get_residue(chan, cookie, &residue);
 	spin_unlock_irqrestore(&atchan->lock, flags);
 
 	if (unlikely(ret < 0)) {
-- 
2.25.1

