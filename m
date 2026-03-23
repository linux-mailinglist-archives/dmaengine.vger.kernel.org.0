Return-Path: <dmaengine+bounces-9576-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GES3HnOawGmJJAQAu9opvQ
	(envelope-from <dmaengine+bounces-9576-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 23 Mar 2026 02:42:11 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D18F42EB8C1
	for <lists+dmaengine@lfdr.de>; Mon, 23 Mar 2026 02:42:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8B2363010DA0
	for <lists+dmaengine@lfdr.de>; Mon, 23 Mar 2026 01:39:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBAD01EE7D5;
	Mon, 23 Mar 2026 01:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="JxKInUJ1"
X-Original-To: dmaengine@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011071.outbound.protection.outlook.com [40.107.74.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE7F41D7E41;
	Mon, 23 Mar 2026 01:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774229994; cv=fail; b=S/Z8E++yh515huAphounAsSJgcE99BoDAN0BPXG+uJbF1xNS+2Ikl6gtkMt3kHrL6SIam2CGH1FWx46ZI5Mpo94LOUHc46JdntAbM8x/93KWct/FlJ80hr2UeXlu5iQIuVuI+Lkdpt5AUwCHL4042gxzYI814CqlfWk4gdbkd+o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774229994; c=relaxed/simple;
	bh=R5LaLYVX0EoFqYW0lFtCnc18SiuImARL2fagsB17KWg=;
	h=Message-ID:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=S1Fc0WEMM+Wa8b/oSp41PUs3TzRE87fofeEVMTi5uQxTw2M2tjwEjh8c8W+v3Ka/g7jVUENrleQpb5M7q9ZTMBWxj52CkcWDwHkeQsEXk0dKp7+69eTqqPhtJ6dh9sKDHHCgigiVp/daK1loHdjfY5mBn7YOL0Z3/PmJgvth3Q4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=JxKInUJ1; arc=fail smtp.client-ip=40.107.74.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nnblkOIyl//M9IdGr4T6bJaH8tAkK+ib6FBpzJpQqTL3CupE8Qs1xFKe5Az5GgPtbyrEtohMFAi5nbm9p7JpIj41K7tUIqfA/OnDuAvOTDGnJkarl3K1jJ9aFTi/Jh4pvQmkWBXTwfRY5QvOqZQfxyhl7NpTc46CKWHVIY9qKGABVcNjiLqZdwidb7MLxHV/XaJB7b2xT9xWyCFuIIEZkds38AnwJb+dLhvFIRxFFLTr+fXQx5OpUnqg9ybMjtCw7gkSpuY+B/Lp06JRHSttNHvIcCJDm7JOI8bLpEZQEfrBaREMX6h70dd8fKzTdKRlKOnne2ya8emslQRgaIj6wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/tXqSVmwBFPGRThHH/uaQgwBU+VJ12FeDTMnXC65Gh0=;
 b=cvLrdPuhPgJPXsXnVvHzMsgp482G2JLKIRYrKQpsuWVxivUACyHB/3je+JjQGp/HkecY5rxpER/AZE2EcOTlWo/ycRMyfJCqIQa9CKlgiAqiqGHZf6GoH4WY9t1UY+3b84aMY2CB7KHxGSMX/UqNeffBaAAvToi5p65WbDSWSFVDDIuK0gBaaKYh6QYvRlVWP3MT1CZZORJw3+um5X8A8x9VhIuSWhc8e3/KtZ7a3jaMrF8uO4uSCf1X2LOkOnf/w8LWhpjqExdWYuur2FLhCwg9MUMrQXOILesuUZcB1a89xUqttLm+BSXEcUOylFDra7JQlc7d/yXRnFE+m5MYbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/tXqSVmwBFPGRThHH/uaQgwBU+VJ12FeDTMnXC65Gh0=;
 b=JxKInUJ1pCwkmE75GKjzEkf14Svc8N+5NEd9IVfLC7pnsWvbkPKj+hWzotxaCMqTVbDtKxc3z/oOMWpMnWLB/6WiO4BbeC8F1xg8X4GUVbb8/sho/Un3E3B5365I+Hk20Vi3XZcE5x06CAZdmDtjYx5lx5KybqBYnxl/sB0RwhY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
Received: from TY3PR01MB11797.jpnprd01.prod.outlook.com (2603:1096:400:373::8)
 by TY4PR01MB15568.jpnprd01.prod.outlook.com (2603:1096:405:28c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.31; Mon, 23 Mar
 2026 01:39:40 +0000
Received: from TY3PR01MB11797.jpnprd01.prod.outlook.com
 ([fe80::1868:c915:c230:a383]) by TY3PR01MB11797.jpnprd01.prod.outlook.com
 ([fe80::1868:c915:c230:a383%5]) with mapi id 15.20.9723.030; Mon, 23 Mar 2026
 01:39:40 +0000
Message-ID: <87bjgf9vdo.wl-kuninori.morimoto.gx@renesas.com>
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
To: John Madieu <john.madieu.xa@bp.renesas.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
	Vinod Koul <vkoul@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Magnus Damm <magnus.damm@gmail.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	John Madieu <john.madieu@gmail.com>,
	linux-renesas-soc@vger.kernel.org,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dmaengine@vger.kernel.org,
	linux-sound@vger.kernel.org
Subject: Re: [PATCH 14/22] ASoC: rsnd: adg: Add per-SSI ADG and SSIF supply clock management
In-Reply-To: <20260319155334.51278-15-john.madieu.xa@bp.renesas.com>
References: <20260319155334.51278-1-john.madieu.xa@bp.renesas.com>
	<20260319155334.51278-15-john.madieu.xa@bp.renesas.com>
User-Agent: Wanderlust/2.15.9 Emacs/29.3 Mule/6.0
Content-Type: text/plain; charset=US-ASCII
Date: Mon, 23 Mar 2026 01:39:39 +0000
X-ClientProxiedBy: OS3P286CA0120.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:1f7::10) To TY3PR01MB11797.jpnprd01.prod.outlook.com
 (2603:1096:400:373::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY3PR01MB11797:EE_|TY4PR01MB15568:EE_
X-MS-Office365-Filtering-Correlation-Id: 56b71865-e801-4e6d-8dfa-08de887d0cbb
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|366016|1800799024|22082099003|56012099003|18002099003|38350700014;
X-Microsoft-Antispam-Message-Info:
	kfZ8qV48M0qYhPcnmMmSKBs/2lXvfDuUflhTAhAM/iQ09PHzg8cfkHWpnDenu698nbEN/Ub99WmgVEkyhVUWTiPnKxKEqPk+ufOabe4K31IDCDpx5VC8my8sLmeDgUldOzxgpkjsMX3WVv1hjEVRsK1y75AMnmnZ5sZfbBoVOkOoc7fp6tmqecIk1ee1qBfcI/vn6caNxh7DeKSW4rm7zF1S7J36IUhsWptpZSEDtuDrDzwoIjeMYqP4FNVWObuX9F38nE3LvwY0NkYLZXsE0sT0YZuYKebEvcvPicmRLf4vSuEIbow0k1urpfHOde/rKgmmbIn0DyuMLCNXoPlFbtXt+gXUxPM1IdK7bag1KQZ6I5uMQuV91hTB10WaP9S//GojVqATkXDgNqAVUOVpgu5eqsHV37WIFJb/xbELRrDCWZQDEP9RfQopqI3zVBG8PWzCJFVU8+DCG4NIss0AUgiAbwCNfwyXLCqEFGQ7H4SYUhE0Q18vKkhEuceP5VT//BGeW+pbFAFtoNAEq7LJEQG5UcOCbKIsm7jEFj9Lwy+1l11GJb4pnFaN7vNaREYYBduYjUGf0IYL9HC2PIpPEbLFw/EauyhRFksIxX7qG3u3PV3bxYmm8fknTXvVWiii0Xm55mISStiTh0VFJe5drrtjE1Usuq1lGUnUepoJqLaYTySlYgxjnPKVBGgkjjSGn2tS7U/uJg9ob+jsUFoY8kp66r/0YvVVodfy5wLTtR+IKITtsNg8S1w1sgKANSoI5RtkUnbxwXWT7dNFM4JyMODiONf2AFAsqHYxg6kThiI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11797.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(366016)(1800799024)(22082099003)(56012099003)(18002099003)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?l6K+T4oAu2uaErkYwtwTg9hj85wkPmlRv94TPRSjYda5IAIJuKRy+KOFNLFm?=
 =?us-ascii?Q?BP41WUb1mSGxMIFpdHtollnm1iHV6FstU9onUQRG2MsBfoXMBg9Q722jwkkB?=
 =?us-ascii?Q?8aKQWGuu0PL9c2hrzUt2Envs/tzkj5vWEEsZBz4TBW8w2P3ENaE03ylJ24+8?=
 =?us-ascii?Q?cZ/lrCPB6DXsdM/GVv/5W+McZ1vYhyCy2vUSzOIX7660/sUt/3bhUSoPIAM9?=
 =?us-ascii?Q?sUlOjKw4/ytrNZv1LHe5u1csrZuoYcRB/MicJvCsS1KkqzjXz6PQVyXsFgI8?=
 =?us-ascii?Q?X7Dw7w5Ynlsu7+AvcYUR1lrfz0PF8AIBTUEOIrci0+wS0z4H0qLol+wWv6Sm?=
 =?us-ascii?Q?o+i7Dc5c5IT7+JzXLr+KtqEPVz/Y4J2QLJN7YKCJesKNZJopcQk96xi56aIM?=
 =?us-ascii?Q?Z8XzjQolj/L9RdoEZ8F/NpMCNTdO6e0fZuZy1XHs3FpY96CNmqaxZtq4+9/i?=
 =?us-ascii?Q?HjZLphXis70BHbvpswT7S86JA19uKNJ3gtJTANPXHDUvwQ/l1OGgVItFRpzE?=
 =?us-ascii?Q?MYvQ1e8KLiMyocgcw7uuhqFAVnen9Q0nliMrL+jaE1AUFjtmrL6pf1N6WjEp?=
 =?us-ascii?Q?B18bYk1XIgw+CR6zRoGJWMmXKG9IO/bW6uNsmPs9hQ4aLpDWdVGThOH2J0++?=
 =?us-ascii?Q?otPq87FsFt7d4EZhHNt4i38FkrBcr85SNToQbctZb2fn9elIgYHMkK+PEBI3?=
 =?us-ascii?Q?ctl/swGuEpZ+kejHFNxK+3JmTB1bQok391M/DC+ZBLYlfBCRx8hqhtx9vPva?=
 =?us-ascii?Q?ekf3TLqeYDWxl/ETn+80OPPnqNV+C67W8n2ccvpwB4j0Shhai3CBfiZVbjvX?=
 =?us-ascii?Q?wUooE0Xkteu45taxhCZ0jNHXw0Vwtu3jcvukH+4rL7VgKn+fScvx0ZKN4peP?=
 =?us-ascii?Q?N9Pt81rPNDZ5AE0bHbB7TuqvwXkQ2pEyYpBWUQJjATaOTkBxFFTXszqjJ7iP?=
 =?us-ascii?Q?R1jqcg/ljm29ODXmlOd+77DJCf7XIrboBMJvKCIbAnzdKix8mdpFczdXzFLg?=
 =?us-ascii?Q?LqNDp6bQNv9eRSqxSHgGyQyFBiDzUf25Bgx6LBHcjhf3o0nD5zd/GHcd/PFJ?=
 =?us-ascii?Q?EK8R7N4cyLT7GNVw5PYomZwBpwgyoImsW67msWOVoFJ8gx0fgvhRXJLNoGgd?=
 =?us-ascii?Q?F+BUouE9uDWZRLV+IM5nkLSjcuwOcgoKLy2jwYx5Nrv1kyvDKtyFfWd++efv?=
 =?us-ascii?Q?2EKk8IKU6wC3xm7XCpk9skR8Brz3r/fkKr+Mqkm1VsdaZ2rhD4qnhqz/npwH?=
 =?us-ascii?Q?0abLSKShAw2r+4wOOFs6MWV8n8yrm/yfZC+deBoxc+0bHeiwYsZNUl3LGMc/?=
 =?us-ascii?Q?UStTJm62gSrQ3FGQwqB1wSy5CJPLBxKFeap9GI0WJWT10rqrptNqOAIx928r?=
 =?us-ascii?Q?PL1fssvJPWm9sbXxKRr+GSk4XR4I9Yfiwdohp1OcJhF3OzC9DD2DkttQPEKp?=
 =?us-ascii?Q?NuTAPZMBswbyATtQ4el4IhJv9xCXJ0MhjpFvg6m7XyjbicG6HHE/44NKV+ZM?=
 =?us-ascii?Q?rhVPePfPz6nLF8vqNfhxjijYtif9hPPlzoHp2IyA8wsHRL2cGINuC6lKAvNA?=
 =?us-ascii?Q?qrKPJE/+FL5/a8Ey53dCIJcbaJOCv5HSew/9MNrT9OnPNFiTOUN1yq6xmTHj?=
 =?us-ascii?Q?JmATbH+QnLSA/IwzlSTSrg6OePrq6zLIc3O0uQ5v5K3cgg+qwlq010p2SVyQ?=
 =?us-ascii?Q?HStSV6lcYarfKysI42Yo1GKuiQfb1TwwA+TCXpTwFM/YCodAMl+b74DosroF?=
 =?us-ascii?Q?Uaq1zRFmm5xdES5DL7JBwWdBADfCAXcjKBVrsZT73+9RQ87Orsql?=
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56b71865-e801-4e6d-8dfa-08de887d0cbb
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11797.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 01:39:40.1146
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uFx+eK90m/YgxrIkeGBBOnSn++yKBQSzI0CdEDSV3RHqIi0Q7/EU5UGR2VGeUUi4OWKBbsrVb0p4k1ARXpprw9ox7VudlwrTLno44H6cZ5z3DNeAyytxuZEChZoZSjuC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB15568
X-Spamd-Result: default: False [2.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[renesas.com,none];
	R_DKIM_ALLOW(-0.20)[renesas.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9576-lists,dmaengine=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[27];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[glider.be,kernel.org,baylibre.com,gmail.com,perex.cz,suse.com,pengutronix.de,tuxon.dev,bp.renesas.com,renesas.com,vger.kernel.org];
	DKIM_TRACE(0.00)[renesas.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuninori.morimoto.gx@renesas.com,dmaengine@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[dmaengine,renesas,dt];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,renesas.com:dkim,renesas.com:email,renesas.com:mid]
X-Rspamd-Queue-Id: D18F42EB8C1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


Hi John

> RZ/G3E's ADG module requires explicit clock management for SSI audio
> interfaces that differs from R-Car Gen2/Gen3/Gen4:
> 
>  - Per-SSI ADG clocks (adg.ssi.N) for each SSI module
>  - A shared SSIF supply clock for the SSI subsystem
> 
> These clocks are acquired using optional APIs, making them transparent
> to platforms that do not require them.
> 
> Additionally, since rsnd_adg_ssi_clk_try_start() is called from the
> trigger path (atomic context), clk_prepare_enable() cannot be used
> directly as clk_prepare() may sleep. Split clock handling into:
> 
>  - hw_params: clk_prepare() - sleepable context
>  - trigger (start): clk_enable() - atomic safe
>  - trigger (stop): clk_disable() - atomic safe
>  - hw_free: clk_unprepare() - sleepable context
> 
> Signed-off-by: John Madieu <john.madieu.xa@bp.renesas.com>
> ---

In this patch, it adds RZ/G3E specific params, and use it on common
function without checking whether it is R-Car or RZ, or whether it has
param or not.
Is it keep compatible on R-Car ?


>  sound/soc/renesas/rcar/adg.c  | 99 ++++++++++++++++++++++++++++++++++-
>  sound/soc/renesas/rcar/rsnd.h |  2 +
>  sound/soc/renesas/rcar/ssi.c  | 18 +++++++
>  3 files changed, 118 insertions(+), 1 deletion(-)
> 
> diff --git a/sound/soc/renesas/rcar/adg.c b/sound/soc/renesas/rcar/adg.c
> index cbb5c4432a2d..131a60689f6d 100644
> --- a/sound/soc/renesas/rcar/adg.c
> +++ b/sound/soc/renesas/rcar/adg.c
> @@ -19,6 +19,9 @@
>  #define CLKOUT3	3
>  #define CLKOUTMAX 4
>  
> +/* Maximum SSI count for per-SSI clocks */
> +#define ADG_SSI_MAX	10
> +
>  #define BRGCKR_31	(1 << 31)
>  #define BRRx_MASK(x) (0x3FF & x)
>  
> @@ -34,6 +37,9 @@ struct rsnd_adg {
>  	struct clk *adg;
>  	struct clk *clkin[CLKINMAX];
>  	struct clk *clkout[CLKOUTMAX];
> +	/* RZ/G3E: per-SSI ADG clocks (adg.ssi.0 through adg.ssi.9) */
> +	struct clk *clk_adg_ssi[ADG_SSI_MAX];
> +	struct clk *clk_ssif_supply;
>  	struct clk *null_clk;
>  	struct clk_onecell_data onecell;
>  	struct rsnd_mod mod;
> @@ -341,10 +347,58 @@ int rsnd_adg_clk_query(struct rsnd_priv *priv, unsigned int rate)
>  	return -EIO;
>  }
>  
> +/*
> + * RZ/G3E: Prepare SSI clocks - call from hw_params (can sleep)
> + */
> +int rsnd_adg_ssi_clk_prepare(struct rsnd_mod *ssi_mod)
> +{
> +	struct rsnd_priv *priv = rsnd_mod_to_priv(ssi_mod);
> +	struct rsnd_adg *adg = rsnd_priv_to_adg(priv);
> +	struct device *dev = rsnd_priv_to_dev(priv);
> +	int id = rsnd_mod_id(ssi_mod);
> +	int ret;
> +
> +	ret = clk_prepare(adg->clk_adg_ssi[id]);
> +	if (ret) {
> +		dev_err(dev, "Cannot prepare adg.ssi.%d ADG clock\n", id);
> +		return ret;
> +	}
> +
> +	ret = clk_prepare(adg->clk_ssif_supply);
> +	if (ret) {
> +		dev_err(dev, "Cannot prepare SSIF supply clock\n");
> +		clk_unprepare(adg->clk_adg_ssi[id]);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +/*
> + * RZ/G3E: Unprepare SSI clocks - call from hw_free (can sleep)
> + */
> +void rsnd_adg_ssi_clk_unprepare(struct rsnd_mod *ssi_mod)
> +{
> +	struct rsnd_priv *priv = rsnd_mod_to_priv(ssi_mod);
> +	struct rsnd_adg *adg = rsnd_priv_to_adg(priv);
> +	int id = rsnd_mod_id(ssi_mod);
> +
> +	clk_unprepare(adg->clk_adg_ssi[id]);
> +	clk_unprepare(adg->clk_ssif_supply);
> +}
> +
>  int rsnd_adg_ssi_clk_stop(struct rsnd_mod *ssi_mod)
>  {
> +	struct rsnd_priv *priv = rsnd_mod_to_priv(ssi_mod);
> +	struct rsnd_adg *adg = rsnd_priv_to_adg(priv);
> +	int id = rsnd_mod_id(ssi_mod);
> +
>  	rsnd_adg_set_ssi_clk(ssi_mod, 0);
>  
> +	/* RZ/G3E: only disable here, unprepare is done in hw_free */
> +	clk_disable(adg->clk_adg_ssi[id]);
> +	clk_disable(adg->clk_ssif_supply);
> +
>  	return 0;
>  }
>  
> @@ -354,7 +408,8 @@ int rsnd_adg_ssi_clk_try_start(struct rsnd_mod *ssi_mod, unsigned int rate)
>  	struct rsnd_adg *adg = rsnd_priv_to_adg(priv);
>  	struct device *dev = rsnd_priv_to_dev(priv);
>  	struct rsnd_mod *adg_mod = rsnd_mod_get(adg);
> -	int data;
> +	int id = rsnd_mod_id(ssi_mod);
> +	int ret, data;
>  	u32 ckr = 0;
>  
>  	data = rsnd_adg_clk_query(priv, rate);
> @@ -376,6 +431,18 @@ int rsnd_adg_ssi_clk_try_start(struct rsnd_mod *ssi_mod, unsigned int rate)
>  		(ckr) ?	adg->brg_rate[ADG_HZ_48] :
>  			adg->brg_rate[ADG_HZ_441]);
>  
> +	/*
> +	 * RZ/G3E: enable per-SSI and supply clocks
> +	 * Prepare was done in hw_params
> +	 */
> +	ret = clk_enable(adg->clk_adg_ssi[id]);
> +	if (ret)
> +		dev_warn(dev, "Cannot enable adg.ssi.%d ADG clock\n", id);
> +
> +	ret = clk_enable(adg->clk_ssif_supply);
> +	if (ret)
> +		dev_warn(dev, "Cannot enable SSIF supply clock\n");
> +
>  	return 0;
>  }
>  
> @@ -769,6 +836,31 @@ void rsnd_adg_clk_dbg_info(struct rsnd_priv *priv, struct seq_file *m)
>  #define rsnd_adg_clk_dbg_info(priv, m)
>  #endif
>  
> +static int rsnd_adg_get_ssi_clks(struct rsnd_priv *priv)
> +{
> +	struct rsnd_adg *adg = rsnd_priv_to_adg(priv);
> +	struct device *dev = rsnd_priv_to_dev(priv);
> +	char name[16];
> +	int i;
> +
> +	/* SSIF supply clock */
> +	adg->clk_ssif_supply = devm_clk_get_optional(dev, "ssif_supply");
> +	if (IS_ERR(adg->clk_ssif_supply))
> +		return dev_err_probe(dev, PTR_ERR(adg->clk_ssif_supply),
> +				     "failed to get ssif_supply clock\n");
> +
> +	/* Per-SSI ADG clocks */
> +	for (i = 0; i < ADG_SSI_MAX; i++) {
> +		snprintf(name, sizeof(name), "adg.ssi.%d", i);
> +		adg->clk_adg_ssi[i] = devm_clk_get_optional(dev, name);
> +		if (IS_ERR(adg->clk_adg_ssi[i]))
> +			return dev_err_probe(dev, PTR_ERR(adg->clk_adg_ssi[i]),
> +					     "failed to get %s clock\n", name);
> +	}
> +
> +	return 0;
> +}
> +
>  int rsnd_adg_probe(struct rsnd_priv *priv)
>  {
>  	struct reset_control *rstc;
> @@ -800,6 +892,11 @@ int rsnd_adg_probe(struct rsnd_priv *priv)
>  	if (ret)
>  		return ret;
>  
> +	/* RZ/G3E-specific: per-SSI ADG and SSIF supply clocks */
> +	ret = rsnd_adg_get_ssi_clks(priv);
> +	if (ret)
> +		return ret;
> +
>  	ret = rsnd_adg_clk_enable(priv);
>  	if (ret)
>  		return ret;
> diff --git a/sound/soc/renesas/rcar/rsnd.h b/sound/soc/renesas/rcar/rsnd.h
> index da377bca45a9..6bde304f93a8 100644
> --- a/sound/soc/renesas/rcar/rsnd.h
> +++ b/sound/soc/renesas/rcar/rsnd.h
> @@ -612,6 +612,8 @@ void __iomem *rsnd_gen_get_base_addr(struct rsnd_priv *priv, int reg_id);
>   *	R-Car ADG
>   */
>  int rsnd_adg_clk_query(struct rsnd_priv *priv, unsigned int rate);
> +int rsnd_adg_ssi_clk_prepare(struct rsnd_mod *ssi_mod);
> +void rsnd_adg_ssi_clk_unprepare(struct rsnd_mod *ssi_mod);
>  int rsnd_adg_ssi_clk_stop(struct rsnd_mod *ssi_mod);
>  int rsnd_adg_ssi_clk_try_start(struct rsnd_mod *ssi_mod, unsigned int rate);
>  int rsnd_adg_probe(struct rsnd_priv *priv);
> diff --git a/sound/soc/renesas/rcar/ssi.c b/sound/soc/renesas/rcar/ssi.c
> index e25a4dfae90c..e0eb48f8977b 100644
> --- a/sound/soc/renesas/rcar/ssi.c
> +++ b/sound/soc/renesas/rcar/ssi.c
> @@ -544,6 +544,7 @@ static int rsnd_ssi_hw_params(struct rsnd_mod *mod,
>  {
>  	struct rsnd_dai *rdai = rsnd_io_to_rdai(io);
>  	unsigned int fmt_width = snd_pcm_format_width(params_format(params));
> +	int ret;
>  
>  	if (fmt_width > rdai->chan_width) {
>  		struct rsnd_priv *priv = rsnd_io_to_priv(io);
> @@ -553,6 +554,21 @@ static int rsnd_ssi_hw_params(struct rsnd_mod *mod,
>  		return -EINVAL;
>  	}
>  
> +	/* RZ/G3E: prepare clocks here (can sleep) */
> +	ret = rsnd_adg_ssi_clk_prepare(mod);
> +	if (ret < 0)
> +		return ret;
> +
> +	return 0;
> +}
> +
> +static int rsnd_ssi_hw_free(struct rsnd_mod *mod,
> +			    struct rsnd_dai_stream *io,
> +			    struct snd_pcm_substream *substream)
> +{
> +	/* RZ/G3E: unprepare clocks here (can sleep) */
> +	rsnd_adg_ssi_clk_unprepare(mod);
> +
>  	return 0;
>  }
>  
> @@ -965,6 +981,7 @@ static struct rsnd_mod_ops rsnd_ssi_pio_ops = {
>  	.pointer	= rsnd_ssi_pio_pointer,
>  	.pcm_new	= rsnd_ssi_pcm_new,
>  	.hw_params	= rsnd_ssi_hw_params,
> +	.hw_free	= rsnd_ssi_hw_free,
>  	.get_status	= rsnd_ssi_get_status,
>  };
>  
> @@ -1079,6 +1096,7 @@ static struct rsnd_mod_ops rsnd_ssi_dma_ops = {
>  	.pcm_new	= rsnd_ssi_pcm_new,
>  	.fallback	= rsnd_ssi_fallback,
>  	.hw_params	= rsnd_ssi_hw_params,
> +	.hw_free	= rsnd_ssi_hw_free,
>  	.get_status	= rsnd_ssi_get_status,
>  	DEBUG_INFO
>  };
> -- 
> 2.25.1
> 




Thank you for your help !!

Best regards
---
Kuninori Morimoto

