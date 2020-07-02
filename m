Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22D9F211C3D
	for <lists+dmaengine@lfdr.de>; Thu,  2 Jul 2020 08:54:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727784AbgGBGyV (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 2 Jul 2020 02:54:21 -0400
Received: from mail-eopbgr60071.outbound.protection.outlook.com ([40.107.6.71]:12347
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726858AbgGBGyU (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 2 Jul 2020 02:54:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E5AH6uEfaqlU5xcZZdCqe9ZQISikhhaUtnzyBoo/Xa8hN6vKNHwhQrroZQOBM0dn9l6JWE18WdXEROUZcvlu7QMz9O5sEAnvkcSRISpIGsuqmExCKfHxoP4yHD1Mph4uQOmD6bDzfY4v0n0Fg8wady2vgD+rGTR54NQovhHXp/liWTxllOflOEhul4MjRa9sX8+qAQyfA1ltluO5YlAYk7AKRuMaf24KycWn7je2Io4GPf4u7zB6dntzmJpPhvk++vHiX20/IcvnJAV288uyfhljbkkW3wLvnYhwl0ofCtRiHbduhKppc1gOKLf7q3UTluCUex1LDeRav78Fjb2YyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2oPNSBxTNY2/skpU+HftgqZlcyRxLbDifUvEbmUW7J8=;
 b=HE0JMUl+Y6z/Kphi/bqKqmFEOtYOBE04LkpNDJQdhoF0XwUcku2A2bRUC8FyxMZJip2iOPE5wS7pTy+nNxPMZcLaLrKZESr8ixOQHwjVidDgtL6KeUSh59aIFPLmlcOpmCqcmoPp8hDX6rsS90QAIYdoZbdpJPACN9Guf31P2dMkeZj9lG5++lomsaSDSpWH/usDQPzLPacuumHBQ0J/QcQ0Ogv22avT9cwoEaqPVKajy0B6J8ldYXq0sTauXqlXs7U04Va3Qs7QLfMMilWDRaARd13zSSF/QQ9ZD0DQCctw8ePzLMj8EnKQONgjLh8Bzh4VHM0ru1cflCqmZ9cKbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2oPNSBxTNY2/skpU+HftgqZlcyRxLbDifUvEbmUW7J8=;
 b=oK/0I2CgxTAGEaBzsziNmTH9kbDOLd7XMiNoBohav7pwpxDHy9d67LIra1DsG7W6yS4xtpXLviFAavuLGp/RLbUJFAe4n8S4eUNqfqTBniQLWQtKUQAESKfMhAoDiNC8FF1+FzvfdcOlHBn65tor0TI0Vq8LID/FnRyRY0KsCfs=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com (2603:10a6:803:119::15)
 by VI1PR04MB6943.eurprd04.prod.outlook.com (2603:10a6:803:13a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.22; Thu, 2 Jul
 2020 06:54:11 +0000
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::5cc4:23a5:ca17:da7d]) by VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::5cc4:23a5:ca17:da7d%6]) with mapi id 15.20.3153.024; Thu, 2 Jul 2020
 06:54:11 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     vkoul@kernel.org, robh+dt@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, festevam@gmail.com,
        catalin.marinas@arm.com, will@kernel.org, dan.j.williams@intel.com,
        angelo@sysam.it
