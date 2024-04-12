Return-Path: <dmaengine+bounces-1831-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 93BF38A27A5
	for <lists+dmaengine@lfdr.de>; Fri, 12 Apr 2024 09:08:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20E9B1F21B23
	for <lists+dmaengine@lfdr.de>; Fri, 12 Apr 2024 07:08:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C6014CE09;
	Fri, 12 Apr 2024 07:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="ewF0xcjp"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11olkn2050.outbound.protection.outlook.com [40.92.19.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70D5D45C0C;
	Fri, 12 Apr 2024 07:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.19.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712905641; cv=fail; b=YCHxmEz1e24iSziRzfeIckiADAGZJKCPxgh9pQkpeF05/m5UBWofEAFsJz0uCb2Wa0tK/xWJ3iHEUzcFRreWTEz0xRi6I6PxoYhNuMB3Dw0QcW1SFxfx4rk9sAWTUc5QX+iVMn7MP8/LI0Di2tSJexTqzyLmVJAB9FcAs/UK0g8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712905641; c=relaxed/simple;
	bh=366cPlraucF0CHjW2XCLk7Mco6aH522k0CimUsPk1Iw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YnYC09X6qxPFxvKkajX3+QZvBFLQU5Vg8zWPrTxFwy7cGhsWUhMtNmMRKNMFBkFv6ZCjYhHm9QZv+uWbk6p1fblFwqiDbO/RCo637Kg2gq0F7s6eZUpf791yMyNPeikTosJ4LyKLc2ZxLuEqP/F9plo/gcBgaLkTWIvfXGTxFkg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=ewF0xcjp; arc=fail smtp.client-ip=40.92.19.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JL0qr9U6AoRxkIH/77ufADP4S3a2Tgh7QF8AHYSZfFxivK+7Tm4H8S9pAJ0Vcb84Hikt1bKHN1BmJq0xUQCt8ZCbxdayuzWAvF8ClbZ2jRG7SvInSTXBCeGOTvy0dGtcvkjhKmY7kbCspb0+4LZrn/3x61+Tk+UBDDe8q+5v7mLhbu8RiVGwBY7eMhxunEmSEnfaLaEfJiJZJYH9WLR8lG4Q3fu2FXEuqpKXruFt7Akr97xxHB+b1J06GTneI0r3EohvBXQpQDywQuxRTHr9+EduQD8xUya43Qt3KXsuYbPFdOHafXdfy2e8cVAcLhz8M3L8rvdfjgVbewwaSts2yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wr1EWI58vgY6CWzXaBMfjrS71hlZHq0bO3sBMwFJADg=;
 b=RBgVI07LoxjgqNMvVF7ijcOtbTB/SNrwxmP7gaHtY9Y3HphwgJgXPan62ZZZAj44eUp1ASA+XwCyaVf0Eg5tr7J/sewdcRi18hCnnoRcf7oaYzU2+z22vA1C4rKLlwtRODsi2IzZ6OfPu9CbcF774VVxmSp9nn+uZB4x3R5iWEW7F30tPMT4iftkXhvaKUYQPb6fHZWOuUJrJzWfePHx0pQhFrjYvN94blCmF8Xv7rWe0rQ8Lzccd4dp5YimFUaGER4Ra2W5edxhbqUeYD08BULdLIR+hKUj/tIVQvVtLgTcfI/DHGQcPJKCqnDuNAVuVMFdvYHcZmmrdAupoVA9Jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wr1EWI58vgY6CWzXaBMfjrS71hlZHq0bO3sBMwFJADg=;
 b=ewF0xcjpBhL5fAqUZhKrthr9LDeq4mjn9ryQllRh/DivJTUn+yAdNjTG3KSfjLaOFCG33sB4FpcObqL80ReYdgjKWjQkVZL2X3jgngXUZP8A/dVGkMADewjqvFEEOLYm72WGgWXMUcYIxI/E5Zvn02U80n6yv+OkUsta0nmCXdNZ/EFR/4wXK4KYFRIthwIZoyqy5SujXfk5npn2eECP79UKHtXTzIkWSf3BIFwMXMLMYbvraazlNZRl1sqRVnwBYB/Df/a3iwQZifZqnYi+0fVg7fdGi21vAjhkkdqqxzb1yR0rzhe+gsYJr2X7L9JXemh0kSlJ5WR/Xuat5IBX4A==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by SA1PR20MB7440.namprd20.prod.outlook.com (2603:10b6:806:3e1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.56; Fri, 12 Apr
 2024 07:07:17 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::182f:841b:6e76:b819]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::182f:841b:6e76:b819%2]) with mapi id 15.20.7409.042; Fri, 12 Apr 2024
 07:07:17 +0000
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
Subject: [PATCH v8 1/3] dt-bindings: dmaengine: Add dma multiplexer for CV18XX/SG200X series SoC
Date: Fri, 12 Apr 2024 15:07:31 +0800
Message-ID:
 <IA1PR20MB495375109D0375B8ADA6519FBB042@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <IA1PR20MB495359880A3A8C4947702BB5BB042@IA1PR20MB4953.namprd20.prod.outlook.com>
References: <IA1PR20MB495359880A3A8C4947702BB5BB042@IA1PR20MB4953.namprd20.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [TczwfkgGVrrMJNwkiu2tX+pCakCrWQNrt/i0Lj4VNMU=]
X-ClientProxiedBy: TY1PR01CA0195.jpnprd01.prod.outlook.com (2603:1096:403::25)
 To IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID:
 <20240412070734.62133-1-inochiama@outlook.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|SA1PR20MB7440:EE_
