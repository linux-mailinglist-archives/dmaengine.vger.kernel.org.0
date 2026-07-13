Return-Path: <dmaengine+bounces-12367-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id YSg9KiWSVGpJngMAu9opvQ
	(envelope-from <dmaengine+bounces-12367-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 13 Jul 2026 09:22:13 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 33C6974804F
	for <lists+dmaengine@lfdr.de>; Mon, 13 Jul 2026 09:22:13 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amd.com header.s=selector1 header.b=qOPUzrRv;
	dmarc=pass (policy=quarantine) header.from=amd.com;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12367-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-12367-lists+dmaengine=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A280A300AB39
	for <lists+dmaengine@lfdr.de>; Mon, 13 Jul 2026 07:22:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A75D4368D4A;
	Mon, 13 Jul 2026 07:22:10 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012043.outbound.protection.outlook.com [40.93.195.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 231C22E03F1;
	Mon, 13 Jul 2026 07:22:08 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783927330; cv=fail; b=WGV7+Y7q1K1wTyiHr9idQ0w28hbBCz/5YTSZ6/rXcBPSzPOW4iX8Ky0ebJy/rGJ2fzHQ1/yI+fVEwkm32cPL9tWaTuHv95zEE2tVjG9OeLGVNl2A5XzkwBwu+jfoiQUUiTAnHvxPsCphM8S2jo/Xy/jBU0feLbxJHIqm2lfbonc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783927330; c=relaxed/simple;
	bh=7eTfpNuz7glLer0glprFK858euInVMsvpzT1hLMww90=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AFDdvnFqzn3wpaz25UWBNdrzIYKozNV7rPp+ZFr99jyoD9UZVnsg54hZ5o0Ge4mKWOSBHJHuOmNg0uA/VRQHonucF6eogAv026lkX7KgopRch41Fe3YX0qxw8UH055dI+tHCQ22P1cJ8sX+wXDMgY8uFnrnaftpKUAZ1Q5aM0Mc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=qOPUzrRv; arc=fail smtp.client-ip=40.93.195.43
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qos2G5PRPRyewPlM5Jx73c8Di72i62rQ/EvyaSOgI8ug1QxnyDGNaIxnBBGXHD2y9/0vzJMzExhSXbn38GMPlu0se+pY/LuxeO/BsSi1qSKXiMZAADp2TG5a0HeocMJN7ZKle6X6fqfhR5I7LZY2qcoQeCBmlygbbOmJD9U3Jn2f44MtxLXk0p/Q9FRTAtZsAnev78S1QCze7ZBUE+jbUMe6UAYE57nPSrh7bHMuGxqHCfHddtQI9mA9csDGvagxa46cPHLI/zwS+nJQ6mQQJ1xV4AtkqvEl7kp7wlcjyJDTT8HnjhI9SZakLROclj4+1BebnZGIWZ99Hw66jktwxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DWWddXUhBm7O44lQU/wEzS0lO6WiRAjYDjUdDgckX+I=;
 b=TG1//xm863Jt+LRO8qs9HPIYb4FfA/oC2RZCrpZaYLF2rXCr/5Hc2xcYJfDuXh0sCZYx4YaymvpwABCX2QTMVheZfbtRG/9nHQ7FLK5h8CwOwQD8/IF2sNf7Br9UG48rZqrk5kBHNQ6/KRmWk+WBu4uyv7kBKFpDlDdfrmyzP8hseruQDGuH9kVg7Ts8XJCmb2+RnVsY1v4kdWkFMi5YGHQI4T1C+jnFLrxQfYwmJLswDoOo+RmECNP8IBOf1ufW15Qw1D4jr23Y1pPAOoh0s6CHkHqFVC88O62nun9dzwPzS4lQW5kstayEP2N1bq3BT7U6hmfgy936vPYmASYHXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DWWddXUhBm7O44lQU/wEzS0lO6WiRAjYDjUdDgckX+I=;
 b=qOPUzrRvzo0PY+m+jd1tjXdfy9u0/A+g2BwZvblUfN1V7W8Y+wyKp4yeijSozARPgzfPG4T5gu5AzcMIjvwZO0K5czpgLuQxQ3Q/A5RHLdaYJ5Vkr0z1qtIwtWN1yJRUvhRXLFS1yy6jKZpHrKGwx4+agnI3MPyvvGdwcG779TM=
Received: from BY1P220CA0023.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:5c3::11)
 by DS4PR12MB9748.namprd12.prod.outlook.com (2603:10b6:8:29e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Mon, 13 Jul
 2026 07:21:59 +0000
Received: from SJ1PEPF000026C5.namprd04.prod.outlook.com
 (2603:10b6:a03:5c3:cafe::af) by BY1P220CA0023.outlook.office365.com
 (2603:10b6:a03:5c3::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.19 via Frontend Transport; Mon,
 13 Jul 2026 07:21:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF000026C5.mail.protection.outlook.com (10.167.244.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.9 via Frontend Transport; Mon, 13 Jul 2026 07:21:58 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 13 Jul
 2026 02:21:58 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 13 Jul
 2026 02:21:57 -0500
Received: from xhdsneeli41.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Mon, 13 Jul 2026 02:21:52 -0500
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
Subject: [PATCH v4 1/4] dmaengine: xilinx_dma: Fix MCDMA descriptor fields based on DMA direction
Date: Mon, 13 Jul 2026 12:51:43 +0530
Message-ID: <20260713072146.45269-2-srinivas.neeli@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C5:EE_|DS4PR12MB9748:EE_
X-MS-Office365-Filtering-Correlation-Id: ef24e639-0b9e-4917-49c4-08dee0af6d52
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|376014|7416014|82310400026|23010399003|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	jYRhh7K4PTy2wL0Miio6Wpo0a+LjdF1iDfZXTOgwiMNd9iOAEGiPNH27Xy2VEhEmeVSS4/FXVSajRXT4LZ36NUbW2UgqaHYw01G2zH0UqXRBc+7sqK1hpjrrUweY+8Ww6jJQb6ZY+fDIzOEiHGA3e//LS+D4OGyubl+0Xl//RphwWj4vZuJ7UXovUlgATrBDW4JmyG9ersAZY+hRG8/JlGH4BBMNAzUa3zFEylFxcSiz7t5pT+NAqiQYwcIHX5MDWirEJOGcsSsuZu+nafQcCdu8n8Yv8FF78yfcJAVvl1M3JyqhIQSrlU3BMfE2MhTbingKljtBzycyQwb+mElQm/LwpkUfDzH1YBvefsB6QZb9xkV/B/lUQhcvWBm6Fn1m1G1iR0tqE9M90+rHneJVswHEUAgzFIXZUHWVGuBSGt3atiWJUxcdl+dXzA6n287Gi7hjN/Y43j0UaFa/Xc+Kgbt8Ydf1fM8PEdo3RmBmpHZzfp2+/uu/45B3d/rEqhAOKLNgBijOwgHQs0ctSzwLDMP5WD8uo9e1U+7urkCJE09+eJOt8lMmsJkjBmZnxM8syZzRJOZ+R3y8xJ5BJCAJEetHdAxVDRKsvkM2Cor+EkX9SZjnS0mf0+Fp7zBD+sHbMMh2I3cr/pDhZ3qVBQ5BpiEowT4iYOK395I0TnWXkVZxQXXl/WL6wf9iYVamH5zmYvqM4W86pPVqO2N1J84O3A==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(376014)(7416014)(82310400026)(23010399003)(18002099003)(22082099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	y7ogJ/Nw7loWLWtoAwEY0pZmjIcU+MRKZux42yMBbw5uWvNImqMkLn04vB+wIoSY+fUrvIMbPf8/JoNN771S7kBGEyFbSaD+sQWNmto3rPs2d/ae8tQnIeeSyFsGABH1Iv44sAsLkWREYSoGgV4w/0Bu5gTnPawHojtcyZgF3vjL1zOOVMTq2Fisipa5R1SgOdjE+yiXs62j6UBa2ywDp2LgOqT/2KDfP+LWX+J0UauYvo+/bf+Lw3cQ45e6PCOpXTXEsUU1pijrS5UA9z+RvK0aVbtQpsdcJxX+cinN7yewHTc6lg8B3T4lF/J8lZM7tLGNtnvp7prb5FxlKzR9txn5L2L/VjfHKjXjtNIdhhCo3DlF+QYb62F4PCtHT7TBw3z2O0AvtuSs6ATyH4C1DLMq20mkQ6Ew7v4O2uW/4u4uuZKAeWpYumJaMLPf3euL
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2026 07:21:58.9937
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ef24e639-0b9e-4917-49c4-08dee0af6d52
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000026C5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9748
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[srinivas.neeli@amd.com,dmaengine@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[19];
	TAGGED_FROM(0.00)[bounces-12367-lists,dmaengine=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,amd.com:from_mime,amd.com:email,amd.com:mid,amd.com:dkim];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[dmaengine,netdev];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 33C6974804F

The MCDMA BD format differs between memory-to-device (MM2S) and
device-to-memory (S2MM) directions, but the driver was using generic
'status' and 'sideband_status' fields for both. This led to incorrect
residue calculations when the hardware updates direction-specific fields.

Refactor the descriptor structure to use unions with direction-specific
field mappings, and update the residue calculation logic to select the
correct status field based on DMA direction.

This matches the hardware descriptor layout and fixes incorrect
residue reporting.

Fixes: 6ccd692bfb7f ("dmaengine: xilinx_dma: Add Xilinx AXI MCDMA Engine driver support")
Reviewed-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
Signed-off-by: Srinivas Neeli <srinivas.neeli@amd.com>
---
Changes in V4:
 - Added Reviewed-by: Radhey Shyam Pandey.

Changes in V3:
 - Renamed subject from "for MM2S vs S2MM" to "based on DMA direction".
 - Reworded commit message for clarity.
 - Added XILINX_MCDMA_BD_HW_SIZE macro and static_assert to verify
   descriptor size at compile time.
 - Refactored residue calculation to separate addition and subtraction
   operations for better readability.

Changes in V2:
 - No change.
---
 drivers/dma/xilinx/xilinx_dma.c | 26 +++++++++++++++++++-------
 1 file changed, 19 insertions(+), 7 deletions(-)

diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
index 98b41b8f8915..ff5b29a808e9 100644
--- a/drivers/dma/xilinx/xilinx_dma.c
+++ b/drivers/dma/xilinx/xilinx_dma.c
@@ -223,6 +223,7 @@
 #define XILINX_MCDMA_IRQ_ERR_MASK		BIT(7)
 #define XILINX_MCDMA_BD_EOP			BIT(30)
 #define XILINX_MCDMA_BD_SOP			BIT(31)
+#define XILINX_MCDMA_BD_HW_SIZE			64
 
 /**
  * struct xilinx_vdma_desc_hw - Hardware Descriptor
@@ -277,8 +278,10 @@ struct xilinx_axidma_desc_hw {
  * @buf_addr_msb: MSB of Buffer address @0x0C
  * @rsvd: Reserved field @0x10
  * @control: Control Information field @0x14
- * @status: Status field @0x18
- * @sideband_status: Status of sideband signals @0x1C
+ * @mm2s_ctrl_sideband: Sideband control info for mm2s @0x18
+ * @s2mm_status: Status field for s2mm @0x18
+ * @mm2s_status: Status field for mm2s @0x1C
+ * @s2mm_sideband_status: Sideband status for s2mm @0x1C
  * @app: APP Fields @0x20 - 0x30
  */
 struct xilinx_aximcdma_desc_hw {
@@ -288,10 +291,17 @@ struct xilinx_aximcdma_desc_hw {
 	u32 buf_addr_msb;
 	u32 rsvd;
 	u32 control;
-	u32 status;
-	u32 sideband_status;
+	union {
+		u32 mm2s_ctrl_sideband;
+		u32 s2mm_status;
+	};
+	union {
+		u32 mm2s_status;
+		u32 s2mm_sideband_status;
+	};
 	u32 app[XILINX_DMA_NUM_APP_WORDS];
 } __aligned(64);
+static_assert(sizeof(struct xilinx_aximcdma_desc_hw) == XILINX_MCDMA_BD_HW_SIZE);
 
 /**
  * struct xilinx_cdma_desc_hw - Hardware Descriptor
@@ -1015,9 +1025,11 @@ static u32 xilinx_dma_get_residue(struct xilinx_dma_chan *chan,
 					   struct xilinx_aximcdma_tx_segment,
 					   node);
 			aximcdma_hw = &aximcdma_seg->hw;
-			residue +=
-				(aximcdma_hw->control & chan->xdev->max_buffer_len) -
-				(aximcdma_hw->status & chan->xdev->max_buffer_len);
+			residue += aximcdma_hw->control & chan->xdev->max_buffer_len;
+			if (chan->direction == DMA_DEV_TO_MEM)
+				residue -= aximcdma_hw->s2mm_status & chan->xdev->max_buffer_len;
+			else
+				residue -= aximcdma_hw->mm2s_status & chan->xdev->max_buffer_len;
 		}
 	}
 
-- 
2.25.1


