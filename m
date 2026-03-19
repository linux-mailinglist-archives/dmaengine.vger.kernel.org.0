Return-Path: <dmaengine+bounces-9547-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QA6yCbM2vGl3uwIAu9opvQ
	(envelope-from <dmaengine+bounces-9547-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 19 Mar 2026 18:47:31 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C14E02D03F9
	for <lists+dmaengine@lfdr.de>; Thu, 19 Mar 2026 18:47:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BB2933038F37
	for <lists+dmaengine@lfdr.de>; Thu, 19 Mar 2026 17:45:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B0BB393DC1;
	Thu, 19 Mar 2026 17:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="UMiRg/d2"
X-Original-To: dmaengine@vger.kernel.org
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11011036.outbound.protection.outlook.com [52.101.125.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3A88393DDA;
	Thu, 19 Mar 2026 17:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773942324; cv=fail; b=cOyVGAJgmAFmGPc4SDFqZ5DOcIKnSQWsD9/FERTuDZ1TODyBmuTZGXLmxVwxUAvuKsU0OQrBJ5UW/m1Qlm9L3Z7qk2AmiPL2/16l7q9TYIN+/kM77g4Awzchh8/DL6gd5kaMKO79H7aECgKCcNabrlKIRFP9v7WFvk4DJOziJ64=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773942324; c=relaxed/simple;
	bh=wgAanzvvX8ROEmHoOU1gKM9fow5/ctLHr3VB8ASo9+U=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=iXs2JE5tSlpXhFlhRFkUUg+efav5/VmdySjd14Sz67yVJXD654WdY8aH261CSSVURSQjkUG0cfIdv7CKvfKy6oIJTm8jNkKYcEUFO4shkXE2U6uEvWgYIXZf5c2reo7wa9opLAdq6wc1CarlrQ3alfj/VginB37OH+BIUDrBmXM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=UMiRg/d2; arc=fail smtp.client-ip=52.101.125.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EVDj0XKZ4+DSAVjcKGTfJq+Wj2PxuXEoObAvwc/sFivicGimw6a70ZaSOrDSPXqaiIs/L+dtM6WsKyMoj4Sqjo4v8YHt2bSaw3qlTTkZeqMqg8Dn/UrLfo6XqC+v4eX8WdcJjoabrQs9ryoK+5+UQiFJ9NcKHXpswRdduQW49jipe+wlpGYsJ7omvfuuYH0odIaKlBKVyIq0l+gAnZHVjYDHwShEBgLY61//PNNOd59Q/CSccu/CxUzvISYVE182pZVX/Y5DIRQZfJ1H4AOIaf3I7YubRRZVkxvcQAx9bbsOqGDjIM6FfJGw+snAkJWkbfe7CEMEo1fwtfedbbEe+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2pEpVTwr3BkG9uxtVUJYt5VyekJ3UOWVQ/kyugMqBG8=;
 b=vUQt4eLjmWiaFIF4i+WiTYLzw1yN147wq2O3UZ/0HmkJsJ9PEOMWsA3SkRuIolp82+tm5wuJO+C+6jng37yGBctTV4F9HuK5/BmL0fDAQh4P1AZI2NE5OFzfoKmjQNwQFd15hjrSP4DjCxtRLAitaIHnUPpI+lxqiNR6ilL1xZQTSNS6w1qJ8xdiC9Lw8drkCea/rpC9qLs6jIwGs2orIkLa73JsVYQzpY65Y+3LuB5aXYMi3PotCVk2kbUQhVSRtUOIDEn4E6HMssnMrQ3xeWB5f2gPo+6c6ZSBdPSRRMiL74BrponQo5J0Fpo/dMBrzESV9wrN9+wtvXr69i37EQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2pEpVTwr3BkG9uxtVUJYt5VyekJ3UOWVQ/kyugMqBG8=;
 b=UMiRg/d282sGAl6ug88FDkXfGb9Y/vXtAU5UEwdEmyx4nLFxqBCSbdWCRlrdzali3F6D+kAgt+axOhWyEYF9yWRD3k/fWvTPx6ambaIjcd14hvIbGF+f5Dg4IqyV8VMkyvUVQhtx4O8lSpKHu5KRao7ICF8EGBrv9v259alUDMw=
Received: from TY6PR01MB17377.jpnprd01.prod.outlook.com (2603:1096:405:35b::6)
 by OSZPR01MB8171.jpnprd01.prod.outlook.com (2603:1096:604:1a6::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.20; Thu, 19 Mar
 2026 17:45:15 +0000
Received: from TY6PR01MB17377.jpnprd01.prod.outlook.com
 ([fe80::f373:26d6:86c4:6aa3]) by TY6PR01MB17377.jpnprd01.prod.outlook.com
 ([fe80::f373:26d6:86c4:6aa3%4]) with mapi id 15.20.9723.018; Thu, 19 Mar 2026
 17:45:05 +0000
From: John Madieu <john.madieu.xa@bp.renesas.com>
To: Mark Brown <broonie@kernel.org>
CC: Geert Uytterhoeven <geert+renesas@glider.be>, Kuninori Morimoto
	<kuninori.morimoto.gx@renesas.com>, Vinod Koul <vkoul@kernel.org>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Michael
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
Subject: RE: [PATCH 00/22] ASoC: rsnd: Add audio support for the Renesas
 RZ/G3E SoC
Thread-Topic: [PATCH 00/22] ASoC: rsnd: Add audio support for the Renesas
 RZ/G3E SoC
Thread-Index: AQHct7ixkWVMq6xq/UKX3UnPZEFuJLW2CY+AgAAVrMA=
Date: Thu, 19 Mar 2026 17:45:05 +0000
Message-ID:
 <TY6PR01MB1737704E431A765933FA6D097FF4FA@TY6PR01MB17377.jpnprd01.prod.outlook.com>
References: <20260319155334.51278-1-john.madieu.xa@bp.renesas.com>
 <b2347c14-7f29-4453-938b-8287f45aa5fd@sirena.org.uk>
In-Reply-To: <b2347c14-7f29-4453-938b-8287f45aa5fd@sirena.org.uk>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY6PR01MB17377:EE_|OSZPR01MB8171:EE_
x-ms-office365-filtering-correlation-id: 05789536-6877-47d5-db23-08de85df4197
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700021|22082099003|18002099003|56012099003;
x-microsoft-antispam-message-info:
 xxMkX8yJk3q8zQdQoY3YYrl7lu/viJx/57ubqODERPHNiqo9vvVcAc6/bBy0yF4VgT4nqBtSt7wRgFDsBcuUu+cHFbciXVRfxZ//pWI0ck+aSlfi/CJm++k5G04MD/WrSUV9mrAzqYb6qIZ44/kHgb+N96ja2BL2li0tlJKbmt6WI6xnF5lyjwqze+Iak1/TJ5MvQxrNffp8NcbwSYpIGX0wxlhVKzeQbT8KvkiHDE4IgjCn/XOydqG3cuMdC1h4Qj7KKb7c4xfJijvaErR3tpPM0oY/nhCTZC0ivE+8rYzGelsevAe1DHMhnVTdb3u2LIEl92KhkmCECS1OFZLsISmkXk4NlMD3xVTjR6nASZoIwQdgLA2xO4dgDuirwWqRMHVygyIXkpmsswA2s8mHXFvxlXjF2SuGJGMAmSEaTAG9D3chLo54m0lVwuWcDOTwSFrqFN93D5KABKKpZT8yuk5uMe8YKQ6EDBV7A0+jN+vJL4MHOrBAPgAmzE7kQmG3gWvjlGVrzD79tv9xsXUSak1AnNEs1HyFqHuphSyzk6VABKV5jU5CduvLDK6d28OSe/Y/Oz5KATYhQb88zLXqlzqIvtcvas1pzKBT2DLf0QC6fTSzIhVsg570a0TUTWXIfPeI4xOuXcE4q8vYtATc/muzvmSzMkoestWIi4WsakTK5J+Y5qqlWkLocHGjVznKfdf/NsKCNH+KghnCd2tiNMMX9q7/gKnX59NWtrDsR3JFSR60xXWDhKEntfZYZw4/ud2HlGE/y4SvkC+ugagadvQcUj+cGN4kCQAGrPiZr8w=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY6PR01MB17377.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700021)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?gdHUo7/Yd+zpb5zcCjw/l34pM8JXuvfHpLSXveCua4aYtH0GBY3EPyFaTn2G?=
 =?us-ascii?Q?+JInaDKC7A/8zki4ETSUqcNt+hiA2nklwjIG+KE1wzUWs4/BM9bPfuS7yhYN?=
 =?us-ascii?Q?tj2yPjl47x2Blr4dAnSOEy+00JKGirBr1/x9BUzgy38y2l6XIJZnlr8C6dAa?=
 =?us-ascii?Q?97SGFQ50gBo52l1bsLJMnw4ARXtKuxcuPA0nhKfWHV3ud2QxADck5QpzMANx?=
 =?us-ascii?Q?dL97YcomQretk4QhQXriEGvthSs7If/zZavYiMgpFbpeRNy85rSNHp1Dik0t?=
 =?us-ascii?Q?oHfJ2NTQEjYxymJjTJ6/vU4dEIov1wXsUUkFnXIHphG/F0JGQJgv/Mb3LuxX?=
 =?us-ascii?Q?k9SKvyNTbhEeS4R0nTjuqx1SnQvXB5pJA0hG3nBjSCxX9q1vQvuIsk2pIBmL?=
 =?us-ascii?Q?q6MLtuPp4v85TyRl9540GC68CiSjr6lMn6hQimWvLuWg5mt52Uet19UPVBFq?=
 =?us-ascii?Q?gjLQWv7LCglZ+v3qMX4NwtRn9whBYVl+oV3qki05I3p+9m6x2w25llXvEnad?=
 =?us-ascii?Q?2NiKIFaSw9/EGUmPyn/2zWPZ2YIM5MVHMEAQzGG2YvDVLMDHmLRx1qSHzEOO?=
 =?us-ascii?Q?mSNwEnCWsSozTqYKNrQMdDE3Gw6lqlLHBMF0aZGCyRvBBx2yvKPBfT9FtQb+?=
 =?us-ascii?Q?JHfXXK1Gnp6gWXzn2jwrnZzBtZ55Qt6WwcnnU9t5OLRiKQP1SGnkf9zO1017?=
 =?us-ascii?Q?HRn0X2eOj2Yd2Xhgfn/riUOiBWKBtRe3it7sFwocya5ex+Sx/af/7y7EzDbK?=
 =?us-ascii?Q?Pc4n3fx0xYE45rVJSKFR6SD8WDrm8tlPKHBQ9AX2l6TmvIWf5wGhR5mwZOZN?=
 =?us-ascii?Q?G3d3cDSMXE6VvmkykAgiVdaf1pBS95rrKMrWVmc80lTBtUDCVrSkDc+aMuY/?=
 =?us-ascii?Q?MKSh/LZKeNHubSDTnsxsCQhNWv7+xIy/jo+mxwlyBzFhYM5FDi0WniDCCF3U?=
 =?us-ascii?Q?JLh4fvvHvJsVUUBBGrBNZwCjSrHBerM+4WTkmk9Sl4sHwaLZSuWuBXu3OTiT?=
 =?us-ascii?Q?Nd97J5/yYSn7CqBSoiGzw/e9RdrECL2d/SdVJM8xMh6U8XsBXEYXxXCCkDA3?=
 =?us-ascii?Q?vSoojyxtq7UDELGuH2OnrW6jpJ74s6wvOrXS4zp77npbDdnlBDlRukSHlz3d?=
 =?us-ascii?Q?MfkxwI0NzapOv1w3R9cs51zVo0P2kJvHuzWvG1Aro+xXcW6wdm/LWxKZ/Qj1?=
 =?us-ascii?Q?pQLdrCXyn7J8KEeEAxflbC02cGeZQTrNyFgrCinMC/zCQf+9XqV83X0X6dU+?=
 =?us-ascii?Q?rDUBYcbxNnYTSm4dwdjCBIxRsaysPsr2Ern1yQKTrVW5QSgJBGhxTLsQ3oGq?=
 =?us-ascii?Q?p0DQ3mv1UHyNSXRrdXd7O2Jv6tp7KRq5gZ8m0iCY/Bk2odcptO88O1Cphl/V?=
 =?us-ascii?Q?0j11WOBGLfTPip5MjUvXDiyn/xetB4gpAus3lkK6lZdjJCk5oiJEI20LoqrL?=
 =?us-ascii?Q?Au+opLCrpAkpZBkaO9a/MXDfIAenmgGNzKu487MIrFqqHMQT4bUY8kCPKtCO?=
 =?us-ascii?Q?VKRQ1DhHLvMIzsjUJJIwAYNe6SCH8MxVx/8mkiNm02lm1+dOwTQBQm/WVjv2?=
 =?us-ascii?Q?qBO8HIlpuD+NvsAjg76turEcgZIVudcc4ayR5ZrzOki1TtCFlpe2CEMNezVG?=
 =?us-ascii?Q?pZC1kjBz8T8IKO1Lf72CB0CV1J/PpVEPzJKz86QU8TYdkXqKGXbjxrHdaEe4?=
 =?us-ascii?Q?iA3I0B/nBYN8OASQEU3zzyqLywGLnLKwtI/yh8QoGK9gh0qF5J6X2wg/cSG0?=
 =?us-ascii?Q?/PrLmqJ6wiGp6A3AHGpJmwwtfdsALc4=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 05789536-6877-47d5-db23-08de85df4197
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2026 17:45:05.7385
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HDDMFCuCU9TMRsD33vGfsRymo/NRjLfZUrMe8TfbJQUJXay1f0pETflHkmudIPivpNSk5PorzgkCTzL/2P7ewu8dCZAHqkBft39Q9vYKTR0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB8171
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[renesas.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[bp.renesas.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[27];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9547-lists,dmaengine=lfdr.de];
	FREEMAIL_CC(0.00)[glider.be,renesas.com,kernel.org,baylibre.com,gmail.com,perex.cz,suse.com,pengutronix.de,tuxon.dev,bp.renesas.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[john.madieu.xa@bp.renesas.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[bp.renesas.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[dmaengine,renesas,dt];
	NEURAL_HAM(-0.00)[-0.949];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,renesas.com:email,bp.renesas.com:dkim]
X-Rspamd-Queue-Id: C14E02D03F9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


Hi Mark,

Thanks for the feedback.

> -----Original Message-----
> From: Mark Brown <broonie@kernel.org>
> Sent: Thursday, March 19, 2026 5:22 PM
> To: John Madieu <john.madieu.xa@bp.renesas.com>
> Subject: Re: [PATCH 00/22] ASoC: rsnd: Add audio support for the Renesas
> RZ/G3E SoC
>=20
> On Thu, Mar 19, 2026 at 04:53:12PM +0100, John Madieu wrote:
>=20
> > This series includes:
> >   - Clock driver support for audio clocks and resets
> >   - DT bindings update for DMA ACK signal field
> >   - IRQ chip extension for DMA ACK signal routing
> >   - RZ-DMAC driver updates for ACK signal support
> >   - R-Car Sound driver updates for RZ/G3E support
> >   - System suspend/resume support
> >   - Device tree nodes for RZ/G3E SMARC EVK
>=20
> Are there any non-runtime dependencies between the various patches here?
> It's a fairly large series touching multiple subsystems, we'll need to
> work out how it gets merged.  It looks to be mainly ASoC but perhaps the
> other subsystem changes are independent and can just go via their tree?

The series contains the full chunk of patches for audio IP to work, so they
depend on each other for runtime to work. However, patches will go through
different trees and will eventually meet in linux-next or a release.

In addition to that, DMA (patch 06/22) has hard dependency on IRQ (path 05/=
22).

The merge strategy could be:

 * Patch 01, 03/22 =3D> Clock
 * Patches 05-06 /22 =3D> DMA
 * Patches 07-17/22 =3D> ASoC
 * Patches 02, 18-22/22 =3D> DT

Next time I'll take care of clarifying this in cover letter.

Regards,
John

