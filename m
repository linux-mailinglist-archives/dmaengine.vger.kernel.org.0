Return-Path: <dmaengine+bounces-6202-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A8ACB35A1B
	for <lists+dmaengine@lfdr.de>; Tue, 26 Aug 2025 12:30:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BB963B2CDE
	for <lists+dmaengine@lfdr.de>; Tue, 26 Aug 2025 10:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30EB9303C91;
	Tue, 26 Aug 2025 10:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qe8s7COg"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6307C29C321;
	Tue, 26 Aug 2025 10:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756204225; cv=none; b=elA0l8FTJx+O76OiZ19EGCfd1UfivRbFWa2GodSnBYO8D/AfxxrZm/UFa3iXVE8o9ipoAelYM/PMhsgR0aeTpZyANUek02Mnpt9A9Qvt2sqhlP/FSOtsDkuFqzG9vR28j/V4qE0T64fLX8FmeuEGacL1mdcvTOsM855IzN/AIjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756204225; c=relaxed/simple;
	bh=J5D0c6C1ve2M499aj8JP84xqqBG9d8GhM26AKpp8RW0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ow2+qvUbl93hxeX1WmbzrawX79dk0BZ+rfIJrwBrxlslmMahAUFR981kj3+7pNLAOXBI944vOHbrdOaxwwbJouySLVTjQdYF6ZKQtpdYlnMlPgseFnwYhJCr5K1TgpyTYHeMaY7KevdjLs5fMBreRJuUTzTYXshLtjqGBK+RBF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qe8s7COg; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-afe9f6caf9eso134831866b.3;
        Tue, 26 Aug 2025 03:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756204221; x=1756809021; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uYtuItXnoGP8pupzVnCcRSCCoPPLDL2Fbyp8Wx0/Cqg=;
        b=Qe8s7COgn4J4DgmXT/zKKtjawgmsjDI48aIdxZcAbUA8I+Zv5QjFWKfo3751ngJnnB
         atqo8JuSNpf/IfMNIr613+taUwhIfjkAN4WXn3LTzBmhDsA99gl2PvkGAMV7ZtFH0w9T
         f61mpZOOF0CHFWDKYQdWtiA2NE6z643hzfExZuQuNEjuYL2tCzYtZ54B7hZV9JesN2jg
         zmZ1sHFi2eZGxAC4hzEbSzjRQGALEH6DgdYCw7yP6wCK3pnh/u+Q6PTYDNjTO2y1WeHI
         pU0XEM/UfuMiSxAqRVh+dwgLe/EbPcfXCwWAuf39rr5tr2y40eKZQOeEtE0DfJYRlchI
         SZIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756204221; x=1756809021;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uYtuItXnoGP8pupzVnCcRSCCoPPLDL2Fbyp8Wx0/Cqg=;
        b=UisBfu9t814qMKywi2y6zWMMUJvGmS+PQzPcle995oS9xkEo/Tf4OOuLRc+LHH3olG
         XHyY4qOv9oOi2sB5KbU4r7DZa1hoZB8pNAhurgGlmHNYdAUQEBLGoNH1l5cPDeoxcnup
         J/M4aG2aqYFbxnNgjLRe4VVic4wr+bvTIzLLJPm47u9/2B15unBVFXrb63gwveLjoAUl
         M1pvW2P8r4P8lcxl3EQJEyalfX3bcr3VHIPSYyEsrbc52INvH8MIflsexeH4qd0CTzdz
         Rhz8ViBHxPlKDUQFPZFsMD8F2mqynYn67xkNoCEmMDaldHed7vHuCuN4Jh3lwDiwbhxM
         L5GA==
X-Forwarded-Encrypted: i=1; AJvYcCUDOH3V1mYapdgpT7vPRh4szDnXuxhZ3H6CXGZZwBgwF1jim8gUtHCCmJhpQfDx4tKGCOz3oscElt7GJ1s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbJPRQUVqqR/p34CYx3BLx7PNu3nGt8imYRxtQXxY8jcwWaOio
	208KwAl5ybRG/NmFfT9RkFF8f0btetMAkvvGp8nIJLBV+oQhLYYmqGTk3UwhEw==
X-Gm-Gg: ASbGncte7Pi8St3AYOU77M5YKKhWlsc6gw5KlNHwFwZNQ9FP96TpM2brRIfNh2yVV/5
	FbumdHezqDkFCeYKYmETc37FxfU9I/DPXg/FHbnknPqTXSdJdna/ZoApLgRPNbjGA9FNxfw4t0H
	AfrVeMha2FaoslXevMtbCiacuEYkzOOHZkf/m2Am9OYhve/OZNCyKJGkRohTM4h/PqHRUS6Ceg5
	UxelUBNBU2sbrDjOlpROgukbcQ4Kaf8cLZUPePW98ST7sRE/+tJo+1Yuu2rGm24VdVlcfCgLSwS
	MnZeNs2WIb89QRSAb57YhOHw8T/4s0YZdHkj32mMBcJSRELBqRTUMNDULlQtGfgz+NqoQCIhU/h
	JmzuOtmFRO5WyDNA=
