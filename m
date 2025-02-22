Return-Path: <dmaengine+bounces-4564-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D4F4A40631
	for <lists+dmaengine@lfdr.de>; Sat, 22 Feb 2025 09:07:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50348189FF6C
	for <lists+dmaengine@lfdr.de>; Sat, 22 Feb 2025 08:07:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE1B220010A;
	Sat, 22 Feb 2025 08:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="Cl9OPyml"
X-Original-To: dmaengine@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010034.outbound.protection.outlook.com [52.101.229.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D80471482F2;
	Sat, 22 Feb 2025 08:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740211619; cv=fail; b=b+eCVnTUKHDRppsSQysk+d9u+ZVu+O2jyFz0iJjtgNky5bSTisOLxAclIwuJVZP1BhqC4gk8QsNJ89MIQpiDw7Y37P3kXEKz4oPGZJ/BXNm4VChcbrSCsLFDlnkSGOLoM1Cfq3MmfFVhHL2TYVvcivuUJSJq8Epqs4bn4+o+LgM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740211619; c=relaxed/simple;
	bh=Pr06fXJmm+yzlRshSh97xwMRylKncC6nqO4Ie02kFGA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Pmpsr7nzAKhZKWyD9ZowHsW74QVSFS64Z/RdEghqNXlHY7GE9XWRRhIrHqf8WzXBVeF5R+mPSINZKXoqpc1gkTY6QNdBXkeT97X1TPSfDVszFQ1F5kxqrTuum5Zla3scuszjS0/2YPfqGCTD+rEVwv/GT3d9u5HyH1G9mdo3tqw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=Cl9OPyml; arc=fail smtp.client-ip=52.101.229.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fPi75l9v1ACk6K2SOxaEWDcFma6317pPKFZk88dlWWqm7kFoPSOTbTm6JxKJlkzuG09FFcNnqRDyoXNp5CUloCSwVMnSeHCDRrMXoVd7KuvI9yyS9PJBKAk7DRA4VWR/s6b24/bDxWOk7CHPs18U/qlSAlj0S0q/WbhGVimljEi42h5OvBy+EwsjlB2kt99Oh1RItuvoccPbUX1pz0JUADZN0BT8A+doqyTKHRuWIEAfboRJw2l1TbCWs1OtN2sfwJ40xXwLMYIuMENKNxDq0Vx2/owRUf1V/N3YAwkb5SL6CpkEiqXdNniTB2RMlEr+4XOO4UkQP0orXPpeSFEEkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/WI4srRwmNEB4xczB3EVWRJ7f4u1zeuhOLlWdjM+d00=;
 b=bW+30u9dd8K9zf3BKk3h+oxD63HFhVrb6btbHJe27d4uvbwtLPqab0LmWWLsJuQ0VtSdQD4+MAZsUeQL6GkW0PUcxuddgbQUirW5JP+KsAOidt5UUEiagAqn9mM3V8gDwfbEBxCyIOlL6Vzhv4o12/RwC3rsqrc17Iy7K0dY7DQdVYuMkXULlTxK0C8sy+l3CG4roiRLukbTKwYeeKwm9tJ6DnGCZKahkXgVDi/BtEBSy2cRohmhb5lyLLAYDjxsTAGsmxpoYDshBvLsmvcTyTln+U9OhIa3mwg7cQbJ0URAa1czzSQMWNCloOBPi0V0l7MwYHPl8VX4EAZsb7UAmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/WI4srRwmNEB4xczB3EVWRJ7f4u1zeuhOLlWdjM+d00=;
 b=Cl9OPymlYMgHuewhUhXtD2jss7HomM3BE/oFJ3L5Pi6s5hGADW0GUZdsk5dStrc4kjH+koLYhj4/7QY2vriv5o886hpKIche6gJ3cD8cjKXeLkPDktenPG22f4sJ2lD3NVSPp/k1K14tNnpXFDvX4518laDhksKbP/7x6GXMzqo=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by OS7PR01MB13585.jpnprd01.prod.outlook.com (2603:1096:604:35c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.17; Sat, 22 Feb
 2025 08:06:52 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1%5]) with mapi id 15.20.8466.016; Sat, 22 Feb 2025
 08:06:52 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Fabrizio Castro <fabrizio.castro.jz@renesas.com>, Vinod Koul
	<vkoul@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>
