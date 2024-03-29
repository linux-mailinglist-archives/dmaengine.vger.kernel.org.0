Return-Path: <dmaengine+bounces-1647-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 90DA8891157
	for <lists+dmaengine@lfdr.de>; Fri, 29 Mar 2024 03:09:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 182431F24401
	for <lists+dmaengine@lfdr.de>; Fri, 29 Mar 2024 02:09:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25F1F3BB50;
	Fri, 29 Mar 2024 02:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="YfhRXhGj"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10olkn2032.outbound.protection.outlook.com [40.92.41.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 485523BBD5;
	Fri, 29 Mar 2024 02:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.41.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711677884; cv=fail; b=mbtwQtOmxNtFHYHxpHxJodVGrYLqx9awci7IJELoozqC5/0a/xTFOTE9GaUvs8M9VuqeGPpfY3Sg9ITqYsLb+OeK/u/ES8Wt+OqWP4KClNATiBy8RMzntfGdHDfBd5Ac6x5rV0dGrHQnHW6hIjfwjZSysWFVJGFZS5xp274Bszo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711677884; c=relaxed/simple;
	bh=8JgoSjCMgT+4YWgPAd3BpnSD8PgiKGpOWzslfEu2zi4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=stHNSVa/5wmnG69hOf9s6NN7M30pzC5sAtYfCg4s7QuKqqgkjvBB9QMCU+ZwLGn+1QsFarAYxWsHqfEM4y6pTaaJV3/iDwfUL26z7NRx1b3ILHPX8xpW7dWwKLYr3Uxfnj0XTrMLaOamSYRhkSawMjuVvL9sX0YM6zKO2OQgGSw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=YfhRXhGj; arc=fail smtp.client-ip=40.92.41.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YfV0l6rSXLlkEXpNb8Kw5D0FRziqfi5NtY8pe1Gs3HxSxJgvuwc1D4Q+DzUkSIs3pesBAN3daD+hnZjRqJJuOICu7b+l1nMstCGSKa/0WiQ/zVjMQC/APikVd+OAfhXrLgxlPb6ZA2QE+l7Oci6Nexizm4+lh7iPwVUOCB/Iuq5bWLOSR/LLNglnJZYVBCETpmuPZymVvA3Xkkw7cGbTOpQgOzXrpJ77lwj1X3lKXh9yJk057Cjip4rqKrFc4QwNCuUygCPXrkBFoz4/Tg9Bgm62TjzUQyyVV9V4Ps9Bt4wVC9ikL98fY2ZGLo5w6uLjUzPA/5lkrBrt6nSczh6wyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kS0KlR6sMzZ54c2Mbq9eCPI0GiPAwbDVfnXhdu/XLI8=;
 b=KQBuxl8jlDNWc5yVL17mHCpg4xaGp3sjiVtHqkDx+T3mbiGs1x256EkPIcXgjrcygJvnieeCwn4heZNI8UOwFe/gm4pOx1IndeBrDm6v7KUuTxOM/FaXL5ORBz5/PiFmgFmEPDJgr9KbwKzr8wyDVl+8KADGeoJg0fi6qoSVi/AD84YF2BLNWltJMb+2Q+dXk/wUH0Z1RdwpbtOXzWG4fCz0wmDiMDO6NX3CUZCk7dzKFXJVkWggKr1Sc3UMVi2+0ikkep/DmQzjwcCOBntJdJ+2yk4OqJVSEmLHyx+w+uMJemCfyiGM2G9LkPe9kpOPrJPmlxZ6oD7IcZ3fGE1Iog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kS0KlR6sMzZ54c2Mbq9eCPI0GiPAwbDVfnXhdu/XLI8=;
 b=YfhRXhGjKlJz5hbC+upkEYfp8BhKEydeJCA0TSI02Gc/CvZ/oBA6xmTE9+QZfAZK01JjkCJ0oZcsnPEddsAohf9wcKZBB1y7qhKqpjEtzSIbSVuP9qi2gkqGTcqgVr29UL1d5lOtNEuPhfrj8+wIpwlz1/j81Wnd2kSeYPuJ5exs6pByloIHhnEs8SOPY2hXKeQcdT5KY7zQjoOltegT9kA371vkT+hLujOkABxxE1Skkc9Bdv3ftXPRxnAHwBKdGO+4/x/z+C2YDe5U7QdZR5AvAtKhCjqwd9O9BQEOvwAgqsEuicpfVY/he9nTDFpP80OxrqpjstEifhrX1ohBBg==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by SA1PR20MB5151.namprd20.prod.outlook.com (2603:10b6:806:256::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.39; Fri, 29 Mar
 2024 02:04:39 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::182f:841b:6e76:b819]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::182f:841b:6e76:b819%2]) with mapi id 15.20.7409.039; Fri, 29 Mar 2024
 02:04:39 +0000
