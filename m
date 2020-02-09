Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DA763156B6D
	for <lists+dmaengine@lfdr.de>; Sun,  9 Feb 2020 17:42:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727939AbgBIQlZ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 9 Feb 2020 11:41:25 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:33766 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727835AbgBIQlY (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 9 Feb 2020 11:41:24 -0500
Received: by mail-lf1-f65.google.com with SMTP id n25so2509854lfl.0;
        Sun, 09 Feb 2020 08:41:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yfyyd1gAYNfQRVTzzie9M6MUShefAhN4x9LLDsJ6WIA=;
        b=U6lkmEfKln73ZyzEdJ/09ICzC4ksclTcmtNCYHWDI1hySYyrMrhnxaZhLfHNnXNi6H
         yIoOtceQA0PFmmvP77i1iUyFvGJLNPYW6cU28QOvs2a3VsbjqwWplimbX6OszHv1pvH9
         hEi/iQoG2t/H5VvAlUUjCdqRWy+G8lCqLz91CSOxaEaXnXT7+b8aU6wZyflZH4n1aCnC
         TKNlmHlhCwU0IUI90UQyV9+Z6rn28+V9fVlsLVb4eIVBRaXJXOf8Sdetb4htFVJ6vIe0
         gsYH+UwisQFui9piv702SD5tiejYq+fNmD6YZJlJctqXAADrAEiqqqSQ8IcvK6TCZAta
         6/qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yfyyd1gAYNfQRVTzzie9M6MUShefAhN4x9LLDsJ6WIA=;
        b=e7HxbRUrECOXywc1DZHgRXX9LEkekhQRlIwcR3odlzWmVfihtXBFScTNbqa689pMZn
         wjMhuT+fKwzY2qvdjYtrl2tAn4lciVBgFQiS2dP/zGoNMBHZKGPq2FtageeRcBTe8FS2
         ozMUBWFfY4ZUkSVvCZIycj/sJWDZtsPQWVEVOFijsLY+Jx5d99/S8F7zIo8I7zARrbep
         f3yL/1r8vhkoNSF0BcH2XrTv0GaWj1HITp2HgO8+fhADcB3p1wq4+WmqBGFrMY4H9RWA
         eu40H3URFcml6kqByH6rpBCPCZn4h0kaP1hkmgcSNV846BqPuN+7CfxCbdKa2r8oWtyH
         mm8Q==
X-Gm-Message-State: APjAAAUcQBeiBM15w/SJMFvfmUUGbHG3f04cpkyQRZ/3VIEG/5U93ZpF
        ANJTA6AtvDBGX0K5DvNUTvc=
X-Google-Smtp-Source: APXvYqzaVQBf3IXsI7JLj6D07ACzUJHgAZM4v7ZQ468ua/v/aKFN33LhEqF5ZfUVcV+aZxbqLbKL2w==
X-Received: by 2002:a19:5e41:: with SMTP id z1mr4176656lfi.101.1581266482285;
        Sun, 09 Feb 2020 08:41:22 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id g21sm4941826ljj.53.2020.02.09.08.41.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Feb 2020 08:41:21 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Laxman Dewangan <ldewangan@nvidia.com>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Cc:     dmaengine@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v8 06/19] dmaengine: tegra-apb: Use devm_platform_ioremap_resource
Date:   Sun,  9 Feb 2020 19:33:43 +0300
Message-Id: <20200209163356.6439-7-digetx@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200209163356.6439-1-digetx@gmail.com>
References: <20200209163356.6439-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Use devm_platform_ioremap_resource to keep code cleaner a tad.

Acked-by: Jon Hunter <jonathanh@nvidia.com>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/dma/tegra20-apb-dma.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/dma/tegra20-apb-dma.c b/drivers/dma/tegra20-apb-dma.c
index aafad50d075e..f44291207928 100644
--- a/drivers/dma/tegra20-apb-dma.c
+++ b/drivers/dma/tegra20-apb-dma.c
@@ -1402,8 +1402,7 @@ static int tegra_dma_probe(struct platform_device *pdev)
 	tdma->chip_data = cdata;
 	platform_set_drvdata(pdev, tdma);
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	tdma->base_addr = devm_ioremap_resource(&pdev->dev, res);
+	tdma->base_addr = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(tdma->base_addr))
 		return PTR_ERR(tdma->base_addr);
 
-- 
2.24.0

