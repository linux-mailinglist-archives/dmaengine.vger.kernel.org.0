Return-Path: <dmaengine+bounces-1388-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A54BF87C7B9
	for <lists+dmaengine@lfdr.de>; Fri, 15 Mar 2024 03:51:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 29D96B221E8
	for <lists+dmaengine@lfdr.de>; Fri, 15 Mar 2024 02:51:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD6A8749A;
	Fri, 15 Mar 2024 02:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="NzSto0ER"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12olkn2021.outbound.protection.outlook.com [40.92.23.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5935DDD8;
	Fri, 15 Mar 2024 02:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.23.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710471066; cv=fail; b=m9yPLwGeTFhxSwi91X700Ypp9dyNKEzkX8ih7QL8rQ7jNzqCxZ5EHlojV3BrhqeSLe+CyKsowLOHe1HwRf09I4vYk40jFAdY7wDF7R18or1MHcViAh0ZKaopJUOV16kmNHN7Ts4RsZKNtn1nb2M9TMD5jatzMEBKo2hZgxXoN5E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710471066; c=relaxed/simple;
	bh=8JgoSjCMgT+4YWgPAd3BpnSD8PgiKGpOWzslfEu2zi4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=W5FqanR3wP4lXnWMOYBIsgvR0SBCAD0ciTXQATH6Ppy1zgt6Zv3y4eiIQkPFLD+yqvr0mQau2udFyYweEeAU9XDx8Dzq7b9SDIX2klAld7FRJapsN4v34UWzbiiq8iBEEANhaifrIbqwv7d32CiIyNBScMTnmLNfXh+ku8AQZXw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=NzSto0ER; arc=fail smtp.client-ip=40.92.23.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f1klhx/SSOz2MuY80l3I4YvSyCItrOLMD/X8bnEe1S1SlhosPkZ/Bts7kWdBYa5iKeP2yMTUyU4f4td0n5Y3ckMIsFCWBL1T3mOri3wD48U/aCseIv0Vpj+hEfNkiw96ei+9UJxrIoT0Y1zmpAvuBb2QqoCFdQeaN6o5KbOiss39jLnDuxfkf9BqwgO/wQdDUE0YHOCBHtsrkT+Z0HWU/FiVZ8x12+YKdPacGdTFmJrwCFK8fa1W2c2mj8lhafBO3Gvv3qaMSO5C5qF0Ug0CfwMUHFCpdskWOVLf2WOS1QqEa9jy2LPfTeNAtsFwM2z0o2m0osVE+EJP5jFmWey0Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kS0KlR6sMzZ54c2Mbq9eCPI0GiPAwbDVfnXhdu/XLI8=;
 b=N7ADzfejAjhxuQ+BPbG85DwtdZovxVwaXMAzF3pdy4ikyngIuzUHZsa8aMVUX2boAFOzlWd9Vik6K95J7nkwVqkn/XuP9Nb/FnzWkHirgEp5StbM+rNxyFN40ng7PRJE1G2rDadx3C4ShyEYGf+qCPyuGZGiOYUwNMXEiqC+r68UoVOXPRS0xz0pbk5k4iKbuGUUINW6k5xT+BhxOH6jxOA9J5NdT29Rp9E8ZgLNheWowHb+RPFSKjUINEh3+Y13BV6bOlYP2Rk3/66xxDPEfyIUgItPzjF08Qo9Zk7hUiQG7HSGzmnuAuEZbj5yXxPsNy1FMbDffKOGrYWlUsdRSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kS0KlR6sMzZ54c2Mbq9eCPI0GiPAwbDVfnXhdu/XLI8=;
 b=NzSto0ERLwJQdWFeFgFrg+QHPCmAsuCk+ktqPTaHyndD+4V+JHYBzi73Mnxl8BOk5KKi7bqUYIinf6RfzVKGLuuggjsAJDjhmsJiCEpPDrEUngx9Ogo48MOD5HbbL12UFcStDU7Uzbt2BgodN0+BypOlYBk7PuzzaBoUegenfH15Y5J+89uVDQTBQC6CLP/DMw2GLMflQeQRtPkxhXaSULur8FaIIdH4ZYcTYOitBuR89ZJIg4e+Byy7pYjzZO0DbDw1mtBi/Xh8fmWrRdbAnXgY6XwSNh6xVvea42tMGKHn+4zb4Y1y/Dh+RwFEbGdXB3wAf/Me5bYX+VEpXEnzSw==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by DS7PR20MB6264.namprd20.prod.outlook.com (2603:10b6:8:ee::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.20; Fri, 15 Mar
 2024 02:51:03 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::8615:efe2:7c8e:2041]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::8615:efe2:7c8e:2041%3]) with mapi id 15.20.7386.021; Fri, 15 Mar 2024
 02:51:03 +0000
