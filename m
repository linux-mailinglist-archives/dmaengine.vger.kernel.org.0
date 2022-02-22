Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EE6E4BF612
	for <lists+dmaengine@lfdr.de>; Tue, 22 Feb 2022 11:35:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231245AbiBVKfg (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 22 Feb 2022 05:35:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230437AbiBVKfe (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 22 Feb 2022 05:35:34 -0500
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4FCD15B983;
        Tue, 22 Feb 2022 02:35:08 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id DCE6DFF811;
        Tue, 22 Feb 2022 10:35:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1645526107;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Epk2uTeuvShgaggsLxcN9kC/j5VSYJM1XeKDbbQfB8E=;
        b=n7TrvmfpRWupIlxSVQnlP2XwIArfX68MjNAemZTUDBIyjlVXi944fkoEhfqaNSovS+pazQ
        QlyM/R5ezqPTsj0G7X4aA0B9r6O/xB/A4WhcM4boqmphn3hTvRSVRpIKP0LXk4NywRzgog
        qK4TXBrMnWS56XCUFxOvJJoGGRg/+e8PDeRm3eLG8aOUwN46pocL6bndt9Jxj/f+kPCjzl
        nznCnGtoMjzcz0jEEUsGA+uEnSND3qA6VVXxzmbDMRy00JM1/3vMiilE4O1XMP8Tra1lkj
        3XXZ4U9LPfTWgCqa82lh0xMk9pvQ44acRZB5rak1aDGcuGeOBJROZ9W1/6sfKA==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Vinod Koul <vkoul@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     dmaengine@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Magnus Damm <magnus.damm@gmail.com>,
        Gareth Williams <gareth.williams.jx@renesas.com>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Milan Stevanovic <milan.stevanovic@se.com>,
        Jimmy Lalande <jimmy.lalande@se.com>,
        Pascal Eberhard <pascal.eberhard@se.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH v2 4/8] dma: dmamux: Introduce RZN1 DMA router support
Date:   Tue, 22 Feb 2022 11:34:33 +0100
Message-Id: <20220222103437.194779-5-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220222103437.194779-1-miquel.raynal@bootlin.com>
References: <20220222103437.194779-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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
 drivers/dma/dw/Kconfig  |   8 ++
 drivers/dma/dw/Makefile |   2 +
 drivers/dma/dw/dmamux.c | 167 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 177 insertions(+)
 create mode 100644 drivers/dma/dw/dmamux.c

diff --git a/drivers/dma/dw/Kconfig b/drivers/dma/dw/Kconfig
index db25f9b7778c..dd53d4a9fa92 100644
--- a/drivers/dma/dw/Kconfig
+++ b/drivers/dma/dw/Kconfig
@@ -16,6 +16,14 @@ config DW_DMAC
 	  Support the Synopsys DesignWare AHB DMA controller. This
 	  can be integrated in chips such as the Intel Cherrytrail.
 
+config RZN1_DMAMUX
+	tristate "Renesas RZ/N1 DMAMUX driver"
+	depends on DW_DMAC
+	help
+	  Support the Renesas RZ/N1 DMAMUX which is located in front of
+	  the Synopsys DesignWare AHB DMA controller located on Renesas
+	  SoCs.
+
 config DW_DMAC_PCI
 	tristate "Synopsys DesignWare AHB DMA PCI driver"
 	depends on PCI
diff --git a/drivers/dma/dw/Makefile b/drivers/dma/dw/Makefile
index a6f358ad8591..7c6e0ab6fcd8 100644
--- a/drivers/dma/dw/Makefile
+++ b/drivers/dma/dw/Makefile
@@ -7,5 +7,7 @@ obj-$(CONFIG_DW_DMAC)		+= dw_dmac.o
 dw_dmac-y			:= platform.o
 dw_dmac-$(CONFIG_OF)		+= of.o
 
+obj-$(CONFIG_RZN1_DMAMUX)	+= dmamux.o
+
 obj-$(CONFIG_DW_DMAC_PCI)	+= dw_dmac_pci.o
 dw_dmac_pci-y			:= pci.o
diff --git a/drivers/dma/dw/dmamux.c b/drivers/dma/dw/dmamux.c
new file mode 100644
index 000000000000..5fb3ffb82e88
--- /dev/null
+++ b/drivers/dma/dw/dmamux.c
@@ -0,0 +1,167 @@
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
+#include <linux/soc/renesas/r9a06g032-sysctrl.h>
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
+	u32 mask;
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
+	master = map->req_idx >= dmamux->dmac_requests ? 1 : 0;
+	dma_spec->np = of_parse_phandle(ofdma->of_node, "dma-masters", master);
+	if (!dma_spec->np) {
+		dev_err(&pdev->dev, "Can't get DMA master\n");
+		return ERR_PTR(-EINVAL);
+	}
+
+	dev_dbg(&pdev->dev, "Mapping DMAMUX request %u to DMAC%u request %u\n",
+		map->req_idx, master, chan);
+
+	mask = BIT(map->req_idx);
+	mutex_lock(&dmamux->lock);
+	dmamux->used_chans |= mask;
+	ret = r9a06g032_sysctrl_set_dmamux(mask, val ? mask : 0);
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
+	{ .compatible = "renesas,rzn1-dma" },
+	{},
+};
+
+static int rzn1_dmamux_probe(struct platform_device *pdev)
+{
+	struct device_node *mux_node = pdev->dev.of_node;
+	const struct of_device_id *match;
+	struct device_node *dmac_node;
+	struct rzn1_dmamux_data *dmamux;
+
+	dmamux = devm_kzalloc(&pdev->dev, sizeof(*dmamux), GFP_KERNEL);
+	if (!dmamux)
+		return -ENOMEM;
+
+	mutex_init(&dmamux->lock);
+
+	dmac_node = of_parse_phandle(mux_node, "dma-masters", 0);
+	if (!dmac_node)
+		return dev_err_probe(&pdev->dev, -ENODEV, "Can't get DMA master node\n");
+
+	match = of_match_node(rzn1_dmac_match, dmac_node);
+	if (!match) {
+		of_node_put(dmac_node);
+		return dev_err_probe(&pdev->dev, -EINVAL, "DMA master is not supported\n");
+	}
+
+	if (of_property_read_u32(dmac_node, "dma-requests", &dmamux->dmac_requests)) {
+		of_node_put(dmac_node);
+		return dev_err_probe(&pdev->dev, -EINVAL, "Missing DMAC requests information\n");
+	}
+
+	of_node_put(dmac_node);
+
+	if (of_property_read_u32(mux_node, "dma-requests", &dmamux->dmamux_requests)) {
+		return dev_err_probe(&pdev->dev, -EINVAL, "Missing mux requests information\n");
+	}
+
+	dmamux->dmarouter.dev = &pdev->dev;
+	dmamux->dmarouter.route_free = rzn1_dmamux_free;
+
+	platform_set_drvdata(pdev, dmamux);
+
+	return of_dma_router_register(mux_node, rzn1_dmamux_route_allocate,
+				      &dmamux->dmarouter);
+}
+
+static const struct of_device_id rzn1_dmamux_match[] = {
+	{ .compatible = "renesas,rzn1-dmamux" },
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

