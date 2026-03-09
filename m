Return-Path: <dmaengine+bounces-9322-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id FcvvFuY/rmlfBAIAu9opvQ
	(envelope-from <dmaengine+bounces-9322-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 09 Mar 2026 04:35:02 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E06F2338A7
	for <lists+dmaengine@lfdr.de>; Mon, 09 Mar 2026 04:35:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9F982300CA0E
	for <lists+dmaengine@lfdr.de>; Mon,  9 Mar 2026 03:35:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A9F21F7569;
	Mon,  9 Mar 2026 03:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="b6F23T2A"
X-Original-To: dmaengine@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010044.outbound.protection.outlook.com [52.101.193.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F4DA7262E;
	Mon,  9 Mar 2026 03:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773027298; cv=fail; b=s7ADGvB6fDbfoS2i4vLdh8xBnNFSkZ6HJ7QxVfFWAGxf7wq8H2OH9cAFV+RYkcpQivKlnTTeV5CsGTou4lV46f6hN4jodIqYyAfU3V5EHysHr9KGZ0nfG8Z5CxC9u8NicFk8kESWvqYfsS+BMMt1gPkX+OhezhsVNngK1rUF2jk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773027298; c=relaxed/simple;
	bh=WrQuRj7S9UHKuqXNhOWsXjjqkf59lZcR+LbJbSFSK7E=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=n8e9xzYC6OeHNL4qjuWJ10BXbuc1lA9TawRqk3esPrz91TWK/HYUvgA6rc109vOFD91lfmbC88GGl41XWy2Un/cPBgunK9aSY32P2ZqWe+N0XJFUghfuUUgCzmxb1J9lV+ENHNhrNuXdU2KAeqlycOpVbeWx4p9v1hY1r7NBm70=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=b6F23T2A; arc=fail smtp.client-ip=52.101.193.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hVmx+ZjsVrqQVEH4FJ536+x3ieRFBWc8zGRrMl51Lm6SMWUzRrHjIV8l3If9Kv0SPnIkmQF7/jB4BECb7rZZ1xJDSc/MSiBxK7iI3Ax8E3be4ztQRdQo1Qok78y5Nc8hL6X6VJAAF4mHMeVWY0seJI82egxRFBOqPLlTwg+EZICUmyZf0jewWDT+wPCGZrjjkLb3m4TAjplehXWk7yejBUGqQ4evueyMZZzn+N9SyeiWws5Ou2k9i2tjMTkpQsfNtsXAXvZbT1HHeWd1ALlR9e+laCYC+9dufzQpR8gbK/8tbWw7+y759XJullZJXA26RFeY+r/ZcEWEv28UtqE9eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ROJ+RiuC5XG5w6wf8gGeMJ+O38Xsfy/6rinsMk7nJ5U=;
 b=Xb86GmQm6atkyMbA/dLhfJvjwIZbNH1OdCmT1HGRNOqTAT6wnWTizssZCBnvogqXI1U+01ZlQCaDxaMORTSDrZK+fDJ6FLlaXWAGRXtZydxygjCmJxoiIH1zi06mJofAoz0yFZ8syUMgyaJ9EaNr+Xj04O+IUIFnRXneZqoK3MrnQ206RXUXNvg5zEc5LeNzAxJyqwLhCs3YStuHSoIuUQVh46Lks2Up3nkUy6nv691OFQmh8gAnBx/TkjZbW9/c/fRyuqHxT+VGi2QdZuh6pr7vwo58y3w/x6j8aH9MWPnpEg4ohd1VTA90qm8JD9TsapOjrTfaU+NyZvMSVGz1jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ROJ+RiuC5XG5w6wf8gGeMJ+O38Xsfy/6rinsMk7nJ5U=;
 b=b6F23T2AB0L5K7QD5+g+Wt84ChRQEkXuo7t9GOLKJTTSrnBwg6VBzvCvBuKwBwtV8Es7NBMTrBu5rKNjK94TAj239eU3BT4Z+ALRwHMZ2IINfVlnyEeeLj96Mdjhh6p+Qf38uf6XQaifz4Yeg4oq0s3HBDZu1O6FJatLNJDaQ/Y=
Received: from CH0PR03CA0084.namprd03.prod.outlook.com (2603:10b6:610:cc::29)
 by BN7PPF39B20C1D8.namprd12.prod.outlook.com (2603:10b6:40f:fc02::6cc) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.7; Mon, 9 Mar
 2026 03:34:50 +0000
Received: from CH1PEPF0000AD78.namprd04.prod.outlook.com
 (2603:10b6:610:cc:cafe::4f) by CH0PR03CA0084.outlook.office365.com
 (2603:10b6:610:cc::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.24 via Frontend Transport; Mon,
 9 Mar 2026 03:34:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000AD78.mail.protection.outlook.com (10.167.244.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Mon, 9 Mar 2026 03:34:50 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Sun, 8 Mar
 2026 22:34:49 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 8 Mar
 2026 22:34:47 -0500
Received: from xhdsuragupt40.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Sun, 8 Mar 2026 22:34:44 -0500
From: Abin Joseph <abin.joseph@amd.com>
To: <vkoul@kernel.org>, <Frank.Li@kernel.org>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <michal.simek@amd.com>,
	<radhey.shyam.pandey@amd.com>
CC: <git@amd.com>, <abin.joseph@amd.com>, <dmaengine@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v5] dt-bindings: dma: xlnx,axi-dma: Convert to DT schema
Date: Mon, 9 Mar 2026 09:04:44 +0530
Message-ID: <20260309033444.3472359-1-abin.joseph@amd.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: abin.joseph@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD78:EE_|BN7PPF39B20C1D8:EE_
X-MS-Office365-Filtering-Correlation-Id: fff7f963-1de2-48dd-accf-08de7d8cd1d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|376014|1800799024|13003099007;
X-Microsoft-Antispam-Message-Info:
	Tu/5L2np0rC7HAxagICZZdeadMkmxQgM+YHdUZQ/KrVaD1nKZ446Y7tsmlEzoTaCrATq6e17Q4kurY0MrZytUujT+DK/8+6icyxCAczNurtBTLZhvBC/aUbr96AiLlW4kSQIzPpnRGcv2CMFncmc06+qp356RuoKJXneCOymf5aMAOCZxaif3K9S+Ul9NHSrtB8WbPJ7qS+nfntUmowx03pL3A7Niug8qM57jvf+DysslEnmqijpQ2mreqKDiqYVDa76f0bWCoid6Bqcx609FRtXThggeV8Yu8+uWjSq5DamOTr+2wopBZrq62rs6hKznrHrMpuO08dRJa1lpPdBnuhWr6jbEyD9PfJLX8vYt7W7DoG8DwSt6dwxd3gW3+GwU7lZjtu/sxZWt2YkS781Gjz9tP4QSuVmnFYsOmRufIXYrwOkgRpX4WW6w4x8Gs8HLy4CBKewgtYk0yvAIWcTh3XPLgjnKDfIXErN4j7nzIMmT8H6AhfFlR88F0khoREpJVTTUtcerdpD1vzGpOC4g6kd6cmqNmDlLYbkZQJCIzx3/wTaK8hdKxs2kUB72YEBKiTsSliMCsjbspfWsbGcMEdR3fAGy+iMteY8tHzv9LzQ9Ue1zmrMrgozdqjuK4o+t6ksUhQRZMkrbKxGWi1Ww6oUqJYZlozCtVtkHSQGpY5DLm+pv1IT25VGFp6HLUml4GnPKr7tP9bIL00cV6la1FE225AP9d2HQYreUMIzM2k=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(376014)(1800799024)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	qrG/1cPvHoL/PMRu2K9+UG0dEjm1hq8sW1H44N+Ai+TsXtEbyFrGhTgU/WZFBznCwlew9ryhQegaGLs9rgzgcOeBwTCoyA/0K+7k3nZAqAeuz+QQB7AlL3isDjdm8r/MlpOrLLIlQl4Psjx5oK+zuJ+Eg96IltWpD/85xPcHaC6dNrHOgmHd5zxVm1sjG4J7K6wo1hv6T9Mhx3wh6ZCXVeOFv3m7NGPlGGptf6OtQmd9sxnJN31d5IjMWoXeysogQglPszFtnJcNcq56LzDarMBThTccKBsBYjHOJJVfsj2bPXejUEWbZpPdiHBZwKxyBFxR5+LeUzYQXPk34bL3G4KsHJEwdnerpUNfCTjtH6RPio/7s0XhE1LKOJSAxD6LQEPL68jElP2opTu4ye9+RBPpQZBGtwgh1/Ru+qWAJiFxPLR2Pm1aFbk40x5vUAkX
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2026 03:34:50.1721
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fff7f963-1de2-48dd-accf-08de7d8cd1d1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD78.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF39B20C1D8
X-Rspamd-Queue-Id: 9E06F2338A7
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-9322-lists,dmaengine=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[13];
	FROM_NEQ_ENVFROM(0.00)[abin.joseph@amd.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.993];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Action: no action

Convert the bindings document for Xilinx DMA.
No changes to existing binding description.

Signed-off-by: Abin Joseph <abin.joseph@amd.com>
---

v5:
-> Use > instead of | for description
-> Use unevaluatedProperties: false because ref to dma-controller.yaml
-> Reorder the properties in the example

v4:
-> Fix the dt_binding_check error

v3:
-> Update the subject heading
-> Remove examples for cdma and mcdma
-> Fix the syntax issue for the clocks
-> Squash the interrupt use case for axistream
connected cases.
-> Reorder the list as per the writing bindings

v2:
-> Add examples for each compatible
-> Remove the note added
-> Use 'enum' rather than 'anyOf' and 'const'
-> Wrap 80 char per line for descriptions Add dma-controller yaml 
-> reference Add -| for paragraph separation Remove labels from the 
-> examples

---
 .../bindings/dma/xilinx/xilinx_dma.txt        | 111 -------
 .../bindings/dma/xilinx/xlnx,axi-dma.yaml     | 299 ++++++++++++++++++
 2 files changed, 299 insertions(+), 111 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt
 create mode 100644 Documentation/devicetree/bindings/dma/xilinx/xlnx,axi-dma.yaml

diff --git a/Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt b/Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt
deleted file mode 100644
index b567107270cb..000000000000
--- a/Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt
+++ /dev/null
@@ -1,111 +0,0 @@
-Xilinx AXI VDMA engine, it does transfers between memory and video devices.
-It can be configured to have one channel or two channels. If configured
-as two channels, one is to transmit to the video device and another is
-to receive from the video device.
-
-Xilinx AXI DMA engine, it does transfers between memory and AXI4 stream
-target devices. It can be configured to have one channel or two channels.
-If configured as two channels, one is to transmit to the device and another
-is to receive from the device.
-
-Xilinx AXI CDMA engine, it does transfers between memory-mapped source
-address and a memory-mapped destination address.
-
-Xilinx AXI MCDMA engine, it does transfer between memory and AXI4 stream
-target devices. It can be configured to have up to 16 independent transmit
-and receive channels.
-
-Required properties:
-- compatible: Should be one of-
-		"xlnx,axi-vdma-1.00.a"
-		"xlnx,axi-dma-1.00.a"
-		"xlnx,axi-cdma-1.00.a"
-		"xlnx,axi-mcdma-1.00.a"
-- #dma-cells: Should be <1>, see "dmas" property below
-- reg: Should contain VDMA registers location and length.
-- xlnx,addrwidth: Should be the vdma addressing size in bits(ex: 32 bits).
-- dma-ranges: Should be as the following <dma_addr cpu_addr max_len>.
-- dma-channel child node: Should have at least one channel and can have up to
-	two channels per device. This node specifies the properties of each
-	DMA channel (see child node properties below).
-- clocks: Input clock specifier. Refer to common clock bindings.
-- clock-names: List of input clocks
-	For VDMA:
-	Required elements: "s_axi_lite_aclk"
-	Optional elements: "m_axi_mm2s_aclk" "m_axi_s2mm_aclk",
-			   "m_axis_mm2s_aclk", "s_axis_s2mm_aclk"
-	For CDMA:
-	Required elements: "s_axi_lite_aclk", "m_axi_aclk"
-	For AXIDMA and MCDMA:
-	Required elements: "s_axi_lite_aclk"
-	Optional elements: "m_axi_mm2s_aclk", "m_axi_s2mm_aclk",
-			   "m_axi_sg_aclk"
-
-Required properties for VDMA:
-- xlnx,num-fstores: Should be the number of framebuffers as configured in h/w.
-
-Optional properties for AXI DMA and MCDMA:
-- xlnx,sg-length-width: Should be set to the width in bits of the length
-	register as configured in h/w. Takes values {8...26}. If the property
-	is missing or invalid then the default value 23 is used. This is the
-	maximum value that is supported by all IP versions.
-
-Optional properties for AXI DMA:
-- xlnx,axistream-connected: Tells whether DMA is connected to AXI stream IP.
-- xlnx,irq-delay: Tells the interrupt delay timeout value. Valid range is from
-	0-255. Setting this value to zero disables the delay timer interrupt.
-	1 timeout interval = 125 * clock period of SG clock.
-Optional properties for VDMA:
-- xlnx,flush-fsync: Tells which channel to Flush on Frame sync.
-	It takes following values:
-	{1}, flush both channels
-	{2}, flush mm2s channel
-	{3}, flush s2mm channel
-
-Required child node properties:
-- compatible:
-	For VDMA: It should be either "xlnx,axi-vdma-mm2s-channel" or
-	"xlnx,axi-vdma-s2mm-channel".
-	For CDMA: It should be "xlnx,axi-cdma-channel".
-	For AXIDMA and MCDMA: It should be either "xlnx,axi-dma-mm2s-channel"
-	or "xlnx,axi-dma-s2mm-channel".
-- interrupts: Should contain per channel VDMA interrupts.
-- xlnx,datawidth: Should contain the stream data width, take values
-	{32,64...1024}.
-
-Optional child node properties:
-- xlnx,include-dre: Tells hardware is configured for Data
-	Realignment Engine.
-Optional child node properties for VDMA:
-- xlnx,genlock-mode: Tells Genlock synchronization is
-	enabled/disabled in hardware.
-- xlnx,enable-vert-flip: Tells vertical flip is
-	enabled/disabled in hardware(S2MM path).
-Optional child node properties for MCDMA:
-- dma-channels: Number of dma channels in child node.
-
-Example:
-++++++++
-
-axi_vdma_0: axivdma@40030000 {
-	compatible = "xlnx,axi-vdma-1.00.a";
-	#dma_cells = <1>;
-	reg = < 0x40030000 0x10000 >;
-	dma-ranges = <0x00000000 0x00000000 0x40000000>;
-	xlnx,num-fstores = <0x8>;
-	xlnx,flush-fsync = <0x1>;
-	xlnx,addrwidth = <0x20>;
-	clocks = <&clk 0>, <&clk 1>, <&clk 2>, <&clk 3>, <&clk 4>;
-	clock-names = "s_axi_lite_aclk", "m_axi_mm2s_aclk", "m_axi_s2mm_aclk",
-		      "m_axis_mm2s_aclk", "s_axis_s2mm_aclk";
-	dma-channel@40030000 {
-		compatible = "xlnx,axi-vdma-mm2s-channel";
-		interrupts = < 0 54 4 >;
-		xlnx,datawidth = <0x40>;
-	} ;
-	dma-channel@40030030 {
-		compatible = "xlnx,axi-vdma-s2mm-channel";
-		interrupts = < 0 53 4 >;
-		xlnx,datawidth = <0x40>;
-	} ;
-} ;
diff --git a/Documentation/devicetree/bindings/dma/xilinx/xlnx,axi-dma.yaml b/Documentation/devicetree/bindings/dma/xilinx/xlnx,axi-dma.yaml
new file mode 100644
index 000000000000..340ae9e91cb0
--- /dev/null
+++ b/Documentation/devicetree/bindings/dma/xilinx/xlnx,axi-dma.yaml
@@ -0,0 +1,299 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/dma/xilinx/xlnx,axi-dma.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Xilinx AXI VDMA, DMA, CDMA and MCDMA IP
+
+maintainers:
+  - Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
+  - Abin Joseph <abin.joseph@amd.com>
+
+description: >
+  Xilinx AXI VDMA engine, it does transfers between memory and video devices.
+  It can be configured to have one channel or two channels. If configured
+  as two channels, one is to transmit to the video device and another is
+  to receive from the video device.
+
+  Xilinx AXI DMA engine, it does transfers between memory and AXI4 stream
+  target devices. It can be configured to have one channel or two channels.
+  If configured as two channels, one is to transmit to the device and another
+  is to receive from the device.
+
+  Xilinx AXI CDMA engine, it does transfers between memory-mapped source
+  address and a memory-mapped destination address.
+
+  Xilinx AXI MCDMA engine, it does transfer between memory and AXI4 stream
+  target devices. It can be configured to have up to 16 independent transmit
+  and receive channels.
+
+properties:
+  compatible:
+    enum:
+      - xlnx,axi-cdma-1.00.a
+      - xlnx,axi-dma-1.00.a
+      - xlnx,axi-mcdma-1.00.a
+      - xlnx,axi-vdma-1.00.a
+
+  reg:
+    maxItems: 1
+
+  "#dma-cells":
+    const: 1
+
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 1
+
+  interrupts:
+    items:
+      - description: Interrupt for single channel (MM2S or S2MM)
+      - description: Interrupt for dual channel configuration
+    minItems: 1
+    description:
+      Interrupt lines for the DMA controller. Only used when
+      xlnx,axistream-connected is present (DMA connected to AXI Stream
+      IP). When child dma-channel nodes are present, interrupts are
+      specified in the child nodes instead.
+
+  clocks:
+    minItems: 1
+    maxItems: 5
+
+  clock-names:
+    minItems: 1
+    maxItems: 5
+
+  dma-ranges: true
+
+  xlnx,addrwidth:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [32, 64]
+    description: The DMA addressing size in bits.
+
+  xlnx,num-fstores:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 1
+    maximum: 32
+    description: Should be the number of framebuffers as configured in h/w.
+
+  xlnx,flush-fsync:
+    type: boolean
+    description: Tells which channel to Flush on Frame sync.
+
+  xlnx,sg-length-width:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 8
+    maximum: 26
+    default: 23
+    description:
+      Width in bits of the length register as configured in hardware.
+
+  xlnx,irq-delay:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 0
+    maximum: 255
+    description:
+      Tells the interrupt delay timeout value. Valid range is from 0-255.
+      Setting this value to zero disables the delay timer interrupt.
+      1 timeout interval = 125 * clock period of SG clock.
+
+  xlnx,axistream-connected:
+    type: boolean
+    description: Tells whether DMA is connected to AXI stream IP.
+
+patternProperties:
+  "^dma-channel(-mm2s|-s2mm)?$":
+    type: object
+    description:
+      Should have at least one channel and can have up to two channels per
+      device. This node specifies the properties of each DMA channel.
+
+    properties:
+      compatible:
+        enum:
+          - xlnx,axi-vdma-mm2s-channel
+          - xlnx,axi-vdma-s2mm-channel
+          - xlnx,axi-cdma-channel
+          - xlnx,axi-dma-mm2s-channel
+          - xlnx,axi-dma-s2mm-channel
+
+      interrupts:
+        maxItems: 1
+
+      xlnx,datawidth:
+        $ref: /schemas/types.yaml#/definitions/uint32
+        enum: [32, 64, 128, 256, 512, 1024]
+        description: Should contain the stream data width, take values {32,64...1024}.
+
+      xlnx,include-dre:
+        type: boolean
+        description: Tells hardware is configured for Data Realignment Engine.
+
+      xlnx,genlock-mode:
+        type: boolean
+        description: Tells Genlock synchronization is enabled/disabled in hardware.
+
+      xlnx,enable-vert-flip:
+        type: boolean
+        description:
+          Tells vertical flip is enabled/disabled in hardware(S2MM path).
+
+      dma-channels:
+        $ref: /schemas/types.yaml#/definitions/uint32
+        description: Number of dma channels in child node.
+
+    required:
+      - compatible
+      - interrupts
+      - xlnx,datawidth
+
+    additionalProperties: false
+
+allOf:
+  - $ref: ../dma-controller.yaml#
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: xlnx,axi-vdma-1.00.a
+    then:
+      properties:
+        clock-names:
+          items:
+            - const: s_axi_lite_aclk
+            - const: m_axi_mm2s_aclk
+            - const: m_axi_s2mm_aclk
+            - const: m_axis_mm2s_aclk
+            - const: s_axis_s2mm_aclk
+          minItems: 1
+        interrupts: false
+      patternProperties:
+        "^dma-channel(-mm2s|-s2mm)?$":
+          properties:
+            compatible:
+              enum:
+                - xlnx,axi-vdma-mm2s-channel
+                - xlnx,axi-vdma-s2mm-channel
+      required:
+        - xlnx,num-fstores
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: xlnx,axi-cdma-1.00.a
+    then:
+      properties:
+        clock-names:
+          items:
+            - const: s_axi_lite_aclk
+            - const: m_axi_aclk
+        interrupts: false
+      patternProperties:
+        "^dma-channel(-mm2s|-s2mm)?$":
+          properties:
+            compatible:
+              enum:
+                - xlnx,axi-cdma-channel
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - xlnx,axi-dma-1.00.a
+              - xlnx,axi-mcdma-1.00.a
+    then:
+      properties:
+        clock-names:
+          items:
+            - const: s_axi_lite_aclk
+            - const: m_axi_mm2s_aclk
+            - const: m_axi_s2mm_aclk
+            - const: m_axi_sg_aclk
+          minItems: 1
+      patternProperties:
+        "^dma-channel(-mm2s|-s2mm)?(@[0-9a-f]+)?$":
+          properties:
+            compatible:
+              enum:
+                - xlnx,axi-dma-mm2s-channel
+                - xlnx,axi-dma-s2mm-channel
+
+required:
+  - "#dma-cells"
+  - reg
+  - xlnx,addrwidth
+  - dma-ranges
+  - clocks
+  - clock-names
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    dma-controller@40030000 {
+        compatible = "xlnx,axi-vdma-1.00.a";
+        reg = <0x40030000 0x10000>;
+        #dma-cells = <1>;
+        #address-cells = <1>;
+        #size-cells = <1>;
+        dma-ranges = <0x0 0x0 0x40000000>;
+        clocks = <&clk 0>, <&clk 1>, <&clk 2>, <&clk 3>, <&clk 4>;
+        clock-names = "s_axi_lite_aclk", "m_axi_mm2s_aclk",
+                      "m_axi_s2mm_aclk", "m_axis_mm2s_aclk",
+                      "s_axis_s2mm_aclk";
+        xlnx,num-fstores = <8>;
+        xlnx,flush-fsync;
+        xlnx,addrwidth = <32>;
+
+        dma-channel-mm2s {
+            compatible = "xlnx,axi-vdma-mm2s-channel";
+            interrupts = <GIC_SPI 54 IRQ_TYPE_LEVEL_HIGH>;
+            xlnx,datawidth = <64>;
+        };
+
+        dma-channel-s2mm {
+            compatible = "xlnx,axi-vdma-s2mm-channel";
+            interrupts = <GIC_SPI 53 IRQ_TYPE_LEVEL_HIGH>;
+            xlnx,datawidth = <64>;
+        };
+    };
+
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    dma-controller@a4030000 {
+        compatible = "xlnx,axi-dma-1.00.a";
+        reg = <0xa4030000 0x10000>;
+        #dma-cells = <1>;
+        #address-cells = <1>;
+        #size-cells = <1>;
+        dma-ranges = <0x0 0x0 0x40000000>;
+        clocks = <&clk 0>, <&clk 1>, <&clk 2>, <&clk 3>;
+        clock-names = "s_axi_lite_aclk", "m_axi_mm2s_aclk",
+                      "m_axi_s2mm_aclk", "m_axi_sg_aclk";
+        xlnx,addrwidth = <32>;
+        xlnx,sg-length-width = <14>;
+
+        dma-channel-mm2s {
+            compatible = "xlnx,axi-dma-mm2s-channel";
+            interrupts = <GIC_SPI 86 IRQ_TYPE_LEVEL_HIGH>;
+            xlnx,datawidth = <64>;
+            xlnx,include-dre;
+        };
+
+        dma-channel-s2mm {
+            compatible = "xlnx,axi-dma-s2mm-channel";
+            interrupts = <GIC_SPI 87 IRQ_TYPE_LEVEL_HIGH>;
+            xlnx,datawidth = <64>;
+            xlnx,include-dre;
+        };
+    };
-- 
2.43.0


