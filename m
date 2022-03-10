Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91E294D5200
	for <lists+dmaengine@lfdr.de>; Thu, 10 Mar 2022 20:43:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244083AbiCJT0w (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 10 Mar 2022 14:26:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343549AbiCJT0v (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 10 Mar 2022 14:26:51 -0500
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2085.outbound.protection.outlook.com [40.107.22.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 173A913FAEA;
        Thu, 10 Mar 2022 11:25:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k9KZJ8UG2yLGjtsWeHJDVMor16tkNFmh6/Ta8O8deRmaWJ849I2azMZ1qmmW1nWsNYIRSFe1O+trdotBTUR2U+R5CbvJNeXvpmpaS/MvvDzNxRu8Xxz5FVllLjyU9STCTsb8+VP/Q4Xbk9bDUoyaZjsf/WSlzL3Vl6XVVURfPAX+OZd16l8bb7U6KzMkvwIVgZS15TsTbT4m+MtJgSgnzpIAj+MzoK7fM4/oCSRvMtGm1PWdr/ci7c69a86y0iCS/VL+mRyTv6LZDIzXM/AkbxuDsUueMs2ANZxXWpOM/SkpZfqEpYPiokkepX5ChYqN4V106lb0gV89tInDCEFbQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MlVD9Tyh91tkr2rqYUEdNCSzxssBGww7nDgILoKvLKw=;
 b=Fl7AGeTsT1jLsM9ymeDAJj/2xeq/Qwpfs8MOMP3+ZpBsUmISq8nsAc69TfAams0DOw2/7UAnzDLnSBkI1cLeVgSnHg5DvYrn8b8uUGWa074Jee5+NoUSiAq6wao4lkxlmbKQ11/k8Ysf8Re4SRITPeWzXECyQpPORwu3gvG4P+LLL5vEwsFnu+90JwxWOJIPBacsQLvus5wumGzMMmXpkvvQEU5KD6sLNb2pg6XYOXO60N50jGEYa9N2UhlUcagIU242tbTmUyLY12hOxBETtWmc6Iapbcfoz/UTW0Z+UkZaMim5BWF8ykZr90nN5x0uYWeBhh2GYsdMfW6x/pO52Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MlVD9Tyh91tkr2rqYUEdNCSzxssBGww7nDgILoKvLKw=;
 b=UQIBOpn0QnvUsdQFrnoRKTDj3MDI0zw8RrcoK1zTlw6/GWOjMNMCjxGxMv/D+T9j8LElGs8YMppGCyU2FG+wOwQN/JbQpzE4IMXyVY8QBHtB2RpsvPjMroBTmf2EJQEsdCTVmFFG4Z77ymE3XNEr6aiC6mrUssD5+UZUHtTho00=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com (2603:10a6:102:232::18)
 by DB7PR04MB4858.eurprd04.prod.outlook.com (2603:10a6:10:1b::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.22; Thu, 10 Mar
 2022 19:25:47 +0000
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::c897:1bdf:e643:aef8]) by PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::c897:1bdf:e643:aef8%7]) with mapi id 15.20.5038.027; Thu, 10 Mar 2022
 19:25:47 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     gustavo.pimentel@synopsys.com, hongxing.zhu@nxp.com,
        l.stach@pengutronix.de, linux-imx@nxp.com,
        linux-pci@vger.kernel.org, dmaengine@vger.kernel.org,
        fancer.lancer@gmail.com, lznuaa@gmail.com
Cc:     vkoul@kernel.org, lorenzo.pieralisi@arm.com, robh@kernel.org,
        kw@linux.com, bhelgaas@google.com, shawnguo@kernel.org,
        manivannan.sadhasivam@linaro.org
