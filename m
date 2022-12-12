Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E137649D15
	for <lists+dmaengine@lfdr.de>; Mon, 12 Dec 2022 12:07:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232116AbiLLLHy (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 12 Dec 2022 06:07:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232125AbiLLLHH (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 12 Dec 2022 06:07:07 -0500
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0477511A13;
        Mon, 12 Dec 2022 02:54:38 -0800 (PST)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 2BCAsXdv019175;
        Mon, 12 Dec 2022 04:54:33 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1670842473;
        bh=w2Ue5WDDYL9x4Hgu6bdWROqq/0qU9t4BO6DzYi2Kw+M=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=F0GvFmQVnjEj7ZWLTiacNHBo25YSFbnUh5cP9YgfwsG8X227jiOafcZ0khSs7swVO
         UkL99binAoPsosKeP0ddpahSW13mc0SaHcZ7jXKFWMzkyZcZVZcJUNelKT/izAsVWY
         JVVemYm2g0tVamTEoyKpJc5kZLVdDaoYE19k0bFU=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 2BCAsXoV099829
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 12 Dec 2022 04:54:33 -0600
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Mon, 12
 Dec 2022 04:54:33 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Mon, 12 Dec 2022 04:54:33 -0600
Received: from uda0132425.dhcp.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 2BCAsJVK035634;
        Mon, 12 Dec 2022 04:54:31 -0600
From:   Vignesh Raghavendra <vigneshr@ti.com>
To:     Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     <dmaengine@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v2 4/5] dmaengine: ti: k3-udma: Add support for DMAs on AM62A SoC
Date:   Mon, 12 Dec 2022 16:24:15 +0530
Message-ID: <20221212105416.3628442-5-vigneshr@ti.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221212105416.3628442-1-vigneshr@ti.com>
References: <20221212105416.3628442-1-vigneshr@ti.com>
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

AM62A SoC has a BCDMA and PKTDMA as systems DMAs for service various
peripherals similar to AM64 SoC. Add support for the same.

Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
---
 drivers/dma/ti/k3-udma.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
index aa50d46fa856..c1005d17b42e 100644
--- a/drivers/dma/ti/k3-udma.c
+++ b/drivers/dma/ti/k3-udma.c
@@ -4386,6 +4386,7 @@ static const struct soc_device_attribute k3_soc_devices[] = {
 	{ .family = "AM64X", .data = &am64_soc_data },
 	{ .family = "J721S2", .data = &j721e_soc_data},
 	{ .family = "AM62X", .data = &am64_soc_data },
+	{ .family = "AM62AX", .data = &am64_soc_data },
 	{ /* sentinel */ }
 };
 
-- 
2.38.1

