Return-Path: <dmaengine+bounces-3965-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E6E4F9F09BF
	for <lists+dmaengine@lfdr.de>; Fri, 13 Dec 2024 11:40:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2856F188BF0D
	for <lists+dmaengine@lfdr.de>; Fri, 13 Dec 2024 10:40:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 570791BB6BA;
	Fri, 13 Dec 2024 10:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pgMor2TB"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2067.outbound.protection.outlook.com [40.107.95.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C17851B415F;
	Fri, 13 Dec 2024 10:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734086408; cv=fail; b=iahQUzIamCzP5PY1NnkT6iLnJHlFvsms9yx83n7oCnDu94/KjPaIZaeDgalhgZN1XE9Tkri8Psq+26yQsz8Ma5FN+aBFuehr9ndjV7Fz54D5j5hdrbckWQeUpueYC5OfbPX/3YGerK/klsqrcw4UY4b6Uk1v7zt8/GhGUvtkHgg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734086408; c=relaxed/simple;
	bh=youipse0aYIvOwGZ+M5C5obq7jhyECOKMrcD2kZgeik=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=or/jc73LMM104NOwQ8V7OBy8g8M22tHIMEwiuwGUisEFyDaKWmkCWSjEjD+sSfNs1D1QZ+PVf4X3lyodJISlJqqqb6UFKape/n59KX5KYNid63lnfZsq/djASCZ5VSxL+xHaLPKFQq8cbi5wbIedIkRzNbtK8EWW3W9xnNRISis=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pgMor2TB; arc=fail smtp.client-ip=40.107.95.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=inAUGgZ7HFPDeo9fbY3QF5EepuAq5XmksgiigwUdzcMVEFyCbLaeDLWMJ3Cf0i9jmY+hnquR7zS19CTWs18bjR/W+WFhjx/BbzUautxqdvRe+HxzCVUzC5TmtkHymGYlEeHdlLI0QHBpktdMePYh7zoCo9onbviC1s9CCLPFmbJINhqx5IQUiLrDOPGRdZpTjSd8f5esQMY1Q6Bb7vQi8YR2uDK6bF65zS1H7nPoZ1dA70ok0/VqDMgRSFJLVTSJkZLNeD5bDCNYw86kHiUt8oEoXAWobzSCVSvfZdHmMrdl+CwA2/kBp5ccRedGsuQRa3+FfaSE3MBAOj6IfqrZvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FNc1Hab42082326taptVzhJRlD+v1mvQueKIgrNbtNA=;
 b=Dm2E6UVAEivBpEbhMYLgsRj9f0vZ4NWMO9jkhz8s7BHrvm5dMjjDvenRii8B0DShgvEdcKgxr2faQluRUJI283Kv5c5Bkrluce7buRlZAPbiOXzSsq3B4+INxEFIjNInMssIjqCQ3mExin5LLqSf5cuxgxaVwpn41wfi4SwkQrPV+9Fa2XrOMgt2DE03vELtyCFAT7V2wKJH8dlGSShrk7aBN5SA2F2VwjL3JHnCkBiIVHSnoDiiQvfT9IWE9Huyrk3RPwHS5oFUDm/52CA91FbJ/yrKJaq6rfyrsMK2Qm9R+Wu0L0kKjpg706sV9M7pv/ugfy/b7tTtG1fzyFyYxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FNc1Hab42082326taptVzhJRlD+v1mvQueKIgrNbtNA=;
 b=pgMor2TBvE2258ocUcDuZ4Qp7Z3vv4VeUEkyuPXDL3DyJBmqhEkWenqrd59BL7TKSursx2Au3yeNYliJ2ATtzrtAUE9ousX29Rw7rZXlt7hZ8jN2LdMjbQonTJIIL0DOqsn5FNS8uVurXKoxyMP2ObQUkOwRIC773fKdIuVkJLd/Djiluf5XwSg3cOSQ5G+0c6z8gilsTkAIXuLrrrPqUCGBI4kiJgzRyn1bot1a0+d400lxf0K1bMrJdMRDXN1L/FlF8LGxwArR9VY4kgvoDrCBpa9W4nNqKhdtAnZTfu6Sg28m3GvzoiO597esi0HkrsSAwZBbtn4FGkyG03IFrw==
