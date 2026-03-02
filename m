Return-Path: <dmaengine+bounces-9163-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YJuAGieFpWl+DAYAu9opvQ
	(envelope-from <dmaengine+bounces-9163-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 02 Mar 2026 13:40:07 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 00FB91D8D04
	for <lists+dmaengine@lfdr.de>; Mon, 02 Mar 2026 13:40:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3F36B302FE8C
	for <lists+dmaengine@lfdr.de>; Mon,  2 Mar 2026 12:33:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB0E236D9E4;
	Mon,  2 Mar 2026 12:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bhqUCqcZ"
X-Original-To: dmaengine@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012020.outbound.protection.outlook.com [52.101.48.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 880EF36D504;
	Mon,  2 Mar 2026 12:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772454835; cv=fail; b=pkQ+6977CfZJazRPWMROp7V/6RZvkRH/eCPdv1NvAq3Dgc9uZtWIxXV2wjPgdsebMvKTmw5HCn0rA528iY+c46b1kUfIBmDgbZmE7KzERLGSe24s0Y7QK69pTSTUnjo/0TwVG4Fwa6RfpmBrUEifojz5fK0TiE9AYYGaRkuyM80=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772454835; c=relaxed/simple;
	bh=g0sUoqaafyX4CPHQ7tmPDd+nmapZ7nhnLwwt1ZQIey4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OgYoFTwg/9tXLZYzPl6pke9B6lKrmQDqC/KFU6s6FhvDZNnLWK5ljVDTfihGHQaEK+qjcmYBQmI7vwVZyAQmMA54lcEidpyfvSeBojtey9pGVrqjEd3PlpR6FgPjRlth+AP2phpAO+6slQ0pPwYa//KoE1jKtPbrPJcmEBbqzB4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bhqUCqcZ; arc=fail smtp.client-ip=52.101.48.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f+sQGjxqP+amwXLeA+YoFH+Qtvlj83ODcvTGFoOdNdKs11dllP8OInv7wCVVX9pJiR0hoRAKiNIjtBcUyfGq+6/sTPJ+96ud1w5CbjZ8OfrFWz8kz4jsoCrlCKU4R7K/QdTKS4NJfYDd/1eq1d6yFNNZFCkns3qGgkl6f2nSHXB9mSPhwalrlsukOgDyY4WONRalvkqVtyOZagHxu4muuVPnPuu6hcJHxgwtoI0lYahOINT9BDMyaNCoNC3hNRXjETTIh8PYQ7Z1Z4OpAi2GixYLAswnFb25lJAc4dZysZ9wtA6cwf2B6ICN9omt/u1IxpXbeoCa5Rq+QnLDTJc+ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gDoFr3TbwzWA2t81KuAF2GGVgsdyyirsQUDVWA9bICM=;
 b=Jcd5P3rb15qO9u7g7rmiJVp2Oyw5f9mz0EwCNiW985Wo/ZwVNLWKtMM+4dUK4mE4NZnjezMLXAAVh3k+jx+U8HY4ZfhEMFmROWp+aXyfcbN0gUxvuO4rakjEiSAd2H37Dmzr/8CnA+LRka9hSjMW7mDRWWT416EI05dakiazkuItuGOUL/qEH4TD4dYFMgJFCMOKrbNahbNpRKSQ4mEt8HkDfGtOds3c0NKcU4nWjZ61hK5lRyq9EwHDQoIP2GSAPEgihNBNhKp61ztZsAhMn2kzilGdRowgh1U7qolF4W5uGebFG8omsE4Oqao2vTqt7dKqetvMJOn1RKYU4qYj9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gDoFr3TbwzWA2t81KuAF2GGVgsdyyirsQUDVWA9bICM=;
 b=bhqUCqcZSNHWspFJ7Oik3VLzdY9ShWLa8rQ0tJciB54VtYhj1+Ugx/6u0qz5JyAROzhn1KWmh8vbCss+l+P4r8yb8N+YSlhPTMJ7Cy5hdowcPmrEV1plBQoZNRr9KJ0AR5WA8GpkfYZuvSjDiDQYj1BX70YvRYw4dBOCj4fNEe3rraaTWULnlP1/NjVUvRfZ81Up7/mnz71PCWdTwQ2/uQtftlWOidPSAQsng8jTt5LRlTtsBz659M54m2hskOW9ajmOGKuLw+FlO0IChuZfVS2rMLr4jmoKqQTCYgmrbBTDgGPQEBiySmWM+a9kYMS+BN/c+G8qipcokGVsOZh7qQ==
Received: from PH7P220CA0072.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32c::31)
 by SJ5PPF5D591B24D.namprd12.prod.outlook.com (2603:10b6:a0f:fc02::994) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.21; Mon, 2 Mar
 2026 12:33:49 +0000
Received: from SN1PEPF000252A2.namprd05.prod.outlook.com
 (2603:10b6:510:32c:cafe::c0) by PH7P220CA0072.outlook.office365.com
 (2603:10b6:510:32c::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9654.18 via Frontend Transport; Mon,
 2 Mar 2026 12:33:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF000252A2.mail.protection.outlook.com (10.167.242.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.16 via Frontend Transport; Mon, 2 Mar 2026 12:33:48 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 2 Mar
 2026 04:33:36 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 2 Mar
 2026 04:33:36 -0800
Received: from BUILDSERVER-IO-L4T.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 2 Mar 2026 04:33:31 -0800
From: Akhil R <akhilrajeev@nvidia.com>
To: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Thierry Reding <thierry.reding@kernel.org>, "Jonathan
 Hunter" <jonathanh@nvidia.com>, Laxman Dewangan <ldewangan@nvidia.com>,
	Philipp Zabel <p.zabel@pengutronix.de>, <dmaengine@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Akhil R <akhilrajeev@nvidia.com>
Subject: [PATCH v2 0/9] Add GPCDMA support in Tegra264
Date: Mon, 2 Mar 2026 18:02:30 +0530
Message-ID: <20260302123239.68441-1-akhilrajeev@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A2:EE_|SJ5PPF5D591B24D:EE_
X-MS-Office365-Filtering-Correlation-Id: 42c6173a-1440-4025-20da-08de7857f459
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	qeAczlJR0E60lXCCQq9DAfCq0+Me4zHVVODSdqrrb24eN9INDnovaIeeViuIpBaTDSg3ka7yLTMGBfyXiRmAnnO5iiGvVBiZVpGlxs78lZwy5deZ52ER35yxTj9j6nwT4n2FGjrwLLAC6GCgkE7WiuWGXkucgJaLyVZH5yM/m7ln7m0I5gRSkJ1EqJvkilVg2PycBBO07YvECJaXZ/+z8/CpfzbujZ9WAOd6hpC9wMjc2n+D8EArm6Zno3TnuAR90L9oyBGB27Om5g6vQrLAMyQJCj2u8z1NJM0RR46H7n4IQmpAcBGgRPdab4VxEDBChC/SUveKKAC11b+3JVvkCLcRkjBlQx5g7DG2enSe6q2rkE0KV/JIgrSNnIbLwhT6QjxyoRre2+5zW/pAbOyegNdYtaPNy0MztmTM8epDPtKI+f6Hw2NXxOvNNLvb6ng7eDqgUq93rtitjb2RghPcsHcs6XF2f/YvRWgg8/qzMfwALggVfK+0BOdSrToaV/glF5Wk43oRPcqe/ypug2ziPxpNOcziiXcET3xSpmL9Z0WgrGY3VyB9mUwlFWdIZdOSvd68K9k6SATP4gptcehLg9f7mMr//NoBYYkXIcAfXEXtRgTYFdgV6G5v+u/M7LXGn/QGzkuC2ZP8lLP1gOZYICHegccFOIk3v1YZh0GMFBG5pW7JLQMB2eE/4pPAR3QbIlvMMqImtDTY03HSRk+kgjFJznUAj6QJmdmswDRFncx1ztTwdgeMa/YK8JMnCDOI1mZlrZPg5QlR+v7swlD9r7MpWVK5HZzwuIK/zX7F/ZUqW1osIwf95PE7hPWVowpSuiM6G7d5WRo7gPP+M6QFX4xsJAh9w+zh4HA/cCzE/hQ=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	89kf60vtcOn4qfUUV7B11Obz0m5jvCKACvTror5NikEtdK98n7J0Iu3tm8sjeJK2nMmSa2RsEpPWhazVJ5+aWW2uGi4ZTDf/YglocdFVyXh3iAEiJW2gRdijRDkoC4AwRn6UkKOYQm5sPusP7RLCQLztGVvSWlmC1jR85TmJw5B87zaEdSVjIy5Vv87HmcK3/QfqbLpu53QbRUZkaw3j6lpPKTX2Si6XoENMokZ+MkxU9omng8aJGlEJEZh+6AwPFrQwdrBhhgDOL8sXtvssNABI1Roqn/qZyQvR0EMUUZ0/PkzF5FHwzLeM4IqE50If9RW0Z+YXs0GueLDDYFd4po2ZxEgAg/XAfEE6ir9Tf50OZFwpjdD163MDFclZnlEaTAOR1DUI7CzE5sSDfM/Bd+ubMfK+zx39L+jcub137YqrKGrZAJUxjYydiNihtsJD
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2026 12:33:48.8691
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 42c6173a-1440-4025-20da-08de7857f459
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000252A2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF5D591B24D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9163-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akhilrajeev@nvidia.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,Nvidia.com:dkim,nvidia.com:mid];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 00FB91D8D04
X-Rspamd-Action: no action

This series adds support for GPCDMA in Tegra264 with additional
support for separate stream ID for each channel. Tegra264 GPCDMA
controller has changes in the register offsets and uses 41-bit
addressing for memory. Add changes in the tegra186-gpc-dma driver
to support these.

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

Akhil R (9):
  dt-bindings: dma: nvidia,tegra186-gpc-dma: Add iommu-map property
  dt-bindings: dma: nvidia,tegra186-gpc-dma: Make reset optional
  dmaengine: tegra: Make reset control optional
  dmaengine: tegra: Use struct for register offsets
  dmaengine: tegra: Support address width > 39 bits
  dmaengine: tegra: Use managed DMA controller registration
  dmaengine: tegra: Use iommu-map for stream ID
  dmaengine: tegra: Add Tegra264 support
  arm64: tegra: Add iommu-map and enable GPCDMA in Tegra264

 .../bindings/dma/nvidia,tegra186-gpc-dma.yaml |  27 +-
 .../arm64/boot/dts/nvidia/tegra264-p3834.dtsi |   4 +
 arch/arm64/boot/dts/nvidia/tegra264.dtsi      |   3 +-
 drivers/dma/tegra186-gpc-dma.c                | 433 +++++++++++-------
 4 files changed, 298 insertions(+), 169 deletions(-)

-- 
2.50.1


