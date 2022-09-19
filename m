Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAD395BD5FD
	for <lists+dmaengine@lfdr.de>; Mon, 19 Sep 2022 23:00:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229893AbiISVAU (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 19 Sep 2022 17:00:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbiISVAQ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 19 Sep 2022 17:00:16 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 338F03F1D4;
        Mon, 19 Sep 2022 14:00:11 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 28JL06mJ130937;
        Mon, 19 Sep 2022 16:00:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1663621206;
        bh=d2Rg6H9N+CllSV5fv0RsOmYsBarSCuaGQm0TWpbzIY4=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=LMJ4Cu1ao53rPwAUZFDqPkZiG1hcoPbGOz18B1yFsBs04VSr0H9f6wOxC4+dliwTx
         aAX+n2ocylgQ+3fKAKTzr2+9uJgPhU7H5dozBUjGEVMm7oXRzdVUAx+HcCW2Ng1ppb
         /9QyUu2lfCgji+LTggMezLbvpy3ROrN708V3lMrQ=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 28JL06aF006018
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 19 Sep 2022 16:00:06 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Mon, 19
 Sep 2022 16:00:05 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Mon, 19 Sep 2022 16:00:06 -0500
Received: from ubuntu.ent.ti.com (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 28JKxoAL014294;
        Mon, 19 Sep 2022 16:00:01 -0500
From:   Matt Ranostay <mranostay@ti.com>
To:     <nm@ti.com>, <vkoul@kernel.org>
CC:     <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Matt Ranostay <mranostay@ti.com>
Subject: [PATCH RESEND 2/2] dmaengine: ti: k3-psil: add additional TX threads for j7200
Date:   Mon, 19 Sep 2022 13:59:31 -0700
Message-ID: <20220919205931.8397-3-mranostay@ti.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220919205931.8397-1-mranostay@ti.com>
References: <20220919205931.8397-1-mranostay@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75 autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Add matching PSI-L threads mapping for transmission DMA channels
on the J7200 platform.

Signed-off-by: Matt Ranostay <mranostay@ti.com>
---
 drivers/dma/ti/k3-psil-j7200.c | 67 ++++++++++++++++++++++++++++++++++
 1 file changed, 67 insertions(+)

diff --git a/drivers/dma/ti/k3-psil-j7200.c b/drivers/dma/ti/k3-psil-j7200.c
index 5ea63ea74822..e3feff869991 100644
--- a/drivers/dma/ti/k3-psil-j7200.c
+++ b/drivers/dma/ti/k3-psil-j7200.c
@@ -143,6 +143,57 @@ static struct psil_ep j7200_src_ep_map[] = {
 
 /* PSI-L destination thread IDs, used for TX (DMA_MEM_TO_DEV) */
 static struct psil_ep j7200_dst_ep_map[] = {
+	/* PDMA_MCASP - McASP0-2 */
+	PSIL_PDMA_MCASP(0xc400),
+	PSIL_PDMA_MCASP(0xc401),
+	PSIL_PDMA_MCASP(0xc402),
+	/* PDMA_SPI_G0 - SPI0-3 */
+	PSIL_PDMA_XY_PKT(0xc600),
+	PSIL_PDMA_XY_PKT(0xc601),
+	PSIL_PDMA_XY_PKT(0xc602),
+	PSIL_PDMA_XY_PKT(0xc603),
+	PSIL_PDMA_XY_PKT(0xc604),
+	PSIL_PDMA_XY_PKT(0xc605),
+	PSIL_PDMA_XY_PKT(0xc606),
+	PSIL_PDMA_XY_PKT(0xc607),
+	PSIL_PDMA_XY_PKT(0xc608),
+	PSIL_PDMA_XY_PKT(0xc609),
+	PSIL_PDMA_XY_PKT(0xc60a),
+	PSIL_PDMA_XY_PKT(0xc60b),
+	PSIL_PDMA_XY_PKT(0xc60c),
+	PSIL_PDMA_XY_PKT(0xc60d),
+	PSIL_PDMA_XY_PKT(0xc60e),
+	PSIL_PDMA_XY_PKT(0xc60f),
+	/* PDMA_SPI_G1 - SPI4-7 */
+	PSIL_PDMA_XY_PKT(0xc610),
+	PSIL_PDMA_XY_PKT(0xc611),
+	PSIL_PDMA_XY_PKT(0xc612),
+	PSIL_PDMA_XY_PKT(0xc613),
+	PSIL_PDMA_XY_PKT(0xc614),
+	PSIL_PDMA_XY_PKT(0xc615),
+	PSIL_PDMA_XY_PKT(0xc616),
+	PSIL_PDMA_XY_PKT(0xc617),
+	PSIL_PDMA_XY_PKT(0xc618),
+	PSIL_PDMA_XY_PKT(0xc619),
+	PSIL_PDMA_XY_PKT(0xc61a),
+	PSIL_PDMA_XY_PKT(0xc61b),
+	PSIL_PDMA_XY_PKT(0xc61c),
+	PSIL_PDMA_XY_PKT(0xc61d),
+	PSIL_PDMA_XY_PKT(0xc61e),
+	PSIL_PDMA_XY_PKT(0xc61f),
+	/* PDMA_USART_G0 - UART0-1 */
+	PSIL_PDMA_XY_PKT(0xc700),
+	PSIL_PDMA_XY_PKT(0xc701),
+	/* PDMA_USART_G1 - UART2-3 */
+	PSIL_PDMA_XY_PKT(0xc702),
+	PSIL_PDMA_XY_PKT(0xc703),
+	/* PDMA_USART_G2 - UART4-9 */
+	PSIL_PDMA_XY_PKT(0xc704),
+	PSIL_PDMA_XY_PKT(0xc705),
+	PSIL_PDMA_XY_PKT(0xc706),
+	PSIL_PDMA_XY_PKT(0xc707),
+	PSIL_PDMA_XY_PKT(0xc708),
+	PSIL_PDMA_XY_PKT(0xc709),
 	/* CPSW5 */
 	PSIL_ETHERNET(0xca00),
 	PSIL_ETHERNET(0xca01),
@@ -161,6 +212,22 @@ static struct psil_ep j7200_dst_ep_map[] = {
 	PSIL_ETHERNET(0xf005),
 	PSIL_ETHERNET(0xf006),
 	PSIL_ETHERNET(0xf007),
+	/* MCU_PDMA_MISC_G0 - SPI0 */
+	PSIL_PDMA_XY_PKT(0xf100),
+	PSIL_PDMA_XY_PKT(0xf101),
+	PSIL_PDMA_XY_PKT(0xf102),
+	PSIL_PDMA_XY_PKT(0xf103),
+	/* MCU_PDMA_MISC_G1 - SPI1-2 */
+	PSIL_PDMA_XY_PKT(0xf200),
+	PSIL_PDMA_XY_PKT(0xf201),
+	PSIL_PDMA_XY_PKT(0xf202),
+	PSIL_PDMA_XY_PKT(0xf203),
+	PSIL_PDMA_XY_PKT(0xf204),
+	PSIL_PDMA_XY_PKT(0xf205),
+	PSIL_PDMA_XY_PKT(0xf206),
+	PSIL_PDMA_XY_PKT(0xf207),
+	/* MCU_PDMA_MISC_G2 - UART0 */
+	PSIL_PDMA_XY_PKT(0xf300),
 	/* SA2UL */
 	PSIL_SA2UL(0xf500, 1),
 	PSIL_SA2UL(0xf501, 1),
-- 
2.37.2

