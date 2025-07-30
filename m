Return-Path: <dmaengine+bounces-5888-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 29F12B157A2
	for <lists+dmaengine@lfdr.de>; Wed, 30 Jul 2025 04:56:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 218D75470B4
	for <lists+dmaengine@lfdr.de>; Wed, 30 Jul 2025 02:56:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CD6F1ADC83;
	Wed, 30 Jul 2025 02:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maxlinear.com header.i=@maxlinear.com header.b="3S7fjpc4"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2073.outbound.protection.outlook.com [40.107.102.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB21C2260C
	for <dmaengine@vger.kernel.org>; Wed, 30 Jul 2025 02:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753844184; cv=fail; b=U1z0Q2mYtO97kOu4iOV8+FHIbG0mKUH3sxVH8rhWN/u33WpOsah6KxMgGmEzfXFIcmlAPvjY9+kbGIGyEvallI/OLnJCdIxXMrAmqtjytMLFiCWCcdTKTHV+3yN9lU/MeyH8TRCGL1VMMzHFhvhcNxPsjbHS14ax+OHUkc6auKw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753844184; c=relaxed/simple;
	bh=TzybDSFCgHUPJMVvZwiNIUKaG5OWx9b3F4xMGwGPl9I=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=EV6AGu74tuP4+t6nZfSQWasdyFMVxTyjbyzqFhlvaknbEZ7hQMU3nZzz4fJhT46ZZu8EfCj6B68+yhIZLlvc8YTjr887NKDeh1y6ybtdDsEiEnJVdIhTG752ORv4wXVWaMK6CBwhJNHbhG8D0W6zRZMR4nUybCq2AAlysrPMZ8w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=maxlinear.com; spf=pass smtp.mailfrom=maxlinear.com; dkim=pass (2048-bit key) header.d=maxlinear.com header.i=@maxlinear.com header.b=3S7fjpc4; arc=fail smtp.client-ip=40.107.102.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=maxlinear.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maxlinear.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JYB4IXtxAugjWiKZy3Xf59T+Qpx3yT2xhNqeKoaxNWJkvzUUx/FEbDe52w64qEkAgflIakNfyLwO0OgVs4mCKjAKPUtVLAbWaxgoypokEcFb2mX3onW8N7HDYbIWpRzQh/yT1Abk/D+IQs5gaICUjF9rng1E4ORZtp+VNB6giuG9X8jBS4F+CdtNi0Po1oXoNgPmLFYZZjZgKnYVZ++plfjOUDvhsRFLUT0UTbBxyEQV1Tf1+Ywk9Pr9aaNVBdhvXXE9kPR0s4sbp+pKTURJMze+Vt6CnGk3ALGainsUyoSeaEYk1JP4AyysV6R+4X2pwyPrv14kwHAIo/6RpP5tCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WgZuQRcGWIQPbrAa55iX+vEvvDwHyv7n5dwDpc53x+w=;
 b=eqLjOTGVeEevQ9CvSlN8Uc9IE0Kp862pc34zB2syIxycxQomqDPG7J91cG6pNTFSdDH1FrEo2S+urRXhXLJYncrHDppBqQZZi0dEI6OgK4FZj2z4Y+mitF/y3LqXhIN7GAcHNCzgy2NYY3IeoKzUcJjFwk2EhKqMxM52mmgdDhRzYL45iTLZFrlGe5Xy/Yirz70TQuxo4uo/MgC+N+3U5FNnP9MYOjSKITNTR/A5+jQCLqKdZSJtvR8cBQXpTv+S3pgIsb24VpwyzC0sX/uoGyvlwdPIYEh8M29TUulp6HNRHYI1ZtzbtK6RDPahk8pPYJe5UL2bIfblpJgBsUezug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 174.47.1.83) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=maxlinear.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=maxlinear.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maxlinear.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WgZuQRcGWIQPbrAa55iX+vEvvDwHyv7n5dwDpc53x+w=;
 b=3S7fjpc4bM3tbaUsCBxBghiwJNxHyVez5bTW3d+fFboe59L4YwdST+7rA9XEKN1jIX3yZuwCjp8ZZyx9R+697I1+QRQ12KAYkaITzfbgqb52oYlWurU6h1RCjHGL6iM86Io01FnZ2TGgvKuK9XmFdiLV/uRxm2iFXiB+HtZVMLI9e4czRWdBfLTOmsS3qlSqFLuRp5pAmhC+iyEQnpeqAjeYMf1fkgHxUMiBJA/9WCRalVgbO87fERdNEbl7yWObjGuToIUz1LRFqCv6E0OuEugJ6ieFlM2ZDfMon70YAcx2Scr/V+YJOVVbeytrWANLGHaDt2dKzLoOUtaBl0yL8w==
