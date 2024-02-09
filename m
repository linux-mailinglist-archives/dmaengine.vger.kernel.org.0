Return-Path: <dmaengine+bounces-986-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B198284EE81
	for <lists+dmaengine@lfdr.de>; Fri,  9 Feb 2024 02:05:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A65B71C24DA1
	for <lists+dmaengine@lfdr.de>; Fri,  9 Feb 2024 01:05:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5E4F804;
	Fri,  9 Feb 2024 01:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="d/Qo9e+c"
X-Original-To: dmaengine@vger.kernel.org
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2083.outbound.protection.outlook.com [40.107.7.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41D24634;
	Fri,  9 Feb 2024 01:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707440700; cv=fail; b=UMM1JKvOYJykj0IhUmDLeUWSvOuUyAWusGuju+zW13ryZk6lVoY4e06LGWdzCacrnwhs/+PnSpPf0JUkzQmhs/2DYd8BLA7JapMB2Az7llIlBWkTSk8gba2CAYymcnPN2Q9EpltR89btMgPhGZtCh2dHR0FLczBC8uWVpXv8x9o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707440700; c=relaxed/simple;
	bh=qxQHYPj7E7f1TTgAVbrbHCfdJpdOq8D88t/Ncyq8qbA=;
	h=From:To:Subject:Date:Message-Id:Content-Type:MIME-Version; b=JEeRdqrmwUdRrVK6SMvaKvld5Y96oqne6xFPRRxAKV3WhuCv6LS4h4AN7mWruKRGYMJF+UdstvxnXO6QxXMXcx1laN01ZGuWbt0nXIBxSOBZVCnvKOe5Fpeu0LIAMww1MSnbb1tt/o+ECuL/N+RNGWfOCSy5InQOT4aaYpXp22E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=d/Qo9e+c; arc=fail smtp.client-ip=40.107.7.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n8071Og5qURqk48CX4eyyg8QdAH+3PdmsHQ7nssMQkyj51cBKYo6n6WkspyBVV2ihhnN0AR5EqlLD8igNz6rjgqHyQFM/JrpcDi9FC1QlU7BnZCQqlhmVd1l6FYvF0Su0FBD1KfX0i0IaHvid8MgTIr2zxGwsnQnllHi/Ml0oqsWi9cuR7wW2Iw8wUi13QhhBR8aDEUgmazKO6jY/sPTmDh9fkVfGursLLbDoLAZ3l3/GMiaTF/K5LmcmZJQIBuVPNXrHsDhwxPWqwQEn8WlSq5nWoEiI74lpQEmaAEcJbpn9PH7ICjMs1g1Hs9idpJh1X6/VDgeOVzBusdJ9BDK2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NCgQT+iu7zN/lWq2++cYqvoF3yQ2hWfYWC5WoP3CT1Y=;
 b=Jqu4XiGnAy0C0JeRUXMHsl9b7CYyiFdidjf6eKAaEThcLBAu3fuV95e5r9uY+NJoIBoGBCVTEir39dCZXgZkEdq7WblC28KswJSJ1jNG1k7++yLa4bMUTMlMj8OdcJ5HJQx9x1c2GKaaB1+XJsQr4HKDZ7t7/XUQdgMrgbBilXLvvIYmYeO4lNGkMlN+0RmO4LZ7IzU/J8E//oFR/Q4H/MAeAKkGn70mfJSK+GglcapgoFwbGjjSulIYMMaOAR6XNfLurQolLgmot1LC2tG7w/8gByNtvan7jDaJ/U0Gv3tibyDu+I02GEl9X8snmceQqhMUU06mBXD8Ingl77u3Gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NCgQT+iu7zN/lWq2++cYqvoF3yQ2hWfYWC5WoP3CT1Y=;
 b=d/Qo9e+ckGxHPLlZTP2hNfdSHPi2Fdx1G9u22u2BUT4VmSwAIeYAXdl9YMxTvU90mHA3NcoGak8sFsXws6pZd9OAGMZ4k0pt/i5pFpGdwScsuzHsSxSanm0sQ4kWzECBjRSb1U71iraRnFNFBWRGW9eeCv8mS6hf5NShpRajNhg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VI1PR04MB9764.eurprd04.prod.outlook.com (2603:10a6:800:1d2::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.43; Fri, 9 Feb
 2024 01:04:55 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c%3]) with mapi id 15.20.7270.025; Fri, 9 Feb 2024
 01:04:54 +0000
