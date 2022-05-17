Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF06D52A602
	for <lists+dmaengine@lfdr.de>; Tue, 17 May 2022 17:20:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244240AbiEQPUW (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 17 May 2022 11:20:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349842AbiEQPUM (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 17 May 2022 11:20:12 -0400
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-eopbgr150053.outbound.protection.outlook.com [40.107.15.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62EE33BA5E;
        Tue, 17 May 2022 08:20:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Us8KpNZU7jDvJaSxPnc/Q2WBJs1hl7q9FWvOfIWqrOVga0+DI43LDQG11xzo2Kz4XPOIJ9owFDrNO8uLOtbxCHvfPJkqW+VDMI6A//I01ix37OCODx1m3IL6VTpgbkfoFGGHhOCIVdzfKNuXr1xkD6W0BYtwkyTChtHymJ5D5MgKQeMui9iiQI1oE6LYk1wxyIfli5fjnEW7fe4LXV3KMCzTFAYjPpflZQQLi1eZm9h0Fn2t6VuaIIW+ZRcd9wFiv5VIcP513TkaKBQYb0XWq8jkWmx3bRAW6UdAwVC/Io9j7uZamstBCv16hkqofRQjkE6QtH4KeAjWEcyCaOs/GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e+Pjllvd4Av2/LNvmId5YRdVr3zuYQIpd1M4RhkuB3w=;
 b=BaTJad6Jf1TS5esWPKGHDS5J2tXMq2tq4JDf+6lKnnPADvKFUDq5RYFg2ckyjZ06XRDZoruS+xq19m4EkdJjsxi2ZrowDTkZeG9y+ZPkDYtSMVGyH0v2twq/Ujw0yUlgHOD1nM1xf4tVtMEXTjIF1c1Q32E/XZcR63dwDBOrtiC49jBAXjcuwbEy+c9Tpta+Og9wazWhEWOidRehRZ3ilqvlpJ97wRRnBKfjMsMotXfG9bDe2+OdoTISSHC0UpMjxeUAbu6xwoVjomGXGCQ9jYtk74tEi6JAFluMFEUk40aBhYbm4TMI5LzCsC/kft0fY7WDiT3morb9NZDqzxBu3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e+Pjllvd4Av2/LNvmId5YRdVr3zuYQIpd1M4RhkuB3w=;
 b=ACJY3alG/X2/hpyD2SfqTOAgg/s9SQ+hjTv/uzuCVKWdOGbtnSh2oMNFsuB6CFP0GynTvFMAPGMpHCo5PWdTnL4ljsBUgIdm2/OMldPBX4GXA12Zb/T//lLmg02EYREGzaJBneK/eg7Ae34B8mEXYee/MOOuqsjyvfKcLbyGmKc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com (2603:10a6:102:232::18)
 by VI1PR0401MB2285.eurprd04.prod.outlook.com (2603:10a6:800:2a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.18; Tue, 17 May
 2022 15:20:08 +0000
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::adc5:45f8:fa40:1b8a]) by PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::adc5:45f8:fa40:1b8a%7]) with mapi id 15.20.5186.021; Tue, 17 May 2022
 15:20:08 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     gustavo.pimentel@synopsys.com, hongxing.zhu@nxp.com,
        l.stach@pengutronix.de, linux-imx@nxp.com,
        linux-pci@vger.kernel.org, dmaengine@vger.kernel.org,
        fancer.lancer@gmail.com, lznuaa@gmail.com, helgaas@kernel.org,
        kishon@ti.com
Cc:     vkoul@kernel.org, lorenzo.pieralisi@arm.com, robh@kernel.org,
        kw@linux.com, bhelgaas@google.com,
        manivannan.sadhasivam@linaro.org, Sergey.Semin@baikalelectronics.ru
