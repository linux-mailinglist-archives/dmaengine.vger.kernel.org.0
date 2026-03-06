Return-Path: <dmaengine+bounces-9293-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YL1FFVnAqmlXWQEAu9opvQ
	(envelope-from <dmaengine+bounces-9293-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 06 Mar 2026 12:54:01 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B089B21FEAC
	for <lists+dmaengine@lfdr.de>; Fri, 06 Mar 2026 12:54:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7CA923016C97
	for <lists+dmaengine@lfdr.de>; Fri,  6 Mar 2026 11:52:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14144364EB7;
	Fri,  6 Mar 2026 11:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ckXipiSk"
X-Original-To: dmaengine@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010045.outbound.protection.outlook.com [52.101.201.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCAE2334C08;
	Fri,  6 Mar 2026 11:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772797958; cv=fail; b=GDKg15F6/LeQiLViV7Qy7lUszeZW9Tva6JbFXXgpzBjXVLngCqplffKqQRlAG+q71Ij+9Mswqeg1nySeNYifQ3tsm+akrAR42W1ayyewXCSPk4Z+QlFPrUI5ZG48GAkAuiVwfX9NFFUmtObdXnDW3Yy9xzN/WPbCyCWxwi/3UMw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772797958; c=relaxed/simple;
	bh=p0mh9CB04fj+4tjBHUBD1rB2VZZPmO5feyHvE/3+nyg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TKH27zcaH1RJDEP+ME1MCIAVIJoEuPxl3FbvMqThlCwmG7cnBPiT35UgHl963rH4jW1wKukUtXaKnZ5b1QGIn56c+B37186dKpSkkhRqnIqyC7kHJtGH/WgqbKlmWaKvohwqOSlZBxSb56DFydP4HTSJwE7E01xpQoQPFxitEr4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ckXipiSk; arc=fail smtp.client-ip=52.101.201.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mgt7ju4m1nYaTLot9o+8KwZtIC8hz+noni9yZFh0X5hEMH1T0xgVW0NaS1LlbIf2QRipq/pRDESdrDmrx4yt3jnblp2q4KnrDW74pxfpFaC6p/c12nQSgZuSSZYxOiFm92/eBYWZOfEhTXhNoxavZ/gc9C+GISOAWi46EMIrJO0wb+FzFgzwolfitjwliS6ZSkD3Yz+JW8+CUGf8Qkvg+vR00e/PMGgpYP5cuVm6Ayg0+hHp8dYhpSy+NVfbUERIap0wP1AeH6S2kFFfBW9Tj8L/9PqcatZHxnqzuo+v3nGw2YKOIIlEqK14cOugTWwky7PgOBMB3twdt7NDGungyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tZfWF5cE6EoAP1T7y3n2sl68rWaebUdAFdH7ben1/OY=;
 b=r9Usut9OtbQqWHtY9t0FbFBYTU8D9jIInlZ97/kVGYxsdO67kKQc5WpIPX/VAuP5WQHOr7RwUq2I3ypZSxxL/kPqRF4fIQ/i+EG4IQo/sTyWU6H0aVjXvGHmpzg1qfCRNOwqyNGaIllD4jC7ooaAFkwsy9Q9a7rSsuxEzgDrRkIMA1GG0Vohw21SxikP8sx0k+O5ZJbxfzdBINbZb+QBfy8ngS2om86sFFS5Ychi53pfOFWXa64bvsEt8u0LOIO8IorhB2qQdAQtqXcSjo5cE//c0ayAS/MQBN48wq8dgBozRz2fZFW1sQk1qhozKLkeNsp8ngSd+9zM7iNIFVW93w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tZfWF5cE6EoAP1T7y3n2sl68rWaebUdAFdH7ben1/OY=;
 b=ckXipiSk6sqoQjdqa9DiA7SevjegRWfy2x87pkakUEj4BnIruV6+k5J3Gf/f3ABmwq3HdKIM3etp3N9y6c0LAQrD2I+DKfQrgmoaPEl4fKjTrrFkBf9cmOy5/U4gpPnc6BF51ROYaDRQbqG52Z3Jap8bh+V1cjOsb/adUIANriY=
Received: from BYAPR08CA0051.namprd08.prod.outlook.com (2603:10b6:a03:117::28)
 by PH8PR12MB7136.namprd12.prod.outlook.com (2603:10b6:510:22b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Fri, 6 Mar
 2026 11:52:32 +0000
Received: from SJ1PEPF000023CB.namprd02.prod.outlook.com
 (2603:10b6:a03:117:cafe::c5) by BYAPR08CA0051.outlook.office365.com
 (2603:10b6:a03:117::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9654.20 via Frontend Transport; Fri,
 6 Mar 2026 11:52:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF000023CB.mail.protection.outlook.com (10.167.244.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Fri, 6 Mar 2026 11:52:31 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 6 Mar
 2026 05:52:31 -0600
Received: from xhddevverma40x.xilinx.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17
 via Frontend Transport; Fri, 6 Mar 2026 05:52:29 -0600
From: Devendra K Verma <devendra.verma@amd.com>
To: <bhelgaas@google.com>, <mani@kernel.org>, <vkoul@kernel.org>
CC: <dmaengine@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <michal.simek@amd.com>,
	<Devendra.Verma@amd.com>
Subject: [PATCH v11 0/2] Add AMD MDB Endpoint and non-LL mode Support
Date: Fri, 6 Mar 2026 17:22:26 +0530
Message-ID: <20260306115228.3446528-1-devendra.verma@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023CB:EE_|PH8PR12MB7136:EE_
X-MS-Office365-Filtering-Correlation-Id: 081ab6c7-a03e-4ff8-f427-08de7b76d99b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	CebuxvEbhB/JObg36IejrVUYXnoFPF84TtazHKqa629KyRcjgH+PNULR1wOuVILwfE6WBhnM7gVNjK3vQgafL+i0C17qfQtPVW4b9V7Ke/pRgbP7CH1i+vy1xquPMsl8S2y9Kpa2L3YulcesyMsfKCppmh6gD1V49IDWqFVs7XZajZ/QgSYqfxGOjpERAQV0TbsKK37pcra0O8yiTD/WHOxRLb+mM+qZPuftBXLWVgg14+ypsXaNLKLcnQuFQPa9IdjWUXjJftjGrhMJJWx4SoL/59sxtArlogKf5vqJohoojGqfcG5OVq+0W4wGjECbammbTP4RKTYai/L5z0FuG/T7Qjxkk5WGRtPzm8+mxAP2fqlbaX7WDYUsIsQqmy7df+wp5fQ9O4HJL6bL3rdkQNF/Jic1O+Nw57amD7vzdsJv3x/8OH2DZDJH1Lfz/EdzZmqPi7JaQhM6mkVLHcnfkveUepjZ3RS4rYsFE8LCHxZps+F468eE+kyAzDVhbiGkHMoADyp65ZI7CbmUCw5wvrBOF/a5O2gb5GEQ1b2xFKCxbqg0n5Ua6Ty/Me2vsENBwLdCF5Aac2EAtAy2di+wdG1dHAubJYcohAf0b0Bnkrg8RdP2YgB4tBRAhXKtEYdnGNm8TmNN1hLexjIsaFZd2mBsUhJAZYUbYXYP8ihm6CEfK3bOhoqDMnTK1vEqQ+KcJw6xwMEUs+VhMEE4lWbiG5AckKatAMq3ucjX/P2RxWqSrE7F+KCVO7vAVHtJyXRvBTBPFEo3r9gsc7xSXvy+aw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	6wYlS+h6BvrjYz5diGKnFGzEoSo+ySY/Jubf97jbM5Hcjqd3yzdovAy74iPbqmKhGQqYhS0WxI9HdiA3j6pfQM3mJ/P3xfd3kJ2CgbajEnYVGsXiV7ske5gVvjFhHlyGP+TVMC06CYGc0gpJumzdCFSmx6HQ4Pw6GIpquMtD3nnh8COv1X0ER1w1jNqq6bz3Gy0uhlG3PUlEyeU7gwa32bALPoq2Um1QuSDwHUlM12x1frd1GBZ+cXJulTdE9ZA/QDFACeqlk8nSLbk3K8ksn64xJdEKTNfgjPDC3bEZUds6zGwUo2gbh37zJdDa0vr0pNwkO3rBpEDkxxI9tTofPkiDA/zeh2FWEfs9iav252jik3Z7c3XJIi0XXyDP7/CX6UID1aNoWNwLIOUuAenVk3heuFKpeubx6FyljlxqUiP/m+BeIdWQHXTTYDO2Ngem
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2026 11:52:31.9085
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 081ab6c7-a03e-4ff8-f427-08de7b76d99b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023CB.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7136
X-Rspamd-Queue-Id: B089B21FEAC
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[devendra.verma@amd.com,dmaengine@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-9293-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[dmaengine];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Action: no action

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
 drivers/dma/dw-edma/dw-hdma-v0-core.c |  65 +++++++-
 drivers/dma/dw-edma/dw-hdma-v0-regs.h |   1 +
 include/linux/dma/edma.h              |   1 +
 6 files changed, 313 insertions(+), 22 deletions(-)

-- 
2.43.0


