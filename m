Return-Path: <dmaengine+bounces-10040-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YBrNMPvY5WnWoQEAu9opvQ
	(envelope-from <dmaengine+bounces-10040-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 20 Apr 2026 09:42:51 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2835A427D59
	for <lists+dmaengine@lfdr.de>; Mon, 20 Apr 2026 09:42:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 67AF8300277D
	for <lists+dmaengine@lfdr.de>; Mon, 20 Apr 2026 07:42:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2C1A346777;
	Mon, 20 Apr 2026 07:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="WgIiy3jY"
X-Original-To: dmaengine@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010034.outbound.protection.outlook.com [52.101.229.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC40F28641E;
	Mon, 20 Apr 2026 07:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776670939; cv=fail; b=omS+wzJ2I/lcHf2w3f3O2Zk9FZl32LTVNQ8UJtbW78M60IT1w1BQQrRY6KrUuiFq6H+WgrMcLvmb7bPFEu0qswgQ9KNHQIiXeqVIjBRV1phxW9pi+DxL2yoLagGdqo335RkK7u4/ZFZGvrE+rl6ySqnno8oFlBYbQ9eeTqr4GVI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776670939; c=relaxed/simple;
	bh=rfNjXJlgX2I2vvMs81je0uxfk5mjTv1U/HrI5PGTq3U=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=S17tI/WJk3lA+a6LvpZkZBZ1L4Huzexsr2pLMp1JeSmhsLZdAdf2nVOAIbMDb0SlI5PXk9xpqU2nbXrL1CNR0q7P2DebFgZRA39DnGUzdffcccrtHw163ig25RxlIK7+ZsM5MltqDb0nA2kto3VgSzFZ72RvSgMuTtL9bjlfPNE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=WgIiy3jY; arc=fail smtp.client-ip=52.101.229.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A2v8SwFB1Qh+XxXv7X5E5yR3ZBJuLhAA0vkO42yb/ex8MXQ9V4Z/9MMY5GCgYe4C37zsPlgwcXFlO5Wrp9XfAAmUQYlHH0l9/m1BsUFc/rQ+DuSG7ZdKTuTyDTCg2kiInoxyCfUq5qWjfCnLj+ZyyZufGHsALzUzYm8VoMitbgxnIlvrKK1JgFB4TAS6tRUr+VLWbML0BzHH77dRb7Qn3wm1VhEBIGhVmf5O71O/SD6s8RQfVM/4khRlWh0+kk1hDI6+7BfIlgwQOIw348BRSVKJJghiBUbBmW4KK20vQ1HElL424EE1Gt5eMN8ov8fZFUGDAn843IqXx0QxnX/5WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CTlHAyq5LoNlPo+WanVojIxquK6OgiOCZM3U+pdgUC8=;
 b=oyjqaetXrh7/vw5iJndry/4mS/WviuXp3+Kj2RMeUI2N5vAJhX5Jf0AK/QMr4R8EVNvabi2Jv9r8NweBJRvnEYRMWE0urLOKBPNhiGdlsVpAUs0TM+UeFnrEaWwDqVg8UWQEdDSRCIE4D/Pyz4NC02FeQrqLUAWqiHvQ1gheG+v719tptovd+QKNXY4dirvoyT7lM+DgAy+xFSKn2UVkfmw2CibKxx0SJdIHh/mrH0FH7upgRR6f9qVQc80T4iIDUF/D1kfYm0vXn2DuEoZtBTHZJZBL+gja62D7cauNfNi7IVa9+c2kJPlBa+254YMnbNwr60HVV+hF22NqijOfkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CTlHAyq5LoNlPo+WanVojIxquK6OgiOCZM3U+pdgUC8=;
 b=WgIiy3jYixtta+ud9PxbmVlIM3H4UT/vnB+cF9RSMtl4d2BomivxLKMZBWHV2sqv+CK8wpOkVIX/2LC8SiRCYOqEPPS20yGAi6LH0v6DivOZCRBPh/Z+pU5fttiaeO9hRGhOGTM+dUqkGTMjRUDN2tObzyQ5ZkcRaRmC1LU2py0=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by OS9PR01MB17145.jpnprd01.prod.outlook.com (2603:1096:604:458::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.31; Mon, 20 Apr
 2026 07:42:14 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de%4]) with mapi id 15.20.9818.032; Mon, 20 Apr 2026
 07:42:14 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Claudiu.Beznea <claudiu.beznea@tuxon.dev>, "vkoul@kernel.org"
	<vkoul@kernel.org>, "Frank.Li@kernel.org" <Frank.Li@kernel.org>,
	"lgirdwood@gmail.com" <lgirdwood@gmail.com>, "broonie@kernel.org"
	<broonie@kernel.org>, "perex@perex.cz" <perex@perex.cz>, "tiwai@suse.com"
	<tiwai@suse.com>, Prabhakar Mahadev Lad
	<prabhakar.mahadev-lad.rj@bp.renesas.com>, "p.zabel@pengutronix.de"
	<p.zabel@pengutronix.de>, "geert+renesas@glider.be"
	<geert+renesas@glider.be>, Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Long Luu <long.luu.ur@renesas.com>
CC: Claudiu.Beznea <claudiu.beznea@tuxon.dev>, "dmaengine@vger.kernel.org"
	<dmaengine@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-sound@vger.kernel.org"
	<linux-sound@vger.kernel.org>, "linux-renesas-soc@vger.kernel.org"
	<linux-renesas-soc@vger.kernel.org>, Claudiu Beznea
	<claudiu.beznea.uj@bp.renesas.com>
Subject: RE: [PATCH v4 14/17] dmaengine: sh: rz-dmac: Add suspend to RAM
 support
Thread-Topic: [PATCH v4 14/17] dmaengine: sh: rz-dmac: Add suspend to RAM
 support
Thread-Index: AQHcyahv0JOFZMxUWUOJK3dra8ccorXnnqbA
Date: Mon, 20 Apr 2026 07:42:14 +0000
Message-ID:
 <TY3PR01MB11346C39C7EABCC7A1BC64109862F2@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20260411114303.2814115-1-claudiu.beznea.uj@bp.renesas.com>
 <20260411114303.2814115-15-claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20260411114303.2814115-15-claudiu.beznea.uj@bp.renesas.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|OS9PR01MB17145:EE_
x-ms-office365-filtering-correlation-id: 43bd5d9f-0ee4-4610-2b32-08de9eb056e3
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|1800799024|376014|38070700021|921020|56012099003|22082099003|18002099003;
x-microsoft-antispam-message-info:
 VVe2dvFeMQLrc2Pd6ihhg5q0aI7RFSmuAyhHLcW2vIYZ/roUrISjsWkmUwVAp6PdFKWv4TSigHNTC3McTlRA5BXBK34VdfNUxhM/h0hiODKn0bOT4WdSR8NGEWrlCAdaLDz2HsJ+iKhJQvz6iDaZOvsPAgjdRX7pGXLEw6mXbkV9GBKu6HZ/N2JPIIkhCBTXRxu8st6AHWVDUH0bcecabeDOKqYYFRy2sCIn0PpGblJW33rCfHBmJoCryeusz0xVdwn/C0dFGE3f1oK79ugkDv6pL2djthdBOu9jDnTOH32M0kVn88RA+0W5GFOSFh6N2a+I4lrXXjetoVXoV4vq+vU7FctfrIyJFVEm18eqfQ85mL73bvAwyZ0U9nlRq01Xk2APwg8d1zdvU6JQzZsRxbTrr9FyyQSPubYzNu8/4KvykZrVHNMn+svV+auyaH/kiHNKmrp2U1B1Wxx2PIZn+uAr+9IA4S8rejlj6N7VpSfIfz4+D0mYcNFEIm8uRWp1OO77sVO24N/IhiMYW5aDHBPOeBTJULD+vBbgnsqeMy7wCIZralPj81upaEDogHm6rJB4N8KxbwygzA12xlbX8v7HwWOPRSU/P3DXlaQCYVfggfP0qeHkANuRCOb8cbnV9+eg7HNn4Nft8S9P5fAqxSx0e0FVzmBJnP0Mm5efWjzsj/ilO3pe+k8JDaIt+mQ1cXgd/bZpgYIRBClzHbsfqDbgpD3PgFHJf7C7ufgjFKPcnRfonR/w2LZvAQAjH/V3aoEYuYO9RaXCxYYwBvcWO2tkkgxPEu9Gu/YZ5s/a2oMu2LSxz8pkDAjiGa6y+3pD
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014)(38070700021)(921020)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?XlcNdPIw+072geGZCC0V4dm4xTGzfw3ZQAx+ZnXxl0HWNpxZqDq65jMQfy6X?=
 =?us-ascii?Q?x41QKjtdRbxtgDpTLBddy7on4t888bcCnXgQpZFRxnSTbWKyT1/jb0oVWtuO?=
 =?us-ascii?Q?hPRWom1JvtoynMT+070W8d/H1p2Df4/DtcZwohWNB0Yv43xUY/mpBt8CgXDD?=
 =?us-ascii?Q?w7x15e9lAZ6hg6NEa4+ItZEYD50gngU0Wsj5EmtgOUWz6ihetZvXwSRSd5e5?=
 =?us-ascii?Q?iYzBIV9jTeKm7nfR/tb+lwadgwwYgrR+fwha2Ytm+ds89j0FVJMo9MM7pEC3?=
 =?us-ascii?Q?04UXXSSGI1FAKePbzRwlmUzDG9hG0jYyg9SWrRi+q2jwu+0L9l9ru4LPH7D/?=
 =?us-ascii?Q?0K5iA/RLqCIED7odqy61zjSj/cb9VdtQBQZxNeFumCmUx130z/2Vh29dVkx1?=
 =?us-ascii?Q?qbKaTnFuhx/iSVFbldEd9I6HuD5JTXWRwdAIQ5+TXPi1I1vf1WNB/O8/bW+l?=
 =?us-ascii?Q?YyBhnT9sjSq2dVBNN3H+RRzVG3PpnWNHJ5iNvxdy4gDSry6YmNHkClDSva6n?=
 =?us-ascii?Q?kiPmcm2dH5Thht4J7boMkeVsCwxJ3uPdTN1TGAJWfOHJ35e4AkrUsN3RBYbz?=
 =?us-ascii?Q?okWdkWKyuU2KIIvabp07rTUQtmGRnwd2eFdNBScn/bTV5aDx51CxAhnBgKpa?=
 =?us-ascii?Q?r3rCY1EWk8wFh6Dwg5oPTpQzCdpliNzY+/XrTPkcauVWJkbQwlAjvKKAzykO?=
 =?us-ascii?Q?YXjkoIbGjedkFsWxM8VcsVIiDekq2UU53GpoXALoc0HSnhb7leLG/GHIrzeK?=
 =?us-ascii?Q?Ki4cCJPKrOvP8WIjtCf/DLGTPpRGziClhVtWfUvtQWa+H3iI6blatCpl4abX?=
 =?us-ascii?Q?/UCLO6iEeDu/0EL48Ax8/TodolTjJPp789YEwiW4IX2MYtmGMp/li55Z5uFT?=
 =?us-ascii?Q?KtAS1ici45+wktgRYQilV6Qh5Xj2FpwyCzphJ4xQpOYuR+zd+gGcMsVLSdJ6?=
 =?us-ascii?Q?Psnh39ZGs3UhfixnI0pc7orgjdM9e/Ps4R6pIVfVzZISljQNzNTMayl+14sl?=
 =?us-ascii?Q?t+jGUtmqXrK+A53+EbHZkxq6F9NJb1p7FgICwb5tNUafXMuIXU6D4K3/GzMI?=
 =?us-ascii?Q?LBFTEzYmo5zWBRao/WgfHys/XBaGUg6v9mJrJEMs1zxGAxofVIy9SeFahjU6?=
 =?us-ascii?Q?HxaH8BEFgfymkOVsJ6ogK3+UIoHIkU9LPsHmOG3IDX6EgnW1vbivmE1f/ETQ?=
 =?us-ascii?Q?ANkQmpJnYqBXI9W+ZxlXHHu9QBaLD6WVMuP++VBMN32s0Q9b/jv7pPokZ+eH?=
 =?us-ascii?Q?0vNhysL5UmjdR3s1LvXcOFJ8rYraMdyxPXlHmePN/V6cUq9JvT2bzo6NIG/O?=
 =?us-ascii?Q?WJFO45XiYHHlfmuIMgnme3+HHZSKjzpyG+kOhJLINOaeDEA5faXaElpwISqH?=
 =?us-ascii?Q?ZxOzWjrvQx0Uez4LFr//zJW713mIualeSiYKIQWpvNmsvGCAqpHD6eV+sch4?=
 =?us-ascii?Q?2OP8i35bS0tcr/Xd/yFVn7iLoOPW8rLjoZQyfGQb3fjdQLiKG88I17wtNCFc?=
 =?us-ascii?Q?utcraPdrofDIeBnJeJx2UsxA5XtC92zeMrtZTff8sGLcK+PpNdMeKI0Y3/hh?=
 =?us-ascii?Q?8hw1MXiYPSFo0797ko1nU/iDfwEKrIntgJsX/OLCCLLe9BQu4sTiU2xUQsAQ?=
 =?us-ascii?Q?CQkfBEWucYzAQEVlallvuVmYp6LwQJh25D3eDRghC9gP2ZkYIZfqIZcx+Dpi?=
 =?us-ascii?Q?12dR5FEmoxlaz6gDFPiXcocEZ7T5pDCb29aKmZbl2zYUjOjzw46HlTfGgIhO?=
 =?us-ascii?Q?Tba/cg66uQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11346.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43bd5d9f-0ee4-4610-2b32-08de9eb056e3
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2026 07:42:14.2280
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1iTLsMR7wZa6OeoARy2Zx34GNVoKonJtBGFeH1/RveJ13kHr1LBIntsrWmo0RUUwUcto87zQXUKHnw19hgw8PGyK/sCAeIa1JA3pXfl0GDc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9PR01MB17145
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[renesas.com,none];
	R_DKIM_ALLOW(-0.20)[bp.renesas.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10040-lists,dmaengine=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[tuxon.dev,kernel.org,gmail.com,perex.cz,suse.com,bp.renesas.com,pengutronix.de,glider.be,renesas.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[biju.das.jz@bp.renesas.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[bp.renesas.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[dmaengine,renesas];
	NEURAL_HAM(-0.00)[-1.000];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[renesas.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,TY3PR01MB11346.jpnprd01.prod.outlook.com:mid]
X-Rspamd-Queue-Id: 2835A427D59
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Claudiu,

> -----Original Message-----
> From: Claudiu <claudiu.beznea@tuxon.dev>
> Sent: 11 April 2026 12:43
> Subject: [PATCH v4 14/17] dmaengine: sh: rz-dmac: Add suspend to RAM supp=
ort
>=20
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>=20
> The Renesas RZ/G3S SoC supports a power saving mode in which power to mos=
t of the SoC components is
> turned off, including the DMA IP. Add suspend to RAM support to save and =
restore the DMA IP registers.
>=20
> Cyclic DMA channels require special handling. Since they can be paused an=
d resumed during system
> suspend/resume, the driver restores additional registers for these channe=
ls during the system resume
> phase. If a channel was not explicitly paused during suspend, the driver =
ensures that it is paused and
> resumed as part of the system suspend/resume flow. This might be the case=
 of a serial device being used
> with no_console_suspend.
>=20
> For non-cyclic channels, the dev_pm_ops::prepare callback waits for all t=
he ongoing transfers to
> complete before allowing suspend-to-RAM to proceed.
>=20
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> ---
>=20
> Changes in v4:
> - in rz_dmac_device_synchronize() kept the read_poll_timeout() as
>   this doesn't fail anymore with the proper status return from
>   ->device_tx_status() API in case the channel is paused; with it
>   the patch description was updated
> - keep the cleanup path in rz_dmac_suspend() simpler to avoid
>   confusion when using guard()
> - used SYSTEM_SLEEP_PM_OPS() as there is no need for having the
>   suspend/resume callbacks being called in NOIRQ phase
>=20
> Changes in v3:
> - dropped RZ_DMAC_CHAN_STATUS_SYS_SUSPENDED
> - dropped read_poll_timeout() from rz_dmac_device_synchronze() as
>   with audio drivers this times out all the time on suspend because
>   the audio DMA is already paused when the rz_dmac_device_synchronize()
>   is called; updated the commit description to describe this change
> - call rz_dmac_device_pause_internal() only if RZ_DMAC_CHAN_STATUS_PAUSED
>   bit is not set or the device is enabled in HW
> - updated rz_dmac_device_resume_set() to have it simpler and cover
>   the cases when it is called with the channel enabled or paused;
>   updated the comment describing the covered use cases
> - call rz_dmac_device_resume_internal() only if
>   RZ_DMAC_CHAN_STATUS_PAUSED_INTERNAL bit is set
> - in rz_dmac_chan_is_enabled() return -EAGAIN only if the channel is
>   enabled in HW
> - in rz_dmac_suspend_recover() drop the update of
>   RZ_DMAC_CHAN_STATUS_SYS_SUSPENDED as this is not available anymore
> - in rz_dmac_suspend() call rz_dmac_device_pause_internal() unconditional=
ly
>   as the logic is now handled inside the called function; also, do not
>   ignore anymore the failure of internal suspend and abort the suspend
>   instead
> - report channel internal resume failures in rz_dmac_resume()
> - use rz_dmac_disable_hw() instead of open coding it in rz_dmac_resume()
> - call rz_dmac_device_resume_internal() uncoditionally as the skip
>   logic is now handled in the function itself
> - use NOIRQ_SYSTEM_SLEEP_PM_OPS()
> - didn't collect Tommaso's Tb tag as the series was changed a lot since
>   v2
>=20
> Changes in v2:
> - fixed typos in patch description
> - in rz_dmac_suspend_prepare(): return -EAGAIN based on the value returne=
d
>   by vchan_issue_pending()
> - in rz_dmac_suspend_recover(): clear RZ_DMAC_CHAN_STATUS_SYS_SUSPENDED f=
or
>   non cyclic channels
> - in rz_dmac_resume(): call rz_dmac_set_dma_req_no() only for cyclic chan=
nels
>=20
>  drivers/dma/sh/rz-dmac.c | 188 +++++++++++++++++++++++++++++++++++++--
>  1 file changed, 183 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c index 9a=
10430109e5..00e18d8213ca
> 100644
> --- a/drivers/dma/sh/rz-dmac.c
> +++ b/drivers/dma/sh/rz-dmac.c
> @@ -69,10 +69,12 @@ struct rz_dmac_desc {
>   * enum rz_dmac_chan_status: RZ DMAC channel status
>   * @RZ_DMAC_CHAN_STATUS_PAUSED: Channel is paused though DMA engine call=
backs
>   * @RZ_DMAC_CHAN_STATUS_CYCLIC: Channel is cyclic
> + * @RZ_DMAC_CHAN_STATUS_PAUSED_INTERNAL: Channel is paused through
> + driver internal logic
>   */
>  enum rz_dmac_chan_status {
>  	RZ_DMAC_CHAN_STATUS_PAUSED,
>  	RZ_DMAC_CHAN_STATUS_CYCLIC,
> +	RZ_DMAC_CHAN_STATUS_PAUSED_INTERNAL,
>  };
>=20
>  struct rz_dmac_chan {
> @@ -92,6 +94,10 @@ struct rz_dmac_chan {
>  	u32 chctrl;
>  	int mid_rid;
>=20
> +	struct {
> +		u32 nxla;
> +	} pm_state;
> +
>  	struct list_head ld_free;
>=20
>  	struct {
> @@ -962,20 +968,57 @@ static int rz_dmac_device_pause(struct dma_chan *ch=
an)
>  	return rz_dmac_device_pause_set(channel, BIT(RZ_DMAC_CHAN_STATUS_PAUSED=
));  }
>=20
> +static int rz_dmac_device_pause_internal(struct rz_dmac_chan *channel)
> +{
> +	lockdep_assert_held(&channel->vc.lock);
> +
> +	/* Skip channels explicitly paused by consummers or disabled. */
> +	if (channel->status & BIT(RZ_DMAC_CHAN_STATUS_PAUSED) ||
> +	    !rz_dmac_chan_is_enabled(channel))
> +		return 0;
> +
> +	return rz_dmac_device_pause_set(channel,
> +BIT(RZ_DMAC_CHAN_STATUS_PAUSED_INTERNAL));
> +}
> +
>  static int rz_dmac_device_resume_set(struct rz_dmac_chan *channel,
>  				     unsigned long clear_bitmask)
>  {
> -	int ret =3D 0;
>  	u32 val;
> +	int ret;
>=20
>  	lockdep_assert_held(&channel->vc.lock);
>=20
> -	/* Do not check CHSTAT_SUS but rely on HW capabilities. */
> +	/*
> +	 * We can be:
> +	 *
> +	 * 1/ after the channel was paused by a consummer and now it
> +	 *    needs to be resummed
> +	 * 2/ after the channel was paused internally (as a result of
> +	 *    a system suspend with power loss or not)
> +	 * 3/ after the channel was paused by a consummer, the system
> +	 *    went through a system suspend (with power loss or not)
> +	 *    and the consummer wants to resume the channel
> +	 *
> +	 * To cover all the above cases we set both CLRSUS and SETEN.
> +	 *
> +	 * In case 1/ setting SETEN while the channel is still enabled
> +	 * is harmless for the controller.
> +	 *
> +	 * In case 2/ the channel is disabled when calling this function
> +	 * and setting CLRSUS is harmless for the controller as the
> +	 * channel is disabled anyway.
> +	 *
> +	 * In case 3/ the channel is disabled/enabled if the system
> +	 * went though a suspend with power loss/or not and setting
> +	 * CLRSUS/SETEN is harmless for the controller as the channel
> +	 * is enabled/disabled anyway.
> +	 */
> +
> +	rz_dmac_ch_writel(channel, CHCTRL_CLRSUS | CHCTRL_SETEN, CHCTRL, 1);
>=20
> -	rz_dmac_ch_writel(channel, CHCTRL_CLRSUS, CHCTRL, 1);
>  	ret =3D read_poll_timeout_atomic(rz_dmac_ch_readl, val,
> -				       !(val & CHSTAT_SUS), 1, 1024, false,
> -				       channel, CHSTAT, 1);
> +				       ((val & (CHSTAT_SUS | CHSTAT_EN)) =3D=3D CHSTAT_EN),
> +				       1, 1024, false, channel, CHSTAT, 1);
>=20
>  	channel->status &=3D ~clear_bitmask;
>=20
> @@ -994,6 +1037,16 @@ static int rz_dmac_device_resume(struct dma_chan *c=
han)
>  	return rz_dmac_device_resume_set(channel, BIT(RZ_DMAC_CHAN_STATUS_PAUSE=
D));  }
>=20
> +static int rz_dmac_device_resume_internal(struct rz_dmac_chan *channel)
> +{
> +	lockdep_assert_held(&channel->vc.lock);
> +
> +	if (!(channel->status & BIT(RZ_DMAC_CHAN_STATUS_PAUSED_INTERNAL)))
> +		return 0;
> +
> +	return rz_dmac_device_resume_set(channel,
> +BIT(RZ_DMAC_CHAN_STATUS_PAUSED_INTERNAL));
> +}
> +
>  /*
>   * ---------------------------------------------------------------------=
--------
>   * IRQ handling
> @@ -1354,6 +1407,130 @@ static void rz_dmac_remove(struct platform_device=
 *pdev)
>  	pm_runtime_disable(&pdev->dev);
>  }
>=20
> +static int rz_dmac_suspend_prepare(struct device *dev) {
> +	struct rz_dmac *dmac =3D dev_get_drvdata(dev);
> +
> +	for (unsigned int i =3D 0; i < dmac->n_channels; i++) {
> +		struct rz_dmac_chan *channel =3D &dmac->channels[i];
> +
> +		guard(spinlock_irqsave)(&channel->vc.lock);
> +
> +		/* Wait for transfer completion, except in cyclic case. */
> +		if (channel->status & BIT(RZ_DMAC_CHAN_STATUS_CYCLIC))
> +			continue;
> +
> +		if (rz_dmac_chan_is_enabled(channel))
> +			return -EAGAIN;
> +	}
> +
> +	return 0;
> +}
> +
> +static void rz_dmac_suspend_recover(struct rz_dmac *dmac) {
> +	for (unsigned int i =3D 0; i < dmac->n_channels; i++) {
> +		struct rz_dmac_chan *channel =3D &dmac->channels[i];
> +
> +		guard(spinlock_irqsave)(&channel->vc.lock);
> +
> +		if (!(channel->status & BIT(RZ_DMAC_CHAN_STATUS_CYCLIC)))
> +			continue;
> +
> +		rz_dmac_device_resume_internal(channel);
> +	}
> +}
> +
> +static int rz_dmac_suspend(struct device *dev) {
> +	struct rz_dmac *dmac =3D dev_get_drvdata(dev);
> +	int ret;
> +
> +	for (unsigned int i =3D 0; i < dmac->n_channels; i++) {
> +		struct rz_dmac_chan *channel =3D &dmac->channels[i];
> +
> +		guard(spinlock_irqsave)(&channel->vc.lock);
> +
> +		if (!(channel->status & BIT(RZ_DMAC_CHAN_STATUS_CYCLIC)))
> +			continue;
> +
> +		ret =3D rz_dmac_device_pause_internal(channel);
> +		if (ret) {
> +			dev_err(dev, "Failed to suspend channel %s\n",
> +				dma_chan_name(&channel->vc.chan));
> +			break;
> +		}
> +
> +		channel->pm_state.nxla =3D rz_dmac_ch_readl(channel, NXLA, 1);
> +	}
> +
> +	if (ret) {
> +		rz_dmac_suspend_recover(dmac);
> +		return ret;
> +	}
> +
> +	pm_runtime_put_sync(dmac->dev);
> +
> +	ret =3D reset_control_assert(dmac->rstc);
> +	if (ret) {
> +		pm_runtime_resume_and_get(dmac->dev);
> +		rz_dmac_suspend_recover(dmac);
> +	}
> +
> +	return ret;
> +}
> +
> +static int rz_dmac_resume(struct device *dev) {
> +	struct rz_dmac *dmac =3D dev_get_drvdata(dev);
> +	int errors =3D 0, ret;
> +
> +	ret =3D reset_control_deassert(dmac->rstc);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D pm_runtime_resume_and_get(dmac->dev);


If this fails for any reason, the next suspend still be called and it will =
decrement the counter, potentially undeflowing it.
Consider switching to pm_runtime_get_sync(), which suits better here.

Cheers,
Biju

