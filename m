Return-Path: <dmaengine+bounces-10771-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QJJZKVjMEGpAdwYAu9opvQ
	(envelope-from <dmaengine+bounces-10771-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 22 May 2026 23:36:24 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 222875BA829
	for <lists+dmaengine@lfdr.de>; Fri, 22 May 2026 23:36:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1883D30021C5
	for <lists+dmaengine@lfdr.de>; Fri, 22 May 2026 21:36:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C38D233931;
	Fri, 22 May 2026 21:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Z+z4997w"
X-Original-To: dmaengine@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010050.outbound.protection.outlook.com [52.101.69.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC21F36F8FB
	for <dmaengine@vger.kernel.org>; Fri, 22 May 2026 21:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779485782; cv=fail; b=DChMMFb/H6Vr6OgRAwlECQPDjeR/IVP0MKWmpQURvFAqxIBivyy59HHDewV6snnKD0RoZYrdEUqqo23toVEHdajo66C4IA9EiVzMalr6c3nZ9+Zy+9iecGr9RKt2N9qg77ndh2YOiJPN1jrHxnYq0F8HMb1HqjSdhoppCw3wucU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779485782; c=relaxed/simple;
	bh=FwglYdd/g5J+z+fBACw/v/jxothA63RVuWbR8qLay6g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Zd4hIpSxKBfhBbTTNth4j2UhzuSUSyGHXYTLEGDXNeNUH6vYverANneOh29Ien4Mmqyaq3aMR+dYy3wFtClLyObQWz2XPBRFraOwRLIYiwRarEGLzq1VV4XaOrWMFm17JkuSKv63F46tFG0yvuuGlyVKDh9NARt8YsXjXP+dmAc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=fail (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Z+z4997w reason="signature verification failed"; arc=fail smtp.client-ip=52.101.69.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iyhkRTNIUXYRluqq2Vnvft3mEwJSn/gZK0Y7+lXY3t4ZLa0grMC+CjnBpCKmgSFG2oofo2vFH1IcAtyhpl3Q0NI6TvN8E4tBBDgBrBTrLurRnOZNJEFRdep3UX+8nIslyeTlHMC3hax3IQyJtjOtLTZ6w5j1I9Q6e8YBJj4gbw8TLtdYY6yG5cjQ0M9aaACQjCkYKCeN7GVYcqN/NoMarwn/SlIM7JMh0uiKuFIL3uLo0EiP44o8MjbViGMhTGxJknus24ldxFg6S+O9jN17GSyIytX+BuTMYA4TLI5u/aJY5Z50JVqhSI+6f32/9jvWYdb6peFHeCBhqQALL5640Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A2VUOBw/npbhDfJdHo0Ul3MpvY30ApjYuj3OrBtMLao=;
 b=MqP34K2LbZRCs6lSNmnD2makzSGijvFgTfkFtUC8Ldluekuz24x9GGWceuDrt+DcZwMOZKmJTMgPJBI0yBhI11Fj003QDGnOVUHn7evf+5DIRChT/ZlC5JWtZ5aG+YlP864ykGocDRRn7uChhEvH0G1fpdu0ToXiUQGGqo0e+0RmYqYlAr6iYREJEMgDY+AtixlHTrF61O4MV3314ECxvYUsb+8CCfizq8DbGkkQiHUQeXXuRJk+Ofihe3SsPYvBilZpUrO9NPxTZfdBEf0QCMXqgh6joAR/QL9bAQetkAW815fpc5jh206ftasxUlT0qdpvSxu9QgXNTRHNNAS58A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A2VUOBw/npbhDfJdHo0Ul3MpvY30ApjYuj3OrBtMLao=;
 b=Z+z4997wzpe2VkOgyZPTfABdaonb9iTAGZWX6vzs5XZJpiU0IODbr8TLE7NxBzjWCuIuplGfhHOOq2ERhoWsJce1IQTzL+ZcsNB0PvGZztF+UuOCEkt9l7Uu5r6qUl8Uws7gpstXMs5oRZx+urM0Hn5Q9qprIcvhPsjZ7ltqUk87+7u4KeaW0v7v6hj9q8hGSF8LJE1eJUzCVm78Zfjs+Dfd+jnPpFa374N5eRAeKwF1WCgDOCnrBOP5om7z2Gme+7GYpbiMvdr59OYKqMc89zDFolZHWzH3ou4UPxZKlA9t0Ur0MmOy1lWkuXb8j/YplmBADCIyXWcnXrBTOurI1A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by DUZPR04MB9968.eurprd04.prod.outlook.com (2603:10a6:10:4d8::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Fri, 22 May
 2026 21:36:16 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%3]) with mapi id 15.21.0048.016; Fri, 22 May 2026
 21:36:16 +0000
Date: Fri, 22 May 2026 17:36:10 -0400
From: Frank Li <Frank.li@nxp.com>
To: sashiko-reviews@lists.linux.dev
Cc: Frank.Li@oss.nxp.com, vkoul@kernel.org, Frank.Li@kernel.org,
	dmaengine@vger.kernel.org, imx@lists.linux.dev
Subject: Re: [PATCH v2 1/2] dmaengine: Add helper
 dmaengine_prep_submit_slave_single()
Message-ID: <ahDMSo9-_b0A8HWH@lizhi-Precision-Tower-5810>
References: <20260522-dma_prep_submit-v2-1-7a87a5a29525@nxp.com>
 <20260522204538.EFE9C1F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260522204538.EFE9C1F000E9@smtp.kernel.org>
X-ClientProxiedBy: SA1P222CA0180.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c4::17) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|DUZPR04MB9968:EE_
X-MS-Office365-Filtering-Correlation-Id: f061a4f0-7d2f-41ee-eb06-08deb84a273f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|19092799006|22082099003|56012099003|18002099003|11063799006|4143699003|38350700014;
X-Microsoft-Antispam-Message-Info:
	lGO0KBdtwb06V1Hw9idoItP0Q9Hv/6rRwNTunBniCak7N9WcWxyEiG8PcYnNQzw66yE4a7TOw+ljZrJoy2GYpO+LE6avQKkfpGGhVDIW9kIUjhTVQQ0U575p/4oPTivZGO9A67pXRoTuXN8Bbkcq/UyiicfZEvYEbH65dhD2HGrGrekkksOm7YKS5Vssr+EDyPHwMq7yQWg4XsXdOxsyYvtp1l10iS25qyFuw+Ct1pCyeqvX1fbVqDriVxVH8VkiH9iphTLMNh3eg5f/uZkaR8dAEQwzN4WASfffOpa96CMtlceiWjCsOxu+zLUtODdKh+Jdc39sRd92O61XX0CXxXl6kKuh/Qtor0jP+/HdH+HJoSCogfn53blpadZXpF01qmnW6WjVkhYBS7QuP8hkkKXqVuUMe1ytkoToi5ZuYOjGzVNqZlDBvIB99vENK1vypNg/Uqs+QFRsvlvlO9Q9JNbGsVs6deSCAgE6TF+0tjfJZbo5bIIhqbH9SSn9UKeyMkR9ShtGQDeS2/EedG3xC0Fg7kFsHvzeGAUmlPQmNi3xSpNgkGb39Yx8ufHN4SNhYDH8HxMGmudD0pngzitc3n7ltS3E7009tBtlQK2I1TjnUyjnxBt+/n3idqB/Y0DMjzozRCMumqvmFs+D0o78ws8E2mkqpQtt47F6DN+NvKn8rcwQUZrLuJlfZDVGGBrF
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(19092799006)(22082099003)(56012099003)(18002099003)(11063799006)(4143699003)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?2+WXv7hwzeJXU6xCAwEwJ+fnS82sSqlRoYyfNuym8IdQA5AHzWwA6hTw1R?=
 =?iso-8859-1?Q?bl6jxTDwqiEGc603ThXQM+QV07Cl3mAOLC20Ejgrzgft0JX8xXnjfC9LwZ?=
 =?iso-8859-1?Q?pguDDZB5YMtxNiUxc01v4LmpCOTahOSAscgxVYu5oxTwhNYgyPbYkafT83?=
 =?iso-8859-1?Q?DRZTvnkMxxCPdNCghX/hXpHju7pjItKwCKvBTabCnLgXfkduPacuN531Ja?=
 =?iso-8859-1?Q?mWx0kGA67g08X3K47Cr4U1E2tEr2xNrb0DBil2SPxw/eq7b0LUipKq/vy1?=
 =?iso-8859-1?Q?oGNYJoXxwTQjBdHEjQ4MDhb4Mf2yGOSDQuWX7LAovlqM04kyV5/RgGlxd3?=
 =?iso-8859-1?Q?Ti12iBkUQ/zJiEk4bAQlXMuoxO6dUTXZQbuT1J3IO/9QtZdy12mxKrCbKr?=
 =?iso-8859-1?Q?VzspdvtLJoIXbRotS2+4bkbCzwBJQkijzt8mrYUqA3/YKz7CXrEEIr8QOK?=
 =?iso-8859-1?Q?lIoA/1AoOlfK0sAuOOrlpEpkmCS6NqaPB1kpzppRfVgnMG2VFdZtYb1/SK?=
 =?iso-8859-1?Q?jS2rtXjWjWtjncRNjxt7LGRiia4Ji27t43qq4dEMIXy1N2juSbfzMZJKZm?=
 =?iso-8859-1?Q?GZMQPZ0oahv7vzLnXkImkyaC5+g0XRKmzlgnynEEiuys5IEWi9nXfphcGA?=
 =?iso-8859-1?Q?X6cJuMJ9UIe18i3WoZEEs19UcHerboayRtoDbxOi+IkLciR0g5EJf1ycCA?=
 =?iso-8859-1?Q?YIqnBt0mcrw7ZqMB0mbzwu3HQiGksDNnTZ+tkfw4qEImWmp8qQEpJuhW+Q?=
 =?iso-8859-1?Q?wG8JeAyCxVuWdhWuUAq3ncKf27q8UCyB7Jw/FnXFc2LlhNuYKmmJ7N0sXm?=
 =?iso-8859-1?Q?kd0Xj+844WWqM4V7AOP6l4kQo8NMXnl6fsLHtMfTBh6QBkiYUIl25x5ek+?=
 =?iso-8859-1?Q?jPYpJGkj6qvM7qj9Xh5fr4UtBQqFkTM0V3Ja3pcp0/NoMRMnhX2p+fEkll?=
 =?iso-8859-1?Q?UFp1ErmtVo47UFvmDXC2bSA/pZA+bzUxQbX9AtIIOUT8/eOHiW5LqTWOQg?=
 =?iso-8859-1?Q?2/XaO53N4hIOtKbm5P20Yin3HbwJffQmi/fbhQzeARkYKZTrkr1uYcgf1Y?=
 =?iso-8859-1?Q?vOqVtyLYBSQ1rePmiNvS6iyUAfv1RwLh7x0JGgwPdcJC81xDLP7igLoE80?=
 =?iso-8859-1?Q?PJYdr5FgHE+WzjYZg57/BZmVlnGamT2zG8WgktePnDWlJbXlIIg7CGwhpz?=
 =?iso-8859-1?Q?MXUU+WhfHyRkK4u5OUA2WPGrW167TDjQPwlzhQOYJ/Var98U8kiSMecxgO?=
 =?iso-8859-1?Q?/k+8zvv1X5TBZ5bPkAk3TtgoVcXbyBPmUgNWubOujrTeTJhe41PJMlaksR?=
 =?iso-8859-1?Q?amP8gbrs5f+ck6AuZ2Et/Ok/sPvgM19F0XeYsAmz8aCV53wW6h1mJXOf95?=
 =?iso-8859-1?Q?gyzE4KXkdqv1iyC/UTmd0YJLJ+FtbBDOUu8fuwL6pTNQT9aVNxBpgU0SHJ?=
 =?iso-8859-1?Q?6uz01fXhCOW3hRMJzeHaQhmbRfRY6CZpFrPQ3xEpboixKtLE0kyW/3hQxo?=
 =?iso-8859-1?Q?egQxPSVCp1Udlr1ywjBK/pX5dnFE7e2KPSdQjtnIYhRFYl0eJVfGc4w47P?=
 =?iso-8859-1?Q?5JKsRrYbW7QFaKSxTVYduDte5Vm+a4EXfK9cJeR97Ovy4wQ3rsnQXZoQcw?=
 =?iso-8859-1?Q?8qv12zOvaZQhJoAj40Wv6lzD3bGGE4vNPd9APS4NG3Wdsrn5JznBA2OE+d?=
 =?iso-8859-1?Q?WDcDDFpy2lrwpKIZO/L/BxxlHvaRcf8tuKbsG22S/eQ99/VnSNhtKlTVPo?=
 =?iso-8859-1?Q?A38HfLzNoFlLHaMB1kBoPlQiz7s0Ty7UKousEbW15QDXG9?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f061a4f0-7d2f-41ee-eb06-08deb84a273f
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2026 21:36:16.0434
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Cl1Df6fLZtZcj4HNfyFvj3idzJmgLm7wOLqYfgePjM/kKKyn524z/88+YBm8/9prL5prxVQhhX2Fkttk6hwwxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB9968
X-Spamd-Result: default: False [2.14 / 15.00];
	R_DKIM_REJECT(1.00)[nxp.com:s=selector1];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10771-lists,dmaengine=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[nxp.com:-];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@nxp.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	NEURAL_HAM(-0.00)[-0.988];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,nxp.com:email,sashiko.dev:url]
