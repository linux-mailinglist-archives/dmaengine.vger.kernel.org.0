Return-Path: <dmaengine+bounces-2593-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A71CF91C27E
	for <lists+dmaengine@lfdr.de>; Fri, 28 Jun 2024 17:21:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E77B2855D2
	for <lists+dmaengine@lfdr.de>; Fri, 28 Jun 2024 15:21:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 034B11C688B;
	Fri, 28 Jun 2024 15:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=timesys-com.20230601.gappssmtp.com header.i=@timesys-com.20230601.gappssmtp.com header.b="ivSr8NMa"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9484B645
	for <dmaengine@vger.kernel.org>; Fri, 28 Jun 2024 15:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719588034; cv=none; b=ACUyX8iBKHL6fCUYAKWmFuwiMFHymK/GJdb7x8OsNToz77DJbJ5mrAHvZn/QiH6QLkF9dGZLMSVc/ywoyMkLll7nITfiH5ce6qN+noxHz9dYIxBT8Cyz9+mR1c41wxgrIkcDrX5FpKY8GuI3Y3re7k4/laqacGeNMp8PXkcdnFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719588034; c=relaxed/simple;
	bh=syRggwfvQimWrDTO6oPdcw0DGm4qewrWAqRwMdLVymo=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=Y5//ggo55xnJXGYCmqStLhA2/QE4b7XRIncDQy2sLgF2PyjUnoBNOk1TJGxDaEFxGV540UiBmPJuJjHyJVt5yaIgoz1vS9Xh5dIs5RWGINXaE8HayvL9AcbKiN5ApapBS7Ir3RyEBoinB37DIfUkpX7T54Fntjp6mVuUgCHNPUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=timesys.com; spf=pass smtp.mailfrom=timesys.com; dkim=pass (2048-bit key) header.d=timesys-com.20230601.gappssmtp.com header.i=@timesys-com.20230601.gappssmtp.com header.b=ivSr8NMa; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=timesys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=timesys.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a6265d3ba8fso82319666b.0
        for <dmaengine@vger.kernel.org>; Fri, 28 Jun 2024 08:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=timesys-com.20230601.gappssmtp.com; s=20230601; t=1719588030; x=1720192830; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=GzLmMzpXa4lP1ZrJW2eEEyDBwtIxTNr3e3V+4wZLmY0=;
        b=ivSr8NMaZky87nriqmWeyr2SN/dd4jas2OD6rBZ8PSkRJ3ht0pORHgR/3dKDCiHdxG
         cI5lJ9PYEsHeHI4Mo8PALPPWRb9Ufi+RrF6bposJ9I6oGjwc00OHGN2nGpzOp6Konngu
         1R13k3D8hd73oo9djlOpo7DnqhcJZOEIvpeHOvkW+m+khELmFnmc4tA7tJlKMX3WaGxL
         pjkOBDvJ4hCkZxVpHGP6rOgf+ySv9JcGieLKjfd8y12Bb3nN693gJoZupsNSCohkE/fk
         ozaCTsyHwxrBmz7exdUoD//AahkVDzTUE9OqZeUTb3+Yw8Yfc6RFjVP1AaPrVqstY03K
         uj6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719588030; x=1720192830;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GzLmMzpXa4lP1ZrJW2eEEyDBwtIxTNr3e3V+4wZLmY0=;
        b=gbvzIEGLz6CBQGTpVDzZu1chw7AoQNSkql1XxK5BqUyGcG3xlzuo2YPvP0qdXV37Fr
         G7t6b6zNj6cXugdXfWAQ8CY8i2N7UljweLS3PobeQ+Hjmf1XDa21BJSOvmzUshrMzWhj
         z4qbaZmVDZl3K67qze8sR0eVDCOhC73xkja1aHJpEAUEOxlpv5SgVVQ73BRiyG1qc41J
         aO8ne5Dkzr0ZVOy8rLB5izI9WNzyps4W6wo7EyYHcRmreNE7cp4S1F7P3HPIMmPn8m0z
         BD1UHkZw6bM5H32Nt+M0SaJjYKsar3tckPR0QHSufdmbunb4zjn6od3gF0F+J2T/7uM9
         oDJw==
