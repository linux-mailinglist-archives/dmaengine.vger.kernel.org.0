Return-Path: <dmaengine+bounces-12113-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 9BaNM40iTmppDwIAu9opvQ
	(envelope-from <dmaengine+bounces-12113-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 08 Jul 2026 12:12:29 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E4F572418B
	for <lists+dmaengine@lfdr.de>; Wed, 08 Jul 2026 12:12:29 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amd.com header.s=selector1 header.b=hazgWBMC;
	dmarc=pass (policy=quarantine) header.from=amd.com;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12113-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="dmaengine+bounces-12113-lists+dmaengine=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 74E473028341
	for <lists+dmaengine@lfdr.de>; Wed,  8 Jul 2026 10:09:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2F1939B484;
	Wed,  8 Jul 2026 10:09:41 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011002.outbound.protection.outlook.com [52.101.52.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36B973932C9;
	Wed,  8 Jul 2026 10:09:39 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783505381; cv=fail; b=aE9/aiQt81QIf7XmztYDXAo0FxOzphBdZhdzdeWumUqTUAPHAAr8FkVyYSti/HIftANh6liGpKsST6p5d3Tsfk4bLhsVANLbpItNoj00pDnNb+cqpREW6/3kq6DUT2UGmM0ucjY28Tw3p6ggYYmmhUhxggDDsNzKevKLeMVPRJY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783505381; c=relaxed/simple;
	bh=WgLTjbVIqxmz7mGY89QjfAcX4YmSy/C4FeZspyILEN0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W/N6YkD18xbHD6WIVwVfGFAElkmadHEhKauGFDD8JMdpWyCH3qCKGVNJsjsdpqxcjMhsZzRANQlrcz4NPZPJBa3sugeZyLOw896/m80EwOgKVdcHKHLbuADaZgysIAEXtEEr750dyIvd7j1rfOvgTXYtSa7rdjW5/PVp5cDgX+c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=hazgWBMC; arc=fail smtp.client-ip=52.101.52.2
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wy84lwoYKD2rzj6BjUTU0uGNrxOgUeJMptckzK3oBy2kD9UPcADMhkOaHz8ouoWB+Am6WoS6RpP91fCwrTP4tA0h9TsdSXD3CjPAwZb2akDFq3P0h9ekXhsr4gpYT1lgCpQZp2nNCzUmGvpXzwVFw+L9WOHYHi5ES0w+CXUuqwz7s9CERMiyirC27UU816LBALkGpgbiAUNYGrfTXPtSi5icITq3MVASYBXkh9YZq99+EX2D7I/G65pwwcHRUDXjUvm35yWSGuJQZ4IsOXlTF/cVXA/qbchFABrSw6HT2ks5ZY8dkxyEKUZp6chPeQJMGv6I2pk72qyYDkMkLpktVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y8CI9qYutkBfVlgH68jW4zGSUC9lnnLAH5Ul0FhQmlE=;
 b=NlNyKXg8XvEVWpLoWjX8gh61DjXC2hTbeNcDythDuowD9t2/xZOas8RxSU3PjQAiBYjHAuG/bKua5r67+8vudqmmKOMsNdNXhwPXfSEy40qo3/YiHzv9PbsczRC4fC+eApnOAnPKwmBq/Ks/DAfUZodkRbviahtz6KsBCRkwIvpt05h15XWktGXJvhXFIDYIQeu3a+MHxW1hNIgA4Rt7fLr5JZeUGHPo5I9uffVf67rYk7NS5xkS1iEmVdSsyDp0rATksshcBjQfJwnVMjj+ovyVa3sxekiWBFcT4gqNwLGC+2SHxFNxLK9+e9ABMEeihaWPzBGQnGoaKO6+C5Tq6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y8CI9qYutkBfVlgH68jW4zGSUC9lnnLAH5Ul0FhQmlE=;
 b=hazgWBMCLln9cBKDsbiJAPdPYLvbrA/B5Ozjn/pgpkFR9FoFpFGmjuKMBdIwPUCdoM6/LW3EdWx32emUukc4GBVi+ejg+D+VRkwGNtH/XRtvK+w3P3Ya03mhRJaNiOIr5TGQJKpNH/aFs3bptSm1W+b4cBFmJdi9XOebuoLQkt8=
Received: from MN2PR18CA0001.namprd18.prod.outlook.com (2603:10b6:208:23c::6)
 by CY3PR12MB9554.namprd12.prod.outlook.com (2603:10b6:930:109::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Wed, 8 Jul
 2026 10:09:35 +0000
Received: from BN3PEPF0000B072.namprd04.prod.outlook.com
 (2603:10b6:208:23c:cafe::8c) by MN2PR18CA0001.outlook.office365.com
 (2603:10b6:208:23c::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.10 via Frontend Transport; Wed, 8
 Jul 2026 10:09:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN3PEPF0000B072.mail.protection.outlook.com (10.167.243.117) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Wed, 8 Jul 2026 10:09:34 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 8 Jul
 2026 05:09:34 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 8 Jul
 2026 03:09:33 -0700
Received: from xhdsneeli41.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 8 Jul 2026 05:09:28 -0500
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
Subject: [PATCH V3 4/4] dmaengine: xilinx_dma: Extend metadata handling for AXI DMA and MCDMA
Date: Wed, 8 Jul 2026 15:36:52 +0530
Message-ID: <20260708100652.603074-5-srinivas.neeli@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260708100652.603074-1-srinivas.neeli@amd.com>
References: <20260708100652.603074-1-srinivas.neeli@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B072:EE_|CY3PR12MB9554:EE_
X-MS-Office365-Filtering-Correlation-Id: f876c272-f6fb-4dfc-6ccb-08dedcd902e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700016|23010399003|376014|7416014|22082099003|18002099003|6133799003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	grpFbuuDUX169C04aydfR5fsQgsYmIiDTn6jOP2s+s4Sex6NxMHY5VmrT02UrfP9Bo8/enKVt/HSh7rAMAbr3ZFmId0WEAhEOMAD8D329jPM7pQkbylF4CxknEepJK4CJu/G+oS3wHcxH7Jlv6fHB7zktXile8WYP6J+cd8lBtbBXueh4GjRIKnJpUOSYxBZach+1Utm7lQg5DuQwGZGA5wzh+N3BGyOXUlxwdgzxn0an7EpBenkhLtT8BmYslf2NTk2wVt4uDWYjKKlVWejwSMJ/9A86j8IDJG5B21ZRw72XeFNT8igwH3U0v46VhCrJTauB6goApZ49qlsGT6e+VCRNhYC+hoWNgHTASuHtm9pWUt0aic4wHiLH5eNtLAGWWk/5soztcKdlIsGxenB6Kt8I4aEGHo7H+VSJVGL6nKY8O5LF5wDWRUy8BpxldTMq+7nl0O8bgDMI+Tkyppu96b6c9zUxDyhLLULuob8LBtS3x196Jeln9/NeFVgDomhOhOmgGGgTmmz1fC2MogFpjV9krfbB+8jgDtr0R3qm+MXSePtz0l8/0YZfYXBngwl1jH+rW1IDHNd4cufWI/JRu8hfkdq7e1I+hIksgYBla7ykOPH7D/7u1Xy0WQfiicXWNCxHfk5cSi/Xs6lJjYW4Lj3HIF1p4edNn5rM/r9m94x0bT6iuGiVuNLTUCZ3E3Yu93RdLD4mSW52Mle4n16Tg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700016)(23010399003)(376014)(7416014)(22082099003)(18002099003)(6133799003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	F61q/0EsEId1yK1yiddq0qyNlsDfTGGupoHxBY+q/ja/riEFLXgj7Fc+ZdMJjZ9KQvWFSu3HNaIP4Sf7Umcl2kL3tygqn9iZtmRckRnQd/lnYoRrr7K1L3sDwD1UmIWyV99s0aygp80AbDMIFtwd1SiHnXl4APYCaxE1P/gxBXUZxyEZ5T+N6sVgsiTChfZefpt4T+BDMkNKceJmgefyPepV2Bg+dqNrW290WTI/cwuNrxckJjvdczRCS+y9FZU5cS5vzZA3TSQbAMjhcrnlOjiLiDdkjGJhIoLVPby1xzPrxeM4GrSOJAegwn41CEhco+AcUWNYFZl0HBiVLCeyBJw9FUUkShA/OXLWWRYmlauErQitrlT+oAXSABfZDR6xw+NN5adWi5AgHpP9CkXj7JTChdsd6CpLGzpi3wOCIDjyrx8Y72MmXwJz4LcmTWAu
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2026 10:09:34.7589
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f876c272-f6fb-4dfc-6ccb-08dedcd902e8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B072.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9554
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[srinivas.neeli@amd.com,dmaengine@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[19];
	TAGGED_FROM(0.00)[bounces-12113-lists,dmaengine=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,amd.com:from_mime,amd.com:email,amd.com:mid,amd.com:dkim];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[dmaengine,netdev];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3E4F572418B

From: Suraj Gupta <suraj.gupta2@amd.com>

xilinx_dma_get_metadata_ptr() exposed only the descriptor APP fields. Both
AXI DMA and AXI MCDMA descriptors carry a status word with the transfer
status, and AXI MCDMA additionally carries an AXI4-Stream sideband status
word holding TID, TDEST and TUSER that clients may need. Extend the
metadata handling to expose these.

The returned pointer now starts at the descriptor status word for both AXI
DMA and AXI MCDMA. As the descriptor words are contiguous, the client sees
the status at index 0, followed for AXI MCDMA by the sideband status
(TID/TDEST/TUSER) at index 1 and the APP fields, or for AXI DMA by the APP
fields directly. The payload length is derived from the field sizes.

This changes the get_metadata_ptr() contract for AXI DMA. The pointer now
starts at the status word of the last (EOF) descriptor instead of the APP
fields of the first, and the payload grows from 20 to 24 bytes. A client
reading app[0] now reads the status word. No in-tree consumer is affected,
as the axienet driver reads the RX frame length from result->residue
rather than the APP fields. Reading the EOF descriptor is also correct, as
the hardware writes the status and APP fields there.

The index 0 and 1 layout described above is for the AXI MCDMA receive
(S2MM) direction, which is where metadata is consumed. On the transmit
(MM2S) direction the same descriptor words hold different fields.

The probe logic is extended to read xlnx,axistream-connected for MCDMA, and
xilinx_mcdma_prep_slave_sg() attaches metadata_ops when an AXI Stream
interface is present, so MCDMA clients can use the metadata API in the same
way as AXI DMA clients.

Signed-off-by: Suraj Gupta <suraj.gupta2@amd.com>
Co-developed-by: Srinivas Neeli <srinivas.neeli@amd.com>
Signed-off-by: Srinivas Neeli <srinivas.neeli@amd.com>
---
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
 drivers/dma/xilinx/xilinx_dma.c | 48 ++++++++++++++++++++++++++++-----
 1 file changed, 41 insertions(+), 7 deletions(-)

diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
index 1b5b00f08c5f..f5c4e0ca2cc4 100644
--- a/drivers/dma/xilinx/xilinx_dma.c
+++ b/drivers/dma/xilinx/xilinx_dma.c
@@ -651,18 +651,48 @@ static inline void xilinx_aximcdma_buf(struct xilinx_dma_chan *chan,
  * @tx: async transaction descriptor
  * @payload_len: metadata payload length
  * @max_len: metadata max length
- * Return: The app field pointer.
+ *
+ * The returned pointer starts at the descriptor status word for both AXI DMA
+ * and AXI MCDMA. As the descriptor words are contiguous, the client sees the
+ * status at index 0, followed for AXI MCDMA by the sideband status
+ * (TID/TDEST/TUSER) at index 1 and the APP fields from index 2, or for AXI DMA
+ * by the APP fields from index 1. These fields are populated by the hardware on
+ * the End-Of-Frame descriptor, so the pointer is taken from there.
+ *
+ * Return: Pointer to the descriptor status field.
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
+
+		/* [0] = status, [1] = sideband (TID/TDEST/TUSER), [2..] = app */
+		*max_len = *payload_len = sizeof(seg->hw.s2mm_status) +
+					 sizeof(seg->hw.s2mm_sideband_status) +
+					 sizeof(seg->hw.app);
+		return &seg->hw.s2mm_status;
+	}
+
+	if (chan->xdev->dma_config->dmatype == XDMA_TYPE_AXIDMA) {
+		struct xilinx_axidma_tx_segment *seg =
+			list_last_entry(&desc->segments,
+					struct xilinx_axidma_tx_segment, node);
+
+		/* [0] = status, [1..] = app */
+		*max_len = *payload_len = sizeof(seg->hw.status) +
+					 sizeof(seg->hw.app);
+		return &seg->hw.status;
+	}
 
-	*max_len = *payload_len = sizeof(u32) * XILINX_DMA_NUM_APP_WORDS;
-	seg = list_first_entry(&desc->segments,
-			       struct xilinx_axidma_tx_segment, node);
-	return seg->hw.app;
+	/* Only AXIDMA and MCDMA attach metadata_ops today. */
+	WARN_ON_ONCE(1);
+	return ERR_PTR(-EINVAL);
 }
 
 static struct dma_descriptor_metadata_ops xilinx_dma_metadata_ops = {
@@ -2639,6 +2669,9 @@ xilinx_mcdma_prep_slave_sg(struct dma_chan *dchan, struct scatterlist *sgl,
 		segment->hw.control |= XILINX_MCDMA_BD_EOP;
 	}
 
+	if (chan->xdev->has_axistream_connected)
+		desc->async_tx.metadata_ops = &xilinx_dma_metadata_ops;
+
 	return &desc->async_tx;
 
 error:
@@ -3287,7 +3320,8 @@ static int xilinx_dma_probe(struct platform_device *pdev)
 
 	dma_set_max_seg_size(xdev->dev, xdev->max_buffer_len);
 
-	if (xdev->dma_config->dmatype == XDMA_TYPE_AXIDMA) {
+	if (xdev->dma_config->dmatype == XDMA_TYPE_AXIDMA ||
+	    xdev->dma_config->dmatype == XDMA_TYPE_AXIMCDMA) {
 		xdev->has_axistream_connected =
 			of_property_read_bool(node, "xlnx,axistream-connected");
 	}
-- 
2.25.1


