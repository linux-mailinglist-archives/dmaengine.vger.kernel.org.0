Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C32D50BA43
	for <lists+dmaengine@lfdr.de>; Fri, 22 Apr 2022 16:37:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1447575AbiDVOkD (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 22 Apr 2022 10:40:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1448733AbiDVOkB (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 22 Apr 2022 10:40:01 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2088.outbound.protection.outlook.com [40.107.20.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D40075BD2E;
        Fri, 22 Apr 2022 07:37:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LJjsXtnKJVEYSd9KbzkhGqgmBk25TEsXmgFMKJfvehmn/0cf8c44yUQAml6K7HiAfas1iklxrQL26XrNUFhd/6FuYfz9DPC4brtVKXW2uALC3xauO1aD3Un4GokMQniJQTpS/4ln+HFn4ErsWe0aLBIo6eG1+bqFui9V5/1Iy18SGIAxBv3Hs13o7mJeOOTWUEe8Url7yw9dd8qTOinUaW6KNsMKu3Foirhe6Em89jPwHxa9DDMOXQK9Trq03Z8lphHM0yBElHbYpHThQAI3d7nBwps8h3CsKAoGeh+cBtGFcdFBwvMB38lWaOKKJ33Ccf4n7rZEMDrI81MKh/UhIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=njvmpLb3dXTkHuEn/BaELpKwJRUXoQH4/3olJtyMbBk=;
 b=jS1px8RxaGg2VF6h5zv6Ulbo03SaBsFrTeQMssXZiYCenwZ/a2fbG7oQdHD1G9YE9TRQvzAjkGrJrdVPwPHErrgsq2Aum4JSfH8qk9QST1wTDZ0uhjQvHDNCvFJgPRBvYWUWleeYV1DLB3dQt531mpqRzYM4pqKcwBymhbC0uhsB0gNC1FnNC0ZQfLw5Cjo/TYOvgEWjNlguoklbC31iO46pUufQ+JlAUPesiJ8V7tn8V9minM12otEkrjnx2SFaILNoLqmlOlmS+26Vl8kNv1GHMnEzNHYI6wn0wD9TJw+unnB93B2sWRl95Ut2Axq2vmN6HjoTGtwH2JQ2zon9wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=njvmpLb3dXTkHuEn/BaELpKwJRUXoQH4/3olJtyMbBk=;
 b=rn6ZEUALNRKcre+hZ2FruWicEFErfjfIDKo1klURC6VIcJy3TaTyFqyyX/JoTsfAjQp0T1b6bn1YUHu4IbtH0J4Uv9oyAWYo306DQxIfU0MCooytDdTvFbb/GKLm6+MdaSlACn1Lc5MeJF5BUSCyfJk+rZn1VYwugXQPJpbd/zM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com (2603:10a6:102:232::18)
 by DB7PR04MB5449.eurprd04.prod.outlook.com (2603:10a6:10:8d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Fri, 22 Apr
 2022 14:37:04 +0000
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::adc5:45f8:fa40:1b8a]) by PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::adc5:45f8:fa40:1b8a%7]) with mapi id 15.20.5186.014; Fri, 22 Apr 2022
 14:37:04 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     gustavo.pimentel@synopsys.com, hongxing.zhu@nxp.com,
        l.stach@pengutronix.de, linux-imx@nxp.com,
        linux-pci@vger.kernel.org, dmaengine@vger.kernel.org,
        fancer.lancer@gmail.com, lznuaa@gmail.com, helgaas@kernel.org
Cc:     vkoul@kernel.org, lorenzo.pieralisi@arm.com, robh@kernel.org,
        kw@linux.com, bhelgaas@google.com,
        manivannan.sadhasivam@linaro.org, Sergey.Semin@baikalelectronics.ru