From: Frank Li <Frank.Li@nxp.com>
To: Vinod Koul <vkoul@kernel.org>,
	linux-kernel@vger.kernel.org (open list),
	dmaengine@vger.kernel.org (open list:DMA GENERIC OFFLOAD ENGINE SUBSYSTEM),
	imx@lists.linux.dev (open list:FREESCALE eDMA DRIVER)
Subject: [PATCH 1/2] dmaengine: fsl-edma: add trace event support
Date: Thu,  8 Feb 2024 20:04:22 -0500
Message-Id: <20240209010425.2001891-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA9PR13CA0148.namprd13.prod.outlook.com
 (2603:10b6:806:27::33) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|VI1PR04MB9764:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d68ea22-c712-4d11-f064-08dc290b2084
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	AiQ9slAhjZcCj6ANpyinUvK5YaeFBsqWO/Mj2yoDllS8YUW67FR4xbBPxn0a8acIxaq9W2YVjsBqksQo+YZOLzLPd1VTpG4JlJbtltfFaxaAy7z4M7nEm2sA0EJ4pdbkRWG3omasuthU+ksh/tvkg6uTB39HjrP6e4buwaurVJOz03JQhWvRzykQdzeC0hlhKLweCRT6JUqISDwZ/KOdzeXJT8k5W9urcazfJ6aOMwmu9BDYpMxcqf4D08J2vF+DoaFb1WWiSQ1LeietKnU3IyCN6Uj4jVNznOjBws7od6kF3YTTAFWe1vlcrtnfSOLzgIaau9CqJneLnRpcHZnpFZehWzePrnBfJAKxAXgW8E0aGm+0HISqi+PpKXKzswWM+2nYsne3SmmKmMUeCxR8Tk4g8tz/E/8LfMWg4DM6gMB9IfxZw1PJTRUl/xc2MUWqpFX2wkYbBoZ/ArBNzasejASk5DKAyLjuhKvKjLE72mkTsX7RPBBMIZvdko7Joy88bsXQFQp+6MPM10fiN1O8MFqtWxePGqqsGgXN5TPo+9WmZ5oKsoRjsIFe5QYyriLmqTSGbSNVkrx6maFeQn0PPpJ0AjayjQZ12gsfq6EGEE4rZD/WqG0f8e+5UoSj9y/f
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(39860400002)(396003)(376002)(366004)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(2906002)(8676002)(8936002)(5660300002)(83380400001)(2616005)(26005)(38100700002)(1076003)(36756003)(86362001)(38350700005)(66946007)(66476007)(66556008)(316002)(6666004)(52116002)(6506007)(6512007)(6486002)(478600001)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4njL0Uim1k6xw+bgqjtoPEtXnYWAv2Ie/bAVZrULo3bfEoz/g/S6Ks0PuQfj?=
 =?us-ascii?Q?VG3aWj2lXRD5zNc/JMx4gVKzDEcx9I2KCVCKvSvnOcfY7LeQ1FgQ0uevhI2V?=
 =?us-ascii?Q?D97C7ZVfjZt7QSXi0K0YrPSZQE0/S5dsV1M3kK4+B4OYEwpU57C07kC3FqjY?=
 =?us-ascii?Q?2DBMYI+Mjo/vQDpiqTZitdWJHUVNMJX0d9uVXCSLzsnHfZbYh0qv/JAKjoKV?=
 =?us-ascii?Q?eDW94oRf2bj9WIBypzvYHiDBj+bsv1Hbuz+qb0ULG87TQ13ptgLkuRspNpJL?=
 =?us-ascii?Q?tPf8pl4RHyVjTLJxALzX0z0yRj3elrw4ggHIYK9IeqzAELyetADuD3bcUyvq?=
 =?us-ascii?Q?VSoqfqaOr6Xp6PQ961HAovroy9PNKUgsQu3bzMYwNJrtNwcCK978dbMi4zLS?=
 =?us-ascii?Q?REjPmIJpioo7bGB8PNm88MPl4VCakvuzMmXwJFJkA6W0f9+A02z4l7k51XDK?=
 =?us-ascii?Q?e6qkQdh/3U9/pAaRcx+Q/5PsecMwvdtA62TxJLD/Ri+Lczs+htSC96Sb06wa?=
 =?us-ascii?Q?hmzHXHQ/aBUlMqQH6eYSMKI7swx2O0QpDfL5ILrs0a7WN6Q/UOYx4d1dZUh6?=
 =?us-ascii?Q?vEZgSL4QrnSUM5A73jZLuMbY/6pqv1QnCOjpHMk070+ED5mksmOmlRikf834?=
 =?us-ascii?Q?LZneuGqONZ65WLrWiy5pUFEamToA6S6rzRyTXZt8EpO6a2XUNzg6+f2nKEjK?=
 =?us-ascii?Q?W9PlHD3oIqdrVRqJXPmV3qzPGQLH7j5xnmQgxPqVbnG42uxDWfEsX6Lg8H3o?=
 =?us-ascii?Q?cRJGQ6hpd5Tt1wc4umY3JL5fG4hXkBbO3L0hr5hQXxpBAs0/yNtP2I1IlflQ?=
 =?us-ascii?Q?UITvam+X2UuKtLpfFfa2mUKVTzrKiRH5EX6DFr9pvvL5vISkibtcgoPo8XLg?=
 =?us-ascii?Q?ZtIRgMPjnKVt0N1SwNne8YpZrRrTrth02RRnBAAOXLv2jHdzSbOGKwrMbUMj?=
 =?us-ascii?Q?e+r7qtuSa/ublVTKrk63kVSGbv+fepDDAIejBGr/PCSPAq3XCKBn3stoxtWx?=
 =?us-ascii?Q?eSO0X/E6wOolI4cYxnNmz/RSw43BoJSDBRQWmFb6qWOyjuwavm2T3gu9VmPJ?=
 =?us-ascii?Q?5S7KcYshP3I6dSqqLFFuYduqPrgk4b/uC9rElNSX89Yk8XyqWRwKxlSUjk6O?=
 =?us-ascii?Q?1+GSCDPRyuVo0oy8dBRdUaiKPQvds74KRSlHVrY6r+LY8SFDfP+CwvryafGv?=
 =?us-ascii?Q?2ELluINAxGuSTRs934NMJJPvSxUFuINdf4U+fDCR+hnqUlgBEeP4M1NMTC8F?=
 =?us-ascii?Q?mxsI08wmVMFbQ1G7XZfpzNXmip757Enrrrpd9blsGYJRRLhdtppewjhM/33z?=
 =?us-ascii?Q?Sm91cqj6Y7PPzdAkQgh9wZ2cIqcxvWeKIwowRdQlFxdUP2Eo0o2vrLQGJ6zB?=
 =?us-ascii?Q?T7RqOFds1TqlAHuSn92FrcfRjD7TR9sCwioQGVQ5QHdJ6cfyi54ju4TPnO7Q?=
 =?us-ascii?Q?SOWEVFQF+QnXuVOQ1ulgUffhzVcE1mrkl2S/2A2YFHEZA2WHuTZ3gIa8aj0Z?=
 =?us-ascii?Q?Q/NJ9zlf0WjyeLtdYgbApD3C63vvzg6PmB4qei+hVdrNSTZxdqVnC54yubJR?=
 =?us-ascii?Q?EstUUPd+rQDTl/ZMa5YW3MqQxUcCNAo2ELMYGoil?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d68ea22-c712-4d11-f064-08dc290b2084
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2024 01:04:54.8787
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2BW2tFADSydd5/955axrQ8wftyNOQBAvvQl2IpJ64HMEqKj1dbvEjA82azOkCKPlIGXdvVXpPUQrKakKErU0bQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9764

