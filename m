Return-Path: <dmaengine+bounces-3055-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E9DF967D02
	for <lists+dmaengine@lfdr.de>; Mon,  2 Sep 2024 02:39:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5747B28161D
	for <lists+dmaengine@lfdr.de>; Mon,  2 Sep 2024 00:39:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C977533F6;
	Mon,  2 Sep 2024 00:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="E8SEmroH"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02olkn2043.outbound.protection.outlook.com [40.92.44.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27B24257D;
	Mon,  2 Sep 2024 00:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.44.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725237542; cv=fail; b=SRW++cdlUjqC49VQQHWf+EtDw0sPKo5amRCWnIQ2lfyS85Y6MFv9gwA1dMKndWRNM0m/nkKYCXwc7mn78x13ZH7He3+OFem1ZBL3ee55LQHKMWS4tle8ggAT4DQ0cjeqhbvRSF0op5NHw7wxWeiHA8zWY+VHFafrVQaJXOiQK4E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725237542; c=relaxed/simple;
	bh=a++zSDN9oMyv9fA2gKZ72zCI8P8EzQ3BS/V+g1ttRUY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rjHLEqgRo1SosFUpJl+43J89Muz7Sq3JTgRjHx4GEwQsJgLmcFXRYYWU/FXFVTF6ZCxd1Ifl6sz63P/o0pp2ql4V4F62ZJn5bxTfhodHUFTAZsD1Iqljkb8kmUAiVYBrZsm+qkzDuwvu4D5EotuBd7YCuyl90OPFn6ojF4fy+lQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=E8SEmroH; arc=fail smtp.client-ip=40.92.44.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ErMd1/vSsG3mPnjN7CUZFxG/UZa4K0x20fZ6Fkzx4fmvBmJxUiXpLVPWCRLDb9OPAti9C9eDgPHjdGW7yVw+q3aweaNss3k9t99KJlIPktLfOfu9SvXUgEi8CV1U5a+ssT7JbU3psoQHdQlS5S4NkiE0ii7C4n7JpF1kf+AMSGwDzdiVQOxxSF6EwjbtkMTY8/MN7oR3DdfG0MPJeLDCP4LkEyiJKFTsWTcqosa4OUp9dtGVABg0GkC4r0vAGIpV243M0Zx0z3pdXxloTRekTto/O+A2sSPPpPid8KDdYFRUTd9qTDWr9eEJtO5ojjQnWkebMXKySWijnAGWMc65fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=odGUw6TQxCZH1ppD8faEmD9SkHZWFu7bl0uSM+oAuE8=;
 b=E+MJE+Pn9RftspO/DggoHUiFt4+9+nBAxZkd1x67vzUY36Qp0WgniY0Dmj6cu+IUGcBgQfabdagKn7zmMLM0GboFfXVedJ9h7U2fHjEx4sfLGGp/nhZ8xzwBupNZypi1DMV3q3YQwwhRlxYbgDD6tEdBBDXkhIeqd+NnlIIK8p17pIY1ZYk0C0R/me+Uw5PtDR1BUpmW2OxGhOGbip8MeHSoK2ez0uC9CSTMavkMS+MRWmfSGUUc2WvWoqpDvBM/aYWof1uFOt3ffcoxZvbWv40ZXpnINNhKXmTHrPy1p0KayaNFWDr+k5iffsegU+aCUZtq16skrZaL70qdJmQ4vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=odGUw6TQxCZH1ppD8faEmD9SkHZWFu7bl0uSM+oAuE8=;
 b=E8SEmroHbp1hb1Fy6zTJ1f6UdKQMmw3qarg45Qi/ltcC6RTGIyN2EkY6xuArcAD3/fDv5ePURAoegGS1YhG1OMcQlPHNYFRBf5Z7zJzG8ONWJmQ62Ge9R/XTAtVtHH87W/Cb5NFdfo6D4zrfizzHpAA7b0EBcStA552eyZfALfM8fC6Jdi9oyx4ju+IJcitX6hLHpoA2BDFDmA1IEDisAhTHEnax7LJIhsGmI1uw9MoF6cdl0JDcGWqstXVlATn4drn+RsCIc+4KvZXN4j3250N7QzmUGQdVWN/N7TJjtV7OOfa6ad0mnCx2RMn+FUp2r21aT9ISSzsR2lypwZu1Ew==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by DM4PR20MB6766.namprd20.prod.outlook.com (2603:10b6:8:be::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.23; Mon, 2 Sep 2024 00:38:59 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::ab0b:c0d3:1f91:d149]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::ab0b:c0d3:1f91:d149%5]) with mapi id 15.20.7918.020; Mon, 2 Sep 2024
 00:38:59 +0000
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
Subject: [PATCH v13 1/2] dt-bindings: dmaengine: Add dma multiplexer for CV18XX/SG200X series SoC
Date: Mon,  2 Sep 2024 08:37:54 +0800
Message-ID:
 <IA1PR20MB4953EFBDF509588F53C937B0BB922@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <IA1PR20MB49539E5AB43E44E9DE5473F1BB922@IA1PR20MB4953.namprd20.prod.outlook.com>
