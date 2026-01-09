Return-Path: <dmaengine+bounces-8143-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AD48CD0944A
	for <lists+dmaengine@lfdr.de>; Fri, 09 Jan 2026 13:07:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6AF8A302A7E5
	for <lists+dmaengine@lfdr.de>; Fri,  9 Jan 2026 12:04:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 766DD359FBA;
	Fri,  9 Jan 2026 12:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="BPV1ehPT"
X-Original-To: dmaengine@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013016.outbound.protection.outlook.com [40.93.196.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 117C533CE9A;
	Fri,  9 Jan 2026 12:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767960248; cv=fail; b=CdjzKJkM1ttyu/hLgnIBglrB4+GeLUzmiRNgZeGt4eNFE3umpS6uQghKBsIPBpl5LwB4/BeEs3LEpk74O1LCiComCz1QXrMJ7X7z29qYGH2dnb6g2Mg4DhzZv/9ex4jO1ueMp0cF89KvdnQXXUHnlsey9UfJVhxvHkddcz+hGRU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767960248; c=relaxed/simple;
	bh=DU9qWaZlWUC6MAaRQClfBST/iOI0QTe1wYs5f4Cjue4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YfwbXbhjGKd0sd+pfcWc6guSvH393a/gjEyk6ZQScXbRWwhpCj6VyBO0WrzSUDh8cwEN4kuzPcH++FMdzoqkzAMjz158a9ytRz0wk0j79wNPCWU1riZmrrMPRPIpoB3eI3h3cCnxo2L8AQ0/FDURjDyiorzP4V0gJXJMWMqS9wA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=BPV1ehPT; arc=fail smtp.client-ip=40.93.196.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vtzEpCdef2KdBv/A1m4S5sKq1EC5KYayroJ7QM1ogb2TXjkQSJIH7xMqiZJUne4tfz5yjmiFFnjHBWdpQ5I0xa6DPTBfCrccfeIOxYoZ9c8C52VGSthfkuns431d5bbh3zBBRlBMYqQSpsD2IG3TdSpHjUNFhvVAYD5go/waCUA5x7QIOhgI9MnZApEhZz64YmevCgO20R76fKXBE8gdYF4pAniPkdYDWBwtaLcv1HjH7iVWbttO7uLBYDokNMVfLHIZL7R0vEZQo3ZAdB87NRaUggNR7oiPxvVHLg5opyfBLIYLHSg+GfARZPwTkhGW2G1gfPSVqHWNIvVogDOYFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hrz7GX4Hq9Ejg2+QPlUVX2xnVxnlz5v0v7GZKVGNl38=;
 b=BRlHlYa5bFas5YvwdhJ6qEv8Awep38qUWEPnOFTMZ4rfeJRFfTFWPo1bHqDdn7DSAL8ak5nJE2k4ux/MWjwkfeJ1BQO6sIAcd+C3GQSOTqiQyCzWUgC7R6sd9swxzvYEe28DjCUb32N2bmxyoEfZSjqRDkY+MyzoTyLiQpa4dlQGcPWHaC6/qrF3nX8gpxlCb/SEjR3QraOBW6qBlSRvV+0WWcgBlR3+L0ah14eqETIEvAjnxER3Gm0IrfG/CFYuwB39Ir0d5NMdK056RSlIEQ3P4eOwEjbNPKvXToZHbz4RPguet0EgxGSUaybhqBsqyMx1fFpR+YZfhIN5cXN1NQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hrz7GX4Hq9Ejg2+QPlUVX2xnVxnlz5v0v7GZKVGNl38=;
 b=BPV1ehPTkW2fAJmpEbOfCluT2Mvfhn7AP5l8giEIR2EypKg/efUzaDkjm1rjMLx+qrenlaqw7XxK3CbziRI0iZESVzMmcQpItz6aYqVnMl6q62LgoBVWvBh56W9lpp3fNx9W4UwW6du0GbK2uGXpdQlYolimdvylEU1NBDCrroo=
Received: from BN9P220CA0020.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:13e::25)
 by DM4PR12MB5721.namprd12.prod.outlook.com (2603:10b6:8:5c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.4; Fri, 9 Jan
 2026 12:04:03 +0000
Received: from BN1PEPF00004687.namprd05.prod.outlook.com
 (2603:10b6:408:13e:cafe::4) by BN9P220CA0020.outlook.office365.com
 (2603:10b6:408:13e::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.3 via Frontend Transport; Fri, 9
 Jan 2026 12:04:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN1PEPF00004687.mail.protection.outlook.com (10.167.243.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Fri, 9 Jan 2026 12:04:03 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 9 Jan
 2026 06:04:03 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 9 Jan
 2026 04:04:03 -0800
Received: from xhdapps-pcie2.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Fri, 9 Jan 2026 04:04:00 -0800
From: Devendra K Verma <devendra.verma@amd.com>
To: <bhelgaas@google.com>, <mani@kernel.org>, <vkoul@kernel.org>
CC: <dmaengine@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <michal.simek@amd.com>,
	<Devendra.Verma@amd.com>
Subject: [PATCH v8 0/2] Add AMD MDB Endpoint and non-LL mode Support
Date: Fri, 9 Jan 2026 17:33:52 +0530
Message-ID: <20260109120354.306048-1-devendra.verma@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00004687:EE_|DM4PR12MB5721:EE_
X-MS-Office365-Filtering-Correlation-Id: fd52ab7d-e6d9-4f59-b35b-08de4f772ebc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8I8miGznBF8hBiE3+wzC1o67KcNzRJnHxbNC47/2UDX+DCvCatvAhYz/m4nz?=
 =?us-ascii?Q?EuelMMRf3i90AvBS17azP6B9Dv8jygjyjpxtVoA6TkucP/F2tZHQmQk8B1Zv?=
 =?us-ascii?Q?ckR4WG2BhaaWR4Y6dE5qDA4981rizJe4aQXdg+n9M+Y0QCFDOJ4QzRfiq3w/?=
 =?us-ascii?Q?unQrsJXtpNEQpEJc9unvHod65bdywMMn+wHT5WsOnwq9af4sfIkPmKFCqR90?=
 =?us-ascii?Q?cPAs6N2JrYsArdul/a9734QZl/bJhE9gWLkK+xEUquAbygM7T8kP/jmGZggS?=
 =?us-ascii?Q?m4fAU17k7in5midMkTVuy8ilCUX2ji8pSpYxW7n9wBsoFxxgjfqmqQvPYnQz?=
 =?us-ascii?Q?GsWjwXDKnjHHXXJu7hg/ABDdEM+rKRfIxiZ8271AVcQzgIEJveOGxbPQQAu5?=
 =?us-ascii?Q?Zi4PHHZNuUz/QvHDjIO7pVsWq+W7UBpNoGY2spvuSZ5Ds7LPeQs6pYtfAfYw?=
 =?us-ascii?Q?NTTRFRNp5FvJQAjQUiPr7fUjEKM+I+Vi2dDyejfM94IjvVFmP/gVdlYxniu4?=
 =?us-ascii?Q?xI4kN9+HlJ06NO4PWajQc7Alp3qxxyZdMbq2taq/RICrBSJZrvtZEarM3VKv?=
 =?us-ascii?Q?/PyNFWnyq20sCE13vK67d8P8O3o7HEROwvOKsIUPjDpy96h8zn0WlIYmiqW8?=
 =?us-ascii?Q?IrsBc7XfZEpub7/rfUldhfpO4SC8H1iSrNs+GkTuZs6o0QNHJb4xHSNPXyi0?=
 =?us-ascii?Q?6SmJ5tZJr1IqA/RoCs1u6uFdqgUl26o1V7YeGtBQMtYSCWSd7aSMc63691mM?=
 =?us-ascii?Q?90mc+IB3aobhACb9PXpWHryEpZ9k+GZygaegfFXwviLFYsnrCb4/q2ePqFda?=
 =?us-ascii?Q?KMrTuK+KtbBDd48V21zt351Iw3Kv+ad6x2NABXFTZX1GTOG9SVbwVw1FnAvU?=
 =?us-ascii?Q?motwtDHtrR/0pjU3qDi9WOAgeRABTuhfd6BYE8NVER/8+AFzxsFwIjF27MEl?=
 =?us-ascii?Q?QV7xYiegE3ORQ3Pe099XenyIOYB8EQtlumJrjwdYFr4SX5KeGYqZDA0R9n9J?=
 =?us-ascii?Q?rMrM+Jt8+nqso8FBaIjXLX99IoJGjPeP6dgarkVfGPHd9GAgbx3EMF0qHzF2?=
 =?us-ascii?Q?9ir/A8eEMm/TiXgdzSTEoK3OFEGx39I5IGNlx6H6kvAZZppAhMgbpqOhbY/X?=
 =?us-ascii?Q?OB0cS5NmswXk5az4L141WZ07s7Cm3oOos42jd0mQS/mFaAOIcCK7XWJsE5JL?=
 =?us-ascii?Q?Fb/fvCOJlvjiEPfzOjbkcYkre5fCSAjH9tl5Oli2jk7M5ubbq8eQQlSdXtXr?=
 =?us-ascii?Q?ttsC/d+Chz/tjzoc5H+f8NAbujoPWbTk3CHp/IIcYOKpPPF3F5uBHpV95PXO?=
 =?us-ascii?Q?gD2MPKTEfvoniHNwXhW62DkAfPpYf8er0WZHK+0Buttxpq/RPBOSeHr88KxQ?=
 =?us-ascii?Q?zVRpedEXpMl6RIx9L0l6wm1hxiPq60u8NRNJLr2yonvmUkXl3T2No8C/Mdxz?=
 =?us-ascii?Q?iiyO3XBLSKMiN17Nth2/1kh3IEn+AfMbUjORNleh7fWiP8vpAme9Kyti/Hu3?=
 =?us-ascii?Q?XvHI6NsU5HhsmBtW4nAgmQQS/IWjWfzTSv2KiG86eiCA7UTA2ix2FKyAJG1o?=
 =?us-ascii?Q?wYRmcXPYCJ05DNkICsA=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2026 12:04:03.6608
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fd52ab7d-e6d9-4f59-b35b-08de4f772ebc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004687.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5721

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

 drivers/dma/dw-edma/dw-edma-core.c    |  42 ++++++-
 drivers/dma/dw-edma/dw-edma-core.h    |   1 +
 drivers/dma/dw-edma/dw-edma-pcie.c    | 222 +++++++++++++++++++++++++++++++---
 drivers/dma/dw-edma/dw-hdma-v0-core.c |  61 +++++++++-
 drivers/dma/dw-edma/dw-hdma-v0-regs.h |   1 +
 include/linux/dma/edma.h              |   1 +
 6 files changed, 302 insertions(+), 26 deletions(-)

-- 
1.8.3.1


