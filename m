Return-Path: <dmaengine+bounces-4000-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AF3A39F4560
	for <lists+dmaengine@lfdr.de>; Tue, 17 Dec 2024 08:44:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9913F7A6C9B
	for <lists+dmaengine@lfdr.de>; Tue, 17 Dec 2024 07:44:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9EFB1D5AD1;
	Tue, 17 Dec 2024 07:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PyJwdO5L"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2074.outbound.protection.outlook.com [40.107.100.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FB1D2F5E;
	Tue, 17 Dec 2024 07:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734421465; cv=fail; b=BcUQs5RB4GzRzzT4anHNM77PPmJayqGHoQNR/C39rBBUvW5dkudWp089ZvW4k5F4P4PQj6HgCtICeuW+Lpog2SbPpRWVZdEXSv+nZ06zvfuUO4TPpJktvcHKBeN/S3pyQxVPzeBMxxAXVHHFQIfUibMzpU76GU/jzwNotfEja64=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734421465; c=relaxed/simple;
	bh=nqA+m8auno0o++swt5p2RFlx0Ze4PWzvmD0FawZOhGM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=EpAzttKaeAtx8PH4awKNTAXcaskxOsQHg4ha3YLmD43O5bTueTqPn2okgFO79bBoPktDnSkSWml4SvTmBeROE10kZ+QmxyZnMdASdL2B1F8TyqMgvZXaZeMs5MH9ef2R3Vsrl4TFhtjXvLZuqPthY+WdqSAPyq1smbqcNDVhPMs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PyJwdO5L; arc=fail smtp.client-ip=40.107.100.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aLC7ZmlhepwalIcQigfgtx0NNVNsBwPL6QPT2Q8rLu+jwj6ZASIuZ2IWs/ZAH6kLDuS64EdkqHgQrQfW7w97+IIHFzokziuEVY602VprS0DL2UKhmras6jkWqTGdnGjdGUHAJDq3+aK/aw+TZz80onQ36ePDuLI7bfpyKGD2IpmHxZc7mYfbYDkemIrRmtDy1PeZQpRoBVwJVF7U3HOMilcvBlXicdngFd4OHcoVrqnWvFVB72K4c8iTPbPkpBtHZIz9q6jjDJYNWfnkovV74KloQdgfi6QMwp1JgJCyeXlpu6lS0Y2J3mI5lX2RhwC1GxIbnwuWVoVxuL41YMHQ6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gdVpbKWZMQ768IaGkDQmLcwdj+HBNoZRpwKzdoflDCc=;
 b=d+VPXk6zDTWoSngT0UbHd/Uq9e3D7YjKWDu8jMF415r//REjeJ1EgirWueiOysojFmH1twOkdK/hDctF03VuPuNyTzb1gM0EIvESbwmrNhTg3odYQBp+eNbgahP/5RUvLTTIP8lo7/WwjGcobLh7+wtgIr37ssWh3v1HVWP/ZNXEFqGLPofd1LfoAM6CsAMOK2P7S+bFyQ/ErDqV+MZ/glVw5Ta4izevGK4OOLuDtBNbEufTLlvn0yWYnzaaS+CRMVhiV7nS9gTQ3hVH/RiRol1Z1ala1pVShmNB9sTxxkeIoNxHm3ajZTpmeuV2qFZ8jPA8oT/u1jmUBZcGs0j8bA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gdVpbKWZMQ768IaGkDQmLcwdj+HBNoZRpwKzdoflDCc=;
 b=PyJwdO5LMdvMXh/eKC2PqKfDIAoVRrm5P4aWfoevifbUI5IBYS3j+ULmkReyByd68OuMH8UpQLGJ/OWrOzMR6ceDwZXuIWI9tKAZb8lNkAVGd9deNOO9dv3wfcnJvvc+E2E4tEFltuR2L+oSgERb6ihqLRzRnWPmLFTNDy3FNvwZ6b1qV1CR1TIzu2a/btXU3BpVpLT8rzNZVllBG6FXcnd8JX8BZSF/v26rLs0lx1LWCoilsH3jU7HZfgs508e9aYqMAhJcvZne4tkorcUXbSOKei9PEA6VpHkWgDLWdNga6/3CL3JM3G9pW9n/H2z02XWkxHXcgPQaYghjOGBpmw==
