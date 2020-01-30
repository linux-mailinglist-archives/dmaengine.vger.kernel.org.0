Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 960E414D5B6
	for <lists+dmaengine@lfdr.de>; Thu, 30 Jan 2020 05:41:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727367AbgA3Ela (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 29 Jan 2020 23:41:30 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45032 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727354AbgA3Ela (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 29 Jan 2020 23:41:30 -0500
Received: by mail-wr1-f65.google.com with SMTP id m16so2280083wrx.11;
        Wed, 29 Jan 2020 20:41:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gfFOKKBycfoTA+tP8C+2g2g1I1HSJbXw7d1KRYGNlF8=;
        b=FsNKPTzOSYhTcJdP167/pyLqgktDgRCg/AjEABBjfBXmNTfKrDj0z/0u3yo9AN+Z7s
         wwyxVsO1nfoQxBdjAkwXhOsaLR0DD4mkLZcaALmYwHwFCulf5Jfx1kWPjXK5YkPfPRMp
         siWTmO3r/kvWD3NAP0jzONQ946JqA5TCc6gJfO1kHAHIu4B6Ra+VGFhHP3BT1M0JfhQR
         uSDovfQgYmXPSumhhBnTcdd2kDzNi7bT/4mdTydFQyA6eAlerVwJS2DBu9Pv00lkpglJ
         2FvF4tqmJfIBSWOZalg6HcXNqPIg8AjBno6Z4JiC61fxQc7czLDYtgt4HOblukE8eLLC
         sXNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gfFOKKBycfoTA+tP8C+2g2g1I1HSJbXw7d1KRYGNlF8=;
        b=kc32pgF1SjABjBYTmlC4vdFs/sX5j2aU5/zkYD/qt92f8PTOX6L+vrygP9YtURdSoy
         i3wh6shxoLI3jZe1j32u+BgGRkbnlwi156BAskz8+iqcwX5LhyaClwdkfqxHh6hEhOwA
         rawTPuXsq2Hjmz+WEvGYJkmZJkB7a4x+InrKEKz+e55NHOIgx1xQnTeqETQVjCdUFqpU
         0XgUv5APLWxo8LaAemdHzBsITdwZ7Wfx6WRInlwKOfN0fIyqgeV6wSMtaqZGJjzvVnn0
         w9LtCTGrAwhhfSFidW69/X6JD3QD6FiCLkMSJKc4L9fFjU9bA2hFLgyHqYAce/VqiSr1
         kiLw==
X-Gm-Message-State: APjAAAXCWZ2ywu8/Z3r2mWNtAVR+izE/U2NfXmyCzBqJM56FD2LUU76d
        fvIp4RiP4jTOojWZEUlvATE=
X-Google-Smtp-Source: APXvYqwUNseDyEBG4iaE2M+lLRu8bHphKJpv9wgXRxA8URzzmpif6FkJ23UjNnqXHjZRWRcjEI1ABw==
X-Received: by 2002:a5d:46c7:: with SMTP id g7mr2702825wrs.11.1580359286731;
        Wed, 29 Jan 2020 20:41:26 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id g128sm4494672wme.47.2020.01.29.20.41.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jan 2020 20:41:26 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Laxman Dewangan <ldewangan@nvidia.com>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Cc:     dmaengine@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 13/16] dmaengine: tegra-apb: Add missing of_dma_controller_free
Date:   Thu, 30 Jan 2020 07:38:01 +0300
Message-Id: <20200130043804.32243-14-digetx@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200130043804.32243-1-digetx@gmail.com>
References: <20200130043804.32243-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The DMA controller shall be released on driver's removal.

Acked-by: Jon Hunter <jonathanh@nvidia.com>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/dma/tegra20-apb-dma.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/dma/tegra20-apb-dma.c b/drivers/dma/tegra20-apb-dma.c
index 4a371891b7c4..8f4281ab6296 100644
--- a/drivers/dma/tegra20-apb-dma.c
+++ b/drivers/dma/tegra20-apb-dma.c
@@ -1587,6 +1587,7 @@ static int tegra_dma_remove(struct platform_device *pdev)
 {
 	struct tegra_dma *tdma = platform_get_drvdata(pdev);
 
+	of_dma_controller_free(pdev->dev.of_node);
 	dma_async_device_unregister(&tdma->dma_dev);
 	pm_runtime_disable(&pdev->dev);
 	clk_unprepare(tdma->dma_clk);
-- 
2.24.0

