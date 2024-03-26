Return-Path: <dmaengine+bounces-1485-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9797588B70D
	for <lists+dmaengine@lfdr.de>; Tue, 26 Mar 2024 02:47:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F8B51F3DD23
	for <lists+dmaengine@lfdr.de>; Tue, 26 Mar 2024 01:47:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 818BD2137F;
	Tue, 26 Mar 2024 01:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="MHNGm17L"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10olkn2030.outbound.protection.outlook.com [40.92.41.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80C6C208C3;
	Tue, 26 Mar 2024 01:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.41.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711417630; cv=fail; b=FJ3ZuTGkG0QiW5MiWB7Uwq2b21x/ufpH1b4aBowciSJKDxFE970bctfN03Xl0TZq9+IlA911S6vLZIsQdc8o8M+y67dmm9LN2q4BP+MC+hZM6kiGVor7xKOWT1TFc9gHhq5860xAkE0lzF3wJI55kSEud4d38NVVz2worEpj3mI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711417630; c=relaxed/simple;
	bh=1OOsucIrRjpdfDLKsQ7i9+kFepqGo9S+LcJ3bptx/Yc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=unkP8vCKm7GUCVqc62jE7ogCjw063un8xQcHiAMaSpgzK4WMbIOb0FyqpG5C/lC0MahYAWrIKiMz2/G7MM6Ton6h1ZEXx8+MCtxGKvVdJrW1qpY3UqUD7Cxd1xkEnArnCEGJkIpgTDPqE3xeriz7khoxxR16DxD3/JBkwJy63Sk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=MHNGm17L; arc=fail smtp.client-ip=40.92.41.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FeP1XG0TPAGui/YiWHZZjTFgOHr8AxXJctqXrccOhRRNiIaH3gn21qDbGICL9iFGE0fxG3g7Ov5KCT2UcLjk1JqVuPXNAMsa5JIUAgP0qvTpGAs768E3xAq6seAnxqnAeIu5oRzVS8C+tefOmWBpxHCSJprKUXq5jJ1vY+c6WWP2ObDErs0Relkrgc4mpHXxLux8z93Em1WAM//8ozuKRCWRX1v3/ZZF8jVThx2ZrH5lW4CLoCuFIIerU70VSbx0gI4Q/m+jcqI/oAcLs5WWqBp7MwdKybE0vketm5e0WnaY5qx5HmeE0gZUOavG+XVDGuoZNzXzd7VMn+0veeTtKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dtomVtg4mIqjy/DwUK3ruv+kxALMcxzSl3aOBQ6jDyo=;
 b=jcfSqqVRB7oWI0PL0EwdgGhHpU06f/sloVrYMKCwM51nSZfe1FfEk9hQ6et/51F5/66YVcBF81L2MJ5eCyj0YONd1+Cglv93tsSe4iJZ/B/4/NH60ZbWofb/BMwDNZ2BzW/B0oeimFa0yfX7BaxZVmq8nYt6DGKXTXUN13csYJ3rHExh8R7c25nRQPJcvf0m97Q0WWAZ6J/BcQb/t/fu1ai22YPKA8Cc1QZfkMt9/HBTJl6Lqwml3Yc9UOYHr7J4O7lBVzkHHsJ5zvEJKhUXoRtSUhGFR2uoj5sij2CJKSgOodiWB8VUWROtRW5d+6QnZki/MGKqmU3PW2JdQKbEmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dtomVtg4mIqjy/DwUK3ruv+kxALMcxzSl3aOBQ6jDyo=;
 b=MHNGm17LnLo0fLRvbVtBvbX0ph4rAVzVqXRyN56q2/ScwTgC6VyNqytBtwcTfh9S2WYyWp6Z3yTlIZz6y3vGr0CSvfXzQWMOHQs6BbInfccjQcIE5ForIH/FYcWq5nbPDiznO6HMOF7k6ZH5nDu/tBMfau23SDrK+gNUGdOItx7MX6PC5G94VohaikLqx20RispiP+ZdO5vn/HGBMnGEZRrweODa/pyuXFHE+eu1b8SE+b11KGUQh68uoeDkt+m5HJIAlQlbL4kFFntZZN4BW6cE3z23zDrzA0siGNwm5MGO/DuI91Js/IYX7lTdNhz+uwFpkn9B4JcpID4rjVvtcw==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by PH7PR20MB4964.namprd20.prod.outlook.com (2603:10b6:510:1f8::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.30; Tue, 26 Mar
 2024 01:47:05 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::182f:841b:6e76:b819]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::182f:841b:6e76:b819%2]) with mapi id 15.20.7409.026; Tue, 26 Mar 2024
 01:47:05 +0000
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
Subject: [PATCH v5 1/3] dt-bindings: dmaengine: Add dmamux for CV18XX/SG200X series SoC
Date: Tue, 26 Mar 2024 09:47:03 +0800
Message-ID:
 <IA1PR20MB4953E2937788D9D92C91ABBBBB352@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <IA1PR20MB4953B500D7451964EE37DA4CBB352@IA1PR20MB4953.namprd20.prod.outlook.com>