From: Inochi Amaoto <inochiama@outlook.com>
To: Vinod Koul <vkoul@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen Wang <unicorn_wang@outlook.com>,
	Inochi Amaoto <inochiama@outlook.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>
Cc: Jisheng Zhang <jszhang@kernel.org>,
	Liu Gui <kenneth.liu@sophgo.com>,
	Jingbao Qiu <qiujingbao.dlmu@gmail.com>,
	dlan@gentoo.org,
	dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: [PATCH v6 2/3] soc/sophgo: add top sysctrl layout file for CV18XX/SG200X
Date: Fri, 29 Mar 2024 10:04:38 +0800
Message-ID:
 <IA1PR20MB49532FB358A842A2ACC5E878BB3A2@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <IA1PR20MB4953F0FAED4373660C7873A2BB3A2@IA1PR20MB4953.namprd20.prod.outlook.com>
References: <IA1PR20MB4953F0FAED4373660C7873A2BB3A2@IA1PR20MB4953.namprd20.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [HAFTpqMxC6TWYTLTdMcj2imac7st8l6uSaeb7RhGIXY=]
X-ClientProxiedBy: SGXP274CA0013.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::25)
 To IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID:
 <20240329020442.373744-2-inochiama@outlook.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|SA1PR20MB5151:EE_
