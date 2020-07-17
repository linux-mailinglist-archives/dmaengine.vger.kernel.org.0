Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CA17223C43
	for <lists+dmaengine@lfdr.de>; Fri, 17 Jul 2020 15:20:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726777AbgGQNUw (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 17 Jul 2020 09:20:52 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:38258 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726524AbgGQNUv (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 17 Jul 2020 09:20:51 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 06HDKlXi049213;
        Fri, 17 Jul 2020 08:20:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1594992047;
        bh=xi7PoJKvmM9K20//9jEe2vQosDqzLT+FXgKG56FGF3M=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=wK6JLwdrAkZq+dwXBDDPgY7YFnrboqXm7gwLw2fmWMEtJ55MAh/0TOloB6zLaoD+J
         sDghpJqeUdDIbsqsm2aVY6DlthGVQjCc/3hdPORHjXVmCodOJTsQkENsi2/46oAlmf
         HmHgHt1K8VhKZljylOGt3uD7kwntw3LAtIlQZjn8=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 06HDKlg1018199
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 17 Jul 2020 08:20:47 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 17
 Jul 2020 08:20:47 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 17 Jul 2020 08:20:47 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 06HDKkOT107722;
        Fri, 17 Jul 2020 08:20:47 -0500
From:   Grygorii Strashko <grygorii.strashko@ti.com>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Vinod Koul <vkoul@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        <dmaengine@vger.kernel.org>, Sekhar Nori <nsekhar@ti.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [PATCH next v2 5/6] soc: ti: k3-ringacc: separate soc specific initialization
Date:   Fri, 17 Jul 2020 16:20:18 +0300
Message-ID: <20200717132019.20427-6-grygorii.strashko@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200717132019.20427-1-grygorii.strashko@ti.com>
References: <20200717132019.20427-1-grygorii.strashko@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Separate SoC specific initialization and and OF mach data in preparation of
adding support for more K3 SoCs

Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
Reviewed-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/soc/ti/k3-ringacc.c | 70 +++++++++++++++++++++++++++++--------
 1 file changed, 55 insertions(+), 15 deletions(-)

diff --git a/drivers/soc/ti/k3-ringacc.c b/drivers/soc/ti/k3-ringacc.c
index 4cf1150de88e..1979479db58d 100644
--- a/drivers/soc/ti/k3-ringacc.c
+++ b/drivers/soc/ti/k3-ringacc.c
@@ -161,6 +161,10 @@ struct k3_ring {
 	int		proxy_id;
 };
 
+struct k3_ringacc_ops {
+	int (*init)(struct platform_device *pdev, struct k3_ringacc *ringacc);
+};
+
 /**
  * struct k3_ringacc - Rings accelerator descriptor
  *
@@ -179,6 +183,7 @@ struct k3_ring {
  * @tisci: pointer ti-sci handle
  * @tisci_ring_ops: ti-sci rings ops
  * @tisci_dev_id: ti-sci device id
+ * @ops: SoC specific ringacc operation
  */
 struct k3_ringacc {
 	struct device *dev;
@@ -199,6 +204,8 @@ struct k3_ringacc {
 	const struct ti_sci_handle *tisci;
 	const struct ti_sci_rm_ringacc_ops *tisci_ring_ops;
 	u32 tisci_dev_id;
+
+	const struct k3_ringacc_ops *ops;
 };
 
 static long k3_ringacc_ring_get_fifo_pos(struct k3_ring *ring)
@@ -1077,21 +1084,14 @@ static int k3_ringacc_probe_dt(struct k3_ringacc *ringacc)
 						 ringacc->rm_gp_range);
 }
 
-static int k3_ringacc_probe(struct platform_device *pdev)
+static int k3_ringacc_init(struct platform_device *pdev,
+			   struct k3_ringacc *ringacc)
 {
-	struct k3_ringacc *ringacc;
 	void __iomem *base_fifo, *base_rt;
 	struct device *dev = &pdev->dev;
 	struct resource *res;
 	int ret, i;
 
-	ringacc = devm_kzalloc(dev, sizeof(*ringacc), GFP_KERNEL);
-	if (!ringacc)
-		return -ENOMEM;
-
-	ringacc->dev = dev;
-	mutex_init(&ringacc->req_lock);
-
 	dev->msi_domain = of_msi_get_domain(dev, dev->of_node,
 					    DOMAIN_BUS_TI_SCI_INTA_MSI);
 	if (!dev->msi_domain) {
@@ -1150,14 +1150,9 @@ static int k3_ringacc_probe(struct platform_device *pdev)
 		ringacc->rings[i].ring_id = i;
 		ringacc->rings[i].proxy_id = K3_RINGACC_PROXY_NOT_USED;
 	}
-	dev_set_drvdata(dev, ringacc);
 
 	ringacc->tisci_ring_ops = &ringacc->tisci->ops.rm_ring_ops;
 
-	mutex_lock(&k3_ringacc_list_lock);
-	list_add_tail(&ringacc->list, &k3_ringacc_list);
-	mutex_unlock(&k3_ringacc_list_lock);
-
 	dev_info(dev, "Ring Accelerator probed rings:%u, gp-rings[%u,%u] sci-dev-id:%u\n",
 		 ringacc->num_rings,
 		 ringacc->rm_gp_range->desc[0].start,
@@ -1167,15 +1162,60 @@ static int k3_ringacc_probe(struct platform_device *pdev)
 		 ringacc->dma_ring_reset_quirk ? "enabled" : "disabled");
 	dev_info(dev, "RA Proxy rev. %08x, num_proxies:%u\n",
 		 readl(&ringacc->proxy_gcfg->revision), ringacc->num_proxies);
+
 	return 0;
 }
 
+struct ringacc_match_data {
+	struct k3_ringacc_ops ops;
+};
+
+static struct ringacc_match_data k3_ringacc_data = {
+	.ops = {
+		.init = k3_ringacc_init,
+	},
+};
+
 /* Match table for of_platform binding */
 static const struct of_device_id k3_ringacc_of_match[] = {
-	{ .compatible = "ti,am654-navss-ringacc", },
+	{ .compatible = "ti,am654-navss-ringacc", .data = &k3_ringacc_data, },
 	{},
 };
 
+static int k3_ringacc_probe(struct platform_device *pdev)
+{
+	const struct ringacc_match_data *match_data;
+	const struct of_device_id *match;
+	struct device *dev = &pdev->dev;
+	struct k3_ringacc *ringacc;
+	int ret;
+
+	match = of_match_node(k3_ringacc_of_match, dev->of_node);
+	if (!match)
+		return -ENODEV;
+	match_data = match->data;
+
+	ringacc = devm_kzalloc(dev, sizeof(*ringacc), GFP_KERNEL);
+	if (!ringacc)
+		return -ENOMEM;
+
+	ringacc->dev = dev;
+	mutex_init(&ringacc->req_lock);
+	ringacc->ops = &match_data->ops;
+
+	ret = ringacc->ops->init(pdev, ringacc);
+	if (ret)
+		return ret;
+
+	dev_set_drvdata(dev, ringacc);
+
+	mutex_lock(&k3_ringacc_list_lock);
+	list_add_tail(&ringacc->list, &k3_ringacc_list);
+	mutex_unlock(&k3_ringacc_list_lock);
+
+	return 0;
+}
+
 static struct platform_driver k3_ringacc_driver = {
 	.probe		= k3_ringacc_probe,
 	.driver		= {
-- 
2.17.1

