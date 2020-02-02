Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 29EE514FFA1
	for <lists+dmaengine@lfdr.de>; Sun,  2 Feb 2020 23:30:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727223AbgBBWaI (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 2 Feb 2020 17:30:08 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:34391 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727262AbgBBWaH (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 2 Feb 2020 17:30:07 -0500
Received: by mail-lj1-f194.google.com with SMTP id x7so12652689ljc.1;
        Sun, 02 Feb 2020 14:30:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fGq+XEJOzs9YbjxSchy3T1osXwV6uIluvBu6lsOH6XI=;
        b=A14PE8CZFI9+v8L/CKRfc7l2yQzvFnqMH8SPk4w/cli0yUcEQSso3qokwECaQXlHJV
         OepFgvPT2xkUoUb7S/h1rmACEGhZDxbTQ7Trzuhk8fKtb+F/rpW35V6j4fMzYsgLEtm1
         YslJ2Lg4SR4JrNIU28cPcO8fzEQ7mJ4WpKtjJhfjBL6U9RxKd5YkhPojY1VmBJBbZpPb
         D/yO3d+ITN7TlO2ZzTqd9WU+S2mURn/YHDRnEi31ah5Xx2rMbE5GeXT912BqOi3boW+6
         32zHe3kyQbT5HGXVv+HFQEkDvtCESp7bMl4c1UPE3nQjigUpham3GydNXA9lcG5DV+nW
         FQRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fGq+XEJOzs9YbjxSchy3T1osXwV6uIluvBu6lsOH6XI=;
        b=rGLXFwd/EXAFVRLTfdk4dRcahyG15uVFnMkRTgX0YNsJCQVRq4ewLgQ4Gjvx8NhA3b
         8gf//0jxEBhZOdbWDXmAGL5LGEcjsbeaTdCp9Tw3HH930PdISRSXV2sCARXCAGIopoeH
         WBMVmZpcty4ZKASrAZZtuQ5EMJbO/+sSl4Z8yDxHB2KCBk9JJSpXU6O4C0PAP5QBgYqx
         TZCG6Gps0RhFSFFrl09vCwaRpPZt25CsJ7vBJV29XiR+p7/xYu0aSLu2gUp+BE2PMmj7
         5fGfym2hgwn188sBCBBAaQ2VmZ554ZlDfu9sJ4473zofXMl82lnCk2PU4UKH9KUqAelg
         uMVw==
X-Gm-Message-State: APjAAAVjZAN23xd/zwERvk1Vo2SjCGtXrEQSwdpqu7l+m+UTaVUbu38v
        +YdM5CdolFDPgTZ/52xnKJaNgCEx
X-Google-Smtp-Source: APXvYqw5dlwhIO2GVGTpC7E84M5RyYxkbSo8Ok2ECinJVQ2BYB9aoh7+DjILkvuoPEEHlPWOwrUnCA==
X-Received: by 2002:a05:651c:299:: with SMTP id b25mr12497917ljo.1.1580682605655;
        Sun, 02 Feb 2020 14:30:05 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id b190sm8050307lfd.39.2020.02.02.14.30.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Feb 2020 14:30:05 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Laxman Dewangan <ldewangan@nvidia.com>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Cc:     dmaengine@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v7 18/19] dmaengine: tegra-apb: Remove MODULE_ALIAS
Date:   Mon,  3 Feb 2020 01:28:53 +0300
Message-Id: <20200202222854.18409-19-digetx@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200202222854.18409-1-digetx@gmail.com>
References: <20200202222854.18409-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Tegra APB DMA driver is an Open Firmware driver, so it uses OF alias
naming scheme which overrides MODULE_ALIAS, meaning that MODULE_ALIAS
does nothing and could be removed safely.

Acked-by: Jon Hunter <jonathanh@nvidia.com>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/dma/tegra20-apb-dma.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/dma/tegra20-apb-dma.c b/drivers/dma/tegra20-apb-dma.c
index 7e9ec945d6bd..05d0da8d2490 100644
--- a/drivers/dma/tegra20-apb-dma.c
+++ b/drivers/dma/tegra20-apb-dma.c
@@ -1669,7 +1669,6 @@ static struct platform_driver tegra_dmac_driver = {
 
 module_platform_driver(tegra_dmac_driver);
 
-MODULE_ALIAS("platform:tegra20-apbdma");
 MODULE_DESCRIPTION("NVIDIA Tegra APB DMA Controller driver");
 MODULE_AUTHOR("Laxman Dewangan <ldewangan@nvidia.com>");
 MODULE_LICENSE("GPL v2");
-- 
2.24.0

