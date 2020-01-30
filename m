Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E480414D5D5
	for <lists+dmaengine@lfdr.de>; Thu, 30 Jan 2020 05:42:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727491AbgA3EmI (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 29 Jan 2020 23:42:08 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46588 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727197AbgA3ElS (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 29 Jan 2020 23:41:18 -0500
Received: by mail-wr1-f65.google.com with SMTP id z7so2254827wrl.13;
        Wed, 29 Jan 2020 20:41:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7zuEhMyyRsm4yoSSRhgi3ZRMmTyTt2unt4jqJAWf7Xs=;
        b=B2c/Ugo+DRiMGk3cKoKTYMqrXcMrfVSh3UTDS/ez+tkY4e9VZlTlSuUTOV6NxSfCYq
         CBSOUyBmBQoqASPil3wV1MEwBEaRj0PLX96wtgiBjXPJa5hnGk/TTwjGZ6K93hw6oeog
         6a135e8h77UNH5adHCyZXSxt7n9F3dryIV3X80VbW/Iy3KlgSpxwL8lEs5at8Jujy2PE
         QqhAff2CSTemIR4+UH2O1LA1JriWZKQmmvy+D3EEvULBUlA/6gEgWmQDwLcFVpAyVnuc
         TuzCZ+jToLRwGFzbNzzl13xvZelKpIdOTLaM3VpwCGWinqL9OJmr5IvGDEYMQCy3suBl
         Ybig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7zuEhMyyRsm4yoSSRhgi3ZRMmTyTt2unt4jqJAWf7Xs=;
        b=pPo/2Xog9s9r3h9fJih+KW7JV3hfH2f4tN3Lp0/6Qd0zyYAAbf8sJvzPxcI1Sjmzdn
         Rz+UTFWnT/2x1ShjLurntKeQfick6oDXdwCmXA0R1yk85bTftISZXGfbnev3ZUBL1tGf
         JCJxIvKqVS2cJ+FeJN5JGMs2ov5ykbX36QQhfEn/Iy1CbBCME4Lcd8mn/cVCh0yPtgiM
         wBDkT75e72urRPxsb2aRpqc8uNGbVkGuMMvTT6EU5AaKwQ5UgxhI164mjEUkgOEtFUeU
         XPq2j0ATAumujEboJC/RIzFCIJunuRBI3atreKlX8CaDhJADjkfA6+FiGMb8TagjC6FJ
         lLOA==
X-Gm-Message-State: APjAAAWzVryLY2XWFzLiFwhRoExOAwIHCj7mEFyIqzQ9+0JWmo7hBcxw
        kEYSAn4adTTOwYx1ZbueJdc=
X-Google-Smtp-Source: APXvYqxJVtFj6BEtsaa/q40dObnw70RgJf5pBvSQ8KDFK3zdappqFCeL0A9zw04nEAZLY6fC8rh0iQ==
X-Received: by 2002:adf:81c2:: with SMTP id 60mr2737199wra.8.1580359274628;
        Wed, 29 Jan 2020 20:41:14 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id g128sm4494672wme.47.2020.01.29.20.41.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jan 2020 20:41:14 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Laxman Dewangan <ldewangan@nvidia.com>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Cc:     dmaengine@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 03/16] dmaengine: tegra-apb: Implement synchronization hook
Date:   Thu, 30 Jan 2020 07:37:51 +0300
Message-Id: <20200130043804.32243-4-digetx@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200130043804.32243-1-digetx@gmail.com>
References: <20200130043804.32243-1-digetx@gmail.com>
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

