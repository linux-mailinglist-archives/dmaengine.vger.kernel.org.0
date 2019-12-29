Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CACFE12C2E8
	for <lists+dmaengine@lfdr.de>; Sun, 29 Dec 2019 15:57:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726810AbfL2O5A (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 29 Dec 2019 09:57:00 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:44976 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726845AbfL2O45 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 29 Dec 2019 09:56:57 -0500
Received: by mail-lf1-f68.google.com with SMTP id v201so23708258lfa.11;
        Sun, 29 Dec 2019 06:56:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=d61xLjjxWbxI5eV1Fujn9jWtoC4pEzqs0yuJAlEPGQA=;
        b=etWVTJZaT3p8VPlVN8QeSiQ46gN7rtZ/ANKmqtVpbKPlKyXl/+ZAvJm2HSxQMBs2zu
         3Ufe5/SgD0LCr2UrtEmHCJmngmiNwek2rJtOXOB2WQzzllZ/9kMkbMB5SQ/R9ea6xqOX
         OV3pHGxrAuRDPsF/zfTJVMWi4rEOhOIuYhVIqcgI/s3LuZMO3F61IID8O935GxBK3ex1
         xVESRfgJNtuoVNyVzLqJxxRgSqD8kSQy9a9BWxOB+hNiyzVL5fi7yPSTtgez1p/2KnzE
         lTgTsmJOsceoub4xCrlD5/tvCaeRhr7b138p/IUYrUx1P2UyVLccGmy/ZlbU10TttJQ7
         ljMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=d61xLjjxWbxI5eV1Fujn9jWtoC4pEzqs0yuJAlEPGQA=;
        b=Wt1jgXbRDv74hioZyoX2MK64mxdzSzSIfrKiNvX6BJGU5DN/j9Cl1KRlakLXMD3WWm
         A1kOs27WjFt8eV8g1mY3u037jhcreR19iXfBRHYqgJzbwGui5L8Pha7sBsYto3PuVsJu
         bSpTm0OuOKOUu/bFKJotlvcwcny0dMFir2eRJALeckryA5bBcfE//i4DlmPoryBdmPmt
         N1xPy0yIj8N7mRpngKbaKRaE+Efe8bd+vr6RqNNAC75E1uEfnJPePhjwhFU/bYtLsXIF
         lEFbeE3MbAUHhk84UxmgULOoj1ORH0RLIt7Y2aDYttyiJEHkpG+gS71xwFJt4cpUiZ2e
         0Pcw==
X-Gm-Message-State: APjAAAW/WNp9FRnXgVU1Drvm5aOi5Or9NtXcppORTRmdAWouzZZhheiO
        g2S2XlBa/k3ZJtPoDblQZb8=
X-Google-Smtp-Source: APXvYqz6IXklzOjO/CUbhhhRC452FVyyPClstVpWvjv0naGRCdnjLM2OpgK3B6pFVOGuCBbvWCBoLA==
X-Received: by 2002:ac2:4add:: with SMTP id m29mr34356272lfp.190.1577631415131;
        Sun, 29 Dec 2019 06:56:55 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id g15sm11563944ljl.10.2019.12.29.06.56.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Dec 2019 06:56:54 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Laxman Dewangan <ldewangan@nvidia.com>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     dmaengine@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 12/12] dmaengine: tegra-apb: Remove MODULE_ALIAS
Date:   Sun, 29 Dec 2019 17:55:25 +0300
Message-Id: <20191229145525.533-13-digetx@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191229145525.533-1-digetx@gmail.com>
References: <20191229145525.533-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Tegra APB DMA driver is an Open Firmware driver and thus it uses OF alias
naming scheme which overrides MODULE_ALIAS, meaning that MODULE_ALIAS does
nothing and could be removed safely.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/dma/tegra20-apb-dma.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/dma/tegra20-apb-dma.c b/drivers/dma/tegra20-apb-dma.c
index d96de35c8253..2eae3b3cdc58 100644
--- a/drivers/dma/tegra20-apb-dma.c
+++ b/drivers/dma/tegra20-apb-dma.c
@@ -1633,7 +1633,6 @@ static struct platform_driver tegra_dmac_driver = {
 
 module_platform_driver(tegra_dmac_driver);
 
-MODULE_ALIAS("platform:tegra20-apbdma");
 MODULE_DESCRIPTION("NVIDIA Tegra APB DMA Controller driver");
 MODULE_AUTHOR("Laxman Dewangan <ldewangan@nvidia.com>");
 MODULE_LICENSE("GPL v2");
-- 
2.24.0