References: <IA1PR20MB4953B500D7451964EE37DA4CBB352@IA1PR20MB4953.namprd20.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [V0DYU5w8+/yTpuTFj220gal4Xaa1y1ld1mLiGlXsa1M=]
X-ClientProxiedBy: TY2PR06CA0046.apcprd06.prod.outlook.com
 (2603:1096:404:2e::34) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID:
 <20240326014707.327110-1-inochiama@outlook.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|PH7PR20MB4964:EE_
X-MS-Office365-Filtering-Correlation-Id: c8ebcd0a-cec6-47f2-2a1e-08dc4d36a3ec
X-MS-Exchange-SLBlob-MailProps:
	RlF2DIMZ1qXOkXGJ+Mozsa5bhT5ExeELuWzU9cKs0/9XTJjCpdX5xXQ/uIssNNpUIG7PA4X2wdaZrIcW0oKYSenUp+oYFz+Wj8E2cXZBEBFgva0Hcu5+l7qA70H18SJX+eh58pCvSkf+D18wJ9/WM3tlpcUyQAtCUTDUCR2buYkrCkRRMW5Vmh0eRlOHOnhTjWlS2yb4s60FuCx+pxYLKr0MZJAPalndQEOhk2mOz4qHEp/++QlRw5bNb+YsUG2GABE77aTzmVGxhAa7zS6CrStm8TjWw2O9H1hVIlk26Gnz2rA6wpMpx+Z5Q5fSe9Quz9Ww/IzdRIqW5bIOvxiurlFKxEs9lucsHdHS0LQZI5EqTb5WFN6WTj2mJUAxgAHYWFdAXF/eHsMwZc9uB63Ppz5KJsO51e7dqLiy7tZUpExngjRUdo45DrTILmobAQXmwphwNodK66SkBRzUo2YBkBjI+quUYSGz52mrlbnQTg8IZ1AszkQFcB0OzqjeEc+wTHo+Y71yKOL+s2Z8OPKSrlqCXzMOahhlPsXscXW4Wl0XrzWDW5hIsF8QjCrg3mjUL7EFTs943SkqQ5FqCGUrv+G8KJ+uzI4UPm2u3lmxqbSA8WTAXBAXfn2Eu7Ujio/MCuxXH7YcRDGnA22hqdFjXhnQgORvh+WMgzt64RJMGPV+/jYHOWcsjVNa4JoA+vEf4DrHeT3e/S/d5CNY5LdvOxeCU0NwtopBtwlc1nx3BkP9Y09/0RHi5W86b4GOgTXZ8F9dBBYu5mrA2ARJd+Qo/H/JoQVsRVP7PzxiS/DipPdicbdyGZiMtGta/F9DsnG+I7RDQIRAkeka8smeq+zLkjtokgVy4KmA
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ac0VcprlR9HsIqxQrVFLvZ11p9H/JX6msNW9k53BiVvF2Ej5IbM7Ig8r3ClMyBnbbykBwx/WmqrHUzWUQk57YtRvgvkcPTQdpfqDCsAA4LUZL1qlUAqAXigY/ohJGZAbR4VUeqERedcs4kIMymzaATeklDowuG+2uc54jIcFhFnmgiWIemf0tYdvhyil2KYkWDrOrzUdxNGJFZCl/8UNZF1eK21S/8zd5SpPN0GbLMHHTFl1xNQRZO7QiZePxWBlM10n7Ru1Qd1ChrMut6LFYmcTPPa7tXoZVZYqQl31DfOys9Z9cYmrTBodGCkP9ainBy+cCxSDfmQPdu+EKusCL1ylWYH3m7912sKa2zvpcreXxX7qfYfMyV/Zo2CJr+G1uU+Y87Ma/3nFv+PMzIFkoOGGhAianbb1SacHra/tWsbstO8XrCieD8XIG2gTZmzzR1ETINRF9BDRmRX/iba8UWJ5aulOT+3APk/6m2WQSDhDXjpQfW9GRSx/Jsx8ydWszfQKC6sJDVCB2BxDRpcGImoWC73QT954IutVkRwtcbfWVdS69begoGPnfELw74dVPvNdkdUL33GgjYqtP1lDdmR7E7GNo+WaH2NtSuB6WhNDu2F+nIm/ERIoHMgREsrBu6Zg/5YavN6bXXH+HvDXmKQzNyI9rNUnrwhE4Chp5u7igwlFEn5vTWj/FognDOGt+eNqQBwuj62d+28x1sy95Q==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CoSB925s9OvSMGJMEjZiA4Vck8kquaxUJLx7+I9lkGIg6h1ZfR5XAnelL+b3?=
 =?us-ascii?Q?GEHjCyn7a5k3vA2AycIia0wvQpRcj6IXSCU48N6znKlHVBuN5gsH0Zl6hjeQ?=
 =?us-ascii?Q?EXWo//4vEWV1wCLy61KWbsZVsJkAxZjNgfTbSZUUH5dh9+117rpvoQi3wSB4?=
 =?us-ascii?Q?1oYiCWHUKDgOOKtaNJMjWEmWipqX3Ya2SE6DOkwDczgs4iXKRuY208W2pe2D?=
 =?us-ascii?Q?tfX/3CT+3/rA7ZeOSm1IqojtzflWn7MIJ7b0usrCoC465M+CU8lYLSI1GwV6?=
 =?us-ascii?Q?kj4omjlT0cTg21ako8hUnh3OzA8zZ9tp0BBtvoBQGhpJg6uIdZqdbDQ8R5fk?=
 =?us-ascii?Q?dgQ3ULqmvJ/V5Ju5vB1uSwfn4oD5S+vyeNIj1Q+VAvDm41EgB8hnpBrUvE9Q?=
 =?us-ascii?Q?UoBIzb2SBEmUdlBezmCJxrf2gC2kZIqVpaXPkPC8KTvEk/gzJP9GU8uKI2hN?=
 =?us-ascii?Q?IP5pYavPBHhfdz52hftiR10FPBERl/Yz11PAGUIr6MfRwr8CsYX3C7yxTedl?=
 =?us-ascii?Q?LNXYPEEDekRQru6P41QDeULIyF4krrYn0tzX7NKIUQ1sNnjQsWV1ts6es8oS?=
 =?us-ascii?Q?+wMbBvNRGQpP9zu6qgZMrlQNR812nyQJ0MvuZRZ1tVlt73BBAkRW+gAjU9qb?=
 =?us-ascii?Q?uqppL0zj195aNgjNGVuzkPdG45/QH7BO0mGxIzQKmDNThgLUHVYsOwCoRwI9?=
 =?us-ascii?Q?f/pdrV5Doe2VI5GC0DjPgLFOJrp9CtyGJpxA2J6vB/089Spnq/W0yc2szaEY?=
 =?us-ascii?Q?ZaDbE9ZY4higMBwN+rSSf9uOwKeSHMQsqaOCEziA0zI37vW3Ka8ycUHIkLLk?=
 =?us-ascii?Q?vN6NSivs35P7iv4tGI8A/kILUtiM1WDWlJPefrnnprC5UbVxov+Y44QDO0ND?=
 =?us-ascii?Q?71V5uuBwsKdGKlu88n0IECb1KkArWSiZsi0W5/v1qXR0KKqI2//s0S6xlRyL?=
 =?us-ascii?Q?jfc56IJaaNnusPxBr22UIY9CH3DP23oWGS/uggcGE2bVBHgC7zQK6rblhL+j?=
 =?us-ascii?Q?7BUu+uz+MwrezKwoh2VOjs3KzVrXA4TXUSHsIveV3qCwrJXTc45UB08opif6?=
 =?us-ascii?Q?C6hD0pY1lrOmdVWXvhZB2VvkoPb2Q51EWyqlNGUsAyDuIh9GsGyLW38tgdnj?=
 =?us-ascii?Q?yxUNmqxibxXBh7bobYfTDGfC0SAODs/kXK7aeuQt18NCpwQ4KUmJP+cM4W6a?=
 =?us-ascii?Q?NZ0epIm/kRdsjtIVyG8O6cXPBMv9CuRUP0K2dpQdgiZlNBwN3keqbSETFnYT?=
 =?us-ascii?Q?DzDZbzeXxVzixeOTJdo9?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8ebcd0a-cec6-47f2-2a1e-08dc4d36a3ec
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2024 01:47:05.5834
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR20MB4964

