Return-Path: <dmaengine+bounces-6820-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74DBDBD4796
	for <lists+dmaengine@lfdr.de>; Mon, 13 Oct 2025 17:46:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2D993E7381
	for <lists+dmaengine@lfdr.de>; Mon, 13 Oct 2025 15:19:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16CE830EF85;
	Mon, 13 Oct 2025 15:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZpQ02ceP"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D69B30EF77
	for <dmaengine@vger.kernel.org>; Mon, 13 Oct 2025 15:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760367813; cv=none; b=mHqG1JzncIQEvwfZRd8/SAJaHMNMbAneNqvFzUsZknORHfDlinIXryLCHiRNlN1gCvApTFzkJVOTlxcv3v2aANW2M2o3yVD7A04eNJVJ/yiFffH5iSWJgHlSed+noziSTXXNCDc5lpn3orgFV8MGiY8fG29SiNkNg2FYy2mWCZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760367813; c=relaxed/simple;
	bh=lyPLERlw8vWrCfdgV/iodmJO/gUP26Jw77ReDaknTuM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E5iLx/N3IACOkaUCgUcXr0LHroMVn3GXgqqDahZTAWoSSvURCIggDRCTEzHLyB6vN/6bucc9+9r3BRgnVKm3yRqFeiZKVNmae23hZDw3oxSjV7UjgVB0eJIKVpkM+Fgr9o3jfDA96mQYGXT6GoA7vSy9xKE8ADx9MtzpHELI8QY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZpQ02ceP; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-61feb87fe26so6842989a12.1
        for <dmaengine@vger.kernel.org>; Mon, 13 Oct 2025 08:03:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760367809; x=1760972609; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J9V/zYY62mF3Jc1sYvz1gRNG552w5eZEPTjzgxmkZz0=;
        b=ZpQ02cePZ6iDwEKZeyjTFJWekuc8SNL1VYAiNRwCHwwo3JHqxZFb/hYeYu8FWYHR9O
         eXkrlZThhl4QsjSdeCiPM+229TWRF1tn/pGCTT+SoA9pLVRNJelHOez9pgZbkR20qZ3v
         EcApYhI+Za25qGNm9R1EEvnTP8gDUdgLDDEtTqZYTLzWXVC1ncMSkq4etO4V3cZy/hTY
         i1OIJLQXY8pFq3lNecAox8D45ItSXQs/SORr11PrOcm5lnXHYpRcUWKj553Dc13CnNws
         titzqyDYj645gtAPql9cJBvj6YCMSiDj7njXYWVGulAzoLmFOCq4RZTWTr9tpzYiVhF/
         2ABQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760367809; x=1760972609;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J9V/zYY62mF3Jc1sYvz1gRNG552w5eZEPTjzgxmkZz0=;
        b=lfyjYIyhkc3eFvy1fmCeiKU91RZ+niqTiqFELcGdQ+iQwA1VdZEwRKaerQ/dEe9kQa
         tHnHrc7BKOWhlFOci3k57IkwMQ3Z5vu/j/03Lp7KtIjnfzpvBRqPCzsFAt4FKvOTqlH1
         YBa2fEZkalChFNZYvSwOpNhywLKIKYOVwzDXtccMRn3jYFiM4Qv3D8AE3L0M6SzV++Dw
         2FI96eDbQUQX+OIFltwsfFM/PWedpRXul2ZiHdxadQi/739m8Fwqou5sBf6GlK/2fxb8
         hMrSJjLWxvbjWXTp1bTN5VdYX7E7DbhS2b20ifXCWjsNq0Yx31ZBpU58tC3dmxKIZgjz
         J0mw==
X-Forwarded-Encrypted: i=1; AJvYcCVi8EvS8GKR3XNSh3qAIRX6l1YkDfa2qKdPW8LnC6celMCt0SGtf2V0UR3aM/LQFSyBFOnv4ZhMeTM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyqn8NUGMnCBUVENrubEFahbC92xxBCgvaEB2IBN7x/Ns6hcFV0
	OXOQx9PXPZec7HBrnWe+AVb5D4Gq77ngX4iCQvtr/NM3ev4e+pib6T7J
