Return-Path: <dmaengine+bounces-12109-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id JIbhA9QhTmpDDwIAu9opvQ
	(envelope-from <dmaengine+bounces-12109-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 08 Jul 2026 12:09:24 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 710FE72410E
	for <lists+dmaengine@lfdr.de>; Wed, 08 Jul 2026 12:09:23 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amd.com header.s=selector1 header.b=zv0G3aUs;
	dmarc=pass (policy=quarantine) header.from=amd.com;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12109-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-12109-lists+dmaengine=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7CC7E300B748
	for <lists+dmaengine@lfdr.de>; Wed,  8 Jul 2026 10:09:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67BA538B154;
	Wed,  8 Jul 2026 10:09:21 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012001.outbound.protection.outlook.com [40.107.209.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01DC638B148;
	Wed,  8 Jul 2026 10:09:19 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783505361; cv=fail; b=PQ4RnLHwRctJE/8Y+Azk9o/GMp8zUZDYdUeKR/ZGPPy0jqOcEznrnPQYrtBhXMRwv5Sw3X4HIa/WjkjYN7PXojgN1xp2+3JTPRHXV9HbGFEJABFeQts3QXg4KtHoLirhh07z0FoA1MzaimsUWGiyLrJFyqqWWVpv1XXQIRFZwF4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783505361; c=relaxed/simple;
	bh=zpjWtDzh37fzDUOmJ74vpjnrzrhhjmQ1Ru3s6BxLUa0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Twrcvp+bEaMSmpR1EoHJ9jR6+rarnN0Awe7Ia/lcW3D7jgqHoo4w+Dh+jutlITn+BHEBXLfxlRJS0GN+I4dHDZjnIpAU6oacaOHOlJ9QBJpGZEdPN3UbJW8L/zEfvF/oAGTgwjnyGRsPkDmwiVLb1mSmiEHUMxw2ldmZquZE2AU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=zv0G3aUs; arc=fail smtp.client-ip=40.107.209.1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UT1VZpOKGVnTOPKUcuSXwiQVcmP0c9mnEv5A0vSHJFrr9ACdaruxHbiQjCanxR9YIjefaWvAOJeAcGynnNMlgPYf66/wJwi7io6CU4o6vPfUAP+4aBb0L7n2CljAzBSf0wuEYlCUc4mf75Sv5LsPQ5u1gaXKgzlB+k4GVsbk8V4PFJPQSQrepnHIoFjPa0ngMWStVVcQ1wV7vYicCXzLZwa3x08CA4VgrzLNJc+2ey9SZADVBPvQIgs++uRwfRc2rc/6tC00Zj/k9lFxfV6aFWyIGnEr0sYsPtKQZ+4IKczhb4Va0P53ilZSNm4EBv7tUQegJddWOxlvWyySo16EPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QB+2f11Eb6q1uI7xdNKusMScdNEpoFlqkrdnKNkPhK0=;
 b=yfPfLFIlrAp5NTgQh79djESlEePqOnPs5I4K2RIqfENkjTf+ai6bMjjaEEV0GtW2I0nfcV+o1yVXIIo3AP9ujE34ajWSL2INbcjgP1JEj0rspV2nRObiPmfNlcSkat0KwLaTkfg8Vqx4sXs5eA+HFyOqU/1w9voF8lFEYbkx6TZTRWNunNjSl2vHu+RyS/fMNFIO+Ag+qLHDjE3hQnXi61vrv2Dk+SOqJ+5lZJliDbb+trN8WqKf/SyjGB4yVxW1K5TEqqI516fSGrVk7Z6UVot4G8ANfQmhYFhmXfyMQ+DJfYqrz7czqFOACYJZpm4LsiETEHydsP7aRTVvb403aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QB+2f11Eb6q1uI7xdNKusMScdNEpoFlqkrdnKNkPhK0=;
 b=zv0G3aUszqmWTntxAcsGeAyb1aLVko9LSQVVTThp26GexTbpnaUUuAfYlrwMXLyZayZQQOGkMXLpri6ZbLT2MsXLfxcpcqL6qeQ6mmmrq5yQQVLKt2mm4mmRNNnI5SXVFSoregM+ZYav6rGpIYPPbJOux7X53mv19/JSjfyJxkk=
Received: from BLAPR03CA0046.namprd03.prod.outlook.com (2603:10b6:208:32d::21)
 by DM4PR12MB6135.namprd12.prod.outlook.com (2603:10b6:8:ac::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.10; Wed, 8 Jul 2026 10:09:14 +0000
Received: from BN3PEPF0000B077.namprd04.prod.outlook.com
 (2603:10b6:208:32d:cafe::a3) by BLAPR03CA0046.outlook.office365.com
 (2603:10b6:208:32d::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.8 via Frontend Transport; Wed, 8
 Jul 2026 10:09:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN3PEPF0000B077.mail.protection.outlook.com (10.167.243.122) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Wed, 8 Jul 2026 10:09:14 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 8 Jul
 2026 05:09:13 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 8 Jul
 2026 03:09:12 -0700
Received: from xhdsneeli41.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 8 Jul 2026 05:09:08 -0500
From: Srinivas Neeli <srinivas.neeli@amd.com>
To: Vinod Koul <vkoul@kernel.org>, Radhey Shyam Pandey
	<radhey.shyam.pandey@amd.com>
CC: Frank Li <Frank.Li@kernel.org>, Michal Simek <michal.simek@amd.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Suraj Gupta
	<suraj.gupta2@amd.com>, Marek Vasut <marex@nabladev.com>, Tomi Valkeinen
	<tomi.valkeinen@ideasonboard.com>, Alex Bereza <alex@bereza.email>, "Folker
 Schwesinger" <dev@folker-schwesinger.de>, <dmaengine@vger.kernel.org>,
	<netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <git@amd.com>
Subject: [PATCH V3 0/4] dmaengine: xilinx_dma: MCDMA descriptor and metadata handling improvements
Date: Wed, 8 Jul 2026 15:36:48 +0530
Message-ID: <20260708100652.603074-1-srinivas.neeli@amd.com>
X-Mailer: git-send-email 2.25.1
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B077:EE_|DM4PR12MB6135:EE_
X-MS-Office365-Filtering-Correlation-Id: 01a5747d-3828-4476-8726-08dedcd8f69e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|82310400026|7416014|376014|36860700016|6133799003|13003099007|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	Rxl5xCXdNgqKS6wx8+LAcwQL2WKuZ3B0/6xVDkIHkZDRf6sI560lF4J/eyDwn2qjvFQbKVqtqhosb6jSIhqy434ecOWWDnA1l8ngk8R/1ahupb0NqyjovqG3hTLuIEiisjrEbhit6U0slWHBnI2XoGaG4uQ5vkcnwzCjH9WH8yih7pMgcnWB7l9G+iHJ5LY2i5jMgjBiQl950ZfIZ3vDhl8/YRSgHJ64x40mwzhjs/wmst0cFKGhvjCg9FtpGu9tgKknwXCw6PS8cwXDZIJEnkgHYfBEa80hZ1BdP06sEFKn7b2dv5SQK696mUrNUO2VKvqIbN6OdA+XwAdx4fwn+wRPD3RsejyXmp7tBhubQrL7V6iMT0s7gTAbI8BnlrtIQVycmbqmfscd94P0pz/VTG+rhEF+rIG9jwDIShqw8t7bYHv6NdnfUapdTgjhnHTZ5lNjWSFchxBkzsGAic3cswOjHGkWyGwoIHN330KO7j2wt5LLJ52BHmM82qRi336oeTkggd5YZJNTc1OfP8fh0/Cchcv5h4RU/jXfmyzXkTRM5v0fv3IUM1/Lgvuqc4i3LR4to/vhqIzKTmwkvxNaKf7LM5SwPSrxuJRg+qEiIFgauTJcPbGN06XeV+zE+euER40Ipqpu9kBahb1yph1AhrhcbQqQw+aCZa85STtNW7N1Bcud9okBKR5utRdOoQMADbxZVAejp1KICZBnYdB4xA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(82310400026)(7416014)(376014)(36860700016)(6133799003)(13003099007)(18002099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Jp/w6coiQMjlsBaL6mp66/V0CE9694wKF52zzgIcFH73Vxecg5vAFhM7+G7iHjSdswnGPwk1F9CdmbOiamHAeL75Z+MQrPRGTIB07W8GcOrccu2vhd83KK9+T5tPAxLLljjSX/hJ1B6xszdAFZNdgBKNtv7H4nS3jE+C5uUFYqcblTLWlCXhrEv27MDi7nCA5gH6p9bFahk6jBHEz4g8HAohaxKH3pTeHIW9VWQgwqNDzRzHYen3yzsVSJnpyZQxCwrJXCqPn4TRuPwQEL0v8of6wFJ8eNg/EE4scHbqBRD0/jeseBZHAgqcHTg5u7FIyNwZxSYhJ5jOYFj94qOruTmSTwrKJVWKSTrhy72UkYi+1Ch4qxv5KZJxW6XaSNJpOPUxbhqvKPeIdpDCW7eNy6OWX9V7IaEUGm4QEg9M84B3lVkTn6Y8gBjQoa9cT1gi
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2026 10:09:14.1386
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 01a5747d-3828-4476-8726-08dedcd8f69e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B077.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6135
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[srinivas.neeli@amd.com,dmaengine@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[19];
	TAGGED_FROM(0.00)[bounces-12109-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:vkoul@kernel.org,m:radhey.shyam.pandey@amd.com,m:Frank.Li@kernel.org,m:michal.simek@amd.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:suraj.gupta2@amd.com,m:marex@nabladev.com,m:tomi.valkeinen@ideasonboard.com,m:alex@bereza.email,m:dev@folker-schwesinger.de,m:dmaengine@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:git@amd.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[amd.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[srinivas.neeli@amd.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[dmaengine,netdev];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 710FE72410E

This series improves the Xilinx AXI DMA and MCDMA driver's descriptor
handling and metadata reporting. It fixes direction-specific descriptor
field usage, ensures completion is based on the hardware completion bit
(important with interrupt coalescing), and extends metadata handling to
expose status and sideband fields alongside APP fields.

The axienet driver is updated to derive RX frame length from the standard
dmaengine residue mechanism rather than descriptor APP fields, making it
work on designs where the AXI4-Stream status/control interface is not
present.

Changes in V3:
 - Patch 1: Renamed subject, added static_assert for descriptor size,
   refactored residue calculation for clarity.
 - Patch 2: Added Fixes tag, expanded commit message explaining interrupt
   coalescing scenario, simplified completion check logic.
 - Patch 3: New patch - axienet now uses result->residue for RX length
   instead of APP metadata, removing dependency on status/control stream.
 - Patch 4: Complete rewrite - metadata pointer now starts at status field
   (index 0) exposing status/sideband to clients; uses EOF descriptor;
   removed 'chan' field from descriptor struct.
 - Dropped V2 patches 4/5 (dt-bindings) and 5/5 (xferred_bytes) as the
   approach changed to use standard residue mechanism.

Changes in V2:
 - Rebased on the AXI DMA binding YAML conversion.
 - Added xlnx,include-stscntrl-strm in the YAML binding.
 - Clarified cover letter to reflect metadata behavior with and without
   APP fields.
https://lore.kernel.org/all/20260309033444.3472359-1-abin.joseph@amd.com/

Srinivas Neeli (3):
  dmaengine: xilinx_dma: Fix MCDMA descriptor fields based on DMA
    direction
  dmaengine: xilinx_dma: Move descriptors to done list based on
    completion bit
  net: xilinx: axienet: Derive RX frame length from DMA residue

Suraj Gupta (1):
  dmaengine: xilinx_dma: Extend metadata handling for AXI DMA and MCDMA

 drivers/dma/xilinx/xilinx_dma.c               | 85 ++++++++++++++++---
 .../net/ethernet/xilinx/xilinx_axienet_main.c | 14 ++-
 2 files changed, 76 insertions(+), 23 deletions(-)

--
2.25.1


