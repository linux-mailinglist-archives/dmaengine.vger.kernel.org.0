Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E35677B5FC4
	for <lists+dmaengine@lfdr.de>; Tue,  3 Oct 2023 06:21:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230128AbjJCEVM (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 3 Oct 2023 00:21:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230105AbjJCEVL (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 3 Oct 2023 00:21:11 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 864B9BB;
        Mon,  2 Oct 2023 21:21:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1696306869; x=1727842869;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=w9nQM23CfY907qE7wT+2FXo1ONLHkiWlscDbAurV5jU=;
  b=a/vXWqKBkGtkFL+7gTKTi1fPGTChqn5FzDdtGw9+veGqeIE0YjlN7gzX
   xM9cuskNFqjsvGez9KxOSqWMqlPzaVVpDV1Jpq9ImDNy7RUVq6syKM8LE
   +MgCpGkEXbiroeYrKmaBWoE3xuCHN1XGwqKn6jD700RtG0okmdhASGN5X
   3J69LZUieeauk6OBc7F796urSRL6vAdXh2UA0YNzty2IoI2QjChjieFmk
   pI/SvV2FRz84kNp5t1o4FQ26w14N9X3ppZPNjes7KbLYcRCBACt80JY3n
   zuh1woPNqoZfWCXABtfzjmbfh4yR2SZdqlcCIqEp1K+lJyFBToE83AUcl
   w==;
X-CSE-ConnectionGUID: jqZ0WZzzR+yIkleglJXjmA==
X-CSE-MsgGUID: vkkS5b0XQsKBfQM2XXOaQA==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.03,196,1694761200"; 
   d="scan'208";a="7744201"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 Oct 2023 21:21:09 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 2 Oct 2023 21:21:07 -0700
Received: from microchip1-OptiPlex-9020.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.21 via Frontend Transport; Mon, 2 Oct 2023 21:21:02 -0700
From:   shravan chippa <shravan.chippa@microchip.com>
To:     <green.wan@sifive.com>, <vkoul@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <palmer@dabbelt.com>,
        <paul.walmsley@sifive.com>, <conor+dt@kernel.org>
CC:     <dmaengine@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <nagasuresh.relli@microchip.com>, <praveen.kumar@microchip.com>,
        <shravan.chippa@microchip.com>
Subject: [PATCH v2 1/4] dmaengine: sf-pdma: Support of_dma_controller_register()
Date:   Tue, 3 Oct 2023 09:52:12 +0530
Message-ID: <20231003042215.142678-2-shravan.chippa@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231003042215.142678-1-shravan.chippa@microchip.com>
References: <20231003042215.142678-1-shravan.chippa@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
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
index d1c6956af452..06a0912a12a1 100644
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
+	struct sf_pdma_chan  *chan;
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

