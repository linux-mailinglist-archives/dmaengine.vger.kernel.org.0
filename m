Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32C0F50A303
	for <lists+dmaengine@lfdr.de>; Thu, 21 Apr 2022 16:45:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389612AbiDUOrx (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 21 Apr 2022 10:47:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1389686AbiDUOrk (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 21 Apr 2022 10:47:40 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2073.outbound.protection.outlook.com [40.107.20.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A08514092D;
        Thu, 21 Apr 2022 07:44:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c8nRugIy9xnEVvuE94tRvC64ner+iqhjkTXo6IH5U5eSFO1Ec71N0EMGBeEL1j1nnaXxMpGyfv5yzmw0Abs2sV0C+13TQmgZ8fvmGVoBIY4WP8mLwFqmAkxk31u0aYFGbUdiDrzbsYPuGn83RJMzGV47DCnupXlXCLAHq+oiokhOV3rkaUxiVJ9VvNvlFVErD7Q25+wFhwm3HVlgQQrtZVNnSfBgBulwealC9yYMLuBdah8KzQVs9DV87Jr3GB5F2Yp/OJoBjJYM7wRoH4pXoC7JQgOztAo9OSj+5tq8R72AGWJS7BpDhpohDRmPCi12j4HWsfbS9qaRAnynmeY+Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PkjgbQ4rONBBxaqeu7k7MNzsLVbp6fcJxxASe5/sQNc=;
 b=ci2pikD9CpiOmROGOG5oNYIpXxjRDrGmxmIC/JhMgw1o+vGPgfRiyIbh+wSyjvdsifrX+vQ/B5d9D8eKFiwKNN5NU11fzDH8xyk5tqjcIJDIsxyR7ZJiXqN7AfxRpv88Xf2Uvy2p4LK1wPShYg8hC7IDLqTACiuYwdkLrpcY4Mpl40nZUyY6HOQ8TwpQPV6mncoTFlNwzTTqErvvTQHmmpEGdxJlhOyxqnKFQb/p9V9WpARpIlQMX/Vc3jiKVsfpyvYU18mlkQP3gLbuc3mrXlHYDKZlBv0rgHmXkb9ZeU8zH5D9vWjnFmBDk+2mfULV7aa2cbjLcTuXj5cg0fbEoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PkjgbQ4rONBBxaqeu7k7MNzsLVbp6fcJxxASe5/sQNc=;
 b=elaa/8zWxCytwoeUsxtw2ZiUMkTzumF0p4X/QytZeGBVIJXqe0eS7PQ40C+4EoZKIIZbbsNqlYCMGF1ch05sNe4f0bSFq1v7IdfVSlqnHtjavD2JL74mYZttgcESSKIYZPurZqS4dv5Ti2+2COAz/xiRoI9yBkt0dSh0vnMpx0w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com (2603:10a6:102:232::18)
 by AS8PR04MB8689.eurprd04.prod.outlook.com (2603:10a6:20b:428::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.13; Thu, 21 Apr
 2022 14:44:48 +0000
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::adc5:45f8:fa40:1b8a]) by PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::adc5:45f8:fa40:1b8a%7]) with mapi id 15.20.5186.014; Thu, 21 Apr 2022
 14:44:48 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     gustavo.pimentel@synopsys.com, hongxing.zhu@nxp.com,
        l.stach@pengutronix.de, linux-imx@nxp.com,
        linux-pci@vger.kernel.org, dmaengine@vger.kernel.org,
        fancer.lancer@gmail.com, lznuaa@gmail.com, helgaas@kernel.org
Cc:     vkoul@kernel.org, lorenzo.pieralisi@arm.com, robh@kernel.org,
        kw@linux.com, bhelgaas@google.com,
        manivannan.sadhasivam@linaro.org, Sergey.Semin@baikalelectronics.ru
