Return-Path: <dmaengine+bounces-9501-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0KEJFnROumlUUAIAu9opvQ
	(envelope-from <dmaengine+bounces-9501-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 18 Mar 2026 08:04:20 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C3DD2B6AAD
	for <lists+dmaengine@lfdr.de>; Wed, 18 Mar 2026 08:04:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6E44E300B8C6
	for <lists+dmaengine@lfdr.de>; Wed, 18 Mar 2026 07:04:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8EA7368277;
	Wed, 18 Mar 2026 07:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="owpze5MY"
X-Original-To: dmaengine@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013060.outbound.protection.outlook.com [40.93.196.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C90B368973;
	Wed, 18 Mar 2026 07:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773817454; cv=fail; b=k+xI3W7HXZtWsT7qExSwagywoOFhg0QyU+ljtVaNqtj+nFWb9lCXgXW6fmdVCCwYyINujXZKMT46wRd6j0+2EydHX6FeARFP8PzYw+1igtr0aikw2K/N+TTO0KsXh5OZydLfSimaHrZBylNOLgffiZiJr9wPfvtUT+uy4pRV5nk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773817454; c=relaxed/simple;
	bh=uMtasryvDfNfQO0IGKexFjDF8cfY6fvEfE8YPJyRe5Y=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=avFl+ykMlDmGrzbsdQNrDAtwSK86Z/BzN42YnPAl0oiQLnMZvRD7U6XGSM5AfklN4+6LAnOMFMvepxzyfDLN1lUVtAG3ETgbHx/IIDYsd/tmFKQUXyrGUU3uLb/MysBmMNvBPaq9V5FoQQUu7eq+qQSPGkQtoY0bL2cMYGmv9w8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=owpze5MY; arc=fail smtp.client-ip=40.93.196.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H+h1Bk1enziOiSm82aAU2KN5RB5wak3RMHx4x6A6trgFZCp9dW4rAeF+7g73V4THMBdh1kdtgV4xXsG8nObHjE9WRafYavKLj4CKRWHrtwgt5aFTvTffK/6qr7qoQ7Hcwwe8ng4tqjmuCTQm8JFPrmKufSJZB8DZ8cyTMFSMB2jTwwgK/q5lOL04tG46iiPXX8M5HOxgLWO16m3mdpZ2RAo6QHI9ppzxGgtrlj7AwMp0aRUzouWGn6MJf9874JVotDo4ylE3QOgFuGDLIhmycp3SrggPmJPGCs14AdN2XyuYMeMZcjiK1ceI/nbTMaFl3OwTB08qX3y2xjrnvXpoEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uxm+6v21f4Q7PFuBggeOK8bzvgIdQNXjSC39un7PC0c=;
 b=JeStEUnXsgL4PBL3GsC01nQorW9EieShghFTsFc/bxpqGc1jD7inDwSplU264YXRMOgK2g7IzlkLMGSnxDqYFfUAPWYZ2G8zgZ5b5SmXtfI9M2iwackDp/1LMVbe5L72xvjg4H99lUJZwQLxn5aUXvXHzymsZ5RY1gRdvwuMNn3uT+iP61x1fOiuzzLelwqCuD5o6VqvEwt0xAcTb7LmFEl0HsDlha4X8lfItsIh4/fFCpjwQMn2eSbjqqrCvHTKtTk8zqbSI3BRXFlwnakeTrGW7bLtqnT3UwlRgI5M4uh1qXNHq05Azp0cdSNTNj+HRQUkUzSfw8njwS4D15m0zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uxm+6v21f4Q7PFuBggeOK8bzvgIdQNXjSC39un7PC0c=;
 b=owpze5MYqS8W5kNVk7MGCVimVngPsthUiq/1mGWfpVsLV9YnNg7czgNfugj2O9/vUAg18q5P1cH6QWe4MLVeWmpsdrfmqPrzFAHfncvzbSu9EeYkrE3pDv5W0Bfj1aCm5Q8oLl8XmLEKERH6nPnAjIQw6NkNBdGKOMe/gmhh3AU=
Received: from SJ0PR03CA0181.namprd03.prod.outlook.com (2603:10b6:a03:2ef::6)
 by BL3PR12MB6475.namprd12.prod.outlook.com (2603:10b6:208:3bb::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.16; Wed, 18 Mar
 2026 07:04:07 +0000
Received: from SJ1PEPF000026C4.namprd04.prod.outlook.com
 (2603:10b6:a03:2ef:cafe::ca) by SJ0PR03CA0181.outlook.office365.com
 (2603:10b6:a03:2ef::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.25 via Frontend Transport; Wed,
 18 Mar 2026 07:03:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF000026C4.mail.protection.outlook.com (10.167.244.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Wed, 18 Mar 2026 07:04:07 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 18 Mar
 2026 02:04:06 -0500
Received: from xhddevverma40x.xilinx.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17
 via Frontend Transport; Wed, 18 Mar 2026 02:04:04 -0500
From: Devendra K Verma <devendra.verma@amd.com>
To: <bhelgaas@google.com>, <mani@kernel.org>, <vkoul@kernel.org>
CC: <dmaengine@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <michal.simek@amd.com>,
	<Devendra.Verma@amd.com>
Subject: [PATCH v15 0/2] Add AMD MDB Endpoint and non-LL mode Support
Date: Wed, 18 Mar 2026 12:34:01 +0530
Message-ID: <20260318070403.1634706-1-devendra.verma@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C4:EE_|BL3PR12MB6475:EE_
X-MS-Office365-Filtering-Correlation-Id: 29901fcd-46da-43ae-7672-08de84bc8c30
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700016|82310400026|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	MX6RTdE5BQsiwhdr5Edq4p37/h7fxcgOzuYa6LYcBZJ5CmvByzcd0E6MsRwg5aE1jGnHMDkINHKKncpG/dQp0wVIynFb2TWzpe1ukE9EX4Jo5xF4ZPH4ISM2IADEeVb/dTx3BqFjAjWxocmf3ze/6CA7aDbntP1SaT9DWZ96WWwSDBLSFsalYbzIo7GhMmrSQwsrOdmvxAJnTn6d1gX2ecmENrd4/NZfLTalvlIf2QzJUeW6sbSobS/ROfq6UwM6srJX7qPMf5GiJ9txoSQkSapim8LVL+u6KiGbdfCcU2P9oTm0rTMXSTjAv6O4VKS3PWUipl6BR5DXQ+AWyyNNWyuY56VIhJfII83n5eb3EV35P3jybwIfZOSno2RrDqiDLjahhkYutQlfVoh2tMErnVkBjNdRYHHdz4sXdl2HchSBjmn0dPuXjVba+yJK7FJvJPIQ4bKNB97VoWVw9kDbYtueNr/vW6nGL5w7vhhsB7V2JZrYV1sxtYU59QIJ6HDaeXI+PUKATx7XVdBTz8F82QWB1kHuKrJz+3MWvbuPImNGjAXfDRDXxLkt50zAU+psglkjl3PiI99i6TAyOXMBij/nVNXXF98VyycN1ARvu/hFF8oIWx8Ly+giF7vFkNOhd8G8wCDNQRRwLWBPl0b9UYsBPWs/WmbGH4br28moVWuPOoC4cNSY23goRf6d0Y8i5ILkWhLCBIAgEl0DdY4JuNQRiJTnihxuwR8+UQGydYfAbclpYncd7W9T1TOtl52CPQPEdG9ZjQ3wuQsMwJrQAg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700016)(82310400026)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	LiWpBIyQBfcY+SU+Tv3lDbMBIJBU4cvFXMWF8MoxFBvjTcQhYe5TVdrSX72HNLazT66Uzqpxw/IEAKo1IO7aH6UYpbJVIDicYL/0IKl1y+c6CDqAtMfdgkzlXhR2I13MNLTus9hWlGj+qdaRpCBhseUgzga634pTyu6njr+3t2OfO2qMl8fyihrnsdWw1zmE2u9pFYad3Qjcpi97urO7YvbOG/RDT/lb8642lHMlnqbzEcpOvZkwpGQOoolJ+wY5uk8Y1+vFytPxPzvnzOAKOCdqAiZzEB2+qI3r7WrP61CyAAye786nNTFXu4Z7ORmWEVP0EACBIRU/R6XxPNOmmoIdFBywTOo0LmcYMP5F/YmaJFHHeN+xlV0l+FcFUDOSIW3KRw6fJZctFCaobs6MkhTDnQyCbBGo/BCT3akF+QFVK3D9k2taD0pTidvrP3GP
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 07:04:07.2819
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 29901fcd-46da-43ae-7672-08de84bc8c30
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000026C4.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6475
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
	TAGGED_FROM(0.00)[bounces-9501-lists,dmaengine=lfdr.de];
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
X-Rspamd-Queue-Id: 5C3DD2B6AAD
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


base-commit: a989fde763f4f24209e4702f50a45be572340e68
-- 
2.43.0


