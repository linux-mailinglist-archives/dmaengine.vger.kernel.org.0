Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FCAE64BA02
	for <lists+dmaengine@lfdr.de>; Tue, 13 Dec 2022 17:43:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236206AbiLMQnd (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 13 Dec 2022 11:43:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236147AbiLMQn1 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 13 Dec 2022 11:43:27 -0500
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDF432BC4;
        Tue, 13 Dec 2022 08:43:25 -0800 (PST)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 2BDGhF4V042968;
        Tue, 13 Dec 2022 10:43:15 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1670949795;
        bh=5eBEqont1Hh66nEc8s7Ovin4BNz2G7HwxSF5/nTvwu8=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=LxfwkajrXiy7c2mhpHKiG7RS36PCiVkGpANNK9D52aAVhT7dGMy+Enjbhb+EhT+qB
         xgtm6b9S3PW4F7OhxURZDrm35KCm0fBuRSQ9lBQ99GRgkpvCtk7pX2CDjLf+WOW/E7
         wkKOZJVG6DOmaO/O1Y9ptUbfeJPlZeD+KC45m3uQ=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 2BDGhF0t112141
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 13 Dec 2022 10:43:15 -0600
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Tue, 13
 Dec 2022 10:43:15 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Tue, 13 Dec 2022 10:43:15 -0600
Received: from uda0132425.dhcp.ti.com (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 2BDGh6gK034997;
        Tue, 13 Dec 2022 10:43:12 -0600
From:   Vignesh Raghavendra <vigneshr@ti.com>
To:     Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     <dmaengine@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v3 2/5] dmaengine: ti: k3-udma: Fix BCDMA for case w/o BCHAN
Date:   Tue, 13 Dec 2022 22:13:01 +0530
Message-ID: <20221213164304.1126945-3-vigneshr@ti.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221213164304.1126945-1-vigneshr@ti.com>
References: <20221213164304.1126945-1-vigneshr@ti.com>
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
 drivers/dma/ti/k3-udma.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
index ce8b80bb34d7..aa50d46fa856 100644
--- a/drivers/dma/ti/k3-udma.c
+++ b/drivers/dma/ti/k3-udma.c
@@ -4774,7 +4774,10 @@ static int bcdma_setup_resources(struct udma_dev *ud)
 				irq_res.desc[i].num = rm_res->desc[i].num;
 			}
 		}
+	} else {
+		i = 0;
 	}
+
 	if (ud->tchan_cnt) {
 		rm_res = tisci_rm->rm_ranges[RM_RANGE_TCHAN];
 		if (IS_ERR(rm_res)) {
-- 
2.38.1

