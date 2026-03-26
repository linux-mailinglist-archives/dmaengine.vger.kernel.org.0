Return-Path: <dmaengine+bounces-9662-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AIhHIRsXxWnr6QQAu9opvQ
	(envelope-from <dmaengine+bounces-9662-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 26 Mar 2026 12:23:07 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C42C9334637
	for <lists+dmaengine@lfdr.de>; Thu, 26 Mar 2026 12:23:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2BA3530091F2
	for <lists+dmaengine@lfdr.de>; Thu, 26 Mar 2026 11:10:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05ACB38A73B;
	Thu, 26 Mar 2026 11:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="BbF7JyGb"
X-Original-To: dmaengine@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012039.outbound.protection.outlook.com [40.107.200.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94B2E33D6FD;
	Thu, 26 Mar 2026 11:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774523414; cv=fail; b=b/WluidYMBWzFWV7SQ+y/FE4jPYpVu/B9LYZ9eqAz7NT8TWr/AwAtrImUPwZ8dWnaWW+e0ThDiamYf+3wKj+s7otc/RmML9Z6a7KUPkD3p8EJZ/hrtlnPTF2xWeh721M91T2IBqP9KoqU7Xtlo98CPzLHkeXlLvjHv5hl/CKexA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774523414; c=relaxed/simple;
	bh=VmzFmrofDLogW5BkMlpkibjdrZo1bRRN4Q0sI3gY2Ko=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=eKVnSic/Mo51giYEKFmESAI1aG023kCG91b9J8n2V9tGlIXGf2sZGVluaGGR+qD5ocb7qWLIkmwkawTvV2EsIgxQx+3hpnLMcHG1k0WFzXqB42bgaW7AXmzLQUYKJeuSjrwF4AfO1QjTwg0IUWGeGl8nwJMiUABw0y30bVeirGs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=BbF7JyGb; arc=fail smtp.client-ip=40.107.200.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DiIy+13gVeT/HPbLGAF4GjbhYeu5sdc52YGxnwJcEjYWe/CdehYbDIYziIABxuuQ38niKGMdq4mLG08DfMvNLnYD3ZYsbpQFJB8WrPN0/ErSYz5f8rviU2+4K8Q1x1c037UswUMe6cGTbNQwocG5NXlNCDP0sXokTt6W8oh7+Nn4PBI1b21Q5dKKqvdkw945oP8zdcBoYL4lSLeYEOM1Tv8py9AcPCizYBJpJQpHuM7ErJ8g82fmcpw60k0g9KrW/CqDxRU0T4rXmH9WgSYRZg3eyBz4TRanOGflXTSJkw9iUMFIW6FVRrUfy2vvBMXW7c2HK6885bSek+cBIa7WUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KiQMmgLyO1Ao1qIiKC9UhhBxkgA1cTI9o64z37Hut7E=;
 b=n5wxkhas8GHLs0Gjnz+bg0zfe9Pa6Zg1ZNpVfQv+L4u31hMAWWNeqTdEIjytY7SAOUd5WzaE8V/RHduIySGnKXcbeQqK8HIpOZNRpIxI5YDoeSdOnieCwxq54tq/33n8LJgd/sXA984LT1ncImapBUONBRYvLH7ynB3csQXEoACNiJa9XZ4ij91cohmgVMVGScqewZauGNc+wpnH3To5oLWEZ7h6YdfVCN3sk6BcCwW43ru/NzDw565Xlqts1PWkeIuZO+BXqDAoeezRDgxPjxhyTFwP0O02l1rqRGuuz8wPanoRBZIM6n/sS4kyCpggdRejanvrmWimMqTratXNQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KiQMmgLyO1Ao1qIiKC9UhhBxkgA1cTI9o64z37Hut7E=;
 b=BbF7JyGbUnn/u6TOH76dE7DsqWM6+LT0+8FTP5hSoBGfy5h63U4L9UBkcENj2fsnCR894BsqkZx1e2m0SYU9ihPOAshVUmhwiSEPhtlOuR0FUIOyNjeC1g1xnE51zJa8RP7D/ZsHtwjarREgDKQzvQoTVZIHGVALNPD23fgqBmuzWx465Lgb8p/EpD91FEtMeixT4p9ifY0tP3jlHBTgyEmrzj4AzxpgONQQzV/yFnhyDA6gJbL0f/eJSddnHfRwNaeuf9nEzl7ZHzp7Yi3VY67mCbddk3cdNozumkMHOE4q7agm1Icmj98k3LqlianfysqOB5J6yczAmUjCslQepg==
Received: from DM6PR12CA0006.namprd12.prod.outlook.com (2603:10b6:5:1c0::19)
 by DS2PR12MB9613.namprd12.prod.outlook.com (2603:10b6:8:276::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.8; Thu, 26 Mar
 2026 11:10:08 +0000
Received: from DS2PEPF00003448.namprd04.prod.outlook.com
 (2603:10b6:5:1c0:cafe::14) by DM6PR12CA0006.outlook.office365.com
 (2603:10b6:5:1c0::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Thu,
 26 Mar 2026 11:10:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 DS2PEPF00003448.mail.protection.outlook.com (10.167.17.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Thu, 26 Mar 2026 11:10:07 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 26 Mar
 2026 04:10:02 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 26 Mar 2026 04:10:02 -0700
Received: from BUILDSERVER-IO-L4T.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Thu, 26 Mar 2026 04:09:58 -0700
From: Akhil R <akhilrajeev@nvidia.com>
To: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, "Jonathan
 Hunter" <jonathanh@nvidia.com>, Laxman Dewangan <ldewangan@nvidia.com>,
	Philipp Zabel <p.zabel@pengutronix.de>, <dmaengine@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Akhil R <akhilrajeev@nvidia.com>
Subject: [PATCH v4 00/10] Add GPCDMA support in Tegra264
Date: Thu, 26 Mar 2026 16:39:37 +0530
Message-ID: <20260326110948.68908-1-akhilrajeev@nvidia.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003448:EE_|DS2PR12MB9613:EE_
X-MS-Office365-Filtering-Correlation-Id: d61deabd-a703-498b-464a-08de8b283d8b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700016|7416014|376014|921020|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	R9huB1jJKR/zGR5FECnBaEM6fsSdbAtVo6pP23IMvnWvMhEr8NYuTewxLpQ8iqsaGEMjguQ4lsVN79HeOE9vxKs+pcuHu1AhCT0G3W705zhPu+MQYfv7bixXaAuZdgzWKwOmPLIQ8fakxv38lT2qN82je0bj76aYoo/9UuuWjpQeZZyxl51JlAVA7Plfmf4BCAwL9luYeI3iJdaivBi5919HeURXhBCcjVwMEKWZSDQ/AbNfTS+lEQ9hiR2hFQNn8GWba28KlvFXVCnStZlmAR5GRS235NvfPrLGmfBFOkMZIqAgV7ZysbGkGkCN0RVmWCgu/iBC7AelxY0jigCysRMXx+pC+B45HExAefyQXQoyGA8fFQKAOEI7UpsHmXB1hjEMEpZDqyXjYCbpEWPOTFEbnJswGuGcCLCaEqj1uf0rnYtyckPGF6StBKUxSuFoAeha52CF8orPN1hgCKcNl2Iq9C8adGIX6fGbJzYSs9aIm934iM2JsvZ7EX0hcELHklB74tf0Vw3TipNKCvyRGezCcZeNzcib1y8//vzUApizqhHFKlgtESzqEk+SNsdBKda9N0yG7dWb3WnjBDo9/VyLD3CgBcmsmN8vaFEfhO3tLZzc4NkMwqhC2EYi9XA4XHxkMUaYGMr/Y0R+m7xQ0kxllBUDHtYvxbylzei5AFOjEFPMjSguNfUBh0+WAi/3fxcey+A69yGkVwfN0jBEPlA8nnGAnnmr61DULMka0JykJeO/kYooPe3GFDG3z4+9r+eViEG2xKwbKg8vakuZtD/ZMqep2tII6vjNnPwFfO65Hm/dVPm0ePTPqDUU9EUQ
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700016)(7416014)(376014)(921020)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	psLWIj6jD/vKpmc7CqATCPc8TbjosmPMBebm5/KukdZPeglQ3JNrllAL8+uoxVD7HCoFuIrI0NGU5vFrtu83jaS5ovHBmnAwPZWpoKusRL2sX92jQshRsIm71DeRhJo6eqRs0CANClz29Hu2QllSOquWyWys+x6J1HEY0pnGxFIS7OGkO+s5FHPtZPkCTyhVm5C/C+0aaNLDeQOOs7BTrI4CtL7p3uWB0DYXSdMGWgcC9r0YKJDwtbkkjVFeMRsTtlpfWIe/uyAdCeIeprU5kTi0LeHY++MWE1eL+tzZnsJxVRSvp4CyhQQFIZG5dSjdAZHZSyNJqlg3ZhENLGt/JTeyG6TMP6xMSpIhRXQQc8IAoJtKGePNPJPzjg6HiX+/Gxu/cTpvYQE1GZlRROhk52QSrQe7GrkxdQlOZKjIx/TU1+QIUV1QdzQT+TEJB9Jm
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 11:10:07.9195
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d61deabd-a703-498b-464a-08de8b283d8b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003448.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9613
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9662-lists,dmaengine=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,nvidia.com,pengutronix.de,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akhilrajeev@nvidia.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,nvidia.com:mid,Nvidia.com:dkim];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: C42C9334637
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This series adds support for GPCDMA in Tegra264 with additional
support for separate stream ID for each channel. Tegra264 GPCDMA
controller has changes in the register offsets and uses 41-bit
addressing for memory. Add changes in the tegra186-gpc-dma driver
to support these.

v3->v4:
- Split device tree changes to two patches.
- Reordered patches to have fixes first.
- Added fixes tag to dt-bindings and device tree changes.
v2->v3:
- Add description for iommu-map property and update commit descriptions.
- Use enum for compatible string instead of const.
- Remove unused registers from struct tegra_dma_channel_regs.
- Use devm_of_dma_controller_register() to register the DMA controller.
- Remove return value check for mask setting in the driver as the bitmask
  value is always greater than 32.
v1->v2:
- Fix dt_bindings_check warnings
- Drop fallback compatible "nvidia,tegra186-gpcdma" from Tegra264 DT
- Use dma_addr_t for sg_req src/dst fields and drop separate high_add
  variable and check for the addr_bits only when programming the
  registers.
- Update address width to 39 bits for Tegra234 and before since the SMMU
  supports only up to 39 bits till Tegra234.
- Add a patch to do managed DMA controller registration.
- Describe the second iteration in the probe.
- Update commit descriptions.

Akhil R (10):
  dt-bindings: dma: nvidia,tegra186-gpc-dma: Make reset optional
  arm64: tegra: Remove fallback compatible for GPCDMA
  dt-bindings: dma: nvidia,tegra186-gpc-dma: Add iommu-map property
  dmaengine: tegra: Make reset control optional
  dmaengine: tegra: Use struct for register offsets
  dmaengine: tegra: Support address width > 39 bits
  dmaengine: tegra: Use managed DMA controller registration
  dmaengine: tegra: Use iommu-map for stream ID
  dmaengine: tegra: Add Tegra264 support
  arm64: tegra: Enable GPCDMA in Tegra264 and add iommu-map

 .../bindings/dma/nvidia,tegra186-gpc-dma.yaml |  34 +-
 .../arm64/boot/dts/nvidia/tegra264-p3834.dtsi |   4 +
 arch/arm64/boot/dts/nvidia/tegra264.dtsi      |   3 +-
 drivers/dma/tegra186-gpc-dma.c                | 435 +++++++++++-------
 4 files changed, 292 insertions(+), 184 deletions(-)

-- 
2.50.1


