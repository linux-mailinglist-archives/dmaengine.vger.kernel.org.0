Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0B4A4BC6F6
	for <lists+dmaengine@lfdr.de>; Sat, 19 Feb 2022 09:33:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241752AbiBSIdD (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 19 Feb 2022 03:33:03 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239001AbiBSIdC (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 19 Feb 2022 03:33:02 -0500
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7D35673F1;
        Sat, 19 Feb 2022 00:32:44 -0800 (PST)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 21J8WXVB112528;
        Sat, 19 Feb 2022 02:32:33 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1645259553;
        bh=yoS740aR9QXHttLhOCtrUXe2a1ycP9PYU0FvhSDUY2c=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=LqhdfCqeX3tcZprlDadWwHRnkOPXVhWe1zwWUEjqNPxOufyFp990/Bk/t3uSPhTcl
         jibvYbZk3dHYG7TVazrU+yJLCKFD+RosnsbjKv6Ck6eHDd5qV5rTf97l5MHD4oktgu
         6H5Luv93rHKs0iv7PijEbOFamIpAEKZ2cMp2I/k0=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 21J8WXrG070278
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sat, 19 Feb 2022 02:32:33 -0600
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Sat, 19
 Feb 2022 02:32:33 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Sat, 19 Feb 2022 02:32:33 -0600
Received: from ula0132425.ent.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 21J8WRX7017343;
        Sat, 19 Feb 2022 02:32:31 -0600
From:   Vignesh Raghavendra <vigneshr@ti.com>
To:     Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        Vinod Koul <vkoul@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <dmaengine@vger.kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 1/2] dmaengine: ti: k3-udma: Add AM62x DMSS support
Date:   Sat, 19 Feb 2022 14:02:19 +0530
Message-ID: <20220219083220.489420-2-vigneshr@ti.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220219083220.489420-1-vigneshr@ti.com>
References: <20220219083220.489420-1-vigneshr@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Attribute AM64x soc data to AM62x as well as the DMSS IP is similar b/w
these two SoCs

Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
---
 drivers/dma/ti/k3-udma.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
index d2d4cbe63e448..2f0d2c68c93c6 100644
--- a/drivers/dma/ti/k3-udma.c
+++ b/drivers/dma/ti/k3-udma.c
@@ -4375,6 +4375,7 @@ static const struct soc_device_attribute k3_soc_devices[] = {
 	{ .family = "J7200", .data = &j7200_soc_data },
 	{ .family = "AM64X", .data = &am64_soc_data },
 	{ .family = "J721S2", .data = &j721e_soc_data},
+	{ .family = "AM62X", .data = &am64_soc_data },
 	{ /* sentinel */ }
 };
 
-- 
2.35.1

