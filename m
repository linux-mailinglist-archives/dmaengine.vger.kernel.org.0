Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6959C4F67AC
	for <lists+dmaengine@lfdr.de>; Wed,  6 Apr 2022 19:39:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238768AbiDFR0X (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 6 Apr 2022 13:26:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238867AbiDFRZ5 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 6 Apr 2022 13:25:57 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2049.outbound.protection.outlook.com [40.107.20.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3672D48858E;
        Wed,  6 Apr 2022 08:24:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YN+lbMBNyviym4wTgZY+bV3SYZ9ViQQBIt5CAEFgkRKvrXmK1qrbs9FbtxxPbwHXhJvgVJQrS6FbNc6kNP6OVCxfJgdXe+YRYIga+FjepfiYJLOi0H5xTNEc4f4AtHJm2HRV7yQbqR1dh0D5zw+X2k7dyjpRYOD7HJq2gaQgVMDXa+UPCya/6Fy538ugOboExJUUo6U2HKk4BXxNp9MOScyUa3O7XdOqf9inJXV3mkgzUyyr3pSu20YnHhphpd0etlZvG2Gsr40VBtZlyNnQmjhLeed25Rlmrj29EHobHipiF9Sqd6Z26vZM01OUwYJzUHmTkNfWPbnrj5mwuIXt7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2yt8poeLQlw8HSzLf+nrRh8ixTw+HA6ON3PCHO477EE=;
 b=EYo4UxnBBY9U2dgIFHWfHIq7C5KY7+IBaXFeySiSUC4WgxkUFjQytiRPz5jy5O5ZpvCtHoA0vpwHJUTfbSqq1lZGJh12l907b5nEGUUg3QBOwwj8xHKyAtY+DawvcoBtRsqxceAe1w9cca+PHkxQvMGE3hQKfdFKfc4Xy69Hcu9teAx+bP7avpB7VvyOodV4L1iO8r2vzIoPqFAAUOH3jg3NDq1SLr+vacre/gBPCVsJDrG7qACRyB3PTA2GkS6ZVf4VxgmYA0I9SPdYmG/1myGI2yQQWOzTapz1TgBblu7Iwxuyt0O8+lJIJY779uKuGcKb6P5GA/zeZ4MH7XH+Dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2yt8poeLQlw8HSzLf+nrRh8ixTw+HA6ON3PCHO477EE=;
 b=kLBGzhgCfKPO8U1zhmX1cS2l4To+GWqXoVYXfoHWGn/R/ik9AWV4CJ1F0F2shhcsNLfCFdm3JtO+QZY4PJgavuR7HcrV7uzH/sV34WmC6cWd05NSIiCH2XYKqcOfVgkwndo2204f8pke2DjQUufj9qcCiUDYy7b3lrV4FC0QQbg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com (2603:10a6:102:232::18)
 by AM0PR04MB4033.eurprd04.prod.outlook.com (2603:10a6:208:5b::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.19; Wed, 6 Apr
 2022 15:24:52 +0000
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::ade4:ad15:823b:7e2b]) by PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::ade4:ad15:823b:7e2b%7]) with mapi id 15.20.5123.031; Wed, 6 Apr 2022
 15:24:52 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     gustavo.pimentel@synopsys.com, hongxing.zhu@nxp.com,
        l.stach@pengutronix.de, linux-imx@nxp.com,
        linux-pci@vger.kernel.org, dmaengine@vger.kernel.org,
        fancer.lancer@gmail.com, lznuaa@gmail.com, helgaas@kernel.org
Cc:     vkoul@kernel.org, lorenzo.pieralisi@arm.com, robh@kernel.org,
        kw@linux.com, bhelgaas@google.com,
        manivannan.sadhasivam@linaro.org, Sergey.Semin@baikalelectronics.ru
