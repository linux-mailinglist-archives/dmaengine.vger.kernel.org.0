Return-Path: <dmaengine+bounces-12276-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id VTEjCgapUGoc3AIAu9opvQ
	(envelope-from <dmaengine+bounces-12276-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 10 Jul 2026 10:10:46 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id BC8D97384D7
	for <lists+dmaengine@lfdr.de>; Fri, 10 Jul 2026 10:10:45 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=valinux.co.jp header.s=selector1 header.b=JIJgMxDi;
	dmarc=pass (policy=none) header.from=valinux.co.jp;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12276-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="dmaengine+bounces-12276-lists+dmaengine=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 054B73038B64
	for <lists+dmaengine@lfdr.de>; Fri, 10 Jul 2026 08:10:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01F8A3EEAD8;
	Fri, 10 Jul 2026 08:09:33 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020099.outbound.protection.outlook.com [52.101.228.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 293253EDE40;
	Fri, 10 Jul 2026 08:09:28 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783670972; cv=fail; b=oX3tQyui5JQoSNA7RJZUlqOzbo8UOUY79awcCwr5ma539FPcVc5i+3DjePMc3MlyoUxS1DfAeXONUiS4riJrOde6oYEETmz/xeelRd7AHIeZgr2KbNCBJiwEaxL4V+igmosAhCaQEMHEywDc+EatvjJF3mdxNYtToFzyIixi6VI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783670972; c=relaxed/simple;
	bh=wd+xxdrnHj8oE4euNvkQnfc3szFzWPb/Eyufp42xKsI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OopX8toxzPYcmPTqjzrlRtpzuofKmyPCUIV7D9Gg4spvxaELYOtXd17Uav2C6TCmQ1x+Hit3yTFw22ZwoAGyATWY7Ggt3wPkxmGo4iLYTIfvlo3u5p8cFzxsEqnausrGzZ0s2zhNMWlSLMiVhHMZpM7CTamzn097O/fu7ka9FR0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=JIJgMxDi; arc=fail smtp.client-ip=52.101.228.99
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UPV0aEZZgpK8XtCteeMyJYcwsnVkz2Z17aNcIkQqvEjFUXr9NGIt1JPmOHHcTC5sXqoK5GaCLr7TLdEqoU4ELkUw5tOWaGVOOFf1FTjuU5MlrAY5F9JjNJidLLRY24Fr4emf3deLh6ATBtpaBAYngpv2E9DdhnIkf+6U1b539A/E9cmtqiq7HCjEuR6GYlRbv69iBgACL19i+/tFQWBkL6cwnjkH7vI3uEOIvmPnYeJI2f0zdl+CIrmlaLHCGd/YrWzB8sO91Y6QczDniqvJjdS8FGeTt5anEQxaMb3R6CA0/RyQTOaC21anygDJdIFZWCWLRK/JpUdmz4/IEZbNvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ovou42GCiulL2AtMFMxSDek9dtOmLR2AXcKcG91ccDU=;
 b=fFlNH5Zl0wmPtiBDMywa7JblcKLUPaO1Uw1v9NMaNQqOClo63AjBmI/J/PIKNsxcTtvlA2smHSS9CsdVZrBhpjPs5Gt6inPwSAYGyx0G6f+NIIyzCdGNbwQTS2e/FMhIYnlg9sYb/RxFipHfxwxEf2ejr04Ni30vnbQJzHPWDx9nf/AT5EDzAcRV3wtGoCfoLP53l/LTrNSyKzbpzsscHJYvquurkG+2UAOgsu8eSlFCWoI3ZuBeQm9NqoqhuKD0iRq8EThocKIRm+jlYeQ86piHfvgb/ny8AOEB5egRO+Z/R7bDogk67bp4fWQvzCSe/gk4POGUCWnsZPxtpblLgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ovou42GCiulL2AtMFMxSDek9dtOmLR2AXcKcG91ccDU=;
 b=JIJgMxDiuOlrLm0PtXpqOwWHdBzf6Qq/IDfM6ke9VxtHC13QB+lqwxsDjkx+oHHmYzG1vjmSPj6u/aVTk8cXg5un16nNUzPdQtjc2ma6mLs5CEYz8sRDdGVmHanPEr1LRzaApDr+KuPJCSp2SHnY1N2S2xiAlpX9Prx2ZavXQ7c=
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TY7P286MB6374.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:32e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.17; Fri, 10 Jul
 2026 08:09:15 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.21.0181.009; Fri, 10 Jul 2026
 08:09:15 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Manivannan Sadhasivam <mani@kernel.org>,
	Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Cai Huoqing <cai.huoqing@linux.dev>,
	Serge Semin <fancer.lancer@gmail.com>,
	Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
Cc: Devendra K Verma <devendra.verma@amd.com>,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 7/7] dmaengine: dw-edma: Defer channel IRQ handling to workqueue
Date: Fri, 10 Jul 2026 17:09:03 +0900
Message-ID: <20260710080903.2392888-8-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260710080903.2392888-1-den@valinux.co.jp>
References: <20260710080903.2392888-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0182.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:382::9) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TY7P286MB6374:EE_
X-MS-Office365-Filtering-Correlation-Id: 36d41804-fce2-4690-0b61-08dede5a889a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|10070799003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	K4uChymZU8WKA0Bvbhyx2g0NCSM4vr/Y83N2fq1azvgs6CUCQ1JPjn3/EAzbbcLmwtBohktGizrmDrgLHRZ1NwouwdpZT7BrElraXrIFVW44zS/P6U7kUWC3kjyUQe9o0AzmPYoWXdLHKS9+U5379DbKGv2g2yey8p9ncDAT/Frdt9pLLQf+o5hihJ5lTWm4NOGh3W+9SwDI+XrSeTLTcJTIbPKUEH488OJEPvnafvldxK4HsdpBh5kGEKX0LrcDDFFMm59Kk3LKmw7KqL7DySKYxQq2XmuLFm0ICPf0S6dIHFQM5FaB+XOhz1BaCkA4/KGCaznq5k4C4/vFpnQmfR5UHlkOaVyYFbauVZyk5JIRFR8HpdMpmKodztIxKmYUUGfwMNkp+ENqog/LszcVyqpTwZjFiogz/8rMv3IyDQTF5Zsas1DQG3LOrR98El2oM7ggpb/WCTr2hx3A6vUH7/1bD14NC0CAfIFJHsleBxsTE48iGx1b/69gGbM5AxXdTZYhpeP5m4q1yDMCYhg9kbpKo7gxluczNT+1VF6Eq7GyApf64oCJss7Ms6wGl8vjr7sKJniaDjORrPYEmAm7Lfa5a09E13dMM9wrXADBvZyIXeCVJgpUT05Nm+9uSOJjgTvV+8KLAbO2pL12NByKBtGReLYvlArAiaP3icPApZY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(10070799003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?uEHqlXKfF+bwNwuxyJ1uH5RC00RnxlRUGI15yvdA3cXFCJHjqdRHK+1EsVyi?=
 =?us-ascii?Q?s8gwUf26NkLx9U8LlhxQ+AHPahkV3AVjyaETLfFkb6BzR8sl8OyihgNK8hZ9?=
 =?us-ascii?Q?dQF1WUbKnhzkuZzu1l0ARihyuhegIiexwPggcPW+DcJyJ3GBVIP0JAockodf?=
 =?us-ascii?Q?az44iexXKZnZUnl6G+xLFA4WYT2eqXaCVRiSjmZm4pcEEJmLr7X42R1p8d4V?=
 =?us-ascii?Q?Vouar7WPboYAluRzZN8UGr6IKjDZgtASiCrvEk0geFO1vJuTytvL+IQyt77Q?=
 =?us-ascii?Q?Nyppn55cFYFr40+zB/Cr6XhRhp6nX4OzMtn3D3FXCdAO1peD5CZC/FS5Y9Dp?=
 =?us-ascii?Q?bfCdVZ6zU+oeXtH89/V8fxqwwlJ+i1GIoRxDEskIXKDS3Pi5F8/4VJa3Ttci?=
 =?us-ascii?Q?pxyuBR9kfgKenRhYfl85G8Y7w/atxo011/qqKThhKc0AQMmcVkiN2PMIeHuN?=
 =?us-ascii?Q?C+fhZI72SiW/BoEhrFCf504u8pGmpeuvNZhbv1FOBMxxbk4SNRCkfIQmc1SM?=
 =?us-ascii?Q?AzK2vOLDvbPdz3dMJxim5Tb5HiJwIt4VY+pUo7gK5HtizUG+RVxtMExnXxSK?=
 =?us-ascii?Q?MVphHjEMbiIZc90PnBzLljTsVeFF8tFFFYfp5Glm9zX5XckUGxHjluzSb5AQ?=
 =?us-ascii?Q?NxrDbcNCkJS3FgHzXYUOzxFdhPOrhKe9FnZV9mVkt7V8O2JFxyu+tedWN/1R?=
 =?us-ascii?Q?hjutNxyVrR9tVsTw83MeYfNf5HlJdH1X2383xz8ftf43h7c/lATQxbP9oWvv?=
 =?us-ascii?Q?c9lQxCpq4DHxW8jwtSZMTLwekRt07a2TM6vtNcaoYap9KJvhQNSfoogEMugW?=
 =?us-ascii?Q?YRztSvVFPxUClTjynAUFWZjTy71HjgeJ7dnD5G6SUUCEDfSN/GKYl7mpdYes?=
 =?us-ascii?Q?WHbb2YtlRxQkLOlrCanLWr25pgu34ES7XbeYqOEqnQwcyqkryt59JG0bA6TA?=
 =?us-ascii?Q?HPV4uPbjE95nLXiHkz0J/1AaDCQvtxcQpD6wJQVbuI0cAGkuQzsmTcVVza50?=
 =?us-ascii?Q?tp6A6al8kOiELiR20+CAI44frZLkmXyRzAaFAlVfuBxKMTjjI0uCf2+ISA3l?=
 =?us-ascii?Q?msKpwnVLheRTCif+0yBlsMSV99zrv58TJEXs5gVzqKLtcEMSBY/Fa7PNODgU?=
 =?us-ascii?Q?t2bl8yPcy1jWqqnBHxztTliTldThQ6Ca6t9pio7nZ7JYI+Fdn+rX28tncfKe?=
 =?us-ascii?Q?gyiiZ/FJDxwALUPah/fh9cQzJDFCan9vN2cP/6YgfqfxMVdoUkdDWXAsx9Jv?=
 =?us-ascii?Q?MmgBlScmvhnF72NtG/zhFRgA8tqziQTv1Q1OCD0PG9tFcnZAVHrRmuIy8FTl?=
 =?us-ascii?Q?+u4gCmnJy4WVgxBy94ypZPAT1Akv693Clh/X5ERhSdfLRKbOBJvSqhX2LnST?=
 =?us-ascii?Q?i4apo6SXrf7JBC1kzQPmO44eJxulaLN63SjaV6lxrzZIuxXXlBEzuPQSYjIi?=
 =?us-ascii?Q?9+DZEWm1hjwjGr/P0RY44jnBQAN8six3aoLe8RAVjJuH5swOQs2VFEnCdmto?=
 =?us-ascii?Q?K11YRyNlvzHq30O1aowad0wyi8pwvu+SmTfAooYousbkgPy9GN6+Mo6+FuAX?=
 =?us-ascii?Q?FxLnVlTIkHx/Okz6qiNLLsksip33Nb8/GHsfFHOyK5ouyDWRaOXxjJIvdmYa?=
 =?us-ascii?Q?vWriM/QeUHpL89ZrKTH1lBQ4LRIoEXhB4Lv8KRnpQUfSXgLmmAo1YaNwdnEc?=
 =?us-ascii?Q?xdzOA/B2jEIcMNUlbDHeNqsGNqYLkyoEm63aAbw/ZKE7DeW8lsIdq4v2MKk8?=
 =?us-ascii?Q?56+08WHQUH1JeTw9kdtCUgPydHyZKOCNauJUrGx2Ae3Q8aAelxtH?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 36d41804-fce2-4690-0b61-08dede5a889a
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2026 08:09:15.4056
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I9+KtWIP575hzNkd9RZQhiJWbFx+4vC7THVbEeFN5iAfq91jFlItha8wwIiPYgTbEgJnJlgPoKP/UiBmkQJ+ew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY7P286MB6374
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[valinux.co.jp,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[valinux.co.jp:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,linux.dev,gmail.com,synopsys.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[den@valinux.co.jp,dmaengine@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-12276-lists,dmaengine=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:mani@kernel.org,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:cai.huoqing@linux.dev,m:fancer.lancer@gmail.com,m:Gustavo.Pimentel@synopsys.com,m:devendra.verma@amd.com,m:dmaengine@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:fancerlancer@gmail.com,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[den@valinux.co.jp,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[valinux.co.jp:+];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,valinux.co.jp:from_mime,valinux.co.jp:email,valinux.co.jp:mid,valinux.co.jp:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BC8D97384D7

On some SoCs (e.g. R-Car S4) the endpoint-side eDMA raises a single
fixed SPI that is hardwired to CPU0 and covers every read and write
channel. Handling channel events directly in that hard IRQ context
serializes the completion processing of all channels on one CPU:
descriptor recycling and refill, client callbacks (the vchan tasklet
runs on the scheduling CPU) and the doorbell writes all funnel through
CPU0, while the handler additionally spins on each channel's vc.lock.
Especially under multi-channels heavy load, the contention becomes a
performance bottleneck.

Keep the hard IRQ handler minimal and have it just clear the status and
dispatch, defer the per-channel processing to work items. A work item
per channel preserves per-channel ordering while letting the channels be
processed in parallel on any CPU.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes in v2:
  - New patch in v2, posted as part of this preparation series.

 drivers/dma/dw-edma/dw-edma-core.c | 73 ++++++++++++++++++++++++++++--
 drivers/dma/dw-edma/dw-edma-core.h | 12 +++++
 2 files changed, 80 insertions(+), 5 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
index 5664421c6f15..704d8f9746e8 100644
--- a/drivers/dma/dw-edma/dw-edma-core.c
+++ b/drivers/dma/dw-edma/dw-edma-core.c
@@ -31,6 +31,11 @@ struct dw_edma_desc *vd2dw_edma_desc(struct virt_dma_desc *vd)
 	return container_of(vd, struct dw_edma_desc, vd);
 }
 
+enum dw_edma_irq_event {
+	DW_EDMA_IRQ_DONE	= BIT(0),
+	DW_EDMA_IRQ_ABORT	= BIT(1),
+};
+
 static inline
 u64 dw_edma_get_pci_address(struct dw_edma_chan *chan, phys_addr_t cpu_addr)
 {
@@ -748,6 +753,44 @@ static void dw_edma_abort_interrupt(struct dw_edma_chan *chan)
 	chan->status = EDMA_ST_IDLE;
 }
 
+static void dw_edma_irq_work(struct work_struct *work)
+{
+	struct dw_edma_chan *chan = container_of(work, struct dw_edma_chan,
+						 irq_work);
+	unsigned int events;
+
+	do {
+		events = atomic_xchg(&chan->irq_pending, 0);
+
+		if (events & DW_EDMA_IRQ_DONE)
+			dw_edma_done_interrupt(chan);
+		if (events & DW_EDMA_IRQ_ABORT)
+			dw_edma_abort_interrupt(chan);
+		/*
+		 * Correctness does not depend on this loop: queue_work() can
+		 * requeue once the work item starts running. Staying here just
+		 * coalesces back-to-back channel events into one wakeup.
+		 */
+	} while (atomic_read(&chan->irq_pending));
+}
+
+static void dw_edma_queue_irq_work(struct dw_edma_chan *chan,
+				   enum dw_edma_irq_event event)
+{
+	atomic_or(event, &chan->irq_pending);
+	queue_work(chan->dw->wq, &chan->irq_work);
+}
+
+static void dw_edma_done_interrupt_deferred(struct dw_edma_chan *chan)
+{
+	dw_edma_queue_irq_work(chan, DW_EDMA_IRQ_DONE);
+}
+
+static void dw_edma_abort_interrupt_deferred(struct dw_edma_chan *chan)
+{
+	dw_edma_queue_irq_work(chan, DW_EDMA_IRQ_ABORT);
+}
+
 static void dw_edma_emul_irq_ack(struct irq_data *d)
 {
 	struct dw_edma *dw = irq_data_get_irq_chip_data(d);
@@ -842,8 +885,8 @@ static inline irqreturn_t dw_edma_interrupt_write_inner(int irq, void *data)
 	struct dw_edma_irq *dw_irq = data;
 
 	return dw_edma_core_handle_int(dw_irq, EDMA_DIR_WRITE,
-				       dw_edma_done_interrupt,
-				       dw_edma_abort_interrupt);
+				       dw_edma_done_interrupt_deferred,
+				       dw_edma_abort_interrupt_deferred);
 }
 
 static inline irqreturn_t dw_edma_interrupt_read_inner(int irq, void *data)
@@ -851,8 +894,8 @@ static inline irqreturn_t dw_edma_interrupt_read_inner(int irq, void *data)
 	struct dw_edma_irq *dw_irq = data;
 
 	return dw_edma_core_handle_int(dw_irq, EDMA_DIR_READ,
-				       dw_edma_done_interrupt,
-				       dw_edma_abort_interrupt);
+				       dw_edma_done_interrupt_deferred,
+				       dw_edma_abort_interrupt_deferred);
 }
 
 static inline irqreturn_t dw_edma_interrupt_write(int irq, void *data)
@@ -930,6 +973,7 @@ static void dw_edma_device_synchronize(struct dma_chan *dchan)
 	struct dw_edma_chan *chan = dchan2dw_edma_chan(dchan);
 
 	dw_edma_wait_termination(dchan);
+	cancel_work_sync(&chan->irq_work);
 	vchan_synchronize(&chan->vc);
 }
 
