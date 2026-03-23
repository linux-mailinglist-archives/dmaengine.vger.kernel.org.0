Return-Path: <dmaengine+bounces-9575-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mJKQO3uYwGlXJAQAu9opvQ
	(envelope-from <dmaengine+bounces-9575-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 23 Mar 2026 02:33:47 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E59812EB7CC
	for <lists+dmaengine@lfdr.de>; Mon, 23 Mar 2026 02:33:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D332F30028D3
	for <lists+dmaengine@lfdr.de>; Mon, 23 Mar 2026 01:33:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA5A519E96D;
	Mon, 23 Mar 2026 01:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="Go9t/4J+"
X-Original-To: dmaengine@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010065.outbound.protection.outlook.com [52.101.229.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 029CACA52;
	Mon, 23 Mar 2026 01:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774229621; cv=fail; b=YbyCyunHok5UdfTxbuSejWquJVInFwEmW8Rs9Tc+IlJtDH5/cQr+QJ9dnKQRvg1m8VSgXrX2m1ElzXW09EyjOwrfPec9uFBJzTYa4F19VKttIg8KiGVDpX8V7OPBLSX1PGXw2kpacZ5UmDdCxXh8GAHLa+oqKHQi9Gq2kkxKaqw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774229621; c=relaxed/simple;
	bh=wmQUgfe3R5fLnjW1Wz8bTHb2lFckAfjfAr53dcIVnok=;
	h=Message-ID:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=PaEp7PEsCyCl3msfWbeKwqOHrIk17vMDgbCpfUH65XeqQdaOCvD/j2xXyfFaZ2YsL9NPA2+6NbwCSGbfAo9lVHHJIK4z094eAC8MmS97ESh2tWq3JmShUI08e36xq2Ynaj4hW7IyQKDScYoJB4Ugu2SVyq1ajIMuglOAnqqFmpQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=Go9t/4J+; arc=fail smtp.client-ip=52.101.229.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=coFw/+IgRw7r/ITtCnldHXpMwlT6zewmWpUb6OBL4dxzWN82HsWDsarZGyUlJh/ziE09KTn5tj9yXJqOOgu6Iq+iTe68RCN/FRyImAzAESwr03SSoHj82BUtbG9kpwW/1jf/y7MNMib11StOv0sUrnEXd3jKLKrFO/iBX4Fj5q02yYDT3+eyPS0FoM7Hc8VOfJjsNd1B7JbDvykTEFPCZaZO1kxS2DZUiYXa68zOQgtiSA+vDYPfxicj0dBS16K7LhVLsrpUtBHIdzkxGGat2R7so1fgzCITB3XLjLJMFyOSPtDmDBdXiZbMbh3Oh+5BuGXwJhqWcan66/++usRJXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M3W7XfWaMthsVMpep9MucitNVRbxgRmymSrw3hzDiTo=;
 b=t6L4CI5cfttQ5M5U8duDVnDRljAORvxBJaNA+7isKYGUBejaByQ8U+fx5YWaL/Fn0nViaHMkAV4XJEWUS0nlzAefHkWZP9dvrdaJ3IKQP3fQbCWOQGIHfBXfdEr0C64rwE+gfxSrk2qVBXKu8jUgh3TmxZld4JCLBjGvqQxygHBBzuBUTWDYCb6U0jod5UGJlBFAJcS877Mg7VyKuqxvlwBuGmvj+9KOBoRHYqBYsaFrc/G6MyMyjqXOFyI+Ja0OBk1f+/ut1A6f3XIm2gE0mxO7f7Te6TD/ysBbMD+nPdEn6WTs/gNuO2udVvCjVzM4XguB3TWqjl0guNb8I2UbbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M3W7XfWaMthsVMpep9MucitNVRbxgRmymSrw3hzDiTo=;
 b=Go9t/4J+q6yC8eCWmrlJKaln1KKbfG74KEpFcacGn/7zIC0jx7jyyr65uHoeQo85nhIphX/5hf3aaXvUWl5N8xFLJ9K/imob1+JdDpITPS5Mk+9b1PSxnA/Xj/uq6VnBXaZ/VL6ysfkrT7p+Via+eKDwmK5ToRwRyVSRt+BFDWs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
Received: from TY3PR01MB11797.jpnprd01.prod.outlook.com (2603:1096:400:373::8)
 by TYRPR01MB13712.jpnprd01.prod.outlook.com (2603:1096:405:18f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.25; Mon, 23 Mar
 2026 01:33:24 +0000
Received: from TY3PR01MB11797.jpnprd01.prod.outlook.com
 ([fe80::1868:c915:c230:a383]) by TY3PR01MB11797.jpnprd01.prod.outlook.com
 ([fe80::1868:c915:c230:a383%5]) with mapi id 15.20.9723.030; Mon, 23 Mar 2026
 01:33:28 +0000
Message-ID: <87cy0v9vo0.wl-kuninori.morimoto.gx@renesas.com>
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
Subject: Re: [PATCH 12/22] ASoC: rsnd: Update SSI for RZ/G3E support
In-Reply-To: <20260319155334.51278-13-john.madieu.xa@bp.renesas.com>
References: <20260319155334.51278-1-john.madieu.xa@bp.renesas.com>
	<20260319155334.51278-13-john.madieu.xa@bp.renesas.com>
User-Agent: Wanderlust/2.15.9 Emacs/29.3 Mule/6.0
Content-Type: text/plain; charset=US-ASCII
Date: Mon, 23 Mar 2026 01:33:27 +0000
X-ClientProxiedBy: OS7PR01CA0197.jpnprd01.prod.outlook.com
 (2603:1096:604:24a::15) To TY3PR01MB11797.jpnprd01.prod.outlook.com
 (2603:1096:400:373::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY3PR01MB11797:EE_|TYRPR01MB13712:EE_
X-MS-Office365-Filtering-Correlation-Id: 30a3c1ff-29f8-4b02-5b2c-08de887c2ef1
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|52116014|38350700014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	C1qWjjtvbpNO6Du0N4rCI9PGqxfwn1tOCrCbnTEw7/matJqUa14sgft+Yg/99bmqL0/Z9Wtx3xFEY+IkmzqeqcsKgXG464s6gqXl/0bbNPnY8gb5yucndjRCAszSLtpEFZwjf6+SP/XYbWF+T6vVICrbO3CmUv9rYFqjPUHRwvpkXAA6ExqMMMSkgxmwM/Dycg3kWNZso6l3KqIc5bI0T7z6WBIo9Npypd98mlqdC3mpj6vZb6fV3Cj/lXC4wDt35dvbJ23EyIJtUU/USBgkpxzVq717h3x7UNrQCOYuw3ScWyyl27YSiZRIkZRfivFgoEC0T/S0yBiq4EnszQ9hAXukpCiawIrftnqKE5bWIw5xdF05/fUK+c4X8ycMbOvY7ffCn/FUxCPA+DQQ608Fmzw/McYnDyg802hgGC10i28nKDVIKGYF2rg8KJQD+Gv+1kGVrqJamQcbEPTebvn9h9FLjuUL9Tqnw/mZKARvK3mLCCOaEpfFHBFvmmCuD5+ZEFl9q+t/xJMY86ldoIsmQ0V0ENrK5mNLWpmnS5YTXKtdNuNKcRV2Jlc/XHitIVDMOKrivk88JSSXFMyd1oVlb39tGfA36+REZGH/fPv0WrN0vXvEx3zolKw3RYli8Dr3XbD7SIKeL8Oi2wXPnNXg+Jp28FtX2CE2NSwChEeWq0RCEc2exZR1kE7hoBHp2UKve3QaGP44i65OisrWiccPNshje9GwBFA510uEuEkK8YGNZN/fyFg/8ZEsnNkKPq1TezcRibHLFPkkSAIKiouqgxJGtR37IVGDOVhDq815lsE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11797.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(52116014)(38350700014)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?x9pEbzX7V4sNw2a7sCmq1zOYInFDRLzJ4zfpBFxdHEZebcRgTuIDqQvHNNIH?=
 =?us-ascii?Q?7BfgB0QYf3UxzAUA8gYlBLrrvJ2fvZ8eBeP4vjDQNjTqvRPduRTSAplsODvZ?=
 =?us-ascii?Q?zum/YSmjP7ZTFK8RsSTDXNI9Rdj/s6Pv/eHz1YUsw1CAaBuSUJSIbIvFE0zA?=
 =?us-ascii?Q?t9To0T68STeA6aEivf2dgc5esACuIuvAp+939fl/+M5+YoInjwMwHP/3+8qg?=
 =?us-ascii?Q?u9wQR6B2JrNboTHYa0ABJfyV9YHyARJFAbzFDEcNNyp4+iJmXpa5NZrwji6L?=
 =?us-ascii?Q?Al0Ndmcss6BUg3ep09D27QyFKwEnCFF/o8EW6Yi1V+ELqCFd0ePWHYUuVJyi?=
 =?us-ascii?Q?ljXqcY8CVteWrBRgiKmDCUzD/PE+6ZaZOZbQmWDbd009nIjbGPRA6IDL/gq9?=
 =?us-ascii?Q?9Q75C0BdmKNytmdP+N70P6QRwH77e67Qdm8j7FoQN3xSR+OYv72Zj4j27ojO?=
 =?us-ascii?Q?AciG66MRenT565taHEUVuyUl3GEa2SE9DL04wnh+w+JtPMo1zWJh6IQ3C3DZ?=
 =?us-ascii?Q?2YBSz8bwcqbgzUZccTlFS8kx0lGe6lyQl8AaGO14cOv/3+Ud7JjKX9lrwX7G?=
 =?us-ascii?Q?4+mI61jolpkF9TDL+Z0dlKpUIUvZv1hUsf8245tE/UktV0oB3vcAii+fxANB?=
 =?us-ascii?Q?jPIFLeVe4rEx+93KnnWhPmhl8y5L9S+mT3yheMnEi0ime/XukFyEZ5kn06Yq?=
 =?us-ascii?Q?gGIfPWMuEtLPO1NHSd8LfBF/WHL9WV+qNwJprpwn3hj0pOKyH+oauHI8+Vbe?=
 =?us-ascii?Q?yFupBYOhCqJFdK0roX76HHovVQGW19ARREOlCiz5mO36x5RodJ0Lz7+gPjlg?=
 =?us-ascii?Q?ZMzhwQDx55l1AFyg1cCylkizgaJZB7g8+pigQiCLn/uLqiApdyAzPE4FB6XJ?=
 =?us-ascii?Q?W8iWHkbDhy3nxhs5jQfYYSjX9Lwh11n3GBY6HcwPazlrPlqB9UYr7+YqVhBw?=
 =?us-ascii?Q?P9ktuZXt5GkYkIvQVHUJugz+Vx2i0e7OzxkR5ShchVQVo1RGFp0B5OrFxBpy?=
 =?us-ascii?Q?O7mK14DAmLMcFVH2SIMabLJsq0Y3V8OmLaH2j79dgHLAJswBOE4qIk2+Iu29?=
 =?us-ascii?Q?87RM5DQeFId3u13l7UJKM6CJWWk+p6tmGTrxmhaIzkoXwwxU5m/Lg8TLtL7p?=
 =?us-ascii?Q?V7wx2TEadysILSN86D3Rv+WBMnV+qXJblnUsgx/IC+iEp7mth7ZVCOWfCx+0?=
 =?us-ascii?Q?4o9D8gIv701Ac3ocIniGCKUUBFCAJJkOeqKnAMutKnD5zrF++8vhGCxN/Rgd?=
 =?us-ascii?Q?8LTvtTO+3vNrx6OGUM+kEf2NdSjtsIVVRl7HgHlXkytC3Eu4GZkLCw0nAF2J?=
 =?us-ascii?Q?XQRwgF4m6QnM9ZE5MKzxo9plEk60nCbPV/bDk9FC0Cw6mk6Vax6RmHX8PJI4?=
 =?us-ascii?Q?jYukMY8V5K1Mmb7jiFuvMKDAhW7AWsvWQLOepbXMlp37wuZCQ6TC7bu1A4X5?=
 =?us-ascii?Q?0MTNqvoPpkxfsQR6iW6dTrhw41J9yARSyIGdOK0j15nimYJbAa76UxSpORg7?=
 =?us-ascii?Q?ZF8wPOAUxzNssnlkSP1BVV8rLvNXh5yyP75CFkjQdTmuWJlFnHkeCeB/+gfE?=
 =?us-ascii?Q?CL6I/K9LCsthJ2hwANtjnsPpJge84KaPHttmyy+pphXfycVrJWQ1Ey7mLzwz?=
 =?us-ascii?Q?NpuSoiMlCSjKONLdCMTAlc828QHXjBRYij0Q2MKHtlu56FnNHYKL+qEqLBLz?=
 =?us-ascii?Q?gnTmN1K+hLq++XUV1zYrdtl+1Qq+8WaH4Y9VTYzBdMmX85p74eMszoyV9viY?=
 =?us-ascii?Q?mHSBcIoNglNZuCg2ACcUHiEo9tIz1/dztCR+OqT+Y6ALjaxa7TwZ?=
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30a3c1ff-29f8-4b02-5b2c-08de887c2ef1
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11797.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 01:33:27.9946
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4h7pdVsiBSX4BAGftbjL+2GMQqZkIMvl2pdjcn+odSPJv8070mYl/Q48uRDPv9MfGJrOyAcdbAUd9LybXQJBSVm7ybR8Kb71d1T8FOkMmGBbjcUV2wgSzrz586JXnY9L
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRPR01MB13712
X-Spamd-Result: default: False [2.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[renesas.com,none];
	R_DKIM_ALLOW(-0.20)[renesas.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9575-lists,dmaengine=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[renesas.com:dkim,renesas.com:email,renesas.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E59812EB7CC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


Hi John

> Add SSI support for the Renesas RZ/G3E SoC, which differs from earlier
> generations in several ways:
> 
>  - The SSI block always operates in BUSIF mode; RZ/G3E does not implement
>    the SSITDR/SSIRDR registers used by R-Car Gen2/Gen3/Gen4 for direct SSI
>    DMA.
>    Consequently, all audio data must pass through BUSIF.
>  - Each SSI instance has its own reset line, exposed using per-SSI names
>    such as "ssi0", "ssi1", etc., rather than a single shared reset.
> 
> To support these differences, update rsnd_ssi_use_busif() to always
> return 1 on RZ/G3E, ensuring that the driver consistently selects the
> BUSIF DMA path. Also update the reset acquisition logic to request the
> appropriate per-SSI reset controller based on the SSI instance name.
> 
> Signed-off-by: John Madieu <john.madieu.xa@bp.renesas.com>
> ---
(snip)
> @@ -865,6 +872,8 @@ static int rsnd_ssi_common_remove(struct rsnd_mod *mod,
>  		rsnd_flags_del(ssi, RSND_SSI_PROBED);
>  	}
>  
> +	rsnd_dma_detach(io, mod, &io->dma);
> +
>  	return 0;
>  }

Why do we need it ?

> @@ -1207,6 +1217,16 @@ int rsnd_ssi_probe(struct rsnd_priv *priv)
>  			goto rsnd_ssi_probe_done;
>  		}
>  
> +		/*
> +		 * RZ/G3E uses per-SSI reset controllers.
> +		 * R-Car platforms typically don't have SSI reset controls.
> +		 */
> +		rstc = devm_reset_control_get_optional(dev, name);
> +		if (IS_ERR(rstc)) {
> +			ret = PTR_ERR(rstc);
> +			goto rsnd_ssi_probe_done;
> +		}

So, all R-Car platforms will be handled as error ?

Thank you for your help !!

Best regards
---
Kuninori Morimoto

