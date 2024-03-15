Return-Path: <dmaengine+bounces-1386-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35BD387C7B3
	for <lists+dmaengine@lfdr.de>; Fri, 15 Mar 2024 03:51:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5C063B20D7B
	for <lists+dmaengine@lfdr.de>; Fri, 15 Mar 2024 02:51:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 080BA79E4;
	Fri, 15 Mar 2024 02:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="OKqshR7+"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12olkn2092.outbound.protection.outlook.com [40.92.23.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F9A46119;
	Fri, 15 Mar 2024 02:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.23.92
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710471057; cv=fail; b=VOpBefRgWGi2owZkMOu4w0AE5xAIrO2GKz79JHW/cqmlYMXmzvKw3BBKmBmFxNd35RGjxIwNmao+xUOVcR9BBqLvzDVadotwo9gxQvf7fqmUETCOc3CYPHa20mcvcO6Hj1jZsWT0lNO0cHruJIbD1kfW9vtwriCdm/7hHqTgr7A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710471057; c=relaxed/simple;
	bh=RTAIXYDwgcB3E6faDSgXQBahZyvOKuZP5azLeFx0UU4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cD7K+D5yjPstvFBB7avtm8GbpFtDO8oxPIEryt1UmoB+aPU/hq7Uxr5bpsEAT5r2VSkWehBcxKOVDO26Sy+mSbA4V88F7XR9IFl808WvWaTG1NBluuq08zezmapSVFYoz39zthKQarZE5ED5ZZxLJFUfaG/i2kOhSKPK8Zm6Fhk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=OKqshR7+; arc=fail smtp.client-ip=40.92.23.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RnLkqy2OP0EI/fJoQzDlCS08QiK7yAFMoAlN0TNDsQtGWNL1T6cal2IlXztzxm95pK6yrNpll9h/ODy8DhPXkZGVbpQUT205pBtFH9WQ250f9lFqoHSx3u1CfE1dz5DXLMAqXHmmqWL9/+1I7srJHwS8aCxVTHuzEqMS8pcJRf1GH0ONSscBPFlyDLeqqeQEXROUqxDF7lvpnWU46WTeWsnn52L9JXhz3Bg2eVxLrPnDYEH/1RZN19JsBMmhulBW/r3ffHwthIFuCSxqklWQ6ZJTLPfTFltBRoNJQCN5txULL8L3yOkACngeLPMPQZfv3WW4aJ7FdAXaEbIWT8CTMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6Y6biWoLFKWq0hm9lvtc9VvDK5jNTPCg1WF/TH/M2B4=;
 b=O/xKqembr3UdA7sNzQfuhomTxuUACRhRD95IfgeLP/S1zrlddueIDUeuJRwBH7lB6lvS65PfKf6+kg7wvm9gEyb4EzH61tJr/9Jtk0IE0CbUJ8CPC7lDnm7L8rpONaaSUT2qOm7AWsSeub5agSlgjGqXMfvKvWXRW6wQQXys2Dq8li3TGGyGYfzt/PNvtoO4pg0XXlvIttj5/+QXNK41OOz2I/ONhmjhAQ1xmtFMelgij48ECUWWkoKbtRCgjCXV9yza60jnrdF/4a3B2i+wnwsQvP9dNE3wpkl9fw/lReEPHeEmvqGiVa++YIpZen2gr6adPrqUNVkhaH+Do1woqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Y6biWoLFKWq0hm9lvtc9VvDK5jNTPCg1WF/TH/M2B4=;
 b=OKqshR7+Q7gYNunNHYtKqPOsI+9m82Mv4jYlt1BGy/LVxyUVq0ygjWD2fuUEGd4pT0WNWnNfQn+nLmxdw+zsLnp3HQO47qpr1PYv91NvF3UXKpbIuoduKpZFNu2vMdFMD1lmDF8opfve/LTzxuN/DdUid++8d7xnUbrgOvkj7HtEN7cwBP4wfTjatoeIvNFpWtCmwZqrmiMuJnVuQ8hJ+0FcFpqdRv8mxyDw9p4nLe5r7rtQ/OkwG3hqO0Zqh/F/8lZItINvSnwVkGhhtVNlk4adpg8yLT+4PJ4g0RAy7X5QcqDeX5UGqre7hmiXJ9PG7iO52U1FyRkoR2G1p7SI+g==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by DS7PR20MB6264.namprd20.prod.outlook.com (2603:10b6:8:ee::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.20; Fri, 15 Mar
 2024 02:50:54 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::8615:efe2:7c8e:2041]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::8615:efe2:7c8e:2041%3]) with mapi id 15.20.7386.021; Fri, 15 Mar 2024
 02:50:54 +0000
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
	linux-riscv@lists.infradead.org,
	Rob Herring <robh@kernel.org>
