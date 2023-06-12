Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAE5B72D093
	for <lists+dmaengine@lfdr.de>; Mon, 12 Jun 2023 22:35:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229480AbjFLUfM (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 12 Jun 2023 16:35:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237683AbjFLUe7 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 12 Jun 2023 16:34:59 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2070.outbound.protection.outlook.com [40.107.8.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4212E55;
        Mon, 12 Jun 2023 13:34:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dsWnYkisdcPKVqLsnijBfcVHvOEvijvXQcs2g5QbSlRssvx1+/go+S/iUkZVP9nGGGnzXjeRpA2hBJRNUfX5kEy87hKg/BtnVayi9YMky+CHvOUeZiPwrGtIVN5h+r9r/nUY8tSLGbS6hyjM2uaM7T2PGpn2Ts8RZg3tSCNuPvmFlTiboKb8s9o6Su2iwuE6C8mAVCTa3Rb++MY3tfGnO/lsJ1FAGhNd8OqKLpEgkbgR+xtxHDICRKUu5L0/CQOIlnbREJ0XC4qDS1Nv+wk1IqgTj0PFl4gonM7F7scJEaA7Wdh5DhSJei0/Yc7uze/zlHygI5xm4QZsjhGGvIhf/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s1+6nOaISVZ89Qy4+Cr3cnXLzqMpnDganBMJUwxpjWY=;
 b=frjv5n39dSLUJcuVA5USMZtYxT62XyAi/34NunbeLn4YweVWSom2NBo8eUagdvRxG5tNXI+qCAwHdL53cFDUpeFguEkogD/owmx2AT//f+DNVIN0xElNSXLrU8lb5AIGerm0g81h0xyPVfeRtXbdAqNT5PIYQGblqpTsdzNjKSae1tGsvOkRrPSPwcQV08/Q814IWW8Rh8EPJx305qopI0N5xJfaeCnPuiRUPXDOh6DbKCygvuqtmkNjXzyAP1OnXEGfr1d7OstFPnlHJCoP6XLfWd6SqRloX6bcQc2/T06WWEZHKqeuHjmMUoxqoLRkIHPFEdKA9KxG1dwABBTw9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s1+6nOaISVZ89Qy4+Cr3cnXLzqMpnDganBMJUwxpjWY=;
 b=CvKKGUwmxmZVSo2YXcVHmaR89uBxnfRisFnlQaXZslx4oNq/3w5WLbIaoQP18wHzN1NGbAhuqqb733/lyN91Q4EGfN1jvr3l/MGdVXjo/GQd3LJz7psKfEJLmrnE+iHhG2ljGQIV0k+Hflm+ByOQTWTEZUFIK7RbfpWqSmIGbto=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB4845.eurprd04.prod.outlook.com (2603:10a6:803:51::30)
 by AS8PR04MB7975.eurprd04.prod.outlook.com (2603:10a6:20b:2a4::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.36; Mon, 12 Jun
 2023 20:34:55 +0000
Received: from VI1PR04MB4845.eurprd04.prod.outlook.com
 ([fe80::602f:42ad:882a:5ca7]) by VI1PR04MB4845.eurprd04.prod.outlook.com
 ([fe80::602f:42ad:882a:5ca7%3]) with mapi id 15.20.6455.045; Mon, 12 Jun 2023
 20:34:55 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     vkoul@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        peng.fan@nxp.com, joy.zou@nxp.com, shenwei.wang@nxp.com,
        imx@lists.linux.dev
Subject: [PATCH v4 06/12] dmaengine: fsl-edma: simply ATTR_DSIZE and ATTR_SSIZE by using ffs()
Date:   Mon, 12 Jun 2023 16:34:12 -0400
Message-Id: <20230612203418.2017769-7-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230612203418.2017769-1-Frank.Li@nxp.com>
References: <20230612203418.2017769-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ2PR07CA0016.namprd07.prod.outlook.com
 (2603:10b6:a03:505::16) To VI1PR04MB4845.eurprd04.prod.outlook.com
 (2603:10a6:803:51::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB4845:EE_|AS8PR04MB7975:EE_
X-MS-Office365-Filtering-Correlation-Id: fcd8fd89-7fa8-4704-c89b-08db6b847b56
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /cE+36kY187A++OJ58UZd33TPsRjV8J9BW1eyhvsAjAdi9fsll2w6erXoNlvbN8T15FCK4CBH3ii2JZs5JkqCStmBIG7028gWlGE6f0UGBWRmOUPjci986c1BI810RUScel2TThmA4oVCsQCesyAnxdCrgVvrAe0mqN+AY9/DsSOJa3T5+2eYU63HIxVkg4AGP/8+PJQ1d8zF3Hln/MH4d05+8+8LnzKdeyPfWpSeFIXC3lizkSY6HjPei2ot4Oouj8cueOVeti53WkLjmi/7BqiGvfyePrLpl/9IJYcMVVWuBWdFpZP1wBqGQuWBP2624DUKa3iK2cQocVt9C4LNPeGuhThDCzojTPj4IUh1/YfCWUCIN3xXJH9SXIk9s2SeA4AB3Qh38ASNPgR+k7GvTQl5TiJ/bKOj7KeaFEfD8tjn4SduxMnuweVIqtOPM33phDIJC7atK2qVrIOA80yTwt2o8vRm7LHlKePUBjnfuR2lU4HQk3AjgLoLDLD2nUincpw3nfOIhEtioDBkjQ4ctdDJVcfkIET6vdEnFqNhv78LLF+21E9hk26Xnv0qlImMQd54iXV0ZGqF7HX5p0+o2a29xcn+rATflaApR3li8ozTfU+XGyeQghp50ev079n
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4845.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(366004)(136003)(346002)(396003)(451199021)(36756003)(1076003)(26005)(6512007)(186003)(5660300002)(41300700001)(6506007)(478600001)(8676002)(2616005)(66556008)(66946007)(83380400001)(66476007)(6666004)(8936002)(2906002)(6486002)(38350700002)(38100700002)(316002)(86362001)(52116002)(921005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DIxOKJZXHdHe6rxt412ZDRK8s+neDQd9hSpHttgDJvCOTCuzNsPApw5abJLR?=
 =?us-ascii?Q?fKE8IhgKFhcgseXp/RqQPPILhyw5esDZdAlpunRNhaStSwnFZ/Oxnr9LsFHx?=
 =?us-ascii?Q?5ZalyBpbv7Yaq7YsSH+i/gF016BHDaQXUFdGdO5RgbqekWGYCWl0cmbuqUhp?=
 =?us-ascii?Q?1z4QSDde6DcrRqpE5zwUNf/+0RTl/DU53Y9AD4kEk5uwgQHbSlfPlOpkzEKz?=
 =?us-ascii?Q?LvwZ4FskTTZy+UXZOu3YoIzn8TVNi+6HiZMpPwGkKagcjo85moymgCd2oDVk?=
 =?us-ascii?Q?DsDWPot6lLfXOytBfyuBxNWGgRb7gdNO5PxgxUGMMqhU7DllckreP53jSAOe?=
 =?us-ascii?Q?62zr2KYvV+qDXNvHZ+2KfP9zyO9XYNQ3itAm0JfyWpuAfeD9KkVJVenYWIMm?=
 =?us-ascii?Q?+aIQZhQaDB61ziPtGUQ8mzF+oR/7Bo4cNphH8nXhwF/WECIIN1C84lcfZnHP?=
 =?us-ascii?Q?+S0ecpzKpp5B6wpXKB9ursaHsRLuKpUuiBc02LP68QSnyV3BiTzw9oZH/DIV?=
 =?us-ascii?Q?5j8WvC/TUyXpQj9seCfJiy2nP/S8waIpGEZaXNBy3AK6ttbDnsgOIlYBI6w+?=
 =?us-ascii?Q?XPxCMspWFwkVs7ONIaySfmlJlCci4GUdVKlpY61Nij4fzLI5SuqW3iDTSDTf?=
 =?us-ascii?Q?v9JlHliMv263KDkyGE/XcqCvD9tumXFoUWwJsEvIXfhys+SXKA2wAzr3je4e?=
 =?us-ascii?Q?Gfw1xMsmFUI4MSUhc7nPAQ+oFZx5mzf75i3L6ge/sOqpUTnWmzphfJfOffVc?=
 =?us-ascii?Q?oiUTAzsYRlxnwTiph3bBIfAyC4EkSUvVm+xOHX8Fp58mnYCc6zTKlByo4ZYD?=
 =?us-ascii?Q?hmVXo3ExXemFeDkXOcwDom+ppz9simvLHYnEpV3R5r3OgcVOmrLV/zSmlWtP?=
 =?us-ascii?Q?Bh7NoasOZZtnNMJ2VDbArxOYYvOIDLEVEwseszSeCel2uQBs6uVcc91z626a?=
 =?us-ascii?Q?6tvqpCAdx9BOp+xF5uluFh42BvIZ1pGOPrP2mKaz5g+SccAqScVg284PEy8p?=
 =?us-ascii?Q?6KkOBcnMAuA2LJVNbijkoIE1Aw5s9DjXvfp1fsosN9xsw6xFG9+MsMHbAqZJ?=
 =?us-ascii?Q?ABvWih9ZA22eLYK5yWkar4ZHp60jg7Q8oFyR0Vy0lJqV0XQMN59J2ku0Vx6A?=
 =?us-ascii?Q?NApVrZQ7Qm7Xuvwy1MB3FnkyPDS1j/Vb4N/GeKre2+5Kj1XIyOjc4tbNmTtQ?=
 =?us-ascii?Q?cXhKq21aXrLebf/DnGr2qKE+MGkumXGtcJhyenHaZ6TZceb33BmkKZXPwkQn?=
 =?us-ascii?Q?eY1IfHmKGRfkFvOlEgE147JolxBmdpK5VhbX+N41hkD1WtRpZo64n6aDlPAu?=
 =?us-ascii?Q?3Yka1YKaws/h6ygY402QOqtSaz4L1I4XTawkezRCRyXueBWxH/EbzhYGOZlH?=
 =?us-ascii?Q?ACg5v/rKgGfmknXfwc+4zcFN5YmCBB+vsmBE5i8cgMzcWa8AjDPKl6o+WXbv?=
 =?us-ascii?Q?eS2vk04u8DZbtYm0Zh4kOGWx3mYf4puPhUnLCcXjIsCyHUt+rEGRL1EMSkaJ?=
 =?us-ascii?Q?Ec8AQBGBDWPjG25UeMmekgLjXgBUsoW1EWhYBni8PZSynHGVvU1V9i9KUBeR?=
 =?us-ascii?Q?cnzv46JTkGGUSt+Nb+xv3jKtZNfbq4ARpBV4+j/M?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fcd8fd89-7fa8-4704-c89b-08db6b847b56
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4845.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2023 20:34:55.3888
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RhulOJXP7X/sXmJPDxncGjbCc8cmNudEDU6Uy5gTFiZhZMuHe62nmMaE5IlVhznk8N6BiqVtodYGkWyX+GWW3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7975
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Removes all ATTR_DSIZE_*BIT(BYTE) and ATTR_SSIZE_*BIT(BYTE) definitions
in edma. Uses ffs() instead, as it gives identical results. This simplifies
the code and avoids adding more similar definitions in future V3 version.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/dma/fsl-edma-common.c | 21 ++++++++-------------
 drivers/dma/fsl-edma-common.h | 10 ----------
 2 files changed, 8 insertions(+), 23 deletions(-)

diff --git a/drivers/dma/fsl-edma-common.c b/drivers/dma/fsl-edma-common.c
index a9d17cf142fc..51fbd7531c74 100644
--- a/drivers/dma/fsl-edma-common.c
+++ b/drivers/dma/fsl-edma-common.c
@@ -154,18 +154,13 @@ void fsl_edma_chan_mux(struct fsl_edma_chan *fsl_chan,
 
 static unsigned int fsl_edma_get_tcd_attr(enum dma_slave_buswidth addr_width)
 {
-	switch (addr_width) {
-	case 1:
-		return EDMA_TCD_ATTR_SSIZE_8BIT | EDMA_TCD_ATTR_DSIZE_8BIT;
-	case 2:
-		return EDMA_TCD_ATTR_SSIZE_16BIT | EDMA_TCD_ATTR_DSIZE_16BIT;
-	case 4:
-		return EDMA_TCD_ATTR_SSIZE_32BIT | EDMA_TCD_ATTR_DSIZE_32BIT;
-	case 8:
-		return EDMA_TCD_ATTR_SSIZE_64BIT | EDMA_TCD_ATTR_DSIZE_64BIT;
-	default:
-		return EDMA_TCD_ATTR_SSIZE_32BIT | EDMA_TCD_ATTR_DSIZE_32BIT;
-	}
+	u32 val;
+
+	if (addr_width == DMA_SLAVE_BUSWIDTH_UNDEFINED)
+		addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
+
+	val = ffs(addr_width) - 1;
+	return val | (val << 8);
 }
 
 void fsl_edma_free_desc(struct virt_dma_desc *vdesc)
@@ -623,7 +618,7 @@ struct dma_async_tx_descriptor *fsl_edma_prep_memcpy(struct dma_chan *chan,
 
 	/* To match with copy_align and max_seg_size so 1 tcd is enough */
 	fsl_edma_fill_tcd(fsl_desc->tcd[0].vtcd, dma_src, dma_dst,
-			EDMA_TCD_ATTR_SSIZE_32BYTE | EDMA_TCD_ATTR_DSIZE_32BYTE,
+			fsl_edma_get_tcd_attr(DMA_SLAVE_BUSWIDTH_32_BYTES),
 			32, len, 0, 1, 1, 32, 0, true, true, false);
 
 	return vchan_tx_prep(&fsl_chan->vchan, &fsl_desc->vdesc, flags);
diff --git a/drivers/dma/fsl-edma-common.h b/drivers/dma/fsl-edma-common.h
index 242ab7df8993..521b79fc3828 100644
--- a/drivers/dma/fsl-edma-common.h
+++ b/drivers/dma/fsl-edma-common.h
@@ -29,16 +29,6 @@
 #define EDMA_TCD_ATTR_DMOD(x)		(((x) & GENMASK(4, 0)) << 3)
 #define EDMA_TCD_ATTR_SSIZE(x)		(((x) & GENMASK(2, 0)) << 8)
 #define EDMA_TCD_ATTR_SMOD(x)		(((x) & GENMASK(4, 0)) << 11)
-#define EDMA_TCD_ATTR_DSIZE_8BIT	0
-#define EDMA_TCD_ATTR_DSIZE_16BIT	BIT(0)
-#define EDMA_TCD_ATTR_DSIZE_32BIT	BIT(1)
-#define EDMA_TCD_ATTR_DSIZE_64BIT	(BIT(0) | BIT(1))
-#define EDMA_TCD_ATTR_DSIZE_32BYTE	(BIT(2) | BIT(0))
-#define EDMA_TCD_ATTR_SSIZE_8BIT	0
-#define EDMA_TCD_ATTR_SSIZE_16BIT	(EDMA_TCD_ATTR_DSIZE_16BIT << 8)
-#define EDMA_TCD_ATTR_SSIZE_32BIT	(EDMA_TCD_ATTR_DSIZE_32BIT << 8)
-#define EDMA_TCD_ATTR_SSIZE_64BIT	(EDMA_TCD_ATTR_DSIZE_64BIT << 8)
-#define EDMA_TCD_ATTR_SSIZE_32BYTE	(EDMA_TCD_ATTR_DSIZE_32BYTE << 8)
 
 #define EDMA_TCD_CITER_CITER(x)		((x) & GENMASK(14, 0))
 #define EDMA_TCD_BITER_BITER(x)		((x) & GENMASK(14, 0))
-- 
2.34.1

