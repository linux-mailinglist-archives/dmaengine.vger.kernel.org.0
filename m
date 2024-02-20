Return-Path: <dmaengine+bounces-1052-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91C1185B90A
	for <lists+dmaengine@lfdr.de>; Tue, 20 Feb 2024 11:29:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A91831C22810
	for <lists+dmaengine@lfdr.de>; Tue, 20 Feb 2024 10:29:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA7975F470;
	Tue, 20 Feb 2024 10:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="l6v9k1+B"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11olkn2027.outbound.protection.outlook.com [40.92.18.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDD44612C3;
	Tue, 20 Feb 2024 10:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.18.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708424941; cv=fail; b=ac79J4tYKJHtMIjmqDAyClXaQ3umbEoneLa+R4KneKH2ExraU3H2N6P9bcGULKBR5BpYU5W59XaKkch0pvslkfLYcD3JTZKiPsDL/RIMXOdMrK9myXxyXyNXIhzZP5wHorq7Dr5YSuS7GAiRRDr5uuKYpygSt31I78pv4eurzDI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708424941; c=relaxed/simple;
	bh=gyy5jwaju35coA1NLIYiVhYlDzoZuCdbjcxOYEm3Dto=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iL02E+2Gv7RpjgCkYaLA9AemZPIs6yiGfRlUO3Z+n6a7puDprrJkhTeHifw3ahFhNjpu16G1q5bPuwFAaddlDKsg36HYz8CZVSN4I6+fViJCEGn810Z7bInyWYT4WYQJ3CVJ4ZUkShdjQ9oNCuHRymlYaPt05cqSQ3oxNMXiUpQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=l6v9k1+B; arc=fail smtp.client-ip=40.92.18.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kk8pMHsLf9FCMcuMdVEqQwGnu5SZ/HwuVgdAGzueuNMnACi4R6+fNLI4dKatPMuW0EQYicHuS61sBAm2bZJNb+J9L+jFtWfeHseoiAxEQEk2jR2zwJE5FppvGaGhi0ra+mBbBKvqVPc3TFfXT2cA+g+B2H85AwKC0Arj+5RbrMsdH2ECubqXf2jjX8WsGB3/cNY6qSOmbHGMtLDgSzPxj6rBIbJZG/JF287Y6YCIP1XnC3OQSQ3VSdTBPivaH+7x0dbqWd9voOOByQnPwysFXg7SY0ZDjX/SXoisawUQ0oit/VrisDNNxA1DT0aeNYI8KBq8rk+dvFNR6xNLend/yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q9y4GfvmMSRdx2AyYLR7SV3ok2Wz8X/1DcRtxIB0cug=;
 b=DLJ5Pm4iO3aGq+OlheF5zjhkghxLke4zrD5eTvYggO+ySgiGa+Gw3g2nzPZc7OMib76C8xVMhPFifcjqU+mfLlpY3zt6AX0HQ93Wo6ikDYkDR2mS2hXcEsxkXaZi/IxRdOx7P+WMG8lyJYOkZCwZoaGt/KQ1Ti35cCzaS0JZnYxIj5vcq5LFL10RNpDJBdntIjAqWHba0y/XnF8/AIPAT89p4EqY3heD8qQYgPHQmiupULNL3yEU95ZejAN8UnnJ8WDGKRUi6nuA/fdhpiJddTH6wmqnkE+NuUju3M0HUh3/lW/3ulqSiCj7fvYi0xLubk9dWl7ljZEFiav5v2RrjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q9y4GfvmMSRdx2AyYLR7SV3ok2Wz8X/1DcRtxIB0cug=;
 b=l6v9k1+B8kXPHNIrX/FYMdfAIh44LFs324zM0MftxyaHqIny4NvASxrij/O8uUHU0ssLCnlbIohM4wEg2Y5LOBk58Z1fc8+OuqovGMe5BVufzHotxn9Gp/A7LpnIOIzyev8ATM479wZSFT1FwOl9iVH+S6bdI4qp/0cf2xc0jMYuZ5xWZvVGPjpv/uR+3KjoTvxVoNs0y+1IO+jd2XFNfFveayzAA9Y5wB7Dl6g6scg9+1CUt8qfojMe82EwsASnvUcfCCSmmdvsorB3GYb6+HQEdikXoIuviqZ0zL7w/D5/d4OB6khsQIeYsjfU1du71Ii+BEW9Ft1peULjZ575vQ==
Received: from PH7PR20MB4962.namprd20.prod.outlook.com (2603:10b6:510:1fa::6)
 by IA0PR20MB6813.namprd20.prod.outlook.com (2603:10b6:208:405::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.38; Tue, 20 Feb
 2024 10:28:56 +0000
Received: from PH7PR20MB4962.namprd20.prod.outlook.com
 ([fe80::4719:8c68:6f:34ff]) by PH7PR20MB4962.namprd20.prod.outlook.com
 ([fe80::4719:8c68:6f:34ff%6]) with mapi id 15.20.7292.033; Tue, 20 Feb 2024
 10:28:56 +0000
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
Subject: [PATCH v2 1/4] dt-bindings: dmaengine: Add dmamux for CV18XX/SG200X series SoC
Date: Tue, 20 Feb 2024 18:28:58 +0800
Message-ID:
 <PH7PR20MB4962B924A3BB53FB2C161CF5BB502@PH7PR20MB4962.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <PH7PR20MB49624AFE44E26F26490DC827BB502@PH7PR20MB4962.namprd20.prod.outlook.com>
References: <PH7PR20MB49624AFE44E26F26490DC827BB502@PH7PR20MB4962.namprd20.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [RFWU7OVraIUpj4XNFKtF8C9rBic/JPVJyA7oD2DE2gQ=]
X-ClientProxiedBy: TYCP301CA0032.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:380::15) To PH7PR20MB4962.namprd20.prod.outlook.com
 (2603:10b6:510:1fa::6)
X-Microsoft-Original-Message-ID:
 <20240220102901.874602-1-inochiama@outlook.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR20MB4962:EE_|IA0PR20MB6813:EE_
X-MS-Office365-Filtering-Correlation-Id: 973d6829-ddc2-4cad-879f-08dc31febe27
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	KFPXQSaQT1nA64E51kl4QrQ7BwANSdrOMDUgrGbsyOnYRrujLaV4IgQ5TBzyfznA5FE2Tz1ug/oZley19NgN6PhA5IdWVwOEKk34GlOr/ERrPXaUt07Q7bfoYMEXOktieLj6nvLwY/n7FbyMFjx84oeB0PCDdvdU3yo7aS/F1bEKb1R5ymxW7E9OijlifEJgONWNlFZeaERXKm6zdO/scY4jstCIyIVNcmMhEQ+sVZq4Eha/iCAil24ct0VnOpcpTY0R3lEmUWfOJ+qH//tJrGo6dAECL2vMGkM0PVWcE3fSsbSHLwg1BoBMuIEj20OOX2PORtLmA4POTPn9LfwP4/yQ6MAAGwpdYWWKw+5aG1zv9UtIczwUcJAqA6WuAjkavU+EvdTowWpZ5Uk/4tWmPelwjZjNbyQ0q6WtIYsgbLlY8CrF+90Xxh14OP/FAfjf0AUWiDML7IXl2isiPx13FQ+549Hf7T6gjXT3iBU0he67vWhCRcERgzlZZoS515WcX/mcPFU+6IpzjXS+5DJ78DbMvqTlKA4Ypyzr92LFvvHVJZrE5IdLAdXurgB86bl7eYKP0LmBVbERR6Q4nG3VosgJp3wz1oVE+WHPhdCvN0toqhAC99px3hYfz+Wmua3m
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Lor94uOkPYVZCfx2I69bMLES3rklxsNe8OIl7eaCMxNsIvz2pf/o8bvH7sA9?=
 =?us-ascii?Q?lRV0+1/vePFGOr5AaxxViAfiyjU5DuVnJL4pceSModAKbm29TwucuzxYEXvb?=
 =?us-ascii?Q?TjOKCPJ6mwpEdCdgGMGj/Na45dHuw5bQYH2JE/Zo9ci9IM7p3voU/HvzKwqV?=
 =?us-ascii?Q?bbYvVxcVfIdso9HbDrK3Y+0u8VerHaKnvnuAkNwliQKttd4zpbvtNzXHQZrj?=
 =?us-ascii?Q?7vRdGJ5+E2pqJUMFRHOGSEjIXyYvUz2Q0FPZ5garS0p1nOfxMpQ0cNuCmCGe?=
 =?us-ascii?Q?9HNxt7I+bVxBWSNiaxP5VZvhit/yTwlWgz4K7ujBCYIN26WvsKd70yHsFykT?=
 =?us-ascii?Q?DwJgojzWYQ1T3HCpv51rcKjlxKDwJE3KUvZFtuH+4TNGi2yfUrpZMteNeopp?=
 =?us-ascii?Q?p2yu/cDvz3lszmdr41Br1RIb22BfskfxiMuORKDLxGLDZdzdW5kfcWENmUEW?=
 =?us-ascii?Q?RqJDz7yDJ4J3ymki6R7jDDorqp1SUow5jYi8Bc1auoVeghUkhouULq7hiO9E?=
 =?us-ascii?Q?vEcHIPpOiJ7DoPbcAANTSiQoGPjQmy2PMKiCsTDRhnwidKW1tUunF8TEx5Y+?=
 =?us-ascii?Q?OTBR3DIqwibL4P463ZYXqg/+9fonr1oV/ZY9AFAvLxDl36iu06Ug+wtdQu07?=
 =?us-ascii?Q?iK5LDQW4376PHfR2iKhFR7Bj+2SC/1CTe3FaT9ZA3LUTWNJBq6piR9bpQbNt?=
 =?us-ascii?Q?SqLA3vagMZUDHWlTsJVIET2/57MtRV0jYM5mNCeq+RLaBn5UOyE+/dmRq695?=
 =?us-ascii?Q?SxZbBkPmPRWqG0mR4irniGSASgjKACTETh0SqprxXDhQSNRivfgKMQqMs/Tj?=
 =?us-ascii?Q?zI7EhmGvOyuZrh8199Dx9FBTsS5OpIaB9fObLntOZpN6h4fFH2cj2CNwMLVe?=
 =?us-ascii?Q?AUWCTa2rOsZuw9Q8XyZd6jssL2fYFNuD/Qvf0OAdWN728rmYukXAv5aGr5cw?=
 =?us-ascii?Q?Ru52PTjnOJogPZjm4BermzJNV00FhSVxMNJlV0JNgAgionPhAdKWIEcsi4qb?=
 =?us-ascii?Q?jTri2tO01T/l+722yi1f8aU0JXwh3XmQzh6qHzL4txeac7CxbG39XjvDsNJV?=
 =?us-ascii?Q?VSCMq7YURXXUAWYIcgq4HV3sDHg/hmCaGnL4V4oUnP1NGs9yUU/GaJG4tKHg?=
 =?us-ascii?Q?oyZhqwdGWzcOE+3Ya5tZ6iCl8m6LWotZdxrAvyhQSugmwZjbLm4A2CLc3mxg?=
 =?us-ascii?Q?DibVN941BasytOB3OeDxB+kVmPYsryV2nYI+ZuoqXNoL02BhxYztLkun4+FG?=
 =?us-ascii?Q?vG3OuBTBHgSGpjrQ7uVg?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 973d6829-ddc2-4cad-879f-08dc31febe27
X-MS-Exchange-CrossTenant-AuthSource: PH7PR20MB4962.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2024 10:28:56.3486
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR20MB6813

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


