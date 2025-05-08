Return-Path: <dmaengine+bounces-5111-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F1C4AAFA19
	for <lists+dmaengine@lfdr.de>; Thu,  8 May 2025 14:36:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2DBF67A199C
	for <lists+dmaengine@lfdr.de>; Thu,  8 May 2025 12:34:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 255DB225414;
	Thu,  8 May 2025 12:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VBMIeRky"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2068.outbound.protection.outlook.com [40.107.243.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88D4E22332B;
	Thu,  8 May 2025 12:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746707758; cv=fail; b=YkAVLdlYhUPPhU3tKBAvKE+VFDayRTjSnrybah+j3d3mSFQquVPTN4O4nzZLCS9wsIpfON2lgb8pQXXzS4xBr//5iI580t2FD1ynF/tLl+X5aOndT3cFSjRQA5lTaA109VoI8NSnsIQCtq+tOCKq+uQnpVLkZxF95w+ZhEQSLJk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746707758; c=relaxed/simple;
	bh=VhYRrXMUTyMRDwZdF5riNQM2DSsXSUsGZSUgHTKk3TM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=A4XT0uCbXBhbVCfByk0rAKZxW056zYK5lFPV+2RMoMpYM+3UWfUSambAdUVqOqyhitZphdiXbHkDP3udfyKMyMJOGtxXYeImVMgCvA+kcrXTyYVBzgAl+8CWLu7PBJL1nJt1Nit+chXTGaK8HCUb02hUJm9RPgdNPhTAaSHy0rY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VBMIeRky; arc=fail smtp.client-ip=40.107.243.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F9moNSfSYfRPHiRy5U8j122KJaZK4NZudTRU/BntTdOM5+SCw5ifPdKY0uSm1/R41LFAQp0FEGFm89zd1dFq3oSLyf/endIyRIdsmuAaa6qi5Fzn2G4BvHd5QrOynQdt0ThTXPq+HnZAiDGPKG2NG9T72nWxyBYNh70wfDajX2DzBS3KtiZm8LiXtXuTRcbB2sFHmU3haVPo+SeFQW1qPv0DHcgSyxWNWMPrFBdptKZ8RpkAFHI/EC/Dl4o4O2C6cSFm6GK+2APKAzde+nWZzwB5OrCnFL+GRl5+MGQjFDsFXdodOohUyP3fzYqM/DEXi1ELO83Wfa4i7JEvRp2qRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OyxcLaZMQ1Y/jfR+kUj+q+6iI1eNSOqXcGAXRypW6iU=;
 b=aC1v1GDjJKAwHvZYC/brKdt+Qoyx5vKpsqaNDGjwXQYAivX/hQhS1agPVLgBNZpl1I1lsvlOYdv2NWh+t4EibFvOh7SpJq6A8Q2hU+y/q1zfqAvHxFXsfmDwIw55USKw9nR1ChwnKlKoTjS8umYtdfMi5ezUJfKwbrLne6xzMp6w06f2kqvAfYPwxguSscCiZIzRq3Isgjq3kLbaM6XAiRGg4twM6Yiv+BhYaT1Lj/U6SWTmcAvnQ5xbFO59cjxkh7tdVRcGxgR3gstgDobKQP5zlU5qyxKLqZfeG7//9H70jg6zAgo1906V/jWeHNtGslOfc3iFLjuKohnK1ZN4hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OyxcLaZMQ1Y/jfR+kUj+q+6iI1eNSOqXcGAXRypW6iU=;
 b=VBMIeRkyHKQx310WZVQxbTRD6MCc1nkzAQcVVc7zjEJunQp/GVkmyYHQV2gwagLtCiR+MMTARkX3jaE8FoLjfqLCl9Flsa8TVy2LEOJgd684OoYdEOXf0xxSs2FBVzYOyBQiYWVhpjWTNpmO/3Y4xgEqD3BzK7IJix79GDIk0VtcKNbCmGpsLqa+Hf3XWhiEi091dMvl2cIAOCzHgpGpiBH29P/D+kW7sCH4pwzP3bfHpUJcUgXGXLzGOHu44rArxNQEYK+eOdVHjGgZRtOAsTq9n6bzo4dkD9V+/NvflHx/JYx8EFOJtrbpgkd732+XvvU0R9RoVypqWV+Ir3nYvQ==
