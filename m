Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DA77245B1A
	for <lists+dmaengine@lfdr.de>; Fri, 14 Jun 2019 13:06:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727162AbfFNLGI (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 14 Jun 2019 07:06:08 -0400
Received: from mga01.intel.com ([192.55.52.88]:19905 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727153AbfFNLGI (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 14 Jun 2019 07:06:08 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Jun 2019 04:06:07 -0700
X-ExtLoop1: 1
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 14 Jun 2019 04:06:05 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id EACF6110C; Fri, 14 Jun 2019 14:06:04 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Viresh Kumar <vireshk@kernel.org>, dmaengine@vger.kernel.org,
        Dan Williams <dan.j.williams@intel.com>,
        Vinod Koul <vkoul@kernel.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1] dmaengine: dw: Distinguish ->remove() between DW and iDMA 32-bit
Date:   Fri, 14 Jun 2019 14:06:04 +0300
Message-Id: <20190614110604.25375-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

In the same way as done for ->probe(), call ->remove() based on
the type of the hardware.

While it works now due to equivalency of the two removal functions,
it might be changed in the future.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/dma/dw/pci.c | 28 ++++++++++++++++++++--------
 1 file changed, 20 insertions(+), 8 deletions(-)

diff --git a/drivers/dma/dw/pci.c b/drivers/dma/dw/pci.c
index e79a75db0852..6aa1355ded6c 100644
--- a/drivers/dma/dw/pci.c
+++ b/drivers/dma/dw/pci.c
@@ -15,10 +15,13 @@
 struct dw_dma_pci_data {
 	const struct dw_dma_platform_data *pdata;
 	int (*probe)(struct dw_dma_chip *chip);
+	int (*remove)(struct dw_dma_chip *chip);
+	struct dw_dma_chip *chip;
 };
 
 static const struct dw_dma_pci_data dw_pci_data = {
 	.probe = dw_dma_probe,
+	.remove = dw_dma_remove,
 };
 
 static const struct dw_dma_platform_data idma32_pdata = {
@@ -34,11 +37,13 @@ static const struct dw_dma_platform_data idma32_pdata = {
 static const struct dw_dma_pci_data idma32_pci_data = {
 	.pdata = &idma32_pdata,
 	.probe = idma32_dma_probe,
+	.remove = idma32_dma_remove,
 };
 
 static int dw_pci_probe(struct pci_dev *pdev, const struct pci_device_id *pid)
 {
-	const struct dw_dma_pci_data *data = (void *)pid->driver_data;
+	const struct dw_dma_pci_data *drv_data = (void *)pid->driver_data;
+	struct dw_dma_pci_data *data;
 	struct dw_dma_chip *chip;
 	int ret;
 
@@ -63,6 +68,10 @@ static int dw_pci_probe(struct pci_dev *pdev, const struct pci_device_id *pid)
 	if (ret)
 		return ret;
 
+	data = devm_kmemdup(&pdev->dev, drv_data, sizeof(*drv_data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
 	chip = devm_kzalloc(&pdev->dev, sizeof(*chip), GFP_KERNEL);
 	if (!chip)
 		return -ENOMEM;
@@ -73,21 +82,24 @@ static int dw_pci_probe(struct pci_dev *pdev, const struct pci_device_id *pid)
 	chip->irq = pdev->irq;
 	chip->pdata = data->pdata;
 
+	data->chip = chip;
+
 	ret = data->probe(chip);
 	if (ret)
 		return ret;
 
-	pci_set_drvdata(pdev, chip);
+	pci_set_drvdata(pdev, data);
 
 	return 0;
 }
 
 static void dw_pci_remove(struct pci_dev *pdev)
 {
-	struct dw_dma_chip *chip = pci_get_drvdata(pdev);
+	struct dw_dma_pci_data *data = pci_get_drvdata(pdev);
+	struct dw_dma_chip *chip = data->chip;
 	int ret;
 
-	ret = dw_dma_remove(chip);
+	ret = data->remove(chip);
 	if (ret)
 		dev_warn(&pdev->dev, "can't remove device properly: %d\n", ret);
 }
@@ -96,16 +108,16 @@ static void dw_pci_remove(struct pci_dev *pdev)
 
 static int dw_pci_suspend_late(struct device *dev)
 {
-	struct pci_dev *pci = to_pci_dev(dev);
-	struct dw_dma_chip *chip = pci_get_drvdata(pci);
+	struct dw_dma_pci_data *data = dev_get_drvdata(dev);
+	struct dw_dma_chip *chip = data->chip;
 
 	return do_dw_dma_disable(chip);
 };
 
 static int dw_pci_resume_early(struct device *dev)
 {
-	struct pci_dev *pci = to_pci_dev(dev);
-	struct dw_dma_chip *chip = pci_get_drvdata(pci);
+	struct dw_dma_pci_data *data = dev_get_drvdata(dev);
+	struct dw_dma_chip *chip = data->chip;
 
 	return do_dw_dma_enable(chip);
 };
-- 
2.20.1

