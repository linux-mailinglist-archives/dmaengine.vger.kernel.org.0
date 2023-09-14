Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D34797A10E0
	for <lists+dmaengine@lfdr.de>; Fri, 15 Sep 2023 00:22:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229499AbjINWW2 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 14 Sep 2023 18:22:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjINWW2 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 14 Sep 2023 18:22:28 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2072.outbound.protection.outlook.com [40.107.7.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A84D126A4;
        Thu, 14 Sep 2023 15:22:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S+prglfJ1xzicnsgSoTOBmVi2YGluFqs6YYu+rLLswoz55YEODQ+QH2KWcFv1xgQ9TZzed/GTGlT1+JDjYuhmum2PCBqB7pRG/gTYS9zqRtmv3HLtU3KInp1UD7zVzPtz1domBSoA6NwTNgZfcTwydICi/AyNN3VIqDotWPv7iVkdric+ziR36rxq5s5XAE2ozadj0G6aTR2CGEgn/uhpJ+FAxjdcT0GsAoqSZmzs5/ovYHC4aSl67B+1Mx0Bp550ptkQWO26vGXH+l92akN7gDt7W8DnJ59KwrTipphMt7evTdRvRIHkny+tkhNMfik6SzqMPnI+S+efFJFJ6NiSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ygC6b8BJ02WxP1eS8ksbhS2iLRFEXexgKg9Mq4jv+C4=;
 b=Xjts/Gae3mwJ7mMVRHpS7ZHHCzb2y17nKd+7iyMlu/SrzWzYrZS934CgXLkFNt/da4w67mIiaykKB2QRJ9O7q731XzO8KBnkBP4DP4e4va7zYwL6foEOgXdUN5epKmPYTH7cCQhn10xMKLEh085UQttZIYdaCKP2zveaRWzWvocJDQpvDYkLETCTmNDbOGzP+NGL8UyMFHDQ0Baoa2XFk2NE28HqeDNpj5SKg7Fdxtcb1B6HbqaWud++WfTJknUHfpv1LYPtavuCP3bQtgOpPOmJafY9KA8KQ1q8iRdgqRClrnorOvCuuyRl3gH1Mz/RzZI74X1vznTZpFTIVEQrTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ygC6b8BJ02WxP1eS8ksbhS2iLRFEXexgKg9Mq4jv+C4=;
 b=RuuIrl49mCf0ILpcTsSJ0CR+NQETom8pS6KOhtJ03uLnURaWL0p0hUv8Pm1pL/6hUJ9IVmSfzDnRWtVKyL0LTWDVxNax3rBJcW36SUCksgWA+fUyqqyYhZNMtyAMWBDIuRbcTPKvr6B88Ar541YwydXE3pQnork47vdK1HQoTx0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by PA4PR04MB7552.eurprd04.prod.outlook.com (2603:10a6:102:ec::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.21; Thu, 14 Sep
 2023 22:22:21 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::aa90:117d:c1d0:346a]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::aa90:117d:c1d0:346a%3]) with mapi id 15.20.6792.020; Thu, 14 Sep 2023
 22:22:21 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     Vinod Koul <vkoul@kernel.org>,
        imx@lists.linux.dev (open list:FREESCALE eDMA DRIVER),
        dmaengine@vger.kernel.org (open list:FREESCALE eDMA DRIVER),
        linux-kernel@vger.kernel.org (open list)
