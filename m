Return-Path: <dmaengine+bounces-1646-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 46BAD891153
	for <lists+dmaengine@lfdr.de>; Fri, 29 Mar 2024 03:09:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C51041F24488
	for <lists+dmaengine@lfdr.de>; Fri, 29 Mar 2024 02:09:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B23952D603;
	Fri, 29 Mar 2024 02:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="Kbj2xD+Y"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10olkn2034.outbound.protection.outlook.com [40.92.40.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDA2B3BBC0;
	Fri, 29 Mar 2024 02:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.40.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711677878; cv=fail; b=n1Zef1ZLHYeCT8aADSAlQmgMqGfFX2VipKoczEj01+BALyyHxExbBWiGd1ZvUJShNJWtn+H2PHoyDvvFgcu2CyeR1nKgCDh1dIyq3ULa3aRcTAarHbpXexZJ691kxCKe7clDyoZL5t25fmLVS50h8DfxgLpRQwD39ITvQHpGBMY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711677878; c=relaxed/simple;
	bh=3z7SuVBJyFhhGdOexfoXNbk3U0Gh62PAUEtrYnDp5Js=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IlctbfOEe1LY6VuHMEbh1NOGI9LGmDnPd2U5gq+LKV95426pyZ+ru9EXyQ06tsk3q3VhvbhYI7DEPjN3TasDa5vet+0jErI0tdmv9mJCwRAKUjH0y3bDmNwH7LFgnyaQI9anCwm8nTbhKa/HkWkCw9Qj2l+w1QV0v2vl4iANr68=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=Kbj2xD+Y; arc=fail smtp.client-ip=40.92.40.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SCF2usli8VzvT2yd0/PW4WC6PCWZEhewP1MgX5jdSV2KmzqKexLMsZOcQv9WrAPxtKAvr7So/mo/+/ZEY4rkpJwLRV0oQUDdpQgkL46LkptBoHC5bpZ0r4Bww2hO3asqSlUTgx/OWFDP/Vh1pUyHazlCn+a7XyCE6mKn18u/c7P/zx2q9hacPHTWT1zKduJLKRmtZybO/CkwRyXL6gYAfu0t9TvvJHKrT/MROVlyPVHhXcKlIO7e6dEYfWSOWIpXjf/Jg6BJ8v+0BjGErF9uQZGv/2K1sJMjDrclCIHzZ/3c0CUb5mM2Ll8jvNiwoak79tj3PSLEFZ/awl1Ta5P2Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XbEJgQUkYMUt5cQ9Zrn6SRRLJDKEAVSER1S38u4iw0E=;
 b=cON0QC/qSnC7qiQzVyzD3AE+VIY3t3ydQouRlgvuBWqrTMwDmQ5AnNeuNdG6LZyBMEB5eySj5QHAA2C6pvWacMahR5heSj+ekIfanNgNUKaKQ67O8hXSJsBO4IDFORxLtIeThnvMSRA79KcFP9Hz07YDEhCgfcAbfyklmToWPFqkcX+hynHlweNp7LFT8Y6mzcrjydIgezTyFIMAXo8wRehrHG3Yr+vKIN0Zn6EIqjtkrF3A0H5S59vOX1BKX/KWLGf+QOJPAlUxyaV+0a7Jd4NyJ07SC2AJaZKouvuJpiwelSilYJrgv5882m+nBRHGi198LETNdICL9f7RDSM0Yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XbEJgQUkYMUt5cQ9Zrn6SRRLJDKEAVSER1S38u4iw0E=;
 b=Kbj2xD+YM3Uiu5DnBotY11afZSsIB8AIf8FnCzGTNbdrFaVOt5oHxugXTcwUa9Cb2+RLnrfSBs1XlI4pMDAnrCXvHcBfrySmX2x97Df2EzkovEwltD061Z75S0X8WWDYA8Kw27oZEscOJWZzUnFH+zpZIPdukZzdbledYHQg/jO4uu61ei0ZMw43/QcP/+0UiafBL8B4klWTvgCFN0Rsp0AQ7RMPrdDHJmxsTYeza/WJJ2tUa3buu2KN2woEIWORJpD9nl8V/6lkBaWUJtw2sXXAnpZGVL+uiGfEek0gVc0Fn3K70iu5pLATlFtA/t3qsgAGJtCUNGo1iLvR/raBng==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by SA1PR20MB5151.namprd20.prod.outlook.com (2603:10b6:806:256::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.39; Fri, 29 Mar
 2024 02:04:34 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::182f:841b:6e76:b819]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::182f:841b:6e76:b819%2]) with mapi id 15.20.7409.039; Fri, 29 Mar 2024
 02:04:34 +0000
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
Subject: [PATCH v6 1/3] dt-bindings: dmaengine: Add dma multiplexer for CV18XX/SG200X series SoC
Date: Fri, 29 Mar 2024 10:04:37 +0800
Message-ID:
 <IA1PR20MB4953DDD8E89675650E0E2529BB3A2@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <IA1PR20MB4953F0FAED4373660C7873A2BB3A2@IA1PR20MB4953.namprd20.prod.outlook.com>
