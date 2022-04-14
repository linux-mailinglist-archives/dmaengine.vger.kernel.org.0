Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8405E501F3F
	for <lists+dmaengine@lfdr.de>; Fri, 15 Apr 2022 01:38:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347728AbiDNXkY (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 14 Apr 2022 19:40:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239685AbiDNXkW (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 14 Apr 2022 19:40:22 -0400
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-eopbgr140057.outbound.protection.outlook.com [40.107.14.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C989BB928;
        Thu, 14 Apr 2022 16:37:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wm/bUNWjI4VamxXtCXIFQcX1hPb20oOUgvLLtLmydPz5zjb3BLUdARjLjlds+CkB6ful1QS9NQnoJEugbhQg98nGBS2tSqF0RF/nc3XxJPfVpk4iiu3jCy4ONa47P6tFkfh539UqqIKEWWz5Hh2v/ZI+Uh74jmPNQDWl2TZAmB575cv+HCg8p7qB9bnRhSCU84cx6TGL8pMb55B3jmyXm5V2wnVFcZqjphdS8oiL5mXgLEr5iO/Z+7SiNSq3atjKxQfYA6EwR7pHZ+uHpmbzdtLLl6joXlKxsn2HIapZghuo9pnigMyPUVdvfOylargEybIA05JiQieXGbbIlUysRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=21gz+xTRvA8WA6ehie5vdFb8Uc0AAso7NHLPnnYsvsg=;
 b=QyOQ7E9Unh3V2Icz4yNHbVAT43bqTS6uB4zhK2f1JJ3R6rimvIm6b1dO4Q+lJ0ICKDIO8O6BmYa88IanA7MiwgD9pTMXk9x0472oaa5ukSA+HhEg89lvIQrrvn5IK8CbhRZHiq7QMB0DPojFgzlJ5Apn9Pk9DiG3zqU/etFKbX0HzL5rZO0DRKQMDNRGxLFElWjEsIM/hvyKTYy8Z1QoD5Ho4pKRnOqOZWtvvyCKatYezvRxwNsE3VHZ0HsC7NFmRwhBzKTG9mPMYtc5yJnLKQ1To4Pui/BB8deFjEQvAT3SQnnprTbiR4FJoDKu8lrAGs1DGdoBqTXFXP10M3yaAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=21gz+xTRvA8WA6ehie5vdFb8Uc0AAso7NHLPnnYsvsg=;
 b=Oi9B9lL39vPuXb7e9z9bi95uDbfME+4nKfLldwNvQLpOtdR3P+nIzHpChj/WSSxzK6/hD+2M+KEojwNEaoltJWgzLr/aCvTRQLOxD6sbyyo6qeJSwfGKvgSydQz0qZIfiHjueyvF7s+jYjc+rXK9XE4tz4q9Ft3knBSI2F5ua3Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com (2603:10a6:102:232::18)
 by DBBPR04MB6043.eurprd04.prod.outlook.com (2603:10a6:10:c5::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Thu, 14 Apr
 2022 23:37:53 +0000
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::e13c:6fb1:ca92:d11b]) by PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::e13c:6fb1:ca92:d11b%9]) with mapi id 15.20.5164.020; Thu, 14 Apr 2022
 23:37:53 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     gustavo.pimentel@synopsys.com, hongxing.zhu@nxp.com,
        l.stach@pengutronix.de, linux-imx@nxp.com,
        linux-pci@vger.kernel.org, dmaengine@vger.kernel.org,
        fancer.lancer@gmail.com, lznuaa@gmail.com, helgaas@kernel.org
Cc:     vkoul@kernel.org, lorenzo.pieralisi@arm.com, robh@kernel.org,
        kw@linux.com, bhelgaas@google.com,
        manivannan.sadhasivam@linaro.org, Sergey.Semin@baikalelectronics.ru
