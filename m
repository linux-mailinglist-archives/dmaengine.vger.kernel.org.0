Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 514CA4F675E
	for <lists+dmaengine@lfdr.de>; Wed,  6 Apr 2022 19:39:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238786AbiDFR0K (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 6 Apr 2022 13:26:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238669AbiDFRZs (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 6 Apr 2022 13:25:48 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2040.outbound.protection.outlook.com [40.107.20.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9B3C3B7460;
        Wed,  6 Apr 2022 08:24:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KUyjOZTnzI+TMMew+KA/0EyFdnbP0dSp+Bo/3tNjKqRQppcQM1UfS1oGTKaBvrR+519ozdhvqUGVMe4GSBMp0saGUSHmsfBMt3BHUPvauOwwFJmB8SBbmA1Stg0aFvcKegA60OxhhbEtIl5j4tY8puIjF8dofw2xcCQn9vpV1rVUGsQiT798Sc0bvdkmj5X1O8BN5KYBKKXxjqZVCHv29CYge5/hyk7/x1QyLJk42bnjFF+t7w96oaRHnzt4yMHgom+H07oGGhBcg8d7N8OTgP1xG6RlS85mKwAgczblzN09ldiy0n72e+YSBS+hP5tR49gTmMcGuZF+aACUctfGGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xczDOrlcjB12yihCHeMDFTh2nwF//4VIGQk4i0BewOM=;
 b=bvuJXH8TzHMvK+a9E1BsIFHaaAVlQgh5actAWxi3aRN32mC3BQrIMpsRbDOqrxYUT0An4JJ6OOtYG1pFmDB5ZwKivZv8vZhNuLASC6fIH4zv8C5JwYMBY7IEo/usLQYYtdlDn0EHJ8oYgxQPy/a+V4kk846bySoXLk1YMUl0/tHK0K9evZ7easAsew5ZDFPuEIZ/nRcFrsLFatbseRD9eS6gmxKHcQh274yx3PdHJIuemAX08HoxLsASULifQpfNjYxmVqPmL9uxgWmSRWw2oOaeq5WzOu4O/Zg5hRup379LD35+cPG7mZyHZUVC/B8HGRpoy5iT3va8Lv2W3gqi7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xczDOrlcjB12yihCHeMDFTh2nwF//4VIGQk4i0BewOM=;
 b=Wg+TRHCQu796Le22AWmaJCi1PRuJb9lzlWgvS9y4u4/eGStvUMq5DHSDZXFlMpQuiYWp6a7AVM4oauFjFBZUvFUweFMFpOc/KFKiyvnKa6xiZvp5dgFXbVAbrMQulO93A00UHlYmGFuKxswaCP1dp5FAGe9u1Yr9ZXh9KBooF90=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com (2603:10a6:102:232::18)
 by VE1PR04MB7343.eurprd04.prod.outlook.com (2603:10a6:800:1a2::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Wed, 6 Apr
 2022 15:24:44 +0000
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::ade4:ad15:823b:7e2b]) by PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::ade4:ad15:823b:7e2b%7]) with mapi id 15.20.5123.031; Wed, 6 Apr 2022
 15:24:44 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     gustavo.pimentel@synopsys.com, hongxing.zhu@nxp.com,
        l.stach@pengutronix.de, linux-imx@nxp.com,
        linux-pci@vger.kernel.org, dmaengine@vger.kernel.org,
        fancer.lancer@gmail.com, lznuaa@gmail.com, helgaas@kernel.org
Cc:     vkoul@kernel.org, lorenzo.pieralisi@arm.com, robh@kernel.org,
        kw@linux.com, bhelgaas@google.com,
        manivannan.sadhasivam@linaro.org, Sergey.Semin@baikalelectronics.ru
