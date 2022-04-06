Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9D674F6784
	for <lists+dmaengine@lfdr.de>; Wed,  6 Apr 2022 19:39:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238958AbiDFRZ6 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 6 Apr 2022 13:25:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239005AbiDFRZp (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 6 Apr 2022 13:25:45 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2062.outbound.protection.outlook.com [40.107.20.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C4C34B93DB;
        Wed,  6 Apr 2022 08:24:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C8b+1lhmlY+k3A4ptugkFgzFvRwBwhBVdsCC08NgbQH0ZG6am3UWkRog1Caal9/Qzsjcyx5N+XtmMvYp5NOksWLytu0F+Smt+hSHzWUApVlVT2TrEWnwIwaKK9uSYrGNw6oUDiODpN0r6VWpiUE6egk0Vvj85SQ2TeYW2u2TcT7R6o0ckXWHFfUqtDxzd8gAUZneDcMNUZ8MRfzdVaFE9mvbXAAqassif1YmQbj2+sFWcD/7Yu82QNclL+cusG4PM139Y/DGx8a8Q6bGW7zIE/gTKN3+TWbski4Z2+DTfiOFHO2hHVm5a3vw0DsWYdCd7tZgPvTjkQbryd5JPocHQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yX0USS3VtZeQCeosliAIqV7fezsnsaGbgypc9QxMwQ0=;
 b=afH7c05zaxRa2WFPOcflaaP36FWskVt3uuUXCc+RxHJvZKErKKXTPt/8z3Um7sZmUpQyha/vOajEey/yw4kEz18DHh11MwElMUEioHfKjU04moKI9Te4U5w1WIng5jb9xUNrE3a6twSmjRq54Czzv+ac2umE4LH87r8kcDVmxUJt0OjSmtyaBg3neYf0+v363H8J0IxICn2xa42ikWdMRNrpOLoEDwhvG5F5GjHukHHfSnkPwceEvWkc8R7TJkPy+AXu1zwJhgWcTmLxXTHu+RiOVeYuRkCa+uNSP5vxiktgI9B5L4B4+UVLCt1W8GD/snPLH97YJVc697KyzAH+hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yX0USS3VtZeQCeosliAIqV7fezsnsaGbgypc9QxMwQ0=;
 b=kS5KN0GaivcFYS/3yz/MUCZmRuF4ffivY6pXmO4tjufAmBW1eEyS5Zs8PZaiuZoBzRpzTvrA0CgZeRx6CiXa8lTrYrAU9KEwoDziHS1D8+iDQZwAzKCIUepH2xrodW18t6d+7m81P4/+uy/2J1arU7tgnGel9Momrx7xfhtZJIg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com (2603:10a6:102:232::18)
 by AM0PR04MB4033.eurprd04.prod.outlook.com (2603:10a6:208:5b::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.19; Wed, 6 Apr
 2022 15:24:40 +0000
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::ade4:ad15:823b:7e2b]) by PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::ade4:ad15:823b:7e2b%7]) with mapi id 15.20.5123.031; Wed, 6 Apr 2022
 15:24:40 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     gustavo.pimentel@synopsys.com, hongxing.zhu@nxp.com,
        l.stach@pengutronix.de, linux-imx@nxp.com,
        linux-pci@vger.kernel.org, dmaengine@vger.kernel.org,
        fancer.lancer@gmail.com, lznuaa@gmail.com, helgaas@kernel.org
Cc:     vkoul@kernel.org, lorenzo.pieralisi@arm.com, robh@kernel.org,
        kw@linux.com, bhelgaas@google.com,
        manivannan.sadhasivam@linaro.org, Sergey.Semin@baikalelectronics.ru
