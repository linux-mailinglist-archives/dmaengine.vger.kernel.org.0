Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AACB4D3BDB
	for <lists+dmaengine@lfdr.de>; Wed,  9 Mar 2022 22:13:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236652AbiCIVOE (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 9 Mar 2022 16:14:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238395AbiCIVOA (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 9 Mar 2022 16:14:00 -0500
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2072.outbound.protection.outlook.com [40.107.22.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D32EFFF9;
        Wed,  9 Mar 2022 13:12:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XQEQfNUJOzzc3gz1IHHz+Vkj2sjn59CS1ykWDRJvLgaRw+63yd4xNy3s+wZdQ7sHUBmlrv8wbmcjrEY06gKC0FOTBJDgZThOKmRt+Upobdep4gwe38vXID/BwGRoEYTY7dE28jXvYTmbtXjp665tAQd3cEZw8ELF645QTngq8/chyykGfjcT57cutvYjHv5UaUAgMiTTYOeZ/NjLfLxBVtJHfaWhTyxQHIPZLQYx8v9DWNxxSi6QkSkuokQOkafWEjedLzKdcpNrPKldsf3/i6QHFf0mVLi9ZlMKaDYjEUCnlteTvMaHsUeBiIHoMlWFkUH8ftI8+P3719kQzoX4zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dEuLhUL2Hq/d4MR+mMw+BsgEktHL//nW4HirvMWbDLc=;
 b=lyDg28qjZaUs+5O3zU7jqiYN3rasT+dPpm2ak9IL8K7xduDAUAlqxVlXOXiwbvv76ziCO5x/w/mhLOOVVPd9wioGa6olKUCgYuF2npwYF/OoD0MTcd9GopRV501igf5rmMANzDnv2Mua1pi94D887171lxdhoSRgZ46XjCki+0pN4Q3xshwqvTYdK5nks1y7k9rcIyatrt2L4R5xiwxCxgCYZUIZjXhTluP9En+pi27cMi7G5h6kDp6D7+GmPH50y25FAZyTPLwvbMkSxOW8GVXnK6i2b0UyBtOZ+yNlpfN7do44uirdzqrEoYXcusRrWQ9ryHeePr1Mnva0vnigAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dEuLhUL2Hq/d4MR+mMw+BsgEktHL//nW4HirvMWbDLc=;
 b=IM5JFD8jb61Kd71TwBTHaDnjgrY+2LDGhXq40hErL2cFlb/rgM4Nh5aVkdQjTATUZNBHlWuF3asFmiMyoDSNq8+Ft6I0TtXKbdFu/IdPe4gTSzvPgrmFjGQ1xGW1blUkziFrudaJuf+azJCPaHtZL5g7QQ5Y3NOlvATr1qMBwkk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com (2603:10a6:102:232::18)
 by AS8PR04MB8358.eurprd04.prod.outlook.com (2603:10a6:20b:3fa::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Wed, 9 Mar
 2022 21:12:57 +0000
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::c897:1bdf:e643:aef8]) by PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::c897:1bdf:e643:aef8%7]) with mapi id 15.20.5038.027; Wed, 9 Mar 2022
 21:12:57 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     gustavo.pimentel@synopsys.com, hongxing.zhu@nxp.com,
        l.stach@pengutronix.de, linux-imx@nxp.com,
        linux-pci@vger.kernel.org, dmaengine@vger.kernel.org,
        fancer.lancer@gmail.com, lznuaa@gmail.com
Cc:     vkoul@kernel.org, lorenzo.pieralisi@arm.com, robh@kernel.org,
        kw@linux.com, bhelgaas@google.com, shawnguo@kernel.org,
        manivannan.sadhasivam@linaro.org
