Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 49B7B12C2E9
	for <lists+dmaengine@lfdr.de>; Sun, 29 Dec 2019 15:57:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726853AbfL2O45 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 29 Dec 2019 09:56:57 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:45088 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726810AbfL2O4z (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 29 Dec 2019 09:56:55 -0500
Received: by mail-lj1-f195.google.com with SMTP id j26so31074315ljc.12;
        Sun, 29 Dec 2019 06:56:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1J1J5BlDcbKt3phhdzz1XyASZlV2076cdy7BI1+jtrk=;
        b=KPSZblQ42+QWm0d0aYXkE8Tgtl+9RH5F4q3rFGkx/65UzwXT8IDPpVr9/xTZMdozRr
         AD9Ww59AJclaQplycQPoDEtK8/Oamcifgb6MnJCrMPMInnU0y+d7UyUhuJheJr20+hSs
         6+QFAtwg9tViNullL4Sl3yDZUtXdlPpjSlPk1/IKE24nrfkd6ma1WyNt+1OPH94HEftL
         CiF8+iCWwYIlS0QZ03FiXXbUgz0TEFnR4bUOD4gaWcbuazl8gAT6cBvuRQodee4i9C8Q
         43M43W86ADWeboyyZo4qFtPw+TKZlmMSvelP6o4gNwmV5dFpWrrA11qKGkHmNQPN6Ru4
         Z6aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1J1J5BlDcbKt3phhdzz1XyASZlV2076cdy7BI1+jtrk=;
        b=mSy3I0aatS+/1L/OUE4NK24KmVEiXV2Ejg7e4HR5cBvURSog/3eJjSXc3/AG5CFObA
         ihPo6dH5NpkuiZc8Y00UwhvQOUqj+RioJzfeGswduh8VGME+6aTcaGBpNLYdizRR43MX
         B2Ufx0He250NyFg8sqr5/UIiG/vVUxKNtibEAYVS4/38w+CS+upI22ygBPkGhK8jtNHm
         3Lh4tR3vOSFNQPqRPEypc4NDRGjGzUjO9Gb7+zyI7/H0Om8U25jSUV4v66rCxvuRggu8
         YSU4hzrfAgkkLuteh77ittoMtiTHDR/FMgSOgoEKk/n92cZ5DJOE2wTZU3RKojQF7vwe
         tttQ==
X-Gm-Message-State: APjAAAUn4uAz+pCiLJH9IvQxXUYA2AXgJL77iqHIv42Y7NBn4puOeCX6
        QESYdMuHeoRZIe8/44KKY3rYhC8K
X-Google-Smtp-Source: APXvYqzVuZfFQq5oKKos6aCevZ4Oufp5wWuyW2XPB/bhYT1oU7fZuHEyR6qSbC0SJMqzyCZdLTvJRw==
X-Received: by 2002:a2e:810d:: with SMTP id d13mr35134869ljg.113.1577631413448;
        Sun, 29 Dec 2019 06:56:53 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id g15sm11563944ljl.10.2019.12.29.06.56.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Dec 2019 06:56:53 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Laxman Dewangan <ldewangan@nvidia.com>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     dmaengine@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 10/12] dmaengine: tegra-apb: Add missing of_dma_controller_free
Date:   Sun, 29 Dec 2019 17:55:23 +0300
Message-Id: <20191229145525.533-11-digetx@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191229145525.533-1-digetx@gmail.com>
References: <20191229145525.533-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The DMA controller shall be released on driver's removal.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/dma/tegra20-apb-dma.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/dma/tegra20-apb-dma.c b/drivers/dma/tegra20-apb-dma.c
index ad54a55e2f24..d96de35c8253 100644
--- a/drivers/dma/tegra20-apb-dma.c
+++ b/drivers/dma/tegra20-apb-dma.c
@@ -1559,6 +1559,7 @@ static int tegra_dma_remove(struct platform_device *pdev)
 {
 	struct tegra_dma *tdma = platform_get_drvdata(pdev);
 
+	of_dma_controller_free(pdev->dev.of_node);
 	dma_async_device_unregister(&tdma->dma_dev);
 	tegra_dma_deinit_hw(tdma);
 
-- 
2.24.0

