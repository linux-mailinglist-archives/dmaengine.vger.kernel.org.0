Return-Path: <dmaengine+bounces-4355-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C32DA2D94C
	for <lists+dmaengine@lfdr.de>; Sat,  8 Feb 2025 23:31:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86F213A6C1A
	for <lists+dmaengine@lfdr.de>; Sat,  8 Feb 2025 22:31:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDE261F2B86;
	Sat,  8 Feb 2025 22:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QoHTID3G"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDAF31F2B88
	for <dmaengine@vger.kernel.org>; Sat,  8 Feb 2025 22:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739053880; cv=none; b=GWryvsE0Cmd8sXElLWvzTBPw7kOutaiwdqsA5Y3zpzOdTNpSvubi90GmHfd9NZo058m0yvCgqSFYj99ENWPs/IppwzMQE0ERFlAP1IItGmrxx88A+xhrAiACXCBN1hTuluvJGtQkwjvLhuNCb7Go77lMGfWA8W+KajeLqVLTPmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739053880; c=relaxed/simple;
	bh=i0Pgu1nNguhn+OcJqADhf+B5dfvmGm1cd/4eQ18Cay0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SD1oDEN6tkZtlounu4rnaKdwD5F88fWIevLpN1K6hqZX/JuN3tAnA8huvTXy6MxYeff+3KXrJ4Lox9rN5GJu9TZyAxktN58t/7IW4PhceSNtQHiNoqQybzIFqcTwuMOqnRM1laNac7ytn+BzG+1Mr26qS4T5uqyhQ7eOUNsOB/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QoHTID3G; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-388cae9eb9fso1588321f8f.3
        for <dmaengine@vger.kernel.org>; Sat, 08 Feb 2025 14:31:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739053877; x=1739658677; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oOymSIevROsxi1+z/Gkz6vM+ejicrRtg+7on9+xHQ7I=;
        b=QoHTID3GayBp+Ya71cE0sHsR9GV0t7mAWfVCWFnaiiApxQJ/qZYGtp3+MkAqrFxHYh
         hVIknIFulZpJkDkpfPctpKkpe8JzvemVvn/OFILciR1hgeU9lTWtyPmg2yfPFSNdNnkk
         X48gjziumFcqle2NEvnvP9T+uiCskyh094CQ784Wqk14r9z+JNnr8ZlUK5njAq33pztC
         gBrxp+vZtocRYk2YJhGUXTUhiPBace2xW2lXhZQgzzMdc12OiPGTuFvafbT42PElclsm
         BI7Pfw7PVptLca8uCAKBGsC7yIDb+sFVHPcpjbX0qaB2TOsMPq01tTlutrGm0h2z9ZyH
         XSyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739053877; x=1739658677;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oOymSIevROsxi1+z/Gkz6vM+ejicrRtg+7on9+xHQ7I=;
        b=uyqj2q6tMFUbQ4K6iDRgDjRDCk6mwXn7zo6waywLBx/xB5qVLp9wvDI9OLBmQao/pV
         ljhISdw4/8aLOiVPh55sNqrWsRPS24GiX4hMmuxdtGPXsAIXuaXtWT4qXx7FjIJKhA04
         Gl5kATNxUxrV9F0QbjLC6IGpBzDVS4Y+8fI7nbzOs7iEhTpkguXv86P9Soo2sCGT8Rwl
         CgRotQQQoYgqwnh1xpvo9W/L8suPC/s/Pj570OkfN8Zpc5jeXbSJy2Z1yCXOxvmdhuOM
         N+REuZJB6K3VTrfeLGEiYFCu1Y0WBrprCRQYhMhVc0UmtfyJXLCt9gjFsl0iP8Jy6wJv
         bWqw==
X-Forwarded-Encrypted: i=1; AJvYcCWHLlEp+3ZVD9LRLSRm5femJ90B8shB9N6Tuvd81Z2/1vhbMIAZkZrenDwwDW1j1ql4c1NeQMafPj4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXsDofK4VIWcKldXewBO1d0PnHKkqPZ7uvJtG8HEnQjJUqQAg+
	6/KU0m5hRctMk+SS5TREYsNO7fHYld9nLopGP+ehEAZx0X0Z9WRFpB/zityKxe4=
X-Gm-Gg: ASbGncvASR9yE71iHH8026rg2vxJAo+AiHX5/W6Y8IH4KJqztD3r/BlV+I80MHvmrxp
	Lg0ZoD6N/6Xs9SyHsFQrJNQjk6I7DxrqfZiDz3ZQ6X5LKS62nenwXzW5xUIINeLD6R81Uji65S5
	L2+NvP/p+dA8mXHIp5GTwPRi36w1wNUPc4b2OokZ/+TlTOY1YdlcF4VMfuSpOI3cJvDL5N6yN2X
	WwyoQGJXLwAvGTaljbmfoENxhE85RRzBuJkOk+AwqfYUJBG0Qp0GBlWHuLcg0zUzTHN/L5qU5JY
	oWeknLBFYRozEy0b9n8VTlZ59HonCj5dwGnqSwJIIouP3vOCvVI=
