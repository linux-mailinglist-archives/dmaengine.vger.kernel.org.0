Return-Path: <dmaengine+bounces-9441-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AAQuFPc8uGmpagEAu9opvQ
	(envelope-from <dmaengine+bounces-9441-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 16 Mar 2026 18:25:11 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C865329E201
	for <lists+dmaengine@lfdr.de>; Mon, 16 Mar 2026 18:25:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8C5543042D58
	for <lists+dmaengine@lfdr.de>; Mon, 16 Mar 2026 17:19:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73E8D3D16E1;
	Mon, 16 Mar 2026 17:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="aY/hGG0b"
X-Original-To: dmaengine@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012068.outbound.protection.outlook.com [40.107.200.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 354233CFF77;
	Mon, 16 Mar 2026 17:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773681537; cv=fail; b=Vwl0dZKbYA+g8A9323q3k8+qFmKIhmVlQMSx+DMnmUdlpLhvYsej5sC630y+GzSs2RsFbUurxRwWExvvo8ClCbzUjYGM2c5oHlf4rdLxoLrFlGv8xidFJ8whXYRhzeo3ImJCPWj4xm6GtMxGyg7ILcl6N/wwnR0WPbysDNqilVU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773681537; c=relaxed/simple;
	bh=WDezFrqY2aCy3mvs7ctp18YhmDJhwY/EGy5iREHZ56A=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pNm5luRJv+4HzRo1Sl/uR//Zh03AqM8jLa2/q8wk0a7BJ9nn70wUj3guN5uTUml9dO3ZBJuBji0J1JEW46G6ycfLsEW/z8Edh7Y+idn/WmQgrukhOm2oJH/p4dw7eC8DtqQyGh7XMV7sJh0GBaqoPc9Vkvkj6JiIiIh61WcXOso=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=aY/hGG0b; arc=fail smtp.client-ip=40.107.200.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LEquTrzkHCiIQqG+hch8RHGHOnBzZFAfMo2yDX05hJy1GQ5mjvTDeEkjKfaSK1LLRqxpV4P6p5UEkhnniZ9soTZ4dj3sssbv5DaJqCdJF1qI7mvdULepCuYrmiMbw/56/P0YoWMCyzCu5/BC3X4CF3mwXeovyPpmGiqQy0JvURUihPBE++dTo83CnBSxKlaw7hxhb0Y+soHQQ17e6M2KmuGaDIvJ48479Bi5Y3cKWZey0l7p2U5oU3KvnMvZdyDXu0IVQKeYuryI6j+RfqCYcV01XUnASwTk6moJ6jcM8Abyle0Ib0IqALeWbJIIUCKTnD9Ge0x5vSlqVOzBhL1Z0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kMqINYWh003YWfrB14EqJYerSwvLT2SUMy/ZCvG9ZPU=;
 b=uYfk4LSK4XNB6j8qwWRlbXtdDZTVl2rnWnaFhQr3SrEyt+w9HVkJ96xuNr/AGgtaMyEwbaFjgt7iBKKMg+O7F0hOyM+Tc03lddutD2XCxRMMpEWXQNA9ct7+tjqgm+hY0dd5h3J+4dcQzhLH61KKQ9BPXLZKtZEZUFjvQGtF37smjfevPj47T8rPe9kWJhpyFvwp2PaWah6JBZwNd12X3Q7z2ar2PqkG+0PDIIyAU+asiKcuMYajlkuP6+XjxqVLpbTS0Tm5TmEoKT3W+d7IRFhlEzigA8810fH7zAJycBtJdRgC7D9qDKuf8jeo2dzM4BLhproldzo/p2p5fINwVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kMqINYWh003YWfrB14EqJYerSwvLT2SUMy/ZCvG9ZPU=;
 b=aY/hGG0bAPjVgzTSeNXh6a39wHtKNcnQYzcOqbD/ZgaYLjmW5kbQJctkIWbINd6SL2p618lla5+5FSJulta8vBFJABD/zRTh4OsHDY5elmEPP4+ANhidYgWSnHv/QdULgfx/ijPRnCGrSf8dUsLF/2UL7jt50lLDE/7d9ZOGxbfdSpvwi1ezEGMy2mMLAVkzqhEeEnFQaDUx13OMLeY9lkj8CHD/PW8Q6JdaLnvir1HTAGddKcvLhL3Ozy7mJh076nKRJunUaaEn0nZMqITEqWETc1XCM9UfoJ8pckav/Fy/4FG0xfKXJigQeU3263Y1Rt+Nn4ued9QMCnHO2hW2JQ==
Received: from CH0PR03CA0044.namprd03.prod.outlook.com (2603:10b6:610:b3::19)
 by IA4PR12MB9788.namprd12.prod.outlook.com (2603:10b6:208:5d5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.17; Mon, 16 Mar
 2026 17:18:50 +0000
Received: from CH1PEPF0000AD76.namprd04.prod.outlook.com
 (2603:10b6:610:b3:cafe::a4) by CH0PR03CA0044.outlook.office365.com
 (2603:10b6:610:b3::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.25 via Frontend Transport; Mon,
 16 Mar 2026 17:18:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CH1PEPF0000AD76.mail.protection.outlook.com (10.167.244.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Mon, 16 Mar 2026 17:18:50 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 16 Mar
 2026 10:18:35 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 16 Mar 2026 10:18:35 -0700
Received: from BUILDSERVER-IO-L4T.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 16 Mar 2026 10:18:31 -0700
From: Akhil R <akhilrajeev@nvidia.com>
To: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Thierry Reding <thierry.reding@kernel.org>, "Jonathan
 Hunter" <jonathanh@nvidia.com>, Laxman Dewangan <ldewangan@nvidia.com>,
	Philipp Zabel <p.zabel@pengutronix.de>, <dmaengine@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Akhil R <akhilrajeev@nvidia.com>
Subject: [PATCH v3 0/9] Add GPCDMA support in Tegra264
Date: Mon, 16 Mar 2026 22:48:14 +0530
Message-ID: <20260316171823.61800-1-akhilrajeev@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD76:EE_|IA4PR12MB9788:EE_
X-MS-Office365-Filtering-Correlation-Id: c1eb1c2f-11ee-4bf7-4d9b-08de83801738
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|376014|7416014|1800799024|56012099003|18002099003|921020;
X-Microsoft-Antispam-Message-Info:
	GqP+Qf3d+9yfqoAuSnUbxiFtOcRatr0rXW8nnhDFZZKU72//l/e5DUCZeAeJ14aRjkgl6JTgXQdzo62l7MS6RuM2+VrwG92bINvfVvrpgb58vUO7k+9rZ0gj3ICProzhezYE9xuDnQxbUAlMt9Xi6K30/hSzrKrezs4V27dEtsiq5+rtbBC+Dz4IwFif++NjD+OwSYQRC2WUT1fDet8U2MMtru6TH4rHaIOeLiezK6290WuEmPK8bALpI24Tqgdk21aXwGXGwOyewOzPIKYyxa/ASWVYbkfzVSP9yo+Uvq9qH4GOWcXyLb8QzhiM7APMtJpdj+5Osc9lUOFVY415EhPKGUFiDpbGw7pvqOCnF7IUlp0JKlgzReyi/0336Qdao+w85iJVEnD2wPZif9iH9WSMJaSy5lKxtYOV1qVxG5dXwLBmw+qgD4Pm6oahvQg9PKcqs9vAHLloJjm5bpcA/q+v9eGBRFAqhR9vsbl32SFSxADhYOMidxsDbNXPI2r2tiDORLxPUvvSPnHYwtaOFmOC6GR7ynbtgC8LbNI63ZWF/62DREWB0VmAOxJD/gPtqRgwQ4x7Qs10XyWfVAjCDSratjNq+bOCSM9qnOFecaIAshs7u1nC2VZUzKHyMvUfYTa457s+JXM3Bh3P3TidNrmDo/a3iUwbLOMzAE32gQNteEpqamRMPGdvNE5sKSn3SzW6TkmsrHPS+eSPR277Uwg8Box8zEafgU1PEPzkUf3cPB2Ju+nBsYertEdYRs5+Xamg84URz3JzqW4TVDB9jPDlevcLGk5BtQ9qY+m7Cvs54LzhQhBRYYyapO1qV6Wc
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(376014)(7416014)(1800799024)(56012099003)(18002099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	FisliZFk94Av2Iu2E739GUUoc8xo4wp+Vq1xGgDBaAoqCqEBqOX3RssQ+E+s7bdJfssjD24E5wYA6G5gz/FctJkG5hEPi+sF/KsCOS+BtlgpKlw3nwW8pTxJogr5BLer4jRmOkeBJonSfaWSxgNdO1H4amgUu+uS8FA9vSC3YMJZvBURXWfwU7q26RpoME2iWAdgk245FwIgDCE9i4pRZmIKktC1ZHLd1eRO+5m0wlFJUpL0FsqbPlk6MEzYDhuVpEg38uljurnATJbK/10/RP/IXL5j1eNee3FULAU/I6fH+tOUWjoSP80D/pe5Wb8+gBOpf3DZIYvpcfJ9B588Sj8iuwJ079n6UwwUDeo9KITu9zaMglFYIZX0CCG7NOTcWyJZSyTQyK6HWWcTaOUen/SHPzCpmyyGdEBWAyb4HcsQIwqEyqt9nooR6xL23kza
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2026 17:18:50.0305
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c1eb1c2f-11ee-4bf7-4d9b-08de83801738
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD76.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR12MB9788
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
	TAGGED_FROM(0.00)[bounces-9441-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akhilrajeev@nvidia.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,Nvidia.com:dkim];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: C865329E201
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This series adds support for GPCDMA in Tegra264 with additional
support for separate stream ID for each channel. Tegra264 GPCDMA
controller has changes in the register offsets and uses 41-bit
addressing for memory. Add changes in the tegra186-gpc-dma driver
to support these.

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

 .../bindings/dma/nvidia,tegra186-gpc-dma.yaml |  34 +-
 .../arm64/boot/dts/nvidia/tegra264-p3834.dtsi |   4 +
 arch/arm64/boot/dts/nvidia/tegra264.dtsi      |   3 +-
 drivers/dma/tegra186-gpc-dma.c                | 435 +++++++++++-------
 4 files changed, 292 insertions(+), 184 deletions(-)

-- 
2.50.1


