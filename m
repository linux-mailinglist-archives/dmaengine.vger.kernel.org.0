Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5663912BF30
	for <lists+dmaengine@lfdr.de>; Sat, 28 Dec 2019 21:47:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727028AbfL1Urj (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 28 Dec 2019 15:47:39 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:43641 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726925AbfL1Urj (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 28 Dec 2019 15:47:39 -0500
Received: by mail-lj1-f194.google.com with SMTP id a13so29878331ljm.10;
        Sat, 28 Dec 2019 12:47:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iZ3D39bl0eyByo7/hfV3v45VBZOWa7JfxNIxRNpu/N8=;
        b=BmrmvnwR3GOPQNeRWzfJ2QlcpbhMh0Qyb61SHXPdhESVag2N3vLPby7fSwv20xW6Dh
         H3YRT2KM0OU+OBfP34LxWZ96jcJAhYin7pWStBpzg9UJYnDBh0JknVx9S37y6oiZWh0x
         lQEdllzhB/XHrLF/3B6arW1psrYLUUGBe11QGWZLxUhJiqW10n+FD7dg32r+NNbnvj5/
         4OVxlb00LOw2qozR52ibezCFPjYDN1xB/NhIoUmgWlDTOLcN9vSX29fZpS7kzgShYRfn
         7HHtG6Pl9Orn9WvZlQxnhNcEmiC/uQbQ1DuGcknaGStG1N6UXNgKpyvQArjrx5cH3KpJ
         F+dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iZ3D39bl0eyByo7/hfV3v45VBZOWa7JfxNIxRNpu/N8=;
        b=n0ndDuQD2MTRWzHrsHu1Rcfrd4mLNu36G6mrmOfVB/tCUaYQQaj+7scD/Oewkpone5
         thR2f34kpwOjX58d5ZNKUMwb8ieg1YySwArQx765bFA9iJrnuaXV6nzPJcQpmaHFz7xL
         pSgWIBeZ749vmL03Dz58Etlr6HOyf1EEWYoIxLyLOFXQ1yjqlPXV3GehYlDUoqFnu5JH
         awmfefz3HgGCjQ4KNyXSWgpUhI4d2+qXJ+GQORRccc+gb2NmSveF+SxrzoMA91LpFJ1h
         IlWKvxJliQuGSws+CTVs+9FsbWNLM1XihLWXu2hxwiuK1B+8sqbOKo1e6ONp/a1XvXCa
         LIYA==
X-Gm-Message-State: APjAAAXi2wr6hw96x2oPW1OFYuvxuyKCI89McG+rfLgE39SzEkrcEkdm
        iDJm85o6JgUzzPoX3hNJm1k=
X-Google-Smtp-Source: APXvYqwRFDWMCt+5WITO7u0D8AG40U1iA3Rkjy8bP/LOlJNsScDdPx0qJp4OQspninWhQEtnAITkUg==
X-Received: by 2002:a2e:8119:: with SMTP id d25mr32134447ljg.76.1577566056359;
        Sat, 28 Dec 2019 12:47:36 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id g15sm10571219ljl.10.2019.12.28.12.47.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Dec 2019 12:47:35 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Laxman Dewangan <ldewangan@nvidia.com>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     dmaengine@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 5/7] dmaengine: tegra-apb: Use devm_platform_ioremap_resource
Date:   Sat, 28 Dec 2019 23:46:38 +0300
Message-Id: <20191228204640.25163-6-digetx@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191228204640.25163-1-digetx@gmail.com>
References: <20191228204640.25163-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Use devm_platform_ioremap_resource to keep code cleaner a tad.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/dma/tegra20-apb-dma.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/dma/tegra20-apb-dma.c b/drivers/dma/tegra20-apb-dma.c
index 740b0ceec7ec..d2353f23b201 100644
--- a/drivers/dma/tegra20-apb-dma.c
+++ b/drivers/dma/tegra20-apb-dma.c
@@ -1405,8 +1405,7 @@ static int tegra_dma_probe(struct platform_device *pdev)
 	tdma->chip_data = cdata;
 	platform_set_drvdata(pdev, tdma);
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	tdma->base_addr = devm_ioremap_resource(&pdev->dev, res);
+	tdma->base_addr = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(tdma->base_addr))
 		return PTR_ERR(tdma->base_addr);
 
-- 
2.24.0

