Return-Path: <dmaengine+bounces-9415-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CF/RAx+vs2kvZwAAu9opvQ
	(envelope-from <dmaengine+bounces-9415-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 13 Mar 2026 07:30:55 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E76F27E268
	for <lists+dmaengine@lfdr.de>; Fri, 13 Mar 2026 07:30:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1BEC530B6C01
	for <lists+dmaengine@lfdr.de>; Fri, 13 Mar 2026 06:25:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7461E345731;
	Fri, 13 Mar 2026 06:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="AZoT85VD"
X-Original-To: dmaengine@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010061.outbound.protection.outlook.com [52.101.56.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F09683431E6;
	Fri, 13 Mar 2026 06:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773383146; cv=fail; b=liWcJ1GmRrCD//LNeL9nk9hASPG1vlK5YYi+/eSPpiOAnsxDRy6PbLyP/MaR9gNe6XDvqCd4RHmNqQHtTvqEfJUhRu+FSN9bNZXDnp6eHey94hLvL8Fam8Kz3zs01EDFLkn2ngyyVBRImhI3bvgEeqsMRQREPvGQnTxL8dUtqHU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773383146; c=relaxed/simple;
	bh=1xag35iODtRAjNwV/+wpLm3LylgWu+1S2cL/w0F1DDs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Raq7inYYIPVZcCjB6gpoIay83OvW0iav68HUeQ/p1Xf5W9NDm8vZuPOaBhakatlaznUkKPQEK/WWxHn1MbXBs1ZVRk8aeW5Od2wB8nSkDI7dkztvqEglBRKP+pTYyqIlczq4v+FA0Znqu9IOcIzCFhRXpP9amIKrgKIq6MjfQqA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=AZoT85VD; arc=fail smtp.client-ip=52.101.56.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tlEOOeN6MbqOl412eypckqtEzNarCO30cGVjjTLH37BEVVKtwRGp54l6sXOsSDI/1vtnIvgSg0UkKTh6by1zeY4G2uXbPu73HuA6AdFlZKjxQQF85oXX++rJOA/0a2+JtK8YjL4viHk+ZHivXjhMuw9e0B9VKGe1J/9HkaW8Aqo4rRWxS9G7IG88lDEPWgMXsrfC9d5ZDazedrUzrhPLscsw+du0RHMgD8pWE97X1QJWP0p47/qBwL5dHKkvqiZnIJK4WY7bUvbkMHETVtw1RqSvnKAHQQSX/t4iL9zMTkLG/GVtDgSqLKtYXbeC4HZH7dgrGUpqmheQeFUV4u87Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lNPwALV0Tf2qKWYJJ3DkoHTbtblOZ1UjGKeyPm7Y1GE=;
 b=Rw2h0zx+UfIJDX4H8CnBtBxLL/AhUz6Jgtt9PD9IgHvxi7fV7mwt+c21cAdUTx0+bDuctscC5/6sN7vbz8EcSR9VaOjtOecBtx55dDJicJqtSoAJRAP1cwFIvgJDAQgmcP2azbhVggGLFBXEh1hfTVn8UinEgGE5e4VBBYB1rvB6dUsLaCs85uXCYf5S3PgHIKqFLJkckqmw7qnVyHhFpz7Cu04MEc5td9y8ngn4EGvPxVXbEulu6cvPyhfnTl7Gp4IjwXhx4ErDklZKDrQYFEZACmwTYcbACRZT3ea2mHcTB5xXFUrDkU/uElv8NICFY/J+6yybt0zT27NpVHgnCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lNPwALV0Tf2qKWYJJ3DkoHTbtblOZ1UjGKeyPm7Y1GE=;
 b=AZoT85VDpgly9Hj6EyzJHe3cU0J++gvVt8tPbAOnjxdYxU79nWUhI8517CGTA+FBVRC+s/Z8o6qIWfvkzPpc4pI4jXfvDQ3WrQQhMM76k1SxWDlChAeFeGrMO2ETDQ4vlRWvKTIRQFDGGWPrQBH9k748h2CR6d/bfM4OLyAzJ7w=
Received: from CH0PR13CA0034.namprd13.prod.outlook.com (2603:10b6:610:b2::9)
 by BL3PR12MB9049.namprd12.prod.outlook.com (2603:10b6:208:3b8::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.7; Fri, 13 Mar
 2026 06:25:40 +0000
Received: from CH1PEPF0000AD75.namprd04.prod.outlook.com
 (2603:10b6:610:b2:cafe::d6) by CH0PR13CA0034.outlook.office365.com
 (2603:10b6:610:b2::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.13 via Frontend
 Transport; Fri, 13 Mar 2026 06:25:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000AD75.mail.protection.outlook.com (10.167.244.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Fri, 13 Mar 2026 06:25:40 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 13 Mar
 2026 01:25:38 -0500
Received: from xhdsneeli40.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Fri, 13 Mar 2026 01:25:34 -0500
From: Srinivas Neeli <srinivas.neeli@amd.com>
To: Vinod Koul <vkoul@kernel.org>, <git@amd.com>, <srinivas.neeli@amd.com>
CC: Frank Li <Frank.Li@kernel.org>, Michal Simek <michal.simek@amd.com>, "Rob
 Herring" <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, "Conor
 Dooley" <conor+dt@kernel.org>, Suraj Gupta <suraj.gupta2@amd.com>, "Radhey
 Shyam Pandey" <radhey.shyam.pandey@amd.com>, Thomas Gessler
	<thomas.gessler@brueckmann-gmbh.de>, Folker Schwesinger
	<dev@folker-schwesinger.de>, Tomi Valkeinen
	<tomi.valkeinen@ideasonboard.com>, Kees Cook <kees@kernel.org>, Abin Joseph
	<abin.joseph@amd.com>, <dmaengine@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH V2 0/5] dmaengine: xilinx_dma: MCDMA descriptor and metadata handling improvements
Date: Fri, 13 Mar 2026 11:55:28 +0530
Message-ID: <20260313062533.421249-1-srinivas.neeli@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD75:EE_|BL3PR12MB9049:EE_
X-MS-Office365-Filtering-Correlation-Id: 23d46346-f1f0-46c6-1458-08de80c958e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|376014|7416014|1800799024|13003099007|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	A35DDyB6xbL0V8gnW1N5w5lWdmDGkAQraqKrKbSvg9IJmzMW1m9VPrp3EbaQo0AYBkr2pnzWgJBxAZUgziIxaJ+LqCQE6X4jrl9VJZ80jC2nUEr235eMLnIKLe0u3Z/kaICtveixR/RzITZ1NR1uAbrOJJEwfuxgTqCL3Czy/aTTLswAFlhTce2kG03BttsWiDYl/EnMUQNkfKFUJI1kWBpNps2m4QRU01eqi3LNm0eWHwHBiRTYtVbWaFHE5+z2V3SkhwqeyKBW0Q3ZfSySSdh2A67mpdwnocK8BnJwU6iAytdBUpyvpsbf7lCR/JH5bg24PTbzaryHFU9keHDhbYS/emj29y8jL7CVfH98+g9VIcDcRJskntPMvgxhpbqI4D9FurjwyJZAuERQBCc/QgsyqJ9IvrQfSLG3dZTe76FN0Ihoi0eE7l5ARzD7ewyG2h6ZdgzcLxtvigLnN6cIB7qGLdKgixH6x7j26ApmqAAuYcarpLE4c0igN9nBpMkmOVzeMaWoRf+7P5aroICKyPRe17pMMQasvziRDfo3s8o5gjUTEMfnbKatSdkRQfH1lYzy5amewcflT4Oa3R+6/dfoNELRf2umPq6VIC2lg7KK63/IXp7qPy0JTnbYkry3s3Y5d9zIutcUFyi1YV/u2s/aeC5AG7juxApfzlEXdANNxhAhEQrjl5THIk03W8GJIiyy+vXyM+xvKLWW03CONeVeThj9zBhlyi8fO9myp+Jx5fRaXBS6XEzFsk3aLV0E6VkHJpNpo4LGYd/gqofoTA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(376014)(7416014)(1800799024)(13003099007)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	zUdeI0NcvzK1KDm1A8+UKMyV+dDjq1MPxEqlRmIdhkzBsIonorh5DSmGwZR/AyOqTb2v0uC5sDkAYg5cUD0zG+eXSNsqKB7CxzFeb7vK2ImlVX2KZEKtxsd7nB4atC5RCI1jHWNl0nTC4dvPwQNwX45RX8HeK1qAzE047lJ26dk62WFOgQkz9mTEpDmqABN70SN3dqtPQd9zud+XWPJoLP1X3iRMA0exx3rPjXmhpdGK7WTCaZCddw/Q/JBed9aIoVj6R3VzCsVWTHyXivi5qhw8ILckjCnm7Vj27dlU6FACp/kXg0r/smO7OYvp+vc5caFJ9Z5sW2P0r6id5xStJ2Fa7iscbNnbTDcEKer2ooQjWRIx9H1z23++dwt9su7O3F8p9d6TKreVLNz9Zmx9Je0cobXUveO3aT4ogHoxljiHJkCghtgJW9U9ykh2CpXB
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2026 06:25:40.0810
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 23d46346-f1f0-46c6-1458-08de80c958e5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD75.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB9049
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-9415-lists,dmaengine=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[srinivas.neeli@amd.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,amd.com:dkim,amd.com:mid];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 9E76F27E268
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This series improves the Xilinx AXI MCDMA driver's descriptor handling
and metadata reporting. It fixes direction specific descriptor field
usage, ensures completion is based on the hardware completion bit
(important with delay interrupts), and extends metadata handling so APP
fields are used when the AXI4-Stream status/control interface is enabled.
When APP fields are unavailable, the series still reports transferred byte
count via the status field, enabling clients to track progress in both
configurations. Device tree bindings are updated to expose the
status/control stream presence with a dedicated property, distinct from
stream connectivity.

Changes in V2:
- Rebased on the AXI DMA binding YAML conversion.
- Added xlnx,include-stscntrl-strm in the YAML binding.
- Clarified cover letter to reflect metadata behavior with and without
  APP fields.
https://lore.kernel.org/all/20260309033444.3472359-1-abin.joseph@amd.com/

Srinivas Neeli (3):
  dmaengine: xilinx_dma: Fix MCDMA descriptor fields for MM2S vs S2MM
  dmaengine: xilinx_dma: Move descriptors to done list based on
    completion bit
  dt-bindings: dma: xlnx,axi-dma: Add "xlnx,include-stscntrl-strm"
    property

Suraj Gupta (2):
  dmaengine: xilinx_dma: Extend metadata handling for AXI MCDMA
  dmaengine: xilinx_dma: Add support for reporting transfer size to AXI
    DMA / MCDMA client when app fields are unavailable

 .../bindings/dma/xilinx/xlnx,axi-dma.yaml     |  4 +
 drivers/dma/xilinx/xilinx_dma.c               | 93 ++++++++++++++++---
 2 files changed, 84 insertions(+), 13 deletions(-)

-- 
2.43.0


