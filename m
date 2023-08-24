Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C640F787548
	for <lists+dmaengine@lfdr.de>; Thu, 24 Aug 2023 18:26:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242528AbjHXQ0R (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 24 Aug 2023 12:26:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242544AbjHXQ0M (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 24 Aug 2023 12:26:12 -0400
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2059.outbound.protection.outlook.com [40.107.13.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9ED71736;
        Thu, 24 Aug 2023 09:26:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BA0toj5wLYFw0XMyfTHUu3tKQ8OLuRL5JySM9LMNKOXPCycmymQKu5jSQCIF/zP7JXkMkeqmgmE4OCFFzqlqnHUaEx3gfjtesMM5WaR7NXIiadTlTABQEWOTyknnSbIEo6b8C6tqXfsWIQ4FPRVu1ldUrz1MXDbrRlOPfruoJjq7Kvat/GEPB38pAAKFI2zW+PwXf509i9jC28Em+VkUYnM9x+EJ+wY/m6D6Ma9QfxDALUk9idc108r76DE2tDV8cVdw8a11INRD2iNEIE2kHGz4GMCqCk0DBJ2xFaKnmulc2CXB6asrDAuzVXxIwYoXUW7IxZwlOGVat8hMj9PAmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CaZh+/BCdP+oWQPDpDOGGD9BzLRANoJCexVMJHK4P9w=;
 b=RZrduVtMaCK+oo3LJNg5wyLwW9HOs6x3zD7wKUoQAQuJs1lqqq9FyPNezDqLjfOVE5oyLtKAcg7qEKOMJ0PCAkAILXp+XQqNN1QtQLS8wIgCIpP1n5xOvQeI79fcOHt/a5mpwaSh8NJ4b+N1J//gfDDAQSHf2u92p1yvOmGnlQ2wNdD+dXeLHGv6EWvyAnvmiFy75zIX9OvyblRsYMMO8juX2Y9u1VtceOpe9KtCOuigKlS7C1a5dT1MmeOmf+wquBqXAtrcbGQcK7pZHffRlmOppQVpGGZKTL+gjQUIx6xDG9gYroEbC4NWLZP7Mh86Ls3X2OUEgNjzHYp1I3Vwqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CaZh+/BCdP+oWQPDpDOGGD9BzLRANoJCexVMJHK4P9w=;
 b=cKtW5+S6khmIUDivA/5OcLyqA1cESwo1iGO0crk38ItTWa0eZEYjNrJqoB637bUzTmK1nHQ6lMC0dXQxhhq6oXXVPeUSxw3B9gNSgAruMbdxkPuIP901LwFqer0IK/xQTT7X9dur8ETg9VICroRL5dkNYIU8OVPxywnRxIsJqhk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by AS1PR04MB9656.eurprd04.prod.outlook.com (2603:10a6:20b:478::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27; Thu, 24 Aug
 2023 16:26:08 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::a680:2943:82d1:6aa8]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::a680:2943:82d1:6aa8%3]) with mapi id 15.20.6699.027; Thu, 24 Aug 2023
 16:26:08 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     frank.li@nxp.com
Cc:     dmaengine@vger.kernel.org, imx@lists.linux.dev, joy.zou@nxp.com,
        linux-kernel@vger.kernel.org, peng.fan@nxp.com,
        shenwei.wang@nxp.com, vkoul@kernel.org
Subject: [PATCH 1/2] dmaengine: fsl-edma: add debugfs support
Date:   Thu, 24 Aug 2023 12:25:47 -0400
Message-Id: <20230824162548.2940355-2-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230824162548.2940355-1-Frank.Li@nxp.com>
References: <20230824162548.2940355-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR03CA0034.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::47) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|AS1PR04MB9656:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ca428f2-5db2-4466-92ff-08dba4bed261
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VYTpBDzAa4+QY6XR+GdUpaMvcEY7VwXiEAcVZpntruhB3MErPfPiVliGvMdHQPBE7AWRiqUltwnzNF2QJlW7nMdMENpw+enO9PYoc1r4CdPCrF1EnUvb1kwuRvWj+pPeAcD8AJpPL+6j6PPDsdcrS7sLCFrv/1g9Vav6f2baNAe/gY4Fhun1O6drzRgJqXw6PtTEFQgXVJcwJKmwHLi+YC0Vo3cFOPipBhlWFaCDzgojYy1sOkUkH/O/+NcNgXJG0D5sRotC8Ed6srZZKoelVIYFaAqQpSCaR8djDoL7g5W66tuzUi0gqir/CRHfwQGVioA8OvV1rYICREmUEN0IKhTNK+ZSaqam1atKFIAQ/m8HvO92Y4PM+EPRyiUA5byXzLaoDFANoDWRfDtVE1nuRxvV58eQPZad8iplegR2Nf1vmyxRiLoW36McM1kcmYrG/01Ns67qp+rM9ZR0ucHhaHjnrOTZKWu8PTCjKUUnKu4noBVsbJzDYw14k/LPQ7YXZMgUDgJABawiXwDntrzMMhnhOUp9trPDFLfAlJTr5AAjOV9ckJlwH56xFlIZ9Wxr1Jw8WfH8NDbPQbSvbdnHyn0b5rw76AFnjDoVgijL7+cBpwhEjm41wOIhC8nDKJNj
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(376002)(346002)(366004)(136003)(186009)(1800799009)(451199024)(1076003)(2616005)(5660300002)(34206002)(8676002)(8936002)(4326008)(36756003)(83380400001)(26005)(38350700002)(38100700002)(6666004)(37006003)(66556008)(66946007)(66476007)(316002)(478600001)(41300700001)(6506007)(6512007)(2906002)(86362001)(52116002)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6H3PAmtUwa8qB5qJi6NQuaooyKxXbUlXkh6v+kj1dRExsoSEtI5qPNrmn6aP?=
 =?us-ascii?Q?TnocCBoqi9TTXwQ8GLlRWXOg3Tw/dvw8OmA6GbH/3S/Wxjh9GtGyeE7wEVFP?=
 =?us-ascii?Q?Z/kpVZ3RjlYryjfQSqp1FCuq6gBqTEDuvQWLpCLCwv+G18SlRIUwcuSj59x6?=
 =?us-ascii?Q?B/VazwCakPUC041aWIREn6ECtQJFcVgGuzf6QxIujG5vw85ManhEhHLIZWFE?=
 =?us-ascii?Q?W4YHr1LYNpF9TIEfkQx+Wom34mHh0zy0yZuPad7KzRZQhnFOToQIhqs/37um?=
 =?us-ascii?Q?YHoZK2Q3LQk3eppM2ftAgtm/xJI59jgfnvMUa63x1AdF0szVGIFzGJ7zOs0a?=
 =?us-ascii?Q?Nzki45t3LvkI2TAgNNgM13DI9CuqpGSjbhVZqK7aQL538EjDnl4KyFXJoQ8n?=
 =?us-ascii?Q?ayvLsuZ+t+I5Ns/S8Y8jodYQ/o7Szfh4IfDZYSQ5kxtFgrn8mdCnZ7om05lI?=
 =?us-ascii?Q?AyjimRk7Nl/jDCPMJQWtNz81PfQe7sRCUEbngvhTQMxXm7iTchASGdIPvXsq?=
 =?us-ascii?Q?mb/88yuKwYI/pBJIhlJ8ppqP/EHJJPZrcH03atpeO1s0qQLFQrdmAvhbXtHh?=
 =?us-ascii?Q?vnhcXYj6r6uYFpwbzt1S1atMnF3o5KcLlq7ieDQ4q/UvKSAXzsZwJKe0AAUx?=
 =?us-ascii?Q?ho+Huf2XnKKkBpuIvSuRFRztaohyp5Xp0jOfazFV37F0CzQIfs+IKkQGx6I8?=
 =?us-ascii?Q?mJdGXL2aUcrAqYaA1g0oSg5012Rm5vDFh/427pJuSxOHlFTW9eKLo683I9TU?=
 =?us-ascii?Q?RxVEqeDV2cOf/3dvnn+kmmZayomsja1yVxPcIl5KQRVNb/Q2SAEtUs+PH36L?=
 =?us-ascii?Q?7qNr1GUzSEbuLoaT0YM4Yafp0CfOxnFw2XHiNoJW422SrarxBbSEIVtzQnPB?=
 =?us-ascii?Q?3AMCN7QXkXOfABiVqjuCdVjZyrTX/8bw62/d1OjcTTSyrPr5OTcHU19Fn90T?=
 =?us-ascii?Q?YXw7so4PNt6JnpbPmJaRxVIdG3fClgYz2Mj8wdNN0atMBa//7K86/FzFhJEO?=
 =?us-ascii?Q?7BjwdIO1OF5IzuA6o4+h4S80Bsw4SJ+Z23ZDzKZmiZZXqyC2qA+ogePQY735?=
 =?us-ascii?Q?IugTSVFurbe+yl9S+kMJfBM8nO9IAq6N7btQl+2qS8iPKkV91Qyz/xRSgHSr?=
 =?us-ascii?Q?i0RZfcGSjEe9KalqkGj0arizy2lpqzeI5UI5F1EpEgQBR8TUOy4S+iAygbk8?=
 =?us-ascii?Q?oUK9s0f0fJLtqyjesZUDbTaripXDb2WQadpo91JrdAQjowQH3nSWHZGMKcRz?=
 =?us-ascii?Q?XwaUaYXDGT9W+Ap1kFgO6Uz9ZxKgdxdenh2Po65ANVMaSuXurJM2RkzVzxUp?=
 =?us-ascii?Q?t6O7P9P84+xinCDDpVjEhVUSo1EQN9YvyE4wt5Ds/wGD/b4SlZ/uAMn2SSUO?=
 =?us-ascii?Q?GMtU9Y7Q1q7YkS890TpIoJ8/QnbSTUMAobQRajQGyiTFG1CE5bl3cuq56L7Y?=
 =?us-ascii?Q?DDZZDjgwVrnK1J6pDtUV59+hlB4oujDRXDxe39y++1kUVokwtSzAx14zEV47?=
 =?us-ascii?Q?lizrid7M9NGO3YtekOg/Fvzh3F199D1e07m3IeQ4nIhP0rfD9d+zpc9e93Cb?=
 =?us-ascii?Q?Z/N6KVI+XirJLpv4V+gcjSR6OZC5M7/xkUQVcalO?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ca428f2-5db2-4466-92ff-08dba4bed261
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2023 16:26:08.4988
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q1EmUu+tiWPjeDAi1+EjBgOaC0x2sBe2DkGG+2iSRQpJsCj9DbG2YMeLtFoogHL1Q5eUpTicK9Iw2VSAC5Js4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9656
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Add debugfs support to fsl-edma to enable dumping of register states.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/dma/Makefile           |   5 +-
 drivers/dma/fsl-edma-common.h  |   8 +++
 drivers/dma/fsl-edma-debugfs.c | 120 +++++++++++++++++++++++++++++++++
 drivers/dma/fsl-edma-main.c    |   2 +
 4 files changed, 133 insertions(+), 2 deletions(-)
 create mode 100644 drivers/dma/fsl-edma-debugfs.c

