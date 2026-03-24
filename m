Return-Path: <dmaengine+bounces-9635-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YGMwG7HxwmkdnQQAu9opvQ
	(envelope-from <dmaengine+bounces-9635-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 24 Mar 2026 21:18:57 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id AE41A31C3C1
	for <lists+dmaengine@lfdr.de>; Tue, 24 Mar 2026 21:18:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CC0CE3126FC8
	for <lists+dmaengine@lfdr.de>; Tue, 24 Mar 2026 20:10:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDABB326D75;
	Tue, 24 Mar 2026 20:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="hzzfqBwf"
X-Original-To: dmaengine@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011043.outbound.protection.outlook.com [40.107.74.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E4AB30DEA2;
	Tue, 24 Mar 2026 20:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774383008; cv=fail; b=um8sYhtjviyJiRPbWdx0Pw4/81wBoUKeuGnIC4lzs4I7SgZ2i1zn/RWPbV5x6rz5M/hJceriCwOEJCDXSJAT00qmT3C51JTFsJzcEiVj/Il9EYqDpwq0MnS3NEssk6eFyP++v4PYE0zc96daZqRyfSlJRzrO9MQNpXnmZDEwRlQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774383008; c=relaxed/simple;
	bh=YShK0MaGqgFJ0/1uyQhAu/tA/BrbTFPiF/MAR6vB4I0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MQIB4WfOTbnaSbo0MC9Ml0+KdqSxDa5pL2Le36017B/yjj2vPuEQsGohOTIL/MCsKRnE+yrjIg5svZt0AzpnoOh1aSGUR1cTQb2LY5TlfZHAu/lXM4LgtTQQ/1DojzelTfCjguBUVS3XCTX2eOoUDf5ZvwZf51YROmy3YYZgRNs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=hzzfqBwf; arc=fail smtp.client-ip=40.107.74.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yrP3/qKDNanH23Z75/CMYK5Tk1BrnnTInAu4V5B5anKEYGOMkYTutXOQfo9jd2GPdbqkgs8weQoQjIf3Qrz0drfjk627HyWLgliLzaaICfnpDG5th8yYt5Y/hM50xMDlibfF6gkwA9m2WWp2wU44aAloj4GbEEkrO0IwXXvJLdivIB/A6eJp829B3ViC7ubMc8hke8oTeJf0hsQRyceIbm22QPx1cHg5R3NAUQPG4pyOpZIlBocdwhblDzgMstr7tWmU3BhSrEUXK56UJ9U6ZFvwX14/0uPWpUlu4udQqxkRwSUpjkNxUnO+/WYPK/5CPc5OOkOYtcoeRQ0/rIkQCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YShK0MaGqgFJ0/1uyQhAu/tA/BrbTFPiF/MAR6vB4I0=;
 b=JG7kpwZqLLyGsmueEHlJTayGVTIgJAE3blTioxE1q50CHXtGORbc1kE1hG+81+GcOSPNNQW34Oa7nvFnsM2ua1ZRnl4BiT1Yp5lC6ezugiK9Ss8EdBT2LN8YieEDj2r7dKWOmFEhljBJH1D/uZHMueyS9Fvl6B0eAtdakz1QzeHsYwwlsTmgByl0gKl2tbEcK5QgUc2CH1XsCYF7wVH2NhpxudDJ6vzeMA16TAVVzGQLOl9pUVw7Vt5+suQIZ5Pe406a2IZS6JCO067cnJ+Li9fGHajAk07lv1BVv8EO/i9aTkXtji/LLi1yCOByCq0oGrA5ZRpL6JXnKtgFJt886g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YShK0MaGqgFJ0/1uyQhAu/tA/BrbTFPiF/MAR6vB4I0=;
 b=hzzfqBwfDfebdMmbZxU9q1qJ8+PdokkI1FlSFCI3OamK8QZTwXmXcqCXtrn9zLGmhGc7z7xU3OGGYrzIp0pUPJk6CEGvSRCkfd7z19nJXUUtXFEnBRulTsy/a7Hd2MTOV0irDyUBjnrrr61j0KS8vhB2N566mOmdPtE+pyFRrj4=
Received: from TY6PR01MB17377.jpnprd01.prod.outlook.com (2603:1096:405:35b::6)
 by OS7PR01MB16983.jpnprd01.prod.outlook.com (2603:1096:604:422::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.31; Tue, 24 Mar
 2026 20:10:03 +0000
Received: from TY6PR01MB17377.jpnprd01.prod.outlook.com
 ([fe80::f373:26d6:86c4:6aa3]) by TY6PR01MB17377.jpnprd01.prod.outlook.com
 ([fe80::f373:26d6:86c4:6aa3%4]) with mapi id 15.20.9723.030; Tue, 24 Mar 2026
 20:10:03 +0000
From: John Madieu <john.madieu.xa@bp.renesas.com>
To: geert <geert@linux-m68k.org>
CC: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Vinod Koul
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
Subject: RE: [PATCH 12/22] ASoC: rsnd: Update SSI for RZ/G3E support
Thread-Topic: [PATCH 12/22] ASoC: rsnd: Update SSI for RZ/G3E support
Thread-Index: AQHct7jz2LaVerAx7UCPMGNW/Eh6sLW9tz6AgABsVyA=
Date: Tue, 24 Mar 2026 20:10:03 +0000
Message-ID:
 <TY6PR01MB173779E71EB46F090934FC80CFF48A@TY6PR01MB17377.jpnprd01.prod.outlook.com>
References: <20260319155334.51278-1-john.madieu.xa@bp.renesas.com>
 <20260319155334.51278-13-john.madieu.xa@bp.renesas.com>
 <CAMuHMdW9uvkcU789W+K38qxVTVQbFHGOaBgqNkj7SbTR8WShoA@mail.gmail.com>
In-Reply-To:
 <CAMuHMdW9uvkcU789W+K38qxVTVQbFHGOaBgqNkj7SbTR8WShoA@mail.gmail.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY6PR01MB17377:EE_|OS7PR01MB16983:EE_
x-ms-office365-filtering-correlation-id: bf3df40d-dff9-4ae6-3bc7-08de89e15606
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|376014|1800799024|22082099003|18002099003|56012099003|38070700021;
x-microsoft-antispam-message-info:
 iQ1ALE/sV4h3Y9T08e9493YgMFK60VBgSfVcGEuBy3ED/+tIXyYhRnvrxp2h8LgEVIbDCT4YBLz6i6a2ruMOgQMw3u4H8KbwCPRaON0oQxD2rEJAEo0bdUlmhIJI6HZ15y5bpBl4YYrx8tH1WDROSJZvqRIQkKgy6zE5k3H5klCpOZndY20ReZgqs/x+AYQWJotoNWqmnOy9I0YvuMkC6sl/322xm7tEM2hiXptIB5zX8TMyPWrqN+NpFQ/uyU7xWRjM9CTTDE4GtPD8Uj0XE56W1P0DgAEpDsh8ec1VlS6Hi/M0ddKUj/0//AuksjBZsAc7q9KnzilFubjX+KVHKOnGVUaase0vgRl+G8FFqmGfamO67T2nHrZHJwz55EZo1uWRFavrbUUJ5fhKIqDrNOU3x54ehs7agVLINFkbyL5uqsoia3VA1SLQjTMhNIwpLzDpUX+GZD3um9KJ53+eoPDPY6N33puYbMYJ+HNyPxFaYcznvFyQsiEdcSGUcvWm/8yMaJ43ND7v28zmL5crEwsauMG5k9fGwaGDzJQ89oSIg03UMegzdra0/3C3sY5+J8cerQ+iTPC9Fnjmh/YZjLGOwQBI8xFL1X1Nyx+V4o1bNRV5INJvnPZvZdSCF1difGx/ZPnF570ID/4QOAiDAnRvEJmwfC3lYt5BTHujKvGlbKleYtL+yitPRS6nUv+jIb6Doqbqm3IulcZqRLufCCCxBeALMkTfkLogXDdQx1TBE3oVOGpaUZDFW7MS5yRJiqcqtYeMqRbyztAz/5Bp4J269nKkZ5zo3X00a/bB0tc=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY6PR01MB17377.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(22082099003)(18002099003)(56012099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?djBNVEcvbUdGaVdLK3JjaTAvaHJadmxhMmtnWHBpYTRjWWw1Vzk3QXNHQU41?=
 =?utf-8?B?UjF6UmFYUVowTVdCOVFUOE1wNTF0ZnUxS2pPVWhncjlPSklWVzNEc2cySm80?=
 =?utf-8?B?cUd3eFdWa1dkYWlQR1BBSmpMQnVqYXh4ZWUzbnZXc29HSUQ5R2MrRlJ3UGV3?=
 =?utf-8?B?NEFsaDFpbUsrRHFCYk8za29iajhrM0t4clJqaDEyd2hxT1JsVVhSVW1nMjdH?=
 =?utf-8?B?K2MzWHY4SVRzSzJkKzlXWWIzalVOaTMzRXpZM05jd3Fwdk5wNW90enNWdEhM?=
 =?utf-8?B?Qkx2TFBFMnFtTkxheU5kQzU1MUw1OE5zd01FK3dHOUZJY0REdHU0VGtxNTBK?=
 =?utf-8?B?ZXRaNGEvQUFoWW9zbnlHY2Z0NEZhZ3NFdGtOTHZRcWJQZjZDaisvbWM1UDJX?=
 =?utf-8?B?VDBYRElHN0FucXd1eVNtSmxJQ3hkRm4yejZPYWdlQUpnNEpHVEh4OGErT0dt?=
 =?utf-8?B?SytKa0tOM0dtVzZzRzFXdVhOYzBXbVh3dG5hRHBzV3RrQ09qRDhwaUpZWFQy?=
 =?utf-8?B?NmFVOUdQd3BaSE0rQTl0K21OVkFyRkhJNGlYWU5SUnZJWXJrNndROEI0TGxm?=
 =?utf-8?B?UnVERTNPMlk1cjVBUldBYWoyeGQra3NwU2lUOHlKeVJ6a21wRjRVcStPOWt2?=
 =?utf-8?B?MWNad0Z1dy9BQ0tpMUZwcnRsKzR5RlBScERmclN1M2dMUUdmSTJKM1JhTC9y?=
 =?utf-8?B?RkhyWkcyTVlzYTNQL0NrZ3UySWxMelFuQVc1OFRNOTE4YUNiMHJlRTh1QVo4?=
 =?utf-8?B?cDBPWVVUN0Rua0hTUTN4SFJsYWxXY3hvUjNRdlljNGRDWjNkeU54NDJQN2dl?=
 =?utf-8?B?THlXSStidExJdkNoUnVETnBBV3lCQnUvWjVOTTljbDU3K1Juc2Yxd21uUHIx?=
 =?utf-8?B?OE1nTS8xdG9NbGtxNGJmdWVZeDFWZGFUdW5wSlUzdEF2TjFTN243ODlYejls?=
 =?utf-8?B?RTVrc004R0pxaUFldDJ6T05OakhjT2p3Mm5EbUt4UWpNN1IvOTM1VEdZOUhI?=
 =?utf-8?B?aExzNnNTdnE5WXE4TlVmTTJiME04YzdLTUd3TnRiNS80M3p3aHplSEFza2hm?=
 =?utf-8?B?VVpXY2xBSlg2NmN3azRhUFpNbkU3WUtRMlBPRTJqd0xrc3JhbXkwMWpySnph?=
 =?utf-8?B?T01BdmEvYllpSHBnbFRaTm40WnJOWTRQOUFWZDhiSGgxL2hmNktWZWpOOGZw?=
 =?utf-8?B?WGlyQmQyQlhBQldIdjMrQkJWc2lRUjN5R1RWY1d2NENNa2JUQWtYOFNQaGNF?=
 =?utf-8?B?ajh0OWZWL0xOWGRwSlc5Nmt5V2VzZjVueFY5M0pFdFh3ekI3MDlxSEk5dU5l?=
 =?utf-8?B?cEpsRTlNVzJVTmw3NWpGdkp6UmVLK04vWkpKMzEwcmZYWTBiUHdQZWRqVWYx?=
 =?utf-8?B?ZHdMWjk5Vk95U2N1Qk0rcld1bDhIK3hnZXIzL3Z3Uk1tSEtpT2hXdTBuK2dn?=
 =?utf-8?B?QkJLUW1pVkVNdXVnVU53Y3BhdXVEN2laOFE3RTd4NE4xSnA2MHhTdUVnSEVi?=
 =?utf-8?B?M2hHbE9Qc1MyOWt3RVhnRDA0RjM1QzNFUXEvNDFMMWNhUG9vaWtTdkNqa3RQ?=
 =?utf-8?B?MUUyQkZtaEZ4NTc5RmVHMk9CbTJWcnRQQjl1alNaUTR2Mmkwai81dVNHcHU2?=
 =?utf-8?B?dkZBMUVpMk5nUHB3emFaY1lqb0c3UjVYcHRRYVJiMVlmdjVqK09ReCtEcDNX?=
 =?utf-8?B?Yy9IeTh3d3hDemt4REU1WTJsZGNFR2paTlRwNFQ5VXFqaGdxaGppZFM0dktm?=
 =?utf-8?B?QzBORk93TWJLWkNpMk50V2M4VGRvc29YMUNqRmp4MzBWVFpsSVRnTG56RVR3?=
 =?utf-8?B?Nm5KQzZUeWhoNUYxYXNJdm16SWpEUTFPSXEyZFdoY3lLaWZHQ0o1SzVJWk16?=
 =?utf-8?B?dTVsZDdyVkVyQk4rV3ljYzJmUUFrNkE2L3QzYWJUS2J3N2FmVDhEVW1Ea0h3?=
 =?utf-8?B?N0RhVFcvMDFabW5yaHhMbzMwWHFWRlRHNXJDRUE0d2d2SU91dEJqL0NtUWZW?=
 =?utf-8?B?aEVUd3hQN3hrakVKaVFaU1JxM2dlWjl5N2grVkZtQzlIZCthQW91clJteGln?=
 =?utf-8?B?NGhldVIxZjFWMUM1d2oyRmZzS05ZZk1EdEViK29TUjNOUVFURUllU21seWR2?=
 =?utf-8?B?a0NVVDlkK1JWOG9WVGxvYTlaZnBhNTZTYTQvTFJUd1BleWZ5dEFNK0praFlk?=
 =?utf-8?B?bU9icEduVWpQK0tFVUtkd1BKODRaZUg4dTRyZUtWQjJuWVlpZitzSk9NU214?=
 =?utf-8?B?QUo3emZUZUxwUXhqMjdKbGJIUWVNbFc1aVM1WVlxa1RlWnkrbHBIbzhzOWlh?=
 =?utf-8?B?NXdPYmZ2dnBvNVBkUTEyc3BUS0N4bklJLy9HZXJJM2kwMWF0Qk1RRTVmYjBV?=
 =?utf-8?Q?yTx+3wsDMUCrQYNU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY6PR01MB17377.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf3df40d-dff9-4ae6-3bc7-08de89e15606
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2026 20:10:03.6649
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: b6thK0EVr8ObnYKl7s3KfONbhpoKYweG5OaqaOPqlxRK2Kj3muWub7TahlweHz3JQCqe8/kkXTuVKR6RKRj/85P09pSQAlDTK4bzwP8UtCs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7PR01MB16983
X-Spamd-Result: default: False [2.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[renesas.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[bp.renesas.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[renesas.com,kernel.org,baylibre.com,gmail.com,perex.cz,suse.com,pengutronix.de,tuxon.dev,bp.renesas.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-9635-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[27];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[john.madieu.xa@bp.renesas.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[bp.renesas.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	NEURAL_HAM(-0.00)[-1.000];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: AE41A31C3C1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

SGkgR2VlcnQsDQoNClRoYW5rcyB5b3UgZm9yIHRlc3RpbmcgYW5kIHJlcG9ydGluZyB0aGlzLg0K
DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEdlZXJ0IFV5dHRlcmhvZXZl
biA8Z2VlcnRAbGludXgtbTY4ay5vcmc+DQo+IFNlbnQ6IFR1ZXNkYXksIE1hcmNoIDI0LCAyMDI2
IDI6MzcgUE0NCj4gVG86IEpvaG4gTWFkaWV1IDxqb2huLm1hZGlldS54YUBicC5yZW5lc2FzLmNv
bT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCAxMi8yMl0gQVNvQzogcnNuZDogVXBkYXRlIFNTSSBm
b3IgUlovRzNFIHN1cHBvcnQNCj4gDQo+IEhpIEpvaG4sDQo+IA0KPiBPbiBUaHUsIDE5IE1hciAy
MDI2IGF0IDE2OjU2LCBKb2huIE1hZGlldSA8am9obi5tYWRpZXUueGFAYnAucmVuZXNhcy5jb20+
DQo+IHdyb3RlOg0KPiA+IEFkZCBTU0kgc3VwcG9ydCBmb3IgdGhlIFJlbmVzYXMgUlovRzNFIFNv
Qywgd2hpY2ggZGlmZmVycyBmcm9tIGVhcmxpZXINCj4gPiBnZW5lcmF0aW9ucyBpbiBzZXZlcmFs
IHdheXM6DQo+ID4NCj4gPiAgLSBUaGUgU1NJIGJsb2NrIGFsd2F5cyBvcGVyYXRlcyBpbiBCVVNJ
RiBtb2RlOyBSWi9HM0UgZG9lcyBub3QNCj4gaW1wbGVtZW50DQo+ID4gICAgdGhlIFNTSVREUi9T
U0lSRFIgcmVnaXN0ZXJzIHVzZWQgYnkgUi1DYXIgR2VuMi9HZW4zL0dlbjQgZm9yIGRpcmVjdA0K
PiBTU0kNCj4gPiAgICBETUEuDQo+ID4gICAgQ29uc2VxdWVudGx5LCBhbGwgYXVkaW8gZGF0YSBt
dXN0IHBhc3MgdGhyb3VnaCBCVVNJRi4NCj4gPiAgLSBFYWNoIFNTSSBpbnN0YW5jZSBoYXMgaXRz
IG93biByZXNldCBsaW5lLCBleHBvc2VkIHVzaW5nIHBlci1TU0kgbmFtZXMNCj4gPiAgICBzdWNo
IGFzICJzc2kwIiwgInNzaTEiLCBldGMuLCByYXRoZXIgdGhhbiBhIHNpbmdsZSBzaGFyZWQgcmVz
ZXQuDQo+ID4NCj4gPiBUbyBzdXBwb3J0IHRoZXNlIGRpZmZlcmVuY2VzLCB1cGRhdGUgcnNuZF9z
c2lfdXNlX2J1c2lmKCkgdG8gYWx3YXlzDQo+ID4gcmV0dXJuIDEgb24gUlovRzNFLCBlbnN1cmlu
ZyB0aGF0IHRoZSBkcml2ZXIgY29uc2lzdGVudGx5IHNlbGVjdHMgdGhlDQo+ID4gQlVTSUYgRE1B
IHBhdGguIEFsc28gdXBkYXRlIHRoZSByZXNldCBhY3F1aXNpdGlvbiBsb2dpYyB0byByZXF1ZXN0
IHRoZQ0KPiA+IGFwcHJvcHJpYXRlIHBlci1TU0kgcmVzZXQgY29udHJvbGxlciBiYXNlZCBvbiB0
aGUgU1NJIGluc3RhbmNlIG5hbWUuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBKb2huIE1hZGll
dSA8am9obi5tYWRpZXUueGFAYnAucmVuZXNhcy5jb20+DQo+IA0KPiBUaGFua3MgZm9yIHlvdXIg
cGF0Y2ghDQo+IA0KPiA+IC0tLSBhL3NvdW5kL3NvYy9yZW5lc2FzL3JjYXIvc3NpLmMNCj4gPiAr
KysgYi9zb3VuZC9zb2MvcmVuZXNhcy9yY2FyL3NzaS5jDQo+ID4gQEAgLTEyMyw4ICsxMjMsMTUg
QEAgaW50IHJzbmRfc3NpX3VzZV9idXNpZihzdHJ1Y3QgcnNuZF9kYWlfc3RyZWFtDQo+ID4gKmlv
KSAgew0KPiA+ICAgICAgICAgc3RydWN0IHJzbmRfbW9kICptb2QgPSByc25kX2lvX3RvX21vZF9z
c2koaW8pOw0KPiA+ICAgICAgICAgc3RydWN0IHJzbmRfc3NpICpzc2kgPSByc25kX21vZF90b19z
c2kobW9kKTsNCj4gPiArICAgICAgIHN0cnVjdCByc25kX3ByaXYgKnByaXYgPSByc25kX21vZF90
b19wcml2KG1vZCk7DQo+ID4gICAgICAgICBpbnQgdXNlX2J1c2lmID0gMDsNCj4gPg0KPiA+ICsg
ICAgICAgLyoNCj4gPiArICAgICAgICAqIFJaL0czRSBkb2VzIG5vdCBzdXBwb3J0IFBJTyBtb2Rl
LiBBbHdheXMgdXNlIEJVU0lGLg0KPiA+ICsgICAgICAgICovDQo+ID4gKyAgICAgICBpZiAocnNu
ZF9mbGFnc19oYXMocHJpdiwgUlNORF9TU0lfQUxXQVlTX0JVU0lGKSkNCj4gPiArICAgICAgICAg
ICAgICAgcmV0dXJuIDE7DQo+ID4gKw0KPiA+ICAgICAgICAgaWYgKCFyc25kX3NzaV9pc19kbWFf
bW9kZShtb2QpKQ0KPiA+ICAgICAgICAgICAgICAgICByZXR1cm4gMDsNCj4gPg0KPiA+IEBAIC04
NjUsNiArODcyLDggQEAgc3RhdGljIGludCByc25kX3NzaV9jb21tb25fcmVtb3ZlKHN0cnVjdCBy
c25kX21vZA0KPiAqbW9kLA0KPiA+ICAgICAgICAgICAgICAgICByc25kX2ZsYWdzX2RlbChzc2ks
IFJTTkRfU1NJX1BST0JFRCk7DQo+ID4gICAgICAgICB9DQo+ID4NCj4gPiArICAgICAgIHJzbmRf
ZG1hX2RldGFjaChpbywgbW9kLCAmaW8tPmRtYSk7DQo+IA0KPiBUaGlzIGdvZXMgQk9PTSBvbiBS
LUNhciBHZW4zIGFuZCBHZW40Og0KDQpTb3JyeSBmb3IgdGhlIGJyZWFrYWdlLCBJIHNob3VsZCBn
ZXQgcmlkIG9mIHRoaXMgaW4NCnYyLg0KDQpSZWdhcmRzLA0KSm9obg0KDQo+IA0KPiAgICAgVW5h
YmxlIHRvIGhhbmRsZSBrZXJuZWwgTlVMTCBwb2ludGVyIGRlcmVmZXJlbmNlIGF0IHZpcnR1YWwg
YWRkcmVzcw0KPiAwMDAwMDAwMDAwMDAwMDA0DQo+ICAgICBNZW0gYWJvcnQgaW5mbzoNCj4gICAg
ICAgRVNSID0gMHgwMDAwMDAwMDk2MDAwMDA0DQo+ICAgICAgIEVDID0gMHgyNTogREFCVCAoY3Vy
cmVudCBFTCksIElMID0gMzIgYml0cw0KPiAgICAgICBTRVQgPSAwLCBGblYgPSAwDQo+ICAgICAg
IEVBID0gMCwgUzFQVFcgPSAwDQo+ICAgICAgIEZTQyA9IDB4MDQ6IGxldmVsIDAgdHJhbnNsYXRp
b24gZmF1bHQNCj4gICAgIERhdGEgYWJvcnQgaW5mbzoNCj4gICAgICAgSVNWID0gMCwgSVNTID0g
MHgwMDAwMDAwNCwgSVNTMiA9IDB4MDAwMDAwMDANCj4gICAgICAgQ00gPSAwLCBXblIgPSAwLCBU
bkQgPSAwLCBUYWdBY2Nlc3MgPSAwDQo+ICAgICAgIEdDUyA9IDAsIE92ZXJsYXkgPSAwLCBEaXJ0
eUJpdCA9IDAsIFhzID0gMA0KPiAgICAgWzAwMDAwMDAwMDAwMDAwMDRdIHVzZXIgYWRkcmVzcyBi
dXQgYWN0aXZlX21tIGlzIHN3YXBwZXINCj4gICAgIEludGVybmFsIGVycm9yOiBPb3BzOiAwMDAw
MDAwMDk2MDAwMDA0IFsjMV0gIFNNUA0KPiAgICAgQ1BVOiAxIFVJRDogMCBQSUQ6IDEgQ29tbTog
c3dhcHBlci8wIE5vdCB0YWludGVkIDcuMC4wLXJjNS1hcm02NC0NCj4gcmVuZXNhcy0wNzIzMy1n
Mzc3ODkzMTI0YjhhICMzNTMwIFBSRUVNUFQNCj4gICAgIEhhcmR3YXJlIG5hbWU6IFJlbmVzYXMg
R3JheSBIYXdrIFNpbmdsZSBib2FyZCBiYXNlZCBvbiByOGE3NzloMCAoRFQpDQo+ICAgICBwc3Rh
dGU6IDYwNDAwMDA1IChuWkN2IGRhaWYgK1BBTiAtVUFPIC1UQ08gLURJVCAtU1NCUyBCVFlQRT0t
LSkNCj4gICAgIHBjIDogcnNuZF9kbWFfZGV0YWNoKzB4MTAvMHgyMA0KPiAgICAgbHIgOiByc25k
X3NzaV9jb21tb25fcmVtb3ZlKzB4NDgvMHg3NA0KPiAgICAgc3AgOiBmZmZmODAwMDgxOGViYWMw
DQo+ICAgICB4Mjk6IGZmZmY4MDAwODE4ZWJhYzAgeDI4OiBmZmZmMDAwNDQxYzAyOTM4IHgyNzog
ZmZmZjAwMDQ0MDhhODQxMA0KPiAgICAgeDI2OiAwMDAwMDAwMDAwMDAwMDBkIHgyNTogMDAwMDAw
MDAwMDAwMDAwMCB4MjQ6IGZmZmY4MDAwODE3Yjk5NzANCj4gICAgIHgyMzogMDAwMDAwMDAwMDAw
MDAwMCB4MjI6IDAwMDAwMDAwMDAwMDAwMGMgeDIxOiAwMDAwMDAwMGZmZmZmZGZiDQo+ICAgICB4
MjA6IGZmZmYwMDA0NDFjMDI5MzggeDE5OiBmZmZmMDAwNDQwMmJjMDgwIHgxODogMDAwMDAwMDBm
ZmZmZmZmZg0KPiAgICAgeDE3OiBmZmZmMDAwNDQwYmE2NjAwIHgxNjogZmZmZjAwMDQ0MGJhNmEw
MCB4MTU6IGZmZmY4MDAwODE4ZWI3MDANCj4gICAgIHgxNDogMDAwMDAwMDAwMDAwMDAwMCB4MTM6
IDAwMDAwMDAwMDAwMDAwMDAgeDEyOiAwMDAwMDAwMDAwMDAwMDMwDQo+ICAgICB4MTE6IDAxMDEw
MTAxMDEwMTAxMDEgeDEwOiBmZmZmODAwMDgwZmE3NjcwIHg5IDogMWZmZmUwMDA4ODA1MmQyMQ0K
PiAgICAgeDggOiAwMTAxMDEwMTAxMDEwMTAxIHg3IDogN2Y3ZjdmN2Y3ZjdmN2Y3ZiB4NiA6IGZl
ZmY2MzZkNzQ2ZTcyMmQNCj4gICAgIHg1IDogMDAwMDAwMDAwMDAwMDAzYyB4NCA6IGZmZmY4MDAw
ODBhOWRjYzQgeDMgOiBmZmZmMDAwNDQwMmJlODAwDQo+ICAgICB4MiA6IGZmZmYwMDA0NDFjMDI5
YjggeDEgOiBmZmZmMDAwNDQxYzAyOTM4IHgwIDogMDAwMDAwMDAwMDAwMDAwMA0KPiAgICAgQ2Fs
bCB0cmFjZToNCj4gICAgICByc25kX2RtYV9kZXRhY2grMHgxMC8weDIwIChQKQ0KPiAgICAgIHJz
bmRfc3NpX2NvbW1vbl9yZW1vdmUrMHg0OC8weDc0DQo+ICAgICAgcnNuZF9wcm9iZSsweDJkMC8w
eDQ0OA0KPiAgICAgIHBsYXRmb3JtX3Byb2JlKzB4NTgvMHg5MA0KPiAgICAgIHJlYWxseV9wcm9i
ZSsweGI4LzB4Mjk0DQo+ICAgICAgX19kcml2ZXJfcHJvYmVfZGV2aWNlKzB4NzQvMHgxMjQNCj4g
ICAgICBkcml2ZXJfcHJvYmVfZGV2aWNlKzB4M2MvMHgxNTgNCj4gICAgICBfX2RyaXZlcl9hdHRh
Y2grMHhlMC8weDFiNA0KPiAgICAgIGJ1c19mb3JfZWFjaF9kZXYrMHg3OC8weGQ0DQo+ICAgICAg
ZHJpdmVyX2F0dGFjaCsweDIwLzB4MjgNCj4gICAgICBidXNfYWRkX2RyaXZlcisweGUwLzB4MWUw
DQo+ICAgICAgZHJpdmVyX3JlZ2lzdGVyKzB4NTgvMHgxMTQNCj4gICAgICBfX3BsYXRmb3JtX2Ry
aXZlcl9yZWdpc3RlcisweDIwLzB4MjgNCj4gICAgICByc25kX2RyaXZlcl9pbml0KzB4MTgvMHgy
MA0KPiAgICAgIGRvX29uZV9pbml0Y2FsbCsweDdjLzB4MTg0DQo+ICAgICAga2VybmVsX2luaXRf
ZnJlZWFibGUrMHgyMDAvMHgyZTANCj4gICAgICBrZXJuZWxfaW5pdCsweDIwLzB4MWNjDQo+ICAg
ICAgcmV0X2Zyb21fZm9yaysweDEwLzB4MjANCj4gICAgIENvZGU6IGE5YmY3YmZkIGFhMDAwM2Ux
IDkxMDAwM2ZkIGY5NDAwMDQwIChiOTQwMDQwMikNCj4gICAgIC0tLVsgZW5kIHRyYWNlIDAwMDAw
MDAwMDAwMDAwMDAgXS0tLQ0KPiANCj4gPiArDQo+ID4gICAgICAgICByZXR1cm4gMDsNCj4gPiAg
fQ0KPiA+DQo+IA0KPiBHcntvZXRqZSxlZXRpbmd9cywNCj4gDQo+ICAgICAgICAgICAgICAgICAg
ICAgICAgIEdlZXJ0DQo+IA0KPiAtLQ0KPiBHZWVydCBVeXR0ZXJob2V2ZW4gLS0gVGhlcmUncyBs
b3RzIG9mIExpbnV4IGJleW9uZCBpYTMyIC0tIGdlZXJ0QGxpbnV4LQ0KPiBtNjhrLm9yZw0KPiAN
Cj4gSW4gcGVyc29uYWwgY29udmVyc2F0aW9ucyB3aXRoIHRlY2huaWNhbCBwZW9wbGUsIEkgY2Fs
bCBteXNlbGYgYSBoYWNrZXIuDQo+IEJ1dCB3aGVuIEknbSB0YWxraW5nIHRvIGpvdXJuYWxpc3Rz
IEkganVzdCBzYXkgInByb2dyYW1tZXIiIG9yIHNvbWV0aGluZw0KPiBsaWtlIHRoYXQuDQo+ICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgLS0gTGludXMgVG9ydmFsZHMNCg==

