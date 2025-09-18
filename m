Return-Path: <dmaengine+bounces-6638-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 42EDCB84AFB
	for <lists+dmaengine@lfdr.de>; Thu, 18 Sep 2025 14:53:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB5FB541FD1
	for <lists+dmaengine@lfdr.de>; Thu, 18 Sep 2025 12:53:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93177285043;
	Thu, 18 Sep 2025 12:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="FPd2wirr"
X-Original-To: dmaengine@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010004.outbound.protection.outlook.com [52.101.193.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEB02191F72;
	Thu, 18 Sep 2025 12:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758200022; cv=fail; b=Hp3G1qKPhMi+27jxsPa9N/xAWFSVViv/48+pCp4pVgKXgSYwERnoDTgDITalj6EaoU0BWNdu94AOcfA6Rx+Foly9kMelQ4/GXsBhlhdpm9+6YY/s+Kk+qTBYQxsRILE7ZcZ9CzZBsr47ReHgFgPrqoJhNm+mW6+USRvU+5kxdWY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758200022; c=relaxed/simple;
	bh=HbLvVsmczfQrC/WMJuY91hSVMLX9oIQlMCii/dQ8RBk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dWmvYYrKDHYZEKUTUbcLeSGQo4q8y/AOCLmV6SbS94GnwApA3A+lPQAWELttIcKsYfI03nKPmwB5O7xsSzujRVR9YKrixIEXC7Ayhfe0IuPYJ+hHo1ZbEzYkK71/eHRNX3ffY6j338aImb/7bUfMaiq1qvART20cUcHyDN+ZSI8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=FPd2wirr; arc=fail smtp.client-ip=52.101.193.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ew86VfzQ68s6tnWTp0cf03JfMk0mb8B0hrnOO5H75ZJc6qJ+sJD/HvhNXDpLcqXfrnaCXj7YEBbzl68cmdWUnmYSy+gojcqssT8VZMPdelHtTMtshsepP6Os1oclkgNIE5+CLaM8iWWB3kK4pnoNSgVlWBaN8HgFr9HMYQ2Y23p0/cDRXVYRJA6JCB58EwxTWkwvuW5pbTWS/QzBol/JqBfWqh7xRd/bgbwJcxdWCNAESfPkSMVXBbfMzZgu1d9FtPjlzVZ9VG/lrHDX0BrAwasFcm8LU8CW7CPkugRXo5W8/0rKazBumIM18bOkX/7RiErBh1o4uWkciomPEXtVZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SAkeswUd2w0WmuGbZxctAgkX1ohVC2/WpAS5zp7vDyE=;
 b=HX+brT/T7TLScOMM0xzgTh7kSzL6fsJkvagNGFduEMokUw7agulj9or5BfsVpXvEYFx+AXGxUsSFRnYSvwPGGOMLR+VE5Bpbe42RSH7Ib/8RdjKyWUo+ibzgvbNcskMi6dkUFvOl8HVriZcNZQlvTarnccNZwL8FuPGVKA0GzoqOHawjH0mu/9LYDYTM0RyMXIbXFcg89dh1gM/eKGUFDpsGtHy9Dw2V//5AF3XXJbgoaDx3w1qovhtDYW5EbuRaZ8Dn5QZfBDWYfJF1rAtu/PuLdfsaMIubNZ8e7UXKjJ9vGXozRdPxRNNYaEvLyTk7PilrGT4pmCUUzI5a3Jls3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SAkeswUd2w0WmuGbZxctAgkX1ohVC2/WpAS5zp7vDyE=;
 b=FPd2wirruEsFvjSEIyw45d4qcYlwpx9YnJ4tu2Mc1SoyN4ZQd/1URJvjQA+6ID9BMmKotNmq0tV0W8+f35wdqmj2HPlyzKrpcU+IeKrM7VgH13G/b0p9XtXIKBzYgqcIJzzfDED+y0lOIsmEhheYrz93Q5g/VnojDTFDqf8C2Lg=
Received: from MW4PR04CA0090.namprd04.prod.outlook.com (2603:10b6:303:6b::35)
 by IA1PR12MB7567.namprd12.prod.outlook.com (2603:10b6:208:42d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.14; Thu, 18 Sep
 2025 12:53:35 +0000
Received: from SJ1PEPF000026C5.namprd04.prod.outlook.com
 (2603:10b6:303:6b:cafe::3e) by MW4PR04CA0090.outlook.office365.com
 (2603:10b6:303:6b::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.14 via Frontend Transport; Thu,
 18 Sep 2025 12:53:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF000026C5.mail.protection.outlook.com (10.167.244.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Thu, 18 Sep 2025 12:53:34 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 18 Sep
 2025 05:53:33 -0700
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 18 Sep
 2025 05:53:32 -0700
Received: from xhdapps-pcie2.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 18 Sep 2025 05:53:30 -0700
From: Devendra K Verma <devendra.verma@amd.com>
To: <bhelgaas@google.com>, <mani@kernel.org>, <vkoul@kernel.org>
CC: <dmaengine@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <michal.simek@amd.com>
Subject: [PATCH v4 0/2] Add AMD MDB Endpoint and non-LL mode Support
Date: Thu, 18 Sep 2025 18:23:22 +0530
Message-ID: <20250918125324.26033-1-devendra.verma@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C5:EE_|IA1PR12MB7567:EE_
X-MS-Office365-Filtering-Correlation-Id: 89279194-ef04-43d7-996c-08ddf6b26121
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?naPmR0MOj5RIcytiGakDwwDQePjZjfbKAAiLU3sK84pcVN1MiBsaMMl9YBm3?=
 =?us-ascii?Q?AeNu3+9q2PDZJSD2gVwXMNmalefDm1skjgy9X9EUdt6eZ7OV+jXaAmOAlAhq?=
 =?us-ascii?Q?365mTeS8LsgYN2doLJg2/YI/+jIGQyoXERidoMC65iSJXwOKc6nCeucI+sng?=
 =?us-ascii?Q?9dq6BwI2EZJLNmaP8eulMfmthX83ZjqbJHYSfCjfPuTNtR12tTICA3Q9aCNO?=
 =?us-ascii?Q?uDgj3kCPIuvdWPriza02xztmbnq6v8yJqHpCmwKGgmq7WHve2aLwWByw/oFv?=
 =?us-ascii?Q?vvK6hlZY522vgmnmzat+ETRt5twhWbi4xyfSnXydjZ9Q99X9BMVSTRXLOqJc?=
 =?us-ascii?Q?5D6JzLTNj3pfFmygkgr+a675U+9kTperGmvIjXHPSrnXeS7GjtZTAi6Bw7jG?=
 =?us-ascii?Q?PryluqpEc1waTxBG1IPwS9XVmvY/eLEaNnlnlAjmYe1BC8D0r7XQxkZArw/g?=
 =?us-ascii?Q?EF1M2E8kJ6gns/ZfKvS7DC32eFW9BIibkOVpYUF7oqbQ+1qg6I1iqebP9hM0?=
 =?us-ascii?Q?qy8zGGj6zQHaW06J2npYJh2AJv0II/wvkHlMbg3cIHwv0ZVcVtHUxXuA2zk+?=
 =?us-ascii?Q?w/mtDQbaoHIZ4aNJ4KWAyuh3y1ejHfqg5mt6p2LOuHgBmMoqELGilyDtGPLh?=
 =?us-ascii?Q?GEIiee96eJnQey7GopvkST5LCopCAl8Ip0YwpoYoDmdWlbTHby2QP0nOylMX?=
 =?us-ascii?Q?fruv5V6+gZShgYhTDv0L40BgeONVgdM2O/w1oQiqTZrGS0Npb6NR8AtUOddp?=
 =?us-ascii?Q?iZUZJMblc+QjLDsE2+etNnNbvS1aKI4sHDCetPW+Pj2J8nUhmlG++wSPtliF?=
 =?us-ascii?Q?GFwIwQhq5e2PqbjwqoSvA3DMXvBlY1gc495Ru0e135+w1yVpG5nY2tqZLjI2?=
 =?us-ascii?Q?j+d3CyBEjeqcwA+P7BivJue380ar5Wt2DjBdPLb8eSn+RrLJDyLoUvv+2m0v?=
 =?us-ascii?Q?1wu0z3WrScLjKwEZPlGkNcl9D08ZPokTPt9F6uYvK/VcU4DCETlnNqQ0HQsJ?=
 =?us-ascii?Q?EsOFcr0lQETOLj+lL6M93hy4bxUj3yzno5VKwDUs6+dfUYdtSoIknDjnfnk2?=
 =?us-ascii?Q?KorsEjfPURBsyjFt8fPdM6lgn2ySg2XxnRVWWP0Sd6ZKIhmlzFt/KW0B59/S?=
 =?us-ascii?Q?ZiZLRsIzvIMUsHr2sZoEOpVwFQPg6im0k5uZZOQcd+eICobkoT423ioQ5Zmz?=
 =?us-ascii?Q?w+35eEEdKyRgpx95ULgZDjJc8gBlKcOhEFmL/YOlknUYWCrU9/2g716wtSBo?=
 =?us-ascii?Q?DhaskehAqDEiISI1Y9S+H3wxSxA63wXezd+RT3wix1bxR/PMznvNgICBCuRo?=
 =?us-ascii?Q?2twICjLI12USbtz8GIIv0a042QC4Yw4QYit09K8Og/1rAloDHecooo1A7R7B?=
 =?us-ascii?Q?Ko6MAtIMT8jwuwzRgsQ8jci2x8mlMHTZYheHGKsmKzH2v6ZFS+A1e/Lxyf0A?=
 =?us-ascii?Q?49hAXKGklUHBHAH467umGjUtjTODTzKNqXKY3+aBW2fM9iLIoj8ISUV9nVHz?=
 =?us-ascii?Q?XWtMcRH28FCMFCrfUtHlGIsbS2LAWTwjmcy2?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2025 12:53:34.9334
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 89279194-ef04-43d7-996c-08ddf6b26121
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000026C5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7567

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
 drivers/dma/dw-edma/dw-edma-pcie.c    | 160 ++++++++++++++++++++++++++++++++--
 drivers/dma/dw-edma/dw-hdma-v0-core.c |  62 ++++++++++++-
 include/linux/dma/edma.h              |   1 +
 5 files changed, 248 insertions(+), 14 deletions(-)

-- 
1.8.3.1