Subject: [PATCH v6 6/9] dmaengine: dw-edma: Fix eDMA Rd/Wr-channels and DMA-direction semantics
Date:   Wed,  6 Apr 2022 10:23:44 -0500
Message-Id: <20220406152347.85908-7-Frank.Li@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 454f20a6-b48c-4b18-0ffc-08da17e193ec
X-MS-TrafficTypeDiagnostic: VE1PR04MB7343:EE_
X-Microsoft-Antispam-PRVS: <VE1PR04MB73437BAA87D16D848125A56288E79@VE1PR04MB7343.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OjVQT8i2Eg2roV2VeGCkEmRjLPfdAaf9NcOGNywHmjfu1TD/T4+j3eBlzUet8edPZRhntmaWT//wt5cap5srTEEsOxBYBA2YC3/RBpNR2z4qQBrbqq7ruWKiu5QRz7ya5gRa0YY0wPbrVYnIZpdpYCvBvdi23nCB9kO1ZAfQ3rSgArJH0g1wpjHcBiKpsC/pMkN/+xrO8uUxJ5P11vsdQEMG1k/cGlFn2XM2MTCLJ2gVfyjUpFWGV9YiKCZhvOXCbo662bGrLhQp1ER9t0wWJuN73YGkTuFZos21uAJj1mAte2zuX1fEugoACKEu2jN/9mlRGlUDjk8rxhB6jyZ9e+lRwuVGapKcGqOCA4ZmxeSER4KDvaCsFhJocTWc7Ku7MbbDvjrkBFVCjuUsSxaAtdtkk1qffn4/JPUe8CHyrRVWmxc16DYmXTUZ95sjsEL7zfoR4hYQzxvI9kzAu6+md6PeA1sH+bOQlxeBdQQ89Bw9CbNm2teN1o/DeN3kCqhBsSDx9+9FuWcNYh27PaoK0iJSxgqy/wRmpoh0ehZlhhZuxPlBtfCFB5R2GX7aCXnsmZWgNrLRq01XgHfvfMKcvcsyK+knb+6LaZ8Fa6v5YzZHsd3ELFk425V9YtrEZONoJhP14WmmassJViSgwIg1+URRreRzmPhHbZ+23K0vzE4Ou3V/tnAWnbAyCvZWq5r6gzJNhxo5XJ2oWpKCXbzF3A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9186.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(508600001)(6512007)(7416002)(36756003)(66476007)(66946007)(66556008)(8676002)(86362001)(83380400001)(4326008)(52116002)(8936002)(26005)(5660300002)(186003)(2906002)(316002)(38350700002)(2616005)(38100700002)(1076003)(6486002)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OFXGJluCejqGoXJpIx/tKlykbT4YQABRcqDQakaixtV9SWQ/yzISO7n7M9LY?=
 =?us-ascii?Q?CJbI7KZLjBeP2wUsQMcNka4GmL+ObtA4HJimifTDWbe8e5Ae8DaYwewm/ifi?=
 =?us-ascii?Q?09N2fgVXAPw0ofucucD8pMdKyC8n3ud5rZaTFsXlsC9vwPIhosPi5h3f7Bs6?=
 =?us-ascii?Q?hF87D6Bhn9waW+5In7HCsHGlkKhDpZdIn/JW9meqKO1ZVJXnIbZWwMtqwqSk?=
 =?us-ascii?Q?Z25EruZUhw6ZTHaMPXwoFCSwVD1IOSpjqcnEDknEbV2kw3W/9C2HPHvizN9h?=
 =?us-ascii?Q?lxQGluRBKlLEpZLpjVoRAWCcR8ItwkNjcEEuih3CvEgTlRtGv459f5rGMnNp?=
 =?us-ascii?Q?n7FQffKHX5L56F60zi4tk08tXSdwueWZKf023CHpqYanMjYzivrFF88LYi6p?=
 =?us-ascii?Q?HLFNfspdLCSFAwt4h+dKHsXeGr5HIg4bGu2T06thdLwPnKnjnbyaqkCMVur5?=
 =?us-ascii?Q?Vw+n/mFAm9ERxh6WHjPcSPO+B+/OtacGazbVOGShgW+9389oHbZdqdBVH2cK?=
 =?us-ascii?Q?l6P/lANCRTwtRCY7GIC4V/Nqubk0L5zf6vMvVAnY/AaY56JgJMC6RtlgcJXT?=
 =?us-ascii?Q?xTj58ofjJq7oVguSH3sy3cNj7NUpYIwvOCGIilClkdaU9XVfzU5LpM1JWysU?=
 =?us-ascii?Q?+/SyRgRPm4O1N8xN2GwnPVl8QiHQMmQzyR7VmSyXZ4kpWtE8Uh7Upn7KdnMs?=
 =?us-ascii?Q?Fd2wkl4drQZncby9beCflqid9ovHPSgI3Zn5nP4uqCY4Lhyfsx8GLjV71cBL?=
 =?us-ascii?Q?DeBSV1FgMwj0AsPxB1dvJPXruRziEUj2xpB0gYLTGMGRXtX6gbn5oyb3vj89?=
 =?us-ascii?Q?NpVMexxd9oAGN39om7KqZvhb/JzAYT2xDORb49cIifthgZ2AMWtiVxjfdOVs?=
 =?us-ascii?Q?qHqmYw5Dq7+4MTnV4o7OnnQTwqBHzsocQtyWddDpMW+Pjz2N5CQfvtcehLCo?=
 =?us-ascii?Q?5Y0TXO0nevMEZk5wdPrlhQo2CBVb4gerrjYMbBXQaq6Gc4c8gT0S5tRnHX8h?=
 =?us-ascii?Q?MgxRyOWWmzdOYx/SOjPcZkM/TmG+wFkjcN7uwZwpN7lBu2INOiqCo3mEKo80?=
 =?us-ascii?Q?WgIJazEJ1hhX1nzmnPn39tHCKBN5Aoy0l+SKZMC0IxHXrBSWjhnQfK/v8yhx?=
 =?us-ascii?Q?VzgffVjy4Jnr1nnjszH/0OtOThvyS9KIf7JQnfJxxNVt8bl/GCVyTUWauKYl?=
 =?us-ascii?Q?nruSgcUY1zxI3Eh+D9Z3V8pf1iBZ/ADCKzLWpTJetuF7Q+GHvVeHMGiv9CkF?=
 =?us-ascii?Q?qG4OLBC/qtcvwHOHvdNDYeUmqKPRQ2HFrgFa+f7EOlEc1DOuHhy6lxFYIlIr?=
 =?us-ascii?Q?Tuiv7oTz3ah8jWPLwgFI2ZW8QhDx3CZUcy/l8+68+gkfvDh1aJqIHUP4czBR?=
 =?us-ascii?Q?LF7mUEwlzBwcV/1n4B4ERjyTxofWTdVtOdb/wayvSCeGvKC1w+JAwxI6aiMY?=
 =?us-ascii?Q?8FXEJSM4vJHen2szTyoq1K9tWSQ6rBzevZXUBs2h1JRZ/qoNiSrO7Uzj9DOz?=
 =?us-ascii?Q?HVZczmGDM1ve2H3sUcDPI+pTrKuR+d5/3gEkYpusPzI8bBGg5+mRydg/f0wJ?=
 =?us-ascii?Q?IUUOo+RVu3qygPbJGo7AL3YFVYZ+jg7nJmn4VyoipKtDIDvIjhEBuXsqRzHo?=
 =?us-ascii?Q?QGutAaqv4uDI3zhwTBGwpG77imB3E+nd4DKytUBvWf4sJ6IVlhzLhZwlM0vQ?=
 =?us-ascii?Q?oV/yPX/LAG2OHt3d+fyVXeqOOonSqni1q3UjKqPRSoKc3pm16CK16MONDZFx?=
 =?us-ascii?Q?uDTAs0sPRA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 454f20a6-b48c-4b18-0ffc-08da17e193ec
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9186.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2022 15:24:44.4866
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t9cqlC/Zan4ZXn9fy/pipq0jR7lCd7A68d+5jUcLTY2eUAWvBspl9KQpHtIQsGj267k6KyZKCzIe4rnAp56toA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7343
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Serge Semin <Sergey.Semin@baikalelectronics.ru>

