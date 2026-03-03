Return-Path: <dmaengine+bounces-9215-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eC5fGNjRpmnHWgAAu9opvQ
	(envelope-from <dmaengine+bounces-9215-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 03 Mar 2026 13:19:36 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 93F211EF42A
	for <lists+dmaengine@lfdr.de>; Tue, 03 Mar 2026 13:19:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0F6DE33F0274
	for <lists+dmaengine@lfdr.de>; Tue,  3 Mar 2026 11:45:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00B244279E9;
	Tue,  3 Mar 2026 11:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="4NBWk8sD"
X-Original-To: dmaengine@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010063.outbound.protection.outlook.com [52.101.193.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02005421EEB;
	Tue,  3 Mar 2026 11:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772538097; cv=fail; b=mf0M18ckR/TjXfFPymc+T5rslOWggwtWDQnNDWwm1awnDNFVDnVSiTWQLlLxrD2Ia6CU/G/8BqXWKw80G7i2dtONxHMr8S9qyZiZafmqBS8uv7CxEfIAjxSKad0DhClQHwH6M7lnlR0gscE5KJNMf5O1ZGs5CPbrmp2tKrXygEw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772538097; c=relaxed/simple;
	bh=TvrkLH9Z1LU0wU6A8YYEVFlE6GvMFuqNAkk23uovgVM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XIjZ9jbRLG35iXCnFgkrIzIMhwkm3QxiD0wrlwvvvdMrk+4ep6gBpEfW/K36m5kDCORxNdn11/yQdRWNuP9msP7mtmG3JoJK/i+DqPmFwvzjByNDGSyPlOxxaGJm/w4G7AstJLxQn+7x3KhOMic3mnktdequZJgw6p7t8Ova7J4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=4NBWk8sD; arc=fail smtp.client-ip=52.101.193.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MbD5AkjTnfzg7Hlhuvk6GGtkUNba3bemRJOCFEeoeZjgJlvhX7Fbg/g907TFce2kYQcktvHOu+aSIc648Oa1LiqYN7RGwfgZlTZNM+EfviWyc1KB5CHQuZjrWqixmnRf7wB9IzM0rJ/UQ6YXKqUh1YZUwsawdVu4rFxVkB3fZtFCAKVWYcpdrV59KhW3V+KG6FtyUr/RbxmEpyKtewUvRb7EaA6HEBdrUpAR+SUuFAKtaibb/ok2GLmN1tRMubNDaYZDyv9rw+vixW3qX0YyDZW5i8LpdDECqGBA9VlumIWO9vtkJ/IqTf4uCv5QKIwK8pDB8m4LMhFEe1Ye53AiEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tmw4aNujkX9BabVJBQBxJVPp+BDH2CLIv3VPUR+8DAQ=;
 b=whvs/IyzXNgf7yUe+T379XcFhMXOkCah6/vXNXypph3IpKXVO9lKy7Enhy5YSbYiRNDD9/dB4+HLjO/41nmIwf9fD5eq0d8spSqzwNJ+4ClWik6R+fbW6vz7SVwwxXxMOYLtT1ADQDNH14ZM67JSAhTnIj4aHtLM9UqyU+PmQP2EimJeAuePEKnwjZSwtaFkgFxdQoil2sjfTAVY4tSyKpmGn6Pbn634KKFAMGpRFeawE3i4ouEdR7hY+PWSGWAr0WeEySioKGwthaRVXUkXIY8aRe2NculSFdFplOwi3PQx/Nj3H4EetqRDhLWqJws5UDeOvNAc/FA4B6MCPfFyAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tmw4aNujkX9BabVJBQBxJVPp+BDH2CLIv3VPUR+8DAQ=;
 b=4NBWk8sDr5ZCkqZsC8Bb0IeKR2NA6HxKkaotjj/C3vqMshkjZr5y4gtkti6fT3k/G0tCCJ8Bl3w9bpVcl9rhRd0UYw0jSwPtryARWtRNLvq1W1YESKg+KmpyGiPJJ6SiTXoPeyknkf2bjFjsBEBgIbirhC13oRUgCpuetjXj4D8=
Received: from SJ0PR13CA0120.namprd13.prod.outlook.com (2603:10b6:a03:2c5::35)
 by PH0PR12MB7983.namprd12.prod.outlook.com (2603:10b6:510:28e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.21; Tue, 3 Mar
 2026 11:41:30 +0000
Received: from SJ1PEPF00002321.namprd03.prod.outlook.com
 (2603:10b6:a03:2c5:cafe::6) by SJ0PR13CA0120.outlook.office365.com
 (2603:10b6:a03:2c5::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9654.21 via Frontend Transport; Tue,
 3 Mar 2026 11:41:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF00002321.mail.protection.outlook.com (10.167.242.91) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.16 via Frontend Transport; Tue, 3 Mar 2026 11:41:30 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 3 Mar
 2026 05:41:28 -0600
Received: from xhdharinit40.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 3 Mar 2026 05:41:25 -0600
From: Abin Joseph <abin.joseph@amd.com>
To: <vkoul@kernel.org>, <Frank.Li@kernel.org>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <michal.simek@amd.com>,
	<radhey.shyam.pandey@amd.com>
CC: <git@amd.com>, <abin.joseph@amd.com>, <dmaengine@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v3] dt-bindings: dma: xlnx,axi-dma: Convert to DT schema
Date: Tue, 3 Mar 2026 17:11:24 +0530
Message-ID: <20260303114125.899850-1-abin.joseph@amd.com>
X-Mailer: git-send-email 2.49.1
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002321:EE_|PH0PR12MB7983:EE_
X-MS-Office365-Filtering-Correlation-Id: a29ee0c2-a3fd-45b0-3929-08de7919d01e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700013|13003099007;
X-Microsoft-Antispam-Message-Info:
	vdYvXYaZEdIxsUXB+K3QO/XOLh25bq+kiERS3RqvJvX9BwTlh3Y+Jwv90SY90PC2eGEtdgL6rt6jaCZwLconCg8hsP8gPm8l9QJwD4A6o/WEEs0QGKK1KxEntRKBxwCD1WK/7rMQWHhjx+iwAi5NhlLpyvaDCBa+bhnWFSi9fUIMGvvRgsDWCJ2rDGQVhwBCZEIPXahQr5WN/WH0e6RZqxiwypo3WcejCv1SNvS3FkcxiQwJOUqpruaiCEyTevFq4kFyiYU5GSUSvPKZidjrVzxSUA83QKt5+vmBQbJPT3NziE3qrL+UIztMViOm6+5cDvmk9MRevh2V68reXWL7YhsWlk+gz2C6uYTeoElIoWbSg06AhI2ucM/ZGzoRTaSZ6fFV+Wlaxn4bUqio599CGUPNLN5eCAVpk/Mooq1W5l3uK50Rfykx4Q+cDEDoAgSchDHhMSrB5Lcxl9RNp0NXp1PtaGqy0fgef1Vr9zlsMguiWhhlc1XCMGfPz6BCwP1Acz2AvC4cAUQtFLG+mAJqbsdbGKJLIM1YCm8ZXyFEESx1qXhCjTQcPOc1kdp2TW7p/MtGnYyOlMhoI3cLc7fyyHkPUUcaTgcOhUomAa/t5jzxzSkbcGbuurPBU3HkbMgs+hHlXB8zSHJgHAK0/KCWkp+xqIfDQDnPf/nsZBR/YUbwnPZh4goGA56QbXbEN4qOFClg1kMf1NQ6gvjnQUyIkDvczQduZEwz8dvgq9tLrW1SfCb0CGVsTVrHwR3VVFe2rnG+BF46IZAk2dIjrfa7vniKDy1Xzdy/BgZ6VkW2Z9RkzLkmMtJf3XZ65KBO37NyuOqOR5lCtGooxbaQtj5LsQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	+hkTygtLxflLdN53s8/isjDlWydgzLlxKyno4iquXmUuX0qlhq6KQBWmHUZko3hEf/RBRtkMbxAMyCokAdp7g8vt4taYRAgYu08lYWJW51r9c3otC/JxOHzC/upoyosX0XTs3Ew/xUZC8a0okBbS5f23brqyxLYbwfS8RZ/iJk57yqLdwgG6VsooKWdtU1BRRkogLU9aeh0e6fCY5eFyx8I8ofOCmMWs1cYKMqCBS45YTYNIPwSqS1eIINfmZ9zmSSr6m6JJduKEVButhP7QBsWV5erUuiwj/7fFFc9RdABxFaOPpmApI9VT3K/C3SkeTpRF6DfAgpSjjh7aIhBnd9SkmqKBH9WBy2GwDZivOYApluykRwuAEtOHXQSG/02/nTTBw3yjpAgx+pxuvw4y5v9k3f/AyKYEOmRFAM0FMxePBP0OdU3cLxzT+YrSYvVs
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2026 11:41:30.4641
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a29ee0c2-a3fd-45b0-3929-08de7919d01e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002321.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7983
X-Rspamd-Queue-Id: 93F211EF42A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9215-lists,dmaengine=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[amd.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_TWELVE(0.00)[13];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[abin.joseph@amd.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,2.98.207.78:email,2.98.207.48:email,amd.com:dkim,amd.com:email,amd.com:mid,devicetree.org:url];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Action: no action

Convert the bindings document for Xilinx DMA.
No changes to existing binding description.

Signed-off-by: Abin Joseph <abin.joseph@amd.com>
---

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
-> Wrap 80 char per line for descriptions
-> Add dma-controller yaml reference 
-> Add -| for paragraph separation
->Remove labels from the examples

---
 .../bindings/dma/xilinx/xilinx_dma.txt        | 111 -------
 .../bindings/dma/xilinx/xlnx,axi-dma.yaml     | 301 ++++++++++++++++++
 2 files changed, 301 insertions(+), 111 deletions(-)
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
index 000000000000..d87b595f31ec
--- /dev/null
+++ b/Documentation/devicetree/bindings/dma/xilinx/xlnx,axi-dma.yaml
@@ -0,0 +1,301 @@
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
+description: |
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
+          maxItems: 5
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
+          maxItems: 4
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
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    dma-controller@40030000 {
+        compatible = "xlnx,axi-vdma-1.00.a";
+        #dma-cells = <1>;
+        #address-cells = <1>;
+        #size-cells = <1>;
+        reg = <0x40030000 0x10000>;
+        dma-ranges = <0x0 0x0 0x40000000>;
+        xlnx,num-fstores = <8>;
+        xlnx,flush-fsync;
+        xlnx,addrwidth = <32>;
+        clocks = <&clk 0>, <&clk 1>, <&clk 2>, <&clk 3>, <&clk 4>;
+        clock-names = "s_axi_lite_aclk", "m_axi_mm2s_aclk",
+                      "m_axi_s2mm_aclk", "m_axis_mm2s_aclk",
+                      "s_axis_s2mm_aclk";
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
+        #dma-cells = <1>;
+        #address-cells = <1>;
+        #size-cells = <1>;
+        reg = <0xa4030000 0x10000>;
+        dma-ranges = <0x0 0x0 0x40000000>;
+        xlnx,addrwidth = <32>;
+        xlnx,sg-length-width = <14>;
+        clocks = <&clk 0>, <&clk 1>, <&clk 2>, <&clk 3>;
+        clock-names = "s_axi_lite_aclk", "m_axi_mm2s_aclk",
+                      "m_axi_s2mm_aclk", "m_axi_sg_aclk";
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
2.49.1


