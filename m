Return-Path: <dmaengine+bounces-2842-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 226A794E00D
	for <lists+dmaengine@lfdr.de>; Sun, 11 Aug 2024 07:17:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92EC21F21554
	for <lists+dmaengine@lfdr.de>; Sun, 11 Aug 2024 05:17:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54C62171BB;
	Sun, 11 Aug 2024 05:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="SHNMxWmY"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11olkn2010.outbound.protection.outlook.com [40.92.20.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F03B12E5B;
	Sun, 11 Aug 2024 05:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.20.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723353453; cv=fail; b=uhFytpyVE+iG6NFKGJsVopCS9tC1adGRVLwWTDtWsWFkaYxfsfMUzGSy7C4AQyT8q2AaBH89DTMLiqVqoteBLkZz/VWXCH582t2D5UZFM/dgLVkcLnupn2MUKOqwjr7BBgigJiyOjZU1eNjpAyTH2YaMRQHrk26ZjvC9MjJefOQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723353453; c=relaxed/simple;
	bh=wXdIyyIjPlUMqsGuR+i2GunfdLykUG0p7h/SVUbs57s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lOJySmmpNRr2/D3p16fPMTdDzKJ2OUksTPuT1NVR1TjU+w7FVrxeHYreNQNgdddmjFBP+SBT2S0xcSVsvxmM/uH933xeuj6FsmtQSPL2w4xNQubbm7xnBamCOrnofhr4WB4VbTEoO3q4W3itzLN818mDmtp0+Ya9V/TOmrDMmCk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=SHNMxWmY; arc=fail smtp.client-ip=40.92.20.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m2NoGi23Lidf+5R+7V6Vk6eb1f3/5DECjkOQrUXG7jCcRzvQNsJIyKxuTrpINRGhIscoIbfPwDwjN7iKN8Y4ONTAqyh3iOfxgy0FIEkrpoHzFFjl7WibNz4RxVX70D1YKtOOycz7tIiTpyPR+Ce/P5hw+F04KS92L1pYKeBck6Tzc1w1kYWUhE65PxKJKmdHqCkgz8A7KgcsCL3nlLtdNQcyENf2+gblKslm952YIysTqBI/z3kLA8AuiXUBUzXw4xWshz+OKicEg1Jgk/3tq1/mEFQPE+mLz0s40Gko/KPJPHcxE3qEVcYX/ahZtV4DJfu66GBE78RIJilQ65HFxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TS8PHrgdoaH8qkkE6JQCf4y7wDTNBlScmjhLd20KYKc=;
 b=Grq2rSJJFC065ebPK4+/Lb7Iivudr7L9bjRHo3eHM99pB5O7zaVqpugGFx++6ebmt1Fxs8uq0f3rrz6RfYSkMrMl2VCAJKlygObsbUCoCNmiBP5B/AaxCjdqTI68r2wDHvqY7fXLmKq6iAZ8OnyKV1ucu6ZDy7xx/ZRLHnUQQaMjIpBiO573vJJeBaZybbdvJDAyshnfcQxY0xmNkLlpqCS2TunIiMzvCEX9YmM8QiLFQkiuxjrQ/RGrWEFn4iWUvuF5qAnBwTFQNBZTSUu/jnMUpyN575oE+8bFF+lyPtsDlcu4MsjVwzQLg/HMWkpg3qF33tLX4byBo+vesS3NjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TS8PHrgdoaH8qkkE6JQCf4y7wDTNBlScmjhLd20KYKc=;
 b=SHNMxWmY0SnOBvH5AUNHVWVqnoiHxZ64/UsC0kKe4lvI+id9arVBPvDvuMwCW9mNtqz2R712tTepOgDw+xO2SQkakVTdf0egNP6lHIFHxpXIAx6CwQHxpJZgJQRT9MtEZNKMcMUhkMN2J88KzR/7HgTiiAruUID6dx+r6tVjCufIgPtUfE7hsTwKLb+OYnXddK2+RZDbABmwv1IVbhcIdOd5QN+Tpsw3g6LO0oe98SRy3pXGEzl3wDEj8vm8pfmm+MHzbs6MN41FOi/ae/2wQyeBGo577QxiYzfUAMdqm3uJmayAg1K4IypkGtmckWg7eqEIaiuQeqxbXB0uR90gTA==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by SJ0PR20MB5255.namprd20.prod.outlook.com (2603:10b6:a03:47d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.17; Sun, 11 Aug
 2024 05:17:27 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::ab0b:c0d3:1f91:d149]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::ab0b:c0d3:1f91:d149%4]) with mapi id 15.20.7849.018; Sun, 11 Aug 2024
 05:17:27 +0000
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
	linux-riscv@lists.infradead.org
