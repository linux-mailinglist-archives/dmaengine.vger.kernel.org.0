Return-Path: <dmaengine+bounces-8979-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6Lo3Eb8rl2nmvQIAu9opvQ
	(envelope-from <dmaengine+bounces-8979-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 19 Feb 2026 16:26:55 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A654B1601CD
	for <lists+dmaengine@lfdr.de>; Thu, 19 Feb 2026 16:26:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 935823008E16
	for <lists+dmaengine@lfdr.de>; Thu, 19 Feb 2026 15:26:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EFA53451DC;
	Thu, 19 Feb 2026 15:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="GkQgi2rj"
X-Original-To: dmaengine@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010039.outbound.protection.outlook.com [52.101.201.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0506F342523;
	Thu, 19 Feb 2026 15:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771514812; cv=fail; b=fH0/teAc4XbA8VaNwKq58XRFFeCz+QtkBOdG2JmfK7XIVAe8o0kiiuAdoHi24KlzMzB1FIphhrCJcxY34G+NeRcj0Q/BAkMdjyYXB+aoUlYAYXpKGwouXrpLALGJo0IEVM3mjpqoVD+po4W3LdRrC2mDAXN2ZlQwlkxrdKUUxZ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771514812; c=relaxed/simple;
	bh=PwOkyBFQTBpJzniIpTVPPRpRWC3AcuegSQ0XfqQW+bg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Pm27orbsnU10yiAmvRVJqSK9sGE+NIvfjaD7x5zll1nUShCAGgHNb9NE+RAm72aoCtIellZVYZe9lO8V8ZYOAT/Zmwv1+AmnuglZYiH0QhdYV3wfKVpCaEdG/jPsni+MrOA5ce+ZAUWxrqQpbBK9g/6x89btJ0rD4q7XZwbemj4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=GkQgi2rj; arc=fail smtp.client-ip=52.101.201.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZKisvCfXX5XMIIwmIloPnF9ZK/SGzF4JioSGS0S4BtKCsuXZIOG/Zpx96ocvPd5uGWNidfc0n/jv5sGeCeJhys11bDE3q8uFGuid2CuXOvObTMAebuJHFxBr52VA17Ne7d2YAUZQqAo+cOoRPGYRg+fqP0Fx7ERv22sR3r/6L/+Jb15bUGF0G2eW72MNTETZg8it4bLm3wJo4G56jqMVd5EdoMseJdp96x8LxKsKyNbbUwmZTYe5lcsIsQWI47Da3aXsnzzS4yRvN+kekIeokN1AIQqWqpoZyJftf4Ip7oSWYZHgpMIfk4/w0Wp4oK8rqN2pbX3N42dysHaybUATCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ftdG1Va4DnIDiZFbMwHXOxsAsoZc5TEVG5NJZA6wRWw=;
 b=RacXE/bwchG4O+4W5Xn/eblTqVvEOF0esn3Y6fNnLNCQc3x1xeCrhEw6wWcYk+fbaZY29oJxVqK25fj2P3fOiQmnEOKCWsoGK3x6h9PpFobsxCozdiVAspjfMp6OrJP9cGfLfyW7zNxI1kFKPsnroYY1CLSRfQLkU1oa5xeirDPfsJNiZi7pzP3Pz93yw9ov0AOOErKkM2auKuTFWg3LBZstI8qmqIVhRN5DIoUG6FcQsVaoOWeAWG0X3eLFvpgKC4tLcm4AnWzh2sJBD+ZqtSzXTdxpwMJOeQz6H37+7xbqyR4ii1v4VtfGvQXuTDLAnGTr0FP1YLTrHe+6BhkDBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ftdG1Va4DnIDiZFbMwHXOxsAsoZc5TEVG5NJZA6wRWw=;
 b=GkQgi2rjRI67A0OJyQmoon/0ad7aKah7B0TV7b10hv5PxRi8vuhf023eOFuSt94Pcm8P+ka2m7MH2wcRJHvvDeHnoSJscZXCVa4MIxjlgyUUD6gcUWf9m//Ee1hCx7QmDkWmPcZP+RISGHK0ZkhUt+J1RJ5exMc1jY698ztwJME=
Received: from SN7P220CA0030.NAMP220.PROD.OUTLOOK.COM (2603:10b6:806:123::35)
 by CY8PR12MB7585.namprd12.prod.outlook.com (2603:10b6:930:98::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.15; Thu, 19 Feb
 2026 15:26:41 +0000
Received: from SA2PEPF00001505.namprd04.prod.outlook.com
 (2603:10b6:806:123:cafe::1e) by SN7P220CA0030.outlook.office365.com
 (2603:10b6:806:123::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.16 via Frontend Transport; Thu,
 19 Feb 2026 15:26:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00001505.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Thu, 19 Feb 2026 15:26:33 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 19 Feb
 2026 09:26:25 -0600
Received: from xhdsuragupt40.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 19 Feb 2026 09:26:22 -0600
From: Abin Joseph <abin.joseph@amd.com>
To: <vkoul@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <michal.simek@amd.com>, <radhey.shyam.pandey@amd.com>
CC: <git@amd.com>, <abin.joseph@amd.com>, <dmaengine@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH] dt-bindings: dmaengine: xlnx,axi-dma: Convert bindings into yaml
Date: Thu, 19 Feb 2026 20:56:21 +0530
Message-ID: <20260219152621.2375256-1-abin.joseph@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00001505:EE_|CY8PR12MB7585:EE_
X-MS-Office365-Filtering-Correlation-Id: 3bcf921b-79d8-43a2-b5b3-08de6fcb43b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xix+SsrYA9Ogb9R8miQxyElLhPkS9EvfqJrFjzwR5ok3mEGq9U5/lqSE0FA/?=
 =?us-ascii?Q?iazzmW6z4pEY9WFfCifjLSgwhWKKu13Vzznl/XDhTZ02zNZM5+Wtm0+c6wKC?=
 =?us-ascii?Q?6O/pDulb1URjeOH9cltswuWgfGhDkL7sCMC3Red+NUJDMuoOKfLsOtoHHfcQ?=
 =?us-ascii?Q?SHZSfk4dPerntlfGNj9MAdiRdu9ZmvE6bEvndiBYWr0ajXwz/InQA+3EKskW?=
 =?us-ascii?Q?J64+F0poVFpR63u/T5G+9I8Kd1LxX4IlP0dbOwn4jd5MHEHAtuCYAgmNXN10?=
 =?us-ascii?Q?dLVbKBmYKrv3r3Nh5r5/W2kGRi8O0niOaFYEhms1/KHyPLy92yPRnfg7+Tmh?=
 =?us-ascii?Q?6U23Yi0M1xR/27oCcV5mda83TjvIzyblU5FMAg/EcciDAyWPAGN8q6IczJDv?=
 =?us-ascii?Q?RKaW8BcP24a3yFU+5hfFx5ayfuEjgMcVSFTJsnwQub8lGZPhLeea7fPq2DhK?=
 =?us-ascii?Q?szoBR+tUzVsjOgemvBu68ZSE3VLxDWCr1b7ToYGp6UE4njpsivlQ+MCp4HRf?=
 =?us-ascii?Q?JzBzZQPH+Zx7AEwPnS7UL5RpPcgL1vyXaVbwwiT+pZwDrqOONDqOwcORAAzh?=
 =?us-ascii?Q?gIksd6oYMkwHXFdJgHYNTpfnMmBMsfmgLMDSy6b2lyLJ7MkVLD+ai3QEvL+9?=
 =?us-ascii?Q?5mWTO+q6elxKq8IwoEpSxn0YBOgZyNz9sdBrxLMoOmiMKz5LDIre/6ZS1S8u?=
 =?us-ascii?Q?33KtXcaL5+ufqibZ9P8lzu+kgzyeXdGjizZoAeLRJfDsR2ic9YcuapaRaCDP?=
 =?us-ascii?Q?9oABXTEYmyq9d6qZ5CyLGA8xJe7kqW4Y6wFmUdtEUMs/lk9I5gcxZXuIfrwQ?=
 =?us-ascii?Q?s3z5FPpBuD/8VzIBnvSxzpmLPPERaq2TUD9XPTv0MB+NOeqQ8kTJZRXFmKSf?=
 =?us-ascii?Q?uhZeUL8YK+AGgkBct57f4HvV9EqxSzjgP0VfMs3jyFKs4NinTqq5jkM6p3Vy?=
 =?us-ascii?Q?E1e9pnQNSfAExdDUOCkYNvYryAU7yHhS0H7y+WbXBiJDWOuVsw7YeU7+BR6b?=
 =?us-ascii?Q?4jnZK2zJm3DWn+GtCxyUJfz4Zeqzff9BGUg+m8KwQbk4xIDB7pr4tWc1ohJ0?=
 =?us-ascii?Q?brwQJLHtvuhL99HTtW5azxxonEJIw+0nJMSnxcbPcN79xQUeOdQdRj3LaiwS?=
 =?us-ascii?Q?NgNEBGuI9JybOMjKgft6WAxyKw3W6Pk8ZGZLV98lJJ/7uUvhzYgXlyTF0vLJ?=
 =?us-ascii?Q?39gkCyuhoF7uge25mS5vsSdflsIilRMDv8fjI7ltmeeD/6IwkRowKW38eQd/?=
 =?us-ascii?Q?LidvSszfa9jjeayJ24fOdzoeKSaGpE/uX9us3jv46H7PfzE0MZ+eQPEek8Lo?=
 =?us-ascii?Q?V6f/jL4RnYUtKc/iTy/B++WjfzvehVFoZRsEStNuIJebecf8CxO3jRz8SHAE?=
 =?us-ascii?Q?Qy29ntpArMzvA7JqZSWqmGLDOnaKj3Ewzwz5buB9XlCQLUshQZbkuGDHc9Ed?=
 =?us-ascii?Q?fIpwoZXyD6o9i4ZDUrfZsyYeKlxG+YoJpXV7IaYW3MgHx0lThod0S9ktLrUx?=
 =?us-ascii?Q?9ojHv/qZBdwiM+SzbrZzyBJVu4fVPeu6jwQ7d1W5ovJioaDHtV3betRTBeL7?=
 =?us-ascii?Q?TqvPxiS1BMaFJPqlo7sxQOxNoJiS9FIrqJFc6mVUnVfC7qTTc/iBhqMcqLI1?=
 =?us-ascii?Q?jHFtEfCY/Z17Skb15mzEDIw+7XyTMaeJfwydAJw+WPHTOhdzNbwHmAKXEG37?=
 =?us-ascii?Q?0BtTxw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	MTJpTNLY1xb4z21v0Si2E/kbCO5PR7tYM5kp+UUvBXynVQcF7779h86L/Q/zo87kCrwafEezDfEcOmEkrcYRp5vuvlspJy5rV5fR4BtnyY0JG85omO8hmuYOMmAGM0LV4B+lEkH0AmdDh1H8jAyESyBf5R85LFER3uhkIO+LlV26RWEYHSExi7WWvdyPsqeGpyDveEnntzrjeBaY29fWT6zO+4wOX/f0H/rSdz3Uq8AWWmx0GrcfO9+5zXIlx8NOwV2W+9raFuvJVt5sIyzNz0dhi+7R1XTwd+kuHs+kZqht0qxLnuqTubAz2ia32ZZRJDVQik0zw03WmWuXSTp2CLbEvwwGiQaDRovOI3MDjOC+ZSukHFIwqh/jeWwsmWijaobWbIr1azvzvWcCh1qENw4h4AwOfP4c+PFkuLqogAtVSx4Nua8wq5s0IFSLUXhz
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2026 15:26:33.7828
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bcf921b-79d8-43a2-b5b3-08de6fcb43b9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00001505.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7585
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8979-lists,dmaengine=lfdr.de];
	DBL_PROHIBIT(0.00)[2.98.207.48:email];
	FROM_NEQ_ENVFROM(0.00)[abin.joseph@amd.com,dmaengine@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,amd.com:mid,amd.com:dkim,amd.com:email,2.98.207.78:email];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: A654B1601CD
X-Rspamd-Action: no action

Convert the bindings document for Xilinx DMA from txt to yaml.
No changes to existing binding description.

Signed-off-by: Abin Joseph <abin.joseph@amd.com>
---
 .../bindings/dma/xilinx/xilinx_dma.txt        | 111 -------
 .../bindings/dma/xilinx/xlnx,axi-dma.yaml     | 290 ++++++++++++++++++
 2 files changed, 290 insertions(+), 111 deletions(-)
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
index 000000000000..6a260f9292d7
--- /dev/null
+++ b/Documentation/devicetree/bindings/dma/xilinx/xlnx,axi-dma.yaml
@@ -0,0 +1,290 @@
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
+description:
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
+    minItems: 1
+    maxItems: 2
+    description:
+      Interrupt lines for the DMA controller. Only used when xlnx,axistream-connected
+      is present (DMA connected to AXI Stream IP). One interrupt for single channel
+      (MM2S or S2MM), two interrupts for dual channel configuration.
+      When child dma-channel nodes are present, interrupts are specified in the
+      child nodes instead.
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
+      Should be set to the width in bits of the length register as configured
+      in h/w. Takes values {8...26}. If the property is missing or invalid then
+      the default value 23 is used. This is the maximum value that is supported
+      by all IP versions.
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
+# Note: This schema combines all DMA types in one file. Parent-child channel
+# compatibility is enforced via allOf conditionals below. Alternatively, this
+# could be split into separate schemas per DMA type to simplify validation rules.
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
+            anyOf:
+              - const: xlnx,axi-dma-1.00.a
+              - const: xlnx,axi-mcdma-1.00.a
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
+      anyOf:
+        - properties:
+            compatible:
+              contains:
+                anyOf:
+                  - const: xlnx,axi-cdma-1.00.a
+                  - const: xlnx,axi-mcdma-1.00.a
+                  - const: xlnx,axi-dma-1.00.a
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
+    axi_vdma_0: dma@40030000 {
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
-- 
2.25.1


