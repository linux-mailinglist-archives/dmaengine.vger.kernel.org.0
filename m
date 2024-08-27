Return-Path: <dmaengine+bounces-2970-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8133596024A
	for <lists+dmaengine@lfdr.de>; Tue, 27 Aug 2024 08:50:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 076141F22C68
	for <lists+dmaengine@lfdr.de>; Tue, 27 Aug 2024 06:50:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEDC814D2B3;
	Tue, 27 Aug 2024 06:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="JR4v7PLC"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12olkn2074.outbound.protection.outlook.com [40.92.22.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C4A63A1C4;
	Tue, 27 Aug 2024 06:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.22.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724741448; cv=fail; b=OuKCFFqMdARVVmEo/hr8UXX82P5wUn30H31NX4d9ST5kZ1Wp7jFbPPEz7alG1BnWJ7JIJFY4JmVruGFbGudsKw/YvPB1N7qOwdDY35eurGoADLaIwjK6NfllHuV8nxlWKicQaqmYmL3ScufV6eho4XlnW6y3ssYLxNUeUZENS4U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724741448; c=relaxed/simple;
	bh=a++zSDN9oMyv9fA2gKZ72zCI8P8EzQ3BS/V+g1ttRUY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iYL8sarbXBdPTGRJCBC9Vl5zpSIkKiWuH5Tbv/Vozkf/ZzpFkK4AXnR8i4wj8dq8EGsasC3xs6xx9AdKsbZo4UWtWE2ozU4MIb+XAecl8BeBTsH2b9j+sMBR421rrIQ4/TCj4nTw4JyL47wCs+VYYF7zDK+qMDtCsTrczp3YUJA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=JR4v7PLC; arc=fail smtp.client-ip=40.92.22.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wspq1yI1ekDRhP+bXWMUIY5Z1aR4xs0mLOnUBtVvauch7rLGiNehg/xRQ06cxYxOSp5pSXDHJLrlakXKDDcQBahDkiue3Uf+TveRvfBEBO5Txly2yzbH0pMFnD8VHtkp+CWDCkuuGFMH82TH0Ze3/gRxGbUYI/leGjKyICHtpm2NVxQj2oR2SE9sA+e3fdLljF5HS4JtsHpF++RUcSteD3MFLtF9NLQMCZsXkpmRFZZj2es0QAqBi/v4kFiEmjMLBroJDhY9OvMmlxOl8BNDwyLGnoPe9tkL1CHBhkYAe7kGMpeJXPY3lRlc7fJUXLPPlHbx9lEScNp2zzUJF/Rpyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=odGUw6TQxCZH1ppD8faEmD9SkHZWFu7bl0uSM+oAuE8=;
 b=dFmsFwtgwolQhMGlSQvaS0ygSGq5c4ybjB53YJGB8sRMNDMlXJfz2wcLU51y/G06biX5bxTkPsyPRqqnI3IVcTvbb9sf7BWHsj1tC+WRrCBdS8dGffcRJAImFi2rO2oRmeJEOdvGpJGbTae8m6orh4sjdlvwcsYxk/gy81Er6nblqxpnMeP4o2kxMxPtON64PGSNf9C0TOdup1F6iuC9kv0vSg1qkQl6ZcH7ERPYlPG28j7iulvRsxMrTXcuJBKXCCC0JBo2UBJJqjeE26auBOYysjHpSZ1hnV0HGddbHXZuiotHYTzA2b4fAw5/2VJXubsQzs+60dgjPml2Vp+Wug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=odGUw6TQxCZH1ppD8faEmD9SkHZWFu7bl0uSM+oAuE8=;
 b=JR4v7PLCrIYNebCP9qRq9QJp10PdGLuVjtImhphTWLxIkSJgEktD79PicqrdHS2ayXgnJSJ7cTu5Mo0qLtuJomWdNaRWlu6OUg8gvV1ix/VVnJf37513u53l3kFhDlnNUteeUkRR4IQZN4vmFQfyHk8bHsuMqqF6wMJQn+BwwS/o+2LoJgAraPwbsOWuNym8sl22WcAP16lncx+Vu8z4v+4mu+tNjdvT92dwpCBCPHKF5uEctymkOkbBdiWuzRXsT5yjgPWI034I0p+PwoSpDnGtcu9ue+BkFxCQXZjZXxImERLbapD0gD9w4C+BuOmkS6wDD1STixd+mMmGTE80HA==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by DM3PR20MB6939.namprd20.prod.outlook.com (2603:10b6:0:42::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25; Tue, 27 Aug
 2024 06:50:45 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::ab0b:c0d3:1f91:d149]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::ab0b:c0d3:1f91:d149%4]) with mapi id 15.20.7897.021; Tue, 27 Aug 2024
 06:50:45 +0000