X-Forwarded-Encrypted: i=1; AJvYcCU1riWsGIPf6bcUVpxlV9aXeoyBTDQSlldprUdUpyAmHpzikr0MWLRADCRTOkbBEnIDrfGlDHD64rmU3YkKNOp+63PvZHVWvf6j
X-Gm-Message-State: AOJu0YyrloahCo0b4sqlwijkwgUNJSwVF4E0Nbs+R23QaD4gJPpvzsp6
	TGb+UfuiUYDVRwPlquhjv4I9sXiK6+VWhmnfRXDbGw34LJqItmZwiaRJuVAeduw=
X-Google-Smtp-Source: AGHT+IEXsrOrS8vPsFa+7j0c/pd2EPHeqLPABOgzKg3gw6hFoHgy9WDH8iWNatNDTeVyZyE67pAdqg==
X-Received: by 2002:a17:907:a80e:b0:a72:8046:931c with SMTP id a640c23a62f3a-a7280469384mr659549266b.76.1719588029688;
        Fri, 28 Jun 2024 08:20:29 -0700 (PDT)
Received: from localhost.localdomain ([91.216.213.152])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a72ab08cfc1sm87220266b.163.2024.06.28.08.20.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jun 2024 08:20:29 -0700 (PDT)
From: Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>
To: Russell King <linux@armlinux.org.uk>,
	Vladimir Zapolskiy <vz@mleia.com>,
	Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>,
	Vinod Koul <vkoul@kernel.org>,
	"J.M.B. Downing" <jonathan.downing@nautel.com>,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	dmaengine@vger.kernel.org
Subject: [Patch v6] dmaengine: Add dma router for pl08x in LPC32XX SoC
Date: Fri, 28 Jun 2024 17:20:19 +0200
Message-Id: <20240628152022.274405-1-piotr.wojtaszczyk@timesys.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

LPC32XX connects few of its peripherals to pl08x DMA thru a multiplexer,
this driver allows to route a signal request line thru the multiplexer for
given peripheral.

Signed-off-by: Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>
---
 MAINTAINERS                   |   1 +
 arch/arm/mach-lpc32xx/Kconfig |   1 +
 drivers/dma/Kconfig           |   9 ++
 drivers/dma/Makefile          |   1 +
 drivers/dma/lpc32xx-dmamux.c  | 195 ++++++++++++++++++++++++++++++++++
 5 files changed, 207 insertions(+)
 create mode 100644 drivers/dma/lpc32xx-dmamux.c

diff --git a/MAINTAINERS b/MAINTAINERS
index ceec359c68fc..118d48747641 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2404,6 +2404,7 @@ R:	Vladimir Zapolskiy <vz@mleia.com>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 F:	Documentation/devicetree/bindings/dma/nxp,lpc3220-dmamux.yaml
+F:	drivers/dma/lpc32xx-dmamux.c
 
 ARM/Marvell Dove/MV78xx0/Orion SOC support
 M:	Andrew Lunn <andrew@lunn.ch>
diff --git a/arch/arm/mach-lpc32xx/Kconfig b/arch/arm/mach-lpc32xx/Kconfig
index 35730d3696d0..138599545c24 100644
--- a/arch/arm/mach-lpc32xx/Kconfig
+++ b/arch/arm/mach-lpc32xx/Kconfig
@@ -8,5 +8,6 @@ config ARCH_LPC32XX
 	select CLKSRC_LPC32XX
 	select CPU_ARM926T
 	select GPIOLIB
+	select LPC32XX_DMAMUX if AMBA_PL08X
 	help
 	  Support for the NXP LPC32XX family of processors
diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
index 002a5ec80620..aeace3d7e066 100644
--- a/drivers/dma/Kconfig
+++ b/drivers/dma/Kconfig
@@ -378,6 +378,15 @@ config LPC18XX_DMAMUX
 	  Enable support for DMA on NXP LPC18xx/43xx platforms
 	  with PL080 and multiplexed DMA request lines.
 
+config LPC32XX_DMAMUX
+	bool "NXP LPC32xx DMA MUX for PL080"
+	depends on ARCH_LPC32XX || COMPILE_TEST
+	depends on OF && AMBA_PL08X
+	select MFD_SYSCON
+	help
+	  Support for PL080 multiplexed DMA request lines on
+	  LPC32XX platrofm.
+
 config LS2X_APB_DMA
 	tristate "Loongson LS2X APB DMA support"
 	depends on LOONGARCH || COMPILE_TEST