Received: from DM5PR07CA0106.namprd07.prod.outlook.com (2603:10b6:4:ae::35) by
 PH7PR12MB8427.namprd12.prod.outlook.com (2603:10b6:510:242::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8699.19; Thu, 8 May 2025 12:35:52 +0000
Received: from DS2PEPF0000343A.namprd02.prod.outlook.com
 (2603:10b6:4:ae:cafe::53) by DM5PR07CA0106.outlook.office365.com
 (2603:10b6:4:ae::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8722.20 via Frontend Transport; Thu,
 8 May 2025 12:35:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS2PEPF0000343A.mail.protection.outlook.com (10.167.18.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8722.18 via Frontend Transport; Thu, 8 May 2025 12:35:51 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 8 May 2025
 05:35:38 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 8 May
 2025 05:35:37 -0700
Received: from build-sheetal-bionic-20250305.nvidia.com (10.127.8.13) by
 mail.nvidia.com (10.129.68.8) with Microsoft SMTP Server id 15.2.1544.14 via
 Frontend Transport; Thu, 8 May 2025 05:35:37 -0700
From: "Sheetal ." <sheetal@nvidia.com>
To: <vkoul@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>
CC: <dmaengine@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<thierry.reding@gmail.com>, <jonathanh@nvidia.com>, <ldewangan@nvidia.com>,
	Sheetal <sheetal@nvidia.com>
Subject: [PATCH 0/2] Add Tegra264 support in ADMA driver
Date: Thu, 8 May 2025 12:35:18 +0000
Message-ID: <20250508123520.973675-1-sheetal@nvidia.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343A:EE_|PH7PR12MB8427:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ffa9ac7-d200-48f8-f312-08dd8e2cde5a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nIK1kAOy+pYo1Dk4O2jIMFJXyzEb+9IKlxo8nmbXWxEEx1FnchJNW8G/5O4C?=
 =?us-ascii?Q?o6j12g7Awe6yeKSeWhHEf5GechyW2fWHISH7G4OJtRij1ZWClFe8l8y0ZVs2?=
 =?us-ascii?Q?zNj2Q7QrWAXIrjJDxa0sNuY08ndejJvuUvWub6sbLHtDlqsdkVP5SrA2/acs?=
 =?us-ascii?Q?Pk2i5QDyRB75VgJYRSbyah61WVWy4M/sy1xhWq8gxASh2aq8inBKBXKcl9fI?=
 =?us-ascii?Q?V+eRFM7ct6tqyll+Hdoxx1LqDcpYf8+rxYOfyS9BszLy/MvDF91rGfLz1MyS?=
 =?us-ascii?Q?ugVAngo9pxjH6BOm8GwK7eK5geNt8P/pFQiQ0g3czFf11O//jn/3/5nncoqH?=
 =?us-ascii?Q?0O2S5uqZjsU+OOxhjTQEUzHx8YtvlMRSw8MpSO+xhb/CkpbsWh/bHAyDIIBv?=
 =?us-ascii?Q?11nXqLEToZC2+eZ9NftK5OeItmDIOS2+N/pQpu4wmvskVZ5n7Cbbnp1hR7qS?=
 =?us-ascii?Q?Xm10jTgi0WT8o956f+7VFGOT2dtXUVqJxXUR8mUME8pkxpZwxBVGv3jtsbKX?=
 =?us-ascii?Q?d/2/k7af3FVITdXRyvCNtsWhgy8dK749Q6Vtbu5q6xq/q001mJC+cLivjj8w?=
 =?us-ascii?Q?HWuBwtyO+sAoyJjr8sPqY6KkgRjoBQaFuw6Gzmwjg5NUSpDCreEgQrEy1a0g?=
 =?us-ascii?Q?FsyJuexnzaC78Gmy2QkjqsVZU3QHdMb9+Qd4M2O9jskHA7TfVWIj3/yPK2NF?=
 =?us-ascii?Q?T60tDXxW9k5JBGD8aIt8R3BJdMikz6cyuJ0AomJ2i//LAZ27oJSgqjytRG6F?=
 =?us-ascii?Q?PsEja+NI9HvREA3bA3ujK0WgEd386DUb1nzotBKTkZoCzO0oVsM/fgVmmux5?=
 =?us-ascii?Q?zXEtWanBX/muy8KM76h2jaJhgvbyQ2K4xon2C8wl9xpncK8xIJ8kOHnJrCyP?=
 =?us-ascii?Q?HAvWZeZkZg5BDnugD/ciiBynK4kK1Qz2nxheWQg3qoQ2Vnnerf3dRFO1yxK/?=
 =?us-ascii?Q?a2dsMjWKErMo9V+9hgndupnq9lBcdiEdQwyPqATv1SI5rtsMQqxX6gI0LTsA?=
 =?us-ascii?Q?p3J/DCHERHa51BFIqIdR9uL0GD637mXrwnVtxm9bHmesHB+/vHingy42HuzD?=
 =?us-ascii?Q?ZYehAsMA/FNfnCmPi+bXtZjujjK0yjEDcLyQXDGpP7LngNEivMxlpJFIkP6f?=
 =?us-ascii?Q?0Zp8Rs8STrUhYr3bJrUnQ+qQPuLaWyJafMTQ+NEOLfAzmSNHpP/BpmZQLKZl?=
 =?us-ascii?Q?+sBhqO1QOPO02EMDFghiRilu++Urqz/AQa69BJXdJ2X5uRougJ8xVpuTKgDb?=
 =?us-ascii?Q?5YYifWOkjHRAthdWGFV09lUjvgntZetC0fUgFvGc7mvyrrDuMcNTBdXFlbmU?=
 =?us-ascii?Q?uFEET+zrD47DJnDW8Suwx1P8wFkXdgAOijSV7GoJzPHaGiloAjC/xHECFTQl?=
 =?us-ascii?Q?dSePshBR57aGLpzLlClnp4zD4QTH9cWPf7igUDOzm24bWnVjWQ5TH2AXtzVa?=
 =?us-ascii?Q?13TKAvRu39X9VrpHezcOT/ZsYphuKsCDM4yJ+/rXiO/JJfrUaic7J0bWp3mY?=
 =?us-ascii?Q?rtZvKqniJ2rqKFbsUISBf988DMXpWLeGlAsY?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2025 12:35:51.5158
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ffa9ac7-d200-48f8-f312-08dd8e2cde5a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF0000343A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8427

From: Sheetal <sheetal@nvidia.com>

The patch series includes the necessary changes to enable
support for the Tegra264 platforms in ADMA drivers.

Sheetal (2):
  dt-bindings: Document Tegra264 ADMA support
  dmaengine: tegra210-adma: Add Tegra264 support

 .../bindings/dma/nvidia,tegra210-adma.yaml    |   1 +
 drivers/dma/tegra210-adma.c                   | 194 +++++++++++++++---
 2 files changed, 165 insertions(+), 30 deletions(-)

-- 
2.17.1