From: Inochi Amaoto <inochiama@outlook.com>
To: Vinod Koul <vkoul@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen Wang <unicorn_wang@outlook.com>,
	Inochi Amaoto <inochiama@outlook.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>
Cc: dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v12 1/3] dt-bindings: dmaengine: Add dma multiplexer for CV18XX/SG200X series SoC
Date: Tue, 27 Aug 2024 14:49:41 +0800
Message-ID:
 <IA1PR20MB4953A44B1388078AB9B1CE0CBB942@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <IA1PR20MB495396729244074C36E51E11BB942@IA1PR20MB4953.namprd20.prod.outlook.com>
References: <IA1PR20MB495396729244074C36E51E11BB942@IA1PR20MB4953.namprd20.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [fe+b2hhLiKur94uz0G+heUNWBeii8B+T8Qgr3sxU6cw=]
X-ClientProxiedBy: TYCP301CA0086.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:7b::12) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID:
 <20240827064944.740024-1-inochiama@outlook.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|DM3PR20MB6939:EE_
X-MS-Office365-Filtering-Correlation-Id: f3bcb4e3-8685-4a50-4b20-08dcc664933d
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|15080799006|5072599009|19110799003|8060799006|461199028|1602099012|3412199025|440099028|4302099013|1710799026;
X-Microsoft-Antispam-Message-Info:
	oVJGS+EWGlb2tRGfGtE4PyY0Y/v43LYOYWQU1IZXlJQfVVOCwNgRSeK5b0ssQJNpHtJWQw7IPGWU69s0N55m/Hq76G2MC9YsFmXQTFT0qgW51aw6mp59EwW5xHILbNcW9N8VJG5rpQNUk0BkqxL8NP2b9ruaJXoBOy8o6mg6U5QkHToX0vrWAG31Huj1z3uYXncWZ3llePMC1jZjZVXAD1Bmw2gGn2q7ITRgMDTdvONa1EKxoMdmPmX6x7nr6QVwvcuPuXUUuMUrdoR8j7w4ie8CPJ3BOpfj7IO6Z2FK/CJYgx8U2oYJ3LhkrZpbNRRYwvpgm/WRBx56aWQ/l7OrVdmoD89qg8laMWVNQiMYwH3lBnD2ZsHhNoQVv7vMeCRJmZknJBvtmB8nt1N9oHZ8S9ZF2iGkafbeGGopRiLowy1NtkgciCuBGhI427pQhZVlgsg0pZziSaJ2A9l6DWRXSo5z/NX6FLHguDBH1Tfs85PUAtVxjDez1tnZePgM4ALj8eW3dU36XkxHjOM0NKb7uy83vBv+2efv1RIz80ceZJ8+k30YRqxP13T6athL9SwiSMWa4547u3ULOwkzXK5GpcdCYzuPme3YanrogQE45rZM0Gyg5Zy2hWgr6mvTvPyswFBOv5jiEQXkMmijJYPE2/L8m/mpdNvxAcTVjBmKg0Dlp0QafuCTeBuEaOrHa6qGWDiD0K8ypaltDDAjXjz556FNAaKqrZxYD+PZkbuIirmh0UZAuZgDAdD2xSdxf8WE/w9W9a6Nal2oItwiuFwi5HPHhfXBnp92b2lVqMSpCrNNZ4EuiQJXJzMV709PfTXKgy9xoqsKZnwPq3ARCVYq9DFj5xOexOjemzxgYHE2VXg=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JUQS8lXHqFtnFUd8ZwokS/th34XxVLr0uYFGIaSSTcnJHoYeMkYvy2Pi001j?=
 =?us-ascii?Q?ZesTH7cxGV9s8akvSMDBH2YFa1vS2hcW9pIBreI87AUknVhNsMpfFtSVK/oO?=
 =?us-ascii?Q?Q/sE/IPVMIglcrXtTjS2OjGQDvaJxHyV/vxnyx8Z9mSHJAs2qx6GIDeYY7tx?=
 =?us-ascii?Q?3gF6QPZOL4aPb+BMdPk0aQfBLSnBg/eKlC4zt/WevhMG7NEkMFNWToAwQKg5?=
 =?us-ascii?Q?dmFqbx/ugMU80ry4P2hXmaAPROM0nS4JWq/H7NXdp1S8lJfFZQc4PCMZYCWt?=
 =?us-ascii?Q?OlFw3x+c8fJKdmG5Yub1IL6cmStwJDlA56ew0p02FXtfduPYrMb2zbwDJf3j?=
 =?us-ascii?Q?GT/aA1VBKFwSHfnG7GUHaoI28zCJZufKYSsNCbpQCi7ACBNh5W9rKiEXHrUu?=
 =?us-ascii?Q?WDRioun2JZH+Tf2MALEqj6goEO61wT+HhLSGzTXb3h7clSOhbqHSqq04sjmJ?=
 =?us-ascii?Q?oAfUMeD5374NIiwLsI7YvVjP2um5oanGpAsvksaTsOakhp9QT1vqbjbc634a?=
 =?us-ascii?Q?OqBcYkFOe3hwiXDfSuyEVsoom+c32FzijZdhHowkLU6Kb3ZMCxkYLh0OPNpy?=
 =?us-ascii?Q?Q7usMH6XATaoYeh7ArJRjDPNxN5szLvm0hdZI1envTPB6JvIx3QkKSrTzjvW?=
 =?us-ascii?Q?kvG8s6Go/uAojz01ueFy8oyxl4kIyEe4Og9TGj8ttf6PyWpsXjIDwRT302sM?=
 =?us-ascii?Q?0VITC0q1AQg4O6D44LRfZzHHYUgXp2zvWDWRbhiqqzwwPqcAkPhrT0vBrhFD?=
 =?us-ascii?Q?xJLjKLN8GQGCRKgMatR/QZ0a1KkA4wrTQ47LbEkPzMxbwmuVECYB/hkQJG8y?=
 =?us-ascii?Q?2a41VEeeopWU+ymNEjzi2EoYHc9umX434JJL5k16V1IHVgBXwj3wL5wV0X0N?=
 =?us-ascii?Q?54jwHuZFj2yqngRWziFln6q9rGHGXlUbL6JqgABs4S+ijuZVOqVGMnZ4xQXM?=
 =?us-ascii?Q?R0+hu/CZmOmQBWNBbbT2rwWJ245++diZz69DZnK2+/6SQP30YX20f6RV627p?=
 =?us-ascii?Q?EZ7wGBzMaTFP3hO5Gh0hO5N4hBx0mmzcymUMbSq9JNYdxkxy8NuGuh8Uh9XO?=
 =?us-ascii?Q?yTYQ3nW0E7SMn9WiJbycn35IbGmm0H7FryeCijDzg41d/lujvgqu8Q3oP+6b?=
 =?us-ascii?Q?Z6i+lZ/sgyVfHliFlPyKKbKanHTEcKKnc5SBrXiGGwPu+J2z4t7lAROMHXuf?=
 =?us-ascii?Q?Iw6kEm/3En/zjYXwNp/eDTMbQrvB2OQpfARZljiOt/ecv7D37tsEfaMINGi2?=
 =?us-ascii?Q?vZ85R12/pO8J7A3MqZre?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3bcb4e3-8685-4a50-4b20-08dcc664933d
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2024 06:50:45.1363
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR20MB6939

