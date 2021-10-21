Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32DEA4358E3
	for <lists+dmaengine@lfdr.de>; Thu, 21 Oct 2021 05:15:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230308AbhJUDRV (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 20 Oct 2021 23:17:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231232AbhJUDRC (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 20 Oct 2021 23:17:02 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90F34C061749;
        Wed, 20 Oct 2021 20:14:46 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id e10so12624205plh.8;
        Wed, 20 Oct 2021 20:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UNDTu9XddTRTWJ0ScwqIo4xay28kBK1wc0RPX4vRg7I=;
        b=gTAbxQcS4dXIzqg0O3WBCM/8Uoyh5SJVlzJtzYJmKnAP1SpZbaDHhbq7WPzQbnXiff
         KIsDMyO5vZUt2MqfN1D/depVuLaZJFHjnyIoOzst+YFOqU6a8Rux25fixCDDvUgI3aMX
         etm6ERXHQwhCuwROlaVKq6dktvgjplGQTl1ly3/QsvLfkFYQ6i9e2r8RJWEQY3k17syW
         giI/4cAnJOkh0q0s5/V9jv01xmzUx0Ud7o5ocHSwIjhaDSw0orvOyZKxSMus8ykfYSeK
         CL53S4PU1LK3eTPlsVXYr+LqRN1aSPuMqArQcH8btOydeiJJRWac2uymeSEPotek6bop
         szPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UNDTu9XddTRTWJ0ScwqIo4xay28kBK1wc0RPX4vRg7I=;
        b=Y9Lqwk7GNEpQOS6APeGzFDsXRm4kOqRXwk6XPDj706UsllG5dkK1X0R6gXgCLoymhC
         2/K7j4dhldXb58X92mTvM1reWZtq6st0meOKYiA6LMaT4OL2ISfut0qIblfz1+UiPoFs
         URuEMQd6qXShr4dVGOWxqyzcKyp3gnL0pa0wPl/uivzFSUi1N/F0U8oqdFEebrJXsa7b
         hyLmxdQhIK/QfBLHcfAe7MeYUCBQaqkcGuyVfVuugfsvsE4X4PsbSBKV2qgtKrxCWoir
         LClgAeV3mMFzIXQPMx5LTE2l0YkEki8jZqFwQD/HS3Vpgc7H4RUx0Gzk70Shd2gV4aDF
         e6zw==
X-Gm-Message-State: AOAM533bj2zw2TqiqyITZb03uN+vd/1/W3lI6XnQ+OtzeovbvbLQ0+4a
        xpRBvcwR5SbQDyTgytn2rmbatnQluxWXv1H8sZs=
X-Google-Smtp-Source: ABdhPJzxiZyHTbBj36UCXrSO4RRpSKlKnLXD5YxVqctHBbgoZ8qwxlgwQyWDbIF9ZQUP9Aab7O1Akw==
X-Received: by 2002:a17:90b:1d0d:: with SMTP id on13mr3425824pjb.118.1634786086001;
        Wed, 20 Oct 2021 20:14:46 -0700 (PDT)
Received: from localhost.localdomain ([94.177.118.132])
        by smtp.gmail.com with ESMTPSA id d19sm4098999pfl.129.2021.10.20.20.14.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Oct 2021 20:14:45 -0700 (PDT)
From:   Dongliang Mu <mudongliangabcd@gmail.com>
To:     Laxman Dewangan <ldewangan@nvidia.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        Vinod Koul <vkoul@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     Dongliang Mu <mudongliangabcd@gmail.com>,
        dmaengine@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] dmaengine: tegra210-adma: fix pm runtime unbalance in tegra_adma_remove
Date:   Thu, 21 Oct 2021 11:14:31 +0800
Message-Id: <20211021031432.3466261-1-mudongliangabcd@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Since pm_runtime_put is done when tegra_adma_probe is successful, we
cannot do pm_runtime_put_sync again in tegra_adma_remove.

Fix this by removing the pm_runtime_put_sync in tegra_adma_remove.

Signed-off-by: Dongliang Mu <mudongliangabcd@gmail.com>
---
 drivers/dma/tegra210-adma.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/dma/tegra210-adma.c b/drivers/dma/tegra210-adma.c
index b1115a6d1935..7e4d40cd9577 100644
--- a/drivers/dma/tegra210-adma.c
+++ b/drivers/dma/tegra210-adma.c
@@ -940,7 +940,6 @@ static int tegra_adma_remove(struct platform_device *pdev)
 	for (i = 0; i < tdma->nr_channels; ++i)
 		irq_dispose_mapping(tdma->channels[i].irq);
 
-	pm_runtime_put_sync(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
 
 	return 0;
-- 
2.25.1