X-MS-Office365-Filtering-Correlation-Id: a16eb3d7-d2b6-4023-b937-08dc5abf3018
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ad9qk06okJGfioff4IeIYFt6cB6Z9p8IPVvX91BemJr8ya8bkhfKP2Q/EeuxJ1Ca7JtO1JRBNgge2WIab9hjg4NLWtYwapHa7bsmjFGbtT41znvaJ0SrAILYdUomjWvXYXhG6jtlzpMOa6FDGfNKfcpdCI3wdTwg030IgoK1MUs6Z4v5brkgyFLf/2n8j/PZXOPDN0Ivr5bZDt+QpY+vQp/JTjVIFXOt3STkBAPtejh3xyLvhopTwvVnr16sLmIb9LAKoVxer4HkHXqD8cCnbmy4UL13+Sgw7t5T0OwP20XPSENyOuLZRgNJ2AmHpJCkaDz8dxzb6OK+1zXU5CB+Z3vjiY9eoUWxxrOzAB8EIR3uQrcqdC2D2o5VPzJ4zGNY6FvqG45GDTNNk+NQujQ0CFDY4wzndz5qaNzBWndSnO7hKVUpqcYnfrJsE6YkWql1JSsAKF4hVbZpzMqFMxCCv8SvpIP+8HdYSGNXQ3C5ADcofU7zmZ173xndznnluEwzsWXQTrLNmrkRrjhHMgJr4YUVCKEKgjwtPDXLkNTPfqenwLkATdGz7Fcfk3UgWq3faGanqJvp+ausdVvoJ85jdepaROm/FVxqWys2P4D2/7IFbhunPG+WY/O8c1LX8cnR9+O/3bDv92HD5s0Hsd0QFIP/qvzNTK7JExDZO482j//Pc/mkzy9P3IDuESRvi66W
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?E2OMlPMLoIwwLiKPho75CuSisDZ+xJJD5cB+GjoXIKnA4BBxXu7jH+tGGFdr?=
 =?us-ascii?Q?RU+ECzDPdKdEI0xhgRuOMKhhxnPj2I4zlWrQW97QQABXhBW70KjZa7RSMeTX?=
 =?us-ascii?Q?R5sWygPSWM1exuezW/hQiDcx8M4QB7jT6N+8MueLcKZhqtQ7ZjOY3R0VPC/k?=
 =?us-ascii?Q?s6JJ7ThdoZbcbGz9mTMJDfsjv6IrRXdG3uR1VgB1T13DqU2RMRaGZxMo+EmW?=
 =?us-ascii?Q?MtBVG/1f30+FgB0/9npCfulEYwTJ9YHqRN3O4xABBs9x/ZdyZ0oU7OjhM0ts?=
 =?us-ascii?Q?Q6OQUAjtP2AcS2hWnHZ1x9C4V6SVKLlA5SMlsG68y1qIwp1TQRp3rMCUZ8Jd?=
 =?us-ascii?Q?LwLOVUwvxKFodgarIXWQIARMrmPe0C2UWlvJVAbwM41xqUjjzW+EqwujSxDF?=
 =?us-ascii?Q?gci8rN6tSSagfksLgB6GYdDaj0k4r8/HQSEmuLWZcQf3C2k4NzhNLfsiY6XA?=
 =?us-ascii?Q?ABxVl1dlDC2c5TH9SHWKOoM8gg/GZOY1jN8lPjKtX2Uk6uLgtcIzXr+/+hlv?=
 =?us-ascii?Q?MO7QzNFeN+Globd9bSKyFVq0NZKgBeSnK1EJTDrCl51TTm9TUALs3UWdyppN?=
 =?us-ascii?Q?maRxfRGCLbHFwoMTBBdxzCtv9+VgDSnyvnBPZwEgeEUXvVrtOha4K9CuT5YS?=
 =?us-ascii?Q?vLW6zNE6yC8G8gqe1wyIQiScB7hhFbc5lLUfJJd+gzcDUdxhHHQ+sPg85i2j?=
 =?us-ascii?Q?MagBiV1lCcR/3B6E29Yzxc8HMoap6mXKpdVbAZvIoqdot2rwOqdkBvXApzC9?=
 =?us-ascii?Q?JuwpOKRE2faLZMQJJc8gJnbzz8ldbImFdGJ4UtjCj+dyCcob+GbvATBCzIxr?=
 =?us-ascii?Q?SqGquIp+DtR0qojZ4Gz21hZZL8t/hNeUhkcXUB81UyPuPNtlX9tpXlDubQSo?=
 =?us-ascii?Q?IUWFYSZ5Pc02ZxIjY3slwjIRGGGCHPFiWF/fIwD5FcU/lXQH1AZ5NMxf8whv?=
 =?us-ascii?Q?W7hQRH13Ompq/ANn29VLsWmRjvMq+VcGHPmmjrzIgwHS7VYHvnRT4ZYpybj1?=
 =?us-ascii?Q?tecac8Om4VCXYHkWvlKaSHV6BjpLwHrVjuEuCSR7Nr66gMixZ/PTsLw0YA7Z?=
 =?us-ascii?Q?dM9LbcgBOSZ4FE2dWumqiVdUIbmzhVYE0YAaJ3R0rG111CeleOwQRQadIqsP?=
 =?us-ascii?Q?tdVrvuuU/WbTAPkZ6vU+AWH9zF55G/239lVx2sT7o4HNKqjhQhJYh5r/ofaJ?=
 =?us-ascii?Q?UBcd46b4zNpWhMkq+SNeUx+Fe88B1tsUdVopvAIvOZJq2+PL216IBcyehD6K?=
 =?us-ascii?Q?r4V6kUKMMubxAmbJKyu5?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a16eb3d7-d2b6-4023-b937-08dc5abf3018
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2024 07:07:17.3796
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR20MB7440

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


