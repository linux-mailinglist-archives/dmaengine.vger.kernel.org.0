Return-Path: <dmaengine+bounces-8611-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SFXJAmuRfGkQNwIAu9opvQ
	(envelope-from <dmaengine+bounces-8611-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 30 Jan 2026 12:09:31 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BD45DB9D3E
	for <lists+dmaengine@lfdr.de>; Fri, 30 Jan 2026 12:09:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 106653096D36
	for <lists+dmaengine@lfdr.de>; Fri, 30 Jan 2026 11:04:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BF8937AA92;
	Fri, 30 Jan 2026 11:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="foLBaQgC"
X-Original-To: dmaengine@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013003.outbound.protection.outlook.com [40.107.201.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6D2E378D97;
	Fri, 30 Jan 2026 11:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769771028; cv=fail; b=iDSHH+wJ6YCVacF4YFH3GB+dP5s619UV1kiL/C20wdc3JKtqI2/K9w8Xx4T0M4Zxds1c0IMkM+iTY6LYpdXHGrvv9fixOCf4rihS/9titBMYcRKMaP+DtVbGUF7fufkjQsLS8wMCBR0zA2D/aiQ5WeIjGhTAAVhC1gu3bl8Uggw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769771028; c=relaxed/simple;
	bh=vmw8Njeqlkv9k8MgwdDoZo5VDNP1gcWvzv7n2ilzS30=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PTsuoM3e9hdhhE9WvJha3r2+hX+2iNKfqS5zt3wAu/cNVIdXRGNaKrTYP/AnGEIZo9k4hAUNt24ERPuBbyNbPGAp5auzI0locJ9jzmMJqj7MFk6aBfHGOw0E+X9QRLW2aP6LBNkigdRoxHv89rHpAuqegUUBdsxqmUBVUDqKQnM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=foLBaQgC; arc=fail smtp.client-ip=40.107.201.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QZP/sxLYKJ/q58oXZicWCG0Jv1U8wP7LRGqxTqakAxcEl3ju+BIg/2U1ECEX3CLF+CBkj/pOASk8SqcCf/Gkmm7oMK8BPfGwoFt5WTfKjCfhOZiRDvPGZeeFDn5iZ7VBgqFECXUFrCDDdSSFmA7dfMF5MGlz+oJ4jkltoqEPVkv1XbFg2Frr9vi3R49kftxVs9SDLUGX2OY3fVC22OA6E9lXZ9UtU/vnizpTZCMXVRuNIVGf9AvH4TN3mj65pEv9StDbCwgUKls+hI3SnJcQfxHhr8ortCXWooStFxKKJY3ZFklQgUcpg1r7BUGoyVk0BK3sLRS2hV2DbxhSuIFaDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CmFagWQxUJk0LPa4cC04Tg1Y/5eSP0Y9cYWw1vU4MjE=;
 b=aSWObiPKBr9wyVFHEOvr71gwVILtlqgc0O4ywP+oxh0tu2Z3PfwtKwhxrQ2s9AOkt94AMx1EebxRjq17FRslikT39qYN8sUfTdpLkgaNUyaTTSHSkSv7Yaxpr98qbsLydkw4YWjIVzu7UHqAoEQq5vcP26LP2PLjcMfvrEArssecOjITXp/lAVCRl/jNX0ung8SD+G8c0dE1eDg06+mE0uSkv/ACWBsXHjZAFeToE594Fvu9lr5rymSKL2mHRFmUtypZPffN+enE9EOCXN4JHal0VIhlKwFL2ywTjc/icypAw9lS8D6zpqtkoj3oNYYmMMQKvYWhpR83NrXFrRCAFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CmFagWQxUJk0LPa4cC04Tg1Y/5eSP0Y9cYWw1vU4MjE=;
 b=foLBaQgCzFibMeEK+ZMV1iVx77jVA7TKqHGeKdtXI5kAfTUR9fBvx9pNxPwlz9fFzDRsBBUIJeMF1Vy9rTHmHLBA12W2OyeR1LwEQKzJ8kECMIykA1pwaq0p7M/CkJ6eQLA637WnYq2pUIa1BnjvCqSa3tdH6MFbcwMypX/NE9U=
Received: from SA1P222CA0096.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:35e::23)
 by DS0PR10MB7049.namprd10.prod.outlook.com (2603:10b6:8:14b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.12; Fri, 30 Jan
 2026 11:03:44 +0000
Received: from SA2PEPF000015CD.namprd03.prod.outlook.com
 (2603:10b6:806:35e:cafe::e6) by SA1P222CA0096.outlook.office365.com
 (2603:10b6:806:35e::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.8 via Frontend Transport; Fri,
 30 Jan 2026 11:03:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 SA2PEPF000015CD.mail.protection.outlook.com (10.167.241.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Fri, 30 Jan 2026 11:03:44 +0000
Received: from DLEE206.ent.ti.com (157.170.170.90) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 30 Jan
 2026 05:03:44 -0600
Received: from DLEE204.ent.ti.com (157.170.170.84) by DLEE206.ent.ti.com
 (157.170.170.90) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 30 Jan
 2026 05:03:44 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE204.ent.ti.com
 (157.170.170.84) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 30 Jan 2026 05:03:44 -0600
Received: from uda0498651.dhcp.ti.com (uda0498651.dhcp.ti.com [172.24.233.239])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 60UB2HBw1204392;
	Fri, 30 Jan 2026 05:03:40 -0600
From: Sai Sree Kartheek Adivi <s-adivi@ti.com>
To: <peter.ujfalusi@gmail.com>, <vkoul@kernel.org>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <nm@ti.com>,
	<ssantosh@kernel.org>, <dmaengine@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <vigneshr@ti.com>, <s-adivi@ti.com>
CC: <r-sharma3@ti.com>, <gehariprasath@ti.com>
Subject: [PATCH v4 19/19] dmaengine: ti: k3-udma: switch to synchronous descriptor freeing
Date: Fri, 30 Jan 2026 16:31:59 +0530
Message-ID: <20260130110159.359501-20-s-adivi@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260130110159.359501-1-s-adivi@ti.com>
References: <20260130110159.359501-1-s-adivi@ti.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CD:EE_|DS0PR10MB7049:EE_
X-MS-Office365-Filtering-Correlation-Id: 792fa5a5-7d99-4a35-30db-08de5fef3c52
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|7416014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?80l4xrFt9+4Q0QHdLdkDXNjHCOykCz3AlRT1HtVYA3of0T5QKiSncaOU+IBt?=
 =?us-ascii?Q?he9WsRFoBPkV7hYKm7eNNv6zshWQ9ASuZ9nEdXfrhb56Ke2P8ZHiuVIb6BRR?=
 =?us-ascii?Q?UQp74v7of6VsgUMImTP5jGpKJQ/v+/cERYCZEoDYL2AtJwPpIFS9y5u9l3YH?=
 =?us-ascii?Q?xTRJMZlYyVKWSpya+QqDuhNqd7ec8aHzQtXdRGPU4XPCCZCmDwn+bS2V6WjG?=
 =?us-ascii?Q?/6c6Z+Q8/F3n/2BAQIbdyCEyw69CRlp+UEecft7nEp1mdnDsDbYUFHZ5KTvr?=
 =?us-ascii?Q?6wQcovKw8Z3VyRrRB02Xk3lttIqmfztx47rm1kEO3MGnvWnHXeWY+94bUBNS?=
 =?us-ascii?Q?0qBbdbJvq1CDEPBYAmjmt6Yoj8N4d3DOlWlLGOco2VEKG0E9/4Ipc9adg4Nl?=
 =?us-ascii?Q?GBqiS8p5zQedtWhFabosHAax7AfsS3WvPEDcGf7OQL6DnpWZBpORDoOwmaeM?=
 =?us-ascii?Q?nJho3hGLX26uZLWEIsf9yYomWHlZGW3tmld7tAFQVYHWznF9nM0xviFWRVfR?=
 =?us-ascii?Q?HuiRtvCrVNOvQ+MXTGHDo95N8fScMwjR2WhLoiqXtRnKIv+UiuAC/ZrVMQbe?=
 =?us-ascii?Q?bjvR+SeA80TwXyFoEQufcsma2JtkM/zsNY0cIyI5JVpL9Z+x0200Jr9vyfVB?=
 =?us-ascii?Q?ZItJVLrf2o4IcoXUI+8dGDIgBvK7bOh2hLBQXhJXr7ZvpmrlPKEhVsGtcwSp?=
 =?us-ascii?Q?JqOoYT5Rr1QyLNbPi5e3vSaGzLamuQ7hLxa7+5GByshhdPEH4aTdjScjIe4N?=
 =?us-ascii?Q?ANC1kk+u1q1KLSZhw/eckPIEciQhNKfH8HF08CNErBvbumdcBfdjH+5ft3DI?=
 =?us-ascii?Q?+rWM70s8OQ0tG737aoisMoRFZOtKwYsPnO+lTQ5zNwl3bwcysWzC2/isCSpw?=
 =?us-ascii?Q?WJc1og03FC400Ka8L91TngOx1yOuRDTIeHkXS14Pa4tqAfNLgZEQzCFOzhPY?=
 =?us-ascii?Q?l33KtZd0iZrKIgT8qMThF3i3W4T3XO/cuOHXHUv8NTBP1HMnEphclqe7AQJ/?=
 =?us-ascii?Q?HkaAGn5o63n2oU1YWHplhaRwmzUPRe8tHsN0w6D6W2TyDmLVaJFPwZGXkEpJ?=
 =?us-ascii?Q?W/UXA+bDEbXbcbLFSHspJLYk2WSuIgd81G8Ccr5697wPHScfFNWLj/kECE20?=
 =?us-ascii?Q?KgjiNH/xeB/lbpiYIjtcK5tdMGypQJ9ngLHrbbe7l/AnMJ2yshy1cEMKRx9O?=
 =?us-ascii?Q?olJgplyfK32imfS6cV6w9qJPsetOCXV6rL5hLLSrJMAyp7T0xrWkQQw3z4tv?=
 =?us-ascii?Q?h28hRO8Mxs+4pT+WjY9sQixzsKAChFqfbOdSUyFFWGh78G74Yp2OIHlACIvq?=
 =?us-ascii?Q?/X8Z5TI29YzPeyPlASMS81uStlvy6VFEjTyoz4jh54KeADBrToAkvysv1SA0?=
 =?us-ascii?Q?M5Z8TxMGuTAt/FxygWkOMmU82jc/bBkRInaYvnQAjxxV8tXdZkUMynIVC+qs?=
 =?us-ascii?Q?XhHAyNwRzH8AZOqQmK0sy77IwhoZkeGxLFml/k1Bg3Xcu+KoVpxuv9AUWvK8?=
 =?us-ascii?Q?ey9Un9kSSki/YDJ1tPRhCrXpkC7gFLozycGD96QkDxrCHjsYFayuofYtMiRS?=
 =?us-ascii?Q?VaIdh9UfSlB+dFyJQ/J1SmMxksdTe6bwnkBnWK1jmtPpCahSuYbZOmvVrTri?=
 =?us-ascii?Q?2aozaaVU5XwLIgA6eW6PTG/zH+k/fKBSPS5G/vQk6j70TEoVJ9Wudd/HlXu9?=
 =?us-ascii?Q?2qTyRrO+oanWJmhNwhZ2OqOOPjA=3D?=
X-Forefront-Antispam-Report:
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(7416014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	dqn/XIyF0sDckTSiqIcjRRWuC8hKQXUI1ggfBBauLbYcyyLL1+7t6mqspOnFsiyVuWMJH2qN9zOt3iHlh6g096BC8tdue11dsNO4ezJj5Q7GWAgLdZY2z+TtC5JhtUTMtHMQnWCJmhur9asmBe+uD1R1bKAOhEhQQo/SloUTCsmgXPd7nQ90pTGVUlEh8Q7XHsJzhHDvXDRNfgV7AA1eDp1gDyHcV7m/1/OSflCCTW70H5+uq21gIrpDbfAyOBFBZSfTw9NWlcq4On6Z+yjQFGPyowYoQECAnp71kVwT8yfiXDhp8cmSGZTUdD39tdiZIcrRmYsGXEm0Rq8t9SW/WK3Aq3ZqeikGQ8Gx4L0U81h1+oSLkhOnGa27CjB5P7t8s1HP/g9CVNJhkvsQR2S9+gGKGRymrWEPUCg9UJmEJ38B+EWQxK6+XggD2Lw+lKJ5
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2026 11:03:44.6338
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 792fa5a5-7d99-4a35-30db-08de5fef3c52
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015CD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7049
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[ti.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[ti.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8611-lists,dmaengine=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,ti.com,vger.kernel.org,lists.infradead.org];
	DKIM_TRACE(0.00)[ti.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[15];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[s-adivi@ti.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,ti.com:email,ti.com:dkim,ti.com:mid];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: BD45DB9D3E
X-Rspamd-Action: no action

The driver currently uses a worker thread to free processed
descriptors. Under high load (e.g., CRYPTO_MANAGER_EXTRA_TESTS), the
descriptor allocation rate can significantly outpace the worker
thread's execution rate.

This leads to false resource exhaustion where dma_alloc_coherent()
fails even though many descriptors are waiting in the purge queue to
be freed.

Remove the lazy freeing mechanism (desc_to_purge list and worker) and
instead free the descriptors immediately in the completion callback.

This eliminates the latency gap between hardware completion and
software reclaim, preventing the pool exhaustion during stress tests.

Signed-off-by: Sai Sree Kartheek Adivi <s-adivi@ti.com>
---
 drivers/dma/ti/k3-udma-common.c | 40 +++------------------------------
 drivers/dma/ti/k3-udma-v2.c     |  2 --
 drivers/dma/ti/k3-udma.c        |  2 --
 drivers/dma/ti/k3-udma.h        |  3 ---
 4 files changed, 3 insertions(+), 44 deletions(-)

diff --git a/drivers/dma/ti/k3-udma-common.c b/drivers/dma/ti/k3-udma-common.c
index 05b2b6b962a06..f9da00298b60f 100644
--- a/drivers/dma/ti/k3-udma-common.c
+++ b/drivers/dma/ti/k3-udma-common.c
@@ -95,32 +95,6 @@ void udma_free_hwdesc(struct udma_chan *uc, struct udma_desc *d)
 	}
 }
 
-void udma_purge_desc_work(struct work_struct *work)
-{
-	struct udma_dev *ud = container_of(work, typeof(*ud), purge_work);
-	struct virt_dma_desc *vd, *_vd;
-	unsigned long flags;
-	LIST_HEAD(head);
-
-	spin_lock_irqsave(&ud->lock, flags);
-	list_splice_tail_init(&ud->desc_to_purge, &head);
-	spin_unlock_irqrestore(&ud->lock, flags);
-
-	list_for_each_entry_safe(vd, _vd, &head, node) {
-		struct udma_chan *uc = to_udma_chan(vd->tx.chan);
-		struct udma_desc *d = to_udma_desc(&vd->tx);
-
-		udma_free_hwdesc(uc, d);
-		list_del(&vd->node);
-		kfree(d);
-	}
-
-	/* If more to purge, schedule the work again */
-	if (!list_empty(&ud->desc_to_purge))
-		schedule_work(&ud->purge_work);
-}
-EXPORT_SYMBOL_GPL(udma_purge_desc_work);
-
 void udma_desc_free(struct virt_dma_desc *vd)
 {
 	struct udma_dev *ud = to_udma_dev(vd->tx.chan->device);
@@ -131,17 +105,9 @@ void udma_desc_free(struct virt_dma_desc *vd)
 	if (uc->terminated_desc == d)
 		uc->terminated_desc = NULL;
 
-	if (uc->use_dma_pool) {
-		udma_free_hwdesc(uc, d);
-		kfree(d);
-		return;
-	}
-
-	spin_lock_irqsave(&ud->lock, flags);
-	list_add_tail(&vd->node, &ud->desc_to_purge);
-	spin_unlock_irqrestore(&ud->lock, flags);
-
-	schedule_work(&ud->purge_work);
+	udma_free_hwdesc(uc, d);
+	kfree(d);
+	return;
 }
 EXPORT_SYMBOL_GPL(udma_desc_free);
 
diff --git a/drivers/dma/ti/k3-udma-v2.c b/drivers/dma/ti/k3-udma-v2.c
index 6761a079025ba..d33382cc0356a 100644
--- a/drivers/dma/ti/k3-udma-v2.c
+++ b/drivers/dma/ti/k3-udma-v2.c
@@ -1320,14 +1320,12 @@ static int udma_v2_probe(struct platform_device *pdev)
 	ud->psil_base = ud->match_data->psil_base;
 
 	INIT_LIST_HEAD(&ud->ddev.channels);
-	INIT_LIST_HEAD(&ud->desc_to_purge);
 
 	ch_count = setup_resources(ud);
 	if (ch_count <= 0)
 		return ch_count;
 
 	spin_lock_init(&ud->lock);
-	INIT_WORK(&ud->purge_work, udma_purge_desc_work);
 
 	ud->desc_align = 64;
 	if (ud->desc_align < dma_get_cache_alignment())
diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
index a8d01d955651a..34d458b4a0dbc 100644
--- a/drivers/dma/ti/k3-udma.c
+++ b/drivers/dma/ti/k3-udma.c
@@ -2704,14 +2704,12 @@ static int udma_probe(struct platform_device *pdev)
 	ud->psil_base = ud->match_data->psil_base;
 
 	INIT_LIST_HEAD(&ud->ddev.channels);
-	INIT_LIST_HEAD(&ud->desc_to_purge);
 
 	ch_count = setup_resources(ud);
 	if (ch_count <= 0)
 		return ch_count;
 
 	spin_lock_init(&ud->lock);
-	INIT_WORK(&ud->purge_work, udma_purge_desc_work);
 
 	ud->desc_align = 64;
 	if (ud->desc_align < dma_get_cache_alignment())
diff --git a/drivers/dma/ti/k3-udma.h b/drivers/dma/ti/k3-udma.h
index 3ae2400e67990..67de9feb9906b 100644
--- a/drivers/dma/ti/k3-udma.h
+++ b/drivers/dma/ti/k3-udma.h
@@ -353,8 +353,6 @@ struct udma_dev {
 
 	struct k3_ringacc *ringacc;
 
-	struct work_struct purge_work;
-	struct list_head desc_to_purge;
 	spinlock_t lock;
 
 	struct udma_rx_flush rx_flush;
@@ -596,7 +594,6 @@ static inline void udma_fetch_epib(struct udma_chan *uc, struct udma_desc *d)
 struct udma_desc *udma_udma_desc_from_paddr(struct udma_chan *uc,
 					    dma_addr_t paddr);
 void udma_free_hwdesc(struct udma_chan *uc, struct udma_desc *d);
-void udma_purge_desc_work(struct work_struct *work);
 void udma_desc_free(struct virt_dma_desc *vd);
 bool udma_desc_is_rx_flush(struct udma_chan *uc, dma_addr_t addr);
 bool udma_is_desc_really_done(struct udma_chan *uc, struct udma_desc *d);
-- 
2.34.1


