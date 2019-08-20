Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 23D9E95FBA
	for <lists+dmaengine@lfdr.de>; Tue, 20 Aug 2019 15:16:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729865AbfHTNPx (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 20 Aug 2019 09:15:53 -0400
Received: from mga04.intel.com ([192.55.52.120]:41653 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729818AbfHTNPw (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 20 Aug 2019 09:15:52 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Aug 2019 06:15:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,408,1559545200"; 
   d="scan'208";a="183194740"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga006.jf.intel.com with ESMTP; 20 Aug 2019 06:15:50 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 581A732D; Tue, 20 Aug 2019 16:15:47 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
        Viresh Kumar <vireshk@kernel.org>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 07/10] dmaengine: dw: platform: Switch to acpi_dma_controller_register()
Date:   Tue, 20 Aug 2019 16:15:43 +0300
Message-Id: <20190820131546.75744-8-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <20190820131546.75744-1-andriy.shevchenko@linux.intel.com>
References: <20190820131546.75744-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

There is a possibility to have registered ACPI DMA controller
while it has been gone already.

To avoid the potential crash, move to non-managed
acpi_dma_controller_register().

Fixes: 42c91ee71d6d ("dw_dmac: add ACPI support")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/dma/dw/platform.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/dw/platform.c b/drivers/dma/dw/platform.c
index 8576439d0035..44fec1eabccd 100644
--- a/drivers/dma/dw/platform.c
+++ b/drivers/dma/dw/platform.c
@@ -84,13 +84,20 @@ static void dw_dma_acpi_controller_register(struct dw_dma *dw)
 	dma_cap_set(DMA_SLAVE, info->dma_cap);
 	info->filter_fn = dw_dma_acpi_filter;
 
-	ret = devm_acpi_dma_controller_register(dev, acpi_dma_simple_xlate,
-						info);
+	ret = acpi_dma_controller_register(dev, acpi_dma_simple_xlate, info);
 	if (ret)
 		dev_err(dev, "could not register acpi_dma_controller\n");
 }
+
+static void dw_dma_acpi_controller_free(struct dw_dma *dw)
+{
+	struct device *dev = dw->dma.dev;
+
+	acpi_dma_controller_free(dev);
+}
 #else /* !CONFIG_ACPI */
 static inline void dw_dma_acpi_controller_register(struct dw_dma *dw) {}
+static inline void dw_dma_acpi_controller_free(struct dw_dma *dw) {}
 #endif /* !CONFIG_ACPI */
 
 #ifdef CONFIG_OF
@@ -249,6 +256,9 @@ static int dw_remove(struct platform_device *pdev)
 	struct dw_dma_chip *chip = data->chip;
 	int ret;
 
+	if (ACPI_HANDLE(&pdev->dev))
+		dw_dma_acpi_controller_free(chip->dw);
+
 	if (pdev->dev.of_node)
 		of_dma_controller_free(pdev->dev.of_node);
 
-- 
2.23.0.rc1

