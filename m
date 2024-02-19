Return-Path: <dmaengine+bounces-1035-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D6A385A0CA
	for <lists+dmaengine@lfdr.de>; Mon, 19 Feb 2024 11:17:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8643A1F23763
	for <lists+dmaengine@lfdr.de>; Mon, 19 Feb 2024 10:17:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4749F28DB5;
	Mon, 19 Feb 2024 10:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="oKIOQ6ui"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76A0528DBD
	for <dmaengine@vger.kernel.org>; Mon, 19 Feb 2024 10:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708337829; cv=none; b=T3ClL4ijNbDKt2+DCq9DfVRMpuKqamxZhvAi1US1DO5VxXyJJ/eRfj/RdVOuJLE2yzxkscssD6XrO1cU1LEOPRvpFu9NiHINBnHMJazlJROUWTZDMe1ZuxmgrXyPwuaSR89wetkLPI6NoJ+UTWcpj9+CCy3QGBSk3FVnPeq1LxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708337829; c=relaxed/simple;
	bh=6roOxEVnsLfbtbTzAbab0yVVN4cgu8hdi24lEZlmOW8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=s4bCWm3DhQstZwMH+3XGXySzTxQEhQ9vDr2ep0dt77R4pJm4wEKAhMahJaBR5AAqcfX8CTZgWIec250J0zbGIGGC4Kscx+7mnbVMLtqd1DvaJ19oYvNm4MJ99zGX4TyStJ9oE4LNnBALSEcAfAx0BbGpO+V7YhWz5iiFNdheFR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=oKIOQ6ui; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41J4l79c011886;
	Mon, 19 Feb 2024 05:16:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:to:cc; s=DKIM; bh=fc9shZm+
	OAZfxdhZnG9bGGwcpv+9tCmKQ0PFuQVb/Vo=; b=oKIOQ6uie/Db0HAyDzUifR+4
	VXZzj/WhGu5W0pKApaHcRkW93IxU3QYwdgGyX+ZmfRWs2kRkho4kFYsnI1iywNaZ
	8dSv9PPkO03GRKNf7zt4fuWzkDCHjCyyRa4f7K6oSqwTVfVu5NI4GsLiZW8GTabe
	V4U4MFRbj1jyanZY5lL7mP6wzbTHTP3bmp5NhdRADTMWgWvMLrq4wHr+NTVTWXH8
	bpvJl2KZn0IFw1h5z4THNQNzqRj9pf6fClbLvAFczlPY+Rfe9oUojGncnPYgYArm
	phyZCKmf4WoNk+7lX0PSM1Kx1iT9ozYB9oWGON2GK/6nkjtubkfNXyp6LodwJw==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3waqh8ep32-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 Feb 2024 05:16:53 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 41JAGqtS003628
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 19 Feb 2024 05:16:52 -0500
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Mon, 19 Feb 2024 05:16:51 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Mon, 19 Feb 2024 05:16:51 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Mon, 19 Feb 2024 05:16:51 -0500
Received: from [127.0.0.1] ([10.44.3.56])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 41JAGh3r029741;
	Mon, 19 Feb 2024 05:16:45 -0500
From: Nuno Sa <nuno.sa@analog.com>
Date: Mon, 19 Feb 2024 11:20:05 +0100
Subject: [PATCH v2] dmaengine: axi-dmac: move to device managed probe
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <20240219-axi-dmac-devm-probe-v2-1-1a6737294f69@analog.com>
X-B4-Tracking: v=1; b=H4sIAFQr02UC/32NTQ6CMBBGr0Jm7RhaENGV9zAs+jOFSYSS1jQY0
 rtbOYDL95LvfTtECkwR7tUOgRJH9ksBearATGoZCdkWBlnLtpaiRbUx2lkZtJRmXIPXhPYqenJ
 N5/Slh7JcAznejupzKDxxfPvwOU6S+Nn/vSRQoJS2axqrxM3oh1rUy49n42cYcs5fzVDLBrcAA
 AA=
To: <dmaengine@vger.kernel.org>
CC: Lars-Peter Clausen <lars@metafoo.de>, Vinod Koul <vkoul@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708338006; l=5227;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=6roOxEVnsLfbtbTzAbab0yVVN4cgu8hdi24lEZlmOW8=;
 b=uPH6qJBdjZ4VWYfmEAHTdBDw364LdFfUi2HAbQz5q0jg5LbVuI4txRgRTT/u2Tv394jN5BBMK
 nQ+VrNeYmSgB4KmJh7PjRab30sdalyx95CylmC4W97FSg1NbW/+7p0W
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: Z7b_Jj6zSYbPEeLrl7OP_CEbkZkfzUFz
X-Proofpoint-GUID: Z7b_Jj6zSYbPEeLrl7OP_CEbkZkfzUFz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-19_07,2024-02-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 lowpriorityscore=0 mlxlogscore=839 suspectscore=0 spamscore=0
 impostorscore=0 adultscore=0 mlxscore=0 priorityscore=1501 clxscore=1015
 phishscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402190077

In axi_dmac_probe(), there's a mix in using device managed APIs and
explicitly cleaning things in the driver .remove() hook. Move to use
device managed APIs and thus drop the .remove() hook.

While doing this move request_irq() before of_dma_controller_register()
so the previous cleanup order in the .remove() hook is preserved.

Signed-off-by: Nuno Sa <nuno.sa@analog.com>
---
Changes in v2:
- Keep devm_request_irq() after of_dma_controller_register() so we free
  the irq first and avoid any possible race agains
  of_dma_controller_register().
- Link to v1: https://lore.kernel.org/r/20240214-axi-dmac-devm-probe-v1-1-22d633da19cb@analog.com

Vinod,

This actually made me think if I shouldn't have a preliminary patch
just moving free_irq() before of_dma_controller_register() and treating
it as bug (adding a proper fixes tag). Then moving to devm_ in a follow up
patch.

What do you think? Is it worth it to backport this?
---
 drivers/dma/dma-axi-dmac.c | 78 ++++++++++++++++++++--------------------------
 1 file changed, 34 insertions(+), 44 deletions(-)

diff --git a/drivers/dma/dma-axi-dmac.c b/drivers/dma/dma-axi-dmac.c
index 4e339c04fc1e..bdb752f11869 100644
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
+		return ret;
 
-	platform_set_drvdata(pdev, dmac);
+	ret = devm_request_irq(&pdev->dev, dmac->irq, axi_dmac_interrupt_handler,
+			       IRQF_SHARED, dev_name(&pdev->dev), dmac);
+	if (ret)
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


