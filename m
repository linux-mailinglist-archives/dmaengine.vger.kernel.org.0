Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E35A87A97C1
	for <lists+dmaengine@lfdr.de>; Thu, 21 Sep 2023 19:27:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229975AbjIUR1g (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 21 Sep 2023 13:27:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229886AbjIUR1F (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 21 Sep 2023 13:27:05 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on0625.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe0e::625])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98DADCCF;
        Thu, 21 Sep 2023 10:01:14 -0700 (PDT)
Received: from AS4PR04MB9650.eurprd04.prod.outlook.com (2603:10a6:20b:4cd::6)
 by AS1PR04MB9382.eurprd04.prod.outlook.com (2603:10a6:20b:4da::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27; Thu, 21 Sep
 2023 16:27:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F8PqlsJKCBtMLPqPgueeBjPQlK+JzRstgNaBKvW7INe9ZDmS7PDR5O+SXqhK0PQOIvuPus3AW8cjYQTgTv7WQsXuAYWQfb9imeYS7aK6cCOryhLyf2ARpZNOX9+XEMoioQRCBLM6w9NO8GddzxJ2T7mTVjFn0iHAOWtyoRostinVdmsEXtI5MuBXcVym03DzMskptBBGH5bs7LSzqXu+0hshSHV/5VSFCo9xIgqXHl0U0B6XmhvisM/6MRCMTCJZCOZ/jm+bcZO5LD3GUy73ZH+xlk0ulScuqEuXIJhU3fHEfH43HRRIRz24TDg7l+HkK2+FyBQrppZoir2EhHwDhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hLXFRZ4eggS0ZMuZ15BPG2khGq5rICDQoRXMnUYA+UI=;
 b=ZCF5LxBdtG5wonrS+7zbTD4oMAFPVVeXazQppMfcXB2nM30LMcIFBOaRCtGK1BEChD8MBED6D08b2gPDiZuuaOvrvGt+lF0cxYEpNM21ARCSqoC4nUIAtuYsIeAqoRXwEGo6ZxRlerKjpV1iFjtezrn6ejb3yS9eEw1eeKrdA/RO/QIVBv/TPfvRlZoXf5oZAGPq2BJKN9M3Fl2H8aFn145OEtWCn2i7SdLxODL/DVenKUHJ3IgTRuRn92/YLvHs63I0jdccBihbeZCUUmDbj8qsgzWzRQgrhSJVjh0Qq6fGiGMABhvptx7hlcV8rLUP6LSO0RQKuIPjzcmbzTsTXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hLXFRZ4eggS0ZMuZ15BPG2khGq5rICDQoRXMnUYA+UI=;
 b=EP6ZQ/gyMzAg80+3f3Ib0igQ/vF8UvQE7YFFPZyDVULZZ2Cc1vGeIypboE5jFBcvjteMP5IZylg7V6HsPKSnmZRc03Nz61VSQnrrS1ZtAnGuv6i2HYO9Uym74mUxwc8G/EEYEaHKJITBs0d7eDoSSfLLMNOP9dwHL6PcPAGG4WY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by AS4PR04MB9650.eurprd04.prod.outlook.com (2603:10a6:20b:4cd::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27; Thu, 21 Sep
 2023 15:02:14 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::1774:e25f:f99:aca2]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::1774:e25f:f99:aca2%4]) with mapi id 15.20.6792.026; Thu, 21 Sep 2023
 15:02:14 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     frank.li@nxp.com
Cc:     dmaengine@vger.kernel.org, gregkh@linuxfoundation.org,
        imx@lists.linux.dev, linux-kernel@vger.kernel.org, lkp@intel.com,
        oe-kbuild-all@lists.linux.dev, rafael@kernel.org, vkoul@kernel.org
