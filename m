Return-Path: <dmaengine+bounces-9247-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MEVPCfpYqGlQtgAAu9opvQ
	(envelope-from <dmaengine+bounces-9247-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 04 Mar 2026 17:08:26 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BA41D203C46
	for <lists+dmaengine@lfdr.de>; Wed, 04 Mar 2026 17:08:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id F026930B6E36
	for <lists+dmaengine@lfdr.de>; Wed,  4 Mar 2026 16:00:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F2BB33DEFC;
	Wed,  4 Mar 2026 16:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="crRt+11E"
X-Original-To: dmaengine@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011009.outbound.protection.outlook.com [52.101.70.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6767241139;
	Wed,  4 Mar 2026 16:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772640017; cv=fail; b=Us1/I0smLN8Y+yzTHoMKm0VWSc0VNl1yuLHoS8lQLUtumyVkLF/9eu9j+z5WjZXNG3gk5G4lZGrbq2cNsdzEQ+fJbOI8N8XquKvKa5FC324s22U1IWghx7kGBopyF0ATe9rP+FzQRlrwAA76eW8wC3qZbhuyYwMX0g01hDQWqz0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772640017; c=relaxed/simple;
	bh=uFIxeCWjpBi32PkVWhM0vl1HbLojygOlIAOd0df/REA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Wf1U1nEVpi+OiYbpOK5eyeBn1A1LMeRON7DgfptUqY4gU/x9tMHUtkeIasOnX9Qxzsc9o3lsUlx2nWqp1fDRXMh2p50a1xuliiLxiAwy9i2CCzk98KoQWZs65fJNlr++eruRqPG37sTLxjQzZdZVf8/EoYoS5knL2jIqOQPdRhE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=fail (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=crRt+11E reason="signature verification failed"; arc=fail smtp.client-ip=52.101.70.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bVKbX6BKIJf5t1rA5dBtzKddWErsey89/PWKbQ2BJANHxWUsEyuMWXG333SVbKkmJKjMEuGihTt4gDZ+2Kcs+ZPdhbUmcro4pJOwxTsVJjF3CQxBQP9io22RxuEhn6Z5u+xPjvhaEhud1csYwuCC5oY15+cdTRa1D2vjU1GZ/8fHXx64hQER4OY90tjBToqFE6XrlOWlemUIfdkwVmt6C3duPj1/5ml5kip7mBeZkuBu3AELXGbe8mD8Qln2YNkPqq98TC52Qibm5/Z5VzXxEJhbNxDrjBgSjxyHQsnlcJ5It9xUerBrC4fPP9IOavocy6qLsWz7FFzTzTbLVI2EbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+uSczgyZcNI24hbf8fLp6hXiy3l0MsJ4OT2tRoqpUAI=;
 b=kYpf2OKmm2NQTLTGkgOCbxtvQ1LXSfpJkMbEcz9xPsUi6SvpWO/AFa5YoBOs9/IZwzUaWqj4x+0IJY8BN5DTkBcjWZmc0Umz1Hy830lKInfMpEh4DrsS1+LzegOQoHJ/usUcVu3cIfJH8bawjMGEzpA5Rc8ea521ajFQv4Ujwr8sQRh7+RO8EuzNLjnh7GZH7i4V1sTNt6mE10QS3W/zKuuP6nYcFBR9mUz8qRyPEgHGgyf5cEy+P/wru0Pj/8s9WQmpypMg4hEVsWVnnwoeYOHbRuWTyGZr4hKmM0ttZB33LxeMJCxowE+NUGnnEdbNv/8FowAytUpyyGszpj9MfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+uSczgyZcNI24hbf8fLp6hXiy3l0MsJ4OT2tRoqpUAI=;
 b=crRt+11E94rkQr2AKglPXh0O/JR+jq8osFNvxV1WLyETKJEsycMPDA8mxvvXkvWZ2Qr99JLVOp98CDzbIj5ROXQ2k6TC6RTfmLvcDtlJOhhYJyKBi/I0+MAJj+Tq7VfEhe84EGjJvNADU2PsjnIC2ydyKiJluLROv32Xid/kiBg1rWTftzDEFervmjC7TUtJ/BkCqeKkb/9Lsi/bux9wbwJTZVIbP5JkihxOc1GtAKmeu9YTFpglYZo9C+f74kXNbIbNFsrNRtWIgArVUOfKhm1hblqZP5/oKxqws1YHsroEpWEkMvcRcl/y8UivGHH86llR+8D99/jhU0WeOcSgQA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by AMBPR04MB12286.eurprd04.prod.outlook.com (2603:10a6:20b:733::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.17; Wed, 4 Mar
 2026 16:00:13 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9654.020; Wed, 4 Mar 2026
 16:00:12 +0000
Date: Wed, 4 Mar 2026 11:00:06 -0500
From: Frank Li <Frank.li@nxp.com>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] dmaengine: ioatdma: make some sysfs structures static
Message-ID: <aahXBnVxMOkStVEh@lizhi-Precision-Tower-5810>
References: <20260302-sysfs-const-ioat-v1-0-1229ee1c83f3@weissschuh.net>
 <20260302-sysfs-const-ioat-v1-1-1229ee1c83f3@weissschuh.net>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260302-sysfs-const-ioat-v1-1-1229ee1c83f3@weissschuh.net>
X-ClientProxiedBy: SA9PR03CA0026.namprd03.prod.outlook.com
 (2603:10b6:806:20::31) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|AMBPR04MB12286:EE_
X-MS-Office365-Filtering-Correlation-Id: 96f1bd9e-1a59-4361-4e7a-08de7a071e61
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|366016|19092799006|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	2RvxNdQOU5WdF1mW45b49Pe8DzpQUpTGj3hOrsBr0xvjaA1bTk9SLwcuCxNfDQrmXK2y95W+hhk1JB1qthoLc0hP1oDlQn1CdlIbELSM4GXPnqMeIld9qpGbATQt7d0shwy3o4Dn/BcHztDXLILLWH7d5xJR6JekJSOoLcUDHauluEPz5G+lYuOiXwyqInweHCo+VPjz8LjqtDbfWhT/37We0qwbit8ihDBiLcHF+Qr+erYP6fRWvhx6dB+afztaxB6N4eajthSM+8BwhCiuIYcHtARA1B+Jq/wjhrR5h6tvWSUZifWO5ph3cgFDxpcB0jx0gNVyVQMS7pq7N2ovMc8kw5DR92z5BA449hpxZ3cKqRju5dEjpDrHSxKly2TcnkMU4B6Cj3ncqzDHCbntEeq9CM2q4NHVPW4Xxyc9+cqvt52l7RnDYKOjO5UNzuv9v9pRnsrdJJnHHaQ4klxustqqGwzWmNakjJoWlLqT1IQRUamNLgLorKFOywL3ZqHZjPQYMcTfqb+4XLZiQUgBs20b2I+pCu1sqKSpqGuE2qUEhSaqRhEAJ4KNBxzVnKCHkO9gWI6GKXpYMzTekZcGYZ5zhce/9zNfBBLjD7V8KGOdTKd5X+KX/4xGpguFyTRj4NgHeZgt76EDOnw3/N6RCBEcOGsXniqJL7mL8+ouB28YgR4pVj6Z5OK5Zja1HWT1Vk6+eiKvPttcr9X9IzxnvyUfkDQTxo+raYrmka3WQAc1fdPAkmUhR2Nd9id8tiP1De4MgpGqYKzRkazYEw5CzmIYA5xYatdjy2+N1d7MVTQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(366016)(19092799006)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?6CpK2rKAPLVsAaw1SCMbf62h//lJZ4SfpzIqsz8+151yXio3KP3VJG9Dv0?=
 =?iso-8859-1?Q?QvziyGfejrds582NVuDG+0oKibmCWoBDQEB4f4HBhf8JPjxa+rPhvdk5Qt?=
 =?iso-8859-1?Q?oG29LCaMZZlIKHjZZf/oZR0pfQPsJquWCmbui5ycIZ/XUARGMvcfnCYqMI?=
 =?iso-8859-1?Q?zfsDPJURiEqnbvwkGBGE/r0RA8k3qn1FeaYrZXV0LOjzh0iOlPhE5yhtNM?=
 =?iso-8859-1?Q?XrevtCU6LaA0lImi1KAtAHdLyxl5zMNFFypGO2TSm0dq0zcbMwOr0E2w+s?=
 =?iso-8859-1?Q?fltM86QfQw/0An4rmsvG9gZxHEFM9DUPK+3uc/3bNJsd+P2bdCNVUHSkiX?=
 =?iso-8859-1?Q?bEV4T2RfnyK4FL6Na9s2f+Pcl/T/UYSuAvyAvvA4t8cjvq3xmit1fsMgHx?=
 =?iso-8859-1?Q?xnT0brD5xvlFZek5r9WcF/oBkmOdYeEvG//ROlgXPMGQUfBGaPxcyO4ERP?=
 =?iso-8859-1?Q?DosM1NfY+pJG51Q8/f+KOBqgefNplFcYnD8C/nDI34i9st+70ops+OXnZ8?=
 =?iso-8859-1?Q?yo5KqDMkViwnrtWADzeQfJfoDMYOY8Au/1lD2mAoF+f8rAegEljzzLIEmq?=
 =?iso-8859-1?Q?Nhb9HRrGb36Y7U7TR5E0Cc3xYN4jZgDVLcDSDC3EFtJQ+4J6M6mVSNxXte?=
 =?iso-8859-1?Q?/tkyqy8+iLKpend955pY2i9TSNxTOcL0l5CQrf56eq927Fog8hBbQm//s2?=
 =?iso-8859-1?Q?QiPzmz/lnJXP6AiPEEMvMitU9Mjj+4O4q+7AF1Mz0mLZat2NL6EGRXVQOB?=
 =?iso-8859-1?Q?gMY7ZOHbf92EeO7zuk6LaXfSvL3SiX+KEkXcx9kXMPx5LkQFBYFLJkgTdJ?=
 =?iso-8859-1?Q?QH1aMLv2Uu0jefKtstGk2jiQbVvJ8a3ALYBHfMErf20IEAOm7N0a2By060?=
 =?iso-8859-1?Q?fYlwKXiQE2C6W07HnKgp/TspwHb+6pwZEjn9LHhII9BGZ8CsRwbW8ojgqO?=
 =?iso-8859-1?Q?YjYnr/+dNwfEz9euVVSN9s+kUfv72N2eooDbJumPuWBxEnQT5OLNbaB0AG?=
 =?iso-8859-1?Q?td2aWTGhxrcbejvBRiAyOgu4Fho4jEGtg+sm3dmNtdWQvavjSuhShc0lK+?=
 =?iso-8859-1?Q?cNb80rI8LjbUbe5vxtrSCLpA3TGkzu2JgCJoDlPg3VJih65DdRUyM+sxnv?=
 =?iso-8859-1?Q?cgsoEVnZQB6rBq5osyhkiUxHNgE0luAJNxqljtD7Y2rphvaVGPW2T9j71r?=
 =?iso-8859-1?Q?F1/ozel2LlOPtHjGCv3prW2QdpJXx178xK2v3cNfV+i99Eik1i9ssGuDpi?=
 =?iso-8859-1?Q?bf6G5lZXWT2QwoJV5zIQTJ2tUgf6nsXuiIT/6YrA3ycqdHvYFw62H3Z39U?=
 =?iso-8859-1?Q?4gZ3CQVA++nxODPSDssSJ+7S6/tbRlpuuFlNHJglcSXqshHoCuhIHPPCy8?=
 =?iso-8859-1?Q?reEug3+H0UYs/pE3Tq039wo6a2vTnwIAQc/xaO5lDJMhH8ORnXa9dgeF09?=
 =?iso-8859-1?Q?CRD1duUNcdncv4PaqQy5FEIaA5+JKvPz8zqmmCQPWdPTy91JR9JloG7Vi9?=
 =?iso-8859-1?Q?ElIG4/SOzLswycRSW3ptJVWeG5SpSEMGkQ/jEiQj8TCGMWAevfhM8VD11K?=
 =?iso-8859-1?Q?KXEqp5OEuXEC4mum3xe/1MZMmSxAGexzKrS6JV8FvNRsHv0s7bdjMsuW9U?=
 =?iso-8859-1?Q?EQ7YJ6ekyLS2RJ/eVspeamxmfc5cNOPpQDVSUMAYC4k0iP99DkaKX60sVs?=
 =?iso-8859-1?Q?HwhwXRiHVH0ikF86psoyJO7E4+/r/Wwf2qyyImy07YTMgGVhCPrqGg9QGw?=
 =?iso-8859-1?Q?+2tXYQ9M7OqFeSV7wU0dZzxWls2t/zrK8c6xjPU1d/D+mTyi3lMWMaA34A?=
 =?iso-8859-1?Q?GJRBE8k47Q=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96f1bd9e-1a59-4361-4e7a-08de7a071e61
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2026 16:00:12.7979
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6XVnEQqZ1RtaL2SYsOX9MBPOLUJ0OgVmNeyHZ8RmTUonj5DEWjqCIVW7nVb+DO5gUNbBjsjtp8i07dyyCxZHGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMBPR04MB12286
X-Rspamd-Queue-Id: BA41D203C46
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.14 / 15.00];
	R_DKIM_REJECT(1.00)[nxp.com:s=selector1];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9247-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@nxp.com,dmaengine@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:-];
	TAGGED_RCPT(0.00)[dmaengine];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_SPAM(0.00)[0.499];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,nxp.com:email,weissschuh.net:email]
