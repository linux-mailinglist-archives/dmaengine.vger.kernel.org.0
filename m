Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 362D6156B93
	for <lists+dmaengine@lfdr.de>; Sun,  9 Feb 2020 17:42:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728139AbgBIQmM (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 9 Feb 2020 11:42:12 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:44887 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727989AbgBIQlc (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 9 Feb 2020 11:41:32 -0500
Received: by mail-lj1-f196.google.com with SMTP id q8so4364936ljj.11;
        Sun, 09 Feb 2020 08:41:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=E1cl/4dR4qjTI8FE+gVvr5rdR2qS1bPJXpjvB8mlwdc=;
        b=BQY0sqGWjl5PmcnUqEMeERRzRuhMi5lrQC7LFdo9emCehEK4h2pVr7amfZs1xMYRIX
         f5jl5ViToSnTnihE8dqPDvL1tsHrpeX9FBftDIll18HSgs2b7WhRgQOJY1n2/Ofy6ebP
         XKdlN5WAEbb6Esj8q8r85vzLmz8z8y3lrszSoBrKOSatoIiAbI1+fx4gYkNXl8uw8Tqu
         NhiXvfFr4utFuUxmz7MBEw4TGlwKoxfnjonXU08mWO38LbcykYS4i92wM7YCyRvHXt3Z
         JSuMiV+/7IGGG7gpb1Asq25VZewuRKy5IFS6Jp4xwG6Wj5MFOPTFn/5Gu/G1tiG66/iC
         AYtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=E1cl/4dR4qjTI8FE+gVvr5rdR2qS1bPJXpjvB8mlwdc=;
        b=lSpJ7C+cBVkqAbDHzBY5f7diwmxBkRUvDFLaqj9v1fc1SuSmx9VjL+u7w3uk1uP4FL
         DnUlAQwQI/VHOkUNWBFvC9hoeOsMxJoJrekAb7UDxrlccduJDNGftgvneaHImjT5MH5I
         V4BA8yiyAeufnPUuadMfahf0sJwmqDjrytsXvDcVVRdsQYVMu90OElr0moy39El3jcK1
         cco7E5Ltg03TelfzjnjbHhFs3FASNtZF6ChsQ4h1nmWzkm4uybPrceB1p5MnfdZprldL
         DTmxSrquw6telJ1fym/nfisxFxsHNUrxkfRyhsmoJo6hK3CpGqDwogs7QswsabMHfwRe
         OBQw==
X-Gm-Message-State: APjAAAWYvhwsj2wI8cxXanqIJpmiCF70TEHm1WLn54+6XY+xmV++WUE6
        fwlZqfTeWKklQICkq5PWIsk=
X-Google-Smtp-Source: APXvYqzgl52/JVmUIyxC/BVZQ/7hllhg8is8a/QYYIrx8O9k/OzRPyUkvB0cTcEV5WWAo8kvBLXDlg==
X-Received: by 2002:a05:651c:239:: with SMTP id z25mr5344911ljn.48.1581266490147;
        Sun, 09 Feb 2020 08:41:30 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id g21sm4941826ljj.53.2020.02.09.08.41.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Feb 2020 08:41:29 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Laxman Dewangan <ldewangan@nvidia.com>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Cc:     dmaengine@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v8 14/19] dmaengine: tegra-apb: Add missing of_dma_controller_free
Date:   Sun,  9 Feb 2020 19:33:51 +0300
Message-Id: <20200209163356.6439-15-digetx@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200209163356.6439-1-digetx@gmail.com>
References: <20200209163356.6439-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The DMA controller shall be released on driver's removal.

Acked-by: Jon Hunter <jonathanh@nvidia.com>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/dma/tegra20-apb-dma.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/dma/tegra20-apb-dma.c b/drivers/dma/tegra20-apb-dma.c
index 7fa0430503d4..370c3f2d68a5 100644
--- a/drivers/dma/tegra20-apb-dma.c
+++ b/drivers/dma/tegra20-apb-dma.c
@@ -1569,6 +1569,7 @@ static int tegra_dma_remove(struct platform_device *pdev)
 {
 	struct tegra_dma *tdma = platform_get_drvdata(pdev);
 
+	of_dma_controller_free(pdev->dev.of_node);
 	dma_async_device_unregister(&tdma->dma_dev);
 	pm_runtime_disable(&pdev->dev);
 	clk_unprepare(tdma->dma_clk);
-- 
2.24.0

