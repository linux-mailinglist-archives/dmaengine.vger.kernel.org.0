Return-Path: <dmaengine+bounces-6801-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 348E5BD00E8
	for <lists+dmaengine@lfdr.de>; Sun, 12 Oct 2025 12:01:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 764424E407D
	for <lists+dmaengine@lfdr.de>; Sun, 12 Oct 2025 10:00:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A900125C80D;
	Sun, 12 Oct 2025 10:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B522r6L2"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A35FB25F7A5
	for <dmaengine@vger.kernel.org>; Sun, 12 Oct 2025 10:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760263253; cv=none; b=PAuV7KxM6XbwXttJyRzdH+PLI4CXKS7haQdEnwHJf87ORJIrMTy7cvEWJbBM4kRYLYepPzi5jRBmXTw+ZE55S/i7eTdk6Tjv078eEvbed3mTZtJoTIGVq5+QFwH1/almftF4Vu9lrx+GfNVwc5FI7X7d+BTvjQ74pbqMl4HD3Qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760263253; c=relaxed/simple;
	bh=NpLOcZjJLcpiLDNkxx1t2kSCTYhfiFQWIPqEvtzTMpw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kYkHwkjFQZl/G1htZ4d7a3/NTsgeM1l+kK+7NrMlSobE3C/8AoxG7fy7bh6ldqoN1JTbE7nckWZWdRXYOFQHrFLGSvqk/GCGjOEUGnQ7iwgi7YlJCyRSO62U7fUdCvFqh/fpI3jh0NzmAQ8Rh0xgFv+mFUDSTm6Vr3tCJbBdsWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B522r6L2; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5797c8612b4so4226517e87.2
        for <dmaengine@vger.kernel.org>; Sun, 12 Oct 2025 03:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760263250; x=1760868050; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gt/08zDoZHi6QCv0lr9Mfxvpxfaye7PST9WTNSBZ4AE=;
        b=B522r6L2LgCb6MFlEjprPs/ip9ruvdWMKvkHpCQe0kiIguLShmG7ScDFyUrSZEwbhz
         qODd43sSMiXHC7/itg4HzOKeLcw4H/CQv4Eyq6l2lEeByZKGTKY3Ze2hcfkeTuKBRJMU
         +i2RzMTx9iwV/ZJpUd9y70F+yfwYPSG5/kdXZM0rDh1jg2vgT90DIoqe48SH+NWvaUrP
         PsQfVy1heI0eOCCmY3b94zEthN+VGvanlFDNuVOzdLpm1A0NR5+Vau7xQQ12x/55v5o8
         HKNnwtJsrWpKCd6RHZm0NTCsFbxJscTNLeeDUzwQjTFWsdA1BpLCNQpTluZDknUPzKiI
         tIWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760263250; x=1760868050;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gt/08zDoZHi6QCv0lr9Mfxvpxfaye7PST9WTNSBZ4AE=;
        b=tFW2m1V0GQixUJnCX+9ostjxDJfXrfkWNo2JLrfeTDO4YVMB4g4nYrUw9SoSSs5Wmp
         fyymjMVpuYx9u//qDcuAkVoSlrqo3ae4yzPxr9OBwL6tY1em9bVycbQhTYqbVKFXTggG
         +vHYyBmNdQ13j6of6cDJ0/fjJ+OTmSpfwP4yQA7BojbkSAc+K1RzICnlYoaevnUHBsi7
         QnmVKCuqgOvWLGUd1Ys63FhkTTKZhfXCne8dt5owkDxIfDXBOb9d+z/DXp4CEQZdui+K
         Fucll6YID/TRXJakCnWq6Tf1cZOW7hRAVT8FB9kk+UWmsYOooXnqSWqppQV/z9H/VY9W
         mCvg==
X-Forwarded-Encrypted: i=1; AJvYcCUj5ZMW7oL4V0/auAiSKDC1b47Pg1Z42Vp31Q5SsjDLTeP1eVVaQeWv+rVCa66rprsqD6FKQIQvtPU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKEoKUmSjlbwXbSIzQC5jxljqcKvUWPglw7GFFkHbJqQW6IEHm
	ELIL+L9k+2eC5k7lYo/jHaAXvCgPRNGI54S9Nu8y1eunw34gH2rsydEy
X-Gm-Gg: ASbGncuyYBGiY7YzcRx/yYxGfX0WUTkBBThvuU2SoCQLaw7qdafh/eNd6ssk9qpIIrd
	ZDWiiIHRuF/VaR+8iONvp51WKOgDVHEI8+ldEsAOoaVM8HMPsZJEMBJ6bHUEV/fjsJXVoUNfY9W
	kVJXZ2xN0NO1Arrd+luOPj6AJqgJDhyYUXT8me/dOlmBITljTnLpGwav6YyRn78hdiZj3YPJml6
	bNAXMruEHaJXaulq8mIY+HCL20XZhYFTRSr7raFCF2lxyOeMloT9gYFlJ0X85hyg0WEaWmnPIre
	jwd26RWdi859fDa5E6p97IbvTsPMpJcz2qv8Z3F0j+4cyXCh8C1D89s6apn0Drxb2a8f8JjPver
	RIkV+ZiBnTQYXC6X3nIWg5GL3ceUSiPwHNXVMk0V7kw==
X-Google-Smtp-Source: AGHT+IEvjh++oNk5D6Hd/JRHER8RRDiSIgrbmvMDu6YMHrVhPmjga47WRCExnEXlmGwt+/hye4sK+g==
X-Received: by 2002:a05:6512:68f:b0:55f:6fb4:e084 with SMTP id 2adb3069b0e04-5906db047d7mr4801424e87.50.1760263249647;
        Sun, 12 Oct 2025 03:00:49 -0700 (PDT)
