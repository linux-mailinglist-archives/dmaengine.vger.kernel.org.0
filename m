Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 28B511294C7
	for <lists+dmaengine@lfdr.de>; Mon, 23 Dec 2019 12:07:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbfLWLGR (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 23 Dec 2019 06:06:17 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:52766 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726918AbfLWLGG (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 23 Dec 2019 06:06:06 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id xBNB5txe067332;
        Mon, 23 Dec 2019 05:05:55 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1577099155;
        bh=VgdWAAJ3Cz8tiJk/iLF7p/5t+YnecUVQdlQ8kNoKFXU=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=UoxeAjlYwCQ2sLKXKo2e9e6TOQhzNiiMKWLsTvljz/X0oleqHX+A9Bl8IJUh1FQnJ
         HBoP/HcHIvF5H/Zn5cGwoRVnF5aTyyomxVrlVGK7jUg4GjQFJK0Ky9eB7hbZ4ZCkQg
         92hWHY1bcsTDib4jaKxFU2nFJDUJbfLbatbKBzpU=
Received: from DFLE101.ent.ti.com (dfle101.ent.ti.com [10.64.6.22])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id xBNB5tJJ041498
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 23 Dec 2019 05:05:55 -0600
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Mon, 23
 Dec 2019 05:05:55 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Mon, 23 Dec 2019 05:05:55 -0600
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id xBNB4eMP025693;
        Mon, 23 Dec 2019 05:05:51 -0600
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <vkoul@kernel.org>, <robh+dt@kernel.org>, <nm@ti.com>,
        <ssantosh@kernel.org>
CC:     <dan.j.williams@intel.com>, <dmaengine@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <grygorii.strashko@ti.com>, <lokeshvutla@ti.com>,
        <t-kristo@ti.com>, <tony@atomide.com>, <j-keerthy@ti.com>,
        <vigneshr@ti.com>, <frowand.list@gmail.com>
Subject: [PATCH v8 18/18] soc: ti: k3-ringacc: Allow the driver to be built as module
Date:   Mon, 23 Dec 2019 13:04:58 +0200
Message-ID: <20191223110458.30766-19-peter.ujfalusi@ti.com>
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
 drivers/soc/ti/Kconfig      |  2 +-
 drivers/soc/ti/k3-ringacc.c | 29 ++++++++++++++++++++++++++---
 2 files changed, 27 insertions(+), 4 deletions(-)

diff --git a/drivers/soc/ti/Kconfig b/drivers/soc/ti/Kconfig
index 4486e055794c..bdce98f68a3e 100644
--- a/drivers/soc/ti/Kconfig
+++ b/drivers/soc/ti/Kconfig
@@ -81,7 +81,7 @@ config TI_SCI_PM_DOMAINS
 	  rootfs may be available.
 
 config TI_K3_RINGACC
-	bool "K3 Ring accelerator Sub System"
+	tristate "K3 Ring accelerator Sub System"
 	depends on ARCH_K3 || COMPILE_TEST
 	depends on TI_SCI_INTA_IRQCHIP
 	help
diff --git a/drivers/soc/ti/k3-ringacc.c b/drivers/soc/ti/k3-ringacc.c
index 5fb2ee2ac978..fd9f35b7c9a6 100644
--- a/drivers/soc/ti/k3-ringacc.c
+++ b/drivers/soc/ti/k3-ringacc.c
@@ -7,7 +7,7 @@
 
 #include <linux/dma-mapping.h>
 #include <linux/io.h>
-#include <linux/init.h>
+#include <linux/module.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/soc/ti/k3-ringacc.h>
@@ -264,6 +264,11 @@ struct k3_ring *k3_ringacc_request_ring(struct k3_ringacc *ringacc,
 
 	mutex_lock(&ringacc->req_lock);
 
+	if (!try_module_get(ringacc->dev->driver->owner)) {
+		mutex_unlock(&ringacc->req_lock);
+		return NULL;
+	}
+
 	if (id == K3_RINGACC_RING_ID_ANY) {
 		/* Request for any general purpose ring */
 		struct ti_sci_resource_desc *gp_rings =
@@ -308,6 +313,7 @@ struct k3_ring *k3_ringacc_request_ring(struct k3_ringacc *ringacc,
 	return &ringacc->rings[id];
 
 error:
+	module_put(ringacc->dev->driver->owner);
 	mutex_unlock(&ringacc->req_lock);
 	return NULL;
 }
@@ -488,6 +494,8 @@ int k3_ringacc_ring_free(struct k3_ring *ring)
 no_init:
 	clear_bit(ring->ring_id, ringacc->rings_inuse);
 
+	module_put(ringacc->dev->driver->owner);
+
 out:
 	mutex_unlock(&ringacc->req_lock);
 	return 0;
@@ -1140,18 +1148,33 @@ static int k3_ringacc_probe(struct platform_device *pdev)
 	return 0;
 }
 
+static int k3_ringacc_remove(struct platform_device *pdev)
+{
+	struct k3_ringacc *ringacc = dev_get_drvdata(&pdev->dev);
+
+	mutex_lock(&k3_ringacc_list_lock);
+	list_del(&ringacc->list);
+	mutex_unlock(&k3_ringacc_list_lock);
+	return 0;
+}
+
 /* Match table for of_platform binding */
 static const struct of_device_id k3_ringacc_of_match[] = {
 	{ .compatible = "ti,am654-navss-ringacc", },
 	{},
 };
+MODULE_DEVICE_TABLE(of, k3_ringacc_of_match);
 
 static struct platform_driver k3_ringacc_driver = {
 	.probe		= k3_ringacc_probe,
+	.remove		= k3_ringacc_remove,
 	.driver		= {
 		.name	= "k3-ringacc",
 		.of_match_table = k3_ringacc_of_match,
-		.suppress_bind_attrs = true,
 	},
 };
-builtin_platform_driver(k3_ringacc_driver);
+module_platform_driver(k3_ringacc_driver);
+
+MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("TI Ringacc driver for K3 SOCs");
+MODULE_AUTHOR("Grygorii Strashko <grygorii.strashko@ti.com>");
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

