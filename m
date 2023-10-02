Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 233BE7B5A5F
	for <lists+dmaengine@lfdr.de>; Mon,  2 Oct 2023 20:42:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238795AbjJBSiZ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 2 Oct 2023 14:38:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238790AbjJBSiY (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 2 Oct 2023 14:38:24 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2076.outbound.protection.outlook.com [40.107.6.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9AB4B8;
        Mon,  2 Oct 2023 11:38:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K90m1Ue2NGFbEBCLWCr5C0TYVbQdPyKxhutyzPYYsPRx0EWH4o2euhNNm6qEfNTuRDv52SEKjoYpnzyd5BhMtZxpwR/R5G+eMr/piqZbdb/zGGus2bM+pBP2cCfNgNZ/Jp7u+KfspCqSDznzSGfyY3gJV1TWnsZe7hDuUwYE/6Fv14aP0tGCizdT8fpG9tSRnuLHPJWelRAGsOWWbRakdn9TMTPN1mVdKTrGwhOXElDorFKKv5oNLk9+tZDJRxOvi5/OGel8rwYwcYQCM3myJMuQNYrMqD0rfEBFsKdga1YCtIJzBTv/mR4qrCUt2IySmu8cFlsDR9tF6D1nNmamyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KrrRSsmz8JDYKRnhitxLdhGClwA1D4DSztdMBen7IAg=;
 b=Wdhng7PcUBa+TbT/eWlu/MsFUS+Ia1lX9FTJfnYvl+Gp1LFqYuMUEBzC3Qvd43uH/s6sWL2CRR/9FTqaFuYIWsoCVbD1joYGo1DtkbdtptgJWSPmuu1oDZ1PQloH1Iizpy/styeCjzMl6/cOiOojxi/b9P2ChcZdwKVrDRRSLF8lVoloYKbk6ZulXTuuPbHmvx0hG2v2JF1vKYkliyHzbnSZEhgkB5PqJV6Uig1+DJmMmpKMzVILH2sF/JiFTE6PNwvYWyVKnjo4JdEnx0ZP9uo0Kx8awuJ4amq9by2MipNJ3RDPVzR3efW7JFKIPDRokMg7KnUki6yGtil/wPS6Wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KrrRSsmz8JDYKRnhitxLdhGClwA1D4DSztdMBen7IAg=;
 b=lsgPq3WMOAeZF6+d79k1/8ne+ou9b7B+EqTsi9/thyRPg3SVZFOVGKOe3GOy+zAhXqJc4d41ou/F/4k9wu8ogxA895vM//1HUfv1fkhU+A5HDIyYML6NtAsdqc6QAMYb/jENyN/PMC/Q6auRWunhGxYsb+O2ILs1DIpqmje81Ac=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by DB9PR04MB9283.eurprd04.prod.outlook.com (2603:10a6:10:36d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.24; Mon, 2 Oct
 2023 18:38:18 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::1774:e25f:f99:aca2]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::1774:e25f:f99:aca2%4]) with mapi id 15.20.6813.027; Mon, 2 Oct 2023
 18:38:18 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     arnd@arndb.de, vkoul@kernel.org
Cc:     Frank.Li@nxp.com, bhe@redhat.com, dmaengine@vger.kernel.org,
        gregkh@linuxfoundation.org, imx@lists.linux.dev,
        linux-kernel@vger.kernel.org, lkp@intel.com,
        oe-kbuild-all@lists.linux.dev, rafael@kernel.org
Subject: [PATCH v5 2/3] dmaengine: fsl-emda: add debugfs support
Date:   Mon,  2 Oct 2023 14:37:49 -0400
Message-Id: <20231002183750.552759-3-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231002183750.552759-1-Frank.Li@nxp.com>
References: <20231002183750.552759-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR07CA0016.namprd07.prod.outlook.com
 (2603:10b6:a02:bc::29) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|DB9PR04MB9283:EE_
