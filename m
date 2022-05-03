Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 693D3517B60
	for <lists+dmaengine@lfdr.de>; Tue,  3 May 2022 03:09:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229496AbiECBJj (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 2 May 2022 21:09:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbiECBJg (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 2 May 2022 21:09:36 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60088.outbound.protection.outlook.com [40.107.6.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C32C14506D;
        Mon,  2 May 2022 18:05:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TPiYfY6kR3n1hNWZep6642kyCvTXq9cFdZ/x7oRPpsYFdxdlBBidvJpaojPgP5ftIX8PmSw2BPRXK/qwiS12OikvrVZF6eKAbBZOKnQZbIy+vc7hrvLZLvuMb84ooS9JT4gORx3F4auvk0zTdWb9OioE5Dafu1BXpLaR9IRTZwik4gW0CChiFKS8wE84zVITU6SOz/d5WWQqVrCVC41lIgl8PMu7tuDa+KbHRKUdYxrr3CbOeRDqbvz/60b8udlkPHCE9fQgETJYH4zGDAoo1V0ToQ0JrnsM48au7lS2oF6E6muNKE92b9Ugw4CSKuPaDgeO2B02kCG1ezuT++nLMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NxBaptBY0B6eF28+OVi2psqGE7FdEfffEn8o6EmwaWg=;
 b=l/fAm1jCnfwfEOHFWi8FnIfz0U3MuvlxMLYkjI85+D4gV4RYIS/6h3CAFKdKwzNV/IEvFwD0TyD5/V1HX2/f0B1zkZ8BKNAB9+mjre1FhyIJD5Lua0LT3n46XT1uDOThR5loNJyjrevfFT2tnenu6cqOkwXAhx8axiMw7kdSBxJRqJ327XgZxQp5VBeNmLkaEz+whEQ1I2aS7q2Hr07a3509wum3SFdXtlZjZOnvB7ArVg5pn+rnEYho/Rzl4RNzdaDgEpUKO3YomjDA8nA517boBcEfNEH9sJWPTPkk4m79hrcPqueRLggyOdnMSW3zR9J6XffVYcN8xGNY0vVAAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NxBaptBY0B6eF28+OVi2psqGE7FdEfffEn8o6EmwaWg=;
 b=rLk7yHkSyF1hwOIwRIHoS0NZe+igkSfUmPJZlK2JEeQMVDSsCdF15VfxBU47MSYsvNQvTxENnkY11CYkN419FTk7RfCmEX0YaL4Vb9WqsI1TJxQla6SUGfv9EG8ZU5snlnxSeBog0dc6LoBYONqOVwV1r/JZT0J6RrJUtHHUMTs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com (2603:10a6:102:232::18)
 by AM8PR04MB7364.eurprd04.prod.outlook.com (2603:10a6:20b:1db::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.24; Tue, 3 May
 2022 00:58:53 +0000
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::adc5:45f8:fa40:1b8a]) by PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::adc5:45f8:fa40:1b8a%7]) with mapi id 15.20.5186.021; Tue, 3 May 2022
 00:58:53 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     gustavo.pimentel@synopsys.com, hongxing.zhu@nxp.com,
        l.stach@pengutronix.de, linux-imx@nxp.com,
        linux-pci@vger.kernel.org, dmaengine@vger.kernel.org,
        fancer.lancer@gmail.com, lznuaa@gmail.com, helgaas@kernel.org
Cc:     vkoul@kernel.org, lorenzo.pieralisi@arm.com, robh@kernel.org,
        kw@linux.com, bhelgaas@google.com,
        manivannan.sadhasivam@linaro.org, Sergey.Semin@baikalelectronics.ru
