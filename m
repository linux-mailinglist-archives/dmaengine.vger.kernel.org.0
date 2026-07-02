Return-Path: <dmaengine+bounces-11967-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id /EEZJrVnRmrMSwsAu9opvQ
	(envelope-from <dmaengine+bounces-11967-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 02 Jul 2026 15:29:25 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B16D6F85A9
	for <lists+dmaengine@lfdr.de>; Thu, 02 Jul 2026 15:29:24 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=fail ("body hash did not verify") header.d=NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b=p0avNSop;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11967-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11967-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed)" header.from=nxp.com (policy=none);
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 65A1530440EE
	for <lists+dmaengine@lfdr.de>; Thu,  2 Jul 2026 13:18:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DD7B4A13A8;
	Thu,  2 Jul 2026 13:17:56 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011055.outbound.protection.outlook.com [40.107.130.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDBA34A2E05
	for <dmaengine@vger.kernel.org>; Thu,  2 Jul 2026 13:17:54 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782998276; cv=fail; b=Hbnaj7FFetK4ruDdVRrVQgAaikqjnXVYVCcC+VVXEPCMVvJ0+7mcCyZc6XmzHalI7vvy3/6lUvY3g+ijU/iNZh4WEQUbUvIjWT94bWRz1Qy7Vzb3yAg3yaQUW9yNuR6dY4tzDUjEySfVn2dXT1MyeveH3PGplsG7RJyMnV0EStI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782998276; c=relaxed/simple;
	bh=7b8Z819NP1OeHfFubmz6dC3+LzmMIHlyyW/oKpIzsfk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=WIt7pUFf+USNq2Yu66uyw6XGaHgi6A5iKNKT34nvLZzqKs6UJyGl1548VjETFwE6s0EPHtDxkjJqDe1M5n8e93soZuVlANxtBMpgX/qxER/iQ0KmzMTHpCPIciYB6B4Tkh1j3rB73b8tOYNsOeAvAMJ4Ujm56MttMVHe0KJqNJM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=fail (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=p0avNSop reason="signature verification failed"; arc=fail smtp.client-ip=40.107.130.55
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dvRGxd9sOe8SnRYi6TH4T8QDxJROC+zRAi0VdQ5SCxD06pKNYsxar9D+L0BbPmeMcd74VOv8XdOy5n1EFjScsL4GGoTgYydQ1fkzN0lzct08I8S2NrNJ1gt/wMvm2D1/ozqrGw800kjNUI9qJWO0skaMkjRbVGnNBvLF6DAUFvRzeUBLrNZUTZvwqvluTmlNwaL42Vllnq3HwoHe/Wu1IpIqUFfkfLiTuEhrtWWG2otw44OGB6mOmwZCsQlGFZAFooJL0GQbCDepukgtV7VD6QwbEZakdXzKIo9Eo9Lit3inZwkjbygZ77f0S/JlerFCGrdVDFv0noIUFpbSA0Vefg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gf/QZ42mphyq6nhvCY+g6MS2VTZzacaocS0g9E6qk2M=;
 b=HiXegweKrDBtGY7wMSmOpsZdC1+EV3PePX28UfZo0DokEhkE3Nl/it23GCcbqVOxOjJ/4Whq2qD+yCT94yOoJB5ehgFQL6eJOY9ub3IXjR7xTjmA1jWDzzXzhRMhbyYOkaA0MLNNO3JUFfykYhkv1c/2y1mZu2MNzBtKFSV5h5xzULFYEz12aRjKPrK/jgybX/5laMWLo3XUW6WspUcu0r/z6uqyc1nS3p0DVdb7sGqbqlxLo8nWqP5xpbYv2VM+Dhr5ZrfM0nGCuRPJ6ls532AOPq5MKewAEdswIQEbU2QibFbvpT1OOjdi4sFA/FM4EoinWSCDr5ql9SZDjhbavg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gf/QZ42mphyq6nhvCY+g6MS2VTZzacaocS0g9E6qk2M=;
 b=p0avNSopqDIj/U0b2EtqZ1oJv9YylHVrCDtyMBrIyhjsMGOqhEjQjMHjZINHMbdX+js/z/4KVAiGTJ4PZ4PILDsdlAdunwjb5vpHBbJPOILxw7D01FQcZ5g5u11AOE8AzNdgGvVFhzHT/bnpvs0c5g8Bwl9I3YwmcA49x2lv1bs8l9OL3D4TXBh33QJXCpZ9J2V7ux7ea8Vt5pZ5rMCsKM/4Pj4dVDsZ42CgssI0y1LBvo3wZaWZKvq1sfL3Uqk6srI1/VSMNaCA4ZO2jKYRRvqvZNCOxlYv53kaS+OxQ/WEY68kqnX0qW2HViVENT1DA1VVvLYasY4mp698n5g/Mw==
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by DU4PR04MB10816.eurprd04.prod.outlook.com (2603:10a6:10:582::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Thu, 2 Jul
 2026 13:17:50 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0159.007; Thu, 2 Jul 2026
 13:17:49 +0000
Date: Thu, 2 Jul 2026 08:17:38 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: sashiko-reviews@lists.linux.dev
Cc: =?iso-8859-1?Q?Beno=EEt?= Monin <benoit.monin@bootlin.com>,
	Frank.Li@kernel.org, imx@lists.linux.dev, vkoul@kernel.org,
	dmaengine@vger.kernel.org
Subject: Re: [PATCH v5 2/2] dmaengine: fsl-edma: Support dynamic
 scatter/gather chaining
Message-ID: <akZk8kHhf01J6lxC@SMW015318>
References: <20260702-fsl-edma-dyn-sg-v5-0-16787185be49@bootlin.com>
 <20260702-fsl-edma-dyn-sg-v5-2-16787185be49@bootlin.com>
 <20260702124553.3E52F1F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260702124553.3E52F1F000E9@smtp.kernel.org>
X-ClientProxiedBy: PH8P222CA0023.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:510:2d7::17) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|DU4PR04MB10816:EE_
X-MS-Office365-Filtering-Correlation-Id: 74a60415-ca93-4291-4e00-08ded83c504d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|376014|23010399003|1800799024|366016|18002099003|56012099006|11063799006|4143699003|6133799003|22082099003;
X-Microsoft-Antispam-Message-Info:
	jfkeXMVswI/6F8QPrujIc4SpmU9cFxCB7PIg99fIhJkupGY8LFF0wm0XdAYl9FMtge7JUfE2BgK/cvsz1fHtIDsk0UFT6sZYk22LUkP5EDDXI+t3nts4NperEYA0HkGLlIEtxpdmmboHE8GCIumtXGq5M8tcue/jIB/cp6ibJPq5krE7GwkxqJuF8Ei79UDEE/zskGz2AiEp/+zwiLkcKOR1XieXXBqSQn3y8NJyJJ8hHTposOgsDVtXXVzkhm7TNu3NvNzXcHqq/vOdMkShOcWmG5EmswdZ/w8WjnutJOApXiaVHB3tX9ByjBEhtdLQHLZwQQQEbtdbL6FxSefDhXRvcUT9A/xaY6Q6zkXo1w8VMVwusQyQ9LmkoDBFQbtYkHQIk19nY3UtiLo60tMJCiJ7njVnxAH3CdaW/gVUMh0UmJDIDVRRZT5awrUo8IIBcphZyeO/MYSd7MtPxoye5M34/DJijX+UeqliTiCPpu5WtCVCXM06rbNkoFmDsOrrhxRHevnP/+nWjfITlCeKNPlQLIm9ce9iyapX8O3cEHyxiWK3k4mOeC4mXyB+hj2aA5fsi3jm2i/Kh71GtD/lt/Ot6Wim/Jfk/kBtq/iZHYA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(23010399003)(1800799024)(366016)(18002099003)(56012099006)(11063799006)(4143699003)(6133799003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?o9kit9CnL4kwk6/pib4HSvaOU9uAUPZYhIQfK7w8gH47ufrdxoeZlcWGA+?=
 =?iso-8859-1?Q?TiECTyNW9xbp8WJh42Ub6hSU5nzPNhA2dfDYfomHVzIjRJeAQdz/1NiQ+o?=
 =?iso-8859-1?Q?+Wsxk7yT2lEGYrIE2XIRI3JrfbeyiVgDyGoYtkYPvSZxAtRcvStdOftlrw?=
 =?iso-8859-1?Q?DPVFIvP9q2qJPJF5ifHI2PvG3i7WKT2fpV/H5UnXKSg1P0rQQ+qQkL6e3b?=
 =?iso-8859-1?Q?RqdXnF1tkJRIhsdbQad9+PT2YxEmWpghib5dXjcx7/QsufFWJqlbw7YCGU?=
 =?iso-8859-1?Q?rQuTjf+T60lw85N6ARUeAeUyIxIDIzIlWZSYYsCnPOGKXNave+Q4qz4pmi?=
 =?iso-8859-1?Q?wQoVRfGrG8UvkXCQrBFMLepOpUfIbI0GDVcJoEtVs5DkRfH3MZ2SwY8RCS?=
 =?iso-8859-1?Q?dgxhI4CVvF//dEqTZw1Wc8smQ1jqGdMP3t0kFWhPE9YL2UugobjSPTyVxj?=
 =?iso-8859-1?Q?L7uxdx508K7mhBYoHomt1aOsnW9niGEJPpmLO795Y7rGoMn87jjKhlEf12?=
 =?iso-8859-1?Q?aAqqm/N4IxxjrG1oncGUcfkySP8uQNhLsZgpFxxpC7yhvC2uoUzCMh3DuC?=
 =?iso-8859-1?Q?PeNe0RyM8zOtFtm5HpWkBz3WKWPVj+18kDBiqSoKeD3slfeIQKiMmlQd3v?=
 =?iso-8859-1?Q?Pz2eQnQwdusuagfuYfYZNj/kO9Gc1KnDnWbFuwYR+LsI494KhzuShV7DOt?=
 =?iso-8859-1?Q?yEttK1JypoGePjJraK0mUwILWHVpoklIIibhOzFWie+JOX3EIbAO8udpvM?=
 =?iso-8859-1?Q?IogN18gnliTNvGz7qA2w/zEi1mn/0xGy4EDmrESWCAlMd9CnMs83hU+JIB?=
 =?iso-8859-1?Q?gTIwcnW1RE5nYdyH/nT5qAo3Z+OJCmfxx+Q0lAG5n/tArhoAd7NXIBh9tk?=
 =?iso-8859-1?Q?uPo3tBBYEDy4DP2oVoWrhzLYP7aHNBQ6+Y9ZbOw7+4X5hkvwespqQDo5Dg?=
 =?iso-8859-1?Q?0KVZNjURTtKVb5JoFMaKv02Jx786lYXfcbWly+uhKWkW3/iXy8MpSGP4uz?=
 =?iso-8859-1?Q?EAtXUhY5cILjdFfdoxnqlhNGiivD6FD3qE0AJJIKYpYJXLdOWaXkCrr03h?=
 =?iso-8859-1?Q?WtY3n62POAa1Qyzq//QK1vl0idNMbz7RLHO4KBaEN6+UfOOta88LTKEUx4?=
 =?iso-8859-1?Q?2AA1qhvaXjA2+8bFDc+jVj6Q6Ah8G5Zeiwn5S63+FqxKFvJE3PxQ44V9La?=
 =?iso-8859-1?Q?xBdS8ykXnO6EQN2nuIJku4Vvpz1uGRgSlxZ+5q2ijX98Qa5usD0AB+o8gP?=
 =?iso-8859-1?Q?bqXMkesYLjqQWslXvgqaQlzdDfg9WzlyMPuOaNWHWfn/WlSIr6Ty7pQi6u?=
 =?iso-8859-1?Q?RcAIfcmVWZ/dCr5TrvTMlDqO9wnTOV9Qb4QfMYDytTqTUUY1+bPfrO1QX+?=
 =?iso-8859-1?Q?5XhxLIWrvNi0YQjmhHJp7BDBY1xKeex/90qu6fGVzecAfHUEddN2i/YqvA?=
 =?iso-8859-1?Q?xsIDbJpEfK148lGFhMvhxPP66OdzeQZxNAyBdP+2AHHXOAOcBJoI6cr3nP?=
 =?iso-8859-1?Q?k8p2VaaPVz0v7m6EdqH0b8qBjjgvWW3x3YfhRZnN0BQ8RiCFR50xD1wcyR?=
 =?iso-8859-1?Q?L3vFEpWWxDotWL/DnJGP7vv09oFRnAqLuHapSKySf9LEZpEta4HOEJNO1/?=
 =?iso-8859-1?Q?j0hv6BXC5qtxzAZg15rgXQ7fLFQiLvhEZTgnId6abQj1LHNVKk8dg3LzWP?=
 =?iso-8859-1?Q?OLe/E/mbrkZNrG8QVl0fulNXQXmTheTazcv2HYL5Uc9AGGGrhO71tQHeUT?=
 =?iso-8859-1?Q?ACyMhuqhcQvjunwXCQfdkWwKEiojaGItZFfx52eSlG+orWAE0Y8Z6Efcla?=
 =?iso-8859-1?Q?iZ2QXh8HXJi4naWPfNw03lH3bCazym04cEVTc7qYKJ2peiHYVHkf?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74a60415-ca93-4291-4e00-08ded83c504d
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2026 13:17:49.5406
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p06fv3teZs064Z014edNgqJ6LtNkpH3IHrdzgAIOMjwArWrglmDOi+sW4AenMEHTKZMCWNPJP8gq56FrwkaJ1MiRwLZqjU/JjK4STgGt06VfaUlndoxjJX1YCKTsV6AR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10816
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.14 / 15.00];
	R_DKIM_REJECT(1.00)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11967-lists,dmaengine=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:sashiko-reviews@lists.linux.dev,m:benoit.monin@bootlin.com,m:Frank.Li@kernel.org,m:imx@lists.linux.dev,m:vkoul@kernel.org,m:dmaengine@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[Frank.li@oss.nxp.com,dmaengine@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@oss.nxp.com,dmaengine@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:-];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6B16D6F85A9

On Thu, Jul 02, 2026 at 12:45:52PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [Critical] Double-execution of DMA descriptors due to state machine desync when interrupts coalesce.
> - [Critical] Channel deadlock due to dynamic descriptor linking bypassing `issue_pending()`.
> --
>
> commit a67c20eb8f20e15fe2cadb092322588069fe328e
> Author: Benoît Monin <benoit.monin@bootlin.com>
>
> dmaengine: fsl-edma: Support dynamic scatter/gather chaining
>
> Implement dynamic linking of scatter/gather transfers to enable
> chaining multiple DMA descriptors without stopping the channel.
> This avoids waiting for the channel to go idle if there is another
> transaction already issued.
>
> > diff --git a/drivers/dma/fsl-edma-common.c b/drivers/dma/fsl-edma-common.c
> > --- a/drivers/dma/fsl-edma-common.c
> > +++ b/drivers/dma/fsl-edma-common.c
> > @@ -58,7 +58,10 @@ void fsl_edma_tx_chan_handler(struct fsl_edma_chan *fsl_chan)
> >  		list_del(&fsl_chan->edesc->vdesc.node);
> >  		vchan_cookie_complete(&fsl_chan->edesc->vdesc);
> >  		fsl_chan->edesc = NULL;
> > -		fsl_chan->status = DMA_COMPLETE;
> > +		if (!(fsl_edma_drvflags(fsl_chan) & FSL_EDMA_DRV_SPLIT_REG) ||
> > +		    (edma_readl_chreg(fsl_chan, ch_csr) & EDMA_V3_CH_CSR_DONE)) {
> > +			fsl_chan->status = DMA_COMPLETE;
> > +		}
>
> [Severity: Critical]
> Does checking the channel-global DONE flag here cause chained descriptors
> to execute twice if interrupts coalesce?
>
> For example, if descriptors A and B are chained and the hardware finishes
> both before the interrupt handler runs, won't the handler complete A,
> see DONE is set, and mark the channel DMA_COMPLETE?
>
> If that happens, wouldn't fsl_edma_xfer_desc() then fetch B from the
> issued list and restart the hardware, executing B a second time?

This is problem, need go though issue list and compared current hardware
working pos. then move all finished item to compelete queue

A
B
C  <- hardware working this
D

Need move A and B to complete queue. Because eDMA have not write back
status to descript and no compelete queue, it needs some efforts to find
dma is working on which item in issue list

>
> [ ... ]
>
> > @@ -673,6 +676,68 @@ struct dma_async_tx_descriptor *fsl_edma_prep_dma_cyclic(
> > +static dma_cookie_t fsl_edma_tx_submit(struct dma_async_tx_descriptor *tx)
> > +{
> > +	struct virt_dma_desc *vd = container_of(tx, struct virt_dma_desc, tx);
> > +	struct fsl_edma_chan *fsl_chan = to_fsl_edma_chan(tx->chan);
> > +	struct fsl_edma_desc *fsl_desc = to_fsl_edma_desc(vd);
> > +	struct virt_dma_chan *vc = to_virt_chan(tx->chan);
> > +	dma_cookie_t cookie;
> > +
> > +	guard(spinlock_irqsave)(&fsl_chan->vchan.lock);
> > +
> > +	fsl_edma_link_sg(fsl_chan, fsl_desc);
> > +	cookie = dma_cookie_assign(tx);
> > +	list_move_tail(&vd->node, &vc->desc_submitted);
> > +
> > +	return cookie;
> > +}
>
> [Severity: Critical]
> Can this cause a channel deadlock by executing unissued descriptors?
>
> Since hardware linking happens in fsl_edma_tx_submit() rather than waiting
> for the issue_pending() callback, if the hardware completes the newly linked
> descriptor before the client calls issue_pending(), won't the interrupt
> handler fire but find edesc is NULL?

Yes, you can't link hardware queue in tx_submit

you can create hardware queue list,  N1->N2->N3.

at issue_pending() function, assume issue queue I1->I2->I3

link submit queue header N3 to issue queue tail I1.

Frank

>
> In fsl_edma_tx_chan_handler():
>
>     if (!fsl_chan->edesc) {
>         /* terminate_all called before */
>         spin_unlock(&fsl_chan->vchan.lock);
>         return;
>     }
>
> Wouldn't this drop the completion and leave the channel stuck when
> issue_pending() is eventually called, since the channel status is still left
> as DMA_IN_PROGRESS?
>
> --
> Sashiko AI review · https://sashiko.dev/#/patchset/20260702-fsl-edma-dyn-sg-v5-0-16787185be49@bootlin.com?part=2

