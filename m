Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C2E2573BE9
	for <lists+dmaengine@lfdr.de>; Wed, 13 Jul 2022 19:22:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235537AbiGMRWf (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 13 Jul 2022 13:22:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231478AbiGMRWc (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 13 Jul 2022 13:22:32 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B441AC60;
        Wed, 13 Jul 2022 10:22:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657732951; x=1689268951;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=bkLgqKbd/VvVIGBhAMjtBA1FLyFfzcA7yQjopEHFUKY=;
  b=K1NaL/CMUAz3O6YdZbQ0unK3UQddBFjY9mCdFL0P3gGklRoCO8fHEmZq
   2I9Xa3wMP04YUF/3PeMKMdsRPf9IwWW3vR9tfQMGbBPXwZVYzE5yQpNIK
   zELY5jnqRmxe7xP82A1qhjENmYFuTC68SVZSMImBXXDVl8ej/xUhpcaEj
   n5qE9HeAK81RwL4NDluU6wAHEL7bkevQMJK9lHsRJlJ2ssavdC11iaP8p
   gqKCvOZjl/9mifnanJFyAb/rPpjwqbyXM/Hck6uG5FjmXSu7C2qsx9Sol
   sYGp0clZOOHgCIK+yRxyEBRj2t5z/RyY+eQTWbiYrRqhat0KevxtWoDDA
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10407"; a="371605136"
X-IronPort-AV: E=Sophos;i="5.92,267,1650956400"; 
   d="scan'208";a="371605136"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2022 10:22:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,267,1650956400"; 
   d="scan'208";a="922726186"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 13 Jul 2022 10:22:30 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 32C65F1; Wed, 13 Jul 2022 20:22:37 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Vinod Koul <vkoul@kernel.org>
Subject: [PATCH v1 1/4] dmaengine: hsu: Finish conversion to managed resources
Date:   Wed, 13 Jul 2022 20:22:32 +0300
Message-Id: <20220713172235.22611-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

With help of devm_add_action_or_reset() we may finish conversion
the driver to use managed resources.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/dma/hsu/pci.c | 27 ++++++++++++---------------
 1 file changed, 12 insertions(+), 15 deletions(-)

diff --git a/drivers/dma/hsu/pci.c b/drivers/dma/hsu/pci.c
index 6a2df3dd78d0..4ed6a4ef1512 100644
--- a/drivers/dma/hsu/pci.c
+++ b/drivers/dma/hsu/pci.c
@@ -47,8 +47,14 @@ static irqreturn_t hsu_pci_irq(int irq, void *dev)
 	return IRQ_RETVAL(ret);
 }
 
+static void hsu_pci_dma_remove(void *chip)
+{
+	hsu_dma_remove(chip);
+}
+
 static int hsu_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 {
+	struct device *dev = &pdev->dev;
 	struct hsu_dma_chip *chip;
 	int ret;
 
@@ -87,9 +93,13 @@ static int hsu_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (ret)
 		return ret;
 
-	ret = request_irq(chip->irq, hsu_pci_irq, 0, "hsu_dma_pci", chip);
+	ret = devm_add_action_or_reset(dev, hsu_pci_dma_remove, chip);
 	if (ret)
-		goto err_register_irq;
+		return ret;
+
+	ret = devm_request_irq(dev, chip->irq, hsu_pci_irq, 0, "hsu_dma_pci", chip);
+	if (ret)
+		return ret;
 
 	/*
 	 * On Intel Tangier B0 and Anniedale the interrupt line, disregarding
@@ -105,18 +115,6 @@ static int hsu_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	pci_set_drvdata(pdev, chip);
 
 	return 0;
-
-err_register_irq:
-	hsu_dma_remove(chip);
-	return ret;
-}
-
-static void hsu_pci_remove(struct pci_dev *pdev)
-{
-	struct hsu_dma_chip *chip = pci_get_drvdata(pdev);
-
-	free_irq(chip->irq, chip);
-	hsu_dma_remove(chip);
 }
 
 static const struct pci_device_id hsu_pci_id_table[] = {
@@ -130,7 +128,6 @@ static struct pci_driver hsu_pci_driver = {
 	.name		= "hsu_dma_pci",
 	.id_table	= hsu_pci_id_table,
 	.probe		= hsu_pci_probe,
-	.remove		= hsu_pci_remove,
 };
 
 module_pci_driver(hsu_pci_driver);
-- 
2.35.1

