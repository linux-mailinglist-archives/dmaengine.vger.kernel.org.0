Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E91B79E5B9
	for <lists+dmaengine@lfdr.de>; Wed, 13 Sep 2023 13:05:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239845AbjIMLFn (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 13 Sep 2023 07:05:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231235AbjIMLFm (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 13 Sep 2023 07:05:42 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 406091726
        for <dmaengine@vger.kernel.org>; Wed, 13 Sep 2023 04:05:38 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-31f8a05aa24so4475439f8f.1
        for <dmaengine@vger.kernel.org>; Wed, 13 Sep 2023 04:05:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694603137; x=1695207937; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6omJwKG04MRfh8ce/W0vROun1mNmIJkUPIR7eVcYNSk=;
        b=QIPNS+W/MYtLStKhXnqRyxb1PpP4+YNbhU1WrBgLFwdgrjK1lcFfPI0OlvX4NbsmKH
         9vD+gSjbHw1ACwulsfBCBYGaqaV1sBfgP2QPL6wLvQVfHd2uclhFv0OC/jwVJGCyscb3
         /6+Fkbk5Td6AHLKaLKC1O6E7L4CxZawBQNHm4hi55dYe28MCCWG33NT3rPTTzuYj7Ojw
         nzM02KtrjZnoDh7PFItdGGxabvXnArFqSjE00VbIYX8TOxQO8Jq0PpMsiQAPdt1fCadV
         EuYjmBdER32lfm3dGDBXUEHH8pMaNuVg3h1CoGjWkTzxikJARMaMeSMQpaqj2J9dt0v4
         RcBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694603137; x=1695207937;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6omJwKG04MRfh8ce/W0vROun1mNmIJkUPIR7eVcYNSk=;
        b=gV2cs4Rj3S9TvrGXQXnjsOUvHIV114DynTaegvtutD+X5d7IUBzEXpbmOpEBqlmjKW
         ysUV4UuWQlIZ+PYcF0ww7NNQGczAB2aqrYRRNVnWsoPv3m2EQkeZk/HoVlQlRJlRpMWt
         kenCchLozXZcC3oiWaYy60BFANn0RLyYUm72jA8xNiCdsR6OdjX3P4K/i7jszY1h0xwa
         ksWHM5rHrHs6ZAcXMlm1BuOmFrtp4xlbtQVoDNvornLXbQHBbd6bGoT58l6uHy4Z+s+T
         52z/XiUbA/L5t6qOsC6VsQIF+YgN4u7qHpfoTqjx8zfdNnn4Ym7qmab7F6qWHzMlRLrI
         5ipg==
X-Gm-Message-State: AOJu0YxLJx+aNfc4nXkhEpN0gCKWDWWXYaZDVmunhKbbowPHaPBaFP+f
        0kdNfrgEtiFvAtlCeqdAMeKY2A==
X-Google-Smtp-Source: AGHT+IEXvw963JsTDPOanZN+SIxlqgxub+SzbJ+C4Vg1fs62eMeNpEmmVYLL7ktk7xZJxPAuBOOtow==
X-Received: by 2002:adf:fdca:0:b0:31f:9a0d:167f with SMTP id i10-20020adffdca000000b0031f9a0d167fmr1619996wrs.50.1694603136700;
        Wed, 13 Sep 2023 04:05:36 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id 12-20020a05600c024c00b003fc06169ab3sm1716067wmj.20.2023.09.13.04.05.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Sep 2023 04:05:36 -0700 (PDT)
Date:   Wed, 13 Sep 2023 14:05:31 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Vignesh Raghavendra <vigneshr@ti.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>
Cc:     Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        Vinod Koul <vkoul@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Siddharth Vadapalli <s-vadapalli@ti.com>,
        Roger Quadros <rogerq@kernel.org>,
        MD Danish Anwar <danishanwar@ti.com>,
        Andrew Lunn <andrew@lunn.ch>, dmaengine@vger.kernel.org,
        netdev@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH net] dmaengine: ti: k3-udma-glue: fix
 k3_udma_glue_tx_get_irq() error checking
Message-ID: <5b29881f-a11a-4230-a044-a60871d3d38c@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The problem is that xudma_pktdma_tflow_get_irq() returns zero on error
and k3_ringacc_get_ring_irq_num() returns negatives.  This complicates
the error handling.  Change it to always return negative errors.

Both callers have other bugs as well.  The am65_cpsw_nuss_init_tx_chns()
function doesn't preserve the error code but instead returns success.
In prueth_init_tx_chns() there is a signedness bug since "tx_chn->irq"
is unsigned so negative errors are not handled correctly.

Fixes: 93a76530316a ("net: ethernet: ti: introduce am65x/j721e gigabit eth subsystem driver")
Fixes: 5b65781d06ea ("dmaengine: ti: k3-udma-glue: Add support for K3 PKTDMA")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
The k3_udma_glue_tx_get_irq() function is in dmaengine, but this bug
affects networking so I think the fix should go through networking.

 drivers/dma/ti/k3-udma-glue.c                | 3 +++
 drivers/net/ethernet/ti/am65-cpsw-nuss.c     | 3 ++-
 drivers/net/ethernet/ti/icssg/icssg_prueth.c | 6 +++---
 3 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/ti/k3-udma-glue.c b/drivers/dma/ti/k3-udma-glue.c
index 789193ed0386..c278d5facf7d 100644
--- a/drivers/dma/ti/k3-udma-glue.c
+++ b/drivers/dma/ti/k3-udma-glue.c
@@ -558,6 +558,9 @@ int k3_udma_glue_tx_get_irq(struct k3_udma_glue_tx_channel *tx_chn)
 		tx_chn->virq = k3_ringacc_get_ring_irq_num(tx_chn->ringtxcq);
 	}
 
+	if (!tx_chn->virq)
+		return -ENXIO;
+
 	return tx_chn->virq;
 }
 EXPORT_SYMBOL_GPL(k3_udma_glue_tx_get_irq);
diff --git a/drivers/net/ethernet/ti/am65-cpsw-nuss.c b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
index bea6fc0f324c..24120605502f 100644
--- a/drivers/net/ethernet/ti/am65-cpsw-nuss.c
+++ b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
@@ -1747,9 +1747,10 @@ static int am65_cpsw_nuss_init_tx_chns(struct am65_cpsw_common *common)
 		}
 
 		tx_chn->irq = k3_udma_glue_tx_get_irq(tx_chn->tx_chn);
-		if (tx_chn->irq <= 0) {
+		if (tx_chn->irq < 0) {
 			dev_err(dev, "Failed to get tx dma irq %d\n",
 				tx_chn->irq);
+			ret = tx_chn->irq;
 			goto err;
 		}
 
diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.c b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
index 47b941fb0198..98b061a3f3c1 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_prueth.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
@@ -316,12 +316,12 @@ static int prueth_init_tx_chns(struct prueth_emac *emac)
 			goto fail;
 		}
 
-		tx_chn->irq = k3_udma_glue_tx_get_irq(tx_chn->tx_chn);
-		if (tx_chn->irq <= 0) {
-			ret = -EINVAL;
+		ret = k3_udma_glue_tx_get_irq(tx_chn->tx_chn);
+		if (ret < 0) {
 			netdev_err(ndev, "failed to get tx irq\n");
 			goto fail;
 		}
+		tx_chn->irq = ret;
 
 		snprintf(tx_chn->name, sizeof(tx_chn->name), "%s-tx%d",
 			 dev_name(dev), tx_chn->id);
-- 
2.39.2

