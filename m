Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DEB2214746C
	for <lists+dmaengine@lfdr.de>; Fri, 24 Jan 2020 00:12:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729925AbgAWXLC (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 23 Jan 2020 18:11:02 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:39351 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729837AbgAWXLB (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 23 Jan 2020 18:11:01 -0500
Received: by mail-wm1-f67.google.com with SMTP id 20so4355655wmj.4;
        Thu, 23 Jan 2020 15:10:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gfFOKKBycfoTA+tP8C+2g2g1I1HSJbXw7d1KRYGNlF8=;
        b=jxU/AVqxnR3+hTPSPz6CkHPCRZ/afTWU8nW6KAmKr6oK7kSnlTg4jXQwqilt8TfYE2
         cIW2ER9Io3raMN6x2ifsf+UI+3CvooSGVVKxgCFo2o+aHXTRWOqDcRD3YB9MUVQslPBP
         XcXYuK26JdPGXvi3FjDlWpqB1SdEfatlwwsAy9NWdNb/fv5TKsIzNV332GxpAk0i1/qq
         mL8hfvAFUiI9P8bGBrLTpt+qtU12wngozJYawTgAA3Fspy3nK/QR4Ri/jF0vbIVqvBC9
         uekBPEZxHCNO31dknpsbJESNyHGEdBFoLpXZQD8J/edjm+WQJrGcz1CCi4XjrdOu0xXB
         EWqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gfFOKKBycfoTA+tP8C+2g2g1I1HSJbXw7d1KRYGNlF8=;
        b=GA6UxP+2iywhR2w2ypshhliDNBhO6ywQiVKmd67IjTqO3+mwAu2zgV5G67YJKocLIr
         OnJvWPP5QYEp/qFwenSmcDe5i3jKlRxZzFLs6Ru9bjQmTWDT5xkALPz6tbHfqNr5dhTR
         VA2SvVE3pXrYT3u+gjSvMDmyBSrbNoAiPmcuUVg/35hRbAz00KSoB5Z7DAShyBmUt8DY
         tdJ56cRok51sHB8MVjA5HAYBK4MeG1DqtxaBNM29FMj7gMsLa4xFqVYXOrDdx5wwWhsN
         prZSOlA1k7zW4UNo8bnAkjCiXZ5m3y/WzzJPAhQZGvfHtkhTMWr9nypD3G/ZXuokDag/
         hlBQ==
X-Gm-Message-State: APjAAAUyGmQiQD8h9SimjAC2DFUnNIwkJlXw+oKJKPjYlsWdgOO3rFLN
        fAcy2Ci684LsKVg8CW9gFYg=
X-Google-Smtp-Source: APXvYqwh0xiC7euwGWnYHRUuMpS2p6IW1LN/+trarCyT+FZVT/LNKqjzFyOCZ0eGrw4s/0e77zq1bQ==
X-Received: by 2002:a1c:80d4:: with SMTP id b203mr282683wmd.102.1579821059100;
        Thu, 23 Jan 2020 15:10:59 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id z6sm5105552wrw.36.2020.01.23.15.10.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2020 15:10:58 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Laxman Dewangan <ldewangan@nvidia.com>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Cc:     dmaengine@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 12/14] dmaengine: tegra-apb: Add missing of_dma_controller_free
Date:   Fri, 24 Jan 2020 02:03:23 +0300
Message-Id: <20200123230325.3037-13-digetx@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200123230325.3037-1-digetx@gmail.com>
References: <20200123230325.3037-1-digetx@gmail.com>
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
index 4a371891b7c4..8f4281ab6296 100644
--- a/drivers/dma/tegra20-apb-dma.c
+++ b/drivers/dma/tegra20-apb-dma.c
@@ -1587,6 +1587,7 @@ static int tegra_dma_remove(struct platform_device *pdev)
 {
 	struct tegra_dma *tdma = platform_get_drvdata(pdev);
 
+	of_dma_controller_free(pdev->dev.of_node);
 	dma_async_device_unregister(&tdma->dma_dev);
 	pm_runtime_disable(&pdev->dev);
 	clk_unprepare(tdma->dma_clk);
-- 
2.24.0

