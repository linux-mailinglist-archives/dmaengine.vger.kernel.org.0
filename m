Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7A05E12C302
	for <lists+dmaengine@lfdr.de>; Sun, 29 Dec 2019 15:57:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726901AbfL2O5c (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 29 Dec 2019 09:57:32 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:35406 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726410AbfL2O4t (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 29 Dec 2019 09:56:49 -0500
Received: by mail-lf1-f68.google.com with SMTP id 15so23756270lfr.2;
        Sun, 29 Dec 2019 06:56:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iSzNtTGK3mbZvFsWdibdEoWrg4nzIZ5PMxmWTFl+mGA=;
        b=MwKNQosH9a8b+Mk8QNMzF8LOvWNFAxJSTi2TjwDnWeUXRQjSYIuEFpt21T2Jl3A8Wo
         ayjDSJRJHwb45xzBLrk67GQZBMh0dAHmJejTD7q6x3YtUN4z1+qE8VvCpckWW0FnUzLM
         dWM8FVd0XQ5flXmeJzqU4ZNQqvAV2pYl7mE+lKl+QzHwMSsahC69lt2Y6+RsLp4VT5CG
         2bd9jH7iO3lI7CByboWpVdYJlpg6/Gp1wDDW/1Iib+rZ5KUeMvPbWWxyVxxCjNy+JEVV
         eAzPkw2xRpDxrAn3rBv0dMOdQVledqx+9HLGEs0udGZIhQWVXEvetvu1CWHXet2JUpbN
         MsGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iSzNtTGK3mbZvFsWdibdEoWrg4nzIZ5PMxmWTFl+mGA=;
        b=ogNGhBKWViPf8n16Wsl5k28PU1pqnDNsXN6/cTIVSUPLHNl5IdZX+c/bPBUb5rRoIt
         Sj8csAA4DfryO7BJtmLRXJ98SwISWVhITFE0pcWfK6sDLTdTmTL9UCHB/8WvBnV+QMS0
         /+F6Jy0JCPSHSWaYmUyRRv2FAI2PdsG4qH4aEqGS2NvP2W1joRM1zyCe0bNjnHb9OCfE
         Au2Q/kGIlbsbOH0cCfW7hjqMzl4ehPhd9ymSM1loLOA7pXLVhkKktCvIgKYTaOA9AQfx
         1HQwvHwA7rA2/4X4d46c/r3f2NmWjSbJ57SKJvVWN7yH3Opm1msvECjbXby1u2NLGiSc
         PNKA==
X-Gm-Message-State: APjAAAUp0rk0bM0ji9uITIbqwJnaMLqpApfzCFdsfHtHOc0xK4XP9Xm8
        1zIt9t17BUAa2APALB7nE4o=
X-Google-Smtp-Source: APXvYqz30BXETtkX0XrGReewQVqwNpDpi1baurkjEb5pjwHevSIKLqRrMEsSyNOnHaqreFESGJGhmw==
X-Received: by 2002:a19:3f16:: with SMTP id m22mr33866388lfa.116.1577631406140;
        Sun, 29 Dec 2019 06:56:46 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id g15sm11563944ljl.10.2019.12.29.06.56.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Dec 2019 06:56:45 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Laxman Dewangan <ldewangan@nvidia.com>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     dmaengine@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 02/12] dmaengine: tegra-apb: Implement synchronization callback
Date:   Sun, 29 Dec 2019 17:55:15 +0300
Message-Id: <20191229145525.533-3-digetx@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191229145525.533-1-digetx@gmail.com>
References: <20191229145525.533-1-digetx@gmail.com>
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

