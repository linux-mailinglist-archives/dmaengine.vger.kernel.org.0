Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A88662DC55
	for <lists+dmaengine@lfdr.de>; Thu, 17 Nov 2022 14:11:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234917AbiKQNLG (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 17 Nov 2022 08:11:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239669AbiKQNLF (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 17 Nov 2022 08:11:05 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDB946868A;
        Thu, 17 Nov 2022 05:11:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1668690664; x=1700226664;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=av/U6KT9yFLokAuDs4tMmkap8eqS82vv/SKP3XHySxE=;
  b=brDmBiPGkdNSIdasIUDmZ0xG+YEfxnRGbt87t2I6yPe1FQmUS39jpWEI
   XbCdOh/GKPsYXjFzn5iLniD+Iwzyo2jjyzAG1r4u0zjTFwFh9zK61N4GA
   C2hZVOm5XIlXn14H/2XWlP8HNSb32cIqXNigEiaVHfj+2e5XOQ2DRWEDB
   OxDx+uiNWdkHx674U0ya7piisXjPRn4AuVsNBp6HtaiHz+rR2rNTWDplw
   OM9TxzVWA77yN2wXi1MYe1XAFFxrtDUJLjSlHovaEYFLjGiL/jFEajY+i
   dNSfjSoy+V2+WXmz/c0mxoMl49NHXH86ub4eDARss0xnibTDPRNWawNjN
   Q==;
X-IronPort-AV: E=Sophos;i="5.96,171,1665471600"; 
   d="scan'208";a="200217668"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 17 Nov 2022 06:11:04 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Thu, 17 Nov 2022 06:11:04 -0700
Received: from localhost.localdomain (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.12 via Frontend Transport; Thu, 17 Nov 2022 06:11:02 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <tudor.ambarus@microchip.com>, <vkoul@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [RESEND][PATCH 2/3] dmaengine: at_xdmac: align properly function members
Date:   Thu, 17 Nov 2022 15:15:46 +0200
Message-ID: <20221117131547.293044-3-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20221117131547.293044-1-claudiu.beznea@microchip.com>
References: <20221117131547.293044-1-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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

