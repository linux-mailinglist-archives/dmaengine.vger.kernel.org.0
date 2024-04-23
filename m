Return-Path: <dmaengine+bounces-1938-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76B4C8AF3A7
	for <lists+dmaengine@lfdr.de>; Tue, 23 Apr 2024 18:14:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 908061C23A20
	for <lists+dmaengine@lfdr.de>; Tue, 23 Apr 2024 16:14:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FA2313D276;
	Tue, 23 Apr 2024 16:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rnp7POTR"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0F6513D254;
	Tue, 23 Apr 2024 16:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713888867; cv=none; b=Xta/0T1jaSG9Zlec8EWbaPG3XDjPzJzJ9j5g9221vFNTBD0gXJYdC4UZ+fQ/9WRRvfcIHGxNKcce/XB4DiF8VNKZ/+TUHvadVfIDxG7PxVvoP6ohOkUuY19ucyDBVvHpzziXfQ5PzDz88sTnvaO5qp98ziXSW7i+criIx1KjXYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713888867; c=relaxed/simple;
	bh=MF9MVVzEWCkDsJuADHSSNcmrmA+7PiShcDl8I7RBoxc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=e7hHloKXMPCVpvbkNaxJyqvajyi8KhGBCRM26OScERtxOM+t96+DkLVL1DRIKyJPJHKpIf+ZS6Yp7SZuC/B0hWop+qHJY6K7GaGNvENE3p7LVet7DF4k0DgVHfsL/aEnmEnOYixEl9XJhh+PdnJ/1GirE2mGTWBh5szMzpLFnEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rnp7POTR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47E89C116B1;
	Tue, 23 Apr 2024 16:14:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713888866;
	bh=MF9MVVzEWCkDsJuADHSSNcmrmA+7PiShcDl8I7RBoxc=;
	h=From:To:Cc:Subject:Date:From;
	b=Rnp7POTRChNVWoSOXbUa2zBnh+rlPche521eDQGL2p8mhuvEiKZsZDk87UD5BXypF
	 mmETVh4VNB5hs4LnXDXqUOAj8fbPCoOJfEl0vaDZZ0OSMuoIaOUgNa/XUOCVPw0K5s
	 IylTEhSZ2UYn01X9oq9G3oP/rQq+qTXA74DlswQcH1omX9ZJ6O8xvdVswOMsStjDY9
	 FQWVZCIQnr6inXW4w6HRuC4mVd3pS5mU1YpsQMRuG6aeBVGml++KC9ccSOMPpsr2F1
	 UhHppXuYNw974WA5nHM9/5I1WQuEdGO3MdND7qsFreQrkfcnZ3OKUH6LkdaoITtz+N
	 NJ19JgsfD8UjQ==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Sinan Kaya <okaya@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Vinod Koul <vkoul@kernel.org>
Cc: Dan Carpenter <dan.carpenter@linaro.org>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-arm-msm@vger.kernel.org,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] dmaengine: qcom: Drop hidma DT support
Date: Tue, 23 Apr 2024 11:14:11 -0500
Message-ID: <20240423161413.481670-1-robh@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The DT support in hidma has been broken since commit 37fa4905d22a
("dmaengine: qcom_hidma: simplify DT resource parsing") in 2018. The
issue is the of_address_to_resource() calls bail out on success rather
than failure. This driver is for a defunct QCom server platform where
DT use was limited to start with. As it seems no one has noticed the
breakage, just remove the DT support altogether.

Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 drivers/dma/qcom/hidma.c      |  11 ----
 drivers/dma/qcom/hidma_mgmt.c | 109 +---------------------------------
 2 files changed, 1 insertion(+), 119 deletions(-)

diff --git a/drivers/dma/qcom/hidma.c b/drivers/dma/qcom/hidma.c
index 202ac95227cb..721b4ac0857a 100644
--- a/drivers/dma/qcom/hidma.c
+++ b/drivers/dma/qcom/hidma.c
@@ -50,7 +50,6 @@
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
-#include <linux/of_dma.h>
 #include <linux/property.h>
 #include <linux/delay.h>
 #include <linux/acpi.h>
