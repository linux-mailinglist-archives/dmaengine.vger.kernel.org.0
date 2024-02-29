Return-Path: <dmaengine+bounces-1199-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AF15486CEF3
	for <lists+dmaengine@lfdr.de>; Thu, 29 Feb 2024 17:26:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4EE11F21E08
	for <lists+dmaengine@lfdr.de>; Thu, 29 Feb 2024 16:26:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 814927829D;
	Thu, 29 Feb 2024 16:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="rZ9IAcG0"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D29E17829F
	for <dmaengine@vger.kernel.org>; Thu, 29 Feb 2024 16:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709223646; cv=none; b=UeO5EqrncMGeV7Mx4laT1aLDZma/SYg8dFKkgKkEYOhgpBH6kINPwt6LVI3KcnM++/hnlw27T+C9Cp7ptZnGURSOSuJAj0nylIDq9N+z6mRI+huob908vyR6is+8yPgvMM/oCoVVx3mK+W/LgGdnKwJHg6eUjd33Hr5f+taD/4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709223646; c=relaxed/simple;
	bh=rZMNbtxfIMUciFGjv9gWxN1PMrqZXwg7bE9MuSd/GkM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=EWBqsqfEAicMyd8/urJtMUjGYN2o070mTqhBBhXIq1sqZbXpgyMF/d6GSkEa+WV7aZhvXrFgQNfoA85jEbny/D7oVk0zn5G0TsFy1JzCF3vfSnIzIqizdRtuj2BtyxysZ/g72jwxhqiLRQYmWK1iA3s647fs7AZCnBAd9NIqIJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=rZ9IAcG0; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41TF6f9A013749;
	Thu, 29 Feb 2024 11:20:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:references:in-reply-to:to
	:cc; s=DKIM; bh=FxSICDQzTucoIj+Ma6YEPoVB46HeW4ERCz0JtglgkWY=; b=
	rZ9IAcG0eBNlUBv1mgFYO+W93/XubHYqgNo04JERQAI7SiXZU1QHi4dJziUtERXo
	pCG0UiJqGqQx9JZ/7XH7G+8oFY4NBQA5RToLqLjs/c4gnhsWZFdAkAHkB55cYICF
	zssWuyjqAxGuSoYKXM277WhZAXIsvoI6fsVQ6bgqASSTuaxsaitxp70VBu/UMEee
	05qLKi7tSfe7/lCAeczALZUyVWxWuUmIQqT87BHHPVHZtvv3WQM/VTe1Drn5aSgc
	GbCJnwRiXH+xQy79KBbMt5e3KbV0bmthmnBn/YZltnHRzFtInOm5pVsDCOSRRFYV
	X0tXiiedzNxLJ1vNfUZAYg==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3whyvepvuy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 Feb 2024 11:20:29 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 41TGKSul035247
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 29 Feb 2024 11:20:28 -0500
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Thu, 29 Feb 2024 11:20:27 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Thu, 29 Feb 2024 11:20:27 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Thu, 29 Feb 2024 11:20:27 -0500
Received: from [127.0.0.1] ([10.44.3.58])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 41TGKHwb019308;
	Thu, 29 Feb 2024 11:20:22 -0500
From: Nuno Sa <nuno.sa@analog.com>
Date: Thu, 29 Feb 2024 17:23:17 +0100
Subject: [PATCH RESEND v3 2/2] dmaengine: axi-dmac: move to device managed
 probe
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240229-axi-dmac-devm-probe-v3-2-f0e78d2ab5b1@analog.com>
References: <20240229-axi-dmac-devm-probe-v3-0-f0e78d2ab5b1@analog.com>
In-Reply-To: <20240229-axi-dmac-devm-probe-v3-0-f0e78d2ab5b1@analog.com>
To: <dmaengine@vger.kernel.org>
CC: Lars-Peter Clausen <lars@metafoo.de>, Vinod Koul <vkoul@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709223821; l=4386;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=rZMNbtxfIMUciFGjv9gWxN1PMrqZXwg7bE9MuSd/GkM=;
 b=AGVz2ybcjRmGBAHlJScUzGmVQZrSi0vl2lqbfvuH5UssdrcI/qJcHVUsRp6yw1ziCA6WKXwKr
 2B17kLZV7WIAFvsf3Um3Jed5G9AF6zenUx7wLaThT1t8ge8boL/M74H
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: gsJ4mQceVYEAuEHEc34Bsw2hKZm1Gjqd
X-Proofpoint-GUID: gsJ4mQceVYEAuEHEc34Bsw2hKZm1Gjqd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-29_02,2024-02-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 priorityscore=1501 mlxlogscore=732 spamscore=0 phishscore=0 suspectscore=0
 bulkscore=0 mlxscore=0 lowpriorityscore=0 impostorscore=0 clxscore=1015
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402290125

In axi_dmac_probe(), there's a mix in using device managed APIs and
explicitly cleaning things in the driver .remove() hook. Move to use
device managed APIs and thus drop the .remove() hook.

Signed-off-by: Nuno Sa <nuno.sa@analog.com>
---
 drivers/dma/dma-axi-dmac.c | 78 ++++++++++++++++++++--------------------------
 1 file changed, 34 insertions(+), 44 deletions(-)

diff --git a/drivers/dma/dma-axi-dmac.c b/drivers/dma/dma-axi-dmac.c
index d5a33e4a91b1..bdb752f11869 100644
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
 	if (ret)
-		goto err_clk_disable;
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
-
-	free_irq(dmac->irq, dmac);
-	of_dma_controller_free(pdev->dev.of_node);
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
 

-- 
2.44.0