X-Gm-Gg: ASbGnctj6bJyKFqo0y+j3BJMc7B/8qcm78KvYv224DG3VbUQIS5zAeSFzNTYqEhVnIc
	OJWWCcwOIeLVq8hPXCtEuKhuaX8zgNH1oFGPevEJ7wMYHxe9gXWv6qaQwJM6VVjw4A3MJ+cuhAC
	ZctWwGHZNslJWSI9EPzsIircp6+5TCWiU9Dc5Eb81iV+cxEHsAUD2l2T3tMMk8Qb6cFSOKqW1Kp
	6yKs5KQRkRN0inj0uvqTNKJReSlML20Ga5sxLgYjsnYvjLO8kVeUlsVH5B1AQI/AAPQPjfxcA6u
	YVLPmxlV5hcnRY5ytukkGm4JEFdtL/k8j3ScsAjiF35GZVZ+Mx5SdetAmQ+dNNQjwmqnyaSEo4F
	Ylh45XAlPBeavnd91UQUAPJPL9D7+/Ou2/u943nULQOAXuufYFG0rhKD5m6dP/Wjy0vv8JF3T9y
	xPkGF182ES
X-Google-Smtp-Source: AGHT+IGPUxbjx1UJw3F56nxVVbUiRufE1LBjyJOtx0bj65ahQeDXudyFNDV/YxETMB9LOQKCQqoQxw==
X-Received: by 2002:a17:907:72d3:b0:b42:9840:eac1 with SMTP id a640c23a62f3a-b50ac7e7a29mr2205488866b.49.1760367809042;
        Mon, 13 Oct 2025 08:03:29 -0700 (PDT)
Received: from NB-6746.corp.yadro.com ([188.243.183.84])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b55d8c129c4sm957903866b.41.2025.10.13.08.03.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 08:03:28 -0700 (PDT)
From: Artem Shimko <a.shimko.dev@gmail.com>
To: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
	Vinod Koul <vkoul@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>
Cc: Artem Shimko <a.shimko.dev@gmail.com>,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] dmaengine: dw-axi-dmac: add reset control support
Date: Mon, 13 Oct 2025 18:02:33 +0300
Message-ID: <20251013150234.3200627-3-a.shimko.dev@gmail.com>
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
 .../dma/dw-axi-dmac/dw-axi-dmac-platform.c    | 35 +++++++++++--------
 drivers/dma/dw-axi-dmac/dw-axi-dmac.h         |  1 +
 2 files changed, 21 insertions(+), 15 deletions(-)

diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
index 8b7cf3baf5d3..8d9cecfc9a99 100644
--- a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
+++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
@@ -1321,6 +1321,8 @@ static int axi_dma_suspend(struct device *dev)
 	axi_dma_irq_disable(chip);
 	axi_dma_disable(chip);
 
+	reset_control_assert(chip->resets);
+
 	clk_disable_unprepare(chip->core_clk);
 	clk_disable_unprepare(chip->cfgr_clk);
 
@@ -1340,6 +1342,8 @@ static int axi_dma_resume(struct device *dev)
 	if (ret < 0)
 		return ret;
 
+	reset_control_deassert(chip->resets);
+
 	axi_dma_enable(chip);
 	axi_dma_irq_enable(chip);
 
@@ -1455,7 +1459,6 @@ static int dw_probe(struct platform_device *pdev)
 	struct axi_dma_chip *chip;
 	struct dw_axi_dma *dw;
 	struct dw_axi_dma_hcfg *hdata;
-	struct reset_control *resets;
 	unsigned int flags;
 	u32 i;
 	int ret;
@@ -1487,16 +1490,6 @@ static int dw_probe(struct platform_device *pdev)
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
@@ -1507,18 +1500,28 @@ static int dw_probe(struct platform_device *pdev)
 	if (IS_ERR(chip->cfgr_clk))
 		return PTR_ERR(chip->cfgr_clk);
 
+	chip->resets = devm_reset_control_array_get_optional_exclusive(&pdev->dev);
+	if (IS_ERR(chip->resets))
+		return PTR_ERR(chip->resets);
+
+	ret = reset_control_deassert(chip->resets);
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret, "Failed to deassert resets\n");
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
@@ -1605,6 +1608,8 @@ static int dw_probe(struct platform_device *pdev)
 
 err_pm_disable:
 	pm_runtime_disable(chip->dev);
+err_exit:
+	reset_control_assert(chip->resets);
 
 	return ret;
 }
diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac.h b/drivers/dma/dw-axi-dmac/dw-axi-dmac.h
index b842e6a8d90d..c74affb9f344 100644
--- a/drivers/dma/dw-axi-dmac/dw-axi-dmac.h
+++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac.h
@@ -71,6 +71,7 @@ struct axi_dma_chip {
 	struct clk		*core_clk;
 	struct clk		*cfgr_clk;
 	struct dw_axi_dma	*dw;
+	struct reset_control	*resets;
 };
 
 /* LLI == Linked List Item */
-- 
2.43.0


