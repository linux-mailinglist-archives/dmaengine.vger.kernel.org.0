Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E255138760
	for <lists+dmaengine@lfdr.de>; Sun, 12 Jan 2020 18:31:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733141AbgALRbe (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 12 Jan 2020 12:31:34 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:45374 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733115AbgALRbd (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 12 Jan 2020 12:31:33 -0500
Received: by mail-lj1-f194.google.com with SMTP id j26so7423670ljc.12;
        Sun, 12 Jan 2020 09:31:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iSzNtTGK3mbZvFsWdibdEoWrg4nzIZ5PMxmWTFl+mGA=;
        b=VLhpT+xtSOOwihhyK3NBL7PpJlC5RGYW6+AL19VuiQzXByT/1ufPIS8D/RH7vouOJW
         B298S+32ed8q7d4kG+fgtBv7U4ULiNaN9G5vjHGZAUm9faPwgGecPJYTkVPLg0V48yHh
         jJo0Pgq3O0+v8i9gSah+8whTlahMvTWCDVJcva2nN0hd+n53T2hjgE96LH3Vwt8H2kXr
         wiDztZLS3j3q8UfpIiWshX7/MzNGYgiYKAoz+9CeP95bJ82DqyixnG45O80Rqfm16Fkc
         yiQR8AJOzrY+/zG/iwPBAV2yycuQD25y8vwBaTPnYfnL/wi7DToyAEnHG95YHbR5CfBH
         XbeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iSzNtTGK3mbZvFsWdibdEoWrg4nzIZ5PMxmWTFl+mGA=;
        b=NATfVFjN/R8qocyqJpXzD/jY18Tu3/3mkz2mW2JDM74PrYgxMKG5QaXIPdB+PWyVvX
         csv1j+MDfkXoBC2ukwLElNtMN6WMauL7VYl1lxAziJt+fOaSXTT4bU/I2XAPwFzsQnOe
         x5iUz39nV/y5I/srxUyOjlnGr5DeTssKxPTUZunt4RzLoQZOVSfIHd+49gD6s7wlvRWX
         2/ivnP6txAuDaEnPIuETfSB1tjqYkawPiVIIBh2mAzUMCcys0OeRWFMk+oRhmayF+GXI
         mEcc3AiDKzSphHIXXD4S2stJ4w1F6kzP7+EFFgjHkGU0NVoV5wMlVR3ru9kIL5O/FCBe
         NugA==
X-Gm-Message-State: APjAAAVsztuLjtlRBo19kZYrLVyKndf+QYopr/lsLSYCj/sFgLSjZGz9
        dkxeTVWHcYbPNGEhDUSQd1I=
X-Google-Smtp-Source: APXvYqz69GLc2KT2ts1nF62Z5SiaR2QrLqQYyJCJ1+hOSA3Q6Mtq/x1Mut6cnygLHSPhmXAuRcuSYA==
X-Received: by 2002:a05:651c:32b:: with SMTP id b11mr8585302ljp.203.1578850290755;
        Sun, 12 Jan 2020 09:31:30 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id 140sm4458888lfk.78.2020.01.12.09.31.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jan 2020 09:31:30 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Laxman Dewangan <ldewangan@nvidia.com>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Cc:     dmaengine@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 02/14] dmaengine: tegra-apb: Implement synchronization callback
Date:   Sun, 12 Jan 2020 20:29:54 +0300
Message-Id: <20200112173006.29863-3-digetx@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200112173006.29863-1-digetx@gmail.com>
References: <20200112173006.29863-1-digetx@gmail.com>
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

