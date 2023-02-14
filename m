Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAA826967E2
	for <lists+dmaengine@lfdr.de>; Tue, 14 Feb 2023 16:21:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233052AbjBNPVU (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 14 Feb 2023 10:21:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233532AbjBNPVM (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 14 Feb 2023 10:21:12 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F2532B631;
        Tue, 14 Feb 2023 07:21:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1676388061; x=1707924061;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qLhOvZL6ESJ8VOsLsLHiNb3s5VJ+t2td+m1FLHyK8zE=;
  b=sh5XeMFrNW627H3ibKTq+U2jQLnfXwU2HjZKV/p+0trsawVz59fo+55p
   1Mk+ADBYqkpoh/TxE/Z9TpbO/cQSsapyPtjyYorqsPzk2p9fDqoFsc/gg
   i5/BHJc/B4LHd9OIhq7kmT+P4lHp4iuANekRpX3O7zSe6XGeNwJRstlBc
   JqhZmpGL5p+DjAckwNS3Gemt8XC3ViDiZp8eBS0sD21++ERZgOSIiQ5bN
   YJik+BzK5jpTLWk3ewJjRn2bkGcgccmTFjjkKx+D2WbckWf3f21rP/lzU
   gp7kcFTx8Pt9XITsPR2qDz8ipCh8LG8ks8XU87gsos4UUA20/gX5emV/7
   A==;
X-IronPort-AV: E=Sophos;i="5.97,296,1669100400"; 
   d="scan'208";a="137131091"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 14 Feb 2023 08:20:58 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 14 Feb 2023 08:20:55 -0700
Received: from m18063-ThinkPad-T460p.mchp-main.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.16 via Frontend Transport; Tue, 14 Feb 2023 08:20:52 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <ludovic.desroches@microchip.com>, <tudor.ambarus@linaro.org>,
        <vkoul@kernel.org>, <nicolas.ferre@microchip.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 5/7] dmaengine: at_xdmac: do not enable all cyclic channels
Date:   Tue, 14 Feb 2023 17:18:25 +0200
Message-ID: <20230214151827.1050280-6-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230214151827.1050280-1-claudiu.beznea@microchip.com>
References: <20230214151827.1050280-1-claudiu.beznea@microchip.com>
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

Do not global enable all the cyclic channels in at_xdmac_resume(). Instead
save the global status in at_xdmac_suspend() and re-enable the cyclic
channel only if it was active before suspend.

Fixes: e1f7c9eee707 ("dmaengine: at_xdmac: creation of the atmel eXtended DMA Controller driver")
Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/dma/at_xdmac.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/at_xdmac.c b/drivers/dma/at_xdmac.c
index 34c004a4b23c..96f1b69f8a75 100644
--- a/drivers/dma/at_xdmac.c
+++ b/drivers/dma/at_xdmac.c
@@ -246,6 +246,7 @@ struct at_xdmac {
 	int			irq;
 	struct clk		*clk;
 	u32			save_gim;
+	u32			save_gs;
 	struct dma_pool		*at_xdmac_desc_pool;
 	const struct at_xdmac_layout	*layout;
 	struct at_xdmac_chan	chan[];
@@ -2162,6 +2163,7 @@ static int __maybe_unused atmel_xdmac_suspend(struct device *dev)
 		}
 	}
 	atxdmac->save_gim = at_xdmac_read(atxdmac, AT_XDMAC_GIM);
+	atxdmac->save_gs = at_xdmac_read(atxdmac, AT_XDMAC_GS);
 
 	at_xdmac_off(atxdmac, false);
 	pm_runtime_mark_last_busy(atxdmac->dev);
@@ -2224,7 +2226,8 @@ static int __maybe_unused atmel_xdmac_resume(struct device *dev)
 			at_xdmac_chan_write(atchan, AT_XDMAC_CNDC, atchan->save_cndc);
 			at_xdmac_chan_write(atchan, AT_XDMAC_CIE, atchan->save_cim);
 			wmb();
-			at_xdmac_write(atxdmac, AT_XDMAC_GE, atchan->mask);
+			if (atxdmac->save_gs & atchan->mask)
+				at_xdmac_write(atxdmac, AT_XDMAC_GE, atchan->mask);
 		}
 	}
 
-- 
2.34.1

