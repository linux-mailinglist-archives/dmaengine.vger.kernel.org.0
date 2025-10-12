Return-Path: <dmaengine+bounces-6800-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 11052BD00E5
	for <lists+dmaengine@lfdr.de>; Sun, 12 Oct 2025 12:00:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 335D13A90AE
	for <lists+dmaengine@lfdr.de>; Sun, 12 Oct 2025 10:00:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 642F523C4F3;
	Sun, 12 Oct 2025 10:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GCN2Gccv"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A341221B196
	for <dmaengine@vger.kernel.org>; Sun, 12 Oct 2025 10:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760263235; cv=none; b=SrSIY1CG15Wpmddcylq5X+gj28L9erojIwzyWB2U3heA123e741mRvzzDY5xreeQMw01ROxKi/ThAVf25zYaed09wPjpvjmUdcdbHn5lZwvd+7pK73oWI0yE1bDPlqbk66/w1pXgnHhXpE7O/E0WJliJaKR0dQq10U5mArW847A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760263235; c=relaxed/simple;
	bh=vZJNHbvvtVosuU810afY1IEoJqCYkWU2Iw4KMxlX0Dc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d8/SY4wlJYXoJ1e7fVOw3QWMKar6upIfKAU2ASKPi3yR104uioWQ9tPt/yHICucUzP1OgXYsxLVy+zvAAKmZPgDr4Hp69Zc5LXPGgop9AaDV/7ekY2GIvrDCeT9CABufDptVNSblqZz/7RE/1l+8yOyIbdrR2/hkI/UgTv0tfMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GCN2Gccv; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-57a59124323so3648182e87.2
        for <dmaengine@vger.kernel.org>; Sun, 12 Oct 2025 03:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760263232; x=1760868032; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VYDF2+npqHbQw9zSrp12H/s1KYxESvsd8Xn/2hyxl7A=;
        b=GCN2Gccv2X4u50HDv4LL4dUGYD8cj8jbSPc/zMvVMEtSNvkOob2aCHUEMG1DMaXu9U
         CwI5eJWZGNDSjXukCts21CpwXhgl6QSzg6hUlPSjakZbK93RoD0xhc6sPxfhMBYLfqPo
         Vcd4QMcsIKa6ijlh08RIzipdB5Lbjv1lOQsB54cVNrm3YVaR5piU7Zp4rJHVtm5LJwGK
         9VchAf5pU0aVz1tl3SkCTbtT71sXTJQjc+HaDyuBbf3Re+8e+c2DjJupzXPfcVuAhY7d
         mcgN1axuwGFO9jG5d8QllzldxZw+81D8xmyU7nXHSQlHj4rxnGKTLXaneMbPaPDOTCtn
         9Lkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760263232; x=1760868032;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VYDF2+npqHbQw9zSrp12H/s1KYxESvsd8Xn/2hyxl7A=;
        b=DCm1SRgf5VKokMV4VTcENAkrwFAkzMUVgoHnDnlZ8nkqjB6G0XUCyZpax2rjatCL7M
         Uk8QCMzZMGD+6gL6TV6WAqnFO9yrThu16bKDddtCXjVuro4/Eb5vO/4EwsYZLVzK57Go
         21WQtr5fLPX0sX6JPaLu0tVvZEFbVZo77t0/BN0VyJcozpasbiE9RjFDTB8YJ7qWuVFH
         ArtYzb9AADVQKVNGX/RmUctLfQ5JVDp6sNAboZFHPjxkj8Z8UZouV5rlwChgpz01+V4E
         dPo8/zAKKcw866A1w68Evb9EozmbspUTZfdZhJtMkTO2WGB7rklyJGSVZGsU8Q9U6flz
         rWmw==
X-Forwarded-Encrypted: i=1; AJvYcCV2jVAmav08b0zCrz/BsAIdzmaLffGPvrNSrZBUD76408tZEkEpMjjXgEuKvoQBaQacsuRG6Nz7/ec=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMvk+92rUQoAPtCS3G8tcrnTolvDpUl1/Mdk7FkVfpf2bj+6NB
	8mg+CbcrZDgKeE1qAecx5YuJJjbTbcR/xL2SWOWBcs3DnSa0W8niK7Fx2afwFQ==
X-Gm-Gg: ASbGnctdq9WwjIF8L0zVgDYAWBXBdDGNNy3k9f4bhKplfMzjSHBXPOGyAGW5oma2svy
	K4ERfkW9yfPPqfsHlj6c/p2bijQrfQ+5YBuei27ziNUzo9G9bYOdxf4PV0L7eRL4zykD3rqDL+j
	HldKE0jzkEAMU/ciB/84YREdO4PAkofNCuOU0+UgZLTRqGhM9uwhXSKjpgs1NlurtBFAwUXVATa
	TYCGCbiOBrXoqtKXK/s3qybxFTMPNhRg5ULjZqlBOmgjLveJZhFIwmomvJFMgTosNrzdRdd3vBb
	hJxkZYcees1sISZ+xRJBr6lr+t34l2JxPlCVhGCxbI91sLczfpGc78IlqJt4pGuvdVW4RI++mZv
	u81EViiSjubgax9JXoG9DHZ8o3+H6vrP7bsAhpQiwgzpkCMu2c9M/