Subject: [PATCH v10 8/9] dmaengine: dw-edma: Add DW_EDMA_CHIP_32BIT_DBI for chip specific flags
Date:   Mon,  2 May 2022 19:58:00 -0500
Message-Id: <20220503005801.1714345-9-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220503005801.1714345-1-Frank.Li@nxp.com>
References: <20220503005801.1714345-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0P220CA0024.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::32) To PAXPR04MB9186.eurprd04.prod.outlook.com
 (2603:10a6:102:232::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: adbf4624-febd-47d8-0386-08da2ca017b0
X-MS-TrafficTypeDiagnostic: AM8PR04MB7364:EE_
X-Microsoft-Antispam-PRVS: <AM8PR04MB7364547D5CC14F875FF6ED7B88C09@AM8PR04MB7364.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AVR5Z+PSYwP9VjlhQQbJmk08aM9n8zIpn4f72IRtLTjTJkaqUXQeQke4dgcNpnUsWZG/gsDMTEAjroFZ5BEdzqust1qrCzT+x/9XdqHyPdEQHeT7rI7Pfan6uHo16Nj6VlAg/vHI4MCt8x1GHxHI7lCrA9WcX+8akH6hx16xGFVrY+faj7AKGAZwqhWrMJ4Q2Ch94z4cVm2Koy9QpILSbNizZtrQayefPSAbEG6G2rJ1BF677Krs0WhZbKxaTqRhn9pt1jX3j7f8xnqcaVw7eflAaOdaKghKSWpSSEHfnWSzWCmXGebIJW6q8eOtlvqHhIQiimONhPg/NgHtgbcx4a+KhzjTcXecHO3aao2V4Q+zWxIcP8M/qVpttg5aHR1gk6Ag2Fp9aOtkv3hdcneXHAiWIC4Kmr0ohb9klIKasHxs2oE7HyaZFLLHXty++Mm55JAHqP0KQdsLOmtbLdAD8jxnMktA7+YCfgM70l/Tdbi/5lKGuU5KuyoaL40U5G0A/1Ef1hyplpjpEWOzgIJbToDU4voBaXApLwZI2Wl3EBcX6v8iKom0GbsQ0HhZoTy7EceK7UD45qqJXK8QeG8FDZfDsc4mD3LtYlCpV1OxRkxPVbUXiUdL3cXy18pkEYYti1Etr4ifTPQI1rOiRcg79b7blSQZ1TTQQEirTIEFr8YechgSZG6K42axIckM5fOQmQCDXeGI7WTg02vu0MdI7A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9186.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(8676002)(66556008)(66946007)(4326008)(2906002)(36756003)(66476007)(6512007)(6666004)(316002)(6506007)(26005)(83380400001)(1076003)(86362001)(186003)(38100700002)(7416002)(8936002)(38350700002)(508600001)(5660300002)(2616005)(52116002)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AdIj3sHtMKqi6c3Q+4p6eFacRCUEhuSq/o3fD6N8KfDVMM06Qu9wcYTVF3AN?=
 =?us-ascii?Q?F/+0afleM3+z7T9fKsDeMbhLBGhj4Cm4PUFlvbQLffFxY/yBDUg9UAxgZ4EW?=
 =?us-ascii?Q?3dmLxXrlcHuY3Sl340Ic+Ak44xUe4MbBF54hamII6X17wZsc9dh1Cp8Ie8/v?=
 =?us-ascii?Q?k14rkH6neCA8x3WmBWTQfIFlkO5hUueXnV0SkYXbFzKivmRSzovb2upMEhyi?=
 =?us-ascii?Q?ID1jz/O7aetofGOdkf4dGt9wuP26PmiXX/Wmhi73iuFYwyo0dMYAIW/McBLE?=
 =?us-ascii?Q?st6lIi0pDo41intZ1vRinuZ9YY6/lVQ4oSPkzcGgszADa2+33pCqRhkZ3P1Q?=
 =?us-ascii?Q?Cnb3wUaAr3S0kkWLvFGLAITh2aR11mUI86WwHKGugkrm4bPXmbMmf2pg6fmj?=
 =?us-ascii?Q?0/CmbFWKTZpSmE0FWY9cM65q6qiFRiaqqeYEyiT114ZQMQzEL6VKWn9Oe3sA?=
 =?us-ascii?Q?GknOrTZjSJD+Xr0OHM+fGbboFC84HbOi9C1cunZppPyczmAeJaACyTr7H5jz?=
 =?us-ascii?Q?O12CDDKI6fDJ3nCVYam6KRMMni3XYGr87RcnaMHLcWnZe8QQkAkRMK8smZtv?=
 =?us-ascii?Q?54R9MtfDg9u+00R7COLA2pLZpMIcO1+TDLL4ls70+ryDrRm4VJKrKkQPUP6a?=
 =?us-ascii?Q?B5x7keJkSY7Snxai+6NtCcIgNPOIgMIsuaUB140YT6PRExeYiqeJ42YMYpfa?=
 =?us-ascii?Q?aQZ6WNQJlO33rfsrSyOb4/KHHdz/lmTY3zzzzqu6JhZ+GygDrr2RenCjkEtF?=
 =?us-ascii?Q?RsgADhtvrYFfPSy9kp4rVrYRpyy9mSyiKXSDyt/aCHrc1facLAYgmxOdihVJ?=
 =?us-ascii?Q?I3KNTv3TIkItJ0Dek3LlCziepiEvH6mWYNoOaOh0OQ6Yf10PTDTwLo3d+zHJ?=
 =?us-ascii?Q?BZB+CO9IN4E4Xp61J+dWE6fwTZP8i6v8XDSWybeCD5q8qB3utMRmxjDslkQU?=
 =?us-ascii?Q?jLgLs5iC08YcFESJhnzAZEmF0gnvlDYth+iPnPGRZ/MiWcwhWR08obgHAm1H?=
 =?us-ascii?Q?GVi/DfjAhEHwsg8jiupKEwVNqJahNzf474ebr5U7d70ciq5kx5p3P3bGbJsn?=
 =?us-ascii?Q?Z8AHwHbCpOKjO32p7OktzciG3vbCUTVfEw47wtL0l1YH8tJZneixEa+RQm00?=
 =?us-ascii?Q?FbDnkcrnvB7RAt1UCv8mu58/wm0fBTFffRp76Kj+Xz1TrLbcXeVOYOC7NqL+?=
 =?us-ascii?Q?ao/eip0FwxS8R39SemX9lQFtMRMavEjEACs+Q4/E317yP6j1mJaj5w2w+aGc?=
 =?us-ascii?Q?5Qg5leFac5a5C4GGoST+PboTwynoB47nYm89e7XHh1m7IjKmdiPCjdi15qCO?=
 =?us-ascii?Q?zvIhW9lioZDENJYNO3LqbD0S7/HF2nEjSuskKuqjKu2iGnA2zA1n+fqJRbLQ?=
 =?us-ascii?Q?jimaP/fSr9ZCTS2FXFHWAJoGMw2XkA30Y7B8LAGqLe4M2IViWcJRodoQn+EN?=
 =?us-ascii?Q?xTMHB5K/khRmZQI0wo72p0yS7uMcgzrDsoPQmLg0yJo45GskUIAQ13dTEwTj?=
 =?us-ascii?Q?saWGHnLtv5k4+YHlPtD1smzBlp/i01L8pe9pq7q+eDxn7dl4Q519Z9bP71Os?=
 =?us-ascii?Q?bfJB1wakA9cBUwZQ4CiefXTwOUN2TP218USYjszXzBnW9b3k5tal4FK1hCSI?=
 =?us-ascii?Q?yYs6mDflVd9MJ/tux3LEdDstbSVb0qQ2osX498UBPJYjIsI/ts7sQMqj7M3i?=
 =?us-ascii?Q?XFLmy3t3kwhsBpFHOLar7pOxqZxhl7u6B2GHJWuWoIWeUEYNOncP2PYdG8qB?=
 =?us-ascii?Q?8udv4vJwwA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: adbf4624-febd-47d8-0386-08da2ca017b0
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9186.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2022 00:58:53.2021
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0lllzyB6u9LUiF6HBncgslK4Rcg5WMq4Htc8hzwH4btNGvE+mAI7EtmM8Xg4m3Qklx4Sei4YQx4qQTX7laYuFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7364
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

DW_EDMA_CHIP_32BIT_DBI was used by the controller drivers like i.MX8 that
allows only 32bit access to the DBI region.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
Reviewed-by: Serge Semin <fancer.lancer@gmail.com>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Tested-by: Serge Semin <fancer.lancer@gmail.com>
---
Change from v6 to v10
- none
Change from v5 to v6
- use enum instead of define
New patch at v5
- fix kernel test robot build error

 drivers/dma/dw-edma/dw-edma-v0-core.c | 13 ++++++++-----
 include/linux/dma/edma.h              |  2 ++
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-v0-core.c b/drivers/dma/dw-edma/dw-edma-v0-core.c
index 2ab1059a3de1e..2d3f74ccc340a 100644
--- a/drivers/dma/dw-edma/dw-edma-v0-core.c
+++ b/drivers/dma/dw-edma/dw-edma-v0-core.c
@@ -417,15 +417,18 @@ void dw_edma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
 		SET_CH_32(dw, chan->dir, chan->id, ch_control1,
 			  (DW_EDMA_V0_CCS | DW_EDMA_V0_LLE));
 		/* Linked list */
-		#ifdef CONFIG_64BIT
-			SET_CH_64(dw, chan->dir, chan->id, llp.reg,
-				  chunk->ll_region.paddr);
-		#else /* CONFIG_64BIT */
+		if ((chan->dw->chip->flags & DW_EDMA_CHIP_32BIT_DBI) ||
+		    !IS_ENABLED(CONFIG_64BIT)) {
 			SET_CH_32(dw, chan->dir, chan->id, llp.lsb,
 				  lower_32_bits(chunk->ll_region.paddr));
 			SET_CH_32(dw, chan->dir, chan->id, llp.msb,
 				  upper_32_bits(chunk->ll_region.paddr));
-		#endif /* CONFIG_64BIT */
+		} else {
+		#ifdef CONFIG_64BIT
+			SET_CH_64(dw, chan->dir, chan->id, llp.reg,
+				  chunk->ll_region.paddr);
+		#endif
+		}
 	}
 	/* Doorbell */
 	SET_RW_32(dw, chan->dir, doorbell,
diff --git a/include/linux/dma/edma.h b/include/linux/dma/edma.h
index 7baf16fd4f233..1664c70a8a0c5 100644
--- a/include/linux/dma/edma.h
+++ b/include/linux/dma/edma.h
@@ -36,9 +36,11 @@ enum dw_edma_map_format {
 /**
  * enum dw_edma_chip_flags - Flags specific to an eDMA chip
  * @DW_EDMA_CHIP_LOCAL:		eDMA is used locally by an endpoint
+ * @DW_EDMA_CHIP_32BIT_DBI	Only support 32bit DBI register access
  */
 enum dw_edma_chip_flags {
 	DW_EDMA_CHIP_LOCAL	= BIT(0),
+	DW_EDMA_CHIP_32BIT_DBI	= BIT(1),
 };
 
 /**
-- 
2.35.1

