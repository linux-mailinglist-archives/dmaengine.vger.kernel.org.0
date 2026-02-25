Return-Path: <dmaengine+bounces-9043-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IHipNg6FnmmGVwQAu9opvQ
	(envelope-from <dmaengine+bounces-9043-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 25 Feb 2026 06:13:50 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CF2E191D88
	for <lists+dmaengine@lfdr.de>; Wed, 25 Feb 2026 06:13:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 17E9D30CF729
	for <lists+dmaengine@lfdr.de>; Wed, 25 Feb 2026 05:11:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10D3526A1B9;
	Wed, 25 Feb 2026 05:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="lR2NLFOK"
X-Original-To: dmaengine@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012013.outbound.protection.outlook.com [40.107.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DB8129AB1D;
	Wed, 25 Feb 2026 05:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771995934; cv=fail; b=i9MygVsshQ47/tU+rOe22ca0RvKMePlt/ntIzVp3H111gWNgbXSBzTkLkqx9IzSjlAmBJgWz0Si9AmwCi5Bbc3Rcrk9K21uy2r88I0APm9uoCN9YZFCpQZDfVXk3u5SX11Ng08NqWO663AKQBgTHoAhgZeE/osBT1khJnGKTdN4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771995934; c=relaxed/simple;
	bh=thScc6aSCw+JbtM3AM41RsgqJotIlzabsXNv+VVwKVc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hXdKQjK8Bdxc8vFdFRMCk85uKQ35VzqoNKtt3jvi3FW8+92CY3PpnikxxDdxExYqCskCwn57+aLirQ77URlzlL1bb5rxMMUzDue4jPKCIoiMeFx7i4gxJ2LbMgoUaZ3fXdLBTRA77uhpsSSI8kuhlqWPeEQ1ymZ7seXgdJqX/0w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=lR2NLFOK; arc=fail smtp.client-ip=40.107.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L/7sa8iFxtu912s7zV9tdzBk8SGxfWUhGfhsNXTuI5XfmHJoMbaRta6fNE4C1O7qZCQ4yhWApDhETaq9uK2uxaco1Ma/NkBxKDEl/6C1jXe+WN8BN0NV74tJ+OKkbQxMEwWWpJ99ccJOWNNxn80NyL3kfmbVOqmXgrOaIdaSIjKZaFAfw0EaZMdcSbABjqmKzL5lxH1B5TwSZ48fPogzcpuTILE6a98bG0F2ZOYhS25TTou1Ss8hHEbPJ+FVY+YnJ8nR8sX47aJWY7gkWbg9vrWZ38T7n8uq2YqOTgK50JSuDmteVouNESDKRiGKmQqDjh4Cu1kYUWENdUEUAZb/AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fRPdf6yacBKXQ3ofOsOGVctdu1nUNnYRc+KH0UlJE5Y=;
 b=ikkKaX7zftUEWuvtBZNMVh+Jh20JZ5bqbQTGgffdib1pkACOrhWUTgKeuBLj9S6iwfJ4uwRPl5SL3gFthVxiaKD5r9ZyfTRloGNN7pKRtQvE+vlxUkYnnW9wDBC1RwCEe6t+VkrCnDGvQScwKnXhBkRB4mnvcoQLUkwxhqUD9zYKMB/X3greprVKesWeR0pVkJpb8ubI3m9cWxs8gsQhInB5XnMxvdGgcvgMXurIvphLWqAH0/CWWqkhA2Cheks1XMvDQf7KPt5Ubf3Oul8obB7NeQkcUTK/SgdTH0ZPnmvTyKCSIf8HAqTl5TjTdMbQprX4oYf+lwBdPbwBCbBqJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fRPdf6yacBKXQ3ofOsOGVctdu1nUNnYRc+KH0UlJE5Y=;
 b=lR2NLFOKo63tpjwSsmZhqoBZpbLu73p0X40GrgibYZaM0f04baviNcNQOYqd+4e6yJ64Od01K/W5CufmfggG69ghoHAloeWUnvgiBO46x09jJGYO951eL7nvmhyvAV1N/TMbpWq9E0c1kAo8QKLX710gnQwCDdFTqXhed8lDVs0=
Received: from MN2PR08CA0030.namprd08.prod.outlook.com (2603:10b6:208:239::35)
 by DS0PR12MB999105.namprd12.prod.outlook.com (2603:10b6:8:301::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Wed, 25 Feb
 2026 05:05:26 +0000
Received: from MN1PEPF0000ECD9.namprd02.prod.outlook.com
 (2603:10b6:208:239:cafe::db) by MN2PR08CA0030.outlook.office365.com
 (2603:10b6:208:239::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.23 via Frontend Transport; Wed,
 25 Feb 2026 05:05:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 MN1PEPF0000ECD9.mail.protection.outlook.com (10.167.242.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Wed, 25 Feb 2026 05:05:26 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 24 Feb
 2026 23:05:25 -0600
Received: from xhdsuragupt40.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 24 Feb 2026 23:05:22 -0600
From: Abin Joseph <abin.joseph@amd.com>
To: <vkoul@kernel.org>, <Frank.Li@kernel.org>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <michal.simek@amd.com>,
	<radhey.shyam.pandey@amd.com>
CC: <git@amd.com>, <abin.joseph@amd.com>, <dmaengine@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v2] dt-bindings: dmaengine: xlnx,axi-dma: Convert bindings into yaml
Date: Wed, 25 Feb 2026 10:35:21 +0530
Message-ID: <20260225050521.160724-1-abin.joseph@amd.com>
X-Mailer: git-send-email 2.25.1
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD9:EE_|DS0PR12MB999105:EE_
X-MS-Office365-Filtering-Correlation-Id: e745dc9e-6fe2-48ca-83f4-08de742b7d24
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|1800799024|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Iehf1UO0H0YnsJ8jWHDTr/+H/oTJNOLF6TTFqCoQgXgqgNeuqMPrzLxkra3j?=
 =?us-ascii?Q?uo151eCco8619KId2UAiHDrUjwVFaZyzPEV/vhBVqxU6F57dIRfx4khyG1f3?=
 =?us-ascii?Q?l3NDRpSOCPEn295yZyIZqvW8JiKalXcZIu6vI3CpXWSrWvrLMmGnpBRWBgjV?=
 =?us-ascii?Q?lNfwLsEaGlhgzDRq3GZHV2XssTpbkofSV3s4ZB1dwI8TcOFpf4mqkQZCNjOk?=
 =?us-ascii?Q?+0zakwKXMcTau69iuX1jyLa0WyRX+1cZJfr2KMdpDVj856CXsaZ9mloeqi35?=
 =?us-ascii?Q?QVfKITvIa4WA84uOoG80Gb99TdGNW1RILPRV0FvXZtth1uRQWwVRmUE74JU5?=
 =?us-ascii?Q?VH70vQdHgwi4qcL/QTGA/bs++Lxc6xFkgvFulE62rC7fBzcfYCd77JJ080Ha?=
 =?us-ascii?Q?R7wtU/zAnWLAR6dM683tiWPlcxeZo2teTLZbYYkCoVO9Kfk6oJ+p/ms04F5F?=
 =?us-ascii?Q?l0qeqxckZAdXgTv4Le5VR6TPAmCldab5jaPApiUhLLzUAI/EvvfpTFhocNFS?=
 =?us-ascii?Q?+qSTltQAplrVz8mhceL0WshuTVN5d0jI8xrNdVZiRo6oIjyAWKX2wVZJUNEl?=
 =?us-ascii?Q?J2EN/PUPfLtTA3kO+ncysAvpYbfLLZQTq/WLVOVU7QedITfoiaWzaUTy6k9+?=
 =?us-ascii?Q?1NeFPgtE2XmMrCQEEN+I1VAsfJa2qMBRLBfdNX+momgOWkVmToM8zvEV+yJP?=
 =?us-ascii?Q?Mq6KsQewfjbFGa+qCVBuTK8UQI6N9cEhsVfZ5fzptAA3/4bgQiUphndN5/IN?=
 =?us-ascii?Q?TKYSwYdF25j0fcGyQ2HZDqYyyjmQ1VWFIpW+EbNR/EZ/vzFBUhL4EMiSq7de?=
 =?us-ascii?Q?eItMsm1k6vZECpkfAmVo+bFwcmHKcO2ilHgE/YMcRC300efQLdOfjGKaKuey?=
 =?us-ascii?Q?tXL+Nt3G0mixnypNmxa7QT5lrIQ56immbYrgryYJPr7NcDd/UgocLeiPuOA2?=
 =?us-ascii?Q?vtVttLTapd2WqDClHd/LXsK7AJaBNwu2AAUM9C7/mHLPSC4HizZ1MWURJjxw?=
 =?us-ascii?Q?y0Mz0uSKGfYtjhqEB43+voXDpSI6gDcFe61NkGo3jJIILjk46KPpS7dDK3IF?=
 =?us-ascii?Q?pRF6DfIBmOjzVkT5MzARsds1gT3rOcuw2uMxFyRIliEp8udNxpkUjCCkD0MB?=
 =?us-ascii?Q?gFmKowWT5xxjj2qCIZPRuw1xbQe+rxPCI2wkZy+kMV+a5SE7JF8jy+Wj0/EF?=
 =?us-ascii?Q?TnvtxmcVGzcdGlTcgcgPgzWAy2kZOjscaUwysxD4MjiHiNxP00ZwMTlSTGSb?=
 =?us-ascii?Q?38BGsXp0PWnUqb57GZrNG9maxEettwF3uEOhhhGHKZIC8h/YtO/L2wYnbxI0?=
 =?us-ascii?Q?qcECvKj20wZOcxjyvZkWRI6wxyOWnmbOrt4e4GfAQ3T5T29QJ/h3Lyy+KKeb?=
 =?us-ascii?Q?/y9u3vbn/X4TT87oWZz9L8RA7ap3SwRm10z2n+xCBUsP3BMp1IBoj8a/PiPl?=
 =?us-ascii?Q?zP4DdQQBaXd/Cjm27a1oLof9eSM2Yq0f89bMhvQu+qcP0e8pRasS3Y+yDnWl?=
 =?us-ascii?Q?s1nJsazLwDJMg9wBx1wwauaj6BA8Tf1GoKXxTpA3/vyw3l+xW/jdNeLceJ7F?=
 =?us-ascii?Q?q0u1kP/qOPppgBcA7u0HKKJm3/EYMBzmQ2DYKhk5/9vFqij3c7JweQ5qQTem?=
 =?us-ascii?Q?TgQN+D3LWkudHd2fVo6bjJ3X5ee5JclM+Jv74F1W7ds1WiLWoUPeJIaYD/UQ?=
 =?us-ascii?Q?rKhp5g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	nJMYozLQoJ5g8Z3iJ9wPHpJwfZjBPk7ZxeVq9S/NmE+hn+xv3pjrjEi0irF4rHSxz5IF4cnf2c3rAjMd8/aPvjNTaLO3XSC7d7HZag0FgYDUpNWz83h5YS55/L3fXT7rmS99BrPOwA9dWBHDxKjO+yuGlo1YePJ8J/GFZD1z2zWsqskhYs8VbhjxgQcSiUS6lsbY6+s77BMllsPqqyq8lt4B3vxORMa8Ibr5xunLb90++n7VKi1zINVIqkb44PfN7v87lLVP8DBae7RmofpBKq9wNoXebjXatkQ9O0mmutfOhXdawjrOkbeXM25Bo7cG3pDma4X+8922xSC+hvuVyQWKKeLGMx+haQYBRe/0mWvF+0zaSGQqJaLP1ALtuf6NWUARxZYukt/WVgTg5oaSmCeQ59lSTc6RglOzixu6aSlzV2VK/qkpdrqHTikV1CPB
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 05:05:26.4640
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e745dc9e-6fe2-48ca-83f4-08de742b7d24
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECD9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB999105
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9043-lists,dmaengine=lfdr.de];
	DBL_PROHIBIT(0.00)[2.98.207.48:email];
	FROM_NEQ_ENVFROM(0.00)[abin.joseph@amd.com,dmaengine@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,amd.com:mid,amd.com:dkim,amd.com:email,a4030000:email,a4010000:email];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 4CF2E191D88
X-Rspamd-Action: no action

Convert the bindings document for Xilinx DMA from txt to yaml.
No changes to existing binding description.

Signed-off-by: Abin Joseph <abin.joseph@amd.com>
---

v2:
-> Add examples for each compatible
-> Remove the note added
-> Use 'enum' rather than 'anyOf' and 'const'
-> Wrap 80 char per line for descriptions
-> Add dma-controller yaml reference
-> Add -| for paragraph separation
-> Remove labels from the examples

---
 .../bindings/dma/xilinx/xilinx_dma.txt        | 111 ------
 .../bindings/dma/xilinx/xlnx,axi-dma.yaml     | 371 ++++++++++++++++++
 2 files changed, 371 insertions(+), 111 deletions(-)
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
index 000000000000..4bdf8a5de251
--- /dev/null
+++ b/Documentation/devicetree/bindings/dma/xilinx/xlnx,axi-dma.yaml
@@ -0,0 +1,371 @@
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
+          contains:
+            const: s_axi_lite_aclk
+          items:
+            enum:
+              - s_axi_lite_aclk
+              - m_axi_mm2s_aclk
+              - m_axi_s2mm_aclk
+              - m_axis_mm2s_aclk
+              - s_axis_s2mm_aclk
+          minItems: 1
+          maxItems: 5
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
+          contains:
+            const: s_axi_lite_aclk
+          items:
+            enum:
+              - s_axi_lite_aclk
+              - m_axi_mm2s_aclk
+              - m_axi_s2mm_aclk
+              - m_axi_sg_aclk
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
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - xlnx,axi-cdma-1.00.a
+              - xlnx,axi-mcdma-1.00.a
+              - xlnx,axi-dma-1.00.a
+    then:
+      properties:
+        interrupts: false
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
+
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    dma-controller@a4010000 {
+        compatible = "xlnx,axi-cdma-1.00.a";
+        #dma-cells = <1>;
+        #address-cells = <1>;
+        #size-cells = <1>;
+        reg = <0xa4010000 0x10000>;
+        dma-ranges = <0x0 0x0 0x40000000>;
+        xlnx,addrwidth = <32>;
+        clocks = <&clk 0>, <&clk 1>;
+        clock-names = "s_axi_lite_aclk", "m_axi_aclk";
+
+        dma-channel {
+            compatible = "xlnx,axi-cdma-channel";
+            interrupts = <GIC_SPI 92 IRQ_TYPE_LEVEL_HIGH>;
+            xlnx,datawidth = <32>;
+        };
+    };
+
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    dma-controller@a4040000 {
+        compatible = "xlnx,axi-mcdma-1.00.a";
+        #dma-cells = <1>;
+        #address-cells = <1>;
+        #size-cells = <1>;
+        reg = <0xa4040000 0x10000>;
+        dma-ranges = <0x0 0x0 0x40000000>;
+        xlnx,addrwidth = <64>;
+        xlnx,sg-length-width = <16>;
+        clocks = <&clk 0>, <&clk 1>, <&clk 2>, <&clk 3>;
+        clock-names = "s_axi_lite_aclk", "m_axi_mm2s_aclk",
+                      "m_axi_s2mm_aclk", "m_axi_sg_aclk";
+
+        dma-channel-mm2s {
+            compatible = "xlnx,axi-dma-mm2s-channel";
+            interrupts = <GIC_SPI 84 IRQ_TYPE_LEVEL_HIGH>;
+            xlnx,datawidth = <128>;
+            xlnx,include-dre;
+            dma-channels = <8>;
+        };
+
+        dma-channel-s2mm {
+            compatible = "xlnx,axi-dma-s2mm-channel";
+            interrupts = <GIC_SPI 85 IRQ_TYPE_LEVEL_HIGH>;
+            xlnx,datawidth = <128>;
+            xlnx,include-dre;
+            dma-channels = <8>;
+        };
+    };
-- 
2.49.1


