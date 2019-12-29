Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 98F5012C2FE
	for <lists+dmaengine@lfdr.de>; Sun, 29 Dec 2019 15:57:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727005AbfL2O5Y (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 29 Dec 2019 09:57:24 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:42777 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726667AbfL2O4t (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 29 Dec 2019 09:56:49 -0500
Received: by mail-lj1-f196.google.com with SMTP id y4so16745956ljj.9;
        Sun, 29 Dec 2019 06:56:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fLPm8kYY1aMbkcJ/I/yZlSuw3yqow+z5kIYMGPZJf+g=;
        b=N468EFQYmzTBqfBQ/MQb5nqJRl41XCor99VIBGQNl/RGUocG1zG9x8SFHqEyQihfBz
         kgh09LplbUjWoPsq8BOAJIbq3gk1IyE+ckMiyRxgVm+KYy7cwQHWm+2kLbzvq6qFBh49
         w3Phlw7QG0BYvZsWrutVH52xq1PEZ0XIkttcbIl4o6a0JiIk53MXMJm6RCgqzVPoUW0r
         tRbcVSgbJuMR08HzVXWGkROvFhkZhPdNSLokGR00azzYgsP7An1+FTtzaoRY3Osh8RRf
         BU/R4KSnWl0pFSIiEVCuTpE7mgTjQkhuZvJb62wGBNixh864xVdE/eqoku+QJ32fOxln
         X/EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fLPm8kYY1aMbkcJ/I/yZlSuw3yqow+z5kIYMGPZJf+g=;
        b=HfrDLTeq9xj23cFIWiN6/Pr6ljgDeVUSCLnk67l3mSIRE5KmOZN1xWwCbGczt9Drt8
         ppFaltNOv8P70k7FputlsCMnoySgmkJ/7vl4L6guPHaoRwKHHu3gw6bXb+RUp57JvqIm
         jRRmXSlTa/Z9ImtrOu8YyH7gBHjlYcOD8A1CHBwgC993SsZi9THCchTGTdfkrPscaWf2
         YAZr4mmcmN3gwGqVD7NQFDBmk5nCBtsuz/ptRJ235gwOcgfq52Fbmock5Eas20rc9vEJ
         E43tyZmVePC1oLnmhjaTHWQbNwsgcoP+qTrdi+Goqgns7xIt9FQVKHmEwtjh3pz4CL6b
         1zzQ==
X-Gm-Message-State: APjAAAWGj2//w0ofey5DYlFR12HL2XWLvYT+KQVro9V8y3fVuZ++/HsH
        K5glxwm+dDTlXN3bohxiKRo=
X-Google-Smtp-Source: APXvYqxk59W/NMB4acxBqQ54lf+yLgcVlD9J+Ly905f8fzEEcpGMYSfrMRaJ8bOM3Mda8nVG24aQYw==
X-Received: by 2002:a05:651c:1110:: with SMTP id d16mr35569724ljo.86.1577631407157;
        Sun, 29 Dec 2019 06:56:47 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id g15sm11563944ljl.10.2019.12.29.06.56.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Dec 2019 06:56:46 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Laxman Dewangan <ldewangan@nvidia.com>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     dmaengine@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 03/12] dmaengine: tegra-apb: Prevent race conditions on channel's freeing
Date:   Sun, 29 Dec 2019 17:55:16 +0300
Message-Id: <20191229145525.533-4-digetx@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191229145525.533-1-digetx@gmail.com>
References: <20191229145525.533-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

It's unsafe to check the channel's "busy" state without taking a lock,
it is also unsafe to assume that tasklet isn't in-fly.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/dma/tegra20-apb-dma.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/tegra20-apb-dma.c b/drivers/dma/tegra20-apb-dma.c
index 664e9c5df3ba..28aff0b9763e 100644
--- a/drivers/dma/tegra20-apb-dma.c
+++ b/drivers/dma/tegra20-apb-dma.c
@@ -1294,8 +1294,8 @@ static void tegra_dma_free_chan_resources(struct dma_chan *dc)
 
 	dev_dbg(tdc2dev(tdc), "Freeing channel %d\n", tdc->id);
 
-	if (tdc->busy)
-		tegra_dma_terminate_all(dc);
+	tegra_dma_terminate_all(dc);
+	tasklet_kill(&tdc->tasklet);
 
 	spin_lock_irqsave(&tdc->lock, flags);
 	list_splice_init(&tdc->pending_sg_req, &sg_req_list);
@@ -1543,7 +1543,6 @@ static int tegra_dma_probe(struct platform_device *pdev)
 		struct tegra_dma_channel *tdc = &tdma->channels[i];
 
 		free_irq(tdc->irq, tdc);
-		tasklet_kill(&tdc->tasklet);
 	}
 
 	pm_runtime_disable(&pdev->dev);
@@ -1563,7 +1562,6 @@ static int tegra_dma_remove(struct platform_device *pdev)
 	for (i = 0; i < tdma->chip_data->nr_channels; ++i) {
 		tdc = &tdma->channels[i];
 		free_irq(tdc->irq, tdc);
-		tasklet_kill(&tdc->tasklet);
 	}
 
 	pm_runtime_disable(&pdev->dev);
-- 
2.24.0

