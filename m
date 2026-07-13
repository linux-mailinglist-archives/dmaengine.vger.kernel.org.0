Return-Path: <dmaengine+bounces-12424-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id YLHZMcQvVWpZlAAAu9opvQ
	(envelope-from <dmaengine+bounces-12424-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 13 Jul 2026 20:34:44 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ED2B74E840
	for <lists+dmaengine@lfdr.de>; Mon, 13 Jul 2026 20:34:44 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=fail ("body hash did not verify") header.d=NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b=wbUyqxU1;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12424-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-12424-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed)" header.from=nxp.com (policy=none);
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3292930221CB
	for <lists+dmaengine@lfdr.de>; Mon, 13 Jul 2026 18:34:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A672347505;
	Mon, 13 Jul 2026 18:34:40 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013047.outbound.protection.outlook.com [40.107.159.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C37AE335BB4;
	Mon, 13 Jul 2026 18:34:38 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783967680; cv=fail; b=GpfSMbtv7S+qRz1pbtrSi9dyO9MJHkk1lzSHnMwWU474GYcdAHiNXu4v1qUngZJEKDBrms9O/s5uEJ7hMjBthdu0tsFYeXukZtJDulEyG0HeYGQBx8HCgpFUYsXYzIWQjAVudCAjHm0VrVbJXh6Ms5MN7dd7la3R0BOiPEHo40U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783967680; c=relaxed/simple;
	bh=rvLZrHpVRZXpLSaAGtguar4Frla52jZfGltOzRfLC00=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qtj++oiP362nCGVsEkYGzt/EONJwermJoI+1OJFyHQivsTFUoRF5uKaC7ykG926Gx/QfWp+HRJkb655PvM7GwOZS5PdMi0k6SIvQZZioeGQRGzuL0TkGypA9t/Mx+mTZBROLXj5veGTUDJuZEL0Nygx9t8v/1fEN7eRhPbeIhh4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=fail (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=wbUyqxU1 reason="signature verification failed"; arc=fail smtp.client-ip=40.107.159.47
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Er64UC7Myu9MM3imnATbKVYfm++hnICcyqrbc2pCQciIiFyyr72j6Tb7B3fPujE9iUVo+KA3PFRV7rvj8Fqm7b/mm2GmvoTE2BYXti1jIeec+ZKKE22m+zAe2/Y5fMauTf1Ki0UOKAC1yb2A4Gxbku9Gjb1VS3aXriE43JmctxCgJgfujBYlvwlZAYaSw+C77IH1/IQ0DNK+CAM4wCHzw+ycfqQaFCOx/sEDV3XLucR4w8fdxqBElgo5QBWbv/vu5zqG9BRFxR2BG95z9L7jS/g791DI50njpdk6zwtq21422l+Tj8ovDR4KG8x44QaMrXO1q0wusg4dmATiS28xCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5CY3ie17rf458mYTu5llwHNK+PvgX6aIV91Dbmp3rNY=;
 b=SLWq8rBn6Z4V7f0gVpsvW039zz/waRghNMe0YsOjcESZDgylQ0hiMOpHbYyIR5YyRViCs13D98Dumx+mkt68lIqsq76HBztEZ2Y/4+usKG+AzdurkID5Nww6gWwPEh/GPu85Sn1VaJkQhMyLnvyxTfUcZOJTRD+FFFlyxoOy3TVCuiLHz4GfYLSjU+M47ZgkUApvdLxOGWmRsuTObOdGh0aa2OHe6emKgQCcktsizgBNppKFH2R+9JsJefUzjEtEcXpCiueENWZYLUIXttiBi8qLZFc2Ee/iARZsX4JD66+mUPJiNG4yTBcXVGm/ALjW77BCJcvOEodx6VJKtjZCug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5CY3ie17rf458mYTu5llwHNK+PvgX6aIV91Dbmp3rNY=;
 b=wbUyqxU1zxsKImxz8OvschtaqaHc4uObhoIeP4Rav7xBONlOhD201f3TfAnzWVrO7VhaHsmQEqG4SJL/U/CGTmJJGoZAAAofUbmyRVTUN5nWrGQYXXldj+bj6flq/p2wXfaXCwmIx5dEBPXQWTua+2z78VgctYpw7DQscjpEsPQY92GKxV0SRo33E7yBkRYaWiP973wRt1aOrQVBVYV4IVk9gRYDx4mXsSk42pGL/03/MLDriQWLBCfXWdt2nJ1CjgEWpMwF6vcvI+8KfxqAbNZ9x8vKAp7Z3qklQ7/LBNuOVHMXrB+oI25bf+stmSpXgrCo6xdCRMWED7MOT9xYeg==
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by GV1PR04MB9197.eurprd04.prod.outlook.com (2603:10a6:150:28::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Mon, 13 Jul
 2026 18:34:34 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0181.019; Mon, 13 Jul 2026
 18:34:34 +0000
Date: Mon, 13 Jul 2026 13:34:26 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: sashiko-reviews@lists.linux.dev
Cc: linux-pci@vger.kernel.org, vkoul@kernel.org, dmaengine@vger.kernel.org,
	Frank.Li@kernel.org, imx@lists.linux.dev
Subject: Re: [PATCH v7 10/10] dmaengine: dw-edma: Remove struct dw_edma_chunk
Message-ID: <alUvso-oXS6faY0g@SMW015318>
References: <20260713-edma_ll-v7-0-6fb7498c901e@nxp.com>
 <20260713-edma_ll-v7-10-6fb7498c901e@nxp.com>
 <20260713172202.70E6C1F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260713172202.70E6C1F000E9@smtp.kernel.org>
X-ClientProxiedBy: SA9PR03CA0026.namprd03.prod.outlook.com
 (2603:10b6:806:20::31) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|GV1PR04MB9197:EE_
X-MS-Office365-Filtering-Correlation-Id: 05719738-3c8b-4683-e15c-08dee10d62eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|1800799024|19092799006|366016|11063799006|4143699003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	lrIFx2RBuKBKmcbyppTNqel6ggianyrwClr8Lq9XyuTjd++ixZTkHXMB/xYAMocbpGMQyfN+xMYdBg+1kYlEnnhLJ550iv94hhzgy61bBH52inLvBZKcf1NGtmisqK/lsBZmbXe3yQdF9dFd6QTrCLysNsgLuPXh+dx5YEXQ4Q+We+j+0qFmSyWuamYQWtaEZts9N2jK6PzDLMWZjd/YmU5K3aW1wz7/AJ2reijceiHsq13TOC9fM5YtjCIoEy4C8IUxvW4JSv0EC1zc2Ba1BXrTbcOHSgY1etpURDm9Yh9Ng+0mGWyjqqZK0m3eFO7bFMRhKzIqyMb1WI4crZCxV5d/NMzywclQfkGwBsraSUKyBg51SDlHYsQ4RRJBwLCVKfl95MT212nHM45XlLZc/9eDLtzO6ke8q3nPeEfEi2q+NoU7+6CDqHxGz6WmoD+pc6c5D9LmHLUYvr0rq8l/fQ5qmErh1YSrjOMQiuM8azxSG8t6mXVmiS63bdsMm34HV+Rk2WDuGY7w8skWv9Osg5WimdCTwj1bmLfJFsqNAVcQV9z6FZ1AQIFQmMt5t1TDaLNFweR1hiffgJ7JR3yjv9IIgSeyja+aq0C6rC3bK/o=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(19092799006)(366016)(11063799006)(4143699003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?zQ+t5ozWPS8dtuFTqtMj9M9PPS+zomzcUh8mX1tvMkTUK7DbpvbfhJB6Vm?=
 =?iso-8859-1?Q?TD77pDecjW9SvW6ST/LbJBJ08PD2KtnGHSZNpe/b2rHqJMY4zOJNzGgANm?=
 =?iso-8859-1?Q?mMadJ/jPZ0bTC+3Rb6hKwQvX835g0BFBow2paO3u2OUjkRToMQe+GOp/5m?=
 =?iso-8859-1?Q?YDdG0mf/gbx1lZIhGRDxYWmftnMePEkUUn0cZuV5xV+fohaiedPcSMKmoe?=
 =?iso-8859-1?Q?gLp6B/jL/UL39QEOHKScgKo/sjTTCYXWv4RS4vQNu+GcyMBx2/bQSnO9gh?=
 =?iso-8859-1?Q?yYor0Bn6DYYLtub0CFkZYxurhOdPWuZfa2ttqVambjuxfEDLdIytY4O+/a?=
 =?iso-8859-1?Q?QZtGxUVUD2EK8PhZNWcBTr9tz0096Iq+HjzTuyZO7hydQkoOR4kgAxmoQ1?=
 =?iso-8859-1?Q?WWA1dwrlKqfTrJaLU9GmCYLM8DkZWvdSpKwSisbr8u3jQ5kiG3uh6c2i2H?=
 =?iso-8859-1?Q?afMaxDcjilnhXOoUnwA5sJzu0yyeXF3v9Tli/IGHHbKp5C7tLhjgRMjoRI?=
 =?iso-8859-1?Q?xuWMluBOZaKDcijv2BQdKVP5jnhmjZPYsU2W6JH04FTPm0GIx2tp+Hgmlg?=
 =?iso-8859-1?Q?XdR0Jw9IaOgjgvJco4yWAqDvgxMrIl0Qoep0ufDecsKmzslcQV9HGmywcn?=
 =?iso-8859-1?Q?EyIlI/JRngpQU1K3wZeZFTl4xrhDJGLrSRz8rnOB9pF39RwHyb/PgXl+Np?=
 =?iso-8859-1?Q?69RdUyqUU0vKw35P+iOJw9h2bGosTTQ95RutS1klMPZzqdGrSsRwSaY/sA?=
 =?iso-8859-1?Q?h22korGzGfNSU/9C6EPrj6+8uNkZBvgHYX858gqfvu39SGHdPT0kwTNCxu?=
 =?iso-8859-1?Q?xkpo9Evw1u73RJaOC6kj35tVpBHLxCJvYkh0LQaXEmYw0PRN7kPNML41XR?=
 =?iso-8859-1?Q?oZ28P1L1PjV6tMgwMK+C9EeLWa9Cjt4sO5v6AZtUyhlgBeFKPufBJYT56y?=
 =?iso-8859-1?Q?/omG9D6MSr+BYIT23tHJ9aM8AXPYE4XbZnqxkQ60G2M6tlGoC9ezYrwQQR?=
 =?iso-8859-1?Q?2qAwRJzAY6EgJrPVfjkLiFy4Vsi1NYjpu2BTTj9Pj5ovwXN6FoMsoLMMgv?=
 =?iso-8859-1?Q?w71HkY0f5MzXixB+CS/QA0utdP6/Z6qC4TOWvqQNKpDX0TEbT9UtBTV9ak?=
 =?iso-8859-1?Q?z7RsMQs9NvXrLyJ050CGS6dd4vUBQRGLQwoVDsOTJDumBZTXsmekS1DQlK?=
 =?iso-8859-1?Q?nNIhtCrnsJHHnS4d+3dIRcB14V3y7e5Zzyx+U+UDxF22Z4OSgHxU3f6wnx?=
 =?iso-8859-1?Q?4qTxQDIUe2QFa7O3Fnz502jaHMUWqYlCH64+SWUDeNXjXHfxUTNYJsfqpR?=
 =?iso-8859-1?Q?GPCnMI+3QIprXxo4pFbH8JD9GQ7W6xSOVp31vznkioX7mkNFYLGB8KMsvx?=
 =?iso-8859-1?Q?f2I63WdRahKkGbm+hce+ur9GZnBf3OKgFlhT8Zl+MO9YVTImPW06BMAViw?=
 =?iso-8859-1?Q?rtebHgpvNoGKZ5SmnLUWSxJXwu8HjuKhl0bajrGDRkdaBx/sh1H7Pir1qs?=
 =?iso-8859-1?Q?jfR3OSyCnLARrd7PDzjVcOlsXcU84FozUzVgPAW+ajsZJoebNtOFtG9sG4?=
 =?iso-8859-1?Q?726yBcJcx9l/oNBuiherD7PgKEmBx5iq3MBxnkkHQwzvQqw33M+1gOs8Ga?=
 =?iso-8859-1?Q?A7w0y3hrqmD25tfX4KZ48pZcdEA/kXibbLy3A0CW2miiTN5yXbS4TRviEt?=
 =?iso-8859-1?Q?iFwF3fniBdE+GilIzFZFFzQu6XCs4vo7pboOOyCDrJ9TFbM2xQVr300Vhz?=
 =?iso-8859-1?Q?98vUoxY4MDaUARhuJQDIdMADLGs8rctxf+I3qq6k3BwXJ/vhl5mLrcyzjp?=
 =?iso-8859-1?Q?uC9cARc/30RfUnVFvJTbDc/Hxfasa4pIDRsTo5b6DGvZRGO7g/Qq?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05719738-3c8b-4683-e15c-08dee10d62eb
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2026 18:34:34.6560
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q/cfrpjihQu18E+P+dAgZPSKh9Z2IuDeU9gcAqP6MNkmMYhSIb8RH/jzpzk7P2J+ofkc9n01wbBv0JNcw8wlIXkYMAyR1o1t18x0aJvG3LU2ECDKlpuPcElYYpnUbQwQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9197
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.14 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_DKIM_REJECT(1.00)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-12424-lists,dmaengine=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[Frank.li@oss.nxp.com,dmaengine@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:sashiko-reviews@lists.linux.dev,m:linux-pci@vger.kernel.org,m:vkoul@kernel.org,m:dmaengine@vger.kernel.org,m:Frank.Li@kernel.org,m:imx@lists.linux.dev,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:-];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@oss.nxp.com,dmaengine@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	DBL_BLOCKED_OPENRESOLVER(0.00)[SMW015318:mid,sashiko.dev:url,oss.nxp.com:from_mime,nxp.com:email,vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2ED2B74E840

On Mon, Jul 13, 2026 at 05:22:02PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 5 potential issue(s) to consider:
>
> New issues:
> - [High] Replacing bounded chunk descriptors with a single contiguous GFP_NOWAIT allocation breaks large DMA transfers due to memory fragmentation.

It should be never happen, not such long list happen.

> - [High] Resuming a paused DMA channel causes an out-of-bounds array read if the active descriptor was fully completed at the time it was paused.

Pause problem, need more work

https://lore.kernel.org/dmaengine/20260710080903.2392888-5-den@valinux.co.jp/

> - [Medium] Uninitialized trailing DMA bursts are submitted to hardware if SG iteration breaks early.

Never happen, pre-alloc enough list.

> - [Medium] Stale DMA residue is reported during a channel pause because `desc->done_burst` lags by one batch.

about pause /resume existing code have problem. need fix later.

Frank

>
> Pre-existing issues:
> - [High] Missing `chan->vc.lock` acquisition in `dw_edma_device_resume` and `dw_edma_device_pause` leads to data races and virt-dma list corruption.
> --
>
> --- Patch [10]: [PATCH v7 10/10] dmaengine: dw-edma: Remove struct dw_edma_chunk ---
> commit ac4e11776f7ec8bd87ba4484bd079463058cc76d
> Author: Frank Li <Frank.Li@nxp.com>
>
> dmaengine: dw-edma: Remove struct dw_edma_chunk
>
> This patch flattens the DMA descriptor layout by moving the burst array
> directly into struct dw_edma_desc and removing the linked-list chunk layer.
> It uses start_burst and done_burst to track current hardware submissions.
>
> > diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
> > index c028011cc61ca..30eeb7bffad80 100644
> > --- a/drivers/dma/dw-edma/dw-edma-core.c
> > +++ b/drivers/dma/dw-edma/dw-edma-core.c
>
> [ ... ]
>
> > @@ -40,82 +40,54 @@ u64 dw_edma_get_pci_address(struct dw_edma_chan *chan, phys_addr_t cpu_addr)
> > -static struct dw_edma_desc *dw_edma_alloc_desc(struct dw_edma_chan *chan)
> > +static struct dw_edma_desc *
> > +dw_edma_alloc_desc(struct dw_edma_chan *chan, size_t nburst)
> >  {
> >  	struct dw_edma_desc *desc;
> >
> > -	desc = kzalloc_obj(*desc, GFP_NOWAIT);
> > +	desc = kzalloc_flex(*desc, burst, nburst, GFP_NOWAIT);
>
> [Severity: High]
> Does allocating this unbounded descriptor array at once with GFP_NOWAIT
> introduce a risk of memory fragmentation failures?
>
> Large DMA transfers previously used bounded chunk allocations. With this
> change, could a large scatter-gather or interleaved transfer spuriously fail
> with -ENOMEM since GFP_NOWAIT cannot sleep or perform direct reclaim?
>
> >  	if (unlikely(!desc))
> >  		return NULL;
>
> [ ... ]
>
> > @@ -107,18 +79,27 @@ static void dw_edma_core_start(struct dw_edma_desc *desc, bool first)
> > -	for (i = 0; i < chunk->nburst; i++)
> > -		dw_edma_core_ll_data(chan, &chunk->burst[i], i, chunk->cb,
> > -				     i == chunk->nburst - 1);
> > +	for (i = 0; i + desc->start_burst < desc->nburst; i++) {
> > +		u32 idx = i + desc->start_burst;
> >
> > -	dw_edma_core_ll_link(chan, i, chunk->cb, chan->ll_region.paddr);
> > +		if (i == chan->ll_max)
> > +			break;
> > +
> > +		dw_edma_core_ll_data(chan, &desc->burst[idx],
> > +				     i, desc->cb,
> > +				     idx == desc->nburst - 1 || i == chan->ll_max - 1);
> > +	}
> > +
> > +	desc->done_burst = desc->start_burst;
> > +	desc->start_burst += i;
>
> [Severity: Medium]
> Will this cause stale residue to be reported during a channel pause?
>
> Because desc->done_burst is updated to match start_burst only when the next
> batch starts, it appears to lag behind the actual completion if the channel
> is paused immediately after an interrupt. This lagging index is then used by
> dw_edma_device_tx_status() for residue calculation.
>
> >
> >  	if (first)
> >  		dw_edma_core_ch_enable(chan);
>
> [ ... ]
>
> > @@ -355,13 +321,11 @@ static struct dma_async_tx_descriptor *
> >  		fsz = xfer->xfer.il->frame_size;
> >  	}
> >
> > +	desc = dw_edma_alloc_desc(chan, cnt);
> > +	if (unlikely(!desc))
> > +		return NULL;
> > +
> >  	for (i = 0; i < cnt; i++) {
> >  		if (xfer->type == EDMA_XFER_SCATTER_GATHER && !sg)
> >  			break;
> >
> > -		if (!(i % bursts_max)) {
> > -			u32 n = min(cnt - i, bursts_max);
> > -
> > -			chunk = dw_edma_alloc_chunk(desc, n);
> > -			if (unlikely(!chunk))
> > -				goto err_alloc;
> > -		}
> > -
> > -		burst = chunk->burst + (i % bursts_max);
> > +		burst = desc->burst + i;
>
> [Severity: Medium]
> If this loop breaks early due to !sg, is desc->nburst left un-updated?
>
> If desc->nburst retains the originally overestimated count,
> dw_edma_core_start() will loop up to the original nburst. Does this risk
> submitting uninitialized (zeroed) DMA bursts to hardware, potentially
> leading to IOMMU faults or hardware hangs?
>
> >
> >  		if (xfer->type == EDMA_XFER_CYCLIC)
> >  			burst->sz = xfer->xfer.cyclic.len;
>
> [ ... ]
>
> > @@ -625,7 +574,7 @@ static void dw_edma_done_interrupt(struct dw_edma_chan *chan)
> >  		case EDMA_REQ_PAUSE:
> >  			chan->request = EDMA_REQ_NONE;
> >  			chan->status = EDMA_ST_PAUSE;
> >  			break;
>
> [Severity: High]
> If a descriptor completes exactly when the channel is paused, could this
> lead to an out-of-bounds array read upon resuming?
>
> If the PAUSE handler breaks out here without checking whether
> desc->start_burst >= desc->nburst, a fully completed descriptor remains on
> the list. When dw_edma_device_resume() is later called,
> dw_edma_start_transfer() would unconditionally fetch it and pass it to
> dw_edma_core_start(), which will access desc->burst[desc->start_burst].
> Since start_burst == nburst in this scenario, would this read past the end
> of the flexible array?
>
> [Severity: High]
> This is a pre-existing issue, but is it safe that dw_edma_device_pause()
> and dw_edma_device_resume() modify chan->request and traverse virt-dma
> descriptors without acquiring chan->vc.lock?
>
> Concurrent calls to dmaengine_pause() or dmaengine_resume() alongside the
> DMA completion interrupt could lead to data races and virt-dma descriptor
> list corruption.
>
> >
> >  		default:
> >  			break;
> >  		}
> >  	}
> >  	spin_unlock_irqrestore(&chan->vc.lock, flags);
> >  }
>
> --
> Sashiko AI review · https://sashiko.dev/#/patchset/20260713-edma_ll-v7-0-6fb7498c901e@nxp.com?part=10

