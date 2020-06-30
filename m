Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B7B620ED64
	for <lists+dmaengine@lfdr.de>; Tue, 30 Jun 2020 07:24:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729557AbgF3FYy (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 30 Jun 2020 01:24:54 -0400
Received: from mail-am6eur05on2061.outbound.protection.outlook.com ([40.107.22.61]:39840
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729538AbgF3FYx (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 30 Jun 2020 01:24:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X0I4p4mwE1Au/ACq6Nkp16IQ2sbIzSLV1Kh6HBx+UD2tlkaQvVcNdmGynAHqepU3YXkvNgUweX4PFE3RsschvexyJvJZrXmfyA35xV/nSbkLNUR2YY9J0tDTbMLyQvUboa5UuxXFcppUf2wC9y8KCMRQi2MCSAZdM3rmb35yNjUlz4lfgrCmmbE/GgSO5zVGSRqTwQk12HevWJ+Eswlcfz80aCsvDXZjiiZ4Zg+KgOSAMPAl8J9YhwFWnIxONRIRm8jUlsL11qhj9clUl7r6EpehdW19O19Hj37Sm93OseDFIxlOnlI89KGhSvfWRBtSxXYUIY/j6U2+tWvIwUVUdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IN1fRToEmGvcd3mguKJujHggzOr4K2gVkDIrU6mwPNY=;
 b=FAQ4GqUI54xU5srFjgeZt7tc9Y6AVGTSD6VfveHOD0KqLXJwHgOrozexykBKnD3fwMAyqdsEh6b/33bGK3Ok1CKDcbumU4r7u/XPQyfHaK9fDRRElgdnviPslZY+DXNSSij2QHr3hTxIaETZNdT8vGrEcNNvk0CjMdwDtNQmnGsf3tzV4Tij43f5zUvGSoOkJkns7TvSUAMlNgQHbAhGFa+jML3WbK3tLRkeSOl5FlwLB5nxdg2UDXXOR069ad0lv4luuDnm9KgG/F+nWDylgFHS2wGasOD2QH2+P0mkBON/YBblGobaL0Apuxzy8Ko4VxJXCFjKpJp80e/4veSWXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IN1fRToEmGvcd3mguKJujHggzOr4K2gVkDIrU6mwPNY=;
 b=lRY3lzEXNqM73NAVfgWATpyUCMGUaBtQ7sU3uuuKCesL1sGCt17dbTkhNVu4vrptcbx5IKN98ZdxKLd3fPoYUsivCiEC6v3tvbGvIp8WpbuSH+dH/ApupzQ0wJmsaQmZLqIQbA4lmk7yKHEYdwOPxKkoRVTVsMM76N/mao+h6cA=
Authentication-Results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=nxp.com;
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com (2603:10a6:803:119::15)
 by VE1PR04MB6640.eurprd04.prod.outlook.com (2603:10a6:803:122::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.26; Tue, 30 Jun
 2020 05:24:49 +0000
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::5cc4:23a5:ca17:da7d]) by VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::5cc4:23a5:ca17:da7d%6]) with mapi id 15.20.3131.028; Tue, 30 Jun 2020
 05:24:49 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     mark.rutland@arm.com, broonie@kernel.org, robh+dt@kernel.org,
        catalin.marinas@arm.com, vkoul@kernel.org, will.deacon@arm.com,
        shawnguo@kernel.org, festevam@gmail.com, s.hauer@pengutronix.de,
        martin.fuzzey@flowbird.group, u.kleine-koenig@pengutronix.de,
        dan.j.williams@intel.com, matthias.schiffer@ew.tq-group.com
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@pengutronix.de, dmaengine@vger.kernel.org, linux-imx@nxp.com
Subject: [PATCH v10 04/12] dmaengine: imx-sdma: remove duplicated sdma_load_context
Date:   Tue, 30 Jun 2020 21:31:08 +0800
Message-Id: <1593523876-22387-5-git-send-email-yibin.gong@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1593523876-22387-1-git-send-email-yibin.gong@nxp.com>
References: <1593523876-22387-1-git-send-email-yibin.gong@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0132.apcprd06.prod.outlook.com
 (2603:1096:1:1d::34) To VE1PR04MB6638.eurprd04.prod.outlook.com
 (2603:10a6:803:119::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from robin-OptiPlex-790.ap.freescale.net (119.31.174.67) by SG2PR06CA0132.apcprd06.prod.outlook.com (2603:1096:1:1d::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3131.21 via Frontend Transport; Tue, 30 Jun 2020 05:24:44 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.67]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 1ad5f176-21e6-4493-6c95-08d81cb5e8ae
X-MS-TrafficTypeDiagnostic: VE1PR04MB6640:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VE1PR04MB66406491DF0E607C26A58485896F0@VE1PR04MB6640.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1923;
X-Forefront-PRVS: 0450A714CB
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0Docbno7St/5j7AdczpFnfDGZoCMmxworl1QFYzF+TvyeX+Gfym0jwNSJ1zAlsGrZ5zMiSW5BVEb9m+HSM3wQNLN6B00a2bK8mmSFTez76881ROOQkkABUINANl+RJLScNdEwWwZYZjZuu5jlwqdgQu2wvIIQeNW0yGFVZyeM4YtE0GKS11WsrZbZvQybkHOJ4N0S5hwUYG0skTskP9O3/ViPAAbrN3NoOqIb1GjxFbGj58kxEXEGbsWs3GYsftFnjGlBYwhzjU95FEsZC/bsoEJwrfBpRq2mRu+hGVQ2yYTCH3LliK8r2WJ9Szb+YocIQcf/EfaLymlRNDpMkRsfO5PCymFpxpIqOGRAMnFjJg/olKrPtHiBrfyrWt7xIAQ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(346002)(136003)(39860400002)(366004)(396003)(86362001)(956004)(6666004)(2616005)(52116002)(7416002)(4326008)(6506007)(6486002)(2906002)(4744005)(5660300002)(186003)(26005)(36756003)(16526019)(8676002)(478600001)(316002)(83380400001)(66946007)(66476007)(6512007)(8936002)(66556008)(921003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: eIEpCtfuEb5JctSF6kkDFf9mM0poq3UfPfQce4M8jlGDp2HE3du5ckriDKIjW2HiohfQ/4aMVeP4J9fqhTfV9CnF4zgQnSrK1LmQEIZXw/uAlif3jevBTkGngLyWRauvqdemi4xN+9CeftkYBwfewTyzqyEkqcipH7VO/MQajUuoVa0cwS3b11fdx6L5VAdeNrritMuJicZDewGpN71YqIGlApWjsEPR102cQ1goPXM8CFfVwmtT3WcjVF4AyQa4nvWPnr+tXO9gOZ4zAiszxzCQ0OzJ4rTuwmq64/XPpYYNwF55j3qei57rIHuePve5jzogtMOy0t/pDCOOREI3DaaRml3cQP519u00cMToNiCoODGgtXxKTFPIT9yjNF9rs2/E8GJ7HP7f0YWsizIrU+QzCMlC2VH1uWTRORTwQmxReVQJgfrigaPM7i+7Byz9QTHW0j5LK1//LlxJlmwFS3cdNkzU2EFERmR2dupS/54=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ad5f176-21e6-4493-6c95-08d81cb5e8ae
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6638.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2020 05:24:49.4616
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tPs8N/F+svlGlx7OTpK2t7MLvJIW84T7wVBz7pvmENP9HXivILeTyNpFjiGUHLgx5TW+AwTbLNKQ9wwThI8JPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6640
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Since sdma_transfer_init() will do sdma_load_context before any
sdma transfer, no need once more in sdma_config_channel().

Signed-off-by: Robin Gong <yibin.gong@nxp.com>
Acked-by: Vinod Koul <vkoul@kernel.org>
---
 drivers/dma/imx-sdma.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index d305b80..5411e01e 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -1137,7 +1137,6 @@ static void sdma_set_watermarklevel_for_p2p(struct sdma_channel *sdmac)
 static int sdma_config_channel(struct dma_chan *chan)
 {
 	struct sdma_channel *sdmac = to_sdma_chan(chan);
-	int ret;
 
 	sdma_disable_channel(chan);
 
@@ -1177,9 +1176,7 @@ static int sdma_config_channel(struct dma_chan *chan)
 		sdmac->watermark_level = 0; /* FIXME: M3_BASE_ADDRESS */
 	}
 
-	ret = sdma_load_context(sdmac);
-
-	return ret;
+	return 0;
 }
 
 static int sdma_set_channel_priority(struct sdma_channel *sdmac,
-- 
2.7.4