@@ -972,6 +1016,8 @@ static int dw_edma_channel_setup(struct dw_edma *dw, u32 wr_alloc, u32 rd_alloc)
 		chan->configured = false;
 		chan->request = EDMA_REQ_NONE;
 		chan->status = EDMA_ST_IDLE;
+		INIT_WORK(&chan->irq_work, dw_edma_irq_work);
+		atomic_set(&chan->irq_pending, 0);
 
 		if (chan->dir == EDMA_DIR_WRITE)
 			chan->ll_max = (chip->ll_region_wr[chan->id].sz / EDMA_LL_SZ);
@@ -1185,10 +1231,21 @@ int dw_edma_probe(struct dw_edma_chip *chip)
 	/* Disable eDMA, only to establish the ideal initial conditions */
 	dw_edma_core_off(dw);
 
+	/*
+	 * Deferred IRQ works are queued from the hard IRQ handlers, so the
+	 * workqueue must exist before any IRQ is requested.
+	 */
+	dw->wq = alloc_workqueue("dw-edma:%s", WQ_UNBOUND | WQ_HIGHPRI, 0,
+				 dev_name(chip->dev));
+	if (!dw->wq)
+		return -ENOMEM;
+
 	/* Request IRQs */
 	err = dw_edma_irq_request(dw, &wr_alloc, &rd_alloc);
