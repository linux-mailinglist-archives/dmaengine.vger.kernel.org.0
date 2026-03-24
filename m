Return-Path: <dmaengine+bounces-9632-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GGmWH9PYwmllmgQAu9opvQ
	(envelope-from <dmaengine+bounces-9632-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 24 Mar 2026 19:32:51 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 26B3731AE84
	for <lists+dmaengine@lfdr.de>; Tue, 24 Mar 2026 19:32:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 948CB308FE63
	for <lists+dmaengine@lfdr.de>; Tue, 24 Mar 2026 18:28:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC0BD3A2566;
	Tue, 24 Mar 2026 18:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="EgZ5r8CR"
X-Original-To: dmaengine@vger.kernel.org
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11010043.outbound.protection.outlook.com [52.101.228.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B29E637A48B;
	Tue, 24 Mar 2026 18:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774376889; cv=fail; b=qivWMWGF1po1ZEHWabCVc2xI1GMzr5K1NiF8XVXJlIPkBCtG3IBZAwOeb/QqPWacXO+KyPkYZZGmSvRleDx8FQZGVpMHpmDkObS9dcw1ENYuPFB3uRYlrsznd7u2oEWk7BHxLkxRmN9cdlsPP69Lsebhc+QKHpatbYr4QPSFPv8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774376889; c=relaxed/simple;
	bh=sKFAevYfPUBpysvIQKcIGnqa0wHAcn2GUZI0p1Vg8cM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LrDNxSpybObR27jECPYZYFhpjl1OdeWpobeuO+0SuegPEX/M94X7L4XveB/e3SCxnFzDN2bzEC26QXjANYvkLBowey7/SCO8+L8qroit6/MfXnDnLWyVJ1ZEHgR60Zn0/ilf0v7bMT5ltVOzzfmPMsRkNFKIhVeBkP3qt3v5PRg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=EgZ5r8CR; arc=fail smtp.client-ip=52.101.228.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hS9WBYpI1/H3W0Dk/jQ69jQR+xh/tA5rwBxV0uqDafCerHEkcnqcQ8U3zIn5fMaxNNoTHHlwfdrOLNovP1Sw1gUIPefjmM/P90hp7uwn3Bdn7jthclYo094czwzi2jDZuCjXNzg0aXHJIGS3oO5NAHXC5GdjmqcSs+GP7gtIhu123yhtecxL4o4TjqiMaGccid1ar1bnspBWVf2MQjYHFHeD7jBclUoSmj+bL5kHA9Eq/+Y7DrXmqUcEeXLOfdP/GJhyeTWqzk5nOvuI0HNaDNpq8gtig/OqDl9znYSRvDzOltYuIeEYO+Ifmb2jSupmDa3r3YLLXCl0R2Fejs3IbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VWU0vm3y4Ag6SIIFJCZh/w1wFO3ciylAYRDROWgXktI=;
 b=h21Kmi4kFwSC8p2mhlqdbrOt3tLXmkKjyHA/oyVLb1ymBEn2yiUax1r2InQ5yQQ58gX30vRZsrl76J8Y+qLPQW4rmudKqXq+hGYSWLvcG2Vv0BLv9uomMojMaVVL7Fh7ZtmzNM+XNOivvXM356gkKj7dbf6AZwGcmHCsnQpraoJcjkqpMNqaJYsmeyO7AKY0vLviNfVlWzujUfxQCa0DBEC4V7TycRtsA5Fo4KLDXSB9Vfz/j9+7QuGZvoYJvox93w3wpYgP/b48K1dyqoE0FPhlWGfoXv+iCoPwkqhyqHZmMzXJ5k8bG91vs4gPK/civSRfpzaGUOEabCReQP4/yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VWU0vm3y4Ag6SIIFJCZh/w1wFO3ciylAYRDROWgXktI=;
 b=EgZ5r8CRDB02zZWtQ9l2zEcdUdBGTqO7PJWhiS+aNxAncNCqKuNzQwztIEKwxyNlpW+b0Iw2aZ9QWgD5+dMvmYwfjM4KEkPZgbStagTiPsmlmBGVGv6kCjcMbvgjpUwQBirxl9SAmQTlDJc3B7kCn4lsa8PGNvphSmQeTtAq62Y=
Received: from TY6PR01MB17377.jpnprd01.prod.outlook.com (2603:1096:405:35b::6)
 by OSZPR01MB9280.jpnprd01.prod.outlook.com (2603:1096:604:1d0::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Tue, 24 Mar
 2026 18:28:04 +0000
Received: from TY6PR01MB17377.jpnprd01.prod.outlook.com
 ([fe80::f373:26d6:86c4:6aa3]) by TY6PR01MB17377.jpnprd01.prod.outlook.com
 ([fe80::f373:26d6:86c4:6aa3%4]) with mapi id 15.20.9723.030; Tue, 24 Mar 2026
 18:28:03 +0000
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
Subject: RE: [PATCH 16/22] ASoC: rsnd: Export module getters for PM support
Thread-Topic: [PATCH 16/22] ASoC: rsnd: Export module getters for PM support
Thread-Index: AQHct7kKd3cY0XMcB0GuCOPoCUsMEbW7Xe2AgAKqHxA=
Date: Tue, 24 Mar 2026 18:28:03 +0000
Message-ID:
 <TY6PR01MB17377D272D1658B6010DFA518FF48A@TY6PR01MB17377.jpnprd01.prod.outlook.com>
References: <20260319155334.51278-1-john.madieu.xa@bp.renesas.com>
	<20260319155334.51278-17-john.madieu.xa@bp.renesas.com>
 <87a4vz9v4g.wl-kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87a4vz9v4g.wl-kuninori.morimoto.gx@renesas.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY6PR01MB17377:EE_|OSZPR01MB9280:EE_
x-ms-office365-filtering-correlation-id: 6aa1988a-31c0-4620-37c3-08de89d31648
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|376014|1800799024|38070700021|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info:
 OuKbf3wd0JdEK+fJS3QPXHyUVwNE+PomW0nOvqGAqxM/HK9OKx0Nm4hGEvaou2Q4yg7AAwfYwDNKq90VjCXd7qYYBaxfIugkoKkznAffGumFbLMES5J33Y4TzrjzA2/wRe0PP9fgBu3bI5tWCEy/JQUF/hEdheg01Mm/Or2O8LwobReZFO9Hn2cOO28kA/gHEAicWlAjciGANfNEdLifD5udoVEwsoCTCEgGv2TRtALUQwtRIlWgWCemB8Z7ZPdI7nBqaoKLq4GSY7wlQgfd2xMyS9rK8SC9d7Cq44GosupylB1V1yQs4iW/USvQE/BZgEt+EH1DEuEXouM1LZ3WK1pdXP7GKAtOVZcz0kJlNFAh/GNoVDIZ1yF/npFnhm1yBGFWegHfarsbgYWJjvVeLfbNfwtbtSY800Q50PqifFcIBe2ALvivXBsLjSUo12FzA1D4ZaGCoRSFYlxtY+8HemrJGF2bafXCyevozfppk3WnBpHvc0gqjsCfywHKXf/Bct7E2agoTbXTS7ZXZ87Gb3XpUuCwksSMTopIqGAbQY2cj+jrjofMeFZCcEnQ+KdLc1CVCO8CP7W+TFGgewTiqat1LgQ74405pDS/xjrMbNb8fk9LPjOGW424MpXXEgwDbf/jX927g33HDxdwgCOENZwSVWyUsSw8i90CvhulvLorjpIZS4TcRIqmnmH4K+7PocBXU3Gn3Y4bceJsSL6B2BgNgNNWTvOZThvCRizqf5XhpHsAa30IKeIzO8Z3tueOuiZXwkpvX1vW5XhGyH2tBwOpdEESAwL/J0UUdAA4ZkY=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY6PR01MB17377.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700021)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?g7zE3Nkz+85GH159xU0XzPcl7MDo2Y9ris3F4YqlUw3ZW0IJbEfYpENBBcnW?=
 =?us-ascii?Q?GjvqHXvEiMlf9JIWMilubaZ9EpUAp8Fx5u1vaFJowP5LWHvXZzT6uF0YnYNu?=
 =?us-ascii?Q?sVpW5StFjtMKPCshuoE4RS1PUlcFirg9d6sD30l1UNqNdbTxcyOvvbGeihcd?=
 =?us-ascii?Q?yUgM19Tb9z8kQFumQ8bIqpzTVlD4ch0CGRm/8nTr6zD9sxVI20AdY4APDooI?=
 =?us-ascii?Q?J9hAVr6YG/w9m7TckdBrgBbKhGiNyQZMqePUQ4BB+AInkQG0DNA3G/iGqR2B?=
 =?us-ascii?Q?uBYsmvVSZrGDOl9wNMe/f0m3Wjouj7a+MmX6krJHgAypVbuM3NG7J3v3jOV1?=
 =?us-ascii?Q?VCVgFjFUO/LBicIfkb2k61EEcaMAItqVK76h4ix3pwvD8qRKY+vS/qG38ToP?=
 =?us-ascii?Q?q435cJ4++goUyh/Sgnb30/S/U7jU8gbTUT11CCWtwYfIoJ/9cso684nDGX0Q?=
 =?us-ascii?Q?E4i1wpIR7/By2HABC8td1dqpg+i0wRehhU6nFFyBot5TaOVpp5CIjJIcZ2oU?=
 =?us-ascii?Q?Dnp6xbkATH5BRjK5IHQbAW4gL+1OlmF2jIrFyfEuEZedSni1EU2w4M2IKada?=
 =?us-ascii?Q?TDw1VFvTohnA1qAPN/bsQKPsl7P9k7ZMmBsVHICZ9EUH2m/4NidcTKrYj3sY?=
 =?us-ascii?Q?3QkGQ1hdiJuARNYLPEm2QggpwHMR9hNU8zv8lM5dy7rZOQQ3f2yA0NaHTRHw?=
 =?us-ascii?Q?3ZiSDM+UOwzx6wcWg1ZVDn0+tahb4+h8fftsLfvJCDRE00u7VF5lOqUEsQMC?=
 =?us-ascii?Q?sKgz5qnke+45WJlrlz3XEJh9yeuTO83Ytws8Z48VvicnD+3wUjWXvTvo+Efn?=
 =?us-ascii?Q?m3B4p+vKXlE0F8wv+RSLow954BZmZOrOjaUh2FRlxinIyBPy/NtwP4kSddjQ?=
 =?us-ascii?Q?souL7AivOk4I2DpoEPeD1zSPCi+4qeC23Dto8wGvCC9Mumx1MuAtuWo/aLsk?=
 =?us-ascii?Q?kpdqIlOL3rqEvDZfEkb2LTnybG2L0IxMnoeG+zmGr34dyD8A2Jk7krtk/C45?=
 =?us-ascii?Q?STb6SENvtgkGBfzxPn7Hj+vzcTdBIsQIiNxrZiLu8aq7r7MiFMqbWShhvofZ?=
 =?us-ascii?Q?3jUqCkqFrb3xlLJ7n+IhhgaxEVENGzeNO18l0smXS++E2Sbc3gFTjlTu+NfP?=
 =?us-ascii?Q?jQlTSN8VqlZRrB0amOqtJ7XbNfi49Sey6SNyUlHTMtAe1IJQOBdbPewZbnOz?=
 =?us-ascii?Q?4P6rUZjNqEn0z5sfEP+t6f/f/MpGL/0+DCxV/WquvmtJAvCOiSbL4QVniS/U?=
 =?us-ascii?Q?Dp1UibXxtSBki8qiR4ef/dXQDQPYQW1YWllO89tFB36KYG1OrRCl0mojCRRP?=
 =?us-ascii?Q?Pp/04z0MR/TRkBB8i7LMTmf35Qb3urYQUyUZf6aAo01xbUIgKd3hoLuUU4GQ?=
 =?us-ascii?Q?rUHIe9ER8Y/04lra3Ttpk9ua+5kiZNZYdPhA3N3dCxza1l3HP+JNeZbAAYc+?=
 =?us-ascii?Q?HfqEo1KgTewbl4saAFx/cNcBGKcttWrEusEbsS9APO6nX2O4CAq2nU8DRDqH?=
 =?us-ascii?Q?Kfa7fEQSVRiO/DXLJJAY4s3CYzi9jEn0NLT8lsYFv48JfBBnsmRSlO/mS5yy?=
 =?us-ascii?Q?R/O4XUfxtZg1nAzy7nZ6NMkta/obXexxGMeO8t5UYb05E6aacokyb1JLr93J?=
 =?us-ascii?Q?mBGe/9XQJHXc2SI/3uz3u+nbDGv3+V1RTNZFB9bE8imNg30OcgVJzAk0ydS+?=
 =?us-ascii?Q?1ZrifHTwWTiZGanG3ECDzuE/6ZUqWqq9Hdr4VgshRmezYydH2us5TYt+RFXk?=
 =?us-ascii?Q?iKDg60/j9lTZ1qkWldyzTIlIHb4akIk=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 6aa1988a-31c0-4620-37c3-08de89d31648
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2026 18:28:03.7555
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RbTlhIkSVOTxwlafbZVNcKdXei1wezB2+Wtd5MPjYsdkMThJb48SE4qX7X4086dFxgNu66vaXv6O7vs8sHERwHMrtnSpRxM4OvNvPKBjibQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB9280
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[renesas.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[bp.renesas.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[27];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9632-lists,dmaengine=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[TY6PR01MB17377.jpnprd01.prod.outlook.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,bp.renesas.com:dkim,renesas.com:email]
X-Rspamd-Queue-Id: 26B3731AE84
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Kuninori,

Thank you for the review.

> -----Original Message-----
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> Sent: Monday, March 23, 2026 2:45 AM
> To: John Madieu <john.madieu.xa@bp.renesas.com>
> Subject: Re: [PATCH 16/22] ASoC: rsnd: Export module getters for PM
> support
>=20
>=20
> Hi John
>=20
> > Export rsnd_adg_mod_get() and rsnd_ssiu_mod_get() to make them
> > accessible from core.c.
>=20
> It is *adding* new rsnd_ssiu_mod_get(),
> and exporting rsnd_ssiu_mod_get() different type of features
>=20

You are right. I'll update the commit message accordingly,
or would prefer it to be split in different patches ?

Regards,
John=20

> >
> > This is preparation for system suspend/resume support, where the PM
> > callbacks need to iterate over all modules to save and restore their
> > clock and reset state. Other modules (SSI, SRC, CTU, MIX, DVC) already
> > have their getters exported.
> >
> > Signed-off-by: John Madieu <john.madieu.xa@bp.renesas.com>
> > ---
> >  sound/soc/renesas/rcar/adg.c  | 10 ++++++++++
> > sound/soc/renesas/rcar/rsnd.h |  2 ++  sound/soc/renesas/rcar/ssiu.c |
> > 2 +-
> >  3 files changed, 13 insertions(+), 1 deletion(-)
> >
> > diff --git a/sound/soc/renesas/rcar/adg.c
> > b/sound/soc/renesas/rcar/adg.c index 131a60689f6d..d73f29bc9de7 100644
> > --- a/sound/soc/renesas/rcar/adg.c
> > +++ b/sound/soc/renesas/rcar/adg.c
> > @@ -906,6 +906,16 @@ int rsnd_adg_probe(struct rsnd_priv *priv)
> >  	return 0;
> >  }
> >
> > +struct rsnd_mod *rsnd_adg_mod_get(struct rsnd_priv *priv) {
> > +	struct rsnd_adg *adg =3D rsnd_priv_to_adg(priv);
> > +
> > +	if (!adg)
> > +		return NULL;
> > +
> > +	return rsnd_mod_get(adg);
> > +}
> > +
> >  void rsnd_adg_remove(struct rsnd_priv *priv)  {
> >  	struct device *dev =3D rsnd_priv_to_dev(priv); diff --git
> > a/sound/soc/renesas/rcar/rsnd.h b/sound/soc/renesas/rcar/rsnd.h index
> > a803c0f03665..2cee5c2aa7d7 100644
> > --- a/sound/soc/renesas/rcar/rsnd.h
> > +++ b/sound/soc/renesas/rcar/rsnd.h
> > @@ -628,6 +628,7 @@ int rsnd_adg_set_cmd_timsel_gen2(struct rsnd_mod
> *cmd_mod,
> >  #define rsnd_adg_clk_disable(priv)	rsnd_adg_clk_control(priv, 0)
> >  int rsnd_adg_clk_control(struct rsnd_priv *priv, int enable);  void
> > rsnd_adg_clk_dbg_info(struct rsnd_priv *priv, struct seq_file *m);
> > +struct rsnd_mod *rsnd_adg_mod_get(struct rsnd_priv *priv);
> >
> >  /*
> >   *	R-Car sound priv
> > @@ -824,6 +825,7 @@ int rsnd_ssi_is_dma_mode(struct rsnd_mod *mod);
> > int __rsnd_ssi_is_pin_sharing(struct rsnd_mod *mod);
> >
> >  #define rsnd_ssi_of_node(priv) rsnd_parse_of_node(priv,
> > RSND_NODE_SSI)
> > +struct rsnd_mod *rsnd_ssiu_mod_get(struct rsnd_priv *priv, int id);
> >  void rsnd_parse_connect_ssi(struct rsnd_dai *rdai,
> >  			    struct device_node *playback,
> >  			    struct device_node *capture);
> > diff --git a/sound/soc/renesas/rcar/ssiu.c
> > b/sound/soc/renesas/rcar/ssiu.c index f377d9414633..1462f02c2a7f
> > 100644
> > --- a/sound/soc/renesas/rcar/ssiu.c
> > +++ b/sound/soc/renesas/rcar/ssiu.c
> > @@ -434,7 +434,7 @@ static struct rsnd_mod_ops rsnd_ssiu_ops_gen2 =3D {
> >  	DEBUG_INFO
> >  };
> >
> > -static struct rsnd_mod *rsnd_ssiu_mod_get(struct rsnd_priv *priv, int
> > id)
> > +struct rsnd_mod *rsnd_ssiu_mod_get(struct rsnd_priv *priv, int id)
> >  {
> >  	if (WARN_ON(id < 0 || id >=3D rsnd_ssiu_nr(priv)))
> >  		id =3D 0;
> > --
> > 2.25.1
> >