diff --git a/drivers/dma/Makefile b/drivers/dma/Makefile
index 802ca916f05f..6f1350b62e7f 100644
--- a/drivers/dma/Makefile
+++ b/drivers/dma/Makefile
@@ -50,6 +50,7 @@ obj-$(CONFIG_INTEL_IOATDMA) += ioat/
 obj-y += idxd/
 obj-$(CONFIG_K3_DMA) += k3dma.o
 obj-$(CONFIG_LPC18XX_DMAMUX) += lpc18xx-dmamux.o
+obj-$(CONFIG_LPC32XX_DMAMUX) += lpc32xx-dmamux.o
 obj-$(CONFIG_LS2X_APB_DMA) += ls2x-apb-dma.o
 obj-$(CONFIG_MILBEAUT_HDMAC) += milbeaut-hdmac.o
 obj-$(CONFIG_MILBEAUT_XDMAC) += milbeaut-xdmac.o
diff --git a/drivers/dma/lpc32xx-dmamux.c b/drivers/dma/lpc32xx-dmamux.c
new file mode 100644
index 000000000000..351d7e23e615
--- /dev/null
+++ b/drivers/dma/lpc32xx-dmamux.c
@@ -0,0 +1,195 @@
+// SPDX-License-Identifier: GPL-2.0-only
+//
+// Copyright 2024 Timesys Corporation <piotr.wojtaszczyk@timesys.com>
+//
+// Based on TI DMA Crossbar driver by:
+//   Copyright (C) 2015 Texas Instruments Incorporated - http://www.ti.com
+//   Author: Peter Ujfalusi <peter.ujfalusi@ti.com>
+
+#include <linux/err.h>
+#include <linux/init.h>
+#include <linux/mfd/syscon.h>
+#include <linux/of.h>
+#include <linux/of_dma.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include <linux/spinlock.h>
+
+#define LPC32XX_SSP_CLK_CTRL 0x78
+#define LPC32XX_I2S_CLK_CTRL 0x7c
+
+struct lpc32xx_dmamux {
+	int signal;
+	char *name_sel0;
+	char *name_sel1;
+	int muxval;
+	int muxreg;
+	int bit;
+	bool busy;
+};
+
+struct lpc32xx_dmamux_data {
+	struct dma_router dmarouter;
+	struct regmap *reg;
+	spinlock_t lock; /* protects busy status flag */
+};
+
+/* From LPC32x0 User manual "3.2.1 DMA request signals" */
+static struct lpc32xx_dmamux lpc32xx_muxes[] = {
+	{
+		.signal = 3,
+		.name_sel0 = "spi2-rx-tx",
+		.name_sel1 = "ssp1-rx",
+		.muxreg = LPC32XX_SSP_CLK_CTRL,
+		.bit = 5,
+	},
+	{
+		.signal = 10,
+		.name_sel0 = "uart7-rx",
+		.name_sel1 = "i2s1-dma1",
+		.muxreg = LPC32XX_I2S_CLK_CTRL,
+		.bit = 4,
+	},
+	{
+		.signal = 11,
+		.name_sel0 = "spi1-rx-tx",
+		.name_sel1 = "ssp1-tx",
+		.muxreg = LPC32XX_SSP_CLK_CTRL,
+		.bit = 4,
+	},
+	{
+		.signal = 14,
+		.name_sel0 = "none",
+		.name_sel1 = "ssp0-rx",
+		.muxreg = LPC32XX_SSP_CLK_CTRL,
+		.bit = 3,
+	},
+	{
+		.signal = 15,
+		.name_sel0 = "none",
+		.name_sel1 = "ssp0-tx",
+		.muxreg = LPC32XX_SSP_CLK_CTRL,
+		.bit = 2,
+	},
+};
+
+static void lpc32xx_dmamux_release(struct device *dev, void *route_data)
+{
+	struct lpc32xx_dmamux_data *dmamux = dev_get_drvdata(dev);
+	struct lpc32xx_dmamux *mux = route_data;
+
+	dev_dbg(dev, "releasing dma request signal %d routed to %s\n",
+		mux->signal, mux->muxval ? mux->name_sel1 : mux->name_sel1);
+
+	guard(spinlock)(&dmamux->lock);
+
+	mux->busy = false;
+}
+
+static void *lpc32xx_dmamux_reserve(struct of_phandle_args *dma_spec,
+				    struct of_dma *ofdma)
+{
+	struct platform_device *pdev = of_find_device_by_node(ofdma->of_node);
+	struct device *dev = &pdev->dev;
+	struct lpc32xx_dmamux_data *dmamux = platform_get_drvdata(pdev);
+	unsigned long flags;
+	struct lpc32xx_dmamux *mux = NULL;
+	int i;
+
+	if (dma_spec->args_count != 3) {
+		dev_err(&pdev->dev, "invalid number of dma mux args\n");
+		return ERR_PTR(-EINVAL);
+	}
+
+	for (i = 0; i < ARRAY_SIZE(lpc32xx_muxes); i++) {
+		if (lpc32xx_muxes[i].signal == dma_spec->args[0]) {
+			mux = &lpc32xx_muxes[i];
+			break;
+		}
+	}
+	if (!mux) {
+		dev_err(&pdev->dev, "invalid mux request number: %d\n",
+			dma_spec->args[0]);
+		return ERR_PTR(-EINVAL);
+	}
+
+	if (dma_spec->args[2] > 1) {
+		dev_err(&pdev->dev, "invalid dma mux value: %d\n",
+			dma_spec->args[1]);
+		return ERR_PTR(-EINVAL);
+	}
+
+	/* The of_node_put() will be done in the core for the node */
+	dma_spec->np = of_parse_phandle(ofdma->of_node, "dma-masters", 0);
+	if (!dma_spec->np) {
+		dev_err(&pdev->dev, "can't get dma master\n");
+		return ERR_PTR(-EINVAL);
+	}
+
+	spin_lock_irqsave(&dmamux->lock, flags);
+	if (mux->busy) {
+		spin_unlock_irqrestore(&dmamux->lock, flags);
+		dev_err(dev, "dma request signal %d busy, routed to %s\n",
+			mux->signal, mux->muxval ? mux->name_sel1 : mux->name_sel1);
+		of_node_put(dma_spec->np);
+		return ERR_PTR(-EBUSY);
+	}
+
+	mux->busy = true;
+	mux->muxval = dma_spec->args[2] ? BIT(mux->bit) : 0;
+
+	regmap_update_bits(dmamux->reg, mux->muxreg, BIT(mux->bit), mux->muxval);
+	spin_unlock_irqrestore(&dmamux->lock, flags);
+
+	dma_spec->args[2] = 0;
+	dma_spec->args_count = 2;
+
+	dev_dbg(dev, "dma request signal %d routed to %s\n",
+		mux->signal, mux->muxval ? mux->name_sel1 : mux->name_sel1);
+
+	return mux;
+}
+
+static int lpc32xx_dmamux_probe(struct platform_device *pdev)
+{
+	struct device_node *np = pdev->dev.of_node;
+	struct lpc32xx_dmamux_data *dmamux;
+
+	dmamux = devm_kzalloc(&pdev->dev, sizeof(*dmamux), GFP_KERNEL);
+	if (!dmamux)
+		return -ENOMEM;
+
+	dmamux->reg = syscon_node_to_regmap(np->parent);
+	if (IS_ERR(dmamux->reg)) {
+		dev_err(&pdev->dev, "syscon lookup failed\n");
+		return PTR_ERR(dmamux->reg);
+	}
+
+	spin_lock_init(&dmamux->lock);
+	platform_set_drvdata(pdev, dmamux);
+	dmamux->dmarouter.dev = &pdev->dev;
+	dmamux->dmarouter.route_free = lpc32xx_dmamux_release;
+
+	return of_dma_router_register(np, lpc32xx_dmamux_reserve,
+				      &dmamux->dmarouter);
+}
+
+static const struct of_device_id lpc32xx_dmamux_match[] = {
+	{ .compatible = "nxp,lpc3220-dmamux" },
+	{},
+};
+
+static struct platform_driver lpc32xx_dmamux_driver = {
+	.probe	= lpc32xx_dmamux_probe,
+	.driver = {
+		.name = "lpc32xx-dmamux",
+		.of_match_table = lpc32xx_dmamux_match,
+	},
+};
+
+static int __init lpc32xx_dmamux_init(void)
+{
+	return platform_driver_register(&lpc32xx_dmamux_driver);
+}
+arch_initcall(lpc32xx_dmamux_init);
-- 
2.25.1


