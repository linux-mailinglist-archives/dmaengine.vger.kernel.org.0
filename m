Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E32E611787
	for <lists+dmaengine@lfdr.de>; Fri, 28 Oct 2022 18:31:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230293AbiJ1QbY (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 28 Oct 2022 12:31:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229968AbiJ1QbX (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 28 Oct 2022 12:31:23 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F195C1C73D1;
        Fri, 28 Oct 2022 09:31:21 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 29SGVIRV009012;
        Fri, 28 Oct 2022 11:31:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1666974678;
        bh=7aMKQAHE01RLpeN36QolcinSJvyqvU8P9/9KHcHaxbs=;
        h=From:To:CC:Subject:Date;
        b=EOsGul9P/eZJIOHjJjAv0rKGBcr80fUv/Fc9NVqzFDyTY0JKXcSke94pGV8ls1b2t
         QFi9jIRMQg7aKSdSblnpWGEWOoIbMYiaYik/WCQbobXPI5lG3sgUFJIxkZwYySv9Ki
         4jXIAC1Dbifa9K5gl9QXS6jowX3SRac6ZiSspx9A=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 29SGVIjX130499
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 28 Oct 2022 11:31:18 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Fri, 28
 Oct 2022 11:31:18 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Fri, 28 Oct 2022 11:31:18 -0500
Received: from jti.ent.ti.com (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 29SGVBYf003448;
        Fri, 28 Oct 2022 11:31:13 -0500
From:   Georgi Vlaev <g-vlaev@ti.com>
To:     Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        Vinod Koul <vkoul@kernel.org>
CC:     Nishanth Menon <nm@ti.com>, <dmaengine@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Georgi Vlaev <g-vlaev@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>
Subject: [PATCH] dmaengine: k3-udma: Add system suspend/resume support
Date:   Fri, 28 Oct 2022 19:30:50 +0300
Message-ID: <20221028163050.248074-1-g-vlaev@ti.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Vignesh Raghavendra <vigneshr@ti.com>

The K3 platforms configure the DMA resources with the
help of the TI's System Firmware's Device Manager(DM)
over TISCI. The group of DMA related Resource Manager[1]
TISCI messages includes: INTA, RINGACC, UDMAP, and PSI-L.
This configuration however, does not persist in the DM
after leaving from Suspend-to-RAM state. We have to restore
the DMA channel configuration over TISCI for all configured
channels when entering suspend.

The TISCI resource management calls for each DMA type (UDMA,
PKTDMA, BCDMA) happen in device_free_chan_resources() and
device_alloc_chan_resources(). In pm_suspend() we store
the current udma_chan_config for channels that still have
attached clients and call device_free_chan_resources().
In pm_resume() restore the udma_channel_config from backup
and call device_alloc_chan_resources() for those channels.
Drivers like CPSW can do their own DMA resource management,
so use the late system suspend/resume hooks.

[1] https://software-dl.ti.com/tisci/esd/latest/2_tisci_msgs/index.html#resource-management-rm

Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
[g-vlaev@ti.com: Add patch description and config backup]
[g-vlaev@ti.com: Supend only channels with clients]
Signed-off-by: Georgi Vlaev <g-vlaev@ti.com>
---
 drivers/dma/ti/k3-udma.c | 55 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
index ce8b80bb34d7..efcc1c5ddb2d 100644
--- a/drivers/dma/ti/k3-udma.c
+++ b/drivers/dma/ti/k3-udma.c
@@ -194,6 +194,7 @@ struct udma_dev {
 	int rchan_cnt;
 	int rflow_cnt;
 	int tflow_cnt;
+	int ch_count;
 	unsigned long *bchan_map;
 	unsigned long *tchan_map;
 	unsigned long *rchan_map;
@@ -304,6 +305,8 @@ struct udma_chan {
 
 	/* Channel configuration parameters */
 	struct udma_chan_config config;
+	/* Channel configuration parameters (backup) */
+	struct udma_chan_config backup_config;
 
 	/* dmapool for packet mode descriptors */
 	bool use_dma_pool;
@@ -4999,6 +5002,7 @@ static int setup_resources(struct udma_dev *ud)
 	if (!ch_count)
 		return -ENODEV;
 
+	ud->ch_count = ch_count;
 	ud->channels = devm_kcalloc(dev, ch_count, sizeof(*ud->channels),
 				    GFP_KERNEL);
 	if (!ud->channels)
@@ -5491,11 +5495,62 @@ static int udma_probe(struct platform_device *pdev)
 	return ret;
 }
 
+static int udma_pm_suspend(struct device *dev)
+{
+	struct udma_dev *ud = dev_get_drvdata(dev);
+	struct dma_chan *chan;
+	int i;
+
+	for (i = 0; i < ud->ch_count; i++) {
+		chan = &ud->channels[i].vc.chan;
+		if (chan->client_count) {
+			/* backup the channel configuration */
+			memcpy(&ud->channels[i].backup_config,
+			       &ud->channels[i].config,
+			       sizeof(struct udma_chan_config));
+			dev_dbg(dev, "Suspending channel %s\n",
+				dma_chan_name(chan));
+			ud->ddev.device_free_chan_resources(chan);
+		}
+	}
+
+	return 0;
+}
+
+static int udma_pm_resume(struct device *dev)
+{
+	struct udma_dev *ud = dev_get_drvdata(dev);
+	struct dma_chan *chan;
+	int ret, i;
+
+	for (i = 0; i < ud->ch_count; i++) {
+		chan = &ud->channels[i].vc.chan;
+		if (chan->client_count) {
+			/* restore the channel configuration */
+			memcpy(&ud->channels[i].config,
+			       &ud->channels[i].backup_config,
+			       sizeof(struct udma_chan_config));
+			dev_dbg(dev, "Resuming channel %s\n",
+				dma_chan_name(chan));
+			ret = ud->ddev.device_alloc_chan_resources(chan);
+			if (ret)
+				return ret;
+		}
+	}
+
+	return 0;
+}
+
+static const struct dev_pm_ops udma_pm_ops = {
+	SET_LATE_SYSTEM_SLEEP_PM_OPS(udma_pm_suspend, udma_pm_resume)
+};
+
 static struct platform_driver udma_driver = {
 	.driver = {
 		.name	= "ti-udma",
 		.of_match_table = udma_of_match,
 		.suppress_bind_attrs = true,
+		.pm = &udma_pm_ops,
 	},
 	.probe		= udma_probe,
 };
-- 
2.30.2

