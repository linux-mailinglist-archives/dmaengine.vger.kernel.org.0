Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86F9A2BFE6A
	for <lists+dmaengine@lfdr.de>; Mon, 23 Nov 2020 03:54:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727556AbgKWCwJ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 22 Nov 2020 21:52:09 -0500
Received: from mga18.intel.com ([134.134.136.126]:60192 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727711AbgKWCwJ (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Sun, 22 Nov 2020 21:52:09 -0500
IronPort-SDR: eM5L2vpDMdayqIblbphVKzbi/Lc6Dj+RKgOBMtdaWht6VpUC4D/i6MbPt/9B6c8lvmZsZce6VK
 qPMZRsWhfdyA==
X-IronPort-AV: E=McAfee;i="6000,8403,9813"; a="159460037"
X-IronPort-AV: E=Sophos;i="5.78,361,1599548400"; 
   d="scan'208";a="159460037"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2020 18:52:08 -0800
IronPort-SDR: 8B32LeFD5GerHRc39O145VSi8lTv4xHkdVYV3HrmBINKOdOPkXv0AAlxXhhwSAvpLnCgIRW9ud
 K8XqvnHp8KIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,361,1599548400"; 
   d="scan'208";a="369879917"
Received: from jsia-hp-z620-workstation.png.intel.com ([10.221.118.135])
  by FMSMGA003.fm.intel.com with ESMTP; 22 Nov 2020 18:52:06 -0800
From:   Sia Jee Heng <jee.heng.sia@intel.com>
To:     vkoul@kernel.org, Eugeniy.Paltsev@synopsys.com, robh+dt@kernel.org
Cc:     andriy.shevchenko@linux.intel.com, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v5 12/16] dmaengine: dw-axi-dmac: Add Intel KeemBay AxiDMA support
Date:   Mon, 23 Nov 2020 10:34:48 +0800
Message-Id: <20201123023452.7894-13-jee.heng.sia@intel.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20201123023452.7894-1-jee.heng.sia@intel.com>
References: <20201123023452.7894-1-jee.heng.sia@intel.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Add support for Intel KeemBay AxiDMA to the .compatible field.
The AxiDMA Apb region will be accessible if the compatible string
matches the "intel,kmb-axi-dma".

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Sia Jee Heng <jee.heng.sia@intel.com>
---
 drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
index 29323e75bc44..8135b827b47a 100644
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

