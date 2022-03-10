Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AACC4D51D5
	for <lists+dmaengine@lfdr.de>; Thu, 10 Mar 2022 20:43:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343554AbiCJT0s (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 10 Mar 2022 14:26:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343549AbiCJT0r (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 10 Mar 2022 14:26:47 -0500
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2056.outbound.protection.outlook.com [40.107.22.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F853136EEB;
        Thu, 10 Mar 2022 11:25:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KKTdoD2dM0ItKzgUrfgdDeQKWLFlkiBFaT1wlesLRO9NfchT7D/vk1vgyTCty36kSpfQV5fey6YUlthi2Jn1/Au5TYMGMBkVXeIacCKPo+xIUkUlvKNsCqpNt46L9bgEe7HwvNaFjy3RTIDKvfzeogRgDHCTrR8wGPpyn2iJ7R9r/PaouOzhxMC/fRmGnkcAj51lfVcLJ3HKqYxUMaBklLNdf+YmvQlKCeoUVJcMKRTWTyvso18/bTmFu6cSGMkCwvLLJvcssHb/s24HNBJXRcV5ysP3lLn3rUpq2leX79vRPRuoG5yEs2Eziyhoe3oLoI65J+hBoyUe74rxSmk1nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m65v4UP7o2Ej1q3jDJdrf7FtoXo4JVDfG1MASIb78/g=;
 b=bKVeW3R7Zt3DKSuDqKToLu532rLrV6zO3vX0eZvuLaV+5TiCUPBu4iLQU0fyQimk8f3LQJ+XVcHvUR2yiBwdOeI1wu5TJpGHTi2nF/pwupxZag6lMi0jwV5ep6kAEpK16bJG/c6gek167nGlW/Nt3QcPadLb0/uYorsjl15zpD9+BsqGTidfHk4uhMZPUN1RbOhhSfFfGPoSFJDtc3qcanusywpeB4D6oYZNyGEhg4Blps7IQpRTZlKnAQ0eCluNK0XC8q7cHa+iK5dvUlp21P/covvJFMpHLiL5MNhCw1/UEHYtUclTQzHuZZXu+w3PNezWjmaH/dMH3aS3u1no+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m65v4UP7o2Ej1q3jDJdrf7FtoXo4JVDfG1MASIb78/g=;
 b=rPqCV2VXeZnB1h8R+MrVlvabGFBp1LyLCjZ+URaZH7+W6QC4/QD8FZurHg6OhGxTbeY/QmHn/qa5Wk0S33iQs9eijJfl4mviqTg8/9N1qopu3S3umtmzlgAlWHsT4NkaeDWwk2LLtlRLjLUBGY2AUlWNLmpn/peiuZD6MZdfEXg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com (2603:10a6:102:232::18)
 by DB7PR04MB4858.eurprd04.prod.outlook.com (2603:10a6:10:1b::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.22; Thu, 10 Mar
 2022 19:25:44 +0000
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::c897:1bdf:e643:aef8]) by PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::c897:1bdf:e643:aef8%7]) with mapi id 15.20.5038.027; Thu, 10 Mar 2022
 19:25:44 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     gustavo.pimentel@synopsys.com, hongxing.zhu@nxp.com,
        l.stach@pengutronix.de, linux-imx@nxp.com,
        linux-pci@vger.kernel.org, dmaengine@vger.kernel.org,
        fancer.lancer@gmail.com, lznuaa@gmail.com
Cc:     vkoul@kernel.org, lorenzo.pieralisi@arm.com, robh@kernel.org,
        kw@linux.com, bhelgaas@google.com, shawnguo@kernel.org,
        manivannan.sadhasivam@linaro.org
