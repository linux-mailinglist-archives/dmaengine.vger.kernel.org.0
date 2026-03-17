Return-Path: <dmaengine+bounces-9477-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eJM0Cz1IuWmK+QEAu9opvQ
	(envelope-from <dmaengine+bounces-9477-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 17 Mar 2026 13:25:33 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 52A022A9CE5
	for <lists+dmaengine@lfdr.de>; Tue, 17 Mar 2026 13:25:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 245AF3009811
	for <lists+dmaengine@lfdr.de>; Tue, 17 Mar 2026 12:21:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C32C83C140C;
	Tue, 17 Mar 2026 12:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="26tTFzcf"
X-Original-To: dmaengine@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012061.outbound.protection.outlook.com [52.101.48.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E4683AE1A0;
	Tue, 17 Mar 2026 12:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773750103; cv=fail; b=oW6xxNAc7Wb8hRVjwO7j/6jTN3db1GrE2ULmu9InTkAWX7h9z7FCXINabxHrKDJlKSVSEgXJ97jHoeEthLCCHQrCJRSwPW9bXWQ0mPnQjdJCQhzn9Tak/bzM4oPlr+FX/S2N6YipI96jitrvE70ZY+H79XFc7+NjllpFp6U2qTQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773750103; c=relaxed/simple;
	bh=AuCUE/15uADoSCaJGN/wU3X7Hk9wMJtRjHRJQMgZFbA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hBIh36XVEXyksaQxlxBUO9Q75b1HNr7vouDzxh1w4UKUaftRTlL3x2A6VyVQnMX5084DvrqmLbKqySBY/kfIzr8apjW+01BwhPgJnoT1bP731r0oAq1JMRzl7o+pbhuu3d5A1IQHBKJf5hjDq7b5M8pV5pRYE6l+VU23jUJK54c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=26tTFzcf; arc=fail smtp.client-ip=52.101.48.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kbRr3Gvr01QrQuRZCL9x7JXYhFL7Bbfn2GMEtjS8RjOffnoQRvhlDb54utdUDRJSO/AbCUvGkd6PQY/MkiXbsNmXZ1wQUsMjTx0UTEPbCNZ+CTnSZf6g7psrKcGj38F5HbSkyefOqxg07yYWUsMwu7hSiTP3JiZLd26KLoFmEcAxOnoL5Le2OzqcEFi8Cek5L/jqLoxpIJ903nOQ7/npvu3s29XJCaVKDIXdXFv2iO82SXzo4hKUL3t6JL3huYjurcJNDR8RmwMs+cyas91v8iuKNyWZeOthOkg0GgBxJldsvWFBqL0bb8mpUbdEBhidAd6RUGcPFaB3ws+KVK2ifQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DlTazOwjVb+ojB+pLrAYtyPxcvaEgPH+S/kJyPYKgkA=;
 b=xjtd/sQNgURNdTlpG2Ow5Fztx78Ypc/DPX5cTFQxoc+1uOKHXN1QGoeKqUu7q+o/AO2UClskp4SGhiNusKJ8VWKM4AmI9L+x0oYFLSgEFbidUz3YxbovedG0SiOUhpJF/SxQKh95Yo7LElFsdRBZ8iSNIWVhh0zaaDpX7E/Y7iBA83bE71CMlFhN210QILoCMnWEVBHO10AFF867jc3TzJq40f98gquT+uy1xlelpsRcsjOlluYLS/dzhQezBHKSmXE4o+JX/a9mZBOXnPU7Zdp6H71HhPfwicC6cEo/JI140tJeZlSn7KqWvcpW9/yP1ErxD1ZIBzsMjP3cylQbPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DlTazOwjVb+ojB+pLrAYtyPxcvaEgPH+S/kJyPYKgkA=;
 b=26tTFzcf6dlkKEcVrgZcnP7pXLi4Ud9/KYcUS44BOHTMctwuT9u92vbbTpyn5BgMPwCIgQFaaMbhzmH5vKcOrdVV9UW1WTYW9gL9psLU7MxwPwyT9VDiHRgV5QaWqIBheXjnOy7QdnzaIU13euyAaEvrGN7+E25/nWJn3q+VhNs=
Received: from BL1PR13CA0115.namprd13.prod.outlook.com (2603:10b6:208:2b9::30)
 by SA0PR12MB4416.namprd12.prod.outlook.com (2603:10b6:806:99::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Tue, 17 Mar
 2026 12:21:39 +0000
Received: from MN1PEPF0000F0E0.namprd04.prod.outlook.com
 (2603:10b6:208:2b9:cafe::86) by BL1PR13CA0115.outlook.office365.com
 (2603:10b6:208:2b9::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.19 via Frontend Transport; Tue,
 17 Mar 2026 12:21:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000F0E0.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Tue, 17 Mar 2026 12:21:39 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 17 Mar
 2026 07:21:38 -0500
Received: from xhdapps-pcie2.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 17 Mar 2026 07:21:36 -0500
From: Devendra K Verma <devendra.verma@amd.com>
To: <bhelgaas@google.com>, <mani@kernel.org>, <vkoul@kernel.org>
CC: <dmaengine@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <michal.simek@amd.com>,
	<Devendra.Verma@amd.com>
Subject: [PATCH v14 0/2]  Add AMD MDB Endpoint and non-LL mode Support
Date: Tue, 17 Mar 2026 17:51:33 +0530
Message-ID: <20260317122135.130474-1-devendra.verma@amd.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E0:EE_|SA0PR12MB4416:EE_
X-MS-Office365-Filtering-Correlation-Id: 46eb66aa-86a5-412a-a962-08de841fbd9b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700016|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	B82n0SYDaSlmxVQiwK4gPAhOfTHC7mId+ydu5KfI4t0ZsqO37JgwWh+nyvMmv1PksJDhMmb7WQXiDBdEBZM6Z24We5qLZUxw3n40a75TmgmRH7xpBsJAoQKUQKMjsq2GTAT1HQT9NdVyqKOnEShG4A479r1VrOnLoBHu2xl/lyFpXUjx0+w9jPhAO8ZYKggj4dmO/hadZz7SJ+aheizUcArUwI2AQNPwxsqDRZUxOOS+E0CDHNMoqV1scTLzZgnS8isugtFJTkZoc7nQMD41+SrvzZEhRbcSqRPUl0h9ghwj4O8fdvEIoriK0LreDURbQo+cjTdg5fuxZ97VJLfhLnnmhsLJ1dPU0xStlPTN+m8D+vHJhy7OcLQ7edSAuXuDxEYxU5YLYKaD4l/FHIw+t6Yy6FEHCaRqDwdRIYULcUmzYBSmZgF9CyW5iEi5AEHdIUASeVxPXGi4K2I5UCqK/HWvmpjWQAOPcDQBRnItiwEeyv8bHr/2Nn1xCtjJM1kW8SJ7xmdZ2OwtkHFSM4egVadwBe2Js3YnNnOQvJKZHMBF0RCF4xvEyvZvW/JB4mesOSwY1KcKIDpiBLg2nrsY/mlvxtGgD0FrirZ3VlfleJDlPzp1hXO5nw39Wz/Bqu6GZLhc/lcJkeJjT5yNR0E2YTnzBZoYrRj+uD2mAeyjDzRWHVEuYovhem2C7b2rRPilYpIsfuoYUc4ClmS7FmmvmSGqtDw2Ens0sbB0CyLP/5TD8imObvry9CqLMLo1JlDPnTasKCy2C47/HtwUwhhExQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700016)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	/8TynYKyG09uUcD6WgynYH4FNkGWG4QNzsmFsaq63FYA6lz+okvxa7rWUc97jZg7pkp3fCXseXwncIfXC9rkzuibRjqpuQcQiw1azdCl5ZZwa2YgiapWxlMJbazAzSM/sKSG9eX+PQTEC0z+j1+weYTIKso6TKeV8sWPBJ19MRjtBPFXkS5w0gTnxZY88rxNUEVozvQbBz9OSnnnNvY2RJXZZJGoe+kgcvtiAfrm9rHNF2BGnWGCdyCopFwqN41rJ7GP+YJFrZmldwWTIy61FExBFmipp5C/UVBIZQ51LBdimoXygR3SDhP3Vay3BmYmoW6B94y7rZOvH0SxPaLWfd3WUIovcUwVdLMs8R5Rm8+m+tFxVn/y8Jzv+qRKYgdYIg36hKH0TKc6wzkmjLgjObsRn8YBra5/ISwRiQCMQBLmIEKFY/dincq/DYYwTkAO
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 12:21:39.2707
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 46eb66aa-86a5-412a-a962-08de841fbd9b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0E0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4416
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	TAGGED_FROM(0.00)[bounces-9477-lists,dmaengine=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:dkim,amd.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devendra.verma@amd.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 52A022A9CE5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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

 drivers/dma/dw-edma/dw-edma-core.c    |  47 +++++-
 drivers/dma/dw-edma/dw-edma-core.h    |   1 +
 drivers/dma/dw-edma/dw-edma-pcie.c    | 220 +++++++++++++++++++++++---
 drivers/dma/dw-edma/dw-hdma-v0-core.c |  64 +++++++-
 drivers/dma/dw-edma/dw-hdma-v0-regs.h |   1 +
 include/linux/dma/edma.h              |   1 +
 6 files changed, 312 insertions(+), 22 deletions(-)

-- 
2.43.0