X-MS-Office365-Filtering-Correlation-Id: 8245185b-02bd-45c6-9f38-08dbc376bf1a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VMJxXemfUtfDNujqvk5IH+nbU/ZD0pqiM1XhVIYy3KTD6jDwsE8eGM8TX19hFJNJOtZyueQ3uuc+sTxrYgWK/nV95XXl64XYSyye4kY1+NYsaOcxzvYceocBg46Rv0tvIJvuzKoGm08DFgCufqyGoTEjXQa2/bftFHh8HuvuD1WMYcnB8e9LSzxuo7Sp1AYFdEzqiQOgZ+3JelwTbunBaQicHwvcrnilneFuCDTaWqsuS0it22YejcxefLPk2E5oalPNXtNLcP6C1Oyln6tfhS8nD7jpUKIAIVwpPlxBYEkIfIglVBal0ZEjAiYdy4e/ZXwQEMJG1rKrN5vJd2zTL7PBlUJe65hAM2xxyNQ3avbrxM6gSQ4E/1QjgR6kZE6yW9NGkrA5pHjaILbsH7d5sOM0lb12t4x+TDj23JXl1U2mIFo5LxBNRcaoG4v+e5z7ShgzTPjyJY1T9whYj5t3s9kWHGQEr/TEnE2riqvT6XwOA4C4acIkdPXL8i1KGJBTuk5Y20teDhByDbEf8KlmeCEqp+2Q4M72/6h8i/XhFOpW0VPuJIX9uajcEld/f1pjIHprt+Y0pB6DRHSI2cyb1b1DT8S++CnO2MGBFBcSqqKvhUHPHFkYugkM0ghR4GNZ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(376002)(396003)(346002)(366004)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(52116002)(2906002)(7416002)(41300700001)(8676002)(4326008)(8936002)(5660300002)(316002)(36756003)(66946007)(66556008)(6506007)(478600001)(6512007)(38100700002)(6666004)(1076003)(86362001)(38350700002)(2616005)(66476007)(83380400001)(26005)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dFBmKFYwGuoGfzxeSu9WkFE6BSLF75u5SP1VBbojbsey6oczbwTE7f+W/i67?=
 =?us-ascii?Q?lPQ2cv/sIclIxCH3ZuXugC7N+ELDHzW+DXGvdq6YNm0Zae1Ks50ePolIoHBr?=
 =?us-ascii?Q?kr5i1EJGNWkR56aXOibNseoJ6dmYHAHHkkhb6Vo6np0nQPzLwg8+Ys0CG8RX?=
 =?us-ascii?Q?z4avWz4MgJ2KEJLtPOApaKCLG4VPQv3vWPlgAd/NpLxz21K49J17rOQ2Vxej?=
 =?us-ascii?Q?91desngHWb5NZ8//1Zppx5TvJDIfMzx8RA1PLYuGnGGKyoIljmZPSl09ixUF?=
 =?us-ascii?Q?mM8Q3jHkUmvEa13YhZVRcD/SIk9LHkxPCN8z51p/OAxccrScae7DLtStjFSz?=
 =?us-ascii?Q?YspTMr1Ho9jpviaLDpo6YXAg7tJsj1dKa4VZmPwe4PpA6ZbmR+rlxBZHk/4J?=
 =?us-ascii?Q?Zt+xdAPjfD1oMiw6Yjf0WS90vTAtitY7W+2awrGbQUYjvv1P7u8HBqZV+pwb?=
 =?us-ascii?Q?hurosIcFJDm4YBUGn1KAGMv+o5PKEd+BAqFXZNWizEeaNcDPCYxyzi/sM2gp?=
 =?us-ascii?Q?8sg1euUU3U9jVkbxWT33CSE0D2J6HwdpuXjQAVY3oftVX0AMD4mK5dnkve2a?=
 =?us-ascii?Q?IpCE49IoTHk1NgqOpUVEX9aoKhgyIczm1y7EOgovMqEloUCWE6ZLZabk/JKG?=
 =?us-ascii?Q?zhQjzLwBNUtb8Xj9knUp2rzqeGKa1zOIv4zO05RKzCTOwOWGx/ulrVZn+O++?=
 =?us-ascii?Q?e6gpZeQpvcF779LlrzalY1ODJiPo8RwMKOz9fMFrRGtYvdSKkyZ7EwVaauUo?=
 =?us-ascii?Q?0XLwJwagnUohx6Jv6TRkYbesqZFn6Z04d7SWhqk1RJ1T5ccePPOgVhaTnusD?=
 =?us-ascii?Q?py91ZnOcmcyUwYQvg9z7zM5qGpl8tG4kSFZCfKmQ3y3AQxG+egWVF5Igv+ZY?=
 =?us-ascii?Q?qL0abmLC5+23T8UuKR3khKwJ0vQvP1lZULKHMIP1I+12gQiF0nFi+fsGRB+y?=
 =?us-ascii?Q?zuJqnVIVHAuyxrbCrJFlf2ASX69PzM5+u29xoCZxnn5aU7MnR7ybCYfNIGUZ?=
 =?us-ascii?Q?ZeO8X4o26zwxhHnbGHkzj9UFvvMGzgPLsx/QTQr5s0GuWog6Xk1njX3FkPkY?=
 =?us-ascii?Q?U2EzOlZW2eCDZYYGYAn86j/TtV85X508K1ibpz9/IUjri6iTySJRoUZzrniu?=
 =?us-ascii?Q?H8uxECUW2nsMJO+QQDBg//vb2WGcpcQD21P/xmfeIQC2A5ssbELOnxDGoBLD?=
 =?us-ascii?Q?9ZPBDB4J3NOLBDwmL0xUpH8MLsIE/47Kcwf0qFsmGTfMUC0eF2dTlbsjYReE?=
 =?us-ascii?Q?pXbA+TimhHyDRViMjGx/hXMsWmepCG6k1hUPkWf1cF8U94IfDxEpYRjNco3K?=
 =?us-ascii?Q?rf6efxq4wCJvOxch6SE+ja4t53u8H+pr6JHAzDnwvQjGRPUZOYKOzF7kWL3t?=
 =?us-ascii?Q?h68R0TPWdQ55q5Sjh4kzti8CzzS7HFNVbDzsWGQMLHl3r7462Ilf7QPgqdw1?=
 =?us-ascii?Q?Hzx0AK6TH9yc9y8SS42EicOJAOtKoeYrlihHp2CWLnpomNfu4Jq4Oemg+qYC?=
 =?us-ascii?Q?0TRjQ3tQVvGv0qrDZ8LrlvBYlkBpYupUA8AixTTqOQD/KjOdTIUc9TmlLPHJ?=
 =?us-ascii?Q?uHSysxWYyV0IqFRXo+WgxnoTPWjNuchodhsuD6wJ?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8245185b-02bd-45c6-9f38-08dbc376bf1a
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2023 18:38:18.4314
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S4o06b8Tp/NZ7QQ4L2QLdM8Otc7rhZEa1QL8dlyFPrT8znnrwAdbawjF1SJWZ2NBhB5ltOLdKP0sw2SGbyKP2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9283
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
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
 drivers/dma/fsl-edma-common.h  |   8 ++
 drivers/dma/fsl-edma-debugfs.c | 200 +++++++++++++++++++++++++++++++++
 drivers/dma/fsl-edma-main.c    |   2 +
 4 files changed, 213 insertions(+), 2 deletions(-)
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
index 3cc0cc8fc2d0..029197440bc3 100644
--- a/drivers/dma/fsl-edma-common.h
+++ b/drivers/dma/fsl-edma-common.h
@@ -336,4 +336,12 @@ void fsl_edma_free_chan_resources(struct dma_chan *chan);
 void fsl_edma_cleanup_vchan(struct dma_device *dmadev);
 void fsl_edma_setup_regs(struct fsl_edma_engine *edma);
 