From: Inochi Amaoto <inochiama@outlook.com>
To: Vinod Koul <vkoul@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Inochi Amaoto <inochiama@outlook.com>
Cc: Chen Wang <unicorn_wang@outlook.com>,
	Jisheng Zhang <jszhang@kernel.org>,
	Liu Gui <kenneth.liu@sophgo.com>,
	Jingbao Qiu <qiujingbao.dlmu@gmail.com>,
	dlan@gentoo.org,
	dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: [PATCH v3 3/4] soc/sophgo: add top sysctrl layout file for CV18XX/SG200X
Date: Fri, 15 Mar 2024 10:50:34 +0800
Message-ID:
 <IA1PR20MB49531DFB2DB7D0397D82098EBB282@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <IA1PR20MB4953E7BB0B270157C8D1DDACBB282@IA1PR20MB4953.namprd20.prod.outlook.com>
References: <IA1PR20MB4953E7BB0B270157C8D1DDACBB282@IA1PR20MB4953.namprd20.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [tZRzF+14o1BP4nOiHH1IWg2XL7ZldA7VnTkbvSdDJnY=]
X-ClientProxiedBy: TYCPR01CA0022.jpnprd01.prod.outlook.com (2603:1096:405::34)
 To IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID:
 <20240315025036.554158-3-inochiama@outlook.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|DS7PR20MB6264:EE_
X-MS-Office365-Filtering-Correlation-Id: 9332383c-7bfe-47e1-e999-08dc449ac0f8
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	eo5BMaIAwcj30EikZ7mfFvWkzikQaKQa/9yLe4GRvvyFkvd0tpCJAXA3RvZYKBLOEw8x+1jW/6ZGpx24UR92oRd0Lx+aZHTCTIPsMwOkbICf56tNwU+EgrsOzCn9h8IHZF8Y5BFPaRqG8rVsp50i/u522A/Fog6RG6+sdcNHC50xnzN9CaNz2plL484/tVpFjU5KcJtZWRqClSCT2S4g3JC3/m97CgGV7eM0KFHYlhFT7DotIBJg387A+6Jbvv9RaUrXaph7BndkNzFElmvMTUeDx5qW5feJHx7Rq2+zRRVLjYvOZyWs6irCQhiT66QgslkP/v/0QDSCAcO2OAPspTUJxlIPKkqcJVl0n4mrc+SXecSAGFDIS6r5SH9yCyT7eAslPx4fO3p1xHA41xbNxmlgdKVnNVHpRrCY5UFhAgytDBjWO60uZyFJkNMc//cDyc9gEEwaYw/I3WLhvRI2X+cuFvVb5ygt36ilNPzeY1jcHjXc2RI45qeW8LgEgi7EZUpa+NOF78MLys9xJnKE0FaCpQ/hbm7cVorx1XTZ9+lnsWhq2cKtCPErF0a6ICPB817rabBhfIWsTwEbPnOnIaQPBWDPztKaMhZq/JrwOX7bf+uJTtxagxYpRCCdAE/2
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+N+3+3XPq3Bw4uIEWQTlEQU/FFyPF7g7aWLXiX+igqWPsGAF7xR+gInBvwpo?=
 =?us-ascii?Q?J19D47glgx3g6MHprboAtN9RVqfBXAYh/JSLyOdxNMLb+GKxXbNOBpz9CVse?=
 =?us-ascii?Q?sWkZ8xJ+XWrOHi24KBed16P9V7o525G7qi/d1z453jp2826/lyXeW9vDDNA5?=
 =?us-ascii?Q?F9tQChw30jHjpZLgYk+FUdtLqGG2OQkq8hrclHoHa+GHKwMbmcK8t6/f5tXU?=
 =?us-ascii?Q?zkUlPXWK5JRruKaaldgqw3isa0Iune4IDkdwaaoF2qcYC1F0o9Kd8KmYLmQg?=
 =?us-ascii?Q?eYeADmgI2WgA2ONLA5ebuXildqGqX+yFpBoGuuIfh3d8XXnfnEW/jXFs9TaM?=
 =?us-ascii?Q?Pr1whhZDZ97Z11Cj45Uy9kHnT5UhqIf9vukYubKu6scTbk3P2nfiR1c33fJa?=
 =?us-ascii?Q?OIBIL9EF9Ph3ulZExhZhHTqmvFGRYeJtR3tTAJZ6+S+secYvtYVhEFpfr4Cp?=
 =?us-ascii?Q?+lbhCuUHNF/rDuhFV16lPooo6GTYx4Ej0D1guYjerppbC9qWeyyd78nRGd7L?=
 =?us-ascii?Q?/A9hzy5BDJEjC0ReGEKrvIWGHUuaFEwanaFgVz2i6VFLm+xSsro0Xehwhhny?=
 =?us-ascii?Q?BXEEMOoOr8djS+1U4Czajzp8rnMSXj7Ki+WQeyeG2pO7e/d+bJSAxTrzeSBC?=
 =?us-ascii?Q?IlaI9wxHH9cLXuRDdbV6Rts7vXe02rObsKybLBNtxzijOIApSUN2dQ/6L90d?=
 =?us-ascii?Q?TP+5AJsXrhdeZwwlkpiwdPESEPt4j6YSD30C4gsE6216Jd3e+MT2cxHjVB10?=
 =?us-ascii?Q?oUkVcpnBx+N+A8nQxSX8JypVbmYJ6lo6y50htfPppU/B6YdhpYG1fFqgw9xo?=
 =?us-ascii?Q?g1V0y/xFDBrIIdSwj9IvB+wnybX00pL2uBRjvuhR6ffZ9GJw7/9+rUCIFgMx?=
 =?us-ascii?Q?qIkfkB1xrlnJlyWjYee4Yur4oCs4geG6LNixTB+uurBP78cpiP9hwY/hUyKE?=
 =?us-ascii?Q?T+qurOCez5ejAcuTKIqNCEKWgo7Tb9MKcMGZbiqRWteb6ZDKwW0eAA+4gINq?=
 =?us-ascii?Q?ft7OIpiHKcLzaiP0ZvNJ8fGjY+dRbsoibJiM/0s8Iv93tUbMeousLo9dlBEV?=
 =?us-ascii?Q?lq+3aO59/2lzKC1wcXz2aV7nkfutKcYxvFRQoEjtN2JGFoC7fxKtVu8upcTT?=
 =?us-ascii?Q?ehnZi9hbKn4edOHkluq6dkedQs3vJAEfI+6CPCxkjG5F508ahThSUDAV1b1q?=
 =?us-ascii?Q?9RVfzBLygLgpnrx20MHG95eKn/7OtvjYmlbye57nDLDOCPClgQ+XQcLNImEp?=
 =?us-ascii?Q?yavOhrejUOk7Sw2SuOp9?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9332383c-7bfe-47e1-e999-08dc449ac0f8
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2024 02:51:03.4352
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR20MB6264

