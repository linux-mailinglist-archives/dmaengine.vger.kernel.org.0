Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 403B5469513
	for <lists+dmaengine@lfdr.de>; Mon,  6 Dec 2021 12:34:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241881AbhLFLiU (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 6 Dec 2021 06:38:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241484AbhLFLiT (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 6 Dec 2021 06:38:19 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45447C061746;
        Mon,  6 Dec 2021 03:34:51 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id np6-20020a17090b4c4600b001a90b011e06so8060804pjb.5;
        Mon, 06 Dec 2021 03:34:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4fGtVCG1i/w+nUv5JtEvYC7FJa62VZy/NwCwniaoRXs=;
        b=cLxXvW7kSC05B8tj7ofVyaOHPEjCb4V1fhQzRO2i2Za88XoZV0t6FIVePHMWkjVmFZ
         HA/4BLfwKr9/mpj2K0GM7eXeC8Ppp3Ffaw+NIzDlxjKlZe6yaWVSd3ywaaw5R3WQBBky
         +omFWP6stZBDH5sFTRhLlyLQmpVdao8jhyNFTPzhVplkcsgxTdBJOKhwfUsUc+KIIvL4
         G69o45s+ckGNOObX0tKvEVjiXOp2t6yBm3XPAZ100kGATdZZ44PVewPgRz+r0vzN+BLg
         KJy22mREvR6FMs3O5Ud8atBghAZlnem4sI67oBALtRanCA/VoPSz1XLIcLcLR7iQzRpF
         WVZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4fGtVCG1i/w+nUv5JtEvYC7FJa62VZy/NwCwniaoRXs=;
        b=XguK57yEo4Opt4uIETxWlMN0dFx7IKXaaqx6kZhNxl+2b2TQdNoFpmR6Xnp01D8pWV
         Ren0NhKhXLMIF+fYNO9FXyW4Toa/kEU46ghY1rZFGS5dWO9RYvic6jCLpAES/0LoloIc
         FBSeELKHdn3bRRGmnzFAizi9hwuo+Dl5JrBl5lN77VK/ECqx77V9MRpCqmd6aFGuNzHe
         u2kY/lHRcf2bmidFthPFW7i6CvaiajShC7zJaxRDrigmN5tdINwGCZ9zcc2PJP7RsdTO
         JKF7GRu3Us21PbdXfQ20uUAQ/FMtCxu3v+72rDVbskX0i2kOlAOKBiH2/jFAq4Uq8VmY
         qoQw==
X-Gm-Message-State: AOAM5337Q3Pyh3VyULP4akqOpkeZ90VTnXp87b+bJm23u2Wvwl4it8cl
        tlVPfs6jEMH/wuzFR+UdMIE=
X-Google-Smtp-Source: ABdhPJz1WHY9AJpTcmS81D6jUO0/nQS1w65gB/0RlRaDyztERcBTYUP8VK8vvZuZanFwCccNlInM9w==
X-Received: by 2002:a17:90a:8049:: with SMTP id e9mr36339793pjw.229.1638790490741;
        Mon, 06 Dec 2021 03:34:50 -0800 (PST)
Received: from localhost.localdomain ([94.177.118.54])
        by smtp.gmail.com with ESMTPSA id s19sm12256594pfu.104.2021.12.06.03.34.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Dec 2021 03:34:50 -0800 (PST)
From:   Dongliang Mu <mudongliangabcd@gmail.com>
To:     Vinod Koul <vkoul@kernel.org>, Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>
Cc:     Dongliang Mu <mudongliangabcd@gmail.com>,
        Baolin Wang <baolin.wang@spreadtrum.com>,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] dmaengine: sprd: move pm_runtime_disable to err_rpm
Date:   Mon,  6 Dec 2021 19:34:37 +0800
Message-Id: <20211206113437.2820889-1-mudongliangabcd@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

When pm_runtime_get_sync fails, it forgets to invoke pm_runtime_disable
in the label err_rpm.

Fix this by moving pm_runtime_disable to label err_rpm.

Fixes: 9b3b8171f7f4 ("dmaengine: sprd: Add Spreadtrum DMA driver")
Signed-off-by: Dongliang Mu <mudongliangabcd@gmail.com>
---
 drivers/dma/sprd-dma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/sprd-dma.c b/drivers/dma/sprd-dma.c
index 4357d2395e6b..ae8b2cfebfee 100644
--- a/drivers/dma/sprd-dma.c
+++ b/drivers/dma/sprd-dma.c
@@ -1226,8 +1226,8 @@ static int sprd_dma_probe(struct platform_device *pdev)
 	dma_async_device_unregister(&sdev->dma_dev);
 err_register:
 	pm_runtime_put_noidle(&pdev->dev);
-	pm_runtime_disable(&pdev->dev);
 err_rpm:
+	pm_runtime_disable(&pdev->dev);
 	sprd_dma_disable(sdev);
 	return ret;
 }
-- 
2.25.1

