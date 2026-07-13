Return-Path: <dmaengine+bounces-12366-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 23HlAGCTVGrengMAu9opvQ
	(envelope-from <dmaengine+bounces-12366-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 13 Jul 2026 09:27:28 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BF8974821C
	for <lists+dmaengine@lfdr.de>; Mon, 13 Jul 2026 09:27:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amd.com header.s=selector1 header.b=1RJ5TP3b;
	dmarc=pass (policy=quarantine) header.from=amd.com;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12366-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="dmaengine+bounces-12366-lists+dmaengine=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 83A5C304139D
	for <lists+dmaengine@lfdr.de>; Mon, 13 Jul 2026 07:22:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09E64368D4A;
	Mon, 13 Jul 2026 07:22:00 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010048.outbound.protection.outlook.com [52.101.46.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 701E9369D4A;
	Mon, 13 Jul 2026 07:21:58 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783927319; cv=fail; b=BlPX4RYjOnTyD6rMJeVyz8xgyp2NIfrgDQ2NEl6md0OJbvP4IogBQKYTskRe/O/1A1YXLbi3T7CEdakmzirVXveHWhCz7qEf3R+mVVQcdxXi/VSnlLsTZH2ZVkwhZ5bOz18q6rmMgr0nnz31EIxNRL1PkMaq9ZdB4245ynX+FYM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783927319; c=relaxed/simple;
	bh=OPC3aAipatCarvCLPDEVcQ9SHz9NVb1aLZWe7MnrWFU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pGsFgfR1kreRmM9J/7fE3aBomzKdghDiKV3lSouUBZeGVea/Jine8Fi+nt0l+6bQAooq5Y9dtlbPrj2ElFCvm2x8QXJDDgidnQx+7QLh9eDe7FeM+wcC/1cFuygjMt8bAaEHx1tBYDst4Cqp6GuWY1kgTla99DQ28StQUc8A9Bo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=1RJ5TP3b; arc=fail smtp.client-ip=52.101.46.48
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qLYTFVZ/s8SKK9oNHZlvIMFc2C6/BbC+PCpGJyd2FC52qLzx6Akh4p9x0GjDrOH46ByknJA8NCY8CGjwSDwc77Xe6tr+fD/8OQ7mAdQO3OiWpDGY5KTlRkE3B0fmgxG5RXk+UG133W8zrVfWzx+k+ZGp8VdSUvdlp/QAX8C1rW4kwolRcpaEU6f4rMOcWyyGyUnAlA0lmsXJPjDv+qTN5Evik39Ocw9HSKeeY1qgKYdoDditUnSTBs5MDF2KpnLDlBydJq/4NwDINTYeL5l6PQTXzQkaItUiIF0FSZ6Xp6obRJbKefoWIkbiydpnc3Nb0os9soHrB5aAPi+zY69qAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ccqm1Zg21zwvevfQkhyiS+L0f0kfAMvK93WrHurzL5c=;
 b=ZSZJER1Ly0SMWCDDUCmWSC6NHaEz8HRxBq2bQcDsapY+Pmi4BKghFcrDDjtNo+cS8Defua2uqtDjF+kCJ9vskAJslfHWb6aY9Gk0Tj8IHRqCW6EVQ+BiANxitdZuySSH3WNx5wC4UaMGXLkket9Z6PqRuhZGPsojMHhPbaLyBk+FEVYJOpyzPYtIefGt0eyaQpQJwHyZfc5rOPhuMRBFfLHNr195bSYM2S4fz2e9nKO5Po/a3vtsovQX/3MTtMqYqxr49MTuUDdnDvNxuOd37tPK2fBsS0lVm9WLdtriktbOmWqFCKOma5tLJkXAwnDPv2EnoBwU8dhLBL/Kma5/4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ccqm1Zg21zwvevfQkhyiS+L0f0kfAMvK93WrHurzL5c=;
 b=1RJ5TP3bTC8gusJGTy7q9LjIJuAOKctU0PeYMelFjSoX8VA8ZOJbIzx/O1jJ6N5HMtk7FZpwkdsAHs8ZLf2wtnIxBNB0Me/BETmOCEg8YELa9yeQmyWKoQnpvsKa/kJKkuOXNT4A0DJV4t9tOfPMsKB0bwedYnf5Oie5FcaOfw8=
Received: from BY3PR10CA0023.namprd10.prod.outlook.com (2603:10b6:a03:255::28)
 by LVUPR12MB999185.namprd12.prod.outlook.com (2603:10b6:408:3a3::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Mon, 13 Jul
 2026 07:21:54 +0000
Received: from SJ1PEPF000026C6.namprd04.prod.outlook.com
 (2603:10b6:a03:255:cafe::45) by BY3PR10CA0023.outlook.office365.com
 (2603:10b6:a03:255::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.19 via Frontend Transport; Mon,
 13 Jul 2026 07:21:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF000026C6.mail.protection.outlook.com (10.167.244.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.9 via Frontend Transport; Mon, 13 Jul 2026 07:21:54 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 13 Jul
 2026 02:21:53 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 13 Jul
 2026 02:21:52 -0500
Received: from xhdsneeli41.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Mon, 13 Jul 2026 02:21:47 -0500
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
Subject: [PATCH v4 0/4] dmaengine: xilinx_dma: MCDMA descriptor and metadata handling improvements
Date: Mon, 13 Jul 2026 12:51:42 +0530
Message-ID: <20260713072146.45269-1-srinivas.neeli@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C6:EE_|LVUPR12MB999185:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e5e2f79-9fb4-4cff-0b31-08dee0af6aa1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|82310400026|23010399003|7416014|376014|6133799003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	2nLCjbwxDgP+gx3/o4glbZAxLWb5yVpv8KPPDIB0zhCX4wf8l8N+S/1fGngYPjwDCh3/qm0IDW7Ya+WAtOfiFyY40/7olucwEM8hIA84nMDjRqhZYnNwG/O+USq4HoX/Jd+xhKCuoLeU+nRIrYjIG7OkjWiDJwimvBLT8v1MRjcEKWIcUpbXDY9v2DJsjaxCh8Yt+ql3bVGY3tlh+uo/bfSRh4B9QfsrQyh3Zc6tKYmBeQW+aLQkpsPKzLK2+mcBOmb34GNLbcvGovVwt5tzh6YBvYt9VggonMzifi+geanmb1KwWj1Jj8AQHC3wcVpcB//Ob4IrZbruYpe9/kgSGF78blMnfnqbFg+eF3crz+JnGCtEbTjU+HMv3+xTIppSie0bwUh3nHNJwR8/n1pTY2AfUVkOaNozDh5rk6M1rpWjaUT+uTYbS1ew89Hu5IwJL6YNFKTs62WCGUzfmoahbfAj7woLLJsYYNDIJeSU9ADi0ND50VZfEJ93uqd3PGVaT+Npbmq8dsODwaVGsIO3TOzfWLqS0euvo5KSWbk/YiMXQCgAIpHZfx9SSP7Iy1tNyvfOtYCrZd4eX+pMVHdlJ4ANWJdLqwlmYGtbo7xDn6p8c6hK802ceChsk7FK+EzSKNFz8Z6jawvfL0p7/7VBu11Jq1776ex35lTSlpbUNTsuHLP0AkZdx+40R0yNENgWv5OhabR61mXSQ4ACXumXug==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(82310400026)(23010399003)(7416014)(376014)(6133799003)(18002099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	yWy/Jd7D/2TjhIDHY/V0nRjswF8nQdpLGpVPDW26fMIzstbG/v7ACCt1rRiR0JUokUD50TyKxeGEeQL0GCuxsuq43b2Xp1XWOY1/WciZzURZXelCvinQ4qfZKr5c/IqIXQW0ceNwU9327FmxrMrbqZkJhkO824JbmwSBH4+m9iVA4MXpHOcZsaMCGEEiPFbEJJac3dwysi3D3GOghf16Q/awkbpi9wwbjC4WXUjMKyXktSds91OGMYWnRp9VuEODthTmLgcqi7SHbF6j2jxtCD3LyepcQ49RcnRf76RXdKE5+j5fTVXdIhg4QCsPM/dx6AkZioXOX5oZFQMDZSSEBV63j0SmF7vAu9LhjXVhXsFA43xkVm8gXgoeX2P4jbxU2UEa/F+IYVlqGnkgdwmfcLDcf/wmrzU1Kg/gU+tAcQ0fKRgz5Grlzoz4FS54wp6C
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2026 07:21:54.4751
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e5e2f79-9fb4-4cff-0b31-08dee0af6aa1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000026C6.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LVUPR12MB999185
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[srinivas.neeli@amd.com,dmaengine@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[19];
	TAGGED_FROM(0.00)[bounces-12366-lists,dmaengine=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,amd.com:from_mime,amd.com:dkim,amd.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[dmaengine,netdev];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7BF8974821C

This series improves the Xilinx AXI DMA and MCDMA driver's descriptor
handling and metadata reporting. It fixes direction-specific descriptor
field usage, ensures completion is based on the hardware completion bit
(important with interrupt coalescing), and extends metadata handling to
expose status and sideband fields alongside APP fields.

The axienet driver is updated to derive RX frame length from the standard
dmaengine residue mechanism rather than descriptor APP fields, making it
work on designs where the AXI4-Stream status/control interface is not
present.

Changes in V4:
 - Patch 1: Added Reviewed-by: Radhey Shyam Pandey.
 - Patch 2: Reworded commit message to reference the AXIDMA fix it mirrors;
   added Reviewed-by: Radhey Shyam Pandey.
 - Patch 3: Renamed subject to "...from residue in dmaengine path";
   condensed commit message; dropped Fixes tag.
 - Patch 4: Restructured get_metadata_ptr() so AXIDMA is the fall-through
   path (no WARN_ON_ONCE); rewrote the kernel-doc as an index table
   covering AXI DMA, MCDMA S2MM and MCDMA MM2S; condensed commit message.

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
  net: xilinx: axienet: Derive RX frame length from residue in dmaengine
    path

Suraj Gupta (1):
  dmaengine: xilinx_dma: Extend metadata handling for AXI DMA and MCDMA

 drivers/dma/xilinx/xilinx_dma.c               | 86 ++++++++++++++++---
 .../net/ethernet/xilinx/xilinx_axienet_main.c | 14 ++-
 2 files changed, 77 insertions(+), 23 deletions(-)

--
2.25.1


