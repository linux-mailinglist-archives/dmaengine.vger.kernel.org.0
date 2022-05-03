Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC0A6517B79
	for <lists+dmaengine@lfdr.de>; Tue,  3 May 2022 03:10:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbiECBJP (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 2 May 2022 21:09:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230056AbiECBJK (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 2 May 2022 21:09:10 -0400
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on062e.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe1f::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 033C8638C;
        Mon,  2 May 2022 18:05:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iiGsMychG4cKyqHD9tQweERvZYCpuyiTT1S/sq9uxpKMymfW+QzDgef969oSdA4PlijzpwCFyc90yL9Zh4P7MgkwQrgFLEy44WscJBt4cNsYCyBFV7iz5qKDXpkGsCgwq52CPCmUEX/edIZVVNyKlBaSmDU+TCuXDiAHacLJ8Wvc8+yh6fQ+4KE/A6QK+gg5Pi4O1w+bLXK9nPdawBXxqtVrkdSYYYCY2ul3tT9ImBmVXxhchKTkOAzW7flI/RGLo+Ituld7E1vawNV/vs2IscC78Ae7n80il2MC8iQIHULyhTJwdc9a5ojSXDZsoWToJkuklRnYv4aonf8RK2bHIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IJpKow6CusuERHfQnEkjveVwbS2llRULQQm2wL6/1lo=;
 b=J+DmqIaJwRH/87CoVDeNkddGshUtMhTbBT8/ZcEQWTBC1LwF7IiuQlEu/VsiSObBhNWvwgJhHBwTTZuyvKRqSj+L9R5LXKh8oiEV3V+3n3jJ1cKzCY7tv9BBrGE0UVq/GnP87WVQmXl+2tvRoWh9gIjiTpPSKGPunOgCCKbIqk7lKVd9jVsxAg+QrnjOwL6a/5cIwiZGlwqcIsVZdkUD3ZWHY8lnxq2Fj0nMm8HrdcpK1scR3Fql0FZaDXifM6i4eArZLGMJXJ85NiyZacOPAcb/jXXYNqtcGwEUwIQ2MtAScS9PXcAST6A5Z3UDZYl0FcQpbSvrNlN5PSFkOBvUCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IJpKow6CusuERHfQnEkjveVwbS2llRULQQm2wL6/1lo=;
 b=M6b039dYx7qYnGLmqVMz8mkvsHV5GUnxR4Yocpe+dp+/vO25x9I3hq0cuB8TFw1hllbNlnp1Jb2a4TRvmDBEO9qOwS/s2hrdjcGozApgSG6NzJi6WQQgvFknZHjvyPi8bj8Tu6RfHM3cZ+vOMBkceCyFNhkR1VE0w1iJb8puyhY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com (2603:10a6:102:232::18)
 by AM8PR04MB7364.eurprd04.prod.outlook.com (2603:10a6:20b:1db::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.24; Tue, 3 May
 2022 00:58:41 +0000
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::adc5:45f8:fa40:1b8a]) by PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::adc5:45f8:fa40:1b8a%7]) with mapi id 15.20.5186.021; Tue, 3 May 2022
 00:58:41 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     gustavo.pimentel@synopsys.com, hongxing.zhu@nxp.com,
        l.stach@pengutronix.de, linux-imx@nxp.com,
        linux-pci@vger.kernel.org, dmaengine@vger.kernel.org,
        fancer.lancer@gmail.com, lznuaa@gmail.com, helgaas@kernel.org
Cc:     vkoul@kernel.org, lorenzo.pieralisi@arm.com, robh@kernel.org,
        kw@linux.com, bhelgaas@google.com,
        manivannan.sadhasivam@linaro.org, Sergey.Semin@baikalelectronics.ru
