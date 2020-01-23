Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8485E14745E
	for <lists+dmaengine@lfdr.de>; Fri, 24 Jan 2020 00:10:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729851AbgAWXKy (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 23 Jan 2020 18:10:54 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38751 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729832AbgAWXKx (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 23 Jan 2020 18:10:53 -0500
Received: by mail-wm1-f67.google.com with SMTP id u2so4378355wmc.3;
        Thu, 23 Jan 2020 15:10:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yfyyd1gAYNfQRVTzzie9M6MUShefAhN4x9LLDsJ6WIA=;
        b=UCi4fZRLcbqile5G4o/rFtRlD8ClrFQ8PF4vqF7UxQX9U7vjLamt7iOy+t3F+s++K5
         HliSdFTLSKE5FlvCaUVZqlWmbmWwEqWesJ1yl/u0AZYECSRZ0z5axMpJgqMBJDFePahb
         wXviyyVM52EQ3Q3vR6JJfoQOITws5hhTdY6WBk/sQjBeWYgPdnZw1umMKzhgrhNP1oID
         TWJkw5mTnx9p+VEl3Msxcfsk2Wr5AxNPECvDRJnlfkAobiSED8B/voDu/JB0Ws2IiWUa
         GTx/2n7R480e0djF2YlniHS4EIhSwS971PWP583sPLCYoGUxdjGy1eF4k3/T9vMNMi9D
         rK1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yfyyd1gAYNfQRVTzzie9M6MUShefAhN4x9LLDsJ6WIA=;
        b=mGbH2O6qUNnsDDXK34dGIvL5jeqTsCFxCSvZC0F/FaJE35YAZ8CnpwoA40TXs4J8og
         EPrwPtrDDzbEQZFlc59FmHUTSeTqw/n+SkAEWNCNZsb/J3bI74RSJbkFZfkjHu9rbeA2
         cYNcateMpSdIvTLw80mIC9lGwS43gLV4Fosu+wfTgMAF9SkP535YfI3RJnsRfQ84w3n1
         S45yeJ3ILhWoKyXfvhkDfSrWh4r0YRXx0pH8AlSWiojmIcYL1xZnlRjlN/0KIVKBBvVp
         kisL8R7F+dt0ZgepUPCuYjJCFCzDltby+pKFPZpVEOjxb6nvPmtqWgJdB3YcabXRU+Bg
         nN0A==
X-Gm-Message-State: APjAAAU8vedMdJyM83URDqWvSdKKVwLAdXOduz858f4yCte+8whRsVdJ
        DIdbDXTB5oZRIGIvOuHjGBk=
X-Google-Smtp-Source: APXvYqxzc6H8NU+QZbJENgrjXzzQpow3NCyqdR7u5em2HGyrsj7YC4vee4S2r3ywh6b23zkqmOV20g==
X-Received: by 2002:a05:600c:228f:: with SMTP id 15mr296725wmf.56.1579821051168;
        Thu, 23 Jan 2020 15:10:51 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id z6sm5105552wrw.36.2020.01.23.15.10.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2020 15:10:50 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Laxman Dewangan <ldewangan@nvidia.com>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Cc:     dmaengine@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 06/14] dmaengine: tegra-apb: Use devm_platform_ioremap_resource
Date:   Fri, 24 Jan 2020 02:03:17 +0300
Message-Id: <20200123230325.3037-7-digetx@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200123230325.3037-1-digetx@gmail.com>
References: <20200123230325.3037-1-digetx@gmail.com>
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