X-Rspamd-Queue-Id: 222875BA829
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, May 22, 2026 at 08:45:38PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:
> - [Critical] The macro accesses the descriptor after calling `dmaengine_submit()`, violating the DMA Engine API contract and causing a Use-After-Free.
> - [Medium] Calling `dmaengine_desc_free()` fails to prevent memory leaks for standard, non-reusable DMA descriptors, defeating the primary goal of the patch.
> - [Low] The fallback implementation of `dmaengine_prep_submit_slave_single` contains severe syntax errors that break compilation when `CONFIG_DMA_ENGINE` is disabled.
> --
>
> commit c731d16a7ec5a6fed71b17234ae1bc2184ad8818
> Author: Frank Li <Frank.Li@nxp.com>
>
> dmaengine: Add helper dmaengine_prep_submit_slave_single()
>
> This commit introduces a helper macro and function to combine the preparation
> and submission of a DMA slave single transfer into a single step. It also
> aims to automatically free the descriptor if the submission fails.
>
> > diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
> > index ca13cd39330ba..1e25be78a22a5 100644
> > --- a/drivers/dma/dmaengine.c
> > +++ b/drivers/dma/dmaengine.c
> [ ... ]
> > @@ -1619,6 +1619,34 @@ void dma_run_dependencies(struct dma_async_tx_descriptor *tx)
> >  }
> >  EXPORT_SYMBOL_GPL(dma_run_dependencies);
> >
> > +#define dmaengine_prep_submit(chan, cb, cb_param, func, ...)	\
> > +({	struct dma_async_tx_descriptor *tx =			\
> > +		dmaengine_prep_##func(chan, __VA_ARGS__);	\
> > +		dma_cookie_t cookie = -ENOMEM;			\
> > +								\
> > +	if (tx) {						\
> > +		tx->callback = cb;				\
> > +		tx->callback_param = cb_param;			\
> > +		cookie = dmaengine_submit(tx);			\
> > +								\
> > +		if (dma_submit_error(cookie))			\
> > +			dmaengine_desc_free(tx);		\
>
> [Severity: Critical]
> Does this access the descriptor after ownership has been transferred?
>
> The DMA Engine API contract specifies that once dmaengine_submit is called,
> the client must consider the descriptor pointer invalid. If submission fails,
> some DMA providers (like the idxd driver in idxd_dma_tx_submit) internally
> free the descriptor before returning an error.

Not sure if it is defined beheavor or just idxd implement as it. If it is
defined beheavor, suggest update Document.

From API document:

 "Once a descriptor has been obtained, the callback information can be
  added and the descriptor must then be submitted. Some DMA engine
  drivers may hold a spinlock between a successful preparation and
  submission so it is important that these two operations are closely
  paired."

prep_submit() API should be provide to align document. but not sure
if dmaengine_desc_free() call for reusable descriptors, Or providor should
consider this like idxd_dma_tx_submit()?

Frank
>
> Calling dmaengine_desc_free here would read tx->flags on an already-freed
> pointer on the error path, resulting in a use-after-free.
>
> [Severity: Medium]
> Will this actually free standard, non-reusable descriptors?
>
> The dmaengine_desc_free function is explicitly designed for reusable
> descriptors. It internally calls dmaengine_desc_test_reuse, which checks
> the DMA_CTRL_REUSE flag and returns -EPERM immediately if it is not set.
>
> Since standard descriptors created via dmaengine_prep_slave_single don't
> have this flag set by default, it seems this call acts as a no-op and might
> not resolve the resource leak mentioned in the commit message.
>
> > +	}							\
> > +	cookie;							\
> > +})
> > +
> [ ... ]
> > diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
> > index 99efe2b9b4ea9..0f789fac7e91a 100644
> > --- a/include/linux/dmaengine.h
> > +++ b/include/linux/dmaengine.h
> [ ... ]
> > @@ -1575,6 +1582,16 @@ static inline int dma_get_slave_caps(struct dma_chan *chan,
> >  {
> >  	return -ENXIO;
> >  }
> > +
> > +static inline dma_cookie_t
> > +dmaengine_prep_submit_slave_single(struct dma_chan *chan,
> > +				   dma_async_tx_callback cb, void *cb_param;
> > +				   dma_addr_t buf, size_t len,
> > +				   enum dma_transfer_direction dir,
> > +				   unsigned long flags);
> > +{
>
> [Severity: Low]
> Are there syntax errors in this fallback implementation?
>
> The parameter list uses a semicolon instead of a comma after cb_param, and
> there is a stray semicolon immediately preceding the function body. This will
> cause a build failure when CONFIG_DMA_ENGINE is disabled.
>
> > +	return -ENODEV;
> > +}
> >  #endif
> >
> >  static inline int dmaengine_desc_set_reuse(struct dma_async_tx_descriptor *tx)
>
> --
> Sashiko AI review · https://sashiko.dev/#/patchset/20260522-dma_prep_submit-v2-0-7a87a5a29525@nxp.com?part=1