Subject: [PATCH v11 1/3] dt-bindings: dmaengine: Add dma multiplexer for CV18XX/SG200X series SoC
Date: Sun, 11 Aug 2024 13:16:37 +0800
Message-ID:
 <IA1PR20MB4953C5A099A0F99FA12B98F1BB842@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <IA1PR20MB495324F3EF7517562CB4CACFBB842@IA1PR20MB4953.namprd20.prod.outlook.com>
References: <IA1PR20MB495324F3EF7517562CB4CACFBB842@IA1PR20MB4953.namprd20.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [zTfM9Wk1nktGtUwsGFJx+4Qc9usL7D1AUCrhOIHswfM=]
X-ClientProxiedBy: SG3P274CA0018.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::30)
 To IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID:
 <20240811051644.990577-1-inochiama@outlook.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|SJ0PR20MB5255:EE_
X-MS-Office365-Filtering-Correlation-Id: 5240b204-e5c3-4ea8-c78a-08dcb9c4e433
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|5072599009|15080799003|8060799006|19110799003|3412199025|440099028|4302099013|1602099012|1710799026;
X-Microsoft-Antispam-Message-Info:
	MNj43QuPZggNESshwTUBOGzN1s8lvM6yvkiaK8YYcE0dsUtY0RdI/lrO4gmwy0n+/OLAdmJwbzZP5SXgF51WSLi/wsRrpRnuZvvimbaSHbMNYnn3/avzL+S1TukWCBiAP81Yk0fqiGxWpnXPg37f4y/kag1pVPrzFNONzxBz4Dv2VcBtDXGXGY8hVi5KO+WeVnYOcMSzXiDtYSzG1TvNDvDf+uKql33xkaXIhrA0snPxcsRGAlgoMDMGDb+nvtA0VzDEA+IA1FqWm09pG8z3ByDPaOLAkaO1yVLROCFAUXz7lswgSiDa69IAU0dCKgUYAIA9w4W4ApVf19P3rqfHWpFw00KbyUZGISKYrUX7FXZhFejNFdDSxaUnXwCJ8+e8nBjyRXraXb4qOtCWoSxRa9k+8AnS0QgdAeG3SQjrGtM6Aa46IdX0iM6eMnw9opDf9mR77QzuZcaqrcptejPq94BvKI95r6aIW4rA2Td/lfI1hW6QlvQqH41A+vP6UAecaGnOaKuQo18p+vZSArueW2DzDg5N/DOGDez1Gyf/v4PtgLt0F+iIhGU1b5YXsiah3DUn1xRue3uxo453who1TG6tMBHHMhfJZzijlS+9v4gR+K0nyzSSPH0fBJfwXeCJ1ANLJAZBLOVgQXcee1ElQuW346zVQ6bo75MT21WW+P88QjYXiIjFSff8mLUsUymhyHwUX+JLRlvTVM9aC6ei5xjCyir6cp7tQ1KQNVPDTuGxfaNOjPixoIz2/2+lSExIVv9Mz24+T5GHnRpuZaBBLL5ygTdhUbdg3yiA1SxwqH+MiPP1fd69tCPpi3pDDANM54I/xUgau2Ph68/p8K51h16RoZbZjgCsVX8GtMxYWjQ=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6dOeUQwVFa23yknBw2Ps/d/zt48uaf0dEasZgD5anFeCQ3ABUC0ATBBoeYUI?=
 =?us-ascii?Q?dRiHQQwa7AsJA97zzIUVMRyYHabE9Ls/Hs6XLlCqfITEZQ31TDgDlBAoN94w?=
 =?us-ascii?Q?X2PDDYaipbqJCRwhIe/DARiarDdk95jzxfkCbmzCPnjeW/yaGTFHlO8TqYQL?=
 =?us-ascii?Q?22hcKs39eTK1AvctbvQht0xtx14VYrhtqkgU2rMiUdFEZm0GM5dTqNsT/hwQ?=
 =?us-ascii?Q?QJ93EJdBYvvXP83qI08fZwz6fYWQbqn6XGPxAASamQrhKePG5iFkrgLzv1fn?=
 =?us-ascii?Q?A65DfiH5bVQWx8u9g45kyTr0baiakNOF7j6StCqJhm6JiJgcEwOH1sBLSPtC?=
 =?us-ascii?Q?LIN75/cB4xxcSePsvPJgACaGjlio9ux/VmnkO1GD7MZwnwg3jYUOUEbxKKtU?=
 =?us-ascii?Q?Lmv1Kyx8RZZneFEhdlGYB7iupUPhn5fA7nAXLSl47M7d8eVOB0OJ525EEWaC?=
 =?us-ascii?Q?Uei7cWj6FEWFmvjONZe2Z1Os8f6TzWoEPAtzgrYH5tpsU4k8UDKBfIS6QiSz?=
 =?us-ascii?Q?JJeov58OBjmlGmXlfUSRZKdiIqEDTQr5BeABGGpyFLDGS3dMIELC2w4N6t7V?=
 =?us-ascii?Q?pJPhOIzL1MvQm3QEBHqL7CCPt58patHz/7xaqmNO/etWdxs2nVrXQNvYEWdF?=
 =?us-ascii?Q?U41xbywyzVnjNDvnbiYLK0R7NnH9OPFALR8wGkSmnC8X8IY930BflTiT80bx?=
 =?us-ascii?Q?J6V5/xf99ECNOPZFrqKM3AMrtOgD+CoG+T5wK37ZdWBDezdH8oKTkZrpmlZ5?=
 =?us-ascii?Q?PJ1dzawh7JTT9NLFD9kdX13luJD65ud2WWx+TbOcWEtoBD7vLaelN2iXeGEC?=
 =?us-ascii?Q?kqkrxn7zGFWrfwAYMhwuGO0xutmHHS22pfY3UCUKScwmAVqfRK6F1g8rMNGf?=
 =?us-ascii?Q?Or2PUsdPBZioIwXjltRFIgDioTxeXWGoI6Dl4dcN8yy38y2efu8SYmYvCtBE?=
 =?us-ascii?Q?J6lofsbXowYk6xf10EONVckuOXFCpORhEiCntTsBROuhDO4vXJHb79lPXm/M?=
 =?us-ascii?Q?p52fDe9nyZPxxRDa97p1zvlwZXKb8gz54I/bGjDGsxRfOA5UoUGoiqSuQsAE?=
 =?us-ascii?Q?7uzdC+HJ0Gq3BGASq7Ed6bwctXAhwUmLW0pe5IdAsSD6eehBQpu+2/mqJAnI?=
 =?us-ascii?Q?PTYg90AoglisFTB6/aSm1p2PJ431HqZxagsoXmliFlpSysXAAbJLZwS2p79N?=
 =?us-ascii?Q?27XUgRxGSGLCxhzJtNgRabhTLECW74ZboRugUpyFu5v0Sj7uh2NPRut+SxT9?=
 =?us-ascii?Q?EZhAT7mPJSQA7c9+ssA1?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5240b204-e5c3-4ea8-c78a-08dcb9c4e433
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2024 05:17:27.4784
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR20MB5255

The DMA IP of Sophgo CV18XX/SG200X is based on a DW AXI CORE, with
an additional channel remap register located in the top system control
area. The DMA channel is exclusive to each core.

In addition, the DMA multiplexer is a subdevice of system controller,
so this binding only contains necessary properties for the multiplexer
itself.

Add the dmamux binding for CV18XX/SG200X series SoC.

Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
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


