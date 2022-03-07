Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A2754D0B69
	for <lists+dmaengine@lfdr.de>; Mon,  7 Mar 2022 23:48:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343876AbiCGWtZ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 7 Mar 2022 17:49:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343878AbiCGWtY (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 7 Mar 2022 17:49:24 -0500
Received: from EUR03-AM5-obe.outbound.protection.outlook.com (mail-eopbgr30074.outbound.protection.outlook.com [40.107.3.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C55DA12758;
        Mon,  7 Mar 2022 14:48:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f42hTJt6/TF+/37pv1TPUn8rSw2r1vukp4B1a6lKaW+Y+iyMJYTUqvwtRyvoX68MVhuCkHgm+gaYXFsW4+eJKTJ5UfIqgTKbUE+gaKBrTIxS0ZQ8uIask/p3rthTcgHDpPZv2Kr0OAcwaDopwafFmwTCJigUhTo/FfZvbo1PCGHeEpu9vh9N0snf8gXQfO3XS5ADUuKSaJjqkXxhv7CRcuhc3EUj0mqZJK7Ggd1CqLsX/01VHdxvI8o6VYYNsgpiV8FPzuqkbxSmNmyVat0cvkBjN/cWnKGohwDUosWSbemIsYcj1gURXfSMjKjycfGosb4+HvrpQ2nST7ALDAONJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TcaCCHVkKGxXZb2OKOc55fVGaX/JIbPTLoSBI7vJyOU=;
 b=M442/W5CMGAIyaQ5ft5cqFu0QaTouQtf7YgUIuEKef9wBBEBXaLK0MZZsZzjCwYRsXqCA85qV6sc9IQoma7RUmabMimkq+3SmT0d+cmzDgaUwDkHaLCKjeLJYIScflSnlVpWJtWfG+QVu5MjB2VZfrDY9fGR04dp2cF2vAuNOHReICiuWwNPT9aXh6DPOeEHDrAAOfpk0M+ubQziI4JPOStAST78He5Hmw6bfHlFD2gUMqhyQ/Cb8p2oVSfwFf1rudezH/1egxkj1LCoATd5ioPDUgyXIEOjBc5NYuYVn99a09RfraD8Rho+GKqIuJUFcS1tukrCDZdMgoZhh6kwvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TcaCCHVkKGxXZb2OKOc55fVGaX/JIbPTLoSBI7vJyOU=;
 b=cLiW45Cf17ug1NLnld1cvcNUZPeoDOFIEriTJLl1G7qwbpygIK0XFEzOIVvwXmn8xMc6UFLI2WqqVJ0TbixAu2JXM3L0adIVhYGzU1b0XdzGySD60mMKaPTVKRI78f+MvI0laxR8poSpgIvXen4k2lvshhmhx08J6X4iBQOvboo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com (2603:10a6:102:232::18)
 by AM0PR04MB4946.eurprd04.prod.outlook.com (2603:10a6:208:c0::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.17; Mon, 7 Mar
 2022 22:48:26 +0000
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::c897:1bdf:e643:aef8]) by PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::c897:1bdf:e643:aef8%7]) with mapi id 15.20.5038.027; Mon, 7 Mar 2022
 22:48:26 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     gustavo.pimentel@synopsys.com, hongxing.zhu@nxp.com,
        l.stach@pengutronix.de, linux-imx@nxp.com,
        linux-pci@vger.kernel.org, dmaengine@vger.kernel.org,
        lznuaa@gmail.com
Cc:     vkoul@kernel.org, lorenzo.pieralisi@arm.com, robh@kernel.org,
        kw@linux.com, bhelgaas@google.com, shawnguo@kernel.org,
        manivannan.sadhasivam@linaro.org