Subject: [PATCH v6 5/9] dmaengine: dw-edma: Drop dma_slave_config.direction field usage
Date:   Wed,  6 Apr 2022 10:23:43 -0500
Message-Id: <20220406152347.85908-6-Frank.Li@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: d07abb2e-7943-482a-4968-08da17e19182
X-MS-TrafficTypeDiagnostic: AM0PR04MB4033:EE_
X-Microsoft-Antispam-PRVS: <AM0PR04MB4033E85898EE7D416437EEC188E79@AM0PR04MB4033.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +IdjCWz58wQE7rF4uC+lYZPxgWb4cgGgFvVlt9cOyePdm8VXCi2dpxjN1Lbag2VuEiXxl4dhiwL5rblKW3vCxOiqZmnub9589sRZ7hQXYj1s9l28hWl0HtxEFS67PdVj55xqobNaTN3oi8DE3MyXfuF3loEzDZlXmKTs9EFDuN20JQbcR+di0a18GAE+VnCbr6Kxj37q7pE/+3nneMP1xzGgf+3sYwVqcWhAuirMVnUb8ZZvPBZQiyeLi7h120wM42tY8mmhvGv4T3fEt5qjcOob2SVuPAEbydDWBr3fa9Rp6R1jhwV+hksGLdhczYQ+GBNWY7qhxBEKcQesQVy9ooUyVrUAaEDaUKF/n5/PpZC5LyXHZ+e3OXlUNCAOrwOq17LG4kKcOHMrmBGuOgml8n10wkR6KvyYawbM8Ed5Ybf1bYrr508AGGgKlp9kHL78admzueXyi0SLy4v3OJlX2sWyjxK4LV1TTl3N1XDPAyxbVrEM1EgqExiTSMGfSqITPIaC6xs+hMrkcEUPI4lB+KTe48i6no2U4Pzo9Ni7qwcPqknncSu2JbcxSxKoyzt50a89j5VBxxjPFAz5D1BSDIlhxU3tQ9XlS2M6DcDPhYzgQFpUmO9xpEIBmmoPMZ3FN0g2eSjDb3TB15CenanDIAElx89axir3+obDawyQEC7FDWLJ380ckrg2tMnkWzaiQKKFNAWjL2oWph4QQ/o6Gw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9186.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(7416002)(26005)(1076003)(2906002)(2616005)(36756003)(83380400001)(186003)(8936002)(8676002)(66476007)(6506007)(66556008)(86362001)(66946007)(4326008)(5660300002)(6512007)(316002)(508600001)(52116002)(38350700002)(6486002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uVzGXJStMbvl2A37kMD0pdmrnnEe+7yJvJSHwTqkuFzLdq7ROjyokMu8/4MF?=
 =?us-ascii?Q?n14S/BWap8DbfTBf9h3nMHoiPuoN7CGUDUYdrodv2Li9Mbbu50HIGEFbPz6G?=
 =?us-ascii?Q?5J8UWAhzexkbeCARjLOEip5W04VZAe/hWBnR2WNYL6LRkXoQ2TsLZnG9IzyC?=
 =?us-ascii?Q?OQ0384i7M0/Mw39kVfCogWskatSegkhPIAZhpnhWHhW+ppujSAcaYNCMH1ss?=
 =?us-ascii?Q?VYEYffX5h9p+hqiY96fDX9xgqevwsr/FXRg1Zyq41Cnwga7XCu88ybxWFjTi?=
 =?us-ascii?Q?4bqjqX9Z29xU5uiJNgtooN60meQlXp1YcBkE0v95WxmoRZutIjjnqN6SEeBD?=
 =?us-ascii?Q?7mKAYyiz/1hrzv+leQKh7cHb1K+iUYhQprVZWaMtF0qqMzHVv9B4YdKUL0Tb?=
 =?us-ascii?Q?AFJ0czhbhJpg3Nk0wNwM3N+ChlHLkiLASTIsk2+cuvHB/7dYAdEe2KPiLbqe?=
 =?us-ascii?Q?9EsvJPDUVxBibyWPRzsZZ4kt5YczyZoCFDHK/WIDmQ89HFEy/fk1tKIg1c1T?=
 =?us-ascii?Q?tXLpcDVnFjtBFeC4//Zf3z1YR8VXyhsGzT61Pvr/hhZpwdAx1b+SLTZe1uqu?=
 =?us-ascii?Q?ZJfBW2a7S4TWai3OYDaHNq4WydKjMx/PZvtTfQYBbSGtCE/LRVWS1Rh3c1m5?=
 =?us-ascii?Q?EKdQ4Utm3+gAl/O95SG0WFQSdzOFKesSpRuxqaYNozaUqNy1ntz4ySqPWNlZ?=
 =?us-ascii?Q?l92ZjWZSnAS41DDF7n1lKlt90iQhrg6lkzUjXuOonZWEbX9VbVIR5Rr7oV4Z?=
 =?us-ascii?Q?a9IvDOL4qq/QuoO+3qiEoI8GeZe8h/hcsD6OUS9G8I8cXMMdRLx8Bb3Qjipz?=
 =?us-ascii?Q?hi7MYrBi/M2qEr/FKIGydVugKKoECO9abBYXgCODEJPu7tE2zayYxlWVUVkb?=
 =?us-ascii?Q?JwaqS1Uyo2lg8haPKL4K9cp6E/AcMW0N0Gz6NDBMK5LDgcmRF4LL89cTlk8q?=
 =?us-ascii?Q?K5nsnZHsCxnczbG1W2icO37pY4CiA24A/tepSi7HXCvMU3CBF5Z8OLowGgVn?=
 =?us-ascii?Q?+1M46lfRG4EhEj+4yad6+zQbwQaDCWd4kIJk3fcwZnJMowXQXFQpr4J8H8+o?=
 =?us-ascii?Q?fTANuYa9IDMeZS0X5RHdnAtlwWqXi0Rs2Hyxweu10ZNlOv/cZhC6AjhZaFPY?=
 =?us-ascii?Q?WS5rb44G7SikEwE/gUCjnCAVdp8Zznfa4eslb/pq1w49EZT5R7S0CK5UXluo?=
 =?us-ascii?Q?/x/YhlqMf/8UpWVrm4UeGLc22mcdFm7yPb5pxDNWezyTOh+fr0OQFO5Ikhkj?=
 =?us-ascii?Q?AGVe1rlMoiIL8kbnq9CovVpQjEZ8jM4xZ5quCZk6x1VzWRRWuBKDL6idNKLH?=
 =?us-ascii?Q?PE63zqHC0rSIzpvZQUPnWcUbUgkgH0rgO5zfwA+SO8WQuibKi5XSZWaErm8Q?=
 =?us-ascii?Q?h/T4cRPHwuZP46HYJTwBDgdtqaT8Qybw6JuIyM9105wd+vVYpZ0e2nY2cGFW?=
 =?us-ascii?Q?tPfRkA69oUxynYdwRh7cVV/31PcR9zJSHpX2zSMqvMjGr+FUGZq00CVWDY0v?=
 =?us-ascii?Q?wlRhuyUpvY/jg1RDUrrwT1t+9M5KMlRHa74HrGpplcd9SsUm3h/iJ/0MmRYv?=
 =?us-ascii?Q?OOfUknps/trsLeRmrzzUhq/osfEH2j5+NZAeHtI4HmaFPqtqCFGX6eUdAlul?=
 =?us-ascii?Q?CAw/rxSNLknEZJNp5uSIiF8y5ID4lO+0cLZ1K3BWpg1srydv/f1hsCgSxCml?=
 =?us-ascii?Q?6zaQC+ohScVyutdpOPH86AJvfTHmI5WamTIWo9/f/XW1iS0Fs+PWWhq8Ag/L?=
 =?us-ascii?Q?FHAvUnX1aw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d07abb2e-7943-482a-4968-08da17e19182
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9186.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2022 15:24:40.4380
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a557j6fqm6Nzx0ZQYoPH3jxNEwBAh4F04DJAOeNQ4C03ThnhkJci3kaWjzXoktuGno65ZnzUCRb1ZOm6LZZdQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4033
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
index cfd1cdaa4c1db..e321f36c1bfb6 100644
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