Implement trace event support to enhance logging functionality for
register access and the transfer control descriptor (TCD) context.
This will enable more comprehensive monitoring and analysis of system
activities

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/dma/Makefile          |   6 +-
 drivers/dma/fsl-edma-common.c |   2 +
 drivers/dma/fsl-edma-common.h |  45 +++++++++---
 drivers/dma/fsl-edma-trace.c  |   4 ++
 drivers/dma/fsl-edma-trace.h  | 132 ++++++++++++++++++++++++++++++++++
 5 files changed, 178 insertions(+), 11 deletions(-)
 create mode 100644 drivers/dma/fsl-edma-trace.c
 create mode 100644 drivers/dma/fsl-edma-trace.h

diff --git a/drivers/dma/Makefile b/drivers/dma/Makefile
index dfd40d14e4089..802ca916f05f5 100644
--- a/drivers/dma/Makefile
+++ b/drivers/dma/Makefile
@@ -31,10 +31,12 @@ obj-$(CONFIG_DW_AXI_DMAC) += dw-axi-dmac/
 obj-$(CONFIG_DW_DMAC_CORE) += dw/
 obj-$(CONFIG_DW_EDMA) += dw-edma/
 obj-$(CONFIG_EP93XX_DMA) += ep93xx_dma.o
+fsl-edma-trace-$(CONFIG_TRACING) := fsl-edma-trace.o
+CFLAGS_fsl-edma-trace.o := -I$(src)
 obj-$(CONFIG_FSL_DMA) += fsldma.o