The DMA IP of Sophgo CV18XX/SG200X is based on a DW AXI CORE, with
an additional channel remap register located in the top system control
area. The DMA channel is exclusive to each core.

Add the dmamux binding for CV18XX/SG200X series SoC

Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
---
 .../bindings/dma/sophgo,cv1800-dmamux.yaml    | 48 ++++++++++++++++
 include/dt-bindings/dma/cv1800-dma.h          | 55 +++++++++++++++++++
 2 files changed, 103 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dma/sophgo,cv1800-dmamux.yaml
 create mode 100644 include/dt-bindings/dma/cv1800-dma.h

diff --git a/Documentation/devicetree/bindings/dma/sophgo,cv1800-dmamux.yaml b/Documentation/devicetree/bindings/dma/sophgo,cv1800-dmamux.yaml
new file mode 100644
index 000000000000..d7256646ea26
--- /dev/null
+++ b/Documentation/devicetree/bindings/dma/sophgo,cv1800-dmamux.yaml
@@ -0,0 +1,48 @@
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
+  reg:
+    items:
+      - description: DMA channal remapping register
+      - description: DMA channel interrupt mapping register
+
+  '#dma-cells':
+    const: 2
+    description:
+      The first cells is device id. The second one is the cpu id.
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
+      #dma-cells = <2>;
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
2.44.0


