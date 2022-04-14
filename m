Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2688501F30
	for <lists+dmaengine@lfdr.de>; Fri, 15 Apr 2022 01:38:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347733AbiDNXka (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 14 Apr 2022 19:40:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347738AbiDNXk3 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 14 Apr 2022 19:40:29 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60067.outbound.protection.outlook.com [40.107.6.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6388BB939;
        Thu, 14 Apr 2022 16:38:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S05tx4M7mrGZOs9n3F5CZiodFwlenjlohMjJK0rp/IyI9MW3D5CeWrvUNoP7K1oGELuYN0jfjT4DV3PUG1IgfqEQsKHTF3kyXZBFcrSzailTTMg7IlXujt0cgOS9NpuGHOcKdq1u79EXzZV4rdLl3lP5rJ839sTIMkZrBsrY+dwQ1ZOChqtIxtrdQemelWDELJJjKZX1PCRGkoxaP2oR5MPw/kVJHTqpPYF6EjXHl09TuRk0XDGREGmwtgGHzCYNkejt3Ug8brSq1HA/RvVecrUGjPKBkj7VfB0L4lEKAiF+UaMWlytFMDGD4mUY8p309LBqQ6AtM7pvE5KHpuSLxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X7r7U0c5ltodlcnRhKLHNkFCGg6VcYEysbUeGBFxFAg=;
 b=NnQSBbAnnblQgyuvmaPru+lr61ZrBctxMhSYT9W8EYHhfrt1ro7LC+6iOln2LYrO7DJcYwK/5rEdUewkyR8MyHVsm/7T/wtAwyDEMA4lIHDDakLqb/vv8sCi8CbtCkXr1VD5mSHyDLXsU4tdZYYFDY88hnqu6JtLc0tqId66U4ouPe5izOj2FEM6T/jY4ZnyucfCHzHScu6vp5YwIoFuui9FCzDEejwOXk0Q7+gujOANAPBnj5hHMXluF7qK9yVBJIS/xmCvYTHzp21oa5LMXmgRtccD1xw31MnANjtJVTTEL15AMpkZ8vXZ71KKU+381Po6nEtfq/avuZK9Ljy1uA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X7r7U0c5ltodlcnRhKLHNkFCGg6VcYEysbUeGBFxFAg=;
 b=fQifmModtwMJJ2Yq/PAS5Fcq3iZCSVkLMwCX6f38etjJix2Oy1Bnwmn1HWwDpFf10mqf4LZHSY43hiJtrUFnhnT+O3fyKdfKGqNuy+NiVO01n+piMuSKMRZGU+GW4emUsRQb6Zh6LIhUWZZmJspU9vIS3bQfh4I6j6/IM0pWbkI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com (2603:10a6:102:232::18)
 by DBBPR04MB6043.eurprd04.prod.outlook.com (2603:10a6:10:c5::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Thu, 14 Apr
 2022 23:38:01 +0000
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::e13c:6fb1:ca92:d11b]) by PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::e13c:6fb1:ca92:d11b%9]) with mapi id 15.20.5164.020; Thu, 14 Apr 2022
 23:38:01 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     gustavo.pimentel@synopsys.com, hongxing.zhu@nxp.com,
        l.stach@pengutronix.de, linux-imx@nxp.com,
        linux-pci@vger.kernel.org, dmaengine@vger.kernel.org,
        fancer.lancer@gmail.com, lznuaa@gmail.com, helgaas@kernel.org
Cc:     vkoul@kernel.org, lorenzo.pieralisi@arm.com, robh@kernel.org,
        kw@linux.com, bhelgaas@google.com,
        manivannan.sadhasivam@linaro.org, Sergey.Semin@baikalelectronics.ru
