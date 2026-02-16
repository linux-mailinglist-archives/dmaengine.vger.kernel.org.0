Return-Path: <dmaengine+bounces-8908-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kN1zKL/3kmlx0gEAu9opvQ
	(envelope-from <dmaengine+bounces-8908-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 16 Feb 2026 11:55:59 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CB841428E3
	for <lists+dmaengine@lfdr.de>; Mon, 16 Feb 2026 11:55:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 06B973012CD3
	for <lists+dmaengine@lfdr.de>; Mon, 16 Feb 2026 10:55:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCE2C3002BB;
	Mon, 16 Feb 2026 10:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="MVpaiDOh"
X-Original-To: dmaengine@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010001.outbound.protection.outlook.com [52.101.46.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81AA8284B25;
	Mon, 16 Feb 2026 10:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771239356; cv=fail; b=SX0+JReVFpewGbe8m9qZvLXBSsUjfN6iJOHSpW7gVmnGuuuVS5fs5SbngaUlIDu1Z9IAA7ejCb1P1tA4D03O8f+TvwLmswP/kYXrcIhvpXiU2G3m/TSHBSA8VMm6ivyAAxqiN7lwX8ShFpBU64Z7Bc6sN62NWE27cZhaB9QRhUw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771239356; c=relaxed/simple;
	bh=Z7Uicl9V30UGzEqdRsf758amgl1VB2li6MAWs8IUjfo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CCiaHmp68bQZbJS0XqjbLmXzeTjS01SYz86y8NRlfNEgf4FivKPeyflDb0fyDQ0HAlxOAyS6SRdRmwYGFygumhUG2un7hoiShWCGeiprpTm2RnfRT3oifZHO5DMTfCZ+a9qoG7OMT5dTudf+i9zNTpVClrO6UOC74m7fx+3zeIs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=MVpaiDOh; arc=fail smtp.client-ip=52.101.46.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pt8ylNK7HES0f4IUj3JLIPojKeJiF9IT8DsWpjLlzBPjcmZQVDHn2qO7eZaW1rtpHAmfMNGbue0JVgnRrBX4zztjo1gkkPeMjct+keafHGNJkm/Sj9L++jaLF3fBynJdd2cwIeAZ0mXE+b7d4yWiHbNz7Wdy6lVbvLCrvfmCNgoEWJzu2hyQAwnDXLT4H+m6etOVgz9BIBIha1J3jMsp+kMSea/NAE6nHzvfqalyX65kXHrHF2w5E8obBl6OKXYqi5VOg9SYzbjOeAL+ePGfOT7WzPsveQGX7ucheIfY3uVDOvlrA2ghnYYATUKHYTURx5J/jX6KUOG+bPPEKe+jxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2h7hhDHPEmy+A9N1DoRQUHnH9U1oD1eXKY8/AAMjJ3s=;
 b=iVuqIK09Pb0A7z3DLfrlg019QNcIMng3R/rdvgoWDybDMBAsX0s+/QP3yaDPx8vQcfFYEDsdROIyostgrhccbALnBmsM7C293stamR6iS7tKCpW+0Ey556uUXhTAMSQxPQuHyIRWGAunxWwYWPfQB5Uho1q8Q9MTmhAO1UyS/qcc26Ka/u2SjRNwDMmI6dSMDnyU7dIuhEapcez6UA+huKKRrBiMgqXBzEtgw3asOETjU+MIL6wcZzNXBqYWm5A8+CNAMuXhshFr37kFiLWsDSMzod2PLB1zXkixfJtGawaXpbbOzrMsgD+ZIy2wCcASDbcNU7sCEvEbiTmgLe60Hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2h7hhDHPEmy+A9N1DoRQUHnH9U1oD1eXKY8/AAMjJ3s=;
 b=MVpaiDOhPb/XqqPCI+JEUfXwDYWBZ2EG4TMHRNtv0+QftjL0cbRgCnCNcrXRrG0/RYHjHKNG8srv8Y8joTuNSgD3OlkOdbc7HfHJh0Q20Xsps2ctSjrBOAoAkfhH0rujQXnGFRzljSYZs3OVkdTJli+owgWxCknXxqQH51XPdP8=
Received: from BYAPR06CA0014.namprd06.prod.outlook.com (2603:10b6:a03:d4::27)
 by SA1PR12MB8699.namprd12.prod.outlook.com (2603:10b6:806:389::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.16; Mon, 16 Feb
 2026 10:55:51 +0000
Received: from CO1PEPF000044F9.namprd21.prod.outlook.com
 (2603:10b6:a03:d4:cafe::ec) by BYAPR06CA0014.outlook.office365.com
 (2603:10b6:a03:d4::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9611.16 via Frontend Transport; Mon,
 16 Feb 2026 10:55:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CO1PEPF000044F9.mail.protection.outlook.com (10.167.241.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.0 via Frontend Transport; Mon, 16 Feb 2026 10:55:50 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Mon, 16 Feb
 2026 04:55:50 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 16 Feb
 2026 04:55:49 -0600
Received: from xhdapps-pcie2.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Mon, 16 Feb 2026 04:55:47 -0600
From: Devendra K Verma <devendra.verma@amd.com>
To: <bhelgaas@google.com>, <mani@kernel.org>, <vkoul@kernel.org>
CC: <dmaengine@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <michal.simek@amd.com>,
	<Devendra.Verma@amd.com>
Subject: [PATCH RESEND v10 0/2] Add AMD MDB Endpoint and non-LL mode Support
Date: Mon, 16 Feb 2026 16:25:44 +0530
Message-ID: <20260216105547.13457-1-devendra.verma@amd.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: devendra.verma@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F9:EE_|SA1PR12MB8699:EE_
X-MS-Office365-Filtering-Correlation-Id: 65375e49-28e2-48e8-00a7-08de6d49f303
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qprOskxswMcLIZDlyFlp3Yf+gM+BeCp1z5/VTl4Y8fdMZv5QIcul7i/KMKio?=
 =?us-ascii?Q?HzTK/IMsKyQHIsBfmQJehNb8x2BCmT/bwAge6kOc+Drnfz+9Iy6fuHIGscBg?=
 =?us-ascii?Q?MXCnjnM7Vbq9xCAEEwuWiGxLvyiniFYzbTJCrixEGFyWjtzjNAiFFue7VGHQ?=
 =?us-ascii?Q?SMtVxh7yR1/d545D2Usbx+RDF4HekmyVI94TFRnINT1Ke5hP+mdl9dBRHbtn?=
 =?us-ascii?Q?Enll45CUrthu+NLsMz0tC9yBlbgyyzp6xPktfoSF0sHBmWgYn4ojLDYdJXs3?=
 =?us-ascii?Q?hzra34JxDfa9lA/7ebWPe+pcYJwfDyeV7DNAHDx8BRazalapUN9IAETjJ2fw?=
 =?us-ascii?Q?LKAq/l3qNtx01Ln585Rn7Sc65VVatwMN1H166+5RGa3u5ul/OMA4N66qp/Fp?=
 =?us-ascii?Q?jr4ce/Fz1qNB3+f+FfGTo6aGwp5nWhNfz8mIeF64fQbo2PgECDkOdBVH2/L0?=
 =?us-ascii?Q?9dzDvUEU558zq3FIMB0a4ZbJC9UT527OE6mLpHQqctd/1+LojwOurIylFx/p?=
 =?us-ascii?Q?/tskrC+lg4QA9crHBRPPqdRxPW6nx5lo02q7H56MW0XI76oN2+0OBz7oe1+b?=
 =?us-ascii?Q?bTXIAp8xHHS61aceM8sKea4L1n+rfUZN6MNThUb535WCrbqGcV3ghLgWYGl0?=
 =?us-ascii?Q?eSwdUrGCuyvNNQcHqrmEj7JXDeGxNuUVA5+fHgbZpCbrvp+eywjRaRBwn+dr?=
 =?us-ascii?Q?O2iQkulsDwcS7G53nYfpK5OCTF46uMSrriekh6B+IWacTuieVys6vcRVXEdV?=
 =?us-ascii?Q?n8+VumMqUtWsEa6h1Dc6x6iOJ3zdV0jx23xNeGSqPCLDHiBdXruKzcWS8CG7?=
 =?us-ascii?Q?hPMpagTs6/6KZUsZrl4hOiPtd9yK9hJMAE4F4sv/N4FndYfN7ZWZ/vCHQoi4?=
 =?us-ascii?Q?dN3xS2WfMWG2nM1fhNMjFraHyyhO2PlNS7ApUlOp3Pn1MNza1n6JAMrN47r5?=
 =?us-ascii?Q?qxdHl8NZPYMXIuQyl3yDfJgk3e3dUT/jx7JcDze1HudhUW3QsjQJ4yo3D7Nc?=
 =?us-ascii?Q?PImfB4HmeCwJYsR3Pkmkkix7WK7X10v7SYIc8D9PG/UBEDaNCOGjyE3qaDYZ?=
 =?us-ascii?Q?YhCvS3e5FvOK0dInQMwrfRSh5GcelcBPzd5rp85ra/0b5iPk8uSos8DVFeid?=
 =?us-ascii?Q?onBB6lF2sYwsTGcVjX5tTaNJHQYOhfeyVon5jsgue6YItvpZggonY/VGdwZk?=
 =?us-ascii?Q?l6q7+qxi98vXK6Dm8bsKhtcQEaVNkHTWu3PB9suhx55UCPsA4T789FdAU57r?=
 =?us-ascii?Q?ZyLOYJ3qIVj/6qxFYfyAoklTYkEalvE6yOKEgcu3EEthFzc9cZLSk3x21Pxu?=
 =?us-ascii?Q?5lGonw03KicaIRVlmUftOkHft9U8jtd1JqbiJRmaHqq6HvTDzaYw8aPbiHVF?=
 =?us-ascii?Q?+tsSXr+xrrOnkVXBsrslrmP0OcJrVryPVWRfUnYetyawD1rXZIJXayU/O2B1?=
 =?us-ascii?Q?45XnN4dzGSyhLqcyR0BH5ER0YuzByAv46atFQDND4myVui1NClTWdOCC3mKX?=
 =?us-ascii?Q?aK6UuemDlahqwKwgVJfOf5u4m0644zqjU/3S1qV230O2MK1nJbE84Rm700pa?=
 =?us-ascii?Q?jqiXZ2YoE7N52Sfkbh6DQFPY3nX0i9WqMCjqlti6XQN06zlz/THYSbQ6lL0T?=
 =?us-ascii?Q?/5yxckOM9HHsg9sH+vyktJg0uMtyy5QIArGkxNuD/N3PuE9yQHTmyvS2u2Xm?=
 =?us-ascii?Q?+UzA3g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	0uF9ZIdFaO8NPCaIsK8oTO3tVYjSy5Qy/vCIbJRaLll3nfU99A3NXsDkX5966YntyTsDI3QP4pomSi/bkVHlJS4wradBYwpsm/+rj7vCUyxVafLX1uTH/WNVrHWoqwej/wTQYlMKX/og5OjJ0YRNoUpICZoCPs0h00w/TyzjV++tQCxdYWxf9OFfWMh+HTl19dEEAhKuaBInUTuM3puOakZFzOGlEiH4JiZ77jrwMjpL1ng+pQu7J/lder6I2ezO4wjaDioKtjPaIC8X6627rW0O2D7h6ZRmKqxOgNE0DuLhDy7WIjQCOPCmwMXGbts83OrvqZTJSrjiA0I/no7UhVhhKDKZKbJ9iQJXw2EFETIqQQaX5lHq12PZx764zgh31dMXe/dYBzubt6LDsh8Gw6Tfgk7NXF/00C4LAZE/lSkF/AmCgYRz3iKbzIVrIdpv
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2026 10:55:50.8957
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 65375e49-28e2-48e8-00a7-08de6d49f303
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F9.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8699
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	TAGGED_FROM(0.00)[bounces-8908-lists,dmaengine=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,amd.com:mid,amd.com:dkim];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[devendra.verma@amd.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 0CB841428E3
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

 drivers/dma/dw-edma/dw-edma-core.c    |  35 +++-
 drivers/dma/dw-edma/dw-edma-core.h    |   1 +
 drivers/dma/dw-edma/dw-edma-pcie.c    | 220 +++++++++++++++++++++++---
 drivers/dma/dw-edma/dw-hdma-v0-core.c |  65 +++++++-
 drivers/dma/dw-edma/dw-hdma-v0-regs.h |   1 +
 include/linux/dma/edma.h              |   1 +
 6 files changed, 301 insertions(+), 22 deletions(-)

-- 
2.43.0


