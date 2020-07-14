Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DF0821ECB9
	for <lists+dmaengine@lfdr.de>; Tue, 14 Jul 2020 11:27:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726820AbgGNJ1a (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 14 Jul 2020 05:27:30 -0400
Received: from mail-eopbgr50047.outbound.protection.outlook.com ([40.107.5.47]:59355
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726803AbgGNJ13 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 14 Jul 2020 05:27:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dTx/eoPZCh2578MJsi5A3/nuG4Kyq6XY9sTF4tH24ldBml/9CY6RpanynQyCwSO+Rm9H0R0225WhoYdhekW2TT8qsQOx9aw52nYxSe4xxNJ2GF44JnzxeXxPF12UsPTyvzrc4LbmPkeFVCYS7EdeWn4U6LAdqC4C9ECSH/pyIS6aMSaTavT+fE772OLAYDmiFnhl4Bnrhsg1YEoYmC0rW3AlZXNr2AJuE550RqfPxGUAiicBVeoQ2jMgBlFNX02waiW65yZ+BABRl2GRumy/SgGYBXnM+8D2ImrpDoifqbfRTRl2cMTTXTL7NUabeIie5X494uRdpzhHpvqMs4P14g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wnGtdIP/hbdfvrIHlyCNUJzLtnZLrNC7lK23LHA+0xg=;
 b=htrvTrztdXOvCY93YBf7Rci9+6XTiDhVkhrHuRl6gqUnixiZ8nBC77qH9ce/YZSObBeVubeHJaov1IEZ78169M1jlYw1npVb+cHZ0czYXUPN5NKxtiYyEFZfKsPCWXe2G/reqTR90hPkHlvn2mvE4SFdBY4LAOhfNkrLdRYLXJjOKPwHj+8Nr9bufHfFUqonOvFdG3SCiRn3ecqlCOum8eGAu4466flxRisxfo/6Olx1vXLGV/QCORrQ2yXO89YXNwEV/lULVDJ6/apaqKEOYZ5TFCvCXBY+bh4ZfE/I5Wxr4eAzT85jPoNvhYFs346okCGMHvyuJU9HjwIMwyoWrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wnGtdIP/hbdfvrIHlyCNUJzLtnZLrNC7lK23LHA+0xg=;
 b=JiK/CXhOTvgX9Uea14OMuHKqbxwszv0SccJBtg/RNfbYxoYFxnIRu/wVFzEVyGdf/eSVmXU5b6z6DeeGkqNhVqQkdPHCvLzU+oeoZ+Lq4iLs77oPwBdmqe6osWqP7iDBGWZaviVgt7mF0ikk0OdSXT6UypOdk3fQLpd9Hy6xQDs=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com (2603:10a6:803:119::15)
 by VI1PR04MB6270.eurprd04.prod.outlook.com (2603:10a6:803:fb::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.21; Tue, 14 Jul
 2020 09:27:26 +0000
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::5cc4:23a5:ca17:da7d]) by VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::5cc4:23a5:ca17:da7d%6]) with mapi id 15.20.3174.025; Tue, 14 Jul 2020
 09:27:26 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     vkoul@kernel.org, robh+dt@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, festevam@gmail.com,
        catalin.marinas@arm.com, will@kernel.org, dan.j.williams@intel.com,
        angelo@sysam.it
