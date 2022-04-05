Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E51F14F2D01
	for <lists+dmaengine@lfdr.de>; Tue,  5 Apr 2022 13:35:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235018AbiDEI0e (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 5 Apr 2022 04:26:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239942AbiDEIV5 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 5 Apr 2022 04:21:57 -0400
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::222])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DB9D9FE4;
        Tue,  5 Apr 2022 01:19:26 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id B8A9840006;
        Tue,  5 Apr 2022 08:19:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1649146764;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WRjdN6jkq9fkRNwYc/qNyJa5NsyQhrDu5GFQ+EKb2uc=;
        b=OwnS4DLQ924l7Fx0OGPTBgVpejmxQb0YQUuaCx/MbpFnrhEsy0t5Em8UOStNyelRKtAp+g
        0K6ezauRzLIFAj4+Lw2LM+/jIaXd9bv58Ry8zOBUFab6BUNlqSyxnFyww3iG+aYZJoXvRg
        5UPqAF91CGyZYRVjskmYuXk0jd/kBokZ5bb6xzLc4WkyzCmgwXSIBstb8IM2QKmDQgwVxn
        pvqB+slQApna60HSEPvF8lGRfFVuP0NY/dUYchaq3pyR2RW1Cnt4ww29kvDjGxmOrq20no
        sAA+iUpL+23C4RA7KPWtoa7u7ZIGXzadVTAzvcPstO7t2YQIwCh8xM7xGfb+/Q==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Magnus Damm <magnus.damm@gmail.com>,
        Gareth Williams <gareth.williams.jx@renesas.com>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Vinod Koul <vkoul@kernel.org>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        linux-renesas-soc@vger.kernel.org, dmaengine@vger.kernel.org,
        Milan Stevanovic <milan.stevanovic@se.com>,
        Jimmy Lalande <jimmy.lalande@se.com>,
        Pascal Eberhard <pascal.eberhard@se.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Herve Codina <herve.codina@bootlin.com>,
        Clement Leger <clement.leger@bootlin.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, Viresh Kumar <vireshk@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v7 5/9] dmaengine: dw: dmamux: Introduce RZN1 DMA router support
Date:   Tue,  5 Apr 2022 10:19:07 +0200
Message-Id: <20220405081911.1349563-6-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220405081911.1349563-1-miquel.raynal@bootlin.com>
References: <20220405081911.1349563-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The Renesas RZN1 DMA IP is based on a DW core, with eg. an additional
dmamux register located in the system control area which can take up to
32 requests (16 per DMA controller). Each DMA channel can be wired to
two different peripherals.

We need two additional information from the 'dmas' property: the channel
(bit in the dmamux register) that must be accessed and the value of the
mux for this channel.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/dma/dw/Kconfig       |   9 ++
 drivers/dma/dw/Makefile      |   2 +
 drivers/dma/dw/rzn1-dmamux.c | 157 +++++++++++++++++++++++++++++++++++
 3 files changed, 168 insertions(+)
 create mode 100644 drivers/dma/dw/rzn1-dmamux.c

diff --git a/drivers/dma/dw/Kconfig b/drivers/dma/dw/Kconfig
index db25f9b7778c..a9828ddd6d06 100644
--- a/drivers/dma/dw/Kconfig
+++ b/drivers/dma/dw/Kconfig
@@ -16,6 +16,15 @@ config DW_DMAC
 	  Support the Synopsys DesignWare AHB DMA controller. This
 	  can be integrated in chips such as the Intel Cherrytrail.
 
+config RZN1_DMAMUX
+	tristate "Renesas RZ/N1 DMAMUX driver"
+	depends on DW_DMAC
+	depends on ARCH_RZN1 || COMPILE_TEST
+	help
+	  Support the Renesas RZ/N1 DMAMUX which is located in front of
+	  the Synopsys DesignWare AHB DMA controller located on Renesas
+	  SoCs.
+
 config DW_DMAC_PCI
 	tristate "Synopsys DesignWare AHB DMA PCI driver"
 	depends on PCI
diff --git a/drivers/dma/dw/Makefile b/drivers/dma/dw/Makefile
index a6f358ad8591..8025f75e589c 100644
--- a/drivers/dma/dw/Makefile
+++ b/drivers/dma/dw/Makefile
@@ -7,5 +7,7 @@ obj-$(CONFIG_DW_DMAC)		+= dw_dmac.o
 dw_dmac-y			:= platform.o
 dw_dmac-$(CONFIG_OF)		+= of.o
 
