Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D48B762DC5B
	for <lists+dmaengine@lfdr.de>; Thu, 17 Nov 2022 14:11:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239701AbiKQNLS (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 17 Nov 2022 08:11:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239737AbiKQNLL (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 17 Nov 2022 08:11:11 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A04DB6B3B5;
        Thu, 17 Nov 2022 05:11:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1668690670; x=1700226670;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JJnRYj7NPQDMFAirw9QUIbVf7WfT2dsZ/Q12yTqq4GA=;
  b=0WeXFwCaJTzVkeEtXoqnICzmQMKHbZCqAb7kAw+8HFrnkpzeySJwco2p
   Qwl0VdD83FifVwdZUr5QktiTk9yATh/tLWcUK53EytwXeOUUOwgJc9ngB
   w9VoGJwvakEgZA7O+XAw27TVY1eI38H3um2L3JInTB+5xwjOY+nGg5YWO
   Cyg4q8nB5lTnJAyXgJ45pyV2x0xVzOLX/q7jfAmi3gsGk95wVTNSn4IzA
   IHoaUKDDW8oB/so9Bzs4JhNCdKns4Px5TnFmhwityKzV4e0/5IneMLqA5
   /qH2Er0/t/kVOQ0vYu4gPmXrcsSqWaHKzgsuUobWrffAo6OYa6XwlMXE1
   A==;
X-IronPort-AV: E=Sophos;i="5.96,171,1665471600"; 
   d="scan'208";a="183993352"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 17 Nov 2022 06:11:09 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Thu, 17 Nov 2022 06:11:06 -0700
Received: from localhost.localdomain (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.12 via Frontend Transport; Thu, 17 Nov 2022 06:11:04 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <tudor.ambarus@microchip.com>, <vkoul@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [RESEND][PATCH 3/3] dmaengine: at_xdmac: remove empty line
Date:   Thu, 17 Nov 2022 15:15:47 +0200
Message-ID: <20221117131547.293044-4-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20221117131547.293044-1-claudiu.beznea@microchip.com>
References: <20221117131547.293044-1-claudiu.beznea@microchip.com>
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

Remove empty line.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/dma/at_xdmac.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/dma/at_xdmac.c b/drivers/dma/at_xdmac.c
index a9278bf4c17b..1f0fab180f8f 100644
--- a/drivers/dma/at_xdmac.c
+++ b/drivers/dma/at_xdmac.c
@@ -533,7 +533,6 @@ static void at_xdmac_start_xfer(struct at_xdmac_chan *atchan,
 		 at_xdmac_chan_read(atchan, AT_XDMAC_CSA),
 		 at_xdmac_chan_read(atchan, AT_XDMAC_CDA),
 		 at_xdmac_chan_read(atchan, AT_XDMAC_CUBC));
-
 }
 
 static dma_cookie_t at_xdmac_tx_submit(struct dma_async_tx_descriptor *tx)
-- 
2.34.1

