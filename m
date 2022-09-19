Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AEDF5BD600
	for <lists+dmaengine@lfdr.de>; Mon, 19 Sep 2022 23:00:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229921AbiISVAZ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 19 Sep 2022 17:00:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbiISVAS (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 19 Sep 2022 17:00:18 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 715D64BA6C;
        Mon, 19 Sep 2022 14:00:14 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 28JL01kB082587;
        Mon, 19 Sep 2022 16:00:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1663621201;
        bh=YavrwkdN8UvY+cRk2KxU/0T8mlD13aSrOfNBFrbrUHE=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=fTxiH22LO9M0qU0cURNfM0gM85pYou8cAShm4bXgS0FMV6eJRXwYCxQmjv+vW705V
         /YLOo6iq6OWCCSWNjMaP1k58cUL6x0Q0/8Wdh39rL+TtN31d3cHUO1u+Yflvwo0bNs
         Uq4hT1uNbRZoGXCbVqDUcFZ4EsujhLeQdIrZqDIw=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 28JL01sp096494
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 19 Sep 2022 16:00:01 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Mon, 19
 Sep 2022 16:00:00 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Mon, 19 Sep 2022 16:00:00 -0500
Received: from ubuntu.ent.ti.com (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 28JKxoAK014294;
        Mon, 19 Sep 2022 15:59:56 -0500
From:   Matt Ranostay <mranostay@ti.com>
To:     <nm@ti.com>, <vkoul@kernel.org>
CC:     <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Matt Ranostay <mranostay@ti.com>
Subject: [PATCH RESEND 1/2] dmaengine: ti: k3-psil: add additional TX threads for j721e
Date:   Mon, 19 Sep 2022 13:59:30 -0700
Message-ID: <20220919205931.8397-2-mranostay@ti.com>
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
on the J721E platform.

Signed-off-by: Matt Ranostay <mranostay@ti.com>
---
 drivers/dma/ti/k3-psil-j721e.c | 79 ++++++++++++++++++++++++++++++++++
 1 file changed, 79 insertions(+)

diff --git a/drivers/dma/ti/k3-psil-j721e.c b/drivers/dma/ti/k3-psil-j721e.c
index 34e3fc565a37..e7c83d668bb6 100644
--- a/drivers/dma/ti/k3-psil-j721e.c
+++ b/drivers/dma/ti/k3-psil-j721e.c
@@ -266,6 +266,69 @@ static struct psil_ep j721e_dst_ep_map[] = {
 	PSIL_ETHERNET(0xc205),
 	PSIL_ETHERNET(0xc206),
 	PSIL_ETHERNET(0xc207),
+	/* PDMA6 (PSIL_PDMA_MCASP_G0) - McASP0-2 */
+	PSIL_PDMA_MCASP(0xc400),
+	PSIL_PDMA_MCASP(0xc401),
+	PSIL_PDMA_MCASP(0xc402),
+	/* PDMA7 (PSIL_PDMA_MCASP_G1) - McASP3-11 */
+	PSIL_PDMA_MCASP(0xc500),
+	PSIL_PDMA_MCASP(0xc501),
+	PSIL_PDMA_MCASP(0xc502),
+	PSIL_PDMA_MCASP(0xc503),
+	PSIL_PDMA_MCASP(0xc504),
+	PSIL_PDMA_MCASP(0xc505),
+	PSIL_PDMA_MCASP(0xc506),
+	PSIL_PDMA_MCASP(0xc507),
+	PSIL_PDMA_MCASP(0xc508),
+	/* PDMA8 (PDMA_MISC_G0) - SPI0-1 */
+	PSIL_PDMA_XY_PKT(0xc600),
+	PSIL_PDMA_XY_PKT(0xc601),
+	PSIL_PDMA_XY_PKT(0xc602),
+	PSIL_PDMA_XY_PKT(0xc603),
+	PSIL_PDMA_XY_PKT(0xc604),
+	PSIL_PDMA_XY_PKT(0xc605),
+	PSIL_PDMA_XY_PKT(0xc606),
+	PSIL_PDMA_XY_PKT(0xc607),
+	/* PDMA9 (PDMA_MISC_G1) - SPI2-3 */
+	PSIL_PDMA_XY_PKT(0xc60c),
+	PSIL_PDMA_XY_PKT(0xc60d),
+	PSIL_PDMA_XY_PKT(0xc60e),
+	PSIL_PDMA_XY_PKT(0xc60f),
+	PSIL_PDMA_XY_PKT(0xc610),
+	PSIL_PDMA_XY_PKT(0xc611),
+	PSIL_PDMA_XY_PKT(0xc612),
+	PSIL_PDMA_XY_PKT(0xc613),
+	/* PDMA10 (PDMA_MISC_G2) - SPI4-5 */
+	PSIL_PDMA_XY_PKT(0xc618),
+	PSIL_PDMA_XY_PKT(0xc619),
+	PSIL_PDMA_XY_PKT(0xc61a),
+	PSIL_PDMA_XY_PKT(0xc61b),
+	PSIL_PDMA_XY_PKT(0xc61c),
+	PSIL_PDMA_XY_PKT(0xc61d),
+	PSIL_PDMA_XY_PKT(0xc61e),
+	PSIL_PDMA_XY_PKT(0xc61f),
+	/* PDMA11 (PDMA_MISC_G3) */
+	PSIL_PDMA_XY_PKT(0xc624),
+	PSIL_PDMA_XY_PKT(0xc625),
+	PSIL_PDMA_XY_PKT(0xc626),
+	PSIL_PDMA_XY_PKT(0xc627),
+	PSIL_PDMA_XY_PKT(0xc628),
+	PSIL_PDMA_XY_PKT(0xc629),
+	PSIL_PDMA_XY_PKT(0xc630),
+	PSIL_PDMA_XY_PKT(0xc63a),
+	/* PDMA13 (PDMA_USART_G0) - UART0-1 */
+	PSIL_PDMA_XY_PKT(0xc700),
+	PSIL_PDMA_XY_PKT(0xc701),
+	/* PDMA14 (PDMA_USART_G1) - UART2-3 */
+	PSIL_PDMA_XY_PKT(0xc702),
+	PSIL_PDMA_XY_PKT(0xc703),
+	/* PDMA15 (PDMA_USART_G2) - UART4-9 */
+	PSIL_PDMA_XY_PKT(0xc704),
+	PSIL_PDMA_XY_PKT(0xc705),
+	PSIL_PDMA_XY_PKT(0xc706),
+	PSIL_PDMA_XY_PKT(0xc707),
+	PSIL_PDMA_XY_PKT(0xc708),
+	PSIL_PDMA_XY_PKT(0xc709),
 	/* CPSW9 */
 	PSIL_ETHERNET(0xca00),
 	PSIL_ETHERNET(0xca01),
@@ -284,6 +347,22 @@ static struct psil_ep j721e_dst_ep_map[] = {
 	PSIL_ETHERNET(0xf005),
 	PSIL_ETHERNET(0xf006),
 	PSIL_ETHERNET(0xf007),
+	/* MCU_PDMA0 (MCU_PDMA_MISC_G0) - SPI0 */
+	PSIL_PDMA_XY_PKT(0xf100),
+	PSIL_PDMA_XY_PKT(0xf101),
+	PSIL_PDMA_XY_PKT(0xf102),
+	PSIL_PDMA_XY_PKT(0xf103),
+	/* MCU_PDMA1 (MCU_PDMA_MISC_G1) - SPI1-2 */
+	PSIL_PDMA_XY_PKT(0xf200),
+	PSIL_PDMA_XY_PKT(0xf201),
+	PSIL_PDMA_XY_PKT(0xf202),
+	PSIL_PDMA_XY_PKT(0xf203),
+	PSIL_PDMA_XY_PKT(0xf204),
+	PSIL_PDMA_XY_PKT(0xf205),
+	PSIL_PDMA_XY_PKT(0xf206),
+	PSIL_PDMA_XY_PKT(0xf207),
+	/* MCU_PDMA2 (MCU_PDMA_MISC_G2) - UART0 */
+	PSIL_PDMA_XY_PKT(0xf300),
 	/* SA2UL */
 	PSIL_SA2UL(0xf500, 1),
 	PSIL_SA2UL(0xf501, 1),
-- 
2.37.2

