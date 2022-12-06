Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA3FD643C62
	for <lists+dmaengine@lfdr.de>; Tue,  6 Dec 2022 05:36:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233470AbiLFEg3 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 5 Dec 2022 23:36:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232841AbiLFEgS (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 5 Dec 2022 23:36:18 -0500
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFD7515FF3;
        Mon,  5 Dec 2022 20:36:16 -0800 (PST)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 2B64a7FN084421;
        Mon, 5 Dec 2022 22:36:07 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1670301367;
        bh=k9emjr+Dl6s21oRvc/gyITAsl5kkv/Qh5rJAI+QMseM=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=wrCgGlDEjVC2asfXK7qnOQ1ZMbADWnc+J69Zzt27Vgxpq6GynT9CQnsPqQvyXT6SC
         lPpm2LO3aG69gsvjHyzu0LqQDOWNplIStP/hFlTB3qT6nSbnZ7Njx6PDwJFlSO84n6
         IVjOySUf9Yobebv9zO+BFJeuBVk2cJfU9Xr6O7B8=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 2B64a7Op001588
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 5 Dec 2022 22:36:07 -0600
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Mon, 5
 Dec 2022 22:36:07 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Mon, 5 Dec 2022 22:36:07 -0600
Received: from uda0132425.dhcp.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 2B64Zx2a097382;
        Mon, 5 Dec 2022 22:36:05 -0600
From:   Vignesh Raghavendra <vigneshr@ti.com>
To:     Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     <dmaengine@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>
Subject: [PATCH 2/5] dmaengine: ti: k3-udma: Fix BCDMA for case w/o BCHAN
Date:   Tue, 6 Dec 2022 10:05:51 +0530
Message-ID: <20221206043554.1521522-3-vigneshr@ti.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221206043554.1521522-1-vigneshr@ti.com>
References: <20221206043554.1521522-1-vigneshr@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Reusing loop iterator fails if BCHAN is not present as iterator is
uninitialized

Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
---
 drivers/dma/ti/k3-udma.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
index ce8b80bb34d7..791cf6354946 100644
--- a/drivers/dma/ti/k3-udma.c
+++ b/drivers/dma/ti/k3-udma.c
@@ -4758,6 +4758,7 @@ static int bcdma_setup_resources(struct udma_dev *ud)
 		}
 	}
 
+	i = 0;
 	irq_res.desc = kcalloc(irq_res.sets, sizeof(*irq_res.desc), GFP_KERNEL);
 	if (!irq_res.desc)
 		return -ENOMEM;
-- 
2.38.1