Subject: [PATCH v3 1/4] dt-bindings: dmaengine: Add dmamux for CV18XX/SG200X series SoC
Date: Fri, 15 Mar 2024 10:50:32 +0800
Message-ID:
 <IA1PR20MB4953686203FB85C86DE56011BB282@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <IA1PR20MB4953E7BB0B270157C8D1DDACBB282@IA1PR20MB4953.namprd20.prod.outlook.com>
References: <IA1PR20MB4953E7BB0B270157C8D1DDACBB282@IA1PR20MB4953.namprd20.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [P/3VFWK/Gi9d5MUPfvJr0NHkynog/V3mnx3Sk/kedRQ=]
X-ClientProxiedBy: TYBP286CA0005.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:404:ce::17) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID:
 <20240315025036.554158-1-inochiama@outlook.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|DS7PR20MB6264:EE_
X-MS-Office365-Filtering-Correlation-Id: 3eac6f41-f7a0-4a06-34a4-08dc449abb73
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	NfeI+o4/cFqe3PiCjV4PMVsNuiqDSPG7/HZSUMYECyeelurCXdSoP/1lpkOqgKp64ryr4IAWaC3jBbYjspKZYwSG/TLyZofsxYRWxYWzAvgN9kGZYaFk8o/5jYGKt7/UNxsxRutY3QbvzHHzUyfhzfKJHdc2qr5E2LwJBELSBNXgU8M8W/nc1qP/5eVukZUyDFNe5748Nn3eo9AKP/1BC4ce0QDxei5oVSdnQ8JciK0iUgWolQkGwTbxY3ZfRjLKbv1k2wTXrQCOdumqpPNxMeOZC3DRnXeTemPrfKoW0KZeVXaODvs4EPkYUyOoVgEFyhX9mevVnl5PozW6rnlKQXhBUdBGsb8B38LCXoCngJTmd0b6oBi9++QJ2t5gKErmtPTXiwNYAdTFpgFhRnXmtCBGK/L2NGWSZkrCum21Uzfa5XRxCSeOb9wGqKi3hZmO30HN0ncgmoXHpHg6NPadIWqmhPIjnCRlRDHtbZBmMqfMWLePNPD1uGMNlEljuhUKdxV6qG8nD/suXfRvNeiAJVyPY/GoRRWjek0CNGqCA9u1f6inqJS6VXyuf7u11xoBibCYgIAoweyscDRhIaiUsggz6kT07ve7uA7kubvOl3PvBHRADkRzHgL3/PLCfj+munnKBq6Qp870QtLntHxT0vFCAKlIUlvzGOtxozmqZHQQT1AFSf64zEe2LLCANT0aSYim8a/Y9wXtyY8phyDHHA==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3PsXm4b9xrHXsio+0s7HjDD1m+8YCIVdIEOsscfpDFtP55mUwaw29g0SahyW?=
 =?us-ascii?Q?STG5WHxFQqs7QqFTg0Ad2NvZ67S+VXAOJDWHw8sn4Ph3FvDPT6d8kdwI1Sae?=
 =?us-ascii?Q?4tWf4IvkZG1HmJTremQzosBkbSoW/N82lpBQWft7oayfhIlBHOJqZ7WqPz51?=
 =?us-ascii?Q?XOmB1T1EfEnrZb5K3MnANwiJQ59xJW5114C1nkmA+CstXKJxQiXzzrNsXGwj?=
 =?us-ascii?Q?L8TqK/+Ak9L7J7IsZNZdKblhnpBBcAaHz1xVRSRIVcDQjeZH9Fa4o3t8UJLc?=
 =?us-ascii?Q?/zrYg8qD2k4hWokFNYvXimmSsBvbwv6IVcJzpQ0TPcr8C7Et+zumjvhvXMbH?=
 =?us-ascii?Q?Y87ENrhLw78hBEmaPRABtYuEIb9ZNKyTydpHxELzUhZh2BblJXOArx3cw3WL?=
 =?us-ascii?Q?OChGZJ7WpA9fox8r98vLztXvAAjRvMnVGpwf92VyqSunqTjaS39JsF8pKSou?=
 =?us-ascii?Q?jyk+u3BbrMB7Pw3JCbXQVG4Wdp7CeHNP4M8a61ly16+eQ8Tcv4RgQBx7YpCW?=
 =?us-ascii?Q?NORrieJ+NM8CsuO8FOWHTwKYuK+NMIw1Kht0Fqf54NFqsRdjSA6beHQ3qbO3?=
 =?us-ascii?Q?fXTtWDjTVENLkNtlXLwLay8R8coLGCz3XkgYhBXAvpp7lCbTh4zI9as4KzOw?=
 =?us-ascii?Q?TZex1up4UJ2CxI9O8EBGdMwbpj2/Vk2/bIjK5Di6vvECenGvoj3z7ALhMYjP?=
 =?us-ascii?Q?sW0VzKsJXPel03D0WYYO1gRe9jXgKwESq5iEDUrlqNrNN/QQ84+bxia2sLkY?=
 =?us-ascii?Q?cNcseQVfhCJWBZAkA7e0mqSqONsuw4w+6ATO3yp76pewOAa5nGyzHpGJ8UW1?=
 =?us-ascii?Q?DAcAW+FpUq7vPmWGOSPr5sIsx9e91m4GKVoElH7DaEE55RkAKG18efVNB9rp?=
 =?us-ascii?Q?PXU5fz+AbNN9WKN3RDsceXQHGMQUjbU9hHUF1e4Dp4dumQNtS/x7eUEYilO5?=
 =?us-ascii?Q?ZqEdP7cZNDSu8UggXxazNMtGbo1K8trvNS0ok0j5DdlP+WAULCW004/rGyz1?=
 =?us-ascii?Q?aCoz3ySzMnDAYAxuMOaXve/tFesZodIShuLZIGGHnpYQEERug8v0KKjsHdB8?=
 =?us-ascii?Q?g0yfpGHEAX1PqPewwnOfGHcO+SRQYWlnx8LAKicK4DZkX47jlJFrwiqeV7GG?=
 =?us-ascii?Q?sY7mzNOZsssrm1lK6/ME2UgyPObOdiGVAeIzoIra30ga1p13zI0vnD3dEbkc?=
 =?us-ascii?Q?riUZInAkasW4lm/j7qTXOFlW3znuUTKtFROYvKI1KZKpO8mCo9oA95bjk8AU?=
 =?us-ascii?Q?jukSZUr+/zq6N8+jqEF2?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3eac6f41-f7a0-4a06-34a4-08dc449abb73
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2024 02:50:54.1578
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR20MB6264

The DMA IP of Sophgo CV18XX/SG200X is based on a DW AXI CORE, with
an additional channel remap register located in the top system control
area. The DMA channel is exclusive to each core.

Add the dmamux binding for CV18XX/SG200X series SoC

Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
Reviewed-by: Rob Herring <robh@kernel.org>
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
2.44.0


