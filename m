Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34035304BD8
	for <lists+dmaengine@lfdr.de>; Tue, 26 Jan 2021 22:56:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726243AbhAZVyO (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 26 Jan 2021 16:54:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729610AbhAZVTo (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 26 Jan 2021 16:19:44 -0500
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED0A0C06174A
        for <dmaengine@vger.kernel.org>; Tue, 26 Jan 2021 13:19:01 -0800 (PST)
Received: by mail-qt1-x82e.google.com with SMTP id c1so13401312qtc.1
        for <dmaengine@vger.kernel.org>; Tue, 26 Jan 2021 13:19:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cxJuuMsa2jIO+Tc7/X3iH1iIFgmN0hDTq5SLplTk3iw=;
        b=QdQiCZypVFfKH4yNeGOjaRL5hxwqgKZiu4RqmwTDneDFb4EpmeiAaNbPVVJm/NQugo
         uormYN/750ESm/TPMXgs+HOWDt5+QKz4VcU6x6AKM06+o9qwCBz1OzfZLSOefQLbGSws
         TqT3s3zcSauhUJfiRbfERE1qhuG6NNASPwQTIFqcM5qJdgUtU7RgwF5eSUM7280aTFMp
         E/TQPDMntSITfia3jONr7zsla+LreiuAiIxM5nu12MEQpjRL8+Eq3nx9ejhbDHic9D73
         7GVnTFucZXSRHoQ1W2p43sdPCE8VtKOK5I3zaogSLVLpHdKULvJO9gLosXcTmhuhTPDY
         JvhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cxJuuMsa2jIO+Tc7/X3iH1iIFgmN0hDTq5SLplTk3iw=;
        b=lem2IqM0F5DkfCUooG1JXzriF/zVtCurjflSRbtx+J5hIYrV4N0LWFaBgwHlPpScYC
         udrzWt0H2O3sV9GT1Zir+uZgPWQsE0gpSe0tSYjcaU3ZW/Xy6+LcuUH7nV/T8j16gJa2
         NGXoW1x1x07Pf65q7QYEopNNJmk2hStoPnt1yS4Vm8yNKykR4HuzRfj+smCEn2HrEIOj
         g/ZjCr7QWE8tF1L8/WE077E0cGLgHlLBhpN1uUp5/Mn5Tpli83JRzPNZneVPhfOEm62f
         wyAQiH8JIZIg/uj0ZUCOD5VK6w4sE/Njo+9NFC9g3My1VrAXMHtJDKPHcKcTgMzFN7kH
         0Hhw==
X-Gm-Message-State: AOAM531TyykZmiVoXGKCoXO4hSJ4yKWGF2W4ovJPOO3fD2F2/JONXuAP
        KGVIomRlpYH5q5Xny0JC5h/ZIQ==
X-Google-Smtp-Source: ABdhPJxcVhas9teyj/3N9iOrznAi2kswqX5kofHpa7y3HxWtrKQzuHm/9Dg9LyRReD3fJVMse6mtHA==
X-Received: by 2002:ac8:5714:: with SMTP id 20mr7054840qtw.197.1611695941146;
        Tue, 26 Jan 2021 13:19:01 -0800 (PST)
Received: from pop-os.fios-router.home (pool-71-163-245-5.washdc.fios.verizon.net. [71.163.245.5])
        by smtp.googlemail.com with ESMTPSA id x134sm15001476qka.1.2021.01.26.13.18.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jan 2021 13:19:00 -0800 (PST)
From:   Thara Gopinath <thara.gopinath@linaro.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org,
        dan.j.williams@intel.com, vkoul@kernel.org
Cc:     shawn.guo@linaro.org, srinivas.kandagatla@linaro.org,
        linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] dma: qcom: bam_dma: Manage clocks when controlled_remotely is set
Date:   Tue, 26 Jan 2021 16:18:59 -0500
Message-Id: <20210126211859.790892-1-thara.gopinath@linaro.org>
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

v1->v2:
	- As per Shawn's suggestion, use devm_clk_get_optional to get the
	  bam clock if the "controlled_remotely" property is set so that
	  the clock code takes care of setting the bam clock to NULL if
	  not specified by dt. 
	- Remove the check for "controlled_remotely" property in
	  bam_dma_resume now that clock enable / disable is based on
	  whether bamclk is NULL or not.
	- Rebased to v5.11-rc5

 drivers/dma/qcom/bam_dma.c | 29 +++++++++++++++--------------
 1 file changed, 15 insertions(+), 14 deletions(-)

diff --git a/drivers/dma/qcom/bam_dma.c b/drivers/dma/qcom/bam_dma.c
index 88579857ca1d..c8a77b428b52 100644
--- a/drivers/dma/qcom/bam_dma.c
+++ b/drivers/dma/qcom/bam_dma.c
@@ -1270,13 +1270,13 @@ static int bam_dma_probe(struct platform_device *pdev)
 			dev_err(bdev->dev, "num-ees unspecified in dt\n");
 	}
 
-	bdev->bamclk = devm_clk_get(bdev->dev, "bam_clk");
-	if (IS_ERR(bdev->bamclk)) {
-		if (!bdev->controlled_remotely)
-			return PTR_ERR(bdev->bamclk);
+	if (bdev->controlled_remotely)
+		bdev->bamclk = devm_clk_get_optional(bdev->dev, "bam_clk");
+	else
+		bdev->bamclk = devm_clk_get(bdev->dev, "bam_clk");
 
-		bdev->bamclk = NULL;
-	}
+	if (IS_ERR(bdev->bamclk))
+		return PTR_ERR(bdev->bamclk);
 
 	ret = clk_prepare_enable(bdev->bamclk);
 	if (ret) {
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
@@ -1451,12 +1451,13 @@ static int __maybe_unused bam_dma_resume(struct device *dev)
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
 		pm_runtime_force_resume(dev);
+	}
 
 	return 0;
 }
-- 
2.25.1

