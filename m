Return-Path: <dmaengine+bounces-1012-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 74B6F854930
	for <lists+dmaengine@lfdr.de>; Wed, 14 Feb 2024 13:27:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0C171F21BC8
	for <lists+dmaengine@lfdr.de>; Wed, 14 Feb 2024 12:27:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AEA321363;
	Wed, 14 Feb 2024 12:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="oRGWCJFZ"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B9F72110E
	for <dmaengine@vger.kernel.org>; Wed, 14 Feb 2024 12:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707913622; cv=none; b=V/geGgbgCFXnTq2yiFVGCU9WUSOe1eLxVDmSc/5ljgndyXXUELK1NT44DrVX++WGxGlFDFABQhsehGSJT2E0MDjB10SG8IToAqAW3ewkykbekgJViX3ldXHSFBa9mp+yi7bkRm90BG/n3jmqVwNQk0GV6hdVklofW+LY4vXNpJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707913622; c=relaxed/simple;
	bh=3k4nsHALhwgihyKUjN+DzVjdL/6M9kFxUKd6TFlhLlc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=EMCIgjO6GaWYaK+9wKEcQW7thSQVBKaOWdsRScRBtAKfj9nZ7wFFDE5R5mSq3ORcPCy7XF7RV3TksGvqhBxO4LCnopQvhDCO/PSEMFNtTIYmZs88FkZgBOaOT7/7gam9szw4WLeKDhClVAxYZhKGTRSIpVrqT34ttOZL6miHzeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=oRGWCJFZ; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41E8rQZh030222;
	Wed, 14 Feb 2024 07:26:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:to:cc; s=DKIM; bh=V5Z48DV3
	xm85jvrX1iaRA8vGmFszlTusT3IwnLSQkQU=; b=oRGWCJFZXyA8aynRW75RKUT8
	ooir1G3fDDSh+OO+95gloq4nxz9BNb0ctiyBuD4T3ZVqlK7k+5RSj4GMbc2STQmx
	TRtNM8Jt3nYmLPktvyEtMli/dvqFtKVCSEvrcAtB8HD9xevug4abyvWWy/vbF2mC
	O2jewRPtujWT66yUBmISkwFztkZCYd0cVIbaFaDlKDV/aqYpnyOOxxbUINzqdl82
	jPiqzjlXqdmfgzwO9RaYwGkt9U9xVo7lIvheZoBoxm922AxSCA8C8TiEyaeFyCyd
	+AcZT7eRdJGtWNTzdtFxlRoEzdvubzkarUsFeNxkqHe2MvLqHH5sLXlndFkcxg==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3w6purd80f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 Feb 2024 07:26:34 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 41ECQWxt018821
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 14 Feb 2024 07:26:32 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Wed, 14 Feb
 2024 07:26:31 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Wed, 14 Feb 2024 07:26:31 -0500
Received: from [127.0.0.1] ([10.44.3.56])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 41ECQMab029705;
	Wed, 14 Feb 2024 07:26:25 -0500
From: Nuno Sa <nuno.sa@analog.com>
Date: Wed, 14 Feb 2024 13:29:36 +0100
Subject: [PATCH] dmaengine: axi-dmac: move to device managed probe
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <20240214-axi-dmac-devm-probe-v1-1-22d633da19cb@analog.com>
X-B4-Tracking: v=1; b=H4sIAC+yzGUC/x3MQQqAIBBA0avErBtQs5KuEi00x5pFGQoRSHdPW
 r7F/wUyJaYMU1Mg0c2Z41kh2wbW3Z4bIftqUEJpoaRG+zD6w67o6T7wStER+lEaCt0QXG+glle
 iwM9/nZf3/QDTOZu5ZQAAAA==
To: <dmaengine@vger.kernel.org>
CC: Lars-Peter Clausen <lars@metafoo.de>, Vinod Koul <vkoul@kernel.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1707913782; l=4659;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=3k4nsHALhwgihyKUjN+DzVjdL/6M9kFxUKd6TFlhLlc=;
 b=2N7QzEsW1KuLDVTaZm9+FX47VKv66Omfpo/R8SOMNtIw/Xbc5YHqBnBLPW+uWhtQ9CdIwmNX2
 gpdNry/ESWXBryEIlPIqjnRwekt5TOiREJa6fUPZ4nIp2OVNjyBI9sl
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: XaZK81VRTJUOpuX1OoxIHLKZIOIjlQlq
X-Proofpoint-ORIG-GUID: XaZK81VRTJUOpuX1OoxIHLKZIOIjlQlq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-14_05,2024-02-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1011 phishscore=0 spamscore=0 mlxlogscore=548 suspectscore=0
 priorityscore=1501 adultscore=0 impostorscore=0 mlxscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402140096

In axi_dmac_probe(), there's a mix in using device managed APIs and
explicitly cleaning things in the driver .remove() hook. Move to use
device managed APIs and thus drop the .remove() hook.

While doing this move request_irq() before of_dma_controller_register()
so the previous cleanup order in the .remove() hook is preserved.

Signed-off-by: Nuno Sa <nuno.sa@analog.com>
---
 drivers/dma/dma-axi-dmac.c | 80 ++++++++++++++++++++--------------------------
 1 file changed, 35 insertions(+), 45 deletions(-)

diff --git a/drivers/dma/dma-axi-dmac.c b/drivers/dma/dma-axi-dmac.c
index 4e339c04fc1e..24c911dc3161 100644
--- a/drivers/dma/dma-axi-dmac.c
+++ b/drivers/dma/dma-axi-dmac.c
@@ -1002,6 +1002,16 @@ static int axi_dmac_detect_caps(struct axi_dmac *dmac, unsigned int version)
 	return 0;
 }
 
