Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E88A0501F3D
	for <lists+dmaengine@lfdr.de>; Fri, 15 Apr 2022 01:38:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347723AbiDNXk1 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 14 Apr 2022 19:40:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239685AbiDNXk0 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 14 Apr 2022 19:40:26 -0400
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-eopbgr140080.outbound.protection.outlook.com [40.107.14.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42AE3BB931;
        Thu, 14 Apr 2022 16:38:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a491lctX8SrOzG/napC8n/zPRc7dGoShAC/c0ywzm2774mc4O2Bi082L5CEGiSsrVY5JK7B15BYAhpi1djgK7ghIxTL/JxWEsCH5QJ5joD5ZIR+SlxWqrB3Q5DgLztQb/NmqKU/JpmKvtJ8YaVQdK9YO5Fjgig8/U0v9eY15fIIYh5FDWrmIJo6F3H8dfDZZ44m4u20rXD9tkX3YjUm7Chck29eAxpTtfdpQ9UAbJDq8jW7rbUwwLBN/M9EeDrbPni1pkWLtsyIzntSr7QunwW4y9THOIA13uVMktDg519qQB30fxVQ5rgWuwBE/dKAxVuGjFZocyXVmc9w3MKE1og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GYzyqiMS3WsIAkX+/4RiuVDLaIkkH6lTzekhetucJl0=;
 b=mjgRPq/7Vq2/if41ikrLhq+5qcTn3ckbNR23YQSxnwOUvToEQRMuTnwlvekCPzsgeovxkUWsc4OREor8rlowl8SnV2eFdEcun9fAv47P4QgNgl9REA4THJ1ey0VSFPpI2oBS/dXzDpatD0zSvyu3v67vMnRf7wsEh/zH7VE32vQxOvnPWDBHImH/t522wPIXfI6QYlyR9xY8zu8h1fzvm86ldu7M8bOXdDKdvNTxdCMa3xhireFNHeqCB41azCs8Xqc7aNXl4jVc0mm1bgppwVeZbHkqIM6iIlIg6I8+b0w21yT6nz5uP7/EvlZ9ezaWnisrt0UNc9/QKXG6QrUTUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GYzyqiMS3WsIAkX+/4RiuVDLaIkkH6lTzekhetucJl0=;
 b=QFykjqOJkZw3pZzw36s6P6JsN72aLtNAJhvJO+saX4tXU09VRXvOlUJnvEhVhDp94Hu+kfGe7dAAXGSigwrKibTBosIPt9LrnfCp4zkWwKRf4gff3TBxuvBEnbG6hT8nzTXPYo1fnbzB9TCtAoRXUSunhpBpzTeJBQoSLcxGgoI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com (2603:10a6:102:232::18)
 by DBBPR04MB6043.eurprd04.prod.outlook.com (2603:10a6:10:c5::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Thu, 14 Apr
 2022 23:37:57 +0000
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::e13c:6fb1:ca92:d11b]) by PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::e13c:6fb1:ca92:d11b%9]) with mapi id 15.20.5164.020; Thu, 14 Apr 2022
 23:37:57 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     gustavo.pimentel@synopsys.com, hongxing.zhu@nxp.com,
        l.stach@pengutronix.de, linux-imx@nxp.com,
        linux-pci@vger.kernel.org, dmaengine@vger.kernel.org,
        fancer.lancer@gmail.com, lznuaa@gmail.com, helgaas@kernel.org
Cc:     vkoul@kernel.org, lorenzo.pieralisi@arm.com, robh@kernel.org,
        kw@linux.com, bhelgaas@google.com,
        manivannan.sadhasivam@linaro.org, Sergey.Semin@baikalelectronics.ru
