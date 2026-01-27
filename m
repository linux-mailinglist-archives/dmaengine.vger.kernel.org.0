Return-Path: <dmaengine+bounces-8542-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OKOUEvQNeWmHuwEAu9opvQ
	(envelope-from <dmaengine+bounces-8542-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 27 Jan 2026 20:11:48 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C7EAD99AEB
	for <lists+dmaengine@lfdr.de>; Tue, 27 Jan 2026 20:11:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6D271300B741
	for <lists+dmaengine@lfdr.de>; Tue, 27 Jan 2026 19:11:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25848366078;
	Tue, 27 Jan 2026 19:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="IMZdx4tZ"
X-Original-To: dmaengine@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010062.outbound.protection.outlook.com [52.101.56.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77C5E366809;
	Tue, 27 Jan 2026 19:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769541081; cv=fail; b=RgW6zGLcqJhX9/z193RCh4F05BIp+RRqw5RaOam5LSNPx5EgPlphckuFXgrb+3pGtSScssS8f1kz/KpH5tkj0VJOvl6YYdGoOocUYPwAwn1q4ft/5qD41+h4RusSyGd2qGcGa/GKlwkem7V9m0038QOSbLse69A2VBIxslUUWo4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769541081; c=relaxed/simple;
	bh=ztaFuYBAFMzvMtgW6JJKnBwBmMuwch5BZy6w7GRFrPM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MlFyUVVtMLGbYsMGN1v4N+MDL9buHSlil3cfgAjXEEE0pcftaxBd+P2jEXkC1KKHfwfMd9sjtb+wKrK4oo/buK0VTm5NRO0T9UOgBbD5Qzf5yMhQfn+0g91L+v3ymHPgeb+ttwaJiEJdsk5yADhS11PtFOUwtT2RMteWNgvF3cw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=IMZdx4tZ; arc=fail smtp.client-ip=52.101.56.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XBJt/Wr+8gZrKUHIwDuJvUQ7wTuTu6763COM43MbuG329rb7xIJpy+Zw5W6elTIHMZSxl/R5EblBLY+Pcc/uZf5qNmAkjCLnqA4tPwhIAQqomzB0y6ysgfwaTOyH9RADVI9lupRzSh0myIuRRCe5HwwQP7IZ2wokT8mSNoNvZZggXwS1dg3CKI0bFKDS6tJTn/GhUhG+rmo+xlC30VE3XXo8PYwzt35NFPvShbPXrUWenb3i6W6BbwDg9yiET9j9wOKmvc43qv8r8ocWbVtx1JzvdLlfopvEU2ujnP3gdHQDCrNhwrvvuI4nKQ/z9ElEpJTS0xj7AH7GdOl5sDjC2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/cAGxIi3lQlZovHYD6wmJzJ2mDiEEoF2dfH6yaVu25s=;
 b=SvkfflPQeh70wZi/IBobvbNztSaZPG3B6EbeT1afu8qO7P79Weuf944hzm0xdbvdM2mSKmSz2krdSkcFyDsWmuEfabYU8Wv9eGWnC40mEIwUkzClzQbUeDsqryq6ZifTVDR9S9069ZyRLBBY7u/u/Z5pgAZASKenqlIKNa4JOo/4uEE0muW9qAHKpPFH1+1eJwYQOE3Kd4X/2keyvHdtWpEPxDbD0ktdbRUmCiuIuFD0p239wef8dYmrLfFFKbqy4+c1G8EHvzKu/sLmeMh275dZfN+gacv7YIdZ6p6p1mBvZocbhJ0oliZyy/CKo9SFwh1+M8VRP1T7+blWhot+iQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/cAGxIi3lQlZovHYD6wmJzJ2mDiEEoF2dfH6yaVu25s=;
 b=IMZdx4tZ0cMqT/6RkEshasg4YOq/KMKOJaYKBAqSD3qoBJqO7FmGY4hjfLQ+B7KlR6EwfOnmhNdnbRl2V4GWjL0WNAaex3fwGHDWs6Xc41Nd9TlJ+5a+e8FVH6iTXVL7WrRxNyxtwKkbBeFuh2ADY70jbBQcbHaczaPQDuduf/0=
Received: from CH0PR03CA0359.namprd03.prod.outlook.com (2603:10b6:610:11a::19)
 by DS0PR10MB7319.namprd10.prod.outlook.com (2603:10b6:8:fd::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Tue, 27 Jan
 2026 19:11:13 +0000
Received: from CH1PEPF0000AD80.namprd04.prod.outlook.com
 (2603:10b6:610:11a:cafe::4f) by CH0PR03CA0359.outlook.office365.com
 (2603:10b6:610:11a::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.7 via Frontend Transport; Tue,
 27 Jan 2026 19:11:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 CH1PEPF0000AD80.mail.protection.outlook.com (10.167.244.90) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Tue, 27 Jan 2026 19:11:11 +0000
Received: from DLEE200.ent.ti.com (157.170.170.75) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 27 Jan
 2026 13:11:11 -0600
Received: from DLEE210.ent.ti.com (157.170.170.112) by DLEE200.ent.ti.com
 (157.170.170.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 27 Jan
 2026 13:11:11 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE210.ent.ti.com
 (157.170.170.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 27 Jan 2026 13:11:10 -0600
Received: from uda0498651.dhcp.ti.com (uda0498651.dhcp.ti.com [172.24.233.239])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 60RJB8lu1011804;
	Tue, 27 Jan 2026 13:11:08 -0600
From: Sai Sree Kartheek Adivi <s-adivi@ti.com>
To: <stable@vger.kernel.org>
CC: <s-vadapalli@ti.com>, <peter.ujfalusi@gmail.com>, <vkoul@kernel.org>,
	<dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <vigneshr@ti.com>
Subject: [PATCH 6.12.y] dmaengine: ti: k3-udma: Enable second resource range for BCDMA and PKTDMA
Date: Wed, 28 Jan 2026 00:41:05 +0530
Message-ID: <20260127191105.1961020-1-s-adivi@ti.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD80:EE_|DS0PR10MB7319:EE_
X-MS-Office365-Filtering-Correlation-Id: 9047ceb4-4760-4970-16e2-08de5dd7d5bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Xf9kUDxr+2ixO6xvDFC6D2krb84pgczWRHMw8yZDmvJssUOg5MFpS43WFKpS?=
 =?us-ascii?Q?R/fB6miGVr/omu/Yzs0onsCtumnvlaPEHfXjx75JCEJwXi6zx+YXYH14/U7H?=
 =?us-ascii?Q?Iw7skx6u9duDIDYONTrrWeEkhuoDNZqx4hDvwYqBtjFnn9dZjCjC8Hwfq6WO?=
 =?us-ascii?Q?hjiCpwbINTbTqdWzN0zQAsTmU1FMf/ULLRw+8wniQaADIyQb3rPIqrfRX/BS?=
 =?us-ascii?Q?wBxtwNUFZ+Bp1xQQnEQA/8mitA6rXDEvmW+jDSdjgbrUiXoqutbQxtPG5Lix?=
 =?us-ascii?Q?oT2HetxieH9Jx7x7u3i+XQIIDakAnHT/b2CapvmeAhEMr/4v+ZtlLx6thWT7?=
 =?us-ascii?Q?dOJ9iVjKdA4y65hFIGZu6apZ3/q9Zx9j5nNn5HaCsyklGT+D4Y3WY4x/4jit?=
 =?us-ascii?Q?FnDl1p1UPpgdQJORo1wjb/xvzhhR65nggoEx9EbZJmQIA/j3x2j9t3+2bzPg?=
 =?us-ascii?Q?odEkr+fZdJNPyzVqeM5vlr/mcRZLunFccAUu/QW8pSx2kRSO52OwWbGr4F4x?=
 =?us-ascii?Q?sRu4WGPnlGK5foqbdO/rHwJG0Te5t9A6UHY7QejQfQlZ+Ezjt8B9tbt2AJkG?=
 =?us-ascii?Q?I9e4NHNcArU5N5fgTW8HkqguHjT6u2A1oZSZ9dQjh+q6sQNasD85GJb6ZKBY?=
 =?us-ascii?Q?UenZQZJ8sxayAChziwLIlQIRm3NUCpsDapS1TOs0g+kZ7jJGrkBDNgYJp3d9?=
 =?us-ascii?Q?eCBieEOJg/PVxgRDsE3s6etfzcZzrzXEH2WK6PAtIdKjFRNMqjz4npv3qhD3?=
 =?us-ascii?Q?dG6LXKTqBTG2210OEfjzi7Iu03Z4vR+1nM7W67Y3jsf4xupeNPo/ewBa4FeR?=
 =?us-ascii?Q?bGIAwuziFn+3JZEFzCPATwlUL0xiG8OrzbqhSVADjoHUJ4NPHAKWlQ4g04ws?=
 =?us-ascii?Q?86D0UQUKetbn0BUGl7G7CXSFZ2Soe6kWMkoEfMhvj/+J36z7x2QlzK4OEEpM?=
 =?us-ascii?Q?N1+dKcchOhEsxOORK0ur/1t7y+KxzoX6R7a9aNGqLzIFPsF/GVgJOhQ4wmzX?=
 =?us-ascii?Q?LSA7hfm55/7aht3NujXonmu95pqX9Dx3MyEdxLBWV+39hWxZk9JcHPVZ6sEt?=
 =?us-ascii?Q?iMT0sSHaXU3viy3hQMl2UcUtZKskqxZ7gnYAYHS2M0wNo/qevfytHt+SGesG?=
 =?us-ascii?Q?aQ5Qh1qqYkbbzkPQvcGOqHhvU6psE5327pmHuAPoO0UkAe1tETk8+CoS/p5F?=
 =?us-ascii?Q?9LnNWk3ycWiuptXc4iGuzLl9+TIOxy6ds/TmLbi8wNw+8RqadVZcp1RCy9Kr?=
 =?us-ascii?Q?LIRLWH7P/JIDRtTT4S3J8GmhjZCxl1Acv8RTYYBHXBm/vNsidwDUwKczsiBG?=
 =?us-ascii?Q?PRrpmF5FCAK3l3rhDdmZeOpatL+KecYJ8ocK/ewdJ4st8mhaUeotf1RsNy+I?=
 =?us-ascii?Q?hcv1kdGfpNkAr6pzDXxe7oxOSdPgfLcDBn8CUwkhlnFsq9A5bggiteYP0cBB?=
 =?us-ascii?Q?9Kb27Tnaz/6E2U8CAxbzs2mS/AuA1CLxXrsQ2Mgk7P137M1X8dU50zoJrecG?=
 =?us-ascii?Q?VUM2Fe4eO+SL7rcxBRJ0K0u5Sw7fPrjsGft6URv3ym98912Woi/vRrAaZGDv?=
 =?us-ascii?Q?WIx1Qgj80/E9zaM4KBOWPHDefQGdR9flRD6/ZtymJKHdKGzJDE1ghMc4AAEp?=
 =?us-ascii?Q?f0/9FmHVCBQa1a663oEUG0pCLeVf24J5kLUhC9hDuzEfMMU+JzKZJiOjgYPl?=
 =?us-ascii?Q?GI/KTySSdts7WsbIUv/FzJwjg+I=3D?=
X-Forefront-Antispam-Report:
	CIP:198.47.23.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet200.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2026 19:11:11.7481
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9047ceb4-4760-4970-16e2-08de5dd7d5bc
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.194];Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD80.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7319
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[ti.com,quarantine];
	R_DKIM_ALLOW(-0.20)[ti.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8542-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[ti.com,gmail.com,kernel.org,vger.kernel.org,lists.infradead.org];
	DKIM_TRACE(0.00)[ti.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[s-adivi@ti.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ti.com:email,ti.com:dkim,ti.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[dmaengine];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: C7EAD99AEB
X-Rspamd-Action: no action

From: Siddharth Vadapalli <s-vadapalli@ti.com>

commit 566beb347eded7a860511164a7a163bc882dc4d0 upstream.

The SoC DMA resources for UDMA, BCDMA and PKTDMA can be described via a
combination of up to two resource ranges. The first resource range handles
the default partitioning wherein all resources belonging to that range are
allocated to a single entity and form a continuous range. For use-cases
where the resources are shared across multiple entities and require to be
described via discontinuous ranges, a second resource range is required.

Currently, udma_setup_resources() supports handling resources that belong
to the second range. Extend bcdma_setup_resources() and
pktdma_setup_resources() to support the same.

Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
Acked-by: Peter Ujfalusi <peter.ujfalusi@gmail.com>
Link: https://lore.kernel.org/r/20250205121805.316792-1-s-vadapalli@ti.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Tested-by: Sai Sree Kartheek Adivi <s-adivi@ti.com>
Signed-off-by: Sai Sree Kartheek Adivi <s-adivi@ti.com>
---

Hi,

This patch is upstreamed at [1]. This is required for ethernet to be
functional on TI AM62P SoC.

Thanks,
Kartheek

[1] v6.14-rc1-24-g566beb347ede
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/drivers/dma/ti/k3-udma.c?id=566beb347eded7a860511164a7a163bc882dc4d0

 drivers/dma/ti/k3-udma.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
index 38b54719587cf..e877cd50898bc 100644
--- a/drivers/dma/ti/k3-udma.c
+++ b/drivers/dma/ti/k3-udma.c
@@ -4876,6 +4876,12 @@ static int bcdma_setup_resources(struct udma_dev *ud)
 				irq_res.desc[i].start = rm_res->desc[i].start +
 							oes->bcdma_bchan_ring;
 				irq_res.desc[i].num = rm_res->desc[i].num;
+
+				if (rm_res->desc[i].num_sec) {
+					irq_res.desc[i].start_sec = rm_res->desc[i].start_sec +
+									oes->bcdma_bchan_ring;
+					irq_res.desc[i].num_sec = rm_res->desc[i].num_sec;
+				}
 			}
 		}
 	} else {
@@ -4899,6 +4905,15 @@ static int bcdma_setup_resources(struct udma_dev *ud)
 				irq_res.desc[i + 1].start = rm_res->desc[j].start +
 							oes->bcdma_tchan_ring;
 				irq_res.desc[i + 1].num = rm_res->desc[j].num;
+
+				if (rm_res->desc[j].num_sec) {
+					irq_res.desc[i].start_sec = rm_res->desc[j].start_sec +
+									oes->bcdma_tchan_data;
+					irq_res.desc[i].num_sec = rm_res->desc[j].num_sec;
+					irq_res.desc[i + 1].start_sec = rm_res->desc[j].start_sec +
+									oes->bcdma_tchan_ring;
+					irq_res.desc[i + 1].num_sec = rm_res->desc[j].num_sec;
+				}
 			}
 		}
 	}
@@ -4919,6 +4934,15 @@ static int bcdma_setup_resources(struct udma_dev *ud)
 				irq_res.desc[i + 1].start = rm_res->desc[j].start +
 							oes->bcdma_rchan_ring;
 				irq_res.desc[i + 1].num = rm_res->desc[j].num;
+
+				if (rm_res->desc[j].num_sec) {
+					irq_res.desc[i].start_sec = rm_res->desc[j].start_sec +
+									oes->bcdma_rchan_data;
+					irq_res.desc[i].num_sec = rm_res->desc[j].num_sec;
+					irq_res.desc[i + 1].start_sec = rm_res->desc[j].start_sec +
+									oes->bcdma_rchan_ring;
+					irq_res.desc[i + 1].num_sec = rm_res->desc[j].num_sec;
+				}
 			}
 		}
 	}