X-Rspamd-Action: no action

On Mon, Mar 02, 2026 at 11:15:53PM +0100, Thomas Weiﬂschuh wrote:
> These structures are only used in sysfs.c, where are defined.
>
> Make them static and remove them from the header.
>
> Signed-off-by: Thomas Weiﬂschuh <linux@weissschuh.net>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/dma/ioat/dma.h   | 3 ---
>  drivers/dma/ioat/sysfs.c | 6 +++---
>  2 files changed, 3 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/dma/ioat/dma.h b/drivers/dma/ioat/dma.h
> index 12a4a4860a74..27d2b411853f 100644
> --- a/drivers/dma/ioat/dma.h
> +++ b/drivers/dma/ioat/dma.h
> @@ -195,9 +195,6 @@ struct ioat_ring_ent {
>  	struct ioat_sed_ent *sed;
>  };
>
> -extern const struct sysfs_ops ioat_sysfs_ops;
> -extern struct ioat_sysfs_entry ioat_version_attr;
> -extern struct ioat_sysfs_entry ioat_cap_attr;
>  extern int ioat_pending_level;
>  extern struct kobj_type ioat_ktype;
>  extern struct kmem_cache *ioat_cache;
> diff --git a/drivers/dma/ioat/sysfs.c b/drivers/dma/ioat/sysfs.c
> index 168adf28c5b1..5da9b0a7b2bb 100644
> --- a/drivers/dma/ioat/sysfs.c
> +++ b/drivers/dma/ioat/sysfs.c
> @@ -26,7 +26,7 @@ static ssize_t cap_show(struct dma_chan *c, char *page)
>  		       dma_has_cap(DMA_INTERRUPT, dma->cap_mask) ? " intr" : "");
>
>  }
> -struct ioat_sysfs_entry ioat_cap_attr = __ATTR_RO(cap);
> +static struct ioat_sysfs_entry ioat_cap_attr = __ATTR_RO(cap);
>
>  static ssize_t version_show(struct dma_chan *c, char *page)
>  {
> @@ -36,7 +36,7 @@ static ssize_t version_show(struct dma_chan *c, char *page)
>  	return sprintf(page, "%d.%d\n",
>  		       ioat_dma->version >> 4, ioat_dma->version & 0xf);
>  }
> -struct ioat_sysfs_entry ioat_version_attr = __ATTR_RO(version);
> +static struct ioat_sysfs_entry ioat_version_attr = __ATTR_RO(version);
>
>  static ssize_t
>  ioat_attr_show(struct kobject *kobj, struct attribute *attr, char *page)
> @@ -67,7 +67,7 @@ const char *page, size_t count)
>  	return entry->store(&ioat_chan->dma_chan, page, count);
>  }
>
> -const struct sysfs_ops ioat_sysfs_ops = {
> +static const struct sysfs_ops ioat_sysfs_ops = {
>  	.show	= ioat_attr_show,
>  	.store  = ioat_attr_store,
>  };
>
> --
> 2.53.0
>