-fsl-edma-objs := fsl-edma-main.o fsl-edma-common.o
+fsl-edma-objs := fsl-edma-main.o fsl-edma-common.o ${fsl-edma-trace-y}
 obj-$(CONFIG_FSL_EDMA) += fsl-edma.o
-mcf-edma-objs := mcf-edma-main.o fsl-edma-common.o
+mcf-edma-objs := mcf-edma-main.o fsl-edma-common.o ${fsl-edma-trace-y}
 obj-$(CONFIG_MCF_EDMA) += mcf-edma.o
 obj-$(CONFIG_FSL_QDMA) += fsl-qdma.o
 obj-$(CONFIG_FSL_RAID) += fsl_raid.o
diff --git a/drivers/dma/fsl-edma-common.c b/drivers/dma/fsl-edma-common.c
index b18faa7cfedb9..ebd9647671c9f 100644
--- a/drivers/dma/fsl-edma-common.c
+++ b/drivers/dma/fsl-edma-common.c
@@ -546,6 +546,8 @@ void fsl_edma_fill_tcd(struct fsl_edma_chan *fsl_chan,
 		csr |= EDMA_TCD_CSR_START;
 
 	fsl_edma_set_tcd_to_le(fsl_chan, tcd, csr, csr);
+
+	trace_edma_fill_tcd(fsl_chan, tcd);
 }
 
 static struct fsl_edma_desc *fsl_edma_alloc_desc(struct fsl_edma_chan *fsl_chan,
diff --git a/drivers/dma/fsl-edma-common.h b/drivers/dma/fsl-edma-common.h
index a05a1f283ece2..365affd5b0764 100644
--- a/drivers/dma/fsl-edma-common.h
+++ b/drivers/dma/fsl-edma-common.h
@@ -249,6 +249,11 @@ struct fsl_edma_engine {
 	struct fsl_edma_chan	chans[] __counted_by(n_chans);
 };
 
+static inline u32 fsl_edma_drvflags(struct fsl_edma_chan *fsl_chan)
+{
+	return fsl_chan->edma->drvdata->flags;
+}
+
 #define edma_read_tcdreg_c(chan, _tcd,  __name)				\
 (sizeof((_tcd)->__name) == sizeof(u64) ?				\
 	edma_readq(chan->edma, &(_tcd)->__name) :			\
@@ -352,6 +357,9 @@ do {								\
 		fsl_edma_set_tcd_to_le_c((struct fsl_edma_hw_tcd *)_tcd, _val, _field);		\
 } while (0)
 
+/* Need after struct defination */
+#include "fsl-edma-trace.h"
+
 /*
  * R/W functions for big- or little-endian registers:
  * The eDMA controller's endian is independent of the CPU core's endian.
@@ -370,23 +378,38 @@ static inline u64 edma_readq(struct fsl_edma_engine *edma, void __iomem *addr)
 		h = ioread32(addr + 4);
 	}
 
+	trace_edma_readl(edma, addr, l);
+	trace_edma_readl(edma, addr + 4, h);
+
 	return (h << 32) | l;
 }
 
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
@@ -397,6 +420,8 @@ static inline void edma_writeb(struct fsl_edma_engine *edma,
 		iowrite8(val, (void __iomem *)((unsigned long)addr ^ 0x3));
 	else
 		iowrite8(val, addr);
+
+	trace_edma_writeb(edma, addr, val);
 }
 
 static inline void edma_writew(struct fsl_edma_engine *edma,
@@ -407,6 +432,8 @@ static inline void edma_writew(struct fsl_edma_engine *edma,
 		iowrite16be(val, (void __iomem *)((unsigned long)addr ^ 0x2));
 	else
 		iowrite16(val, addr);
+
+	trace_edma_writew(edma, addr, val);
 }
 
 static inline void edma_writel(struct fsl_edma_engine *edma,
@@ -416,6 +443,8 @@ static inline void edma_writel(struct fsl_edma_engine *edma,
 		iowrite32be(val, addr);
 	else
 		iowrite32(val, addr);
+
+	trace_edma_writel(edma, addr, val);
 }
 
 static inline void edma_writeq(struct fsl_edma_engine *edma,
@@ -428,6 +457,9 @@ static inline void edma_writeq(struct fsl_edma_engine *edma,
 		iowrite32(val & 0xFFFFFFFF, addr);
 		iowrite32(val >> 32, addr + 4);
 	}
+
+	trace_edma_writel(edma, addr, val & 0xFFFFFFFF);
+	trace_edma_writel(edma, addr + 4, val >> 32);
 }
 
 static inline struct fsl_edma_chan *to_fsl_edma_chan(struct dma_chan *chan)
@@ -435,11 +467,6 @@ static inline struct fsl_edma_chan *to_fsl_edma_chan(struct dma_chan *chan)
 	return container_of(chan, struct fsl_edma_chan, vchan.chan);
 }
 
-static inline u32 fsl_edma_drvflags(struct fsl_edma_chan *fsl_chan)
-{
-	return fsl_chan->edma->drvdata->flags;
-}
-
 static inline struct fsl_edma_desc *to_fsl_edma_desc(struct virt_dma_desc *vd)
 {
 	return container_of(vd, struct fsl_edma_desc, vdesc);
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
index 0000000000000..d3541301a2470
--- /dev/null
+++ b/drivers/dma/fsl-edma-trace.h
@@ -0,0 +1,132 @@
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
+	TP_PROTO(struct fsl_edma_chan *chan, void *tcd),
+	TP_ARGS(chan, tcd),
+	TP_STRUCT__entry(
+		__field(u64, saddr)
+		__field(u16, soff)
+		__field(u16, attr)
+		__field(u32, nbytes)
+		__field(u64, slast)
+		__field(u64, daddr)
+		__field(u16, doff)
+		__field(u16, citer)
+		__field(u64, dlast_sga)
+		__field(u16, csr)
+		__field(u16, biter)
+
+	),
+	TP_fast_assign(
+		__entry->saddr = fsl_edma_get_tcd_to_cpu(chan, tcd, saddr),
+		__entry->soff = fsl_edma_get_tcd_to_cpu(chan, tcd, soff),
+		__entry->attr = fsl_edma_get_tcd_to_cpu(chan, tcd, attr),
+		__entry->nbytes = fsl_edma_get_tcd_to_cpu(chan, tcd, nbytes),
+		__entry->slast = fsl_edma_get_tcd_to_cpu(chan, tcd, slast),
+		__entry->daddr = fsl_edma_get_tcd_to_cpu(chan, tcd, daddr),
+		__entry->doff = fsl_edma_get_tcd_to_cpu(chan, tcd, doff),
+		__entry->citer = fsl_edma_get_tcd_to_cpu(chan, tcd, citer),
+		__entry->dlast_sga = fsl_edma_get_tcd_to_cpu(chan, tcd, dlast_sga),
+		__entry->csr = fsl_edma_get_tcd_to_cpu(chan, tcd, csr),
+		__entry->biter = fsl_edma_get_tcd_to_cpu(chan, tcd, biter);
+	),
+	TP_printk("\n==== TCD =====\n"
+		  "  saddr:  0x%016llx\n"
+		  "  soff:               0x%04x\n"
+		  "  attr:               0x%04x\n"
+		  "  nbytes:         0x%08x\n"
+		  "  slast:  0x%016llx\n"
+		  "  daddr:  0x%016llx\n"
+		  "  doff:               0x%04x\n"
+		  "  citer:              0x%04x\n"
+		  "  dlast:  0x%016llx\n"
+		  "  csr:                0x%04x\n"
+		  "  biter:              0x%04x\n",
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
+	TP_PROTO(struct fsl_edma_chan *chan, void *tcd),
+	TP_ARGS(chan, tcd)
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


