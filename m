Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B81F64BA04
	for <lists+dmaengine@lfdr.de>; Tue, 13 Dec 2022 17:43:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236211AbiLMQne (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 13 Dec 2022 11:43:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236190AbiLMQn1 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 13 Dec 2022 11:43:27 -0500
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25EAA268;
        Tue, 13 Dec 2022 08:43:27 -0800 (PST)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 2BDGhLEU114201;
        Tue, 13 Dec 2022 10:43:21 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1670949801;
        bh=w2Ue5WDDYL9x4Hgu6bdWROqq/0qU9t4BO6DzYi2Kw+M=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=HnE55/SMN2jaQMP5FeYwi/jv9sKnhDra2+OCh0XCMI4KooatbjreAHoOGD0Xh2pVf
         9n3IIjFLpwIcoRksBrWk6PMyCuCBIk0Q97A5EVrVPpWtgVe5+5uL1cOZBVJECba/ia
         koX6fBOeWj8FPj0xsIEuqcYtc/GPLEYwHRztdX/c=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 2BDGhL47073245
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 13 Dec 2022 10:43:21 -0600
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Tue, 13
 Dec 2022 10:43:20 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Tue, 13 Dec 2022 10:43:20 -0600
Received: from uda0132425.dhcp.ti.com (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 2BDGh6gM034997;
        Tue, 13 Dec 2022 10:43:18 -0600
From:   Vignesh Raghavendra <vigneshr@ti.com>
To:     Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     <dmaengine@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v3 4/5] dmaengine: ti: k3-udma: Add support for DMAs on AM62A SoC
Date:   Tue, 13 Dec 2022 22:13:03 +0530
Message-ID: <20221213164304.1126945-5-vigneshr@ti.com>
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