Subject: [PATCH v10 5/9] dmaengine: dw-edma: Drop dma_slave_config.direction field usage
Date:   Mon,  2 May 2022 19:57:57 -0500
Message-Id: <20220503005801.1714345-6-Frank.Li@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 469eb9fb-b8c6-40e4-f4b2-08da2ca01052
X-MS-TrafficTypeDiagnostic: AM8PR04MB7364:EE_
X-Microsoft-Antispam-PRVS: <AM8PR04MB73641A4583DCFBFC59049D0688C09@AM8PR04MB7364.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /FEwZz3KY4d5hvBOMl0G5jyHnNU4X5JdeyOToAHndc+3RdaVLF86A/yrNF8eFoN5PXRf6iH2RpVP+9st+cdy6aHnVOGfWqL1AX1UkVA6eTON5h/uY5QzZj/tuMYl+A0N7T0RTla3udCmg9pFrmSXP6JxZvjKNNIk+S6rfCs43LNueNpkPNa14YuRsYK9z5ZerRz1qcocwHYZXHgrzM+X7ubtiqA9ImDoToxBjBik3xsdXUXdKHqVNSOCEJgFyUC7gjyUyJzjD0nwVVdsaEHZZAJHEByyb3zRx180+w3ZZi1nVqcALwl79RjmGzgaoebKdkOeEjeU0eajKgvJ2lqmbdRx0RZc3NC0UhZTXms5jEJfIrD9Fe7J1EO4/LOCJOjiG1xlhXwZvbtjVRjMSpZIuvZDXZ2DGeLZQ8Bs1ekIdNZOgvrMUIANsQgNS4UVC76E1DnWfsw1V0KBAWtK9ZboVB1FH9IQkc1NtCdYgu35wb1SGbCqnTZmlvHUhl3nvSnMheokmnmEDU+XkIGF0A8AXRqDzWow6vKxkg9MflNCTV+Y1tiLRp7TutI3JvAgDQtcsW26jm72JOobGWzoCjIoTgsL0aYHmuyC8G2e4GgPOCMduIHVcEMVSzrGJFlodZEEAEJir7PcEM0ToV52e68NpcinVlEqW2Et0bHptt8imxj3EVTfwAHeb413ey0fyEA/y+k5zxngmsKmlGD1SF649g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9186.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(8676002)(66556008)(66946007)(4326008)(2906002)(36756003)(66476007)(6512007)(6666004)(316002)(6506007)(26005)(83380400001)(1076003)(86362001)(186003)(38100700002)(7416002)(8936002)(38350700002)(508600001)(5660300002)(2616005)(52116002)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YuApS/mDAVUs88walZlywYMw5c8E07ZtxIHltGKnBNhUkg65DJBsbzbmtTNx?=
 =?us-ascii?Q?8oQ6kYlVXD3JaHAtSuvNVnu8aa78ctyj0wG7C5EEglfaov6uN6ypsT3iOoV4?=
 =?us-ascii?Q?+7VOGtgCEOg/eLQUtlKLzudtcpb8iCG9I5UHxRDinfnvxvI9MXg+Xiy1yVIF?=
 =?us-ascii?Q?mm98QDt79ia4gDZtLDaLqUgAmnBwUgE7MdVqwqQu305lsGWjdqs21T6800Rz?=
 =?us-ascii?Q?y2YN4pT7z/vDMtEKnDqTAYQV2eYpAPPS3qZdcie3akPRr0gcCimwxFrqXo5b?=
 =?us-ascii?Q?1e/1RMWPeZ9QIlzOOxadUtxu9gr0QKbft83RaCCxGZKle6LpKlSdP4g3QDhw?=
 =?us-ascii?Q?k+LEPeD/eCBg2LHOD3zdSwwosKyf1OHYT88Wrkv04bB0H7/9Sa3cveyj5mE9?=
 =?us-ascii?Q?hz5t3MROzc8F1+OffglOpX4Wwefd0b0nktlG+JqMc3LYFlSScVVzVRy1qk3C?=
 =?us-ascii?Q?mqHZ4JMoIdRYS9jMTH2o8JmXwEtyoJBSU1XXKP/tLD0OFl1ZGz9B3ezR+qsR?=
 =?us-ascii?Q?Iwg5mcjYD9wu5cTRDNjm9E9VHEGpO19281FfBBsBt+Qa9dLSdbFdAUSewVEz?=
 =?us-ascii?Q?r9wj/ZaKLZZFixIBLOyM/945BzJSGJDALoOb50Z0P36uORFp5ZhhcxtpN9SX?=
 =?us-ascii?Q?iIwqVPe+tHG06lpIVHmuPEHMSGKDrN/zPd6RXtygPa8ueo2jWMFH83diDAtZ?=
 =?us-ascii?Q?K0mJQ68c8p26R15qZ4pYHCzGK+dMntUPv+SZ/r1VuCItwPwx4CoNJmY1XUy8?=
 =?us-ascii?Q?0VnSNw1GmidQ9mx5RGiHmyV6x2+NoR4NvsUpuwM8KoxRf42Ziz0+Vhs9ZfbV?=
 =?us-ascii?Q?l/uDF/kkaGe7jS6o3wJi/mAdr+9xXK3xBRwxZgnbwaO2AuyUTqaQFX52Hl1J?=
 =?us-ascii?Q?0cY1qUY86IURlbXrsd93ayYC7dHkg/r57bAZAcOEoCuqdlAYB7h/JY4bLDXk?=
 =?us-ascii?Q?BQTwrt02oxZk2V2VIizpqHx8FmxUseqyGUhO2BiSWu5J9MPpoEAu0uHhjplp?=
 =?us-ascii?Q?h6xJeb/HXWUIsWZSOoOOnJIZ+xsLEdST8gQ0PuHVOP0ODUH1iNZwtzxQbnZD?=
 =?us-ascii?Q?OFeoQxa4acjiNjbGmRkqZEOBIVZ79KD8HEi4qGyGAH1gcalSDJE99D0f/jyz?=
 =?us-ascii?Q?h+yXqNn7v75IcnwMH09IPjzjSQbArAkGbu9p+x1qHtCcJMmJt7j+xkSY2YKO?=
 =?us-ascii?Q?sLKX1t4gZ6wQ6zMNZNQKQfY1NovQDrivGmfmPXwAcvfm7P0ZF8x8mbQhSf8i?=
 =?us-ascii?Q?feYU65XI/sSg1f7OG8gtYqb98PkAK9oEBBHNIajEBNJ0+37GGfE2jJkHoeXw?=
 =?us-ascii?Q?RlcUiscuEvXxiVsGnrfv+6tdZP7HlupKZxmaZ2ekfqNHdq3o3Hp1AUYZMhGe?=
 =?us-ascii?Q?m/H1Y6+Va6t513lxjGmymIgkCCWsMxF2dBmLWgj9ZMvUybwev/eq1AubrAKO?=
 =?us-ascii?Q?tuiL/780PHuaQ1qPJqUj+9PqTt9wWb7ApgLl2wgUJO4uHADB9BW7H4941W3f?=
 =?us-ascii?Q?IqSt6SmG6zqq36B4Q/AoEqy+ljKBFvhyKCNx3Yl0oBeemfc5TYr9qM2vsw0C?=
 =?us-ascii?Q?j/4i0oMoaOuVfcHYvWSsX7Su/sktcR9ghE+i0eh0KpdiRIo7Ov+Dyr4wT5t1?=
 =?us-ascii?Q?L3DVhh8ZCY+g/vUhZ5PzZnwT5MbJ1cdljrpaUgZv9uGNRRnksV6LOlMdaDz/?=
 =?us-ascii?Q?PtProzzIlaNDL7yY4lZePUx6dmhFTgNzItQav69vH7CMyIpkMHO/4419d8o9?=
 =?us-ascii?Q?knl9utA14g=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 469eb9fb-b8c6-40e4-f4b2-08da2ca01052
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9186.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2022 00:58:40.8951
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sC6bG4YvSfL7dYaQReC8+ySLrIISxeUc5EwYtWct7/4aJ3RPhV64hWhAUkoLPK9ZB7odmepJrOpR/W8pXXmCeg==
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

