Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 346A3532D59
	for <lists+dmaengine@lfdr.de>; Tue, 24 May 2022 17:24:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238888AbiEXPXK (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 24 May 2022 11:23:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238963AbiEXPXE (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 24 May 2022 11:23:04 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2084.outbound.protection.outlook.com [40.107.22.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D4BDA005A;
        Tue, 24 May 2022 08:22:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U+38HDTNO/JsqLmV5etydCIwnlhkqRu2gUcIb5jipPIC52lg4o3IGIxPf4sMb0Q1RHPl0/ZNHxpOerdc9ukAkCJsqFCKjBUaxmDcmYMdusguF+Mc2elR5ZkfPFJTgQLSmbidKd21kRcefHw11qeIKSa0ah96haV7sLslWDqbWSFSYUPFmHf2VE6UHm0J5t4QHli1SbElgTNUFk31s5LkfPHwpEMRxgEdksQidVVq4KjtRLl1PuT8yEuOdhIFX8vqLM9xOX+0ZQr//EJgOMDjE0kAoP6CZ0qkldRtKH9ks6DeFj9p07s0Ng0kPZeW0SLeA/5R9Y4SRgefRCPXrjLZ7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8xiesIl3VQKcbMSIZFTlAHHkBLiMP3OMyWwMoX4eAW4=;
 b=PV0TXvkbssWYAzlyDsDFM+J2fz/OIL1//duiqPiPzZf029vF5LYeb0JFs4+VhGz6H7snOeIDOMSWibHtS3lIxojuD1tZhb1NoesyagS2Qf8TXSQw+LuW68GPK+jBFQS1GRN7FdYDQgJ7T5vtiC/RBH1vcwwWFu3/Ef6qy1gH3QHXprJIxa/mnMqQpkEt1rmf6gK7WcuBpPVr4q33jsze1hS+IxQzPI7c6aNkmZt7ro/fdqy8ZWnbhhpqDFYSCQp7YslDDaqLh4yFAoTwjpV8pucV2IhGRvxytbkyV+M0ainwFHZ022xHVfvgMFdm+sFy9vJ3cgP6uDw8d9N+xUh4MA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8xiesIl3VQKcbMSIZFTlAHHkBLiMP3OMyWwMoX4eAW4=;
 b=gMhVg2FMqTUSOYC+WkGodJQ0ug06CEZPsNqWwIysnYpzTYE7oBdNywd0RwOUxWnXytk8fv7eJ5a1LQqEbpx1dLlx8+qkfFogpD0tmOBylPuYZh8wFdAuqt5C652s33QvbSvlhiwRPrsGhLRQ0P14kcIu4zhcvIQVdcGZhVXWt2s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com (2603:10a6:102:232::18)
 by AM6PR04MB5672.eurprd04.prod.outlook.com (2603:10a6:20b:ae::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.22; Tue, 24 May
 2022 15:22:44 +0000
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::e0bf:616e:3fa0:e4ea]) by PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::e0bf:616e:3fa0:e4ea%5]) with mapi id 15.20.5273.022; Tue, 24 May 2022
 15:22:43 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     gustavo.pimentel@synopsys.com, hongxing.zhu@nxp.com,
        l.stach@pengutronix.de, linux-imx@nxp.com,
        linux-pci@vger.kernel.org, dmaengine@vger.kernel.org,
        fancer.lancer@gmail.com, lznuaa@gmail.com, helgaas@kernel.org,
        kishon@ti.com
Cc:     vkoul@kernel.org, lorenzo.pieralisi@arm.com, robh@kernel.org,
        kw@linux.com, bhelgaas@google.com,
        manivannan.sadhasivam@linaro.org, Sergey.Semin@baikalelectronics.ru
