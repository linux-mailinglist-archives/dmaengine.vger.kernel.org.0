Return-Path: <dmaengine+bounces-7131-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 60355C4C0FC
	for <lists+dmaengine@lfdr.de>; Tue, 11 Nov 2025 08:18:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F40742319F
	for <lists+dmaengine@lfdr.de>; Tue, 11 Nov 2025 07:11:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C9182BE653;
	Tue, 11 Nov 2025 07:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="kMdSMd+M"
X-Original-To: dmaengine@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012041.outbound.protection.outlook.com [52.101.43.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B2B2346FD0;
	Tue, 11 Nov 2025 07:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762844740; cv=fail; b=WZYiaC3G+rDE7cTP9o4bDx8FJlujJxSMwUyT2chs8UD+uu4i4uIasKVECHXl23AvfRcG5KEtUvZ4dsQohC2/rSv9A4qRba3cZjaVeV3HoRSpWXA7D8RyL0iYm/yMIyqoWYnRBnyrY8pBy8cVbYoIAE92ySvjgngnVQTKyeJdeVM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762844740; c=relaxed/simple;
	bh=FKNx8F8Gk/HYKfUaXoUd0tBQKChfoStQpfP+Oorni2A=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dy09swKJuhumUfu5AUE1KL82uoPmkVjEPg1DkG0D+HBOaKRsRzrcOo+0tOgpyBuXVV6jwsTmhaDDWI81PSmMePRWJIY2PRBe8qzpqubr6WLb6YI03O3Fztu04M7s2YiTpJffXl1Ul6KTgfiJHLkhbA6vSqwuuZdl/I5KsrPI3N8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=kMdSMd+M; arc=fail smtp.client-ip=52.101.43.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kn2FjaEfSrJyofNcjBK6mkXd972Lho5Ftmsq9h4wUmNESk9iZnsgu0Ua79UcWxdVsHeDDd69F1cS1NyKbWCcvYvYdxNWrM4+VwwXqbd3NN1tyajU54XJ2NSuEeAoWLsJS1y2sLSAg5yP9K+PG5IY1GdxDOl1s0rMslGi77kiQgYJCLhUTJVLt7IqfmTkGZtXwPEqUedw6/LZcgYwy9ARsJxXPZIjjn2KRRDLqP2vQ/8Nt5gEYxOwWG6+SYGf2c7B8QoHtPOj3TYLWbIq3puN++wcHVolng58MEtXFoyuLjB6wGE3mxQhHMkRtArGGZsoqQ8ddS1+l58B4jLDxgDj+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UjrIt1aS+TpVpHd1RtOccDThd+ZrRS3kLtPUaNZ5YMM=;
 b=rZAv8TeiNGjhCl1uVA3ls51qn92HzNZCmUw/RvfzA3ukSFgz8Uf4LSKyGqdHzrzAWclBmRY8s5wtEZzcoHOzQ60CPXDX3dPPsbwYupmPctOunoJjKVowptQLHKhD+7Ij4r8+NC92DcuOzoXYYYkoFRG8VIKXUOwVqayNpZQh78bgOgLawY+DtXf63YscHXSeMcP5l1oRggpa1PbZMheE3O3yxE5feYU83Ao3w/AfLOo2lNxZiSAmpvRn1KM05FCwkvwXxlnD90VH1fnTIf+8uPFEG8Nrpc72EQdyKSHf0GzvtLsZd0l3Od1n1wBz6dAX19iPrL6yr8Vczihz8OFUPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UjrIt1aS+TpVpHd1RtOccDThd+ZrRS3kLtPUaNZ5YMM=;
 b=kMdSMd+Mx7nMVR/FDMmqP8Gmb9eX8qj1A2iBNtWxuM6tNWSxiksxMtpiQm2k9+zOMIW6FlOKOskDNvPfUun3/C3YFyRtI01XDFWTb/9N3e9pA5nQUgPPmK1UnpU073AWBqCtg/USCvBZcflE5OOvbI5b+Nq4q4Sxt2ISNumRJ9c=
Received: from CH0PR03CA0092.namprd03.prod.outlook.com (2603:10b6:610:cd::7)
 by DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Tue, 11 Nov
 2025 07:05:36 +0000
Received: from CH2PEPF00000142.namprd02.prod.outlook.com
 (2603:10b6:610:cd:cafe::19) by CH0PR03CA0092.outlook.office365.com
 (2603:10b6:610:cd::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.16 via Frontend Transport; Tue,
 11 Nov 2025 07:05:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH2PEPF00000142.mail.protection.outlook.com (10.167.244.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Tue, 11 Nov 2025 07:05:35 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Mon, 10 Nov
 2025 23:05:35 -0800
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 11 Nov
 2025 01:05:34 -0600
Received: from xhdapps-pcie2.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Mon, 10 Nov 2025 23:05:32 -0800
From: Devendra K Verma <devendra.verma@amd.com>
To: <bhelgaas@google.com>, <mani@kernel.org>, <vkoul@kernel.org>
CC: <dmaengine@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <michal.simek@amd.com>,
	<Devendra.Verma@amd.com>
Subject: [PATCH RESEND v6 0/2] Add AMD MDB Endpoint and non-LL mode Support
Date: Tue, 11 Nov 2025 12:35:29 +0530
Message-ID: <20251111070531.6808-1-devendra.verma@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000142:EE_|DS7PR12MB9473:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f363ab2-02fd-428b-fe7b-08de20f0b688
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ndVKAK3c9wYlixZDLm3aF53DaESpEVSFomU1TMZH5TYB8xYrZnCO0i0IYOvu?=
 =?us-ascii?Q?BWCk6wEEZbUI3x0+96+wIYecvdLRLoFpvjVxRBYW2Dj4KB656iJLbFy0uhOz?=
 =?us-ascii?Q?jFws+e5es9uwF0gUpqhyZBopwaburIAXIxr3p6EYh9MPQR3QmTyxSNOFzGRp?=
 =?us-ascii?Q?MEMquNKgqF7i+7kv0UndzIS/m0vIPap710EpWUR6e7HwAakfgGEg3oNchcJk?=
 =?us-ascii?Q?NanLd1sk7x9MmRTcuneSUxlrYb4E8GHl3eanBLBWIieb1ap0w8xpVWyxjAdb?=
 =?us-ascii?Q?Hn5micyt63tmhQkWH1eg1kT+xBV/1HpOa07AebfHSdr4Dmal5k5C50E+Gxhg?=
 =?us-ascii?Q?hascmAqHAdzfwUvIy9zy94eNWLSune6d5x36vlmmgACMKzEf37eUmz4BvuhW?=
 =?us-ascii?Q?4VJ/zr/49OEi7niRROxQKydbhhsfQmrOnw164NQudqA7vQOEM5FGVCk7JM5/?=
 =?us-ascii?Q?OZm3j34v5g2JxAtD9NBw3zfY40eFBSH7464fv7gpHYApA9fTyufyNr6mg6hA?=
 =?us-ascii?Q?UR8jbiybi7wq5Igcgq5Lm/WpGksGqbYgoHX1+Krmq+7x9g0mFh8/4VhWt+8t?=
 =?us-ascii?Q?YB4qDW8rkShOL9CwT//KSFSp75s2u59jMGhxN5C9KCcmpDfWsG0hn7SG1hLk?=
 =?us-ascii?Q?YfkFSnkmejhYkaVDPPBWbNlBgujjpLcwrOp3uUd9ilpVBFWaElHWF91ob6zS?=
 =?us-ascii?Q?rjckk54Mi9yt8VLnz8b5Cefn5iz0BB1ICk7312qzPhyvUbbBUx+a98njAV6j?=
 =?us-ascii?Q?cLS6ud274rYH+wBblfi9r2ivsLqReoH1MMEhGKAGqfsGfihUg7WpMCIGhSkh?=
 =?us-ascii?Q?wbFQvPjyuK8Wv+csUZS0IcbucXq5XdNNzBJbnjT5WvHdBMRmjXNz8sSZ3k25?=
 =?us-ascii?Q?lEIb8+kRv3B41TVHfvt2of1jz9dZQ1IexQjUwI6QTETi+U+D1oNbKINk4cRq?=
 =?us-ascii?Q?jtNrl3p9XaystjpRqb007zlwZgKPnVAxHR3zwwHIDfXBTv6lwf+zAZcZtgzb?=
 =?us-ascii?Q?xTIAL6fzweF2X0PuF/ju/DRNCJUpoI68y4GkGVXYvIv7vq6tuEQ58g7NBkuS?=
 =?us-ascii?Q?pNUDBsIL+P0KvN5kVshy/2DekpTgDaRRCQhevBUREvEsjCBeeFDM3SQJ9y11?=
 =?us-ascii?Q?DztvJV4+y8NzMhr2wC1RomCNq06Rn/9xbOwO+4w4RTzgxT3KiWHqpYVaNl6L?=
 =?us-ascii?Q?419tkU8qy+18hiiOZwNU1QUU2AGTNhlOls6GS9XJFWCxp3A8awuaKWufTfv4?=
 =?us-ascii?Q?PRGWKcl7wcCLic2Av9Y0uqCESxt4IrwLrf3NzV7Tg1ccKaBtIEu1s0u081ag?=
 =?us-ascii?Q?A4lUcn8AgtSimkOwVyy0nPEI3MuzqeQghoit7o9RK/LzpMNSmwYd8LNe4dU8?=
 =?us-ascii?Q?my2I2+upRLPo1k1A3J929AaKOBQtXMBwkGRXsvI6hKTS1dY73zd7vlqal1/Z?=
 =?us-ascii?Q?D8WKazhFnortyjknYncaPWJZbhwID7mzoUN9PkwXRSd69Uq8Au1XT23kpxjg?=
 =?us-ascii?Q?I/dORjhe8c9sPuq4gvfmKhYaAZw1vyjnGzc5nyQLelUEa1G6zj1AlRQ9h8Ma?=
 =?us-ascii?Q?hgR/t74OInB98k52d4w=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2025 07:05:35.9346
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f363ab2-02fd-428b-fe7b-08de20f0b688
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000142.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB9473

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


