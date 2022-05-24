Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EBCA532D5F
	for <lists+dmaengine@lfdr.de>; Tue, 24 May 2022 17:24:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237891AbiEXPXX (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 24 May 2022 11:23:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238942AbiEXPXD (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 24 May 2022 11:23:03 -0400
Received: from EUR02-HE1-obe.outbound.protection.outlook.com (mail-eopbgr10048.outbound.protection.outlook.com [40.107.1.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31E419D4FD;
        Tue, 24 May 2022 08:22:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VVVhRuG9OnVr1mKyDFNi1Vs9zqlffmlTenjTNb8lQtNr0HMt+4h3tScOQVzeeTiW/TOSoqmcZ+2nIkTXz86tAZ64+/MxTEuRkNK99JvjvwqcVIHrjw7s/QO0v+UjpQS+MRuoyHtyjIOpASqIvF61CmZBlt3YprG8QOhnnBngzqbM6ZCNxoEk/kLGBF7KBaH8+66cr5hWt5hyDxrq436b0pFdYkBRzfxWjyqYVTzujjR3KtjvTEo480TaSuv0SQ/6Dp2kkFe6E8nFIopA0vBC1aQ45anmpDITarjYcMBzgmqOFqM1/YA1T986tIR/u/u54t2f48dDuTQid6WOysaAew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m6PYFWLjdxdEGOKFifXzCyQb8b2XDlH4k/Z9xT9L3lA=;
 b=LQiFZq5UJ1KGNzS/EYI5TPnRv5qoCDdW3c3PZweCZlAmC5iSWN8E0y0EVb+gUrFzbgg62V+OG/qqTgFGgMxiSOXPrM61o0GyKdUr8pdSsi5OfSiodDi37gMxTS3BMXupBEnxElrSd9VgboztBppp/vNlmlgZh5b2j3aszY/nDxssNykXoqJIdjOxFBBiLrV4h0BJEb6vQ4X3QAXIWrW5k4Hyx+0oVyKb7JFAqSD4/sdCom/4CtrR91Zev4YaZHghSnY19yoINTcm0e/qk52ufWaBTzRWB6p3791P425+iGjswZxTIoqPrQhvZUlbnxdCeE5qpQJ1VlbndQuKLEAOlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m6PYFWLjdxdEGOKFifXzCyQb8b2XDlH4k/Z9xT9L3lA=;
 b=PsjHM14ijMA05NmTPOA00lu5OY67kosGA7fMEbZyzGwXBrt7uNbU9sT2WjhY02JJfTuwJFojBFdgHlj0t17DESn23AebRVptWyvZb3zwcWcVx9QOweBt2DFZ34RelYVF5bIIDHhVg0RJtGfjfWi+lmgY9Di8KeDJYpYDi4uf40A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com (2603:10a6:102:232::18)
 by PA4PR04MB7536.eurprd04.prod.outlook.com (2603:10a6:102:e1::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.22; Tue, 24 May
 2022 15:22:39 +0000
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::e0bf:616e:3fa0:e4ea]) by PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::e0bf:616e:3fa0:e4ea%5]) with mapi id 15.20.5273.022; Tue, 24 May 2022
 15:22:39 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     gustavo.pimentel@synopsys.com, hongxing.zhu@nxp.com,
        l.stach@pengutronix.de, linux-imx@nxp.com,
        linux-pci@vger.kernel.org, dmaengine@vger.kernel.org,
        fancer.lancer@gmail.com, lznuaa@gmail.com, helgaas@kernel.org,
        kishon@ti.com
Cc:     vkoul@kernel.org, lorenzo.pieralisi@arm.com, robh@kernel.org,
        kw@linux.com, bhelgaas@google.com,
        manivannan.sadhasivam@linaro.org, Sergey.Semin@baikalelectronics.ru
Subject: [PATCH v12 5/8] dmaengine: dw-edma: Drop dma_slave_config.direction field usage
Date:   Tue, 24 May 2022 10:21:56 -0500
Message-Id: <20220524152159.2370739-6-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220524152159.2370739-1-Frank.Li@nxp.com>
References: <20220524152159.2370739-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR01CA0004.prod.exchangelabs.com (2603:10b6:a02:80::17)
 To PAXPR04MB9186.eurprd04.prod.outlook.com (2603:10a6:102:232::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c3a9ef8c-6535-43e0-4ad3-08da3d993d52
X-MS-TrafficTypeDiagnostic: PA4PR04MB7536:EE_
X-Microsoft-Antispam-PRVS: <PA4PR04MB753639940AB49508FA91A0B288D79@PA4PR04MB7536.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +ZB8RJEDdy0dveltJxAQ5QkKhNQCwjBWyzOAaNXs6nLXNRV7Qr+jeVzuxrXyaBBj7vaRLx82OHXw1cvKOvNY3touJ5KLfPjavADEpN/EJu3LKzVIykGiFgrVEgOH0d5XXF5by9lmSTNeOWnZNkx/IDnvmBMifpu01Oj5it9v37OalHJ/SEhvlCEajXlMT8RKpr7RsjFMH2lpCN8jVJeFa4x2Fh2VDTxbBp7ctd9ZuXXFmQo3XJuThaR8KuPSGQjWMSrEwOzImMkKJeCUW7BLTWbTmv9F5C8mhtA0VTCJoOjpk+rJ76Z4zIZRtdvl9z+/lJB25LIqysU9mCHQ2SkaMQP/OnrjIsThHybFPDM7qamKXriOO5pWkD/G6x5NNr/7oTqO0xg4e0MPdpfubwxbIaDt48iV6TfUsFTg0hhARyMrWQiYkbcRAlrjAkhMJ2heaQz9mt/XHXCy5NhuDjDK/B2Bwoqnz1H4/NtKvjLMnZupk4aHdT1zIgZIJvxgmMtbmh9FsiXqf1FcPf1oAHBBu8IAcHfPa21bXkrdHO/u/H7I/LmqlX83vl8UZEMY5GiJ+a0acPXeVeT55zly1PqzWVOhjKvUf/UIZm5opFsm7gytHGFK4WzAc2fRVcDX9Vm3HFNaBsAcSZJZPHg5+MRzlx0aV4Hz40+Pq3zTJ94X3TTUWKiU9By/toJ0Zs7oRlo0puM6tPX5iKDVIg8GZt3zwrHf8QpUe2HS2xd4XyEgx4U=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9186.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66556008)(2906002)(26005)(6512007)(1076003)(921005)(66476007)(508600001)(316002)(2616005)(186003)(66946007)(6506007)(7416002)(36756003)(8936002)(5660300002)(52116002)(6486002)(86362001)(38100700002)(4326008)(38350700002)(8676002)(6666004)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2CUIGeuLVH5LamAM7cOloG804XF6m11EHORNEZZxq//ejaL+Xln1y6U1k/JL?=
 =?us-ascii?Q?iGTr970s0R5lXXAhoqlWz+Y7OkfOJtEv3oqIbPDtcQGW2zRVMQd81HP3X5JI?=
 =?us-ascii?Q?dGiVJBdiRUnVUpHya5HSrx1X/EKihBLy1PknFHw5sj2h4Ju2OXEx0uI2mH2L?=
 =?us-ascii?Q?eIyXwd+zlFfWFcB7YUtWhKOSqGatHhYODTwKuMiz570FfpwsDB1TooE953b2?=
 =?us-ascii?Q?wifTy2huyh/oILm/QedidRGpcHix0Lq6lVVcLhuVS2UwuFDg7DYflD+U27J/?=
 =?us-ascii?Q?Z5VvIh8CFBqL8AWs0h1gcg2DiLbMuuPDDk9h8UVdpEz23J6LYurZo/LN5E5H?=
 =?us-ascii?Q?VP03gB766gCxdbDjg9zVymR0W1/p3ySDpreE83EEGBz6jxxkCnQV3LPeekiH?=
 =?us-ascii?Q?xvhbls05ZN3SeHbVcqreLdWvJ56WngpgxtDJSZWY81IH9CFiWWX2vQUHBXLE?=
 =?us-ascii?Q?8f20+oxbooECDKJUetlk1A4f/hXg4mKtSakkfyX1HmZwhSibKEQplnCZ2fQ6?=
 =?us-ascii?Q?MNSnq/MRKpNbrruKcA8zQMheqZak28M2sgKtHDn9e4PU6pTNzbdD7VG8HDNE?=
 =?us-ascii?Q?L9xfoxU5hlL+uD60DgOCx4rzWpm17wAWzGJ6Cx2c9s/JPHSAaBZaZRsKZ3tQ?=
 =?us-ascii?Q?UgSt/ri7zxsRrKSVju6WDo+8O+DksKj5GO3BbumpBrs91WObYlYfLDUOPxoM?=
 =?us-ascii?Q?NS0GZQOWyYJNNDFG9i8Uf3vMV4qKHlGf6vjaCqvsJOZCS/Dc/8GG1UbxhuNw?=
 =?us-ascii?Q?3gJ9crWXBi+7K+WOO/4UFCHsWTdLrXc7JhzoEQvPxFDhiVg2a15XYHW1vt24?=
 =?us-ascii?Q?WmybsODX9rlaRWKkGSueyImfakcxvv+qRASl43EFC/c4jFbdInHaMmgro16/?=
 =?us-ascii?Q?+EjyppIJRpGrrF/v+1mSuvTg7bTapyA8uHyQiJEaDMYRORpP+4jHeJXPVMIk?=
 =?us-ascii?Q?8E6jXMOz8zeIMkTdVg/aFkR4LcoMVUg37nMEd82JwLm59hrTPwjz8VQ+Z/Dj?=
 =?us-ascii?Q?UDXozW/HHv+Q8BVOcjl1/BvgxWJ7igzKsFz9+DSLCMh/tdwGvQ/45mo6kvYH?=
 =?us-ascii?Q?ep4169AVTw8JDkArw8cLCJDiKv/6g3kUr6T5uCwN8AL9s7WTY6sbzBBmuE67?=
 =?us-ascii?Q?UlxgGyRtk6MbFU026UMubGB8RZ1w0kI+tFOtZM1Y1XPSNYyWdDomkK7uD9e3?=
 =?us-ascii?Q?vF8n2hQbhYA5DWHbpp9cVh0aBj4XzKEWrEXwivryJ3pQ1/GBg75586ceYzht?=
 =?us-ascii?Q?e6TkYteBNLJQVa6bX4hu4yPIWeaWdOqJjuRQGTrvC6sGdK0Rj5Pxuo3utyZT?=
 =?us-ascii?Q?WAsJWKa52wjKdVlaFTz+bQgHoOZNXoUXX6TbYLlVW2/GxkSv/XVCKHrrJE7t?=
 =?us-ascii?Q?CB9eIfCeFmQepcl8xAS71alZ5gVRvZ9VuMr+YG/pqAEcfNKXbrFlUs8xgjdi?=
 =?us-ascii?Q?aVXqhTBNpdcPnpic2pVbmqcAyIS6niCDbIXJ31WMoNTNxaacF/PMW8uj0bsR?=
 =?us-ascii?Q?xKeq2emrrNsXdcGQW3hCa3jsYPkwTzpK3K8zn0zJSts2lcbVyKzi++ASEm9a?=
 =?us-ascii?Q?b9/w5fWJ8xbC3MAK5nO3cAqGu7cMC7yfk5pnbAkFkADKM8kdzql3lcY1/xj5?=
 =?us-ascii?Q?691QKfDFh8wvUnpgpo6IfdREZ74yN0jTpXZnYbFosuTfS9Jc6Q7cOkI9mzPM?=
 =?us-ascii?Q?uYrIW+3Punoxx5OLASO2LSKN+VHeywINN5BHgM8f6kQW7JildlwMhWPvFSnE?=
 =?us-ascii?Q?yA190ggNJQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3a9ef8c-6535-43e0-4ad3-08da3d993d52
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9186.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2022 15:22:39.6471
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UU33vdyve/b/iB3OMHe1NHnHg0iEYgc+0rIjOEFadM6Io3rlUEHvW2WI85zrvG8pzG+lEaMlbpsULyED1vc4rQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7536
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

The dma_slave_config.direction field usage in the DW eDMA driver has been
introduced in the commit bd96f1b2f43a ("dmaengine: dw-edma: support local
dma device transfer semantics"). Mainly the change introduced there was
correct (indeed DEV_TO_MEM means using RD-channel and MEM_TO_DEV -
WR-channel for the case of having eDMA accessed locally from
CPU/Application side), but providing an additional
MEM_TO_MEM/DEV_TO_DEV-based semantics was quite redundant if not to say
potentially harmful (when it comes to removing the denoted field). First
of all since the dma_slave_config.direction field has been marked as
obsolete (see [1] and the structure dc [2]) and will be discarded in
future, using it especially in a non-standard way is discouraged. Secondly
in accordance with the commit denoted above the default
dw_edma_device_transfer() semantics has been changed despite what it's
message said. So claiming that the method was left backward compatible was
wrong.

Anyway let's fix the problems denoted above and simplify the
dw_edma_device_transfer() method by dropping the parsing of the
DMA-channel direction field. Instead of having that implicit
dma_slave_config.direction field semantic we can use the recently added
DW_EDMA_CHIP_LOCAL flag to distinguish between the local and remote DW
eDMA setups thus preserving both cases support. In addition to that an
ASCII-figure has been added to clarify the complication out.

[1] Documentation/driver-api/dmaengine/provider.rst
[2] include/linux/dmaengine.h: dma_slave_config.direction

Co-developed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
Tested-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/dma/dw-edma/dw-edma-core.c | 49 +++++++++++++++++++++---------
 1 file changed, 34 insertions(+), 15 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
index 1ef326f7151a3..3ce0d7600da64 100644
--- a/drivers/dma/dw-edma/dw-edma-core.c
+++ b/drivers/dma/dw-edma/dw-edma-core.c
@@ -340,21 +340,40 @@ dw_edma_device_transfer(struct dw_edma_transfer *xfer)
 	if (!chan->configured)
 		return NULL;
 
-	switch (chan->config.direction) {
-	case DMA_DEV_TO_MEM: /* local DMA */
-		if (dir == DMA_DEV_TO_MEM && chan->dir == EDMA_DIR_READ)
-			break;
-		return NULL;
-	case DMA_MEM_TO_DEV: /* local DMA */
-		if (dir == DMA_MEM_TO_DEV && chan->dir == EDMA_DIR_WRITE)
-			break;
-		return NULL;
-	default: /* remote DMA */
-		if (dir == DMA_MEM_TO_DEV && chan->dir == EDMA_DIR_READ)
-			break;
-		if (dir == DMA_DEV_TO_MEM && chan->dir == EDMA_DIR_WRITE)
-			break;
-		return NULL;
+	/*
+	 * Local Root Port/End-point              Remote End-point
+	 * +-----------------------+ PCIe bus +----------------------+
+	 * |                       |    +-+   |                      |
+	 * |    DEV_TO_MEM   Rx Ch <----+ +---+ Tx Ch  DEV_TO_MEM    |
+	 * |                       |    | |   |                      |
+	 * |    MEM_TO_DEV   Tx Ch +----+ +---> Rx Ch  MEM_TO_DEV    |
+	 * |                       |    +-+   |                      |
+	 * +-----------------------+          +----------------------+
+	 *
+	 * 1. Normal logic:
+	 * If eDMA is embedded into the DW PCIe RP/EP and controlled from the
+	 * CPU/Application side, the Rx channel (EDMA_DIR_READ) will be used
+	 * for the device read operations (DEV_TO_MEM) and the Tx channel
+	 * (EDMA_DIR_WRITE) - for the write operations (MEM_TO_DEV).
+	 *
+	 * 2. Inverted logic:
+	 * If eDMA is embedded into a Remote PCIe EP and is controlled by the
+	 * MWr/MRd TLPs sent from the CPU's PCIe host controller, the Tx
+	 * channel (EDMA_DIR_WRITE) will be used for the device read operations
+	 * (DEV_TO_MEM) and the Rx channel (EDMA_DIR_READ) - for the write
+	 * operations (MEM_TO_DEV).
+	 *
+	 * It is the client driver responsibility to choose a proper channel
+	 * for the DMA transfers.
+	 */
+	if (chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL) {
+		if ((chan->dir == EDMA_DIR_READ && dir != DMA_DEV_TO_MEM) ||
+		    (chan->dir == EDMA_DIR_WRITE && dir != DMA_MEM_TO_DEV))
+			return NULL;
+	} else {
+		if ((chan->dir == EDMA_DIR_WRITE && dir != DMA_DEV_TO_MEM) ||
+		    (chan->dir == EDMA_DIR_READ && dir != DMA_MEM_TO_DEV))
+			return NULL;
 	}
 
 	if (xfer->type == EDMA_XFER_CYCLIC) {
-- 
2.35.1