@@ -5053,6 +5077,12 @@ static int pktdma_setup_resources(struct udma_dev *ud)
 			irq_res.desc[i].start = rm_res->desc[i].start +
 						oes->pktdma_tchan_flow;
 			irq_res.desc[i].num = rm_res->desc[i].num;
+
+			if (rm_res->desc[i].num_sec) {
+				irq_res.desc[i].start_sec = rm_res->desc[i].start_sec +
+								oes->pktdma_tchan_flow;
+				irq_res.desc[i].num_sec = rm_res->desc[i].num_sec;
+			}
 		}
 	}
 	rm_res = tisci_rm->rm_ranges[RM_RANGE_RFLOW];
@@ -5064,6 +5094,12 @@ static int pktdma_setup_resources(struct udma_dev *ud)
 			irq_res.desc[i].start = rm_res->desc[j].start +
 						oes->pktdma_rchan_flow;
 			irq_res.desc[i].num = rm_res->desc[j].num;
+
+			if (rm_res->desc[j].num_sec) {
+				irq_res.desc[i].start_sec = rm_res->desc[j].start_sec +
+								oes->pktdma_rchan_flow;
+				irq_res.desc[i].num_sec = rm_res->desc[j].num_sec;
+			}
 		}
 	}
 	ret = ti_sci_inta_msi_domain_alloc_irqs(ud->dev, &irq_res);
-- 
2.34.1