Subject: [PATCH v7 6/9] dmaengine: dw-edma: Fix eDMA Rd/Wr-channels and DMA-direction semantics
Date:   Thu, 14 Apr 2022 18:37:06 -0500
Message-Id: <20220414233709.412275-7-Frank.Li@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 9d5088ba-f21f-4066-45a1-08da1e6fcbc8
X-MS-TrafficTypeDiagnostic: DBBPR04MB6043:EE_
X-Microsoft-Antispam-PRVS: <DBBPR04MB604333DB38BD13EE3563979988EF9@DBBPR04MB6043.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3FGxemsQ+s9YeJw4ZvrkdvEQ91rUBdAZ83KQHAo3ABE9wiU8H2Tv+czv76wHgm+PhAJ2v/quuZb+cMxctCmWMRXxP6pAR2VOyArHBPhQ2TUK/rankb87xKIj2iytZiVuhhjJaQCa4nRRpz4xnWMPhbS+6gXYR42Cmq9zVmPcx6HDuXJoxgfP8n0qU3LEFXDVzTr/O2afEv96oQUo6vFViNZuGMjEEwD3iORubeqBx6zygC2Cme9s+WHhzr0SG7bYgKitdnT5c1qArNolXa+LAMDqawq16ngtlqouxMEObqWIAWDRLDeB/5ZALFFvkOzCWOUngY50LhkQ+ntXkvJIs5Xy/K9r45VLgT6qXZSbE1iiq3R4C3pqB46FTcDaBt1fWIKEJd9Nd0KnYLzOPxaq+S5DsED8YqF3b6+rp17caFsJPIBH93k+5f8Jc2RKtIWYzRqLT1M6jRC67DpUpk1nOYqvKidUeB4dD8EAxgYnJFtPTq9a8/PJYZCoA0kNp4swwDPFlTljNVp/Zl1o76FD0bXt6zgl/NDpXenYj5F50hbLno+MpkBnPKglZ7dWuS6HvOV48+mguFt+q4EiM8IU+kZBeGLP3OKtGO3W0bYdA76PQU4olckDAv7KgrUqK0a6jEBXscwJSoQJBE7i1v16pHxC3njBUBIqVBlufupdAvTG/febS8eTQQTwbKADy+QLhyJCGgyttBkETxYMfrA8dQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9186.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(5660300002)(6506007)(8936002)(38350700002)(83380400001)(36756003)(38100700002)(508600001)(6486002)(2906002)(6512007)(6666004)(4326008)(8676002)(186003)(316002)(86362001)(7416002)(1076003)(52116002)(66556008)(26005)(66476007)(66946007)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2jM74C5CBa1gjdlI8nY8ZeJ0nPMXsHpOLnLAJ/flpTIlqA5EXuM79CziTVqO?=
 =?us-ascii?Q?bhZUvG3W4aVikecyAqC5h3AqQOHRdqyqXPItlJNWLSxnzYfWCEh+d1Ej0jNm?=
 =?us-ascii?Q?VsMwHRjBTX5XxD+62dtaS3vVuYNThrF9mBTIXUKAaao2xCIWM5gTKC5rPwY1?=
 =?us-ascii?Q?GbLPhuS1gYfkTlBaClS26ILO7voo+dAI8Q8CabHDxKkYZXWszV2zC5XVP6Tx?=
 =?us-ascii?Q?r/Py0HI3/k5qZdmRjcaVbNbYuxTFsvwNdQ91ehMgjbcq2d7ZzdyA/U6DeLK3?=
 =?us-ascii?Q?sn4trN1BCY7wiB+LBgZaa06FQDEKhhHUHf+76ZAP42n3brqgQU3++LUTVPCp?=
 =?us-ascii?Q?C1Wi7U6wp19zRxlN58kEEC5D+nt1NrQzNSeZZQX7jUFqJO2V5cCaeN3ofIeM?=
 =?us-ascii?Q?UlwbN2PQtFQ9mbLjP5g78hpAimIwge9F8G4aMEbnMO66jMUg7QWeO4RJDhT0?=
 =?us-ascii?Q?hrsC/dezk3jiPFx73AzufFp9UcLetzb5FNj4cT2XtqWmICCZOWKylo/86w6i?=
 =?us-ascii?Q?02+aNUQnTfGrK7znC1Ez+JuFoaXq8ad5mViyraMBCo83ItPLEZNDmhUUqOyF?=
 =?us-ascii?Q?6zs72m5aIeY/r9GjR70pgWt8kkNL1LWjUe+EOFTTEYC85g/6oOspw2Cfw8CR?=
 =?us-ascii?Q?tyJmrGmIrZ2ra5YV7IhPhQJr+ZlBCF1xBz7gKqw/q707WJGd2wGL88u4/m2y?=
 =?us-ascii?Q?fbYNFodJ0UDwL5qd/A3TFGfrMpaGSxm6HmJOw5mHUXYNAuzjp9wVvo7MmFIo?=
 =?us-ascii?Q?UPkwX1jgByA+X8g4fl/JJ1bPookaflEeoKHNH+Z+NpjSvnSFPwRj07JafXF8?=
 =?us-ascii?Q?YoUfJ8Jq5Ge0Q2JDGYtryBVWyd1Wk9C6Ph9uoOyd3zsoIsM72iHhrZH8dpnZ?=
 =?us-ascii?Q?uz26xsy/eo6jwKCCLRKGgrcPyUGVifVip4VjZ78F/lv1dofxv7ipT+VQokSJ?=
 =?us-ascii?Q?VFSsyhjsIVQ7azrvysQZxbefaTNTAmNCNH9Z6C52CDgrnprCFRd4XKKqSm7/?=
 =?us-ascii?Q?yiO/QPX87jqWwj77CLTVW2DGg6c3tv3F8NSNUIcAdwtO2vzvS4SeQmQ5zYRj?=
 =?us-ascii?Q?DGnRp9HWpLaHHth1esKvCQEv5pYn4/0hKv8hAOYwi3Mhh1GUHLx8bantWrzP?=
 =?us-ascii?Q?invNPcIoloJmATpTAObxq4zpXAOR8KhuG/HVTv2UsYHwP0nuW7yuICBcogO8?=
 =?us-ascii?Q?8yq4gA9vvGQRJua/oAJ7Ig2tbVVrnRTmu9lXpw9FVcYdyBltM/R2d3JtEBHN?=
 =?us-ascii?Q?ZEg7INaAWoFMfheRRu2mori/K8/PQO5OhzCwQpyHIyodg36lpSxShvNnRsG5?=
 =?us-ascii?Q?j73bsY1uX39ZO3C6Gj2R/W5nbJxopaWjXTTjUZ9mz6OXrsRUYiqwMCQrhjwm?=
 =?us-ascii?Q?uieo3BOqX7+J36Gi1Xq3TOOqAoXj2xoJeKOyJYc2HtmhM9b4YdvYL53gHtD3?=
 =?us-ascii?Q?lzFZy5R5cpymvfp3CPeUq85wC03Y2VQBl1I4PpNxThRFBhd1snB9iQQ90uCh?=
 =?us-ascii?Q?BXZ+scGSnAB938VwMTdg+x+3B2S2va8Yh8U0yNk+gvPKLWq0xPs/lfXOhXfa?=
 =?us-ascii?Q?P8PvkavytGl9BCnA2Y9F41ZhIPFoFszA15BCfpVayS93L3WlU0SlM86e33vl?=
 =?us-ascii?Q?0BxWN/21l2kHvSjXppf70/28gi7gQvfcdUNb4hdhDl06EP926vRUKjpIUpPP?=
 =?us-ascii?Q?KMBh+4B5b7AOai4AD8bgEMDsxpNAzcy5bBqxK6dEHU02wRcooN+RL4hXatTK?=
 =?us-ascii?Q?yugmDvKrrQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d5088ba-f21f-4066-45a1-08da1e6fcbc8
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9186.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2022 23:37:53.7167
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pojn4agwyggyOvR1PjeGk5awwUimhKfylU3d0JH3srvhrZYgaC4468RIdQuj8H52xs60VYsZpskagMgea13bbg==
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
index f413fd9416956..2765fa1230dc0 100644
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