Subject: [PATCH v5 7/9] dmaengine: dw-edma: Add support for chip specific flags
Date:   Thu, 10 Mar 2022 13:24:55 -0600
Message-Id: <20220310192457.3090-8-Frank.Li@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: ab0062ed-a6c1-4b62-959e-08da02cbc552
X-MS-TrafficTypeDiagnostic: DB7PR04MB4858:EE_
X-Microsoft-Antispam-PRVS: <DB7PR04MB48585E70F116B027DF71B77F880B9@DB7PR04MB4858.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CN7+8duKIUW9uySAES7asFD92fxfAJON5onGLplN+l+vFJivaW2kZ3TV/EhThAeodV8kRlVTNz6bXTgt+PZioM7T0wc1FSYwiSU1WLryE4XScsSq135m5bnsC92tvn/spD5lHp8H+uDIa4tEJYJdEFULgQzrSsIAoAdWMVTFbrL0cUWqBjZ9uv6lYhnabagyy5Shy97/pcMPNWfznLtOQO2Kx+ZLEnPUrz2orqVoAgBYAgb9q3V/2d6KeBoPcnCiO533mVHpwuXNxFDLW59SNLiFHbI9rX+gnLFvnAw7P/QL6h8oRM6Ekx9LYN96ZDvhn5NRqb/s5wpA4e8ATnMJXou6g3VGuPxBNhmNjS96oVx9nbEd+IhxzHs6/lLqYGAwHc1j0h/+X581REiFUySKqdrFoYpeNssLijZOhX75E9cULxgnZMatSFcBxgRu4wQk7eV7nEIMmlmviW3UZIUlWT+6EngrDe0UMNRUQ6iuYVIgIJCUKJE/XKPvqniKk10n8qStTAGx+1oDoBenQEWgdORXU3HzaInNGMu3obbOf69jzvp/W0Avut4UiwuKGwSZBABUOAQ304aBmyJ3dkNkLlMzwPw3zp5gBwVez7NQveUn8JdpT4dWxn/upk+dnhq5yO6rQJ3T7vOuQ6kbaf60W5jqDw2R2t4FqEn4j2a14GCiLv5qX7OknhKn1ygTqsngmPb/tjcHPzY1GU39dg95ag==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9186.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(1076003)(7416002)(6506007)(6512007)(36756003)(186003)(5660300002)(66476007)(52116002)(6666004)(2906002)(2616005)(86362001)(4326008)(8676002)(66556008)(83380400001)(26005)(66946007)(8936002)(38350700002)(6486002)(498600001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TY1zNgNN8ci6CfXRg3kkxhbRjIPpDV3kfwfW8MIwLIlKM3wK9wPcOe0dP12n?=
 =?us-ascii?Q?xxAoo76y5Xh5DEwmUcG+RPpBzqt2QwaUlNA8Suy3uJ4vXQwYGLiNwpv/olGu?=
 =?us-ascii?Q?zjUdh5zGJFASAXTtLxPlV1iW/KK4j0FeU5d/w7Ovdghiy1slQNkVRNNg90F9?=
 =?us-ascii?Q?OZFdBhJYr0y75ihBEmXXodxt1hXabUHiAGrnI/PCLCsH8mX2/9IoUY4kB4Cr?=
 =?us-ascii?Q?JtCmsGklG+6g0JPL7SfJoEk6LXWYQRl06aIkHsYjOHOtI6xy4pwnFtFnlmSQ?=
 =?us-ascii?Q?ZHv65H4WeWpd304saGhqOdSPuTtGmxSOTu0EhMS7KwVqR09pTcYK/NYWpBcO?=
 =?us-ascii?Q?9S3qapqfUVOkDW/IDqWSkNp75iyGP43XY7FvwWGhoiw60byKD85Hsmu106CU?=
 =?us-ascii?Q?3w9/wjh5lno13YbKLEcWj9s+FP1kQHzSFoNOAJEG8+j91fPjpQN9hgC0D4Vf?=
 =?us-ascii?Q?TW1IlDpnI4bvi/Woq9HHxpeUw0thaJT7jlg+c1ogIJomqnwKtirUC0BVbOsA?=
 =?us-ascii?Q?A7K0whNaxTVaHgv2nd1xCgAaszHHBOxQo6H0ph7fDnsJu2jHR9X9DCpEIEjv?=
 =?us-ascii?Q?rCuQbDNV4qFjLY/VJ883fzuy7INXR8fTxSs5hmyiJvHmehg04AWLo222AmjK?=
 =?us-ascii?Q?jTNET5njSROZsI0QqFkqGkwod3fERIlvMomttQgys5h3LbSsUfhynGuQIpxv?=
 =?us-ascii?Q?tPKvb5cBWgR4DVVAXdmTFV6xm8mKm2ZpyOlk21HgADdgEWNnbselxIJvpE7h?=
 =?us-ascii?Q?qkBuV4hjkW1e7b1DKzMAreMBHN8DFGOpBOZ0swO0FbVWcHIrpfUjRXCTLREd?=
 =?us-ascii?Q?ZFqkGfhtR6HeHDjEpY6xIIbmR4A3khL3N5JfKO3HQhQBqUkwMaH3uznaoC1i?=
 =?us-ascii?Q?xXCop6v1VT8besBnFC/sJiLYP4WY+IZc6VDNc1vXmAHUdK+/5YdB5PgOAxbr?=
 =?us-ascii?Q?8MOE9DmEalg2uVoCoem8yLe0DaLbPvuZF/6Og/UkGjRqbg++6RuNY8OBa2vC?=
 =?us-ascii?Q?0AxbVhEwa58qtV2+hZM1nc6vAoNbFiUsUw3rNIZzqA77Pr7nQg3qPNykNWuC?=
 =?us-ascii?Q?3pJYcjYTnpZZDJ+LHZarYStxn4szxOlotlJ/d1mTKcjZj07KasCFwCQi6T2z?=
 =?us-ascii?Q?eogoz+AUIEOrfMPFQ6jRmfeSh2e4xGBsN8njP8Ehbkd6mcnHUI0mZsleTRr0?=
 =?us-ascii?Q?mVwdg7OER6n623I+M2ANG0uyHLYtN0CnmTr9dN/nCAPEgz5UDebmxMaRs6pz?=
 =?us-ascii?Q?THT8pTADSLttQDkv2ubcBZ57VNjaOCnGvHbNoeW+FK87+7GdY/zY/hBMcJwh?=
 =?us-ascii?Q?rlslldon2bVxPzRIqaIZ7yLiRO1GkixO5xsoOfoOkBmMIrrePPhsCutT9hv8?=
 =?us-ascii?Q?BizksFVp71gn8wcOYMOIJy68XbYPe1kNy5ap9JUggymCcSQQUTFAhyreHY18?=
 =?us-ascii?Q?U2i6F75nm04NHb2nGdhzz+bRsi/j7rOf?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab0062ed-a6c1-4b62-959e-08da02cbc552
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9186.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2022 19:25:43.9892
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3ikzgrxycx+L5fSOmI80bsEI/JUzC9AW2VmEDvmMz5zuMp+femHmb6NEjQZwHvY6l3DMEOJkVbsjLbmiVoMwfQ==
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

Add a "flags" field to the "struct dw_edma_chip" so that the controller
drivers can pass flags that are relevant to the platform.

DW_EDMA_CHIP_LOCAL - Used by the controller drivers accessing eDMA
locally. Local eDMA access doesn't require generating MSIs to the remote.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
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

 drivers/dma/dw-edma/dw-edma-v0-core.c | 9 ++++++---
 include/linux/dma/edma.h              | 5 +++++
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-v0-core.c b/drivers/dma/dw-edma/dw-edma-v0-core.c
index 35f2adac93e46..30686bfe1790c 100644
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
index c2039246fc08c..5816c8bdf9a64 100644
--- a/include/linux/dma/edma.h
+++ b/include/linux/dma/edma.h
@@ -33,12 +33,16 @@ enum dw_edma_map_format {
 	EDMA_MF_HDMA_COMPAT = 0x5
 };
 
+/* Probe EDMA engine locally and prevent generate MSI to host side*/
+#define DW_EDMA_CHIP_LOCAL	BIT(0)
+
 /**
  * struct dw_edma_chip - representation of DesignWare eDMA controller hardware
  * @dev:		 struct device of the eDMA controller
  * @id:			 instance ID
  * @nr_irqs:		 total dma irq number
  * @ops			 DMA channel to IRQ number mapping
+ * @flags		  - DW_EDMA_CHIP_LOCAL
  * @reg_base		 DMA register base address
  * @ll_wr_cnt		 DMA write link list number
  * @ll_rd_cnt		 DMA read link list number
@@ -53,6 +57,7 @@ struct dw_edma_chip {
 	int			id;
 	int			nr_irqs;
 	const struct dw_edma_core_ops   *ops;
+	u32			flags;
 
 	void __iomem		*reg_base;
 
-- 
2.24.0.rc1

