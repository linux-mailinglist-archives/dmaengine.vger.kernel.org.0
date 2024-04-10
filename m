Return-Path: <dmaengine+bounces-1799-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FBA289E7B1
	for <lists+dmaengine@lfdr.de>; Wed, 10 Apr 2024 03:21:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 953DEB21381
	for <lists+dmaengine@lfdr.de>; Wed, 10 Apr 2024 01:21:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0687465C;
	Wed, 10 Apr 2024 01:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="V3018SSg"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12olkn2061.outbound.protection.outlook.com [40.92.22.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D577623;
	Wed, 10 Apr 2024 01:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.22.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712712073; cv=fail; b=M18DCvxblMPEot0FOfaL6SZRUP/pnE6L1+7pUFdKzCLoDchrmzapf3/IixEgNv4M+ynriS6o7zHIMLdYqs+eZHj/MJGk8CqR/FQSpGXx/nA/EJCmCoFzKqDTgq8mi/ftK53tMliZG+dXKRznCe1t09sg28stt8Hurfu67d5Tz0s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712712073; c=relaxed/simple;
	bh=366cPlraucF0CHjW2XCLk7Mco6aH522k0CimUsPk1Iw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PSjUP/lG2MqxSqgm7iKWBYH8lBlNVGv3L4ywhif4lFtRygcKcwUaI1bsXfq+JXVjmu8mc1aq+e7LkkJCi/5pj6l9+1cR8aDsvEhrTIIW6ecQiXOFjt80Dw79Tcv/2/fq+1zrgIwYWsHr92msykB7BjvGPuEgC4iVDEu2IOKJvyw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=V3018SSg; arc=fail smtp.client-ip=40.92.22.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FUd10cP1xLRZLLfz8JPJLs5AJqHo5IfYZrBbFfQCE1rZQjkSAEWRTZC+3kMXfMJCbs2O0Gwp5nDQSGfm9C+P9F/WdOQZCU5D+BhGnSzwqlWcgxETTitsPoFklYgzPvY5I0lWgqN7e1uf8oVF1ODaFHtgeUGxYDWYcX5+8YcKF+Pa/nfP5uzP4OTdqC6zCeKOzcjrxII56RgxTtG4z2QtDTTzFnP3H/3UXzxm1jw4kDQJT3FbRQ8tD7CqcytjjAz0y9D0+w6St0k99NQp+Su/YWwYSCetFGlTLgr/tGNzp5cBFeqWkgzNcGhW8Fdj4yORxX/JJMJCRq3za1oxZ5XrLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wr1EWI58vgY6CWzXaBMfjrS71hlZHq0bO3sBMwFJADg=;
 b=nWSI87kMPh3K5212Yk54Co3x8dFNLYmm+dlYcCGUkjxmWLCnp54Lz3hFAxeHztck+LjTCcBO5DdR1s7YXNAc0bhtolFjOSwI+wmxy/3LkGf8JeVP4XBIT6RYKnfprGIgxgbRINv4XQ3DvDsQowsHv4f4GX6FIHmAOiJCQ/1Huvs95JDmQ+1Ms3zXKSGmyJ78AYEY61LuORbnar127iYTRITJGg2cl4D2y5hu2RTyHzQhJCw2nR7jF3JHNf3YmTgf6PyOBdfE4wpmfh5eVhVgiRrO+Sw3Lh4f8tNL4ttmenDtAFY+y5SjLUxusM0s5i16phxkijwhcN38TtsxQFveDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wr1EWI58vgY6CWzXaBMfjrS71hlZHq0bO3sBMwFJADg=;
 b=V3018SSgKla7riQuxTaMSVhMQs/7AiMLxw1J928fIwbZyGhSlz8An9dP0ftHqXEyM1g3ciOR5cJaUvtINwcoPvCbwtpWiXmoemH+HbnHfOnpmj6T1O3E45M6nnFdbNgaH8tFuJZ+QKkAQXCkm0E/Y6kvO/cszLc6TS5A9uk6f6MxitmhgzwLjE19r0dWERyMMaY39SRPyeqF88gRbX4ebGQneKsAlIPNQN2ycqwSpxDd/QIcsqqoCp3QSZ66/m36iINyKBWdRTo+ePrfv+jk3cliLREoNXWyOzzG7OCTu18ZK2vCBBUmvarIqhj2D/Cu9G9ABeY3/qtmJHxFCoK8Mw==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by CYYPR20MB6833.namprd20.prod.outlook.com (2603:10b6:930:c6::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Wed, 10 Apr
 2024 01:21:10 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::182f:841b:6e76:b819]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::182f:841b:6e76:b819%2]) with mapi id 15.20.7409.042; Wed, 10 Apr 2024
 01:21:10 +0000
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
	linux-riscv@lists.infradead.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v7 1/3] dt-bindings: dmaengine: Add dma multiplexer for CV18XX/SG200X series SoC