Subject: [PATCH v7 8/9] dmaengine: dw-edma: Add DW_EDMA_CHIP_32BIT_DBI for chip specific flags
Date:   Thu, 14 Apr 2022 18:37:08 -0500
Message-Id: <20220414233709.412275-9-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220414233709.412275-1-Frank.Li@nxp.com>
References: <20220414233709.412275-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR06CA0045.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::22) To PAXPR04MB9186.eurprd04.prod.outlook.com
 (2603:10a6:102:232::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5f8b2419-f22b-4d4a-1163-08da1e6fd084
X-MS-TrafficTypeDiagnostic: DBBPR04MB6043:EE_
X-Microsoft-Antispam-PRVS: <DBBPR04MB6043E428653C1973B6AD358D88EF9@DBBPR04MB6043.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6csiAWmTZUAfAvaJGe3sM5QRB7KkLAohsFsyyg/t8QTl/HFeXbdJdiv4zYL8sQfzMx2THO6U6xGEY1wyiHBh7JhaC9McO3YBDQMUFJGaRKf3h55c+xxIXU2zJ/aKPXqUxdG+w+JM97V41LPkyI918hDFfC1ySrE0TNfT0GuS97czfbOWM1Eg0RQDmHiC9kMu2RB7X/scd6+XcNnHTqzfY5bPDO70ju10IT5/Sljv6WeVQDdGceLYiRupJaLhzJfl3xP5MWVFCCSC1zm1puostXUhuhIsTwi0H4WIeT3oc8Wb4taTrW5tJ7imXu8sTIDiPx/J5zphpHCYpjdRlrK3tlWEA4hs5/X9sIiFlbsr5XBJ2vbolQDhQ6SJosKmQ/dwdiPB4uPnOdHNtJjPSMZa39KegaXNY/MTp4UfCmJ6+BDramVvdcd+H2+88hWBulgjeV1UcBz1if6lo+euSC4Kv0vorCKVk7dccwHYr+sADDBpt4tERYtO6i3MFJaFfZdNvHI6Ct/sFM8m9+H32VTSMqLMlmtDkJoXmMA6QawHZgWl5FgrJexZmMtBp2HMV3RoX1UOwZ6akH5zkbFAldXrocuF4elnnOnIdIeYhDOMCITDVQ8Y8aLK1HORi//oFTCe8MWanHiPgz4gWOHEiTbYAvDsIrgydZQ/EgKPCEDX9B/19z3balvR8gjq9JlRbs4BPeCwa4Wbs8+WdmqPXnZAYQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9186.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(5660300002)(6506007)(8936002)(38350700002)(83380400001)(36756003)(38100700002)(508600001)(6486002)(2906002)(6512007)(4326008)(8676002)(186003)(316002)(86362001)(7416002)(1076003)(52116002)(66556008)(26005)(66476007)(66946007)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AKxtjITfiKj9bUjOK9HgKq7ie1D8R1KPOgPpp12FhDgtkN+B1eOZ6RZwH+81?=
 =?us-ascii?Q?U9UhpFhZpBRLqjjMyFbC/FfTNUrUCAwfA/ZYzxF+2ZDE0cf/Wmt+SK3x5LJI?=
 =?us-ascii?Q?OpsQrS/V+8fRZEM8GYd7jxR+FPB6dytD/TPuq7ZT3Ha4Dqz8k2hTvKfxJmyK?=
 =?us-ascii?Q?eJWWb25D/hZl4AU6VYqjnzR6sSpUrQEKGvUHuGVK+hfGT2nfH4V6BxgHw2dM?=
 =?us-ascii?Q?zkMaR2Cw9WK3yD7jF6Bu5BQvZuM5eJAr21JC52fDWZKyVGw0YuOeWd2AiSiU?=
 =?us-ascii?Q?tMWTuvcRp/yuP3koKaWxhmwwVqhs/BwEU76McNIqHZGwBAmqbZDwgT+PIPWj?=
 =?us-ascii?Q?1ml7mKL/RCps9ni4Nznj+MhCUkmHyaW6NaEFRb2zCNJwk0PiqhG8Bc0xrW5U?=
 =?us-ascii?Q?JWRNqSOmLpbKetbiITM0wrDl5iRPV7+sf7hC/s80x5Rrg3NzSmVxiYH/RI25?=
 =?us-ascii?Q?hOm2yFAp2x6bcBaH1qBg7mSUORZnzwIJxLx0Pa4vmDTAC8FyUshJ6/GO4v1e?=
 =?us-ascii?Q?9jiDUqbYJOPZ8Oh9m2mhxrnwQGm8xoxXW3EtEkg6DDwcd27P8E982gSMTTMX?=
 =?us-ascii?Q?GvDFw4B0rknxuj489a91+tBPQrWBehOr9L4Q4EWRTfqdezXKrXivG+bpwXAq?=
 =?us-ascii?Q?E0HvbkDJevmTW56XsyZ+L3bwAkLL7mir5p38yi2Y+T0uiH0Wv4nmH+PsnHM/?=
 =?us-ascii?Q?Mi0yM8nERj5gYOdV3wiqUo9V0QtrsUCHhmkNYaHvGbR+3aeA0Wm4MKds42EL?=
 =?us-ascii?Q?B2b5MI8VwwFue/dBMrUUMG7v63ZuMamIPWtF4LJXvX6QcJwxX+quo24b5SDv?=
 =?us-ascii?Q?E+jOhadBL0uUUfQ3LQlALMonTyATjRVNRUaMDZ9nGoHlrEi/JAm50MWsqRg+?=
 =?us-ascii?Q?rzlDqSr+mRviQu6OtM/EqjyYRNonFiBmaQLzxr02vonQmEzve2arLOzlQZbC?=
 =?us-ascii?Q?IPi+3Z+04seeiLH0omDiCM+mU8umvkf8gyUEa2t6ym6X/U9QNZrlhi7ssrBC?=
 =?us-ascii?Q?WV2tunHj7jIil3G/qKOrPkUmNxTpZtfu/m8H4IAXgKUEXt0cSo/YikLWiVak?=
 =?us-ascii?Q?qTqkKwdFbrenXc6RCPk8tJ0YvFFDWG3OG7ALJ2w4+uFRKwz9ltpK0uiTznnv?=
 =?us-ascii?Q?fe8neeTKLnRGkJBq0GLJwhWTHHNBa4TC2xQtdJPQKEf2xoVYGSd4KBEN8tPL?=
 =?us-ascii?Q?BNCey1v27+Lfuo1zQr6XOuoP/E1TXjsiMLu3LElwRS2Xj/hjuwVmIHWBuyoo?=
 =?us-ascii?Q?tMv9hdHdzrVXh/XF+ZprFEemzE+q0R4P847mo/6ml2thHSO5XfZGF+npwOwP?=
 =?us-ascii?Q?HA2Uim/RJSjznKmTu5Nid6fhCMwA2de5sa1Sif6alhNTDkrZOk2o63Sa4761?=
 =?us-ascii?Q?zAZEgy2LcS6lORMkB+dL4iOcCQSNdaPwXHJckGX+ZZLSfZ9abuAntUjE/KkO?=
 =?us-ascii?Q?sr5BDOg6Q7tPEDXB+LK4YMUOB+vWi4PoSvXJ9kCZL0B/HqPS05hRrcHBlq3f?=
 =?us-ascii?Q?0yoYpAUIwAFDz/SZR08azExjcwNh63LWB54jj65kFOouVubtC87mUBxye1YY?=
 =?us-ascii?Q?nUfwewij1DzgEXxkaEdxNCeZBA7c1XllzUknYZd3rL0dc7rmNhoj1p4Wgpoz?=
 =?us-ascii?Q?I5HYI0xKl6dnZkOsiVfkF3ca0tZu8DDMC/88Ynvq6oubW78hFcC9CSZjpz18?=
 =?us-ascii?Q?W5bB26Z/WXul/QTBotbqRRaap3ULVD32T6Lb2AngfomDFiScC0fxb7MSOKE3?=
 =?us-ascii?Q?eaxcNCU/Mw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f8b2419-f22b-4d4a-1163-08da1e6fd084
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9186.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2022 23:38:01.6428
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ow07T7AAAxvZuuVOlbdqbBEn0Hz258LNLxHzPFkJvS/ZaEJ5JOrKPvtWSdrXG5o5XCC1gc5s0mqETpvuXKmVsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB6043
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
Change from v6 to v7
- none
Change from v5 to v6
- use enum instead of define
New patch at v5
- fix kernel test robot build error

 drivers/dma/dw-edma/dw-edma-v0-core.c | 13 ++++++++-----
 include/linux/dma/edma.h              |  2 ++
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-v0-core.c b/drivers/dma/dw-edma/dw-edma-v0-core.c
index 30f8bfe6e5712..b2b2cbe75fe4f 100644
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
index 5232d3d198f88..85df746659c0d 100644
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