Subject: [PATCH v7 7/9] dmaengine: dw-edma: Add support for chip specific flags
Date:   Thu, 14 Apr 2022 18:37:07 -0500
Message-Id: <20220414233709.412275-8-Frank.Li@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: c0789dc2-eb62-498a-ae20-08da1e6fce17
X-MS-TrafficTypeDiagnostic: DBBPR04MB6043:EE_
X-Microsoft-Antispam-PRVS: <DBBPR04MB60430C98EE38426FC79EA04188EF9@DBBPR04MB6043.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6pztZI49HC9Bt6NjfHpSgIy2mz+etyPmIoc5yM5/ppPF6E2fk4wU6w/oAAWy264GjaB/rgGIThqiGLHY32rp57Z4+DAIAnvub8ebl6ZX57SB6579P9msK62kh4lDqlFGJaZFGkJL7QU2oTC1ylhBOb2MlHoFKURfr5BMONJOROG0x4gXjKwKS6k1unGPEfmgUIlc5FlowjD5CpmfLGgn/YkF/YfyMXkn8HVK8eSWffFVCqj5u2mdoS90MWvpr5Jj+t2n1TDyi5pXOwIO7Xo9au4W7fPIIsn2w9aE/Ty7EVZ3+fvYFTdMQtKwtNo49w665OJtTcZvOHXLPwZTtAfGtjwPtB7O4KPd4QCQJ89o87DVB8AiCgCDk8CHRDR4hE660rAojY6bs0V9mKkWtCOMeTnXPopjUwQkyEptgWIUTVtVb1uxQQzp4Hr3FNHiJFzUmADZ4s99VMObUa/PiiBagB2PHFZx6i446MFgoPWxGcwpRnoy7KzEDrC2eY5ADhcTS6yiDap+71117IliP1oMLn54qA3ib+u+scKSe2auJmy0polGjWas9oFzJgHqj9CPIq4vgUJ2u2j/qcVAqqrN6e5iX4bd9XBUQICnVmikrYAQDQhmE10zrAnOQg+DyKgwuxFiLeMQxP6WkYhL9lF6RNJtFO2jb010LKaWQRo+oKQzXXtwCm9asH/s7uZM5CjYlCXcM36fFPMRqEh1TesLKw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9186.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(5660300002)(6506007)(8936002)(38350700002)(83380400001)(36756003)(38100700002)(508600001)(6486002)(2906002)(6512007)(6666004)(4326008)(8676002)(186003)(316002)(86362001)(7416002)(1076003)(52116002)(66556008)(26005)(66476007)(66946007)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RNf7P0Yhpt6gC2JgKvFPmHjKf3gDyTJfcqTMH6lCPKsNQe385Ty9zQ2EeS1M?=
 =?us-ascii?Q?ukEmm3/NiWagSX8Vw5IP3vsoOcpo1mq17d/w+Gx0qGKDii1lRYzT8pQWCha8?=
 =?us-ascii?Q?IVE1Nv0eUMwpxqkyV+pvcUnL52c5IPAyRUMwc2sa5auZIEfmMrujm7g19dS8?=
 =?us-ascii?Q?Xl+MD/xycV6qo0q5Ja2Pf+jbA7LtdDGE14ib5OdNQ62rmXnyzxQIYyji7sNd?=
 =?us-ascii?Q?nwM1AwocuVF/lJoRQl5MAGU5ocgvlzoylJzLkSLWKn1EWyUAMhX5EdUNF/k1?=
 =?us-ascii?Q?sSaT/nS80nK433XSbLtnl5xOS0LaaslPrwu3dcgud8EZ8U1TBxvOW9o6Z+6F?=
 =?us-ascii?Q?4kszbriFxmgmO1yTce7s/E1K6MwwWGKzk9PmsVGJjniOmev7wr7XnTiROXIj?=
 =?us-ascii?Q?X/G8+7rz/bduTBDdJ0aXYij5G4D5DWxvVJUnjoCaEYTgTrQHY2lSSKQGNrv2?=
 =?us-ascii?Q?TgDxbQI10g6ZGEVaVghyZgkVFs+6MIKqDfMGB1YPACBpbu9RWUHhIl86i7Ze?=
 =?us-ascii?Q?BA5ST8wJVBqdBB6WYDxE95GjZaHYrU8sNrsO2qO/OZuaPMbGXLqQ2OYTD3wT?=
 =?us-ascii?Q?cxsAPczPGWErsN3j/nUDAEJQbmBfxGEW0DQpouRp2jS+l8KSMxRdXFbsuZeA?=
 =?us-ascii?Q?dz/vPRPT20WMIjeNqageSQlCw/BN3s991rVVOYI5rlW/Lhipny6aXvkSj97x?=
 =?us-ascii?Q?UASoF8fJ5iKN8uP/sQvI74gatMPgtc+i5Bs5vCkKcl+IMa8WhKG5IoK+aHBW?=
 =?us-ascii?Q?kvhvlifJvdlPhNprYvLonM3USRXmBhUWTFooT1eFrDdEu49Xbs3k3dXG4p6O?=
 =?us-ascii?Q?vW/aYrIeNRCjUeprW7tRqCqPGcixcu5zA/dbW3i84fHDqzvvElWxezv2/yc2?=
 =?us-ascii?Q?gLEXVltScZUNiCK/bPCH3UzzaFiJ2r30C8DeyB1/yayP/ANlEaJSONnVOKTH?=
 =?us-ascii?Q?b1nIntZJsinnawxy+TCjBhZT7pKWLZkr9y/UvQt9M1cIEb7p2BnXO8dfOEDq?=
 =?us-ascii?Q?ymodlBwxVKTGvBDzvJQ3AH/giltdu5Br7IrRWgzdX1CCsUAZy7IKtgQfR7Bn?=
 =?us-ascii?Q?z12nST1M6eyYMh4oGJhIm6rvyRWyeV5TbiTduFNi3rnnDeG8KSGD5ZdfcmLA?=
 =?us-ascii?Q?+OSzeLlPyqrV7g7kYEYKPAj4ZifLVpzfXdfaTX4OyKQeQRbj0nqQE05UenOx?=
 =?us-ascii?Q?4vhnBE1FAXC6CV0MZdvExjl45FK40sw5F+89tAr7dS/4/B2b+wmSMll78rI6?=
 =?us-ascii?Q?6SFExZb2J/3v0ll9EzTkdL+xQClXyyvaJ17yp+vD1ZBrVePcLcFut0Iv3Fp7?=
 =?us-ascii?Q?HXKFw3E0FIm8ZJo+MW9DttM9cZhQTfsUvWOYhrUaDBPfFejVpb7VF/8thTxD?=
 =?us-ascii?Q?3BiEPBIXAMmXugKwMYLdywVmH5NODMfXekFc389qd7MJiWjtgAjff2Huv5fz?=
 =?us-ascii?Q?WSR6xu96zvDn0mUXDfdu/Qj/2R1XI96PqPwJmiIVcZyIj70xzn7kSKpZ/jt8?=
 =?us-ascii?Q?svOyIaxgYxtnygBembXOieN4OSaiSp6EL/iBo2ocSqaFYoBxffWacbp0ixpJ?=
 =?us-ascii?Q?4cxAz1iVQ1lRRHpW8UHIbvf5n9rHY3hMOPnJnDy925mcuutAd7RnmnWGprlp?=
 =?us-ascii?Q?vP8oUzshPPOa/fvtvklNbrCxmIpqWCxdv6knWFTNWXdT1GuMzwLNxI7LByRl?=
 =?us-ascii?Q?KQFWu7TwLarQK17lNUhZE8vIWw2P1gjEx6KXu0M09DeIfpL4LiGenH0YF1xv?=
 =?us-ascii?Q?6gcXgzTgXg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0789dc2-eb62-498a-ae20-08da1e6fce17
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9186.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2022 23:37:57.7801
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7f2Xbl/NXKgS31IBc43LQxD2+WinP7wzJFC0X82knYf7NkwIzmUwiEz0uQZUgQu6QlHL5R1xFij/khKZeCpnEA==
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

