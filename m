Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 712802ACDF9
	for <lists+dmaengine@lfdr.de>; Tue, 10 Nov 2020 05:06:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733086AbgKJEGg (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 9 Nov 2020 23:06:36 -0500
Received: from smtp2207-205.mail.aliyun.com ([121.197.207.205]:60098 "EHLO
        smtp2207-205.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387574AbgKJEGf (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 9 Nov 2020 23:06:35 -0500
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07436289|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.019185-0.0136594-0.967156;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047193;MF=frank@allwinnertech.com;NM=1;PH=DS;RN=28;RT=28;SR=0;TI=SMTPD_---.IulFdj5_1604981159;
Received: from allwinnertech.com(mailfrom:frank@allwinnertech.com fp:SMTPD_---.IulFdj5_1604981159)
          by smtp.aliyun-inc.com(10.147.42.135);
          Tue, 10 Nov 2020 12:06:29 +0800
From:   Frank Lee <frank@allwinnertech.com>
To:     vkoul@kernel.org, robh+dt@kernel.org, mripard@kernel.org,
        wens@csie.org, ulf.hansson@linaro.org, kishon@ti.com,
        wim@linux-watchdog.org, linux@roeck-us.net,
        dan.j.williams@intel.com, linus.walleij@linaro.org,
        wsa+renesas@sang-engineering.com, dianders@chromium.org,
        marex@denx.de, colin.king@canonical.com, rdunlap@infradead.org,
        krzk@kernel.org, gregkh@linuxfoundation.org, megous@megous.com,
        rikard.falkeborn@gmail.com, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-watchdog@vger.kernel.org, linux-gpio@vger.kernel.org,
        tiny.windzz@gmail.com
Cc:     Yangtao Li <frank@allwinnertech.com>
Subject: [PATCH 09/19] phy: allwinner: Convert to devm_platform_ioremap_* API
Date:   Tue, 10 Nov 2020 12:05:43 +0800
Message-Id: <20201110040553.1381-10-frank@allwinnertech.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201110040553.1381-1-frank@allwinnertech.com>
References: <20201110040553.1381-1-frank@allwinnertech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Yangtao Li <frank@allwinnertech.com>

Use the devm_platform_ioremap_resource_byname() and
devm_platform_ioremap_resource helper to simplify the code.

Signed-off-by: Yangtao Li <frank@allwinnertech.com>
---
 drivers/phy/allwinner/phy-sun4i-usb.c       | 9 +++------
 drivers/phy/allwinner/phy-sun50i-usb3.c     | 4 +---
 drivers/phy/allwinner/phy-sun6i-mipi-dphy.c | 4 +---
 drivers/phy/allwinner/phy-sun9i-usb.c       | 4 +---
 4 files changed, 6 insertions(+), 15 deletions(-)

diff --git a/drivers/phy/allwinner/phy-sun4i-usb.c b/drivers/phy/allwinner/phy-sun4i-usb.c
index 0f1888b55dbd..a6900495baa5 100644
--- a/drivers/phy/allwinner/phy-sun4i-usb.c
+++ b/drivers/phy/allwinner/phy-sun4i-usb.c
@@ -686,7 +686,6 @@ static int sun4i_usb_phy_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct device_node *np = dev->of_node;
 	struct phy_provider *phy_provider;
-	struct resource *res;
 	int i, ret;
 
 	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
@@ -700,8 +699,7 @@ static int sun4i_usb_phy_probe(struct platform_device *pdev)
 	if (!data->cfg)
 		return -EINVAL;
 
-	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "phy_ctrl");
-	data->base = devm_ioremap_resource(dev, res);
+	data->base = devm_platform_ioremap_resource_byname(pdev, "phy_ctrl");
 	if (IS_ERR(data->base))
 		return PTR_ERR(data->base);
 
@@ -796,9 +794,8 @@ static int sun4i_usb_phy_probe(struct platform_device *pdev)
 
 		if (i || data->cfg->phy0_dual_route) { /* No pmu for musb */
 			snprintf(name, sizeof(name), "pmu%d", i);
-			res = platform_get_resource_byname(pdev,
-							IORESOURCE_MEM, name);
-			phy->pmu = devm_ioremap_resource(dev, res);
+			phy->pmu = devm_platform_ioremap_resource_byname(pdev,
+									 name);
 			if (IS_ERR(phy->pmu))
 				return PTR_ERR(phy->pmu);
 		}
diff --git a/drivers/phy/allwinner/phy-sun50i-usb3.c b/drivers/phy/allwinner/phy-sun50i-usb3.c
index b1c04f71a31d..84055b720016 100644
--- a/drivers/phy/allwinner/phy-sun50i-usb3.c
+++ b/drivers/phy/allwinner/phy-sun50i-usb3.c
@@ -134,7 +134,6 @@ static int sun50i_usb3_phy_probe(struct platform_device *pdev)
 	struct sun50i_usb3_phy *phy;
 	struct device *dev = &pdev->dev;
 	struct phy_provider *phy_provider;
-	struct resource *res;
 
 	phy = devm_kzalloc(dev, sizeof(*phy), GFP_KERNEL);
 	if (!phy)
@@ -153,8 +152,7 @@ static int sun50i_usb3_phy_probe(struct platform_device *pdev)
 		return PTR_ERR(phy->reset);
 	}
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	phy->regs = devm_ioremap_resource(dev, res);
+	phy->regs = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(phy->regs))
 		return PTR_ERR(phy->regs);
 
diff --git a/drivers/phy/allwinner/phy-sun6i-mipi-dphy.c b/drivers/phy/allwinner/phy-sun6i-mipi-dphy.c
index 1fa761ba6cbb..f0bc87d654d4 100644
--- a/drivers/phy/allwinner/phy-sun6i-mipi-dphy.c
+++ b/drivers/phy/allwinner/phy-sun6i-mipi-dphy.c
@@ -253,15 +253,13 @@ static int sun6i_dphy_probe(struct platform_device *pdev)
 {
 	struct phy_provider *phy_provider;
 	struct sun6i_dphy *dphy;
-	struct resource *res;
 	void __iomem *regs;
 
 	dphy = devm_kzalloc(&pdev->dev, sizeof(*dphy), GFP_KERNEL);
 	if (!dphy)
 		return -ENOMEM;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	regs = devm_ioremap_resource(&pdev->dev, res);
+	regs = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(regs)) {
 		dev_err(&pdev->dev, "Couldn't map the DPHY encoder registers\n");
 		return PTR_ERR(regs);
diff --git a/drivers/phy/allwinner/phy-sun9i-usb.c b/drivers/phy/allwinner/phy-sun9i-usb.c
index fc6784dd7fa0..2f9e60c188b8 100644
--- a/drivers/phy/allwinner/phy-sun9i-usb.c
+++ b/drivers/phy/allwinner/phy-sun9i-usb.c
@@ -117,7 +117,6 @@ static int sun9i_usb_phy_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct device_node *np = dev->of_node;
 	struct phy_provider *phy_provider;
-	struct resource *res;
 
 	phy = devm_kzalloc(dev, sizeof(*phy), GFP_KERNEL);
 	if (!phy)
@@ -156,8 +155,7 @@ static int sun9i_usb_phy_probe(struct platform_device *pdev)
 		}
 	}
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	phy->pmu = devm_ioremap_resource(dev, res);
+	phy->pmu = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(phy->pmu))
 		return PTR_ERR(phy->pmu);
 
-- 
2.28.0

