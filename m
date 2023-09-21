Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DDFE7A9770
	for <lists+dmaengine@lfdr.de>; Thu, 21 Sep 2023 19:24:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbjIURYL (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 21 Sep 2023 13:24:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbjIURXu (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 21 Sep 2023 13:23:50 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2070.outbound.protection.outlook.com [40.107.20.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 126F97A8D;
        Thu, 21 Sep 2023 10:05:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h+pRV9sIBykduaHjIQRobDIk1hBfs3O+5f0gdEAdNa+45fHpyD1tgNC1YehotS7tFpuj76dI+ScaaQhzM+f7YlH8MnnVX8ffZYdwKXKGN1MlzE1ruzzGqiuSzTHaLYj78wPM+oFZML/jgaEUTP7gWHB0pw/t2wKDmdnei4Fubu8TMqSMJXV5zOBC+8vBKwZjCgUp3bEyqfqu88rkUdk9EfjLrbQNQeFmwK7qNPXebQawcVe1/wnZ7567iob75h4pbsPXJ6FywTdsM5G23JyjrCZ1si9bcehG0y6h8Ib/vvn7Iti3mxxhr99g6Ioq1Z4RjAqAQvFyAJ8phW8i0/YOSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=heqmdTVqfhnLxI+2CClLhvw/xF82JJ11whNOuB/AQ0g=;
 b=HEeo+lrRFF1mzZPRJlrv9SSjI1Z7wv9SB00n5pb3rQybtwfpU9arrjM09h9lM0nhOPeEeXGGEVa6gQITk9tqSiyUr2VGxucqDcYsV5kf1BzUEqfcnqNjn+4KUNeTykW5ftOT/JPEE/9DldS9bjxK/gmx/ZW39tVm0kNEWptsOkyG93iIbI0cwaXJLRKoM0rOuKntE6e6EQ3GRoobojoyhLi1Be+7q+cwV3Eylj8IL2fMyFSRBw6FpdMgZMQbKlbznhF+WNYwSNsuXISDTMtUsAteuocfeYh6tel+/Zy/E4ej5RXFDDX9ZAxB14GIbCIH7Gd8cfLzgDO8QlrJ755oTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=heqmdTVqfhnLxI+2CClLhvw/xF82JJ11whNOuB/AQ0g=;
 b=Q5oA6DiWpWxxL91/nkqD6GGVODOnsI/IoEkxd3Leq/DV+NUgmABDrhOZj7d3o2lWGc0poWCK39E7nBCK7A/0UyHr1tInVq5ZnCSgPCJSYoXOVMWuAFZBbd8euuNkxVwhDrphXS27gIpKWnpctV5kp+5psbNlbj0Z7XNxc2DWkKM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by PAXPR04MB8590.eurprd04.prod.outlook.com (2603:10a6:102:219::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.20; Thu, 21 Sep
 2023 15:02:11 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::1774:e25f:f99:aca2]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::1774:e25f:f99:aca2%4]) with mapi id 15.20.6792.026; Thu, 21 Sep 2023
 15:02:11 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     frank.li@nxp.com
Cc:     dmaengine@vger.kernel.org, gregkh@linuxfoundation.org,
        imx@lists.linux.dev, linux-kernel@vger.kernel.org, lkp@intel.com,
        oe-kbuild-all@lists.linux.dev, rafael@kernel.org, vkoul@kernel.org
Subject: [PATCH v4 2/3] dmaengine: fsl-emda: add debugfs support
Date:   Thu, 21 Sep 2023 11:01:43 -0400
Message-Id: <20230921150144.3260231-3-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230921150144.3260231-1-Frank.Li@nxp.com>
References: <20230921150144.3260231-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR17CA0007.namprd17.prod.outlook.com
 (2603:10b6:a03:1b8::20) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|PAXPR04MB8590:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a4f5142-5388-4e14-c8a8-08dbbab3bb99
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OsQbZOjAmFX7reFOcykNlTVBG8gEuiFRRDwer+We7IEfpq7H9lovNnswlBxf2lVBjXFEfZpUUZn4xFxRwg1eozRNbl7o4nTsneJ/iJF0W/hmpl/XlGoJHXDfT8g6KAZ3WG1HYaacVyb0xLnuac6Sh2o1980cx5dhvLvtHXFvHa9rBOnDqSiPmYi9bH3azuX/6kKMJEuPtjC9ek5Lh/Supy0cO4LzNzqKxe6D4NUa+QNFqjgnr6tCwcDhHSgmItbAJbGOS+BUDfn8f4ofNdBhK/CuDcsEV3+HkJWx18tL2i3n6Qdr+i9/rw2QRZqK+BrgDE/4kIu7cXdRvzyJUspgxbh9g63jTd39QdL/5YOOrPEiVwsyibmAxuWkq3wi5f+LsrF7b+9R9RQL5N8ZtGsb75UsHUFVS/pLNy2lPc9/plu9tCBsnfNr/hb/eX+HzmNphGizI/k9SRLU1HXVCBRtHdAQvN1+faVFJ1zQ9naZ5t/BDJM8gsn3nedWnLc6mYdclrfcmbGo+TWKarVvkAZmav5PxAuJiKCp7ZjACXc74HkEC14NMcUDZDUx54u8bivkSB//qXBNWkfQ8mm+KW0duq/qByl+ptOMOUlN2BMiAM1MYFEnXEdGySBU4bKhXOGb
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(366004)(346002)(136003)(376002)(1800799009)(451199024)(186009)(6666004)(38100700002)(83380400001)(38350700002)(2616005)(1076003)(6512007)(41300700001)(86362001)(4326008)(2906002)(34206002)(8936002)(8676002)(5660300002)(6486002)(52116002)(66946007)(66556008)(66476007)(6506007)(37006003)(36756003)(316002)(26005)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?58pznj1LzGX70ABpERQ2x46bug5N9JHdix8HauhAVOyZaQRaLRrEtuq+cchq?=
 =?us-ascii?Q?m9ES3i0jRuhzzusUei4hPsgtpqgcT6ToMrsuz5gOkFcOuikC6emdRf+lg6vN?=
 =?us-ascii?Q?b1Sf6RMqdjeEX6nEjr1No3HXsE5MO2ZIqRuuESBldePh1wUaSiQJWUuInPx9?=
 =?us-ascii?Q?5sUrs6eKfhQag+qczYaax0VlZ1TzGdZQGfErkx0wcohakChv03vwU6qNogue?=
 =?us-ascii?Q?Y5ARZQchCtbcuM41OUbpiKxGEHT2l1207eZF8Ci6F0G56i9ShzeeSO1TYiFC?=
 =?us-ascii?Q?oW52FdCcs3/PtTszygDbDqgUSMjPgdGsyXp4AV7nL5f4bBi0criJ/Mz262yD?=
 =?us-ascii?Q?yaggtCl9vEHQK3yd12u4j6cTOIc3CyANDOEgINLx+jQcjwKEbQJYZlpINaTZ?=
 =?us-ascii?Q?BhoBzqQFPHEA8w+DJP243WEoeYOz8lwfcv7nQua/OF0i6cYnoMIzPQZNS1gi?=
 =?us-ascii?Q?gkYFN107CQqvxMIlpcjageG3ppGAtp59SClq3EhAQykgSmv7f2fUt2nOQrH/?=
 =?us-ascii?Q?348TETon58GQVMMwZsqPyaPffndhzFJZIjltk8tz3BsOH/nDZsqQM1+qgnM9?=
 =?us-ascii?Q?V028eQioLNTFUFAF+pYSqcUOnKWNjyXfhoytl3MpKykM9vrQ7kayBlWjsc5G?=
 =?us-ascii?Q?b34PbQmhJ31YSshzqRi620Ql5SZuj918n9WZPy/+1JE2MFn5qbuuWE7ZmoCO?=
 =?us-ascii?Q?Zo8uBNqxbpT9Ig1gjsi68x7jdAlHX+iMpzo2deHNUJsgewNIZ0/1zpVB6ygg?=
 =?us-ascii?Q?QFl/i2k4hiCkdnFq+BAMENtAbd4tFkWRTwj3nwMB2y/CwDaunVCd3MbswDE9?=
 =?us-ascii?Q?B/WaSDu2EUOtqFJ31j69OTafuAT3nm9lMJclhffx/2QL2W83to9S+ownAMTk?=
 =?us-ascii?Q?DiXrL9pRrVXHrmtQzqCTPV0K+PcdFhqVZxc17P5xoqy6DAqjm7fpNcFxe/8D?=
 =?us-ascii?Q?MruAktwaFC94juPr+6iBYaLC3uRsx3ZucpEr89yUgquGR/sDivsT2wlwrHmO?=
 =?us-ascii?Q?yDQtozwVhIB21JvHUNSC7BIHZwFSGSU4xudkNVkzHzO97/ZozGXwe5hb14nI?=
 =?us-ascii?Q?0K3qIcG8iwWMBMmCdMeft3pwrZSTB35h0/mbaw3Ru9CsqdncIsFuhTyQDmkz?=
 =?us-ascii?Q?9Jai12p+0Dpob6B9uX2xDDqXkJsfk8Rh2TL1JGA5dij4NOVunPh3deMwoS/L?=
 =?us-ascii?Q?lE7VxyCIde6mTbR9BZ1Gtmfdns2gd+TScy9ZY546dJFWbZzweYMJokX7Y8B+?=
 =?us-ascii?Q?9Aq9rEnMISrY8WDeJCrgWIaYxULk9h94cL8wPe0grLGGEbD9Xip3ad687+jm?=
 =?us-ascii?Q?NoTDREEVPs7kTORf3n+JeELEemY02CPUju0Sr+Z/PwKAEz06I9ZIU5iTJ0uO?=
 =?us-ascii?Q?QJPu/45GDNSKwRkh7V7xomZQRvbDGM3uK0voJ+UIa02U5QQWdRvCLLdKDbUq?=
 =?us-ascii?Q?CbGE5006QwCR5vOoZKI1+FG1VhtcZoHT1GqamMW9sQTaMls40S8w3S1QziJp?=
 =?us-ascii?Q?lR0JIzLQWdBVqmBLJRXQLRo7Gxk/grh61kEKsB11P1uxzodkzrCwZQjzb7ZZ?=
 =?us-ascii?Q?/NnsXekoizo2EC6FQDeqVEHt0I4wB7WAEgTbBCkf?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a4f5142-5388-4e14-c8a8-08dbbab3bb99
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2023 15:02:11.3948
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nOQNlB7SF8x/xezLh/je5siAISG6iU/ZGxsb0p+dQzJMdFxaspKaTWrFFM3GN3rVe8A6Mc0gb+cZc0DayeaVnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8590
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
index 83553a97a010e..a51c6397bcad0 100644
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
index 3cc0cc8fc2d05..029197440bc34 100644
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
index 0000000000000..99f34198dae05
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
index 63d48d046f046..029a72872821d 100644
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