+obj-$(CONFIG_RZN1_DMAMUX)	+= rzn1-dmamux.o
+
 obj-$(CONFIG_DW_DMAC_PCI)	+= dw_dmac_pci.o
 dw_dmac_pci-y			:= pci.o
diff --git a/drivers/dma/dw/rzn1-dmamux.c b/drivers/dma/dw/rzn1-dmamux.c
new file mode 100644
index 000000000000..a3313f268275
--- /dev/null
+++ b/drivers/dma/dw/rzn1-dmamux.c
@@ -0,0 +1,157 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2022 Schneider-Electric
+ * Author: Miquel Raynal <miquel.raynal@bootlin.com
+ * Based on TI crossbar driver written by Peter Ujfalusi <peter.ujfalusi@ti.com>
+ */
+#include <linux/of_device.h>
+#include <linux/of_dma.h>
+#include <linux/slab.h>
+#include <linux/soc/renesas/r9a06g032-sysctrl.h>
+
+#define RZN1_DMAMUX_LINES 64
+#define RZN1_DMAMUX_SPLIT 16
+
+struct rzn1_dmamux_data {
+	struct dma_router dmarouter;
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
+	unsigned int dmac_idx, chan, val;
+	u32 mask;
+	int ret;
+
+	if (dma_spec->args_count != 6)
+		return ERR_PTR(-EINVAL);
+
+	map = kzalloc(sizeof(*map), GFP_KERNEL);
+	if (!map)
+		return ERR_PTR(-ENOMEM);
+
+	chan = dma_spec->args[0];
+	map->req_idx = dma_spec->args[4];
+	val = dma_spec->args[5];
+	dma_spec->args_count -= 2;
+
+	if (chan >= RZN1_DMAMUX_SPLIT) {
+		dev_err(&pdev->dev, "Invalid DMA request line: %u\n", chan);
+		ret = -EINVAL;
+		goto free_map;
+	}
+
+	if (map->req_idx >= RZN1_DMAMUX_LINES ||
+	    (map->req_idx % RZN1_DMAMUX_SPLIT) != chan) {
+		dev_err(&pdev->dev, "Invalid MUX request line: %u\n", map->req_idx);
+		ret = -EINVAL;
+		goto free_map;
+	}
+
+	dmac_idx = map->req_idx < RZN1_DMAMUX_SPLIT ? 0 : 1;
+	dma_spec->np = of_parse_phandle(ofdma->of_node, "dma-masters", dmac_idx);
+	if (!dma_spec->np) {
+		dev_err(&pdev->dev, "Can't get DMA master\n");
+		ret = -EINVAL;
+		goto free_map;
+	}
+
+	dev_dbg(&pdev->dev, "Mapping DMAMUX request %u to DMAC%u request %u\n",
+		map->req_idx, dmac_idx, chan);
+
+	mask = BIT(map->req_idx);
+	mutex_lock(&dmamux->lock);
+	dmamux->used_chans |= mask;
+	ret = r9a06g032_sysctrl_set_dmamux(mask, val ? mask : 0);
+	if (ret)
+		goto release_chan_and_unlock;
+
+	mutex_unlock(&dmamux->lock);
+
+	return map;
+
+release_chan_and_unlock:
+	dmamux->used_chans &= ~mask;
+	mutex_unlock(&dmamux->lock);
+free_map:
+	kfree(map);
+
+	return ERR_PTR(ret);
+}
+
+static const struct of_device_id rzn1_dmac_match[] = {
+	{ .compatible = "renesas,rzn1-dma" },
+	{}
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
+	of_node_put(dmac_node);
+	if (!match)
+		return dev_err_probe(&pdev->dev, -EINVAL, "DMA master is not supported\n");
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
+	{}
+};
+
+static struct platform_driver rzn1_dmamux_driver = {
+	.driver = {
+		.name = "renesas,rzn1-dmamux",
+		.of_match_table = rzn1_dmamux_match,
+	},
+	.probe	= rzn1_dmamux_probe,
+};
+module_platform_driver(rzn1_dmamux_driver);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Miquel Raynal <miquel.raynal@bootlin.com");
+MODULE_DESCRIPTION("Renesas RZ/N1 DMAMUX driver");
-- 
2.27.0

