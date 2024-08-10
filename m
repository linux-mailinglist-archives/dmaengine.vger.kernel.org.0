Return-Path: <dmaengine+bounces-2831-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C96A594DB79
	for <lists+dmaengine@lfdr.de>; Sat, 10 Aug 2024 10:39:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58BAE1F21C51
	for <lists+dmaengine@lfdr.de>; Sat, 10 Aug 2024 08:39:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7038914A619;
	Sat, 10 Aug 2024 08:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="lnLUFme0"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11olkn2032.outbound.protection.outlook.com [40.92.20.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AD0E24B2F;
	Sat, 10 Aug 2024 08:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.20.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723279181; cv=fail; b=gdhDdyTKe3tA8kzIF1WjTHVEsfob5w1OkiSNlyQo5s/DH6QyjjWcAZDGzkXPd/xGSqCcmCYUBKbqvdKR22IChM4Yf+FCADn3B6hp64ovZWf9KgJQ6Hj6rFDBrZuQ9CPLyDkwRrllBRSKtlocRMb5zFsYfDfxx3pjdSNMWV1WP2Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723279181; c=relaxed/simple;
	bh=i9vNv66HDHDll+vbxgK4SnsmzW4uDRQPtQFjqs3T87o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mD0Mf+u3JxqvjpEy5lXjoMhfrrNLmTHUNddPjcp2PBaYXElE6bGneXyTnCcFGZ8wbTEZVeVi3/a96K6aX2iuofRgdsWXDh9zBPl4fEA4tUXM9EL6Xv1W3j4Cgj1PUC/RcNDR9JgLnD3WI8B8OMYuwBMt8AS0T+ZRMdjngcaN3kA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=lnLUFme0; arc=fail smtp.client-ip=40.92.20.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hp2DXPEye17C5KJMB7W71QHjX3vfjMeHa9Z1sL/Wp8y+LUlegPAdjpwbK3JKt+wCJjWuvF9dpbh0k0ZyDJkOxjllDRWA85Km2wRIVR+MKXskScdmDgOaQaKI78oALQhiBxWQkrtcoro9NboYQeGGXNtaP59zKZqDS5cLBWn8tcZHi6yjEr1zQfK0fzggDuEU0nwpcVom/5IqkWl1QspXKCWOgkpvanS4UR+gRKIA/oH8OYtTTE8Cj7W5zXQ5QYbvcr+cxRAn0erRW+o5s5MmJmwMzuSR7+5KC5gRzek5bq/t9vTE0Pau9nCAnTyRFN52fXV/qfkf2iHFeZHIs26HcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bWgQNS5HAX8Lns7csOKsQ0dL79ppzSttQCfsAesf1FE=;
 b=EnXkKlWztjvc5khKsz5JZeB10hVum2Cu68LvkFxcUAnGlYTkk2Z+Z3xLZba16fVBpA4S6j8pJb4MiFqF0OwpJOlF64KCuisvVJ+AQ2tXXcQMzcZTQ8ITbpS10b0AM/ZRYQQYw3IvO+P4PyOnjMHzgKsthRQurh0+nloYYX1wpillbmSWZ3YrB9n5YALpCK7wvOW/xUfZzio8TkVn3+Mxn8M3mTERbjrpzduc6Y1zhMsxhWQ4MPO00n6oniCwV+prdkmqCzVVFQnfbmHyC09AikEK1Hf5Cxs55k58CzN4c5kDmlVuRTZ+NXBsRXpwlN80wsCh1UURjSuNKQ71RVetjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bWgQNS5HAX8Lns7csOKsQ0dL79ppzSttQCfsAesf1FE=;
 b=lnLUFme0S0pFfNbqILta1i5HBrev9sGqAnl71h3onKnQfPO0afMqIeX95vin6wAznz0oPDIHunGo4c6Tpxxhz4k7MvBsNAtD/4XkCkk5TsUUPb+Nz0ozdQKAJ00+gxU0NLTEZWI2HFsZaXQEttDwU0ezQtySU+PwyQ5/mBz8mrmSoFFYjXcdIBw3eFXdJBp04xlaTujbKN59+5Y2p4X/fjAhsT6nGwPTQnoaxAUCgr0ZMtOHywsGQfnotKRSTtjkA6b+N0EERzlD+B7xYgW+OP9dEa/uvBU66dsuatEWd4mK4gFswhq22N33azf51L44N3D4qGr6koer6Nq7Ic5QEg==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by PH7PR20MB6115.namprd20.prod.outlook.com (2603:10b6:510:2bb::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.23; Sat, 10 Aug
 2024 08:39:35 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::ab0b:c0d3:1f91:d149]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::ab0b:c0d3:1f91:d149%4]) with mapi id 15.20.7849.015; Sat, 10 Aug 2024
 08:39:35 +0000
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
Subject: [PATCH v10 1/3] dt-bindings: dmaengine: Add dma multiplexer for CV18XX/SG200X series SoC
Date: Sat, 10 Aug 2024 16:38:53 +0800
Message-ID:
 <IA1PR20MB4953DBA230FF57B2F78F7283BBBB2@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <IA1PR20MB49530ABC137B465548817077BBBB2@IA1PR20MB4953.namprd20.prod.outlook.com>