X-Google-Smtp-Source: AGHT+IFi1fUGWXXrzQXgdvKlPV4b/k4v9f0nExJgxLzlllLxkCrL9Lm8RLhyS5/kurH3sZNgiawCcA==
X-Received: by 2002:a17:907:980e:b0:afc:cbf4:ca7d with SMTP id a640c23a62f3a-afe296e4c0amr1560727166b.54.1756204221350;
        Tue, 26 Aug 2025 03:30:21 -0700 (PDT)
Received: from NB-6746.. ([88.201.206.17])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afe4936a335sm766732666b.114.2025.08.26.03.30.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 03:30:21 -0700 (PDT)
From: Artem Shimko <artyom.shimko@gmail.com>
X-Google-Original-From: Artem Shimko <a.shimko@yadro.com>
To: dmaengine@vger.kernel.org
Cc: Artem Shimko <artyom.shimko@gmail.com>,
	linux-kernel@vger.kernel.org,
	vkoul@kernel.org,
	eugeniy.paltsev@synopsys.com
Subject: [PATCH 1/1] drivers: dma: change pm registration for dw-axi-dmac-platform's suspend
Date: Tue, 26 Aug 2025 13:30:15 +0300
Message-ID: <20250826103017.1891990-2-a.shimko@yadro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250826103017.1891990-1-a.shimko@yadro.com>
References: <y>
 <20250826103017.1891990-1-a.shimko@yadro.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Artem Shimko <artyom.shimko@gmail.com>

Replaced the deprecated SET_RUNTIME_PM_OPS macro with the
DEFINE_RUNTIME_DEV_PM_OPS macro for defining device power
management operations.

The DEFINE_RUNTIME_DEV_PM_OPS macro provides the same functionality
to support system suspend mode.

Signed-off-by: Artem Shimko <artyom.shimko@gmail.com>
---
 .../dma/dw-axi-dmac/dw-axi-dmac-platform.c    | 31 ++++++-------------
 1 file changed, 9 insertions(+), 22 deletions(-)

diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
index c8eaa9c14c03..eeba28a1d2c8 100644
--- a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
+++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
@@ -1400,8 +1400,10 @@ static int dma_chan_resume(struct dma_chan *dchan)
 	return 0;
 }
 
-static int axi_dma_suspend(struct axi_dma_chip *chip)
+static int __maybe_unused axi_dma_suspend(struct device *dev)
 {
+	struct axi_dma_chip *chip = dev_get_drvdata(dev);
+
 	axi_dma_irq_disable(chip);
 	axi_dma_disable(chip);
 
@@ -1411,9 +1413,10 @@ static int axi_dma_suspend(struct axi_dma_chip *chip)
 	return 0;
 }
 
-static int axi_dma_resume(struct axi_dma_chip *chip)
+static int __maybe_unused axi_dma_resume(struct device *dev)
 {
 	int ret;
+	struct axi_dma_chip *chip = dev_get_drvdata(dev);
 
 	ret = clk_prepare_enable(chip->cfgr_clk);
 	if (ret < 0)
@@ -1429,20 +1432,6 @@ static int axi_dma_resume(struct axi_dma_chip *chip)
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
@@ -1676,7 +1665,7 @@ static int dw_probe(struct platform_device *pdev)
 	 * driver to work also without Runtime PM.
 	 */
 	pm_runtime_get_noresume(chip->dev);
-	ret = axi_dma_resume(chip);
+	ret = axi_dma_resume(chip->dev);
 	if (ret < 0)
 		goto err_pm_disable;
 
@@ -1724,7 +1713,7 @@ static void dw_remove(struct platform_device *pdev)
 	axi_dma_disable(chip);
 
 	pm_runtime_disable(chip->dev);
-	axi_dma_suspend(chip);
+	axi_dma_suspend(chip->dev);
 
 	for (i = 0; i < DMAC_MAX_CHANNELS; i++)
 		if (chip->irq[i] > 0)
@@ -1739,9 +1728,7 @@ static void dw_remove(struct platform_device *pdev)
 	}
 }
 
-static const struct dev_pm_ops dw_axi_dma_pm_ops = {
-	SET_RUNTIME_PM_OPS(axi_dma_runtime_suspend, axi_dma_runtime_resume, NULL)
-};
+static DEFINE_RUNTIME_DEV_PM_OPS(dw_axi_dma_pm_ops, axi_dma_suspend, axi_dma_resume, NULL);
 
 static const struct of_device_id dw_dma_of_id_table[] = {
 	{
@@ -1766,7 +1753,7 @@ static struct platform_driver dw_driver = {
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