Subject: [PATCH v5 8/9] dmaengine: dw-edma: Add DW_EDMA_CHIP_32BIT_DBI for chip specific flags
Date:   Thu, 10 Mar 2022 13:24:56 -0600
Message-Id: <20220310192457.3090-9-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.24.0.rc1
In-Reply-To: <20220310192457.3090-1-Frank.Li@nxp.com>
References: <20220310192457.3090-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0051.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::26) To PAXPR04MB9186.eurprd04.prod.outlook.com
 (2603:10a6:102:232::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d09d442e-d634-4589-63da-08da02cbc785
X-MS-TrafficTypeDiagnostic: DB7PR04MB4858:EE_
X-Microsoft-Antispam-PRVS: <DB7PR04MB485835F8888A55A4F790B2AD880B9@DB7PR04MB4858.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wjhH2ln/rmHBBfe+2QXo00a4IeoHk9m3f8vz/u3NbzE/uM1PeVFyxxwN4tfP3irOkc9xtcI/MjF3RyDSCXNMZoBICqXsEoqVxEhbviL2PNk9i03N/5POkpnOvmQ/D6z4f3Y1iakyl2WQ5p78aP0EVydWN/+pZCTVBgp+DGpAS/43BocNuINJ6cRVkMqAfQyt5ZaNSWvHq/JiwGshxfi4aJX5Y9/3ctivJULj3/4q3iyiQX7ri/Hf2AbD4dHEEqcQzQ1xjPDxI1y3OqUES40t/tQEGbE4DHN7/UonrQVUgeOU2qag9IZ21XBBuIu52lm6HG0g2SsZylRsX+b+1P6ucPTJKxROf62wmuiGCdn2/Olda0XZF0qBuxuMDDVN66fg97HTaz38T+245my9lIbWY9qAgJNMZJRvg5iGfCg4pvvGCskKtfjEY4ZZOi66uo1RxIFjQwQtZVnbI4c6n2PvUEk36V4FntxmYazHM+RyWfQzJOxwZinDp8mdKrNqXDx72NkUQw5YganAVQAjpfRh5cxD8aUSbmncqRi9M5iLUmwKeTl4qbIBMWhQCuwRL1bgWIRVzD/pkW8uHhEozoqgbB7az2a7LszAZJwZ1IxUnDeC66CtRn7chBX6MJuNABV9LqdtdNqasygMSe2sNCvzOgUpVT59c74Bjnzw33raIhtqBk6PRD/I7gSaT/wZBC4F
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9186.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(1076003)(7416002)(6506007)(6512007)(36756003)(186003)(5660300002)(66476007)(52116002)(6666004)(2906002)(2616005)(86362001)(4326008)(8676002)(66556008)(83380400001)(26005)(66946007)(8936002)(38350700002)(6486002)(498600001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3t7VxpG/FEdsIlEjXovMisiJmap5wIqkuw7JlRRdXvaIO7ECeL+VkxsMDkHj?=
 =?us-ascii?Q?V0a4dJaKychgsGSm/EpgQCrEFUgD1bA8XTB1XrMZoedSG8ngWDKWNknZRfEv?=
 =?us-ascii?Q?2uhy3b5wISwohV6mutukbrZFVv6z6/D3TlEvgwHW0a74lilmBGPJ6mRkyPWp?=
 =?us-ascii?Q?RuLKo/8gn5CWQAaHFCix0RbpUVJervL8h1xo6mxjYXWvnq6lXQUoKAzdQ2tJ?=
 =?us-ascii?Q?GGPUrMyzuhB5Ttp8m0p3pnUqgZGy8RVNiV2WsHor8dRh/pETGkZ6Vp3RYD/X?=
 =?us-ascii?Q?bBuPYfYIIlYkNxECK+SD7Wc4cn7GZCCb/T0Smlmfu5HJl3FL8mvIu35YArBl?=
 =?us-ascii?Q?AKMdPFAwFd5MWIJYrtrTdKuowo+433+HS92pfoR6CYeyR+n+xMm4ur8b2x6J?=
 =?us-ascii?Q?hW+wWA2/L5rZEWKoA+ndsj31v0Vxqh6l3WhzFJGczuGhnkKfuK+t0eYeJcvN?=
 =?us-ascii?Q?wzmam+MEUKDrVGCZBr25p42g6HjLwzDcS5eJnTwO7djHq6Y8UB5R60vhbNO0?=
 =?us-ascii?Q?RGVuFqZOmPH39G05Bnnj08Wm5hExYFN9G/+7Wgai6h/mBhQbkB433kgFvqkC?=
 =?us-ascii?Q?1X/LJIdVP/5xDAVPPadhT37VAgTOufUX+0vK3c6YEMn7DXwQU8TED9zHp2Rz?=
 =?us-ascii?Q?8ssAQid1FxadUhcLI1+muJSqNr36NR4jxVLv/yuJcBwVrLtGMQ9m/qF4zFAT?=
 =?us-ascii?Q?tBzWje4nWTqZGlxODaFPGJuP7V/GNciSkkQ06nccEV7w84LUozREag4MUB/D?=
 =?us-ascii?Q?Z8FvyS1TIxgXqSkOfCJmwDimWt6B2uLQ0rZjJuntV05wnahQDSBRkd7se3wf?=
 =?us-ascii?Q?24+h9+DAN+gYo+GZR+22mLDodXAWW6lx+zQOpo7gXTNj1uzv6Jty1RSzl6er?=
 =?us-ascii?Q?l8mttAbi+yAjcHuMsq13jsJRzc07a7S9JGUa850TJdCMEKoM1+ZpF/lFfLnl?=
 =?us-ascii?Q?0b5FkQfsvEQRxF10tonPWmwDZqdmbA+69lu6EMwTYU5JLOtYGvXwfhQI50po?=
 =?us-ascii?Q?G0KVhG4I4JkipBrSqc2Y7ryvKqdMgBrF0S/0hgAkjgReolJy2dw8Re8/c8lO?=
 =?us-ascii?Q?uYl7Y8wQm4AOyBJ7TtBPgSO7GL8mJNDu7T0ypbEt41duhUt45Xd3N7XpKFWE?=
 =?us-ascii?Q?XZeckr97+Rb3Imr9T+Tz2zFvxEJi5SbGf0+Zq9QECT/wmbXqtbqUdAShAARn?=
 =?us-ascii?Q?YgB2siy3MMrZ7+2JFBYmBvrzl4bnqMVGHqcgqvA/juMZ9L+Bc9CEh/6SWoZr?=
 =?us-ascii?Q?yTtO1uIkdNSnMaFhBdwHG8aBzhMMop7zk5929EFVT4IcvgMksgK5c2pPHoR7?=
 =?us-ascii?Q?IZANm9R9bDFXQGCsZjcUOw1NRIVD9AA3tF599dm9Ypib/iM46mDefqKJF3Gp?=
 =?us-ascii?Q?9/x+KwMtXuOUWi5UmsCR+D//8JwWBibMJ6DbJ+ub2ctuD18/s7dk4SAjKVTZ?=
 =?us-ascii?Q?+kFR2WkzAhRQkyjKc+7L7E/ae8nV7sK5?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d09d442e-d634-4589-63da-08da02cbc785
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9186.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2022 19:25:47.6776
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: truE+xvouu6XUQrZIBsIz9feCscm629v+E9O+0kF/J/CMSDzd9uJzaioYtteqtfPecFodzX+jOo8I7a0ENRHRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4858
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
---
New patch at v5
- fix kernel test robot build error

 drivers/dma/dw-edma/dw-edma-v0-core.c | 13 ++++++++-----
 include/linux/dma/edma.h              |  4 ++++
 2 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-v0-core.c b/drivers/dma/dw-edma/dw-edma-v0-core.c
index 30686bfe1790c..013d9a9cb991e 100644
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
index 5816c8bdf9a64..8897f8a79b521 100644
--- a/include/linux/dma/edma.h
+++ b/include/linux/dma/edma.h
@@ -36,6 +36,9 @@ enum dw_edma_map_format {
 /* Probe EDMA engine locally and prevent generate MSI to host side*/
 #define DW_EDMA_CHIP_LOCAL	BIT(0)
 
+/* Only support 32bit DBI register access */
+#define DW_EDMA_CHIP_32BIT_DBI	BIT(1)
+
 /**
  * struct dw_edma_chip - representation of DesignWare eDMA controller hardware
  * @dev:		 struct device of the eDMA controller
@@ -43,6 +46,7 @@ enum dw_edma_map_format {
  * @nr_irqs:		 total dma irq number
  * @ops			 DMA channel to IRQ number mapping
  * @flags		  - DW_EDMA_CHIP_LOCAL
+ *			  - DW_EDMA_CHIP_32BIT_DBI
  * @reg_base		 DMA register base address
  * @ll_wr_cnt		 DMA write link list number
  * @ll_rd_cnt		 DMA read link list number
-- 
2.24.0.rc1

