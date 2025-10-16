Return-Path: <dmaengine+bounces-6873-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E732BE453D
	for <lists+dmaengine@lfdr.de>; Thu, 16 Oct 2025 17:47:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 251033A7293
	for <lists+dmaengine@lfdr.de>; Thu, 16 Oct 2025 15:46:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15019350D46;
	Thu, 16 Oct 2025 15:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fE11jwQ6"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21E2534F481
	for <dmaengine@vger.kernel.org>; Thu, 16 Oct 2025 15:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760629599; cv=none; b=g+dRDipiMvDphfGbsBhTl/DAas3LfVFG8RrIwzA5yELsNGo7BIwbh6RQpdDfXnhJilIM2r4ZFYJtoCDvRGY+/PiGvftiltTbQpcZCRQn3KPizx4s5gz8Bh+7JU79xSGsSJfHeWaNwdrClj9hhM4S/pN/dSNSgzbIf70B09Ijr0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760629599; c=relaxed/simple;
	bh=kUCeFgHQMCRWh0vi3n2eXqVII7Jhb7VzNj8JhwyAw1E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DELpX/9Dvd23qTB1AF7Ya4t81ugrqnPMKHJ9hNieHe8dOa9CCbV1ighpU/GO2nHbGkheoVinCGBnTXlLoo3MrzYgRUPYCxNvj8kF1LOKKS9PMKnZOxQ4ZwQR5cR2y6/FQzuamTJibJrbfDS69euLqb11DvDQAmp5Q/dRxM9xC3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fE11jwQ6; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-63c0eb94ac3so1266508a12.2
        for <dmaengine@vger.kernel.org>; Thu, 16 Oct 2025 08:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760629595; x=1761234395; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eTOdQ6EvuzATlkoQOWo/SqmOTJM5gobylAZ7Hzz1+yw=;
        b=fE11jwQ6TDyFYms1RVcFZdjvxB0vpm5q6nUsUK+EhQZdk5SnAGt1LPp6fRn3T022L0
         ZmGlm+sjUIXKNFoAXdIrxMyYdvLVop6HKZR+NDZZckVzcD0sfYOSqeqgLMKa7LP9TqVq
         z/soEQFvBEeRdzLg0/hM0hGrx+2IeuIiaPpmICN2o9KrVmZZlGhxsBHakaY7VUzgFnUS
         CQaj/rmTjOj5u8Ymh4SqvtIvLeERe1Ftj3+8URXWEfLmT/s0ijBjHouYwmkoV7nZ53TT
         mpI2QdywaHyNiJqdYQEXDJA15j0rsab12Uc1XXI9JZB/+TIFz14IT6kFHLRCw4cm/JYr
         BCIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760629595; x=1761234395;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eTOdQ6EvuzATlkoQOWo/SqmOTJM5gobylAZ7Hzz1+yw=;
        b=KO0umrGCbitFMfnoUT46dQkJlyRzCri2cYnSlK/RqQCa+GsgLwAbW2FxbxS1Ou8lAy
         hvmF9Bj/a/RcEi928JbRWkmNJlN+cATX6G83sLDmIq/TqoV7IE2qo4k6P7x5xpdz+Gdj
         jt9wYkGRrpEM10N2kMalPmyCx6TWrqXZD5xa78a4MPTiVCS3DNbakDBXyeHZckozNoyK
         k8LBiMTfUV92ipcBMCBfjaMqzMDugoWnmH7kK6N3OU/l4nyLNNIeakhEofKQb6V410+q
         1XffKKwcjFRo2ofaKkfsEkY1A03BZ5zF8cuVq4qnhP/v5gwxmUDoHMmaneFvGxu18Iml
         G90w==
X-Forwarded-Encrypted: i=1; AJvYcCWsJH7IzIXYwCK2ecOVg5Ng1Q1xcJrmc2KC0n2cufMiet9S8xOp6wid0IZrnmnaDRWLZ96sLm3VdNg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yykd8a/S9qeYxBGh0Taws3r9LuUgIEUCiLWgKkkGuVPiU5xadMc
	YBQqKmvCsfzVQXubrKM9REpAtiqLJHNzYdIjIQfzPM9vqxtKDnu/fzNY
X-Gm-Gg: ASbGncv4WF7CO0kayCT/vJFtyh8FziFdKP9khLpo8IOM3U/Y4pwOcLVyIHlgtBFqYJy
	h66kmukk+hDqzJJ1EhFSow6iv4T/7e6Ad3TE5WR9AdppMuhNP+uNfXAnW4m/0H10OkdyrOSdF7s
	rs5FbXSBRR8YZQAlBWOfttdRGzkjtM6LLs+vvd8ftK1VTryh7VPqbRYtFkprM2tKCiUVaMQ6YiH
	efVMLotQjRYL4fsQQOxUK2LH7dRHblSAi3Z65RRCrP4muLbO3XRtd2Gd9tuMeIMvnG25UvNkXpp
	8NrPWzDYGkTU49stUgRL1G8k8Hn17cyHmoWIKV1zBooL4TDfezMSWXP9R7jWC5pJ9It/8wAUqDi
	QpZiQ14UyJzyjk5Q5hOjoDcocHqYCaDcy5haKsD/4eHHubpayikojq9yRHJJVWNhcdu4RH+HI1h
	8QtIUE7AY1OJcLDbd8WQ==
X-Google-Smtp-Source: AGHT+IHPF8qvl92qn4O9HhTI1Ru2B9M2uJdkrL9b57C7ScKd/dNGobpzHj6JIHuzPjJ880jsHGaSFQ==
X-Received: by 2002:aa7:c551:0:b0:634:544b:a756 with SMTP id 4fb4d7f45d1cf-63c1f6dfbe8mr243723a12.32.1760629595073;
        Thu, 16 Oct 2025 08:46:35 -0700 (PDT)
Received: from NB-6746.corp.yadro.com ([188.243.183.84])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63c12279a54sm1237989a12.11.2025.10.16.08.46.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 08:46:34 -0700 (PDT)
From: Artem Shimko <a.shimko.dev@gmail.com>
To: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
	Vinod Koul <vkoul@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>
Cc: Artem Shimko <a.shimko.dev@gmail.com>,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/2] dmaengine: dw-axi-dmac: add reset control support
Date: Thu, 16 Oct 2025 18:46:26 +0300
Message-ID: <20251016154627.175796-3-a.shimko.dev@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251016154627.175796-1-a.shimko.dev@gmail.com>
References: <20251016154627.175796-1-a.shimko.dev@gmail.com>
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
 .../dma/dw-axi-dmac/dw-axi-dmac-platform.c    | 42 ++++++++++++-------
 drivers/dma/dw-axi-dmac/dw-axi-dmac.h         |  1 +
 2 files changed, 27 insertions(+), 16 deletions(-)

diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
index 8b7cf3baf5d3..ac23e1a5e218 100644
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
@@ -1616,9 +1621,14 @@ static void dw_remove(struct platform_device *pdev)
 	struct axi_dma_chan *chan, *_chan;
 	u32 i;
 
-	/* Enable clk before accessing to registers */
+	/*
+	 * The peripheral must be clocked and out of reset
+	 * before its registers can be accessed.
+	 */
 	clk_prepare_enable(chip->cfgr_clk);
 	clk_prepare_enable(chip->core_clk);
+	reset_control_deassert(chip->resets);
+
 	axi_dma_irq_disable(chip);
 	for (i = 0; i < dw->hdata->nr_channels; i++) {
 		axi_chan_disable(&chip->dw->chan[i]);
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