Received: from SJ0PR13CA0043.namprd13.prod.outlook.com (2603:10b6:a03:2c2::18)
 by SN7PR12MB6670.namprd12.prod.outlook.com (2603:10b6:806:26e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.15; Fri, 13 Dec
 2024 10:40:03 +0000
Received: from SJ5PEPF000001F3.namprd05.prod.outlook.com
 (2603:10b6:a03:2c2:cafe::ed) by SJ0PR13CA0043.outlook.office365.com
 (2603:10b6:a03:2c2::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8272.5 via Frontend Transport; Fri,
 13 Dec 2024 10:40:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ5PEPF000001F3.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8251.15 via Frontend Transport; Fri, 13 Dec 2024 10:40:03 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 13 Dec
 2024 02:39:51 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 13 Dec
 2024 02:39:51 -0800
Received: from 13db4e1-lcedt.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 13 Dec 2024 02:39:48 -0800
From: Mohan Kumar D <mkumard@nvidia.com>
To: <vkoul@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>
CC: <dmaengine@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<thierry.reding@gmail.com>, <jonathanh@nvidia.com>, <spujar@nvidia.com>,
	Mohan Kumar D <mkumard@nvidia.com>
Subject: [PATCH v2 0/2] Add Tegra ADMA channel page support
Date: Fri, 13 Dec 2024 16:09:37 +0530
Message-ID: <20241213103939.3851827-1-mkumard@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F3:EE_|SN7PR12MB6670:EE_
X-MS-Office365-Filtering-Correlation-Id: 33aa4086-d176-40cd-ff2e-08dd1b628074
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?netOm9a3PuWwOTKjVN93R2pZVQumbF5DllKDjq8sIb7baKlBCLXH3nwrnqPA?=
 =?us-ascii?Q?anV3vyxv0z92Pb55oWUUYjwBTNbcRSv3w8iHhRLpbByY245QNlEl+6dnblgB?=
 =?us-ascii?Q?27BeiyhQzjwQdQVBcbfdq2rFMk2PY1bUHmBHE7eKPMr6kGNCgGD9hLw4IDC4?=
 =?us-ascii?Q?b9Kzx7rYHdmlltTCQltw8hEYYBEcTNW/DoF9FT30B3FUc6KI402jcQk0LubG?=
 =?us-ascii?Q?srVplMJFFCSIU3xoJSGG3hPT7i/L081woX7Vy7VdwFUar1V/OmV0TzVWL+28?=
 =?us-ascii?Q?lw0ObofgwebUtWhHjGSav9P8e1J0lJ8EKGyFs/oOZylpWsdWGBswJksJkh2B?=
 =?us-ascii?Q?nBicvyARcGM67lgCfx7W9HFE856doxIDCBTfEe0w4krvESIRyDhzN1L2p9F7?=
 =?us-ascii?Q?Vlo4Qvbog9x5+drzx3X6ITBJDMKI3a9vNyVHSyCMzU502RBbCw3vQQJ0ztU+?=
 =?us-ascii?Q?3uup6fzbf6iWHwMDa6uCzXr1Qop4PbPq0OXIMehAwMk6Y07HEcp5LPYyTd2m?=
 =?us-ascii?Q?7X5bAKRjsLPGSuGrMVFDBhbrKGwXzu+Sx+YFBy4ppnb1jsFftyb6FtDXkazK?=
 =?us-ascii?Q?bPj8MHvZJnH+Dqt1KgzxyldQWUYCvudp1q3ei0tM+rB+Ttc5XyrRwHg9TKtZ?=
 =?us-ascii?Q?cXoAhXsf15pPaZEowWyl14VtcfcyhSBnjxdj9K1L8UO0K5gi0ip5HdndmYDc?=
 =?us-ascii?Q?7bVbasMU1vBC9loxEWC43z6eOmZJP6MIxSq9THbZFuFA4LRESFDB2iL5mdr3?=
 =?us-ascii?Q?gJjXUAo1T9WYS9FMeohbqzfuIE1NFaOVxFmUGAdlIuAx8GYikvFfleZG3jkG?=
 =?us-ascii?Q?gXQHFLLaexpp7hvIt5+eP3bmsGCvODSyTP83SpwPtm/zVnXbqNsdzq9zzuxq?=
 =?us-ascii?Q?qm426LyIuN1JFJa7FG0c+ubxFMNtS3E3xMYZuhs6Sd3Sv4bxAE6E3KcEOXDB?=
 =?us-ascii?Q?VAEOPXidau95Y1UoFzbLf8OfzhBtgCs96uwyrT7yDIxZsdZLQcJQGb/aES0m?=
 =?us-ascii?Q?lRrUlgkicCtuCHdMu8xxbeJYTdVobCHdlCtC352mkwDQmShM/B3TdAMZawtQ?=
 =?us-ascii?Q?m+pXDwbQBXpbmw7j2f7qu2znaZ+/adGVcipj7+2AjXfCwxrj0UjQIHV1F0EH?=
 =?us-ascii?Q?RUCLPS9hxtidsEJu8Xk585AFEkWZGMukAUBCdG6qtP4D+reVj7Xs0YNDwczu?=
 =?us-ascii?Q?4eEjpJbaflOvb/O/9s5uuLFx0ywzIRTfYVICUUCT05SdJP8QcN/5gf32zf2X?=
 =?us-ascii?Q?p0I2tlNH/1/0h9hgUGA3HsZDLsbSZIsO9JRs/sJX9q8Gl2NKhNbAb3G7aY+C?=
 =?us-ascii?Q?xxjV6QKGC/jRCXo1pN0EJALkwPRYpDJ2Kc4xW+0onzbsEam/l6Mlb/gaozpt?=
 =?us-ascii?Q?jXu7XPNVO7jinhQiWFxBijWx4+A39Gf7PbBoZatixWiFBbWTMWZGcdcIG5bR?=
 =?us-ascii?Q?2bab+yo/GD9HehOKGgyy8Oc7bJHdXODc?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2024 10:40:03.0968
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 33aa4086-d176-40cd-ff2e-08dd1b628074
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001F3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6670

Multiple ADMA Channel page hardware support has been added from
TEGRA186 and onwards. Add channel page handling support in the tegra
adma driver

Mohan Kumar D (2):
  dt-bindings: dma: Support channel page to nvidia,tegra210-adma
  dmaengine: tegra210-adma: Support channel page

 .../bindings/dma/nvidia,tegra210-adma.yaml    | 60 ++++++++++++-
 drivers/dma/tegra210-adma.c                   | 86 ++++++++++++++++---
 2 files changed, 132 insertions(+), 14 deletions(-)

-- 
2.25.1