The DMA IP of Sophgo CV18XX/SG200X is based on a DW AXI CORE, with
an additional channel remap register located in the top system control
area. The DMA channel is exclusive to each core.

In addition, the DMA multiplexer is a subdevice of system controller,
so this binding only contains necessary properties for the multiplexer
itself.

Add the dmamux binding for CV18XX/SG200X series SoC.

Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
---
 .../bindings/dma/sophgo,cv1800b-dmamux.yaml   | 51 +++++++++++++++++++
 1 file changed, 51 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dma/sophgo,cv1800b-dmamux.yaml

diff --git a/Documentation/devicetree/bindings/dma/sophgo,cv1800b-dmamux.yaml b/Documentation/devicetree/bindings/dma/sophgo,cv1800b-dmamux.yaml
new file mode 100644
index 000000000000..e444ac2cc9a2
--- /dev/null
+++ b/Documentation/devicetree/bindings/dma/sophgo,cv1800b-dmamux.yaml
@@ -0,0 +1,51 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/dma/sophgo,cv1800b-dmamux.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Sophgo CV1800/SG200 Series DMA multiplexer
+
+maintainers:
+  - Inochi Amaoto <inochiama@outlook.com>
+
+description:
+  The DMA multiplexer of CV1800 is a subdevice of the system
+  controller. It support mapping 8 channels, but each channel
+  can be mapped only once.
+
+allOf:
+  - $ref: dma-router.yaml#
+
+properties:
+  compatible:
+    const: sophgo,cv1800b-dmamux
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
+required:
+  - reg
+  - '#dma-cells'
+  - dma-masters
+
+additionalProperties: false
+
+examples:
+  - |
+    dma-router@154 {
+      compatible = "sophgo,cv1800b-dmamux";
+      reg = <0x154 0x8>, <0x298 0x4>;
+      #dma-cells = <2>;
+      dma-masters = <&dmac>;
+    };
-- 
2.46.0


