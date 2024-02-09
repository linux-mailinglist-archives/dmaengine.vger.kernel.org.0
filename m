Return-Path: <dmaengine+bounces-995-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5070C84FEFE
	for <lists+dmaengine@lfdr.de>; Fri,  9 Feb 2024 22:36:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DBF61F23069
	for <lists+dmaengine@lfdr.de>; Fri,  9 Feb 2024 21:36:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A494918623;
	Fri,  9 Feb 2024 21:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="CO+83cQr"
X-Original-To: dmaengine@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2047.outbound.protection.outlook.com [40.107.104.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36C04168A7;
	Fri,  9 Feb 2024 21:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707514585; cv=fail; b=a9Wk29TZyf0hL5ySUdc3wB3SwczrNNwKXIuVxCnklhx7SYLHCo+w6IRLpozL7DdYQ+Et7SDPg69yIscZM9lYX/UBerdRgwsRPQ8xHyLmEkJ7FAMCkpWwLSWdphiG8X4g6dBWnERmXlhT8FEpKF6ebJmiyRtes6mSnqyuT57Qzng=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707514585; c=relaxed/simple;
	bh=qxQHYPj7E7f1TTgAVbrbHCfdJpdOq8D88t/Ncyq8qbA=;
	h=From:To:Subject:Date:Message-Id:Content-Type:MIME-Version; b=NJt3v5RdDdfakeyIKqcwOGaxMTnjoL55Q74G0kxmhwYkEhZrMNx969ZqTurzpn6DtOJ607rBTpBn3dugalw8JJyIfZffF0g9CAbfZIQhj9uJoj4QaS5T6MZQfChJgi1M4eQOZL1+rq8ELCR1zkFGlvbPuAVy0iyzf5etG1d9aMY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=CO+83cQr; arc=fail smtp.client-ip=40.107.104.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SWUXwxC0cZNBWavGIqZt5hDR/l5S1qcMIq7Q9JSAwaKgoAZQlJfSyjPw1xSemj9WxwdOeLYf4BdzgkW03VCY7sp/IEx9G5nkwgs5TX7ClSERKtaFzVIMRY1127uBTmXryqmR9pFcDgUS7afVMjur2FE2HP4Ts50Bx4fy5HhuBOfAnhuG4RHIaxG54FWe0TDAvPe+KUmskVjPQmyoknjr8OuH3jTxkp+VhQa8yP/HlFqyGAv4XTG02DJ8PeeZaDTQniICs1Zv25kHlFtJERGhbgHK1NxtG+AJY7UfPguKN3vxXviH0ftRdg9ftiEZ5xOXPN87T3ltjcW7+w4mMTStRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NCgQT+iu7zN/lWq2++cYqvoF3yQ2hWfYWC5WoP3CT1Y=;
 b=UzRzNodc/JzqZ6d1EDYnhaM+zHw8lDr/c/NJZvxJvRgbep4uDWkuqdecCL01gze+UHQsP6hqGpy+zVsAYt7r+FPV7gQrH0dqUvmDCIuJ3pF7r9l3uKUeBjgoAWxbFeDTrL19udDXQ8yKZ4LSvO2PQKfai5K+H61SRavURJ2CfUB/8AuaidGTldj3cPCSyPKPv3fCZxUg0qW8MlWmfa21Ep84yGKhcj8tNAkL6whU1rWZfEqhk6ioVjS6jJmLFgOFRgqshtosEDZfazvshn9SbXLQ0jjllWpzNtYWVe4Xs2k9a1CoWk9hOuTjqHK0faIIq07GEgIWMoHAwiipGH6ttQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NCgQT+iu7zN/lWq2++cYqvoF3yQ2hWfYWC5WoP3CT1Y=;
 b=CO+83cQrQ4DuyVWU9mgYLgTQ0WnQgZYUsRlusCZgrbDGUJ5Xh6PXwc3ld08Mt9qp/in83Zv9dYSHRnVjGVbbHIgxXVVbvyZHUvGlKcJXAKb8zG/K8BgJI3L3IKV5k0971psnirNdI0rzYoI1Ha+NC1XX3Xhax2mlHOFfy42wepk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PAXPR04MB8800.eurprd04.prod.outlook.com (2603:10a6:102:20f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.27; Fri, 9 Feb
 2024 21:36:20 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c%3]) with mapi id 15.20.7270.025; Fri, 9 Feb 2024
 21:36:20 +0000
