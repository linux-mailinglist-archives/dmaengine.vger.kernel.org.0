Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B7DC2FFAAC
	for <lists+dmaengine@lfdr.de>; Fri, 22 Jan 2021 03:53:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726683AbhAVCxe (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 21 Jan 2021 21:53:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726268AbhAVCxd (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 21 Jan 2021 21:53:33 -0500
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 208E3C06174A
        for <dmaengine@vger.kernel.org>; Thu, 21 Jan 2021 18:52:53 -0800 (PST)
Received: by mail-qt1-x836.google.com with SMTP id z22so3186605qto.7
        for <dmaengine@vger.kernel.org>; Thu, 21 Jan 2021 18:52:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GKuYChxcbat6wOowZ/luWuFDp05RLb0vBoPsH1W9HLw=;
        b=fWX1fVnSDfRBs4lvhqIkcuFxJczn4RVcy8W7l7m57JkcWR8brGBrkwyok3ZO5XV3YL
         3RccD753tIuCIC0P4G1d7mBywZOi/pwihdwRctYeiqSLrd9jVCS+qK9fGTIdbkuLYYCS
         wmiRwQx4lOEVr6f1M1UMbUV7pdeeceHIKQBdN+13ziDRMeW3A+V/Dx/Fs0WlmOo7SdLo
         JJYv89XgNZzOZo2HQPNOQZOF04qMh+bCZS9313D0PLJfkSbDKkfKJr/RoCKSqWdreMaW
         1LXNrQAk6BdJryD72zjbT/O3Uq3Mxe1tWCyoUdVrWzcQIJsXi0z5WjEdMRtU8cQhWeLM
         a4yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GKuYChxcbat6wOowZ/luWuFDp05RLb0vBoPsH1W9HLw=;
        b=R0N3YFMd0tE/d0TxUYwB/Zasd+vwZ6lYimVYRP+iO00slKxUz9i2Lgj3gGeq94c0Te
         6Iyartpqt+kSZbD1bIXO6KJZqRADBKZMsQ2usEdZ47J21gWp9qSgOr+4RcgNWMqSzE+f
         +edmjhAnrqejROwNiJ3r9BFlT7Qr8Qpnklct6OjWuWCalbzo6snHIAePbjS8Bytqcsi+
         2+FmfWKqrFawk6yKcd/EmN0jYndXiQtCtZLkxiJI0DakyWoaf6mnGsCwIMMB18sJvIbd
         UuDcUhlzccjxjQOkLoMHneJlE7ZDnIpdZHUWKNT73ChiBV63LXG0Xtnk9aerelyZnOsH
         1uoA==
X-Gm-Message-State: AOAM531GmX+u3nsgUoBJnxEk4fsnsA16G3E6fcHRup5ezrSzuczEufpR
        1H1zL1xxrnvxmTSW4aXni81atg==
X-Google-Smtp-Source: ABdhPJz0/0z3vN1mwtb/eHobd43pDem3zer8bhWxzdjrhtLzoPfPsWI7C+OqW6A2WNXnrCjLU5m9dg==
X-Received: by 2002:ac8:718d:: with SMTP id w13mr2513193qto.361.1611283972393;
        Thu, 21 Jan 2021 18:52:52 -0800 (PST)
Received: from pop-os.fios-router.home (pool-71-163-245-5.washdc.fios.verizon.net. [71.163.245.5])
        by smtp.googlemail.com with ESMTPSA id n62sm5414409qkn.125.2021.01.21.18.52.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jan 2021 18:52:51 -0800 (PST)
From:   Thara Gopinath <thara.gopinath@linaro.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org,
        dan.j.williams@intel.com, vkoul@kernel.org
Cc:     shawn.guo@linaro.org, srinivas.kandagatla@linaro.org,
        linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drivers: dma: qcom: bam_dma: Manage clocks when controlled_remotely is set
Date:   Thu, 21 Jan 2021 21:52:51 -0500
Message-Id: <20210122025251.3501362-1-thara.gopinath@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

When bam dma is "controlled remotely", thus far clocks were not controlled
from the Linux. In this scenario, Linux was disabling runtime pm in bam dma
driver and not doing any clock management in suspend/resume hooks.

With introduction of crypto engine bam dma, the clock is a rpmh resource
that can be controlled from both Linux and TZ/remote side.  Now bam dma
clock is getting enabled during probe even though the bam dma can be
"controlled remotely". But due to clocks not being handled properly,
bam_suspend generates a unbalanced clk_unprepare warning during system
suspend.

To fix the above issue and to enable proper clock-management, this patch
enables runtim-pm and handles bam dma clocks in suspend/resume hooks if
the clock node is present irrespective of controlled_remotely property.

Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
---
 drivers/dma/qcom/bam_dma.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/dma/qcom/bam_dma.c b/drivers/dma/qcom/bam_dma.c
index 88579857ca1d..b3a34be63e99 100644
--- a/drivers/dma/qcom/bam_dma.c
+++ b/drivers/dma/qcom/bam_dma.c
@@ -1350,7 +1350,7 @@ static int bam_dma_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_unregister_dma;
 
-	if (bdev->controlled_remotely) {
+	if (!bdev->bamclk) {
 		pm_runtime_disable(&pdev->dev);
 		return 0;
 	}
@@ -1438,10 +1438,10 @@ static int __maybe_unused bam_dma_suspend(struct device *dev)
 {
 	struct bam_device *bdev = dev_get_drvdata(dev);
 
-	if (!bdev->controlled_remotely)
+	if (bdev->bamclk) {
 		pm_runtime_force_suspend(dev);
-
-	clk_unprepare(bdev->bamclk);
+		clk_unprepare(bdev->bamclk);
+	}
 
 	return 0;
 }
@@ -1451,12 +1451,14 @@ static int __maybe_unused bam_dma_resume(struct device *dev)
 	struct bam_device *bdev = dev_get_drvdata(dev);
 	int ret;
 
-	ret = clk_prepare(bdev->bamclk);
-	if (ret)
-		return ret;
+	if (bdev->bamclk) {
+		ret = clk_prepare(bdev->bamclk);
+		if (ret)
+			return ret;
 
-	if (!bdev->controlled_remotely)
-		pm_runtime_force_resume(dev);
+		if (!bdev->controlled_remotely)
+			pm_runtime_force_resume(dev);
+	}
 
 	return 0;
 }
-- 
2.25.1

