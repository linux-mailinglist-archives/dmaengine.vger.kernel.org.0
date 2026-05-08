Return-Path: <dmaengine+bounces-10281-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sF0rF7w9/mlmoQAAu9opvQ
	(envelope-from <dmaengine+bounces-10281-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 08 May 2026 21:47:08 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CCBA4FB3EF
	for <lists+dmaengine@lfdr.de>; Fri, 08 May 2026 21:47:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 780F5300D4DE
	for <lists+dmaengine@lfdr.de>; Fri,  8 May 2026 19:47:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2FAF344D95;
	Fri,  8 May 2026 19:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="O14hqRW5"
X-Original-To: dmaengine@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013050.outbound.protection.outlook.com [40.107.162.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44D833C1F;
	Fri,  8 May 2026 19:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778269620; cv=fail; b=lAnhrSjEanHuU1VXA7cURbjf3u19JpwJqi0Trt7wKJAAzLjw17Al8coKmgfSkC6Rs/p6FbO7DJD/8T6Dfr+Q6aT3t9M2lSv64Kyun7zzReIrCjnMG5QwsKqF/idYD16YO6s+Smh5iGcdTdXgu+olOeXdVaBgQYRZz3yEIHCwVPE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778269620; c=relaxed/simple;
	bh=LOz0Piozl/PrrnXEKfvhlt6ZuEp/eExHaICWCpKDj6Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=pQ/Z/zbLGOLet8cijH9gEz7MB2rJSXb86Sg4OQGTaHD+YtlpuGlISX1GrVk3E+Ch7VpMZ0K9TrY7bIID0lN89lqsJ2QOqjWLQkSOduemOvGCtdBLoaI3XnVbQYt0RYuIjhk8GeWz7nFqZ70Tlkqe94OSYPeF0gra3hkMaMGw+FY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=fail (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=O14hqRW5 reason="signature verification failed"; arc=fail smtp.client-ip=40.107.162.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WMNOmPg31IQGUksPJueRcA/Auik583i4rxlTzdvF4/18ONv9H73fCYj8xxWrFn0f2AhkJR9iOXeuR4bWHO/175hgMCxvBrdL3WC3N4tYh5YWA8iPMC/JzinHpkLjCWDD0HOcIqGl52hbjM5g0XZAXkB/DR3N3mM+kw2I+ouJHTohL5fa9rWU1hN3bEzrLMf6OakffGDKodkapb2U4jqdrBWkrazzBrT4lQi8pCKhM3ic3S9ufedMIcRnqqA2Cyk/Da7XLajy6NWzLNMnEbvulDiTFxhmsj8Qi2ueYxSkFR5uScic6Qb/UrqD6E4Prte0w42nUkX5MNN8eJomBpz//Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hwxL71o/MZwNgSpWHb1zl1stkaLgbVI3cXxFMXIAjk4=;
 b=e8bwr112M8D6X1xzobh5GVkNOu/QeHfy4S2FbMQz+DnubasebTF27L2jNU3TtpUxDr2iz9/NzCYREGUhShY2dtTc52zN/IbTe783JW60PtqLqcW0R23q6L3ROJLd1GOELWIeoOnmyGzE83bvwzgmVZ08SRXAo4QZ5BbQSufgIplMhgOtizjuWtsBlJHmSUkn9KVNcZ+qOXJtGOzwuM6okL/KEBafVSSymsHP3FSj+N7vuQ/LH6TK7J0jRzaUTW8kdYgv/+jbgMUqXdPj57uFsORheS2vcBdnpxNAQXJ26Dp5y3I1maf77PcUeYbwrIe9yhKKfH6+bk/SDxn+Jy/G4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hwxL71o/MZwNgSpWHb1zl1stkaLgbVI3cXxFMXIAjk4=;
 b=O14hqRW58Nu9K5rk7xRAeXYBc/5QqwpHzBaPxwCKgWROhnGvDNYVt56Rfs7chcCwmZyhHa9AsrssSu9HwgloHVzT2LW2/VKNcArq7NFTdS5UwikmStp3RFAOMJSp3ybqKj+lzdtEXYf/LeRK7vtU1vCxb/gFkgkiQtytGF9wFrWTilT5agWmozZNEia1/KeX1YjMGbOHLASC8dEahepkB1OutqEC+ry38tuWSf3lFA19bMHboPU+xpXJss8PAuO9IynYZqSbCZy7xVIv0GxnM692Z5YuPDKpt1YkWdO/KM2R1e8LBBFkx7l2Ol6pp1KLpMuRa5hyqFUSBxl3cbDlmA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by PA4PR04MB7951.eurprd04.prod.outlook.com (2603:10a6:102:ca::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.19; Fri, 8 May
 2026 19:46:56 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%3]) with mapi id 15.20.9891.019; Fri, 8 May 2026
 19:46:56 +0000
Date: Fri, 8 May 2026 15:46:49 -0400
From: Frank Li <Frank.li@nxp.com>
To: dd <zhongling0719@126.com>
Cc: Hongling Zeng <zenghongling@kylinos.cn>,
	ludovic.desroches@microchip.com, vkoul@kernel.org,
	Frank.Li@kernel.org, djbw@kernel.org, nicolas.ferre@microchip.com,
	maciej.sosnowski@intel.com, dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: Re: [PATCH] dma: at_hdmac: Fix IRQ leak in at_dma_probe()
Message-ID: <af49qdT5TCjJ6aPU@lizhi-Precision-Tower-5810>
References: <20260507075750.14310-1-zenghongling@kylinos.cn>
 <afzY9B9lGrfWMWUh@lizhi-Precision-Tower-5810>
 <1a41b0d2.11d6.19e0537be23.Coremail.zhongling0719@126.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1a41b0d2.11d6.19e0537be23.Coremail.zhongling0719@126.com>
X-ClientProxiedBy: SA1P222CA0043.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:2d0::17) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|PA4PR04MB7951:EE_
X-MS-Office365-Filtering-Correlation-Id: bbbf3646-bee3-41bd-3091-08dead3a8f8e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|376014|7416014|52116014|1800799024|366016|38350700014|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	KbcSKhoHYCaj+quhsPzNLCPvOVZebe04hggTN7O5Tu4E1XN6B90Z9Rd7CcdJ39U7rhl8FUOyOStFWIrJ4e8TbmwWnE7O1eWSu9Judn54PaIiNlH7noHhEEBScJv2NZ/bEqU5gz+HMczPEmmDp5+ZGfZjndLBpgms8ND4EGiUkqt3sTPE/m1tydDbUAXz1tOatGuWDzlbfnjM8jI2xRNQBOXXo//pw2tvWWbJ2AsEPZDG092v/b/ShDDdnGo6CBhfpO3QH+vbHnMRuyiSbjhWUFelC0NYHrmpSB3hjXuoN1I/rHtktAk7fN0BeWE1wQQUtVX+09Ppx/smaUWasVrGQDQibQ08U77zYxfyCvZEGeBfCMD0z3uzWQktp/PB1FBOTj75BLlNGZIZqoEMMM2AsuMy8WXyo6je04IVYTDy6CmewlQ1paLJAmyADmmzjjXx1wYSJatlD0WvMcVvIvr9ptBzZCmfcxtLBBb6sLqHr+KdK6KztU7oad2Ndjs/f95Do5p0c5ageMkKNVQj8J6wknbU93MLNHabbkKGaKluIZxplLh6uYMrXy9yHC7OCahdftZjLbOblDJypsD8mR+oDvegQm1Vci5pBSTSIXdaQsJyES2iYU3uXHq0kWZ3yJM7tYIu3/xF79YRjlvd3aVMtvL25TeIhVwErxd5Na9R7n84d4q8Ai7LWXxdYUB7aQqWFF0e+6JihnENZoiiNukZlouSv6H1LzdCOXv4XUI+CjiMZHRXyu8KMUdVbY2tvkzq
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(7416014)(52116014)(1800799024)(366016)(38350700014)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?DmbEBQw8k2ci+dDCyWhzZrdBAccPwFFc0zx8Et3SPxNmB/l98XKOdijwmw?=
 =?iso-8859-1?Q?AKZQfbrr3rZFHZvkhODsHSXlYuWX9LlkFGIqBsjqmrQlnHfbN9KJR1wWHn?=
 =?iso-8859-1?Q?rPdoNCsZO6DgMYXdPcjHlq8LAmzImNOe0Ma+S5Bco2N8BOz1UH/c6hc6FZ?=
 =?iso-8859-1?Q?2AJj9/bomVKoowydzLl4YrUTE/fyBMgS8zI+wsh5rGJRDnSAWjt9Is7Ezb?=
 =?iso-8859-1?Q?/ZEo/MJayfGUD3YJv8PztWLdlOk40NR8/txa6pvL6RI9EWAF0F17HNmyvU?=
 =?iso-8859-1?Q?ozKUz7HosS44mjYiFCjereZQHJpgmEcj5v754X59lrgV87Y/4zVj+suSQ6?=
 =?iso-8859-1?Q?w05H46i1GgY1UPcI9Hva39piaudc4Cdg5ijXpeGJQBi7c676NwpX6ByZJU?=
 =?iso-8859-1?Q?z3ilRBhkLQZI1drfAHI1cARGTsQOc/hD9ncHr2CPP4rTdTXZ+ofRnvV98S?=
 =?iso-8859-1?Q?OLrX93pZ+xq6ZUoWW4zxqdQIjDhYrw/6wNOme0gR9iFYlqHicnkxUxX/M6?=
 =?iso-8859-1?Q?+JaCBT37gPVF+6jcpSOthpb6k7sU1EErgBRTv7ScjN1fTyiwZoGaHyJ6/9?=
 =?iso-8859-1?Q?q9aR3M3EvED9p7lr/mmLVtGyYssaDKavTLIPsZ38xQngQnwYPGbYO9Am3U?=
 =?iso-8859-1?Q?bwDvQfAYhveE1rw0ZVQBp9y7LDYWIKmxe1c56gbzJtTRQFp/p0imJoIe2f?=
 =?iso-8859-1?Q?21BPvH6TZCNbJ6mt6GHFoPM9wSPXffvpQauFuPrpTh3Sk8sA6hdtLZselC?=
 =?iso-8859-1?Q?ysWtikQX5/ldpixp/D41Y94Pq7FWwA5qORWcjWtU9r/7ecS4PvE/ipqqzs?=
 =?iso-8859-1?Q?uL3VaiiKo0hM6CE26N2UWWfxjkm14QR3duNa80UDHJpKhsEKdDG0jzeMyU?=
 =?iso-8859-1?Q?eW3ylercswQO3q+qyggu6bXAvzCDXsSxhilu+HhNqYn/3nH3B4urjPOn3a?=
 =?iso-8859-1?Q?pqekByhfhDWRM6aBoCmYiISxz+ZsJjDNsYkydE/vcbmKuIv45xw3OmAGcx?=
 =?iso-8859-1?Q?5u3aYh1qD/WQlNwKUXp+3XB0uMXy0Two85gZxqB7hjzDXdeJErsWtTLUMB?=
 =?iso-8859-1?Q?jqt16y5ShwLevHsMV8613NNj3I0/GnzgIor02eXduY2os8AnJoUDcltT2c?=
 =?iso-8859-1?Q?SH13lx+dNzeBIaE5+U4oxhawZdhIhvCL74FsrilaefSVVmph6S8LCo5t7Q?=
 =?iso-8859-1?Q?38VTEJtTHwUbBRAvS47+nyD3uT/NzfxBApCDVvryxyENyuOr89i5PN64ob?=
 =?iso-8859-1?Q?fkkUIRfIGfTGwsjXgu9PwaLod3pHZ1/CthatH20dezno59jrGiHrx+boRy?=
 =?iso-8859-1?Q?Le9J4eANuCcTI7lL4GYZuZ5rrUZHYj/M1Fi3IzAoL9LVYkYcOM6esE4wcz?=
 =?iso-8859-1?Q?Ka30wu5Mw9pEY3/GAwY1Dw2sVIX23LLyx+80VwRAZ9vvotKek2mmA3QmSY?=
 =?iso-8859-1?Q?oZlj8HN1dr5RhfsWvtZv1DnsJJkNZ9rFyy8jgBJqH0b19ZVJY+C9ynNT+6?=
 =?iso-8859-1?Q?bjIPAAJtsN3L8UZ3CcDp7PBPGQw8fEN4WWfjKcViAndM/RPLeFjoQJ7v+A?=
 =?iso-8859-1?Q?IX268r9oX3cF3jMKJpfOeTOanHoroFOGp6ZYfFP2M/n/lI/+Mnl3oHSbwy?=
 =?iso-8859-1?Q?/sxdYUeTzRx4Pf7Id7UDxbY727LxJ4KXQ1t8tDOishYRP0i1PoYZFVzeRY?=
 =?iso-8859-1?Q?URXOaImylDiviNVEUyNlx0PH84mZGGRgUPXZbEZt5H66qaFERV0RRuOZKX?=
 =?iso-8859-1?Q?epF9g/tupBbSwhAFIsuS7+PVdN/inWQgMJW2h6jWq2sFT8GiKD3cUC820/?=
 =?iso-8859-1?Q?vzZXOe10IA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbbf3646-bee3-41bd-3091-08dead3a8f8e
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2026 19:46:56.3963
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PSxr/fLouQHdekER+tON9OUS5sWGjKLU+ZuaIRP1W4piBIGvBjwl1+R/GKtQJZWAENl8CZ+4QWniBzNxtousww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7951
X-Rspamd-Queue-Id: 5CCBA4FB3EF
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.14 / 15.00];
	R_DKIM_REJECT(1.00)[nxp.com:s=selector1];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10281-lists,dmaengine=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[126.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:-];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@nxp.com,dmaengine@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.996];
	TAGGED_RCPT(0.00)[dmaengine];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

