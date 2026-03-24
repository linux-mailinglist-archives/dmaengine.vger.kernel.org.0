Return-Path: <dmaengine+bounces-9628-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WFckIm3CwmmjlQQAu9opvQ
	(envelope-from <dmaengine+bounces-9628-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 24 Mar 2026 17:57:17 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E7CD319806
	for <lists+dmaengine@lfdr.de>; Tue, 24 Mar 2026 17:57:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6F37E3014603
	for <lists+dmaengine@lfdr.de>; Tue, 24 Mar 2026 16:49:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13E0A3FB7FC;
	Tue, 24 Mar 2026 16:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="bCQdAHHI"
X-Original-To: dmaengine@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011056.outbound.protection.outlook.com [40.107.74.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 383382F8BF0;
	Tue, 24 Mar 2026 16:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774370971; cv=fail; b=RGoO3pQVpLbeN9ymJvJyFn1ro1OsCvaMz2L+6OM+2NMyupYIs/mgm0rhUxOrg9pfd2weNynBGn6YbPxqEGlDuA9GXfNR2jfiVfMakmVBspK7E6DEw6P4f03vvuGXwedssppQmFb0n4cx8zuQW+O9Y0acZb9hxeHVbiY/AtpkIv4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774370971; c=relaxed/simple;
	bh=ippKUdmU6/7En1MJeer69sRDUK497YIckAgPj3n3NME=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RrEIwMEDCTVXlEMxW/ZzwNCW8kH/zFZ80UPheRTKpmWDnvGqBtxVToUrPJF4rnichvnRdBwXEaT5u0Ta2HFtbHYmtoCiYyaE5HPbYJlL58hwco3FJU50bIDb0zbSkLHD09wbU0RYRCVUvJMnOUwyc+j3MMrsYGPXvcRzcASUy2k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=bCQdAHHI; arc=fail smtp.client-ip=40.107.74.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pjbV+a1zKgBjIg88ouVMrAt3u5mFNdT01WKwuh+lk3kX6hugmgzljhvqvYEe2BIUwP9yJrl+b+A/06PTqeyG5t96K1DcW2VOmZ/P/ceBcrulvTBRiLq88Q1ILEM3geyvGlxT8teUjRqOWNI8ldS/ebKsVAI/eyKlqmxgAGeDvBWdEapMMFJqVnCSCAUsl4ow7c03FCFocRO2uWfBYNCZfe9gKZlZcUunvfBzf/TRU1pfhQ3NqMGMeRqnNsFC1YnbSl5syXSqt/bQMruUz6nhdEDiikTOEQkvwgkBlqbUvhFEN7aN37DdniHujh5AjY+t683N6RsyZAHQke2q6aJdzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0s+TD5Fz7UDY+sIzkqiK6DLwyVlOEgU1yhKisghlJT4=;
 b=k4TgP4eAs947LkJewebH6i56Wx5spD0bF+bAlpGM5igzJk0fQ0q/ZcfLQ92FPnhvYNoFbdokwAMQoQm/184FwzDgbQVZgaEED7VyRUIDMFczy3ms1mYLA93AHsaaAv9xKDt/A2qnpeP5SrMCz0Z5655rlubum3ooCnZjjWN3YkMGR5TCPHi0CfJOq9dCX3c9XebgtT75gdfE7k6HB87RoR8SkkujJgG1vaiCdBRII3YJQKqgiJ9PbSgUIADF+5cR4ol5XcnKGT0q0RRIxMb5+TSjQKgXd2HX5nmXOOetvEfo+gvxbctl+COdvE43oXjYjZ0QHbkTGoAX3zp4zS/dtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0s+TD5Fz7UDY+sIzkqiK6DLwyVlOEgU1yhKisghlJT4=;
 b=bCQdAHHIrmbwgzXiD0+g8BxpAhYZuG0LM8ZuPeIvSTmiEZ6W5o1LNelVnOEU9IUj64vBaltYkyrAcxGj9PRbSJnrTl+Lynu/cFHXCXeuwo8HgpV4TZ82CaBqoZBopoDEVP4Phtjpo8E0uwfEDIGNvK/DAq2r4C5ssxqroUq2+VA=
Received: from TY6PR01MB17377.jpnprd01.prod.outlook.com (2603:1096:405:35b::6)
 by OS7PR01MB11925.jpnprd01.prod.outlook.com (2603:1096:604:239::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.31; Tue, 24 Mar
 2026 16:49:23 +0000
Received: from TY6PR01MB17377.jpnprd01.prod.outlook.com
 ([fe80::f373:26d6:86c4:6aa3]) by TY6PR01MB17377.jpnprd01.prod.outlook.com
 ([fe80::f373:26d6:86c4:6aa3%4]) with mapi id 15.20.9723.030; Tue, 24 Mar 2026
 16:49:23 +0000
From: John Madieu <john.madieu.xa@bp.renesas.com>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
CC: Geert Uytterhoeven <geert+renesas@glider.be>, Vinod Koul
	<vkoul@kernel.org>, Mark Brown <broonie@kernel.org>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Michael
 Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Frank Li <Frank.Li@kernel.org>, Liam Girdwood
	<lgirdwood@gmail.com>, magnus.damm <magnus.damm@gmail.com>, Thomas Gleixner
	<tglx@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai
	<tiwai@suse.com>, Philipp Zabel <p.zabel@pengutronix.de>, Claudiu.Beznea
	<claudiu.beznea@tuxon.dev>, Biju Das <biju.das.jz@bp.renesas.com>, Fabrizio
 Castro <fabrizio.castro.jz@renesas.com>, Prabhakar Mahadev Lad
	<prabhakar.mahadev-lad.rj@bp.renesas.com>, John Madieu
	<john.madieu@gmail.com>, "linux-renesas-soc@vger.kernel.org"
	<linux-renesas-soc@vger.kernel.org>, "linux-clk@vger.kernel.org"
	<linux-clk@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "dmaengine@vger.kernel.org"
	<dmaengine@vger.kernel.org>, "linux-sound@vger.kernel.org"
	<linux-sound@vger.kernel.org>
Subject: RE: [PATCH 10/22] ASoC: rsnd: Add DMA support infrastructure for
 RZ/G3E
Thread-Topic: [PATCH 10/22] ASoC: rsnd: Add DMA support infrastructure for
 RZ/G3E
Thread-Index: AQHct7jpskYDXbJ5n0WlxNLGupdi77W7U4UAgAJ6RCA=
Date: Tue, 24 Mar 2026 16:49:22 +0000
Message-ID:
 <TY6PR01MB173777CB90871A8837834EC94FF48A@TY6PR01MB17377.jpnprd01.prod.outlook.com>
References: <20260319155334.51278-1-john.madieu.xa@bp.renesas.com>
	<20260319155334.51278-11-john.madieu.xa@bp.renesas.com>
 <87jyv39wuj.wl-kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87jyv39wuj.wl-kuninori.morimoto.gx@renesas.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY6PR01MB17377:EE_|OS7PR01MB11925:EE_
x-ms-office365-filtering-correlation-id: ee80ec09-3c6b-4448-daa5-08de89c54d37
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700021|22082099003|56012099003|18002099003;
x-microsoft-antispam-message-info:
 JO2sl/yohJeUjLnFQUeQjMl8qELvMf8UQDLJXZkw//tHqG9pFa11npZiqfLsqgJ7Gl5mr+ju5AeCB+/gCIBtXS7Yhvc3lXlPRoPiW11eX2TtoBqRlBFKsWTWn+Ur4oixAHLu/IijpSz1QGG8FwsZ6qUcYOBto7NsljzuneVDLXVakMsY4/Q3m+JP3pHG21HOSH5gpZ1l3a0yzFnRI6HsrHp2SGAxymTQtJC3VZwkTEp3GLl66DXigJeZAWTqMgeY/3+Mqzm+TMIULQ1NxvUIoLEDV7Zraa3DAt1skRb30vW5zJBHjzU9OhIVPMsMARIKLW73pz+7qzq65rAHRwQ9kIJu+UVmnVtYz4kWuvvLcLuij4lM9U/vy6j65sAq0eeTvJxbslUBwOOGg2TO/AugqB6s6+9a1ZaDN7tOpdcT7sVmmeMQOxwPakuIBKb6RT+knmKVf1W3bk4rIIpV7mhG+UE7roirz++zae0Sfjuxmjv2AFGpoSAbr+KXH4QW4nFdKtmVj4/ncuxavgHFatdiV6f+e4Se3/8LsIymkBg7joXynKilwQ7QOP/naQy8xnmMkHSHT5T5y6MrzXRzjuCiQ6r/a0OHgqX/lSxoAmTpTNCZuiDZOKu/nQdLFO38bllbmEdv6k2BFiS+j5BV+mt7g97AgAnR9FhgDdJa5QT9/WFaLlkDUoG0Raai9OkYHRIEA3JJsDVMf72Pt2QMBxn9W/BGDCd/T861LFy2ncL3T5Nel1O8Anfruu9vqeNmfDF0pfRekT4lHgrEN/Git0X4dFjrcGqQxo/cTFRrcF/QgpY=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY6PR01MB17377.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700021)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?PVrC1V8fVbfN7we0a/Zh+Z81+VmLhLJU3Ga232RQCXBWqyqoflfqYsxJWD+O?=
 =?us-ascii?Q?H/KyIlM0FGYri/nL3KoT2yKLgBssrgNpnTvNKXvOl60MYB3Mb8EQQlxm5woF?=
 =?us-ascii?Q?RApXatMqVckeQhnJv+PnVfzzArCimV0B8VfQhferRtESmTRaVhSknCx4Ra4O?=
 =?us-ascii?Q?4WPx02gGPCEvAOKkcbV9wXAka1A3kLY5mbjPeynHjf5jY4n8k6yLNAII/g8Y?=
 =?us-ascii?Q?OQYiGvvgze21KSczvZvth8z45mX47hBA0AD4ROCnFhHnRCbwBBW8rPA1XoU6?=
 =?us-ascii?Q?6026mzxZuL8aj/MItsmPbYSOo/BBJvGe/dGEFT/d7VdthJhFsPn27C3XqeYF?=
 =?us-ascii?Q?DOadiK3lyLSTPvOg/GAV7tKwWNiRu2eyoLsMIv+FeN047INFXW9i5fMb1b8L?=
 =?us-ascii?Q?8gjMQvRBxESkazQ1lLoh7khTNB/5ykJDmq/XRIgIGpKsFCZ3U8VLQH2Z1q5D?=
 =?us-ascii?Q?O1suyHL9bvaK7pNElOp7tgyIntp+yAP1OGrIkBFCPK3pex4QQ702DsE3vn+p?=
 =?us-ascii?Q?8d+9ZRNGWSRN1PWCpsAAjWSiqhVAwZC1vgSPSSIIHkTJo5UKAodGdog5+NCp?=
 =?us-ascii?Q?6aJSXRE+PSCfYf4b93wHh+Jz7X+fGZG3NLomvzLnSchWtLP7ZYwWf0OrGGD8?=
 =?us-ascii?Q?wdZW1zP03ex6gFlTSpS+YDnq1dDnO87CZ0KcF0duQuVwSBj1abGJkAFrFhwZ?=
 =?us-ascii?Q?i7N+e63ycWi9P7ZB9vcoitTnFmlbmtxolfpkHKr0Hk+g0flHW29PCiYWasu8?=
 =?us-ascii?Q?ROV8tQy02EG+cfuqk2EPJFJ0XXgiNd7U20opQe+ASL0zDFoomkzntRYYnCvs?=
 =?us-ascii?Q?0t0gsZ6BlnQPbmikEma/pX7frf/+Lq1PWTxN4FYkr6xrqmaDVDBGaJMUMd60?=
 =?us-ascii?Q?DwOO/WL+l4aiypiwYQlAtCIpQ8igQAq3r7Qd6XU+mO/HkAfPOzqAwH3vHe6g?=
 =?us-ascii?Q?2BwX916K4iTR8t61dgXcIxZDR6hG38QPmviv1yVpOZ34JeacmJ9qpoNLzbps?=
 =?us-ascii?Q?OimCFK4arz/SXXYhPfZq0JzMUJflpjvSMRuwEUUAfTnPXrzM/q5BuUeJJM17?=
 =?us-ascii?Q?CthoB5dW2GJlVMsScsg82l2GFJnG/bfQw2ch7pmWNKQgunzwSizgyRMWKLUG?=
 =?us-ascii?Q?fGQav74sIVL78//VPCmjPVm5dgThy8rww0+gb9sEavoHhPasx3cJKznP5gKm?=
 =?us-ascii?Q?Az/TacS4kt7Np17XeU43QY50pOxDU9ijMon8HhssVz/MfcW7JDwlHrmesk/y?=
 =?us-ascii?Q?72NE/ocIiT3HzIuiDul/vO9oG0bkfyA+FcS5EM6yIX3spjMOjnUlIHabdigK?=
 =?us-ascii?Q?N0spHI9/npyckvSs/hCvtjY27ZSSKBAlXcVoq6X9XgA/etXpi66mJzD1csg6?=
 =?us-ascii?Q?zvlticmJR+q2s4QlDmuZ14n7OrajWo5Zh1j0UsmbdfHdkPQ+rSj4/W/0uAr0?=
 =?us-ascii?Q?kv+jpKXifDbL8o+tioPeAwzn7Vd1V+IfWaxLrogMiL01izsSkrBXcOcSrwLO?=
 =?us-ascii?Q?AtAw7EOYhWZnbJhH0hoSU0xVngx14zxnDj9fcI0dqxemkFmoa8tyDVCFBrXB?=
 =?us-ascii?Q?K2i9rn7SO+ELPLH1ZuoIGuk6xyOBHPrZcQFR8D7pYn4dGIEx05kNyb2VyTse?=
 =?us-ascii?Q?/AB5laJfyl3ybYOvdkFHAlH82a+UuKySN5SnfIr75byZ8eFK/8+7H0Fyfn2X?=
 =?us-ascii?Q?5T+DxV9TPJXpXuaBFmV03Psz3rjcBBt6go0Lf9dywzNukhiW/WgOPY8FntRf?=
 =?us-ascii?Q?m4hVCOeDeMc9eABU0pnglDTvP8fr8DE=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: TY6PR01MB17377.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee80ec09-3c6b-4448-daa5-08de89c54d37
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2026 16:49:23.0065
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MhA9GQaJzBOSqHX79XG/qwN/S65cIwFrsFWqzsVbBgeF0POtHuKf0XpYXUoVmlssKVlCeUjIETQWTsppo2nXwVR8aC2bxXrlgTlW234OzF4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7PR01MB11925
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[renesas.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[bp.renesas.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[27];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9628-lists,dmaengine=lfdr.de];
	FREEMAIL_CC(0.00)[glider.be,kernel.org,baylibre.com,gmail.com,perex.cz,suse.com,pengutronix.de,tuxon.dev,bp.renesas.com,renesas.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[john.madieu.xa@bp.renesas.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[bp.renesas.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[dmaengine,renesas,dt];
	NEURAL_HAM(-0.00)[-1.000];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bp.renesas.com:dkim,renesas.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1E7CD319806
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Kuninori,

Thanks for the review.

> -----Original Message-----
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> Sent: Monday, March 23, 2026 2:08 AM
> To: John Madieu <john.madieu.xa@bp.renesas.com>
> Subject: Re: [PATCH 10/22] ASoC: rsnd: Add DMA support infrastructure for
> RZ/G3E
>=20
>=20
> Hi John
>=20
> Thank you for your patch
>=20
> > RZ/G3E has different DMA register base addresses and offset
> > calculations compared to R-Car platforms, and requires additional
> > audmac-pp clock and reset lines for Audio DMAC operation.
> >
> > Add RZ/G3E-specific DMA address macros and audmac-pp clock/reset
> > support using optional APIs to remain transparent to other platforms.
> >
> > Signed-off-by: John Madieu <john.madieu.xa@bp.renesas.com>
> > ---
>=20
> I think it include many features in 1 patch.
> You should separate it into each features.

Agreed, I'll split this into separate patches. One for
RZ/G3E DMA address support and one for audmac-pp clock/reset
management. What do you think of this approach ?

>=20
> > diff --git a/sound/soc/renesas/rcar/dma.c
> > b/sound/soc/renesas/rcar/dma.c index 68c859897e68..d3123ae3b402 100644
> > --- a/sound/soc/renesas/rcar/dma.c
> > +++ b/sound/soc/renesas/rcar/dma.c
> > @@ -496,24 +496,71 @@ static struct rsnd_mod_ops rsnd_dmapp_ops =3D {
> >   *	SSIU: 0xec541000 / 0xec100000 / 0xec100000 / 0xec400000 / 0xec40000=
0
> >   *	SCU : 0xec500000 / 0xec000000 / 0xec004000 / 0xec300000 / 0xec30400=
0
> >   *	CMD : 0xec500000 /            / 0xec008000                0xec30800=
0
> > + *
> > + * 	ex) G3E case
> > + *	      mod        / DMAC in    / DMAC out   / DMAC PP in / DMAC pp
> out
> > + *	SSI : 0x13C31000 / 0x13C40000 / 0x13C40000
> > + *	SSIU: 0x13C31000 / 0x13C40000 / 0x13C40000 / 0xEC400000 / 0xEC40000=
0
> > + *	SCU : 0x13C00000 / 0x13C10000 / 0x13C14000 / 0xEC300000 / 0xEC30400=
0
> > + *	CMD : 0x13C00000 /            / 0x13C18000                0xEC30800=
0
> >   */
> > -#define RDMA_SSI_I_N(addr, i)	(addr ##_reg - 0x00300000 + (0x40 * i)
> + 0x8)
> > -#define RDMA_SSI_O_N(addr, i)	(addr ##_reg - 0x00300000 + (0x40 * i)
> + 0xc)
> >
> > -#define RDMA_SSIU_I_N(addr, i, j) (addr ##_reg - 0x00441000 + (0x1000
> > * (i)) + (((j) / 4) * 0xA000) + (((j) % 4) * 0x400) - (0x4000 * ((i) /
> > 9) * ((j) / 4))) -#define RDMA_SSIU_O_N(addr, i, j)
> > RDMA_SSIU_I_N(addr, i, j)
> > +/* RZ/G3E DMA address macros */
> > +#define RDMA_SSI_I_N_G3E(addr, i)	(addr ##_reg + 0x0000F000 +
> (0x1000 * i))
> > +#define RDMA_SSI_O_N_G3E(addr, i)	(addr ##_reg + 0x0000F000 +
> (0x1000 * i))
> > +
> > +#define RDMA_SSIU_I_N_G3E(addr, i, j) (addr ##_reg + 0x0000F000 +
> > +(0x1000 * (i)) + (((j) / 4) * 0xA000) + (((j) % 4) * 0x400) - (0x4000
> > +* ((i) / 9) * ((j) / 4))) #define RDMA_SSIU_O_N_G3E(addr, i, j)
> > +RDMA_SSIU_I_N_G3E(addr, i, j)
> > +
> > +#define RDMA_SSIU_I_P_G3E(addr, i, j) (addr ##_reg + 0xD87CF000 +
> > +(0x1000 * (i)) + (((j) / 4) * 0xA000) + (((j) % 4) * 0x400) - (0x4000
> > +* ((i) / 9) * ((j) / 4))) #define RDMA_SSIU_O_P_G3E(addr, i, j)
> > +RDMA_SSIU_I_P_G3E(addr, i, j)
> > +
> > +#define RDMA_SRC_I_N_G3E(addr, i)	(addr ##_reg + 0x00010000 +
> (0x400 * i))
> > +#define RDMA_SRC_O_N_G3E(addr, i)	(addr ##_reg + 0x00014000 +
> (0x400 * i))
> > +
> > +#define RDMA_SRC_I_P_G3E(addr, i)	(addr ##_reg + 0xD8700000 +
> (0x400 * i))
> > +#define RDMA_SRC_O_P_G3E(addr, i)	(addr ##_reg + 0xD8704000 +
> (0x400 * i))
> > +
> > +#define RDMA_CMD_O_N_G3E(addr, i)	(addr ##_reg + 0x00018000 +
> (0x400 * i))
> > +#define RDMA_CMD_O_P_G3E(addr, i)	(addr ##_reg + 0xD8708000 +
> (0x400 * i))
> > +
> > +/* R-Car DMA address macros */
> > +#define RDMA_SSI_I_N_RCAR(addr, i)	(addr ##_reg - 0x00300000 +
> (0x40 * i) + 0x8)
> > +#define RDMA_SSI_O_N_RCAR(addr, i)	(addr ##_reg - 0x00300000 +
> (0x40 * i) + 0xc)
> >
> > -#define RDMA_SSIU_I_P(addr, i, j) (addr ##_reg - 0x00141000 + (0x1000
> > * (i)) + (((j) / 4) * 0xA000) + (((j) % 4) * 0x400) - (0x4000 * ((i) /
> > 9) * ((j) / 4))) -#define RDMA_SSIU_O_P(addr, i, j)
> > RDMA_SSIU_I_P(addr, i, j)
> > +#define RDMA_SSIU_I_N_RCAR(addr, i, j) (addr ##_reg - 0x00441000 +
> > +(0x1000 * (i)) + (((j) / 4) * 0xA000) + (((j) % 4) * 0x400) - (0x4000
> > +* ((i) / 9) * ((j) / 4))) #define RDMA_SSIU_O_N_RCAR(addr, i, j)
> > +RDMA_SSIU_I_N_RCAR(addr, i, j)
> >
> > -#define RDMA_SRC_I_N(addr, i)	(addr ##_reg - 0x00500000 + (0x400 *
> i))
> > -#define RDMA_SRC_O_N(addr, i)	(addr ##_reg - 0x004fc000 + (0x400 *
> i))
> > +#define RDMA_SSIU_I_P_RCAR(addr, i, j) (addr ##_reg - 0x00141000 +
> > +(0x1000 * (i)) + (((j) / 4) * 0xA000) + (((j) % 4) * 0x400) - (0x4000
> > +* ((i) / 9) * ((j) / 4))) #define RDMA_SSIU_O_P_RCAR(addr, i, j)
> > +RDMA_SSIU_I_N_RCAR(addr, i, j)
> >
> > -#define RDMA_SRC_I_P(addr, i)	(addr ##_reg - 0x00200000 + (0x400 *
> i))
> > -#define RDMA_SRC_O_P(addr, i)	(addr ##_reg - 0x001fc000 + (0x400 *
> i))
> > +#define RDMA_SRC_I_N_RCAR(addr, i)	(addr ##_reg - 0x00500000 +
> (0x400 * i))
> > +#define RDMA_SRC_O_N_RCAR(addr, i)	(addr ##_reg - 0x004fc000 +
> (0x400 * i))
> >
> > -#define RDMA_CMD_O_N(addr, i)	(addr ##_reg - 0x004f8000 + (0x400 *
> i))
> > -#define RDMA_CMD_O_P(addr, i)	(addr ##_reg - 0x001f8000 + (0x400 *
> i))
> > +#define RDMA_SRC_I_P_RCAR(addr, i)	(addr ##_reg - 0x00200000 +
> (0x400 * i))
> > +#define RDMA_SRC_O_P_RCAR(addr, i)	(addr ##_reg - 0x001fc000 +
> (0x400 * i))
> > +
> > +#define RDMA_CMD_O_N_RCAR(addr, i)	(addr ##_reg - 0x004f8000 +
> (0x400 * i))
> > +#define RDMA_CMD_O_P_RCAR(addr, i)	(addr ##_reg - 0x001f8000 +
> (0x400 * i))
> > +
> > +/* Platform-agnostic address macros */
> > +#define RDMA_SSI_I_N(p, addr, i)	rsnd_is_rzg3e(p) ?
> RDMA_SSI_I_N_G3E(addr, i) : RDMA_SSI_I_N_RCAR(addr, i)
> > +#define RDMA_SSI_O_N(p, addr, i)	rsnd_is_rzg3e(p) ?
> RDMA_SSI_O_N_G3E(addr, i) : RDMA_SSI_O_N_RCAR(addr, i)
> > +
> > +#define RDMA_SSIU_I_N(p, addr, i, j) rsnd_is_rzg3e(p) ?
> > +RDMA_SSIU_I_N_G3E(addr, i, j) : RDMA_SSIU_I_N_RCAR(addr, i, j)
> > +#define RDMA_SSIU_O_N(p, addr, i, j) rsnd_is_rzg3e(p) ?
> > +RDMA_SSIU_O_N_G3E(addr, i, j) : RDMA_SSIU_O_N_RCAR(addr, i, j)
> > +
> > +#define RDMA_SSIU_I_P(p, addr, i, j) rsnd_is_rzg3e(p) ?
> > +RDMA_SSIU_I_P_G3E(addr, i, j) : RDMA_SSIU_I_P_RCAR(addr, i, j)
> > +#define RDMA_SSIU_O_P(p, addr, i, j) rsnd_is_rzg3e(p) ?
> > +RDMA_SSIU_O_P_G3E(addr, i, j) : RDMA_SSIU_O_P_RCAR(addr, i, j)
> > +
> > +#define RDMA_SRC_I_N(p, addr, i)	rsnd_is_rzg3e(p) ?
> RDMA_SRC_I_N_G3E(addr, i) : RDMA_SRC_I_N_RCAR(addr, i)
> > +#define RDMA_SRC_O_N(p, addr, i)	rsnd_is_rzg3e(p) ?
> RDMA_SRC_O_N_G3E(addr, i) : RDMA_SRC_O_N_RCAR(addr, i)
> > +
> > +#define RDMA_SRC_I_P(p, addr, i)	rsnd_is_rzg3e(p) ?
> RDMA_SRC_I_P_G3E(addr, i) : RDMA_SRC_I_P_RCAR(addr, i)
> > +#define RDMA_SRC_O_P(p, addr, i)	rsnd_is_rzg3e(p) ?
> RDMA_SRC_O_P_G3E(addr, i) : RDMA_SRC_O_P_RCAR(addr, i)
> > +
> > +#define RDMA_CMD_O_N(p, addr, i)	rsnd_is_rzg3e(p) ?
> RDMA_CMD_O_N_G3E(addr, i) : RDMA_CMD_O_N_RCAR(addr, i)
> > +#define RDMA_CMD_O_P(p, addr, i)	rsnd_is_rzg3e(p) ?
> RDMA_CMD_O_P_G3E(addr, i) : RDMA_CMD_O_P_RCAR(addr, i)
>=20
> I think you want to create new rsnd_rzg3e_dma_addr() and call it, instead
> of makes existing code complex.

