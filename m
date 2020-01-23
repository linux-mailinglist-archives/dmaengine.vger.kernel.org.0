Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6C72D147464
	for <lists+dmaengine@lfdr.de>; Fri, 24 Jan 2020 00:12:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729814AbgAWXKv (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 23 Jan 2020 18:10:51 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41060 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727056AbgAWXKr (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 23 Jan 2020 18:10:47 -0500
Received: by mail-wr1-f66.google.com with SMTP id c9so5191616wrw.8;
        Thu, 23 Jan 2020 15:10:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NYonzf1fVhFYzmQTcZfQISC641wGqXMLHQ0dPIoSwuM=;
        b=Oqf0ZnX/iZprtRvdUHnQiYKr2Sn3z/ptVuYc2e+ppYNkcY6uJZHBLsDhnaNPEu7qOg
         0Nvw1SipU2s2A6LeBbIGooyUO1A8b44Yo+XWaewzj/8br788qbWU+mV4R6YcBQZ0q3C8
         IQQTDcuC1lfxuLbj6eM3snrlWxe7wqxl+6T4ZYJK0KmcBqwd8RDfm4OF2GGXYlWDP5dV
         5x/DHrdpSVCsWCjbkKw0bkdEmQ4d116rkMExhyXWfwMBoEKsbd5+c+Aw4XnJiH9LxET7
         q4kUFrYHRoh2CnxOTzBqAziCa1dTYesDvR8Gs8OfeA3GaktmXoZYmEpAzH2JvVp2AReW
         5BZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NYonzf1fVhFYzmQTcZfQISC641wGqXMLHQ0dPIoSwuM=;
        b=VcLQ6MkdiY+dRpIC8YXGE4goOWEPHDa5TlVK+/W/Cz0fHA9AF+ubfDaOEHknOFf6zI
         Z4Iaw/M+6OBTMphUBVBJ/+i0+LwAEtuA8uaVhuYFwXLh7MlfJbQULJSDx+fQqaibDLQk
         hhRDfnXSYy39zxPxXjz8kqNVnBylz4HZ1r9d2qSx2nrSV50kyrQ4bCAV48uo/bu3+TUp
         e3bNXMqsRgbqZjd8b4Y8Nxlp53K6PY6ZhzahypHf9ES3Rf2GQikzS0YI4aUUUjU3wYUF
         MKxwN2AglS3xvIpfcZ1WgH8mP72H5ye7j5MhaK6os3xwmbQRJ8r4vOxt9RJV766DdOzw
         Qrig==
X-Gm-Message-State: APjAAAUrMPP/+MMZcKE89C7gdcLiX3isLDiLf9Nt1pBE0L2CimhyRPvD
        S+Yi9khLBAGVE+gd1gtTnBQ=
X-Google-Smtp-Source: APXvYqzZfJtEoHCBkiLOC/3Ocg2DIdl+0cHXXkkc9L72w0gZNMoRTCjaTe/CTiML8ObFj2GkKt+3eg==
X-Received: by 2002:a5d:4984:: with SMTP id r4mr425619wrq.137.1579821045825;
        Thu, 23 Jan 2020 15:10:45 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id z6sm5105552wrw.36.2020.01.23.15.10.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2020 15:10:45 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Laxman Dewangan <ldewangan@nvidia.com>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Cc:     dmaengine@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 02/14] dmaengine: tegra-apb: Implement synchronization hook
Date:   Fri, 24 Jan 2020 02:03:13 +0300
Message-Id: <20200123230325.3037-3-digetx@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200123230325.3037-1-digetx@gmail.com>
References: <20200123230325.3037-1-digetx@gmail.com>
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

