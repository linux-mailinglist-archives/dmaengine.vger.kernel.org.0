Return-Path: <dmaengine+bounces-11003-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SCdfDrdJGGpoiggAu9opvQ
	(envelope-from <dmaengine+bounces-11003-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 28 May 2026 15:57:11 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A8165F330A
	for <lists+dmaengine@lfdr.de>; Thu, 28 May 2026 15:57:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EE1C031AD9ED
	for <lists+dmaengine@lfdr.de>; Thu, 28 May 2026 13:49:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70B6B2836BE;
	Thu, 28 May 2026 13:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="wMOw7dOk"
X-Original-To: dmaengine@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011065.outbound.protection.outlook.com [40.107.74.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6185246774;
	Thu, 28 May 2026 13:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779976151; cv=fail; b=g2KQXIwDeOAJVdokLXsbcW+YaNR0yNkXhvei7HYKjYmKaJHBvYwPRRZ2GVl6d7f6grQDyvfNFSnpgCeMdW3hgMRj1JGBxIGaUlBwN+nnPNgw+y33/oy3O85DGrtR5MbXfez+BXec3kC4dET3tDiF/Fu54vg29kE0c2u+BGwm1oU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779976151; c=relaxed/simple;
	bh=lws618n2RSo3FQqOIAYW3DVwZIFsNmKHEcHQh/dKbOI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=SrEqT3UeF6Bao0I4tRHB5gUnMY8MeBmD/Xat6XJ4FkiPfmUZsFZjFk6EvABsTWvmXy3RFDgW5mkdgZ9mO8T+9F/hJsvNPNH83Z8azlSRUECKxDdM4DOOwLhw+IKVuRNzRCO4ryQHg3iSERZY4sg1TihjWpzpeqUFl897+chLkV4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=wMOw7dOk; arc=fail smtp.client-ip=40.107.74.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vmJEJLfObPdCL4UmBIi2lPTq1hfMhYHAnI90wAFUK1sd1wjHUaD53pS+57/1zUvKkBNkKLBzzk2cu5CkMMVbwegDbiaLGe5x8T8FfOOU0uhzJRxziI5M9ztp3wdyJhLa1poySzwz4RH2HvA1mZ21JOgQPhDHN14pYJfdqNyQOM7RO9wH3DjJUZ3yaprpP6V44mBhqZ92Ajm8KAhnX+nKhmDTn8w2+vIFWya9VqsSAKE+S1cWNZiVXwST9t1hMbfdrY/An9tJS1ArDGsUJJQXerw1HH/MpHUa+x7HT8UMbQJ2glVfcyH5nJpX9tj16Xoo5/dJU/ROfDX2VGC3mh8fPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dqBCebghBhV9LFqwGOYm61e1I1N3Gch2aT030HFq8uc=;
 b=GW33j7YyTEOe0cPHMmi21LgOsf894Ds+kdE2fcQSn5ijPtYFuZlMrp3fTlAcNJFIW4AiGhdE4++covmlD83I+IQX7XLnaQjNoiDO3binlol6KlUyDJzDmpQt+GgwIsSHG4/0SwX1zy9pGcpC/p1KvHl1ReFHqYSKvi7qRAl3LNBn/uz/06Lnz+0G4ywvUjv9p/rp7l0Tk0/IBAm2HADpdXihm93smCCfK4FhGa8E1Bc/33Je4lIvmft4rZtI1cyL4dmzXnAIPhyY33vh6eY5Dlw0uCQGLtOqiT0WgPiCwoGU8W7WAWNJLO9+Lq6gc1L0OCBckq7lR49/PdzQJNog+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dqBCebghBhV9LFqwGOYm61e1I1N3Gch2aT030HFq8uc=;
 b=wMOw7dOkgWWRdmgMJKqU/hlKXqi2P8cUCvzWbdYhqEwdqKqbCMic884ABuUcSWNhjn74siXah3+d3fZxeWb//5j8K9NGhhNDqBgZMhh+jUkTVaWMZa6dMXfc8Qa43kHk/4jHSmMLSt108bi9kKxJyATgA66NLnmRZsVyHtjvEX4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com (2603:1096:400:3e1::6)
 by OSRPR01MB11420.jpnprd01.prod.outlook.com (2603:1096:604:234::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.13; Thu, 28 May
 2026 13:49:07 +0000
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8]) by TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8%5]) with mapi id 15.21.0071.011; Thu, 28 May 2026
 13:49:06 +0000
