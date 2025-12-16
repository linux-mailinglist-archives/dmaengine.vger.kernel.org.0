Return-Path: <dmaengine+bounces-7661-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E6C0CC339F
	for <lists+dmaengine@lfdr.de>; Tue, 16 Dec 2025 14:29:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 552543085444
	for <lists+dmaengine@lfdr.de>; Tue, 16 Dec 2025 13:25:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECED63AA191;
	Tue, 16 Dec 2025 12:30:35 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11023082.outbound.protection.outlook.com [40.107.44.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD3C13A1D03;
	Tue, 16 Dec 2025 12:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765888235; cv=fail; b=pPNjYpiA1qi9aqR8yNfdelqtLqsihMsu8l+XAXzizYyfLGMeCXvOCn8e/k8HQc7YMcn9K6yJd2rafvx/+a45GCF3hQXm/tl9mwFPbejvmzhj1406Oq1rdMrGxdFDW6fHra/fjMoQj4VihzZf+bYWT/ezXLxA9Ck3Y7dKBZwWKYU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765888235; c=relaxed/simple;
	bh=L4c6Faz8r4wne0qHIuyoirNmBwlNY8XrZo5D7PV41Do=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=UJE5CKRTZsBMliKMhBIm5a+q6HkJn6E07nPo2wGiYzJiyyBAJW6PZ5uZU4nkBxMq0jbtx84zwf83mB4Uh5FTsJzmS8SFM82GKfafvaESYFs+Y1K7Hgi0TQSywQJDbhT4Cdfu/OpRf2/YMnRfCaKoNRdH44QgoV4ZsMw1KKjw9uo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=40.107.44.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vI/A8orfToHPaODI2tNgjv+NaPgAU4YUnQU4xaD1HZzNV2BGsKEZnFfGJkN5AHKnENUNSA3xgEiVbIkyWO2Cnn5rWNWPmcM/vIaGajcJDFLH6FoaVgSfxzChPy3+j2U04Q4UUVboS+Od9Oe+JF9zeIu/F4YGqdQtTkXCZk7zIgox/VkcDnvFras2RHZ3tGV/00PhVjdcGBvgfTbC7OtfVjSyB0HIFkKCPHFg9arHk4ZhmjgYQPn603auzZLaaQkiyUCFFhj2NVQvc7piAbzDibGOAImHrZ8ZuuPzbHS/DdSahO+YLlG9QKynjAY1Xyo8wSxIPnN9UrCk4rD5AsNa6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vYCnl86Ut8GCmdwuCi/7sC/CFgv/BMq396WfwSMOY1c=;
 b=y1ogTK1rx2tdxACgp94hpSr5/AKCXkd7eFli4/Ca4Tit4EpwX5q6GjSsCp2l+wrVUbPtO89VkC9uU2xXMA9lb3kmpOFLxX3elw9Xu3x/2M+q+ZdqWTu7/okYlmoGPusOydbHAdZrPsb1f6iBZxWVoaKLmkv6b1LB9BSKfiT6sAIiPuTVhBvTNhmcmglODWybvazZHtDBsbCK9XFvLRqaQsp1lTFo7jTgFqTuC6NSm8d3zSkOw3psfSCbwYdl+ISx2bZuKSARgdC7j30t8ukZQiyoE7HSIFbCZoUeQkdJdV0MGrhaVPhphMJNwFAgZLimF/rkNtakeqM4ZFYsyFvjkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=arm.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from OS7PR01CA0119.jpnprd01.prod.outlook.com (2603:1096:604:258::6)
 by SI2PR06MB5140.apcprd06.prod.outlook.com (2603:1096:4:1af::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Tue, 16 Dec
 2025 12:30:29 +0000
Received: from OSA0EPF000000CA.apcprd02.prod.outlook.com
 (2603:1096:604:258:cafe::6e) by OS7PR01CA0119.outlook.office365.com
 (2603:1096:604:258::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9412.13 via Frontend Transport; Tue,
 16 Dec 2025 12:30:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 OSA0EPF000000CA.mail.protection.outlook.com (10.167.240.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.6 via Frontend Transport; Tue, 16 Dec 2025 12:30:28 +0000
Received: from guoo-System-Product-Name.. (unknown [172.20.64.188])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id E008240A5A13;
	Tue, 16 Dec 2025 20:30:26 +0800 (CST)
From: Jun Guo <jun.guo@cixtech.com>
To: peter.chen@cixtech.com,
	fugang.duan@cixtech.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	vkoul@kernel.org,
	ychuang3@nuvoton.com,
	schung@nuvoton.com,
	robin.murphy@arm.com
Cc: dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	cix-kernel-upstream@cixtech.com,
	linux-arm-kernel@lists.infradead.org,
	jelly.jia@cixtech.com,
	Jun Guo <jun.guo@cixtech.com>
Subject: [PATCH v2 0/3] dmaengine: arm-dma350: add support for shared interrupt mode
Date: Tue, 16 Dec 2025 20:30:23 +0800
Message-Id: <20251216123026.3519923-1-jun.guo@cixtech.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSA0EPF000000CA:EE_|SI2PR06MB5140:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 5d585da4-c115-46e9-84a5-08de3c9ee59c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?km1cN4dfSKCDuyr3aJlEu/DD5hPJLccNUQrfwZDuN5AW7yIkIjGzypfqtjw1?=
 =?us-ascii?Q?mA7q7EXSIWJAkcDa9aSUD0znJthKWJ1O27JRmdIcXQbJy3tqd81jSISyLue8?=
 =?us-ascii?Q?pDFu4+aN9DNOKrWby73Yd7lDugWCI2N+UAa7BxtKkIkuOnZSvakMcDZWtpfT?=
 =?us-ascii?Q?BFCGZE5ZZPwBa0MXL67T7yH9qYS8+n25j2T9dQ+BKOS+aCqNKJq6tS23f2yq?=
 =?us-ascii?Q?eyoO9Mri0gxBDs9jdEu/3WfUx78O6/OKCNi575bHh+mbxuMYtWNYhxDyKjDD?=
 =?us-ascii?Q?bUrA2yMwl7m2qzutzMYNfD6XZAY5/hKHxvf3Jt1oQLQbsXkv14pG7iC9gxOr?=
 =?us-ascii?Q?C2RxM077wNhYnKs4G7hERGEpmOppoxGVwajHozRWhoJmEuc21XWFqQTzYweP?=
 =?us-ascii?Q?fgBVImwfUisVGrrS5HuddY5qWoiWtLCT9wRTEpxloL+WLEC50AtH0WQP2zL7?=
 =?us-ascii?Q?8W6GWm4Irzjqppuii8+WYpJ0nHeGHVObxCJZNSgGMLZiNtFUsRTIuaDq31+8?=
 =?us-ascii?Q?al8KldLiEaVlq7rMX1w67yoccJGcpMXdlUYjRIsvZx73izQpHjEwLUqXHf4K?=
 =?us-ascii?Q?RmzeCFOTJ9h9R8zprxryH5Aw7J5K1PYhgZSeWMKHVCbO0oduGumiiX2MeQZJ?=
 =?us-ascii?Q?y2oRJYyThVlfrsg7U92yBPiDtDcZ69iDUoMikWd93n7xw++3ihN/nf8Hhkue?=
 =?us-ascii?Q?BGX7vdXlTeJl9e5WiAmYZXVg5g79/WzLEJCs9ZwBUjEWUpRFD8hW/1QsLKcI?=
 =?us-ascii?Q?4VzgMCrcpdJvKDWkGq8He1Qj6jJYGqdhDZXKineyxOgUd/p/US5Z9dNfWKi1?=
 =?us-ascii?Q?qSrs6gB2dJA1IaVUhE5N5/bBklFEQ4+4TUu9ms74Vnd2LZz2o8lCNIrWcSk2?=
 =?us-ascii?Q?DZAnB3Kgjy+1kWeMXRa4I93QjG4NG1MJqAMfGdIlqWENR1CJA7b/w43BtoVO?=
 =?us-ascii?Q?Oqr/LwWK7rTjpXFgLOHhYy64kO6uo8iW/8W5XBvGV+Ga2kKhVFQ8oRJQBRBi?=
 =?us-ascii?Q?w/BlqCj1TTe8FTRZn9xUeAvAnqReYsShfUsLMGOF7Idvim9cpIRTK0KSbzCf?=
 =?us-ascii?Q?AHZXSUVW1moW+RKI1AZRKos8PPfm1gQe5gx1SQEkZArgzN2Jn6ObCWWfLoHU?=
 =?us-ascii?Q?7MO9KdSX/htuS1G14Xhlwms9cH9GMOX/MpuE/zKrTL3OwxdpQWKhJrN6ePZ3?=
 =?us-ascii?Q?jh8HYO7+7a3i03bQaNrSsvO52ItkRuYo2rRQbLqMrkd94m4cMzSckkTj1Qfh?=
 =?us-ascii?Q?SwsAtlKrRyxNhQBAvOZp6WT5Wbp71pvuu3jxbB8XqRNxaQQnPPfrA+i5HAMw?=
 =?us-ascii?Q?HFKpwIW+t8iFIoG77p23n+dcx9SStBs/lsUn5JPi59JypTNgnrDhUypCYrqC?=
 =?us-ascii?Q?ipers0iESHglaagJED0P2AsWOOxbPI7DueoC3PsyiES74Jql6nD9Ttp89W6z?=
 =?us-ascii?Q?1KJ/dYAcDmTTQjWXii69Q8EpOO6tlV6lDc8Vfn/ls5c0s4JDDpCjfokSmsUo?=
 =?us-ascii?Q?cBXGS2LjTT7KGZKhq7B3V9at3IiMO7wEtZwgLxjCFlHImrbvZT1gyxAgq44a?=
 =?us-ascii?Q?IVf5swDTGOQUIooYoSo=3D?=
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1102;
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2025 12:30:28.5379
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d585da4-c115-46e9-84a5-08de3c9ee59c
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource:
	OSA0EPF000000CA.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB5140

The arm dma350 controller's hardware implementation varies: some
designs dedicate a separate interrupt line for each channel, while
others have all channels sharing a single interrupt.This patch adds
support for the hardware design where all DMA channels share a
single interrupt.

This series introduces the following enhancements for arm dma350
controller support on arm64 platforms:

Patch 1: Add a compatible string "cix,sky1-dma-350" for the cix
sky1 SoC.
Patch 2: Implement support for the shared interrupt design of the DMA
controller.
Patch 3: add DT nodes for DMA.

The patches have been tested on CIX SKY1 platform, the test steps are
as follows:
    % echo 2000 > /sys/module/dmatest/parameters/timeout
    % echo 1 > /sys/module/dmatest/parameters/iterations
    % echo "" > /sys/module/dmatest/parameters/channel
    % echo 1 > /sys/module/dmatest/parameters/run

Changes for v2:
- Update to kernel standards, enhance patch description, and refactor
 driver to use match data for hardware differentiation instead of
 compatible strings.

Jun Guo (3):
  dt-bindings: dma: arm-dma350: update DT binding docs for cix sky1 SoC
  dma: arm-dma350: add support for shared interrupt mode
  arm64: dts: cix: add DT nodes for DMA

 .../devicetree/bindings/dma/arm,dma-350.yaml  |  31 +++--
 arch/arm64/boot/dts/cix/sky1.dtsi             |   7 +
 drivers/dma/arm-dma350.c                      | 124 ++++++++++++++++--
 3 files changed, 142 insertions(+), 20 deletions(-)

-- 
2.34.1


