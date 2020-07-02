Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A76E211C2F
	for <lists+dmaengine@lfdr.de>; Thu,  2 Jul 2020 08:53:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726068AbgGBGxv (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 2 Jul 2020 02:53:51 -0400
Received: from mail-eopbgr60058.outbound.protection.outlook.com ([40.107.6.58]:45039
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726805AbgGBGxu (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 2 Jul 2020 02:53:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TptrUa5QYaF/l8p/05piu8ETPcA/t6X6BrI5FYINVau0gOhddD0PO2ChQzCLLBeqaO1kE0BxSaOidbFCQFdJc4hQbOw9huCQjuSvjo1waGaiJPadGw4zOW2OY1G9YUV7d28a+APDRkGyv8HdZmGhbRKIHLqL0G7bs8HbUaG3nwH7Wpq7aNFai1650wcUDrrm/RlXyPXyhnETi/erFb5/Me0pYhtlX/eRoLvvoyc5M09gK6vJ3PB3rSI/+cf9742b7LmqJwuRdmRUx/Nf6i7Tikjx9kexwrajaXMvi6NbltVPyzt5nOZ5EM2g8dpOcA+afeOQC8RVJMm1NQzu4FLzKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wnGtdIP/hbdfvrIHlyCNUJzLtnZLrNC7lK23LHA+0xg=;
 b=QVK8BwB24HBJf5m3lhPz9lFGzIPUjuaFNa/ucWs/By7O8Lf+mOk4qm5vO8wK4lFkOyJmzzk+eONLE191GGneiMrt5C0EMZfTbclFRBmuOA32+S/7By/Tl4IDv0Qek6ol3lFKghZmzw5jrRhGY1k5AGZIj3ATl5vFs4vAXyw0k4anv3iJyh1EeCMGeKGcoZyGExY2fTGL45v3UKGRN30xMZ0uF4Qi09ps0uauZwZDEqy+EB0sRT4GbDYrqc5JQrPONpfgmeI2Rs0OiMlMJv6UX2YLv+kTpOirdaJaK50UYAuc9cxrQ/zTab7Fs730UjoO7sKqcNLbP/A1q6E6GBPJ7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wnGtdIP/hbdfvrIHlyCNUJzLtnZLrNC7lK23LHA+0xg=;
 b=HWWTK9XC2jkJG7AaB7Ddlf9e7q1KFASzC7I0nkGQJPJoY15fCCqjhWWdAs+kJvfYTBu0YSfLhbi4RFfRF/6F6vPasLi5YREik+Z/P7nPAtdZ5I5dshryEjeeIIk4zd+UVXa9ov0kNnwaaYsEDluOrfgUHknCb7ArJ8hy3vFY+VQ=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com (2603:10a6:803:119::15)
 by VI1PR04MB6943.eurprd04.prod.outlook.com (2603:10a6:803:13a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.22; Thu, 2 Jul
 2020 06:53:46 +0000
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::5cc4:23a5:ca17:da7d]) by VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::5cc4:23a5:ca17:da7d%6]) with mapi id 15.20.3153.024; Thu, 2 Jul 2020
 06:53:46 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     vkoul@kernel.org, robh+dt@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, festevam@gmail.com,
        catalin.marinas@arm.com, will@kernel.org, dan.j.williams@intel.com,
        angelo@sysam.it
Cc:     kernel@pengutronix.de, linux-imx@nxp.com,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v1 2/9] dmaengine: fsl-edma-common: add condition check for fsl_edma_chan_mux
Date:   Thu,  2 Jul 2020 23:08:02 +0800
Message-Id: <1593702489-21648-3-git-send-email-yibin.gong@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1593702489-21648-1-git-send-email-yibin.gong@nxp.com>
References: <1593702489-21648-1-git-send-email-yibin.gong@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0172.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::28) To VE1PR04MB6638.eurprd04.prod.outlook.com
 (2603:10a6:803:119::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from robin-OptiPlex-790.ap.freescale.net (119.31.174.67) by SG2PR01CA0172.apcprd01.prod.exchangelabs.com (2603:1096:4:28::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3153.24 via Frontend Transport; Thu, 2 Jul 2020 06:53:42 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.67]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 48ce6396-f159-4a1f-f977-08d81e54aa93
X-MS-TrafficTypeDiagnostic: VI1PR04MB6943:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR04MB694328E7F427F91ECDABB61A896D0@VI1PR04MB6943.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1247;
X-Forefront-PRVS: 0452022BE1
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Lk0G3pU/hVc210r+HI6BiyeGbAb8YtYQ3vH2p8Zl5+Yn6cNYxsGXigy0OtLKYvhiwpC0CJ6BQCDzxTZzdT7YDjihzlPusI09t8CKg61H/oVd9y/iEN0GCVavmQ2NGsGFBy6ot4vJhPbofuOHKfB6ZCNYXzBLnEM1+5dmRiM9X3lFxq4xKyxauk96bJzKi5q9Xr0fKYQytEVhWjp/gDehT83WgMg+ruSlTwgzgz1kocl8U61NKlswhT/LKyMFbSloMHRcHI6qCrCJ1/8jcwcqmhpVHyUAJ9CMiRmpHelD7wiMFC1Y3DLnxtETWXVJnuvBvBcfFJLyle5Gglewnf/UNg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(136003)(366004)(376002)(39860400002)(346002)(83380400001)(66476007)(6666004)(66946007)(66556008)(52116002)(36756003)(8936002)(2616005)(6486002)(956004)(6512007)(186003)(7416002)(4326008)(26005)(2906002)(8676002)(86362001)(16526019)(4744005)(478600001)(6506007)(5660300002)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: xWOxiCM6cwZJonh1nzh+bHhrNUv9CES5uzKKbylO/2hpaclcReb59+DVwUAmvwKlXLOGzmKkzXERLSnpDEuo104g+AoNvcmm6AWT2TcYyqsLTEqa69Ustk+58dTy9R2Ufkj894NY6uJSlDYTO0DdMwrfMpO3j4v5qTRjVtbUQX9D97+V5fw+OtQonkzCZeroJpWmOtFa4SsFUVMiHy33TBXlM2hnYy+CMBbV7NcnnqP5UrXczqtG4WHZY0h2t8LI79SVXdKvQQ9gl8TxpIkwjooE8hSPkqCjEX+LEnPGrZur0F4gbD+eMieFk7Sk1aVLhHZDqeYeV2x8cD+d7X3MyGYhI624AE2VmJXMAWyGwWjwoIRG++FOw+/i93cfNMO1VdMypOs2kFkPc0gg4eA9XML01h2D5NQhDiUjut/UYnWApKtKJjjYBdF1qf3uF5XhQraPdnKvvnX4KMPCztRF8KGg2KRdnlI5fb9melLzqu4=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48ce6396-f159-4a1f-f977-08d81e54aa93
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6638.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2020 06:53:46.4333
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: np4HXcxLulTG5mgEzvPpOpkxHERyozaJEC6tTQ2FAsCaja5fX3aPLrPad/2eZkRwicSmaFLGDVdKhDGEEhIKvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6943
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