Subject: [PATCH v8 8/9] dmaengine: dw-edma: Add DW_EDMA_CHIP_32BIT_DBI for chip specific flags
Date:   Thu, 21 Apr 2022 09:43:48 -0500
Message-Id: <20220421144349.690115-9-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220421144349.690115-1-Frank.Li@nxp.com>
References: <20220421144349.690115-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0048.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::23) To PAXPR04MB9186.eurprd04.prod.outlook.com
 (2603:10a6:102:232::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 10ccebba-1d57-4dd5-ce8e-08da23a57bf7
X-MS-TrafficTypeDiagnostic: AS8PR04MB8689:EE_
X-Microsoft-Antispam-PRVS: <AS8PR04MB8689DD9AEDF163DC8D64CD0888F49@AS8PR04MB8689.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: siaRafxn4CeE0nfo8J+w/W74DnL4+7tfAFl6ph6GY6nVadAJ+C2MsB/iY4F/bwxqpK+axEd+q+8cx/u7txUWdY0jFwFdLtIf3xeArDyGQdSAjJ8j0PkJKYHsxu3+qMi4pSbGZmVgDiII6X/TMgTKmtIorwbVoYJvfoJFyD8WuJR38vT3+/EOEQmR4I1Q/Po4YBg7tgfq8hmN5iW3VQnYw9PI0YGfmrnVffjy40nd41kZI5M7TtEPcbQtBttNETu7BE7sidYeeM1vmZpTkhL1qUUYdOEIPsgysUlE8dJmEc8EiubDyxy+AJTHn+5Kud7lgW7iTsVFAQEZLtF6tKnVx669SLotNnuT8Cat5Cdg90aplof72DWyZj5SmhethBN0fD3iXrJp4zWIEQJuSfKS86Bzjr9JZQAlEqOOpntIedVTuAbqbmDSNDNVj+o116lQ1W0DqkPWgnQmJnq+jCt/qQgvC2Q2zqooELlQ/hwZBnoFOjoz9yBMo0OvVL5zC6ob7RUFQagjB/i9ewaNQcyeeBnPrBGAIGZGbJoWEAEweHcsYQSD2clOtdK3N6Z3OQlBeaRtwRjahwB3qpzonGhOtr93mLnbbep/5tCLCVb8Ch/0iX3XJA7KkNP3luxfp6bqmhgigM+fZ+gEXcB1nYPqDQ7NHjxL9bGTXNTFw6Vw791DHvGHE8SKekaRfO33KbdfYWaQht86vTNmvQf5GZ3BJw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9186.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38100700002)(38350700002)(186003)(86362001)(7416002)(2616005)(36756003)(5660300002)(1076003)(8936002)(2906002)(8676002)(26005)(66556008)(52116002)(6512007)(508600001)(66946007)(66476007)(316002)(4326008)(83380400001)(6506007)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6GbNA8wpUe3dSCMtRwlgwL0yCGcxEf9xZykCR1/EaUnNJgzjGF7GIWFv6T/B?=
 =?us-ascii?Q?pu5wFRmH9h4Nl8CeVoTnj3rXwi9x1x47MPPSHDSHyANZFuyic7c2b5puDKNq?=
 =?us-ascii?Q?imaOhV+uVRshrck2sfTDwa4vpt5JewLIBip+IDWGCneLWJ66mwpksc6PCyhW?=
 =?us-ascii?Q?SWyZiYrlUI3kaz/LfYsytVjj+zclJz2bcBb8u3AA8Hl5dAg1O4rp8wRvCwHZ?=
 =?us-ascii?Q?HTOmAkBuFuaF2fhyeNU26J1dnVR6AfczKIw54E+PVxBw1Iny4zCpGBS+dDkg?=
 =?us-ascii?Q?kQ5CSYyMs57w29TtNceHPxY2vwxaToCQX32XTQkqZZw7Icd4ZgUJo6+y/1+Y?=
 =?us-ascii?Q?nC+hHLT+yXWe1t7ZGsi0uUOEcLAF1f2XelnEAxmZCBDYcb/z//00VCfFFlKd?=
 =?us-ascii?Q?EEBcyiTG215+NMeBXf++U23/3iHCC7GZ+d9NpPVB353TN1USBCNS/M1apr4f?=
 =?us-ascii?Q?Hinl9TIb3SwhTNkIMN4fmL7f7Qublc+icwJ7zZf7XWHTtn9Ks/GIBGqfemfA?=
 =?us-ascii?Q?ZtSRnqkEoLXSHaboTIIvL/RmQvAj27iIU46vIatLhBc8fzKnlcOkHQGwg0/L?=
 =?us-ascii?Q?mMhTxC4SmmiX2Z7cYSwryByUYSY7oQSOOtweWSrQwfyh7uFNL+ZuTkp+sYbO?=
 =?us-ascii?Q?G8Lf03mt6JYVmD6fR9X2L6TU0z7AnjoM4R3APNANNAuqt6leTSb/qFSaLeWZ?=
 =?us-ascii?Q?bCcJs+GxaItKFhfLBcnkJMJNb9AEd5bkwSk5Hu7BFV9S1/1pzh58gziqRYz1?=
 =?us-ascii?Q?G1vegUHeDxq7dGtEh+C4//ezn6xzmPwcRBCR2y6THULtSA943/iZoEM27aqn?=
 =?us-ascii?Q?xogGXJwKGWC0Zvg6vmeWAtouLdImmRX7cpRuxgbokiGN/C9Fr7NgLop4Rvet?=
 =?us-ascii?Q?bmmswi2DvEvG7giUKizKpzb6Ofagv2GwuVuqi7RZ7lHiWLGEcD9kVCskoS+n?=
 =?us-ascii?Q?cvms9gVOC5I7f+etR1IdyCa9nBU0iu33pXe5RYCmc+1k3OFOGhlrWF1zxsbs?=
 =?us-ascii?Q?AxaRUsQ2opNicWeRoFzfXAgpy5RSyVYG/6q38FKSdwz7NbaF68mASxDSH9gr?=
 =?us-ascii?Q?TQxQealrW9/u4ENc/k61QbYoyEH2FaFKxQnMa1WlLaL+wSftpQja61gDGZco?=
 =?us-ascii?Q?y7tM+dSXl2PL10OFJSjbO0EX0NXCAGcqWdh5XhuejtMTYBqwfoGTnbJ1R1xe?=
 =?us-ascii?Q?bV9XlCnFqAYo6WNvwip5uMj8hsioLEUnnHiEvCzk4UAW6Gn8tWe0zX5lLH5L?=
 =?us-ascii?Q?J69eE2BnxkuWtsp8XuoZsZQhQQmDTxSE3DbVFHWC+vmxEZ8xBxIoWkuvYz84?=
 =?us-ascii?Q?Djme2BXIDhjo0QSLO8BAEgdzMUzXOPFnpPWiXV4w4uU0sTS2YHgfeXeCkCUK?=
 =?us-ascii?Q?A39H2WLhxpbA21tOvC0m7M+UCMMBb6hfhGlcNFdFOwP67MnVrATCdQDA22XI?=
 =?us-ascii?Q?ZON0AN/rrOMTKDSkcoUPRUT/Jmcy34CpCw8A4lziABpUvPB5J99qfqiEjr8y?=
 =?us-ascii?Q?1V9HEMBP7RF2pFN5CjAerxEPgMU+fSiO32HYz6PKTIUEMP89jKNM+eDaTcqa?=
 =?us-ascii?Q?IUjMkXL9UB5bPMjwat4NVC/4C59x3Zds3mDyVILxyoIa049ibfgeDfNxx6Ob?=
 =?us-ascii?Q?ZPvOx7IAR4WoozjY3Wu4C/u9onoGyVya0SsLfI/GoBrHTlnK2a2E4KbZt5LF?=
 =?us-ascii?Q?Ed0X3Ijb35FsY2q+9lyu3so4RGGVAkXS/6YRndlA2uFMwe0KdjaP1SwJ7ak4?=
 =?us-ascii?Q?5vGR+BZU0w=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10ccebba-1d57-4dd5-ce8e-08da23a57bf7
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9186.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2022 14:44:48.4634
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a4/pI8s9AKzNP+q/wMzrGBX+8Spvhxp2/znzgNYUOm2TXaL3rSpy7BStE9VGBMybqYTQNTMLJ310BFsWQyle7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8689
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

DW_EDMA_CHIP_32BIT_DBI was used by the controller drivers like i.MX8 that
allows only 32bit access to the DBI region.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
Reviewed-by: Serge Semin <fancer.lancer@gmail.com>
---

Change from v6 to v8
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
index fbd05a7284934..8b134896c9edb 100644
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

