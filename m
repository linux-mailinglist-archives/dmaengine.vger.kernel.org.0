Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C85752A601
	for <lists+dmaengine@lfdr.de>; Tue, 17 May 2022 17:20:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349846AbiEQPUO (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 17 May 2022 11:20:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349863AbiEQPUI (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 17 May 2022 11:20:08 -0400
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-eopbgr150088.outbound.protection.outlook.com [40.107.15.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 851774AE27;
        Tue, 17 May 2022 08:20:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=auU2IzC//vK/gR9VtFyVP6M+FK9+G67wq0BYXtd05+q/DmkxsW9C2bXeZf7gOkMoJHOIWRaqeGpW+9HEdCKYtRTH7Tt9Bncn1J+3O3gkvVlWp9CMmoALZ9Kv4+KbAYs8fLnRx1XigzxqzAkmK6LhVI812hYSz2qDvn3BgIvtvYTfSAJ+ymbH/3Yp0aS3Iez5DmQ7jMljjcagm9v/3lZUfBJ8pMvKx30omIINMEdfCxrk5On1a6rnAPUTiLPYts1uq1XDqTvCV24m5davwsg+wrLiqk3XLUVsyL+NBWyPFt68li26ATRTw6piNDml8vt2Qy9kVIgIGwwLstJuzDiUzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8xiesIl3VQKcbMSIZFTlAHHkBLiMP3OMyWwMoX4eAW4=;
 b=hwJh/4o/HetDaMvbuB0qA/6cXOLLH4//czkRgQBrgif86/GHTQWMgxcSXJqcnMVAp2NvY6X5nLCKzWte9+u9hZdx4ptWnJBpMnt60rUOV/WMVpV3Kq7Ls9+QHYsfK4b1YwKofkqhKAIpvxBYA89emnY7iU2dAGDxpHdGBP6TgHbEMseEarY7o0dQJI7hzGqKTaogg/zDoeMjc9vVkn1t+g270Hd7SRJDEDNVr3V443x4Kt0/tCbDGgy7vzOH6O/pECqsKdof1xsPwMFnmmfB/JAeK1UjCchbrzeZnjIliRs3urGo4rQOsDCy+edu8pkkXKMxuc/4H6Bub6FZtMI1Sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8xiesIl3VQKcbMSIZFTlAHHkBLiMP3OMyWwMoX4eAW4=;
 b=Wx/HQfD1Nu6GC+qXIC+8nmH3tUUKVXib6rO+ayhCOjWjx5rdiLBHEJWKTQaCkOSj6mbsxH0gbg/OdwG7UfMMe3XZdYH2th2dxaoVUT2XsW59eD4bGjkXeJR6VjiociEt82wP7lcuC4a2wNxhO6b4NSDuhdAGC9wbpczYgYZ57t0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com (2603:10a6:102:232::18)
 by VI1PR0401MB2285.eurprd04.prod.outlook.com (2603:10a6:800:2a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.18; Tue, 17 May
 2022 15:20:04 +0000
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::adc5:45f8:fa40:1b8a]) by PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::adc5:45f8:fa40:1b8a%7]) with mapi id 15.20.5186.021; Tue, 17 May 2022
 15:20:04 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     gustavo.pimentel@synopsys.com, hongxing.zhu@nxp.com,
        l.stach@pengutronix.de, linux-imx@nxp.com,
        linux-pci@vger.kernel.org, dmaengine@vger.kernel.org,
        fancer.lancer@gmail.com, lznuaa@gmail.com, helgaas@kernel.org,
        kishon@ti.com
Cc:     vkoul@kernel.org, lorenzo.pieralisi@arm.com, robh@kernel.org,
        kw@linux.com, bhelgaas@google.com,
        manivannan.sadhasivam@linaro.org, Sergey.Semin@baikalelectronics.ru
