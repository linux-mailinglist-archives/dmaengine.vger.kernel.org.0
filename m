Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01AA0643C61
	for <lists+dmaengine@lfdr.de>; Tue,  6 Dec 2022 05:36:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233338AbiLFEg1 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 5 Dec 2022 23:36:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233241AbiLFEgQ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 5 Dec 2022 23:36:16 -0500
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B43031A203;
        Mon,  5 Dec 2022 20:36:15 -0800 (PST)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 2B64aC6n084437;
        Mon, 5 Dec 2022 22:36:12 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1670301372;
        bh=uzdACK3CoCmgtIqp1J3myv+V/5ADPKpVfzb86+ZMmqo=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=szR1Ly3G6Arbw6u5DA3fqZ5hnm9sVOq8ueLcucmN9KJmT4cHfwIoC1DJdZlrfn6oE
         8IZnHBvw5YO7sXe8A80Ov6fg9k6EuDQjJhXMT5J0j5p5JPzLA3rSLQPD693oVjrXPy
         7MJv65CMbJ4mQiSxR1DR8JmTsfq3UdR4nGuBIoBg=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 2B64aCGQ113336
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 5 Dec 2022 22:36:12 -0600
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Mon, 5
 Dec 2022 22:36:12 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Mon, 5 Dec 2022 22:36:12 -0600
Received: from uda0132425.dhcp.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 2B64Zx2c097382;
        Mon, 5 Dec 2022 22:36:10 -0600
From:   Vignesh Raghavendra <vigneshr@ti.com>
To:     Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     <dmaengine@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>
Subject: [PATCH 4/5] dmaengine: ti: k3-udma: Add support for DMAs on AM62A SoC
Date:   Tue, 6 Dec 2022 10:05:53 +0530
Message-ID: <20221206043554.1521522-5-vigneshr@ti.com>
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

AM62A SoC has a BCDMA and PKTDMA as systems DMAs for service various
peripherals similar to AM64 SoC. Add support for the same.

Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
---
 drivers/dma/ti/k3-udma.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
index 791cf6354946..19fce52a9b53 100644
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

