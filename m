Return-Path: <dmaengine+bounces-9383-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OAhLHyFQsWlCtAIAu9opvQ
	(envelope-from <dmaengine+bounces-9383-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 11 Mar 2026 12:21:05 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CD50262D8E
	for <lists+dmaengine@lfdr.de>; Wed, 11 Mar 2026 12:21:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 297FD30378A2
	for <lists+dmaengine@lfdr.de>; Wed, 11 Mar 2026 11:18:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BA8D3DA7F5;
	Wed, 11 Mar 2026 11:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="NcjGn0jA"
X-Original-To: dmaengine@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013033.outbound.protection.outlook.com [40.93.196.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9423D3DB642;
	Wed, 11 Mar 2026 11:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773227923; cv=fail; b=mPke9x0RgL7rgJ6dQFCTNRHEQRiCV3sKotfw616JfcWCfTx2g7MSuEqURpVB2c3pzmQj9gEDW8WU+fyrC2fRcc/TLaQ2laXDSUOfRnUB1rcpJvVQ3w1xvZajL/3gUSpzjTN963NARVFVpnPWGt2lQdd5/Y6tbCnomhaxlhOD8fc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773227923; c=relaxed/simple;
	bh=p0mh9CB04fj+4tjBHUBD1rB2VZZPmO5feyHvE/3+nyg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=myU4RqQUOshux6P2LPD2KYtU9jYYJzj0vpb92tjVFixOzN8xmkuSDp0Nihg7AO+OW9LEtfF9Uw8qPg8rLXzMNycjrNb0j9FrsUNV/211DVvjfKh9jjo1vn5jSSRZj8rn2BqmCXtTKu/Y9dk4GWSI+FN0Xz5fCYQXAkqVNqEJZDI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=NcjGn0jA; arc=fail smtp.client-ip=40.93.196.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uv86Q6tKokj8+0nh0kUDyvFwpbbw+FcK2WB9eG2OG8PCxvKVClFyqvN9PXbtfVTSDPRzLvfjBCvKhnR8y4NSktAhMzNVJ6VBT1bqxz/VQJ73iT1Js/H1j3g5I37V7KNNji6tzzrrD13pikPkK2jlQdVaSk2UOPJL3CU8c4NjA++a8oC8sj3pu2Us5v8rwTZ6ijrL0Z4ZKh4FQdrPt5XCdYlg4kTbAgLGO1I3MYVHLJoSXs5tIL9QpUXuLQEGbgDNIg+1hsoJr8ZwCjk3RvELnH/HWOAOvLcRpepYLZENkPfDf8oNIW1jZ3BCvPzdzcv2WqDyJoXUEHv1btClOtbXZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tZfWF5cE6EoAP1T7y3n2sl68rWaebUdAFdH7ben1/OY=;
 b=LEECNN84FhDkNhgqsDb3bu8dgw1NcNAMgQSytSyfry8ahYfUXxmbvxLOfw5p4mjGSJS1MwkVGizSmAAzVkZEo+p8Mr1KWmy7TlN8NehoRpNwMm/5z8tQhuN7VXaGtBlig5+XKEqRVc9RBZoTW+oDQuVumM156DTiYkrRFvcYBQsdCdrYyCqy/4NQLChaJ44eC4gchIiGA+leqtfaanZhUp2M+aYB59Av9uX1xGqtFzHsr9JtdNlTdh3WgnjaTbyg8QovHUPRoW8lRXSKXU1Agkh1kxdeDq8xT2WQkQAP+tKJISuFCxfD++lIiCbdWQE0oEHztq/rWarcSzL2pefw4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tZfWF5cE6EoAP1T7y3n2sl68rWaebUdAFdH7ben1/OY=;
 b=NcjGn0jAH9YL49KavDIU8eT1KQtKrthcqFr5/PeXRxV3v1dp8QPDzYIYP9k+dWkNmmltNJd9Ra4Sw7sfqxRqMUtcOqxjN1a2teXj/geeVN9nwz6sJX1mHs2kkY7QKtLQaaVJDz2JGdj+A8XIHXLdOikv7T44xE5Njyr4qz14sy0=
Received: from CH0PR03CA0343.namprd03.prod.outlook.com (2603:10b6:610:11a::14)
 by DS0PR12MB8526.namprd12.prod.outlook.com (2603:10b6:8:163::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Wed, 11 Mar
 2026 11:18:38 +0000
Received: from CH2PEPF0000013E.namprd02.prod.outlook.com
 (2603:10b6:610:11a:cafe::21) by CH0PR03CA0343.outlook.office365.com
 (2603:10b6:610:11a::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.26 via Frontend Transport; Wed,
 11 Mar 2026 11:18:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF0000013E.mail.protection.outlook.com (10.167.244.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Wed, 11 Mar 2026 11:18:38 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 11 Mar
 2026 06:18:37 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 11 Mar
 2026 06:18:37 -0500
Received: from xhddevverma40x.xilinx.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17
 via Frontend Transport; Wed, 11 Mar 2026 06:18:35 -0500
From: Devendra K Verma <devendra.verma@amd.com>
To: <bhelgaas@google.com>, <mani@kernel.org>, <vkoul@kernel.org>
CC: <dmaengine@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <michal.simek@amd.com>,
	<Devendra.Verma@amd.com>
Subject: [PATCH v13 0/2] Add AMD MDB Endpoint and non-LL mode Support
Date: Wed, 11 Mar 2026 16:48:32 +0530
Message-ID: <20260311111834.3750297-1-devendra.verma@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013E:EE_|DS0PR12MB8526:EE_
X-MS-Office365-Filtering-Correlation-Id: 31220e98-a7ee-46d9-eef0-08de7f5ff154
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700016|376014|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	pFXhfFV21EJKn1I63GE9ezt1GQh5LKtQHROQXg4pYLnP0V4+V2WyqCoeegN6LYUVbuDtFs64ukY1uJGDT7qNxNbX3FP44XEkUpzfU34PWr3vJDriQx67ZVxkEcraszoQXNkyi8kyWSYZe9C+wbtBMWIXo2T/JeAf/CDUg48tKJ9t30tAN7N4gy7+88Syx2dCKb22NS3+Fb8Rr6J+BDv4Tp6Up7Gc6aBnc5eUlkQbn1XzD5rXcO2WldkXzu5wetqrI+PxuVTDdMXXAFih43i9AYKgENbI9RuadPZ91+wqw4IYe2j5n2DwdaOUeuKthmxKT8SmDTQK6j4Osk3IY8Gwthm8IFrNmubMLPloOdGA3HSY8DTSBQlU6xMwdwHKVICdQ+FlKODg74m5i34ajBFrG3h7LY2mfdt7rIG5+5VJWPP+XXmdzGzowFgVrEmmnKhJqza0ZcuWp7Bn67NIs/HWPw28f58e0VkzzXSjJcv8QkBEZonIViS163mW+PzUjxL0ngJEhKJTp6rf9Qp3XrfRo0elCOY7YhQpQtdr5+F8Rbxzk3lByv6xMQearOebvKREnSo4I0G/x4qkZ0FT2ZJWmVuBZmEIid7tQ00sg/D55btKITrYA04gHF4tF+oakLyYdu27DOM6cnPmZxlzoQzf/tqOzQJuOCfBs7URnizCl8YK9hdm4PWOSjs/NKk4FNvWCqa/eQU9r5nTUhjdXNfuKA8CxCAzoFQcpDSMiidojo2XJhKykMlggcTOBIOK5ZBa+dCvV0x9/nOflzaw6QrtTw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	4DD6P4G+2BegtYHMLFXyQS96rZgmBknUdvDgla4yBk9apC/cNyPEVFbGFhhFYS26+mxBbqYEesu/Rm2RVEisNMUjtGPZoTwYcyqpVwGpUeWqocshVKXIKyaDGs4nO4ecYlJdj6IHpVgGxNw2qkdERdfLHsaSLykJBw24am8W1YDxF6wSI/tZ0e9ASn4LueXdaFsrzp1+R6c0SymgKH1BIblLAENG9LqKfOzyeiQ5VvuMzwYx5xA6+6Gw7Z8A5BqECLLyBbufGHUrpvYpQEhmVgBkPs250av0AAyYAbdH8U9myMXDmSNV7PbAEFN+JKwkt+ip8/E3+aKNE99mFeePxasB62OR9W9CQ7eYebfhEGnAD3tFmtsEkf8B5y7amiUkG6tMGSDcvMWcTeDytufqhqx84VDDgyjIsc0rzGxXl4BE2KZKyCNhMO9f+/SKXuJD
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2026 11:18:38.0140
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 31220e98-a7ee-46d9-eef0-08de7f5ff154
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000013E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8526
X-Rspamd-Queue-Id: 1CD50262D8E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	TAGGED_FROM(0.00)[bounces-9383-lists,dmaengine=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:dkim,amd.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devendra.verma@amd.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine];
	RCVD_COUNT_SEVEN(0.00)[9]
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