Subject: [PATCH v6 8/9] dmaengine: dw-edma: Add DW_EDMA_CHIP_32BIT_DBI for chip specific flags
Date:   Wed,  6 Apr 2022 10:23:46 -0500
Message-Id: <20220406152347.85908-9-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220406152347.85908-1-Frank.Li@nxp.com>
References: <20220406152347.85908-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR11CA0046.namprd11.prod.outlook.com
 (2603:10b6:a03:80::23) To PAXPR04MB9186.eurprd04.prod.outlook.com
 (2603:10a6:102:232::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b94cf588-ec6f-43e6-5edc-08da17e198d7
X-MS-TrafficTypeDiagnostic: AM0PR04MB4033:EE_
X-Microsoft-Antispam-PRVS: <AM0PR04MB4033498A54301D0E5889E00788E79@AM0PR04MB4033.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EOllJiWUsOYdySwn5iAHa74g38dZ+Jb0/QXPs73dT6oo9mX2PcqjAjN9Bu/3mm9yogddaTmyynl0IZblB0UH0AsVxhr1nlRJSGe573leBau5AGV/4zQgTFLljcM6o90NAxZGYFz/41Kd9ygsh8FOLGfdcFMEc9OP6LTwbSilb0oDBhI+rBF/dnZQ4psGpzfhYhdd0B3/QGruOj8wLDWftA3O0t965maq5lHYhS+6wXr2Cah+DztRqOx70OfrTkjQ6lESESHPq7+zcYrlWaZefC7IAzqJ60nvFTR1m3z+vw7A3izhM+wGEC2xDQDCySRFsMu503ewoSq4ztlOHiyK0eLovUPHg2JqnqD24wHPH5zQzR549EucwWvXVJIFDf8Q1OGK/Fuy/qiJsBQd9tnT7PVXuoOHez/ETEuR/F7ulDhXT+6mq0K85tVsPiU/eNKB7kRxOWgj1/hS6POrOM41ErnhkfSYAo9mJ89wN5BzljRreSmw0C52TbZBC3zb/6YLAjeuKVUibMWrpcvsXA77iWsuYIABMdym/6wg8zh2UTm1LUNjoc+heI75MyEJ1f8nLqVyd09mt6LjvJl4iwvy2xgNVEFa7c4fIfs1hHNEFJTiEJ9JnAAN3iR9Uue2uXiV5fmrs+4+Mn6pfezOk9r9+LLmkoL2P0BiQ9wlbrC0Z092MOkCijdVxbs7jdDQcvMgph1UY2QIEa5GvJDF9x/Vzw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9186.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(7416002)(26005)(1076003)(2906002)(2616005)(36756003)(83380400001)(186003)(8936002)(8676002)(6666004)(66476007)(6506007)(66556008)(86362001)(66946007)(4326008)(5660300002)(6512007)(316002)(508600001)(52116002)(38350700002)(6486002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?crYz96TO3woanGKO4EkBTrVTW1YSxa0DXzoeXx24HEUPaoVgpSgCAYL8ollT?=
 =?us-ascii?Q?DvlNQhd5iG2UkmYe6H9U6wPKnQ0aFBjuHBUckvfQxt2KRzectpqXS8zRwQmH?=
 =?us-ascii?Q?L8TBtA/oKZIL6bylK//VVItlVsbn+LcVOaPbkvZwLhRPH059UKcqw1jng+yv?=
 =?us-ascii?Q?uaOulPsyWn7d+HbjX+JVh7XY0Yd4M4Zg0sIxUxnuEaxyFS4bSdWyJd7Qy+K0?=
 =?us-ascii?Q?E+ooVYazN/UPIlVPM0Cpr9Iubivz26qaGs4fM+Ecp1ahrfZSzaM0bNnm2cx4?=
 =?us-ascii?Q?A78TivDqlh/FSA7Zb3Ns5BL/nY5ktzHozcZFT5o8g8Wl0FG2uI+PWYr7bXLC?=
 =?us-ascii?Q?lFW2OzjQztOZqC8pwdc4n1bRvp2w0Am6EgSmTVzkq8l+F2dkQS0HwRuR2aqc?=
 =?us-ascii?Q?jE2SWmNeeyUpu8bOwDqfHUjtEMmPU4no8mcAqyWaGIwqV9TS6IDYVSqAOPRm?=
 =?us-ascii?Q?1RLNTjF152GJpT0IN3lamF6LR13R9jZ8kKOhgcbyPnhCnLAClKiBn3F/K1UH?=
 =?us-ascii?Q?3Azwq/N86HrZeiqsAbmJ+DID1TDaUQFfJTs5BD9mGTqkqRWMZ6AGnkg503GN?=
 =?us-ascii?Q?I/kRx2eKMW+bYx5wH0ohRXRC0NqrzZ5W8U3Eo7YoBQdgdNZPUxL/FMYS39uS?=
 =?us-ascii?Q?ZUlncJJvPMuSc31CB6M5BefoQ0rF/RZeo1A7S2zqfGQ3qow4kxf8ZPClwmLW?=
 =?us-ascii?Q?VQMOk0lsq4bynliBVdX0IW6iRGbSQJB+Ee8XIAX6lCUg8jycP9N0oydR+RJ9?=
 =?us-ascii?Q?LFoKmibzUcEycec+sSTa3hLcyrgwQMzmrqvTRk9hIwm8CrIpssZYy0o9bAWw?=
 =?us-ascii?Q?iL6xdDoJbiXLzPBXf1gZq9KE+Bjvbjh60POTBNPmeafNXd2eXE6507k3fMh2?=
 =?us-ascii?Q?KKKddyOCOqxY3QDwb6gym+02wZMdUGpzZndqmf/8R4NOHJ129vlhx8PP2rW9?=
 =?us-ascii?Q?JKQcEcgsA11cAv+TESzWu3blFK0L8pwcBNKnw087lFnGfMpmAkMDO/OxZjwQ?=
 =?us-ascii?Q?d8LdXI9jCjs4K4qS9VDCrj4jsldR1J2fH8mccG2qutNintPO6khbFpPDzl7E?=
 =?us-ascii?Q?Qkvy3dxaPJ4V3tdsam6thQfY0BOXguMOhVsyWM5bewOH5+Xxpv5KK79PV+QL?=
 =?us-ascii?Q?HhD1/qhsEWWWblwzP/uYKHpvQTLR/QVH4QLLEosg6QHaW4b50qpyXeGU8JfO?=
 =?us-ascii?Q?UCtDF//IHDaXICHPQkmg+aZ9oArVqtvtGGleNvPKfO4zoaVSTEkounb+8Uc/?=
 =?us-ascii?Q?MVugmrVOYsFebqtz8fRv+7ZepaflxVwRSDyJkgNWBTsrUx0VRUBlyqIht1lB?=
 =?us-ascii?Q?WwuXbVli59TSWz4SEt6KTSuZAbiIR9TcqCxA4G9E03B2Ej3T2YxSIblL1DSv?=
 =?us-ascii?Q?gs3yn/Y3CsJnMF01Ash6pqZZpTe6mpM3UzwMxabcr8Pb4YlaIMaV/s01qEN2?=
 =?us-ascii?Q?ibo1fuzlqFtnNeX85q5G/r73jfEvhOql2XTt5bruObZjGfBUCttgBbduNY9B?=
 =?us-ascii?Q?GamgCb6Beeg/qvxcZdnNEG4fXt+MIobb4o2GaEpvBOuiq5HEloZvA47DPvOE?=
 =?us-ascii?Q?jbS0MtRkswYt1GuZt7EFdHRFfMy9x7qo18FRwZJf92sZm3PJm1zANzxw2Fdb?=
 =?us-ascii?Q?60L1M1OTXjQXSdLJUq8pxTIhZvCSSOCVjWyjGlpyf7gITKWvk3m/CkTjQpHL?=
 =?us-ascii?Q?yhLkot22/MOLzN8ORQkjQW6zrt5YxTWKEGGtPUccL0JFfzaWm+yj5PQjiqYM?=
 =?us-ascii?Q?TJ6q3JkN/Q=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b94cf588-ec6f-43e6-5edc-08da17e198d7
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9186.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2022 15:24:52.7552
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xKjGgHapievtcAZHN9hTPWj7QJFxOGPDyVANIs4mNrpugtXVZS7H+rqI5nDqCU0gvuKikyKgGb1DSoW+fMNafA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4033
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

DW_EDMA_CHIP_32BIT_DBI was used by the controller drivers like i.MX8 that
allows only 32bit access to the DBI region.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
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
index bec444e2939b2..dc353a33a4a25 100644
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