Add a "flags" field to the "struct dw_edma_chip" so that the controller
drivers can pass flags that are relevant to the platform.

DW_EDMA_CHIP_LOCAL - Used by the controller drivers accessing eDMA
locally. Local eDMA access doesn't require generating MSIs to the remote.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Change from v6 to v7
 - dw_edma_chip_flags to u32
Change from v5 to v6
 - use enum instead of define

Change from v4 to v5
 - split two two patch
 - rework commit message
Change from v3 to v4
none
Change from v2 to v3
 - rework commit message
 - Change to DW_EDMA_CHIP_32BIT_DBI
 - using DW_EDMA_CHIP_LOCAL control msi
 - Apply Bjorn's comments,
        if (!j) {
               control |= DW_EDMA_V0_LIE;
               if (!(chan->chip->flags & DW_EDMA_CHIP_LOCAL))
                               control |= DW_EDMA_V0_RIE;
        }

        if ((chan->chip->flags & DW_EDMA_CHIP_REG32BIT) ||
              !IS_ENABLED(CONFIG_64BIT)) {
          SET_CH_32(...);
          SET_CH_32(...);
       } else {
          SET_CH_64(...);
       }


Change from v1 to v2
- none


 drivers/dma/dw-edma/dw-edma-v0-core.c |  9 ++++++---
 include/linux/dma/edma.h              | 10 ++++++++++
 2 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-v0-core.c b/drivers/dma/dw-edma/dw-edma-v0-core.c