References: <IA1PR20MB4953F0FAED4373660C7873A2BB3A2@IA1PR20MB4953.namprd20.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [ooin3k6VJ7coTSQbNqFJF/i9M6jHWYbaOztpjJjWsgo=]
X-ClientProxiedBy: SI2PR02CA0012.apcprd02.prod.outlook.com
 (2603:1096:4:194::7) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID:
 <20240329020442.373744-1-inochiama@outlook.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|SA1PR20MB5151:EE_
X-MS-Office365-Filtering-Correlation-Id: 997d6efb-69bd-428e-12bb-08dc4f949427
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	siY0LAwyBgQ3cxY9zKy8W9Xo1EJjXC1nL+G+xG2lgEzzKpwaNNZ6m18eZrlhcVmy3F+i0qaKQWGS1vFonVdA9gCRFsW/uyvCX03GuGDgsQ7h9E9riGQyiiBKT16sgpcdpmSLXmQMrNjszp8SG3ljITfrRUxi4x6Jenb9REtTw4y7V80/6oZYj9AF1t7K4/3yrqUdHm/dG/ep2xFF9HYW0OwdtczSBqtP6Ak5LrRISVY9g/oWxQkBh2V/4nfqWYp4HZlKCx4R4aQYD1xmJ2o3+wno02OuYyXbXcC+wV64iEvpOJC0otVQxaK1YrO5Z9GKCs60nW5+28r65whV2iMY6xg/86StQwxQ1TOSm5C8pufO27Suu4QPjsM0uPTeWNT/V7L6WTyRRoB4XO8FUXJ10yUMwE9OZ3YhQdosNsPG8Ta9x7Dg2K1QcfJDnukYuUPjCWmyLT+LixYzD/BCQwGEKIUegs77lf/ubbnLFEPpyFvEnMc+EiZmsoS4qUploNWkdWAwGXwhMGP/8lkLdMQvOy+vlw1X5GfZM4+VGlsyxjcHbZ6OCg/ic5BHWifJCq50fFbPANa0pJCYy23WDpCjOpenVKK8WWAWkFHKQfVrC2hfu3mF3CN+EwtnCQLtFET4pBTKgOyj3y+Ca0qYyDC8M1SuVsPA0N0C6CSqQ/tkD2qCHg2YE5aLZ5XXLR3P8xzkwVT8bs3unu3FAWZ2IEbZzA==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?P8jApDyui+t01exk0B9p60tkeFFvRF1n0FwlLAWXQqiUADn+YkhY/CCTLp2I?=
 =?us-ascii?Q?ZyghMJIrARKdp9AhzHry0/Im5ZhY+C2Z6vh/mrzABwK0FP153zBYFb0+N5vb?=
 =?us-ascii?Q?6NRlga4s1kQR7ow/KTWGDJ7TeqrsDcF2lQlAyJGdEeMs8fEwOOUB5/NBJJ67?=
 =?us-ascii?Q?cw4S3x0LheFbMWaobvNApxfFWTqUDkrdYeP/6XA1gIPsFnoxB0ujSxsJWK0r?=
 =?us-ascii?Q?NWp38UZctGnc9FoLf1ja9gjFf/5/UwUKilkwAnu2j7c2Mf8eFB9ta0bRCfhR?=
 =?us-ascii?Q?7U9fnt2prPCGCRCZ/5OXJqzUvjp71Y0Oape0OyJ60mbnCX4CyJIuhZEpfTcz?=
 =?us-ascii?Q?CkRS8VT1V9aejUuQZtSRXuC0HIpd7wvXbgg+NZmEloWgYiWVy6g+aYWsGUnn?=
 =?us-ascii?Q?8g4sjLoM7CrdAaTQBJ37VIaQagkstUGGQ+cJXoPb/ZucamUJCfXHeRg2eZyi?=
 =?us-ascii?Q?0FFmYqmzndXeT5K+sVJnlXm8lnNliv1l06nKzF7LRuIaEbVtJBq94AsRUcBB?=
 =?us-ascii?Q?ZJLmwumRQPEbWuKDtt80+cck6BsTYNC4gNHOBAvsA5xCcyHwAxON/7Rwkeq0?=
 =?us-ascii?Q?18o8nMKOe4jUmfJORzhfe7dSa6Nz6dVUpHf3B9z2Hejv7U3i8QaNT3RmGuG4?=
 =?us-ascii?Q?lZcxfXTjMRSExAtxaMGO3bgZJNCCJSzWm30mvvJsaA7h78PJ+0HuJM2E5rup?=
 =?us-ascii?Q?q9WN+u7EJvQD0PSfunD+NfgCy6cBWHKir3aj4XUvT+sSFpPWRMHbjrl3BoHU?=
 =?us-ascii?Q?x8oVuiMcbfqP1giAUYw7HcWt/JgrdH7kd86r2tOChpdsVoqkXSBHP7gGpLIx?=
 =?us-ascii?Q?O2YJUZv17UxOU2WOj1Mgs19K87Gk3iNv6DZHlnpPdVbEzvPJOHWiY+oATHWv?=
 =?us-ascii?Q?3Caa3GpiLJiIC3gJq8ICs0H/ozZqnHXStayWAJsBRZ7IXPOhLFXNsH/GtRfh?=
 =?us-ascii?Q?QtBQMZWFs6j/LrKUGh5+IkrqNS7kWDz1Pn54TOAf/VKClyDjswVNisqrxZCG?=
 =?us-ascii?Q?PazGm6N0C6zBSomkuTVkH+cwBkCKX/VsYrc8XpVdLU7la/CtKZBnw3OCqu/7?=
 =?us-ascii?Q?0/2UbvzRTlAYpvaex/rFdZpTPIiloXXvhASmpJGJuXzv+tqsz9D/6JilwMKl?=
 =?us-ascii?Q?QZf3uzUn6XJDcBFx4zc3tobgo+gHAuslrQNmPL7a76TDXABQj/UrtDbqUsSy?=
 =?us-ascii?Q?JHfYPDcdFU6ya0wv2Ba9bH8xA25RdoiSKSPZEUQObddxyTrzFZrh/OGmjzhN?=
 =?us-ascii?Q?tPad1Wb7INck7EM9uDuZ?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 997d6efb-69bd-428e-12bb-08dc4f949427
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2024 02:04:34.0594
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR20MB5151

The DMA IP of Sophgo CV18XX/SG200X is based on a DW AXI CORE, with
an additional channel remap register located in the top system control
area. The DMA channel is exclusive to each core.

In addition, the DMA multiplexer is a subdevice of system controller,
so this binding only contains necessary properties for the multiplexer
itself.

Add the dmamux binding for CV18XX/SG200X series SoC.

Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
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