Subject: [PATCH v3 5/6] dmaengine: dw-edma: add flags at struct dw_edma_chip
Date:   Mon,  7 Mar 2022 16:47:49 -0600
Message-Id: <20220307224750.18055-5-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.24.0.rc1
In-Reply-To: <20220307224750.18055-1-Frank.Li@nxp.com>
References: <20220307224750.18055-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0019.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::24) To PAXPR04MB9186.eurprd04.prod.outlook.com
 (2603:10a6:102:232::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 78e7548c-2fe6-4dd6-1327-08da008c9758
X-MS-TrafficTypeDiagnostic: AM0PR04MB4946:EE_
X-Microsoft-Antispam-PRVS: <AM0PR04MB49460B6BB46C1585F1CC274888089@AM0PR04MB4946.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PMuEpAFXdihQF5F7uj71qaVTDagHFsmfQy9bQqBA2DuGsf5OYSmXe4ccVRa9HXGuLWsq2+3Slr1aZoI4o2bsRbYMIj9YuBEfGM+5HUe93cvY44Px5mJzZuAJi6U1fuXX4sWr67Lds6tETgkXQ6GN7DkgVmjvKZ+58KEeg7+37Msn3Cu/3jrvPf8fAOnP8SeIfvzhXpu1pkP/yZaKYtnidRdP1HKcbQexRo/BU2cnoaj/Q6+EZy25mHw63Fv8g/bL9z1bCcZYqOiV04d1sptg0DJCxKT/iAklYdSxyzQhp5wJ7rYmUa4C3EXIjr8A4hfglptTPeZ9pIFnO/ww6wKMmNyAF7XjkS2VpJE3CwinD7LLbiIxY6ATLJdN68K7km1MSsyVxqDYdl83WcrAqwW16rXFvh8gTEnAeUV+oJEbMLQYv/3vKPuQuXszghkqfDVh6FFwklFORr7BYEBVxo7VaUCzPhr+nHNASX2C+fg40I7YjHRHQLHxfJby6v3y0cGVSlpqUQRBL2fjS+JmrNM2OtIJ/IqEtwuUot/R8SrkQcHJt8t5iOo4MkMPSDFOh9CGpjuJ/6w0dMk9/W7adkPUL5Lj0OvpBp6+mgR7GClDnfw8zjo9HmJlfM58TGgtEO1br0nX8j+kvh+wZnTJHy2VUINN5zLUH9/fVoF0L8vhfBi6/Q8B6cDlEsWFtwClqWXi+XrsEsyAH7SzACQo+Fouvw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9186.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(2906002)(5660300002)(86362001)(8676002)(508600001)(7416002)(66476007)(66946007)(66556008)(4326008)(6512007)(8936002)(6486002)(6666004)(6506007)(52116002)(83380400001)(38350700002)(1076003)(186003)(26005)(36756003)(316002)(2616005)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TqSXmEyKqBm/nubOKxL/AePrw4RKufagtMS31Wsnp+M/9A/SC4qJi1czErt3?=
 =?us-ascii?Q?5o9PMCsIimjSBQxx78c9IA2DCOonftoFjI5p6rbDuy1Hhu671SZVrB1g6ol3?=
 =?us-ascii?Q?xNCW+QJtZ+4D48e/mHjubWCJlRqx3oV7287DE4NIvltW/RNNQ2NdQ+ta9mQE?=
 =?us-ascii?Q?aNX8LiIbpK6aLS9EqQ5QyE9TjcFQYLESxVosdMHiNRKG+ZB1ICQkUvqfeqv7?=
 =?us-ascii?Q?I3vSlrrKsZPijKiTXwCvdAQnRfUK2kYmF4388bQRpdlDTm7iyvlSkees1mF0?=
 =?us-ascii?Q?Brow368s1bFcC/W/HmWgxr+toIPlqBxsD1Zfsao031ToCmSjV4e65cOWb3SC?=
 =?us-ascii?Q?2xFvh3x0FAQDEG3NEBXddkEqclcgbm02lcsleHYm5XcKnYtfOZDZpkeWeTsT?=
 =?us-ascii?Q?l4KmkCiI0Boh8GKj03SvbFRP8Oz8rf5jG+xmZvyJ42TXZZ6wjWloF4gZyjyS?=
 =?us-ascii?Q?Q/hg39OSMZ0oEzGh8kgS7FjCXWu5/EjrPqrs4iccW9JXxf7ICKYu6nUYOjyF?=
 =?us-ascii?Q?/hB/26nFjEvhrBWBgN7lmx+gaEJBOwZheRGBR3V5gEW/z/FbxSlYn+0ncgoA?=
 =?us-ascii?Q?vLilz5uDciAPKjTFNgahcNVgoSX7KfpH3wuzgpAdYo86TXRJ8vrZZzcKIUJt?=
 =?us-ascii?Q?VN5KBy9ckZ+ADKCt1lGDrwZbuNr9WRziqf5+7EhKyKBC4dGM89sCdxSFPj1V?=
 =?us-ascii?Q?zGskKMinkUeW1U2UPVmet2hsE0cGFXKQTXTNfcvpKzuUH2fh7GjJeFscIxZM?=
 =?us-ascii?Q?teD3aL4620M6xST8A+AdU/oCKGuCUUSMA37P9+TAXj0tOXK4asQBLKTxqCkC?=
 =?us-ascii?Q?lSCdS8xTJrsDisN6MHdnj1BmEDESatq/WqeB1REMkIdsQd5B+dKrl5TLVw8B?=
 =?us-ascii?Q?TXlaM1GUpzVhJ1J61oH98q2wjh+E5SacNj2fLpKuUztc8EtNnHZnLj8U9Wsg?=
 =?us-ascii?Q?Pnt8yLLLXS47HKxrkb4tITW45kfBgXnTV7MHUhg4NeVWy7Pb6rW+UHzs6Yjw?=
 =?us-ascii?Q?Qf5auu/Lc47ebXUzgF/JFD1G8unyK9Nl4TjKymgHe6C6anHv1a/nPvGM76nh?=
 =?us-ascii?Q?DXhcFKbyQDHNsgnXj/X1oPmQHsLnhbyrQGdm1YndV+5rs7dB/5XOLd20nFC5?=
 =?us-ascii?Q?G/DC6iVJwI0NqbBThaBZN9UQrn2NaczPmbFhIX/rVpuLZaslM2lDyq4HuJkH?=
 =?us-ascii?Q?F+mFn9QNEyJsqMhYP66N1sH2rEBCHWLMVYsBCfFalHr4vmdOHh0P6xVwgBYH?=
 =?us-ascii?Q?VQqh2YACPdtKbW44WI7INEQ66E8TCXAU3zi9a2Chkxt5nj61lFUUN3Hlx0O5?=
 =?us-ascii?Q?Aktq5u34vitTt8q2PREZVhdq9RCLyXm6JSQHTDd66uwRKE/jQTg1KpTddTLf?=
 =?us-ascii?Q?KvgYw+UhF5vHIj4aMV0qVTbN7T4akrDK/P96pE71ZZtSCARmRAk/OorX30ZY?=
 =?us-ascii?Q?oumAVux0RzNKSMkKoH3uvPvpdac1P7vHA0mPS90EKQooWPH9TDCDnbeFcx8P?=
 =?us-ascii?Q?U4p5yq86coUxDRl9915zRg4a8SJ/K6g+lao4PI+FcTKQjLDwQMzy8pUa4cDV?=
 =?us-ascii?Q?c/GDdU0OMewjkK/pfcqNyV9bd7vvH0rNR0jfuB4MD8L+nybEEtHpw4XDOQmu?=
 =?us-ascii?Q?5fAwmD63ZGBswL+kjUhnefE=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78e7548c-2fe6-4dd6-1327-08da008c9758
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9186.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2022 22:48:26.2461
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: orOPDlt04iX/N0ZKKbB3TE1tlrgxPsPwaWhOnVRGcyvzVf4iDyhmMRXn/Wf8vjfVJO50+MaA3ayVqIiOEjmWHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4946
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Allow PCI EP probe DMA locally and prevent use of remote MSI
to remote PCI host.

Add option to force 32bit DBI register access even on
64-bit systems. i.MX8 hardware only allowed 32bit register
access.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---

Resend added dmaengine@vger.kernel.org

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

 drivers/dma/dw-edma/dw-edma-v0-core.c | 20 ++++++++++++--------
 include/linux/dma/edma.h              |  9 +++++++++
 2 files changed, 21 insertions(+), 8 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-v0-core.c b/drivers/dma/dw-edma/dw-edma-v0-core.c
index 6e2f83e31a03a..081cd7997348d 100644
--- a/drivers/dma/dw-edma/dw-edma-v0-core.c
+++ b/drivers/dma/dw-edma/dw-edma-v0-core.c
@@ -307,6 +307,7 @@ u32 dw_edma_v0_core_status_abort_int(struct dw_edma_chip *chip, enum dw_edma_dir
 static void dw_edma_v0_core_write_chunk(struct dw_edma_chunk *chunk)
 {
 	struct dw_edma_burst *child;
+	struct dw_edma_chan *chan = chunk->chan;
 	struct dw_edma_v0_lli __iomem *lli;
 	struct dw_edma_v0_llp __iomem *llp;
 	u32 control = 0, i = 0;
@@ -320,9 +321,11 @@ static void dw_edma_v0_core_write_chunk(struct dw_edma_chunk *chunk)
 	j = chunk->bursts_alloc;
 	list_for_each_entry(child, &chunk->burst->list, list) {
 		j--;
-		if (!j)
-			control |= (DW_EDMA_V0_LIE | DW_EDMA_V0_RIE);
-
+		if (!j) {
+			control |= DW_EDMA_V0_LIE;
+			if (!(chan->chip->flags & DW_EDMA_CHIP_LOCAL))
+				control |= DW_EDMA_V0_RIE;
+		}
 		/* Channel control */
 		SET_LL_32(&lli[i].control, control);
 		/* Transfer size */
@@ -420,15 +423,16 @@ void dw_edma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
 		SET_CH_32(chip, chan->dir, chan->id, ch_control1,
 			  (DW_EDMA_V0_CCS | DW_EDMA_V0_LLE));
 		/* Linked list */
-		#ifdef CONFIG_64BIT
-			SET_CH_64(chip, chan->dir, chan->id, llp.reg,
-				  chunk->ll_region.paddr);
-		#else /* CONFIG_64BIT */
+		if ((chan->chip->flags & DW_EDMA_CHIP_32BIT_DBI) ||
+		    !IS_ENABLED(CONFIG_64BIT)) {
 			SET_CH_32(chip, chan->dir, chan->id, llp.lsb,
 				  lower_32_bits(chunk->ll_region.paddr));
 			SET_CH_32(chip, chan->dir, chan->id, llp.msb,
 				  upper_32_bits(chunk->ll_region.paddr));
-		#endif /* CONFIG_64BIT */
+		} else {
+			SET_CH_64(chip, chan->dir, chan->id, llp.reg,
+				  chunk->ll_region.paddr);
+		}
 	}
 	/* Doorbell */
 	SET_RW_32(chip, chan->dir, doorbell,
diff --git a/include/linux/dma/edma.h b/include/linux/dma/edma.h
index fcfbc0f47f83d..4321f6378ef66 100644
--- a/include/linux/dma/edma.h
+++ b/include/linux/dma/edma.h
@@ -33,6 +33,12 @@ enum dw_edma_map_format {
 	EDMA_MF_HDMA_COMPAT = 0x5
 };
 
+/* Probe EDMA engine locally and prevent generate MSI to host side*/
+#define DW_EDMA_CHIP_LOCAL	BIT(0)
+
+/* Only support 32bit DBI register access */
+#define DW_EDMA_CHIP_32BIT_DBI	BIT(1)
+
 /**
  * struct dw_edma_chip - representation of DesignWare eDMA controller hardware
  * @dev:		 struct device of the eDMA controller
@@ -40,6 +46,8 @@ enum dw_edma_map_format {
  * @nr_irqs:		 total dma irq number
  * reg64bit		 if support 64bit write to register
  * @ops			 DMA channel to IRQ number mapping
+ * @flags		 - DW_EDMA_CHIP_LOCAL
+ *			 - DW_EDMA_CHIP_32BIT_DBI
  * @wr_ch_cnt		 DMA write channel number
  * @rd_ch_cnt		 DMA read channel number
  * @rg_region		 DMA register region
@@ -53,6 +61,7 @@ struct dw_edma_chip {
 	int			id;
 	int			nr_irqs;
 	const struct dw_edma_core_ops   *ops;
+	u32			flags;
 
 	void __iomem		*reg_base;
 
-- 
2.24.0.rc1

