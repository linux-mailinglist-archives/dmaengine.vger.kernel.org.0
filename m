Return-Path: <dmaengine+bounces-7279-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id AF501C78D1D
	for <lists+dmaengine@lfdr.de>; Fri, 21 Nov 2025 12:35:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E29463622D0
	for <lists+dmaengine@lfdr.de>; Fri, 21 Nov 2025 11:35:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEC59333747;
	Fri, 21 Nov 2025 11:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="OniuAlyA"
X-Original-To: dmaengine@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013069.outbound.protection.outlook.com [40.107.201.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03EE3146D53;
	Fri, 21 Nov 2025 11:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763724904; cv=fail; b=f9Hi10vB2FWVyMa/2g0NWDD6jU6V5Kwv5LHwMwl3V2d1WW4Bafu3QyUFXfe0EI51abK1tYK+i/ePW6gO2WZHTFsNsnEOZ6CLKLOoc7K/S7ceqbLwWY+nttEQVGJW4l8ja5zKq2MEYslQpGRqxTQi+xWs5mWeV+pGe+ms5hmpoeg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763724904; c=relaxed/simple;
	bh=FKNx8F8Gk/HYKfUaXoUd0tBQKChfoStQpfP+Oorni2A=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=t160j8cQ+ScOLESsgCQHUuQk/TzyX7+WFhpn1NE46iUIEj4Qg3X2vu72KY8WgI414LJfUWGV5bvXl1oH6eYOO8cSjLb3phn3i3k81tx3qdTOQAeNdGel5myHfSD4a2kHjIwNtM9VnJVohoEJ9lMc9sEYxWZnfDmnqDOSonPSiHQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=OniuAlyA; arc=fail smtp.client-ip=40.107.201.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cjqEPoqleyrHMoa6Gl0pGZSMT2addTFXwwNAmgoLh2VUImkDNi8bP86xEyNGdOJf3FjgNAdbCegb4Hld0aLySrMS1DAhpdNWc36RRWL1uhTPgSLsoUYwP8o85bbIIohlNonS2iSATTblCkOU3mUVo5yT79wCJPn70DsiPuEtxKfMZ9qnxWNEgBfAhBYwRzlS8Fr1Yj3HJ5MHHsjKVlxqIh5MBmqwHAhmIrxtxLFTD00SctGoWp2xN6IVIFrGei/T5SGWEryBl7SeCCOMP6TBybI9zQYDViwJLE0YIHeFnsj4yO1eyTFFn1wMJfufnugGxq3YBDVVErFVv9h7T7amKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UjrIt1aS+TpVpHd1RtOccDThd+ZrRS3kLtPUaNZ5YMM=;
 b=ukKT+xC7w9MHuaL9eOmlnsdSFYp2Z1bmgM64YCvSQjvt0nUS2po/PiutN7k0qxVgzZJBrMbmQ3ANhkrREBng7pzmK6SnQ+0y05NVoSrWFo5K+s3qkBcTIJSuahWLV95mauH6pQ7/J8V1wTqPK+QT3zRv51MUxgzfOW+1G1hUdP9a27oi6GbyPJ3Nm072mrr+FuvzHIoc4nUh9pgJ7hXpKiC1w8/k1t0CY08tIMsmdhi1Vxqo8KQKacHfibSJceLTjFahBGKbaD9gEVpmIt7gZZqrOiof4KRTJT4i2/sYpo+w1tvutLyzxomVmsXiZ4P6I6eHayP86xOUOUlDp7L7ZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UjrIt1aS+TpVpHd1RtOccDThd+ZrRS3kLtPUaNZ5YMM=;
 b=OniuAlyAgu7DRRsT/bf330QYQXYDGpu1d4HISkcC208riLB+uTjxE34qx+wG6Y360m788sjdu3plpXZehlFC+Cjvr/HzOg5hgarS4zidfESE6IYOlH8O+tJ8fNDZa6eGtVV/QGw52WYMGTQah090ugmISMp+EeqOY1sRBoi0pZA=
Received: from BYAPR08CA0049.namprd08.prod.outlook.com (2603:10b6:a03:117::26)
 by SA0PR12MB4349.namprd12.prod.outlook.com (2603:10b6:806:98::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.13; Fri, 21 Nov
 2025 11:34:59 +0000
Received: from SJ1PEPF000023D0.namprd02.prod.outlook.com
 (2603:10b6:a03:117:cafe::28) by BYAPR08CA0049.outlook.office365.com
 (2603:10b6:a03:117::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.14 via Frontend Transport; Fri,
 21 Nov 2025 11:34:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000023D0.mail.protection.outlook.com (10.167.244.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Fri, 21 Nov 2025 11:34:59 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 21 Nov
 2025 03:34:58 -0800
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 21 Nov
 2025 03:34:58 -0800
Received: from xhdapps-pcie2.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Fri, 21 Nov 2025 03:34:56 -0800
From: Devendra K Verma <devendra.verma@amd.com>
To: <bhelgaas@google.com>, <mani@kernel.org>, <vkoul@kernel.org>
CC: <dmaengine@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <michal.simek@amd.com>,
	<Devendra.Verma@amd.com>
Subject: [PATCH RESEND v6 0/2] Add AMD MDB Endpoint and non-LL mode Support
Date: Fri, 21 Nov 2025 17:04:53 +0530
Message-ID: <20251121113455.4029-1-devendra.verma@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D0:EE_|SA0PR12MB4349:EE_
X-MS-Office365-Filtering-Correlation-Id: 179f7215-ee7d-4686-032a-08de28f200d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZWhojJWQ151DwYO576SKGlNRjdBx4LOPlMHyC8mEDGZhODtTrKpflltyAfKm?=
 =?us-ascii?Q?c0ntux3TtFY2zaYnc0ecRNHcTZ5A7IfMEZAcci+jXSjPGS9BXgyOHoDB8S4g?=
 =?us-ascii?Q?kqVIa0+C6G84MkLa47bER48BE/6/tu/P70xfSuAQeRqlltUJ1Ojfs2h1tDNq?=
 =?us-ascii?Q?Z9PvaevFXKi7anieqVpX3MIeRrEERJ9Hmdcv5TTD4IjSc/yY567ifUvENYJt?=
 =?us-ascii?Q?Jtt8SOXSXj4Dk6wWEJMCTB7ASd5mziYcllBEwS0QhTHO6qwylbFdKay77b1G?=
 =?us-ascii?Q?1PryP47m4STjr6YMCr1sgzvk24GRtl9CwaAPqmxmqCoIjc6otyWOBRkdrDhi?=
 =?us-ascii?Q?e3RbV93uzgdqeGoB0HR8Z/g3kVCNV8L5YGBejRF4n9pAxTe2uxcnXRjfoEFG?=
 =?us-ascii?Q?O6+ABFqCTaA0WSaBe79wtD42EQxfu38rZLMtR0NlJUbEXQ5fb6+OFy3dOQ6N?=
 =?us-ascii?Q?aFb1Msw7eE0GHmm+dv+o3zktK6Vq4oKDprkcRF7/KKrYk090IEIKhRFIbFUY?=
 =?us-ascii?Q?BBDIOjjqqaiV6LW/7s9+vzZNVNTND2uQTUHKvXLDfrBrqGA+caJgiHo3wHDA?=
 =?us-ascii?Q?pMjpOkrcqdhEcvHgYVNKGsHpDkZkCg6HU+gBFpXCqhqMWnMnC55XyOn+0+2Z?=
 =?us-ascii?Q?tdci40Qm2jdNRaaBFAUgZXfSR5m3oS0x8mkSBnebAiEfW6EuTeW5smFXagz8?=
 =?us-ascii?Q?AOmDWAI6SzHOsw7VrgYgzju0LgE5PFbGNFoD6TeIgJRX72+oiyuBKyFM3QAB?=
 =?us-ascii?Q?93bEDgM9GvT7AeUjndqiRN8zsXRgH6RJ8RK165NirYVEK99UbIXtBBQ+KKcw?=
 =?us-ascii?Q?RE6aAYx9SCIhXqqqpU9fuswcoqQvJ9cgu+83KC2A21RRAp4dCWwAx0H6fUjx?=
 =?us-ascii?Q?MAX+nt0flwIzFX7yI8N2rNrbMesQtiLIMbG8JQATxMV7gLz6IPL0qbOS2s3h?=
 =?us-ascii?Q?ceAnXjr7mTvo7eIyxwH66LsdWA7cE8PGQfONomaEW2KjRNH1KabUdoTg4pFT?=
 =?us-ascii?Q?CDDlxAhAHvKyb6x2Jv88IjBmjVlmHJvBleAj0jesh8qygd4kNIXydaKm650R?=
 =?us-ascii?Q?wm0jbga3QNPEeJoYn/ZtyrvmBleWuPwtckp+kKkxMqMC6CO/EuZ7XYBpDcfH?=
 =?us-ascii?Q?FYt6Wzt2O8tOalBDCRA+hIvUoSSh/3g2wbC/L1PUAOfOa7n+B4hjGB4m9rpR?=
 =?us-ascii?Q?lRLy3sSXxSi7Uk0FA/e2CKqik7tdLSYwyLKgEdmC1tfiXlx1cl69NSdKmvRu?=
 =?us-ascii?Q?2DCHpZKtiplZbdmSi843y0IWOwU6kgNcoI/QbMQ93WDSEpTgD6t04MFD546b?=
 =?us-ascii?Q?BQ4cnLyj6fCkKZqrv3rgcZkfHg0yfShzkJ896N6dfkxj/78STy3X64+LFRJ/?=
 =?us-ascii?Q?jvqgMd2BxDLxMnmcMbuGiXsD0R0E1vJQ7gp+LatTnfsXK6LlJl6+yv5TbB8c?=
 =?us-ascii?Q?7R3aanYr/w3jm6TmfXlFFj8TDnNHNyPLK/wAuNmOu6Xds4HMuFeSMAs4rwLG?=
 =?us-ascii?Q?/kwMNzrMrXHIJoprxqb38x+BuvWXBfRDJlxq9OE0uWE9y/+R6s3bYF26pTpS?=
 =?us-ascii?Q?aCwZnn5bxa7s6Kka/cg=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2025 11:34:59.3073
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 179f7215-ee7d-4686-032a-08de28f200d6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D0.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4349

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
     param peripheral_config, by the client for all the vendors
     using HDMA IP.
   o Allow IP utilization if LL mode is not available

Devendra K Verma (2):
  dmaengine: dw-edma: Add AMD MDB Endpoint Support
  dmaengine: dw-edma: Add non-LL mode

 drivers/dma/dw-edma/dw-edma-core.c    |  41 ++++++++-
 drivers/dma/dw-edma/dw-edma-core.h    |   1 +
 drivers/dma/dw-edma/dw-edma-pcie.c    | 169 ++++++++++++++++++++++++++++++++--
 drivers/dma/dw-edma/dw-hdma-v0-core.c |  61 +++++++++++-
 drivers/dma/dw-edma/dw-hdma-v0-regs.h |   1 +
 include/linux/dma/edma.h              |   1 +
 6 files changed, 260 insertions(+), 14 deletions(-)

-- 
1.8.3.1