Subject: [PATCH v11 6/8] dmaengine: dw-edma: Fix eDMA Rd/Wr-channels and DMA-direction semantics
Date:   Tue, 17 May 2022 10:19:13 -0500
Message-Id: <20220517151915.2212838-7-Frank.Li@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 6354484c-2bc7-4e5f-6094-08da3818b80c
X-MS-TrafficTypeDiagnostic: VI1PR0401MB2285:EE_
X-Microsoft-Antispam-PRVS: <VI1PR0401MB22857D6F6DBB5E16E323A72B88CE9@VI1PR0401MB2285.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DsAcX2+N7BTqYowwEaY+a0GPQsXXcUPfzDQmX56loQCGDg1JJ4Z9qOAYteiwqrIjhszvBFgDq071snWwfhnj2F176IRMEX9OC9FeqkX6UjjWUMCqpIJHDteSA01uioEY2gZDyGEx0ZiY/StMS2PcKuNrKu8OrkKOyt56qUox/SWeM8sgCH8UP2OO2JOeE4a8In4fKuwTeHBz1DKlWkjCoTfqBvgLr1ZuyKcNGnNPl5nPZgXDTFGpAbsZPlEW3Tch9t0mdAJP6/zzjGe4eONXj/XJhqb/IyHEZOsZT9vqc9XcbtDVWYYu2A8CMV/FKFFt8N+OmtGV46v2rElM+1rRn9ZEJdp2T1S9bnVTOKSbK5r0UAV9c0vFJqqTnKOZTK358SepqagX8irjdJF8FyWXgF0oWOYOqDeS8z0EZmO4t4rUKDIdptvmBnQgxHZUsE7/juDeBoHHKKOpd4Iuu0wUDZvFWJ3AzThBUlb4VOa3yWxWY/LXnzQDUG1DfH6erG9viyKDr/IWkWgnfeDm+Oa84RMRR4vBplbYASui9Xq8l5ydfhl6swHVjqRTL8nZBiF7QnmwULDIHVyfq5IYIOmjL4dI/IrH1iBsUh83l9g6sdESMgbUn5s5qZHKrnZAiIXirAUHcWIR/0g89/b40J26EqzHuVUKbNBUbSMwRq1PZobSkLXtY/dxKBTXtuoCuxmR5uFh+nUrc4pKmxEgxn+cpdzVp1acFQiQvDLpfB1IRgE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9186.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66946007)(6666004)(52116002)(8676002)(6506007)(66556008)(86362001)(36756003)(6486002)(316002)(508600001)(38350700002)(38100700002)(2616005)(1076003)(186003)(921005)(83380400001)(8936002)(2906002)(6512007)(66476007)(26005)(5660300002)(4326008)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Tyj9mYbukf9BE4k4r+AoVoa5Bpek+HEp3NVSETL5EI/jc7PIVhbX1++k31Xd?=
 =?us-ascii?Q?zq6EuWEBTT2Ze/jZZa9Ogn2oynzobD/XmTdH3wTx97GFNadTkEF8UZRCIy3g?=
 =?us-ascii?Q?Yt4I+buKnzbxvADDohophiGsLjyZxDFVYvsee8x1gRXzJI6CLTTPIoII8Xyp?=
 =?us-ascii?Q?efrG9+1RiS7yXt1m1WprTToT0GyEnUP3mvbcf4qiex9Q0MUAx19+ikCzWzfc?=
 =?us-ascii?Q?bVv1hdzSZD+WS2LO6Jtfu3mJjzXpTMjwu+taR4RytTk29BhYgdynu2QjFI3D?=
 =?us-ascii?Q?RhNRmLlxYTce2IBLlVWdSUzvAtRMfQxNe0W/GzVb2AEYSYtdaULLHCTFuf8M?=
 =?us-ascii?Q?h25EcGaQtQMha5AiiksHL33EHZjfwRvFLQUiVT//dGxY+IPenPB7cRnPlFX/?=
 =?us-ascii?Q?K4sysEmmtFV2BpTS2C4lUjFGfKcc5/E8zrRz/9Jo6QZYEsXSx+QUN2AjWGzB?=
 =?us-ascii?Q?dH5NaZmL0tMYJ9Dk1uuwGc02Jb7C7ROJr+hR7bcnSRE903/fcSD1I1NE24XW?=
 =?us-ascii?Q?9QjIC6sX2xCgSaXogk2OHFdJlo23f0kz+o7LtL5X+8o3w1Ux4w8iyFPFAPvE?=
 =?us-ascii?Q?LwhCsqTOmeimCJRg7ow1IqohfBmycRE65W0eVwp7ejHI8Lxu4tul3H9c8oYV?=
 =?us-ascii?Q?r0YwzyR2G0QArndbq/XoFXnDavXMPfc4GJA+edUfEmvShYgBY8VtxLgsaOkH?=
 =?us-ascii?Q?KX6ov3tC7SvEYw7MBo0achsZf+zBBfZD59wydPtLCjZDnhG7XDMSJG5WiNPE?=
 =?us-ascii?Q?hJY1Dioar2afBIJ3/9AiRO9n82mjvrGEXj3x4apr6n/pdC+yW6UWVnKh4cr4?=
 =?us-ascii?Q?9llkn0x56wBPUftJ7qWoOj2uhb3AdjdPYCf0ATXAiQvrlcFFrROZwx2OrJA8?=
 =?us-ascii?Q?IcCruwBYlCmPKPUX5WpvNzDoUuxiL1VH2svJDPAXQffCZ7fUC+QiLCsVpmYa?=
 =?us-ascii?Q?+jSRKInAi4+yywjW/CGUQa3ZxCL+wf08jZk0EIHsOqLacJrr834wyWSFS11F?=
 =?us-ascii?Q?pTRFr5Oh3djgbo55itRuXkiNEKNGwmkBcnU5GcJt2JMsI4St2v8zJ8W+gt42?=
 =?us-ascii?Q?S6PBvf+AP3D/nKJKe9cDSeb2aXtXkhK6hd+8KmNYCzZjB3NYccPRnfPR2VcD?=
 =?us-ascii?Q?6HAfq3AOROV3MdIwcpd91rYLlhKQqxrYdgSHXmRCyWOf+aSx4TaukXbLdiFV?=
 =?us-ascii?Q?YALAECMFdAsYznQFd6X6cogAWpuM/7ozEliDl0/N9Bjpzp8VAW4mjFkpHNtq?=
 =?us-ascii?Q?QxwZTxEBtZeLGQo8bdZux59lqriyzK1SbLw3UzyEsIGk90ihpqYWhqcg250A?=
 =?us-ascii?Q?HJQzM3Z4DmxaSStoLJHk4ovhft72wKLSsfmWe1dRjgIheTIahh/1Nazy5ipP?=
 =?us-ascii?Q?XzyPAxgYqwWSYAaUuX9sjQxPy8D5z9HUXgCbc9xytZc+BmR9N2X8xyhsgSY8?=
 =?us-ascii?Q?9Cb9w87gTPSFFKvX+edVX8hRqMNktzomhHrAw4Jq5uiFSRlmWqYw8IqrGOhI?=
 =?us-ascii?Q?l5ymRPsDYlJYo4O3YdeYn1ri5TyMvlMkC1/f2LOUrts+44rL0aZrWP8zUHt2?=
 =?us-ascii?Q?spm+Y3ojJnAXVgNfuzxhqd/GUscHQbdwmeFQAj3aU53KkdjMQ5v+ZzEIiuxP?=
 =?us-ascii?Q?atEaEe3ABjveN7OdP6BJjJ+JvWJq8obJyVAN2RTyDT6LBd9+TU7f7ynSSEOD?=
 =?us-ascii?Q?KLqDJbV5BCyvbDNFepBYTfMwcEkCehKxWqs5v/l185LHOrz1+0LLO5SANivL?=
 =?us-ascii?Q?aNclzHMsSg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6354484c-2bc7-4e5f-6094-08da3818b80c
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9186.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2022 15:20:04.6410
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qqj/JdkI7EoWELo4qIy39ab53xfdaegKHd31M7CsG1/uBUJF3A7X5LOa3xnMm4XtYPDtdYPGSUn9Vetzn0F2aw==
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