Received: from SA1P222CA0062.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:2c1::13)
 by DS7PR12MB6261.namprd12.prod.outlook.com (2603:10b6:8:97::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.22; Tue, 17 Dec
 2024 07:44:20 +0000
Received: from SA2PEPF00001509.namprd04.prod.outlook.com
 (2603:10b6:806:2c1:cafe::a3) by SA1P222CA0062.outlook.office365.com
 (2603:10b6:806:2c1::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.22 via Frontend Transport; Tue,
 17 Dec 2024 07:44:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SA2PEPF00001509.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8251.15 via Frontend Transport; Tue, 17 Dec 2024 07:44:20 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 16 Dec
 2024 23:44:11 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 16 Dec 2024 23:44:10 -0800
Received: from 13db4e1-lcedt.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 16 Dec 2024 23:44:07 -0800
From: Mohan Kumar D <mkumard@nvidia.com>
To: <vkoul@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>
CC: <dmaengine@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<treding@nvidia.com>, <jonathanh@nvidia.com>, <spujar@nvidia.com>, "Mohan
 Kumar D" <mkumard@nvidia.com>
Subject: [PATCH v2 RESEND 0/2] Add Tegra ADMA channel page support
Date: Tue, 17 Dec 2024 13:13:56 +0530
Message-ID: <20241217074358.340180-1-mkumard@nvidia.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001509:EE_|DS7PR12MB6261:EE_
X-MS-Office365-Filtering-Correlation-Id: 9290b690-764a-4c1f-3b09-08dd1e6e9e28
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MvcQ7BlYzL6U2GdiI09burKdo5PzDb0QtpTu0U/HH/wZFskLVoIV45aCzxIh?=
 =?us-ascii?Q?j3R4tunNt1VBDQJ2BGZ52Q7U81v1IuSijscA82bQXRV7tkMvPwErDwNxnkjn?=
 =?us-ascii?Q?BOKpaDX9eLrAJCNahHHEhlA8RmxGbJGbWa40oLFUIegjMwUzHH66ICyLqgXc?=
 =?us-ascii?Q?y4Gvu8ltdAZ7E/ZxSM7OVMCVXvPPrDWnzo8apqbrzr80S9MMfwq5v0INQ4AV?=
 =?us-ascii?Q?6cYHHsyeiRx7dSzZ76ooy6uBfpXjwSC8pHJ6s1QGoPxoaIy1YyzALEgotRAK?=
 =?us-ascii?Q?cEke1VVIpJhuEAH5Z0vG4dsXzdmwNodmTtdCuwYMFR/IBBT8BgLxpOTTUU6j?=
 =?us-ascii?Q?6xBEyEo5nKM0Uy+b1ubm9EW7b1gU2Op6IGsuQxj9sqxniv3QftZC8JIqb5QG?=
 =?us-ascii?Q?aMNXGmN+tKk86KuwFM5Iw121WgM2C2Lftikf+ZgBpvp78rNeIMBUw0KlhEsK?=
 =?us-ascii?Q?mJy1eRYH8bWpiD4uMezD/bPwCYTEsfi/QH+EEoB1E5ihwxlOmDjZ7nywBDN7?=
 =?us-ascii?Q?kbOxVshQi9sswIoJ8iZGvfL5CxU5TyouafEBiC9LhQWVNnBM+6OLz3eV2iR2?=
 =?us-ascii?Q?t1hjaY2pBDRewemVtpKwHLxvGrVCgzeFuuQUBEAG0W2ikjKqZM5PMs+1ruqR?=
 =?us-ascii?Q?UulCDummYKynR89tAqb2F1tpjWEuRsN4wkCYpv1lAmPUSW7kHjPIz5Ok1xLN?=
 =?us-ascii?Q?iQPVfZUcdlPU2d0rorUg3w4zGM7w1qduUZNkVBVhvofbtXJpLh/vPYMQZqh6?=
 =?us-ascii?Q?liIoOuxk9gPSYp4vyvWGdCEyviJ4EeTzrnePP82fP7XvcBRRNt7xW8eU4d+A?=
 =?us-ascii?Q?pDC6y90Ndzz7I05nA57452E9IDY0ywNu+r9EqCQcEkupmfgvDAXds0Vc+Tkv?=
 =?us-ascii?Q?u0hwA92C9rVE3v80bXU1IwyIyF92SwE6bxXam+6CDdNYLwdP5L6VepMfCKqW?=
 =?us-ascii?Q?X+NAP8tcNvTIol9JBRBERxy8TBzFowID1pBpiKobW4LqUYOkZYfzM7lX2TzO?=
 =?us-ascii?Q?vdrHsbrelqM13GNIkaig4chmSlSEuZBS+oU7HxL8vY3iuSyhliXHfIWe962Z?=
 =?us-ascii?Q?1oP3d8A1gF1clbRu7KOGoLKY6dGSZx6eHBc+HjatGsgHJvdT7+Uk15cUVo9S?=
 =?us-ascii?Q?1wHg6JmtDwrLv4JPukYLu62bHsEal/Aqrf47TRDoEWEyfrmFx6FAT1Emv2Xj?=
 =?us-ascii?Q?sSnXjzKYU7zNpHAdHdhaB29JqCZdr1WzQF0wTf83y8PmpPHWp13MP+TPEPsP?=
 =?us-ascii?Q?5sj4LqmVKarCbmvFiEOXwGq8V8MI+YhOjTEnCMQh/JTFbE7gr4JaNtLP7+jA?=
 =?us-ascii?Q?vfFQGw5urNBxuFmkc8eVZR8zTV7zwUY35t8x6SIZ28FeA/OyNrrhY3N4lMXT?=
 =?us-ascii?Q?oy/nv5N4tlvTS3ZbT0E3LTvRW8NqnW3Eyk1pSAOmaVxgfmBP3bTOD0F0ythF?=
 =?us-ascii?Q?FoL18Rq3QljvZk8BREuHwljZZ3CqeuiuftrpRGlQFAjho0Z3j3oIneWhb/HX?=
 =?us-ascii?Q?47vj1IG1CtwmM5k=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2024 07:44:20.3900
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9290b690-764a-4c1f-3b09-08dd1e6e9e28
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00001509.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6261

Multiple ADMA Channel page hardware support has been added from
TEGRA186 and onwards. Add channel page handling support in the tegra
adma driver

Changelog
=========

v1 -> v2:
---------
   * Removed '|' in the reg description
   * Included the allof:if:then: to describe the reg and reg-names
     properties to reflect exact restriction for all the Tegra platforms.
   * Replaced oneOf listing with items description   
   * Overall approach followed is to use either legacy single reg entry
     that encompasses the entire ADMA address space. This configuration
     ensures that the first channel page was always used. However, for
     Tegra186 and subsequent versions of platforms, opting for a more
     flexible approach to configure channel page address space

Mohan Kumar D (2):
  dt-bindings: dma: Support channel page to nvidia,tegra210-adma
  dmaengine: tegra210-adma: Support channel page

 .../bindings/dma/nvidia,tegra210-adma.yaml    | 60 ++++++++++++-
 drivers/dma/tegra210-adma.c                   | 86 ++++++++++++++++---
 2 files changed, 132 insertions(+), 14 deletions(-)

-- 
2.25.1


