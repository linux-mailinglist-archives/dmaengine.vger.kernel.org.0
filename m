Return-Path: <dmaengine+bounces-10193-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iHoPDNJE8mlnpQEAu9opvQ
	(envelope-from <dmaengine+bounces-10193-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 29 Apr 2026 19:50:10 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9873D4984B7
	for <lists+dmaengine@lfdr.de>; Wed, 29 Apr 2026 19:50:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AB4C8302CB30
	for <lists+dmaengine@lfdr.de>; Wed, 29 Apr 2026 17:49:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F01B738CFF1;
	Wed, 29 Apr 2026 17:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="FsGQ8JqD"
X-Original-To: dmaengine@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011054.outbound.protection.outlook.com [52.101.52.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E37D938B133;
	Wed, 29 Apr 2026 17:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777484969; cv=fail; b=e1tjJ+QJ/pVqFGGMBb54Eg6j2ih0efw0FzHIeEV7qC5fDbH3DERBsfOpZcPLDVVq/XXdtZ+B2PA2x7wAz4Wvi0lE5gf/FE2bX1pAnsu0EGHay/tpFPpmLNPmefZPosfHImi/Ck2Hio5No/qTuMkaWbqBxZCgzAqHWsvckpvqOv4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777484969; c=relaxed/simple;
	bh=F2ubNQitHEv3gSUK4VKZmhowF37/J+4qUDab0rFpt/4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rutu+TKF1w3zr1wTvQAXE6b3cXOsc1gunquwyaJvIW/OEbdEpFMIKal3qrN+2ft+T5jqyltIh3sW3MiwseVIUqEzTDbD0Ipj83EFeYzSNxp6V6Rmd+NmJaWteOx7J2wGsPWsYHawjhqNDERg5WGyA/9eantrDyGPG2oG06BBiY0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=FsGQ8JqD; arc=fail smtp.client-ip=52.101.52.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vGuvev1Sk/6Ov7n/aQa+IZFCHM/uQ/OjzRXBn9Q+p0ji5Cvg48ph0icygQbe4COGhgIwBSt10wqybqHCpsiuM8NvWpJyhaXFNZPpnzi1JLdLutCPBkmG1s0JIX3e+ROIlgw408wSLgfnITA10gTUkAZX8c1mIB0ctwuYRwWldu8k2bkzGhmhXqTVOwuX8Z80saHusiQcwdOQj8cbWrNbD15/DubhjZqVU8lmLoFKOHnQlonwPhVr4+V6Rh6fdk/ud2AYLyHyUl2GroTNlD0xRdocHoYWiwwejI6He59VzcANjgQJNVySW7/a/vuEjy7pBM7cTMXd5AZhvDiD6yGdFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=at5FlQ322RxHTC5zYDDhsWA3fhZSE8dJrt/s9DNEzlc=;
 b=vNg8eUseZCOtmulrocZCDEC2tHZvoQJPaq/3Sy4G2TGuKR6t9j4dbOXaj4pOfC/5xlIzVrZiO9r1myN2LzaUT+Km2J5gxmUHLuNi1jRIe8q5ctkrVRjA9kBfq13ScBC5eslnaFEgD55r06nM6Di7QYsOQ5Vwg+p+yDJ7V7MVK1JKIB7uHg/HBch+RTR8OB/IvwYo53HZwN/KSX90mu0vlZXIRrKpA/YPkalAK88VBcy2n68WzTfsNjCkHwEIeN1vgmNtfFsU+JpnRhsRRpZHa2xLNLzkX2q50OVOK6H4GAUJjRr2lJ0pPHp1FQmDazqjb8lgY18oczVesBNp8lrDhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=at5FlQ322RxHTC5zYDDhsWA3fhZSE8dJrt/s9DNEzlc=;
 b=FsGQ8JqDog7bpGuoZcgV7pWF/FAkD1WMSB5VwjBC3CUJre227BXq0sfSN3qcm9HNoF+DvhpWTkgDId4it5icz8V3AqNYCXbxy0+/CQmy2LihDJqvCJTWeAgXeAJCFaLt/Sffni+z25vR5494TY9pJUznu2CSYra+smVoVh84LZU=
Received: from BN1PR12CA0019.namprd12.prod.outlook.com (2603:10b6:408:e1::24)
 by IA3PR10MB8681.namprd10.prod.outlook.com (2603:10b6:208:577::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Wed, 29 Apr
 2026 17:49:21 +0000
Received: from BN1PEPF0000468E.namprd05.prod.outlook.com
 (2603:10b6:408:e1:cafe::2b) by BN1PR12CA0019.outlook.office365.com
 (2603:10b6:408:e1::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.30 via Frontend Transport; Wed,
 29 Apr 2026 17:49:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 BN1PEPF0000468E.mail.protection.outlook.com (10.167.243.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Wed, 29 Apr 2026 17:49:21 +0000
Received: from DLEE210.ent.ti.com (157.170.170.112) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 29 Apr
 2026 12:49:20 -0500
Received: from DLEE204.ent.ti.com (157.170.170.84) by DLEE210.ent.ti.com
 (157.170.170.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 29 Apr
 2026 12:49:19 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE204.ent.ti.com
 (157.170.170.84) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 29 Apr 2026 12:49:19 -0500
Received: from uda1253387.dhcp.ti.com (uda1253387.dhcp.ti.com [172.24.233.12])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 63THnDDG3822334;
	Wed, 29 Apr 2026 12:49:17 -0500
From: Rahul Sharma <r-sharma3@ti.com>
To: <peter.ujfalusi@gmail.com>, <vkoul@kernel.org>, <Frank.Li@kernel.org>,
	<nm@ti.com>, <kristo@kernel.org>, <ssantosh@kernel.org>, <tglx@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <dmaengine@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH 1/2] dma: ti: k3-udma: enable runtime PM support
Date: Wed, 29 Apr 2026 23:19:03 +0530
Message-ID: <20260429174904.4049243-2-r-sharma3@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260429174904.4049243-1-r-sharma3@ti.com>
References: <20260429174904.4049243-1-r-sharma3@ti.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468E:EE_|IA3PR10MB8681:EE_
X-MS-Office365-Filtering-Correlation-Id: 39fd84ce-4d32-46b9-a7af-08dea617a50b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700016|1800799024|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	vngm1h/dAeOQV1ZventSCUAky7adDRuczjAHZAcwgZlonJcBLdOfOnksmFtcgXoGPt0Ep1Af1sipGRy/YcPmfNbjDbtBi+S5WEy1Inms/qSxipEory9Oi1WW6J6n/vHxO3/YfZ09wReygW59NC7uRwubrLMgd9HDr0EDvL4sFFr0VownNzt3mE+Mx9KR6B8gjm4isP/tKrQrClF7zwZahvyh9qKyEUoRyhuYLJNXTpYD9xmjoXQrdMt93RyoUvtuyS7iW62D4lNAyrrQboSnBLwGoaf2rdnDcEzGnG1oFunEwpgdTS6O9BEKa/92RMoNkcWHH/5YoO5rLf+ZlFu9Flgbqx3ffltQs1EVX8moHhqpZJc3vJglRPBQeYDrJi+7feY9N3IxXTwo8mx40Mv9Xj3WUWkKV0OWGUxYob49woGXcklkcvoo9k1OkKPikB4ACF82OXB9WDrMAErrHFTkgwZWbZl2vDLUJWu4NrqoQT3QGsuASSZ4aCs9QCVXdK6jtlK80pkKOv6BmOEXFoM3CqkjfF2x8V+ZU8P3Eh6BL/x6qiQW4BZ6+AZ6DeFwKjqm9767fjbHYxF6n9lxWBevZ/LCXnr7QUZlb0SqNM+zx3+IRGd1Hmz/YY5mER7HQ7gOCaS9rEmcICCtcGxPrX47lH1ed/+5KRSuB96pYGrfFdhQS+nxqrPhXaohVW6QTPBRiMyc33H8lMFOfQuJ8hNltbhX6INmolfj7DSVz/kP038BffZ8xhPtJRZITRENGcfEaoIVpKsU4Vg149y4I+QAtA==
X-Forefront-Antispam-Report:
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	nRv+UnppLgRCLBmMtdH8AM+coO2bsyj4LaZgYvfGtJ2aWNQBfBhsqwwkAHDtmC2LgzuCEspK7hPax55hnpNsdufHFYoUWAHCu1DS26G5AcXZxNFtwnoUCBf8tZZPle1QqLXeWJFbEXVDS0kUDApGG0M9/1aMZfALaxkcr3lQ53kxwhkF4OSbXsNxf7PS7rL2Z6tJEEDKEEMP7sf3reOhG9TQOK8uR3dAWxyemh58FREdODWyBjNQ2hja0WUkagiaD3PCbv0osRGblhZY7gtlm8oSnhPl44HbatVrOtojGX1HiBbUo0vQ2c6TDqw8H+KFJiwnLJCQgVU1yN72AanOxfYo+6sknxEEmD2xi1be9kx6yiwZ4IDltXoYoCCu6kgjpzd/bmdpcFvXmipzJ3+umFUsOBhXRJuyxHEnCMPpJ1yVWAGL5WNQV71vGBEhZLJx
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2026 17:49:21.5458
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 39fd84ce-4d32-46b9-a7af-08dea617a50b
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF0000468E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB8681
X-Rspamd-Queue-Id: 9873D4984B7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[ti.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[ti.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10193-lists,dmaengine=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,ti.com];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[ti.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[r-sharma3@ti.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[dmaengine];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_COUNT_SEVEN(0.00)[10]

Rename udma_pm_suspend/resume to udma_runtime_suspend/resume and
register them as runtime PM callbacks via SET_RUNTIME_PM_OPS. Enable
runtime PM in probe via devm_pm_runtime_enable().

System sleep is handled by reusing the same callbacks via
pm_runtime_force_suspend/resume as late/early sleep ops, keeping the
PM runtime state machine consistent across system sleep transitions.

Hold a runtime PM reference for the lifetime of each allocated channel
(acquired in alloc_chan_resources, released in free_chan_resources) to
ensure the device stays powered while DMA is in use.

Signed-off-by: Rahul Sharma <r-sharma3@ti.com>
---
 drivers/dma/ti/k3-udma.c | 46 +++++++++++++++++++++++++++++++---------
 1 file changed, 36 insertions(+), 10 deletions(-)

diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
index c964ebfcf3b6..47a4d45f4c09 100644
--- a/drivers/dma/ti/k3-udma.c
+++ b/drivers/dma/ti/k3-udma.c
@@ -28,6 +28,7 @@
 #include <linux/soc/ti/ti_sci_inta_msi.h>
 #include <linux/dma/k3-event-router.h>
 #include <linux/dma/ti-cppi5.h>
+#include <linux/pm_runtime.h>
 
 #include "../virt-dma.h"
 #include "k3-udma.h"
@@ -2189,6 +2190,10 @@ static int udma_alloc_chan_resources(struct dma_chan *chan)
 	u32 irq_udma_idx;
 	int ret;
 
+	ret = pm_runtime_resume_and_get(ud->dev);
+	if (ret)
+		return ret;
+
 	uc->dma_dev = ud->dev;
 
 	if (uc->config.pkt_mode || uc->config.dir == DMA_MEM_TO_MEM) {
@@ -2382,6 +2387,7 @@ static int udma_alloc_chan_resources(struct dma_chan *chan)
 		uc->use_dma_pool = false;
 	}
 
+	pm_runtime_put(ud->dev);
 	return ret;
 }
 
@@ -2393,6 +2399,10 @@ static int bcdma_alloc_chan_resources(struct dma_chan *chan)
 	u32 irq_udma_idx, irq_ring_idx;
 	int ret;
 
+	ret = pm_runtime_resume_and_get(ud->dev);
+	if (ret)
+		return ret;
+
 	/* Only TR mode is supported */
 	uc->config.pkt_mode = false;
 
@@ -2412,7 +2422,7 @@ static int bcdma_alloc_chan_resources(struct dma_chan *chan)
 
 		ret = bcdma_alloc_bchan_resources(uc);
 		if (ret)
-			return ret;
+			goto err_res_free;
 
 		irq_ring_idx = uc->bchan->id + oes->bcdma_bchan_ring;
 		irq_udma_idx = uc->bchan->id + oes->bcdma_bchan_data;
@@ -2427,7 +2437,7 @@ static int bcdma_alloc_chan_resources(struct dma_chan *chan)
 		ret = udma_alloc_tx_resources(uc);
 		if (ret) {
 			uc->config.remote_thread_id = -1;
-			return ret;
+			goto err_res_free;
 		}
 
 		uc->config.src_thread = ud->psil_base + uc->tchan->id;
@@ -2447,7 +2457,7 @@ static int bcdma_alloc_chan_resources(struct dma_chan *chan)
 		ret = udma_alloc_rx_resources(uc);
 		if (ret) {
 			uc->config.remote_thread_id = -1;
-			return ret;
+			goto err_res_free;
 		}
 
 		uc->config.src_thread = uc->config.remote_thread_id;
@@ -2463,7 +2473,8 @@ static int bcdma_alloc_chan_resources(struct dma_chan *chan)
 		/* Can not happen */
 		dev_err(uc->ud->dev, "%s: chan%d invalid direction (%u)\n",
 			__func__, uc->id, uc->config.dir);
-		return -EINVAL;
+		ret = -EINVAL;
+		goto err_res_free;
 	}
 
 	/* check if the channel configuration was successful */
@@ -2576,6 +2587,7 @@ static int bcdma_alloc_chan_resources(struct dma_chan *chan)
 		uc->use_dma_pool = false;
 	}
 
+	pm_runtime_put(ud->dev);
 	return ret;
 }
 
@@ -2605,6 +2617,10 @@ static int pktdma_alloc_chan_resources(struct dma_chan *chan)
 	u32 irq_ring_idx;
 	int ret;
 
+	ret = pm_runtime_resume_and_get(ud->dev);
+	if (ret)
+		return ret;
+
 	/*
 	 * Make sure that the completion is in a known state:
 	 * No teardown, the channel is idle
@@ -2622,7 +2638,7 @@ static int pktdma_alloc_chan_resources(struct dma_chan *chan)
 		ret = udma_alloc_tx_resources(uc);
 		if (ret) {
 			uc->config.remote_thread_id = -1;
-			return ret;
+			goto err_res_free;
 		}
 
 		uc->config.src_thread = ud->psil_base + uc->tchan->id;
@@ -2641,7 +2657,7 @@ static int pktdma_alloc_chan_resources(struct dma_chan *chan)
 		ret = udma_alloc_rx_resources(uc);
 		if (ret) {
 			uc->config.remote_thread_id = -1;
-			return ret;
+			goto err_res_free;
 		}
 
 		uc->config.src_thread = uc->config.remote_thread_id;
@@ -2656,7 +2672,8 @@ static int pktdma_alloc_chan_resources(struct dma_chan *chan)
 		/* Can not happen */
 		dev_err(uc->ud->dev, "%s: chan%d invalid direction (%u)\n",
 			__func__, uc->id, uc->config.dir);
-		return -EINVAL;
+		ret = -EINVAL;
+		goto err_res_free;
 	}
 
 	/* check if the channel configuration was successful */
@@ -2745,6 +2762,7 @@ static int pktdma_alloc_chan_resources(struct dma_chan *chan)
 	dma_pool_destroy(uc->hdesc_pool);
 	uc->use_dma_pool = false;
 
+	pm_runtime_put(ud->dev);
 	return ret;
 }
 
@@ -4123,6 +4141,8 @@ static void udma_free_chan_resources(struct dma_chan *chan)
 		dma_pool_destroy(uc->hdesc_pool);
 		uc->use_dma_pool = false;
 	}
+
+	pm_runtime_put(ud->dev);
 }
 
 static struct platform_driver udma_driver;