Date: Thu, 28 May 2026 15:48:52 +0200
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: Claudiu Beznea <claudiu.beznea@kernel.org>
Cc: vkoul@kernel.org, Frank.Li@kernel.org, lgirdwood@gmail.com,
	broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
	biju.das.jz@bp.renesas.com, prabhakar.mahadev-lad.rj@bp.renesas.com,
	p.zabel@pengutronix.de, geert+renesas@glider.be,
	kuninori.morimoto.gx@renesas.com, long.luu.ur@renesas.com,
	claudiu.beznea@tuxon.dev, dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	Frank Li <Frank.Li@nxp.com>,
	John Madieu <john.madieu.xa@bp.renesas.com>
Subject: Re: [PATCH v6 08/18] dmaengine: sh: rz-dmac: Add helper to check if
 the channel is paused
Message-ID: <ahhHxHg1EzPQE-G2@tom-desktop>
References: <20260526084710.3491480-1-claudiu.beznea@kernel.org>
 <20260526084710.3491480-9-claudiu.beznea@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260526084710.3491480-9-claudiu.beznea@kernel.org>
X-ClientProxiedBy: FR5P281CA0010.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f2::11) To TY3PR01MB11948.jpnprd01.prod.outlook.com
 (2603:1096:400:409::5)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB11947:EE_|OSRPR01MB11420:EE_