+static void axi_dmac_tasklet_kill(void *task)
+{
+	tasklet_kill(task);
+}
+
+static void axi_dmac_free_dma_controller(void *of_node)
+{
+	of_dma_controller_free(of_node);
+}
+
 static int axi_dmac_probe(struct platform_device *pdev)
 {
 	struct dma_device *dma_dev;
@@ -1025,14 +1035,10 @@ static int axi_dmac_probe(struct platform_device *pdev)
 	if (IS_ERR(dmac->base))
 		return PTR_ERR(dmac->base);
 
-	dmac->clk = devm_clk_get(&pdev->dev, NULL);
+	dmac->clk = devm_clk_get_enabled(&pdev->dev, NULL);
 	if (IS_ERR(dmac->clk))
 		return PTR_ERR(dmac->clk);
 
-	ret = clk_prepare_enable(dmac->clk);
-	if (ret < 0)
-		return ret;
-
 	version = axi_dmac_read(dmac, ADI_AXI_REG_VERSION);
 
 	if (version >= ADI_AXI_PCORE_VER(4, 3, 'a'))
@@ -1041,7 +1047,7 @@ static int axi_dmac_probe(struct platform_device *pdev)
 		ret = axi_dmac_parse_dt(&pdev->dev, dmac);
 
 	if (ret < 0)
-		goto err_clk_disable;
+		return ret;
 
 	INIT_LIST_HEAD(&dmac->chan.active_descs);
 
@@ -1072,7 +1078,7 @@ static int axi_dmac_probe(struct platform_device *pdev)
 
 	ret = axi_dmac_detect_caps(dmac, version);
 	if (ret)
-		goto err_clk_disable;
+		return ret;
 
 	dma_dev->copy_align = (dmac->chan.address_align_mask + 1);
 
@@ -1088,57 +1094,42 @@ static int axi_dmac_probe(struct platform_device *pdev)
 		    !AXI_DMAC_DST_COHERENT_GET(ret)) {
 			dev_err(dmac->dma_dev.dev,
 				"Coherent DMA not supported in hardware");
-			ret = -EINVAL;
-			goto err_clk_disable;
+			return -EINVAL;
 		}
 	}
 
-	ret = dma_async_device_register(dma_dev);
+	ret = dmaenginem_async_device_register(dma_dev);
+	if (ret)
+		return ret;
+
+	/*
+	 * Put the action in here so it get's done before unregistering the DMA
+	 * device.
+	 */
+	ret = devm_add_action_or_reset(&pdev->dev, axi_dmac_tasklet_kill,
+				       &dmac->chan.vchan.task);
+	if (ret)
+		return ret;
+
+	ret = devm_request_irq(&pdev->dev, dmac->irq, axi_dmac_interrupt_handler,
+			       IRQF_SHARED, dev_name(&pdev->dev), dmac);
 	if (ret)
-		goto err_clk_disable;
+		return ret;
 
 	ret = of_dma_controller_register(pdev->dev.of_node,
 		of_dma_xlate_by_chan_id, dma_dev);
 	if (ret)
-		goto err_unregister_device;
+		return ret;
 
-	ret = request_irq(dmac->irq, axi_dmac_interrupt_handler, IRQF_SHARED,
-		dev_name(&pdev->dev), dmac);
+	ret = devm_add_action_or_reset(&pdev->dev, axi_dmac_free_dma_controller,
+				       pdev->dev.of_node);
 	if (ret)
-		goto err_unregister_of;
-
-	platform_set_drvdata(pdev, dmac);
+		return ret;
 
 	regmap = devm_regmap_init_mmio(&pdev->dev, dmac->base,
 		 &axi_dmac_regmap_config);
-	if (IS_ERR(regmap)) {
-		ret = PTR_ERR(regmap);
-		goto err_free_irq;
-	}
-
-	return 0;
-
-err_free_irq:
-	free_irq(dmac->irq, dmac);
-err_unregister_of:
-	of_dma_controller_free(pdev->dev.of_node);
-err_unregister_device:
-	dma_async_device_unregister(&dmac->dma_dev);
-err_clk_disable:
-	clk_disable_unprepare(dmac->clk);
-
-	return ret;
-}
-
-static void axi_dmac_remove(struct platform_device *pdev)
-{
-	struct axi_dmac *dmac = platform_get_drvdata(pdev);
 
-	of_dma_controller_free(pdev->dev.of_node);
-	free_irq(dmac->irq, dmac);
-	tasklet_kill(&dmac->chan.vchan.task);
-	dma_async_device_unregister(&dmac->dma_dev);
-	clk_disable_unprepare(dmac->clk);
+	return PTR_ERR_OR_ZERO(regmap);
 }
 
 static const struct of_device_id axi_dmac_of_match_table[] = {
@@ -1153,7 +1144,6 @@ static struct platform_driver axi_dmac_driver = {
 		.of_match_table = axi_dmac_of_match_table,
 	},
 	.probe = axi_dmac_probe,
-	.remove_new = axi_dmac_remove,
 };
 module_platform_driver(axi_dmac_driver);
 

---
base-commit: de7d9cb3b064fdfb2e0e7706d14ffee20b762ad2
change-id: 20240214-axi-dmac-devm-probe-d718ef36fb58
--

Thanks!
- Nuno Sá


