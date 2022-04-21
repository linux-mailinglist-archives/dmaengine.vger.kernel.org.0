Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6FFC50A2F2
	for <lists+dmaengine@lfdr.de>; Thu, 21 Apr 2022 16:45:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389605AbiDUOrv (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 21 Apr 2022 10:47:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1389655AbiDUOrc (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 21 Apr 2022 10:47:32 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2077.outbound.protection.outlook.com [40.107.20.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B39B40E70;
        Thu, 21 Apr 2022 07:44:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nHGx+4oSS6YRb3v7zrVOHqD0A+DsWaW0tY2HJE26hHs3RbVOHuoMHYY9oahXE0muKbDQJzfjsl1HQtDokpLJRXFt43a3KBcXmKHUdP559jj6h0qYuQNpcuawauD0kMkMzwXjaGbUIYIOXTwSRLwuaCgH8J93Rs/95nOLkrNZ3UyLqK4lSl9NL4KqByGACo3IQIcBkDXuRybCNxfM2FCVvBZ1mB4ZxOkbqP8kBi2RxNhtB0V5cHq8Rh0p2iBaRoowxZOJcnXJKi3S7TXGWz0FRttXerwjit/vmHeR7KnTfnT8F2gvf0IlWSA+N0Eeobef813kL4tZsp+068uyzS9pwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iDLR4RrzcSMDkGIvXMGWpsgkncN1pWQgo5kbq3jU6wU=;
 b=luqJ0r3+y/MVpdx1VH4+TyK+QL9a4HMe+UohRsEWGTBI4YrR669eSdPYTj/gUdCoLYfdI7g9nbv2SXIZZr+J4TWS3avgraxLIxVUiGsNdJ94rEuGORGfVjYcsRe7Am7nfXBN276SXGI30PdwnSGrDI/r4OIJG8q/2krij2eOBXZKoxGfh5OtC6ixo/8KpcpavSr+P/YZgEfwpQqoHexZaiNtOiWE6BDMA477j4YiCuDUlQL6lKJVo6gSbhDwzQn+nYKpRjfWhMk7ZRJDeq/cOdCFMVy6GB4jSgPiNCTybRNy2eakGrAmjvNYzWFcJhcAdRt4NP5kw+QrqFRiq6EYFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iDLR4RrzcSMDkGIvXMGWpsgkncN1pWQgo5kbq3jU6wU=;
 b=V68d7IIEk50O1PD3URZ/DQCxvmI/Bjnb82vtoBg/40QVpwaEv8ug0v8i20ZACU0InkFJ7quEjUlMbu6NOTiR5tTf/LcMl4bwhzY6beeJbqCelrYsHqe+aDQASP3LK4GtD+jB/vZ93ubuYqWMq5fZbMP0H+YcDiNpLYrxOXzTqyI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com (2603:10a6:102:232::18)
 by AS8PR04MB8689.eurprd04.prod.outlook.com (2603:10a6:20b:428::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.13; Thu, 21 Apr
 2022 14:44:39 +0000
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::adc5:45f8:fa40:1b8a]) by PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::adc5:45f8:fa40:1b8a%7]) with mapi id 15.20.5186.014; Thu, 21 Apr 2022
 14:44:39 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     gustavo.pimentel@synopsys.com, hongxing.zhu@nxp.com,
        l.stach@pengutronix.de, linux-imx@nxp.com,
        linux-pci@vger.kernel.org, dmaengine@vger.kernel.org,
        fancer.lancer@gmail.com, lznuaa@gmail.com, helgaas@kernel.org
Cc:     vkoul@kernel.org, lorenzo.pieralisi@arm.com, robh@kernel.org,
        kw@linux.com, bhelgaas@google.com,
        manivannan.sadhasivam@linaro.org, Sergey.Semin@baikalelectronics.ru
