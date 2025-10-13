Return-Path: <dmaengine+bounces-6819-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9136BBD42A0
	for <lists+dmaengine@lfdr.de>; Mon, 13 Oct 2025 17:27:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31E4C4069E8
	for <lists+dmaengine@lfdr.de>; Mon, 13 Oct 2025 15:18:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EAB130BF6E;
	Mon, 13 Oct 2025 15:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KIzWI5jm"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 391A030E84E
	for <dmaengine@vger.kernel.org>; Mon, 13 Oct 2025 15:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760367802; cv=none; b=mQq5zAiMejDIWh3awlIZywXYxz1oiOXX0CyXjBoHbpVKSrqPCqxNAE0MT/Z9rqP7Mg+nASDJYrKkb3dm10t5nPuxe2U2QwfMvLLBseD2LsDAnAmkz9sCBZZ2Jf+txOLPeP3kgyalJ76P6O9FP0UcH7akU25PScMdaXt0cczlhU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760367802; c=relaxed/simple;
	bh=OzK0aYW2LWITX9fdd4z7rDbgFG5oDHlyFtFytqntWLc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I6T9m8wC8rt+2nNaQCKNNgUmn+BMLiu+Sz3ZAJs6VfCgs+Wzj8zEHjDip/LvX3uiLku9XIfRvybU7eVGMOW2if5gwDXWeoUzZAdiXZ0Hkm57ozmx6IM9jinqJY5q/F98dcgLEGpiGU+UgkiJZpIvCVp5J/jlqMxDWYLZhCroWl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KIzWI5jm; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b48d8deaef9so775057666b.2
        for <dmaengine@vger.kernel.org>; Mon, 13 Oct 2025 08:03:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760367799; x=1760972599; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KXSMFjXcnbUgtoA/eC/AHIzf0ylAZ7zJ33rVYw0AFyk=;
        b=KIzWI5jm6d4NAvRN8ov3Ehp4l4UiXqcDbDLv2khd3EUnlROlFkt4TwzK4YQTATCR8e
         mbUE+3ZWCaNJzpIzrLa1z7PxOa5pP8nB4aB6hZlI1lwkPPUacT/9ZvrFRgpXLkgK9iCJ
         Dg4U1gCCEZzN/+1vJw9j7RPGhFDEB8PZJjEh6AINhrKQkyXbKdtazB0KJRkhOYuTv9sR
         undva1bYu/OsFpKDVH+xLWqSngEh9moGFb+uYpkSI94dG312eg/V235PkHp4LGqliBAk
         7bvByDhzaEIbI/zmFQVGMU4Vow35SFxdMoTd0rvjNlogFwAzlJftSAVO/oc1Fydcn8/1
         uWpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760367799; x=1760972599;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KXSMFjXcnbUgtoA/eC/AHIzf0ylAZ7zJ33rVYw0AFyk=;
        b=QvyPiKX8gmOGsdE93X+Zuv6VT84gOS61x+DMzaMuREm7/a2Rmg8/6falzCAyjeRtHt
         M1zOxA+CSasgDCo8nd2937W0mjVsQbSHkft5OYthoh1y2aOxw5zMvLVIRPki8YlwsoWT
         xVJZRdvkSprd/2EOI+U6xY/JHEosOOnBQbdesmiXi+FcBpshM7ES52gDwJz2TWCbCE0H
         jrNHmVsj/BWvulkhd2hetvHDFOTyxyrjYMVVfz6jzn8LagJcrlH9jff4KXqnM3pBqukF
         W6sxp2rZFI3dhyiDSTzclsuAs+LemwPW2nx+vEE4oRsixbjIaC0/ykIAU6VFgyAmldjw
         K+iw==
X-Forwarded-Encrypted: i=1; AJvYcCX84lSO7508G1S4mEh26RCX7Ik5zZpLy00RYaobu0NWcw347xD/iCQaRhq8YddvucRCbuWLSsli5X0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKw7vohceCMUdyyVpdjiRt1o1xriSCAK4MnBESNcvpFqv7juJR
	XPO7zAl+XX9tcfNOzG5OWQHSSlEX61w6Grim6qOa7K6GSj2GK7UV6ucPl83oxA==
X-Gm-Gg: ASbGncvE2eZh/2zejndZmWyJwSW79fd8w2IrhOPeBMJXtaMG5c/3mWpMXWbt4/S61el
	cy4NEtOMLu7pIY2Yw4BSjDP1651ZlPJ2b/bdrrFYQ9Kzqgj4tsyI0S8GESRKKsUK3fAeO5dLIPj
	h3yY+uu6afPVWuenQCpQtH8BRI0Vbzwy+sK+zMrNIunxd8wvlXxwEDxEalqNGPrOBMk60Q0zaX+
	B89PoXHRaQDJ8L5dH0iQs3f3SsYaY+UyI90fm6ea7MTzLEKvz4L6tIEKkmCkeo5ZP2Wy6dagjrT
	EVWvpwDm2/cGnpCj5/EiyDApfXVedN6TSTXAZD+oifEXsW+QKNgGfDxG952QNvuEQAt7nej2+Or
	SLTfZSmH4A5g4PUfcRqWYAXi4SYMuy6b985M7Eebm09eDkQCUPoPujBu0Qh5htovPTQBDY92OlA
	==
X-Google-Smtp-Source: AGHT+IGXCqTReJ94d66EEB+8s5ZF34ZclwL1Q/rIdYVO7a5YUFeWWK/uxTC9yxu7YownwJ8zZfnCzQ==
X-Received: by 2002:a17:907:da2:b0:b2c:fa41:c1be with SMTP id a640c23a62f3a-b50acd299ffmr2305092066b.61.1760367799090;
        Mon, 13 Oct 2025 08:03:19 -0700 (PDT)
Received: from NB-6746.corp.yadro.com ([188.243.183.84])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b55d8c129c4sm957903866b.41.2025.10.13.08.03.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 08:03:18 -0700 (PDT)
From: Artem Shimko <a.shimko.dev@gmail.com>
To: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
	Vinod Koul <vkoul@kernel.org>
Cc: p.zabel@pengutronix.de,
	Artem Shimko <a.shimko.dev@gmail.com>,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] dmaengine: dw-axi-dmac: simplify PM functions and use modern macros
Date: Mon, 13 Oct 2025 18:02:32 +0300
Message-ID: <20251013150234.3200627-2-a.shimko.dev@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251013150234.3200627-1-a.shimko.dev@gmail.com>
References: <20251013150234.3200627-1-a.shimko.dev@gmail.com>
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
DEFINE_RUNTIME_DEV_PM_OPS() macro and pm_ptr() is used for the platform
driver. Probe and remove functions are updated to call PM functions with
device pointer.

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