Cc:     kernel@pengutronix.de, linux-imx@nxp.com,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 2/9] dmaengine: fsl-edma-common: add condition check for fsl_edma_chan_mux
Date:   Wed, 15 Jul 2020 01:41:41 +0800
Message-Id: <1594748508-22179-3-git-send-email-yibin.gong@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1594748508-22179-1-git-send-email-yibin.gong@nxp.com>
References: <1594748508-22179-1-git-send-email-yibin.gong@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0092.apcprd01.prod.exchangelabs.com
 (2603:1096:3:15::18) To VE1PR04MB6638.eurprd04.prod.outlook.com
 (2603:10a6:803:119::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from robin-OptiPlex-790.ap.freescale.net (119.31.174.67) by SG2PR01CA0092.apcprd01.prod.exchangelabs.com (2603:1096:3:15::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3195.17 via Frontend Transport; Tue, 14 Jul 2020 09:27:21 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.67]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: fb5e9702-7499-4f20-d669-08d827d81ec9
X-MS-TrafficTypeDiagnostic: VI1PR04MB6270:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR04MB62704B3CF5559E05C51D7C4F89610@VI1PR04MB6270.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1247;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: L533UtPFavhICK6QmU/qzjQ1iG8tSfx4y8g9XNGmBtNnXiUzK87GcZFfyoHWbqxM2zz1G0tY3dm8MXFpmYYTBhdXeVyEUcGnDHp/tTs0Ya2mI0s6+dFtvURLyhw9e3eOHJe2v/rEdfSufLa7QRqMlzVnADFTN/6F9UdxsTL73Et+LssYYOkJejV8UuszRPNSSVmjks7nwmZC7q1LJbeWnDy2hyl8tX3Fj9g1G+Te2EUK+k/xOIAyjTD9rY44gvvQImL39bUeBSZFfvXWCrpmrYpBv4i6ntVdUnfQZFCSoTXlfA9OqZ9cRFyUf60d+inYjfJ3uFzc4F6i8EiVrrc6MQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(366004)(396003)(136003)(346002)(376002)(66946007)(6486002)(6512007)(66476007)(66556008)(8936002)(4326008)(86362001)(2906002)(6506007)(83380400001)(478600001)(36756003)(16526019)(956004)(2616005)(186003)(6666004)(26005)(5660300002)(8676002)(52116002)(7416002)(4744005)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: EJcZ/kVzw9XOTuPR0JgQp8oa2OqWsHucD5ursn9j9PDkg4qY5dtJ7swtuXSu8khih8/zJzi/t2PVIRwPCBhpnTMClRRjVTR+r0ZdDVUaRY3HIj/3uOSKTlItwu2kfLtrBkSLYzYHPairTjtswN94i/brdHpilzd0IFqfMCLTMIGOfcBBtYP2lvkqSDzmloK76vdzfCcaZdgm0BhwjGq9E7SZHnSWLdpPqtNQcRfZOC7FPX7vDMymYmsepJYv5brFeHxgxdYJIQ5PF3AfTRXg7Zqjb5VuiuxzhsM0O3LlvUFeTJdWMckLgsSlZNxFxZErLDT6n5p+mgvXP7r6mNFhOLni+cUeW0zL0mbx8O/wNFpG/TDJu8eh6fu2rPsTNV3ZMsePjpDAdMss4MDj5bOdwKIhcE6lJeY6e0YJ005acXEetIqHrgrFPoKZTAt7f92aRfvQAkbsUK54fAA7rA44//Wy68VRG4SwTeSx1Fn1e2A=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb5e9702-7499-4f20-d669-08d827d81ec9
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6638.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2020 09:27:25.9416
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M79X/HIBQBV/gYIGKIHEpXsFbm+oPKKnyStug9p4z417miw4H4uJOLD/3N2cBeykudUA9wDNyvgZPjVr+UiSyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6270
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Since next edma3 don't have dmamux, add condition check in the common
fsl_edma_free_chan_resources().

Signed-off-by: Robin Gong <yibin.gong@nxp.com>
---
 drivers/dma/fsl-edma-common.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/fsl-edma-common.c b/drivers/dma/fsl-edma-common.c
index ef5294f0..d19e8a8 100644
--- a/drivers/dma/fsl-edma-common.c
+++ b/drivers/dma/fsl-edma-common.c
@@ -642,7 +642,10 @@ void fsl_edma_free_chan_resources(struct dma_chan *chan)
 
 	spin_lock_irqsave(&fsl_chan->vchan.lock, flags);
 	fsl_chan->edma->drvdata->dis_req(fsl_chan);
-	fsl_edma_chan_mux(fsl_chan, 0, false);
+
+	if (fsl_chan->edma->drvdata->dmamuxs)
+		fsl_edma_chan_mux(fsl_chan, 0, false);
+
 	fsl_chan->edesc = NULL;
 	vchan_get_all_descriptors(&fsl_chan->vchan, &head);
 	fsl_edma_unprep_slave_dma(fsl_chan);
-- 
2.7.4

