Return-Path: <dmaengine+bounces-5130-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 824D5AB2E97
	for <lists+dmaengine@lfdr.de>; Mon, 12 May 2025 07:00:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC7643A9C71
	for <lists+dmaengine@lfdr.de>; Mon, 12 May 2025 05:00:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DA8619E7D0;
	Mon, 12 May 2025 05:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="N456eYFB"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2049.outbound.protection.outlook.com [40.107.96.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A0A43FF1;
	Mon, 12 May 2025 05:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747026047; cv=fail; b=H1k9NgRHdTwbALUVUWFiiWjmJ02cVJST/o88jDCZx4ot8bZ1S0TDlx7aQ3u8fyQxMImq7pO9KCEAhpDgb70M4Iq9Bj+eTYXRQ8ZFa2S0vih9xISkVD00e0GzC/TEs+lM+DFDXa/With9yridy6zuuWoDS9KYaPnz39V8NV/qTvg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747026047; c=relaxed/simple;
	bh=Lucm/+4pk/SqpFyf7dvnuZCqkhjIM/nB0n5DT2xSvTs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=b/Q7EvmiQ0AgO090pLMfr7nUVEQKLtgAtv5MooBJLbDYfJMrpos5r+kc2saEVEusOKavScgnKTBYf0wteXDYqnJO2imRmFyQbtR0Tpu4KV9b32Y3GSadIIxDOFcEnt8iA8MSeVFv3UBW/9kOFUe1wWoXaOSuumPuS+b0y2wjOSE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=N456eYFB; arc=fail smtp.client-ip=40.107.96.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o8isr61Uvji1GfoS5kre+PlsmXlRc4mnQ5LO+Xsx3I55F/hycb2oZelVYpK0XSbESEDuno6JJakqAFN1gQEH2icN2oIGn87AEwh1UrL7dHxJfritq8r/y8H+E9fAcWo9QpUpPhN9SBx95pxZdYFIgHNqvSb6qoX3hXZwfFx6TQVQz64LKV3j7ePuqdHqHmTNYW0JWD1IZVXtIeDKWOq4QQ1A5iOn9FXus5mwNN37NhkleFIMLXUfG4GcIR/E4w5Y5uhVzbwVQG7uzaVCM2RfxFFZo7cW+E3LwuBYMiMBf2UXiY4UGgy7kg7d6eLDpc2znV1YNNifQGCYnQFUolC/Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AHBHx6DhxtWUnpyQV+dQcu/U/LBMD8AeIU4C4eecmqQ=;
 b=Iv5rgTGORRuxG70fjyDfj1ehedXFzR6jU3yJKgoA18l9gPxAE4jtw743pe2TFbi2KhdjdQxzWwscBsYNDmMSDmlWR6avSB6T/9zBfV6Qh4Am50cVNb65eJc12gn8LiooTJSpRpTfB8zKJYDgmok/LuSEhU/Y1NGi1mKRX5SbbfsSBAqpCE4vnqkBuxSNsFV9WK3u0zAxyhob+z7LBELXLJh9RycQht0u0JY/VxOOe/Kv3UVYyN6+8ozU/N0E1QlV94iTdU48xn8GhgrsKR/zstorcDdEWOT4lBPAs4E3U1JhSShnly85/v7dVg0oKTnXCYn8UYyrCwAtJ/oPMyd3NA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AHBHx6DhxtWUnpyQV+dQcu/U/LBMD8AeIU4C4eecmqQ=;
 b=N456eYFBmGhA7f62S3NweB2zZM7Bq13K33IX3vA46al9x2bCMetWLlebXEyXEH3xy6Orcu9NzR5RIqqbUJ++3+XgkYcc51406SkXzWtzoKZYcFQvKgG1Fuose/R2JcG9S+KnRf6yVKj3+1lqwcXmYICUGMmC+F6VKEYG0ahOsNiCfX3eTRT1MUFiapD//CTat/qkk0KmxiOa3/zg1duwZGBsYMf/ITDay/25Wf4K39nziabcaJR9b/SELSOzJJdB50E03inXP3UcAc72g5jUjF9i8Nk5JcNg6HkjaJM41DuQrsGI0sZkdEVejKXzcfnmoqdBwDiWnuGgOFVTYqcgUw==
Received: from SJ0PR03CA0053.namprd03.prod.outlook.com (2603:10b6:a03:33e::28)
 by CY5PR12MB6480.namprd12.prod.outlook.com (2603:10b6:930:33::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.29; Mon, 12 May
 2025 05:00:39 +0000
Received: from SJ1PEPF000023CE.namprd02.prod.outlook.com
 (2603:10b6:a03:33e:cafe::ea) by SJ0PR03CA0053.outlook.office365.com
 (2603:10b6:a03:33e::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.31 via Frontend Transport; Mon,
 12 May 2025 05:00:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SJ1PEPF000023CE.mail.protection.outlook.com (10.167.244.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8722.18 via Frontend Transport; Mon, 12 May 2025 05:00:38 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 11 May
 2025 22:00:24 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Sun, 11 May 2025 22:00:24 -0700
Received: from build-sheetal-bionic-20250305.nvidia.com (10.127.8.13) by
 mail.nvidia.com (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.14
 via Frontend Transport; Sun, 11 May 2025 22:00:24 -0700
From: "Sheetal ." <sheetal@nvidia.com>
To: <vkoul@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>
CC: <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
	<ldewangan@nvidia.com>, <dmaengine@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Sheetal <sheetal@nvidia.com>
Subject: [PATCH v2 0/2] Add Tegra264 support in ADMA driver
Date: Mon, 12 May 2025 05:00:08 +0000
Message-ID: <20250512050010.1025259-1-sheetal@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023CE:EE_|CY5PR12MB6480:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a7c095b-905a-4cb6-115b-08dd9111f049
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ClbrTFsRqX1akr3dEptAabZ3Y75nQ5D5vvlhHEoWeOl2Tzgz2FyOdbkH3Q+U?=
 =?us-ascii?Q?Ud3A+a1IskpS9l106gxvhM4U8G7y43ejvgHJulDHRtOIRxJ8u138TiJwklGx?=
 =?us-ascii?Q?CB1UMFBPZ0X688cmJVkSukJkOo+FtTLV0u+yUgu0ej5EJfat1r7EN9tfRDLt?=
 =?us-ascii?Q?hk9PnpVkzUKtCiMwa7A+Dh7F4Qvg26afJQWCSzrgxL//0U67oyOhKuHDnouT?=
 =?us-ascii?Q?gZYSpi/xEqh/FQSYvga1jFTPme+sqCWp/ws+eeuzr2x6mMC/P4Hj4D1IdQVq?=
 =?us-ascii?Q?O3CuKMeYemLKtWquX1fqJi9Fkss4B6cxo5KsigrmhEFeA5L8BSG4KgOeIntJ?=
 =?us-ascii?Q?w4itKQIapAsMUv3ZQNTveWB4n/My5rSCgvrcwWdlt9IKABJrO+D5l6f7ZUNX?=
 =?us-ascii?Q?wXjklOadUgioV8KihJlxQDeWRdQ/zgD8HJ4OTGXT0BKUpQohJbcasnorxTwX?=
 =?us-ascii?Q?5RkaYLxpU2Pcr0If8VXhoMqwiTMFJLxq4cQPO24W0rHg/OB4yPZXDeImnxae?=
 =?us-ascii?Q?TYfTJPIFTJynFghO47+QmHE8embtVM+UWKWQN8IkhAeauoPZKnnMzeFbRm3I?=
 =?us-ascii?Q?9jf/aBT9948+6LwmolBtmc3aEygDl1bHvSg8xW5V8FfP5Bx3s/8S2Z70e/8L?=
 =?us-ascii?Q?pnpKJWtbWl2L8nTGOcL9KrrEeF743RRlbTu2W6RZQjrJuf5O5AFqUm1zrk8V?=
 =?us-ascii?Q?vKWYMacsEaujOnXMkBxnzb5gvOYIM78YZ6pVFVjyW9l4nph7HuSFDJ0NL2vO?=
 =?us-ascii?Q?m4sJtNKQdyOf49IgWOm8dBslldRKRdhU1+VI+sNUlGvS/nwatapyYjUXkZWO?=
 =?us-ascii?Q?b2MI424APP5MRNfrTQ/j7QfaXV3KQr7Fi9wHFBn00bK7iQC9o+MEDYzXhAVy?=
 =?us-ascii?Q?gfe6DK+tCKo4TQzz1UdLjurQDe/eXPnyI5/7XJdSNSYfaSp1BoC8TvnidK+E?=
 =?us-ascii?Q?R3hsQsdFmo0SUu9dj/b+PV19zgTrp4QiStZTu0R7z9X2R6EMjZdvVZweL4si?=
 =?us-ascii?Q?9NpCdvozyw2Gj8ojqcN36Qdy6kro9uRBGEmDc7LNzs/RXZqWdA0KLX527JZY?=
 =?us-ascii?Q?MwrsLoynhRRb/YxPltOFXALpyiqarmt7ihzTW6t1kLQEdDNrnjTDJxei+DUD?=
 =?us-ascii?Q?9oF0WA+YB9YmcYlxdHhsGNKbiXohjvbiI9zaSaioUbeBvrCdVYTvhXV3Lav6?=
 =?us-ascii?Q?BhI2NCZ5K43T/4YCl6a/Dhehs8268VqL1KyRY0GeTqbSpTKR0SCEtrBB609N?=
 =?us-ascii?Q?gnEjqYA0l97QxmQMhPsRBZ4wh9CyxT5l7FfHYB2ks8H9/71DjjGKXAcNYJRs?=
 =?us-ascii?Q?/0c3IA97W3BvD5BAQMHf3MKDu2pMjJXan+GopDqcUnbXiGRBm0O6JpjExsqM?=
 =?us-ascii?Q?JHKWx+b2+A5vVI+Ej5d+aEBY2qEc523M4TrmUY3f+m6X3SFDpZaPHIAn5ts6?=
 =?us-ascii?Q?OCSYm7sF1odJbfhfWDTDttplz3x2DlT5tsoIL/qa9hbUaADhVIOnAIB/2QJN?=
 =?us-ascii?Q?+UA5knXjmq8D4LUxs+mKomSJlZlscJBVCWJg?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2025 05:00:38.8106
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a7c095b-905a-4cb6-115b-08dd9111f049
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023CE.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6480

From: Sheetal <sheetal@nvidia.com>

The patch series includes the necessary changes to enable
support for the Tegra264 platforms in ADMA drivers.

Changelog
=========

v1 -> v2:
---------
 - Patch 1/2: Update commit message and Tegra264 bindings properly.
 - Patch 2/2: No header update.

Sheetal (2):
  dt-bindings: Document Tegra264 ADMA support
  dmaengine: tegra210-adma: Add Tegra264 support

 .../bindings/dma/nvidia,tegra210-adma.yaml    |   2 +
 drivers/dma/tegra210-adma.c                   | 185 +++++++++++++++---
 2 files changed, 162 insertions(+), 25 deletions(-)

-- 
2.17.1