References: <IA1PR20MB49539E5AB43E44E9DE5473F1BB922@IA1PR20MB4953.namprd20.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [tnQhI6DDVnCJlENtHPB0kulZ7xpxQIWJWp7q5hHUy9c=]
X-ClientProxiedBy: TYCPR01CA0198.jpnprd01.prod.outlook.com
 (2603:1096:405:7a::19) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID:
 <20240902003756.217629-1-inochiama@outlook.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|DM4PR20MB6766:EE_
X-MS-Office365-Filtering-Correlation-Id: 63546099-3aca-4ba6-fb42-08dccae7a275
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|19110799003|5072599009|8060799006|15080799006|461199028|1602099012|3412199025|4302099013|440099028|1710799026;
X-Microsoft-Antispam-Message-Info:
	ADtLaeyGaeT3h5Sie0bAqqW5xfCOpOZXB7iCEaKuHCE8sPhG31DYM3RdwamXC8BbTYxW9c56hCaQeLtzD+L2EnOqWhonNcIoWTTkLhnZ1DcFxhwef/NxLqpWfvaEcOYbhNGJ5RDhFM1lhUSCfECWjAB2BhRHRPkmIXld+KW4n80Qxd5H6TJw+ZJ0A6xlGWf8pyz/keeVLFEKVT6rFvAt8ZVaqGYEbq96mpXpUV4es/BjLuhFpMJGWTjtB1PoVN/ocAEe/fDgWEjHeNHMGykUyDQcR0lvoAXamsb7Q6HRXqJpcmohUQ7xUn9iOh3YVnD/aDiu4kNlbiPHpBl5FeuzaQa8bs0ig7SGVsJHKvxNL11pMOLWY6z8uQeFdS360Gd4kQ9Y43KHWRCIpQUVE7mw30j4axGvAYF7ZdZdZcb/S8PCbmXgW4byQLprVCvg87Y12xrUrRNLWV2MXumhC/E5UqZbb0Vj1PU8MDCq8sa1deF9+AtcfRkvrIJX68Lr5spDrO4YLYv4F6ydiYewXeYOHue92nwEtduHn9QuTEcPs2I4BVLqPlQ7QekrUaOevYE7C3/aghTJPb8+fwpy48yUebRGO3LlCgZbMh+GDMv8X5OcG+zpEZW0R3Udgs9EN4YJujCcQWFUBT3xJ8pjVaKjPxzB0XGiNZZWbeeuSx1oUtLeTHNGd1cfVMZZAxK7+bPKmS/oNNIXWOgd32v9kCUv/w3EeHH7Iey+DuuYa4OxzIFqY8NptPJFmoLpz0GSDFecCXDBlNRWHW6hU4LFOu97rS3UsGdmhsHP5hZtwqtu1fSBW0frasarZR7Ul/bqgHh8KcT8/uMvjG7r8f3hNsyb5oPxgqVmq0OHkPnBYx59JVU=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cMGwwyAP+CZsoboIE6TKPHSF4lfuOKfvIglBALKQrECp/plZUL7JZzgKm80k?=
 =?us-ascii?Q?/fU3OOY/cN7E7mcU1D+rJiuKW0GeFm9EhEKRtq+FXpi304gYDLai8J3U3dgZ?=
 =?us-ascii?Q?nRwSPmHasWSPT/zDwo8MVZM0MaOwvqtCiiEAj9qaI//vkk8ivZWlasJaA41c?=
 =?us-ascii?Q?7bFbwMWd1D+nGcWHCkUYKotztqqqnixbfeBpS3sYJHXaoYSGbMhLN5Apg7lJ?=
 =?us-ascii?Q?RrY9rALGYnYk++Dtf4xspO66iCV7mZ2msdvixYWlQGMDy0nIaZltc1j9yJyA?=
 =?us-ascii?Q?wFpoOvdac8bQb1zu5sSoFZXjh4OrJWrP5+/WDVj+6+enzk2k/wGba5uW/xlT?=
 =?us-ascii?Q?B8Q9Bn2V2OdXiNw0fE0CjHKjgXRD0OYrmjJrzTJi/8VdvMAfWkjwq/T01nH1?=
 =?us-ascii?Q?CkS8xX6L+ONq/IfniFte8KAFHkcwNW/1IkoXCClQPj0feHNqkG0KSWif5iUG?=
 =?us-ascii?Q?mpKjAR58qt8IYGHFnh1KQOvGLxY/eTd73CytLWwV32nBbNtvn7L3jlbLh88w?=
 =?us-ascii?Q?/PKAYu6kvh8BTFCGPEWnM8MRTtK+KTRltSmIq0OLPlYJi1KcvI5ASNgBw1HD?=
 =?us-ascii?Q?gbLVatoF3P0+VkNchfnxKVjyb5gdK3ZJW75vBRwV6NvPsaAe6NZZgLKZNlt2?=
 =?us-ascii?Q?Amp9HZ46Jxv8/gu30PldZI9tj3gM4U0CkR7ngViwMzS/WWefnahePtMfgO12?=
 =?us-ascii?Q?1WxD9NKUk0jrwMsRjIWcZcFN2PYK28uqWgR+tJBWD39EpGpwqJU1syctYEVf?=
 =?us-ascii?Q?NpB5OfvmnLJVFfHqV7+jPlqKgWtc08KYBGfDQkgZzNyE8G/xWL8T6UKOUrjQ?=
 =?us-ascii?Q?REbMNraRR0TbuTcXISprH9QfJhKbIcwcGPASjsmUdssnrTI4r3Lo5MX9Cq3Y?=
 =?us-ascii?Q?Zr7jf06QjjZI9G7gR9PFLtOI93RXicPGuKj26/T0fIGbGZRubL3VlCKIjDXq?=
 =?us-ascii?Q?Ego4LNS1jnPeG12UHwr5RGNN259yUQm9Fl6grj069vYaajbm5cUBx10V35Sw?=
 =?us-ascii?Q?6JD43CmN2iv5XzPQRLjQslPYPn7la7dMa/Dx+MX4pCLktgX43+yzK/wFxtVE?=
 =?us-ascii?Q?ttFUoxNqMP+rPBxCtISuOO1rz8l783vQDD9nwe1NWz+NH13WNb1TZ8KnZG+n?=
 =?us-ascii?Q?c1qkCnjj4AmM8U6LLesXhlepBaWndt1hqbLGPk79Q1bJ4x39Ux/E+8TasiEp?=
 =?us-ascii?Q?/iqscKLPVQcd/IApI+NQMz7zkMsJROREaxoB6rPOCSdv+xfMTk/HHJV0GG3b?=
 =?us-ascii?Q?M/hqPmV8jrvW8kmFSN8f?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63546099-3aca-4ba6-fb42-08dccae7a275
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2024 00:38:59.3130
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR20MB6766

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


