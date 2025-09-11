Return-Path: <dmaengine+bounces-6448-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E3793B53153
	for <lists+dmaengine@lfdr.de>; Thu, 11 Sep 2025 13:47:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1904A88395
	for <lists+dmaengine@lfdr.de>; Thu, 11 Sep 2025 11:45:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97C263148BA;
	Thu, 11 Sep 2025 11:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="5hQWBVi3"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2082.outbound.protection.outlook.com [40.107.94.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A9B76FC3;
	Thu, 11 Sep 2025 11:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757591101; cv=fail; b=iFOV0I05Y/mPd3l6NBFMVzCLSzC5EpV5ywrT/eTHYR2VY6oDyoIliIWB5MX0ax+MJyjUAAITFRJcwcVDq0/jr9HcKNAfbOR0RPF0vcAq+EOEAS6mvqHAHzaKfkJQdz7/jNWdiIulp2cJElhSkWhTgV9hZUMijyb3u1gqKxY4ais=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757591101; c=relaxed/simple;
	bh=nyPAnmyXUcXphTI6rdG0k35aLrqBgD43sdflGCf/HAY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ODYAT4tErcOTc3fAoyKJZdeKhdwBMyCVXe/49msYAj+9CabsgtwHyNvyYH7sguGQQVnwxi5EyFldBkDQAj2TQAvSvlFcBpAxBAo+TN10t/xE5+mb+b+NOdNBRCe2aREMB9rxCirhqb/V0Z47/8uW0jICpBklCvHMhzxGjxFtYQ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=5hQWBVi3; arc=fail smtp.client-ip=40.107.94.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HZlDX4hU3MHH5qeRbUaLjg1t4JXv23nYmOyxf45v+TTQPgmgiwmNO3dsu79D+/xLCnGt8tdMe1d+dVlKXmHinVwEfHyMt5s2ct/N9sWJ4GOnEnWtlG/cQjE0USDm+833al0D8v4bLdIYHIp6lfqA55GilQGCuc6h8w4T68hdGoxEmGGa0s/YX8LNI0LeNvn9xGEzbAhiisifloILtkaTUJmnLCfvq1fvjYqA3sT8E9CVee1N0rXWErYHq2A0dRI8LzGSPTQSRic8mCPO/Rr74Bsl7JaHItYUKiObt/57FdtbBgo4Txl7P6I+nhBEn6//u3XCXJaQGbYSInjMRsHHbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZdbnpW4klaY4TNpkg4pGH2SviHf6HZ2U2o37XPhtaSM=;
 b=q8XX26HKO2k3Jdu5xBHWC2smt1W7MFHfyxe8J+hW7ViKfRiSe9p9591mn6IgpIsrbr6SUC3iTpZ3d+07Cqj8T7BkM2KqErXBM4lnm6BIyGUL0i/3QZ11HaNRkV5D/fP4xGPOAyeeJHAsqO4xIV+Ygc4+qyovvR8HmIg3Qu6EmzONYnAtlrKdDqDZR4dvXHuHYO1oNKolLAoPxDAa8bXtZKHU+1Q6VzlaPCyY8x0km7+xxWJVIqZxL7TQNocOhKDVw76HWJ7akXbDd+hhhGn5rb+uMjQ2gYbHA2I3uy89nBqzS4k6Xk8DSxtWQKojyRbAXQ4gXB6fu10NMv/TSrXhjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZdbnpW4klaY4TNpkg4pGH2SviHf6HZ2U2o37XPhtaSM=;
 b=5hQWBVi3KR3PGxTHUpnf6QcBG37lapZ5AVnSNahVzDA5iYcrOh9Y/raVIrcM238/2TnIHwI2iuV3xqzsiIAloZ+MFhbVZg+gZd7gGdmek7eNYj2uDlP8Q3iZQjEi/Ifql0RoHe+5Ewh7+4RJLxLYq7FJ0PIRzIQ1cNL/f7Hw3Io=
Received: from CH5PR03CA0001.namprd03.prod.outlook.com (2603:10b6:610:1f1::29)
 by MN0PR12MB6001.namprd12.prod.outlook.com (2603:10b6:208:37d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Thu, 11 Sep
 2025 11:44:56 +0000
Received: from CH2PEPF0000009D.namprd02.prod.outlook.com
 (2603:10b6:610:1f1:cafe::12) by CH5PR03CA0001.outlook.office365.com
 (2603:10b6:610:1f1::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.16 via Frontend Transport; Thu,
 11 Sep 2025 11:44:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH2PEPF0000009D.mail.protection.outlook.com (10.167.244.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Thu, 11 Sep 2025 11:44:55 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 11 Sep
 2025 04:44:55 -0700
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 11 Sep
 2025 04:44:55 -0700
Received: from xhdapps-pcie2.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 11 Sep 2025 04:44:52 -0700
From: Devendra K Verma <devendra.verma@amd.com>
To: <bhelgaas@google.com>, <mani@kernel.org>, <vkoul@kernel.org>
CC: <dmaengine@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <michal.simek@amd.com>
Subject: [PATCH v1 0/2] Add AMD MDB Endpoint and non-LL mode Support
Date: Thu, 11 Sep 2025 17:14:49 +0530
Message-ID: <20250911114451.15947-1-devendra.verma@amd.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009D:EE_|MN0PR12MB6001:EE_
X-MS-Office365-Filtering-Correlation-Id: 3780ea35-6b74-4d40-099d-08ddf128a10f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9LtZTEcAX0ax4MYORxqtg6GCejWekwLhSvSjYz6kAi/0eho8SQyOjeazAZpa?=
 =?us-ascii?Q?iFqZBMmzjrpHgg4rSi8ghuAqiKE7BnaIUdkKzo69Ma0Nzbt+CBh86Oi131hX?=
 =?us-ascii?Q?SGMRMmJQzfSBVz4XMsBJkBNe+etdQsQAJuUzxTH1s3Jkl+FIugopRl0PsunH?=
 =?us-ascii?Q?42buqYo1EDBDMk45dx9NA9XtWaakqc6wAt5RxlADzHdmVrkFeoZjTJKt+tyh?=
 =?us-ascii?Q?jDNYfCHNKTxMjA4otvfcgiMGYQHTVPUhNwbNFy9GPg+fe9cfDyd0CtEOkMz3?=
 =?us-ascii?Q?zRBeh97Vq/9uY4qgn7f07weFO+DFjOt4xHXfjqGVNS1qvnwZvIZoCT0ObN4M?=
 =?us-ascii?Q?mGqeSi6p3pEZFiwV7GwACFI5vU877zBZw6YSMWczUD3MM5R6Sqo6Ud9bsh8B?=
 =?us-ascii?Q?7x24CMZboTMhuguSA8cd6m6QLk5nXJ0OT8JNFn0z8Iy3cWpMHw2XzHUP0zQ3?=
 =?us-ascii?Q?tVJE60ak8JwgFIZr4XC01poxScgT04GisIYa4Peoss1Hpzrd7GOp8d+RSEdq?=
 =?us-ascii?Q?s34fw9OK2FBD+xCGjjN4b47loYqcvt17h+wf5a3ISi6siTlSN9aKoGW3uUPR?=
 =?us-ascii?Q?vVMioX+qSQsd2AC/ms+L6KokFEvE+x0l/jSoWmRYxmQhss7+0f6SM88KqE/Y?=
 =?us-ascii?Q?YbO1Guc4xr+65HWXeumNxIn4U4Qe76keP0KHemEHxDoRqkxAj1gXhSFU16Pb?=
 =?us-ascii?Q?XyqXtmgtFNMa0nSz+bD2xr8JMEYk2xQxqIFHdEH6rZZYPO86meH3wuxjcnp+?=
 =?us-ascii?Q?45W30bA2GDFO/z0LUEVWTcVkZU+XaR+Ve1wbHivCTrnbUg/rMDonMKNvVKJ/?=
 =?us-ascii?Q?Ymocmd3gBTxFQN9wfODCGdaNndfZ7Rn5XA6GzUooXpz8uXQopSGvdq3Y0eg3?=
 =?us-ascii?Q?wtJraskPP2dBmh4IfjWAelMSHvVBqtLHWm7XfuLdlZxQI7Bz2C5kggfPL5E+?=
 =?us-ascii?Q?PeDsoSLEw7BIp9PfDCXTxVt/yD/S/7nRe0y6oOzAxqYQR5FnpQZ2DQjqpZQd?=
 =?us-ascii?Q?Dleg9pONek0NldxFw71eoST5QdaQDMZTfviO8lW0+CM+P0SGsNdIVx1F5cO4?=
 =?us-ascii?Q?JqK9oaeNt9hkAliSqreOlH2Y1wSTH+qhmix/m4/kQ/TXJN6YvEPn9SVq4ZPR?=
 =?us-ascii?Q?d0/YdfD+sVPdY8c1f4lE0RTRiTUBjYAwDVXCIUlXcbGdLpGVED6cArSptRTn?=
 =?us-ascii?Q?GN5OHCgo4zAKeOn9A3cU/j7JN1CGBZJZcVyTCIq6NPO9jdf0/YzG4YzQ5u5L?=
 =?us-ascii?Q?bgdWEYqhXY6sRoeUFvcNnUs7l5SEg9xljkAn6f6eneg9ij88N+AqMaVkhFih?=
 =?us-ascii?Q?PBAqNonkwZ4BpS6cwF4uBNHS7uSgFcKkGmSoRogOM24sC+5K2xs/IMpMq4g8?=
 =?us-ascii?Q?+tO+f1NUVb3gCllH81cnKlsy6IpjjLGhzq0iwa7sjL4dQ8c0tFwpcaaTAulF?=
 =?us-ascii?Q?4cJK0hkiqzlEBBvqOcZgYAiRrqdLCilILFqBe5XpLpNFVZa0AmapLNbP3zvx?=
 =?us-ascii?Q?PIY8YTrWULwAdNKJml4DWhCUix1Xhbyk2o+f?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2025 11:44:55.9031
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3780ea35-6b74-4d40-099d-08ddf128a10f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000009D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6001

This series of patch support the following:

 - AMD MDB Endpoint Support, as part of this patch following are
   added:
   o AMD supported device ID and vendor ID (Xilinx)
   o AMD MDB specific driver data
   o AMD specific VSEC capabilities to retrieve the base of
     phys address of MDB side DDR
   o Logic to assign the offsets to LL and data blocks if
     more number of channels are enabled than configured
     in the given pci_data struct.

 - Addition of non-LL mode
   o The IP supported non-LL mode functions
   o Flexibility to choose non-LL mode via dma_slave_config
     param peripheral_config, by the client
   o Allow IP utilization if LL mode is not available


Devendra K Verma (2):
  dmaengine: dw-edma: Add AMD MDB Endpoint Support
  dmaengine: dw-edma: Add non-LL mode

 drivers/dma/dw-edma/dw-edma-core.c    |  38 ++++++--
 drivers/dma/dw-edma/dw-edma-core.h    |   1 +
 drivers/dma/dw-edma/dw-edma-pcie.c    | 162 ++++++++++++++++++++++++++++++++--
 drivers/dma/dw-edma/dw-hdma-v0-core.c |  62 ++++++++++++-
 include/linux/dma/edma.h              |   1 +
 5 files changed, 251 insertions(+), 13 deletions(-)

-- 
1.8.3.1


