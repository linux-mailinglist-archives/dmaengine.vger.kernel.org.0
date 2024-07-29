Return-Path: <dmaengine+bounces-2750-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2040D93EC9A
	for <lists+dmaengine@lfdr.de>; Mon, 29 Jul 2024 06:37:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 89E54B212AC
	for <lists+dmaengine@lfdr.de>; Mon, 29 Jul 2024 04:37:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B12DA81749;
	Mon, 29 Jul 2024 04:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="uWAviDDk"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02olkn2071.outbound.protection.outlook.com [40.92.15.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C89C81E49E;
	Mon, 29 Jul 2024 04:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.15.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722227841; cv=fail; b=RxT1wWC8XP1zTF6ges2goHD2Bh0RGXjQKq9REUWazzuqGcfri2rLEytNfaq7CPKmLXx1RKVVkQMcM8oO2qSG8pNV06P/gSbSLT84OSmf48HCS8mqAb1yI6GWaTQoN8RfOyy66vNbh30y32QUCL0h/jBwnoTbtI4OHOqbP/auNMA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722227841; c=relaxed/simple;
	bh=366cPlraucF0CHjW2XCLk7Mco6aH522k0CimUsPk1Iw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cTqc2R/10J3kkN4g1FmMpxY5c1LRvo2OOi/v66eaZJMJaRYUE0qjasA3iUTLWSTP72A+G/bG4fJISlMKIrZYfWUZzFk7IlhYIeZY6zyMUJ5v7u3lYCqAN/CmLgCabx7dq0aTiUxA+npXdTISDlrydTG+4uJOme6wzB8kibRojp4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=uWAviDDk; arc=fail smtp.client-ip=40.92.15.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QQOukr7Oof8Tkgf9dFx68qyEE/vFKxoevkfXUIKYMAhpa6Y9wl0Q8h6tySWFj2/1fR/iCDVBSKB1KOCm94QuHuL8cW9briESA99dhwjMeNBbbEGJJh2H7H4X2k/Spq36KSpB9vq/F1DBCE9LyTM/UJK8Lrr5HhYbamdHtsUJTScdxdz50zhXmImThNJ/XoEaVywCYAnr5jY5hfORjCftRQad54CqAbgy+GWHIUXwYZwldJ74Vudh9Og4FFoAGwQkM8KhOysa0h/Sg4GHnyDs/0YRnnKpFwsTXklb2VmW8CgvU9oPCe5tpBLCSR9P4LXIRAXhQpszp+wCQxaL8uQjJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wr1EWI58vgY6CWzXaBMfjrS71hlZHq0bO3sBMwFJADg=;
 b=fNIQ7WhZsxIE92E2e+pAOnEY1VB0V5c3Mvpa4bFLmma3cOrgAGMaMh7M3ZGD+dwzasdlEKDoudsB5ZZNBJ3jr6c5TqaVdZ3vANqaFBUYEhKJyD4TfzWYSyBhfXycZy2/+CIY4Jjesvz+XSDMOh5T/6CisxTULueeCuSTYQRy+pGm94pCa0J1XTZATJlQwmMtj30Gu+mEK5GIegeFGGV6gdXk6noowblAbQkBQsSWEPlp5b9cTEm7/d1D+m1nnO1ZZxGHfWSG/+0Rx8UNt6BmUpyNVzZo24kKyxkFx2exrWYTS4WVBdUbfHNo9Oy/rwCjhtlfM6aWS6GfPsbGBSCUwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wr1EWI58vgY6CWzXaBMfjrS71hlZHq0bO3sBMwFJADg=;
 b=uWAviDDk+Ynb5wvd4phfem/HbYF193D++cXQy/UHgGxfwYW073tgE65OH8Eii6SJehBM0qRMJp5gIhBzS5bG0GAKZGnEYqVT/BHIaS2iDVxuMqQ8I9p4MM9PW+/jmUdTFFhWUTg8ingLtSUfVDVBHv8MVEVFD6XJaorRD3PLEH8urC7F0ouSm6p0EKr7q4hiSt/4bCoFu7P3M46LxZNaPVNiLxSQ+VSKehTbQ6TNY+sE2fsDdVQ3JQs+8N/i3KJGvyCgXSKMINqbKb0Hj3gTJUXY2jHSNMKMRwO8MZ9pu5XoeXjpJiOlDCNU1xdIw/SLtva/WofP9CSUYQhFv9aQOQ==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by SA1PR20MB4516.namprd20.prod.outlook.com (2603:10b6:806:23d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.29; Mon, 29 Jul
 2024 04:37:17 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::ab0b:c0d3:1f91:d149]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::ab0b:c0d3:1f91:d149%5]) with mapi id 15.20.7807.026; Mon, 29 Jul 2024
 04:37:16 +0000
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
Cc: Liu Gui <kenneth.liu@sophgo.com>,
	dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v8 RESEND 1/3] dt-bindings: dmaengine: Add dma multiplexer for CV18XX/SG200X series SoC
