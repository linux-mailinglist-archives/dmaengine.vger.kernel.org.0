Return-Path: <dmaengine+bounces-10173-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qI5kN6R58GnMTwEAu9opvQ
	(envelope-from <dmaengine+bounces-10173-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 28 Apr 2026 11:11:00 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 96553480FE6
	for <lists+dmaengine@lfdr.de>; Tue, 28 Apr 2026 11:10:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DFD1530C7A89
	for <lists+dmaengine@lfdr.de>; Tue, 28 Apr 2026 08:54:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 230973DFC67;
	Tue, 28 Apr 2026 08:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="p1HJxkOC"
X-Original-To: dmaengine@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010057.outbound.protection.outlook.com [52.101.46.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F15C3DEAC7;
	Tue, 28 Apr 2026 08:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777366395; cv=fail; b=aalbiCTZoZc+I0Zk39UMtXYwo6N5+cRUb5dtSPHv3pDIOAt7bG9yC+q4xM6TLx45pMFxsXEvH6U2dXfX2JYzDYiswsinvU0MuRMrLzvNY5N0PHe30h1di2yBGPgMvhIDDQZpHb0Mf7MnDxnTpjTZFChbaXsKvZjZWB4deDpfst4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777366395; c=relaxed/simple;
	bh=OSHhGeL0971UXCUP+A2L1e8yJwvuZDDHNwj9V+lfZak=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mSw9l3t23HVd5sIR6/Ek8TW4opd3ym7d2z4xuvhfQmTHWh07WFaxoB08x77ikvcoXdqd6LT/cSpVB2wcXRLnbI1e17y5VlFxdI4h5SHERJd1OJ4byRT6V0QFQ8SW5xYJwceXNwbKF/qMJyQtkj57WFJB0yl0vkT7N838zkXS040=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=p1HJxkOC; arc=fail smtp.client-ip=52.101.46.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QDgjYy8bsAjZY2/HuLFuQhjPSiHCqfuIgJH5AjfTesOQwbrzo2gcPd4PGukQbuZAp6dbWrx0AY0xHdKtg2uTUB8FRaKBdaLkkeYJX0Tj0v43IkWkt4SbmMWVTThmqcK20pDr0A5zW/dUoV6qTcBqDziGmuPYpOz4d9dmFQxtWaFDycs/42u1It7LOsKt0j+CavogYMVqzPlmUvzS8wvtTArfNGkBf0lsBtT87G1mwgBx1HR5nMD4HmWETkg+4ebrZaNcBxHWwchN6j4nObgQatjipzz9q93L8YZfuqB5zFt6AQ6BB0EnQDPHPkfm2xU6grFAMDToAhfyab7X0Egmig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YHCF0SNttGb0G8VZ96nwtg7LxzzgIfuaCksOb0W8kPw=;
 b=bC95NoHMdhMUrto0yVL0eqnAKnkedIk6Y7vwBPMTgTVpLl/3zpfjsm1yW5LfeO+HWfk/e4UuU4ekIZ6HYH4RWT/Bk7yea2SP/dIKw2vxCvhNMwhERiNVIZpulY8Wvw01E4bsqRlzU0wUHHwk3iOhKX0v2HRSB2OoIer/93ReWqEDVOymkSyefcHpNy4lgE3hxreRcnLNPGzPaYqYkoITqkAszyvZC+Ize2CRfQewv0yFDskXyaEPIKVXdv0+Byfeur5+EvAuBSx8in/bRSw9hoxYCs4NrqHFB8Nelry9oB90CyGgcyc0vhWQGUcEb8q1Bka6od0Yp9lkBghBvU5kZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=nxp.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YHCF0SNttGb0G8VZ96nwtg7LxzzgIfuaCksOb0W8kPw=;
 b=p1HJxkOC2FtDd4boE/6ko9ucNMIAfGDxMP/R+mCozmFaYejhvMvJxtBcyE1kxyTGtd3DA0X6NVVyT0NXU8UhgaNW5J+CFldybZarjaYN7GNO2+SQLDSsG+YYiMe0wrwe06sT4JaImpWsE+D4Vl8cSC3SuFwr0VMy8/meV3Wv7A0=
Received: from CH0PR03CA0326.namprd03.prod.outlook.com (2603:10b6:610:118::9)
 by IA1PR10MB6781.namprd10.prod.outlook.com (2603:10b6:208:42b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Tue, 28 Apr
 2026 08:53:12 +0000
Received: from CH2PEPF00000099.namprd02.prod.outlook.com
 (2603:10b6:610:118:cafe::87) by CH0PR03CA0326.outlook.office365.com
 (2603:10b6:610:118::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.25 via Frontend Transport; Tue,
 28 Apr 2026 08:53:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 CH2PEPF00000099.mail.protection.outlook.com (10.167.244.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Tue, 28 Apr 2026 08:53:11 +0000
Received: from DFLE201.ent.ti.com (10.64.6.59) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 28 Apr
 2026 03:52:44 -0500
Received: from DFLE210.ent.ti.com (10.64.6.68) by DFLE201.ent.ti.com
 (10.64.6.59) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 28 Apr
 2026 03:52:44 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE210.ent.ti.com
 (10.64.6.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 28 Apr 2026 03:52:44 -0500
Received: from uda0498651.dhcp.ti.com (uda0498651.dhcp.ti.com [172.24.233.239])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 63S8q6MP623293;
	Tue, 28 Apr 2026 03:52:40 -0500
From: Sai Sree Kartheek Adivi <s-adivi@ti.com>
To: <peter.ujfalusi@gmail.com>, <vkoul@kernel.org>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <nm@ti.com>,
	<ssantosh@kernel.org>, <dmaengine@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <vigneshr@ti.com>,
	<Frank.li@nxp.com>, <s-adivi@ti.com>
CC: <r-sharma3@ti.com>, <gehariprasath@ti.com>
Subject: [PATCH v6 07/19] dmaengine: ti: k3-udma: Add variant-specific function pointers to udma_dev
Date: Tue, 28 Apr 2026 14:21:36 +0530
Message-ID: <20260428085202.1724548-8-s-adivi@ti.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260428085202.1724548-1-s-adivi@ti.com>
References: <20260428085202.1724548-1-s-adivi@ti.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000099:EE_|IA1PR10MB6781:EE_
X-MS-Office365-Filtering-Correlation-Id: 0020fbc4-9c2d-4544-1ee5-08dea50393a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|36860700016|376014|1800799024|82310400026|18002099003|56012099003|22082099003|921020;
X-Microsoft-Antispam-Message-Info:
	ko5Y0GFYs1uoAuDxZI5PIbaubTirZk5loehj6kkqVLp9f6CVEatyki9Fbi6h/1jh4k2FJXD0ycVYf0Hay1wcU22DBu2hr79yDwFXTQMIz5LBtmQKbGmp/IxoQHq0t0xHdA/5BE6pgTEkyRJ4FN+OyADB3Lfs7iDIuoetHYWzLSqWrk8Xr2UwNgfCIakPxf0grdB6K9HeojnDp4lCauZEuv5bmUNcgnjV55rB5kyrOV8bQrInK58DjyOMz4mp/0k+t/20oU18qlBRc9KKYTzhHqvIBoUfFMemEg/VYkTW1qRqMBm0DBFs7uw2hTL6uIozDC1FS7JlH+NBGqj62Ny/lC1uZ2vDR7a58DpaAQ7fCGhAGDEy0hJNUfGdN0NtS7mGWDvCPG1ULiZNr+zQuGOgqQZuS6UbjXYmv17nm/AUWGLzLYG3C7Z9Z5xhXk+Ybd75Liqp66cioiKEtJwNBN1nMVglovGrd6NEmulomK8qq9sLFlmBSHJO4s+6shotgjURBAV5jfJPeKXG4FTjQ3Qepgwqi+ZTV+8+0LseYtD4A+7uGyAhZ1S0AU2E2zgx87yAV05c5fhhlyeuXA50Wic00OqrhjM6CurL2GBJ6PpmcHb6uaN5ot+cuIvsIM6+CCIir9qaTHGQZJfnFdUh+XCYH+I1oKNZpR7Gq6zdofr0HNy58L3bfX8tWowfwWHN3ST6A9ngrLPgpnZfNpqXl1dQ+FM+21YTtsPG6r04FAz6xcFEiYlrY5FtvnQWDXVlGJ/q1jqLNpvUu8PxkOBuTOwjTt3IIBoxmWPa6gWnpEw7jRiFd2RTOqELB5C9RzazD0oz
X-Forefront-Antispam-Report:
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(7416014)(36860700016)(376014)(1800799024)(82310400026)(18002099003)(56012099003)(22082099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	60Ooc/mAjfK40DxWD7OJVrGD8YEGQ3wJWOjyBrEH54DMnGDViPqRrC6oxU4ZhoDVEuUUC7Az25PW8Yqejj3cqpE97zbh7TAx6tq14U14MIMSCdO3+3fPPYganY9yTkXMDfX/q706zouKwNuD7dyqfk3VYxUMKDE87F7RhhTZC/RRV2T3YnBJGAzDi9qPryhv4Erj4rBG0QEMV/W76NGWLJV8dWPwwAi5l1RLQb6RMmyZNjvpr7cc+496Ar2tENVwv2hQNCMZ4tvEtMT1EbXqdd202XyKBq0r/2IZsPgj9PMlU9FNl7GeD0n/aNemEbjZ0Sfr2dU9QpVPXqw6O9+Bm4qWbbDYbhfSB8TOa/RYbQiDQ4VCPaCexdtE8Fbx6r4LpIACoVp0iMyRRnqozFlDxRi5Ap34T4e4/KQTKCw/i0X5P5bpZq0rWJy9r8CyJeyy
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2026 08:53:11.2757
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0020fbc4-9c2d-4544-1ee5-08dea50393a4
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000099.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6781
X-Rspamd-Queue-Id: 96553480FE6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[ti.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[ti.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,ti.com,vger.kernel.org,lists.infradead.org,nxp.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10173-lists,dmaengine=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[s-adivi@ti.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ti.com:+];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,ti.com:email,ti.com:dkim,ti.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	RCVD_COUNT_SEVEN(0.00)[10]

Introduce function pointers in the udma_dev structure to allow
variant-specific implementations for certain operations.
This prepares the driver for supporting multiple K3 UDMA variants,
such as UDMA v2, with minimal code duplication.

No functional changes intended in this commit.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Sai Sree Kartheek Adivi <s-adivi@ti.com>
---
 drivers/dma/ti/k3-udma-private.c | 10 +++++--
 drivers/dma/ti/k3-udma.c         | 46 +++++++++++++++++++-------------
 drivers/dma/ti/k3-udma.h         | 12 +++++++++
 3 files changed, 47 insertions(+), 21 deletions(-)

diff --git a/drivers/dma/ti/k3-udma-private.c b/drivers/dma/ti/k3-udma-private.c
index 624360423ef17..44c097fff5ee6 100644
--- a/drivers/dma/ti/k3-udma-private.c
+++ b/drivers/dma/ti/k3-udma-private.c
@@ -8,13 +8,19 @@
 
 int xudma_navss_psil_pair(struct udma_dev *ud, u32 src_thread, u32 dst_thread)
 {
-	return navss_psil_pair(ud, src_thread, dst_thread);
+	if (ud->psil_pair)
+		return ud->psil_pair(ud, src_thread, dst_thread);
+
+	return 0;
 }
 EXPORT_SYMBOL(xudma_navss_psil_pair);
 
 int xudma_navss_psil_unpair(struct udma_dev *ud, u32 src_thread, u32 dst_thread)
 {
-	return navss_psil_unpair(ud, src_thread, dst_thread);
+	if (ud->psil_unpair)
+		return ud->psil_unpair(ud, src_thread, dst_thread);
+
+	return 0;
 }
 EXPORT_SYMBOL(xudma_navss_psil_unpair);
 
diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
index 5c84741881cae..21b1e3908399d 100644
--- a/drivers/dma/ti/k3-udma.c
+++ b/drivers/dma/ti/k3-udma.c
@@ -40,7 +40,7 @@ static const char * const mmr_names[] = {
 	[MMR_TCHANRT] = "tchanrt",
 };
 
-static int navss_psil_pair(struct udma_dev *ud, u32 src_thread, u32 dst_thread)
+int navss_psil_pair(struct udma_dev *ud, u32 src_thread, u32 dst_thread)
 {
 	struct udma_tisci_rm *tisci_rm = &ud->tisci_rm;
 
@@ -50,8 +50,8 @@ static int navss_psil_pair(struct udma_dev *ud, u32 src_thread, u32 dst_thread)
 					      src_thread, dst_thread);
 }
 
-static int navss_psil_unpair(struct udma_dev *ud, u32 src_thread,
-			     u32 dst_thread)
+int navss_psil_unpair(struct udma_dev *ud, u32 src_thread,
+		      u32 dst_thread)
 {
 	struct udma_tisci_rm *tisci_rm = &ud->tisci_rm;
 
@@ -329,7 +329,7 @@ static int udma_start(struct udma_chan *uc)
 	}
 
 	/* Make sure that we clear the teardown bit, if it is set */
-	udma_reset_chan(uc, false);
+	uc->ud->reset_chan(uc, false);
 
 	/* Push descriptors before we start the channel */
 	udma_start_desc(uc);
@@ -521,8 +521,8 @@ static void udma_check_tx_completion(struct work_struct *work)
 		if (uc->desc) {
 			struct udma_desc *d = uc->desc;
 
-			udma_decrement_byte_counters(uc, d->residue);
-			udma_start(uc);
+			uc->ud->decrement_byte_counters(uc, d->residue);
+			uc->ud->start(uc);
 			vchan_cookie_complete(&d->vd);
 			break;
 		}
@@ -554,7 +554,7 @@ static irqreturn_t udma_ring_irq_handler(int irq, void *data)
 		}
 
 		if (!uc->desc)
-			udma_start(uc);
+			uc->ud->start(uc);
 
 		goto out;
 	}
@@ -576,8 +576,8 @@ static irqreturn_t udma_ring_irq_handler(int irq, void *data)
 				vchan_cyclic_callback(&d->vd);
 			} else {
 				if (udma_is_desc_really_done(uc, d)) {
-					udma_decrement_byte_counters(uc, d->residue);
-					udma_start(uc);
+					uc->ud->decrement_byte_counters(uc, d->residue);
+					uc->ud->start(uc);
 					vchan_cookie_complete(&d->vd);
 				} else {
 					schedule_delayed_work(&uc->tx_drain.work,
@@ -612,8 +612,8 @@ static irqreturn_t udma_udma_irq_handler(int irq, void *data)
 			vchan_cyclic_callback(&d->vd);
 		} else {
 			/* TODO: figure out the real amount of data */
-			udma_decrement_byte_counters(uc, d->residue);
-			udma_start(uc);
+			uc->ud->decrement_byte_counters(uc, d->residue);
+			uc->ud->start(uc);
 			vchan_cookie_complete(&d->vd);
 		}
 	}
@@ -1654,7 +1654,7 @@ static int udma_alloc_chan_resources(struct dma_chan *chan)
 
 	if (udma_is_chan_running(uc)) {
 		dev_warn(ud->dev, "chan%d: is running!\n", uc->id);
-		udma_reset_chan(uc, false);
+		ud->reset_chan(uc, false);
 		if (udma_is_chan_running(uc)) {
 			dev_err(ud->dev, "chan%d: won't stop!\n", uc->id);
 			ret = -EBUSY;
@@ -1821,7 +1821,7 @@ static int bcdma_alloc_chan_resources(struct dma_chan *chan)
 
 	if (udma_is_chan_running(uc)) {
 		dev_warn(ud->dev, "chan%d: is running!\n", uc->id);
-		udma_reset_chan(uc, false);
+		ud->reset_chan(uc, false);
 		if (udma_is_chan_running(uc)) {
 			dev_err(ud->dev, "chan%d: won't stop!\n", uc->id);
 			ret = -EBUSY;
@@ -2014,7 +2014,7 @@ static int pktdma_alloc_chan_resources(struct dma_chan *chan)
 
 	if (udma_is_chan_running(uc)) {
 		dev_warn(ud->dev, "chan%d: is running!\n", uc->id);
-		udma_reset_chan(uc, false);
+		ud->reset_chan(uc, false);
 		if (udma_is_chan_running(uc)) {
 			dev_err(ud->dev, "chan%d: won't stop!\n", uc->id);
 			ret = -EBUSY;
@@ -2123,7 +2123,7 @@ static void udma_issue_pending(struct dma_chan *chan)
 		 */
 		if (!(uc->state == UDMA_CHAN_IS_TERMINATING &&
 		      udma_is_chan_running(uc)))
-			udma_start(uc);
+			uc->ud->start(uc);
 	}
 
 	spin_unlock_irqrestore(&uc->vc.lock, flags);
@@ -2265,7 +2265,7 @@ static int udma_terminate_all(struct dma_chan *chan)
 	spin_lock_irqsave(&uc->vc.lock, flags);
 
 	if (udma_is_chan_running(uc))
-		udma_stop(uc);
+		uc->ud->stop(uc);
 
 	if (uc->desc) {
 		uc->terminated_desc = uc->desc;
@@ -2297,11 +2297,11 @@ static void udma_synchronize(struct dma_chan *chan)
 			dev_warn(uc->ud->dev, "chan%d teardown timeout!\n",
 				 uc->id);
 			udma_dump_chan_stdata(uc);
-			udma_reset_chan(uc, true);
+			uc->ud->reset_chan(uc, true);
 		}
 	}
 
-	udma_reset_chan(uc, false);
+	uc->ud->reset_chan(uc, false);
 	if (udma_is_chan_running(uc))
 		dev_warn(uc->ud->dev, "chan%d refused to stop!\n", uc->id);
 
@@ -2355,7 +2355,7 @@ static void udma_free_chan_resources(struct dma_chan *chan)
 
 	udma_terminate_all(chan);
 	if (uc->terminated_desc) {
-		udma_reset_chan(uc, false);
+		ud->reset_chan(uc, false);
 		udma_reset_rings(uc);
 	}
 
@@ -3694,6 +3694,14 @@ static int udma_probe(struct platform_device *pdev)
 		ud->soc_data = soc->data;
 	}
 
+	// Setup function pointers
+	ud->start = udma_start;
+	ud->stop = udma_stop;
+	ud->reset_chan = udma_reset_chan;
+	ud->decrement_byte_counters = udma_decrement_byte_counters;
+	ud->psil_pair = navss_psil_pair;
+	ud->psil_unpair = navss_psil_unpair;
+
 	ret = udma_get_mmrs(pdev, ud);
 	if (ret)
 		return ret;
diff --git a/drivers/dma/ti/k3-udma.h b/drivers/dma/ti/k3-udma.h
index 4c6e5b946d5cf..2f5fbea446fed 100644
--- a/drivers/dma/ti/k3-udma.h
+++ b/drivers/dma/ti/k3-udma.h
@@ -344,6 +344,15 @@ struct udma_dev {
 	u32 psil_base;
 	u32 atype;
 	u32 asel;
+
+	int (*start)(struct udma_chan *uc);
+	int (*stop)(struct udma_chan *uc);
+	int (*reset_chan)(struct udma_chan *uc, bool hard);
+	void (*decrement_byte_counters)(struct udma_chan *uc, u32 val);
+	int (*psil_pair)(struct udma_dev *ud, u32 src_thread,
+			 u32 dst_thread);
+	int (*psil_unpair)(struct udma_dev *ud, u32 src_thread,
+			   u32 dst_thread);
 };
 
 struct udma_desc {
@@ -614,6 +623,9 @@ int udma_push_to_ring(struct udma_chan *uc, int idx);
 int udma_pop_from_ring(struct udma_chan *uc, dma_addr_t *addr);
 void udma_reset_rings(struct udma_chan *uc);
 
+int navss_psil_pair(struct udma_dev *ud, u32 src_thread, u32 dst_thread);
+int navss_psil_unpair(struct udma_dev *ud, u32 src_thread, u32 dst_thread);
+
 /* Direct access to UDMA low lever resources for the glue layer */
 int xudma_navss_psil_pair(struct udma_dev *ud, u32 src_thread, u32 dst_thread);
 int xudma_navss_psil_unpair(struct udma_dev *ud, u32 src_thread,
-- 
2.53.0