-	if (err)
+	if (err) {
+		destroy_workqueue(dw->wq);
 		return err;
+	}
 
 	/* Allocate a dedicated virtual IRQ for interrupt-emulation doorbells */
 	err = dw_edma_emul_irq_alloc(dw);
@@ -1211,6 +1268,7 @@ int dw_edma_probe(struct dw_edma_chip *chip)
 	for (i = (dw->nr_irqs - 1); i >= 0; i--)
 		free_irq(chip->ops->irq_vector(dev, i), &dw->irq[i]);
 	dw_edma_emul_irq_free(dw);
+	destroy_workqueue(dw->wq);
 
 	return err;
 }
@@ -1235,6 +1293,11 @@ int dw_edma_remove(struct dw_edma_chip *chip)
 		free_irq(chip->ops->irq_vector(dev, i), &dw->irq[i]);
 	dw_edma_emul_irq_free(dw);
 
+	for (i = 0; i < dw->wr_ch_cnt + dw->rd_ch_cnt; i++)
+		cancel_work_sync(&dw->chan[i].irq_work);
+
+	destroy_workqueue(dw->wq);
+
 	/* Deregister eDMA device */
 	dma_async_device_unregister(&dw->dma);
 	list_for_each_entry_safe(chan, _chan, &dw->dma.channels,
diff --git a/drivers/dma/dw-edma/dw-edma-core.h b/drivers/dma/dw-edma/dw-edma-core.h
index 6474cacf7195..a6a9ed09fe1b 100644
--- a/drivers/dma/dw-edma/dw-edma-core.h
+++ b/drivers/dma/dw-edma/dw-edma-core.h
@@ -9,8 +9,10 @@
 #ifndef _DW_EDMA_CORE_H
 #define _DW_EDMA_CORE_H
 
+#include <linux/atomic.h>
 #include <linux/msi.h>
 #include <linux/dma/edma.h>
+#include <linux/workqueue.h>
 
 #include "../virt-dma.h"
 
@@ -87,6 +89,9 @@ struct dw_edma_chan {
 
 	struct dma_slave_config		config;
 	bool				non_ll;
+
+	struct work_struct		irq_work;
+	atomic_t			irq_pending;
 };
 
 struct dw_edma_irq {
@@ -109,6 +114,13 @@ struct dw_edma {
 
 	struct dw_edma_chan		*chan;
 
+	/*
+	 * Deferred channel IRQ handling. WQ_HIGHPRI keeps
+	 * completion processing from starving behind saturated user load;
+	 * WQ_UNBOUND spreads per-channel works across CPUs.
+	 */
+	struct workqueue_struct		*wq;
+
 	raw_spinlock_t			lock;		/* Protect v0 shared registers */
 
 	struct dw_edma_chip             *chip;
-- 
2.51.0


