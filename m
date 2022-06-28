Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 703F255D5BD
	for <lists+dmaengine@lfdr.de>; Tue, 28 Jun 2022 15:15:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244413AbiF1FDL (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 28 Jun 2022 01:03:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244616AbiF1FCi (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 28 Jun 2022 01:02:38 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E39AF2613F;
        Mon, 27 Jun 2022 22:02:37 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 25S52YCh027533;
        Tue, 28 Jun 2022 00:02:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1656392554;
        bh=rRr91cbrwvFz6l2mbIAWuAo3eEpVAxQU6875Im+lL54=;
        h=From:To:CC:Subject:Date;
        b=jUqJtlK81bHwjyc67afIcHEmgFN6/ebMRgw/Ej2Frcyj7lg5JkpJa7vcqTYFtZlLS
         OUQtKGknbYoaWrfw2ceMBdmwUCRC2tgDqFbIQCh5cnrxLC20fSjkTBz6OURctSnY+L
         GVtBw0cUDKZZncWiBKSgpaAPlKqzDEr0Jb1D2n5s=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 25S52YsB017644
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 28 Jun 2022 00:02:34 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Tue, 28
 Jun 2022 00:02:33 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Tue, 28 Jun 2022 00:02:33 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 25S52XWM114443;
        Tue, 28 Jun 2022 00:02:33 -0500
From:   Jayesh Choudhary <j-choudhary@ti.com>
To:     <dmaengine@vger.kernel.org>
CC:     <peter.ujfalusi@gmail.com>, <vkoul@kernel.org>,
        <linux-kernel@vger.kernel.org>, <j-choudhary@ti.com>
Subject: [PATCH] dmaengine: ti: k3-psil-j721s2: Add psil threads for sa2ul
Date:   Tue, 28 Jun 2022 10:32:32 +0530
Message-ID: <20220628050232.331956-1-j-choudhary@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Add endpoint configuration for the four ingress and two egress
threads for main domain crypto accelerator.

Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
---
 drivers/dma/ti/k3-psil-j721s2.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/dma/ti/k3-psil-j721s2.c b/drivers/dma/ti/k3-psil-j721s2.c
index 4c4172a4d271..a488c2250623 100644
--- a/drivers/dma/ti/k3-psil-j721s2.c
+++ b/drivers/dma/ti/k3-psil-j721s2.c
@@ -112,6 +112,11 @@ static struct psil_ep j721s2_src_ep_map[] = {
 	PSIL_PDMA_XY_PKT(0x4707),
 	PSIL_PDMA_XY_PKT(0x4708),
 	PSIL_PDMA_XY_PKT(0x4709),
+	/* MAIN SA2UL */
+	PSIL_SA2UL(0x4a40, 0),
+	PSIL_SA2UL(0x4a41, 0),
+	PSIL_SA2UL(0x4a42, 0),
+	PSIL_SA2UL(0x4a43, 0),
 	/* CPSW0 */
 	PSIL_ETHERNET(0x7000),
 	/* MCU_PDMA0 (MCU_PDMA_MISC_G0) - SPI0 */
@@ -144,6 +149,9 @@ static struct psil_ep j721s2_src_ep_map[] = {
 
 /* PSI-L destination thread IDs, used for TX (DMA_MEM_TO_DEV) */
 static struct psil_ep j721s2_dst_ep_map[] = {
+	/* MAIN SA2UL */
+	PSIL_SA2UL(0xca40, 1),
+	PSIL_SA2UL(0xca41, 1),
 	/* CPSW0 */
 	PSIL_ETHERNET(0xf000),
 	PSIL_ETHERNET(0xf001),
-- 
2.17.1