X-Google-Smtp-Source: AGHT+IEPI1lpVJMdKndYbstkJD7fFNRz3JYxn9yHDdjXaQCn//Np8gVHfr98hT7x7dMyS1p3lhHrcw==
X-Received: by 2002:a05:6000:2aa:b0:38d:daf3:be60 with SMTP id ffacd0b85a97d-38ddaf3c056mr47881f8f.48.1739053877148;
        Sat, 08 Feb 2025 14:31:17 -0800 (PST)
Received: from toyger.caleb.rex.connolly.tech ([2a0a:ef40:1d11:ab01:ce4f:b99d:6477:b544])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4391dc9ffd8sm95906905e9.10.2025.02.08.14.31.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Feb 2025 14:31:16 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
To: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Amit Vadhavana <av2082000@gmail.com>,
	Caleb Connolly <caleb.connolly@linaro.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Fenghua Yu <fenghua.yu@intel.com>,
	Kees Cook <kees@kernel.org>,
	Md Sadre Alam <quic_mdalam@quicinc.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Vinod Koul <vkoul@kernel.org>
Cc: David Heidelberg <david@ixit.cz>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	dmaengine@vger.kernel.org,
	linux-arm-msm@vger.kernel.org
Subject: [PATCH] Revert "dmaengine: qcom: bam_dma: Avoid writing unavailable register"
Date: Sat,  8 Feb 2025 22:30:54 +0000
Message-ID: <20250208223112.142567-1-caleb.connolly@linaro.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit causes a hard crash on sdm845 and likely other platforms.
Revert it until a proper fix is found.

This reverts commit 57a7138d0627309d469719f1845d2778c251f358.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 drivers/dma/qcom/bam_dma.c | 24 ++++++++----------------
 1 file changed, 8 insertions(+), 16 deletions(-)

diff --git a/drivers/dma/qcom/bam_dma.c b/drivers/dma/qcom/bam_dma.c
index c14557efd577..bbc3276992bb 100644
--- a/drivers/dma/qcom/bam_dma.c
+++ b/drivers/dma/qcom/bam_dma.c
@@ -58,11 +58,8 @@ struct bam_desc_hw {
 #define DESC_FLAG_EOB BIT(13)
 #define DESC_FLAG_NWD BIT(12)
 #define DESC_FLAG_CMD BIT(11)
 
-#define BAM_NDP_REVISION_START	0x20
-#define BAM_NDP_REVISION_END	0x27
-
 struct bam_async_desc {
 	struct virt_dma_desc vd;
 
 	u32 num_desc;
@@ -400,9 +397,8 @@ struct bam_device {
 	int irq;
 
 	/* dma start transaction tasklet */
 	struct tasklet_struct task;
-	u32 bam_revision;
 };
 
 /**
  * bam_addr - returns BAM register address
@@ -444,12 +440,10 @@ static void bam_reset(struct bam_device *bdev)
 	val |= BAM_EN;
 	writel_relaxed(val, bam_addr(bdev, 0, BAM_CTRL));
 
 	/* set descriptor threshold, start with 4 bytes */
-	if (in_range(bdev->bam_revision, BAM_NDP_REVISION_START,
-		     BAM_NDP_REVISION_END))
-		writel_relaxed(DEFAULT_CNT_THRSHLD,
-			       bam_addr(bdev, 0, BAM_DESC_CNT_TRSHLD));
+	writel_relaxed(DEFAULT_CNT_THRSHLD,
+			bam_addr(bdev, 0, BAM_DESC_CNT_TRSHLD));
 
 	/* Enable default set of h/w workarounds, ie all except BAM_FULL_PIPE */
 	writel_relaxed(BAM_CNFG_BITS_DEFAULT, bam_addr(bdev, 0, BAM_CNFG_BITS));
 
@@ -1005,12 +999,11 @@ static void bam_apply_new_config(struct bam_chan *bchan,
 		if (dir == DMA_DEV_TO_MEM)
 			maxburst = bchan->slave.src_maxburst;
 		else
 			maxburst = bchan->slave.dst_maxburst;
-		if (in_range(bdev->bam_revision, BAM_NDP_REVISION_START,
-			     BAM_NDP_REVISION_END))
-			writel_relaxed(maxburst,
-				       bam_addr(bdev, 0, BAM_DESC_CNT_TRSHLD));
+
+		writel_relaxed(maxburst,
+			       bam_addr(bdev, 0, BAM_DESC_CNT_TRSHLD));
 	}
 
 	bchan->reconfigure = 0;
 }
@@ -1198,13 +1191,12 @@ static int bam_init(struct bam_device *bdev)
 {
 	u32 val;
 
 	/* read revision and configuration information */
-	val = readl_relaxed(bam_addr(bdev, 0, BAM_REVISION));
-	if (!bdev->num_ees)
+	if (!bdev->num_ees) {
+		val = readl_relaxed(bam_addr(bdev, 0, BAM_REVISION));
 		bdev->num_ees = (val >> NUM_EES_SHIFT) & NUM_EES_MASK;
-
-	bdev->bam_revision = val & REVISION_MASK;
+	}
 
 	/* check that configured EE is within range */
 	if (bdev->ee >= bdev->num_ees)
 		return -EINVAL;
-- 
2.48.1