Subject: [PATCH v11 7/8] dmaengine: dw-edma: Add support for chip specific flags
Date:   Tue, 17 May 2022 10:19:14 -0500
Message-Id: <20220517151915.2212838-8-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220517151915.2212838-1-Frank.Li@nxp.com>
References: <20220517151915.2212838-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0097.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::12) To PAXPR04MB9186.eurprd04.prod.outlook.com
 (2603:10a6:102:232::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6234ab41-f525-46c1-eb8f-08da3818ba8b
X-MS-TrafficTypeDiagnostic: VI1PR0401MB2285:EE_
X-Microsoft-Antispam-PRVS: <VI1PR0401MB22854D1E2287A366146BB5D288CE9@VI1PR0401MB2285.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jhAkG9wlFHU5n00ObP2tSCzts70+wh44D2yM4dubN8/gS15/PydBQW2LJF76F8BpcQosP7OWa5uB7h/fZZqt6/VbLUbNUeQuHTLH3buQasM/Dx38ZrieygWOC5enVUAgCwLBKDRxNib9Ziorw4nkwY/d1Ozr8v6OYctmpd1xavb79ezjCwzVVqv7Wqh7Hf3uw3rxaakXP9pmgFEOppbYbrblTLlhkRKZkwkXobBW83MW9QQMcsV30ubODUgYPRmHaa8cghBs8BXV2U9+28CkAvqcn42nKAYl/WUbEGGljg7/AvGJIdBFZmi1lqWKwGbgrqKNhBuXO2aQ1ZWHKN9jf2e4TUp1lRCpvG6Y1/VYLQEGGgon4XCh2iBpfZWxu80W9BZK+pOG18AJyKaPKK4FzmKFbS4tAw9EeZw2gtIkzjI4lIrS72mcjQlm6Z2+DBces1Dt+kaFgCSxsAhDXFRA1Hf394qpaSHZtiVKAoSpjOWKNk+p/RGCvqEInyzO+f++6s2RSVe/dVbQT8TWuy2gPfkorZOtfcSKPXJZi0D1grUheJ4YqNXKtgSP/ON2/ld5CxJUvz1ZU8BvikjEiRIENGyWvZfM9Sr10YokstVeRZPAAVkmA9fgGGk7xqvz/mlDUqmGXX9N9gqmNSUNSt8v1s9rKdBIjlYkCKIvRzvv9wQ0GWOBQBanhk9VfUoeFdVzEwcKJelB07SgO8rpmFGFdHYXeZ5g4Nk2BtyEheeUwG0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9186.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66946007)(6666004)(52116002)(8676002)(6506007)(66556008)(86362001)(36756003)(6486002)(316002)(508600001)(38350700002)(38100700002)(2616005)(1076003)(186003)(921005)(83380400001)(8936002)(2906002)(6512007)(66476007)(26005)(5660300002)(4326008)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EiAeby1ep6mP6QcOEgHrFGY+9dn3S++xNp4ZKn5Qy0kYk1CfJCbA+fA4c9PC?=
 =?us-ascii?Q?JgPurY0qEg55xitFOUZKL0R/B8apqBPRsGsufpGkIKUs7XL8o9++xAZCOHFe?=
 =?us-ascii?Q?jELSzTbLwyPWNQpOI/WWDVbVELLngItVg40Onjb8Fq+T+iMvWbPnGbc1e92X?=
 =?us-ascii?Q?QyOhgaYl5B8/EWyZzn6bpom+8jRmpkxCnMkb6gQ5FUrP/BGX5poYBN5BGgvR?=
 =?us-ascii?Q?DC8HRm2dgDAHAjPhJkVMEExqSWT8yJqfAJ9cyBbku9i8uYhxh8suCITWToOK?=
 =?us-ascii?Q?Wm+ect3r4taxLq4ymCDqqIibyoRqZ6HePLqPZIkzoDNQHsh4wIT/LpWSo1a4?=
 =?us-ascii?Q?AZiR+a3TbRBx1VMW1eM5IxqPcK8fL6GxHYIZfCMeWHdD4eqEgTtHOv63zjnb?=
 =?us-ascii?Q?vhCcu34v0Jfr5AzvAI+ij9nMYwcv+N/HiQHNuXOWTSL45+eZUmMRtpcmROja?=
 =?us-ascii?Q?klNac2yBbAj8mFT22ZaK+0odXwNY62n8smkZInbhf0lzssH0nbQ+s4tBbRUD?=
 =?us-ascii?Q?/DSt0WakHrhtU6+MJTv/JzMFxd0S62LhWvR/72Y+vlSYjh4ZyGrsdw/9PZhk?=
 =?us-ascii?Q?fg1r45mQsi+3/bLvWRkq8YORKWB2MYHCBcg7o72gh7oPRMhMLQ3eXSzA+0T4?=
 =?us-ascii?Q?00WObV+nNgy0Jq5LqeywcL1pQHXn7Ofl5opCMJCXt1+r4+nyfEio5WlG4Xfz?=
 =?us-ascii?Q?TQPpkZw8a5T4/maY04jlg6KxOHE0YVY3h5kXlycG0xGVv4miDOAMaVD5PE3M?=
 =?us-ascii?Q?A1oth2BQmTL2CLnyPf5IrJrbh9sF9wUNHQ1n6gFl/1f7Ke5tRuZCtL93ph3c?=
 =?us-ascii?Q?SEvoi/lNL5g81Ngi5LvsfJQA1cxtMxy5zhVwVITdZIGi/ykcyShUtc1F/2+A?=
 =?us-ascii?Q?0YPqKAZ2QgiIj212/p/ymxNc12S5w61v4TfYUEBHiaUQkIbSXDcuOAguuzs4?=
 =?us-ascii?Q?xMebMeqEzxhFylwu53EoUrjKdKnEnwNyJt+1XdrN6fvDjT9QrLEAzYEL6MVx?=
 =?us-ascii?Q?HowXUhPY+BppjXYQ4YkMYvsS45TGlCT1VPWtR6cNm6VraP7oM/qxMf9rqGRl?=
 =?us-ascii?Q?U3CegIAHFixt0DC7KLt+6YygH7qSQzkanHd1EMZzrNCr7CQZByMGOLtX7FS6?=
 =?us-ascii?Q?hvxoaxBjMyTa2pnfXKddt2E7um1qoeb49DnYiSBIcUAmdHWu/PWDx0tSkljo?=
 =?us-ascii?Q?+XTxepYFY5CelUWSZuqDIlfeJK/1NkJNmfS7DTWwuUKXcQQ7JhYt3Qsq67ef?=
 =?us-ascii?Q?Bmws2m96falU5t8BpJAX60MbKSgMnmXhRM+u715/Zq4jfPrQ+Ttu0A+dYsBM?=
 =?us-ascii?Q?uxqBb93zSlfk55a/40527XST/0nbpaPBu1cJW7zIC9OAR45GMFfEqgxurglX?=
 =?us-ascii?Q?nQCFyEugCNGqz9tcMZt5a9wHQsYneFNGhiNlxmLoKQAMzmMzVxpCBG3JKwP5?=
 =?us-ascii?Q?QXJ++ymhNA+8C9C93t5ZnA4NmpoSuhISJhb3ciIZevx64Ba2b8gL6/jcBAXq?=
 =?us-ascii?Q?Yxb1AEnivPdKTO34HXdNhRsZZFzJ7CE3d8umDV//fLZpbp5FtYVobx4129jC?=
 =?us-ascii?Q?sTxfrmc+kj+SyK1JSCnumF4hOM0VkL9EWM689jg8cav2CONd8l0XjYq4S4M6?=
 =?us-ascii?Q?0ziPT0urKV6UPJe6MfizHIWcCoieOFpNkOuUVVhynzKSknpJSY2TapjDbex5?=
 =?us-ascii?Q?3wYtRPNXUHUsd1ZaieGnlTP6iIRBw8u3pbRl75yc83Amy7AI71mF/ODJkuJq?=
 =?us-ascii?Q?NzIU2Cf6Bg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6234ab41-f525-46c1-eb8f-08da3818ba8b
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9186.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2022 15:20:08.7855
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Kt0usyzaEaksIuDRk4TSyuT50R+i26A1XFEEg7kctuGQH6viihn6nfAikczdqHC2fDdf3dkM6MIGvzMtKQqJ1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0401MB2285
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
Reviewed-by: Serge Semin <fancer.lancer@gmail.com>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Tested-by: Serge Semin <fancer.lancer@gmail.com>
Tested-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
Change from v7 to v11
 -none
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
index 403ade40c1b1b..607647dacc291 100644
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
index c8b479f1d4da7..7baf16fd4f233 100644
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
+ * @flags		 dw_edma_chip_flags
  * @reg_base		 DMA register base address
  * @ll_wr_cnt		 DMA write link list count
  * @ll_rd_cnt		 DMA read link list count
@@ -55,6 +64,7 @@ struct dw_edma_chip {
 	int			id;
 	int			nr_irqs;
 	const struct dw_edma_core_ops   *ops;
+	u32			flags;
 
 	void __iomem		*reg_base;
 
-- 
2.35.1