Cc:     kernel@pengutronix.de, linux-imx@nxp.com,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v1 7/9] firmware: imx: scu-pd: correct dma resource
Date:   Thu,  2 Jul 2020 23:08:07 +0800
Message-Id: <1593702489-21648-8-git-send-email-yibin.gong@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1593702489-21648-1-git-send-email-yibin.gong@nxp.com>
References: <1593702489-21648-1-git-send-email-yibin.gong@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0172.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::28) To VE1PR04MB6638.eurprd04.prod.outlook.com
 (2603:10a6:803:119::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from robin-OptiPlex-790.ap.freescale.net (119.31.174.67) by SG2PR01CA0172.apcprd01.prod.exchangelabs.com (2603:1096:4:28::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3153.24 via Frontend Transport; Thu, 2 Jul 2020 06:54:06 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.67]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c46b4698-64b2-45a1-2dbc-08d81e54b972
X-MS-TrafficTypeDiagnostic: VI1PR04MB6943:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR04MB69435A7B1DEB2D77DDE10F76896D0@VI1PR04MB6943.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:538;
X-Forefront-PRVS: 0452022BE1
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DlRrE58K5/b7DhlJsb0THjFrYVS+S4DJ3V4T1Kn9RjmYhQeXodA9H7TdJbE4yvAEmbUOx78GP8+gHfGL56KQUiBWiNvE+pxeNsqaSeXxcexpRQXbLqe950YJrtwor+UXp4vta3XKMnx8jTUCJI6jiuGdWhgYASi/wNScJcCIOf7QqFCqRc+/JHh0oGI4OOp22w7wEzAaoA+bQ5gH/d8j38mD3tADDCI/f9memK7vR3hf2Ycx3pY7MH4OwQNVvwRMbil57M11GZC0GGgX8XW3sh28/U4PezF21Xsxfx5em7eHYlD75ZQmJ0NvLjsMn7DKnSBNfj3k/sNNXGZ4qx1+0w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(136003)(366004)(376002)(39860400002)(346002)(83380400001)(66476007)(66946007)(66556008)(52116002)(36756003)(8936002)(2616005)(6486002)(956004)(6512007)(186003)(7416002)(4326008)(26005)(2906002)(8676002)(86362001)(16526019)(478600001)(6506007)(5660300002)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: uIMk7m+qw9+tff0rNCnz3swPgxtC3u2rpv/esLM2f24DRrKkSEzVyuJLrIMqvqrjeE91af3LlsWaikT4mE8Pr05larN17kiY7YOG7dWm4tbkGpxgL+DV5stemrj2pYh/XtMngOjXPYcCPaCBECDrTs7xzvEC3xT9FyNoGx7DSBZWRb6tFyu0St5d9CPWbjLoaczKY8NzQcHthD5wiUVUwdGhBG1XWF8lW7DGTuESK67ICKltlwFl5OPnyfNwZXuokbOwCpAfHJ0P7FptRI19ZgG6OXbpuT8ykV2weTFUkiz4yDX/yWlFuCqg/8ZOAF69omSs96+uEiLxqJUmjY14VdHs7q3Q7ViBHxCAyI9JuX2DgpdgOpF2k4rLLhffjKCwx//VYAhoKr6vz7lmCpAtXdjrfUPagPs3INrfpUfpG0eHoXBCS5rOmCI5tv2rUluARF8jAT0/1ZIFQsXAbwDbfMyTZIODfxC3ZSnx5pSiVsw=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c46b4698-64b2-45a1-2dbc-08d81e54b972
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6638.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2020 06:54:11.3757
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sEOtPndWdTG+9DZo5rpzjoCB5FBdLDWACKmRcSQ1KQyv4DCxd5P/3nGB36elyX/xZoPCD0zpWRDtqAoRCCZSVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6943
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

enlarge dma0/dma1 channel resource to 32 and split two parts of dma2 since
their resource id are not continouse.

Signed-off-by: Robin Gong <yibin.gong@nxp.com>
---
 drivers/firmware/imx/scu-pd.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/firmware/imx/scu-pd.c b/drivers/firmware/imx/scu-pd.c
index af3d6d9..9818890 100644
--- a/drivers/firmware/imx/scu-pd.c
+++ b/drivers/firmware/imx/scu-pd.c
@@ -110,9 +110,10 @@ static const struct imx_sc_pd_range imx8qxp_scu_pd_ranges[] = {
 	{ "audio-pll1", IMX_SC_R_AUDIO_PLL_1, 1, false, 0 },
 	{ "audio-clk-0", IMX_SC_R_AUDIO_CLK_0, 1, false, 0 },
 	{ "audio-clk-1", IMX_SC_R_AUDIO_CLK_1, 1, false, 0 },
-	{ "dma0-ch", IMX_SC_R_DMA_0_CH0, 16, true, 0 },
-	{ "dma1-ch", IMX_SC_R_DMA_1_CH0, 16, true, 0 },
-	{ "dma2-ch", IMX_SC_R_DMA_2_CH0, 5, true, 0 },
+	{ "dma0-ch", IMX_SC_R_DMA_0_CH0, 32, true, 0 },
+	{ "dma1-ch", IMX_SC_R_DMA_1_CH0, 32, true, 0 },
+	{ "dma2-ch0", IMX_SC_R_DMA_2_CH0, 5, true, 0 },
+	{ "dma2-ch1", IMX_SC_R_DMA_2_CH5, 27, true, 0 },
 	{ "asrc0", IMX_SC_R_ASRC_0, 1, false, 0 },
 	{ "asrc1", IMX_SC_R_ASRC_1, 1, false, 0 },
 	{ "esai0", IMX_SC_R_ESAI_0, 1, false, 0 },
-- 
2.7.4

