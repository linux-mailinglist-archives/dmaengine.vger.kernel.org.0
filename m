Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5BF2914FFC3
	for <lists+dmaengine@lfdr.de>; Sun,  2 Feb 2020 23:30:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727170AbgBBWaq (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 2 Feb 2020 17:30:46 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:34386 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727198AbgBBWaA (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 2 Feb 2020 17:30:00 -0500
Received: by mail-lj1-f194.google.com with SMTP id x7so12652548ljc.1;
        Sun, 02 Feb 2020 14:29:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EA2aX2gMwFfc16iv548oZvQgKjYnmWGj0LmTyLTJTmM=;
        b=PY3MH52l9pxtCP2F/2ZmM5mlLagJFgJiTefeZGJoQMoBPuVbi7vYq6n3gXWPJPMhim
         gcni1v88jLTz8wgYv1reUV8H/24N7pQTa6AIj31bASbU36AEwbpjBHZ0+MrJ3apoEaF8
         hmCoiU7jUkQy3sb+BJUcpxORpjYCWsJ0XzMfm/V90Reej94N2FNXPl22J6TnaZQTIIts
         XhDKzQYbFnYFBalh0yMmhN+ajRf4PojQBjGmbympQZa7rxvL+fxjgUu+7WGOFz/CAFT7
         O7vNK8Q7npEXCa4/CCp5402LyfR0tmdS2W19SQCDkPxJIpA7LoWwAxpFPewOspyzdf1N
         fMsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EA2aX2gMwFfc16iv548oZvQgKjYnmWGj0LmTyLTJTmM=;
        b=A+cPCu0mD8oONzBQ3heAfkPfdQKNhQUThN7S4hd+I7Vo9tq/WX8QVRCYWkYB96CbGQ
         Y1/jaDOWGyzctZ/LF+yvGUcEH+VZPROIPjF4vvgMcvfQD5Sr8e5LATAAvsSNBuWDfO5Q
         kdPLdNDOmrHpfeoOD9N22mjn3uQG8jskZiX01N85o/Z/GIu9eCnrtIEuIA0YgEtW36tZ
         x3oFEtuvhxzhzXEBGDduf4yiH4suEh/eYwEH3yz4JxE2E4QmNdeRVFbZnvrmtJUyzUz4
         yyCH5LeGnN3z8KEpt26y+8VtmRzX964dbtLA//5FyJ98m45rM3ektiCKe+mYOmSIVQdX
         Nxpg==
X-Gm-Message-State: APjAAAUsxNZymN8dGjrxQ9b3QCmsfYH+Sk9QYR751OrHG+5WlrmpCgTm
        m7hh4in1+CfoqcnbENoeZgc=
X-Google-Smtp-Source: APXvYqxfaRoK07R8BsmkSfRO2NTdt3KR7Wc3WMNRtUOVfpnGcFBRbxNRX/hsfF53N1ljiGppDSg0rg==
X-Received: by 2002:a2e:5304:: with SMTP id h4mr12169905ljb.75.1580682598234;
        Sun, 02 Feb 2020 14:29:58 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id b190sm8050307lfd.39.2020.02.02.14.29.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Feb 2020 14:29:57 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Laxman Dewangan <ldewangan@nvidia.com>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Cc:     dmaengine@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v7 10/19] dmaengine: tegra-apb: Remove assumptions about unavailable runtime PM
Date:   Mon,  3 Feb 2020 01:28:45 +0300
Message-Id: <20200202222854.18409-11-digetx@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200202222854.18409-1-digetx@gmail.com>
References: <20200202222854.18409-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The runtime PM is always available on all Tegra SoCs since the commit
40b2bb1b132a ("ARM: tegra: enforce PM requirement"), so there is no
need to handle the case of unavailable RPM in the code anymore.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/dma/tegra20-apb-dma.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/dma/tegra20-apb-dma.c b/drivers/dma/tegra20-apb-dma.c
index 7158bd3145c4..22b88ccff05d 100644
--- a/drivers/dma/tegra20-apb-dma.c
+++ b/drivers/dma/tegra20-apb-dma.c
@@ -1429,11 +1429,8 @@ static int tegra_dma_probe(struct platform_device *pdev)
 	spin_lock_init(&tdma->global_lock);
 
 	pm_runtime_enable(&pdev->dev);
-	if (!pm_runtime_enabled(&pdev->dev))
-		ret = tegra_dma_runtime_resume(&pdev->dev);
-	else
-		ret = pm_runtime_get_sync(&pdev->dev);
 
+	ret = pm_runtime_get_sync(&pdev->dev);
 	if (ret < 0)
 		goto err_pm_disable;
 
@@ -1546,8 +1543,6 @@ static int tegra_dma_probe(struct platform_device *pdev)
 
 err_pm_disable:
 	pm_runtime_disable(&pdev->dev);
-	if (!pm_runtime_status_suspended(&pdev->dev))
-		tegra_dma_runtime_suspend(&pdev->dev);
 
 	return ret;
 }
@@ -1557,10 +1552,7 @@ static int tegra_dma_remove(struct platform_device *pdev)
 	struct tegra_dma *tdma = platform_get_drvdata(pdev);
 
 	dma_async_device_unregister(&tdma->dma_dev);
-
 	pm_runtime_disable(&pdev->dev);
-	if (!pm_runtime_status_suspended(&pdev->dev))
-		tegra_dma_runtime_suspend(&pdev->dev);
 
 	return 0;
 }
-- 
2.24.0