X-MS-Office365-Filtering-Correlation-Id: ac6c8368-a0bd-4231-c874-08dc4f949761
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	B6TZEXAupqvEPYciboh1sR+uib5K6idJxIZMNq0n0q0c99hJ1XiKkiVuNSZHyDdKivVp/CybmEfpzMkhE5/S4PfVXUBV+XFxg7lWLjNtbAIL5k74NQbe0l9zc1HuWCjcjfPz3STaMiQF5HyafLMGQbJM5q3y4SHCJN5UnqNHJ2BITOysjI5HNx8WtL5pQ7MF2cnuGdI++QG4HTkDEGrbA63Rc7+lPnRMPt1jDleOiEngEl/3byp/pd/2xdxd2xFk624CcMN1T4btd1mLLgf1Mm4ZYf77xag+HAM/MyMEyZuqDZYUWHCxTwGyYqDkbq5AnQGVkYvbc4IjRwdioMNcld5p7SHpGf9OorL/4x7WneMfHrgxGIg4N3lKC763D2s3txpdDS+BXiChff9m9tZ16W9XacT9sldTy4i5xoh1PLPBvmLeRuS83aMH2BgC62oQfo3RVSNp92wAVG2T1CIVSUcaNzPFTOMqPYDm0NNIRShYhEjRhYZc12yD0IXkypJAeoVNmVKIJDHA1sim75ZtKQ/UhiJyxqOCWyzX5lrqE2a7d/osCSjTahvFA1RYxRt9yiFUynWONJVA+o4y0ibZFVTNJuHvPofF6KfuYuMGUhLvmuUXY7msI2h+i7RBxMEb
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xuH7O9yKWY5w/EDokYsVm6V9LM0GtluwYIzS/dOy9CSo2uAcOIysOlQ60+qk?=
 =?us-ascii?Q?5pDznNx/+nNz4t0Wr3y457I+iHPPR/BDTNYv5SDyxTmYGZF4EFw1V7Vc7/5A?=
 =?us-ascii?Q?Zl1VVa4W7ipGXQjExxV9n368iOUzhLPXS1UvdKIXn+BrBnohgC86eu1MZsbR?=
 =?us-ascii?Q?f/o3574jkQmjegleZKcWN8Tlyae+7ycX8ZjLqATKxxsSBl/jrjlHktC5dmNX?=
 =?us-ascii?Q?8qpTfxUWpUn/JCiVk25h4sx+sDehxYuw63++p+g3+H7egCS4BKREiZ9Kfu/c?=
 =?us-ascii?Q?VJ96Ti9aMZRrZmoemnvQkdP6Hs+l9YZpss2LIhs+yJi0J0jbOoKvnilPPIfC?=
 =?us-ascii?Q?tG8O7y8/U9KR37sk855ADKEyPPoY3p12mVko3PHQQ8gSTA6t0iPr3+cynWg9?=
 =?us-ascii?Q?EIhs8O8OxdtHFqPzrLrlpsJiVSb9t2x64yO15Wj81cqp3x2XOs7uWPaPNNJe?=
 =?us-ascii?Q?0U5y1xFoKPdfVcABTS+M8sxHy8wNraKzLoRqDy8TkL4OsJ5oN30xtbNSkrvp?=
 =?us-ascii?Q?OyTftB44vuc231LQARUfz6EnjNJ9pUdSwZ6DZsJ+mw0n4nVCl+Z/NhI744B4?=
 =?us-ascii?Q?ljs6v4nag8tlN/L2Fa045O8KwAztzYNDqsBpj9OKzlQKFUYGgh3Yx5bnFZdN?=
 =?us-ascii?Q?3Bd6oRHves1PEp2d8jtrGoaiZqgUMHqA7efVMloSAo9LhQbSx7rKsEVHPTQI?=
 =?us-ascii?Q?ekWW8HVmxJfGbqsAHRS3OFTG0WiOJ6yIiryPeSfD7aMloEDuIWhmoaWVT3/U?=
 =?us-ascii?Q?33gsuk0fdPT4TZseJgbmUvf30h7jM8Uc3E7FjhdwhPjTJtHlcOjtdjtRO+XP?=
 =?us-ascii?Q?OjzTFMwgtlP/qVWzgHBuzkS2MV8Hfhh60sbqbx41q6IMUtrRJu0Q0tkb5BzE?=
 =?us-ascii?Q?bPfA54tuaQqvPWFFLQrn9g+WpcTHAil9albh+ofwDSv5zQCNvASOa75iOkts?=
 =?us-ascii?Q?Clb085Uqu42w1au5Fuk/8h771IOhG7et2UbxjXAK/hbigbxNbtr/SunK38RC?=
 =?us-ascii?Q?mA4mrJz227W/jWirHW5uca4AfQpXT7sYwrLsGta9938Jx+kY2BxUsQSB0E7s?=
 =?us-ascii?Q?mb1hxixitU/s+h2hPyfMsKQFoPMv1FfaN6exhb5AYsI3uCV9qW4AYgzmPkPY?=
 =?us-ascii?Q?AFAbHbZs3a9J/QxP+w/shgcXVGEhp6n1uT/w7e4QKFb1Xtxh/wuU+XD3sQ/V?=
 =?us-ascii?Q?xdjQqp/x+p6Hk1qC438SFYZWToLoLjWOMwkW50YrDp6BW8T/7rb6nnnagd1c?=
 =?us-ascii?Q?mykX27waBQ1HaIk+xhNd?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac6c8368-a0bd-4231-c874-08dc4f949761
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2024 02:04:39.7542
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR20MB5151

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