Subject: [PATCH v4 7/8] dmaengine: dw-edma: add flags at struct dw_edma_chip
Date:   Wed,  9 Mar 2022 15:12:03 -0600
Message-Id: <20220309211204.26050-8-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.24.0.rc1
In-Reply-To: <20220309211204.26050-1-Frank.Li@nxp.com>
References: <20220309211204.26050-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0170.namprd05.prod.outlook.com
 (2603:10b6:a03:339::25) To PAXPR04MB9186.eurprd04.prod.outlook.com
 (2603:10a6:102:232::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b7b40e59-9895-429e-638d-08da0211957a
X-MS-TrafficTypeDiagnostic: AS8PR04MB8358:EE_
X-Microsoft-Antispam-PRVS: <AS8PR04MB8358CBF68817AA1D91E61D7E880A9@AS8PR04MB8358.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: S2xrXvzvbmnT0NLtqqDHWGGU3MaYckF5e61X/YJXteC3bVbb8h+OBUbgb7KK8FgYuZYRQyXntkztc6Krwz9krrEaxh6et5xKg5CQ3a0l9VchqtFK3xJ4pSlZ3/dzRbIXyEVkTSZvIVkcDmWHbQ4iy8HLXD2xn3ajaoy3q3ngDuWRtPlLBPTanlla87NhW89pd1Tb0ZbVEa43vhk0L0LeWzx6RaRQatkuzPjU97u5ZvGkBEnayaPGOk8XNO8r/NRpfP+pmHrOZw1Z0gpRQA6OTOpCsLUS0lx7kowf1T5uLtHQfvesruTl/TKBnf7UkbSprICizwYZm4Es12Dfye7dR6tfkRyENqFAB7QKhM6HJQTGTDIDaf0QLuvOJ6yBZO9YgRENJgOwAMD/u0mGt8fZLJz6F+8YPC+Mrclew4aIOdbspa0/SkICvl4PL63+rDIZgX1afSlCb7bH7BmMTOV+py2ZyKxr1jkPQ28qizCyRhkrJUQrjKCTLHQVZZFlXKzNUE4pf+NJ1qbJPk7VVUD6a8jxUZk53DiN7x/UEWRNERVJsJ1Kkgz2sRT7geZ3RBaCzOxTCCpyrA/+PVFG8Ie2CRCpsUnMksKyncDIyjBB0t3GYucXn5MQtLtLtBoq4W67PgywUfnou92VLlm5OqmpR71VBJ+mfrlWXlDWyVYQhhjkbCs4kDaCB313BFU6d8scZp91R/cIt0y1HXQDVz3teg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9186.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(26005)(186003)(508600001)(2616005)(1076003)(316002)(83380400001)(6512007)(66946007)(86362001)(66556008)(52116002)(66476007)(8676002)(6506007)(4326008)(36756003)(2906002)(38350700002)(38100700002)(6486002)(5660300002)(6666004)(8936002)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?f4vdm15bUlk8sorsmtPHTOExBIRyQInAc9B1m6KGD+Gjgw3Hxy+X36TiiWaK?=
 =?us-ascii?Q?bt6hQJlSM3oUPwfHKXRhxRo550cOf65AQQhncofwtyAH2J07DDK1NAnQLItT?=
 =?us-ascii?Q?qI76sMR4YtqmcnvYnWfvvs5jfzH6NloXSGqcNoyZV22weMxZJF7n1dkRziA8?=
 =?us-ascii?Q?IdJYoajQ1ub+cu1wrbiiwYxVpfX9XTtcLQpn1f+wpplZ1iFt/7Vpyrw4z2Nx?=
 =?us-ascii?Q?ctfO9UyTqw5TAZF1kgVzTB6T/6h3M0z7Yp2iMuRLHmNjZJSatwIy7JPT8ZbE?=
 =?us-ascii?Q?MWuTrycHr8XU/iJPZ7CDvm+A1GSRLUmgFvgqLrVzAUs6+5SMeZvobjdHMplC?=
 =?us-ascii?Q?pLs5ZSSsH10Gp60PGGtbp/JycysgaBXgw2id9hiOR68Jq/zzfUcbL55sSJhu?=
 =?us-ascii?Q?T8RMOoe9duwDX9czexXr5M0/1S+eSpOJmXo/07lo4h7oHvs3ddhekPvN755T?=
 =?us-ascii?Q?j6KXhCjDCKHpoXcfelJaNwrOhMN2WIY7BVUijG1nRdJ/9C9BeBEkOKfgy+j+?=
 =?us-ascii?Q?g6Cx9FgP+aghW/k0irLH4IldBzyV9YDhektRrdp4iZStl2MB1CAxEo8nHwgW?=
 =?us-ascii?Q?yJLLzRtMPYIqOtZV/gghJ+Yr3LEGJ+zG8AzvCMPiJFA/G7iUsxBdTwBNg9T6?=
 =?us-ascii?Q?oik6RdYspILkTLg1MnCa4qiKOioppD1dXb8/ql2YSa+NIk4ab259evl/JPEC?=
 =?us-ascii?Q?rlG3xLHKMZg/kt2zzKKTP2iFUSjXilUf8MSB7W2F5zCleHKyc1oS2aP2i4WR?=
 =?us-ascii?Q?D4FihBJJHxsyA2gy3BTHp02koz6wp79SS/nn+w3nd5mugO2LdhsztjRZ8vOt?=
 =?us-ascii?Q?faAaqnYEvuuohc+jhSiTNeiARQDEFrkTWqahBzNuc+UX9xSGfSiMgOogSLIQ?=
 =?us-ascii?Q?l+E7OGi2gb7q/4/AVlib5h6nwH+etmppv5ITXzOBCY+Qy3arJWSweshUJOKo?=
 =?us-ascii?Q?w/XkSDJcry/lAlW0+GGv4KyzYIFRyI1C1b3GoKGaQNo1KlY7XRIyuasfwHPq?=
 =?us-ascii?Q?+igWRzBt90W/gKCYHtJrnWGOsjPsGugIwJQ9xTokT4FFkDFeNQ/vnrzMbwOx?=
 =?us-ascii?Q?aSsV0P9VrgGTIynYv7Q6C+WBjTBFtU31ySFvlckoyd+xLbomFdkn/OSIbpPP?=
 =?us-ascii?Q?rotsEULg9sOInijL7p1CxTczIcdDjbfZ1fzVJZdrHwCNvkumDUZlkuOtLxM4?=
 =?us-ascii?Q?Sw609h0Ch1tdIDCVpPlpw1Y3+QothOalvThBIxDDLR7f6JlfSN4evjm4Ph1T?=
 =?us-ascii?Q?nURdPMKPJ9x6Rg4MlcjAmNBNLUzMmzEH8VhOhdeaQ8xL6efsim5/AHLpPwPX?=
 =?us-ascii?Q?mTCqgI+hk87hhjI54GJPIgiaNoLx8H2L9r4C5/LwYT2EifaGUpah78L9BfeB?=
 =?us-ascii?Q?sRZGmx+v05IgHLhhXcxADoUdixHVn+eJnrJXfpCYtpdCNTZkekf0reZd4NfT?=
 =?us-ascii?Q?pxYEruTHctOUeeTspmZsT3WT1yw7rWmy4rixQK/ksXJ15MBjfZR2Uz6HRDsn?=
 =?us-ascii?Q?O5EGWykeIzieDm/wo6HQA+ZbUurJvlNtrAeaJpveP6CjJjHjMVpzyJX43Ela?=
 =?us-ascii?Q?TiNdi5dl+tdkfsPa13eALV5Yh+eHo+ArDiCgT4qKDxK/vobeN5X9dtMaxZs1?=
 =?us-ascii?Q?mPFijO0tqnuZ2FsbbyFzzS4=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7b40e59-9895-429e-638d-08da0211957a
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9186.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2022 21:12:57.8290
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2YJZOIuZHN8XtW+rnn3nGRvVlcc/ex7pizadPKCGMV4OXst8ghmouIoe4QriSdzVdq9Q6UyVoSuBix/P3yfQxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8358
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
Change from v3 to v4
 - None
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
index 35f2adac93e46..00a00d68d44e7 100644
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
@@ -414,15 +417,16 @@ void dw_edma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
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
+			SET_CH_64(dw, chan->dir, chan->id, llp.reg,
+				  chunk->ll_region.paddr);
+		}
 	}
 	/* Doorbell */
 	SET_RW_32(dw, chan->dir, doorbell,
diff --git a/include/linux/dma/edma.h b/include/linux/dma/edma.h
index c2039246fc08c..eea11b1d9e688 100644
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
  * @ops			 DMA channel to IRQ number mapping
  * @reg_base		 DMA register base address
+ * @flags		   - DW_EDMA_CHIP_LOCAL
+ *			   - DW_EDMA_CHIP_32BIT_DBI
  * @ll_wr_cnt		 DMA write link list number
  * @ll_rd_cnt		 DMA read link list number
  * @rg_region		 DMA register region
@@ -53,6 +61,7 @@ struct dw_edma_chip {
 	int			id;
 	int			nr_irqs;
 	const struct dw_edma_core_ops   *ops;
+	u32			flags;
 
 	void __iomem		*reg_base;
 
-- 
2.24.0.rc1

