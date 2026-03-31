Return-Path: <dmaengine+bounces-9759-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EBndISiiy2kUJwYAu9opvQ
	(envelope-from <dmaengine+bounces-9759-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 31 Mar 2026 12:30:00 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F117D367FB4
	for <lists+dmaengine@lfdr.de>; Tue, 31 Mar 2026 12:29:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7F6FF30AF01F
	for <lists+dmaengine@lfdr.de>; Tue, 31 Mar 2026 10:23:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EFDC3EC2FD;
	Tue, 31 Mar 2026 10:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UfHtwNlY"
X-Original-To: dmaengine@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013028.outbound.protection.outlook.com [40.93.201.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A5BA3ECBC9;
	Tue, 31 Mar 2026 10:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774952626; cv=fail; b=Wn7G75HKqqyDqPxSbshQB6N//zw7GXKKwzE5QFUZmKRhCEG+xZUif3zde2pRfjfYTSPp2Oov37yk66LjUR0aFaoPC3aeUM1Te4xP52kIVuOpADsYukMhQYDen3wDRqM9WuR90lIm4b/tGIYnCOJSFeJ7W1R8CPVYTEBy6Sa/UF8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774952626; c=relaxed/simple;
	bh=HqlDYU4R5VgeUJDHw8pwswcr/ODHrPkaCrY+8bKAbTI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=EKtZGVPaZEPrl3zsqzTiLj87VgKR0zPA/ylvru40NfgqiiDRADolYsfMACyl5iqcrq4ioz/PAfxg7OfNvMGdC4VpX2ti52+c/+8pYHwAh+7GY5SWcJFgpQYQKRX+lEgejh53JFtQ9RJdZ8pGuQlfPzXUoAVByAPZDaGmWTYuYFw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UfHtwNlY; arc=fail smtp.client-ip=40.93.201.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l+tyzWzb9uF76RA94DGhwBkAFvg7W6t+stNUAIurI9J7CvXAW4pPo9GGb/XkSJEOXq00zsAPP6eFH7nPW6aKTn+5jE3yRNHAmaCXORf8BHCwJdfaFFw7pyiTftTIp/996U+oZ1ahc1i5n/w2oRUb31ZM+2Y7dX5BZwgOwrPGpz5sAwR8si3Jx0aAhIs8GD1oVd8EehUFyh3owcTSRP4sKFDgkNUWZ3MeEraqSY2/vZJjBsf7iTPmbnu5Gu/0PzOQZ3K/qznr3RItVZaZCPMb8L6i/1bqVxUWigXPjztkRI9sHnAM5q+OaXh9S294/AgWVo/n2rf5GqUZcxEWrqbkGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7oOVt7b57OWi3+np5eRq0wnSkReBR2KVM6pf4nooK7c=;
 b=cnPz7B6EczsNKOisWju6R+rgcPdR1mFrzfSko0stLGVyS4RvADAeT5qGbaqeo48q7kYc0FeRHhB179xM9mpUKq8bhrO4e2pGW9eHT0KxTXfvSUcP7pxKfMgftbV3wj0jmVQKWkYvtCPz9+01qrnfEXvVloyWSohyV31+te74ijU6oMaHkLW19n4h1Fp8jfsHLcAuw3fgZ7xwcdF3hiTPg+RpTNrrzSKYBgKR/fEHIZU/t/RMfGMe8NKAHx1/rrQhPIU9qcWY7N/czjYQxf+0euEagg/x4DMj87DVujS7TZzTZldJr/fWl7bSGd0jJZWPKT7zQXk7Cuqf9Lz4WvQO+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7oOVt7b57OWi3+np5eRq0wnSkReBR2KVM6pf4nooK7c=;
 b=UfHtwNlYl/6O16P0Xibvob1MyMPqaGoKYJpORL/59FPPxDBYu1kqQ+3IUqdNewwUIFQ2cE6udaKK+6Zl99tk4mPTVmbkxjyK5Ai37/9Wv2LUgy/8UIzs20TbRGgD9dPzUGi68rt20CTNzJT7QAucxLUNC+E7Gjw6qMJzYxyLgtT0Hy4BArS5W0WDbPEi8v0+wVc9YW8Cw5cdfg7qv4o2T6xAYqYUxzdkRFbz/67h7d3ZrgUnqnYKuMIgH9rgHfMLXvx2E36GEh1EbGnfmHvwncHWVo/TO2nlf4esT7LsnD8ZSTsj2cU/DaiCUYfreWdizmrlmoOO4jJG30La+61uuA==
Received: from DS7P222CA0005.NAMP222.PROD.OUTLOOK.COM (2603:10b6:8:2e::17) by
 LV2PR12MB5751.namprd12.prod.outlook.com (2603:10b6:408:17d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Tue, 31 Mar
 2026 10:23:38 +0000
Received: from DS3PEPF0000C37B.namprd04.prod.outlook.com
 (2603:10b6:8:2e:cafe::75) by DS7P222CA0005.outlook.office365.com
 (2603:10b6:8:2e::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.28 via Frontend Transport; Tue,
 31 Mar 2026 10:23:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 DS3PEPF0000C37B.mail.protection.outlook.com (10.167.23.5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Tue, 31 Mar 2026 10:23:38 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 31 Mar
 2026 03:23:25 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Tue, 31 Mar 2026 03:23:24 -0700
Received: from BUILDSERVER-IO-L4T.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Tue, 31 Mar 2026 03:23:21 -0700
From: Akhil R <akhilrajeev@nvidia.com>
To: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, "Jonathan
 Hunter" <jonathanh@nvidia.com>, Laxman Dewangan <ldewangan@nvidia.com>,
	Philipp Zabel <p.zabel@pengutronix.de>, <dmaengine@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Akhil R <akhilrajeev@nvidia.com>
Subject: [PATCH v6 00/10] Add GPCDMA support in Tegra264
Date: Tue, 31 Mar 2026 15:52:53 +0530
Message-ID: <20260331102303.33181-1-akhilrajeev@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37B:EE_|LV2PR12MB5751:EE_
X-MS-Office365-Filtering-Correlation-Id: f9c479fe-634c-406b-7079-08de8f0f92c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|7416014|376014|82310400026|1800799024|921020|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	FJE2+Sp8c/f9F5kc75KhP8QAAD3Q/Vg4OBsboM4EzALPvX/YFM7SuBBKNcqUa/Kfh4ks55HqAu5sPaAHCYZSXlpI3moyQHDGFpexIJvaVEvn1WIQRfwOKrhw4LVY+edGnTmcmn3FKRW8sFKvmArIRisqKzr7s09/0YscMOFrJ5ywlU1zEB+Pq48PkpDOpHzUzn0h8COcdZVgIMlxVL3zNiTJwZDUSapr5FLp0VXdbp1GI3HOGOOvlCAuGV+XqWzh/1BkNxE5CEt35KaPycncsKRsRtqYHWx2/QybTdp3Hs90aByfzDZu5T6Ot0+4TcIQpBsbNXSV8hbb7Iw4g26tEDN6frh3XZOSF+4f3s+nZmqG+Zaan3xYin4/dU7hZzpGPsfWQ2GBjccI9illNOOjiI837FIAD0IRmnIpSMbH2GAPvY5ruqwXTgpEYSpWjabrBzu5VGk1mx4qujHlyURJl76OQEry39Ho4jotsfWv5yz7VXyfInoFfd9FywuMttVljaBkMedRkxp38klAIAPZ6KFIaUQveQeH4bhrAs3wGREFxI10IcEvQVYRERkZkgeF6Nm0yoHM4mogFlMQgLdtGK0knOEI972Q1GN9R7DVAEdsUS43Ynfmay8PdXxTHQUdWcZe4gSc/tlwAqm3fiuVOhJlRJUxWi5T1NSYbE0XMb+Lt7/5JPB8jaIWG550nFRc2l4zlqOdECVOLmyNt8F+oKTEPWnUbtmCDeI1rP8wwnEDn7DCtT9kipk8ceGAQfcBKF2GfiMhIdh+Rj4vjQG1ajvceuOaqYP0f0ZOpg1YRKoqvuJTCw2js0WKcBwlDZ+o
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(7416014)(376014)(82310400026)(1800799024)(921020)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	sCfcIZ2Mvf+ud22pgUVzJhJ6JNIiVPoUPsGQ5tf8aDheegT/U5GiFK87tqpde/vVexdtIW9PQZ0x3xBEdo1aV6hDeAQpQqLdxhoABXCVBiFp3pIzzXYtkXVUE86/h2rDYa+LQu1xwhZ/4amvcoYfCgfX27jx7bGPwDAVo3FRKFTabt2wHctG7Llcsk4zTehN7cD/2nBHZEoTF1Cz/Fhw/J1yT7VGlD/AjaWEDvsg/rKZM7HnkG2rr6AIXKsxNiOusu8pss/P0T6Rx6haxLSQ4NguBYvZnr6r9TnwMp2XbcrzkqvzyVPsMTH6vy69Zg6KB411osR1KQpsG0qzOW4g2BPn+lM8CmLVpq+Xx+VcJ3p96lH3NSP0PoGrFRoIKH7LwEaUTH+2iWuekj5yPcWyqoBSmuRWPRKeeq74aR4VwiKRX+opsXe1oKmwQXIqd3nM
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2026 10:23:38.1123
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f9c479fe-634c-406b-7079-08de8f0f92c1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF0000C37B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5751
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9759-lists,dmaengine=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,Nvidia.com:dkim];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: F117D367FB4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This series adds support for GPCDMA in Tegra264 with additional
support for separate stream ID for each channel. Tegra264 GPCDMA
controller has changes in the register offsets and uses 41-bit
addressing for memory. Add changes in the tegra186-gpc-dma driver
to support these.

v5->v6:
- Replace dev_err() with dev_err_probe() in the probe function for fixed
  return values also.
v4->v5:
- Use dev_err_probe() when returning error from the probe function.
- Remove tegra194 and tegra234 compatible from the reset 'if' condition
  in the bindings as suggested in v2 (which I missed).
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

 .../bindings/dma/nvidia,tegra186-gpc-dma.yaml |  32 +-
 .../arm64/boot/dts/nvidia/tegra264-p3834.dtsi |   4 +
 arch/arm64/boot/dts/nvidia/tegra264.dtsi      |   3 +-
 drivers/dma/tegra186-gpc-dma.c                | 429 +++++++++++-------
 4 files changed, 284 insertions(+), 184 deletions(-)

-- 
2.50.1


