Return-Path: <dmaengine+bounces-7027-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 17692C18B9F
	for <lists+dmaengine@lfdr.de>; Wed, 29 Oct 2025 08:40:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0CBB1A21164
	for <lists+dmaengine@lfdr.de>; Wed, 29 Oct 2025 07:39:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA3C52F6198;
	Wed, 29 Oct 2025 07:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="L5OQj9tl"
X-Original-To: dmaengine@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012034.outbound.protection.outlook.com [52.101.43.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EBD8302761;
	Wed, 29 Oct 2025 07:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761723554; cv=fail; b=Zyekcl1i/U81lpxMLG7K5CIt9GQbaIlnhlIrnMwe+S75fNGLROtuscFQIo//oIiRcHiyvOK+k/wQaqZdmWYRFIX83V7fys3e18AIRvL66zOo2rCagQWieZcVxaNZFxxb9jOUE46DQ1qwlU2UO1VKlP9dVwsRjyJfr9Q9Pf93mR8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761723554; c=relaxed/simple;
	bh=FKNx8F8Gk/HYKfUaXoUd0tBQKChfoStQpfP+Oorni2A=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ffAnSno9oh2uiRF4SxD6yN1dvsm80EZhBMYi9C1K1+/D3yvgu0DfiJzaSJW418ueMD/x2MtSdr+mSF5/oT8B/FOClioW4rqdZkZ/vzjc/9MQpQQV6WOnNbhpSS5vu8Dpa8mV1foMy6EijpRjyKFPx+IkJVxR7HUr/wcLoFblO5Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=L5OQj9tl; arc=fail smtp.client-ip=52.101.43.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L6MYvLHqW3cmZDut+vxeZLz3SweiTEEJIYl0KyrGPiE2sYN4ptF1bthZLbX5y1H9gGSNQv+SrMSeVUYido7naNwaHvZdaXYLvTGksgwDxpF5NN78T/xpUZK2/l08b8A5I9fKHsuCTMzlDmpTYXs4X2wAqzIgjOhmk5ujJZcXil0ATmkM0/Jetb33RuBkyJSDfunVR4AmLGBnXxEFTYTkX/5YzNeHbmwybBKE0kSpYUPocEfy1r8K4zgFMmDuVmRebh/0Ud1oQXkwEicTqVHMpS49sKzjsWih63bsEtDR7vV4N1omMlnU3vnQr7JddNFG1B7IroznPqNiWpSCYQIPgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UjrIt1aS+TpVpHd1RtOccDThd+ZrRS3kLtPUaNZ5YMM=;
 b=yq+gXvxfW+fWQE2C76XIYUkRlMAlCV7kt+skfwrBaiU+RlLxyX7FoWhdvYsWHkzMqggXAIGEF0+Pv4U5QDuef/hWnMEf25YnClMXu6kp54C9qzllW0brJYv0y8UUwDivWadI33AWEZYOWpZlvwN/phptJiUeKbeWpHHJTC6+jj6n5r5u4XxnMFjvbq3RMTJ1GiQtlNz4JMXptC49MV4xm+MEiA1naybgmboVcWjNchB9ABtaMZDlwzyup0s1tWydrmWvzSBPjeL+ULCxZh5KNGpio/e6oC0qWnSinLGoix+g8ELRFIy4gxEZL7QIDj6pC9+q+JtJSqGzBa16GYEyzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UjrIt1aS+TpVpHd1RtOccDThd+ZrRS3kLtPUaNZ5YMM=;
 b=L5OQj9tl75F/nB7Le5o1IsDBOqDT7S1PaK77/UqLBIUF2nBoJdL2AserYxdO/QezRCeXof3bl8iQNStuuSm4mvUreivJB808lKI+6cig60sXr5dOIS9YElDm3MYdis1axae5AFsak0mbMnUzQy5WQBVDCRBmMAEMYgUGD7SYo08=
Received: from BY3PR04CA0008.namprd04.prod.outlook.com (2603:10b6:a03:217::13)
 by CY8PR12MB7340.namprd12.prod.outlook.com (2603:10b6:930:50::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Wed, 29 Oct
 2025 07:39:09 +0000
Received: from MWH0EPF000989EC.namprd02.prod.outlook.com
 (2603:10b6:a03:217:cafe::33) by BY3PR04CA0008.outlook.office365.com
 (2603:10b6:a03:217::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.12 via Frontend Transport; Wed,
 29 Oct 2025 07:39:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 MWH0EPF000989EC.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Wed, 29 Oct 2025 07:39:08 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 29 Oct
 2025 00:39:08 -0700
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 29 Oct
 2025 00:39:08 -0700
Received: from xhdapps-pcie2.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 29 Oct 2025 00:39:06 -0700
From: Devendra K Verma <devendra.verma@amd.com>
To: <bhelgaas@google.com>, <mani@kernel.org>, <vkoul@kernel.org>
CC: <dmaengine@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <michal.simek@amd.com>,
	<Devendra.Verma@amd.com>
Subject: [PATCH v6 0/2] Add AMD MDB Endpoint and non-LL mode Support
Date: Wed, 29 Oct 2025 13:09:03 +0530
Message-ID: <20251029073905.40409-1-devendra.verma@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EC:EE_|CY8PR12MB7340:EE_
X-MS-Office365-Filtering-Correlation-Id: aa0f1c0c-6235-433b-e399-08de16be3efe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+L22E/0L4Lht+o9LFpsBJYr/fIguToVkqMt9do67arhx6q/LAMudDLM5Zznl?=
 =?us-ascii?Q?IB9fbEnHq1MMplPg7aU5HiOEs8kOz4IuM+O9BRNW740I5ZFgqi/TOc/QeaXJ?=
 =?us-ascii?Q?qtEnRN+Cr9emWAIXh1jvaZwlMzTz34bcpcUgqQUv3ujRVyrdlFYJ4oEGzyEc?=
 =?us-ascii?Q?lTvdTS8JFSs9I4C8pbp3fS87mgT8beE7weThRjjg/kbZBRwMdxc/Zfg+T+Q7?=
 =?us-ascii?Q?VmWck6cQTU5lyBcmPlwzmRx0jcgVkUqMesWQ57FTGj0POQwQ4ljgrrU8+8sg?=
 =?us-ascii?Q?wgOE8zrM8P4lY5VqiRUxnzBbBc201Dq+Piam4nfeixtCkMqmFMGwURWU3RhI?=
 =?us-ascii?Q?uffL7i+I7Rrs5l4StMPU2lFjCGQsWv3ZG9cV9aKE4hMZNAWyxl0mnpLfZUNs?=
 =?us-ascii?Q?lZZzbJVZdwq/cZOO40cSWurlOilousBiORVfmNwtokewbDCZKGp8EE9yFRnp?=
 =?us-ascii?Q?IoteM3HKL3/htyZKHlpT1Xa+95IvNmItrEg3HbmITZvaK6c0k8jGuGplWHbv?=
 =?us-ascii?Q?Ca03QpceN1Q/dgX3J2lVIjyIk3T7/jR0MMeEEbkjieLsGias+tf2EcWuJyF4?=
 =?us-ascii?Q?FGT4DpAUkLfoloGcrrXS8NGTvw+lbW+26zYijvTQuwp9mBRqlgFX/K4H7vwD?=
 =?us-ascii?Q?t+BV7xXvaPntUIdfVfBsv7T1rpagnI0pcLD/qvxvNQivI9iOwBOJv1WQv73A?=
 =?us-ascii?Q?hklDwrwN2OfL3409kjvBFN7JN3Za9XOLIq8kzMCQMKLKeN7aAhG/d4R6U4Eg?=
 =?us-ascii?Q?kH0I/QL424ShgVYFZX8NX8cEWSo1aKRmH9Qoe5fCYyDpc9jH7pIFhcWsfmal?=
 =?us-ascii?Q?msNE/5nL1PiqTvBtAfTC9r5el9FTxULL8MLCeIdSOI0U0HgYgtFYalGd2Ju/?=
 =?us-ascii?Q?AHChIhH4phwmdQsmezpIyvMkZ1+3RfzckvF8S8S0vpDoH0QVK3T2pH1QHf1Y?=
 =?us-ascii?Q?k4lT0KsPJAJTzwWxnxjaO7uOCw5o9/lcNVQjWh2UNEX5YnoSwcPpvLRH/aV0?=
 =?us-ascii?Q?5rln+gYOgLnjysKFq6dCiFg8GSxeT7OXnHRAYoaznEyB22RV+6VOFpk/UYbe?=
 =?us-ascii?Q?bwXmoNUZc2gISdIh/8rR4UHQA9SvhhJWwOaIXWvbQdhPVgzKf1DSlHfUwic7?=
 =?us-ascii?Q?4SdgrzPnYvAR+hpVxH1QtGAddR+7Ar/Lcpqsgh0VGrUO8goR12kZwL0Vv4Oq?=
 =?us-ascii?Q?QVvcM+mODxPfQTZyn0gwUXMQmpCVZ+EtwufBHs/HC/MTGEPwz3bZ/I0qk3Lw?=
 =?us-ascii?Q?O5cGaefwcZhbMfsgv+5aGG+2+DNaVRPU5IgjH1zqN0UJlM4daYLSMKu5z8s+?=
 =?us-ascii?Q?Wp8BrPtzEiBw146fqE/O2MvRWIgEhQddgBZ/x/vKnzzoeP2AnYN2v++B4L3h?=
 =?us-ascii?Q?hL4U+dborCK9Zmr9cTCd3pP2p5eW1sH5GSA5/tiwob4skacT79PN3KX0TMEL?=
 =?us-ascii?Q?4BPdI1/NsL1GJP3Zo0mNtMzH8rFp9rnEI5A2JmM8BNbvhOZVJX2FcgTc+yZ0?=
 =?us-ascii?Q?RAqeHiI9itECd2wjcIKPCgkMHXgxSFd6w3rbwu7avdtcWKwU/VQ+vbCFjPYJ?=
 =?us-ascii?Q?u5wNqkE4POAoFuZ2ubo=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 07:39:08.8345
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aa0f1c0c-6235-433b-e399-08de16be3efe
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989EC.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7340

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