X-Google-Smtp-Source: AGHT+IGWL1ei9PIDD8TDC51CGyly0xILPwGmdbo+11xbW/F19i3aU0zPMr0X7T0T3NyywfF50qx2wg==
X-Received: by 2002:a05:6512:2c04:b0:562:c06c:8c03 with SMTP id 2adb3069b0e04-5906d896d2dmr4569190e87.21.1760263231566;
        Sun, 12 Oct 2025 03:00:31 -0700 (PDT)
Received: from NB-6746.. ([94.25.228.43])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59088585860sm2823882e87.128.2025.10.12.03.00.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Oct 2025 03:00:31 -0700 (PDT)
From: Artem Shimko <a.shimko.dev@gmail.com>
To: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
	Vinod Koul <vkoul@kernel.org>
Cc: a.shimko.dev@gmail.com,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] dmaengine: dw-axi-dmac: simplify PM functions and use modern macros
Date: Sun, 12 Oct 2025 12:59:59 +0300
Message-ID: <20251012100002.2959213-2-a.shimko.dev@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251012100002.2959213-1-a.shimko.dev@gmail.com>
References: <20251012100002.2959213-1-a.shimko.dev@gmail.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Simplify the power management code by removing redundant wrapper functions
and using modern kernel PM macros. This reduces code duplication and
improves maintainability.

The changes convert the suspend/resume functions to take device pointer
directly instead of the chip structure, allowing removal of the runtime
PM wrapper functions. The manual PM ops definition is replaced with
DEFINE_RUNTIME_DEV_PM_OPS() macro and pm_ptr(). Probe and remove
functions are updated to call PM functions with device pointer.

Signed-off-by: Artem Shimko <a.shimko.dev@gmail.com>
---
 .../dma/dw-axi-dmac/dw-axi-dmac-platform.c    | 31 ++++++-------------
 1 file changed, 9 insertions(+), 22 deletions(-)

diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
index b23536645ff7..8b7cf3baf5d3 100644
--- a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
+++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
@@ -1314,8 +1314,10 @@ static int dma_chan_resume(struct dma_chan *dchan)
 	return 0;
 }
 
-static int axi_dma_suspend(struct axi_dma_chip *chip)
+static int axi_dma_suspend(struct device *dev)
 {
+	struct axi_dma_chip *chip = dev_get_drvdata(dev);
+
 	axi_dma_irq_disable(chip);
 	axi_dma_disable(chip);
 
@@ -1325,9 +1327,10 @@ static int axi_dma_suspend(struct axi_dma_chip *chip)
 	return 0;
 }
 
-static int axi_dma_resume(struct axi_dma_chip *chip)
+static int axi_dma_resume(struct device *dev)
 {
 	int ret;
+	struct axi_dma_chip *chip = dev_get_drvdata(dev);
 
 	ret = clk_prepare_enable(chip->cfgr_clk);
 	if (ret < 0)
@@ -1343,20 +1346,6 @@ static int axi_dma_resume(struct axi_dma_chip *chip)
 	return 0;
 }
 
-static int __maybe_unused axi_dma_runtime_suspend(struct device *dev)
-{
-	struct axi_dma_chip *chip = dev_get_drvdata(dev);
-
-	return axi_dma_suspend(chip);
-}
-
-static int __maybe_unused axi_dma_runtime_resume(struct device *dev)
-{
-	struct axi_dma_chip *chip = dev_get_drvdata(dev);
-
-	return axi_dma_resume(chip);
-}
-
 static struct dma_chan *dw_axi_dma_of_xlate(struct of_phandle_args *dma_spec,
 					    struct of_dma *ofdma)
 {
@@ -1590,7 +1579,7 @@ static int dw_probe(struct platform_device *pdev)
 	 * driver to work also without Runtime PM.
 	 */
 	pm_runtime_get_noresume(chip->dev);
-	ret = axi_dma_resume(chip);
+	ret = axi_dma_resume(chip->dev);
 	if (ret < 0)
 		goto err_pm_disable;
 
@@ -1638,7 +1627,7 @@ static void dw_remove(struct platform_device *pdev)
 	axi_dma_disable(chip);
 
 	pm_runtime_disable(chip->dev);
-	axi_dma_suspend(chip);
+	axi_dma_suspend(chip->dev);
 
 	for (i = 0; i < DMAC_MAX_CHANNELS; i++)
 		if (chip->irq[i] > 0)
@@ -1653,9 +1642,7 @@ static void dw_remove(struct platform_device *pdev)
 	}
 }
 
-static const struct dev_pm_ops dw_axi_dma_pm_ops = {
-	SET_RUNTIME_PM_OPS(axi_dma_runtime_suspend, axi_dma_runtime_resume, NULL)
-};
+static DEFINE_RUNTIME_DEV_PM_OPS(dw_axi_dma_pm_ops, axi_dma_suspend, axi_dma_resume, NULL);
 
 static const struct of_device_id dw_dma_of_id_table[] = {
 	{
@@ -1680,7 +1667,7 @@ static struct platform_driver dw_driver = {
 	.driver = {
 		.name	= KBUILD_MODNAME,
 		.of_match_table = dw_dma_of_id_table,
-		.pm = &dw_axi_dma_pm_ops,
+		.pm = pm_ptr(&dw_axi_dma_pm_ops),
 	},
 };
 module_platform_driver(dw_driver);
-- 
2.43.0


