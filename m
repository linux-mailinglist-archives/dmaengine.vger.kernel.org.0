Return-Path: <dmaengine+bounces-9726-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iMofFWWQymlV+AUAu9opvQ
	(envelope-from <dmaengine+bounces-9726-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 30 Mar 2026 17:01:57 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A478635D5CD
	for <lists+dmaengine@lfdr.de>; Mon, 30 Mar 2026 17:01:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C94DC3007AD4
	for <lists+dmaengine@lfdr.de>; Mon, 30 Mar 2026 15:01:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2082332901;
	Mon, 30 Mar 2026 15:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="daPZToF7"
X-Original-To: dmaengine@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013006.outbound.protection.outlook.com [40.107.159.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EAA52E22BD;
	Mon, 30 Mar 2026 15:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774882905; cv=fail; b=Q0sbTELjsfOQNCyaM1rhWOdgW/pOrBB4HQcIWA88pY9Tm2RK4pzbrIB1kV9t1Op7XNk3/Kbtjx2Fkuak7okETymAWPoKGELplm9C5bQmpqPQFGZQff0CcJYvn7h7nwUPvvNE0fIHQPaX8//xgTt8eW5SE7FfvTu29zsTnbuuE3s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774882905; c=relaxed/simple;
	bh=t0BTAVZbMNbVBsKI/hq7W3vK18Xc00Rm4VrgTV6kB4U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=HqMRQmW4b1H2g7FrQ7ZY/R/ECECbPpoFzRWHFEbehlHVroB0krGP8MhkNkRGOMGbfPRH1bjgen8hh4yigYYlQKnMz7Sjvfk8To0HWJWrXLsg/y0FFQq1Q4QTOYy3aS105QiZAaQFeDwjbPfKXiiKWhHcRmiR6XNSCqpwIdMNr/k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=daPZToF7; arc=fail smtp.client-ip=40.107.159.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FtH4R66ZQzf4gERf4DUU1fa5Znx4pNcLyQJQ3R4thmI6JDWmxRID8ytp5ZPkPnAy0vWdjxbSULqJxrLfBj+SnDofzLr2uiWvdgYkUrVIAwb6Epss0u3JVD7+yrvXBTA5vbujedVgRnpQpAOH5sSyRBV/ANTNRu+TYWRVOFCRDtF/5QQ0s0veFBCMMLxCe3nQGAI19lX8X3GXiWD0/8RLQf0/IQbVVv2CvBD4ZpvjolRD2UHW6lIiYtrFRopN0oLv4OLVbCPZeYnQVxBld1lyPtQ8paHajXDJ/5yPzueb1jAWXGCOUXSU03rZqJ6F+jRqnFLssy4afuKbUunnEb1c/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/4UvGom6nHFC/D4c8t5Mg/fpPuO7UndPGsNPMndR/9A=;
 b=ULK2wT+wor6Wl6RCMHFKPJxzxTm4lA8xGuzk/wDi3/TSxMn5/oUot4wFK59NaECxsjEh9qzSV7yI9H6EI7Izrq8j81Ti1vQV3s1ae6BSoXBhZdqIKOYY294Tmlh9C5gWwoXB4aUtsvrdZ2daYmQWwwRA2L/24cgyu9+OV+5rQZLZ9LASG6oF3wUu+HvNjNC0CC2YpXuET2FjsP2dnHvRi1YOtXMbQhvvOl608pBp2rPgqwBny09gbUrAAIUXKoukXGFoIrAA5bU9nBU0liDWZWsGO5+8fWEPVWWBXvT750tYECceD1Yt/bTbvHHhoFB7sdH0AyHgeMkAKu4bcuXJBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/4UvGom6nHFC/D4c8t5Mg/fpPuO7UndPGsNPMndR/9A=;
 b=daPZToF7fQDT66xU1Jn/k7f0yjNLzCe0WJOEiscb6RMkuOcR4tCzWrEBtoxlmBOek8wYoRiaCzQ8W9Fn3rcbDXw/mEPgtqfoEbdMKLAjOQzuLlSulh2PK6CCV4UW8sAcSa5KOISWlARbSXHURxHUvpAX05Yjo9n97AqoojurP73hVjlMBoiKwtIf/dnRdd8MCa/9jhabnMFBirmOXrcIimpZY7Zxt58qrho3gKp7xaxOg/t1VAdaW95on4H72Id42TZivmMPcTgq/qOgXSVp/v6JtyuIRTDPeTZ6tOGWBLUyYjObUzEbqzbEmi2wixeL88TPObO3lqZ5DOQg8eWqJw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by PAXPR04MB9229.eurprd04.prod.outlook.com (2603:10a6:102:2bd::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.28; Mon, 30 Mar
 2026 15:01:40 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9745.027; Mon, 30 Mar 2026
 15:01:40 +0000
Date: Mon, 30 Mar 2026 11:01:34 -0400
From: Frank Li <Frank.li@nxp.com>
To: Khairul Anuar Romli <karom.9560@gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>, dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org, Markus.Elfring@web.de
Subject: Re: [PATCH 1/3] dmaengine: dw-axi-dmac: fix Alignment should match
 open parenthesis
Message-ID: <acqQTmr5ti8RWfnV@lizhi-Precision-Tower-5810>
References: <20260328025706.52722-1-karom.9560@gmail.com>
 <20260328025706.52722-2-karom.9560@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260328025706.52722-2-karom.9560@gmail.com>
X-ClientProxiedBy: SA1P222CA0092.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:35e::12) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|PAXPR04MB9229:EE_
X-MS-Office365-Filtering-Correlation-Id: 88d1c4b6-d782-4d88-9180-08de8e6d3f15
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|19092799006|52116014|376014|38350700014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	ooNBos2U5dVceRvhTaE5uEy2K1V+/LohnkO9SddFmDaEQChfrBDrcXIfl4ZrwQpJF0CM5mKYVO1GiBpGqIeXDGRcFCuDhGaBLykc0+/NkeJz7kSgvYQuicECqViOPzk8fcRGkPdyDY7HCbNhsh3c2fIZJdBHkFBnLUHp/xJ9moR7hY9ObRI4iDqsydLn4/KLF7q+ACGzgEc+aZZT3txlGPzrMw6mXNQ563yb1ixmtqZ2y9iZg7fc2Cp+Ka1jhN2JbYeWNvD0C+vcMpRrJUHahmM0eV1emUFqE64U5IAbB8ZvZJYUy9EoOcIGfgOS54CtJupxpVm5F5cK3kEYPXsqB91j5oGMajresHgr/rBTgRTD1i9JfErcwcIslmZrRzY/X4bjCczsrOQAflgkAgfs4AH5rTwmYsy1nkJIhiNlBR3q9jKgNObaUGJj81xGp6GI57K42963ShT/nyaiiLleVMOwym2lyLFmXTHhFVZIWrJSqs1ZEkDr5++mF8bkF1Ff1R1KVCNG9cOoC0qunr6jnLxfXCRqT0Bxpnlmnzpl0PZ71cc8V8SdRcawQNx4dRn0Zj2GvUq/uSDTC4Ez63rd29BvEzHFiXmd+Ys0RSRpSdD9q6sf3+9McBeZGbfJOUlqZBZnL7JEvffVWoj2lr+C5SCMJ0UwkDuCnY8HrjTgp7/N35F6NRdCYrJXq+AXATsiurCcYL+vF3wDjwpNUvCyLvdUlno8WRf5yRtb3J0t/IxIv+yqrb5z37eryQ0UIzjGJOZT+pv3aCUqnehBhJxhSVDRHbouPS5bvxMOeR6QSqM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(52116014)(376014)(38350700014)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DA7bt4ZYsWrKmXWnQ2Vi87V3yVJLku7LYm3e+p6yUxi1FBb3EVIurbl8mmer?=
 =?us-ascii?Q?s4lHiLK1eyuthPEBKk54PBwB/qEr4gpUXkb6qZDuZqPAhuGgdbL+xlx5R8XH?=
 =?us-ascii?Q?IjsVVMP9NNocaq3IA0GRaqz3WgUUumz3ywt06XemAUVmDkVsfTSaURqBJ0vZ?=
 =?us-ascii?Q?v7jEtRT3dnf0RsjGRuEWig2PZOcnTr/vIWI/IyOcG20D6Fq62rCORD4l8grg?=
 =?us-ascii?Q?NUmtIrh4SawSjkiJIBHDVkPzRiviDPhRbIu4zYHenn0zBsvZQ+dPOiS8jpgt?=
 =?us-ascii?Q?lknIECO39yaJ0IQXSedZv6ub8Ou2cd5mjdK0QPQdtRtsVhDg47KkF8jKJQDb?=
 =?us-ascii?Q?VD4KV87rSZPWaziP+suyLFNlgmusa0r7JeysncaIxGYzNQZQUp6zAfRCnq4R?=
 =?us-ascii?Q?UXmpywMyemqn5UL+s4ms1WksFD8QplU1oi4W/vJaieFcUp/9vb+RMGXvq8+v?=
 =?us-ascii?Q?b88duY5RA8j4yx3rBvW7oASk36hBPes77PoYhnrFQCK8V1w4PXAU1w15zAE4?=
 =?us-ascii?Q?NiAtOzvlF7rTwvRIOWslJ8eUIBCtenzJS1+02pONZL9bYCiB7R79YPbTviyT?=
 =?us-ascii?Q?uBZ8Pc5VZhmp4wCoQvgVJlOsvN9lE1FOZ04NvgBVzQubDTr69kAepyAI3SVx?=
 =?us-ascii?Q?awX+PmsYO2/I9RnYjsOIKkESS0vYT8hfE4lfbT4Yp3KlLiFefFf3e4LZ0SSD?=
 =?us-ascii?Q?SK4t6lzfZx6D/kk0C4+hShpY/5urP67Yw29N7lbpQJYyqa0fY6zt/crfpDof?=
 =?us-ascii?Q?/U7ELJ1D+fezfCXjgG25XzkcmhxwPTPWy6qj0ZJu81qf/6yDphJkY3GUb0My?=
 =?us-ascii?Q?uVRHbKHRmj4wiLTRhVrn5Rh/Xaiop3PiX9I7OYAlMcvl1tdSSacyrhz1JDRS?=
 =?us-ascii?Q?I7ZHHEcRonszQJKcGCmOBY5W+ONm4gWpGpNCicoYdrei3JjnWoQQxpitL0w1?=
 =?us-ascii?Q?IgxChlp1DV46W3vuFNuT+VC1xzcPQisD5zxLM73R8RaVPNKb+B3nIPjH2+c7?=
 =?us-ascii?Q?4YZi+CoAbhfwqTjW2d+9HcVFuo0pXCWaLYtKXlntzAGGG69MJc6TvDvEinr3?=
 =?us-ascii?Q?ygOxEEyFEqr1pNxpxslCKPMKsAxjbFi2B67gGTHhYRsf0DgZi4Iuj02tAQGb?=
 =?us-ascii?Q?3Ndn9REQyYVJEPewXdt2hfoWEyZprqeyP3OIbtIZpyShIN/LPAeBlfo5bG5O?=
 =?us-ascii?Q?Ps2B/QmwAusEI+7t+0PzcOVqd8yvAoXUzyrcF9mjlHSVX8KX0NdAImygE9qA?=
 =?us-ascii?Q?BHVl4yugAgJKQd6NOai4nQk88BooDxGMiPZ46rPS/puEkz9n00PDxr6Pan1J?=
 =?us-ascii?Q?pM46QZHnQ36VJDrqvJFpwhI/awnE5iFQVeY1biR/JWc29vpVOSolRcmw48VF?=
 =?us-ascii?Q?hdbr/c5ctNbIgSt8I9jg72SDSZhstgGWt1whi5et4jpFOKWVeXSsoc315ZG4?=
 =?us-ascii?Q?hD0Og7MTOhtyyqxmWgrCRBpRA8y63MqWu9dAsTIRlyLZ3E5IA0sTCu8jq2Az?=
 =?us-ascii?Q?+Qd43wRB+gFIIchgdHKG8l2C2eKlOiQ42dAW1Yp0Ix62IyyK8iZ5pC7plH38?=
 =?us-ascii?Q?r9H1GMUcr/MMOo+q9HTOot3lzyljfWq5gnMXs5i1W96z3ceyETHIEqjBEsG0?=
 =?us-ascii?Q?UitvkMXAm1c73/CHaZKdu8Q2FQYML7a80dwAhVshPBcqtlyBCJ0nwC47g8cB?=
 =?us-ascii?Q?EeXrOW7txadXKLieq9NLVHB1GLl/aF/ELxtmKuk6tjjuiLky+fdso5O35j8m?=
 =?us-ascii?Q?CvIuHmT00w=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88d1c4b6-d782-4d88-9180-08de8e6d3f15
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 15:01:40.2955
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6ZWfniP6v8zcVLqv8A/HmgCiKgK75dBiduO5dw142fyiItLj5eIOGEjf0ys3P/3dDUoZ/2HIebcA9iqASDarMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9229
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-9726-lists,dmaengine=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[metafoo.de,kernel.org,vger.kernel.org,web.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.996];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@nxp.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[nxp.com:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	RSPAMD_EMAILBL_FAIL(0.00)[karom9560.gmail.com:query timed out];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,checkpatch.pl:url,nxp.com:dkim]
X-Rspamd-Queue-Id: A478635D5CD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, Mar 28, 2026 at 10:56:55AM +0800, Khairul Anuar Romli wrote:
>     checkpatch.pl --strict reports a CHECK warning in dw-axi-dmac.c:
>
>       CHECK: Alignment should match open parenthesis
>
>     This warning occurs when multi-line function calls or expressions have
>     continuation lines that don't properly align with the opening
>     parenthesis position.
>
>     Fixes all instances in dw-axi-dmac.c where continuation lines were
>     indented with an inconsistent number of spaces/tabs that neither
>     matched the parenthesis column nor followed a standard indent pattern.
>     Proper alignment improves code readability and maintainability by
>     making parameter lists visually consistent across the kernel codebase.
>
> Fixes: 0e3b67b348b8 ("dmaengine: Add support for the Analog Devices AXI-DMAC DMA controller")
> Fixes: e3923592f80b ("dmaengine: axi-dmac: populate residue info for completed xfers")
> Fixes: 3f8fd25936ee ("dmaengine: axi-dmac: Allocate hardware descriptors")
> Fixes: 921234e0c5d7 ("dmaengine: axi-dmac: Split too large segments")
> Fixes: a5b982af953b ("dmaengine: axi-dmac: add a check for devm_regmap_init_mmio")

This is code cleanup and not user visiual problem. I think needn't add
fixes tags here.

Frank

> Signed-off-by: Khairul Anuar Romli <karom.9560@gmail.com>
> ---
>  drivers/dma/dma-axi-dmac.c | 28 +++++++++++++++-------------
>  1 file changed, 15 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/dma/dma-axi-dmac.c b/drivers/dma/dma-axi-dmac.c
> index 45c2c8e4bc45..0017f4dc6dcc 100644
> --- a/drivers/dma/dma-axi-dmac.c
> +++ b/drivers/dma/dma-axi-dmac.c
> @@ -193,7 +193,7 @@ static struct axi_dmac_desc *to_axi_dmac_desc(struct virt_dma_desc *vdesc)
>  }
>
>  static void axi_dmac_write(struct axi_dmac *axi_dmac, unsigned int reg,
> -	unsigned int val)
> +			   unsigned int val)
>  {
>  	writel(val, axi_dmac->base + reg);
>  }
> @@ -382,7 +382,7 @@ static void axi_dmac_start_transfer(struct axi_dmac_chan *chan)
>  }
>
>  static inline unsigned int axi_dmac_total_sg_bytes(struct axi_dmac_chan *chan,
> -	struct axi_dmac_sg *sg)
> +						   struct axi_dmac_sg *sg)
>  {
>  	if (chan->hw_2d)
>  		return (sg->hw->x_len + 1) * (sg->hw->y_len + 1);
> @@ -437,7 +437,7 @@ static void axi_dmac_dequeue_partial_xfers(struct axi_dmac_chan *chan)
>  }
>
>  static void axi_dmac_compute_residue(struct axi_dmac_chan *chan,
> -	struct axi_dmac_desc *active)
> +				     struct axi_dmac_desc *active)
>  {
>  	struct dmaengine_result *rslt = &active->vdesc.tx_result;
>  	unsigned int start = active->num_completed - 1;
> @@ -517,7 +517,7 @@ static bool axi_dmac_handle_cyclic_eot(struct axi_dmac_chan *chan,
>  }
>
>  static bool axi_dmac_transfer_done(struct axi_dmac_chan *chan,
> -	unsigned int completed_transfers)
> +				   unsigned int completed_transfers)
>  {
>  	struct axi_dmac_desc *active;
>  	struct axi_dmac_sg *sg;
> @@ -667,7 +667,7 @@ axi_dmac_alloc_desc(struct axi_dmac_chan *chan, unsigned int num_sgs)
>  	desc->chan = chan;
>
>  	hws = dma_alloc_coherent(dev, PAGE_ALIGN(num_sgs * sizeof(*hws)),
> -				&hw_phys, GFP_ATOMIC);
> +				 &hw_phys, GFP_ATOMIC);
>  	if (!hws) {
>  		kfree(desc);
>  		return NULL;
> @@ -703,9 +703,11 @@ static void axi_dmac_free_desc(struct axi_dmac_desc *desc)
>  }
>
>  static struct axi_dmac_sg *axi_dmac_fill_linear_sg(struct axi_dmac_chan *chan,
> -	enum dma_transfer_direction direction, dma_addr_t addr,
> -	unsigned int num_periods, unsigned int period_len,
> -	struct axi_dmac_sg *sg)
> +						   enum dma_transfer_direction direction,
> +						   dma_addr_t addr,
> +						   unsigned int num_periods,
> +						   unsigned int period_len,
> +						   struct axi_dmac_sg *sg)
>  {
>  	unsigned int num_segments, i;
>  	unsigned int segment_size;
> @@ -817,7 +819,7 @@ static struct dma_async_tx_descriptor *axi_dmac_prep_slave_sg(
>  		}
>
>  		dsg = axi_dmac_fill_linear_sg(chan, direction, sg_dma_address(sg), 1,
> -			sg_dma_len(sg), dsg);
> +					      sg_dma_len(sg), dsg);
>  	}
>
>  	desc->cyclic = false;
> @@ -857,7 +859,7 @@ static struct dma_async_tx_descriptor *axi_dmac_prep_dma_cyclic(
>  	desc->sg[num_sgs - 1].hw->flags &= ~AXI_DMAC_HW_FLAG_LAST;
>
>  	axi_dmac_fill_linear_sg(chan, direction, buf_addr, num_periods,
> -		period_len, desc->sg);
> +				period_len, desc->sg);
>
>  	desc->cyclic = true;
>
> @@ -1006,7 +1008,7 @@ static void axi_dmac_adjust_chan_params(struct axi_dmac_chan *chan)
>   * features are implemented and how it should behave.
>   */
>  static int axi_dmac_parse_chan_dt(struct device_node *of_chan,
> -	struct axi_dmac_chan *chan)
> +				  struct axi_dmac_chan *chan)
>  {
>  	u32 val;
>  	int ret;
> @@ -1295,7 +1297,7 @@ static int axi_dmac_probe(struct platform_device *pdev)
>  		return ret;
>
>  	ret = of_dma_controller_register(pdev->dev.of_node,
> -		of_dma_xlate_by_chan_id, dma_dev);
> +					 of_dma_xlate_by_chan_id, dma_dev);
>  	if (ret)
>  		return ret;
>
> @@ -1310,7 +1312,7 @@ static int axi_dmac_probe(struct platform_device *pdev)
>  		return ret;
>
>  	regmap = devm_regmap_init_mmio(&pdev->dev, dmac->base,
> -		 &axi_dmac_regmap_config);
> +				       &axi_dmac_regmap_config);
>
>  	return PTR_ERR_OR_ZERO(regmap);
>  }
> --
> 2.43.0
>

