Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 08AE112C2E2
	for <lists+dmaengine@lfdr.de>; Sun, 29 Dec 2019 15:56:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726728AbfL2O4v (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 29 Dec 2019 09:56:51 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:39210 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726697AbfL2O4v (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 29 Dec 2019 09:56:51 -0500
Received: by mail-lf1-f66.google.com with SMTP id y1so23724794lfb.6;
        Sun, 29 Dec 2019 06:56:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iZ3D39bl0eyByo7/hfV3v45VBZOWa7JfxNIxRNpu/N8=;
        b=V9nzhDUEHYRzIMZLQpcT/ET/k73thPfjad2SMWF88muli4C4cuLBL3sEcjLslMmqId
         YWM6FeyNFB14fOGeSD71i+FEO8YFGqQRpyJYdgBDp2x3F6Z7hy9iH/Fs6G7EFKYq6gcV
         yQYSqdFsBkYMLjMLo4vyfTv2WA88I3eOz9EgsaVe63BBnKL1nRo9fZsfW0yJaftzacjA
         s9TTfdKzqtnSXbdfbAF6CSlzIKHPuTTq94837kGsx7qlxIMH0S5Lo00K9M6UQxUSaDFp
         FSV8PM3c2Hun5sp6eyUlehz3MWTIxf1CXvmnEedknU6LF2W2PTy/SERRcD/uqVJnzy8x
         Oq7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iZ3D39bl0eyByo7/hfV3v45VBZOWa7JfxNIxRNpu/N8=;
        b=VAoTECoqMyG1xu0e+JH/LbnRzY/s6F4baEFECCJAXqMQxEbRzN6YTaLIv5sSj545E/
         NKQIBCzupkUl6QNNGiBwph18Q/irunUjZ3zGUz39nceMAGdGftfca5SRE2/vQNlkUJJr
         LoISkK17Q3OAanH04qm96PStVkq/8uajaQuf2LDpFBmkldOL0brNqOc3Isz1t/cB0j+2
         cyyBGgzpcpPGoS1Be6H/8hDMjExCXpCJy3RZLpAqs01EJoyOz6lxBDDGeF3QOI29fKHB
         S8pT7NU0N0VvCdm0LUmq0uc5gao5aschfDZ2x9fyIWslE0RerNfXqtD1jcLLSdFTZrYF
         m+UA==
X-Gm-Message-State: APjAAAW6WoySlj6bAX5qX96kYEMCmSkkMXwkY5vtTimHs2s6JRnqcrCF
        uJFTBuTZ1ygdBJhoO2sZqN0=
X-Google-Smtp-Source: APXvYqx4G/2EtcPQ7a9zW4nyYeoMXyNyVZmXuXWR1cHoB3TnWtoFqgpg8U56hEycM5nIHhecRE0JHw==
X-Received: by 2002:ac2:5c4b:: with SMTP id s11mr34678154lfp.133.1577631408873;
        Sun, 29 Dec 2019 06:56:48 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id g15sm11563944ljl.10.2019.12.29.06.56.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Dec 2019 06:56:48 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Laxman Dewangan <ldewangan@nvidia.com>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     dmaengine@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 05/12] dmaengine: tegra-apb: Use devm_platform_ioremap_resource
Date:   Sun, 29 Dec 2019 17:55:18 +0300
Message-Id: <20191229145525.533-6-digetx@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191229145525.533-1-digetx@gmail.com>
References: <20191229145525.533-1-digetx@gmail.com>
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

