Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E58060C781
	for <lists+dmaengine@lfdr.de>; Tue, 25 Oct 2022 11:07:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231455AbiJYJHa (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 25 Oct 2022 05:07:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231854AbiJYJFw (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 25 Oct 2022 05:05:52 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57E1515A96B;
        Tue, 25 Oct 2022 02:04:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1666688659; x=1698224659;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DNAY7VAtyOz7UkqIW9MBLxULwOivUa2HVnvrZrgiFrY=;
  b=OYICH/C2KwsBGeRh/T1EfGzYWxhQkjVFIw6vMjF2t3U2YITja9hgOVlz
   He5zfm/usiSSxpbT5dzRv++37X1epaW1u86+vRcBuJsDTgqoVXakn3lIt
   BdjwV/0AeST65geSuJd3hjr3whxPTNQ9fVHX6GD9rtUFog1TGYVzdadbA
   l9VcLB5p/QRvrISV7k2RwkGPJVP7A7chiZOTEAW3/rpIisltb6albCFdA
   nAWb8nK3U9gY4pvgXsQnmclhC+ehJBPwujWRIspvUzn+wZ6m8fb7Kzhar
   ruEGIvwGGZ2dXACjYgUmXx5LJF65wKVZ1KsCqKx9xQF1M/6CblrpDHjGZ
   g==;
X-IronPort-AV: E=Sophos;i="5.95,211,1661842800"; 
   d="scan'208";a="120221361"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 25 Oct 2022 02:04:18 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Tue, 25 Oct 2022 02:04:12 -0700
Received: from ROB-ULT-M18064N.mchp-main.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.12 via Frontend Transport; Tue, 25 Oct 2022 02:04:09 -0700
From:   Tudor Ambarus <tudor.ambarus@microchip.com>
To:     <vkoul@kernel.org>, <peda@axentia.se>, <du@axentia.se>
CC:     <maciej.sosnowski@intel.com>, <nicolas.ferre@microchip.com>,
        <mripard@kernel.org>, <torfl6749@gmail.com>,
        <linux-kernel@vger.kernel.org>, <dmaengine@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        "Tudor Ambarus" <tudor.ambarus@microchip.com>
Subject: [PATCH v2 20/32] dmaengine: at_hdmac: s/atc_get_bytes_left/atc_get_residue
Date:   Tue, 25 Oct 2022 12:02:54 +0300
Message-ID: <20221025090306.297886-21-tudor.ambarus@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221025090306.297886-1-tudor.ambarus@microchip.com>
References: <20221025090306.297886-1-tudor.ambarus@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
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
index e2c46f32b284..6c328cd16983 100644
--- a/drivers/dma/at_hdmac.c
+++ b/drivers/dma/at_hdmac.c
@@ -308,15 +308,15 @@ static inline u32 atc_calc_bytes_left(u32 current_len, u32 ctrla)
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
@@ -1471,10 +1471,7 @@ atc_tx_status(struct dma_chan *chan,
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