diff --git a/drivers/dma/Makefile b/drivers/dma/Makefile
index 83553a97a010..a51c6397bcad 100644
--- a/drivers/dma/Makefile
+++ b/drivers/dma/Makefile
@@ -31,10 +31,11 @@ obj-$(CONFIG_DW_AXI_DMAC) += dw-axi-dmac/
 obj-$(CONFIG_DW_DMAC_CORE) += dw/
 obj-$(CONFIG_DW_EDMA) += dw-edma/
 obj-$(CONFIG_EP93XX_DMA) += ep93xx_dma.o
+fsl-edma-debugfs-$(CONFIG_DEBUG_FS) := fsl-edma-debugfs.o
 obj-$(CONFIG_FSL_DMA) += fsldma.o
-fsl-edma-objs := fsl-edma-main.o fsl-edma-common.o
+fsl-edma-objs := fsl-edma-main.o fsl-edma-common.o $(fsl-edma-debugfs-y)
 obj-$(CONFIG_FSL_EDMA) += fsl-edma.o
-mcf-edma-objs := mcf-edma-main.o fsl-edma-common.o
+mcf-edma-objs := mcf-edma-main.o fsl-edma-common.o $(fsl-edma-debugfs-y)
 obj-$(CONFIG_MCF_EDMA) += mcf-edma.o
 obj-$(CONFIG_FSL_QDMA) += fsl-qdma.o
 obj-$(CONFIG_FSL_RAID) += fsl_raid.o
