Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8947F6CEFC8
	for <lists+dmaengine@lfdr.de>; Wed, 29 Mar 2023 18:50:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229638AbjC2Qul (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 29 Mar 2023 12:50:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230375AbjC2Qui (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 29 Mar 2023 12:50:38 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B14E44ECA;
        Wed, 29 Mar 2023 09:50:33 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 32TFs3Qw039376;
        Wed, 29 Mar 2023 10:54:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1680105243;
        bh=WAzoF+GZ+3htx/VecrbaI/auuYHR+49PsTPPUQMF9fo=;
        h=From:To:CC:Subject:Date;
        b=QNCgjYaGUl2ggyS+Xl7rkFLwYDmnJoLEj+N7JSDkGZbKTfD/+F2dECcnnaCfbAQEw
         EHbE4G8ItFF5rchf4V2+3vZF4+DB+iQX/yeQGKh3tbZlAlQ5+7oy/VAf/5gm3hvEse
         5AWbmmlwh63hIcP7wAXrVOheqvPdBT23ZHApr8Cc=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 32TFs3U8016342
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 29 Mar 2023 10:54:03 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Wed, 29
 Mar 2023 10:54:02 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Wed, 29 Mar 2023 10:54:02 -0500
Received: from uda0132425.dhcp.ti.com (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 32TFs03H081701;
        Wed, 29 Mar 2023 10:54:01 -0500
From:   Vignesh Raghavendra <vigneshr@ti.com>
To:     Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        Vinod Koul <vkoul@kernel.org>
CC:     <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [RESEND PATCH v2] dmaengine: ti: k3-udma: Add system suspend/resume support
Date:   Wed, 29 Mar 2023 21:23:49 +0530
Message-ID: <20230329155349.2566010-1-vigneshr@ti.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The K3 platforms configure the DMA resources with the
help of the TI's System Firmware's Device Manager(DM)
over TISCI. The group of DMA related Resource Manager[1]
TISCI messages includes: INTA, RINGACC, UDMAP, and PSI-L.
This configuration however, does not persist in the DM
after leaving from Suspend-to-RAM state. We have to restore
the DMA channel configuration over TISCI for all configured
channels when returning from suspend.

The TISCI resource management calls for each DMA type (UDMA,
PKTDMA, BCDMA) happen in device_free_chan_resources() and
device_alloc_chan_resources(). In pm_suspend() we store
the current udma_chan_config for channels that still have
attached clients and call device_free_chan_resources().
In pm_resume() restore the udma_channel_config from backup
and call device_alloc_chan_resources() for those channels.

Drivers like CPSW that use k3-udma-glue already do their own
DMA resource management so use the late system suspend/resume hooks.

[1] https://software-dl.ti.com/tisci/esd/latest/2_tisci_msgs/index.html#resource-management-rm

Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
[g-vlaev@ti.com: Add patch description and config backup]
[g-vlaev@ti.com: Supend only channels with clients]
Signed-off-by: Georgi Vlaev <g-vlaev@ti.com>
Acked-by: Peter Ujfalusi <peter.ujfalusi@gmail.com>
---

RESEND v2:
Collect Peter's ACK, reword commit msg to reflect glue layer state

v2: https://lore.kernel.org/all/20221103203021.83929-1-g-vlaev@ti.com/

 drivers/dma/ti/k3-udma.c | 54 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
index 7e23a6fdef95..f652a217be76 100644
--- a/drivers/dma/ti/k3-udma.c
+++ b/drivers/dma/ti/k3-udma.c
@@ -305,6 +305,8 @@ struct udma_chan {
 
 	/* Channel configuration parameters */
 	struct udma_chan_config config;
+	/* Channel configuration parameters (backup) */
+	struct udma_chan_config backup_config;
 
 	/* dmapool for packet mode descriptors */
 	bool use_dma_pool;
@@ -5522,11 +5524,63 @@ static int udma_probe(struct platform_device *pdev)
 	return ret;
 }
 
+static int udma_pm_suspend(struct device *dev)
+{
+	struct udma_dev *ud = dev_get_drvdata(dev);
+	struct dma_device *dma_dev = &ud->ddev;
+	struct dma_chan *chan;
+	struct udma_chan *uc;
+
+	list_for_each_entry(chan, &dma_dev->channels, device_node) {
+		if (chan->client_count) {
+			uc = to_udma_chan(chan);
+			/* backup the channel configuration */
+			memcpy(&uc->backup_config, &uc->config,
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
+	struct dma_device *dma_dev = &ud->ddev;
+	struct dma_chan *chan;
+	struct udma_chan *uc;
+	int ret;
+
+	list_for_each_entry(chan, &dma_dev->channels, device_node) {
+		if (chan->client_count) {
+			uc = to_udma_chan(chan);
+			/* restore the channel configuration */
+			memcpy(&uc->config, &uc->backup_config,
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
2.40.0