References: <IA1PR20MB49530ABC137B465548817077BBBB2@IA1PR20MB4953.namprd20.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [8ifUDYPhYk4+XHypRhGydgyYWUTFlQkDG2eCDq+F8n0=]
X-ClientProxiedBy: SI2PR01CA0044.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::8) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID:
 <20240810083857.487764-1-inochiama@outlook.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|PH7PR20MB6115:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ce476a4-cead-4b46-3c53-08dcb917f6d3
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5072599009|461199028|19110799003|8060799006|15080799003|4302099013|440099028|3412199025|1602099012|1710799026;
X-Microsoft-Antispam-Message-Info:
	qoKyJ6qu0KH1+rCl1e6QGvezIdBTNzrhfQwkw9dtvVPuYc+PpI5iJKvOYcLwjnW4gCUpCFm9xc3dkYm4O1PSbo6bzB3FU1Zr6Qk9DUGHp5Dt3u2xdAPtfsiw7Sfqs+x5xfY+e/tjhMb9cNog8+VRAlsILE1bsSGSnKA3VY28krtLM67eMh7v0MxrK9AAQTj7LteJ97dq2QCxlVErPvjmRFGgZJJd1/eqNLrWeFuCXTmU6DRnzt3dtgkfTE8JHMmJ5FFBF3ivPqT/i/z6bodp/F9gS3Qw9robTIn7QKe/6CM4Cmb9IJ80XtcG/32opSouMK9m+l+91XNXXuroJXjS6OIJukOMth9XYGqMka8D7FLZYKuribdTJiDqTV97t89oTj3fykub9LI0Es4rKIw8apipcIVMerS2DLWWGUEn/pDcBaaFn8hCOcom8F827iGC4wFt+WoLbtryfVHyD+tvIymYFaANH52071wIEcNTl62wGNMyQnXSPzDhpuBDrlFx3ubmGN/6C9gnLsHcerVLSmYch4bHsMiadtZPUfI23X8pBPaGDPLWNeqo4JQKfg60hHAvusC/zRji/1/O9/e/6Xgh2ZFbFGBOhB6VgUUr23hGgdyDKWujAW/d9zVqIgwqojO6GoU+7HQxkkvYTDhLmdQKigTOYHQHyWpwxLbPf/41y9RwmLwmC2h8FHaeIXuN4OWotBCZFLfAVB+u4UCtzp7EEricu3z9tOZylEmed5k6tNh8tLuF63LErD6+IPkFuPxH+aNJyrdZom4eKPJRxG1XlR8eNWmk6TbqnOIDFsgN1HlKAaYlYix8jypBNi0Yab/WJ4yhUBi6EVlJSJbD+mBIANekmCCnKwDMN8PR/8U=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0L2JaX9e4nzn2OpN5UuQwc+cd34sGYo9VZUncTOVZH8/GCOoc/RgSYRm5FMK?=
 =?us-ascii?Q?HHniubw0q7xetJkGAmOhc+y9PF9c96NZgv7eaRQ/haWsqsv4wEgo17tuaQaa?=
 =?us-ascii?Q?wjjoYavnytuBxTT5CdiCB7Q/4q21BBBkmqg95IVnjl/jn7s5RzmPuII2KpOu?=
 =?us-ascii?Q?XamOd0RTdxxc9t5+CmqZMj4srlhYnmvAq1awSpOPAzTT/9+RqdiV7SQyc/nn?=
 =?us-ascii?Q?R6upc/Smp/sSeVNEJFkE2B6lZ2FESv13c3RE5KXucNsAokrFt6RNMOrJXZxd?=
 =?us-ascii?Q?ytcWiLJqVQPLT4yRiNZDdcSKsbcv1h61VSR8Mkf8vXKjDe+bliGqSn93VYiH?=
 =?us-ascii?Q?JmOEHnm+eAJQahVHFyiMi+qKoRvcuqCQOKd093oY0dvi/f7moWTNRhqeTdqf?=
 =?us-ascii?Q?FhPNhNpcowmdh+2zfutqw7Sg0dWfcKt50YuvFuCoJYYmc8MXM58ugGaJt8pT?=
 =?us-ascii?Q?cM0L+Y6Df6+ND8FXJEnBUMHiEsBnhSMDFhZxpMfUguqvaskQ9x9WOQLGkIIe?=
 =?us-ascii?Q?8kUQl9oRnOES9/H3hcWtxQS/lLQ8g429SqINAPfJ3hm+3LWLIQd9qIGvc1Th?=
 =?us-ascii?Q?+Cx6UAb+y3yXwp/1O3JF8/bw5rmBz14UKQT13ULLJ7p97PFy+lOhsICiY7z0?=
 =?us-ascii?Q?aMEnXa9WmTrdPTRSXigz28B/hZFuPF6Vv+TnJgg01eXtd3xRQ5NhB/JlCsyx?=
 =?us-ascii?Q?iVb1uDFxn0eFocT9Nq54aP93VjC9zYFp/Qh/cX649MV4kD5rnAP289rexOMF?=
 =?us-ascii?Q?en7/xOXsL52JJ93WdLsaoijcq1DOBv4HxrslzCVJ620VeTnbY/DLdyzTKBD+?=
 =?us-ascii?Q?j+CjAe0Ti7nI2Q7l2ZlaNFnISfeNbefLBsOFqY98dL88+VrPyFv1NroZDGBS?=
 =?us-ascii?Q?Uy4P0d7o4Tc2x8qEteRI7M0tOVOtIzAxuaOGYF3BULkJf8M94P6yiBpf3K29?=
 =?us-ascii?Q?2rfvcQwYA4E/+wwzknMxh8SlE1lZdE3XBJbkUOOYSIUZAsKZeRE8Gdrvvzko?=
 =?us-ascii?Q?+NasXE1C1A5vVUcnjpaBhnTDgdmU8+hNKVj2S8uxjhUDPc2zyVGf7zAUyTOj?=
 =?us-ascii?Q?M1H/EurX8u6+rqkoML2TV+y/vQDuE2yLb9Cj9bkIQaSujkUC0meWdwCd9H80?=
 =?us-ascii?Q?ghC6SL+moJ95LpX5dndj4TtbsXl3+OqeOj7jLlw19z1IJnGCx7Mz523ATJG3?=
 =?us-ascii?Q?fyg/iHCWt3QslyiTakvr8pZI+ASoRL30dyaPfsUq4Qhgj/ynloux6YxvphoH?=
 =?us-ascii?Q?/2fo5kCs88zTPP2BbYCu?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ce476a4-cead-4b46-3c53-08dcb917f6d3
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2024 08:39:35.7541
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR20MB6115

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
index 000000000000..457fdad308df
--- /dev/null
+++ b/Documentation/devicetree/bindings/dma/sophgo,cv1800b-dmamux.yaml
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