Received: from NB-6746.. ([94.25.228.43])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59088585860sm2823882e87.128.2025.10.12.03.00.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Oct 2025 03:00:49 -0700 (PDT)
From: Artem Shimko <a.shimko.dev@gmail.com>
To: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
	Vinod Koul <vkoul@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>
Cc: a.shimko.dev@gmail.com,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] dmaengine: dw-axi-dmac: add reset control support
Date: Sun, 12 Oct 2025 13:00:00 +0300
Message-ID: <20251012100002.2959213-3-a.shimko.dev@gmail.com>
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

Add proper reset control handling to the AXI DMA driver to ensure
reliable initialization and power management. The driver now manages
resets during probe, remove, and system suspend/resume operations.

The implementation stores reset control in the chip structure and adds
reset assert/deassert calls at the appropriate points: resets are
deasserted during probe after clock acquisition, asserted during remove
and error cleanup, and properly managed during suspend/resume cycles.
Additionally, proper error handling is implemented for reset control
operations to ensure robust behavior.

This ensures the controller is properly reset during power transitions
and prevents potential issues with incomplete initialization.

Signed-off-by: Artem Shimko <a.shimko.dev@gmail.com>
---
 .../dma/dw-axi-dmac/dw-axi-dmac-platform.c    | 41 ++++++++++++-------
 drivers/dma/dw-axi-dmac/dw-axi-dmac.h         |  2 +
 2 files changed, 28 insertions(+), 15 deletions(-)

diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
index 8b7cf3baf5d3..3f4dd2178498 100644
--- a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
+++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
@@ -1321,6 +1321,9 @@ static int axi_dma_suspend(struct device *dev)
 	axi_dma_irq_disable(chip);
 	axi_dma_disable(chip);
 
+	if (chip->has_resets)
+		reset_control_assert(chip->resets);
+
 	clk_disable_unprepare(chip->core_clk);
 	clk_disable_unprepare(chip->cfgr_clk);
 
@@ -1340,6 +1343,9 @@ static int axi_dma_resume(struct device *dev)
 	if (ret < 0)
 		return ret;
 
+	if (chip->has_resets)
+		reset_control_deassert(chip->resets);
+
 	axi_dma_enable(chip);
 	axi_dma_irq_enable(chip);
 
@@ -1455,7 +1461,6 @@ static int dw_probe(struct platform_device *pdev)
 	struct axi_dma_chip *chip;
 	struct dw_axi_dma *dw;
 	struct dw_axi_dma_hcfg *hdata;
-	struct reset_control *resets;
 	unsigned int flags;
 	u32 i;
 	int ret;
@@ -1487,16 +1492,6 @@ static int dw_probe(struct platform_device *pdev)
 			return PTR_ERR(chip->apb_regs);
 	}
 
-	if (flags & AXI_DMA_FLAG_HAS_RESETS) {
-		resets = devm_reset_control_array_get_exclusive(&pdev->dev);
-		if (IS_ERR(resets))
-			return PTR_ERR(resets);
-
-		ret = reset_control_deassert(resets);
-		if (ret)
-			return ret;
-	}
-
 	chip->dw->hdata->use_cfg2 = !!(flags & AXI_DMA_FLAG_USE_CFG2);
 
 	chip->core_clk = devm_clk_get(chip->dev, "core-clk");
@@ -1507,18 +1502,31 @@ static int dw_probe(struct platform_device *pdev)
 	if (IS_ERR(chip->cfgr_clk))
 		return PTR_ERR(chip->cfgr_clk);
 
+	chip->has_resets = !!(flags & AXI_DMA_FLAG_HAS_RESETS);
+	if (chip->has_resets) {
+		chip->resets = devm_reset_control_array_get_exclusive(&pdev->dev);
+		if (IS_ERR(chip->resets))
+			return PTR_ERR(chip->resets);
+
+		ret = reset_control_deassert(chip->resets);
+		if (ret)
+			return dev_err_probe(&pdev->dev, ret, "Failed to deassert resets\n");
+	}
+
 	ret = parse_device_properties(chip);
 	if (ret)
-		return ret;
+		goto err_exit;
 
 	dw->chan = devm_kcalloc(chip->dev, hdata->nr_channels,
 				sizeof(*dw->chan), GFP_KERNEL);
-	if (!dw->chan)
-		return -ENOMEM;
+	if (!dw->chan) {
+		ret = -ENOMEM;
+		goto err_exit;
+	}
 
 	ret = axi_req_irqs(pdev, chip);
 	if (ret)
-		return ret;
+		goto err_exit;
 
 	INIT_LIST_HEAD(&dw->dma.channels);
 	for (i = 0; i < hdata->nr_channels; i++) {
@@ -1605,6 +1613,9 @@ static int dw_probe(struct platform_device *pdev)
 
 err_pm_disable:
 	pm_runtime_disable(chip->dev);
+err_exit:
+	if (chip->has_resets)
+		reset_control_assert(chip->resets);
 
 	return ret;
 }
diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac.h b/drivers/dma/dw-axi-dmac/dw-axi-dmac.h
index b842e6a8d90d..56dc3d75fe92 100644
--- a/drivers/dma/dw-axi-dmac/dw-axi-dmac.h
+++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac.h
@@ -71,6 +71,8 @@ struct axi_dma_chip {
 	struct clk		*core_clk;
 	struct clk		*cfgr_clk;
 	struct dw_axi_dma	*dw;
+	struct reset_control	*resets;
+	bool			has_resets;
 };
 
 /* LLI == Linked List Item */
-- 
2.43.0