@@ -5644,6 +5664,11 @@ static int udma_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, ud);
 
+	/* Enable runtime PM */
+	ret = devm_pm_runtime_enable(dev);
+	if (ret)
+		return ret;
+
 	ret = of_dma_controller_register(dev->of_node, udma_of_xlate, ud);
 	if (ret) {
 		dev_err(dev, "failed to register of_dma controller\n");
@@ -5653,7 +5678,7 @@ static int udma_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int __maybe_unused udma_pm_suspend(struct device *dev)
+static int udma_runtime_suspend(struct device *dev)
 {
 	struct udma_dev *ud = dev_get_drvdata(dev);
 	struct dma_device *dma_dev = &ud->ddev;
@@ -5675,7 +5700,7 @@ static int __maybe_unused udma_pm_suspend(struct device *dev)
 	return 0;
 }
 
-static int __maybe_unused udma_pm_resume(struct device *dev)
+static int udma_runtime_resume(struct device *dev)
 {
 	struct udma_dev *ud = dev_get_drvdata(dev);
 	struct dma_device *dma_dev = &ud->ddev;
@@ -5701,7 +5726,8 @@ static int __maybe_unused udma_pm_resume(struct device *dev)
 }
 
 static const struct dev_pm_ops udma_pm_ops = {
-	SET_LATE_SYSTEM_SLEEP_PM_OPS(udma_pm_suspend, udma_pm_resume)
+	SET_LATE_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend, pm_runtime_force_resume)
+	SET_RUNTIME_PM_OPS(udma_runtime_suspend, udma_runtime_resume, NULL)
 };
 
 static struct platform_driver udma_driver = {
-- 
2.34.1


