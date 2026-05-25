Return-Path: <dmaengine+bounces-10812-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eAWwHUjrE2qoHQcAu9opvQ
	(envelope-from <dmaengine+bounces-10812-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 25 May 2026 08:25:12 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5568C5C65ED
	for <lists+dmaengine@lfdr.de>; Mon, 25 May 2026 08:25:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CD17F3008278
	for <lists+dmaengine@lfdr.de>; Mon, 25 May 2026 06:24:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82DB03A5E6F;
	Mon, 25 May 2026 06:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="q3AdLC7z"
X-Original-To: dmaengine@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020141.outbound.protection.outlook.com [52.101.229.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B98053A1691;
	Mon, 25 May 2026 06:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779690283; cv=fail; b=SdCau1bXtezfaCoGIOYdsAghSt+W1hdvo3aH/f/HNXDHGljtUTacZLWQoE/oVyURWgvJM2fVKf+EwlDCQBgMizSGSVzkCd8vWulw2EEo2c8YFauszdbEQ0AO+Kiu72a8k/TRypy2nDRwrc0P/NcjrfUtFtDMej49LF2sMv967jk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779690283; c=relaxed/simple;
	bh=NZzEhMAWfzIWLDmN2TJg+sizGNaONbmviXKLcN8AWNg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WBQ6s7oLpXWZsf0ZCTRYump3GyOORFQXWQg1dnhhMniIEI2PP8fuiIBo/SRcRJJKpgix7/cm+VWZRBKQlL//OjgwcQJ2Jjhysbccii7ccWW2ASiGC8hmD1LgAJBEfIrusl5HTqd1uJw1tgn4cXgvJKWEiD5V5lUx9L++cuSjBMU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=q3AdLC7z; arc=fail smtp.client-ip=52.101.229.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fIvopsgyfMAmvh6tot1Da8lMiVB1vhxNnfDiZy3/9JbdbYs//CeZ/6QwIxh0cOQQcgod9nXTAl02zKIT9z8TPOqGbb9764E6Hvl1xHqJA1+9sAt2novFLo+kUn3BVOTMuKEKh4Gh8fUUJa5GVXH6qLRbJAPv71/TtBWLO3LDwDEApph0OCep5Ec0uDPtB4y4fUtTJ1F1VGfMUrU0aJlrKh2tINAEMmBCh3AANBgMIvmgKgFl7XI9FIMwKvzo/CRupEoAI9XZedye3XS64QCJIt1nwtmesD1/TaJFpFXXOrNLSq7n9HlV9OB6CrlzHXUgdYf+3/2ItNZrQ4rohGqwvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2mH/QQ8/foS/bSZfOg1/4x9zxO4E7uFVkN26SEC7NUY=;
 b=Zlb68MsU/2WYkA+1evpHO1lZuxOJkDaldbyvC5uMT2cHnOTwoJkvaWYDS2b3ubXJbMzqzITcF5Vjz80f0mBSfKeMFLH8SNkHhJQUMyAhxG27u72kVYvysLFqG5B8e1SZmrFZ9phkVGPFfXhjvr3dA1t12x4IhSHzCOdZOOHf7uBNdU/aQwduTY65t89k7Sfp+p8lIaj/V/qFTLE3r/hSM9rrtfmCLmKW4suKN2NTKOIuCLrAY4lWnO2nY/0mPuwd3leKp2ZlEJMGksWWiKaI1Fk3eMzx0E36fD1SoclJl+jMs2s5KWw1zrrlgt6FVxPIEWuE6jADzXgMgo4DFqOCAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2mH/QQ8/foS/bSZfOg1/4x9zxO4E7uFVkN26SEC7NUY=;
 b=q3AdLC7znnF95sntticEGiO3zNtpEs7kJJBLwdhchcCglH2yi8ko4k3GFpv8My4/iRwInzr5Pz5PmDzMVmCcNsByCYxcLvHoTwdat0Shw1xhCUFp+O3uRhrilfmx5b+e8gMt3yiENUD/NOg5XxV31WenBwcgVSYfoBK7S7v1IUY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OS9P286MB4655.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:2fd::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.19; Mon, 25 May
 2026 06:24:35 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.21.0048.016; Mon, 25 May 2026
 06:24:35 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 03/12] dmaengine: dw-edma: Add partial channel ownership mode
Date: Mon, 25 May 2026 15:24:11 +0900
Message-ID: <20260525062420.3315904-4-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260525062420.3315904-1-den@valinux.co.jp>
References: <20260525062420.3315904-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0067.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:31a::9) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OS9P286MB4655:EE_
X-MS-Office365-Filtering-Correlation-Id: f7391120-e449-40a3-154b-08deba264aa3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|10070799003|1800799024|376014|6133799003|3023799007|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	SNiLMGsKG1Cnb3TaOIhBuXG7anNgp5hGwxr1M1O+m1ScYRAWK1pJISSnjQgqZVtscY+sjCVPeYw074FvXcEF9GZ2eesR+UN+VTxS7ia1otN3Cjsrp7Y6Mp9fe49wtALtPoFGXxQYW+paU9Dd2sOMhf+BYXacgfxtC4/OZkRN1wIroJtCAlG6YFXack/tx37sTYeGuu/R1eIniJSyXyAZiObEz+z6WAQ8l98s1jS91/JhRl6+PoJnEUacQnIk7o5v1AJ4OECDOwNRRD1DnUfxd3W+9mse8oy8WDfRdUuHsKHU6sDUNHn6H2v+2nV2/MW6+1gSp4EHFUSRROlw9xE26OjCNeZg2lH5NlACGfMb8kYvNCLzngZc2IC8Ezw6eLXGuFhuJBPzCFjtM3bKvOxz2yrKFfS7TNFTa9dWQcIEMkCAPMExDy6MO1qBGADSTuwzNwReu3vY+ybn0wtcyfQPrwOHcKVs39cu5tjmsFXb0U6g8QPT7TzI25lNtLSHEPrhJA7yc/ioFFqRzyf6al4P1iXnVldgfuuiDE/IyClLgCGRuphwwzdpBeEId+IdpMkqspp1aapweY+mn36tU7GS/Uoy+wgKv7ITmDM7isJTS7KjC//rL2JqQ9/ZPMxxEB6YX/BZ40Nn8V+ZgjLPdSDUIEwUQ3t/DF+VzFSXtaHWnSHwVVGH4Z12HZl8ec6IRk0j
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(1800799024)(376014)(6133799003)(3023799007)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kNDzvgGdwr5A56Xx6U9qOxzsWRlhspNVAUBBVxuvjIRXd9vBskK6/vel0dDZ?=
 =?us-ascii?Q?pb5eAlfEOuDyfzjmulCJ2WBKAWSywgeS5QwSlbXBp5QiOq5oRgV14ldbUQlA?=
 =?us-ascii?Q?utxpJHHL6a4xcNDcphynqXS3nVK5mYgCTF7LB9DPTnCEAmvYuHfwcZ/g6lWh?=
 =?us-ascii?Q?bztchlgKFeG7gkmfJGVGZkrr/9uo0cE1ft6vMDtDZp2j+wWYHcyus9+mN1EX?=
 =?us-ascii?Q?ED/4pvo94XdIEBI/w49I3e14rAh/jX3tRasTZjD9Iev/pGS05nB+Yxz8FQIQ?=
 =?us-ascii?Q?ME9Ju6Nm29oj1LnlorB/tEwmekgV43MPsiYU70ZcdYe16zV06bXQPiVwu2ar?=
 =?us-ascii?Q?EDoOToNr31DMGlP/kQMrWzQe7GoN/+G0zSloSObnbu2kIKfRzZMFt0ROH4GV?=
 =?us-ascii?Q?vxvB+uISWY4oElbvr6OkRxvcKhc4/9rMeuFjYN64p4ZmPQjZPCtKmHl59YLb?=
 =?us-ascii?Q?OgMT2zAy+CVaga4MTduWlnGf0uByfzsK5IDQ/NVvvsQXypHBPoqqEpN2y/cM?=
 =?us-ascii?Q?P5EkO8wo5CowPOI6jVkkNsk8jrD4B/B+GwqVLvmXTkoq3tJKrcbv1fV6FHh8?=
 =?us-ascii?Q?nNEII9AKbuiHqXAOkA1niYMj9YxG7dIUmQy1D2TZqO4PWhOH4s8PgiKkOsnl?=
 =?us-ascii?Q?ldy2tCUX1JgjSNCJGuXD4BDDrnAIn4iFYtmaDiU4yanJVQ7N/U4ZldM3Kl5L?=
 =?us-ascii?Q?OaiHyCPVgMKlMLwLbdXUv9VidkZK4gj3yH+fn7d1ArmYbGXiuphKDhVUj9vq?=
 =?us-ascii?Q?rhEiyRVh23JIiygDIBr9WqAFS1XfkEXqvsYDHV0C5Us6DA0kz/7wUKeHG6zM?=
 =?us-ascii?Q?2kNkL6ftRlZlBBzwBZd+1ji/fveofKo0nAY81+MfK9dnxWESfN9zyhXDNpdS?=
 =?us-ascii?Q?6fuGgPjgbliUfYs4XZ7rlic1IU8707HfCWBbN774wqxTiLdlNh78I8JrUK9h?=
 =?us-ascii?Q?KqUIL8dCxWzAJR66X9Yu7YAmOfJzueFKVvO4DHTdEMxSva/ddb43/Zhk1iKc?=
 =?us-ascii?Q?IxnPsWpjj8BQug0TbB/ewuwzESLshVxVt/liXvk8yZzWp1tV9UAt0FqLRzse?=
 =?us-ascii?Q?2DnQMEIhtlsbbQsX75xRgtQy5WajDeZxo8QUYr1+OSWhBXuVYiXLW5zOZdv3?=
 =?us-ascii?Q?vFATOqPIIqD399VDqRndtFvKBVLUJP+LuBz7Ig4biUL6Qd6FaJYamKyal5m+?=
 =?us-ascii?Q?OUP3ubR2+u5QwCPpIgN9KMvLdl8bOZAoS/b7KHNOJkG3xvVhJ6B8OlnbxZOC?=
 =?us-ascii?Q?qhOu1HxojdYEu5OVsVmc8W+/ugXuAumnsk5iXvCFZ4EQsmv0tUPGaJl5FlKK?=
 =?us-ascii?Q?F2rCy7CP8WX/xnzPzo0HM6GZJh7nW5Z7l/Vmj5w2mrFD1vbeZiiTivVjPuH2?=
 =?us-ascii?Q?iOMKkUNMa6hHrg8ZGMhq2nhIQ1brdRoBcH1th9TJTwXTcBmGiLugZdToRlq+?=
 =?us-ascii?Q?bAEYTeu4sbkbpAsc6Oi0n8gT3WaHQIT5qOfQaIgoeyk0dqub3uqK6c6NTQya?=
 =?us-ascii?Q?UXkaK3earIu3Cvwf4zUbDqk49NNtSpAuz12MLn9EaLjLP8PudANMjl2D0mw2?=
 =?us-ascii?Q?8ZBvliCINvoJNAe1g2n3nMRVkUnL5n4CiDtzYRlwQdRLwslav7JR5t+3+V29?=
 =?us-ascii?Q?6dP6nNThwNfnTnUxj5H2bTS0XeaxZNLy5eCyNGUHEz/PB/PjjJgnEvKSChbo?=
 =?us-ascii?Q?s08tfRwv1VuuLIalxzXhKRyPNYVMUw4lDsgnwL1lgojd0LOx0mDr7SdBNb8X?=
 =?us-ascii?Q?TPXTW5dVGY2dZWyetAfF4lCmXKjTl9MpPRW1X4JCJkTytZ+I17ps?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: f7391120-e449-40a3-154b-08deba264aa3
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2026 06:24:35.7728
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pki3prrsH1B7xMTxq+p1Hf4M2LlSSzR/Sb1YWXWAwvsRrUtvTDxmrM7qBC0SVVhACRnzpnKQFXbfzZei9bmXFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9P286MB4655
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[valinux.co.jp,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[valinux.co.jp:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-10812-lists,dmaengine=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[valinux.co.jp:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[den@valinux.co.jp,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine,renesas];
	DBL_BLOCKED_OPENRESOLVER(0.00)[valinux.co.jp:email,valinux.co.jp:mid,valinux.co.jp:dkim,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 5568C5C65ED
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Some endpoint DMA frontends expose only a subset of a controller that is
also initialized by the endpoint-side OS. Add a partial ownership flag
so dw-edma does not reset controller-wide state in probe() or remove().

Keep the mode conservative. Do not enable interrupt-emulation doorbells,
and reject partial instances for map formats that this driver cannot safely
share. For EDMA_MF_EDMA_UNROLL and EDMA_MF_HDMA_COMPAT, require ownership
of all channels in each exposed direction. The driver updates registers
shared by all channels in a direction, such as interrupt masks and
linked-list error enables, so two independent OS instances cannot safely
split one direction without a shared locking protocol, which is
unrealistic.

The frontend must still quiesce delegated channels before removing a
partial instance. The flag only keeps probe() and remove() from
resetting controller-wide state that may belong to a peer OS instance.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes in v2:
  - Reject partial ownership for unsupported map formats up front,
    keep direction-granularity validation limited to supported formats.
  - Revise the commit message accordingly.

 drivers/dma/dw-edma/dw-edma-core.c | 47 +++++++++++++++++++++++-------
 include/linux/dma/edma.h           |  6 ++++
 2 files changed, 43 insertions(+), 10 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
index a70e0640d082..fcef9a27b6ce 100644
--- a/drivers/dma/dw-edma/dw-edma-core.c
+++ b/drivers/dma/dw-edma/dw-edma-core.c
@@ -794,6 +794,9 @@ static int dw_edma_emul_irq_alloc(struct dw_edma *dw)
 	chip->db_irq = 0;
 	chip->db_offset = ~0;
 
+	if (chip->flags & DW_EDMA_CHIP_PARTIAL)
+		return 0;
+
 	/*
 	 * Only meaningful when the core provides the deassert sequence
 	 * for interrupt emulation.
@@ -1135,6 +1138,8 @@ int dw_edma_probe(struct dw_edma_chip *chip)
 {
 	struct device *dev;
 	struct dw_edma *dw;
+	u16 hw_wr_ch_cnt;
+	u16 hw_rd_ch_cnt;
 	u32 wr_alloc = 0;
 	u32 rd_alloc = 0;
 	int i, err;
@@ -1146,6 +1151,16 @@ int dw_edma_probe(struct dw_edma_chip *chip)
 	if (!dev || !chip->ops)
 		return -EINVAL;
 
+	if (chip->flags & DW_EDMA_CHIP_PARTIAL) {
+		switch (chip->mf) {
+		case EDMA_MF_EDMA_UNROLL:
+		case EDMA_MF_HDMA_COMPAT:
+			break;
+		default:
+			return -EOPNOTSUPP;
+		}
+	}
+
 	dw = devm_kzalloc(dev, sizeof(*dw), GFP_KERNEL);
 	if (!dw)
 		return -ENOMEM;
@@ -1159,13 +1174,23 @@ int dw_edma_probe(struct dw_edma_chip *chip)
 
 	raw_spin_lock_init(&dw->lock);
 
-	dw->wr_ch_cnt = min_t(u16, chip->ll_wr_cnt,
-			      dw_edma_core_ch_count(dw, EDMA_DIR_WRITE));
-	dw->wr_ch_cnt = min_t(u16, dw->wr_ch_cnt, EDMA_MAX_WR_CH);
+	hw_wr_ch_cnt = min_t(u16, dw_edma_core_ch_count(dw, EDMA_DIR_WRITE),
+			     EDMA_MAX_WR_CH);
+	hw_rd_ch_cnt = min_t(u16, dw_edma_core_ch_count(dw, EDMA_DIR_READ),
+			     EDMA_MAX_RD_CH);
+
+	if (chip->flags & DW_EDMA_CHIP_PARTIAL) {
+		/*
+		 * Direction-wide registers are shared by all channels in that
+		 * direction, so a direction must have a single owner.
+		 */
+		if ((chip->ll_wr_cnt && chip->ll_wr_cnt != hw_wr_ch_cnt) ||
+		    (chip->ll_rd_cnt && chip->ll_rd_cnt != hw_rd_ch_cnt))
+			return -EOPNOTSUPP;
+	}
 
-	dw->rd_ch_cnt = min_t(u16, chip->ll_rd_cnt,
-			      dw_edma_core_ch_count(dw, EDMA_DIR_READ));
-	dw->rd_ch_cnt = min_t(u16, dw->rd_ch_cnt, EDMA_MAX_RD_CH);
+	dw->wr_ch_cnt = min_t(u16, chip->ll_wr_cnt, hw_wr_ch_cnt);
+	dw->rd_ch_cnt = min_t(u16, chip->ll_rd_cnt, hw_rd_ch_cnt);
 
 	if (!dw->wr_ch_cnt && !dw->rd_ch_cnt)
 		return -EINVAL;
@@ -1182,8 +1207,10 @@ int dw_edma_probe(struct dw_edma_chip *chip)
 	snprintf(dw->name, sizeof(dw->name), "dw-edma-core:%s",
 		 dev_name(chip->dev));
 
-	/* Disable eDMA, only to establish the ideal initial conditions */
-	dw_edma_core_off(dw);
+	if (!(chip->flags & DW_EDMA_CHIP_PARTIAL)) {
+		/* Disable eDMA only when this instance owns the controller. */
+		dw_edma_core_off(dw);
+	}
 
 	/* Request IRQs */
 	err = dw_edma_irq_request(dw, &wr_alloc, &rd_alloc);
@@ -1227,8 +1254,8 @@ int dw_edma_remove(struct dw_edma_chip *chip)
 	if (!dw)
 		return -ENODEV;
 
-	/* Disable eDMA */
-	dw_edma_core_off(dw);
+	if (!(chip->flags & DW_EDMA_CHIP_PARTIAL))
+		dw_edma_core_off(dw);
 
 	/* Free irqs */
 	for (i = (dw->nr_irqs - 1); i >= 0; i--)
diff --git a/include/linux/dma/edma.h b/include/linux/dma/edma.h
index 2bf2298711e1..84f0e728d300 100644
--- a/include/linux/dma/edma.h
+++ b/include/linux/dma/edma.h
@@ -55,9 +55,15 @@ enum dw_edma_map_format {
 /**
  * enum dw_edma_chip_flags - Flags specific to an eDMA chip
  * @DW_EDMA_CHIP_LOCAL:		eDMA is used locally by an endpoint
+ * @DW_EDMA_CHIP_PARTIAL:	Only channels described by this instance are
+ *				owned by this driver. Controller-wide state
+ *				must be preserved, and layouts with shared
+ *				direction-wide registers must only be shared at
+ *				direction granularity.
  */
 enum dw_edma_chip_flags {
 	DW_EDMA_CHIP_LOCAL	= BIT(0),
+	DW_EDMA_CHIP_PARTIAL	= BIT(1),
 };
 
 /**
-- 
2.51.0


