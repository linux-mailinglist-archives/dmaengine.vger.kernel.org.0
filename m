Return-Path: <dmaengine+bounces-6843-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B818EBD94AE
	for <lists+dmaengine@lfdr.de>; Tue, 14 Oct 2025 14:16:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24606422973
	for <lists+dmaengine@lfdr.de>; Tue, 14 Oct 2025 12:16:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CAA931329C;
	Tue, 14 Oct 2025 12:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="xGNHH9X4"
X-Original-To: dmaengine@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012046.outbound.protection.outlook.com [40.107.200.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EAE72C21F4;
	Tue, 14 Oct 2025 12:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760444212; cv=fail; b=ZU8N2oAUqKy/R6U7DySxLQIenvPYGM1uxAaAQwoOe2lb2G8MqxDuN10PDnR1Wgc7Tc+6y1o3BViyp7kw2JDZpc8xveFLiGMCgP4XsY2+60JrcLt3UjuXP/zk8gf6YJCoqtyGIy5VcfRB6CSO4m//vhZN5yVqQE1rW38c617VVDk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760444212; c=relaxed/simple;
	bh=yiRrxcdkcs9wJ2YZWLjIEPROYtfxLzIE2oJyzHnO+kM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pqOV29r5tHOJZp0jUDOLE4f9cJ4VwEUc+QHSDoLQULD3R37NGMTBbIpLP4wVVnPjNm9DPEvXMApiMpKMUVvzOIyRA2ApQnXSBWMJk4lbpZUPXOxppKjSH8PMcyySFpo8c0xwbUTVeg/PQmEBzIISOWKR8GRku2Ktv41KDHkeWoI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=xGNHH9X4; arc=fail smtp.client-ip=40.107.200.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I9/N0zAHIa5K9sBMnSGNjjDWUPHU5yAmrQm8OkyCVgACCLPHEOWxxxhivKN+0oe6odUyn0yI079QKS/Hyp0cVSLrFpCTIsPMVI4ZQLBBw01NFIqMQ21R0Cx29ExS2ucCfqWg0uETvwRQ/HJ3kizxxAyZSyFvKiVw4h7bSR4koi/l92nu2v5j5oQOpYRoQ44bhrT0M/w2YPlaj5Jtl3iE6EdkIWtrcC3CYhzrCtTFRpGkIrVGutif7puZHCR4tZaCSnYpY3M/A+e9GTRmpzqIE6j8lW02gv4qqX6rjz+t/AZJchHm1acDN0IB215J5sa40SnmMKLJpFk8GajpjvuD1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MbFm7EzxpDYTMPchtWmB1N4NZWywMoPUMB3TCIzOULA=;
 b=PH3YPR1s9ln+CueVpFAV/wt7X6lgUujPvsnOd8TMKXFXLVxfedB9NnY8HKiytm4fZ3RMdDJnGJb5plBcvC2lSPVostxpzxmEbRDL6SvbZZqtOs60DykiotfuVcfLLNywFiNJ3eK2sSozZcxlBi4UxvXbZHbL8bj3f6faWOoDtg4qWP2B3Y57rwz8BN/8mwiClqNFn7GhEved7MBmZiji+CM+JwRZq8338HSxApLKPae59moHuPIgs71wZVx59AJ2wVs+PGMUnnOqgCpZfv0b/MzhdtP5bWbXX27itNq0t7fcPRbX9JXjD606tiUC0ZcPkLkZek4FWyY5rlRLFHKuHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MbFm7EzxpDYTMPchtWmB1N4NZWywMoPUMB3TCIzOULA=;
 b=xGNHH9X4Fe7dorQt0XVA3w/UXXO5ve9AcK9fyxOCAlw+jvcPWYYyNS/FBuy/lEP6CplVk78lJZq++euWTiHvUaWqoyOEbb4Il6cljRdmLKix6aMwFwiuvEsnVkeJ0oVoqUySp7W4C1DyGljlat1Us7LoUqrynHX/H1FcHTqWAOY=
Received: from SJ0PR03CA0002.namprd03.prod.outlook.com (2603:10b6:a03:33a::7)
 by LV8PR12MB9334.namprd12.prod.outlook.com (2603:10b6:408:20b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.10; Tue, 14 Oct
 2025 12:16:44 +0000
Received: from CO1PEPF000066E7.namprd05.prod.outlook.com
 (2603:10b6:a03:33a:cafe::83) by SJ0PR03CA0002.outlook.office365.com
 (2603:10b6:a03:33a::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.9 via Frontend Transport; Tue,
 14 Oct 2025 12:16:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CO1PEPF000066E7.mail.protection.outlook.com (10.167.249.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.7 via Frontend Transport; Tue, 14 Oct 2025 12:16:44 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Tue, 14 Oct
 2025 05:16:43 -0700
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 14 Oct
 2025 07:16:43 -0500
Received: from xhdapps-pcie2.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 14 Oct 2025 05:16:40 -0700
From: Devendra K Verma <devendra.verma@amd.com>
To: <bhelgaas@google.com>, <mani@kernel.org>, <vkoul@kernel.org>
CC: <dmaengine@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <michal.simek@amd.com>,
	<devendra.verma@amd.com>
Subject: [PATCH RESEND v4 0/2] Add AMD MDB Endpoint and non-LL mode Support
Date: Tue, 14 Oct 2025 17:46:32 +0530
Message-ID: <20251014121635.47914-1-devendra.verma@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000066E7:EE_|LV8PR12MB9334:EE_
X-MS-Office365-Filtering-Correlation-Id: 409da0e0-e0d0-4525-c281-08de0b1b8a12
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Qqvz1wks7Mgir8BrRzgBgoN0GFC1ZqYGehifmouLV7KiGVPnFrActKvxD4pS?=
 =?us-ascii?Q?z8FARW60K4UqkM+YbJW5+fUEDWSVj04xCv95k76nOSaZZLBtghYdq55VJEtV?=
 =?us-ascii?Q?JJ2gDAK1X/SpkWU2mQbvJHQqTHAeveu5h3mI5pvfWIuW6dOH5LLcwlpLmqz0?=
 =?us-ascii?Q?eAFyirkXx8hkNZT17+YJ0ixdBwEMifjz6jQNNmx9rMMimu+tpCYimWzfwxG3?=
 =?us-ascii?Q?A6o9KW5YSmhyAftYHPWIsLH73+k40eMntO8YSG+QGuvZ42vcMdtFmTLS5EQq?=
 =?us-ascii?Q?lFKw7vkTxsfhD3dRYu1ZjXDxSqHspo7mo1KBURbSBC6qQKZA3hF9xHzPeTwO?=
 =?us-ascii?Q?HF+hSGR1DpHNryUytKNFkTEwvECmxSp5Rwz/kvd1CJlQAvPmdaXy8yWKgAi0?=
 =?us-ascii?Q?pBls1/cGE2mkDPRGHiiAn4VN0gfebiVT3VwnPIas+Lj9q0RbWUU3c62DoXzZ?=
 =?us-ascii?Q?0RDbwjG+O7t92KYyITJlzkG7i0NcrOIIKRbGGrI5FOTRiKijxVLjnhhPNl9w?=
 =?us-ascii?Q?d4PB2x8/jWLpo+Coo6pwME98MUr3q2K+FStjVif5AEr5L0iZqVE0YEKvShKW?=
 =?us-ascii?Q?VAg416/YPrgDy8lU3bA4kjtlE7l7RZC3vC97JalCqHAbIkRQqyoP0DGLEyR6?=
 =?us-ascii?Q?bjQPtgU6+oEEjV6HezMGrTohycNEgsd6qzESsZPI0Fu63aY/knB5tbQxpjWE?=
 =?us-ascii?Q?wJ9BtyIFepS0P501Ugia8nw9ButXCqMHHOc2tKvYXUEm0UOYB/gXFuuB6yLz?=
 =?us-ascii?Q?7mvujm49ThDds1lr34s0ZIPzTWDj0WJzf/tN4T0DBhP4/zC2vPwdCpfWNhAg?=
 =?us-ascii?Q?CMFH6M1uLBX6B3V/EgvJQ2ITR3Xn7VX3oReGz/nuNlUaAElfpVwB7b+F9L4O?=
 =?us-ascii?Q?uYhZs3OxHCsB6DH9hnR+jH2wPN/Qp+Jcz1n/kpNFAd/8yZeDt7vXns4L6dij?=
 =?us-ascii?Q?woZrdgDdXjagM13idfidE3U180S9jGEri+l2vUahobvi88QBjdfjIzhW+vQ8?=
 =?us-ascii?Q?WsWrSnNKgrAe8iEL3W8JsidO7IjyPU8oDraRPmeUS/Wq/VdjHOopDny1/JKV?=
 =?us-ascii?Q?IW/NznM6DCXia48DJb5AK8uPKfMu9CUZL20/yOBvzrZu7UFodjHFsxdqzqGF?=
 =?us-ascii?Q?sWhC5pauLUTVybFVTFwuoJdQUQu/ZiaQPXumJV+/vRpevA+d82yOzaiVhWP0?=
 =?us-ascii?Q?dHPLJlmX9Rb7lc7NNKv+sN1qqp02Er2f0qSRmUPwo2V4j/W4iaUFbN7SFbVL?=
 =?us-ascii?Q?KKlL61U1dw8xUsFY7kjwZyXUc75E7ymIlcu+3JyogaqkM/kK6YTm9f2pOoN2?=
 =?us-ascii?Q?G/Osu2WB9q9mVyV+WwSW7uv24xBT7TXfsxgoA39jQHN6scSI4QKgHd8rT/gF?=
 =?us-ascii?Q?ceDnGgVZg7w1nNY1Rq5rPgH2lBmXIgOcX7GAGKr/s54mYdtbZ5JV0ZFm5o1Q?=
 =?us-ascii?Q?z6Ieb6J71LxR/Mm/gxG0s9o6UhjT700ZOB0rA3E8BDUAzoctSSgLq2oST685?=
 =?us-ascii?Q?bMN/0/jdfJDCYG0fc09Zqb2joNm08GSq4c+N4WysCI+sJruQnmy+OS6N5i8N?=
 =?us-ascii?Q?YdeTnUppswnBsvLatjQ=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2025 12:16:44.0349
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 409da0e0-e0d0-4525-c281-08de0b1b8a12
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000066E7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9334

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