index 8ddc537d11fd6..30f8bfe6e5712 100644
--- a/drivers/dma/dw-edma/dw-edma-v0-core.c
+++ b/drivers/dma/dw-edma/dw-edma-v0-core.c
@@ -301,6 +301,7 @@ u32 dw_edma_v0_core_status_abort_int(struct dw_edma *dw, enum dw_edma_dir dir)
 static void dw_edma_v0_core_write_chunk(struct dw_edma_chunk *chunk)
 {
 	struct dw_edma_burst *child;
+	struct dw_edma_chan *chan = chunk->chan;
 	struct dw_edma_v0_lli __iomem *lli;
 	struct dw_edma_v0_llp __iomem *llp;
 	u32 control = 0, i = 0;
@@ -314,9 +315,11 @@ static void dw_edma_v0_core_write_chunk(struct dw_edma_chunk *chunk)
 	j = chunk->bursts_alloc;
 	list_for_each_entry(child, &chunk->burst->list, list) {
 		j--;
-		if (!j)
-			control |= (DW_EDMA_V0_LIE | DW_EDMA_V0_RIE);
-
+		if (!j) {
+			control |= DW_EDMA_V0_LIE;
+			if (!(chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL))
+				control |= DW_EDMA_V0_RIE;
+		}
 		/* Channel control */
 		SET_LL_32(&lli[i].control, control);
 		/* Transfer size */
diff --git a/include/linux/dma/edma.h b/include/linux/dma/edma.h
index c2039246fc08c..5232d3d198f88 100644
--- a/include/linux/dma/edma.h
+++ b/include/linux/dma/edma.h
@@ -33,12 +33,21 @@ enum dw_edma_map_format {
 	EDMA_MF_HDMA_COMPAT = 0x5
 };
 
+/**
+ * enum dw_edma_chip_flags - Flags specific to an eDMA chip
+ * @DW_EDMA_CHIP_LOCAL:		eDMA is used locally by an endpoint
+ */
+enum dw_edma_chip_flags {
+	DW_EDMA_CHIP_LOCAL	= BIT(0),
+};
+
 /**
  * struct dw_edma_chip - representation of DesignWare eDMA controller hardware
  * @dev:		 struct device of the eDMA controller
  * @id:			 instance ID
  * @nr_irqs:		 total dma irq number
  * @ops			 DMA channel to IRQ number mapping
+ * #flags		 dw_edma_chip_flags
  * @reg_base		 DMA register base address
  * @ll_wr_cnt		 DMA write link list number
  * @ll_rd_cnt		 DMA read link list number
@@ -53,6 +62,7 @@ struct dw_edma_chip {
 	int			id;
 	int			nr_irqs;
 	const struct dw_edma_core_ops   *ops;
+	u32			flags;
 
 	void __iomem		*reg_base;
 
-- 
2.35.1