CC: Fabrizio Castro <fabrizio.castro.jz@renesas.com>, Magnus Damm
	<magnus.damm@gmail.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>,
	=?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>,
	"dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [PATCH v4 6/7] dmaengine: sh: rz-dmac: Add RZ/V2H(P) support
Thread-Topic: [PATCH v4 6/7] dmaengine: sh: rz-dmac: Add RZ/V2H(P) support
Thread-Index: AQHbg6haNLctC6ID5UyVBbTDj2gS37NS+QrQgAAA2iA=
Date: Sat, 22 Feb 2025 08:06:52 +0000
Message-ID:
 <TY3PR01MB11346120529049351F8B5C43A86C62@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20250220150110.738619-1-fabrizio.castro.jz@renesas.com>
 <20250220150110.738619-7-fabrizio.castro.jz@renesas.com>
 <TY3PR01MB113460BFB6817240662420BF186C62@TY3PR01MB11346.jpnprd01.prod.outlook.com>
In-Reply-To:
 <TY3PR01MB113460BFB6817240662420BF186C62@TY3PR01MB11346.jpnprd01.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|OS7PR01MB13585:EE_
x-ms-office365-filtering-correlation-id: 4ee6cf4a-caf7-4803-3ba7-08dd5317dd82
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?1ZnaSRuwZkdN40KgFU8V1rulqUywKJ02rF/sxjzniF37YnSTUGImb5r6jf?=
 =?iso-8859-1?Q?qWE84lI/PKDT1BUl5g4sCRWoArcPsOZwezswdzUa+HdOyt0mtm5+YaVaoZ?=
 =?iso-8859-1?Q?50PQAc4IVkRjhye28PdZSP6WB5Gvsi+eEcyrVtWtKUjE5g2twej05AJOh/?=
 =?iso-8859-1?Q?8KcS7M9gBPeHI9yrNxArWfZdPg0oLcpCyNn6hgpxS7PxXzGGNWebC5b0y/?=
 =?iso-8859-1?Q?s8ogNnYI3lLApgXeReYhE3vX9Gu5mn4hIbFKttwLjJGVg0eJUgnwTyOsXm?=
 =?iso-8859-1?Q?D8C6g3shY7/P5gsx0TwYvvCR1jkF/I1aOj4W0P8BMabds6aEBzNL7edxgR?=
 =?iso-8859-1?Q?IbZmKXm5I/Ub5KtOMKVoHJtruER7supqO8kupXrM9NNeddH517VMn4Q5MY?=
 =?iso-8859-1?Q?59xwr8KhYv6+vcQg9i7pHFX6UhlyAJvi/bncwJYUPcH4kHoU9PgIjBLv9l?=
 =?iso-8859-1?Q?01IJX0azHNItzsqjpLXiwj5f2T/KsBiF4sbhW2Y4Svb1B40Lv0QBUF8FTV?=
 =?iso-8859-1?Q?JeZBPWzeIUK3KK5Cmd9vnmhrQFq/FQTGWtGQXK0PDEyd/hPn4TNBQhKHzV?=
 =?iso-8859-1?Q?zNlpGxiShkb3DSsORIikD2l5Lyt0eLI1Nq86gX1Pn0LEvJo301fOR29p4u?=
 =?iso-8859-1?Q?7Y+qnR8gfHyf+dqwdYHUn5/dgW9u2UV2iJmXk2yzWpVoet4bO5furFA4fe?=
 =?iso-8859-1?Q?Epwtst47xt1WRXHylI5bnQBYbS0hl5djVilT5dcuNldmtaFBvG31Tn0D4p?=
 =?iso-8859-1?Q?WPT/kgofOvQwOaCKm0CBngC63puC3Z+YxRAvoIV60U/dCxxxIociVxNf6L?=
 =?iso-8859-1?Q?6x843VdeEn/RX41JA3LPbO+xpYl8q4y5+Om6wmDwyHsH5nJGY6Tbve2or0?=
 =?iso-8859-1?Q?wbuL07s406gUBgfQhfaGtv7wOb6mtTWkAhnJM2OE8tDIvcJBa9hmS1jWeb?=
 =?iso-8859-1?Q?W485qroKAQg+iZKj5GCuHFXUCSBqwMj8SR/NiyzXPHVv2tcqGfUbBR+yH0?=
 =?iso-8859-1?Q?If109UYVnL+8qXuNHn9OfVfUWGZ9G68xNh0u6D4B846Ks+ljD9Ix3IcrQn?=
 =?iso-8859-1?Q?oiBAEZN2P+FyEcbzDyc8pow9d/epIuJJvV+iXKpa9sKo2yDaDPJrRbiMqa?=
 =?iso-8859-1?Q?xWuEaa4mE30ryXvYGYZUbQ6mm4AdKRtveZ9wQUvOJCEOtoKMljAE+G7IPL?=
 =?iso-8859-1?Q?pmC84NWQeyoMbyAdkta4G7yRlYIGjcRwpDETJOXZBfnaPlh4mnELjmguE6?=
 =?iso-8859-1?Q?vN5zKOT1fKl5kRrYSncG/ArH6RYJDjWCprMmf40vqi5YSGVIgX9Uq9QUun?=
 =?iso-8859-1?Q?PtIjnG28wI/AGEKFF5gqIC6oZM6tg7tXHnPHBlAR1s+g1Lq2hJlJ50PopJ?=
 =?iso-8859-1?Q?WE9/xNVxS9phF5gYPmBoIbgBZjWZ1Nvyb2mxzJqsKEsNEXuKFplgiCF6iS?=
 =?iso-8859-1?Q?qR57qITFhr4Rvss9V5DmTLW2FI7JVK/sGvnWS5Pgjl3SmS3UbNTP0UBAWl?=
 =?iso-8859-1?Q?Tv3uxfjpHT6zzkdDmV2Vjd?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?J7nlZddWNFfQcQL1XJBlPpSjUDzIIjtxfN+QH/QYBo8tXw9s2/WsVFWS72?=
 =?iso-8859-1?Q?8vGUm+Dx041hnNt7lDuJ4EgNrqY6/VoZ87O4YDzJ3DDte3yzspCeR0hpjb?=
 =?iso-8859-1?Q?6oim5G1AlJC3EWce5lZf+bFRPbcKCBjZETw7+k+ucwaGEC/KRaVKnoHWYG?=
 =?iso-8859-1?Q?CyAMMj2BBWXJ9I/eoNbsg4wNJlnMCDTKvZg9zFCGJh8uGlFkvkFlMdgh3S?=
 =?iso-8859-1?Q?qjAEl7b+TD6IiE03vjnFCBgzQ0bul8Pa2KfZhEVZgyb5xuLP/YGcEtn8zi?=
 =?iso-8859-1?Q?SvCxNC1rGJ3z6MSAEMMdLO/hTdQUZM2sOD+IEoDrrb+HK2RhPq51SSpw/k?=
 =?iso-8859-1?Q?uu85ujOWWlhCo8c/5Jaknp14VuIM3+SGkjLcZqqRbyQhr6uXNLUdbjrEN5?=
 =?iso-8859-1?Q?EtddxdB7JINqEKDRq8YL1DimuF8F/OUhCljFBYSqCU373F0Ui+/d5Q6XgJ?=
 =?iso-8859-1?Q?2pjr+f41fTcFvnh3lnDpRJVTWqqknb8eX3BIg0vRtNY6a5Nybkvg/mbtj5?=
 =?iso-8859-1?Q?s9MBelfBj9XSiNqcUJkKeum/VhdpwP6kFRABJcZTHKcdg6NUuVlX9A/LBt?=
 =?iso-8859-1?Q?6xZggkdvmhmIvRWkSYXmBh6RNDQFobbxpdzrWobbpiiUE5quVjBE2k7YiV?=
 =?iso-8859-1?Q?lYyPNKnDHRfZxRNk2Fqs9f2GgPcur9FbQnwP1jBNzdCPPBw7zDa6IFdJCd?=
 =?iso-8859-1?Q?V/fevvhrohl0jlVePT/Jq7h9fXlWtno9GO0sZ7f40LFvb9IMxuABerdiw0?=
 =?iso-8859-1?Q?qg8yjJbbKPLgkh0IVL233OxlUSlapslrjwI3B2FpPI0VmwoNYFS+Mx3qId?=
 =?iso-8859-1?Q?+OVoZ2lDpQFKhabAh2jeBL7k95OASTakKPDCMLbm3GDlejMW4Vwx3A2SQ9?=
 =?iso-8859-1?Q?FYNYvEuddZuHKlS/pWmjoE1Bp8CF6MAnVA0knQDW8Vi502ZJ/Apndh9V38?=
 =?iso-8859-1?Q?XlfzAB0HsCVNKyAAk1rJ7btgaqkDDfB4oq1HxmXRrBMjWV9GY5uqIgDkhg?=
 =?iso-8859-1?Q?2mIGCqJAbJh/Qq/dD/7gujJJR8cNr59iGWktsBp5Gp6f5AF2Csr+64MBw4?=
 =?iso-8859-1?Q?QBi5o75dYNbwkp8sqbRkd+XKX9zGpwCqc7eyaUMWJE4fPsvdYpmEFgIFs/?=
 =?iso-8859-1?Q?3CzCDcaCYLQ6VKD2NG2sHYv4F5wXRNbZE+gJ5CBozBPSy5a2Src/CK0J0F?=
 =?iso-8859-1?Q?tH2kHdD2yPK66WT15U9d+ZqM3dVQ3Zh9i2tjwhIHlcPwOJBksHax13KZZN?=
 =?iso-8859-1?Q?20dwh0x6GjE9M4o9WZwMMCLRlPhSrqyJJjf7URBJi/jGzKihnBVV388x40?=
 =?iso-8859-1?Q?9MoXsF2qSQsEej7QUw0nFb7DQRhTMhoAzCCn7xAzct4p5x5DGvQxE6XK2L?=
 =?iso-8859-1?Q?YKP5Xpls8oXAaD9QbQ3U2j3m/JxBXzJ+BLAn1q2cJrRmIS37Yhk7qv990M?=
 =?iso-8859-1?Q?90QaSNSr01VPfxFjtDLiETyzDAgvpDiknyzePrWextEyDiO3SjMRR+EtJV?=
 =?iso-8859-1?Q?D8Tvn7cxglIQjaKfV5SSxxImuSIgER2kTO8PFzS+OyT9hghXH+rdmVR6c2?=
 =?iso-8859-1?Q?KWK7BL2lXDHm1K7dyOzH9e1ANfE0A2fKP4FEcdZRp1Orxb2mrCmHaQLVjP?=
 =?iso-8859-1?Q?f6hBabHyL4QtetgoSteS9F/T6mS2fbSkHbeiUKIynaoERu/8dty1tniw?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ee6cf4a-caf7-4803-3ba7-08dd5317dd82
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Feb 2025 08:06:52.1589
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8dST6h+GR/PymX2Lzf/xbP2eUUX23F1WRSqK6wsz8IaC3WJPBXAdhzwY5YQCwHfMseNG6s+W7PNDFgNlmhdj0KlYEJ7bVW9jWwORuFyYPRY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7PR01MB13585



