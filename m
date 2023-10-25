Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BC257D683F
	for <lists+dmaengine@lfdr.de>; Wed, 25 Oct 2023 12:22:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234393AbjJYKWL (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 25 Oct 2023 06:22:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234511AbjJYKWK (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 25 Oct 2023 06:22:10 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8642313A;
        Wed, 25 Oct 2023 03:22:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1698229326; x=1729765326;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zSkOZ12TKc1wwVLKvzsXxeC5tl7G/J3ooSzJ/My7COk=;
  b=dtYfoyF930juvfEIYDqEWu6ebbQzvSjfroVNhTMmUu/kQ5S+BQuOkdzb
   uUSuTik28Ham2wHB7hLiMJuzZJJ+2RqSWLHwKHp3EZ2rDiNGBu94rQfus
   2oFDFOpGxUaiFA/At/KdVz7i1J7mkRuhBMt3mt77k9qitaHttenGAUnjt
   oObgC/ZXYzOzauEgXKKywZUC3OO76RIn7pvzcwZm5KDcvj4ZLpfd1oaLD
   QkwT/Zn/A9l+zTAlXeqqPZiFJP2r8Gov407sw59ZGFak/IljfUmtWtj67
   Z6CnOVqeHinkK7t4bjyYDUOmaUErYpUSjpwM8AlH4NvCG0egi7AoHnDE8
   g==;
X-CSE-ConnectionGUID: lZ11uPMKRAauSrL+tx1Dsw==
X-CSE-MsgGUID: mq3IHkvsRjy/Gl6qLK7KjA==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.03,250,1694761200"; 
   d="scan'208";a="10565833"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 Oct 2023 03:22:05 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 25 Oct 2023 03:21:50 -0700
Received: from microchip1-OptiPlex-9020.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.21 via Frontend Transport; Wed, 25 Oct 2023 03:21:45 -0700
From:   shravan chippa <shravan.chippa@microchip.com>
To:     <green.wan@sifive.com>, <vkoul@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <palmer@dabbelt.com>,
        <paul.walmsley@sifive.com>, <conor+dt@kernel.org>
CC:     <dmaengine@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <nagasuresh.relli@microchip.com>, <praveen.kumar@microchip.com>,
        <shravan.chippa@microchip.com>
Subject: [PATCH v3 1/4] dmaengine: sf-pdma: Support of_dma_controller_register()
Date:   Wed, 25 Oct 2023 15:52:48 +0530
Message-ID: <20231025102251.3369472-2-shravan.chippa@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231025102251.3369472-1-shravan.chippa@microchip.com>
References: <20231025102251.3369472-1-shravan.chippa@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Shravan Chippa <shravan.chippa@microchip.com>

Update sf-pdma driver to adopt generic DMA device tree bindings.
It calls of_dma_controller_register() with sf-pdma specific
of_dma_xlate to get the generic DMA device tree helper support
and the DMA clients can look up the sf-pdma controller using
standard APIs.

Signed-off-by: Shravan Chippa <shravan.chippa@microchip.com>
---
 drivers/dma/sf-pdma/sf-pdma.c | 44 +++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/drivers/dma/sf-pdma/sf-pdma.c b/drivers/dma/sf-pdma/sf-pdma.c
index d1c6956af452..4c456bdef882 100644
--- a/drivers/dma/sf-pdma/sf-pdma.c
+++ b/drivers/dma/sf-pdma/sf-pdma.c
@@ -20,6 +20,7 @@
 #include <linux/mod_devicetable.h>
 #include <linux/dma-mapping.h>
 #include <linux/of.h>
+#include <linux/of_dma.h>
 #include <linux/slab.h>
 
 #include "sf-pdma.h"
@@ -490,6 +491,33 @@ static void sf_pdma_setup_chans(struct sf_pdma *pdma)
 	}
 }
 
+static struct dma_chan *sf_pdma_of_xlate(struct of_phandle_args *dma_spec,
+					 struct of_dma *ofdma)
+{
+	struct sf_pdma *pdma = ofdma->of_dma_data;
+	struct device *dev = pdma->dma_dev.dev;
+	struct sf_pdma_chan *chan;
+	struct dma_chan *c;
+	u32 channel_id;
+
+	if (dma_spec->args_count != 1) {
+		dev_err(dev, "Bad number of cells\n");
+		return NULL;
+	}
+
+	channel_id = dma_spec->args[0];
+
+	chan = &pdma->chans[channel_id];
+
+	c = dma_get_slave_channel(&chan->vchan.chan);
+	if (!c) {
+		dev_err(dev, "No more channels available\n");
+		return NULL;
+	}
+
+	return c;
+}
+
 static int sf_pdma_probe(struct platform_device *pdev)
 {
 	struct sf_pdma *pdma;
@@ -563,7 +591,20 @@ static int sf_pdma_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	ret = of_dma_controller_register(pdev->dev.of_node,
+					 sf_pdma_of_xlate, pdma);
+	if (ret < 0) {
+		dev_err(&pdev->dev,
+			"Can't register SiFive Platform OF_DMA. (%d)\n", ret);
+		goto err_unregister;
+	}
+
 	return 0;
+
+err_unregister:
+	dma_async_device_unregister(&pdma->dma_dev);
+
+	return ret;
 }
 
 static int sf_pdma_remove(struct platform_device *pdev)
@@ -583,6 +624,9 @@ static int sf_pdma_remove(struct platform_device *pdev)
 		tasklet_kill(&ch->err_tasklet);
 	}
 
+	if (pdev->dev.of_node)
+		of_dma_controller_free(pdev->dev.of_node);
+
 	dma_async_device_unregister(&pdma->dma_dev);
 
 	return 0;
-- 
2.34.1