Subject: [PATCH v9 1/9] dmaengine: dw-edma: Remove unused field irq in struct dw_edma_chip
Date:   Fri, 22 Apr 2022 09:36:35 -0500
Message-Id: <20220422143643.727871-2-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220422143643.727871-1-Frank.Li@nxp.com>
References: <20220422143643.727871-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SN7PR04CA0063.namprd04.prod.outlook.com
 (2603:10b6:806:121::8) To PAXPR04MB9186.eurprd04.prod.outlook.com
 (2603:10a6:102:232::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e98c5306-abc2-4051-6790-08da246d91df
X-MS-TrafficTypeDiagnostic: DB7PR04MB5449:EE_
X-Microsoft-Antispam-PRVS: <DB7PR04MB544950DAE1A6C3B8B53E9C0588F79@DB7PR04MB5449.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VFuh1Jzv9NKj6575Z5+qjJJbc61Q7x2mtba1FTvN7dhCXej8ClPCO/Sx778GBdkVKnwa749lgK/zJ5DgrXGwBOet3Dot1DNneXfoF3kdTBuG8l/qeLFt0VGJEtCfZmo+LtFWeGmM12T7bqjy8ND3GivEIc00ujSP2icAIpGiw8t34ItVfXVJMAM6a+iRi8bJaj+CZRfvLXyAtvAeU3FTwubfrTU1GMDTdmVGVBi/r8oALmt8UCw49Yy6rpqAeIQD3RjwbTZ9A6UKT6kHdt5ytUrIduhs7chCvusjeyU5p0XF2jhPitkjItSfbTs8yW770RiWyDFhIdIUAIuTM6YF9rWpC7oj2MEirsYS15zYe0vMP4aQMyJBIviMtynsA4sylZlkDlu+jsRapiUnyYsZJMyFyGgZvinC23jVq47qtE28h7QQ5XL5qpf8nLQMrckoYhLVr5wXGsD6ufzcCHnM6JoAPAsZriYSbvvrkmNShTA9gLaCjpFWdiMacPRAQmTLQCwt7HwOJ9h0vDpReZ+GVmVoRQdIlx9MorpPTj9ggohBncfzyZu/9V0JRQp/1llR05n78Xct0VzO5qYkQ7SFTabEu15SmYRnfAWZpH7U5CiAP6I4biMxVL6tPSKgtypY61v6oW+ipRljhxFg2DtN183aQ67SylktrxAwswTYJYc6+jupDtuusQtoLfKVE+p84itoNzTau7kKnu5ryoS8Pg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9186.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(1076003)(4326008)(8676002)(66476007)(508600001)(316002)(2616005)(6666004)(6506007)(52116002)(26005)(6512007)(8936002)(38100700002)(66946007)(6486002)(86362001)(66556008)(38350700002)(83380400001)(2906002)(36756003)(186003)(5660300002)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?w9BNJR4dbws22JtBZG0KC/rhm3y1sj6MqBjDFV/dxqF6c0DFyt3q1Vr/7pft?=
 =?us-ascii?Q?9zMhROCqdEuit8CzClip65Y3W/5ypvGuyh7BJJUMfkZbRhnTyA4rQSS3g9+u?=
 =?us-ascii?Q?sUyX/mS9x9L+yxP8kkG5FsMZesNyJW3JC4pKBOHG6Q2pGYGTC+OlLguGAhEq?=
 =?us-ascii?Q?L6e6I1qSd4J0bkj1+lgW73kx/ZushCKx22nCYlaLVujYXzgvoM6/Cwm+K2RQ?=
 =?us-ascii?Q?YHqM8sZToncMAO8IPMiuAVTZQuiBsAyjwKGGf+WFD6qdgX+utVZWTwS3jqRV?=
 =?us-ascii?Q?tGPBQrcxVKHLZmKsh0m+L4PsF/3F/jinjSVrpilJZkg09jj3ootQiKC+uJPq?=
 =?us-ascii?Q?Zq/L9T5a2J3nB1rSEr3PQM5Tl78Yxyfn066zJmvV+3zcNgvxvifbxy5up1dE?=
 =?us-ascii?Q?CaGLbeGKGm3chfeW4BM3XoC27tbZ5NQD2VfyQoi9HV65ZZ6iWusT95hqjPgC?=
 =?us-ascii?Q?F04R1VdkXfC0WRBjha8+WZHuZ64qzabxJbQw5QuKxPS4lVD1VT44xFRNqBj6?=
 =?us-ascii?Q?CxdzequJAmZFeVFBznaAQ2879zqroyyEYr1bREIZwdnCF+E5JTXwgg9VuzVM?=
 =?us-ascii?Q?h414gLikmV+Nc3b9bFGNYenZHOsfybYyLhP2TTOEr5thABZhq1an0E1z58x9?=
 =?us-ascii?Q?kG0QJO4r9mduEZZtfscOpHWMjnq/4dqNKCOnsapNXIdzP2ejC4wf8aSqxCgE?=
 =?us-ascii?Q?9we5MQwyFMKMfnDOJ9qQlDFE1LpQen3+h/bg/f+Av1vK3eE+ORJhO1RP+cZg?=
 =?us-ascii?Q?KmeRLbPFAq1tfUPZaYAJqwn4V+3Rhu87dEzhNdPdyY4s/5c/b4HlEuHqOLXq?=
 =?us-ascii?Q?MrcDl800KLkfn42knImJ8U0nv1b6bUDVU2M/mhl2B5zhU85C7R6iNq5KIo0v?=
 =?us-ascii?Q?fCXlQwomenUQtu2ceBuvrbfM8yX7osoLQba+Kq3Xm4Jlf54B/DQkdbf5dvtc?=
 =?us-ascii?Q?WTl7qmWvu9X290nJqPOfIP0ZokhBSJVXKCz5mtGMF6o0XGYqSVMd1fJ0/fIY?=
 =?us-ascii?Q?AXPX1J7rEAooPTrCda7GNXXkrEJ1ye7nR4cRS8Ygmi5eb9FsUDITNwKl78ua?=
 =?us-ascii?Q?WgB1d78oKZJYz33hKtaFE559XDGRfSKZeAJNIG+KbvJLwWSVyQ8+c40u8As+?=
 =?us-ascii?Q?1vY1QPOowy2Bch1S3hUYM91DSqvlurp8vgQ7aINuKHsnFYvUC4SQUTzqR3X2?=
 =?us-ascii?Q?flz/JJAziPB+awtd1VPIgtmNCSdEV9+P5Ro7lS1Qz+qUXkmYt3zE7tG36Hv1?=
 =?us-ascii?Q?+nFhm8npcDS0dMicU4dJXi++IBXfScimMsy4v9m6gFzAO+w4Q85ShgbH4r4R?=
 =?us-ascii?Q?WeRcO00NLN4oYPgdIn2jwCd+1aLxw2oRUj6Wp+HyuKbvBYC1f8R4EwP7ywu0?=
 =?us-ascii?Q?CbUNDx/JWILLOoPD4IcaPKsdXh70/NCe0dtsWKPGNB9nqgF/EdMg0YEAOG74?=
 =?us-ascii?Q?aRK5Q9BLmx+c62LA/Ev2+vi7NR7frz4PUojB8gDamtQqH3Hu+MmdtdtrhHTp?=
 =?us-ascii?Q?u6Iemg1SWZXG3lITI6PImgcldIxSA3uIeuHUQrrKfo0ltNM1cwS2aDNy1cOl?=
 =?us-ascii?Q?Z6lHH491XcwQGZDWLHmaV74QAauyaEwy4qcQVngLppP+9ksaTisBjGytQevb?=
 =?us-ascii?Q?zhbTN/JL9VYYvTLAeznSSjSw6GD5Hzw6PEswKLMhW+1fePok6W8sDa6Diq52?=
 =?us-ascii?Q?WGGmS3C81bfcH0nBTtNWrZGKpO8txydmiQ4LrKEet5w5zNFtaGAiASGPN64e?=
 =?us-ascii?Q?ZmDCyNTWaA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e98c5306-abc2-4051-6790-08da246d91df
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9186.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2022 14:37:04.6075
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pjXRhYgy+MXdNOFgAXsIr6FA9GOvARSPetU3guyErQxXpC6hI5sGDaCffCOQC3smgavHurp/Ul0biJ+06zKLHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB5449
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

irq of struct dw_edma_chip was never used.
It can be removed safely.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
Reviewed-by: Serge Semin <fancer.lancer@gmail.com>
---
Change from v7 to v9
 - None
Change from v6 to v7
 - move to 1st patch
Change from v5 to v6
 - s/remove/Remove/ at subject
Change from v4 to v5
 - none
new patch at v4

 drivers/dma/dw-edma/dw-edma-pcie.c | 1 -
 include/linux/dma/edma.h           | 2 --
 2 files changed, 3 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-edma-pcie.c
index 44f6e09bdb531..b8f52ca10fa91 100644
--- a/drivers/dma/dw-edma/dw-edma-pcie.c
+++ b/drivers/dma/dw-edma/dw-edma-pcie.c
@@ -231,7 +231,6 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 	chip->dw = dw;
 	chip->dev = dev;
 	chip->id = pdev->devfn;
-	chip->irq = pdev->irq;
 
 	dw->mf = vsec_data.mf;
 	dw->nr_irqs = nr_irqs;
diff --git a/include/linux/dma/edma.h b/include/linux/dma/edma.h
index cab6e18773dad..d4333e721588d 100644
--- a/include/linux/dma/edma.h
+++ b/include/linux/dma/edma.h
@@ -18,13 +18,11 @@ struct dw_edma;
  * struct dw_edma_chip - representation of DesignWare eDMA controller hardware
  * @dev:		 struct device of the eDMA controller
  * @id:			 instance ID
- * @irq:		 irq line
  * @dw:			 struct dw_edma that is filed by dw_edma_probe()
  */
 struct dw_edma_chip {
 	struct device		*dev;
 	int			id;
-	int			irq;
 	struct dw_edma		*dw;
 };
 
-- 
2.35.1