X-MS-Office365-Filtering-Correlation-Id: 1cdebe5e-9229-47f8-b4a6-08debcbfe2d5
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|52116014|1800799024|38350700014|18002099003|22082099003|4143699003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	sk0rBk35WGOfzMqo80C7GikGbmCYNFNHuy+2crtTTK3wGJVYFRVS+x0rxu9NgY3M/iPv4OuNF95GKqCNY9wtpkJCa8CmoDSWXXM6+Bl4SgwxieyPjEcSFaXya8PXXxqAigDjIGEQAaDeN5E2pBvqK1cpvZ+ARwmEdhze/7t5eqi0ZL7xarq0G/PAFHdbGvgBtM3dZ0Vt4Y/HeTFqBACfHEVUVEQKInSC4flPAOGkQC0ZoRi7EVP1bRLe0HsA/7KcwKUQAB0V7Vo2XsBidnjojotaeiN/0cOrAJpw/JMZzHekJP6zaWIImPGxZIFTznYSmP/bjHrSt+qiXX06YBfkwUEh1Gh5/pjOQf361lhDH4SBQLQ1h+KPiNFzznISiCsG2dWWgnP0agh1LZD8q7f4hA0TF3MiB42EjfszjHJnjhsVaUnDYyg3uFzibzlf/tMZkkVBmQToyZnthTww4p9i4MgJgD4/DwOptVbsAGB5tasH7NVMG4+DC+ukO0ESTiL+vThYeEflXbuUCNZYaRw5YiVI808X9b6vvXuAOCYxTSnRyoqpf3DnKIpWFXzWzeb8CRJ75MJAu2a+AMPNtqbofJs4GpNUFsp4v4PUIg9g2vXRl7XU9snu+qnqB+gAYngse8sXwdaKs2CHawKrJ2wtwXH9QF7vwfU+GbK3Jd4UJWiLOrLpB9ChwRSeoFdfXMBPkSVnOMfyebML34pY35nuSY75KuMCEfpEoVh2vud+lb5VX26VUzPMBxbN/NIsbZXS
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11947.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(52116014)(1800799024)(38350700014)(18002099003)(22082099003)(4143699003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zlZfIpHO0v87uY2MGF6ztOqgr9rrIAm579JKd7/LJOfe1ehiZPdS0rQDoaAb?=
 =?us-ascii?Q?kj64Jyya8FAfEPO6Wy4zC9qM7yfZdCB+Tx5TZUqXpuB2RRXcE5lwUEkfg2jy?=
 =?us-ascii?Q?LIqzj0CHO4jJNWQAjB15kGB9S0z30Pp+nQ/0zKFqWz1rXXftq/c1MJjACEmY?=
 =?us-ascii?Q?cTkTrULKVWucCUqjXLPbAobZuqA5hBCSBl9zJUTCjUTD0bP5WdjxR8th1hXM?=
 =?us-ascii?Q?0HvVMuCZmXn9g19rLb1Chxj8EN4jvqhvpPwo046D+258Z0kkswvVPY6IuGdw?=
 =?us-ascii?Q?dgZLG0H4+aa+IcfyVUNHMn743dFZmnrU8CXHvbnlMuiT1pQn5AyNi04V2cZ1?=
 =?us-ascii?Q?8GWdqmPwvYpBNXGow8k6hqyu5Xi13qIWiV5sQQDsl2VgYC1EwiK6uPaw9axD?=
 =?us-ascii?Q?nMwuEhvz0zmE90VGvmkCdShL7vaytyzCdDf20D16j/uo/sJMuQXZipdBYHP2?=
 =?us-ascii?Q?F1i5UYvbyUP541lqaWe+y+Yj4s24l78as7RKyxEpwr3is22CXSK04jpXiXiH?=
 =?us-ascii?Q?FLvdvy4iqFRH1c8aLYh5lrV4u7IqKxoEhq4v0fjzVPlPeOvGy/nvBVrOLYjL?=
 =?us-ascii?Q?5/SJ1rna3c9BqekEqZlqIzNmNFtMZyG1gf1NQI3A6Pf1QDJYGxK+qcsRMXXj?=
 =?us-ascii?Q?A6NORrelWvQuddoHorhCc5ERjU7f2E4XotlIZ53YN4ARCAuedbxmYMzxGydG?=
 =?us-ascii?Q?PcNuKTIv2L7hONsYKfq2kjA6LI6z5fhhexLlysZzhFG2PF8Kx8kUNoXYMlny?=
 =?us-ascii?Q?DTaB/WAyz+QB2rDZ2dWPNfF70UbQ8ZiRhvaeywHsoRmMkBmDL9lIwERVfGTl?=
 =?us-ascii?Q?0IwwJZoUk4QUZc0I+QDMl1bru8vYveph+1XYwxon6/ObI5meVHxbuHrnhAp8?=
 =?us-ascii?Q?IVUhcC9Y3t+i8V3s3Xwv2YDUQgA214VuZNhb72KNKFo8GD944Zdj+2nLtHof?=
 =?us-ascii?Q?Ui+8S9wDNmyQAmsLqC0UubwcmM/eDQDmM0FoN0zMtFt4X0cB+FAWk5KsbAUx?=
 =?us-ascii?Q?8xVQQfIYqVFiXVIV5wEEvJ6vg7ATiOQtHFHD3nM1Z1amWhz/M6RLRqFWLvIx?=
 =?us-ascii?Q?iP9gdJrHufJKrCaMQg9hhg4Al5lApU6Vmhq3+EBgwNKmbHmYglmG2ajBTjL1?=
 =?us-ascii?Q?QBFRk9hhAIocVxaKqOoIbWnyPSomjD/2q4k7O9MqiavOMNyXFRIWM4y0WQIv?=
 =?us-ascii?Q?GniAan+sJPvobDGIKblw29iqddMSLZyleQ5Vx8l0D9bfVyEQ80uU23p5+vHl?=
 =?us-ascii?Q?y76/7ZJAypnGb5HaY3940OL4JBU1f1+GBo0sb/4qRm+27VXH6bxyscC4QtpR?=
 =?us-ascii?Q?5MdwH7jxxZpdu6cJhGIoelcgg5yyZnQQPr4Su49qAqswEP2rcHV7imGZwokD?=
 =?us-ascii?Q?n5ojR3NcOyeen39SYAmF5HfoORfhNNNB+rndtZwhzSnsLfMuZo7dQgMABw/M?=
 =?us-ascii?Q?/esRpSIheNYnCIBMyATjzDwVC4JjLtPzAcoRF0e8pnsY16STASiFCEaTTPRJ?=
 =?us-ascii?Q?6XP4Y6q8Ge8dwvXPeRKXBLp21Gtly1ox1HfFpjx5rElICFGrarM44rUBM1Gp?=
 =?us-ascii?Q?Gkx7JpKsqR3+HCj1vn3E+7v0bI+vYWntxgMOaE1s4JoEKWRnB1FuUGRPDVtw?=
 =?us-ascii?Q?fBEMmBhqVINbTJuoXQZySI+OSDnHiKGEeNgdhr/f9zvAbQv8op8GBcaEQueL?=
 =?us-ascii?Q?zntYihuw//Ns9oCZ+OqJ4rdkuPNKO06WAWqAUoTaa17jtcDQIUCT1mYJNJDd?=
 =?us-ascii?Q?3f71cnCFyYcefV4CJG44P1wz8jdnd7gfaTqS9W2GkrfhkNZV7c+X?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cdebe5e-9229-47f8-b4a6-08debcbfe2d5
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11948.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 13:49:06.7932
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yWNxsgzVPhdbLUozM5TbrOdRWs2FsoAf3Tp/bFHr1dNPtrOJDN3akKKfYXyFQ4Axcj9IVxuMObYJuJzgYYn3nom4GVR7T5juqeuxZQTG4pPTeCfMJwdzu7yM5tfPY+qd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSRPR01MB11420
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[renesas.com,none];
	R_DKIM_ALLOW(-0.20)[bp.renesas.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11003-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,perex.cz,suse.com,bp.renesas.com,pengutronix.de,glider.be,renesas.com,tuxon.dev,vger.kernel.org,nxp.com];
	DKIM_TRACE(0.00)[bp.renesas.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tommaso.merciai.xr@bp.renesas.com,dmaengine@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[dmaengine,renesas];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[renesas.com:email,bp.renesas.com:dkim,nxp.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 8A8165F330A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, May 26, 2026 at 11:47:00AM +0300, Claudiu Beznea wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> 
> Add the rz_dmac_chan_is_paused() helper to check if the channel is paused.
> This helper will be reused in subsequent patches.
>

Tested-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>

> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> Tested-by: John Madieu <john.madieu.xa@bp.renesas.com>
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> ---
> 
> Changes in v6:
> - updated patch description to reflect better the changes
> - collected tags
> - s/chan/channel in rz_dmac_chan_is_paused() to follow the naming convention
>   accross the driver for the variable of type struct rz_dmac_chan
> 
> Changes in v5:
> - none
> 
> Changes in v4:
> - none
> 
> Changes in v3:
> - none, this patch is new
> 
>  drivers/dma/sh/rz-dmac.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
> index 76bac11c217c..217657513fa7 100644
> --- a/drivers/dma/sh/rz-dmac.c
> +++ b/drivers/dma/sh/rz-dmac.c
> @@ -286,6 +286,13 @@ static bool rz_dmac_chan_is_enabled(struct rz_dmac_chan *channel)
>  	return !!(val & CHSTAT_EN);
>  }
>  
> +static bool rz_dmac_chan_is_paused(struct rz_dmac_chan *channel)
> +{
> +	u32 val = rz_dmac_ch_readl(channel, CHSTAT, 1);
> +
> +	return !!(val & CHSTAT_SUS);
> +}
> +
>  static void rz_dmac_enable_hw(struct rz_dmac_chan *channel)
>  {
>  	struct dma_chan *chan = &channel->vc.chan;
> @@ -822,12 +829,9 @@ static enum dma_status rz_dmac_tx_status(struct dma_chan *chan,
>  		return status;
>  
>  	scoped_guard(spinlock_irqsave, &channel->vc.lock) {
> -		u32 val;
> -
>  		residue = rz_dmac_chan_get_residue(channel, cookie);
>  
> -		val = rz_dmac_ch_readl(channel, CHSTAT, 1);
> -		if (val & CHSTAT_SUS)
> +		if (rz_dmac_chan_is_paused(channel))
>  			status = DMA_PAUSED;
>  	}
>  
> -- 
> 2.43.0
> 

