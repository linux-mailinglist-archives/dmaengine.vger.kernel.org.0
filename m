Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AF5B50BA3A
	for <lists+dmaengine@lfdr.de>; Fri, 22 Apr 2022 16:37:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1448747AbiDVOkT (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 22 Apr 2022 10:40:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1448748AbiDVOkP (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 22 Apr 2022 10:40:15 -0400
Received: from EUR02-VE1-obe.outbound.protection.outlook.com (mail-eopbgr20045.outbound.protection.outlook.com [40.107.2.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24AEC5BD38;
        Fri, 22 Apr 2022 07:37:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gEe8E9icCk6ENBa0FnoJubHqMsW3OCNESrYvQBkxyCyTarBnThIXlGs4Db00FrCpCxbWSwITV+RJQwkZwFpVe9PclkqpxUrk2cbHpy7VhAjNaJBhJJHTnKk2zHT+EWl1KVUV7y1K67V4oDSR4D3BdJghX3FOIcu6OeWvVu0Gt/a7MmJy6sVzLbkQIAHtzIKYxD9PQhlBlzQPvfsHyp+5dPA0MpM+EoQEJ0Y1NpJIdyK2lBjKljUJ6Jui+4kVyagzzBgu+AntAg93/rXZfG2yG9NwQSTH77BVrXLxEr/6BHZMJ7gT6ToaBCoMfkoJ92gUcXzYJMXSzSbQvLV+G6vM5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iDLR4RrzcSMDkGIvXMGWpsgkncN1pWQgo5kbq3jU6wU=;
 b=Tz4pgxzCrc+cArmUfFtqSnBzTLZ2fU+hNU35ICiLNFraB9Qo9n3f/eSPPB3VD+Jcpr9fi7A9MFX+Mdxy7nXxHvl2X9kxzz9xOjRZQBRKZN1zZZDOFB06i0ASVcdfCjbid1c79b8POvx7c6uoe+fq9Qsj8TMZNhBSmC6xfnaAGMRbLRIYSTm7oIw3HaLVjHoqd7dhAwgpR6HPWjria+fImCLldwaDnvvCziIrUZ/vSOV9ECKEDzGcV0iSusk7P5dWQxyN5U+kuhOvjSS7XBUVy0JvBt4VAZnNz9yz+KYPUOTGR5fNNgT2SfYn2yvsbZuToT32glTRo0nDzsqWWAy/0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iDLR4RrzcSMDkGIvXMGWpsgkncN1pWQgo5kbq3jU6wU=;
 b=c6s26t3wAIwSMXTOCWc4GQk6/ldUQ8UBanpjmu9w91eVSLzV0KixpEXNxgyqMOal4zy21lsZvdE4qoB0MO2rM8vLPVIpVC21pHWuYNhP+5YVGYByP8krSPeuVL5yNnt/CBXn6TzSWDwUeTjxMbUxP23TdCB3/Jm2OhJxCQiWqVA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com (2603:10a6:102:232::18)
 by AM5PR0401MB2644.eurprd04.prod.outlook.com (2603:10a6:203:38::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Fri, 22 Apr
 2022 14:37:18 +0000
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::adc5:45f8:fa40:1b8a]) by PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::adc5:45f8:fa40:1b8a%7]) with mapi id 15.20.5186.014; Fri, 22 Apr 2022
 14:37:18 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     gustavo.pimentel@synopsys.com, hongxing.zhu@nxp.com,
        l.stach@pengutronix.de, linux-imx@nxp.com,
        linux-pci@vger.kernel.org, dmaengine@vger.kernel.org,
        fancer.lancer@gmail.com, lznuaa@gmail.com, helgaas@kernel.org
Cc:     vkoul@kernel.org, lorenzo.pieralisi@arm.com, robh@kernel.org,
        kw@linux.com, bhelgaas@google.com,
        manivannan.sadhasivam@linaro.org, Sergey.Semin@baikalelectronics.ru
Subject: [PATCH v9 6/9] dmaengine: dw-edma: Fix eDMA Rd/Wr-channels and DMA-direction semantics
Date:   Fri, 22 Apr 2022 09:36:40 -0500
Message-Id: <20220422143643.727871-7-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220422143643.727871-1-Frank.Li@nxp.com>
References: <20220422143643.727871-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SN7PR04CA0063.namprd04.prod.outlook.com
 (2603:10b6:806:121::8) To PAXPR04MB9186.eurprd04.prod.outlook.com
 (2603:10a6:102:232::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ac865861-6137-4b53-295e-08da246d9a34
X-MS-TrafficTypeDiagnostic: AM5PR0401MB2644:EE_
X-Microsoft-Antispam-PRVS: <AM5PR0401MB26441F248C9A64FAC78103B488F79@AM5PR0401MB2644.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GQeoqKsjLUwa7ufwNWIjBM53wJN7A+fElC3rWpq5yLu0EdSYu0TtBWlN2GUO8nCGpDyNviAfGXGsax6ns5yxiXJ8/phm5DZWkWr18z2nSgPFt5mKEPV8g+ahXxfN4Em9Zdm2JH8f/bX9RRntXypGIsuq0A/HUbSb16Ht24NlRzkbumO7jgKY5h92cMJbHixlkKfDin9HomBZEyfHdgONaGH4gbJuw20AtlI9Kd7nNl2Vgh8xJG/MCmG+AQLRjXzU667b4gzf5J7pydjSdlT9WKOXx7O1e2AXLEBIzHKO/2ueXWvmI68t/0EpxiZMyn5FFVgFrRAUJI9P0pY+QWP3idKKju2eurZp+sbvbZ477VrrW4KB54hWkwUI20mzPyPRN22z0LeNFJ6KvSm8jrfmwYVbvZhoetAqX61/ueOPbqb8kiCZPuz+kla+zHqgVpS5fr3YudH/z9yaE74oiKBJ0DJImkruYYKTUqA1FFZRFslKLtrREpMRsmR3bRvBOmMZVXIAH3xUHOveLqqRAWAL9e3xGX+CtAHvWAI31s4VEZ/m6v2AygjgrDvFHgNtNu6bK9wt2gM5YY5gjWU5xQ0lpOsNe0u556tBZBhxYXlBMmV+qfGfDvn7e3TevcuhuqN9l/N8zP1pmPxTWI2L80TL7i5M3dfAsBWfq6u5fQv3Yrf1FXKGqw01B/DKODIxMKoh1/eS90NNDsFFGoMJyaiNWA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9186.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(8936002)(316002)(4326008)(6666004)(66946007)(83380400001)(508600001)(5660300002)(6506007)(86362001)(38350700002)(6512007)(36756003)(52116002)(26005)(38100700002)(2616005)(6486002)(66556008)(7416002)(8676002)(66476007)(2906002)(1076003)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?173uF+vG35mbVCmKgeBnRzK7lSyww2GcJsDHizC2r3ch+ZpPGny7r5Gshwwh?=
 =?us-ascii?Q?QCCiMfkOmoXFQYm2HiBmWm6fqBhp0g+qzTHZqo0v+S2VJjr7JPt6C7yGmYXg?=
 =?us-ascii?Q?lfvnWQq+H4M1onmavF+TDu28qZTkxhcvNQG5Yr4KE0aCdNXZgZ7Kmq5kDV2I?=
 =?us-ascii?Q?wWNkljMGYY1a/Z+cIGVZbRCBc6kk7gRzVfe08jlTrcTNwLBW9HvLqNxAVgkM?=
 =?us-ascii?Q?ZieC1eA20RnrTWnZnOLWj0ko7UgX+3KRccK6lPiThYJ4AVj8FyB2Z8fZ+F1R?=
 =?us-ascii?Q?JoB8z3qGO7z2LyOAVAFbb/LK2VG/EB2LG6ZvP2GiNHUgYoVjgKGhoLE8iVR/?=
 =?us-ascii?Q?z4fxHHdNbZXlyn7fm8be7Nr6CmZJJwZA5T+kMg0HO0btkVWdb3mpT6wWy24X?=
 =?us-ascii?Q?jhrE4Kp0s8C+2/4uNgrJmdoReu7twe+pNTiuRSSE+6zEiHFUPLemN6kAzZbu?=
 =?us-ascii?Q?TbmN0x/glLredaor7kPFnRY7JWZ+fiQWgVIP0mpYlsvYLwW7Ykq7V+BrNuzO?=
 =?us-ascii?Q?jFP60QwgQ1e57FTzPeNUgYYqMSMDAkkAGWoDCNUjkxFVkexId19qcmSXZkR+?=
 =?us-ascii?Q?xjY5pI/1di9yypMNS9q4u1vLh/BwUEoqrC56nbPzUoIYfd5TrVD47Jp3ekYY?=
 =?us-ascii?Q?91NG7YeDuG8STYrYaoNrIp7XiSjpHxnPe3rJuYmq9/goiEUIzyP3KMXWcO+O?=
 =?us-ascii?Q?NPTnpZC+c74D9w9AHS/x8Ml2yEQASBVEBUzXEl5YzBhiErabGr+6j4k95pev?=
 =?us-ascii?Q?mOYnAQCNQLOG8P42LAOYVOddx26ZYUknQvMH/KrET2O2i4mZ8UikYt186+kN?=
 =?us-ascii?Q?3IGk20CoVe7VxrG0tTSXLnJNzwgBvdUfiYEnOAnrPYeSEOGxg8vsYZeUClkO?=
 =?us-ascii?Q?KPDzPA8GnpiBJmAZV0duXalzdkf2V4spGDCyszzLGhmBgV271lfoyEvamFT8?=
 =?us-ascii?Q?ZAi3Io41PBDj+jRwSx7Urc4oI3qRQZDhiGhV7HUcYbhd0EVixLBsopTRl/6I?=
 =?us-ascii?Q?YxNSxHLfepy1VWhAMxU12Rtd33n3PDuWGjL7frLj4qJ+ivfaUcwYUOu7qEy/?=
 =?us-ascii?Q?nNV6oWLoH/VXK5Ktb/HZpIemx9kseXT+aYtnAPneKc6GvOlOxqBpKUMOcF6c?=
 =?us-ascii?Q?z8MG7dVpHfEbk8bzY+0xBtYolL0PddhWBxxG4aeZ+1uaAOuSCLq7mCvk9SSF?=
 =?us-ascii?Q?q4sRKuCasiPzHPo1tfrE2WhC2kBg6DduWkcT9/c54Wc3Skqo9c0ww7bpjhdQ?=
 =?us-ascii?Q?0seNf95T5/BR0rjq4aD9ESBzBix984OYOjPzDrdTnRcb1RZBrAHX0BayxvUz?=
 =?us-ascii?Q?xMou76UZ9tZJucktIIm4wwOiA9DypXyfgKOx9mJk7xbjyafxtutUHN+D7qV1?=
 =?us-ascii?Q?tZFlrDREMrhzZZeJkpgJrVqzYhf68wIk25fuE+sJWtV1RUd5a0giuUJKJxGk?=
 =?us-ascii?Q?JTAGfrMJPmAiGke6i0o3/OIIX6A5o+/99oY1/aTzMFopjfI7prztLKS4ujl2?=
 =?us-ascii?Q?xSdR7Bx3+cfAyx5z4jjoUPB8Z0+qQhnqzoHicwkof8XDCToRpW7zlH4wRnOy?=
 =?us-ascii?Q?MG1/XFrvpmkREtCYahhUu/lE7ttEvsvyMAzQvlDi4Gjz8IDPpj4LsyZskzJL?=
 =?us-ascii?Q?376naisLMHHKuBXuwyWfeNlgVCmb1bn3RNKHkbdoiOaL+fLB73h29suqvZrV?=
 =?us-ascii?Q?zMfNfMICjoPgrI+7tIUEmOc1BwuyHrRQfu6Qkvf7vNj/c14X+6/6PWMeKGlL?=
 =?us-ascii?Q?URx5mz0jxw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac865861-6137-4b53-295e-08da246d9a34
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9186.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2022 14:37:18.4428
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xAcXdx3kKEyp3U+Z6+ECLWiW7F7MR+EhP1mqxRjdxX/OtJGs7nrb4LXl7LwpeY8v3C2oh7ug3O/hUrtuweHtWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0401MB2644
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

