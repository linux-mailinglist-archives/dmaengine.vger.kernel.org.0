Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52F5A2E742F
	for <lists+dmaengine@lfdr.de>; Tue, 29 Dec 2020 22:22:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726531AbgL2VSy (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 29 Dec 2020 16:18:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726111AbgL2VSx (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 29 Dec 2020 16:18:53 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94766C061799;
        Tue, 29 Dec 2020 13:17:40 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id cw27so13758790edb.5;
        Tue, 29 Dec 2020 13:17:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mLPCpKzf6krEKXWFnGnqJyJkJYqgpzn8TIaRHOKPMPk=;
        b=K1NVOWfsKfOq7Ox9bF8q3/lZ6t7PwWj/6A0kXDc5UjjN+GfdlL4850kuS0g+M8bQIf
         XII09UTQGQSMM1EUTlakNaduMOxCUg6Kkk0NAIOE+duyxo2KnpDOx+cOkZbajkMMWDbb
         BM8LHRS+ciuPlB2SEVwNlYC0T+m5befwUcHllS9pXA8zLiEUFN1CVOtxhKLH6zxQM5Y/
         GLJ19/HZp9SWseyeuBHBjNjW/+qb0obzHboLi6vtGQcT4bYeWyYcVqzPb0mi9C1JWfap
         CV7Fau3CxDSVgNK7ISqQro3D/e1YQSpKupHkrOZA/aHNslsYdlvJC4RgWjYhiq0PsISC
         k3Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mLPCpKzf6krEKXWFnGnqJyJkJYqgpzn8TIaRHOKPMPk=;
        b=CpEfRpIAeCDhoVeIAQgt2cZQ7EdrBgsvvmgG5O1ylyUCe7B57yu1zJrbgQT+/NBWbz
         Inq6yY50uO7egOQXn7cZ1wpx06uEqAQ0kUVgmmNCM0OyPBPkID1M5MQcIviyaLuTKiGv
         mRqa22PQGemsmiuXnX1mfV+q8hUKTopJVRasBIzI9tnn+pBqKPQXbTBPFElGZ0D9gvwL
         Kv1CCTi+CxThE1pPrXzGMjUAvobTZv1L+Ebj7gVgwAGCs47QAAiVjGOckd4am0ey2Tli
         k1uykdoxqNsPMQSpVfR48MD/0vVQNR3n2L1KHyARjvD5Yl+YpICxCzsE7q7YVR/QAr4u
         dWlA==
X-Gm-Message-State: AOAM5321Fq1vguskWA+7J4CLPOjnaV7eUs+6fYy8pbzi5wUuzzW91n7e
        +PvdUuy5OZnVNHzfZgMHYk7biVjKANqOog==
X-Google-Smtp-Source: ABdhPJxDcTTJuXRywjL9UEnsigwT+47XYuRR8/naVMrTuf36EECH7WD7h2FHskUVqslsyGWZJBfBUg==
X-Received: by 2002:a05:6402:307c:: with SMTP id bs28mr48357265edb.186.1609276659354;
        Tue, 29 Dec 2020 13:17:39 -0800 (PST)
Received: from localhost.localdomain ([188.24.159.61])
        by smtp.gmail.com with ESMTPSA id u9sm37354553edd.54.2020.12.29.13.17.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Dec 2020 13:17:38 -0800 (PST)
From:   Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
To:     Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 05/13] dmaengine: owl: Add compatible for the Actions Semi S500 DMA controller
Date:   Tue, 29 Dec 2020 23:17:20 +0200
Message-Id: <88dc9dc064fd4c71f7ad46f172b05b09b9777e42.1609263738.git.cristian.ciocaltea@gmail.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <cover.1609263738.git.cristian.ciocaltea@gmail.com>
References: <cover.1609263738.git.cristian.ciocaltea@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The DMA controller present on the Actions Semi S500 SoC is compatible
with the S900 variant, so add it to the list of devices supported by
the Actions Semi Owl DMA driver. Additionally, order the entries
alphabetically.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
Changes in v3:
 - Added Reviewed-by from Mani
 - Ordered the entries to be consistent with the related dt-bindings

 drivers/dma/owl-dma.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/owl-dma.c b/drivers/dma/owl-dma.c
index 9fede32641e9..25cbd363e513 100644
--- a/drivers/dma/owl-dma.c
+++ b/drivers/dma/owl-dma.c
@@ -1080,8 +1080,9 @@ static struct dma_chan *owl_dma_of_xlate(struct of_phandle_args *dma_spec,
 }
 
 static const struct of_device_id owl_dma_match[] = {
-	{ .compatible = "actions,s900-dma", .data = (void *)S900_DMA,},
+	{ .compatible = "actions,s500-dma", .data = (void *)S900_DMA,},
 	{ .compatible = "actions,s700-dma", .data = (void *)S700_DMA,},
+	{ .compatible = "actions,s900-dma", .data = (void *)S900_DMA,},
 	{ /* sentinel */ },
 };
 MODULE_DEVICE_TABLE(of, owl_dma_match);
-- 
2.30.0