Makes sense. I'll drop the macro-based approach and create a
dedicated rsnd_rzg3e_dma_addr() function following the same
pattern as rsnd_gen4_dma_addr()/rsnd_gen2_dma_addr(), with
dispatch in rsnd_dma_addr().

>=20
> + static dma_addr_t rsnd_rzg3e_dma_addr(...)  {
> +	...
> + }
> ...
>   static dma_addr_t rsnd_dma_addr(...)
>   {
> 	...
> 	else if (rsnd_is_gen4(priv))
> 		return rsnd_gen4_dma_addr(...);
> +	else if (rsnd_is_rzg3e(priv))
> +		return rsnd_rzg3e_dma_addr(...)
> 	else
> 		return rsnd_gen2_dma_addr(...);
> }
>=20
> > @@ -860,6 +917,56 @@ int rsnd_dma_probe(struct rsnd_priv *priv)
> >  		return 0; /* it will be PIO mode */
> >  	}
> >
> > +	/*
> > +	 * audmac_pp clock/reset management strategy:
> > +	 *
> > +	 * Unlike other modules (SSI, SRC, etc.) which have their own
> dedicated
> > +	 * clocks, all DMA modules share the single audmac_pp clock/reset.
> > +	 * Managing it per-stream or per-DMA-module causes
> > +	 * reference count imbalances:
> > +	 *
> > +	 *   - rsnd_mod_init() does clk_prepare_enable() then clk_disable(),
> > +	 *     leaving prepare_count=3D1 per module
> > +	 *   - With N DMA modules sharing the same clock handle,
> prepare_count=3DN
> > +	 *   - suspend does single clk_disable_unprepare() (-1)
> > +	 *   - resume does single clk_prepare_enable() (+1)
> > +	 *   - Result: prepare_count leaks on each suspend/resume cycle
> > +	 *
> > +	 * Per-stream management (iterating DMA modules in suspend/resume)
> is
> > +	 * not worth the complexity:
> > +	 *
> > +	 *   - No power benefit: audmac_pp is needed whenever ANY stream is
> > +	 *     active, and every stream uses DMA, so it's essentially always
> on
> > +	 *   - Architecture mismatch: DMA modules live in io->dma, not in a
> > +	 *     priv array -- no clean way to iterate like SSI/SRC/DVC
> > +	 *   - Shared handle problem: all DMA modules point to the same
> clock,
> > +	 *     so iterating would call clk_unprepare() N times on one clock
> > +	 *   - Would require manual refcounting ("enable on first stream,
> > +	 *     disable on last") -- reimplementing what clk framework does
> > +	 *
> > +	 * The correct approach is to treat audmac_pp as always-on
> infrastructure
> > +	 * (same pattern as clk_adg), managed globally:
> > +	 *   - Probe: acquire + enable (via devm_clk_get_optional_enabled)
> > +	 *   - Suspend/Resume: toggle in core.c rsnd_suspend/rsnd_resume
> > +	 *   - Remove: devm cleanup
> > +	 *   - DMA modules: pass NULL clock/reset to rsnd_mod_init()
> > +	 *
> > +	 * Use devm variants that handle deassert/enable automatically.
> > +	 * Order: reset deasserted first, then clock enabled.
> > +	 */
> > +	priv->rstc_audmac_pp =3D
> > +		devm_reset_control_get_optional_exclusive_deasserted(dev,
> "audmac_pp");
> > +	if (IS_ERR(priv->rstc_audmac_pp)) {
> > +		return dev_err_probe(dev, PTR_ERR(priv->rstc_audmac_pp),
> > +				     "failed to get audmac_pp reset\n");
> > +	}
> > +
> > +	priv->clk_audmac_pp =3D devm_clk_get_optional_enabled(dev,
> "audmac_pp");
> > +	if (IS_ERR(priv->clk_audmac_pp)) {
> > +		return dev_err_probe(dev, PTR_ERR(priv->clk_audmac_pp),
> > +				     "failed to get audmac_pp clock\n");
> > +	}
>=20
> rsnd_dma_probe() is common fucntion.
> Is above possible to keep compatible with other SoCs ?

Other SoCs do not need or specify these clock/reset in DTS and
the fact I use optional APIs makes it compatible with these other
SoCs. I'm wondering if you meant something else here?


>=20
> And, we are already using "audmacpp".

What do you mean by the above ?

> I think it time to update rsnd_dma_probe() like below ?
>=20
> 	int rsnd_dma_probe(...)
> 	{
> 		if (rsnd_is_gen1(..))
> 			return ...
> 		else if (rsnd_is_gen2(...) ||
> 			 rsnd_is_gen3(...))
> 			return ...
> 		else if (rsnd_is_gen4(...))
> 			return ...
> 		else if (rsnd_is_rzg3e(...))
> 			return ...
> 		...
> 	}

Regarding rsnd_dma_probe(), I intentionally used
devm_clk_get_optional_enabled() and
devm_reset_control_get_optional_exclusive_deasserted() - these
return NULL when the clock/reset is not present in the device tree,
so they are fully transparent to existing SoCs (R-Car Gen2/3/4).

Adding per-SoC branches in rsnd_dma_probe() would duplicate the
common DMAC setup logic. I believe keeping this in the common
path is the cleaner approach, but I'm happy to discuss if you
see a specific concern beyond compatibility.

Regards,
John

