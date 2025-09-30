Return-Path: <dmaengine+bounces-6731-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5101ABAD07F
	for <lists+dmaengine@lfdr.de>; Tue, 30 Sep 2025 15:20:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08F2717415D
	for <lists+dmaengine@lfdr.de>; Tue, 30 Sep 2025 13:20:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E03CD309F12;
	Tue, 30 Sep 2025 13:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="fUYgshD4"
X-Original-To: dmaengine@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013027.outbound.protection.outlook.com [40.107.201.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E63D23043C5;
	Tue, 30 Sep 2025 13:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759238288; cv=fail; b=pUZF6e3IzdcQ5qsCpOOaTFQvjt/VQjsBYMK9SQdwpe4P0ttYUtuBS8nBpZ27JZO+AKXe1Xech1veoTyE9BSrOxenVkCpn3yhVDJZhIjqy9ainM18gHF74P2v/1ZNhYJvT6VOv8VjRQLPSCHb1gIsMoSeTIXw0Svbz9Mj1YkK7lg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759238288; c=relaxed/simple;
	bh=D46ARqk356im1/6n1MhQN+8qIaVW2jTQGmrV7AuOqQc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cppno/n0+11PRsxhJbosOTdvYawvAzHC/akSP2/XG+qg9BM3LTaip2Fp5U2pqkuB3YANJG+dGTnlD7bHTL+tFG9Q25dZd53As3MiIFJ/8LX581kKrGmDnWJXlPHapLaS3+s2xMpdKj1ysxl5+sEO8kINLpFmm1C/9TZ7CIFqwLQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=fUYgshD4; arc=fail smtp.client-ip=40.107.201.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dobO1LiXxsSof8FutwBleJOw+wQNUpFZtsy7IRfqPUBqzvKegdnuhmux313Rryz3oH/EbKBPcRELgX6Oic8fX18IoU6Emu/ytoB1f4bQsnbIHJsF4pMvkuwEWl53jmalDt8sokPDYOybET3O3imVVfnmOikn8v1NEE6b2w0LuSft1qWoDLqvD0CLdEzutxBBOuOZN862EbbGPiRaIagFd6AF0Agn3h5uIRdtbEzzyP83H/VFOmfWUPQf0PLmuQEL+GBCF3G9DHC6IMzAXSHwsrU88xz2VAuQH8gngJm+P/nS9v7o+U+phvcHLDwL/JWe+vo4U7/oVQoyBsk/636JPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=igsW4tD1eLCjzTZaWUX9e5VZCIUEaQn2U1Z8eQVXZkY=;
 b=J43Zly1+yWZWf6yAqpeQAHXe+GgcXQI5mM0fCTQOWUE5nLo8yn/xovbCR+zsfhP8pL1G43nxV7wzyrO27SxfYkoaFEe+84WA1EtLXizi6rnL5Auc5BLo5VOJhCq1WPJ5dvdZJoXVhpsV9zNRI6nwgmcNufCYoFFvYHlEZiAVCUBGW+ueADZ8bgPZsW1mM1ViQhwu1Vs1lI8eLKRpm9isA0h4Q6tDsYvgh3Z7uJToBkolGLbD/oF+jGG9MfXe37WJvAY+Sl1/z8/h501RPOitL3PobnpgN7zGn3JyUDoT9LBf7yuPD/QzY0CesvMDNSzC4CkAinal6tWoe+7wyaFBNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=igsW4tD1eLCjzTZaWUX9e5VZCIUEaQn2U1Z8eQVXZkY=;
 b=fUYgshD4FMBSFZHfpAHes9B56AYOlmpbMBCAkgojx5f1umJfSyc8+qn6/HFLrZQ2kHVF+jkvxthu8ErZ9M9rYCMCKoNZIo2JdZaRj3SDGwtokCda1XS5a0SGCEEBwvW6Dz1l0yYncOZn98uV2IL2w/gL94847vd9e5pYbqFcT68=
Received: from BL1PR13CA0097.namprd13.prod.outlook.com (2603:10b6:208:2b9::12)
 by PH8PR12MB7277.namprd12.prod.outlook.com (2603:10b6:510:223::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Tue, 30 Sep
 2025 13:17:59 +0000
Received: from BN3PEPF0000B075.namprd04.prod.outlook.com
 (2603:10b6:208:2b9:cafe::1b) by BL1PR13CA0097.outlook.office365.com
 (2603:10b6:208:2b9::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9182.14 via Frontend Transport; Tue,
 30 Sep 2025 13:17:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B075.mail.protection.outlook.com (10.167.243.120) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.9 via Frontend Transport; Tue, 30 Sep 2025 13:17:59 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Tue, 30 Sep
 2025 06:17:58 -0700
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 30 Sep
 2025 08:17:57 -0500
Received: from xhdapps-pcie2.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 30 Sep 2025 06:17:55 -0700
From: Devendra K Verma <devendra.verma@amd.com>
To: <bhelgaas@google.com>, <mani@kernel.org>, <vkoul@kernel.org>
CC: <dmaengine@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <michal.simek@amd.com>
Subject: [RESEND PATCH v4 0/2] Add AMD MDB Endpoint and non-LL mode Support
Date: Tue, 30 Sep 2025 18:47:53 +0530
Message-ID: <20250930131755.3844-1-devendra.verma@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B075:EE_|PH8PR12MB7277:EE_
X-MS-Office365-Filtering-Correlation-Id: 61dd2bd4-f58b-450b-08ee-08de0023c70f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bp7B5b1F4FyGCI4oFLZsLBCYEC38ECg5sUhhdAFKSYRb63CmQBGOsBCKYifl?=
 =?us-ascii?Q?WvjMkjBrX7q07pQpTh20Q+va2sABhpNyay44re13eFw1NLGyJvLBqlc2dsYP?=
 =?us-ascii?Q?cO2/saVwih3zZQMUL9Qxftds/eugIDIMdWWereb/rECW65XLd275hqARTROw?=
 =?us-ascii?Q?SAqLHg9KMe9mIY33BJevf0zrSP9EF/12ACE9RlTA03BFLF/lhMYQQl1KOWWC?=
 =?us-ascii?Q?dyiKCAVKhG2JuYv+hAMrWZa/RrVTp+w6KNOq09h3RS8GyB5f/JOoSdxHtPAf?=
 =?us-ascii?Q?UeZKq38t66c/FPONoiAr6qLhP+FDgzL53RlzyW5RZaBcxZBeXcELiE1ZT0S2?=
 =?us-ascii?Q?fxJAmTbBKL+NvnnnsmQh2Wsl3PhHT3MKZjrRcFeer+AfwPkdJ0xhQKqqxuEL?=
 =?us-ascii?Q?1FYneBHUSiOfwIs8tx+jpk/tCau4O/zrpdOqeb3zdg0hpM2iN5cfBhFX04P6?=
 =?us-ascii?Q?1x7IF+IdwpaLjl7945QiqNOaXrlbGzveDPau3RfO0E6LChB5ExT7vg9ZBryA?=
 =?us-ascii?Q?5nOTYJOqr5UJfCVf80fexUq0W27yWLHXghyKyY7LI2WV4uaWcPuismksivRb?=
 =?us-ascii?Q?aJAXXll0QF7UERTe+CuzSMhXVj0sE9fFPpi4WmmR2gL5B9Q/0g0l2uWa0/Ou?=
 =?us-ascii?Q?fqQdQUIOie28lHFlyKeiG7IvqNhiuetLkQfiIfJv8ZOPIVCw7icDQmWrTWi4?=
 =?us-ascii?Q?/Htm7zgDchFE0fb+JhkHCLymEQSE5i+12WbHtZyYciTNjVzGb3ENGqW8D7s4?=
 =?us-ascii?Q?gfO2hvBNO4ku+LxcJ9Jd4TON7QjIn4PgWB6Ux/oxSBemaU69/XouXcAUd1pZ?=
 =?us-ascii?Q?QhafxAE01guPnF9zFPv6Dp6edF5A4sC7CeMefSoaks/YSez7/8jzjeyPP5K9?=
 =?us-ascii?Q?VF2W7n3dW37wHc51XFuux6wSccc22CJ6my/LDJwDGBsSomQmSPPrLuAlCzII?=
 =?us-ascii?Q?sRK2/Bz70Oj0/hGRw757LMKYhikTOEFI663WFZfUrOgarxIONY2gu9dZHnb1?=
 =?us-ascii?Q?uEfNjjJp9zj5afbkiwJHpfSVgHD+PHAD+fWxReMAKe+i3qCjy9SBJtbtXJWl?=
 =?us-ascii?Q?Dhx28t7Iazlnnt/sB0/XQICjX5ph+G9dx0bDvPfiVDLApF99xBwhN7NiDVH3?=
 =?us-ascii?Q?bHrncCCqS5IyLvbWDh18Ee9F+nN1dXBXg2iiqG2powaH39AsbkylMXVbEaaY?=
 =?us-ascii?Q?YOQrHaL7tkFYCVqoRG46bvSN1pCac/LLIsDMENfRs9nX/8MKPzrkJZpbGvas?=
 =?us-ascii?Q?pt3cSU+Q/IOwZ3xhzcg4tTbJ7u9OqaoXd2gqQowW+C+Du+RpPdwHT1baSTal?=
 =?us-ascii?Q?tsntvBq69mywma6hfP0bIPLYc24xSXjaF2zz0GV59Bb8t+60utMC99Ofe7hP?=
 =?us-ascii?Q?Pn8/eqIc5CwrqGvsiWFAHuPRF3eMWLCp4SLlheTJDWI+nwOjYyKqktX3je5y?=
 =?us-ascii?Q?WkTn/tSKtjgBibiOs9SMqFkMo+I29WkaCYYGjJGl7C/1LFdefK/BcW6DCPwQ?=
 =?us-ascii?Q?UtqyGl0tvEh7gM3RmOV3whLZmSWFLyjGb+0MTc9j3uBSug/eL6wWbbPayCgx?=
 =?us-ascii?Q?87RGNiecxQqzKb+fO04=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2025 13:17:59.6257
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 61dd2bd4-f58b-450b-08ee-08de0023c70f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B075.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7277

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

 drivers/dma/dw-edma/dw-edma-core.c    |  38 +++++-
 drivers/dma/dw-edma/dw-edma-core.h    |   1 +
 drivers/dma/dw-edma/dw-edma-pcie.c    | 160 ++++++++++++++++++++++++--
 drivers/dma/dw-edma/dw-hdma-v0-core.c |  62 +++++++++-
 include/linux/dma/edma.h              |   1 +
 5 files changed, 248 insertions(+), 14 deletions(-)

-- 
2.43.0


