Return-Path: <dmaengine+bounces-9359-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AI2LGfofsGmCgAIAu9opvQ
	(envelope-from <dmaengine+bounces-9359-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 10 Mar 2026 14:43:22 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ACA6D250A89
	for <lists+dmaengine@lfdr.de>; Tue, 10 Mar 2026 14:43:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F36B633F7F7D
	for <lists+dmaengine@lfdr.de>; Tue, 10 Mar 2026 13:04:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEC7F3CFF4C;
	Tue, 10 Mar 2026 12:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="vidJZk1Y"
X-Original-To: dmaengine@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010050.outbound.protection.outlook.com [52.101.56.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 646563CFF40;
	Tue, 10 Mar 2026 12:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773145865; cv=fail; b=Yg9/cxVgJZiuQw8HCcnTP9PP4JIUUxUuEdRtut4gDJm1R1ihAj1NBLCEf0JYS0S6AIGtje4+1hqySKKCtJogBjwL2EyhAu8Cab+gOAx3zdKachbP6NQKtuurCOQd2ZkojHZ3Q0rgcBdAcaDix9EjusSGgJ6/EFENPs4PcbfajNg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773145865; c=relaxed/simple;
	bh=p0mh9CB04fj+4tjBHUBD1rB2VZZPmO5feyHvE/3+nyg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bTIolFarFqBS+N7oTNl5b1cvg/kHybYcG2KMktyjBtf04o8P1z3rFuoEOviLuOZ/s9PCefRMC+JY+uPnJSS1KFyhGN6ZQofoYIufrHAdts4iE3wNS3s3/YAwKtlqDhYjrQ+Dc+kFP0oDcXewFGeU5gfGmD/PKenk3SHiQDYpwLw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=vidJZk1Y; arc=fail smtp.client-ip=52.101.56.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SciwbWJs3xSylGa33h/JuAnGrOKgM1I32QiijvJrh/MjaZBDqUb8x3uBENzJWGo21ROmT9vUzMnpvDwnIG7vP1ekE/f6xo9OE8Lb7GRUsF9/NQnM0p6BsfwFHUJ1etfiNBycDgvu07QzbWKOPoXTfEkl18oQklkBLM/RYIVbnrwMyft8j/CjGzoXhXMGdpXtR6iGKzjKV5VqbF6rcV26yWtKov4N0cbZ8aHRYgbYiMWYQwJlNLg7dom7sl7rzwUbLixYriUsoNhJCqu7MO0EJa3zPGzZODyfNR9xarjWFOrGvILDZ/gDjPdHYmojnehTI4soURq0V7S8D5yBarIoAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tZfWF5cE6EoAP1T7y3n2sl68rWaebUdAFdH7ben1/OY=;
 b=aLpaeWYfqTP3BEBx3oBxSfeO+6iCLRv27uhBUIceThat1TiffWxx3jpj9O47qUuo6P5aKUl2U9SnnrU+OW6lfgpacMnzyc69HIHK0VT34r26xy1B0aPaSK8VKL2Vq7MvHUG9C1QVvVm4+fo0gEsQdqeIURHgvvo0Q5AkLjYNPwhF+HeDd+tsRePVK0bcvQm/j5IfMVDHMzPmLXiAcQ8vsyDV0BUMovruasZBytCp5d95o8Kzc1BN/V3sVq2LexfRPmGOQEY+TzxbYRM/HMi2Fa+0vmO7jO2ZbQppu24NSEV132usL0Hi49rLMVhw/x/bt9eZ7CxomfgfGKaAjhisPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com;
 dmarc=temperror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tZfWF5cE6EoAP1T7y3n2sl68rWaebUdAFdH7ben1/OY=;
 b=vidJZk1YfHf+LJL8wOODiEbTy4nuFG0/5OS2jCa8xh/uAuIeAUHcSLGZob5RNSonwEX31CSm6iJ7PLbQ1hIhWUdh5TkK/gS3TpoKmnREC/MK+vGYyrr5rISA0Z++87cM1S1ctALdFtvCAGpSHb5nRugeCOXPpgvtlttYnGEnp+w=
Received: from BLAPR03CA0103.namprd03.prod.outlook.com (2603:10b6:208:32a::18)
 by LV8PR12MB9263.namprd12.prod.outlook.com (2603:10b6:408:1e6::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Tue, 10 Mar
 2026 12:31:00 +0000
Received: from BL02EPF00029929.namprd02.prod.outlook.com
 (2603:10b6:208:32a:cafe::e1) by BLAPR03CA0103.outlook.office365.com
 (2603:10b6:208:32a::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.25 via Frontend Transport; Tue,
 10 Mar 2026 12:30:54 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=temperror action=none header.from=amd.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of amd.com: DNS Timeout)
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL02EPF00029929.mail.protection.outlook.com (10.167.249.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Tue, 10 Mar 2026 12:30:59 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 10 Mar
 2026 07:30:58 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 10 Mar
 2026 07:30:58 -0500
Received: from xhddevverma40x.xilinx.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17
 via Frontend Transport; Tue, 10 Mar 2026 07:30:56 -0500
From: Devendra K Verma <devendra.verma@amd.com>
To: <bhelgaas@google.com>, <mani@kernel.org>, <vkoul@kernel.org>
CC: <dmaengine@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <michal.simek@amd.com>,
	<Devendra.Verma@amd.com>
Subject: [PATCH v12 0/2] Add AMD MDB Endpoint and non-LL mode Support
Date: Tue, 10 Mar 2026 18:00:53 +0530
Message-ID: <20260310123055.2863727-1-devendra.verma@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF00029929:EE_|LV8PR12MB9263:EE_
X-MS-Office365-Filtering-Correlation-Id: 00ddb100-ddfd-4060-7113-08de7ea0e265
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700016;
X-Microsoft-Antispam-Message-Info:
	t/J7BthJK9P5NysXnphvbi+YiophxwUsnxBmOsSOsCPbwVRFphe5nZSq871/l1NI39hLR/hVDl0Ry2LBBcuFjYxdsgUQJoASCJTpai5DeO5pny4xOi1eyrc1aYlHmYjHHWFVsOqK207M3nB85qu3dngo59sWOKPnN7nV21ZuCrkXI2LpLuPYjT5blYrVuli+S4lBuPHNg0B29da93W/QYySgQSXdG//N4qiEroWmc139AedzpESkTlM5MylP39pUBRtmHINO0+YZ2GDgHvcxHXPDIW24L0BfvXeqDFKsbFodZjj93nLz9RW2wV3vFcfKHQzC/+2I9q4PuhR2EE8vOPkdHO5PAau11X6iUrIDVyTsa7lpd3fVtDBZpoSlfGen5kUAhcL6cRJehpYCljYXfcUEUqcDEzOJIOowjTasS8+/0riq7lAIOnmUWekNIMxzCRLd4t5n5r0o3OT6l/GrN94a50KcZug1wNsmSDvokD4fEuPAUUlIpq9lcs7aPnkgSPVIPpYRT1wM6bwpI17rx3MmMe0BwFcsc+m8oOdLqiS4/DVBEqlvmHX9uT9TpyELZY9WrlgQTS0HjAHW8JtyG1Pg5wPUklOAub9K+WehL2nOS1QkFhdtTehw3uXIb0hERmU/pQkmp1BQ1Tp/nwIHO8IdjQO6ytXxmeOxSUK8gUvEe4p8uZ4jLgiC9OIgj1N3alpvb/ddM0fIPdcA7vyNneG2wuBBGsNzgt1/EKclW0u2gmHy153PtRR87ySchrGfvvMweka440f6EUwK+v/SDw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	V/dR+i1T/PZGvhrLqbuLybSdzq/8CRqa42ISnlkXU4mX3erC9vCPtr+Ol8A6n3bxp9l/bkxyqJOj9fLtcQYTUNtBfTwIj+XJDgokck+r1AafNYYLn/53H5ir4g3Kg/tTTGzNfTJDNFyjbQY3DgNEw7RdpVAeLTC48JmcNVzvogqP4kc1Su7ne1dwZvxPPzGqntYYbMVRsSdoKqVSQyiaWWE47bpvrjGUlc1qvmQI+Op6GG1dmICrwKbZ+Gof/lBgCoSz92gN6mjNZem4HDMyzcKur9aqT04s5WX2Me/N+aBcckRSXeGafzgjjR0oGR6fkHlIBZFXGn2y6dDuy/kqA2NfG6YYrUI8xOSdAh7MWFjvy8rGVWylZNG71ajmOg85sfZSnIOKpVF9W73a3EJpSaL7YkDMAZX6sUQNOI86NE85hjPMZ6ybcyHNazQUJhZL
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2026 12:30:59.1000
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 00ddb100-ddfd-4060-7113-08de7ea0e265
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00029929.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9263
X-Rspamd-Queue-Id: ACA6D250A89
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	TAGGED_FROM(0.00)[bounces-9359-lists,dmaengine=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,amd.com:dkim,amd.com:mid];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devendra.verma@amd.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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


