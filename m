Return-Path: <dmaengine+bounces-9091-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wKu8HY8on2nmZAQAu9opvQ
	(envelope-from <dmaengine+bounces-9091-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 25 Feb 2026 17:51:27 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D927319AFB5
	for <lists+dmaengine@lfdr.de>; Wed, 25 Feb 2026 17:51:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4B3AF30607AD
	for <lists+dmaengine@lfdr.de>; Wed, 25 Feb 2026 16:43:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5458C3D7D7F;
	Wed, 25 Feb 2026 16:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="IKhRkXBg"
X-Original-To: dmaengine@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011042.outbound.protection.outlook.com [52.101.65.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B2763D5247;
	Wed, 25 Feb 2026 16:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772037808; cv=fail; b=nhGJhpPFL6Hvs1Ums/wKcih3QhAxtaeafFvNBgIYFN5JJZiRgagqUcMupTmKfgL8GtECnu/3RA312gua9WlrzeTzBujSafTJhQif7aNji8ZHe4IJ6ixEfY76HRfw8ruLJUe/b7djlYfWXtBtlStbhEJl1tcD3TG/M3S629IR550=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772037808; c=relaxed/simple;
	bh=c9h0b+1bfiRtVfKJyPnQgDRxSVCkLbnFasCvvqHGf+c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=TIV+0G3zl0n4cflQWMS3H/j/c1PH0Vn6QN6dZwGZlLFmuofTZX8F83WVUuzIqj57Q8LCKK9Vlf75VqQayNZ5j573j3K8i/LN6R+efprFnpMhMD0FDK9FwUGtHfGil7jXjOVTX/7zjQvyTSxhi7KQnIIkjYWVqp0DvgbH0T0mff0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=IKhRkXBg; arc=fail smtp.client-ip=52.101.65.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UNYbPFO5Fiok6w4Otl75zv9FtH5SrsjQhXDaPzubu8wauuYxlFFqwBc2xgjlqB2fNRPbHNw2gKhcT3a4ikXmmeslwlHcHQXGsScyto/zG2p5VrXmf+1RUNkoKY4gYfgP+9bXCKpdcqGneggsd71zNki9gqgfkMy21dL76UeeRjlTaNNwbce2TKlSm8Kt6U+xfXxWSKBXTwBqGW9LFAi3vSo8YMgik93qLD1QAXum2uXlpb0Zk30YnML6kC72qpZaI9XTltRyES2nS4EOTOlDtXPFbuHnJHd6cfBZihMkL+Q5OHjSUM9rbd37PdETr+f8ma3lbsxj5etVCP8MIANVqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F3ZZofH3xjJh4A1JJVTTjCD6CGgVhE/4iPLml7yuSiU=;
 b=FS4aBFb3d2XyMXoQSrSd4s9WISzUodq+6BQ5q9NuDzCbx8w2p8YrzkC8W92hVy6qd5k7RhIiJPl3Jlw2uYUet/0nQhRqeE2OCP2o7SGdUh2uZf1qXnZ1bhEl5dlQyB7bBKxZqxyD4N+t5n05nNzoFVZtTqC/jmZRPhJM6YAdf8dP9bhmdoLj1eBSFEbvJoi8tGn02VDYFTNSN0fMOdYo29clnM/BVRs+QEeeG7E9A23MpXMZcegk4uhCyhgcbtyRvEPUlDbEn1ajw9RPBYWK8N8QjkWCEmQDqgqSwi66u8fuOFlL+nbY97MHvgF6UjkPOOGDq+VY3/jym+qRehUojQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F3ZZofH3xjJh4A1JJVTTjCD6CGgVhE/4iPLml7yuSiU=;
 b=IKhRkXBgWMsoo3RG/m3qy3Vq5XaHeB9BTYdKyZahagYwGpucrSj9UhtIg73B2AQDFOB+0pnl2kizDZ5HNP0fxWkDN9pToLzvKxKwESfqhuapQiQfmuWaSX5zEyj8MuxkNTUW4Ovr0e6Y4W622ZYauQ3MMZMhZBhaLEE9Ryph1zDhiHjs9VXUfbVNLTlalUljg9gCz4lJztZZqRq6sQPmpEm42NCQHEDwJ56zGi8KHaySaHbvqmBEYiYjZWM86jPXdV0Fy/TcvTFpWx/bCmM7KiHm/3TyzFWHeypLGueMUWFTHK1/kh3QtoSq8ENCHFcXAHhSIE2ESlJFPoeYHI1DRw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by DB9PR04MB10065.eurprd04.prod.outlook.com (2603:10a6:10:4c4::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.23; Wed, 25 Feb
 2026 16:43:23 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9632.017; Wed, 25 Feb 2026
 16:43:22 +0000
Date: Wed, 25 Feb 2026 11:43:16 -0500
From: Frank Li <Frank.li@nxp.com>
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: vkoul@kernel.org, geert+renesas@glider.be, biju.das.jz@bp.renesas.com,
	fabrizio.castro.jz@renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com, dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: Re: [PATCH v8 7/8] dmaengine: sh: rz-dmac: Add device_tx_status()
 callback
Message-ID: <aZ8mpBwOJ-opyKWi@lizhi-Precision-Tower-5810>
References: <20260120133330.3738850-1-claudiu.beznea.uj@bp.renesas.com>
 <20260120133330.3738850-8-claudiu.beznea.uj@bp.renesas.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260120133330.3738850-8-claudiu.beznea.uj@bp.renesas.com>
X-ClientProxiedBy: PH7P220CA0055.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:32b::8) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|DB9PR04MB10065:EE_
X-MS-Office365-Filtering-Correlation-Id: bf88b905-833a-4836-ccc2-08de748cfd57
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|52116014|366016|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	1eM6mTij5PaiMepjzk1d5tP/qgaSuSrIQxZcf+cq9HYcc9Cb7yHvEmIUvdnzRc5ZzmmM366JzgpNTAfHbGN10DMEg56ijme3FXcHXvSHFTvM5LjUyT5iyOF17WaU3YhdDerC5bttRhjgVLKp3rB08B93xv7OnYEAbh+cfGnKA2cF3JnN10IexQgrvhTREle4/in8dFTzdTsuzvzYGm7YwEW5tm94cfB2tUsy/oLkx80aKW6zCK6CVKoKngzyvwXBM5kdVAANZO3XAmqsxy+4kkNQnRjW2TAA47h4TT3/e8EdZ7yY4rC4aRG5o4fi4I5GQYW/Ynsj9OXpjKN62gLjuJLgkKxsVMEfbQ4RcpvLayNPSk9sGW4S8zNdq8l50TDNcMtsdylShKvvwlLpFHp9JTuAA0ijzl1ezaZpRxMJx5z56DypMadnxycKcZKBUjNlj5OGFiw7SXfGUANKFeiRO9xGz0LfoBVY35DhnqXY7/KaSkF1rQgbLZgnens1QL8INdPFDIYQMYmwvDh4g6tIfh6V3ki4ehb/b27mwQJQqcnGTIlbqA812H2luzEc/OjTROx//j54r/zOz14IqDXayvXzh8HQmTio2ztbBFchsMDm7o4gVb0/ycreYYnGeIqb/VFWLugGuyw4rxM0A0+MdpwdS96YzXkcyP3I1UwsMgsx/3XgzxTnMwz3t4FuD5KFUecRte8IbUDLAQ/RjnrKwPbQw6e/cpwnYJNsMDKWWiIm/GPuK3C8iHsWjMz/DN7B9o34meco8Yoer5XUKvHcmqsb1aVw7Fn5UNkN+mWHgVg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+6n8YH7wMLCvfWm9X/8fA8G3uuqmsqZ8UjFVM/kUG2xLGCyuec8B3wJRFxvb?=
 =?us-ascii?Q?P67syRKw7E1pjir5PhbGzSV7H7ID97Bb1rmUD8OQj4byhd5upa6qy6aJLdu0?=
 =?us-ascii?Q?lGzsbROHp0QCAxmW+1fTfNU0oSisIuyqWfpRPuRyGJvv+F8iH7HZllRP5QrM?=
 =?us-ascii?Q?xBWOPD4+TEz+D/wXuMzKVJfSCu6eDrJ+9bvfxc8FJ3RfatitXz6gyjEfJ22S?=
 =?us-ascii?Q?TO60DYGGEoLAJwZuV5ZtFq3PSqJAezS5DEZCIMNFYnIlISk4uWjjvHSQaGlC?=
 =?us-ascii?Q?M32qN/NwLO838NuVj1iaKFI5/07KNyDGkRjD2uS4hObrdyyNSa9I1+/Rjkbu?=
 =?us-ascii?Q?dnD1KMiVJQEX5q6UMfa4LZYNkO1xfwU9pxhbsdYMj78FboNfUimk8vN+dbBj?=
 =?us-ascii?Q?joDnZHWkzGoH8ed0e4oIde6ET5NFTrjfWLv0WiMEmLYYbvOYGOZfXG/XhAbh?=
 =?us-ascii?Q?rJSDqyHYmoALHEiMelLAw+y8svNqH2OpNxt51WAz4N7fiMf5YsUxvifzSir5?=
 =?us-ascii?Q?hqdopdIeRyMb2V0mcn0NLu9+XvCtVl3JPVoLpEBAKV1ZIQ8Ot/R4c2VIl8ox?=
 =?us-ascii?Q?Rlr6cZ1LJdolUt4tB9aRnAAlc+SeYl6PJV2HF1ebgKZGQ55TEvGQ94hOm8zX?=
 =?us-ascii?Q?UTCWbq/gBRZd01BQsQk7d/sKbjy4WBpd183MUoLaTOGUDHTjVy1gaPx17X5L?=
 =?us-ascii?Q?XGSGQn9HvCCE/zP753jakSIqmzWpYEcNj8VXC9AJE6Qvzudx2qn7WW082H1w?=
 =?us-ascii?Q?ZZjGTlZkk0BGcLwAYBcfIilXd18OFA1jPfmmjUYytXdLJlIPghigIbOEYn2Y?=
 =?us-ascii?Q?WnRxjhpIwaMCyv9EnBwH5E+sAi7KsGuPpx9/YCe0DTYDNzZQVfnzCUdxhsYC?=
 =?us-ascii?Q?KTJs9X790OFcjL97YYHIHA9OPd44tDVj/ovFTX1h3EVbACd3FTK54HVt6kbu?=
 =?us-ascii?Q?DpZdjtMRW+QwjHx5jL5JezqGYIL1Lsc+utYJmZOGx+y/K0myIqzh0yCKyfsA?=
 =?us-ascii?Q?xutI8mXrwX1ZK6dXvw/8eTq+TA1kzOGVHLucslkurlhz26vfQzWnJQ21oQ60?=
 =?us-ascii?Q?287XGLoLaHMIU53ph7jSS+vxy4NYZTnWQhNdTc6AdkZ0+edLo/fI8VuuYxmI?=
 =?us-ascii?Q?nPxHb0oVg9Vf1D+85RCkBjv1368TWKaB30CIS/X6HTRVnjt6/XaDZoUQQ9yk?=
 =?us-ascii?Q?zOwP7ePFhLCGg7yDcrsOFpY3lNyTh9iNS7e9riDv00CCVzGoCL5dwvTG87m6?=
 =?us-ascii?Q?FycsXxlJiGFRkdvKVIiNJ3EVXmahCI/SMtavh69JsOwdTUZaFqAhMF8FFNXL?=
 =?us-ascii?Q?t+Y97nJnqHKQxzMccks0G6rovS46fdQRVFdXtFx11FZtZXyYJqY/kgfod3TB?=
 =?us-ascii?Q?7YAVpcmNzJSclJdBmjp0quSKa3+IkpJQB2TIgPb418xEuFbO91zwZd5ZLxF/?=
 =?us-ascii?Q?UkZ1jFjM81WNdJMtIDS3r4ftZimDCK7JZcb5HouvpfUUaEEjmBzK41AvB21R?=
 =?us-ascii?Q?TOfCZzj8UuSd2mrLmeV6zXfwLTMrSH3ONHq7FEaOe21GoGPUot4juTQsNYfH?=
 =?us-ascii?Q?bDoZbBqPsb1DJ9K2VqhANYhF2lePIjuZV3pFWFyYj1yDGyfXRr1DWhEvQNCA?=
 =?us-ascii?Q?uVBr4YRHdj3p05/Mtb5YR4+IKLECcytMCANkUKg6LTeyyy8XMabT9zssqSU3?=
 =?us-ascii?Q?zS1/8q4dPMu9WvZmhIWZfqUDht4Zp+8F7tQrB2Xmpeo+gmMpJqr/4kWf4EUL?=
 =?us-ascii?Q?I8ICcyh7RA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf88b905-833a-4836-ccc2-08de748cfd57
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 16:43:22.9291
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kJTTIvpSGwGmE7Sc4+rJ21+6KPj/00Dtk/gygLRGguz5Iy9uSa/eAC9/Zg35f7oOtwdk7l3erZOc0EluBMEHaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB10065
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9091-lists,dmaengine=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[nxp.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@nxp.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[dmaengine,renesas];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nxp.com:dkim,renesas.com:email]
X-Rspamd-Queue-Id: D927319AFB5
X-Rspamd-Action: no action

On Tue, Jan 20, 2026 at 03:33:29PM +0200, Claudiu wrote:
> From: Biju Das <biju.das.jz@bp.renesas.com>
>
> Add support for device_tx_status() callback as it is needed for
> RZ/G2L SCIFA driver.
>
> Based on a patch in the BSP similar to rcar-dmac by
> Long Luu <long.luu.ur@renesas.com>.

If you want to give credit to Long Luu, any public link?

>
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> [claudiu.beznea:
>  - post-increment lmdesc in rz_dmac_get_next_lmdesc() to allow the next
>    pointer to advance
>  - use 'lmdesc->nxla != crla' comparison instead of
>    '!(lmdesc->nxla == crla)' in rz_dmac_calculate_residue_bytes_in_vd()
>  - in rz_dmac_calculate_residue_bytes_in_vd() use '++i >= DMAC_NR_LMDESC'
>    to verify if the full lmdesc list was checked
>  - drop rz_dmac_calculate_total_bytes_in_vd() and use desc->len instead
>  - re-arranged comments so they span fewer lines and are wrapped to ~80
>    characters
>  - use u32 for the residue value and the functions returning it
>  - use u32 for the variables storing register values
>  - fixed typos]

Suppose needn't this section

> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> ---
>
> Changes in v8:
> - populated engine->residue_granularity
>
> Changes in v7:
> - none
>
> Changes in v6:
> - s/byte/bytes in comment from rz_dmac_chan_get_residue()
>
> Changes in v5:
> - post-increment lmdesc in rz_dmac_get_next_lmdesc() to allow the next
>   pointer to advance
> - use 'lmdesc->nxla != crla' comparison instead of
>   '!(lmdesc->nxla == crla)' in rz_dmac_calculate_residue_bytes_in_vd()
> - in rz_dmac_calculate_residue_bytes_in_vd() use '++i >= DMAC_NR_LMDESC'
>   to verify if the full lmdesc list was checked
> - drop rz_dmac_calculate_total_bytes_in_vd() and use desc->len instead
> - re-arranged comments so they span fewer lines and are wrapped to ~80
>   characters
> - use u32 for the residue value and the functions returning it
> - use u32 for the variables storing register values
> - fixed typos
>
>  drivers/dma/sh/rz-dmac.c | 145 ++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 144 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
> index 4602f8b7408a..27c963083e29 100644
> --- a/drivers/dma/sh/rz-dmac.c
> +++ b/drivers/dma/sh/rz-dmac.c
> @@ -125,10 +125,12 @@ struct rz_dmac {
>   * Registers
>   */
>
> +#define CRTB				0x0020
>  #define CHSTAT				0x0024
>  #define CHCTRL				0x0028
>  #define CHCFG				0x002c
>  #define NXLA				0x0038
> +#define CRLA				0x003c
>
>  #define DCTRL				0x0000
>
> @@ -684,6 +686,146 @@ static void rz_dmac_device_synchronize(struct dma_chan *chan)
>  	rz_dmac_set_dma_req_no(dmac, channel->index, dmac->info->default_dma_req_no);
>  }
>
> +static struct rz_lmdesc *
> +rz_dmac_get_next_lmdesc(struct rz_lmdesc *base, struct rz_lmdesc *lmdesc)
> +{
> +	struct rz_lmdesc *next = ++lmdesc;
> +
> +	if (next >= base + DMAC_NR_LMDESC)
> +		next = base;
> +
> +	return next;
> +}
> +
> +static u32 rz_dmac_calculate_residue_bytes_in_vd(struct rz_dmac_chan *channel)
> +{
> +	struct rz_lmdesc *lmdesc = channel->lmdesc.head;
> +	struct dma_chan *chan = &channel->vc.chan;
> +	struct rz_dmac *dmac = to_rz_dmac(chan->device);
> +	u32 residue = 0, crla, i = 0;
> +
> +	crla = rz_dmac_ch_readl(channel, CRLA, 1);
> +	while (lmdesc->nxla != crla) {
> +		lmdesc = rz_dmac_get_next_lmdesc(channel->lmdesc.base, lmdesc);
> +		if (++i >= DMAC_NR_LMDESC)
> +			return 0;
> +	}
> +
> +	/* Calculate residue from next lmdesc to end of virtual desc */
> +	while (lmdesc->chcfg & CHCFG_DEM) {
> +		residue += lmdesc->tb;
> +		lmdesc = rz_dmac_get_next_lmdesc(channel->lmdesc.base, lmdesc);
> +	}

can use one loop

for (int i=0; i<DMAC_NR_LMDESC; i++) {
	if (lmdesc->nxla == crla)
		residue = 0; 	//reset to 0;

	if (lmdesc->chcfg & CHCFG_DEM)
		residue += lmdesc->tb;

	lmdesc = rz_dmac_get_next_lmdesc(channel->lmdesc.base, lmdesc);
}

return residue;

> +
> +	dev_dbg(dmac->dev, "%s: VD residue is %u\n", __func__, residue);
> +
> +	return residue;
> +}
> +
> +static u32 rz_dmac_chan_get_residue(struct rz_dmac_chan *channel,
> +				    dma_cookie_t cookie)
> +{
> +	struct rz_dmac_desc *current_desc, *desc;
> +	enum dma_status status;
> +	u32 crla, crtb, i;
> +
> +	/* Get current processing virtual descriptor */
> +	current_desc = list_first_entry(&channel->ld_active,
> +					struct rz_dmac_desc, node);
> +	if (!current_desc)
> +		return 0;
> +
> +	/*
> +	 * If the cookie corresponds to a descriptor that has been completed
> +	 * there is no residue. The same check has already been performed by the
> +	 * caller but without holding the channel lock, so the descriptor could
> +	 * now be complete.
> +	 */
> +	status = dma_cookie_status(&channel->vc.chan, cookie, NULL);
> +	if (status == DMA_COMPLETE)
> +		return 0;
> +
> +	/*
> +	 * If the cookie doesn't correspond to the currently processing virtual
> +	 * descriptor then the descriptor hasn't been processed yet, and the
> +	 * residue is equal to the full descriptor size. Also, a client driver
> +	 * is possible to call this function before rz_dmac_irq_handler_thread()
> +	 * runs. In this case, the running descriptor will be the next
> +	 * descriptor, and will appear in the done list. So, if the argument
> +	 * cookie matches the done list's cookie, we can assume the residue is
> +	 * zero.
> +	 */
> +	if (cookie != current_desc->vd.tx.cookie) {
> +		list_for_each_entry(desc, &channel->ld_free, node) {
> +			if (cookie == desc->vd.tx.cookie)
> +				return 0;
> +		}
> +
> +		list_for_each_entry(desc, &channel->ld_queue, node) {
> +			if (cookie == desc->vd.tx.cookie)
> +				return desc->len;
> +		}
> +
> +		list_for_each_entry(desc, &channel->ld_active, node) {
> +			if (cookie == desc->vd.tx.cookie)
> +				return desc->len;
> +		}
> +
> +		/*
> +		 * No descriptor found for the cookie, there's thus no residue.
> +		 * This shouldn't happen if the calling driver passes a correct
> +		 * cookie value.
> +		 */
> +		WARN(1, "No descriptor for cookie!");
> +		return 0;
> +	}
> +
> +	/*
> +	 * We need to read two registers. Make sure the hardware does not move
> +	 * to next lmdesc while reading the current lmdesc. Trying it 3 times
> +	 * should be enough: initial read, retry, retry for the paranoid.
> +	 */
> +	for (i = 0; i < 3; i++) {
> +		crla = rz_dmac_ch_readl(channel, CRLA, 1);
> +		crtb = rz_dmac_ch_readl(channel, CRTB, 1);
> +		/* Still the same? */
> +		if (crla == rz_dmac_ch_readl(channel, CRLA, 1))
> +			break;
> +	}
> +
> +	WARN_ONCE(i >= 3, "residue might not be continuous!");
> +
> +	/*
> +	 * Calculate number of bytes transferred in processing virtual descriptor.
> +	 * One virtual descriptor can have many lmdesc.
> +	 */
> +	return crtb + rz_dmac_calculate_residue_bytes_in_vd(channel);

you don't use varible 'ctra' here, so retry 3 become useless. suppose
rz_dmac_calculate_residue_bytes_in_vd(channel, ctra)

and avoid rz_dmac_ch_readl(channel, CRLA, 1) in
rz_dmac_calculate_residue_bytes_in_vd() to keep ctra and ctrb reflect the
correct hardware state.

Frank

> +}
> +
> +static enum dma_status rz_dmac_tx_status(struct dma_chan *chan,
> +					 dma_cookie_t cookie,
> +					 struct dma_tx_state *txstate)
> +{
> +	struct rz_dmac_chan *channel = to_rz_dmac_chan(chan);
> +	enum dma_status status;
> +	u32 residue;
> +
> +	status = dma_cookie_status(chan, cookie, txstate);
> +	if (status == DMA_COMPLETE || !txstate)
> +		return status;
> +
> +	scoped_guard(spinlock_irqsave, &channel->vc.lock)
> +		residue = rz_dmac_chan_get_residue(channel, cookie);
> +
> +	/* if there's no residue, the cookie is complete */
> +	if (!residue)
> +		return DMA_COMPLETE;
> +
> +	dma_set_residue(txstate, residue);
> +
> +	return status;
> +}
> +
>  /*
>   * -----------------------------------------------------------------------------
>   * IRQ handling
> @@ -1007,6 +1149,7 @@ static int rz_dmac_probe(struct platform_device *pdev)
>  	engine = &dmac->engine;
>  	dma_cap_set(DMA_SLAVE, engine->cap_mask);
>  	dma_cap_set(DMA_MEMCPY, engine->cap_mask);
> +	engine->residue_granularity = DMA_RESIDUE_GRANULARITY_BURST;
>  	rz_dmac_writel(dmac, DCTRL_DEFAULT, CHANNEL_0_7_COMMON_BASE + DCTRL);
>  	rz_dmac_writel(dmac, DCTRL_DEFAULT, CHANNEL_8_15_COMMON_BASE + DCTRL);
>
> @@ -1014,7 +1157,7 @@ static int rz_dmac_probe(struct platform_device *pdev)
>
>  	engine->device_alloc_chan_resources = rz_dmac_alloc_chan_resources;
>  	engine->device_free_chan_resources = rz_dmac_free_chan_resources;
> -	engine->device_tx_status = dma_cookie_status;
> +	engine->device_tx_status = rz_dmac_tx_status;
>  	engine->device_prep_slave_sg = rz_dmac_prep_slave_sg;
>  	engine->device_prep_dma_memcpy = rz_dmac_prep_dma_memcpy;
>  	engine->device_config = rz_dmac_config;
> --
> 2.43.0
>

