Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C4D7412BF2C
	for <lists+dmaengine@lfdr.de>; Sat, 28 Dec 2019 21:47:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726923AbfL1Urh (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 28 Dec 2019 15:47:37 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:40975 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726730AbfL1Urg (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 28 Dec 2019 15:47:36 -0500
Received: by mail-lj1-f193.google.com with SMTP id h23so29878263ljc.8;
        Sat, 28 Dec 2019 12:47:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iSzNtTGK3mbZvFsWdibdEoWrg4nzIZ5PMxmWTFl+mGA=;
        b=aQobqtgc9qfZlmPXk8UOStRSUkmmwPp8tOLqOok9CH5lvlEgAIEA6eORSie2AELROd
         HpZWkaKM8qTqLFx6lN+8Ij4xCBeZp+pR3SP1NaM06AJM5CKr10Aro7t99IJCAA8qH4xO
         zfovOiDdoosbldJP+MWdO4bC0DpsfhEs0NR6J+Ot+iWbe67zJpmcnp/3tjcNogYxA7lI
         ZMT8Bq4qH8zhhHLg0PVQNyMAkHlkg3XO+cthBkTKL/nWZOloWzwIxIARoXFuyt90DPQZ
         B42FfiHiHvfVqCOBtuqcoH6ss2TuBJUJTyG6nAaOmm3IlC4+YQ0VNpuTADLQUXA+VZvK
         s06w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iSzNtTGK3mbZvFsWdibdEoWrg4nzIZ5PMxmWTFl+mGA=;
        b=oHKWgS7hdDLpEG3M7O0kch1hqAw/ApYc31eqN6w2jv7GpFSutz7Lq5E6KEkrHhMB/F
         m1m63JqISHmlx1n80uiPUXgTsus/VGS32sTBsHjrryGOpPZV1IDQuiLrqbwd/6F0Ktke
         U47WUlu/Ozfb1TVeVR9TexrxzL0NV7bFYIrQ0RXUwxfT4V4QfAZKRrxYMTi+gfs75fP7
         DuMCY5oNUG0LVECr/htJ1f+Qhhe4ZlkGzioy00zhqa2o3ZLeHBTbqUKU94l+ef5Iso1N
         Bp8YD915wOpKyxImAm0wPe+ujyD1QAKf6k0HZ/qeM8wZ9ZMOZ4OqXNslFDVm4iH7yZ+r
         xdTA==
X-Gm-Message-State: APjAAAWw2elLqVI1ejbk/+dKMtGY9UQb574dNiLj14YxIcLj7bTeMTZB
        qzlScz3S5jLFcp629nNZSqM=
X-Google-Smtp-Source: APXvYqwvTuwFfA5xYeX0IUUhu0tlpFP6dPmn2gLahtb441Lto3fi3ieam7nB8EGvQhtKtttZEpQeCw==
X-Received: by 2002:a2e:8954:: with SMTP id b20mr16119033ljk.27.1577566053945;
        Sat, 28 Dec 2019 12:47:33 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id g15sm10571219ljl.10.2019.12.28.12.47.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Dec 2019 12:47:33 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Laxman Dewangan <ldewangan@nvidia.com>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     dmaengine@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 2/7] dmaengine: tegra-apb: Implement synchronization callback
Date:   Sat, 28 Dec 2019 23:46:35 +0300
Message-Id: <20191228204640.25163-3-digetx@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191228204640.25163-1-digetx@gmail.com>
References: <20191228204640.25163-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The ISR tasklet could be kept scheduled after DMA transfer termination,
let's add synchronization callback which blocks until tasklet is finished.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/dma/tegra20-apb-dma.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/dma/tegra20-apb-dma.c b/drivers/dma/tegra20-apb-dma.c
index 319f31d27014..664e9c5df3ba 100644
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

