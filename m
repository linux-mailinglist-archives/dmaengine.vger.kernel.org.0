Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3E8FB130B6A
	for <lists+dmaengine@lfdr.de>; Mon,  6 Jan 2020 02:18:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727412AbgAFBSA (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 5 Jan 2020 20:18:00 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:35067 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727366AbgAFBR3 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 5 Jan 2020 20:17:29 -0500
Received: by mail-lj1-f196.google.com with SMTP id j1so41895564lja.2;
        Sun, 05 Jan 2020 17:17:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KfuSooXOkxJU0/VsQZ2ZGbsgKKy+nQ25m7jbl5DejHM=;
        b=A348d47vqgmZE3QZHZNr4VYjBQsBxNT0Y7L/VpR06H89JD0HnMzIy5yX9i0EB/L+R8
         pHFicXl6bs8pyz5mpLHxhFllxz9uXFaNiJAoSqhU67SBBiiFGQ/z+uQjYXNt73HCL3WE
         Z8FBOVoDhpCCnjKjp9Xh1WoTVqdP0c8xzjZz1MMmMF0KT/hVMDRAtwD/xfsfPgrvizEx
         Ytce26+8/m0xDMkDyfgvGWSDUhq8rHnKo+LN+5a7zbLVIsplaBMKmGZGZ2wyeRSlb5tA
         G221IFlTD6MIBARal1blCJUskAkRryzA03lj0FNCU8p+Ln88qjlzqQ4YjMEHcgpnT2GA
         iksw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KfuSooXOkxJU0/VsQZ2ZGbsgKKy+nQ25m7jbl5DejHM=;
        b=Z2o2fFs22AlzoUDtU2CRTStEc/8KsBtVO1rF5g6ljlvvCzabB4nfX8bhCGm99fqMT3
         9xfF8BU027kacagj5zSUta/0kkrtsz6+s+wiVdfKharOgTewFpNdXHbzQMubudl7247k
         hxGeJ5/Za/N0692O7X8fyokQR6OiFknEjyF7T5zAyWjShHksUKmYrC5HBYho7Tnc/Jby
         jhng6qXx6WEeXhcT2jr1LZvaxQBlCmEhUKNY4syHNXHne84YPbxdo4aiU6W4wRmhQdga
         nZwBfFuee0+igQpCTWjdip7nPpwvEsS413HvbPgM0+JL5ceFFersqkucn3Ds69LVyWFC
         o1nw==
X-Gm-Message-State: APjAAAWmOObvyZR+DuI3AnWreHWWSEVE3AwUcVRKvJJb144JwXWHh9xu
        CME7ku65RRTtUjJW1CcyQY0=
X-Google-Smtp-Source: APXvYqyyxu9GfbDaxxQeEVxeLNvnxScrVjEMec1ZPASAPBAeaxevmI9ojILCm7DUqenwk+cJ6Zzoag==
X-Received: by 2002:a2e:b0db:: with SMTP id g27mr60026564ljl.74.1578273446766;
        Sun, 05 Jan 2020 17:17:26 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id y14sm28353271ljk.46.2020.01.05.17.17.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jan 2020 17:17:26 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Laxman Dewangan <ldewangan@nvidia.com>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Cc:     dmaengine@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 06/13] dmaengine: tegra-apb: Use devm_platform_ioremap_resource
Date:   Mon,  6 Jan 2020 04:17:01 +0300
Message-Id: <20200106011708.7463-7-digetx@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200106011708.7463-1-digetx@gmail.com>
References: <20200106011708.7463-1-digetx@gmail.com>
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

