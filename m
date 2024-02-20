Return-Path: <dmaengine+bounces-1047-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CE39385B8DD
	for <lists+dmaengine@lfdr.de>; Tue, 20 Feb 2024 11:20:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2C221C22DE2
	for <lists+dmaengine@lfdr.de>; Tue, 20 Feb 2024 10:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57729612C3;
	Tue, 20 Feb 2024 10:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="YTdeAf6j"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02olkn2069.outbound.protection.outlook.com [40.92.44.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C72660ED2;
	Tue, 20 Feb 2024 10:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.44.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708424432; cv=fail; b=VdlnwsABSpNw9fO2KOKv9RcrOt6BkBFhPul+eHdV/2v+HKPyVnczeBgvzrT2vt5IWkYCLzTwt4sD6b6zcm6xxM3mI/GulQ9n5VI2iYRUfMX22Isd4dJZAZEiLNFJ3TM8+t0rQKh9mhqsRgScbXR3oxUTZtPAKxxYd9SFipEOa6Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708424432; c=relaxed/simple;
	bh=gyy5jwaju35coA1NLIYiVhYlDzoZuCdbjcxOYEm3Dto=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WlLpa3Wg3WvJSwY5dj9mYpEvQ9Z8RMDxaygXgWkQ30yzXmYWwEGsTQfonKax8q2MGeC8wsR9w/7KYIToUFRJmGXSh8Fyecbdpi7w9uN2vli9Elk4q0rNeDyUf4Ucdiz7PaoV9p3JrhPunw8xFSnWGURL1I4YgbTxXfxqnGs5OeI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=YTdeAf6j; arc=fail smtp.client-ip=40.92.44.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dR1nMqgsmc5otO8L02Li6A6ISF3+zoipWQs90HcblPZNXeShw4hq5AIb48gxkK/vS3RhWsi5izUj/L7ft2LI7Xh+rrObuTmXFuZEzNy6zG+iBkdDUs/pH+O7JpmlSwzsAaQQAMq1VGxQs36UlqSP5tGrSLVsyjvxW/zJjJkwfERUWzo64yjOtanEyF5XC+cLrUXiGgeF8PU8N0YSN8WMnVlE5sRjFCEmU0pTYpaAsrCQGuTCH+o6McY27NTjKhK2v4gSzyXTBeS+6a/PlljQGmRMtabAi2Ext8O0WkwBddilW+JwfWP66GQqnu3HOLHj5b0oe3tYin+PsMblBmn3Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q9y4GfvmMSRdx2AyYLR7SV3ok2Wz8X/1DcRtxIB0cug=;
 b=A02tJGwt5VI62ljCpigJGEiGn9yrCWwrjxyI5/aiJMlwBLz1cYO8WJ48trliu8W3Q9gpM6bNWMJkdruEgO0YuKEaKSBaG7Edsivhl0ZiW0Q//8XZkMmJaZ/mBmJV2VQDorwJoGeTJAh11khVsayHX4MZOK48p2c8xPLK5JeKPgugz7gvUdx8Q1rxRRFaXSwlbZtwLRuzbkekSL3fueisWmGstsgERLs77/1mPX6XzShBBckSkn0W3YsijO6LxDejoHuYzM9Zye0+CaY5PXPP5T13v6FpHoPxXH3Rg8VOAF/+l7TJELv3buGGpQHN1wultpz2OH9Sn7Bczmog/XY0cA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q9y4GfvmMSRdx2AyYLR7SV3ok2Wz8X/1DcRtxIB0cug=;
 b=YTdeAf6jNTpQEzT9ViHoeB0E55Y9z64hrVm33x10uOvwL7GZoVQLDuQBvHxM0y8K68Ki6tUAsP0U5p3Xt0TlT74wYPVy6PQi5nddHGgttQNzAgxNup2E/LSA1HdMXHaDNmk1AYnSfaOXYDIkMWTSTuD3Efw2+I79vgaAUaemoCw+MzHvKwlnRCwHIpwJ/KMmGc8RlPKcxyTCFDfbBbT64MKZjgj+PStVlOSGj8nW+gUX08cmWHl0oyJ2KJNjVXjBt7A+O3iyytemt9lWBfWdx/v1wHnhmuPK+UZU00bJK0VDy3FadtOJSIMFUS2vU6Kdho1eJAV+Ad/ry6XwM2iGyw==
Received: from PH7PR20MB4962.namprd20.prod.outlook.com (2603:10b6:510:1fa::6)
 by MW4PR20MB5156.namprd20.prod.outlook.com (2603:10b6:303:1ea::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.31; Tue, 20 Feb
 2024 10:20:27 +0000
Received: from PH7PR20MB4962.namprd20.prod.outlook.com
 ([fe80::4719:8c68:6f:34ff]) by PH7PR20MB4962.namprd20.prod.outlook.com
 ([fe80::4719:8c68:6f:34ff%6]) with mapi id 15.20.7292.033; Tue, 20 Feb 2024
 10:20:27 +0000
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
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] dt-bindings: dmaengine: Add dmamux for CV18XX/SG200X series SoC
Date: Tue, 20 Feb 2024 18:20:28 +0800
Message-ID:
 <PH7PR20MB4962C36C86B56F31F14005CFBB502@PH7PR20MB4962.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <PH7PR20MB49624130A5D0B71599D76358BB502@PH7PR20MB4962.namprd20.prod.outlook.com>
References: <PH7PR20MB49624130A5D0B71599D76358BB502@PH7PR20MB4962.namprd20.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [RsOGHVyKM6KT5nBM/G4YCPma1OebsM13A9hGmRSxFbo=]
X-ClientProxiedBy: TY2PR01CA0017.jpnprd01.prod.outlook.com
 (2603:1096:404:a::29) To PH7PR20MB4962.namprd20.prod.outlook.com
 (2603:10b6:510:1fa::6)
X-Microsoft-Original-Message-ID:
 <20240220102032.870200-1-inochiama@outlook.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR20MB4962:EE_|MW4PR20MB5156:EE_
X-MS-Office365-Filtering-Correlation-Id: c746c2e6-54d0-41ee-251a-08dc31fd8ecc
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	6W0yA4qhXh/8Pc6vJZReiMgUYFDttPXGRbKJ6NcBenIpbbGox8Ii2i4AKa2JqitHidNe6swnFC2EsP+XM3wprtTuZtCOEFxlRIn1E+/qu6O/m8/ZQysqB81XMP84Ieh/aFvskF+9YfrX5AztmbIDoqW5UNMEbEVkneCnNkDNMlebLv9bujK2uRHQxAGEaphkIpTMi7zzbz7PujJfgI6tH+uHjH9PeaDeWIDqTXxoD6Qll6F5/0uYbWJSMESDnYaP14T3bfnP5ul2xYQR1R+S9TPQs/nMN8b4CX4siq/FyulCM3VId9li+F/P6+3mogy9hcBf62TNOuXKK5VVlqwDTmFkJ8Gp5jpwzT+Bw4i5oub8eWZ6vf9G6dWNu04eiQXKNQrGz0YoyTtswfA2OZVotMKj6rLYRqP4MTmld8W1Mb7Ea/yzu9vGRxF89neMK/byZ2uiv2lS0cmNYTdLsP2EJ9E+hkeLGwh4i5UAhiHO6ScRphhF+JkL5daBaMTY4Dotjn69pG8RHXLhdKvaPIlHt75U6wGXEKLWev3zU0C7E5OnyhhT29tPIaxbbBGWmVAfWkBbH9amozjjWckG/qc96c/CxQHom6l2AD9PvVOMnSY6sSv5OrPYE8Md1XYcEwHg
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NbJyoN9GhzFqwNM8Pyx1iogi3iBn2PD66z1A8SknoYgOkK+kX3cVylH72PBG?=
 =?us-ascii?Q?7czXgTLU5YebFKjIB/+M/AWQBhuhv8eziDu2XJb+MQtvNjX9+7T0eTvD/SNU?=
 =?us-ascii?Q?WYlWXLCyap/dfTz/eZpnVEcJ4kyhMLUiSNQKg0e5iAfkMqwpl3qIstJxxONh?=
 =?us-ascii?Q?oP2Y6EKK1T/tViSDQSQQv9nX+fqSW/1XxUqD58Sa2Cs3K4bxNaTc9WH3CLKn?=
 =?us-ascii?Q?K8imWKpZNjxd7MGEm6tpTD7j37gLt1KkftxVOhLHNmKuk7E5VdRWJUGdgNe/?=
 =?us-ascii?Q?HZ6e8e5EFtNTp8lwU526eWJXHYfLWtH04Dm2Ga26jUD5np5nPFPMsFwTLh85?=
 =?us-ascii?Q?m1QnuZ/DzG5g0wIYocEJeFwMkc+lkK8ULRayrJxIgUZhImtqEinsDjoaSnKQ?=
 =?us-ascii?Q?HzqgtmMqbvoBWTfwxOq3Z97h4ceiCOLPn4roERvwn6/+z4aEJE5Nkv24BBrG?=
 =?us-ascii?Q?wwOVhXFXmqSfa7lHssDw62ELLQ4LUSVZvDFsE3j9JD24DnglgGcFKX9DmgYJ?=
 =?us-ascii?Q?r4LO3Pp4AggonDrrhJWfowt9rNVCnPOSWzPUuTA+gqvvX7yNXJKctMmvwc6H?=
 =?us-ascii?Q?hL7UAsiOuKNHlf9eyaAMp3ZInohCa/D59XJaufVppkTNl5FFP0FTVzxsA9UK?=
 =?us-ascii?Q?1WF/TETKnfiGAWQjRvFt9dsbHFXzJrK4/tkfBW+MA/ehFKbUKK6Q3rR72aX8?=
 =?us-ascii?Q?ICYHPCYDu/B7jxVc5eUdAIoiWuTA4yB80V8wEc02vWXp2tZHeG/csMLtTUek?=
 =?us-ascii?Q?3FpXahY9RcvcNHKcjlfEWa5/VcxxpHHzGJLKeSxAuWkJPJG8OvWZ43CvLSOC?=
 =?us-ascii?Q?6ylaRbyrSG9WvyCo+M5HqjNh+rpDo1PrJIijT35UEH6dC3EXgMWgaMIfn/5V?=
 =?us-ascii?Q?Q/MWAnEiMGYnPyu35AdR5g5WMEedei9hTRUgGh9Vd9nMgi23/HkzFbK5T/yU?=
 =?us-ascii?Q?X/W+QW2u6QVjjQUTKvOYN3GGFrjjGXKQmAjBYeoJ7XaL2N+pSxGyB2rNOO09?=
 =?us-ascii?Q?acOyLe4AQwADf3+3UuurqDeLg29nekMr8ylM7A7xmOpinjIfQgrb0V/z9jHs?=
 =?us-ascii?Q?ZfVAdunewBU67Oefjo0us3wgRK9vrQ5QfBk4541YsaOawclLbP+L7JjyNwMu?=
 =?us-ascii?Q?8k6G0ZyD5DYpSQ4IdjNu4I1Yi3lnlS6JNbW7OvoNDFm71IWrAjN3vX7wv16G?=
 =?us-ascii?Q?d2NGWdTCHVBUp4uULYUx/xK1xfeUh3O33f/Rl+Vxn4Fdduoud4ZwffPVeLTd?=
 =?us-ascii?Q?brw8p9XPMnCF5/DMRUWK?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c746c2e6-54d0-41ee-251a-08dc31fd8ecc
X-MS-Exchange-CrossTenant-AuthSource: PH7PR20MB4962.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2024 10:20:27.3730
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR20MB5156

The DMA IP of Sophgo CV18XX/SG200X is based on a DW AXI CORE, with
an additional channel remap register located in the top system control
area. The DMA channel is exclusive to each core.

Add the dmamux binding for CV18XX/SG200X series SoC

Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
---
 .../bindings/dma/sophgo,cv1800-dmamux.yaml    | 44 +++++++++++++++
 include/dt-bindings/dma/cv1800-dma.h          | 55 +++++++++++++++++++
 2 files changed, 99 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dma/sophgo,cv1800-dmamux.yaml
 create mode 100644 include/dt-bindings/dma/cv1800-dma.h

diff --git a/Documentation/devicetree/bindings/dma/sophgo,cv1800-dmamux.yaml b/Documentation/devicetree/bindings/dma/sophgo,cv1800-dmamux.yaml
new file mode 100644
index 000000000000..8bcbf7beb432
--- /dev/null
+++ b/Documentation/devicetree/bindings/dma/sophgo,cv1800-dmamux.yaml
@@ -0,0 +1,44 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/dma/sophgo,cv1800-dmamux.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Sophgo CV1800/SG200 Series DMA mux
+
+maintainers:
+  - Inochi Amaoto <inochiama@outlook.com>
+
+allOf:
+  - $ref: dma-router.yaml#
+
+properties:
+  compatible:
+    const: sophgo,cv1800-dmamux
+
+  '#dma-cells':
+    const: 3
+    description:
+      The first cells is DMA channel. The second one is device id.
+      The third one is the cpu id.
+
+  dma-masters:
+    maxItems: 1
+
+  dma-requests:
+    const: 8
+
+required:
+  - '#dma-cells'
+  - dma-masters
+
+additionalProperties: false
+
+examples:
+  - |
+    dma-router {
+      compatible = "sophgo,cv1800-dmamux";
+      #dma-cells = <3>;
+      dma-masters = <&dmac>;
+      dma-requests = <8>;
+    };
diff --git a/include/dt-bindings/dma/cv1800-dma.h b/include/dt-bindings/dma/cv1800-dma.h
new file mode 100644
index 000000000000..3ce9dac25259
--- /dev/null
+++ b/include/dt-bindings/dma/cv1800-dma.h
@@ -0,0 +1,55 @@
+/* SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause */
+
+#ifndef __DT_BINDINGS_DMA_CV1800_H__
+#define __DT_BINDINGS_DMA_CV1800_H__
+
+#define DMA_I2S0_RX		0
+#define DMA_I2S0_TX		1
+#define DMA_I2S1_RX		2
+#define DMA_I2S1_TX		3
+#define DMA_I2S2_RX		4
+#define DMA_I2S2_TX		5
+#define DMA_I2S3_RX		6
+#define DMA_I2S3_TX		7
+#define DMA_UART0_RX		8
+#define DMA_UART0_TX		9
+#define DMA_UART1_RX		10
+#define DMA_UART1_TX		11
+#define DMA_UART2_RX		12
+#define DMA_UART2_TX		13
+#define DMA_UART3_RX		14
+#define DMA_UART3_TX		15
+#define DMA_SPI0_RX		16
+#define DMA_SPI0_TX		17
+#define DMA_SPI1_RX		18
+#define DMA_SPI1_TX		19
+#define DMA_SPI2_RX		20
+#define DMA_SPI2_TX		21
+#define DMA_SPI3_RX		22
+#define DMA_SPI3_TX		23
+#define DMA_I2C0_RX		24
+#define DMA_I2C0_TX		25
+#define DMA_I2C1_RX		26
+#define DMA_I2C1_TX		27
+#define DMA_I2C2_RX		28
+#define DMA_I2C2_TX		29
+#define DMA_I2C3_RX		30
+#define DMA_I2C3_TX		31
+#define DMA_I2C4_RX		32
+#define DMA_I2C4_TX		33
+#define DMA_TDM0_RX		34
+#define DMA_TDM0_TX		35
+#define DMA_TDM1_RX		36
+#define DMA_AUDSRC		37
+#define DMA_SPI_NAND		38
+#define DMA_SPI_NOR		39
+#define DMA_UART4_RX		40
+#define DMA_UART4_TX		41
+#define DMA_SPI_NOR1		42
+
+#define DMA_CPU_A53		0
+#define DMA_CPU_C906_0		1
+#define DMA_CPU_C906_1		2
+
+
+#endif // __DT_BINDINGS_DMA_CV1800_H__
--
2.43.2