The "top" system controller of CV18XX/SG200X exposes control
register access for various devices. Add soc header file to
describe it.

Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
---
 include/soc/sophgo/cv1800-sysctl.h | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)
 create mode 100644 include/soc/sophgo/cv1800-sysctl.h

diff --git a/include/soc/sophgo/cv1800-sysctl.h b/include/soc/sophgo/cv1800-sysctl.h
new file mode 100644
index 000000000000..b9396d33e240
--- /dev/null
+++ b/include/soc/sophgo/cv1800-sysctl.h
@@ -0,0 +1,30 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Copyright (C) 2023 Inochi Amaoto <inochiama@outlook.com>
+ */
+
+#ifndef CV1800_SYSCTL_H
+#define CV1800_SYSCTL_H
+
+/*
+ * SOPHGO CV1800/SG2000 SoC top system controller registers offsets.
+ */
+
+#define CV1800_CONF_INFO		0x004
+#define CV1800_SYS_CTRL_REG		0x008
+#define CV1800_USB_PHY_CTRL_REG		0x048
+#define CV1800_SDMA_DMA_CHANNEL_REMAP0	0x154
+#define CV1800_SDMA_DMA_CHANNEL_REMAP1	0x158
+#define CV1800_TOP_TIMER_CLK_SEL	0x1a0
+#define CV1800_TOP_WDT_CTRL		0x1a8
+#define CV1800_DDR_AXI_URGENT_OW	0x1b8
+#define CV1800_DDR_AXI_URGENT		0x1bc
+#define CV1800_DDR_AXI_QOS_0		0x1d8
+#define CV1800_DDR_AXI_QOS_1		0x1dc
+#define CV1800_SD_PWRSW_CTRL		0x1f4
+#define CV1800_SD_PWRSW_TIME		0x1f8
+#define CV1800_DDR_AXI_QOS_OW		0x23c
+#define CV1800_SD_CTRL_OPT		0x294
+#define CV1800_SDMA_DMA_INT_MUX		0x298
+
+#endif // CV1800_SYSCTL_H
--
2.44.0


