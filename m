Return-Path: <dmaengine+bounces-11708-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 2mV4N02TOGrWdwcAu9opvQ
	(envelope-from <dmaengine+bounces-11708-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 22 Jun 2026 03:43:41 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D4D7F6ABF98
	for <lists+dmaengine@lfdr.de>; Mon, 22 Jun 2026 03:43:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=fail ("body hash did not verify") header.d=valinux.co.jp header.s=selector1 header.b=Hbg9qyQr;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11708-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11708-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed)" header.from=valinux.co.jp (policy=none);
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6755E30107EE
	for <lists+dmaengine@lfdr.de>; Mon, 22 Jun 2026 01:43:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DF4A253B58;
	Mon, 22 Jun 2026 01:43:17 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11021077.outbound.protection.outlook.com [40.107.74.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 513B1259C9C
	for <dmaengine@vger.kernel.org>; Mon, 22 Jun 2026 01:43:14 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782092597; cv=fail; b=tK0JinppDlN7d8cC+Qzq3Fd+b6QWY3tFDn3+VRywlS6CfzqauPtBYCTuelZuus2cHGZIaM/Wa4ocPsWKHQUu34nFwJfQcFgqgXjydOiACzjMJh5aQqF9E45QqM/SoOldv9dcCyXYmxz5MfNf4jLvoWkBwE89kEwTqxfe8y651Ig=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782092597; c=relaxed/simple;
	bh=W29bydqCM/A0viCX63fqUTHFL59qQQ/YSjl2gAOb79U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bNOkO77urSfx9AtuFa4rXqWKt3V8Icqqu8sikgCzT3go3u2y20za8dL0pc5OXAlZir+BtLdbI8zbGIKSSgO0pkXOTL3adWOHl0SDmD0U4ZRVqvtPz8XK9hKqf6LtlIPd1WIpYlWLztsqZscCXyVMtVRBQZ6M9/u4vESDe5+z5Mk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=fail (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=Hbg9qyQr reason="signature verification failed"; arc=fail smtp.client-ip=40.107.74.77
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QqXU03RyuCe05FIjgsJ8LdhouLHy12vbmRoK+X/d6iJwYfYKwTOlX62NEx1fVWx+KAyt3PY1Q+hDsBBJHG4wmh3eIei1+p/HgaVc17f718MadVPLuaj9p+sqijfRsLniDJCxFzxsnnq+U7n5VJ4Q6VQjhzRFP53hDJQUX0W2aB+9h22j7jqVAylNHgZ1z1Vezb25yAPIDkQRByW55xdeK0+sy/AVt7GE0eTvb/09s059DQ9wr/JnZS+15mVVg6z5R4rmYuL05UvLptyr8N1tOYPQqoaqZklQ/tQH9qhjF6iah16feEPak5Oe1g338QCYO7HMXsdlBPquw0WWC3bQxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=93wn40yDKM+64uCjRiO/94bQ6jENMrSoScnwLZmt5C0=;
 b=R+pN+fyoAr7BBrCUsF8rKjAmKfoVm8lcBxGjZGfRlorcZSL/zJc/bo2b9S8lmc1GUrydsORac5rPOmNu5qNFpv+6LHIxw2Zg+5xV/JEB5sj27heb1wPOXY7MR7IvsM7Y1udw1qdpI2WbI/5RcnCjkCJRXl3m1EfPvjCh122+dlOTIxFnNNdLovdDT21Yr0DebaZsV3bPGQb8UbeXtj7Vg4HrsYeA2/5/rwLilGjPyLCP1rWNmGFQfd7fnn3SOziSYvAgykk4WDrJRmB39g1gUfVzwtuwmzZ0jjG0kQsrsz/nVJS3BAajjHiMqe3feUaOBfzxF/fW6UxLXnQdcUI+Ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=93wn40yDKM+64uCjRiO/94bQ6jENMrSoScnwLZmt5C0=;
 b=Hbg9qyQrpcffBLJQWywfsy1rViIxwrUEB1igbc+qtTrECES1gLfegpLk8jI5D7SMSafPmoh1t506SmqHgv/em21TcWDrGn08ywCs+jDmP931N/NpPCGB7AoEL/pV1XZEjhuqbInBHx5FESBa2JFHCHgKe8Yo1yrdtsx8hEo3Zlk=
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OS7P286MB6729.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:42d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.19; Mon, 22 Jun
 2026 01:43:11 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.21.0139.018; Mon, 22 Jun 2026
 01:43:11 +0000
Date: Mon, 22 Jun 2026 10:43:10 +0900
From: Koichiro Den <den@valinux.co.jp>
To: sashiko-reviews@lists.linux.dev
Cc: Frank.Li@kernel.org, vkoul@kernel.org, dmaengine@vger.kernel.org
Subject: Re: [PATCH v3 02/13] dmaengine: dw-edma: Add core quiesce operations
Message-ID: <pmxfqgsjposbv6zehrgitqwvbxppc7cfht4xsxw4l2lcjkojkw@ycqyo72w24ji>
References: <20260620170040.3756043-1-den@valinux.co.jp>
 <20260620170040.3756043-3-den@valinux.co.jp>
 <20260620171536.0DE831F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260620171536.0DE831F000E9@smtp.kernel.org>
X-ClientProxiedBy: TYCP286CA0125.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b6::7) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OS7P286MB6729:EE_
X-MS-Office365-Filtering-Correlation-Id: ed979cb1-d7c3-4e6a-9c5a-08decfff9e79
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|10070799003|1800799024|376014|366016|7136999003|6133799003|18002099003|22082099003|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info:
	9J6bd8b/Oa3tBFHruWY5YQqdliLEtNZfLTLafIX59gWWkFPqcnKmJbx2BRkpdUPUp9CjioaoOgMtQe1u/zeNUlIyRd+9q3uoAAii04xMUIdW6CvnuhyvsWIHK4lWwmkvx1aWpj5W6iCkrOPOr8/QpIgzRd7JNa1Io9lkApNszYepCLZjVd5RGyHsaMJEQorZsXaB3fg0astiaJ+W3Hma5HveSKc97o8ekgStI7C/FXQnXW7HzbqpHQmT8MNWamnutM6HRLjpJKhFlpW19elQ1tCmBvAkwx6dTl691fWUPTQBL+KvNKA3vT7dHVxA0/7gHur3VQ1oQHwD9UaE0y6o4RThpQpObTtGYrx8rXFNUuO/zeFgqOEcx4gDzek3Vqn9+d2CX2u/uFzNGzSZ4o9qGXwiaf1MV8oNSgDjrzwpFQgzSvo0DaWs3TSnPLIqP4HL0qSJOwTKs8UJ/YmZTuV3J62x3N1+hBrlWu/QfCSsbeyCvr5s8WRvS61AiMXy4mCB7/Bgfj4sjqIHc7aVL4AeFVjTwOyjn2pGQ66Barwif71SXX7Aq3ZV0Kv4YGSKW1DbZWswqyqq3Fr3kxIXECuBoji4ASSIohEw/B3XHU3f/rk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(10070799003)(1800799024)(376014)(366016)(7136999003)(6133799003)(18002099003)(22082099003)(56012099006)(4143699003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?vGQCLgNJyr3AJgtvk8SneoqXO4sRv9e4zJoDWtXdPvHX1V7s2k+bVnuuI9?=
 =?iso-8859-1?Q?k/ZwaHbT64SHXKG9icJzgqIKCAIK6W4u55+0BgpkiHR4PL376hM2GSVpvq?=
 =?iso-8859-1?Q?C6VnjsQbML/pZVPAvX88SUCejOMeazWL0OVbdkxHjr77AYBQ4PezLlyY7r?=
 =?iso-8859-1?Q?f3JPjFR3CnHDof72a1UrbaScBlqrRiaOp7FrYg+2f8nlwREFiMYzwz0If3?=
 =?iso-8859-1?Q?1R+X007I6aJreENF/pZc4mmDbsDeBTyqr3y+P9Q7PbwuZgCfG4RQ2DFB32?=
 =?iso-8859-1?Q?DWw6A2rXBIj6beR7l5JoyIKG6LfUxCnUt67IPGTnM1Dlo+ZrtfRlGOBDYA?=
 =?iso-8859-1?Q?XjEvDzqLJUZca8TApzURDR3QN8F1EzgDUwrx+T9E1800t74N+eTe9HY4b9?=
 =?iso-8859-1?Q?pCDX7cLF2pbALnukBD0gkEAcAhg+cjhJcHWJUD47eVbSM1/yGCJ+ouhRmf?=
 =?iso-8859-1?Q?6bXF0vlKD4Tz41RcYxTzpBEJpj6TIlm9gPvjeZj+NNj9E0l8triP4A+yMC?=
 =?iso-8859-1?Q?RDUbaUpfg6lK1O/WpZqEm3DDa8vxV5dM1R8hptPYjIuda9eiexQ0XT4v1H?=
 =?iso-8859-1?Q?RwYROXDL3Py9PcH64fDldXkGxrIoIWSKMqw42i9vC1wsKx0HnLaw0MOH7h?=
 =?iso-8859-1?Q?T/RXCgAlwssPfaFZxYI2k39w6guzRPhT3tfAioHsk7a/zd8mXjrldh0dSV?=
 =?iso-8859-1?Q?3/8F+NCIu19zRm4cDi7WWKSkw/oHuLALNs9gh5gPaz1WqJNJboz65wqzNg?=
 =?iso-8859-1?Q?0MhbPtJR7nC0gjnRas8RSDnGv257vDqzoXNmUGCz05Q+8QbkSpKer27XU8?=
 =?iso-8859-1?Q?QANWq1Cb6on2RITUH4hNRyZXfdcIZR5riNHg9LVFmCND7n9+ACEUvjWlUN?=
 =?iso-8859-1?Q?EXkuHJ9/J8vXRuzmvgIh13HG+z0+XxKqErS4VuUOFSRt+b7PwRmvO/9Iwr?=
 =?iso-8859-1?Q?SLuZ3mOK/45J9TA4cOYH5DkB4qH5ALp5ymDj0GLbBnqblwEdMS4gtL2qSi?=
 =?iso-8859-1?Q?1V+bkiGwqUe2b3YiV1X6dnP0nCYYqfgmXUTVvxv+Cz6lsSfu7wf4UD90kh?=
 =?iso-8859-1?Q?Q8MFwAv46AWRKV76PxfVTVoroF+k1+XnO+BmP8prCgWhpQol6hmvrC0AYH?=
 =?iso-8859-1?Q?vyiEYR2qBbqhIqQFoDl6KpubxaQdDpZwlCvUafxqD/zOTVLrWhtS82f6a9?=
 =?iso-8859-1?Q?+FTgWFjRuZuM+FaRMPKVTCHS6RSDlsCqNtP6Oaw1y3wAnKZAoY5DpAj7JD?=
 =?iso-8859-1?Q?glqbSnHIj2/5APoXSI012JSKviehBdbkt/0dOP8DzpCzLhmPlpzvCm97BF?=
 =?iso-8859-1?Q?Huc/VRjiVvhqO44GXs5wuoANshdELOThf3hxOc3XA5HtBfTseK5/ecSwsU?=
 =?iso-8859-1?Q?onGbKC6C8u8njFH0YFYG3rFtP8ZMxWKyoc3G7+JtdEyCFcxhxjbEuPvq6R?=
 =?iso-8859-1?Q?ZR3wJV5z7XHnslgqh6Qyky7pGuQUu5pak1X10/yxhWz3dbJqjOTJojUwzk?=
 =?iso-8859-1?Q?7Fb6emZCmRECb1YzbTHXtZ7C2507ZA1gPfJK7aBb8O0SBuheywo48INMzJ?=
 =?iso-8859-1?Q?sAVqilVu5W/MCbFBtlbkV1CBySJinaSlN2Or0AwhBxKYJnla3draRVLo5g?=
 =?iso-8859-1?Q?TycccGlR1KLN5U8k/jUDX1OWKfbkjRWQ+IHOlwLP6ZjNXR6DwuxMuBbZ7W?=
 =?iso-8859-1?Q?b9uSQ61j7niHHpyNVrzJWfa4qm2GCQo7Iq4PfvVhtkUIScBeeUJR4OwJa+?=
 =?iso-8859-1?Q?QgI01LVK7eE1CwfCNcgw9KlOCR2vfgSQMKbttQAdlIhWMlO79r2fGGBx2V?=
 =?iso-8859-1?Q?lJIX+gFlXIPMb0XnXD9ksVk06YosD2jJmpi15OfwcC+ikyx0mKP0?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: ed979cb1-d7c3-4e6a-9c5a-08decfff9e79
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 01:43:11.6601
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0zzCDf8DG6MDAKBVBLP46hZ7VqcR7hYkM51Wt2XcF7yk20/gWwekld/Sa2dU2KvALhvBLZyqKfw9PHSTvPeJrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7P286MB6729
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.14 / 15.00];
	R_DKIM_REJECT(1.00)[valinux.co.jp:s=selector1];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[valinux.co.jp : SPF not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11708-lists,dmaengine=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:sashiko-reviews@lists.linux.dev,m:Frank.Li@kernel.org,m:vkoul@kernel.org,m:dmaengine@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[den@valinux.co.jp,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[valinux.co.jp:-];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[den@valinux.co.jp,dmaengine@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,ycqyo72w24ji:mid,sashiko.dev:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D4D7F6ABF98

On Sat, Jun 20, 2026 at 05:15:35PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [High] The v0 eDMA `ch_quiesce` operation globally disables the DMA engine and clobbers interrupt states for all channels in the direction.

This is a false positive under the ownership model enforced by this series.

Still, I should add a short source comment in v4. The v0 eDMA quiesce
implementation is intentionally direction-granular because the relevant hardware
controls are direction-granular, and that may be easy to miss from the callback
name alone.

> - [High] `dw_edma_v0_core_dir_off` modifies the shared direction-wide `int_mask` register without holding `dw->lock`, causing a data race.

This points at a real teardown assumption, but adding the lock only to this new
helper would fix the wrong layer. The same issue already exists in the
pre-existing dw_edma_v0_core_off() path if the driver is unbound while local
DMA engine clients are still programming the same instance. More below.

> --
> 
> commit d7eb32d006bf71fa3372ef97f6fa793fa851c5c8
> Author: Koichiro Den <den@valinux.co.jp>
> 
> dmaengine: dw-edma: Add core quiesce operations
> 
> This adds core operations to quiesce only the resources represented by a
> dw-edma instance. It implements per-channel and per-direction quiesce
> operations for v0 eDMA and HDMA compatible register layouts.
> 
> > diff --git a/drivers/dma/dw-edma/dw-edma-v0-core.c b/drivers/dma/dw-edma/dw-edma-v0-core.c
> > index 1781ba4f022ec..316d8c94eff9c 100644
> > --- a/drivers/dma/dw-edma/dw-edma-v0-core.c
> > +++ b/drivers/dma/dw-edma/dw-edma-v0-core.c
> 
> [ ... ]
> 
> > @@ -160,6 +160,15 @@ static inline u32 readl_ch(struct dw_edma *dw, enum dw_edma_dir dir, u16 ch,
> >  	readl_ch(dw, dir, ch, &(__dw_ch_regs(dw, dir, ch)->name))
> >  
> >  /* eDMA management callbacks */
> > +static void dw_edma_v0_core_dir_off(struct dw_edma *dw, enum dw_edma_dir dir)
> > +{
> > +	SET_RW_32(dw, dir, int_mask,
> > +		  EDMA_V0_DONE_INT_MASK | EDMA_V0_ABORT_INT_MASK);
> 
> [Severity: High]
> Does this modification of the shared int_mask register need to be
> protected by dw->lock?
> 
> In dw_edma_v0_core_start(), modifications to int_mask are protected by
> raw_spin_lock_irqsave(&dw->lock, flags). However,
> dw_edma_v0_core_dir_off() directly overwrites the entire int_mask
> register without acquiring dw->lock.
> 
> Could this cause a data race where a concurrent read-modify-write cycle
> in dw_edma_v0_core_start() clobbers the mask state configured here,
> leaving the interrupt configuration inconsistent?

To be fair, this patch just adds one more path that relies on the existing
teardown assumption: the same dw-edma instance must not be torn down while local
DMA engine clients are still actively programming it.

Taking dw->lock here would not fix that fundamental problem. The existing
core_off() path already writes these direction-wide registers locklessly. If
dw_edma_v0_core_start() can run concurrently with core_off() or dir_off(), the
problem is broader than this int_mask write.

So in my opinion, the proper fix is outside this patch and should be one of the
following:

  (a) Do not allow the driver to be unbound, as Frank pointed out earlier:
      https://lore.kernel.org/dmaengine/aiHe9UG3FwIACC8B@lizhi-Precision-Tower-5810/

  (b) Harden the DMA engine termination and teardown path so remove waits until
      existing channel users have stopped using all channels before turning the
      hardware off.

      Parts of that are covered by another series of mine, esp. patches 3/4/5 of:
      https://lore.kernel.org/dmaengine/20260615154111.2174161-1-den@valinux.co.jp/

      The remaining piece is the remove ordering itself: dw_edma_remove() should
      not call dw_edma_core_quiesce() or dw_edma_core_off() until the instance
      is no longer used nor usable by local DMAengine clients. Only after that
      should it turn the core off, free IRQs, and unregister the DMA device.

> 
> > +	SET_RW_32(dw, dir, int_clear,
> > +		  EDMA_V0_DONE_INT_MASK | EDMA_V0_ABORT_INT_MASK);
> > +	SET_RW_32(dw, dir, engine_en, 0);
> > +}
> 
> [ ... ]
> 
> > +static void dw_edma_v0_core_ch_quiesce(struct dw_edma_chan *chan)
> > +{
> > +	dw_edma_v0_core_dir_off(chan->dw, chan->dir);
> > +}
> 
> [Severity: High]
> Will this globally disable the DMA engine and clobber interrupt states
> for all active channels in this direction?
> 
> The .ch_quiesce operation is intended as a per-channel action. However,
> dw_edma_v0_core_ch_quiesce() wraps dw_edma_v0_core_dir_off(), which
> writes 0 to engine_en and masks all interrupts for the entire direction.
> 
> If a device has multiple active channels in the same direction, would
> releasing one delegated channel halt and silently drop pending interrupts
> for all other active channels in that direction?

At the register level, yes: for v0 eDMA this is direction-granular. The relevant
control registers, including engine enable and interrupt mask/clear, are not
per-channel.

The important part is that this series does not allow arbitrary per-channel
partial ownership for the v0 eDMA and HDMA-compatible layouts. Those layouts
require ownership of the whole direction before channels in that direction can
be delegated. So this helper is only used where quiescing the whole direction
matches the ownership boundary.

HDMA native is different and uses the per-channel quiesce path.

In other words, releasing one delegated v0 eDMA channel is not meant to stop
unrelated live channels owned by another local user in the same direction. That
mixed-ownership case is rejected from the beginning.

In short, .quiesce/.ch_quiesce implementations are intentional, but I should add
source comments to make things clearer for future readers.

Best regards,
Koichiro

> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260620170040.3756043-1-den@valinux.co.jp?part=2

