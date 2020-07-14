Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E699921ECCE
	for <lists+dmaengine@lfdr.de>; Tue, 14 Jul 2020 11:28:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727114AbgGNJ2C (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 14 Jul 2020 05:28:02 -0400
Received: from mail-eopbgr50075.outbound.protection.outlook.com ([40.107.5.75]:34030
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725955AbgGNJ2B (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 14 Jul 2020 05:28:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qo+iaEMkZF3jTXVNCQtWQLSMYrqgjIAUGcSUhjCBhVYS22eRahciGW9whBLhD4jMQL2GIIe7pIwaa9gNZLnolvnnFpc9DApqudwZ6hVHb86bw1k03AjjgqfizYuUce1pnH2iEGr7UcZviNPkXW5j/FbOyoa5FJwkVJgCjQT++RzGtQBwWRSKtiUXKvw0E6M0R73m8Vbu0+0xbiS1jIQ3mN3ZvpYc7abrdRViej9mToRv5N5eT7EYPx+EF9otvZ/E2drWHunW2WpVinMgm1iZYSJVtgpj+0zG3aw0IklGEPUwK09P3NIo+Fz8xHEcD9sd1mwkt8eD3oj8BRhRZ6XEqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2oPNSBxTNY2/skpU+HftgqZlcyRxLbDifUvEbmUW7J8=;
 b=cqorzGTIeZ0UC2AoC5yisviMZJ+SCpxLji4c+pdqQjo/C0ov4DDYC6dYsUv+v+67MB0I5o9MpwJo41wIqWa0rUBHfuTlOWn4AakDZq2Kq8P7lvfmnUKdU7ZFvWQpFStLImhHgGJc6SwYbBUpEwXGvotCF3O89wfLk/j2EANxViFAvyhwsq/p9cidTF2Ovk4WZavR9X4TU793MooLnH/X77isi7IobRD9+tiuYd7Ik7IbMCDfF4O2BDkcgxjY5NlEmVYf7vohQX7NsoQbkNyjmHOwJPU2XvDSJMy+U2ddscGCbDqR12d1nC1cAGhSfSC+XfkcgNoYEX5Rfn7QHDR7EQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2oPNSBxTNY2/skpU+HftgqZlcyRxLbDifUvEbmUW7J8=;
 b=P/HcrS6jRpXhbESdhYldQbFGyHxBYQ6gIBlcydpa4VJbS3hBhxQpzR9VCdtXROQQ2P1QUduRZwWAP2qp2+XAA5RTfVUaNos/MmPtJ1kYEigL89PPGFixJtj0t2V+t2FfIa2513VzHPHukXN3ZVJAtTaYXQuzM8EAB4pFczZrLTc=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com (2603:10a6:803:119::15)
 by VI1PR04MB6270.eurprd04.prod.outlook.com (2603:10a6:803:fb::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.21; Tue, 14 Jul
 2020 09:27:50 +0000
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::5cc4:23a5:ca17:da7d]) by VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::5cc4:23a5:ca17:da7d%6]) with mapi id 15.20.3174.025; Tue, 14 Jul 2020
 09:27:50 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     vkoul@kernel.org, robh+dt@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, festevam@gmail.com,
        catalin.marinas@arm.com, will@kernel.org, dan.j.williams@intel.com,
        angelo@sysam.it
Cc:     kernel@pengutronix.de, linux-imx@nxp.com,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 7/9] firmware: imx: scu-pd: correct dma resource
Date:   Wed, 15 Jul 2020 01:41:46 +0800
Message-Id: <1594748508-22179-8-git-send-email-yibin.gong@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1594748508-22179-1-git-send-email-yibin.gong@nxp.com>
References: <1594748508-22179-1-git-send-email-yibin.gong@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0092.apcprd01.prod.exchangelabs.com
 (2603:1096:3:15::18) To VE1PR04MB6638.eurprd04.prod.outlook.com
 (2603:10a6:803:119::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from robin-OptiPlex-790.ap.freescale.net (119.31.174.67) by SG2PR01CA0092.apcprd01.prod.exchangelabs.com (2603:1096:3:15::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3195.17 via Frontend Transport; Tue, 14 Jul 2020 09:27:45 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.67]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 9c2b7b0e-a675-4c40-9a97-08d827d82d2a
X-MS-TrafficTypeDiagnostic: VI1PR04MB6270:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR04MB6270F9639F64B420EF954B2789610@VI1PR04MB6270.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:538;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mnREYlnwy856cwh4u4RHfg+9/OuzVPBnb6ddspjQVbZfxxJEMgpqKlXVCVqrRmP73vvSnVeQ6SDiR9n1BpI3pRgQd1XPrF8jXpUBaZ5Kq4xrDN53o278NfZffw191JvlTxNuiW9ZQBP4LLBnTY+kv0fZKagxdRDXHxkmP13iLCfvA7BepqJiC7gYLMSwbq2yWCRyZlu92SFol7m65+NIHeXwjH7sLbLce4LuWg0H4QqKVlh19ykehj2P8wKYRP6QlGWpPNAS3KTo+24ndb9YscgtA1ID0cfbD5BQ3SHHSaVOfgIY6ZoUrbUyw4faeRIPMQz0oI4l4IXg477U6/6ksw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(366004)(396003)(136003)(346002)(376002)(66946007)(6486002)(6512007)(66476007)(66556008)(8936002)(4326008)(86362001)(2906002)(6506007)(83380400001)(478600001)(36756003)(16526019)(956004)(2616005)(186003)(26005)(5660300002)(8676002)(52116002)(7416002)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: uNfSVcq+oWkfE1jFmvf56OmD7n+Vk15X/Eq1bv83Mb3rj/INBnOFGx+Gf90sL0T/r/dnURukggIhXzHW8Wxd6rWmpS0woAFaB4k64dSiHJrZnJB3jpjcrTTRAcLOBuJ168jE7J94F+Zs+uvwpYEKfInoUUGKrJ9wQtph1acn5uSkQn8XTzrkXxlYOpG9wJ0FsQ5kQuQ0ENiRD4fm4kZyho+5uQ/GCTOiptFrxP83etT5IvSENnZxqODkj8daW0QxTE8LNdK7VWKnRYBXZ8wkhLIx3X2e0365otD23aff6nSylFtlVLho/FNYIh+Xot8K2GAW3gpsNgYPuiGly1TKOWhYF0pbsHYoC5BidmdeNntapli8z5TnxyLeFkykTP1IZDLw8jXLNBxlxfuWGVHgek4Ogg4XUU/esqrCeB2YYuDWCcLeox+/aNWDBwJhcXKAxmp0tws2oEByQEDe5Wnemjg50kjrrjuYAwxaq7yYIPY=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c2b7b0e-a675-4c40-9a97-08d827d82d2a
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6638.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2020 09:27:50.0809
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +xpsjZKPH7UhF96i7GuW/mt4O1E4xemBzMldJayGZDIlkI2q5d3AwDMZF5dk3VWc9z3qixT2erdFakJbttZ4Gg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6270
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