> -----Original Message-----
> From: Biju Das
> Sent: 22 February 2025 08:06
> To: 'Fabrizio Castro' <fabrizio.castro.jz@renesas.com>; Vinod Koul <vkoul=
@kernel.org>; Geert
> Uytterhoeven <geert+renesas@glider.be>
> Cc: Fabrizio Castro <fabrizio.castro.jz@renesas.com>; Magnus Damm <magnus=
.damm@gmail.com>; Wolfram
> Sang <wsa+renesas@sang-engineering.com>; Uwe Kleine-K=F6nig <u.kleine-koe=
nig@baylibre.com>;
> dmaengine@vger.kernel.org; linux-kernel@vger.kernel.org; linux-renesas-so=
c@vger.kernel.org; Prabhakar
> Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Subject: RE: [PATCH v4 6/7] dmaengine: sh: rz-dmac: Add RZ/V2H(P) support
>=20
> Hi Fabrizio Castro,
>=20
> > -----Original Message-----
> > From: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
> > Sent: 20 February 2025 15:01
> > Subject: [PATCH v4 6/7] dmaengine: sh: rz-dmac: Add RZ/V2H(P) support
> >
> > The DMAC IP found on the Renesas RZ/V2H(P) family of SoCs is similar
> > to the version found on the Renesas RZ/G2L family of SoCs, but there ar=
e some differences:
> > * It only uses one register area
> > * It only uses one clock
> > * It only uses one reset
> > * Instead of using MID/IRD it uses REQ NO/ACK NO
> > * It is connected to the Interrupt Control Unit (ICU)
> > * On the RZ/G2L there is only 1 DMAC, on the RZ/V2H(P) there are 5
> >
> > Add specific support for the Renesas RZ/V2H(P) family of SoC by
> > tackling the aforementioned differences.
> >
> > Signed-off-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
> > ---
> > v3->v4:
> > * Fixed an issue with mid_rid/req_no/ack_no initialization
> > v2->v3:
> > * Dropped change to Kconfig.
> > * Replaced rz_dmac_type with has_icu flag.
> > * Put req_no and ack_no in an anonymous struct, nested under an
> >   anonymous union with mid_rid.
> > * Dropped data field of_rz_dmac_match[], and added logic to determine
> >   value of has_icu flag from DT parsing.
> > v1->v2:
> > * Switched to new macros for minimum values.
> > ---
> >  drivers/dma/sh/rz-dmac.c | 162
> > +++++++++++++++++++++++++++++++++++----
> >  1 file changed, 146 insertions(+), 16 deletions(-)
> >
> > diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c index
> > d7a4ce28040b..57a1fdeed734
> > 100644
> > --- a/drivers/dma/sh/rz-dmac.c
> > +++ b/drivers/dma/sh/rz-dmac.c
> > @@ -14,6 +14,7 @@
> >  #include <linux/dmaengine.h>
> >  #include <linux/interrupt.h>
> >  #include <linux/iopoll.h>
> > +#include <linux/irqchip/irq-renesas-rzv2h.h>
> >  #include <linux/list.h>
> >  #include <linux/module.h>
> >  #include <linux/of.h>
> > @@ -73,7 +74,6 @@ struct rz_dmac_chan {
> >
> >  	u32 chcfg;
> >  	u32 chctrl;
> > -	int mid_rid;
> >
> >  	struct list_head ld_free;
> >  	struct list_head ld_queue;
> > @@ -85,20 +85,36 @@ struct rz_dmac_chan {
> >  		struct rz_lmdesc *tail;
> >  		dma_addr_t base_dma;
> >  	} lmdesc;
> > +
> > +	union {
> > +		int mid_rid;
> > +		struct {
> > +			u16 req_no;
> > +			u8 ack_no;
> > +		};
> > +	};
> >  };
> >
> >  #define to_rz_dmac_chan(c)	container_of(c, struct rz_dmac_chan, vc.cha=
n)
> >
> > +struct rz_dmac_icu {
> > +	struct platform_device *pdev;
> > +	u8 dmac_index;
> > +};
> > +
> >  struct rz_dmac {
> >  	struct dma_device engine;
> >  	struct device *dev;
> >  	struct reset_control *rstc;
> > +	struct rz_dmac_icu icu;
> >  	void __iomem *base;
> >  	void __iomem *ext_base;
> >
> >  	unsigned int n_channels;
> >  	struct rz_dmac_chan *channels;
> >
> > +	bool has_icu;
> > +
> >  	DECLARE_BITMAP(modules, 1024);
> >  };
> >
> > @@ -167,6 +183,23 @@ struct rz_dmac {
> >  #define RZ_DMAC_MAX_CHANNELS		16
> >  #define DMAC_NR_LMDESC			64
> >
> > +/* RZ/V2H ICU related */
> > +#define RZV2H_REQ_NO_MASK		GENMASK(9, 0)
> > +#define RZV2H_ACK_NO_MASK		GENMASK(16, 10)
> > +#define RZV2H_HIEN_MASK			BIT(17)
> > +#define RZV2H_LVL_MASK			BIT(18)
> > +#define RZV2H_AM_MASK			GENMASK(21, 19)
> > +#define RZV2H_TM_MASK			BIT(22)
> > +#define RZV2H_EXTRACT_REQ_NO(x)		FIELD_GET(RZV2H_REQ_NO_MASK, (x))
> > +#define RZV2H_EXTRACT_ACK_NO(x)		FIELD_GET(RZV2H_ACK_NO_MASK, (x))
> > +#define RZVH2_EXTRACT_CHCFG(x)		((FIELD_GET(RZV2H_HIEN_MASK, (x)) << 5=
) | \
> > +					 (FIELD_GET(RZV2H_LVL_MASK, (x))  << 6) | \
> > +					 (FIELD_GET(RZV2H_AM_MASK, (x))   << 8) | \
> > +					 (FIELD_GET(RZV2H_TM_MASK, (x))   << 22))
> > +
> > +#define RZV2H_MAX_DMAC_INDEX		4
> > +#define RZV2H_ICU_PROPERTY		"renesas,icu"
> > +
> >  /*
> >   * -------------------------------------------------------------------=
----------
> >   * Device access
> > @@ -324,7 +357,15 @@ static void rz_dmac_prepare_desc_for_memcpy(struct=
 rz_dmac_chan *channel)
> >  	lmdesc->chext =3D 0;
> >  	lmdesc->header =3D HEADER_LV;
> >
> > -	rz_dmac_set_dmars_register(dmac, channel->index, 0);
> > +	if (!dmac->has_icu) {
> > +		rz_dmac_set_dmars_register(dmac, channel->index, 0);
> > +	} else {
> > +		rzv2h_icu_register_dma_req_ack(dmac->icu.pdev,
> > +					       dmac->icu.dmac_index,
> > +					       channel->index,
> > +					       RZV2H_ICU_DMAC_REQ_NO_DEFAULT,
> > +					       RZV2H_ICU_DMAC_ACK_NO_DEFAULT);
> > +	}
> >
> >  	channel->chcfg =3D chcfg;
> >  	channel->chctrl =3D CHCTRL_STG | CHCTRL_SETEN; @@ -375,7 +416,15 @@
> > static void rz_dmac_prepare_descs_for_slave_sg(struct rz_dmac_chan
> > *channel)
> >
> >  	channel->lmdesc.tail =3D lmdesc;
> >
> > -	rz_dmac_set_dmars_register(dmac, channel->index, channel->mid_rid);
> > +	if (!dmac->has_icu) {
> > +		rz_dmac_set_dmars_register(dmac, channel->index, channel->mid_rid);
> > +	} else {
> > +		rzv2h_icu_register_dma_req_ack(dmac->icu.pdev,
> > +					       dmac->icu.dmac_index,
> > +					       channel->index, channel->req_no,
> > +					       channel->ack_no);
> > +	}
> > +
> >  	channel->chctrl =3D CHCTRL_SETEN;
> >  }
> >
> > @@ -452,9 +501,15 @@ static void rz_dmac_free_chan_resources(struct dma=
_chan *chan)
> >  	list_splice_tail_init(&channel->ld_active, &channel->ld_free);
> >  	list_splice_tail_init(&channel->ld_queue, &channel->ld_free);
> >
> > -	if (channel->mid_rid >=3D 0) {
> > -		clear_bit(channel->mid_rid, dmac->modules);
> > -		channel->mid_rid =3D -EINVAL;
> > +	if (!dmac->has_icu) {
> > +		if (channel->mid_rid >=3D 0) {
> > +			clear_bit(channel->mid_rid, dmac->modules);
> > +			channel->mid_rid =3D -EINVAL;
> > +		}
> > +	} else {
> > +		clear_bit(channel->req_no, dmac->modules);
> > +		channel->req_no =3D RZV2H_ICU_DMAC_REQ_NO_DEFAULT;
> > +		channel->ack_no =3D RZV2H_ICU_DMAC_ACK_NO_DEFAULT;
> >  	}
> >
> >  	spin_unlock_irqrestore(&channel->vc.lock, flags); @@ -647,7 +702,15
> > @@ static void rz_dmac_device_synchronize(struct dma_chan *chan)
> >  	if (ret < 0)
> >  		dev_warn(dmac->dev, "DMA Timeout");
> >
> > -	rz_dmac_set_dmars_register(dmac, channel->index, 0);
> > +	if (!dmac->has_icu) {
> > +		rz_dmac_set_dmars_register(dmac, channel->index, 0);
> > +	} else {
> > +		rzv2h_icu_register_dma_req_ack(dmac->icu.pdev,
> > +					       dmac->icu.dmac_index,
> > +					       channel->index,
> > +					       RZV2H_ICU_DMAC_REQ_NO_DEFAULT,
> > +					       RZV2H_ICU_DMAC_ACK_NO_DEFAULT);
> > +	}
> >  }
> >
> >  /*
> > @@ -727,13 +790,30 @@ static bool rz_dmac_chan_filter(struct dma_chan *=
chan, void *arg)
> >  	struct rz_dmac *dmac =3D to_rz_dmac(chan->device);
> >  	struct of_phandle_args *dma_spec =3D arg;
> >  	u32 ch_cfg;
> > +	u16 req_no;
> > +
> > +	if (!dmac->has_icu) {
> > +		channel->mid_rid =3D dma_spec->args[0] & MID_RID_MASK;
> > +		ch_cfg =3D (dma_spec->args[0] & CHCFG_MASK) >> 10;
> > +		channel->chcfg =3D CHCFG_FILL_TM(ch_cfg) | CHCFG_FILL_AM(ch_cfg) |
> > +				 CHCFG_FILL_LVL(ch_cfg) | CHCFG_FILL_HIEN(ch_cfg);
> > +
> > +		return !test_and_set_bit(channel->mid_rid, dmac->modules);
> > +	}
> > +
> > +	req_no =3D RZV2H_EXTRACT_REQ_NO(dma_spec->args[0]);
> > +	if (req_no >=3D RZV2H_ICU_DMAC_REQ_NO_MIN_FIX_OUTPUT)
> > +		return false;
> > +
> > +	channel->req_no =3D req_no;
> > +
> > +	channel->ack_no =3D RZV2H_EXTRACT_ACK_NO(dma_spec->args[0]);
> > +	if (channel->ack_no >=3D RZV2H_ICU_DMAC_ACK_NO_MIN_FIX_OUTPUT)
> > +		channel->ack_no =3D RZV2H_ICU_DMAC_ACK_NO_DEFAULT;
> >
> > -	channel->mid_rid =3D dma_spec->args[0] & MID_RID_MASK;
> > -	ch_cfg =3D (dma_spec->args[0] & CHCFG_MASK) >> 10;
> > -	channel->chcfg =3D CHCFG_FILL_TM(ch_cfg) | CHCFG_FILL_AM(ch_cfg) |
> > -			 CHCFG_FILL_LVL(ch_cfg) | CHCFG_FILL_HIEN(ch_cfg);
> > +	channel->chcfg =3D RZVH2_EXTRACT_CHCFG(dma_spec->args[0]);
>=20
> Looks like a typo?? RZVH2_EXTRACT_CHCFG-> RZVH2_EXTRACT_CHCFG

Oops.

Looks like a typo?? RZVH2_*-> RZV2H_*

Cheers,
Biju

