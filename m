Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4680B1294C3
	for <lists+dmaengine@lfdr.de>; Mon, 23 Dec 2019 12:07:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727363AbfLWLGH (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 23 Dec 2019 06:06:07 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:52768 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727354AbfLWLGG (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 23 Dec 2019 06:06:06 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id xBNB5vOD067342;
        Mon, 23 Dec 2019 05:05:57 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1577099157;
        bh=r1gS6mo4nypLVCopYeBhWj8jG7dU7VspthOGMAgLfCc=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=reCILNYQ06w6nhsoWm1LzMu9B8gj/GCwuN1tm6THht27TG84HqLsyP7ae/mdy2r1O
         oN1QZ4rhvak5Hwd2tHRSx3TbQOPuVqEen+XALH4mX2F2bXCq+zwVuST7JIwIR1YdKq
         UygbiAcxyJLukkL898z3D1lsK8e2t4lxh8Nel/SE=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id xBNB5vku026316
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 23 Dec 2019 05:05:57 -0600
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Mon, 23
 Dec 2019 05:05:47 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Mon, 23 Dec 2019 05:05:47 -0600
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id xBNB4eMN025693;
        Mon, 23 Dec 2019 05:05:43 -0600
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <vkoul@kernel.org>, <robh+dt@kernel.org>, <nm@ti.com>,
        <ssantosh@kernel.org>
CC:     <dan.j.williams@intel.com>, <dmaengine@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <grygorii.strashko@ti.com>, <lokeshvutla@ti.com>,
        <t-kristo@ti.com>, <tony@atomide.com>, <j-keerthy@ti.com>,
        <vigneshr@ti.com>, <frowand.list@gmail.com>
Subject: [PATCH v8 16/18] dmaengine: ti: k3-udma: Allow the driver to be built as module
Date:   Mon, 23 Dec 2019 13:04:56 +0200
Message-ID: <20191223110458.30766-17-peter.ujfalusi@ti.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191223110458.30766-1-peter.ujfalusi@ti.com>
References: <20191223110458.30766-1-peter.ujfalusi@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The ring accelerator driver can be built as module since all depending
functions are exported.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Tested-by: Keerthy <j-keerthy@ti.com>
Reviewed-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
 drivers/dma/ti/Kconfig   |  2 +-
 drivers/dma/ti/k3-udma.c | 29 +++++++++++++++++++++++++++--
 2 files changed, 28 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/ti/Kconfig b/drivers/dma/ti/Kconfig
index f76e06651f80..beb000be7d1b 100644
--- a/drivers/dma/ti/Kconfig
+++ b/drivers/dma/ti/Kconfig
@@ -35,7 +35,7 @@ config DMA_OMAP
 	  DMA engine is found on OMAP and DRA7xx parts.
 
 config TI_K3_UDMA
-	bool "Texas Instruments UDMA support"
+	tristate "Texas Instruments UDMA support"
 	depends on ARCH_K3 || COMPILE_TEST
 	depends on TI_SCI_PROTOCOL
 	depends on TI_SCI_INTA_IRQCHIP
diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
index c97c5f6f1e29..dbed2205065a 100644
--- a/drivers/dma/ti/k3-udma.c
+++ b/drivers/dma/ti/k3-udma.c
@@ -12,6 +12,7 @@
 #include <linux/init.h>
 #include <linux/interrupt.h>
 #include <linux/list.h>
+#include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
@@ -3088,6 +3089,7 @@ static const struct of_device_id udma_of_match[] = {
 	},
 	{ /* Sentinel */ },
 };
+MODULE_DEVICE_TABLE(of, udma_of_match);
 
 static int udma_get_mmrs(struct platform_device *pdev, struct udma_dev *ud)
 {
@@ -3426,15 +3428,38 @@ static int udma_probe(struct platform_device *pdev)
 	return ret;
 }
 
+static int udma_remove(struct platform_device *pdev)
+{
+	struct udma_dev *ud = platform_get_drvdata(pdev);
+	struct udma_chan *uc;
+
+	list_for_each_entry(uc, &ud->ddev.channels, vc.chan.device_node)
+		tasklet_kill(&uc->vc.task);
+
+	of_dma_controller_free(pdev->dev.of_node);
+	dma_async_device_unregister(&ud->ddev);
+
+	/* Make sure that we did proper cleanup */
+	cancel_work_sync(&ud->purge_work);
+	udma_purge_desc_work(&ud->purge_work);
+
+	return 0;
+}
+
 static struct platform_driver udma_driver = {
 	.driver = {
 		.name	= "ti-udma",
 		.of_match_table = udma_of_match,
-		.suppress_bind_attrs = true,
 	},
 	.probe		= udma_probe,
+	.remove		= udma_remove,
 };
-builtin_platform_driver(udma_driver);
+module_platform_driver(udma_driver);
 
 /* Private interfaces to UDMA */
 #include "k3-udma-private.c"
+
+MODULE_ALIAS("platform:ti-udma");
+MODULE_DESCRIPTION("TI K3 DMA driver for CPPI 5.0 compliant devices");
+MODULE_AUTHOR("Peter Ujfalusi <peter.ujfalusi@ti.com>");
+MODULE_LICENSE("GPL v2");
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