Received: from CY5P221CA0074.NAMP221.PROD.OUTLOOK.COM (2603:10b6:930:9::11) by
 PH8PR19MB7024.namprd19.prod.outlook.com (2603:10b6:510:224::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.22; Wed, 30 Jul
 2025 02:56:14 +0000
Received: from CY4PEPF0000FCC5.namprd03.prod.outlook.com
 (2603:10b6:930:9:cafe::56) by CY5P221CA0074.outlook.office365.com
 (2603:10b6:930:9::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.33 via Frontend Transport; Wed,
 30 Jul 2025 02:56:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 174.47.1.83)
 smtp.mailfrom=maxlinear.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=maxlinear.com;
Received-SPF: Pass (protection.outlook.com: domain of maxlinear.com designates
 174.47.1.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=174.47.1.83; helo=usmxlcas.maxlinear.com; pr=C
Received: from usmxlcas.maxlinear.com (174.47.1.83) by
 CY4PEPF0000FCC5.mail.protection.outlook.com (10.167.242.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.8989.10 via Frontend Transport; Wed, 30 Jul 2025 02:56:14 +0000
Received: from sgb015.sgsw.maxlinear.com (10.23.238.15) by mail.maxlinear.com
 (10.23.38.120) with Microsoft SMTP Server id 15.1.2507.39; Tue, 29 Jul 2025
 19:56:12 -0700
From: Zhu Yixin <yzhu@maxlinear.com>
To: <dmaengine@vger.kernel.org>, <vkoul@kernel.org>
CC: <jchng@maxlinear.com>, <sureshnagaraj@maxlinear.com>, Zhu Yixin
	<yzhu@maxlinear.com>
Subject: [PATCH 1/5] dmaengine: lgm-dma: Move platfrom data to device tree
Date: Wed, 30 Jul 2025 10:45:43 +0800
Message-ID: <20250730024547.3160871-1-yzhu@maxlinear.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC5:EE_|PH8PR19MB7024:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c42aefe-27a3-45d1-7e14-08ddcf14a5d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Cep/4RV9nBwYNCY9V9Seu9lXDzOwWwE08apgwcug/iFp4DpaLM0nI6LG3ks5?=
 =?us-ascii?Q?Tc/cw5K6049293g9d/y9YA9HZC/1xzZEgyxfQbSNr6/V3XcRCMP/eKLSzPbc?=
 =?us-ascii?Q?slslHjd/dxU/USQkUpkqnRhXdbxvaWb5LGi/5zmh5vpqLAbcqqveEhAfTORE?=
 =?us-ascii?Q?ATze/b6boVNF9zdLqpjfOCeTRH3D8sbK/yn4KeS517DnE8NKpPCsx1CAsg4n?=
 =?us-ascii?Q?4L6mo2oBqRNbuzRaL2HURfQzz6NO78OQ7QcIR+nIKFqHbUTnLVWiEpbo8Zzn?=
 =?us-ascii?Q?N03PhDuAoSJvHCYhHlSicz17rFkb+JHpnPfpyYw2YZPnkBzKejhBZc9pkihk?=
 =?us-ascii?Q?p3s1QNl1ycCvCvgVCgWdBux6RPtuPobZJCH5E/qYStOp3yA9kQGjj5DBZTHb?=
 =?us-ascii?Q?tGn+U+C61gNHaIHefxHnO7EcaYjhd92tllPyYJe4uUE4L8aVAECabwSup2nN?=
 =?us-ascii?Q?Yl3qiGUwOtwp3Kbci/Xr+adAnnwflkjTaKUBRygNqzlp7GjGuYvZe+tWx0vb?=
 =?us-ascii?Q?O2CA5yPvSn1jmZkx4LaI49E/B8ONSZ/b+SKrPKSGfccbdTjUJONyVccICgli?=
 =?us-ascii?Q?MonpxqNjkcsIBuZXkKsqRT1O/ZiJvMXeNPdqoJH1aq1bn8HEgZJY6LWdmDaS?=
 =?us-ascii?Q?2a60YoyNv5xbGuvcI4tAAP9iN04exOVrFANvcCSLiEPGW4JjhV9MxW9pykwM?=
 =?us-ascii?Q?VCf6ZWdPPACwE08x4GeXCI9/VYGQKxzeNLYRDtayWZdC9fR7tzCq/N2clkYp?=
 =?us-ascii?Q?zU6qr6XA4Ou50/zWb+hhBDbfsyRu8H3b8cPHzdB+9QXFZmVWNDfFAOenZyby?=
 =?us-ascii?Q?KT+sWXyS4KkJx2OO2ubyfp5NwLqddkc83cs511nF+sCHiq1kl9MpMIfB7PTT?=
 =?us-ascii?Q?B54S0mHW6AKDa8Ekmn04HdNiXz5NylQYjejArnjrzTcJlvh96brUuIp5IFFZ?=
 =?us-ascii?Q?gwX8ujNtCGOnND+u7j/Ag0Xwf6CdM2c722f+48Kd15+cauEe96rfqep8+2a1?=
 =?us-ascii?Q?7BCCEJw7s4DC/mIQUaNmmO5diGMb+fOoKZT4IjAhev7RcLR0YmhE7RNwbjO4?=
 =?us-ascii?Q?WPWt4eSa9V+ktzo5mNrG4cir2+GNBVw+dpkZz+63sI2eC/SsgVelZXOq/TwV?=
 =?us-ascii?Q?Ch8MCB5+qxVPTSuZQvnlqgPRvH16FtTv1ZdvX/pWWXdOkKW8MIT45tUOQoyW?=
 =?us-ascii?Q?CNB8cTNqW2Q+4WVI7euh6KC97VRINT6HYrhY9Y9rspPRaYY4lV1HPHYOVroF?=
 =?us-ascii?Q?r5+9BX5qWpcd0WgbcdHhkDvSEWQcGhad49yQNPlb6gRm0T2PAxwMj/Ge/aCy?=
 =?us-ascii?Q?KRR1ZmbFfHhkxiCwz1Gk5EmgLpCgF2R/FV+1jNLMOeIXFswvBHSgF2okh0m3?=
 =?us-ascii?Q?RPQ3bnIh+dIrJoYWtZjAnLh8aZlladl48b0TTztzcxLalZAtMxmOkTGFsF6C?=
 =?us-ascii?Q?+Lf9SRN49VxnfCPQNtBuE7ZgAoPWv+UP6QfFk3E10sklDpsQM+0K0Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:174.47.1.83;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:usmxlcas.maxlinear.com;PTR:174-47-1-83.static.ctl.one;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: maxlinear.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2025 02:56:14.4231
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c42aefe-27a3-45d1-7e14-08ddcf14a5d6
X-MS-Exchange-CrossTenant-Id: dac28005-13e0-41b8-8280-7663835f2b1d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=dac28005-13e0-41b8-8280-7663835f2b1d;Ip=[174.47.1.83];Helo=[usmxlcas.maxlinear.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCC5.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR19MB7024

Remove platform data and unified the setting from device tree.

Signed-off-by: Zhu Yixin <yzhu@maxlinear.com>
---
 .../devicetree/bindings/dma/intel,ldma.yaml   |  67 ++++-
 drivers/dma/lgm/lgm-dma.c                     | 242 +++++++-----------
 2 files changed, 144 insertions(+), 165 deletions(-)

diff --git a/Documentation/devicetree/bindings/dma/intel,ldma.yaml b/Documentation/devicetree/bindings/dma/intel,ldma.yaml
index d6bb553a2c6f..59f928297613 100644
--- a/Documentation/devicetree/bindings/dma/intel,ldma.yaml
+++ b/Documentation/devicetree/bindings/dma/intel,ldma.yaml
@@ -7,8 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: Lightning Mountain centralized DMA controllers.
 
 maintainers:
-  - chuanhua.lei@intel.com
-  - mallikarjunax.reddy@intel.com
+  - yzhu@maxlinear.com
 
 allOf:
   - $ref: dma-controller.yaml#
@@ -16,14 +15,7 @@ allOf:
 properties:
   compatible:
     enum:
-      - intel,lgm-cdma
-      - intel,lgm-dma2tx
-      - intel,lgm-dma1rx
-      - intel,lgm-dma1tx
-      - intel,lgm-dma0tx
-      - intel,lgm-dma3
-      - intel,lgm-toe-dma30
-      - intel,lgm-toe-dma31
+      - intel,lgm-ldma
 
   reg:
     maxItems: 1
@@ -80,16 +72,62 @@ properties:
       if it is disabled, the DMA RX will still support programmable fixed burst size of 2,4,8,16.
       It only applies to RX DMA and memcopy DMA.
 
+  intel,dma-flowctrl:
+    type: boolean
+    description:
+      DMA per-channel flow control.
+
+  intel,dma-fod:
+    type: boolean
+    description:
+      DMA fetch-on-demand.
+      It should only be enabled when DMA connected to a component that can
+      provide fetch-on-demand signal to DMA.
+
+  intel,dma-desc-in-sram:
+    type: boolean
+    description:
+      DMA descriptor in sram.
+      It only affects legacy DMA(V22)
+      DMA version V31 onwards, it is always enabled and setting ignored by
+      DMA HW.
+
+  intel,dma-desc-fack:
+    type: boolean
+    description:
+      DMA descriptor fetch acknowledgement.
+      This feature only takes effects if DMA fetch-on-demand is enabled.
+
+  intel,dma-orrc:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      DMA outstanding descriptor read.
+      The maximum orrc count is 16.
+
+  intel,dma-type:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      DMA type. Only valid for DMAV31 onwards.
+      DMA type TX is 0.
+      DMA type RX is 1.
+      DMA type MCPY is 2.
+
+  intel,dma-name:
+    $ref: /schemas/types.yaml#/definitions/string
+    description:
+      Name of the DMA.
+
 required:
   - compatible
   - reg
+  - intel,dma-name
 
 additionalProperties: false
 
 examples:
   - |
     dma0: dma-controller@e0e00000 {
-      compatible = "intel,lgm-cdma";
+      compatible = "intel,lgm-ldma";
       reg = <0xe0e00000 0x1000>;
       #dma-cells = <3>;
       dma-channels = <16>;
@@ -102,10 +140,11 @@ examples:
       intel,dma-poll-cnt = <4>;
       intel,dma-byte-en;
       intel,dma-drb;
+      intel,dma-name = "dma0";
     };
   - |
     dma3: dma-controller@ec800000 {
-      compatible = "intel,lgm-dma3";
+      compatible = "intel,lgm-ldma";
       reg = <0xec800000 0x1000>;
       clocks = <&cgu0 71>;
       resets = <&rcu0 0x10 9>;
@@ -113,4 +152,8 @@ examples:
       intel,dma-poll-cnt = <16>;
       intel,dma-byte-en;
       intel,dma-dburst-wr;
+      intel,dma-type = <2>;
+      intel,dma-desc-in-sram;
+      intel,dma-name = "dma3";
+      intel,dma-orrc = <16>;
     };
diff --git a/drivers/dma/lgm/lgm-dma.c b/drivers/dma/lgm/lgm-dma.c
index 8173c3f1075a..93438cc9f020 100644
--- a/drivers/dma/lgm/lgm-dma.c
+++ b/drivers/dma/lgm/lgm-dma.c
@@ -3,6 +3,7 @@
  * Lightning Mountain centralized DMA controller driver
  *
  * Copyright (c) 2016 - 2020 Intel Corporation.
+ * Copyright (c) 2020 - 2025 Maxlinear Inc.
  */
 
 #include <linux/bitfield.h>
@@ -139,6 +140,7 @@
 #define DMA_VALID_DESC_FETCH_ACK	BIT(7)
 #define DMA_DFT_DRB			BIT(8)
 
+#define DMA_DFT_ORRC_CNT		16
 #define DMA_ORRC_MAX_CNT		(SZ_32 - 1)
 #define DMA_DFT_POLL_CNT		SZ_4
 #define DMA_DFT_BURST_V22		SZ_2
@@ -183,11 +185,17 @@ enum ldma_chan_on_off {
 };
 
 enum {
+	DMA_TYPE_INVD = -1, /* Legacy DMA does not have type */
 	DMA_TYPE_TX = 0,
 	DMA_TYPE_RX,
 	DMA_TYPE_MCPY,
 };
 
+enum {
+	DMA_IN_HW_MODE,
+	DMA_IN_SW_MODE,
+};
+
 struct ldma_dev;
 struct ldma_port;
 
@@ -218,6 +226,7 @@ struct ldma_chan {
 	struct dw2_desc_sw	*ds;
 	struct work_struct	work;
 	struct dma_slave_config config;
+	int			mode;
 };
 
 struct ldma_port {
@@ -230,17 +239,6 @@ struct ldma_port {
 	u32			pkt_drop;
 };
 
-/* Instance specific data */
-struct ldma_inst_data {
-	bool			desc_in_sram;
-	bool			chan_fc;
-	bool			desc_fod; /* Fetch On Demand */
-	bool			valid_desc_fetch_ack;
-	u32			orrc; /* Outstanding read count */
-	const char		*name;
-	u32			type;
-};
-
 struct ldma_dev {
 	struct device		*dev;
 	void __iomem		*base;
@@ -257,7 +255,9 @@ struct ldma_dev {
 	u32			channels_mask;
 	u32			flags;
 	u32			pollcnt;
-	const struct ldma_inst_data *inst;
+	u32			orrc; /* Outstanding read count */
+	int			type;
+	const char		*name;
 	struct workqueue_struct	*wq;
 };
 
@@ -349,7 +349,7 @@ static void ldma_dev_chan_flow_ctl_cfg(struct ldma_dev *d, bool enable)
 	unsigned long flags;
 	u32 mask, val;
 
-	if (d->inst->type != DMA_TYPE_TX)
+	if (d->type != DMA_TYPE_TX)
 		return;
 
 	mask = DMA_CTRL_CH_FL;
@@ -378,7 +378,7 @@ static void ldma_dev_desc_fetch_on_demand_cfg(struct ldma_dev *d, bool enable)
 	unsigned long flags;
 	u32 mask, val;
 
-	if (d->inst->type == DMA_TYPE_MCPY)
+	if (d->type == DMA_TYPE_MCPY)
 		return;
 
 	mask = DMA_CTRL_DS_FOD;
@@ -406,12 +406,12 @@ static void ldma_dev_orrc_cfg(struct ldma_dev *d)
 	u32 val = 0;
 	u32 mask;
 
-	if (d->inst->type == DMA_TYPE_RX)
+	if (d->type == DMA_TYPE_RX)
 		return;
 
 	mask = DMA_ORRC_EN | DMA_ORRC_ORRCNT;
-	if (d->inst->orrc > 0 && d->inst->orrc <= DMA_ORRC_MAX_CNT)
-		val = DMA_ORRC_EN | FIELD_PREP(DMA_ORRC_ORRCNT, d->inst->orrc);
+	if (d->orrc > 0 && d->orrc <= DMA_ORRC_MAX_CNT)
+		val = DMA_ORRC_EN | FIELD_PREP(DMA_ORRC_ORRCNT, d->orrc);
 
 	spin_lock_irqsave(&d->dev_lock, flags);
 	ldma_update_bits(d, mask, val, DMA_ORRC);
@@ -439,7 +439,7 @@ static void ldma_dev_dburst_wr_cfg(struct ldma_dev *d, bool enable)
 	unsigned long flags;
 	u32 mask, val;
 
-	if (d->inst->type != DMA_TYPE_RX && d->inst->type != DMA_TYPE_MCPY)
+	if (d->type != DMA_TYPE_RX && d->type != DMA_TYPE_MCPY)
 		return;
 
 	mask = DMA_CTRL_DBURST_WR;
@@ -455,7 +455,7 @@ static void ldma_dev_vld_fetch_ack_cfg(struct ldma_dev *d, bool enable)
 	unsigned long flags;
 	u32 mask, val;
 
-	if (d->inst->type != DMA_TYPE_TX)
+	if (d->type != DMA_TYPE_TX)
 		return;
 
 	mask = DMA_CTRL_VLD_DF_ACK;
@@ -511,7 +511,7 @@ static int ldma_dev_cfg(struct ldma_dev *d)
 	}
 
 	dev_dbg(d->dev, "%s Controller 0x%08x configuration done\n",
-		d->inst->name, readl(d->base + DMA_CTRL));
+		d->name, readl(d->base + DMA_CTRL));
 
 	return 0;
 }
@@ -578,7 +578,7 @@ static void ldma_chan_set_class(struct ldma_chan *c, u32 val)
 	struct ldma_dev *d = to_ldma_dev(c->vchan.chan.device);
 	u32 class_val;
 
-	if (d->inst->type == DMA_TYPE_MCPY || val > DMA_MAX_CLASS)
+	if (d->type == DMA_TYPE_MCPY || val > DMA_MAX_CLASS)
 		return;
 
 	/* 3 bits low */
@@ -929,26 +929,41 @@ static int ldma_parse_dt(struct ldma_dev *d)
 	if (fwnode_property_read_bool(fwnode, "intel,dma-drb"))
 		d->flags |= DMA_DFT_DRB;
 
-	if (fwnode_property_read_u32(fwnode, "intel,dma-poll-cnt",
-				     &d->pollcnt))
-		d->pollcnt = DMA_DFT_POLL_CNT;
-
-	if (d->inst->chan_fc)
+	if (fwnode_property_read_bool(fwnode, "intel,dma-flowctrl"))
 		d->flags |= DMA_CHAN_FLOW_CTL;
 
-	if (d->inst->desc_fod)
+	if (fwnode_property_read_bool(fwnode, "intel,dma-fod"))
 		d->flags |= DMA_DESC_FOD;
 
-	if (d->inst->desc_in_sram)
+	if (fwnode_property_read_bool(fwnode, "intel,dma-desc-in-sram"))
 		d->flags |= DMA_DESC_IN_SRAM;
 
-	if (d->inst->valid_desc_fetch_ack)
+	if (fwnode_property_read_bool(fwnode, "intel,dma-desc-fack"))
 		d->flags |= DMA_VALID_DESC_FETCH_ACK;
 
-	if (d->ver > DMA_VER22) {
-		if (!d->port_nrs)
-			return -EINVAL;
+	if (fwnode_property_read_u32(fwnode, "intel,dma-poll-cnt",
+				     &d->pollcnt))
+		d->pollcnt = DMA_DFT_POLL_CNT;
+
+	if (fwnode_property_read_u32(fwnode, "intel,dma-orrc",
+				     &d->orrc))
+		d->orrc = DMA_DFT_ORRC_CNT;
+
+	if (fwnode_property_read_u32(fwnode, "intel,dma-type",
+				     &d->type))
+		d->type = DMA_TYPE_INVD;
 
+	if (fwnode_property_read_u32(fwnode, "dma-channel-mask",
+				     &d->channels_mask))
+		d->channels_mask = GENMASK(d->chan_nrs - 1, 0);
+
+	if (fwnode_property_read_string(fwnode, "intel,dma-name",
+					&d->name)) {
+		dev_err(d->dev, "DMA name not available!\n");
+		return -EINVAL;
+	}
+
+	if (d->ver > DMA_VER22) {
 		for (i = 0; i < d->port_nrs; i++) {
 			p = &d->ports[i];
 			p->rxendi = DMA_DFT_ENDIAN;
@@ -1471,93 +1486,48 @@ static void ldma_clk_disable(void *data)
 	reset_control_assert(d->rst);
 }
 
-static const struct ldma_inst_data dma0 = {
-	.name = "dma0",
-	.chan_fc = false,
-	.desc_fod = false,
-	.desc_in_sram = false,
-	.valid_desc_fetch_ack = false,
-};
-
-static const struct ldma_inst_data dma2tx = {
-	.name = "dma2tx",
-	.type = DMA_TYPE_TX,
-	.orrc = 16,
-	.chan_fc = true,
-	.desc_fod = true,
-	.desc_in_sram = true,
-	.valid_desc_fetch_ack = true,
-};
+static int intel_ldma_port_channel_init(struct ldma_dev *d)
+{
+	struct ldma_chan *c;
+	struct ldma_port *p;
+	unsigned long ch_mask;
+	int i,j;
 
-static const struct ldma_inst_data dma1rx = {
-	.name = "dma1rx",
-	.type = DMA_TYPE_RX,
-	.orrc = 16,
-	.chan_fc = false,
-	.desc_fod = true,
-	.desc_in_sram = true,
-	.valid_desc_fetch_ack = false,
-};
+	/* Port Initializations */
+	d->ports = devm_kcalloc(d->dev, d->port_nrs, sizeof(*p), GFP_KERNEL);
+	if (!d->ports)
+		return -ENOMEM;
 
-static const struct ldma_inst_data dma1tx = {
-	.name = "dma1tx",
-	.type = DMA_TYPE_TX,
-	.orrc = 16,
-	.chan_fc = true,
-	.desc_fod = true,
-	.desc_in_sram = true,
-	.valid_desc_fetch_ack = true,
-};
+	/* Channels Initializations */
+	d->chans = devm_kcalloc(d->dev, d->chan_nrs, sizeof(*c), GFP_KERNEL);
+	if (!d->chans)
+		return -ENOMEM;
 
-static const struct ldma_inst_data dma0tx = {
-	.name = "dma0tx",
-	.type = DMA_TYPE_TX,
-	.orrc = 16,
-	.chan_fc = true,
-	.desc_fod = true,
-	.desc_in_sram = true,
-	.valid_desc_fetch_ack = true,
-};
+	for (i = 0; i < d->port_nrs; i++) {
+		p = &d->ports[i];
+		p->portid = i;
+		p->ldev = d;
 
-static const struct ldma_inst_data dma3 = {
-	.name = "dma3",
-	.type = DMA_TYPE_MCPY,
-	.orrc = 16,
-	.chan_fc = false,
-	.desc_fod = false,
-	.desc_in_sram = true,
-	.valid_desc_fetch_ack = false,
-};
+		p->rxendi = DMA_DFT_ENDIAN;
+		p->txendi = DMA_DFT_ENDIAN;
+		p->rxbl = DMA_DFT_BURST;
+		p->txbl = DMA_DFT_BURST;
+		p->pkt_drop = DMA_PKT_DROP_DIS;
+	}
 
-static const struct ldma_inst_data toe_dma30 = {
-	.name = "toe_dma30",
-	.type = DMA_TYPE_MCPY,
-	.orrc = 16,
-	.chan_fc = false,
-	.desc_fod = false,
-	.desc_in_sram = true,
-	.valid_desc_fetch_ack = true,
-};
+	ch_mask = (unsigned long)d->channels_mask;
+	for_each_set_bit(j, &ch_mask, d->chan_nrs) {
+		if (d->ver == DMA_VER22)
+			ldma_dma_init_v22(j, d);
+		else
+			ldma_dma_init_v3X(j, d);
+	}
 
-static const struct ldma_inst_data toe_dma31 = {
-	.name = "toe_dma31",
-	.type = DMA_TYPE_MCPY,
-	.orrc = 16,
-	.chan_fc = false,
-	.desc_fod = false,
-	.desc_in_sram = true,
-	.valid_desc_fetch_ack = true,
-};
+	return 0;
+}
 
 static const struct of_device_id intel_ldma_match[] = {
-	{ .compatible = "intel,lgm-cdma", .data = &dma0},
-	{ .compatible = "intel,lgm-dma2tx", .data = &dma2tx},
-	{ .compatible = "intel,lgm-dma1rx", .data = &dma1rx},
-	{ .compatible = "intel,lgm-dma1tx", .data = &dma1tx},
-	{ .compatible = "intel,lgm-dma0tx", .data = &dma0tx},
-	{ .compatible = "intel,lgm-dma3", .data = &dma3},
-	{ .compatible = "intel,lgm-toe-dma30", .data = &toe_dma30},
-	{ .compatible = "intel,lgm-toe-dma31", .data = &toe_dma31},
+	{ .compatible = "intel,lgm-ldma" },
 	{}
 };
 
@@ -1565,12 +1535,9 @@ static int intel_ldma_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct dma_device *dma_dev;
-	unsigned long ch_mask;
-	struct ldma_chan *c;
-	struct ldma_port *p;
 	struct ldma_dev *d;
-	u32 id, bitn = 32, j;
-	int i, ret;
+	u32 id, bitn = 32;
+	int ret;
 
 	d = devm_kzalloc(dev, sizeof(*d), GFP_KERNEL);
 	if (!d)
@@ -1579,12 +1546,6 @@ static int intel_ldma_probe(struct platform_device *pdev)
 	/* Link controller to platform device */
 	d->dev = &pdev->dev;
 
-	d->inst = device_get_match_data(dev);
-	if (!d->inst) {
-		dev_err(dev, "No device match found\n");
-		return -ENODEV;
-	}
-
 	d->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(d->base))
 		return PTR_ERR(d->base);
@@ -1627,17 +1588,18 @@ static int intel_ldma_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	ret = ldma_parse_dt(d);
+	if (ret)
+		return ret;
+
 	if (d->ver == DMA_VER22) {
 		ret = ldma_init_v22(d, pdev);
 		if (ret)
 			return ret;
 	}
 
-	ret = device_property_read_u32(dev, "dma-channel-mask", &d->channels_mask);
-	if (ret < 0)
-		d->channels_mask = GENMASK(d->chan_nrs - 1, 0);
-
 	dma_dev = &d->dma_dev;
+	dma_dev->dev = &pdev->dev;
 
 	dma_cap_zero(dma_dev->cap_mask);
 	dma_cap_set(DMA_SLAVE, dma_dev->cap_mask);
@@ -1645,33 +1607,7 @@ static int intel_ldma_probe(struct platform_device *pdev)
 	/* Channel initializations */
 	INIT_LIST_HEAD(&dma_dev->channels);
 
-	/* Port Initializations */
-	d->ports = devm_kcalloc(dev, d->port_nrs, sizeof(*p), GFP_KERNEL);
-	if (!d->ports)
-		return -ENOMEM;
-
-	/* Channels Initializations */
-	d->chans = devm_kcalloc(d->dev, d->chan_nrs, sizeof(*c), GFP_KERNEL);
-	if (!d->chans)
-		return -ENOMEM;
-
-	for (i = 0; i < d->port_nrs; i++) {
-		p = &d->ports[i];
-		p->portid = i;
-		p->ldev = d;
-	}
-
-	dma_dev->dev = &pdev->dev;
-
-	ch_mask = (unsigned long)d->channels_mask;
-	for_each_set_bit(j, &ch_mask, d->chan_nrs) {
-		if (d->ver == DMA_VER22)
-			ldma_dma_init_v22(j, d);
-		else
-			ldma_dma_init_v3X(j, d);
-	}
-
-	ret = ldma_parse_dt(d);
+	ret = intel_ldma_port_channel_init(d);
 	if (ret)
 		return ret;
 
-- 
2.43.5