Subject: [PATCH v4 3/3] dmaengine: fsl-edma: add trace event support
Date:   Thu, 21 Sep 2023 11:01:44 -0400
Message-Id: <20230921150144.3260231-4-Frank.Li@nxp.com>
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
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|AS4PR04MB9650:EE_|AS1PR04MB9382:EE_
X-MS-Office365-Filtering-Correlation-Id: 11e08d87-7596-4157-ac3e-08dbbab3bd4b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PQ/K+LLJtJ7K+Ok11bqx4ciK1wnDyiIZVEfjCz0PDMG7jOjDKcDwc/RLmKkBulPbdhrPF9NGB+8Fi2jzM/p2ITWYPi9hSsmmCzQnwVCaWBx72Yg3J/61q9ChxVvdaIC8uT0VlSZ7k1A2H71fJbHSwG9uVou39KBpiDkQjDgHpV+rAwD85fHShNVM5sckSgQZy2nPtNO7KO090EilwNInNtNu5Alw+4utQC01Hh7Prqhsn4t4gJeh13B6OdjqMEeXVZCn76GW0AZf21ChgPpQh2ZG13Rx8radKCcCeiNVVX5YarqHAsC13TLXC8WniFxEdZ6z5+kkV22vYozGBfG4NYIfxweEzftfveFu1Y0E0nInqbl4o65DFFylaAQIbHGxqMWV0cGkHjT6qXV4Xo+/BCxGdqM/Hc7SBH1FSizX56Gme8Ebdxzbtq8dfFSimUA78mG/XBwGqJcXBI2Hqfw4/77RA2dCCZFTe6RhDeo8D99ZbAXgN4i9e+FyjPW9QX2uRa6frdb/mSc44AkT6xs+qvTHW8Tg6M9bk1F0FVXnixCADOqy/ESDZCtORi2VKTxajjN0wUlub9Q1F8qjYOJbluMjfhKWSxKPu0cEyh7XL/MdiYfgFXyFh2giCwsmnBI4
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(136003)(396003)(346002)(39860400002)(1800799009)(186009)(451199024)(37006003)(66476007)(66556008)(66946007)(52116002)(8676002)(316002)(34206002)(41300700001)(478600001)(6506007)(1076003)(6512007)(6666004)(83380400001)(8936002)(86362001)(38350700002)(5660300002)(2616005)(4326008)(26005)(2906002)(38100700002)(6486002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OBT+qHfbNoKhhx9ZTMUqMupjHLCdGlr2cfMkqWB6jPSmi/f0msCIYnzeltni?=
 =?us-ascii?Q?CdhyrAFE5EmFBrBCGKgbFHJWaGUrT2IlYUr2zn6qzpmc+qmHAmmowKuaq4kb?=
 =?us-ascii?Q?m5bYPFYMINVl5LQdMeCM9nvyYWIPHHn2oRkZY5KmG/QUtiPnLU+zM82kczEB?=
 =?us-ascii?Q?DKTJeLNerp/YJT3n27LrFj+7NIPKl18go3N20FpQRB6G+qY0bs0ywoP9bbqS?=
 =?us-ascii?Q?te88Vpn97KISPgeHqm3nnHWuG8oOGl49oBvxsKTszIp4aaI5mUlFL/msCUSS?=
 =?us-ascii?Q?Jw9fJUo2wq4qVMLkqk+Z3/95pARZe9EvwCKAP6UpMrsppj7vCMAvXRMID8Cl?=
 =?us-ascii?Q?7DI01oHtoolBrQCcMRFGNCbaRB9La4Smk33hstAk+qoyhXtO7zdFv5nYEp89?=
 =?us-ascii?Q?bVAyoi2tsgoRj0tmokMj1XL1A7ORrLb1wbnS6H/ZGLa+K3dpe0QuwuB92BqQ?=
 =?us-ascii?Q?iimTYMS1tSw426L56EGdXlX2nvf5oPLJmL5QQEjhmyI7RbLLaIk/V36DvTeK?=
 =?us-ascii?Q?WASalKO7XS8iQu+lR6ybPezobJ/On5p6V0Tz+El1WHXOxZcq9dFZankJ4Rki?=
 =?us-ascii?Q?8s5kA4lf2DYeAQPRFUQy6JJDzTNCjYxf93lvP13fNqygqm9hdIQsBZxvHFoL?=
 =?us-ascii?Q?yMlt7BdR01UKCY01S4r64jd0SU21Hu1FKu1X3PUVIaoNfN5enYlKDX+6ubW5?=
 =?us-ascii?Q?nacBbIL723qGMkdviEYS7M+bfZHtmr999A7RLbil9LfWFfbITu1Vv5/Nhddf?=
 =?us-ascii?Q?qAD18JsklWaIHGVA7mIuKUvrKgzU7M7HWqgHOxuacy7JkbndKd2ZcOEjDBTj?=
 =?us-ascii?Q?XigJT+/9OnG6oc5lHFxxxSqJP8FiVBw5/c4FJtAPXCCfsBWronBuBjuqa+3u?=
 =?us-ascii?Q?Udvez59WCOdPFOFBifkkvochIlc8vem3JEuT84Jh87t7XHEGYWbL4VPqMLnm?=
 =?us-ascii?Q?I1I8OWzZ2RSzrXEMXl71g1n5PcNeoJB99VS7OUyjgUwoBXwmsGPWHgRBQcDZ?=
 =?us-ascii?Q?X1VgHKTFsttu0gey22ng1k0u3+dmpJkgCRVzqCOpeNti79cZPhUutxdYnnRp?=
 =?us-ascii?Q?/GrkpdvFYx4TkUB1+0CUSbOueU0NujxHFma2GzdFWIRbbc96P00vmJfOdHbt?=
 =?us-ascii?Q?Ubp9EXRfbF/usS2ZSS0vaWAsDsEtuHljvpFrqNjYZcgPprKaKJH0HnyCcmJE?=
 =?us-ascii?Q?kSCllhFvRVoYxHaV+T6OMxeVejkS36h7elC5nZCq9oJf5HFoLLGCHNAdTlB3?=
 =?us-ascii?Q?Xa79q7gzKd0JHvF0b7XJxhxqaXWbnq7oeg/idV/bZKpXvihNAtcLI+3bReuL?=
 =?us-ascii?Q?CBL7bsM/VUjo0iDAEv7uM/BRdSZgtFx4gJBvfXUXba6r23dgoWMk6qmvBNL2?=
 =?us-ascii?Q?KWZLh4rWMV05CwYJTo84DdUIujZn0evubksXIyjqnrbOjg2O1l2O1NHINLYi?=
 =?us-ascii?Q?8e+g95htS+TX+on0e51a6ZyfEbi1bRv6WO0u62t9YPpHnhFkTahsksod1wkL?=
 =?us-ascii?Q?Olmsvwirl7HycB31AygXAeWJBFKKNWKWXXcmtGfiMsJrN7msLCOYd8ojludK?=
 =?us-ascii?Q?O4KWlWLdnAa2W5noo2iM0prhoaQHXS/BwLECv27R?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 11e08d87-7596-4157-ac3e-08dbbab3bd4b
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2023 15:02:14.2670
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ENMFPp9XTbIFc1m1G1kE/4pz0QQviskuFWrLJuDJ2fvUR4cH9awd3jMk11gcf/uGQo/U59l2Y/aZNDBLtuhidw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9650
X-OriginatorOrg: nxp.com
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,T_SPF_PERMERROR,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Implement trace event support to enhance logging functionality for
register access and the transfer control descriptor (TCD) context.
This will enable more comprehensive monitoring and analysis of system
activities

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/dma/Makefile          |   6 +-
 drivers/dma/fsl-edma-common.c |   2 +
 drivers/dma/fsl-edma-common.h |  29 +++++++-
 drivers/dma/fsl-edma-trace.c  |   4 +
 drivers/dma/fsl-edma-trace.h  | 134 ++++++++++++++++++++++++++++++++++
 5 files changed, 169 insertions(+), 6 deletions(-)
 create mode 100644 drivers/dma/fsl-edma-trace.c
 create mode 100644 drivers/dma/fsl-edma-trace.h

diff --git a/drivers/dma/Makefile b/drivers/dma/Makefile
index a51c6397bcad0..40b2dd554e5dc 100644
--- a/drivers/dma/Makefile
+++ b/drivers/dma/Makefile
@@ -32,10 +32,12 @@ obj-$(CONFIG_DW_DMAC_CORE) += dw/
 obj-$(CONFIG_DW_EDMA) += dw-edma/
 obj-$(CONFIG_EP93XX_DMA) += ep93xx_dma.o
 fsl-edma-debugfs-$(CONFIG_DEBUG_FS) := fsl-edma-debugfs.o
+CFLAGS_fsl-edma-trace.o := -I$(src)
+fsl-edma-trace-$(CONFIG_TRACING) := fsl-edma-trace.o
 obj-$(CONFIG_FSL_DMA) += fsldma.o
-fsl-edma-objs := fsl-edma-main.o fsl-edma-common.o $(fsl-edma-debugfs-y)
+fsl-edma-objs := fsl-edma-main.o fsl-edma-common.o $(fsl-edma-debugfs-y) ${fsl-edma-trace-y}
 obj-$(CONFIG_FSL_EDMA) += fsl-edma.o
-mcf-edma-objs := mcf-edma-main.o fsl-edma-common.o $(fsl-edma-debugfs-y)
+mcf-edma-objs := mcf-edma-main.o fsl-edma-common.o $(fsl-edma-debugfs-y) ${fsl-edma-trace-y}
 obj-$(CONFIG_MCF_EDMA) += mcf-edma.o
 obj-$(CONFIG_FSL_QDMA) += fsl-qdma.o
 obj-$(CONFIG_FSL_RAID) += fsl_raid.o
diff --git a/drivers/dma/fsl-edma-common.c b/drivers/dma/fsl-edma-common.c
index a0f5741abcc47..0182e2695fdc0 100644
--- a/drivers/dma/fsl-edma-common.c
+++ b/drivers/dma/fsl-edma-common.c
@@ -521,6 +521,8 @@ void fsl_edma_fill_tcd(struct fsl_edma_chan *fsl_chan,
 		csr |= EDMA_TCD_CSR_START;
 
 	tcd->csr = cpu_to_le16(csr);
+
+	trace_edma_fill_tcd(fsl_chan->edma, tcd);
 }
 
 static struct fsl_edma_desc *fsl_edma_alloc_desc(struct fsl_edma_chan *fsl_chan,
diff --git a/drivers/dma/fsl-edma-common.h b/drivers/dma/fsl-edma-common.h
index 029197440bc34..453c997d0119a 100644
--- a/drivers/dma/fsl-edma-common.h
+++ b/drivers/dma/fsl-edma-common.h
@@ -234,6 +234,9 @@ struct fsl_edma_engine {
 	edma_writel(chan->edma, val,				\
 		   (void __iomem *)&(container_of(chan->tcd, struct fsl_edma3_ch_reg, tcd)->__name))
 
+/* Need after struct defination */
+#include "fsl-edma-trace.h"
+
 /*
  * R/W functions for big- or little-endian registers:
  * The eDMA controller's endian is independent of the CPU core's endian.
@@ -242,18 +245,30 @@ struct fsl_edma_engine {
  */
 static inline u32 edma_readl(struct fsl_edma_engine *edma, void __iomem *addr)
 {
+	u32 val;
+
 	if (edma->big_endian)
-		return ioread32be(addr);
+		val = ioread32be(addr);
 	else
-		return ioread32(addr);
+		val = ioread32(addr);
+
+	trace_edma_readl(edma, addr, val);
+
+	return val;
 }
 
 static inline u16 edma_readw(struct fsl_edma_engine *edma, void __iomem *addr)
 {
+	u16 val;
+
 	if (edma->big_endian)
-		return ioread16be(addr);
+		val = ioread16be(addr);
 	else
-		return ioread16(addr);
+		val = ioread16(addr);
+
+	trace_edma_readw(edma, addr, val);
+
+	return val;
 }
 
 static inline void edma_writeb(struct fsl_edma_engine *edma,
@@ -264,6 +279,8 @@ static inline void edma_writeb(struct fsl_edma_engine *edma,
 		iowrite8(val, (void __iomem *)((unsigned long)addr ^ 0x3));
 	else
 		iowrite8(val, addr);
+
+	trace_edma_writeb(edma, addr, val);
 }
 
 static inline void edma_writew(struct fsl_edma_engine *edma,
@@ -274,6 +291,8 @@ static inline void edma_writew(struct fsl_edma_engine *edma,
 		iowrite16be(val, (void __iomem *)((unsigned long)addr ^ 0x2));
 	else
 		iowrite16(val, addr);
+
+	trace_edma_writew(edma, addr, val);
 }
 
 static inline void edma_writel(struct fsl_edma_engine *edma,
@@ -283,6 +302,8 @@ static inline void edma_writel(struct fsl_edma_engine *edma,
 		iowrite32be(val, addr);
 	else
 		iowrite32(val, addr);
+
+	trace_edma_writel(edma, addr, val);
 }
 
 static inline struct fsl_edma_chan *to_fsl_edma_chan(struct dma_chan *chan)
diff --git a/drivers/dma/fsl-edma-trace.c b/drivers/dma/fsl-edma-trace.c
new file mode 100644
index 0000000000000..28300ad80bb75
--- /dev/null
+++ b/drivers/dma/fsl-edma-trace.c
@@ -0,0 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#define CREATE_TRACE_POINTS
+#include "fsl-edma-common.h"
diff --git a/drivers/dma/fsl-edma-trace.h b/drivers/dma/fsl-edma-trace.h
new file mode 100644
index 0000000000000..9dd08a42ad54a
--- /dev/null
+++ b/drivers/dma/fsl-edma-trace.h
@@ -0,0 +1,134 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright 2023 NXP.
+ */
+
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM fsl_edma
+
+#if !defined(__LINUX_FSL_EDMA_TRACE) || defined(TRACE_HEADER_MULTI_READ)
+#define __LINUX_FSL_EDMA_TRACE
+
+#include <linux/types.h>
+#include <linux/tracepoint.h>
+
+DECLARE_EVENT_CLASS(edma_log_io,
+	TP_PROTO(struct fsl_edma_engine *edma, void __iomem *addr, u32 value),
+	TP_ARGS(edma, addr, value),
+	TP_STRUCT__entry(
+		__field(struct fsl_edma_engine *, edma)
+		__field(void __iomem *, addr)
+		__field(u32, value)
+	),
+	TP_fast_assign(
+		__entry->edma = edma;
+		__entry->addr = addr;
+		__entry->value = value;
+	),
+	TP_printk("offset %08x: value %08x",
+		(u32)(__entry->addr - __entry->edma->membase), __entry->value)
+);
+
+DEFINE_EVENT(edma_log_io, edma_readl,
+	TP_PROTO(struct fsl_edma_engine *edma, void __iomem *addr, u32 value),
+	TP_ARGS(edma, addr, value)
+);
+
+DEFINE_EVENT(edma_log_io, edma_writel,
+	TP_PROTO(struct fsl_edma_engine *edma, void __iomem *addr,  u32 value),
+	TP_ARGS(edma, addr, value)
+);
+
+DEFINE_EVENT(edma_log_io, edma_readw,
+	TP_PROTO(struct fsl_edma_engine *edma, void __iomem *addr, u32 value),
+	TP_ARGS(edma, addr, value)
+);
+
+DEFINE_EVENT(edma_log_io, edma_writew,
+	TP_PROTO(struct fsl_edma_engine *edma, void __iomem *addr,  u32 value),
+	TP_ARGS(edma, addr, value)
+);
+
+DEFINE_EVENT(edma_log_io, edma_readb,
+	TP_PROTO(struct fsl_edma_engine *edma, void __iomem *addr, u32 value),
+	TP_ARGS(edma, addr, value)
+);
+
+DEFINE_EVENT(edma_log_io, edma_writeb,
+	TP_PROTO(struct fsl_edma_engine *edma, void __iomem *addr,  u32 value),
+	TP_ARGS(edma, addr, value)
+);
+
+DECLARE_EVENT_CLASS(edma_log_tcd,
+	TP_PROTO(struct fsl_edma_engine *edma, struct fsl_edma_hw_tcd *tcd),
+	TP_ARGS(edma, tcd),
+	TP_STRUCT__entry(
+		__field(struct fsl_edma_engine *, edma)
+		__field(u32, saddr)
+		__field(u16, soff)
+		__field(u16, attr)
+		__field(u32, nbytes)
+		__field(u32, slast)
+		__field(u32, daddr)
+		__field(u16, doff)
+		__field(u16, citer)
+		__field(u32, dlast_sga)
+		__field(u16, csr)
+		__field(u16, biter)
+
+	),
+	TP_fast_assign(
+		__entry->edma = edma;
+		__entry->saddr = le32_to_cpu(tcd->saddr),
+		__entry->soff = le16_to_cpu(tcd->soff),
+		__entry->attr = le16_to_cpu(tcd->attr),
+		__entry->nbytes = le32_to_cpu(tcd->nbytes),
+		__entry->slast = le32_to_cpu(tcd->slast),
+		__entry->daddr = le32_to_cpu(tcd->daddr),
+		__entry->doff = le16_to_cpu(tcd->doff),
+		__entry->citer = le16_to_cpu(tcd->citer),
+		__entry->dlast_sga = le32_to_cpu(tcd->dlast_sga),
+		__entry->csr = le16_to_cpu(tcd->csr),
+		__entry->biter = le16_to_cpu(tcd->biter);
+	),
+	TP_printk("\n==== TCD =====\n"
+		  "  saddr:  0x%08x\n"
+		  "  soff:       0x%04x\n"
+		  "  attr:       0x%04x\n"
+		  "  nbytes: 0x%08x\n"
+		  "  slast:  0x%08x\n"
+		  "  daddr:  0x%08x\n"
+		  "  doff:       0x%04x\n"
+		  "  citer:      0x%04x\n"
+		  "  dlast:  0x%08x\n"
+		  "  csr:        0x%04x\n"
+		  "  biter:      0x%04x\n",
+		__entry->saddr,
+		__entry->soff,
+		__entry->attr,
+		__entry->nbytes,
+		__entry->slast,
+		__entry->daddr,
+		__entry->doff,
+		__entry->citer,
+		__entry->dlast_sga,
+		__entry->csr,
+		__entry->biter)
+);
+
+DEFINE_EVENT(edma_log_tcd, edma_fill_tcd,
+	TP_PROTO(struct fsl_edma_engine *edma, struct fsl_edma_hw_tcd *tcd),
+	TP_ARGS(edma, tcd)
+);
+
+#endif
+
+/* this part must be outside header guard */
+
+#undef TRACE_INCLUDE_PATH
+#define TRACE_INCLUDE_PATH .
+
+#undef TRACE_INCLUDE_FILE
+#define TRACE_INCLUDE_FILE fsl-edma-trace
+
+#include <trace/define_trace.h>
-- 
2.34.1