diff --git a/drivers/dma/fsl-edma-common.h b/drivers/dma/fsl-edma-common.h
index 3cc0cc8fc2d0..ecaba563d489 100644
--- a/drivers/dma/fsl-edma-common.h
+++ b/drivers/dma/fsl-edma-common.h
@@ -336,4 +336,12 @@ void fsl_edma_free_chan_resources(struct dma_chan *chan);
 void fsl_edma_cleanup_vchan(struct dma_device *dmadev);
 void fsl_edma_setup_regs(struct fsl_edma_engine *edma);
 
+#ifdef CONFIG_DEBUG_FS
+void fsl_edma_debugfs_on(struct fsl_edma_engine *edma);
+#else
+static inline void fsl_edma_debugfs_on(struct dw_edma *edma)
+{
+}
+#endif /* CONFIG_DEBUG_FS */
+
 #endif /* _FSL_EDMA_COMMON_H_ */
diff --git a/drivers/dma/fsl-edma-debugfs.c b/drivers/dma/fsl-edma-debugfs.c
new file mode 100644
index 000000000000..0f9a2cb57545
--- /dev/null
+++ b/drivers/dma/fsl-edma-debugfs.c
@@ -0,0 +1,120 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// Copyright 2023 NXP
+
+#include <linux/debugfs.h>
+#include <linux/bitfield.h>
+
+#include "fsl-edma-common.h"
+
+#define fsl_edma_debugfs_reg(reg, dir, __name)						\
+((sizeof(reg->__name) == sizeof(u32)) ?							\
+	debugfs_create_x32(__stringify(__name), 0644, dir, (u32 *)&reg->__name) :	\
+	debugfs_create_x16(__stringify(__name), 0644, dir, (u16 *)&reg->__name)		\
+)
+
+#define fsl_edma_debugfs_regv1(reg, dir, __name)					\
+	debugfs_create_x32(__stringify(__name), 0644, dir, reg.__name)
+
+static void fsl_edma_debufs_tcdreg(struct fsl_edma_chan *chan, struct dentry *dir)
+{
+	fsl_edma_debugfs_reg(chan->tcd, dir, saddr);
+	fsl_edma_debugfs_reg(chan->tcd, dir, soff);
+	fsl_edma_debugfs_reg(chan->tcd, dir, attr);
+	fsl_edma_debugfs_reg(chan->tcd, dir, nbytes);
+	fsl_edma_debugfs_reg(chan->tcd, dir, slast);
+	fsl_edma_debugfs_reg(chan->tcd, dir, daddr);
+	fsl_edma_debugfs_reg(chan->tcd, dir, doff);
+	fsl_edma_debugfs_reg(chan->tcd, dir, citer);
+	fsl_edma_debugfs_reg(chan->tcd, dir, dlast_sga);
+	fsl_edma_debugfs_reg(chan->tcd, dir, csr);
+	fsl_edma_debugfs_reg(chan->tcd, dir, biter);
+}
+
+static void fsl_edma3_debufs_chan(struct fsl_edma_chan *chan, struct dentry *entry)
+{
+	struct fsl_edma3_ch_reg *reg;
+	struct dentry *dir;
+
+	reg = container_of(chan->tcd, struct fsl_edma3_ch_reg, tcd);
+	fsl_edma_debugfs_reg(reg, entry, ch_csr);
+	fsl_edma_debugfs_reg(reg, entry, ch_int);
+	fsl_edma_debugfs_reg(reg, entry, ch_sbr);
+	fsl_edma_debugfs_reg(reg, entry, ch_pri);
+	fsl_edma_debugfs_reg(reg, entry, ch_mux);
+	fsl_edma_debugfs_reg(reg, entry, ch_mattr);
+
+	dir = debugfs_create_dir("tcd_regs", entry);
+
+	fsl_edma_debufs_tcdreg(chan, dir);
+}
+
+static void fsl_edma3_debugfs_init(struct fsl_edma_engine *edma)
+{
+	struct fsl_edma_chan *chan;
+	struct dentry *dir;
+	int i;
+
+	for (i = 0; i < edma->n_chans; i++) {
+		if (edma->chan_masked & BIT(i))
+			continue;
+
+		chan = &edma->chans[i];
+		dir = debugfs_create_dir(chan->chan_name, edma->dma_dev.dbg_dev_root);
+
+		fsl_edma3_debufs_chan(chan, dir);
+	}
+
+}
+
+static void fsl_edma_debugfs_init(struct fsl_edma_engine *edma)
+{
+	struct fsl_edma_chan *chan;
+	struct dentry *dir;
+	int i;
+
+	fsl_edma_debugfs_regv1(edma->regs, edma->dma_dev.dbg_dev_root, cr);
+	fsl_edma_debugfs_regv1(edma->regs, edma->dma_dev.dbg_dev_root, es);
+	fsl_edma_debugfs_regv1(edma->regs, edma->dma_dev.dbg_dev_root, erqh);
+	fsl_edma_debugfs_regv1(edma->regs, edma->dma_dev.dbg_dev_root, erql);
+	fsl_edma_debugfs_regv1(edma->regs, edma->dma_dev.dbg_dev_root, eeih);
+	fsl_edma_debugfs_regv1(edma->regs, edma->dma_dev.dbg_dev_root, eeil);
+	fsl_edma_debugfs_regv1(edma->regs, edma->dma_dev.dbg_dev_root, seei);
+	fsl_edma_debugfs_regv1(edma->regs, edma->dma_dev.dbg_dev_root, ceei);
+	fsl_edma_debugfs_regv1(edma->regs, edma->dma_dev.dbg_dev_root, serq);
+	fsl_edma_debugfs_regv1(edma->regs, edma->dma_dev.dbg_dev_root, cerq);
+	fsl_edma_debugfs_regv1(edma->regs, edma->dma_dev.dbg_dev_root, cint);
+	fsl_edma_debugfs_regv1(edma->regs, edma->dma_dev.dbg_dev_root, cerr);
+	fsl_edma_debugfs_regv1(edma->regs, edma->dma_dev.dbg_dev_root, ssrt);
+	fsl_edma_debugfs_regv1(edma->regs, edma->dma_dev.dbg_dev_root, cdne);
+	fsl_edma_debugfs_regv1(edma->regs, edma->dma_dev.dbg_dev_root, inth);
+	fsl_edma_debugfs_regv1(edma->regs, edma->dma_dev.dbg_dev_root, errh);
+	fsl_edma_debugfs_regv1(edma->regs, edma->dma_dev.dbg_dev_root, errl);
+
+	for (i = 0; i < edma->n_chans; i++) {
+		if (edma->chan_masked & BIT(i))
+			continue;
+
+		chan = &edma->chans[i];
+		dir = debugfs_create_dir(chan->chan_name, edma->dma_dev.dbg_dev_root);
+
+		fsl_edma_debufs_tcdreg(chan, dir);
+	}
+}
+
+void fsl_edma_debugfs_on(struct fsl_edma_engine *edma)
+{
+	if (!debugfs_initialized())
+		return;
+
+	debugfs_create_bool("big_endian", 0444, edma->dma_dev.dbg_dev_root, &edma->big_endian);
+	debugfs_create_x64("chan_mask", 0444, edma->dma_dev.dbg_dev_root, &edma->chan_masked);
+	debugfs_create_x32("n_chans", 0444, edma->dma_dev.dbg_dev_root, &edma->n_chans);
+
+	if (edma->drvdata->flags & FSL_EDMA_DRV_SPLIT_REG)
+		fsl_edma3_debugfs_init(edma);
+	else
+		fsl_edma_debugfs_init(edma);
+}
+
+
diff --git a/drivers/dma/fsl-edma-main.c b/drivers/dma/fsl-edma-main.c
index 63d48d046f04..029a72872821 100644
--- a/drivers/dma/fsl-edma-main.c
+++ b/drivers/dma/fsl-edma-main.c
@@ -612,6 +612,8 @@ static int fsl_edma_probe(struct platform_device *pdev)
 	if (!(drvdata->flags & FSL_EDMA_DRV_SPLIT_REG))
 		edma_writel(fsl_edma, EDMA_CR_ERGA | EDMA_CR_ERCA, regs->cr);
 
+	fsl_edma_debugfs_on(fsl_edma);
+
 	return 0;
 }
 
-- 
2.34.1