In accordance with [1, 2] the DW eDMA controller has been created to be
part of the DW PCIe Root Port and DW PCIe End-point controllers and to
offload the transferring of large blocks of data between application and
remote PCIe domains leaving the system CPU free for other tasks. In the
first case (eDMA being part of DW PCIe Root Port) the eDMA controller is
always accessible via the CPU DBI interface and never over the PCIe wire.
The later case is more complex. Depending on the DW PCIe End-Point IP-core
synthesize parameters it's possible to have the eDMA registers accessible
not only from the application CPU side, but also via mapping the eDMA CSRs
over a dedicated end-point BAR. So based on the specifics denoted above
the eDMA driver is supposed to support two types of the DMA controller
setups:
1) eDMA embedded into the DW PCIe Root Port/End-point and accessible over
the local CPU from the application side.
2) eDMA embedded into the DW PCIe End-point and accessible via the PCIe
wire with MWr/MRd TLPs generated by the CPU PCIe host controller.
Since the CPU memory resides different sides in these cases the semantics
of the MEM_TO_DEV and DEV_TO_MEM operations is flipped with respect to the
Tx and Rx DMA channels. So MEM_TO_DEV/DEV_TO_MEM corresponds to the Tx/Rx
channels in setup 1) and to the Rx/Tx channels in case of setup 2).

