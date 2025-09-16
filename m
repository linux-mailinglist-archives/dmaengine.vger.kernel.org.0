Return-Path: <dmaengine+bounces-6528-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 96751B593F3
	for <lists+dmaengine@lfdr.de>; Tue, 16 Sep 2025 12:43:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16E5B1B21A5C
	for <lists+dmaengine@lfdr.de>; Tue, 16 Sep 2025 10:43:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BBA0222585;
	Tue, 16 Sep 2025 10:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="haOHaTuw"
X-Original-To: dmaengine@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012003.outbound.protection.outlook.com [52.101.48.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14CA82C11DA;
	Tue, 16 Sep 2025 10:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758019412; cv=fail; b=Swhc/yLj2iefOX2iTti50Uz4uvol4YK/BgJTgMaHBx7nEzmRHkkfvyRGeYhwdmg8queM3jeKaX+WIdCs3x9C3P7Tqo7oSb8EZsx4Ah22PbnFL7nJsxjScmiMI9nBilPcyXdCxEzHEdUzNnaTjXprH3XqQl25917kdWi04dw35UM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758019412; c=relaxed/simple;
	bh=33QvYkajPjxLy++iyhn+B/YR2ytxAKSQX3Ba+0QVdmU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=sYhT7J3v1vxSEgWFYHkOWc37IPMzjWNyUxsKLxXL4k3ncMDKB6wLvDSKW48ACY5JMPDkJZXXD6DUv717Ln3+VFvCfFBlnHkRDCwdqgI9ta46gD6Qlw1H/sGkEBCx2o8Stc49tg+NhC19+E7slh3anK3T+O4ODFRqm7ZJdoIl7Ls=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=haOHaTuw; arc=fail smtp.client-ip=52.101.48.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GXnSsqZaZ7RPI/p3s0vqm0j27D1W+KwDnueuww4o8mtPypQX+1UwmUgVlZcGz/X3T9KQig6sv03dQGZvQt4D9kav33JqyQrjOa+6YHTKGs80lc16Ap1Yc1PTnf0+WEYMt2Mij2Cdkc/shv6XHptiEt+GusNNSLBLkzrCVPWajKQkvy34lLaZjfWdhBYGD+5akbYAEKXssT/cmH2MA5n3RFhzxEtIcOyAiw/JXNBylo7/MUPLZL80reK5rdrcbCtdkhtEvPs/Awdd46MOoTd1ZmqeLRYStI1z0ljlAL2Ua7+NzwfO/M79wIkaQbpJ/Fsj3VvJOQT80uhEvx4qx8u0pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=POOaGtDq3AApC5W3w3TfrdVWi+gV/uqhSG+xPfXv1W8=;
 b=O8uZD8z8613teILzmz/l5XettAVMpUhO5PG8E+6EyXM3kbl1zdcJNt3Zk5sZMLvy4vxQNuHQxtQ6+C+KlNw6+0TyVfHyeBu3/TAGIdD8SFWZvDuVrROoP12xBOjOoRTNuBhtuguVGCaG4BX0QlUlp7/3HZQsiVXn8wv7/vHT7rGSjRqWQdL/uahrkp0QkI2CFbtxr2U6qHjfvTp+ircvJf3eSy7N3hx7NHGBqHO5Byk4kXPab++9+onzX0z64+uWQ6jE6Eq4F2BhooLkxBGgNulIpfHRLSSSpdceJ1y/Nah2l4BenWSvcNKg9izPp8XEvHOg0fOwyzcbyk5V/sbqjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=POOaGtDq3AApC5W3w3TfrdVWi+gV/uqhSG+xPfXv1W8=;
 b=haOHaTuwKUkNiVdMTxjg8CbZ5SOS3mybpNb8e6TAxtz6u5+GMtYko5lwz8MeKDVJ/isUzzXjySB7StUkXKELqwRUH/2ungdxEPl4Zl4PBIOBGguixElbK+P4rzqYE3PVzdsyyUfZlECZjT65kKL4Gv4MzYf6IKwG6baWykgfQM8=
Received: from BY3PR05CA0058.namprd05.prod.outlook.com (2603:10b6:a03:39b::33)
 by CH2PR12MB4213.namprd12.prod.outlook.com (2603:10b6:610:a4::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.23; Tue, 16 Sep
 2025 10:43:25 +0000
Received: from CY4PEPF0000EDD1.namprd03.prod.outlook.com
 (2603:10b6:a03:39b:cafe::d2) by BY3PR05CA0058.outlook.office365.com
 (2603:10b6:a03:39b::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.12 via Frontend Transport; Tue,
 16 Sep 2025 10:43:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CY4PEPF0000EDD1.mail.protection.outlook.com (10.167.241.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Tue, 16 Sep 2025 10:43:24 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Tue, 16 Sep
 2025 03:43:24 -0700
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 16 Sep
 2025 05:43:23 -0500
Received: from xhdapps-pcie2.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 16 Sep 2025 03:43:21 -0700
From: Devendra K Verma <devendra.verma@amd.com>
To: <bhelgaas@google.com>, <mani@kernel.org>, <vkoul@kernel.org>
CC: <dmaengine@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <michal.simek@amd.com>
Subject: [PATCH v2 0/2] Add AMD MDB Endpoint and non-LL mode Support
Date: Tue, 16 Sep 2025 16:13:17 +0530
Message-ID: <20250916104320.9473-1-devendra.verma@amd.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: devendra.verma@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD1:EE_|CH2PR12MB4213:EE_
X-MS-Office365-Filtering-Correlation-Id: 45227534-aa5d-4e01-9f20-08ddf50ddcd5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KT7eaXeyb+2M//QZR12iG7M6iNwXjzWzjnWWrMzYco3MI9KtxJKMTm5X3bVZ?=
 =?us-ascii?Q?peVTtNNXx1WJ0H9Z1bHRKabxykK2Ud2zZY9aVF//csM49urWjn11fxgwCP+H?=
 =?us-ascii?Q?FUDqyBTyKdWl4vQVd0AGF+Enp4cFlIY+h8fOWiWR+PTYoDyCxTW3BI8DJA7t?=
 =?us-ascii?Q?gMKxAHKDV7lJg7ZyNQxrowop4qSuZvr75hBUEHCR4xDYjZ+ZoWI8cRWDHhcf?=
 =?us-ascii?Q?1wY+58PWyQjidZdLYpBC47efbILPprCqlApKEobsWPjO873NVnYncYx+Lemy?=
 =?us-ascii?Q?LzvcSnbbZz1Zi9GDcBzcArcSbc8kQcG/BCTw2EkaB2jQii9Imir7LSHG0KI8?=
 =?us-ascii?Q?YzS+9w/gXj23hZKdnQD26XTTv4LvMyC/VNsG+6vcrMyjMiHveZ+p2+OZSgw0?=
 =?us-ascii?Q?WFz7TMbRVPFVdiIuYkZ+YijsTl6tyeQEXVykb6RGvionorqt1lIdRsGth7fD?=
 =?us-ascii?Q?nkSUiyGz+SxkerGpeWW4URWUx2kFTOGsRsHQyOSnK12Ja9pzj1vTtEgut9a9?=
 =?us-ascii?Q?52g7p5TqclCCIQsTTO1eijASjoWoSx5lWJAEs3kVgbqzIf/RaZJENj3VXr5O?=
 =?us-ascii?Q?SP/LUAclrH2ztuLnZgv3ooMB+MNwpP2oKFWXkDTedMSmd0EtjoeNSpKImbUh?=
 =?us-ascii?Q?trM72qNHwUA5OlpNKicCcKBNq85cbgJAdhpCTf5wcWqNaaJB8Cl8xPHRm7bM?=
 =?us-ascii?Q?gsaPHcRx19nes5d0bparzSNYXPtsaX5dCrLqEVzlBOtoGWTnFn24Q7/g7bE0?=
 =?us-ascii?Q?uGQFBG9idAGFp7GG1k9U3wAXoZXFD90uVox3vsREyh8y9Dep++TSyNrLC51r?=
 =?us-ascii?Q?6AuzT1S8s/bkq0/KEc+O3m/l03eElu8AQYtk8oGcmm1JJtrGTk0d733M1NF6?=
 =?us-ascii?Q?ArORFqMJtYT8+Mz09+q6NsNMBYpu9U/bB3W2RPu40dIUtHjDxZMy4Cx7fr3i?=
 =?us-ascii?Q?jGh/JyVEtheTB1iU07rYpF9l5ODsU/ncmRDyXMoCAI2r0Cb2JojUns4l13Ho?=
 =?us-ascii?Q?LAeF2OmvznnLs9zhEeoKdviijBO5l6zTu/aYTuEJ/Z9iG2BHLFqN+4fqQwaY?=
 =?us-ascii?Q?rxxNp1puQqBUlBR7MB8izbw9VZ1YOD6jr87Tpd1vwRQEljg5gE631eUmiklK?=
 =?us-ascii?Q?rMNA48Tei6NLVdkL66kZMXIj1+WP995UOW9c5C5Dl7C7BLg+0d29Y1B7zEpk?=
 =?us-ascii?Q?RyuUrYMzJLTWHx40YoSKgmykgYNzFObmS7zo3lWtoNOABMigxrLN3LjhRjPJ?=
 =?us-ascii?Q?HvbD8NY5n5pyFOhqBAEteOpRT4qis4Ua+q4sgG5XP1QGdrn4X/iN4yT1i6j1?=
 =?us-ascii?Q?mpXNq48/RiuH6QGZrnIcnjfMWEA18S+oncCbtPOaFHtXrcwmliYk4asKE6XN?=
 =?us-ascii?Q?FTlbhLyJZzIYlBPvv6MMRtZj1ng4DFcMxZy9+qELtJ1CJaVJlLnHkNJxSrng?=
 =?us-ascii?Q?koZgWCTQ69buM1L3FLZBWjZF44iFlnWb6lAkplGZKLD25TY2fY96QyTJw3Xq?=
 =?us-ascii?Q?4jAzouY2EdHavSyq+LUybV3nOMMtovenNNJp?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2025 10:43:24.3965
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 45227534-aa5d-4e01-9f20-08ddf50ddcd5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4213

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

 drivers/dma/dw-edma/dw-edma-core.c    |  38 +++++++-
 drivers/dma/dw-edma/dw-edma-core.h    |   1 +
 drivers/dma/dw-edma/dw-edma-pcie.c    | 178 ++++++++++++++++++++++++++++++++--
 drivers/dma/dw-edma/dw-hdma-v0-core.c |  62 +++++++++++-
 include/linux/dma/edma.h              |   1 +
 5 files changed, 266 insertions(+), 14 deletions(-)

-- 
1.8.3.1


