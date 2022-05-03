Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59845517B81
	for <lists+dmaengine@lfdr.de>; Tue,  3 May 2022 03:10:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229533AbiECBJO (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 2 May 2022 21:09:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230118AbiECBJN (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 2 May 2022 21:09:13 -0400
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on0613.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe1f::613])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAAEB65B1;
        Mon,  2 May 2022 18:05:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jijaLr9neEMQR2vsStAphvzNeXPMbBa4CrzYEfPQEVHf2KoKVRJ3xp3WJxeSGCX56nxT4cexl/UhtAqFlUmb3baqvQMKHnjMvBweF1SDbWAoZhJfpW1H9i5/yw9Fpz0FZRqRqFZmxEgdDTjdNAT/k+KLr4ILsHrczGcHSaYBT8WvqItyWfl7nwi5JNW/prvX4pf2GmzjhC85AZwUAAojO7S82AZGEBzBxqEZRyy7go7JarcrIijbftzebWjdna/pEcU40YKpQJhIdL3Jwr7v5D3BYn3Jj8+lkhckmCVD5iaSR7iMTXtBNrZNiB13SwmH53vkqJDwU3Vyd6FLnLbghQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VuIljC2J16V74gKmqQPj8+r+bV/BDFcJCLCqq4qjU7k=;
 b=UwYQ69ZRW8M9LMTU1Sh42NFiBIGgwWsDe1ylyV9Q4rLgwl4h3ULSzQBPD5ugOQk82+gxAlCCSdKHOle12hYkPw2VAmugiNvd6+TUTrqOCMXDn0J0PhZd4+iZ/0WAAEe8t5MZLWMpkXmqSmw/Qx5dDYsdv7whIQZXsMJPXKHc9tcIj4N6zBUTvGAbi7zJ89i1oebf/3g8KDnvA5iMUkbCYTYJF41c4ry4xcO/kTChoU1QRaMRkc6rfijzjcHOxNTVoL2XSzCkTOHHSWBvsxc0kOJkkt4OgnWbFYdmesWK8nQeq1E+Nv07VUQkfXdcSoBzA9h5uJ0p8JF03GiRk/GsXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VuIljC2J16V74gKmqQPj8+r+bV/BDFcJCLCqq4qjU7k=;
 b=cTNUqh8aIolmaJISyt9sLNKTdHfSIXXOqG+qdxIz+afDeIuVlm49nK+Sim8J50BBQYjzQaj4bPeuHuE6h7krgtFgTkr0KC68f8Me0VG3KdZcP6WLUwTA/YrnF4ag68JpDbwccP3MOVOBTpzFve50VroKH0tIkJFyJrfJv/XxJh8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com (2603:10a6:102:232::18)
 by AM8PR04MB7364.eurprd04.prod.outlook.com (2603:10a6:20b:1db::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.24; Tue, 3 May
 2022 00:58:45 +0000
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::adc5:45f8:fa40:1b8a]) by PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::adc5:45f8:fa40:1b8a%7]) with mapi id 15.20.5186.021; Tue, 3 May 2022
 00:58:45 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     gustavo.pimentel@synopsys.com, hongxing.zhu@nxp.com,
        l.stach@pengutronix.de, linux-imx@nxp.com,
        linux-pci@vger.kernel.org, dmaengine@vger.kernel.org,
        fancer.lancer@gmail.com, lznuaa@gmail.com, helgaas@kernel.org
Cc:     vkoul@kernel.org, lorenzo.pieralisi@arm.com, robh@kernel.org,
        kw@linux.com, bhelgaas@google.com,
        manivannan.sadhasivam@linaro.org, Sergey.Semin@baikalelectronics.ru