Date: Wed, 10 Apr 2024 09:21:20 +0800
Message-ID:
 <IA1PR20MB495390FFAAD76FA3ED3A01CDBB062@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <IA1PR20MB49538A66B7AAE7801C5A7C04BB062@IA1PR20MB4953.namprd20.prod.outlook.com>
References: <IA1PR20MB49538A66B7AAE7801C5A7C04BB062@IA1PR20MB4953.namprd20.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [wRYU3N0bLwrQcV2pCBOx9FrMzXdZXRFxklPN7PurhHA=]
X-ClientProxiedBy: SG2P153CA0001.APCP153.PROD.OUTLOOK.COM (2603:1096::11) To
 IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID:
 <20240410012124.165438-1-inochiama@outlook.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|CYYPR20MB6833:EE_
X-MS-Office365-Filtering-Correlation-Id: dfa0ea31-ba26-459f-67f7-08dc58fc8124
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	cpvFNluDYHx1zvRLnv+Lk1vCzz8aheKMVxhXVz+I3lShIlgji2w9BklpycM8Pbb/vgL/yWo47+z8VpOrYI3SpqMHY0KQAGaXZTaS3yoQ9fAHgpyP6Sh8shDpp7i/63eS9Zkbkg7VLpNA+2ZXwxk2uFbbO2SH5NvVGqMXZpSJPz+8FxoKG7O8p+8miosIadGDCilLEtygHVzt8DXes8lNwC+zFY2Tq+ObqOdwX0k0OoXr1bzrwsSREC4mriWEsFaSFF6V6bLgRiESAEr8nWcPUHYJoTQb9P9oTJ9q905IvvZk/y+FyOxZ1Q20DR8vaKGtja9sz93/hBGXrl7jWgZkE5+Sz+FIg3vAp955G/joZZQk4gjCrrVGiELaituAgW32tsbtitD/Ux39WaoEwlQ1EBzH9mHCigEArZjoBh2OqoQefVrhvKNCgSw9HE9oUuXdrH5FuXjJtAuWUtI75J/6v/96CGgTVlsIbiqiRWpaf5ALsBj2JaeXK/7zNj6W6Cu6DEw1TxXUfnarU8lSrXLz1n1JBSP9XRmT4Nfwp8t3SuefcupDsapBy8Bvl9w5MweCoWCIw4yxhnTSYgCbZSaqDbm+TX+HmQyOI7FJdveNGsmt5f6mZNaonLEcWEymjGxu3gxCfD5julmtVP3gKcvuMJTMUoAwhoNb0vWECcs1gIPi1NpdWSpO8iCsGrQeRg4K
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vqPQVAKulveoKpiiuvgbYEgbMYH4XnuZ2+VwShr8zen6vvSdCqatEZg4N2oT?=
 =?us-ascii?Q?H1nxF/htrvwM3RFO5zBJZixkZtAhwvfV1Ip4cjWftGm1SMjJq16T2VLfCOED?=
 =?us-ascii?Q?Dzk0KaGJs+4jw3+yZXOGkaXHMP8n3K0LHduxjT5sl9d/OPaUlPU5LzSLkU5j?=
 =?us-ascii?Q?hhYmTvMso/zitiGZwXUtRQ3hY6MjAwSx5AIFABbfll9WRakCP1mp+mkVZ9pa?=
 =?us-ascii?Q?MhKJFYXsMiPeVWasq7gR3aTvfMWhAVmtKcIMsfyTsr1yIOEZBMDmq8qftbFw?=
 =?us-ascii?Q?kxPK0mLNgZ/nrue6zfU07ZNwImFLYPcS/aqVklZ1IaZUl/VleqSKwzDhV1Jm?=
 =?us-ascii?Q?rwSMkNLbzTJuIL0eyrFtRpYXydJfFeXbWSsmYR/DwaHH48fhX8+GT0k3jyoR?=
 =?us-ascii?Q?33LDGG78LN5JLNxnjRPYbnijO07egkQDrVLIZhI/6SIBC/m6yVPghHThUZSi?=
 =?us-ascii?Q?0uDCZmJOpLuy9qtnnyzARNRxKVd82L944/IHhSUbUtns1tSbNLSIpOlLHcg4?=
 =?us-ascii?Q?iTndnZ1w2qn+5q1GNMh3YLm2OExKOeGJSZloga089D7Lu1wybFD7E2jB81k/?=
 =?us-ascii?Q?V8iZvpYTNQ3Sn32tmR7Fx2Z7kzVfXEbKPenVtZmjM2Nhm1NI1nG+KlhweCq/?=
 =?us-ascii?Q?dYsR1OalU5ikEy3n2x+A8VVlcAsog7GDVGLuz9DPqxBE8L0RQG3WpAFP80HL?=
 =?us-ascii?Q?bTRJM6nc1hftWEP2Jvm2kKMCYlc9kyuNLkrWuabIvKcLzp4bM6LQCXl8tzEK?=
 =?us-ascii?Q?NyokivP3XSsuaj0RNOfH3efbMTOpBXjNRV8WEI10jFKKKB7UsbfR8wGulECi?=
 =?us-ascii?Q?n03bwHXtnPF6PREPdmkQRzwz17KGBIvpmBxZfC6NEgbzVqNQwMsk41K8ow6N?=
 =?us-ascii?Q?iQxNfZp82gzB7blbi+9UXPnbg8JY8zp1eyIWtg64mXB4dJvwX7UsxIAC/bSA?=
 =?us-ascii?Q?wy+bbBGlX5Rv+0Ph5kiCDsLAm3hkuXzFuy3ib4nZmInMDaLFrvrfm/rq6NHt?=
 =?us-ascii?Q?qFG7Nk8TjYoFWqqBIlMfqyaOylCdb6r+ZDqgzdaw6GExusAqj5ECZ9tiJXJO?=
 =?us-ascii?Q?Ocq5hV+gG7+xQWEdJo97lyMCDc3HDOjwbnyLtLIlPs9EBe89wO6JnaKX6GmT?=
 =?us-ascii?Q?AfWqi3zP/sZHL70Yn4tNCRwZzbdR+Ye8Wq8oongi6PSe3kxVDL4Ycw/wFhyq?=
 =?us-ascii?Q?xhZwX8+LCadpII4atRPD677jXmQdiXi8c57ByX47KK8aq62P4wafoeKojWbN?=
 =?us-ascii?Q?lQkg37mfvUDpzi4+VoMD?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dfa0ea31-ba26-459f-67f7-08dc58fc8124
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2024 01:21:10.2833
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR20MB6833

