Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 15AD2156B63
	for <lists+dmaengine@lfdr.de>; Sun,  9 Feb 2020 17:42:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727891AbgBIQlW (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 9 Feb 2020 11:41:22 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:33787 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727835AbgBIQlW (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 9 Feb 2020 11:41:22 -0500
Received: by mail-lj1-f193.google.com with SMTP id y6so4439287lji.0;
        Sun, 09 Feb 2020 08:41:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7zuEhMyyRsm4yoSSRhgi3ZRMmTyTt2unt4jqJAWf7Xs=;
        b=VnxvBuSvDi1n/j2v9GrClQa16cLsGvZFk5/vQVVDj0F/4rh2dyP/Ts7xIC7dNEhgAG
         9+NUuJNZo/i34inBxZcaQ1xNTQ8G5OEF0jiKrBpmVogqADjMCA/4WfrSDY847jwcmH6h
         5Hb5G4uPpD9tQKADJdo9scVYLqmmSWSkP4d2+H9Iq1JYtZ91I9P5gvGDUf4EurMZFeZq
         C4tW6JGEvCPFoNstKwQx6ZfBfw6iVkXXtq02TgwdxQtgJCC4V8y1hpJ1ozHBkHVaOB2W
         KW3B+VWVc0UQ6gCXeybVY1+n01Ka2sct+n003XrPrbBLkVH7h5UP2N1Boug1nncjcauu
         0O9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7zuEhMyyRsm4yoSSRhgi3ZRMmTyTt2unt4jqJAWf7Xs=;
        b=UNLk3tECIIzDUPMjNU5bOwYnLAN96kOahQ/HkcZ3ogEjAZ7GERtabFAE4D8CyqEflh
         skqaLodz68etLEZdExeu2ar5o878O2hcakScgmYWjrSQFeHZsBFFBl9azzokmnGza9bm
         YL/nTMQunivGrPzq16/Mizl13WZIgstJq8TFvQ7O+XZWvak1GygpDmeY6tM3Qzl3n76C
         L+ZuMRNL0oXvI3yOOhs9DZyKjAAoZfqbS0j6nOFYjcavpU+RRyhYMwLyNFW63t+OWUYD
         myCO9v21mfSk+Tfbrf4gqH2EdUBCXErgRF1vMINHJ/x3a0+riUsK1UOUopVNTMCCtpiU
         EN6g==
X-Gm-Message-State: APjAAAUH5NEcAcYkw6Zg0TUgGK73ligsJGCAwfOXt2iAR7kkwIENPZPs
        +CAiCg/osl10G86mMC4TyZo=
X-Google-Smtp-Source: APXvYqyFqIOQsToLRasR/8Pw2e8lTWolPtKdJlY3DB8msRvz4n8rDEGcCl84iwe7GsRaJiwkyZfvYg==
X-Received: by 2002:a05:651c:d4:: with SMTP id 20mr5392835ljr.269.1581266479436;
        Sun, 09 Feb 2020 08:41:19 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id g21sm4941826ljj.53.2020.02.09.08.41.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Feb 2020 08:41:19 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Laxman Dewangan <ldewangan@nvidia.com>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Cc:     dmaengine@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v8 03/19] dmaengine: tegra-apb: Implement synchronization hook
Date:   Sun,  9 Feb 2020 19:33:40 +0300
Message-Id: <20200209163356.6439-4-digetx@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200209163356.6439-1-digetx@gmail.com>
References: <20200209163356.6439-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The ISR tasklet could be kept scheduled after DMA transfer termination,
let's add synchronization hook which blocks until tasklet is finished.

Acked-by: Jon Hunter <jonathanh@nvidia.com>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/dma/tegra20-apb-dma.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/dma/tegra20-apb-dma.c b/drivers/dma/tegra20-apb-dma.c
index 4a750e29bfb5..f56881500a23 100644
--- a/drivers/dma/tegra20-apb-dma.c
+++ b/drivers/dma/tegra20-apb-dma.c
@@ -798,6 +798,13 @@ static int tegra_dma_terminate_all(struct dma_chan *dc)
 	return 0;
 }
 
+static void tegra_dma_synchronize(struct dma_chan *dc)
+{
+	struct tegra_dma_channel *tdc = to_tegra_dma_chan(dc);
+
+	tasklet_kill(&tdc->tasklet);
+}
+
 static unsigned int tegra_dma_sg_bytes_xferred(struct tegra_dma_channel *tdc,
 					       struct tegra_dma_sg_req *sg_req)
 {
@@ -1506,6 +1513,7 @@ static int tegra_dma_probe(struct platform_device *pdev)
 	tdma->dma_dev.residue_granularity = DMA_RESIDUE_GRANULARITY_BURST;
 	tdma->dma_dev.device_config = tegra_dma_slave_config;
 	tdma->dma_dev.device_terminate_all = tegra_dma_terminate_all;
+	tdma->dma_dev.device_synchronize = tegra_dma_synchronize;
 	tdma->dma_dev.device_tx_status = tegra_dma_tx_status;
 	tdma->dma_dev.device_issue_pending = tegra_dma_issue_pending;
 
-- 
2.24.0

