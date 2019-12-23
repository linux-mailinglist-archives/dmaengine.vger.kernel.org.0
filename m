Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D7BE51294C0
	for <lists+dmaengine@lfdr.de>; Mon, 23 Dec 2019 12:07:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727355AbfLWLGG (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 23 Dec 2019 06:06:06 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:39124 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726744AbfLWLGF (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 23 Dec 2019 06:06:05 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id xBNB5pFZ032320;
        Mon, 23 Dec 2019 05:05:51 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1577099151;
        bh=rp/62BQYhqoboYRxDYwm8GGofs63IPLsPbjQvI9zhO4=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=SEmFS4yU+Ye4liFn8IDs48Dmku+Fd2i06zwMpWmUJ0x2tL6nti6tHJbiozeT+sWuM
         Cy+VKPC6qySjnpnR39Zn0ko0TnyUpiw7BxYo8aVca+kXXan0aSq/p+UfCpV1EMiGSE
         vulJHo8jxf4D4IKfkKRtZIZPpCnSzmpQkQOETmm0=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id xBNB5p1M026258
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 23 Dec 2019 05:05:51 -0600
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Mon, 23
 Dec 2019 05:05:51 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Mon, 23 Dec 2019 05:05:51 -0600
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id xBNB4eMO025693;
        Mon, 23 Dec 2019 05:05:47 -0600
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <vkoul@kernel.org>, <robh+dt@kernel.org>, <nm@ti.com>,
        <ssantosh@kernel.org>
CC:     <dan.j.williams@intel.com>, <dmaengine@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <grygorii.strashko@ti.com>, <lokeshvutla@ti.com>,
        <t-kristo@ti.com>, <tony@atomide.com>, <j-keerthy@ti.com>,
        <vigneshr@ti.com>, <frowand.list@gmail.com>
Subject: [PATCH v8 17/18] dmaengine: ti: k3-udma-glue: Allow the driver to be built as module
Date:   Mon, 23 Dec 2019 13:04:57 +0200
Message-ID: <20191223110458.30766-18-peter.ujfalusi@ti.com>
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
 drivers/dma/ti/Kconfig        | 2 +-
 drivers/dma/ti/k3-udma-glue.c | 4 +++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/ti/Kconfig b/drivers/dma/ti/Kconfig
index beb000be7d1b..987339e6f517 100644
--- a/drivers/dma/ti/Kconfig
+++ b/drivers/dma/ti/Kconfig
@@ -48,7 +48,7 @@ config TI_K3_UDMA
 	  DMA engine is used in AM65x and j721e.
 
 config TI_K3_UDMA_GLUE_LAYER
-	bool "Texas Instruments UDMA Glue layer for non DMAengine users"
+	tristate "Texas Instruments UDMA Glue layer for non DMAengine users"
 	depends on ARCH_K3 || COMPILE_TEST
 	depends on TI_K3_UDMA
 	help
diff --git a/drivers/dma/ti/k3-udma-glue.c b/drivers/dma/ti/k3-udma-glue.c
index c1511298ece2..fe3f96f6e0a1 100644
--- a/drivers/dma/ti/k3-udma-glue.c
+++ b/drivers/dma/ti/k3-udma-glue.c
@@ -10,7 +10,7 @@
 #include <linux/delay.h>
 #include <linux/dma-mapping.h>
 #include <linux/io.h>
-#include <linux/init.h>
+#include <linux/module.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/soc/ti/k3-ringacc.h>
@@ -1196,3 +1196,5 @@ int k3_udma_glue_rx_get_irq(struct k3_udma_glue_rx_channel *rx_chn,
 	return flow->virq;
 }
 EXPORT_SYMBOL_GPL(k3_udma_glue_rx_get_irq);
+
+MODULE_LICENSE("GPL v2");
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

