Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A21514BBF26
	for <lists+dmaengine@lfdr.de>; Fri, 18 Feb 2022 19:12:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239020AbiBRSNA (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 18 Feb 2022 13:13:00 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239023AbiBRSM6 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 18 Feb 2022 13:12:58 -0500
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3086B35DFC;
        Fri, 18 Feb 2022 10:12:39 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 1F65820004;
        Fri, 18 Feb 2022 18:12:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1645207955;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IC8lFvXRL1fNo+5ENEfO2RVo3H7nGIfCsrQqrZ/74nk=;
        b=jHPHZivsTTsI1vnJ/i/p0Kt78pXiE0v1bZ4Vv3TVpTe/Yd2cyWiZHY9gdFv+AFdRWQzJna
        FBmqbnPbQOy8SXH19jsFNqRG6FcfVO0Qq5Wt3b3gQL5ZnRwjbp6KTiXY6cOn52W4MPu5Uh
        Du2f6+boFc4x5F9p5hEqCam5WwHi49CUxcU75xV+rkmBD0Dm6w8u36TS4GHhtSIzbf1PMK
        PAlfYunut5SR5yTNUtoQVS8tpRiQuCyQE8J3goPLm39Uh0w+XjoIJu8Tqx+HRUYyjUP/zK
        iiflf5w6cuwHXJe9bK8UCqHr9d3I4fahprv9s526TXWa4//O/sudL9kow1DX1w==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Viresh Kumar <vireshk@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Vinod Koul <vkoul@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        dmaengine@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-clk@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Milan Stevanovic <milan.stevanovic@se.com>,
        Jimmy Lalande <jimmy.lalande@se.com>,
        Laetitia MARIOTTINI <laetitia.mariottini@se.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH 4/8] dma: dmamux: Introduce RZN1 DMA router support
Date:   Fri, 18 Feb 2022 19:12:22 +0100
Message-Id: <20220218181226.431098-5-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220218181226.431098-1-miquel.raynal@bootlin.com>
References: <20220218181226.431098-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The Renesas RZN1 DMA IP is a based on a DW core, with eg. an additional
dmamux register located in the system control area which can take up to
32 requests (16 per DMA controller). Each DMA channel can be wired to
two different peripherals.

We need two additional information from the 'dmas' property: the channel
(bit in the dmamux register) that must be accessed and the value of the
mux for this channel.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/dma/dw/Makefile |   2 +-
 drivers/dma/dw/dmamux.c | 175 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 176 insertions(+), 1 deletion(-)
 create mode 100644 drivers/dma/dw/dmamux.c

diff --git a/drivers/dma/dw/Makefile b/drivers/dma/dw/Makefile
index a6f358ad8591..d8cfbf36b381 100644
--- a/drivers/dma/dw/Makefile
+++ b/drivers/dma/dw/Makefile
@@ -4,7 +4,7 @@ dw_dmac_core-y			:= core.o dw.o idma32.o
 dw_dmac_core-$(CONFIG_ACPI)	+= acpi.o
 
 obj-$(CONFIG_DW_DMAC)		+= dw_dmac.o
-dw_dmac-y			:= platform.o
+dw_dmac-y			:= platform.o dmamux.o
 dw_dmac-$(CONFIG_OF)		+= of.o
 
 obj-$(CONFIG_DW_DMAC_PCI)	+= dw_dmac_pci.o