Subject: [PATCH v10 6/9] dmaengine: dw-edma: Fix eDMA Rd/Wr-channels and DMA-direction semantics
Date:   Mon,  2 May 2022 19:57:58 -0500
Message-Id: <20220503005801.1714345-7-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220503005801.1714345-1-Frank.Li@nxp.com>
References: <20220503005801.1714345-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0P220CA0024.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::32) To PAXPR04MB9186.eurprd04.prod.outlook.com
 (2603:10a6:102:232::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 08e2e681-5b21-45fe-a7f7-08da2ca01304
X-MS-TrafficTypeDiagnostic: AM8PR04MB7364:EE_
X-Microsoft-Antispam-PRVS: <AM8PR04MB73648FB61654277D8F90969388C09@AM8PR04MB7364.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: v8f6kK83aTGcbr9kFJeBGJ+rKLtfiJru5a8K89ayUW8obYrS0aAMnUYmocWYeQHQN/Xt4G01w7tWxjEmTFadyW/W9CDLM3U9NjQXg15At/6RUSAtIYiDGWC4w+3rUtRmgloX5rRXmeY1Ry1DBKiGerxxpm6JGghyM/4iGj7vgrbw8UWr//bAUpOV+AtIHxcz2iC4ECqjUcoRm10JvP7wzA/I8ayDVbKpqeRg5fxZe3uvOYz+UNaIlIgYS0Ef89PX4EX5JHiYrgQ9wVaDsOqYweaTj85wfZ2vsMfgbCQ3wUwWyAiIQB7u5ub4YW6+6rXpWZWGV2e9ItPTEwNvM8Y0hHLsHqy0LA+AEG1EGJBt+P6vxmDqNJ3+Eq7y8vV+zCb6p1kiEsrEFgc1fgDFmZ48NlO8yQdVW9lX2KWdEcjs0wwCA3WOcrzMUBIJJpYo9Zji+NFsQ1IYfYJtyaIQcVRCI+PF2ayq5iMMKhd4edgtscTy909Gv9EqcixUfBhBSOHGC08qTZZtyWsAX3C/sQS+MzvtbQw31NUScmWC/Z6VUxJ/uFteI/ytYMznIYXCMveIKDOhwsuR45Z41gz6JSTvYSaL0fsJAMFIxSby7Kpw3l8LIcsLvZ51KOzfLrHFGHhzYSMjMHPNEAZiIDl78K7mZoLf8LDhMzcsRBRstG+mOpmBjcLL0BUsqdD2E3eMCqlLh5AjWOur7X5MvXCN1Hd9Jw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9186.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(8676002)(66556008)(66946007)(4326008)(2906002)(36756003)(66476007)(6512007)(6666004)(316002)(6506007)(26005)(83380400001)(1076003)(86362001)(186003)(38100700002)(7416002)(8936002)(38350700002)(508600001)(5660300002)(2616005)(52116002)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qj47IjhGk701Y7HQW4Erqefg+bqy7rvfuzCeLFSN+RC1iKlQjqtjIz03hSPK?=
 =?us-ascii?Q?XjqMNUd9mCeoQO/FBc1Amj4YRMctbTI4yBuwp+66crtr1+q3yYbPzm0aPFF9?=
 =?us-ascii?Q?IF5cfQUScI/cvuBjibY0/GvNqLTtzebkRea8O6O9t5kjmq6C4PZ5TMUIw+ak?=
 =?us-ascii?Q?EZc0//OogzSjVg6T8iZThMnWE11SnGFEkuGYrC0NbY62STop4FARJno2AZ/u?=
 =?us-ascii?Q?U+v8a+izeG9JbZsYw2TKjbai2kGfbEDGaRWZp0UnYhypPkRd34WtR742vN4L?=
 =?us-ascii?Q?y3cnBX/tV6PjPqbMxMGQqlH6+vG8YRhVaGWmYHlbcs+Gv9od9TW153ArzvZa?=
 =?us-ascii?Q?riR9ozE5zSnSc4fNWmWi2p3cdsqRCe+TMWuRUPDAVn+leBOX1T3P2EjPZ2l4?=
 =?us-ascii?Q?4DAiq8aKrdDUnigyoqLCoSFetbyYsgue/bRKtwpuw2+QvD0fIW2WnN1gfDob?=
 =?us-ascii?Q?OgcULzOdoesUbGei1aB1xPZEfA346pY02j/SfU4q//DlQ4HTxD0fMAEaE9Hn?=
 =?us-ascii?Q?Www+NUmM7B7HpxeJytbE85DEQu4UcjEY+5OOj6yrZKA3yij3P5XTJlILMEX0?=
 =?us-ascii?Q?2PM62UDf9ewMlkYxhieMbDIjtoiZxyOXnOTqGQZdVpXiDmsHx6geFGqIKUis?=
 =?us-ascii?Q?12gEswXoJDw2YhSg2qOw5mH+qg+m0Jp0XammJ1Ow8iEuwXxWHOupc4FkoFmc?=
 =?us-ascii?Q?/ldJNpV78YmpxiJv3H1+KzQTSWKKmWE9YAfFUx4k50HsGRa/6JP7PdCdv1Sj?=
 =?us-ascii?Q?FvRwyOXJN2COftAWYCG7RgsevtPDnvEE4cA/0wDN7+KMmLPTC2SjKH21qaL+?=
 =?us-ascii?Q?GUhRtPk7DqsLBy9QGStiNLnWabZGb2JJBvSylqp9niRNhwfRzG8YUSJwm2FP?=
 =?us-ascii?Q?V6DBtqR0En2Xjl+0Zq1JAwagEYtw4I35d53BSdKcmsXgUTykVXFohLyC3MOE?=
 =?us-ascii?Q?157+LWnB/4VqBj12SzXcR5WoAzEmKmHeV5LuM5rnhC6OADXfrhl6y98biVUi?=
 =?us-ascii?Q?4H87yYHOCX3TBylP4yNVFDOnAxAyA/7RkvC2A2vYUjj7gjZHGx+XO461rEMD?=
 =?us-ascii?Q?hhI7PNX/rRTqyQnrsQctfWVRMR4gohD2zqf3HEIh9KJCXIluRiVumIdjrAt5?=
 =?us-ascii?Q?m6k2IweKZzjSc4v94eOqCmOnT/fENaXjTuing75rUrQX9A4cCgGM717nCKSi?=
 =?us-ascii?Q?l36YsIOnqljXW0qdq+R1GRz/PnMdNMUF66WWPDpMItgErQP+SfPKEq6CNpQO?=
 =?us-ascii?Q?qlWojK/obEJhtwgp6c2Izl8mKRvbrpvFRfx8FC5SA9wi5oO34YS79dQ+oRzS?=
 =?us-ascii?Q?Zc78fyMIHo+Qyhi+pi/+iFt8KoT/7l8AFeisbcOxTmy4qL32mh4ftUSJOol3?=
 =?us-ascii?Q?eX0woIVvaIJLoFtlMC9kL5f5h/7BieMRuVW1QbX1unPeGjEJ3W3d4GBkKuBS?=
 =?us-ascii?Q?ccxChpVAuH+OcctGiZUdRzkQq8WkhCj9qo+neNfl7fjSVMpPs0In1RpdNCUK?=
 =?us-ascii?Q?tgbLMF5/1EnvHs1qvbItKFZ+vN2Zkq9B6obk5WECsMLxz9XO4hsqUy3kSTDU?=
 =?us-ascii?Q?uGwpi3if3E0wqmozYhwilaIBmMAqEj93kC454eOuN3POox7COvakqJoVw4c6?=
 =?us-ascii?Q?tx5C0BR5clX2LqfOaKhj6twCnWpL7aQwMiXEyBt774PTMDw2q0teQOLOIg9B?=
 =?us-ascii?Q?iYT4A/aJujnWOVAty2ZMreMv8EzlaqVKwKvqSVc1UmBDw0/sc0lFlBVJzPJj?=
 =?us-ascii?Q?IQUJJvprnA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08e2e681-5b21-45fe-a7f7-08da2ca01304
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9186.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2022 00:58:45.3228
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BtkfHYus22rBYcqTLBoAPaNjRrrJaDeN+OEv/fxAEn+T2WO3f2KU9pmm0IqqC42UcUqBbKmiYPpP21rG2dGe0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7364
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,SPF_HELO_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR autolearn=no autolearn_force=no
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

