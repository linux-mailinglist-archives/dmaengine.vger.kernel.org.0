Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4605A2FE28E
	for <lists+dmaengine@lfdr.de>; Thu, 21 Jan 2021 07:18:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726837AbhAUGR4 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 21 Jan 2021 01:17:56 -0500
Received: from mga11.intel.com ([192.55.52.93]:10408 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726702AbhAUGP5 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 21 Jan 2021 01:15:57 -0500
IronPort-SDR: UdnsZct8SYfs7z3WSSBj8ImVEBosefgj+n59CikSl8IU/NblL8Ra7xx3C+sDxkYB0KosHtGDXP
 4TohsSEOL6lA==
X-IronPort-AV: E=McAfee;i="6000,8403,9870"; a="175716802"
X-IronPort-AV: E=Sophos;i="5.79,363,1602572400"; 
   d="scan'208";a="175716802"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2021 22:14:44 -0800
IronPort-SDR: yToBH0dYuW7YCxSpLiY76uHw32QDLVjrIN9SyS8jciIiQ6Pdkt4X2J4iCMvbeaCUKY1txg1Akq
 YiEBoJSo5JhA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,363,1602572400"; 
   d="scan'208";a="427201433"
Received: from jsia-hp-z620-workstation.png.intel.com ([10.221.118.135])
  by orsmga001.jf.intel.com with ESMTP; 20 Jan 2021 22:14:42 -0800
From:   Sia Jee Heng <jee.heng.sia@intel.com>
To:     vkoul@kernel.org, Eugeniy.Paltsev@synopsys.com, robh+dt@kernel.org
Cc:     andriy.shevchenko@linux.intel.com, jee.heng.sia@intel.com,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v10 12/16] dmaengine: dw-axi-dmac: Add Intel KeemBay AxiDMA support
Date:   Thu, 21 Jan 2021 13:56:37 +0800
Message-Id: <20210121055641.6307-13-jee.heng.sia@intel.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210121055641.6307-1-jee.heng.sia@intel.com>
References: <20210121055641.6307-1-jee.heng.sia@intel.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Add support for Intel KeemBay AxiDMA to the .compatible field.
The AxiDMA Apb region will be accessible if the compatible string
matches the "intel,kmb-axi-dma".

Signed-off-by: Sia Jee Heng <jee.heng.sia@intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Tested-by: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
---
 drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
index 830d3de76abd..062d27c61983 100644
--- a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
+++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
@@ -1160,6 +1160,7 @@ static int parse_device_properties(struct axi_dma_chip *chip)
 
 static int dw_probe(struct platform_device *pdev)
 {
+	struct device_node *node = pdev->dev.of_node;
 	struct axi_dma_chip *chip;
 	struct resource *mem;
 	struct dw_axi_dma *dw;
@@ -1192,6 +1193,12 @@ static int dw_probe(struct platform_device *pdev)
 	if (IS_ERR(chip->regs))
 		return PTR_ERR(chip->regs);
 
+	if (of_device_is_compatible(node, "intel,kmb-axi-dma")) {
+		chip->apb_regs = devm_platform_ioremap_resource(pdev, 1);
+		if (IS_ERR(chip->apb_regs))
+			return PTR_ERR(chip->apb_regs);
+	}
+
 	chip->core_clk = devm_clk_get(chip->dev, "core-clk");
 	if (IS_ERR(chip->core_clk))
 		return PTR_ERR(chip->core_clk);
@@ -1336,6 +1343,7 @@ static const struct dev_pm_ops dw_axi_dma_pm_ops = {
 
 static const struct of_device_id dw_dma_of_id_table[] = {
 	{ .compatible = "snps,axi-dma-1.01a" },
+	{ .compatible = "intel,kmb-axi-dma" },
 	{}
 };
 MODULE_DEVICE_TABLE(of, dw_dma_of_id_table);
-- 
2.18.0