+#ifdef CONFIG_DEBUG_FS
+void fsl_edma_debugfs_on(struct fsl_edma_engine *edma);
+#else
+static inline void fsl_edma_debugfs_on(struct fsl_edma_engine *edma)
+{
+}
+#endif /* CONFIG_DEBUG_FS */
+
 #endif /* _FSL_EDMA_COMMON_H_ */
diff --git a/drivers/dma/fsl-edma-debugfs.c b/drivers/dma/fsl-edma-debugfs.c
new file mode 100644
index 000000000000..99f34198dae0
--- /dev/null
+++ b/drivers/dma/fsl-edma-debugfs.c
@@ -0,0 +1,200 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/debugfs.h>
+#include <linux/bitfield.h>
+
+#include "fsl-edma-common.h"
+
+#define fsl_edma_debugfs_reg(reg, b, _s, __name)	\
+do {	reg->name = __stringify(__name);		\
+	reg->offset = offsetof(struct _s, __name);	\
+	reg->size = sizeof(((struct _s *)0)->__name);	\
+	reg->bigendian = b;				\
+	reg++;						\
+} while (0)
+
+#define fsl_edma_debugfs_regv1(reg, edma, __name)	\
+do {	reg->name = __stringify(__name);		\
+	reg->offset = edma->regs.__name - edma->membase;\
+	reg->bigendian = edma->big_endian;		\
+	reg++;						\
+} while (0)
+
+static void fsl_edma_debufs_tcdreg(struct fsl_edma_chan *chan, struct dentry *dir)
+{
+	struct debugfs_regset *regset;
+	struct debugfs_reg *reg;
+	struct device *dev;
+	int be;
+
+	be = chan->edma->big_endian;
+
+	dev = &chan->pdev->dev;
+
+	regset = devm_kzalloc(dev, sizeof(*regset), GFP_KERNEL);
+	if (!regset)
+		return;
+
+	regset->dev = dev;
+	regset->base = chan->tcd;
+
+	/* sizeof(struct fsl_edma_hw_tcd)/sizeof(u16) is enough for hold all registers */
+	reg = devm_kcalloc(dev, sizeof(struct fsl_edma_hw_tcd)/sizeof(u16),
+			   sizeof(*reg), GFP_KERNEL);
+
+	if (!reg)
+		return;
+
+	regset->regs = reg;
+
+	fsl_edma_debugfs_reg(reg, be, fsl_edma_hw_tcd, saddr);
+	fsl_edma_debugfs_reg(reg, be, fsl_edma_hw_tcd, soff);
+	fsl_edma_debugfs_reg(reg, be, fsl_edma_hw_tcd, attr);
+	fsl_edma_debugfs_reg(reg, be, fsl_edma_hw_tcd, nbytes);
+	fsl_edma_debugfs_reg(reg, be, fsl_edma_hw_tcd, slast);
+	fsl_edma_debugfs_reg(reg, be, fsl_edma_hw_tcd, daddr);
+	fsl_edma_debugfs_reg(reg, be, fsl_edma_hw_tcd, doff);
+	fsl_edma_debugfs_reg(reg, be, fsl_edma_hw_tcd, citer);
+	fsl_edma_debugfs_reg(reg, be, fsl_edma_hw_tcd, dlast_sga);
+	fsl_edma_debugfs_reg(reg, be, fsl_edma_hw_tcd, csr);
+	fsl_edma_debugfs_reg(reg, be, fsl_edma_hw_tcd, biter);
+
+	regset->nregs = reg - regset->regs;
+
+	debugfs_create_regset("tcd", 0444, dir, regset);
+}
+
+static void fsl_edma3_debufs_chan(struct fsl_edma_chan *chan, struct dentry *entry)
+{
+	struct debugfs_regset *regset;
+	struct debugfs_reg *reg;
+	struct device *dev;
+	int be;
+
+	be = chan->edma->big_endian;
+
+	dev = &chan->pdev->dev;
+
+	regset = devm_kzalloc(dev, sizeof(*regset), GFP_KERNEL);
+	if (!regset)
+		return;
+
+	regset->dev = dev;
+
+	reg = devm_kcalloc(dev, sizeof(struct fsl_edma3_ch_reg)/sizeof(u32),
+			   sizeof(*reg), GFP_KERNEL);
+
+	if (!reg)
+		return;
+
+	regset->base = chan->tcd;
+	regset->base -= offsetof(struct fsl_edma3_ch_reg, tcd);
+
+	regset->regs = reg;
+
+	fsl_edma_debugfs_reg(reg, be, fsl_edma3_ch_reg, ch_csr);
+	fsl_edma_debugfs_reg(reg, be, fsl_edma3_ch_reg, ch_es);
+	fsl_edma_debugfs_reg(reg, be, fsl_edma3_ch_reg, ch_int);
+	fsl_edma_debugfs_reg(reg, be, fsl_edma3_ch_reg, ch_sbr);
+	fsl_edma_debugfs_reg(reg, be, fsl_edma3_ch_reg, ch_pri);
+	fsl_edma_debugfs_reg(reg, be, fsl_edma3_ch_reg, ch_mux);
+	fsl_edma_debugfs_reg(reg, be, fsl_edma3_ch_reg, ch_mattr);
+
+	regset->nregs = reg - regset->regs;
+	debugfs_create_regset("regs", 0444, entry, regset);
+
+	fsl_edma_debufs_tcdreg(chan, entry);
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
+	struct debugfs_regset *regset;
+	struct fsl_edma_chan *chan;
+	struct debugfs_reg *reg;
+	struct dentry *dir;
+	struct device *dev;
+	int i;
+
+	dev = edma->dma_dev.dev;
+
+	regset = devm_kzalloc(dev, sizeof(*regset), GFP_KERNEL);
+	if (!regset)
+		return;
+
+	regset->dev = dev;
+
+	reg = devm_kcalloc(dev, sizeof(struct edma_regs)/sizeof(void *), sizeof(*reg), GFP_KERNEL);
+
+	if (!reg)
+		return;
+
+	regset->regs = reg;
+	regset->base = edma->membase;
+
+	fsl_edma_debugfs_regv1(reg, edma, cr);
+	fsl_edma_debugfs_regv1(reg, edma, es);
+	fsl_edma_debugfs_regv1(reg, edma, erqh);
+	fsl_edma_debugfs_regv1(reg, edma, erql);
+	fsl_edma_debugfs_regv1(reg, edma, eeih);
+	fsl_edma_debugfs_regv1(reg, edma, eeil);
+	fsl_edma_debugfs_regv1(reg, edma, seei);
+	fsl_edma_debugfs_regv1(reg, edma, ceei);
+	fsl_edma_debugfs_regv1(reg, edma, serq);
+	fsl_edma_debugfs_regv1(reg, edma, cerq);
+	fsl_edma_debugfs_regv1(reg, edma, cint);
+	fsl_edma_debugfs_regv1(reg, edma, cerr);
+	fsl_edma_debugfs_regv1(reg, edma, ssrt);
+	fsl_edma_debugfs_regv1(reg, edma, cdne);
+	fsl_edma_debugfs_regv1(reg, edma, inth);
+	fsl_edma_debugfs_regv1(reg, edma, errh);
+	fsl_edma_debugfs_regv1(reg, edma, errl);
+
+	regset->nregs = reg - regset->regs;
+
+	debugfs_create_regset("regs", 0444, edma->dma_dev.dbg_dev_root, regset);
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

