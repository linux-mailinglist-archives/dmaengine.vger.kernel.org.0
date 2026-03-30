Return-Path: <dmaengine+bounces-9715-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GJXRDYCSymnF+AUAu9opvQ
	(envelope-from <dmaengine+bounces-9715-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 30 Mar 2026 17:10:56 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D2A0A35D85C
	for <lists+dmaengine@lfdr.de>; Mon, 30 Mar 2026 17:10:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C2C60304A6EC
	for <lists+dmaengine@lfdr.de>; Mon, 30 Mar 2026 14:45:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55817323416;
	Mon, 30 Mar 2026 14:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="D9/BoSDU"
X-Original-To: dmaengine@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010065.outbound.protection.outlook.com [52.101.85.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1EA8320A34;
	Mon, 30 Mar 2026 14:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774881947; cv=fail; b=hPneiIXq4AElckh/cIPusSNW0b3KrvxErLgvYbOCYTk+Xg7KEIXpF8cqFvX0jeqQpGCckGMWv1/s3K5EGRb/b8bXKvq6dKNblAmhlJOpRRwilOsawQ10nBftT1OYd6iJMS0SybsuF+6gt4udlOcnWxrYLyZ647f9mkweGlhDnSU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774881947; c=relaxed/simple;
	bh=mkYuKrdPgpV/mWA+MCYWafwmmI0FohOpz2xfIHnKgZY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=K4abMRxeBNDsr0g5mfbLeGkrMyK8kNgWXlo/VNmFC1oyfIzIp7ZiUGYVf9g2OyxU5alSJU0LtCVOrPqu44bRohAuPHQJ1MV2SbuXqhwxSixJfMkge66R/UlYilocSkuLcO+1yjboeZ5POafJhbse1qIvCsc0qc6GWf7NmXf7aDI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=D9/BoSDU; arc=fail smtp.client-ip=52.101.85.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vOXiKf/JbDAPYoreyXgc44SP8KQ/2Rnw3dCP2MgfJ2dTURNajVAZa5D4Q7YcdZ2zJLMrQ6yOulCzT0kBUnrsUulGKje9BH2um7uMc0mdOqZ3dgRvZWlA9dJTd7rHOtKE2vH2RHm6SphMfkk1Yru81HEc1XE/p766yIOzf9A3PgVqfe48K9UAV6MhvTo5O5E6y6mhxfDOIRJ8GpluMinPqCauoHLJ7zMU/JXpyUI5LRHb0iZRbyHXcHP5r6o2MQgESuc7RfHPQlgJf7MjrFvp4fvIMz49W63xIWf+SHzOYJXE3ITQLtmsjgjqwR8Rn+g2N14OAcxyRP7GYCDtMmbRNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TihfDJmp3q5xhK35P1FIFymlMOxRIWTci0AbNRvAbxY=;
 b=wYfKaYHAVpbMpzshfH9jXBOmOwipT1+8Zwpp6puyCoKNbTqHaZjIynxiTpSoZMZq4PrIcUqZEV0eTn6fsrfi3/2HKHsn2FS/eGgd0YwY5B56vNYDve/gAscbipuOHJZ+tLK97Yy7WOsjfo5GUfh6zE+V9eyWIn6uT+gTlvzJJzoAZkQ7QIVz7fip79zXNXIdquTPim3WKtI4xlh15AG5X08d59qyH72CUr+O8IHdVSgSN9yzxCSocZbiyfplb9EJJ/I+/UD3pJ9d52e+yUvEPrwOGmdC81r1fLcASpIUh5BSqDWjPjoAdusCJT/zdlURkXO6tgUXVaqJCnSsre42gA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TihfDJmp3q5xhK35P1FIFymlMOxRIWTci0AbNRvAbxY=;
 b=D9/BoSDUyknUyrPtW5BL5whWezT6cd+KYTboBK5Yn+ZLY/eKryQsVMBczVeG7kFfQtkrbaUqfkQhjWlEtI7JBo/hnpsT1ruoMKsabYBj36vG6WR+tppN5ojXDRwnEb7GNDCJLFMk7Dfubv0Wt6z1O4ry4qIXBpPlZLn/tot5If8mUHSGeJ6M9yKaGjCK4zSR2/9om3uUPTbaFUexI4Dx4v07XvGitdSRANcerxfKxoETYRR2/3fXTm917uCYkthDtFkAi8b/pzjUwkZIGEuo/iaNJJlp2oGZGRxvM1QjKqeUIGuwkkP5xjlQEh0aZbX13f0yHTMAxgwgkT8d2sFcaw==
Received: from BL1PR13CA0374.namprd13.prod.outlook.com (2603:10b6:208:2c0::19)
 by LV2PR12MB6013.namprd12.prod.outlook.com (2603:10b6:408:171::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Mon, 30 Mar
 2026 14:45:38 +0000
Received: from MN1PEPF0000ECD8.namprd02.prod.outlook.com
 (2603:10b6:208:2c0:cafe::19) by BL1PR13CA0374.outlook.office365.com
 (2603:10b6:208:2c0::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.28 via Frontend Transport; Mon,
 30 Mar 2026 14:45:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MN1PEPF0000ECD8.mail.protection.outlook.com (10.167.242.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Mon, 30 Mar 2026 14:45:38 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 30 Mar
 2026 07:45:14 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 30 Mar
 2026 07:45:14 -0700
Received: from BUILDSERVER-IO-L4T.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 30 Mar 2026 07:45:10 -0700
From: Akhil R <akhilrajeev@nvidia.com>
To: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, "Jonathan
 Hunter" <jonathanh@nvidia.com>, Laxman Dewangan <ldewangan@nvidia.com>,
	Philipp Zabel <p.zabel@pengutronix.de>, <dmaengine@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Akhil R <akhilrajeev@nvidia.com>
Subject: [PATCH v5 00/10] Add GPCDMA support in Tegra264
Date: Mon, 30 Mar 2026 20:14:46 +0530
Message-ID: <20260330144456.13551-1-akhilrajeev@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD8:EE_|LV2PR12MB6013:EE_
X-MS-Office365-Filtering-Correlation-Id: e1156f02-65ec-47b6-c9ba-08de8e6b028b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700016|7416014|376014|921020|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	QvyGY+X31k2mvSaRpDmsgFrCL0Wrclu4C8T8oyNJruWOReCXVfRyT3uIHZV1JhcUpHFiq9xTIPX0RkSs3+Yu1OOH2bA2PLQ/j/YM44vT5SrV0gy3qdPIE+FHIGR7HvuUS6bvFfDkcEPUMuPwCp3w0w9dYPaPwZ5GuBOjqF+FjCqE0vRaqFDBHWqVVS5O5pre2SL77pgo5puC8b3cq1A3nGsWLQDpexGQbY6anU2is0NLWJ/UIQXioGz4wU+BIQ+JtBX3MJZAt9eXuHwd91e2/58adL9SHgyXyEomr0+Xa+8eDSvEQzZOwuXIPWcUHnou3+62xHKjekInuic4seP73ZWWq5BIqX5r6KRMtIR572mbTOvso/+BFe68xQ/mhDaXh8Yxiy8pXsNYtOEEiKBFYdtIepK9ajjbT65XL2RfkK/Jxe00OdkxaTkFjXn8RUWJAeHDLwcRbFiVzLdLKWjm45ORsuCptrIcP7sChySiHYlk6YdPD4o0sG9H1BrZ/H37Md/sOkLHbkUgtG4bG+cfBMyWiuWxybsCZu6jx2R7j10xPLhQUWAkH9bGHbW7pPeB+38lg/HB6zltvTyHO0fiCbwJae8WJh5dexqOACbIxhju21WS0pLgkb0Z3je+4E3RKm1bbHZ1ui9pJdkfDaKxW7u4ms7p2gzGe1RH5Tb/pSBywk7BfoY5gErNtIZkmDwha8Mp6rTgdtNDybRI3UeHArTkPZ+xleXrQ5G3W7AjI96u3+OtUz9YpUgGfXOCmHNA/75LUL0jhJTOzxYtNXu0+uywEITxoRX8ha5i+Fr1zYSSPHtCzzAWIfyqJWAaVfGw
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700016)(7416014)(376014)(921020)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	9npI7aEpyqlGg12J8tIZ4m3eR4RxUGLmAmtjub9nj3AalPoSkPkW9D8hhj4XUcO03cNde5Pem1HBtCQ/4fXKnCsYjsPmEAUNWU5MOJQevd6ovBNqf/pkFjbnQNrODu31X4DFsVNWX/rK+/JJc44RfRWy1bK0mhoEVSm8+P+fnI4Mc5+8AqrzVKKLNIyJYYLlMSo0drpsO2pkIoWTCYZ+cJcZyNlud5Pp6oS35v7B2WRsItDnwt5BEPG4or9d5uWdvjrsWv+9kxALSUdXNGdU7V21uBlKd+2hDnbEmDzMJ8n94Pe7fDBmKoxPKe4SZPITnXKYyeNmxwtbXFbtt/+WHR5Fy74FKOnkK3kb/tlvCfgWuvNespAgxtXfyVZ/AYiR4TodzEw7ZAygCe4TJPHsLkVCLu9CgDf/qkzsZ0y9G0/GZB0B+4xKciFno9AwL8k/
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 14:45:38.6728
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e1156f02-65ec-47b6-c9ba-08de8e6b028b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECD8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB6013
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9715-lists,dmaengine=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,Nvidia.com:dkim,nvidia.com:mid];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: D2A0A35D85C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This series adds support for GPCDMA in Tegra264 with additional
support for separate stream ID for each channel. Tegra264 GPCDMA
controller has changes in the register offsets and uses 41-bit
addressing for memory. Add changes in the tegra186-gpc-dma driver
to support these.

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
 drivers/dma/tegra186-gpc-dma.c                | 433 +++++++++++-------
 4 files changed, 288 insertions(+), 184 deletions(-)

-- 
2.50.1