From: Frank Li <Frank.Li@nxp.com>
To: Vinod Koul <vkoul@kernel.org>,
	linux-kernel@vger.kernel.org (open list),
	dmaengine@vger.kernel.org (open list:DMA GENERIC OFFLOAD ENGINE SUBSYSTEM),
	imx@lists.linux.dev (open list:FREESCALE eDMA DRIVER)
Subject: [PATCH v2 1/2] dmaengine: fsl-edma: add trace event support
Date: Fri,  9 Feb 2024 16:36:03 -0500
Message-Id: <20240209213606.367025-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0P220CA0021.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::8) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PAXPR04MB8800:EE_
X-MS-Office365-Filtering-Correlation-Id: 1bb04aa9-eb9e-4b10-c121-08dc29b72777
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	pwhIFm5f//HROANjmYllesTkITSUR8E2rrvMw23iy+Z77E6aXVxaYou1qhb7HRwo5pJ+t6LRrFQkzsMF1gczfJwh92zcqwr/X7M/NdnJhAeGfe7bNUeNiFZYliew3uKIkVUlDA8siiilQ0GjpzHwld5ts45pFuRgO/K2694L8FjJ2UugCqe2Gi6I41nhzE/e58wcXCL4YI61l1Vt7e6bYYz5iyF06Fb3xWh2PFAOsWGjt+zVRGisb25QeDt/z9uVbfxDpBcaG7YueLucXEH9tQDObk+HVM2bksKtARQQ0yB9XoO5dbN6JkL6BuFBmwO6xeXYIZimKibzHIWnz5hS0emjBij261C3spG60BBywoPhDe8g0WiZz17A/1Gm0lxoxeK7gVY4p16DYvkYQGGgnWkOKaazswPC70TdOp4niMIOt0d0Hp1Etq4BSKv9I4FBb3P1D+qi/M05R6o/jhTGVfD/VDW2QXjXLsag08W1ztVQejmv6MKU9kyonwJOuEa0GCmEMYik0a4CMlSdqoo4oHq1VFh4qlBjH5ieUQzeVEChNPOxj37xRJj1M4nJh28mIrkihtUx38MtYJ0jocmguomxVPMvRwYNiuASHef0A7ufCpo9YodPMPFylKev6/Rm
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(396003)(366004)(39860400002)(136003)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(5660300002)(2906002)(41300700001)(38100700002)(86362001)(478600001)(38350700005)(6512007)(6506007)(6486002)(83380400001)(1076003)(66556008)(26005)(66946007)(66476007)(316002)(36756003)(8936002)(8676002)(2616005)(6666004)(52116002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zIvQEe7XVBlFvDlF1REafip2mtP7xlkE2nf9xH0ROpv5QHhgp8A34qVK14X7?=
 =?us-ascii?Q?RBg/dmmTU9tHtBHtCa1h+uUfXJ7S0ABPfQHCSoVTefMnARdX6tccSNipL1qf?=
 =?us-ascii?Q?f4nsyZxPnMiKAZEEZfuTjDfaF3wGtkXnly89UL7bC6zsDIk7u14+6BvXdjXt?=
 =?us-ascii?Q?H0AeZ7wu5u12rcGhT/inI/1rGUY/K1Jz3eUR0T431birOvezx70uyEAeo0sy?=
 =?us-ascii?Q?/xvwdUQuLodsqXv1/8apmT6GIolEJ8TndWtIkBw8zRyXUX0oSC2PHOcZQlSs?=
 =?us-ascii?Q?E+ciyI3v51Tt3Bz4wOboyaM951blft03T7+Q+xvJZBS46IjptqVG7hV9krYQ?=
 =?us-ascii?Q?kvIQrm09E8fHYN3t5P8LB0Ppyjn+ixfM81SNr/+MwnCYKwRKvv6KTckPYCJZ?=
 =?us-ascii?Q?Qclb5MlWuXQsOl9+ODOEc5wVfDkyVEDdxQfsWeCFkeSsrog5O818j/zAjm95?=
 =?us-ascii?Q?y/4/I/pffzbrJymxcw/92UIIJD0ByAXvY9ksSluYvKsiPiJaJGIkDitbY3wj?=
 =?us-ascii?Q?Dd/7LAHeX/uzE5KCi/u2E2Q1RiVaL4PcrSV3qQ3OEwn/cnEJY4lDJBjoNY9X?=
 =?us-ascii?Q?YVzawfJmrcG065ikunie6NfCcIHvAicY3PzgscnlvHMoiHwR5V6CfjNw+3j0?=
 =?us-ascii?Q?bqWO89TGT3JfoC3VErFH/1VF8TgF3129+Gq6jcusX3ywAeIiTxCh+es47MGr?=
 =?us-ascii?Q?nrW+SVA/Yt3neNn6fKffSfupeTFGVIkpro4EBTuNJKTokAosURNyCaE3GYvP?=
 =?us-ascii?Q?Ql5JsEg5SSz6ukSJt6JowcsFodbr1yvADAgVz7L68pJEXtNSFbtQdggLOAkz?=
 =?us-ascii?Q?E4qYyp81peAVeLxxuEUfbK6jvw1LGgT261/YBf79qgqhoE7z7ZTZCAzoz2FI?=
 =?us-ascii?Q?qrVerrJszzUHtxS5sO1x0JE97cuLQA+V5DZu2nRJl2u7yYYLhgQLz4DZzBjo?=
 =?us-ascii?Q?CaqSFu177e5spcdKuZugDGQ0rId/3XmbBKuDetI2r7BYoqY5mgtcQhnwnURJ?=
 =?us-ascii?Q?O/Pp3txDehcJKW2M58Fh9olafWBcF4vmIxMaVRjJ2YWLQv9+UIN5bF6CJoAu?=
 =?us-ascii?Q?Ae+UR7SAB0TMbhSxf4/Qx1AZvC1AVU4D5ZllSdJGxjPYP03qi9P1GnnUArsd?=
 =?us-ascii?Q?ZQuITuiDnkhr/hvwQDv9S0DTQrl/gS94R408urGQSOwa01WFvCGZYLYYW8KH?=
 =?us-ascii?Q?QmX+XFfPpsgUePzBWXPsxh1e19HYdFnFSP6bMhJMH4tfzZoEyjF4Nz9XIE+x?=
 =?us-ascii?Q?ewJYL320vNeaHnOT9oIvOkynR5I+qbyatK3Siu2fom1tbWxJNEMySNNsnKFG?=
 =?us-ascii?Q?1WSJ6kKRJkPvWshTIcmhcTszP+u1UYqnYmzyhZQoHPl0LgK3if8NfrlJUURs?=
 =?us-ascii?Q?0yqrMZzTafrXOEqGE4KvEhGzDj62++6QT4LpBWFD5TVQUniMW69JU4zkK1ty?=
 =?us-ascii?Q?SE5Y9rEi9SZi69qJWbLzT2nYc3KAmudSavYUUuko1d8LASDulGTUWAoe8hX9?=
 =?us-ascii?Q?EYrRPYY/clSgoQSzpXRLjbYduzVD7gRh6nY87+XiKZUATMhhkfzea79MhS1c?=
 =?us-ascii?Q?xczYWbjQAnD/vbm9Nn0=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bb04aa9-eb9e-4b10-c121-08dc29b72777
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2024 21:36:20.0332
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5Hq/eWsgk5TyJmTTkEsbpWWfD7hEoII8k+4InkoX6tohQLvkEzwh8RgIpfBgR+KZ9ByAz3LmxxVcG0sa+9NB2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8800

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


