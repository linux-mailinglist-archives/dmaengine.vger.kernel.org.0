Return-Path: <dmaengine+bounces-4385-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7E5EA2EEE5
	for <lists+dmaengine@lfdr.de>; Mon, 10 Feb 2025 14:54:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82D31164413
	for <lists+dmaengine@lfdr.de>; Mon, 10 Feb 2025 13:54:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E4E123099E;
	Mon, 10 Feb 2025 13:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="IjlRBGys"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2041.outbound.protection.outlook.com [40.107.244.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA69122E410;
	Mon, 10 Feb 2025 13:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739195676; cv=fail; b=Gj40OfW/kvnO5/z8JsO9zlx1iHa9zO0604RPsXqwrlQAaqMrdHxogWkPKsAZwPWdBuPbjIssV84Gi27RbB1hd6BCexC+kBJHGBHCnODdFbhDBDfjtOKkVsrsLU4f9o1X4plLRSSLXLilFwpbRCZ3cd3GOh7Ic8sU0hyCniioHv0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739195676; c=relaxed/simple;
	bh=Zdx6P5//ZtdUeedVwSAqAWdVOqzbkGnhmbxaMJE+gUE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ssm3n2RXjAg1A69F9HcJ/9ZQI7P8ncjFrqfx8xB6lohpeaHYPoYG65NCumCHAmZ75YV4rVZM7x+gtsCMdDXww7/KxCxQ927TRKeRaLvGjnSFX2A5ofxjdWcSvFU5TxpE3EgFCoYe8uZLKz38BUu9GgGi/Rtb0Doa47txbvE6PNY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=IjlRBGys; arc=fail smtp.client-ip=40.107.244.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZS2fJsCOuADiF85l/sjDegvd19grQJgdeClVUhpAXdt4CfDV/Gwc3qxxbk5mEp4DkSdo/IiEIIIuZNrcdtRs9sUN9D09g3Xw4+vUmgiwrNVJjmHSLq9yjgk+0lBd8eUuFzu70lLlGN22U0zkVMxgv76bZDqMax4Kt6EBR0vvXfM80CpLc8rZwURICr2CQA0PKiro7Iza5TxlxsdoQCcmorb5/IGZd/TtbfNQNlUm/4ll25X2HqvBBdIioelwKvHiU7mXlNfcFNVhFR3mJX1a+qV/3hoB5M5pMVx7/PMMwHC3uIt9kruWHgM7Be6LuEJ2r0EtN0Qz09g3jID+5uHGlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gaxJ0Vrdl39xChtY6zjhN+Eobpa1UJn+hiyJF0n3tRU=;
 b=L/+/Jlhc2ecLPgs0YSOWizJu4dD2rQa1KFxVRO48TlOxYoi8kzJo52lkVkY5qOkDQOtqE4wGA31rQFTFXU0XZ8ej9B4PpkgPpszL0IJea4ybe39pypB/T4Wmvpz3L4YemyQbSABgHnERB7Fv3T/1gX5thomsr5dtMz0VjWtya7uuK/nlSwKOtuwTx3ax3ifV7+0uRdnzm1EK++cn+6rkJ4kkNjehtis3ngzRtbUGMaZLaiDEPhY4yBu9tBLSCozNgjR7yWtv+RI03S6AOCNTqJ96UEA5o9MFRDi/s/hTZIaz/rjUxyZ+rYyq41Uj93YxoUJRAcs4O0Miyq4Q9AA4Aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gaxJ0Vrdl39xChtY6zjhN+Eobpa1UJn+hiyJF0n3tRU=;
 b=IjlRBGysdyjJlzC6Dj8KytZ6GDP5wCd0RmqXzJIoCbsMPS2cVOybTn5ICdPudLBAJqneYdPB9XvY0x/CNQHl/gdGfoq2lJ6k3enwcxnP0EhvXu7lrNLrWUP4Z1GHLpQ+09ZWDySTbay8l9QxrcfbbnKVIl1RfGSjt/9Iy6MavCdNKsI9wrcsjB4ob6VhERsmyXp8ohsTKbUJqOvpzDXmyi5J+ZBV9sRpziEM47t1uoZLjyx0Fsn7OsSAiScxZag0qvptgDQxDgy+TVX2G58N9TSvpkx5NSJ1itA9Dyw6s22mLhkqkI+KhM9XtV7qcBu6s/v+TV2STshpY+bYv356bA==
Received: from CH0PR03CA0109.namprd03.prod.outlook.com (2603:10b6:610:cd::24)
 by DM6PR12MB4420.namprd12.prod.outlook.com (2603:10b6:5:2a7::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Mon, 10 Feb
 2025 13:54:31 +0000
Received: from CH2PEPF0000013C.namprd02.prod.outlook.com
 (2603:10b6:610:cd:cafe::6a) by CH0PR03CA0109.outlook.office365.com
 (2603:10b6:610:cd::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.31 via Frontend Transport; Mon,
 10 Feb 2025 13:54:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CH2PEPF0000013C.mail.protection.outlook.com (10.167.244.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8445.10 via Frontend Transport; Mon, 10 Feb 2025 13:54:31 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 10 Feb
 2025 05:54:20 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 10 Feb 2025 05:54:19 -0800
Received: from 13db4e1-lcedt.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Mon, 10 Feb 2025 05:54:17 -0800
From: Mohan Kumar D <mkumard@nvidia.com>
To: <vkoul@kernel.org>, <thierry.reding@gmail.com>, <jonathanh@nvidia.com>
CC: <dmaengine@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>, Mohan Kumar D
	<mkumard@nvidia.com>
Subject: [PATCH v5 0/2] Tegra ADMA fixes
Date: Mon, 10 Feb 2025 19:24:11 +0530
Message-ID: <20250210135413.2504272-1-mkumard@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013C:EE_|DM6PR12MB4420:EE_
X-MS-Office365-Filtering-Correlation-Id: 435466f4-51e6-447f-072c-08dd49da7173
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZcgFfWRbBeeIBGE1w7FstK3hZG4AUeDXmt6NIBeY66BS7tBa5PX51WoLjcjf?=
 =?us-ascii?Q?Kgjf/EKY1QLoGDk4hF0UqhGSSE0MWGXEKcc4tlNrfA7HNLyQI7KsZKjtpU/l?=
 =?us-ascii?Q?8baG9OtpfJ8pgcp8cZ1HEAnd+PTwV+ObXnNDxKXMiveIkCToBV0zreGAG430?=
 =?us-ascii?Q?9sPELcgfBKshX0D6oqczhYmudoMD7kmf0WXJBiXHQuJSNj1aHoz7Abx8Iuc+?=
 =?us-ascii?Q?PPAD5NZ3HLGFmyYY7c2UNU0yDx2jgjX1D3Loi/Jkd1SQGaGdKtJR7xZrmd8y?=
 =?us-ascii?Q?/f1NC5wtCszQTQEbf4F3o275j6DKpik/9DUsZQifvqZcx73FY5hbKwoE6CSj?=
 =?us-ascii?Q?Mqfc2paSLdmDDq7gGxhHLSZf5YXrevu5rXzeemFZZVc3IJNlCKDszJbLQp3W?=
 =?us-ascii?Q?WseHx/RJQ4P27x98k0rp2sDpxLV8zF4/6CDpWYCcoUQ1hIY8kvkjhLxpiua+?=
 =?us-ascii?Q?HDamiU7TqnbQYhtYeQ41sh9n8lXsr233hI9ltSRKxnSMfbYhFUjrTNwvxwAh?=
 =?us-ascii?Q?mc3M9m17GGB4EzHkrXkwkyDqCLmLP+7W/at4SXPkaK6youSh43dDHrnfPIv2?=
 =?us-ascii?Q?zWgLNl6XHwUn6Sju7oaI9h6HKpK/oEyT+dXzZscBl9klQ3+bXDeSc4mrjSeX?=
 =?us-ascii?Q?Mi60WgMw86AVewY9H2XIwWricd3u1TwP0AygjfqJVpmBWsnKxGx4VVfyZTpf?=
 =?us-ascii?Q?KTuFMO9M6oumEYreEH/uz7dkG74+MkwttdcwnFeSQXGi8RG0Kj4wSvCz2P7U?=
 =?us-ascii?Q?pQweg4Ln60dUlIsdY29YtsGZ2q4AkqelZ63wzF6TWaR9X6Hh0NZ7UnoHDMAa?=
 =?us-ascii?Q?lCiCWzHfeGBiOZut6qrlxPFSA7VCRKAFCxuqMuCWGYOAkl9YhhuLFCXezByQ?=
 =?us-ascii?Q?qbvi07q6Dv9X4kgktTBGB+mQafq5nUJrHuq/4rR/XXLaEzPw/LgLRFfx37ov?=
 =?us-ascii?Q?aKH7Ko53sMsT0g4yK098clUMARgVm6mHOpf6Wcjf7e284xedMVkM4jwLZlIg?=
 =?us-ascii?Q?36cHofUfeA+8t98uRsyxVrpHoMY1MtrqKWW7Ugq4lBLLFVifWmQ2OJLTcqst?=
 =?us-ascii?Q?EEQvZrzDxUNIpcIdUYIHGDROH/ah12GIGo4RomwdMeU2LHMy2zRFFa2sbKq1?=
 =?us-ascii?Q?BkIv8OqnmzgNwuugcA94w6oCCBaGfOZYeEvw0aA0ler0hTiCpiEbup86SfDA?=
 =?us-ascii?Q?vnzjIBKGKRuCK9N6/QXe9p9PxUW6XCIlk3PjvSsiBzlnPaZ2X5OmCTe/uoBH?=
 =?us-ascii?Q?1gkI13w/2yEP90ClBwzmBv7dBDzLp+rGAPS5LI7swWFYD4mgXz/u0x6o0hSF?=
 =?us-ascii?Q?/skFJSXncncfQ9qYzs9YasBuoPNtY9KI9MUXiABlupx9Cv19hfq8L10Vd5RR?=
 =?us-ascii?Q?XnZSuKSadEjOen0jIjTaHWkwqbvQ8Fh9HtAJcd4rl3JCzARfPUKswJPxy2+r?=
 =?us-ascii?Q?CeCsrLhYL96LCXCF50ZTEMHskcngIkxnufpB1M1kMZj7wggh2VsuMJADG8dc?=
 =?us-ascii?Q?OyzojeAa+EWPDkU=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2025 13:54:31.0134
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 435466f4-51e6-447f-072c-08dd49da7173
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000013C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4420

- Kernel test robot reported the build errors on 32-bit platforms due to
plain 64-by-32 division. Fix build error by using div_u64()

- Additional check for adma max page

Changelog
=========

v1 -> v2:
   * Used lower_32_bits() to truncate the 64-bit address space for
     division
   * Included additional patch to check for adma max page

v2 -> v3:
   * Removed unwanter file change

v3 -> v4:
   * Used div_u64() to perform the 64-bit division of adma address
     differences

v4 -> v5:
   * Updated commit message of the patchsets

Mohan Kumar D (2):
  dmaengine: tegra210-adma: Use div_u64 for 64 bit division
  dmaengine: tegra210-adma: check for adma max page

 drivers/dma/tegra210-adma.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

-- 
2.25.1