Date: Mon, 29 Jul 2024 12:36:51 +0800
Message-ID:
 <IA1PR20MB4953865775FA926B2BA4580CBBB72@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <IA1PR20MB49535EC188F8EE3F8FD0B68DBBB72@IA1PR20MB4953.namprd20.prod.outlook.com>
References: <IA1PR20MB49535EC188F8EE3F8FD0B68DBBB72@IA1PR20MB4953.namprd20.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [OxSrfHYK5Hgq2n3dm+S83MyCfc7Okiuz84L41aUuVCM=]
X-ClientProxiedBy: TYCP286CA0361.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:79::17) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID:
 <20240729043653.899480-1-inochiama@outlook.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|SA1PR20MB4516:EE_
X-MS-Office365-Filtering-Correlation-Id: d7d7d55c-7d28-4177-84aa-08dcaf881fcf
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|8060799006|5072599006|19110799003|461199028|1602099012|440099028|3412199025|4302099013|1710799026;
X-Microsoft-Antispam-Message-Info:
	vF3pM2UZ5y6BlHZFwT45bfsSI3ljTUB3ae9r8xHRpmza4irNB5wyDKxBASDOPas3S2PWgdLbzhOqM24SVY9KWXw9if6w3qkPr225dvdzfG475fZdOW1LCNjz+pjb3fm5Id2OnsFDhejkF6kodxBUC3JpvSTiy16RwfB0cyQ7sCvrkHfCi/4Mmi+zjgepfAV9ekzqUuqHfHopXnZZMSVdWPjvBAmu1X770c7ZJEmz5LT0EKA1TjvEmVtZHrwx0DGIeS/yqlKh+bGXOpniF5Y8qYqcHs9/FdHNfaMnS0HAEeG36bZHVGdzH0cRnP0fhmYt3Dl2wYKEvivNmdCem/TJZPHObu9mNwRQGAAPPZjlzlAzE0mEVHXVhTj9FXYyzkTb/dgzQW9T26pYL1cfdwepDkXSiqFojESw/VNlKEA9Yj04cBNO/EEOX+GHFDcr1xTFBWfQrDTsIIx5ht3sRpB1IEDNwk0h/tXYzLRB/1AsDh92mqJIdwRwpqjLewGyqRwdhNWGuLQg/NbXGo40Rf+0DOi5y+bj5YmezMy5eVyRDJy5q65rwykBRq+RBS4RaDHkzCm7hwVduLFGqsCQ7PBt9ZrrHknw0CX05SGsU7QWmu2Lr52M9mS0y7lzOCLnn1onSUJ5hOaA+AoohoANFseI8Ogvac17XSzB1qhACHypGFVEGdjcQNAzb02A7HGB0sZmEdU0+eSBWjIGPHeDkX76VHJI+AzEaS4msx/2aj2N5sNdH33/IwzGXdz8oS14R5E4YYJSV2Wp+uiKRryWNueaVnpSH4EpNo83sRXItK5flWopNGKs4au2JEX9Zes9K0Z+
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tosEywjvHyxng/rEiBJ64ikqWoEQoQofqBFJhxx5p+w76g7pp+W5lkFnxv6W?=
 =?us-ascii?Q?+dOFRzQN65/FB++b7r87WEDRtBjGu+sxVFcdP66mvcAHSvy7s54tp8D28ZnK?=
 =?us-ascii?Q?vAjB3BxwF2XDo1sxVqBgVt3UcnDdm3rYMl/p8xFllTaDh3oMbvSbl0hSFVea?=
 =?us-ascii?Q?hQWXQ3tcu1dz8fmlaCI45f8UQGsKocxcE+TN6+wz+FVt2hBNHqfmB3/+VPg/?=
 =?us-ascii?Q?K+5JKVpW18UEf6LY6gmVKdQcstpRF3rgkmyNOAgN5dDMBsQG104qLQrWft91?=
 =?us-ascii?Q?nyrivPUG+2DSM5k/aYIZZL6pkT8ljt1ZLm5r1SomRgXLWrqTmzCKvFLReJ2n?=
 =?us-ascii?Q?4iEB7mpC72Jfaz/GKZXFH6Fe98qucaPmPj/d26iOyqoRfMSmuOBlQ+1o0jt8?=
 =?us-ascii?Q?qJLgjbEPlFzv6x+QCeXhYx1wYxK4fX/guLuOyPx0tFXy0nWSFvG11UNjfR3d?=
 =?us-ascii?Q?3wMPgnYqYLXIeHDrMNp2xq4Rzn6p+V1gGT+YhlHaJ1NqJsB6sym9KcAV4fyW?=
 =?us-ascii?Q?aZxuRmg39d2NLsVzXC6o5ygcaQ6msuWzmnvSc2SSI7VofBeX0tdEXlTMH00U?=
 =?us-ascii?Q?GRvAeD8jwvF04yIsSElGcMCWaLjvWgqhrYQzfOw88i5SqKv7120ClmeAJWLs?=
 =?us-ascii?Q?gLOQuj2Bw2Mo+XNVzvLRW8CjnkmLH0xH+ietJcglZ/9El3Xpb9Qe15QXuuKF?=
 =?us-ascii?Q?OvUl9bePlnXl9pcizziYNPYaxvC9ekHWBfCRUvusSjmne61PUnnT1969Yk9c?=
 =?us-ascii?Q?tALeq9ioBeFKyPKbHSkHk16RGhVjPSfsZToNloIEmWdyvSU5V4ubz2/j9aPk?=
 =?us-ascii?Q?f0ruLD9mu0xArTjt8jH+Lhm7yeL43MVSFMYfPinsvhmSEllBns3yGJtDVwlq?=
 =?us-ascii?Q?KqH/V5Frh3bXyZdViIfEy7ESky9+q7oFM7acD3Vn6/ZRDYaMChCd3Nw0nYDh?=
 =?us-ascii?Q?ro5e1UubTylzbAi9PwyoUSqcpLP6t9n6c8ZB+ITCjSBiDKsVfSUQhznqNLNm?=
 =?us-ascii?Q?/5MzWl90hg2jB0o2JZPJ4t/WAS3IzTWCUQ+uq1iYCii5nBpIIKqU8eggREGR?=
 =?us-ascii?Q?ZLRsudSadMGXFZLeixd0VigkTfwyxiMRbi3PjyEXs3/uVUxR0lS+Q3F3FJbu?=
 =?us-ascii?Q?TDzg6N5BljTe21duGIV36wHjp9qNk72+G842NgswZlYsuMYF6x3wA5Vcby39?=
 =?us-ascii?Q?DeznSrawHQMlwKBudq+Nz8u8QyeexUdmXS4RRUvmZodGdip7/aoxPHktwhV3?=
 =?us-ascii?Q?iDBM+zBh1CGxysPYcGqD?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7d7d55c-7d28-4177-84aa-08dcaf881fcf
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2024 04:37:16.5257
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR20MB4516

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