Cc:     imx@lists.linux.dev
Subject: [PATCH 1/1] dmaengine: fsl-edma: fix all channels requested when call fsl_edma3_xlate()
Date:   Thu, 14 Sep 2023 18:22:04 -0400
Message-Id: <20230914222204.2336508-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR01CA0055.prod.exchangelabs.com (2603:10b6:a03:94::32)
 To AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|PA4PR04MB7552:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e69d5f4-7182-4918-d72a-08dbb571100c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mF7mTvJ3nkdAPaVjSO3LYd/lUvot/8pgJZZrSgfMWCw+JFxxomzTspZubdL/Sp6rzOnd8nvn2XvzyNEIOrLe64BE+6rnMqVwRpBLW3u4K+BDsXEsJUvkMuIGPy7H3SvEQOBEMfXiBXGwV0+VJkfzsMtQTOQRienPWss/p14RP/S88hP/f1b0p0JAfqiiy8zeEsF2GQqjcfVhpRR+64mF2jrXPofSoJJz/8Bslg7H9AU3dEjAzUk3YFA8/kT1wq3B/Y8GRTZQybjtTwIfuo8p7w9PEfVMb6KMJu5rTRi82ZB5viI/5lJVGUxVVryl3Cp56xka+8v1//U5jXJOKipWsBgD9my3mIn6mNw26yOcbllsypjDbAZBR068tCevjfT6wbjTUqOU3INC0D1rRlOx4a11Umh6rL31WmHFtx/yhGqzchIH1AeGBXg1DFlNqbF6yBdbeyrKThWjiFbJF9JfpUcqMDSjp55pEbsQ/tM8frzgVgtuSCiysgAWBzMR7ydNUXdjQdXGMuGq09VJ9UQcGmwk0DFPWzpyxmhOgqCr/JxJZIAGv0U2Pc0q3QkKKmFLeXAhaT9dIEeVoXLovBa+WalbqYw/MCj1YopWp9pIQsEkto3RjTUOPMNR8Ve1bxrE
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(346002)(136003)(376002)(396003)(451199024)(1800799009)(186009)(83380400001)(2616005)(26005)(1076003)(2906002)(66476007)(66556008)(66946007)(4326008)(316002)(8936002)(8676002)(41300700001)(5660300002)(6666004)(6486002)(6506007)(6512007)(52116002)(478600001)(38100700002)(38350700002)(86362001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+co+yp2TNxBXXm3EKWg2V5BpZLcWKuO/Tq0ExsN9tlsXafQGQKRTQcii4dui?=
 =?us-ascii?Q?QA2noODGE1dwkh6rd5NZ76PDZn1m/UP3xaQ0NuWESWQp2a78ztnXlvl6P5ST?=
 =?us-ascii?Q?2uzFgSAS4MbvHHoaiA6EbDVHuRBnHyj6zo5EEtF/1Bk/uAeZ23NTdSxKZ9h6?=
 =?us-ascii?Q?vXevo/PnudwfDU3QD4uxaNftkCR/8WDL+kahaOYTvstRVqZkA5UpGgvfnbEx?=
 =?us-ascii?Q?UsRNdb5eiJmwT8jhEJh7rS3lhIA9pX7GO6YtgBzTNVh65HS/KdtcI8fSEapK?=
 =?us-ascii?Q?Z+ByOlRbCvUuLFqK3JDOVZroH2sVauBytQTItumxs18VBAeFlh58tyHaZ1cn?=
 =?us-ascii?Q?LxCFVCnnIA2kpXudf47RyHqXAFz7rfqCHp0Assp+e/ugfcnivnK6GQp3VJb3?=
 =?us-ascii?Q?eKvRxcGBcLuIuemoJZRJqTuc81ccByBj78I1i8YJrwupCSRqCLTkKWSlcDeg?=
 =?us-ascii?Q?DNBN4z7dNyraD+mdlNdHawHj1SFqx65yxahe6kdKkUjU1RrKvAvawrr2muU8?=
 =?us-ascii?Q?iycpzTw8XsB80dabInDE2iG+nLG+Y8w3g0mYwxNwNXvT4wylsbvVXv5e9z/3?=
 =?us-ascii?Q?0J2MuPNU52zpE/CUNJ68JtShGzbBlDPG56A90+OlCYp5wJZgOKZ0xwHKC94p?=
 =?us-ascii?Q?8KPonOz10kNvd0BTdMewdHCylxJD26+1xDZ5ZrA/vm6b3AhGyGx/ocYFwTO7?=
 =?us-ascii?Q?+uUGiSr1Y8JSFMG3SscQMFDgWVV1WghUE4elXfIyPl1jyD5uGLW6A47MtbRp?=
 =?us-ascii?Q?9GqONtXd6593x5cYw9DCT+Q5cotZPKwm8p4XzMDePKoFjmeRGNhfjbYEHoB9?=
 =?us-ascii?Q?I7C4yTWoVSD1uXHMeNsyP6zOK46L7LMXB9qRhjYOB1NlLFug0iauOnSjIUQS?=
 =?us-ascii?Q?mx9nlhzGzmZBklcwp3q/q+FeXKCGx4HvzJ/p1gII4Q2XMS6L+DI5aIQBAZlF?=
 =?us-ascii?Q?0ZH1Kxj50EQ0V9hH09Z95Zm3Pl7DYnEhu/I3qF1JDp7SHoqu/vPYE75J8ylx?=
 =?us-ascii?Q?Pnyn/KdXwiq9v+IuMaPAMbx6PeszD8Pq58w6tI0isHW1wqmZmsfgD1d3brzR?=
 =?us-ascii?Q?25+dCxy7/g4TtnxhjN8sKmb9KlwNFOFO0+W88eSVUwCv36Jbw9M2tC3kwrQ5?=
 =?us-ascii?Q?eaB3wSOuSPgqU1PiYzT2ZuK3RhWaWZO+rhzG0/8kSwcSwJ2IuvOot4yiSrxh?=
 =?us-ascii?Q?XEPguQSc9GUXpWYPN/jjPx9bVvZRLslV0fY3RqN/hjWdUPQZjfxoDFa/mO7N?=
 =?us-ascii?Q?48YRNYZkGSH0C+Lu8nZiSFMle+W/XAe4m7PQr2AJXPoIiD7gulaLBw2rnAnE?=
 =?us-ascii?Q?vIiJltREGQQl1apxvvOWF4GKrwU6nWCJGkfLyOqqb5C4SvkT056dur4hiVH0?=
 =?us-ascii?Q?0Yeq1+J1M2BafXGvacbmdJaMWu1y1EQoqo07YaewggD6fyaKjg+EzDPjTgWR?=
 =?us-ascii?Q?i0rHOxIEgs1t3Ba9p0P4gz9uBWz34cSkfdEATIdE8q2fXvQbJHInLZpxq5HR?=
 =?us-ascii?Q?8UrzS9/EXb+Q1fIcRqHcJ4i2mS1Imx3TVAP9rsFkIyh7ADtxq0QYiipbT/+w?=
 =?us-ascii?Q?DuOJgdXHCVeDI6mQvALS7l9zau5EtPtPZtsd56IC?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e69d5f4-7182-4918-d72a-08dbb571100c
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2023 22:22:21.0209
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hXq62Rjppq1iqrO3PR+PpM0eoOcRULQNezDBvP4ju05Mzr2KI2wqH9IfwhKDyMbUH/D9cWcOHwUOs0/RdT+Dfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7552
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

dma_get_slave_channel() increases client_count for all channels. It should
only be called when a matched channel is found in fsl_edma3_xlate().

Move dma_get_slave_channel() after checking for a matched channel.

Cc: <stable@vger.kernel.org>
Fixes: 72f5801a4e2b ("dmaengine: fsl-edma: integrate v3 support")
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/dma/fsl-edma-main.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/fsl-edma-main.c b/drivers/dma/fsl-edma-main.c
index 029a72872821d..2c20460e53aa9 100644
--- a/drivers/dma/fsl-edma-main.c
+++ b/drivers/dma/fsl-edma-main.c
@@ -154,18 +154,20 @@ static struct dma_chan *fsl_edma3_xlate(struct of_phandle_args *dma_spec,
 		fsl_chan = to_fsl_edma_chan(chan);
 		i = fsl_chan - fsl_edma->chans;
 
-		chan = dma_get_slave_channel(chan);
-		chan->device->privatecnt++;
 		fsl_chan->priority = dma_spec->args[1];
 		fsl_chan->is_rxchan = dma_spec->args[2] & ARGS_RX;
 		fsl_chan->is_remote = dma_spec->args[2] & ARGS_REMOTE;
 		fsl_chan->is_multi_fifo = dma_spec->args[2] & ARGS_MULTI_FIFO;
 
 		if (!b_chmux && i == dma_spec->args[0]) {
+			chan = dma_get_slave_channel(chan);
+			chan->device->privatecnt++;
 			mutex_unlock(&fsl_edma->fsl_edma_mutex);
 			return chan;
 		} else if (b_chmux && !fsl_chan->srcid) {
 			/* if controller support channel mux, choose a free channel */
+			chan = dma_get_slave_channel(chan);
+			chan->device->privatecnt++;
 			fsl_chan->srcid = dma_spec->args[0];
 			mutex_unlock(&fsl_edma->fsl_edma_mutex);
 			return chan;
-- 
2.34.1