Subject: [PATCH v12 6/8] dmaengine: dw-edma: Fix eDMA Rd/Wr-channels and DMA-direction semantics
Date:   Tue, 24 May 2022 10:21:57 -0500
Message-Id: <20220524152159.2370739-7-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220524152159.2370739-1-Frank.Li@nxp.com>
References: <20220524152159.2370739-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR01CA0004.prod.exchangelabs.com (2603:10b6:a02:80::17)
 To PAXPR04MB9186.eurprd04.prod.outlook.com (2603:10a6:102:232::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: aecfde96-b0c2-470a-9e19-08da3d993fcc
X-MS-TrafficTypeDiagnostic: AM6PR04MB5672:EE_
X-Microsoft-Antispam-PRVS: <AM6PR04MB5672586845AE605DEBBE8CA588D79@AM6PR04MB5672.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: L7rgJSeTZ0c1g4Y7DHkzxrAQqkEg9ldNR5x9P2b6iqiZ/ovH7+Opy/31c/1hizxsekKp35zgY0/3dcnjom91O0SQfzNb4ABz2gK0ZpzExiTL94S3hZX63x/dQSivZoWUfIHoFh4z/zullqrMFVB9V16N3XdWG1u59Cu5F/aCNTPqrCufDiB4p53xizSMO2L9+Nt7z85caUzPFs25xGz0pX2rHS84Eb27l7eYgygrPYp0TzqOOw6MAhVWW63IpXvUPe2oFOX8inxPALB6QjD/XCu/EoWYI00/2Vdq9Lsqw1I1/BDWEKLAu9cxOhgLzS02BUE+cmTiJ+5hNbpR+OmlWu2Nd5LB0YHjvieTokosBOSAbAypWpkYnVwQi7/KNNEK+fLGTQyKifFfhFw0J6+wv53S8WAK3RRSE8SnDcYXyLXTS+dr2M+npSQyhQbez8u9WrYhdQ98070QNKRgSNITbQT/hj6oje+R6+MSuKKbv4FYwmsezI794+rG6YP5FeGCi0zrUebwOdr3LtonuL7KOy7FTyil+qHpUzihlnCGwq3FtUQ4wIG5MuSzOhsrXLLhjattmoS30iDjZ2++jY248yUlQUQSY6OORroaIaU1rFHylZT0ES7OO4xnjuQRyE18otfnFtVspvXmvc1H+eBOlf3tqhzUyTHnB5xiujjAFbf9jd5t0bI3UayUx9x8uh32w2Mx3iwDbUijUyMrO3sFtjZWdxHMeADnX6OnV5Gf8sQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9186.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6512007)(1076003)(921005)(6666004)(36756003)(83380400001)(2616005)(52116002)(26005)(66946007)(66556008)(6486002)(7416002)(86362001)(66476007)(8676002)(38350700002)(6506007)(316002)(38100700002)(4326008)(5660300002)(186003)(508600001)(8936002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0EeCXT2ZjiWLgPe+GZYr31cGoT4Zpw7gTaZb9fBmcVDphsw86otVbPOWJtzo?=
 =?us-ascii?Q?EcISrx3J0eUJRMqIV2g7VlIE5QNU7XL2839wMbRRuXnNYwy0HMznEJhNcfmM?=
 =?us-ascii?Q?JxClXj5N8N14E79Hm+YWPcb+43rJZmR2RNR3R9rZECZQpLNk21nvh8EgQBqZ?=
 =?us-ascii?Q?8AMkLClotBDxVOrsOJAXjgJYWYjGyUdDDkNfrXPVJ+E+U5sa3Ppz/esuXVJG?=
 =?us-ascii?Q?daY8SAbcltfoCK5PLuRB4bFuS577q4xM3xj0aK9dAm8rylUWxpu/q32clzGC?=
 =?us-ascii?Q?bgm/Vjv7Tj78NMU8tgovyqDCqNF7FHkAUtdNLcZWDe9p6TK3M/VqiYf9NJpw?=
 =?us-ascii?Q?MVyE30HVunA6Nf1OiJkt90YIIa6F6eDsRKEwDHPeZy0y6szyuf6jJIrcpVgi?=
 =?us-ascii?Q?G0eAY1duFnGLLHhWCKmifohrHx2A+tNDq4oS5v0NaT0l2r4w5v70gmwfBcpn?=
 =?us-ascii?Q?6DOgKBGdUhp2jjAkK50j8TzMXyvymbCvA4XRNvXvCnbtK4iKpNoi5jXfXn4l?=
 =?us-ascii?Q?QL0Y/iCoJKF8fopuQ656YvWPGOC4muRca74qDJg1AWQ3TeTg9I7TOGhLDoml?=
 =?us-ascii?Q?krXWOtyJuxnpE9cFo53/ArUZBGcKwIVtEmHCHFo46nhLGkZgPg3+Z8gprUNx?=
 =?us-ascii?Q?mBgpTTnIJ9+qziR/IuYXXeSvMFZr4ctqjJ3XmbSm/glq66du6/QKn0b73Zw6?=
 =?us-ascii?Q?z++f/bobx7oZwIWB1RYtlAYTM9h5bNf71Do0o7GMbumuzL8Zr5E9z1Lg0mt+?=
 =?us-ascii?Q?7zungn+02bd2241GJI2NpOVrgJ74QEsNr1M4Q+mCy09LAkLyQaPcAPrUOqcO?=
 =?us-ascii?Q?tgurdI8+auBHoSXT7PMlCbI1da5Pw6gg3Cdd8tko+MCPeCDeckP/vZC9xLEQ?=
 =?us-ascii?Q?zFzONofSaYde+tCDrrdqg6XmDaGpR5L/aGpvlizWsrVOtz/1cGpBtOwCGWYz?=
 =?us-ascii?Q?wMmZ5IMZ/3AOv3jGVlmxAU6TSWP/1x1ljC4yEfTtGcYXFfvJ7Aw7nwiv3uZw?=
 =?us-ascii?Q?4Kac4vOW3ywxWJ+oIggEC2L9asuLarsmc5Gt/DMbUtlRPNlOK0lqxN4QD/vx?=
 =?us-ascii?Q?FqLw9KVoKaY3Mc9pjAz5Q/1bAdmFLfR2L1OjYvZzu8q1+cEC28Er1Zxkz2dU?=
 =?us-ascii?Q?TDXFZkLvcEH4MKp32BJ2Q3O0jPL9cJFNytQZkJZSZr0woEGM2rMn0CwrV3rp?=
 =?us-ascii?Q?5WTBzbtN4t4OaLDzX8HVV026BnE8s9PGsKfuKYdwG8PVRqJ5axUfvFJgisu/?=
 =?us-ascii?Q?qTaq3C9fJLEyz5XpQqRVZPI063oiL7tWeU9b/eWkTuQiJkQt08K0RNCUSXX9?=
 =?us-ascii?Q?0EgYwH5AM2YCPD9G1SA+IqlSyZCfbDe6sMNvBZ0sdV6qvwdIJZO7lHVVZ/3n?=
 =?us-ascii?Q?c6FVn7D3c7rG/YpFXhKXUf4zeGc22WqtjFwxEmTCwSQSvuL9WYs3meKsRRw+?=
 =?us-ascii?Q?rsAaW9rSv2Pzk8wjXWNU5sw5ndAMA85TDnT50gjo0m5cCfRQH+jYpQ+eHYso?=
 =?us-ascii?Q?l2SJnsDlXdkm5OLKSi305/1zne+lTPIAryMGkjB/hxjdvo3fEAlyZ1UnAaZT?=
 =?us-ascii?Q?xhDo2roTCvpyBfmQZxkicz1VOpugG/4X/+z1h9xoIDuU1iUn9o8QvVkRcNfi?=
 =?us-ascii?Q?m+fGCUINpwybkKtcvhgDykucKIvGa2cEwzTaiHzyKXMh1QB+lgTNEtxQuh+m?=
 =?us-ascii?Q?mtT6MQK/8ieLZkMg3ozJYaMWoNMMFxPj9LgMVwIwD5bwZA8H1/4vXhhmWPs1?=
 =?us-ascii?Q?XSlrI5hUhg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aecfde96-b0c2-470a-9e19-08da3d993fcc
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9186.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2022 15:22:43.8667
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OVnMkoaMWhRstyndJ0H53sOE8hawKmigwlgDbqwFzAInqGTR4EEf9d5W2QE+DopWqPnVQs2wXPzqeSNoYPcUlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5672
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
Tested-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/dma/dw-edma/dw-edma-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
index 3ce0d7600da64..fa95d1d17db21 100644
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