Subject: [PATCH v8 6/9] dmaengine: dw-edma: Fix eDMA Rd/Wr-channels and DMA-direction semantics
Date:   Thu, 21 Apr 2022 09:43:46 -0500
Message-Id: <20220421144349.690115-7-Frank.Li@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 3de95cb5-d20b-40a2-ed27-08da23a576dc
X-MS-TrafficTypeDiagnostic: AS8PR04MB8689:EE_
X-Microsoft-Antispam-PRVS: <AS8PR04MB8689440B9B378D02CD040BB188F49@AS8PR04MB8689.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jX7y6wrPgbt1WqQCH292woNcKxNrebxt/T2re11miu9xHDRIs+Pq41bdjO+bcsLEh3zhOA5Fkf6RGVTiP40nW19+IuHekin2EmVAOZZl8dgDkISzcFFJ1SxdGZl12y6I/NHJZXHm0YgaXZAxBg5+dE4RPOjMTjqltIL+XI3RTj/lqBPZouHjIb3PlrA0PwCoM5orKnx8AkeYdOgM7DpZrztekh1pnpjKW6OvMzf09smYGjuUWi79v/UxiWsmgHWGqfRZlIoQAHIINH2Qer48KKGjwepp7DfzS2JMR0IW+b5FbD4bOGMwye3zOo24vAkJGmiJlnPmY/Gke4PBXtEkVnJeAiRwVZ6+GMxFKnlxPRvxSxuRb6sCOYJ1dc6/3n/Zdkly0Uz8Pg8QK9/+gTrwkn57M8WbaAFzjnF8jve56NEoZUviULpnaONJvlW5sF5S2Pl7Bm1354ys/jVLsQJ1CIkn2kgSltEPmbFJeM9y9r3vmpO0xcR6VR2ujqTsEXJWlFP5xwLcb6gq7TkxmM++4ESlxKLBGe1tyk/InEx0HGIGM9b+oIoUcigV+SIjcLsc/A9pIgMvRXuLFjQtIHoBGBAJSRGX5+jUxfpRD7KGwIUKbs5yX9byrwwHng7iBm2E4N0W/P02bbrzaf0Qw43jy2nESn+zaJvzqJux6rmF+ww2Rua4MORAZTVKzi4fEeyi8vX0ngkxnQhoBxWFn/5G4Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9186.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66476007)(66946007)(6512007)(508600001)(4326008)(316002)(26005)(66556008)(8676002)(52116002)(6666004)(6506007)(6486002)(83380400001)(86362001)(38350700002)(38100700002)(186003)(8936002)(2906002)(2616005)(7416002)(36756003)(5660300002)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FEg18Fk/KJbcTniFj16Ruba4Og8pN64v3w3VTjB+DFEEG3UodFz3eRZupMkT?=
 =?us-ascii?Q?lJAQsnbmz00YqhmCHMs+lxcznWXGBjMTiFq1DTF4rL7ch9owYU/MmwDUR6+R?=
 =?us-ascii?Q?VUU7MEa5nIqJ12zn8yy86TktRPfU4L1u0OioJyt59piuWMiNHaExrYUbZs/5?=
 =?us-ascii?Q?10Ry3G7PfjirTcbt1/qrOUoFKWwhUfhAdCRFwm5X0JeD8h8FHL4Txm0euLgc?=
 =?us-ascii?Q?xnhdebk7Ls00oAzfjLMoCtySa+1bDicCMXIJCNc/TX5zucKTGU7RJZhAKIOT?=
 =?us-ascii?Q?LJ6tp6OA4/hgJW6tAyNkqXLBzUOBMftG7HPmraW9uMFq0jH4AXtfxI6PjkUO?=
 =?us-ascii?Q?JqZPX3LaY44y76SkPTUnZ21kuEnqBijrIOdfw8Xizl9zHyiwmOMqdFmb5Ojj?=
 =?us-ascii?Q?76F/hibKYz02ewiqnXc3YSEVrwN4l0jPIWBjRZPVmMiJp0Qu9R++x3zlWewM?=
 =?us-ascii?Q?Ea8BepFm9NPH75PkTfEii8x5c2EZuCFsjVQh5UdegHKi4q9tCPtmietZlNEJ?=
 =?us-ascii?Q?x/PinRyPAr3mw72uBFoaR2ih03je9LtJs+nU9KI3suM6+G8z2+B5lXSYerqj?=
 =?us-ascii?Q?e0v5gC2Lbvc+KRW9NnKGj3hABmXevvul6MfSD5vK8RZjPLNJAViPpknP8PES?=
 =?us-ascii?Q?SomM1IKkIXyY0YfQPTKJkhekO1ATe6V6mgayqlWLyp/kvp5WymOsh9jWS0ci?=
 =?us-ascii?Q?mpo1+XPz/weGyVF6Re0HAr/PJYwA9G7tJGFTKX7e5Mz1NYii/roDo2O1TzS0?=
 =?us-ascii?Q?uUBaFufJ69knXGuvFm+liOtF5FGrB0nw+PP/llRoP2PKvwKOLCOuRkHDVb7v?=
 =?us-ascii?Q?JhY4Hn510GeogrZJLBKqdMijIhDnXUlU55nEf4AfPalD8al3nDgdoeoL5Sjz?=
 =?us-ascii?Q?XjJDy/Hp7jPgsIPETAeKcMFrJQqmB107wEzpFAmex3b4I1F8IHoomyk2ZM+5?=
 =?us-ascii?Q?d+gDQoFvIBk9na9zyMZNns4JTrPbclB3qU3OaCU91TlxzEf7Bc+/EeJmhoEy?=
 =?us-ascii?Q?C3ASuYmGp/KAWpiFMtBc8whsHEDA6VnN5n8bBDpNZohTQW14hZETGE2yw7ne?=
 =?us-ascii?Q?SHyG+RFchVpRe/RyI2CM3J+RzuLnTMaklwZK0sysPt64G+XMQV9GFkNaHD3a?=
 =?us-ascii?Q?DMMyNz0pV2dkzB9fqa21FUxEDtFtzc1hfYl0J0idWn2cmyREvF87jzeaUvpN?=
 =?us-ascii?Q?cmRifuGddU/J+PsLWnulO/6QtNKuH4dItM7nANDJPnSiyF+RYQ34UFpKHUYV?=
 =?us-ascii?Q?te9ExFVA+TdWj2UNdpzScG3PVgPHKG54Hn9a2Wn27fc3Ey5WnV32Bln3Y65J?=
 =?us-ascii?Q?idVKv8voB4/Y6fymdU9oqBaIBYiJobPBLDFGX2hJnYRzbL2hS8MPzzJcjEa3?=
 =?us-ascii?Q?oRGt1+zAmJj1s9mtc4K26I5fni+61LFgZWOgk4Wr2KZcZOev0dyGfo+eN6fM?=
 =?us-ascii?Q?lwyuyUgsifa5WTTSkpE+YBoZJ6lXcfvZ0Yd/xQ4mgO9MrWzMLq8pQrwx0Tn+?=
 =?us-ascii?Q?M4rESLQfdcWDCcNIdCEpXu4wXvRJfUQ/FABgzOyIHXpwZtQ7Kf0I7l+fcL0V?=
 =?us-ascii?Q?Vp/jhYB4jf3nD1UMKMgpsWtz6IzuFvjuppjkLhsQ3k7RAKIsNeWr4zKYWVu4?=
 =?us-ascii?Q?COguvY/+jkZTe6PBV4p3wDmpdpvkYVl17QuqUFfiM8lTugSa423Flep90Bjd?=
 =?us-ascii?Q?YsfM00LgAy1Iev6tedezNYibf8Sd7Y7ErNAThHbzQldCHNB/8sEZLHcMBa6G?=
 =?us-ascii?Q?3edfQKE5+Q=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3de95cb5-d20b-40a2-ed27-08da23a576dc
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9186.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2022 14:44:39.8674
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PGBg2Ph5C1W5TRcC+NvwFXAIpkx7+SZSNMd5KSe4Zqwg75vCN0zMTxYgf21fxStQVAzFTUWIZ5lK0urtb4vQLQ==
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
index 184622be500b7..9ac2723ed31fb 100644
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

