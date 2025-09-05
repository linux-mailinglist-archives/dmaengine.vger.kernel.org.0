Return-Path: <dmaengine+bounces-6393-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AF90B4544D
	for <lists+dmaengine@lfdr.de>; Fri,  5 Sep 2025 12:17:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31FC23A4F7E
	for <lists+dmaengine@lfdr.de>; Fri,  5 Sep 2025 10:17:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E99902D46C9;
	Fri,  5 Sep 2025 10:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="QrvoJsIH"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2048.outbound.protection.outlook.com [40.107.243.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 325232D3EC7;
	Fri,  5 Sep 2025 10:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757067430; cv=fail; b=rl+mUe0JQutH1322jNxX5kidmKB5POxI6Uzt5Q9NygIgFGKsDeZQJSB6dbup4c7qL5ESwrUC0sW0S7K39Bbbi7pP0i4NwcKr9oH1gJQ8bnMmVD4Ftaj3Au6QbupZ+UP/uJh+Wk8sgZ8UqhlgQ49o2/Kub9XGSLsR7S2VKVMTBwg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757067430; c=relaxed/simple;
	bh=9Xcv4rqSNajGdBNFi3R80KL/TUDbmYePRogn8qLuum8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cPEvJvODEgPgFzO9UtvYEWOPnia2GYF2QjQ60K8wZh8ytMtlNgPfRnMKEQruskTLLbymDm/wpnQlammjWNR9M1bZ4+/ZQMohluIHMrMIfGAIAHIWqgfw+/phfqA26nKYzpqUXn14G4oX/42YfMXysVhndN69sOxAEiDjhQMcNCI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=QrvoJsIH; arc=fail smtp.client-ip=40.107.243.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YFMdwlFxLUYhtpHcxZOigdZpFEVDB/pzNMKZWXE3ufpdWJgHSWVoEQmnmPsthkamAO2kJYRMOGn+HC+qJ/ZtNLFBBQc2HGLwX5ME80+E+LXB9799oCEXnSj4bqGBCpreCuu6DpEqKF7k5GNLwY/+U22wAePuNQ4w9vD0CRbO/ExQmXotRvbH/Gd4vkt7382vdSjirzQcpTtGt9npsaumKY+SmoD/88haXQ7cyl23ueR41MnE4qLdEhTgHfvUg1TOu+gjsNALawpfIVn7cRY4/I1pmaMURx1PgVhZOfbxwvEHp0rKUKosmC0G1Ccf4RzrdHoEwwXhkrG3q8+Oi7Ws5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+qFoRxccUWRF03+AtYNZH95GXwlmrH2JH7Kdjege5Y4=;
 b=NaQFMxrDt7jbRUMOHGUk86FmmWx7Qyu5bgbtljt66LXYuhgNRqAXNYAnWTANqSaXdi4zpgL2KxdLQZxMloPvN1Q7bqhO3J1l4fjQ7s777U+/QdT8NvC0BirI16K4rl6xVmMwWFu1CI/PZ9rDrQTFus/g1D4KmKUE9H5DdbiK4gAeIYbwjP7ZYqhLEBjUOGqNWxAURhWe/OY7cqZYefgLJcMEQbl10ZRY1slLD0w+v1TwtDH+W1bW1QkdY/3ogFgJBQQfd7ovSorCc0e9d4NUzZBkJs8AjEOhNTxHzzfAcKoGU+6FrqdPQB9YIW+r6agNsPDcuIyaW7OOcattb+RdrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+qFoRxccUWRF03+AtYNZH95GXwlmrH2JH7Kdjege5Y4=;
 b=QrvoJsIHzJHLUD88foy9Q1ccyhELumL/yxl040WnzVazOPsreBw+QaT43SOXxd5cfuJ+O+Q9RY2hM6NdjcGGhE+3hEEJ/dmNTNJDKCh9MtOvl48umZYgUp1greZAcwhr4wTCib9uM/6EbOvq0ccWprW0eclKeYS/J8SnT+GXPiE=
Received: from DM6PR03CA0066.namprd03.prod.outlook.com (2603:10b6:5:100::43)
 by DS7PR12MB6285.namprd12.prod.outlook.com (2603:10b6:8:96::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9052.14; Fri, 5 Sep 2025 10:17:06 +0000
Received: from CY4PEPF0000E9D5.namprd05.prod.outlook.com
 (2603:10b6:5:100:cafe::40) by DM6PR03CA0066.outlook.office365.com
 (2603:10b6:5:100::43) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.20 via Frontend Transport; Fri,
 5 Sep 2025 10:17:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000E9D5.mail.protection.outlook.com (10.167.241.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9094.14 via Frontend Transport; Fri, 5 Sep 2025 10:17:05 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 5 Sep
 2025 05:17:03 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Fri, 5 Sep
 2025 03:17:02 -0700
Received: from xhdapps-pcie2.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Fri, 5 Sep 2025 05:17:00 -0500
From: Devendra K Verma <devendra.verma@amd.com>
To: <bhelgaas@google.com>, <mani@kernel.org>, <vkoul@kernel.org>
CC: <dmaengine@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <michal.simek@amd.com>
Subject: [PATCH 0/2] Add AMD MDB Endpoint and non-LL mode Support
Date: Fri, 5 Sep 2025 15:46:57 +0530
Message-ID: <20250905101659.95700-1-devendra.verma@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D5:EE_|DS7PR12MB6285:EE_
X-MS-Office365-Filtering-Correlation-Id: 18b5353f-614f-4c43-ee54-08ddec655d4d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HHiIu8VUZtJU8/yP7OHwTJHpKMFB3C4FXF/n0rO9shkc0oGypDRIX8OD6bDM?=
 =?us-ascii?Q?KspYL4Kqwtnw61y7nYFXAc8lSuOZi1R1mISq3IBo1obZ9dxx1VsnBP4mx+Si?=
 =?us-ascii?Q?WAv0d8mAXwQRZj3fT57xAVC6gqfTma/C3v4Xg6t2Zz6pIGA0ywAMjcJCOhN8?=
 =?us-ascii?Q?16nbGYOrIciLwmy5iXV3t7Q57CzVOS06mB/tp6ZLzfFKv1794v5zqvdhquQ8?=
 =?us-ascii?Q?62akmHAH6LYTZZ+WcsJRlNE/rkzQsDixgRMKBNBXeCAPNlXVw9Z/lnj8tQAH?=
 =?us-ascii?Q?LN5rcvWChLnNAt4lotTaVrHiS/V2k0LsXHOXTCKFQGFUBrdUvqSCfb/Yo5a2?=
 =?us-ascii?Q?CA/96/37/bab1ICy5lpQGdoht6xIydT4USDhcQBhOJ5tJEXH7WzVP1Refn6c?=
 =?us-ascii?Q?WZj6KRtL54NrXkazie1rBur+EA/kLFSDI1CDigWToOCM8l/6ivRZklpsZwOJ?=
 =?us-ascii?Q?T3IqheS3i0sKu1elZMluKl8PeP7yLgNaWGByxGpylyyEELdvNiw7oVtjpG6O?=
 =?us-ascii?Q?i/rCRM0b63cHYIGaugWMm3tUThNkE3ecvGGKK6AP26Oo259vT+X8UczLbt5a?=
 =?us-ascii?Q?uZlO+MniYEQbUth1SoJMt9ej7u2DzVeV2g9gvi6KZco8+XUouxoGB91FVf8+?=
 =?us-ascii?Q?dp4NkLPAlFjl8dqiJzfGs3r4D5G3eZ/5AbURDyurGQdXxKeT3zBThL+IRKV/?=
 =?us-ascii?Q?U+5KEU5DrZ8LpP1YjvVTMNDSyNZfOf9DvTDPx0Axmf1aYJB7a/rjAhC2NRfg?=
 =?us-ascii?Q?meitt3VQDhIWBxtgJjkrlgfiqh0MaZRlx23aaAG3t/X6wERvHBo8heCInWzk?=
 =?us-ascii?Q?TQXEGpom3AmmowFugLkHFoY7mRTwlx5i0wDDjl0KiHae5+Jpo3ww7j/YG/GG?=
 =?us-ascii?Q?VJPiT0wWzUYSik+i6p2TYtPIgaB61obPXsHRptw+OUdVR2ytoyGWBAVarPna?=
 =?us-ascii?Q?ytSFkpj857e7d9cAUIZsffuTatSKMRR7jJbEIkW0ytE1n0lyOt7kCZpCOhv6?=
 =?us-ascii?Q?uV0OdEp3EAJs5XiIn2vctRtMrikopQZEIdUZMMcOYqv67gxNvkPTR7szxZQO?=
 =?us-ascii?Q?ifdI/+Cl6kMXkWTpoXKKbCBF9ofykczTttYHEpf2fhBnntb8UqFI2Nk4iIX+?=
 =?us-ascii?Q?d/p6k3dSzEGZKS3GGA+sSzbp0BPUI+FHxj6zhb3Epkq6amYN6JNQSCzPnFYp?=
 =?us-ascii?Q?fSPvZlpmWV/trI3Zm2H7+Ik7GaY/8Qw/TOqApjIzVbJesbwXjFaB6/FLcDpL?=
 =?us-ascii?Q?HbI2NpiKRA46hh1z/zZQ/oTzm2REi3BwSZP9e/qx8YgqLHT2B/XnDQChkMcG?=
 =?us-ascii?Q?UZihhuSM387T+gpuNpwnt+x7mTCJMFxGBWBWaP6K1dhHtOB279n4o09We5X6?=
 =?us-ascii?Q?2fxbV4ZsJRA/uQYCfRJ4gW311v9zZKZ/wk1sbIIIbCDe4SH6Pby4X555eZYQ?=
 =?us-ascii?Q?9bmKYoYMkIOonB+MByVZqe7Ga1mhBJTNu3ZJm7oMk79edagCYEGDdwHLC8kr?=
 =?us-ascii?Q?vEInoUDEPcpku7LPclH+sx/CbCWtaOHAHq/V?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2025 10:17:05.6829
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 18b5353f-614f-4c43-ee54-08ddec655d4d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6285

This series of patch support the following:

 - AMD MDB Endpoint Support, as part of this patch following are
   added:
   o AMD supported device ID and vendor ID (Xilinx)
   o AMD MDB specific driver data
   o AMD specific VSEC capabilities to retrieve the base of
     phys address of MDB side DDR

 - Addition of non-LL mode
   o The IP supported non-LL mode functions
   o Flexibility to choose non-LL mode via dma_slave_config
     param peripheral_config, by the client
   o Allow IP utilization if LL mode is not available


Devendra K Verma (2):
  dmaengine: dw-edma: Add AMD MDB Endpoint Support
  dmaengine: dw-edma: Add non-LL mode

 drivers/dma/dw-edma/dw-edma-core.c    |  38 ++++++++++--
 drivers/dma/dw-edma/dw-edma-core.h    |   1 +
 drivers/dma/dw-edma/dw-edma-pcie.c    | 112 +++++++++++++++++++++++++++++++---
 drivers/dma/dw-edma/dw-hdma-v0-core.c |  62 ++++++++++++++++++-
 include/linux/dma/edma.h              |   1 +
 include/linux/pci_ids.h               |   1 +
 6 files changed, 201 insertions(+), 14 deletions(-)

-- 
1.8.3.1


