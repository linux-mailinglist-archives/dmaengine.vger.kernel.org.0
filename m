Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E54CF5B9942
	for <lists+dmaengine@lfdr.de>; Thu, 15 Sep 2022 13:03:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbiIOLDI (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 15 Sep 2022 07:03:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbiIOLDF (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 15 Sep 2022 07:03:05 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB4249926A;
        Thu, 15 Sep 2022 04:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1663239784; x=1694775784;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=av/U6KT9yFLokAuDs4tMmkap8eqS82vv/SKP3XHySxE=;
  b=aKrGRw0VP17DwMtStx+Nu+Krs6TdTSPeBmHUFZVlNLGLo2eQb63weGRd
   Bv0ee6HncCM/jn/grzkCnOIYthyuQ2WOhwTlODjRcliK7gPig9wDehjHQ
   OyGu1lLs4E2HYC8X2zHH7+UOo9twJGTfAIBQReYPG/f33AQ1cpKDKIN8s
   VjBo7pAjGxnUpZuGDZQ229IhX0SIDctf5q7e4Alxg7Rl/d5c9n/xWoTeY
   yuY7lnqFf/eYTOI61llpiV0fySWhH5HElF2hrPbQjZHFutoj5/ngf6Ej5
   8dN5Vx4biAZxSy5LGaRKuPeeh0DO19SQSM0Kbrr3P9GiTZnmd/wP9kcqr
   A==;
X-IronPort-AV: E=Sophos;i="5.93,317,1654585200"; 
   d="scan'208";a="113813863"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 15 Sep 2022 04:03:04 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Thu, 15 Sep 2022 04:03:02 -0700
Received: from localhost.localdomain (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.12 via Frontend Transport; Thu, 15 Sep 2022 04:03:00 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <ludovic.desroches@microchip.com>, <tudor.ambarus@microchip.com>,
        <vkoul@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 2/3] dmaengine: at_xdmac: align properly function members
Date:   Thu, 15 Sep 2022 14:05:15 +0300
Message-ID: <20220915110516.4160443-3-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20220915110516.4160443-1-claudiu.beznea@microchip.com>
References: <20220915110516.4160443-1-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Align properly function members.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/dma/at_xdmac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/at_xdmac.c b/drivers/dma/at_xdmac.c
index 090bab2196ab..a9278bf4c17b 100644
--- a/drivers/dma/at_xdmac.c
+++ b/drivers/dma/at_xdmac.c
@@ -1527,7 +1527,7 @@ at_xdmac_prep_dma_memset_sg(struct dma_chan *chan, struct scatterlist *sgl,
 
 static enum dma_status
 at_xdmac_tx_status(struct dma_chan *chan, dma_cookie_t cookie,
-		struct dma_tx_state *txstate)
+		   struct dma_tx_state *txstate)
 {
 	struct at_xdmac_chan	*atchan = to_at_xdmac_chan(chan);
 	struct at_xdmac		*atxdmac = to_at_xdmac(atchan->chan.device);
-- 
2.34.1

