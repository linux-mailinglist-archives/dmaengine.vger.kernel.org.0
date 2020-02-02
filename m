Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2FEEC14FFCF
	for <lists+dmaengine@lfdr.de>; Sun,  2 Feb 2020 23:31:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727034AbgBBWbA (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 2 Feb 2020 17:31:00 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:33007 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726995AbgBBW3x (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 2 Feb 2020 17:29:53 -0500
Received: by mail-lf1-f66.google.com with SMTP id n25so8399837lfl.0;
        Sun, 02 Feb 2020 14:29:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7zuEhMyyRsm4yoSSRhgi3ZRMmTyTt2unt4jqJAWf7Xs=;
        b=Vjd2LIBnzhFjM8DunE+XTSL68He5AzXn78FifJB55OI2tTDmg7ap6leEdDLBF1VVmm
         SNW4P4IbbJOyDp1UtXz2xRNiGuI2EI5eYnzLFYyTQYSiB4TsYKWLXPpfwXX2hQtwAILF
         1OTbtD30AhPmM+xnnuaX+8UTQZwn4KPOsOapRfKEFbsBy48VFaZ0zAkCFFMP+S/jIO6H
         A+ohdLGQuE0qPuf/s6esc7PjrlEgJmF1cpA6h8l3kLw1rVgTvc2iOFkg23cd3J1k1bod
         iAawRjDe0BIOk6E3W3oca60MBN5pCeV0wuCcnHxA4doy3HuwSa3e4oRBDC0nBFziVsNn
         A8QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7zuEhMyyRsm4yoSSRhgi3ZRMmTyTt2unt4jqJAWf7Xs=;
        b=Lk8wACfIfaRbptz1w5zItqnV/VpUTLGWuVU4PhBk8ePvZde0OpYWUxCyGRHcTDI8vQ
         lOE8tmfMXABWcWeJ1ecHVQ/ebK/GlSRxBKPTNYe0nfBwy2KTrp0BYQn9CnV8CDud+h/7
         CpoF5NIGRWfI9klwVgYxzA6Sk0VuHVo1gX39IUli5jHrNLRuBZEHVS/YdSjI1FbSTA+P
         p4dqpwSkehNiVxeUwadf2pUMTSD0dmPTxLg4DddndwJroS/7QOCK1472LDD9QB9or+c3
         dxyc++DuzDqZ+oBvDfyRSUKjbkCAxTCnNwNqLoMydcNnjoa5hFEZMxUvAQVpIIluCwXM
         o+Fg==
X-Gm-Message-State: APjAAAXz10GzVz8AcOWETtGIUOl1kZh/7z2k4o1YHZMWvkRemvvflJ4K
        UK2Pw0kA5A25Hg93VoJjBJk=
X-Google-Smtp-Source: APXvYqxXRg7x6L0yFByVVBf6PfucuRpLsn5tbc9KuzPll93JKq4R/8CEoN9yn8OQQ45zWIRQXkZbJQ==
X-Received: by 2002:a05:6512:1cc:: with SMTP id f12mr10749904lfp.128.1580682591273;
        Sun, 02 Feb 2020 14:29:51 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id b190sm8050307lfd.39.2020.02.02.14.29.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Feb 2020 14:29:50 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Laxman Dewangan <ldewangan@nvidia.com>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Cc:     dmaengine@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v7 03/19] dmaengine: tegra-apb: Implement synchronization hook
Date:   Mon,  3 Feb 2020 01:28:38 +0300
Message-Id: <20200202222854.18409-4-digetx@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200202222854.18409-1-digetx@gmail.com>
References: <20200202222854.18409-1-digetx@gmail.com>
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