diff --git a/drivers/dma/dw/dmamux.c b/drivers/dma/dw/dmamux.c
new file mode 100644
index 000000000000..30de776f195e
--- /dev/null
+++ b/drivers/dma/dw/dmamux.c
@@ -0,0 +1,175 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2022 Schneider-Electric
+ * Author: Miquel Raynal <miquel.raynal@bootlin.com
+ * Based on TI crossbar driver written by Peter Ujfalusi <peter.ujfalusi@ti.com>
+ */
+#include <linux/slab.h>
+#include <linux/err.h>
+#include <linux/init.h>
+#include <linux/list.h>
+#include <linux/io.h>
+#include <linux/of_address.h>
+#include <linux/of_device.h>
+#include <linux/of_dma.h>
+#include <linux/soc/renesas/r9a06g032-syscon.h>
+
+#define RZN1_DMAMUX_LINES	64
+
+struct rzn1_dmamux_data {
+	struct dma_router dmarouter;
+	unsigned int dmac_requests;
+	unsigned int dmamux_requests;
+	u32 used_chans;
+	struct mutex lock;
+};
+
+struct rzn1_dmamux_map {
+	unsigned int req_idx;
+};
+
+static void rzn1_dmamux_free(struct device *dev, void *route_data)
+{
+	struct rzn1_dmamux_data *dmamux = dev_get_drvdata(dev);
+	struct rzn1_dmamux_map *map = route_data;
+
+	dev_dbg(dev, "Unmapping DMAMUX request %u\n", map->req_idx);
+
+	mutex_lock(&dmamux->lock);
+	dmamux->used_chans &= ~BIT(map->req_idx);
+	mutex_unlock(&dmamux->lock);
+
+	kfree(map);
+}
+
+static void *rzn1_dmamux_route_allocate(struct of_phandle_args *dma_spec,
+					struct of_dma *ofdma)
+{
+	struct platform_device *pdev = of_find_device_by_node(ofdma->of_node);
+	struct rzn1_dmamux_data *dmamux = platform_get_drvdata(pdev);
+	struct rzn1_dmamux_map *map;
+	unsigned int master, chan, val;
+	int ret;
+
+	map = kzalloc(sizeof(*map), GFP_KERNEL);
+	if (!map)
+		return ERR_PTR(-ENOMEM);
+
+	if (dma_spec->args_count != 6)
+		return ERR_PTR(-EINVAL);
+
+	chan = dma_spec->args[0];
+	map->req_idx = dma_spec->args[4];
+	val = dma_spec->args[5];
+	dma_spec->args_count -= 2;
+
+	if (chan >= dmamux->dmac_requests) {
+		dev_err(&pdev->dev, "Invalid DMA request line: %d\n", chan);
+		return ERR_PTR(-EINVAL);
+	}
+
+	if (map->req_idx >= dmamux->dmamux_requests ||
+	    map->req_idx % dmamux->dmac_requests != chan) {
+		dev_err(&pdev->dev, "Invalid MUX request line: %d\n", map->req_idx);
+		return ERR_PTR(-EINVAL);
+	}
+
+	/* The of_node_put() will be done in the core for the node */
+	master = map->req_idx < dmamux->dmac_requests ? 0 : 1;
+	dma_spec->np = of_parse_phandle(ofdma->of_node, "dma-masters", master);
+	if (!dma_spec->np) {
+		dev_err(&pdev->dev, "Can't get DMA master\n");
+		return ERR_PTR(-EINVAL);
+	}
+
+	dev_dbg(&pdev->dev, "Mapping DMAMUX request %u to DMAC%u request %u\n",
+		map->req_idx, master, chan);
+
+	mutex_lock(&dmamux->lock);
+	dmamux->used_chans |= BIT(map->req_idx);
+	ret = r9a06g032_syscon_set_dmamux(BIT(map->req_idx),
+					  val ? BIT(map->req_idx) : 0);
+	mutex_unlock(&dmamux->lock);
+	if (ret) {
+		rzn1_dmamux_free(&pdev->dev, map);
+		return ERR_PTR(ret);
+	}
+
+	return map;
+}
+
+static const struct of_device_id rzn1_dmac_match[] __maybe_unused = {
+	{ .compatible = "renesas,rzn1-dma", },
+	{},
+};
+
+static int rzn1_dmamux_probe(struct platform_device *pdev)
+{
+	struct device_node *node = pdev->dev.of_node;
+	const struct of_device_id *match;
+	struct device_node *dmac_node;
+	struct rzn1_dmamux_data *dmamux;
+
+	if (!node)
+		return -ENODEV;
+
+	dmamux = devm_kzalloc(&pdev->dev, sizeof(*dmamux), GFP_KERNEL);
+	if (!dmamux)
+		return -ENOMEM;
+
+	mutex_init(&dmamux->lock);
+
+	dmac_node = of_parse_phandle(node, "dma-masters", 0);
+	if (!dmac_node) {
+		dev_err(&pdev->dev, "Can't get DMA master node\n");
+		return -ENODEV;
+	}
+
+	match = of_match_node(rzn1_dmac_match, dmac_node);
+	if (!match) {
+		dev_err(&pdev->dev, "DMA master is not supported\n");
+		of_node_put(dmac_node);
+		return -EINVAL;
+	}
+
+	if (of_property_read_u32(dmac_node, "dma-requests",
+				 &dmamux->dmac_requests)) {
+		dev_err(&pdev->dev, "Missing DMAC requests information\n");
+		of_node_put(dmac_node);
+		return -EINVAL;
+	}
+	of_node_put(dmac_node);
+
+	if (of_property_read_u32(node, "dma-requests",
+				 &dmamux->dmamux_requests)) {
+		dev_err(&pdev->dev, "Missing DMA mux requests information\n");
+		return -EINVAL;
+	}
+
+	dmamux->dmarouter.dev = &pdev->dev;
+	dmamux->dmarouter.route_free = rzn1_dmamux_free;
+
+	platform_set_drvdata(pdev, dmamux);
+
+	return of_dma_router_register(node, rzn1_dmamux_route_allocate,
+				      &dmamux->dmarouter);
+}
+
+static const struct of_device_id rzn1_dmamux_match[] = {
+	{ .compatible = "renesas,rzn1-dmamux", },
+	{},
+};
+
+static struct platform_driver rzn1_dmamux_driver = {
+	.driver = {
+		.name = "renesas,rzn1-dmamux",
+		.of_match_table = rzn1_dmamux_match,
+	},
+	.probe	= rzn1_dmamux_probe,
+};
+
+static int rzn1_dmamux_init(void)
+{
+	return platform_driver_register(&rzn1_dmamux_driver);
+}
+arch_initcall(rzn1_dmamux_init);
-- 
2.27.0

