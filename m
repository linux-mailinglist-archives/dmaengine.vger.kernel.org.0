Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3D2DC14FFB7
	for <lists+dmaengine@lfdr.de>; Sun,  2 Feb 2020 23:30:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727053AbgBBWaY (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 2 Feb 2020 17:30:24 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:42789 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727253AbgBBWaG (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 2 Feb 2020 17:30:06 -0500
Received: by mail-lf1-f66.google.com with SMTP id y19so8347822lfl.9;
        Sun, 02 Feb 2020 14:30:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nSFyw0+Q9kQMhBeT0mTZWHihPYKhlfkGWd5c5D4FidI=;
        b=bs/V1bh/r7waOP6HPAIy+zkn07Bc5o4lS8lSrMXAGu3HAPDMpKF446aeTPwjuBcJZr
         YvbpXiHPJyJ2wgeyK9HunlA1pJBqSy4orYouLXOZ1dOX5EXpvRnsX5MXLlitTMhqG/pA
         ppHwB+X0bw6c2iiOohA15VM0jAJyEWIWwaVFaJCo6Jbw+heRILMrBIprVHf3sjN6EDKI
         R22CDY7p1QpuCtSVS5As8I8cfUSZ3aF2+0VTs0/VB9iew/VTJd//4Qe/y84X1ETPF1YU
         gTID9RnO4by8zRyhzf+UukPYOwqy2z+OOfmt/Gxj3TUMnwH5I/ruxY4nRylg2RaKO/KY
         7TAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nSFyw0+Q9kQMhBeT0mTZWHihPYKhlfkGWd5c5D4FidI=;
        b=VGNzCSWnQpQeiGNLgsFcEcFIlqR1BrNRRfNTLod+dfYD0m+WK4iaaSDKLvsvr4wAeA
         PEwpFsXKzhmAcj8w9QCzfGEuUC458l2OUWszEpIit9m+vkPz810TCq/1LLXM3tlsfApk
         0M0mzR08n3q+yKwP6s+Mp685TwuvAWtXa3vBbJh4Juk3xrLDRQ2/CADjKIOQcBfHZl1j
         bQheetwFp0+TrJXp8uQcxsvppoI/1ApYvK6cke1smmVoKF5e3JnHW/YSLzwuDgqhADN7
         QqVgNe3rQDLvVbxpYKbI1FRb65noAHBPErxL5B+Tnvc83KcEvEPsjQyxFDTClFurm2z2
         rQGQ==
X-Gm-Message-State: APjAAAXfkf5rCoW9LwyNK5ttczz9teulNKAa4lw9OUZeMg4hR226klwf
        YtnwaCG33WiIS854G56k3Z8=
X-Google-Smtp-Source: APXvYqzAXBfBsH4fqqGMuQI+N3eaCGo+Q0Z3F/jZKku4J44A1uia85AEW4atm4H39pS06B+zBTPlaQ==
X-Received: by 2002:ac2:5444:: with SMTP id d4mr10121642lfn.49.1580682603720;
        Sun, 02 Feb 2020 14:30:03 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id b190sm8050307lfd.39.2020.02.02.14.30.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Feb 2020 14:30:03 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Laxman Dewangan <ldewangan@nvidia.com>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Cc:     dmaengine@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v7 16/19] dmaengine: tegra-apb: Add missing of_dma_controller_free
Date:   Mon,  3 Feb 2020 01:28:51 +0300
Message-Id: <20200202222854.18409-17-digetx@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200202222854.18409-1-digetx@gmail.com>
References: <20200202222854.18409-1-digetx@gmail.com>
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
index db726e635048..7e9ec945d6bd 100644
--- a/drivers/dma/tegra20-apb-dma.c
+++ b/drivers/dma/tegra20-apb-dma.c
@@ -1572,6 +1572,7 @@ static int tegra_dma_remove(struct platform_device *pdev)
 {
 	struct tegra_dma *tdma = platform_get_drvdata(pdev);
 
+	of_dma_controller_free(pdev->dev.of_node);
 	dma_async_device_unregister(&tdma->dma_dev);
 	pm_runtime_disable(&pdev->dev);
 	clk_unprepare(tdma->dma_clk);
-- 
2.24.0

