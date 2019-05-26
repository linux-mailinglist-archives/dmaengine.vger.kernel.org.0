Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A46A72A8F2
	for <lists+dmaengine@lfdr.de>; Sun, 26 May 2019 09:14:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727233AbfEZHOH (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 26 May 2019 03:14:07 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:34881 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726348AbfEZHOH (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 26 May 2019 03:14:07 -0400
Received: by mail-pf1-f193.google.com with SMTP id d126so5553246pfd.2;
        Sun, 26 May 2019 00:14:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=gpKp1Ji3NbYE6dlIioVp6OmCdvPteX1H1EwDeUiYnRo=;
        b=SlQO+gvKGyFVekP53VsMEkLrnYKIXnPeCfyVJpCc6L5giIU+OyiuvYGxLKys+i4eEg
         x4Bxv0XjnhN+IX32qe7Y6ElOmFVk5JLdxHDQghLROUfhfkS/yI7y9AsqY8dDjZTmx9Qd
         xQq6iB6wwJHfMzKKMnLuHIqOGcQm72DQLSdgSd8p2BRMGx11qnpAKZACoV3zQish1JUA
         LHrdhVNgk2vQzJ78O0MaTc2cM+d8KmN9D06jyp3OatZm4LGXzYiLtYWkToQNPYiS/QdZ
         HJroVs+UoCH+9+RMl3xE/lALsZKw7lFYjaYgbdr4apzaQv8q/VQyLTftAW25QN3sZjdX
         a30w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=gpKp1Ji3NbYE6dlIioVp6OmCdvPteX1H1EwDeUiYnRo=;
        b=oLZOJ9FPuAewNATYEEk0nfpNRP3WVCvctkkOyYZ1TC/xb2teyA6/2AV5U1citD45Mf
         /0jwOOA22Gtm0zvtCGRzTesVe0RiOhuRKpOCgklRjTWLpOHCEeyoVs/HTuVycUsdd9NX
         0M2fp7X2G4HhfT/FH3+ekfaCMxCkNjpqSzf8swcXYVQbJwCrB6y9AW6Bs5JN6jBtV7WE
         EHOSFWe9qK6fZYElbUQUh3CRWl/inVGkyHTzAcyqAjxDi5beCgVk640A9wyuYQa4My5L
         NGXMSfWZix/DXLYb3qVUmPHBK8nRXcWzFDacCL1bI1YuyH7+deDbt78RXq1plyVpaX7/
         YSEw==
X-Gm-Message-State: APjAAAWbPbcMDOou2b5MDTTL1177QiSQCXfvc7GCZwyuvn7L4HRYIhhv
        Y+n0fpG7ngY/LfYmxt51AlEP6n4X
X-Google-Smtp-Source: APXvYqwTC0FptfX7CPxxhryj2laivRpDqWwH7V8fygp/VEbP5GYpQPJX1vkSLqIrM2RDP7oYdhrGsA==
X-Received: by 2002:aa7:8e46:: with SMTP id d6mr98123175pfr.91.1558854846680;
        Sun, 26 May 2019 00:14:06 -0700 (PDT)
Received: from localhost ([43.224.245.181])
        by smtp.gmail.com with ESMTPSA id 4sm11313421pfj.111.2019.05.26.00.14.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 26 May 2019 00:14:06 -0700 (PDT)
From:   Weitao Hou <houweitaoo@gmail.com>
To:     vkoul@kernel.org, dan.j.williams@intel.com,
        mcoquelin.stm32@gmail.com, alexandre.torgue@st.com
Cc:     dmaengine@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Weitao Hou <houweitaoo@gmail.com>
Subject: [PATCH] dmaengine: use to_platform_device()
Date:   Sun, 26 May 2019 15:13:24 +0800
Message-Id: <20190526071324.15307-1-houweitaoo@gmail.com>
X-Mailer: git-send-email 2.18.0
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Use to_platform_device() instead of open-coding it.

Signed-off-by: Weitao Hou <houweitaoo@gmail.com>
---
 drivers/dma/stm32-dmamux.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/stm32-dmamux.c b/drivers/dma/stm32-dmamux.c
index a67119199c45..63af24d4c834 100644
--- a/drivers/dma/stm32-dmamux.c
+++ b/drivers/dma/stm32-dmamux.c
@@ -306,8 +306,7 @@ static int stm32_dmamux_probe(struct platform_device *pdev)
 #ifdef CONFIG_PM
 static int stm32_dmamux_runtime_suspend(struct device *dev)
 {
-	struct platform_device *pdev =
-		container_of(dev, struct platform_device, dev);
+	struct platform_device *pdev = to_platform_device(dev);
 	struct stm32_dmamux_data *stm32_dmamux = platform_get_drvdata(pdev);
 
 	clk_disable_unprepare(stm32_dmamux->clk);
@@ -317,8 +316,7 @@ static int stm32_dmamux_runtime_suspend(struct device *dev)
 
 static int stm32_dmamux_runtime_resume(struct device *dev)
 {
-	struct platform_device *pdev =
-		container_of(dev, struct platform_device, dev);
+	struct platform_device *pdev = to_platform_device(dev);
 	struct stm32_dmamux_data *stm32_dmamux = platform_get_drvdata(pdev);
 	int ret;
 
-- 
2.18.0