@@ -947,22 +946,12 @@ static const struct acpi_device_id hidma_acpi_ids[] = {
 MODULE_DEVICE_TABLE(acpi, hidma_acpi_ids);
 #endif
 
-static const struct of_device_id hidma_match[] = {
-	{.compatible = "qcom,hidma-1.0",},
-	{.compatible = "qcom,hidma-1.1", .data = (void *)(HIDMA_MSI_CAP),},
-	{.compatible = "qcom,hidma-1.2",
-	 .data = (void *)(HIDMA_MSI_CAP | HIDMA_IDENTITY_CAP),},
-	{},
-};
-MODULE_DEVICE_TABLE(of, hidma_match);
-
 static struct platform_driver hidma_driver = {
 	.probe = hidma_probe,
 	.remove_new = hidma_remove,
 	.shutdown = hidma_shutdown,
 	.driver = {
 		   .name = "hidma",
-		   .of_match_table = hidma_match,
 		   .acpi_match_table = ACPI_PTR(hidma_acpi_ids),
 	},
 };
diff --git a/drivers/dma/qcom/hidma_mgmt.c b/drivers/dma/qcom/hidma_mgmt.c
index 1d675f31252b..bb883e138ebf 100644
--- a/drivers/dma/qcom/hidma_mgmt.c
+++ b/drivers/dma/qcom/hidma_mgmt.c
@@ -7,12 +7,7 @@
 
 #include <linux/dmaengine.h>
 #include <linux/acpi.h>
-#include <linux/of.h>
 #include <linux/property.h>
-#include <linux/of_address.h>
-#include <linux/of_irq.h>
-#include <linux/of_platform.h>
-#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/module.h>
 #include <linux/uaccess.h>
@@ -327,115 +322,13 @@ static const struct acpi_device_id hidma_mgmt_acpi_ids[] = {
 MODULE_DEVICE_TABLE(acpi, hidma_mgmt_acpi_ids);
 #endif
 
-static const struct of_device_id hidma_mgmt_match[] = {
-	{.compatible = "qcom,hidma-mgmt-1.0",},
-	{},
-};
-MODULE_DEVICE_TABLE(of, hidma_mgmt_match);
-
 static struct platform_driver hidma_mgmt_driver = {
 	.probe = hidma_mgmt_probe,
 	.driver = {
 		   .name = "hidma-mgmt",
-		   .of_match_table = hidma_mgmt_match,
 		   .acpi_match_table = ACPI_PTR(hidma_mgmt_acpi_ids),
 	},
 };
 
-#if defined(CONFIG_OF) && defined(CONFIG_OF_IRQ)
-static int object_counter;
-
-static int __init hidma_mgmt_of_populate_channels(struct device_node *np)
-{
-	struct platform_device *pdev_parent = of_find_device_by_node(np);
-	struct platform_device_info pdevinfo;
-	struct device_node *child;
-	struct resource *res;
-	int ret = 0;
-
-	/* allocate a resource array */
-	res = kcalloc(3, sizeof(*res), GFP_KERNEL);
-	if (!res)
-		return -ENOMEM;
-
-	for_each_available_child_of_node(np, child) {
-		struct platform_device *new_pdev;
-
-		ret = of_address_to_resource(child, 0, &res[0]);
-		if (!ret)
-			goto out;
-
-		ret = of_address_to_resource(child, 1, &res[1]);
-		if (!ret)
-			goto out;
-
-		ret = of_irq_to_resource(child, 0, &res[2]);
-		if (ret <= 0)
-			goto out;
-
-		memset(&pdevinfo, 0, sizeof(pdevinfo));
-		pdevinfo.fwnode = &child->fwnode;
-		pdevinfo.parent = pdev_parent ? &pdev_parent->dev : NULL;
-		pdevinfo.name = child->name;
-		pdevinfo.id = object_counter++;
-		pdevinfo.res = res;
-		pdevinfo.num_res = 3;
-		pdevinfo.data = NULL;
-		pdevinfo.size_data = 0;
-		pdevinfo.dma_mask = DMA_BIT_MASK(64);
-		new_pdev = platform_device_register_full(&pdevinfo);
-		if (IS_ERR(new_pdev)) {
-			ret = PTR_ERR(new_pdev);
-			goto out;
-		}
-		new_pdev->dev.of_node = child;
-		of_dma_configure(&new_pdev->dev, child, true);
-		/*
-		 * It is assumed that calling of_msi_configure is safe on
-		 * platforms with or without MSI support.
-		 */
-		of_msi_configure(&new_pdev->dev, child);
-	}
-
-	kfree(res);
-
-	return ret;
-
-out:
-	of_node_put(child);
-	kfree(res);
-
-	return ret;
-}
-#endif
-
-static int __init hidma_mgmt_init(void)
-{
-#if defined(CONFIG_OF) && defined(CONFIG_OF_IRQ)
-	struct device_node *child;
-
-	for_each_matching_node(child, hidma_mgmt_match) {
-		/* device tree based firmware here */
-		hidma_mgmt_of_populate_channels(child);
-	}
-#endif
-	/*
-	 * We do not check for return value here, as it is assumed that
-	 * platform_driver_register must not fail. The reason for this is that
-	 * the (potential) hidma_mgmt_of_populate_channels calls above are not
-	 * cleaned up if it does fail, and to do this work is quite
-	 * complicated. In particular, various calls of of_address_to_resource,
-	 * of_irq_to_resource, platform_device_register_full, of_dma_configure,
-	 * and of_msi_configure which then call other functions and so on, must
-	 * be cleaned up - this is not a trivial exercise.
-	 *
-	 * Currently, this module is not intended to be unloaded, and there is
-	 * no module_exit function defined which does the needed cleanup. For
-	 * this reason, we have to assume success here.
-	 */
-	platform_driver_register(&hidma_mgmt_driver);
-
-	return 0;
-}
-module_init(hidma_mgmt_init);
+module_platform_driver(hidma_mgmt_driver);
 MODULE_LICENSE("GPL v2");
-- 
2.43.0


