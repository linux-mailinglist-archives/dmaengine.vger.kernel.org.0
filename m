Return-Path: <dmaengine+bounces-12369-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id gE8MHWyTVGrkngMAu9opvQ
	(envelope-from <dmaengine+bounces-12369-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 13 Jul 2026 09:27:40 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DF03E748222
	for <lists+dmaengine@lfdr.de>; Mon, 13 Jul 2026 09:27:39 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amd.com header.s=selector1 header.b=QNc82diB;
	dmarc=pass (policy=quarantine) header.from=amd.com;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12369-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="dmaengine+bounces-12369-lists+dmaengine=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0A142307F1C5
	for <lists+dmaengine@lfdr.de>; Mon, 13 Jul 2026 07:22:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C19F36E498;
	Mon, 13 Jul 2026 07:22:20 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011010.outbound.protection.outlook.com [40.107.208.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A36A2361640;
	Mon, 13 Jul 2026 07:22:18 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783927340; cv=fail; b=i/d4g9qD+x20pDzI4RipbDMFblkMK+OfvC7gqeTNgRN5oQBmHfaWXJiMPHpTpzqf5Q4Z0atLv51A6UYocti5l80Dff6cIThKEpkn8g7SGm80TSYx5Y2GreUzN3r8M2zslKwBZVMoQ/03ylK0Jft+MPmxyLEq7hmZtbPQTzy8Kqk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783927340; c=relaxed/simple;
	bh=NFM+bfYKQB7P5UG4FPUycR9XDIklVnJJv/jLLoEphuU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A5ujXF2mwjmV64VHHUYnvON3iRrnEb1bMlKPejZJRBbUspSXnVSLYuzMyNx80txR9rIyvuxMNmrVrEPO89RgnNyxoIRzGrQFq5y4SplQTtge/UOgNypILSq1zP/5L9KwUEHX7G2lF5ZaqUqsYFk3YzGME2zb+F50zJecarqtKok=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=QNc82diB; arc=fail smtp.client-ip=40.107.208.10
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZfJhwoSPFqE5Y8+voJjQpet6/YWIaKaLyNhsmFsJoUM+C63dAYHZNH5gQYGwz3ohz2rPScKnjby6oS02dV2hfOxBCUcz3+MzauVvqLrKErVSzAb1ujM1ima5DoDVxmibfnbjQeffUAmdR4hEZLsLbE7CSGKvjJ08KEQIVDn2IYcjCFV/g2RFIQBTGPeilQBAPyVE8eKXkOjUeVInVQdhUllCajsjiiF9fu3y1p1EWfrMR6g0+0N4WBPEfMy8LAB9+/BRB7xFcWhykwCL5BnA9xHB2kDbeABr9Y3LBLr6VY6f7lYad59GS4MRT0p9rfVxjo0T0gDQ7TIV1KtKZeO4+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ILs0zhuWj2N5J/O0cLyjNuA1PgMldmppg86cnxVkA3E=;
 b=vCKAar2irVhPWQ9Up9liRnax7wAYkJkxDRFSaR5Jm2oq3Fpg+Cofz2VTndKgSt7XfRagyqW9i1dS3tqIzpYphEiW058XL7BITVaOvhtXiOvdsBsBuLZHwH/p4HFFIAkPph1SQImjGXrKI0yguHHUPTApEZHvLt32JstdGKvMtTdI5VUDBdDHRpWlEgF1Gf5Qe1xiJDECkatUpI2hccP0IbGA+97eS74LfRoClmvHd/34Jo6iv9e+roFvH7EnF3ziyZlwa/hP0t0ay9/dm3NYiPalw08KA4KgiFrzR2u4rwas7zeHDIplvXHx0tVL5x/hYGp86aj7Lg9ivOdtUrF+dQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ILs0zhuWj2N5J/O0cLyjNuA1PgMldmppg86cnxVkA3E=;
 b=QNc82diBwzNUvXhQnHUxQr/Cthb9y3ZViKdJqRFGHtDZ0hdNEnOytdapp0zAKTC+kpGGB8zjVJYu/mLUYJzHRzAMrqauKeCnzMIBaLswrdxY17/jmj1TY2jhrUz1lXqe4pl9WSeJtAzM0lGTRTwr2DWrnbuqXkwsAaYlGgjsqtI=
Received: from CH0PR03CA0090.namprd03.prod.outlook.com (2603:10b6:610:cc::35)
 by SJ0PR12MB8615.namprd12.prod.outlook.com (2603:10b6:a03:484::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Mon, 13 Jul
 2026 07:22:14 +0000
Received: from CH2PEPF00000148.namprd02.prod.outlook.com
 (2603:10b6:610:cc:cafe::9e) by CH0PR03CA0090.outlook.office365.com
 (2603:10b6:610:cc::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.19 via Frontend
 Transport; Mon, 13 Jul 2026 07:22:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF00000148.mail.protection.outlook.com (10.167.244.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.9 via Frontend Transport; Mon, 13 Jul 2026 07:22:14 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 13 Jul
 2026 02:22:14 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 13 Jul
 2026 02:22:13 -0500
Received: from xhdsneeli41.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Mon, 13 Jul 2026 02:22:08 -0500
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
Subject: [PATCH v4 4/4] dmaengine: xilinx_dma: Extend metadata handling for AXI DMA and MCDMA
Date: Mon, 13 Jul 2026 12:51:46 +0530
Message-ID: <20260713072146.45269-5-srinivas.neeli@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260713072146.45269-1-srinivas.neeli@amd.com>
References: <20260713072146.45269-1-srinivas.neeli@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000148:EE_|SJ0PR12MB8615:EE_
X-MS-Office365-Filtering-Correlation-Id: 345e7316-9326-4a95-ae13-08dee0af7697
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|23010399003|1800799024|7416014|376014|36860700016|6133799003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	ePd0L/AZD1Gsod91Cp5N2zZSGu7nPB+9b7V7IKE2C/GVG5W1geW3HFy6LALqq85Vxu2qfuKnEDwoemFUdY6p/qtaVTlJ5lgvbPT/TiwQJu4kb+Q8QbN3XdIq10p0hzYYsV7KBVHPc1j+b9gLeCq6H3KnFxjGlA+WueqmED9qFalk/JjkuY/NTjkOuYp0kMGFYu62VcHBfuHieDZVS1/6x0PgTk1OxZDoqV2+Pswe3XQdfqquM557AkN/II0YwwRpJJZ73vBYh7zppOP7R9MeAXiY65cS2cj2ThExrf8YqbFeSU0sD8GPJ4yjCvNIFk4qO46AelNOIqpf1XmnDiRqpBriqA9fCF4NHLtmcMlSbedCXJiN81HEpzCLtSOUhdkiLqDRk7MFVzm7J7UT+qrDAoKbEfHFkWVAyLkZl/DJUBoD+awou8+K8b5Bd5pPaLoalPywQlKDnwQXX6zLkvnPYog/xyhbfOH8QNOxmJJp2FU2dDJbkkFVUcgjnIIZK9NY2+ovyXJ6o49S5agpiGIUskk9tFpS8SKcGEJzdJbDNgHN6zc5FoxUwM9B2VZ0tlWoaNG9ol3DdTrA42+cwzjwblQvNCLCzeTht7UdCokkWUtHHDgLFT3xG4+V16sp1owATd9+LP7aba+6hGVY0QG8qTnlSOJYubzqMK7Ow4PjqEd8L8KCHtOaXTomCc7tHtlDweebEacGBR9ogjOqEE2uaA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(23010399003)(1800799024)(7416014)(376014)(36860700016)(6133799003)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	N8UoRJ8o1MpL7Aj3qNvm0gBbdkR4ASXdmIGetGEl4f8c2ifw93PUO8hw8z8OujTOOK4OSWwY8Cf9OipOlvRIyPEES7wBgtywj88ijd6HdF1kkt+wsahmRdOrWzKHtlnbm8D2Us1orPaW6n3Eq+l1ITgz7L0Bx1cW6xMjr1NsRyM6cVtIY12Z2rlnVq/WT9YZmvXr0KoiM1ArAkKLsgDdgGFe41KzI/DcZ3aoqyCC0qSQH3bsF2rJBNCZvfY5vlflTR5dSLSn3DL5XY37Zyy7cYPbWYCLE+YSqGfnwOrVyQVpHSjBFD4Js/75B91d/PAkJySCJs2bivbjak8l4oLg5clQ6HJnWHGUExB9yNg0G4pvTGydXT9z+8r+LLFagBIGS+epumCYnlzGQReonWJ7FrDZiuyGksEQQMGVrXxsyJD4IHbvegJdbkj6qNgJd2Tf
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2026 07:22:14.6181
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 345e7316-9326-4a95-ae13-08dee0af7697
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000148.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8615
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
	TAGGED_FROM(0.00)[bounces-12369-lists,dmaengine=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,amd.com:from_mime,amd.com:email,amd.com:mid,amd.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[dmaengine,netdev];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DF03E748222

From: Suraj Gupta <suraj.gupta2@amd.com>

xilinx_dma_get_metadata_ptr() exposed only the descriptor APP fields.
Each descriptor also carries a status word, and AXI MCDMA carries an
AXI4-Stream sideband word holding TID, TDEST and TUSER that clients may
need. Return a pointer to the status word so clients can read the status,
the sideband and the APP fields together. The exact index layout is
documented at the function.

Take the pointer from the End-Of-Frame descriptor, where the hardware
writes these fields. For AXI DMA the pointer now starts at the status word
of the EOF descriptor instead of the APP fields of the first descriptor,
and the payload grows from 20 to 24 bytes. No in-tree consumer is affected,
since axienet reads the RX frame length from result->residue rather than
the APP fields.

Read xlnx,axistream-connected for MCDMA as well, and attach metadata_ops
in xilinx_mcdma_prep_slave_sg() when an AXI Stream interface is present,
so MCDMA clients use the metadata API the same way as AXI DMA clients.

Signed-off-by: Suraj Gupta <suraj.gupta2@amd.com>
Co-developed-by: Srinivas Neeli <srinivas.neeli@amd.com>
Signed-off-by: Srinivas Neeli <srinivas.neeli@amd.com>
---
Changes in V4:
 - Restructured xilinx_dma_get_metadata_ptr(): AXIDMA is now the
   fall-through path instead of a separate branch guarded by
   WARN_ON_ONCE()/ERR_PTR().
 - Rewrote the kernel-doc as an index table covering AXI DMA, MCDMA S2MM
   and MCDMA MM2S, and documented that the pointer and payload length are
   the same for both MCDMA directions.
 - Added an inline comment explaining the union aliasing.
 - Condensed the commit message.

Changes in V3:
 - Renamed subject to include "AXI DMA and MCDMA" (was "AXI MCDMA" only).
 - Complete rewrite of commit message and implementation.
 - Metadata pointer now returns status field at index 0 instead of APP
   fields, exposing status and sideband information to clients.
 - Changed from list_first_entry to list_last_entry to return the EOF
   descriptor where hardware writes status and APP fields.
 - Added explicit handling for both AXIDMA and MCDMA types with proper
   payload length calculation.
 - Added WARN_ON_ONCE for unsupported DMA types.
 - Removed the 'chan' field from struct xilinx_dma_tx_descriptor (was
   added in V2) as it's no longer needed; channel is obtained from
   tx->chan instead.
 - Dropped V2 patches 4/5 (dt-bindings xlnx,include-stscntrl-strm) and
   5/5 (xferred_bytes support) as the approach changed to use residue.

Changes in V2:
 - Added support for MCDMA metadata handling alongside AXIDMA.
 - Added 'chan' field to struct xilinx_dma_tx_descriptor.
---
 drivers/dma/xilinx/xilinx_dma.c | 49 ++++++++++++++++++++++++++++-----
 1 file changed, 42 insertions(+), 7 deletions(-)

diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
index 1b5b00f08c5f..2be95f0ba3ea 100644
--- a/drivers/dma/xilinx/xilinx_dma.c
+++ b/drivers/dma/xilinx/xilinx_dma.c
@@ -651,18 +651,49 @@ static inline void xilinx_aximcdma_buf(struct xilinx_dma_chan *chan,
  * @tx: async transaction descriptor
  * @payload_len: metadata payload length
  * @max_len: metadata max length
- * Return: The app field pointer.
+ *
+ * The hardware writes the status, sideband and APP fields into the last
+ * (End-Of-Frame) descriptor. These words are contiguous, so a client reads
+ * them by index from the returned pointer:
+ *
+ *   AXI DMA:          [0] status,        [1..] app
+ *   AXI MCDMA (S2MM): [0] status,        [1] sideband (TID/TDEST/TUSER), [2..] app
+ *   AXI MCDMA (MM2S): [0] ctrl sideband, [1] status,                     [2..] app
+ *
+ * For MCDMA the pointer and payload length are the same in both directions
+ * because the union members overlay the same descriptor words.
+ *
+ * Return: Pointer to the first metadata word.
  */
 static void *xilinx_dma_get_metadata_ptr(struct dma_async_tx_descriptor *tx,
 					 size_t *payload_len, size_t *max_len)
 {
 	struct xilinx_dma_tx_descriptor *desc = to_dma_tx_descriptor(tx);
-	struct xilinx_axidma_tx_segment *seg;
+	struct xilinx_dma_chan *chan = to_xilinx_chan(tx->chan);
+
+	if (chan->xdev->dma_config->dmatype == XDMA_TYPE_AXIMCDMA) {
+		struct xilinx_aximcdma_tx_segment *seg =
+			list_last_entry(&desc->segments,
+					struct xilinx_aximcdma_tx_segment, node);
 
-	*max_len = *payload_len = sizeof(u32) * XILINX_DMA_NUM_APP_WORDS;
-	seg = list_first_entry(&desc->segments,
-			       struct xilinx_axidma_tx_segment, node);
-	return seg->hw.app;
+		/*
+		 * The union members overlay the same words, so one pointer and
+		 * length cover both directions (see the layout above).
+		 */
+		*max_len = *payload_len = sizeof(seg->hw.s2mm_status) +
+					  sizeof(seg->hw.s2mm_sideband_status) +
+					  sizeof(seg->hw.app);
+		return &seg->hw.s2mm_status;
+	}
+
+	/* Only AXIDMA and MCDMA attach metadata_ops, so this is AXIDMA. */
+	struct xilinx_axidma_tx_segment *seg =
+		list_last_entry(&desc->segments,
+				struct xilinx_axidma_tx_segment, node);
+
+	*max_len = *payload_len = sizeof(seg->hw.status) +
+				  sizeof(seg->hw.app);
+	return &seg->hw.status;
 }
 
 static struct dma_descriptor_metadata_ops xilinx_dma_metadata_ops = {
@@ -2639,6 +2670,9 @@ xilinx_mcdma_prep_slave_sg(struct dma_chan *dchan, struct scatterlist *sgl,
 		segment->hw.control |= XILINX_MCDMA_BD_EOP;
 	}
 
+	if (chan->xdev->has_axistream_connected)
+		desc->async_tx.metadata_ops = &xilinx_dma_metadata_ops;
+
 	return &desc->async_tx;
 
 error:
@@ -3287,7 +3321,8 @@ static int xilinx_dma_probe(struct platform_device *pdev)
 
 	dma_set_max_seg_size(xdev->dev, xdev->max_buffer_len);
 
-	if (xdev->dma_config->dmatype == XDMA_TYPE_AXIDMA) {
+	if (xdev->dma_config->dmatype == XDMA_TYPE_AXIDMA ||
+	    xdev->dma_config->dmatype == XDMA_TYPE_AXIMCDMA) {
 		xdev->has_axistream_connected =
 			of_property_read_bool(node, "xlnx,axistream-connected");
 	}
-- 
2.25.1