The DMA IP of Sophgo CV18XX/SG200X is based on a DW AXI CORE, with
an additional channel remap register located in the top system control
area. The DMA channel is exclusive to each core.

In addition, the DMA multiplexer is a subdevice of system controller,
so this binding only contains necessary properties for the multiplexer
itself.

Add the dmamux binding for CV18XX/SG200X series SoC.

Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/dma/sophgo,cv1800-dmamux.yaml    | 51 +++++++++++++++++++
 1 file changed, 51 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dma/sophgo,cv1800-dmamux.yaml

diff --git a/Documentation/devicetree/bindings/dma/sophgo,cv1800-dmamux.yaml b/Documentation/devicetree/bindings/dma/sophgo,cv1800-dmamux.yaml
new file mode 100644
index 000000000000..480cb117db9b
--- /dev/null
+++ b/Documentation/devicetree/bindings/dma/sophgo,cv1800-dmamux.yaml
@@ -0,0 +1,51 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/dma/sophgo,cv1800-dmamux.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Sophgo CV1800/SG200 Series DMA multiplexer
+
+maintainers:
+  - Inochi Amaoto <inochiama@outlook.com>
+
+description: |
+  The DMA multiplexer of CV1800 is a subdevice of the system
+  controller. It support mapping 8 channels, but each channel
+  can be mapped only once.
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
+      compatible = "sophgo,cv1800-dmamux";
+      reg = <0x154 0x8>, <0x298 0x4>;
+      #dma-cells = <2>;
+      dma-masters = <&dmac>;
+    };
--
2.44.0