On Fri, May 08, 2026 at 09:33:19AM +0800, dd wrote:
>
>
>
> Hi Frank,
>
> Thanks for your review.

Avoid top post

>
> You're right that in the normal case platform_get_irq() returns the
>
> same value as 'irq'. However, this pattern triggers a smatch warning:
>
>            drivers/dma/at_hdmac.c:2110 at_dma_probe()
>
>            warn: 'irq' from request_irq() not released on lines: 2110.
>
> Static analysis tools cannot guarantee that platform_get_irq() will
>
> always match the previously requested IRQ, so they treat it as a
>
> potential resource leak.

It is false alarm from static analysis tools.

>
> Using the stored 'irq' makes the error path unambiguous and silences
>
> the warning. Therefore I think it qualifies as a small bug fix rather
>
> than just cleanup.

So it still belong code cleanup, no user visible impact.


Frank

>
> Thanks,
>
>
>
> At 2026-05-08 02:24:52, "Frank Li" <Frank.li@nxp.com> wrote:
> >On Thu, May 07, 2026 at 03:57:50PM +0800, Hongling Zeng wrote:
> >> When request_irq() succeeds but a later error occurs in at_dma_probe(),
> >> the error handling path attempts to free the IRQ by calling
> >> platform_get_irq() again instead of using the already stored IRQ number
> >> in the local variable 'irq'.
> >>
> >> Fix this by using the stored 'irq' variable directly in free_irq().
> >>
> >> Fixes: dc78baa2b90b2 ("dmaengine: Atmel HDMAC driver")
> >
> >Any actual problem do you meet? suppose it should be the same as 'irq'.
> >
> >of course using varible irq is correct. but this patch should belong code
> >cleanup, not fix.
> >
> >Frank
> >
> >> Signed-off-by: Hongling Zeng <zenghongling@kylinos.cn>
> >> ---
> >>  drivers/dma/at_hdmac.c | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/dma/at_hdmac.c b/drivers/dma/at_hdmac.c
> >> index e5b30a57c477..2a860679b9e1 100644
> >> --- a/drivers/dma/at_hdmac.c
> >> +++ b/drivers/dma/at_hdmac.c
> >> @@ -2109,7 +2109,7 @@ static int __init at_dma_probe(struct platform_device *pdev)
> >>  err_memset_pool_create:
> >>  	dma_pool_destroy(atdma->lli_pool);
> >>  err_desc_pool_create:
> >> -	free_irq(platform_get_irq(pdev, 0), atdma);
> >> +	free_irq(irq, atdma);
> >>  err_irq:
> >>  	clk_disable_unprepare(atdma->clk);
> >>  	return err;
> >> --
> >> 2.25.1
> >>