The DW eDMA driver has supported the case 2) since the initial
commit e63d79d1ffcd ("dmaengine: Add Synopsys eDMA IP core driver") in the
framework of the drivers/dma/dw-edma/dw-edma-pcie.c driver. The case 1)
support was added a bit later in commit bd96f1b2f43a ("dmaengine: dw-edma:
support local dma device transfer semantics"). Afterwards the driver was
supposed to cover the both possible eDMA setups, but the later commit
turned to be not fully correct. The problem was that the commit together
with the new functionality support also changed the channel direction
semantics in a way so the eDMA Read-channel (corresponding to the
DMA_DEV_TO_MEM direction for the case 1.) now uses the sgl/cyclic base
addresses as the Source addresses of the DMA-transfers and
dma_slave_config.dst_addr as the Destination address of the DMA-transfers.
Similarly the eDMA Write-channel (corresponding to the DMA_MEM_TO_DEV
direction for case 1.) now utilizes dma_slave_config.src_addr as a source
address of the DMA-transfers and sgl/cyclic base address as the
Destination address of the DMA-transfers. This contradicts to the logic of
the DMA-interface, which implies that DEV side is supposed to belong to
the PCIe device memory and MEM - to the CPU/Application memory. Indeed it
seems irrational to have the SG-list defined in the PCIe bus space, while
expecting a contiguous buffer allocated in the CPU memory. Moreover the
passed SG-list and cyclic DMA buffers are supposed to be mapped in a way
so to be seen by the DW eDMA Application (CPU) interface. So in order to
have the correct DW eDMA interface we need to invert the eDMA
Rd/Wr-channels and DMA-slave directions semantics by selecting the src/dst
addresses based on the DMA transfer direction instead of using the channel
direction capability.

[1] DesignWare Cores PCI Express Controller Databook - DWC PCIe Root Port,
v.5.40a, March 2019, p.1092
[2] DesignWare Cores PCI Express Controller Databook - DWC PCIe Endpoint,
v.5.40a, March 2019, p.1189

Fixes: bd96f1b2f43a ("dmaengine: dw-edma: support local dma device transfer semantics")
Co-developed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/dma/dw-edma/dw-edma-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
index e321f36c1bfb6..90a353bb5fb49 100644
--- a/drivers/dma/dw-edma/dw-edma-core.c
+++ b/drivers/dma/dw-edma/dw-edma-core.c
@@ -443,7 +443,7 @@ dw_edma_device_transfer(struct dw_edma_transfer *xfer)
 		chunk->ll_region.sz += burst->sz;
 		desc->alloc_sz += burst->sz;
 
-		if (chan->dir == EDMA_DIR_WRITE) {
+		if (dir == DMA_DEV_TO_MEM) {
 			burst->sar = src_addr;
 			if (xfer->type == EDMA_XFER_CYCLIC) {
 				burst->dar = xfer->xfer.cyclic.paddr;
-- 
2.35.1

