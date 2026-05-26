Return-Path: <dmaengine+bounces-10916-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sNefI4BhFWoiUwcAu9opvQ
	(envelope-from <dmaengine+bounces-10916-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 26 May 2026 11:01:52 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3604D5D2E6F
	for <lists+dmaengine@lfdr.de>; Tue, 26 May 2026 11:01:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AF90B305D86D
	for <lists+dmaengine@lfdr.de>; Tue, 26 May 2026 08:54:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CF223CE4BF;
	Tue, 26 May 2026 08:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="BhmTAIMP"
X-Original-To: dmaengine@vger.kernel.org
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11010038.outbound.protection.outlook.com [52.101.228.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0061A3CEBB7;
	Tue, 26 May 2026 08:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779785648; cv=fail; b=byerKLMdLhaQNszp9K+vOA4CaRK8ocpgtRfaWaK0TWnBqk4PizZQWqzLZLPTn4RxPLkvJfE+/K5lDabjRl++tzcf4or1L9gzu0KWxsVYuEiJQG3gN9A8840i68H1xsrhWWwOrgr96BfqAqS2XarA0VDqpuL1zX49ENVNjPx0N6c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779785648; c=relaxed/simple;
	bh=hhEzyN/fYuXxL/AjsC7QkAwTt9gtQ5+rLL4lmVy9PRY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Rmn5NBG+66Mw+Fcwtb7HcfTXp6ykcT+cq/WiRfKbfG6hUXjlj3tmrq6MnTOFDne3L3rv1peoLCGmlkNPDCuzioIaNjV+Ze3IamlBDvjR5iNkTnhRw+CXM4vb5qzzSk6xI5fX7NgEeYGSbgNha2RzDCicLL56VYn3Dv6rjeqbsuc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=BhmTAIMP; arc=fail smtp.client-ip=52.101.228.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h+EBM0JmZFDRmcG4rrlUaxHiOMDSgDV3MEeLs2FQEcBlxlO8vv7HoDwJa3F00XNxiyHHXGN5l00ONAhnmmTc/tFV39g/2hPQIchCMMbiZvotGByb+ESbmJdANQ7fFkFu7fQ+RRYordYu2o2m+7ZporyQ35X8IVGgYe6Y95D3qf1JQHA49AY6mEjli3WOnaa5m+mavStfFbQrcbwQrhmNyjHcEWwOSJDKfmoo5SBbrSq0xVbAeytP/W7mTNBqw9kwYlDoW2tm2fwSUJvuTpyYdtAp0YrTrAkUOujsEiZOkSpo6qAV8fvotqHBASzK5faUgCDGBbD9jpe57zCbc7MEdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oBqCsIPLUb8urJHv7UOLglL/AJLK5MGse9x+1jCoDRs=;
 b=lv9AEEx27OX4W7KhohnVbbKY8CVGBTRgJUgA/dFSKqeLYWWOaD+zDzxAfbIKzIBvobQ/GdKNi+IPvNReKJqO8RZy3+ldfkIwI+m1Uc25PfuGfvjyzLnMfcf6zIeAfhjURGOVhpAOeefM8gWMrqchk6RM0iNubQUzhwp+Z8lf3nJK4OrQ9Wl+x3v2K85SfMVlGfNL++YqbuzMJAUqKX7UjUp0+FlwswWI3JbHMm8ni6sD2L5fDM32s2ufdmszxLLT/kyDSBjvPf8Bu5omFrsicizA84BitY+46srE0YHhaG1auczNvZgNnf6zTc4deA+/H8PDWkv7Ze5k7EENIJK09w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oBqCsIPLUb8urJHv7UOLglL/AJLK5MGse9x+1jCoDRs=;
 b=BhmTAIMPg/zbniVrn4PEFMmsnhDVvmV/n6anNzEbfl3ALXYIoE2/wSAJQ3Xj3XactzkVmjtrla7B2V1qCB726D1MfMPY5TIiOBb3mgdHqDCq2dDJsU+ietTuLVryAOpdDnpDTCuDQtSDbeFpFaLkeOxqcIcVQYmWvkMYl1zaIb0=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by TY4PR01MB12649.jpnprd01.prod.outlook.com (2603:1096:405:1e7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.20; Tue, 26 May
 2026 08:54:02 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de%4]) with mapi id 15.21.0048.019; Tue, 26 May 2026
 08:54:02 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Claudiu Beznea <claudiu.beznea@kernel.org>, "vkoul@kernel.org"
	<vkoul@kernel.org>, "Frank.Li@kernel.org" <Frank.Li@kernel.org>,
	"lgirdwood@gmail.com" <lgirdwood@gmail.com>, "broonie@kernel.org"
	<broonie@kernel.org>, "perex@perex.cz" <perex@perex.cz>, "tiwai@suse.com"
	<tiwai@suse.com>, Prabhakar Mahadev Lad
	<prabhakar.mahadev-lad.rj@bp.renesas.com>, "p.zabel@pengutronix.de"
	<p.zabel@pengutronix.de>, "geert+renesas@glider.be"
	<geert+renesas@glider.be>, Kuninori Morimoto
	<kuninori.morimoto.gx@renesas.com>, Long Luu <long.luu.ur@renesas.com>
CC: Claudiu.Beznea <claudiu.beznea@tuxon.dev>, "dmaengine@vger.kernel.org"
	<dmaengine@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-sound@vger.kernel.org"
	<linux-sound@vger.kernel.org>, "linux-renesas-soc@vger.kernel.org"
	<linux-renesas-soc@vger.kernel.org>, Claudiu Beznea
	<claudiu.beznea.uj@bp.renesas.com>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>, Frank Li <Frank.Li@nxp.com>, John Madieu
	<john.madieu.xa@bp.renesas.com>
Subject: RE: [PATCH v6 01/18] dmaengine: sh: rz-dmac: Move interrupt request
 after everything is set up
Thread-Topic: [PATCH v6 01/18] dmaengine: sh: rz-dmac: Move interrupt request
 after everything is set up
Thread-Index: AQHc7OxJ+K5vYSqOKUeeUPNEYC8zxrYf/50w
Date: Tue, 26 May 2026 08:54:02 +0000
Message-ID:
 <TY3PR01MB11346AC919B1D62FADB18FB20860B2@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20260526084710.3491480-1-claudiu.beznea@kernel.org>
 <20260526084710.3491480-2-claudiu.beznea@kernel.org>
In-Reply-To: <20260526084710.3491480-2-claudiu.beznea@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|TY4PR01MB12649:EE_
x-ms-office365-filtering-correlation-id: 45352396-2ed6-4811-c08b-08debb0455a2
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|18002099003|22082099003|56012099003|38070700021|921020|11063799006|4143699003;
x-microsoft-antispam-message-info:
 dp1NAm8ptMBngnESAAi2MlePRpAmx1VYIXAXWtTCqllvW+o0uGkNBF4f2YuIe9Mh5d5cJIe+ECYSCHo8gbGZBaHB/b9F3621pfOJ6jqSTdOb75+FqE7M6On+mO15KhH+nhRCdl6wz5TDXv1eYcylpYd3d/utHx6OYntGDZVbm/z5b1mB+K9zDMQ+NB3TxajwdYuJ+//CVxUyINEXyEHiOgc5hozjUKbccauFff9nUY6OcxArol2EKc4/SzmuXNziXIlVQZR6OEyuTzsLzBZ3dLjE64zuoFFFMm2xB195x0kT3R0KMzmC66dxpXU9z1HHrP6tcJYm2VSKzz3AjZ6nUpaCgAxT8WAZiKaM/t4zMcwD0SfUFqWtWi8WeWgyLRA35llzuGBDtaGFqYRr2wcBP07FNlJAndmDVenoPlETEi59TpXRIVuylOv1g8IQjiTEdBBL5bbLX7i9rlD2ScdiE/7M0f6WgSwXWFmvJypz5youM8KeqE/UJHsCI2n+qgC1FTNjsBDpC7x2EBlvtgaFk5gNql8jZquCQgUTHyxwEiM8P+PYmsrXy7awHA7j3sLHoIlo71iOsrEt1bttT49jRXMSHhKGqt3TisKiumOq7Vdt0AVZtBqxz7NA3o5dA39qyH5wERiFkgv4bM8oqEfn+AiM/M9XjovGv8nygcEwyr8YuOeUpZ2t+sX79wxNDNdkLa3lRu2Ast7dolkIdbhW/fjg5TbMldL/9xKR/5WbcdjVoD2TES44ub1eprtwBZ8s9ZSpZLbF+o0qrQkJ6G/Fjg==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(18002099003)(22082099003)(56012099003)(38070700021)(921020)(11063799006)(4143699003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?p00W6ldV3b1VHucVV+SsujI3X8IeuCBE4r/5S28zHIvtS2WvetTdV9gwaOuj?=
 =?us-ascii?Q?4WXNZEvTLWKmKrUcG0bTS5Y+s+xdd3TZTZNM+E7ZcOgbRO3ywPU8cFMIXJuu?=
 =?us-ascii?Q?H5bgJJfLUR894UmpxTU56cjExp0680tEUtN+nn8BlINZvNgOS31tmIbNLANn?=
 =?us-ascii?Q?UiC7va8j4WDAF+y7pHF4ORb1gjvQ3E7yyi36v9AJrRGszNknd2oKQS+CjMrK?=
 =?us-ascii?Q?Wd0MGBiRz+Kp2phiwf3iuHLuZee/nehe3wPJSR0TjmjyiHAhC9XB/4n7OP1P?=
 =?us-ascii?Q?gxtUSzUJSeKEN2UH/jWyUI8WykxZ6NIuCLOoqHkejyVdysnnUqTNkiNjR7Kk?=
 =?us-ascii?Q?T6RKp9KU7rubzPH8PlgalW6Vzs8n27jk1sK11cyJMVoBnJ9brc1njhGBkzt7?=
 =?us-ascii?Q?uB2t9ArYPnJjb2KUXeophowUU3EZYSPGQ89j89CxkNB56LniUfPaGWTiURqR?=
 =?us-ascii?Q?bbV7WQclo6kvtm4webAMQqLZ5AMtucNXPq7NByquDKQUuMcjR//6rbuZTEhP?=
 =?us-ascii?Q?j5fq/cWOxdy8Tj1JVz/NthF7Wch9LhZROVVQFDOy1zaLTvFyzkh36yGiK6IR?=
 =?us-ascii?Q?3Y1Um+IuMmHB1EXNHDLm75SkqUG70lcYgtSuB8OIX7m27M9hr4A1/te0lvcw?=
 =?us-ascii?Q?Q/jbLtqtFHWWAhnbqP4i4fhCxpNnRO9Eq5CDzC2oufoqkjrEjAO7fM4PKAGs?=
 =?us-ascii?Q?wknQoSLWimwSXEDyKBzH6LhfQkk8axfBIuFUAKm88palkL8xeVBWPonScRjJ?=
 =?us-ascii?Q?//iIqfBMdWD3UVoHMIHFGR4+eWKnLU9PGamGgnLLKWYoddHU+gxRgMseLGUP?=
 =?us-ascii?Q?mx4CB7bvzO+oSk8ojdCAqUf59KhISB9ixF/hoIQ79HhOQQmzKrcNhD8qFV7z?=
 =?us-ascii?Q?4MJgjxQmTCQRYSU0ugCXqZ9jSLCXuzDsrII/2VGzXoxOiobsNOQH81SZzzMG?=
 =?us-ascii?Q?qcxKZXOwP1oIGgC2/L3j3QkKJM8qo/JOsXFDbdKOlf1kfsphhNJl0YdNldCk?=
 =?us-ascii?Q?jgnfQ7eksg9IqrkgoODXtz5WCaMxsBCIlnUhGqesxXUYQdfeRQHcPT/+PKV6?=
 =?us-ascii?Q?Q/XwrcvV0tN57sda2W/XE/dTpJ8FzVD6Dadn7hKKr0J/NzmsMdWQMxh85Pm+?=
 =?us-ascii?Q?CdVDVrKq9PHcehxH8v4nE7duDk5yJbZc0I8CQlKPBtCBNueV9hSp2FnNEQi5?=
 =?us-ascii?Q?hVA3vETXOGSPrYPNRgbjP+b2nws0xECXBzcYuQWYNhmpkQyD9kYbwB56PwcN?=
 =?us-ascii?Q?I0B6OuQrk4psMn41u+dpGbJHBoV6zKkrY0Kxgq1cdftZHlVLWuxxt0f+CO9L?=
 =?us-ascii?Q?Z5Vf4qC1jwY+iauxyvo/XCv/KwUGWNqsORT9cBYFuKCBH05u/XXsZ7lBENdx?=
 =?us-ascii?Q?tGC13pvLRTh/Y88Drc5KOEP68p9cRMyAtoPF9c70wSq+aBd8y+XWwDVxqHte?=
 =?us-ascii?Q?HUTtn3viMsukXjKLqx8aw134Kt9v3eHe+TJX4OLODNXpMpqzDZUYh0FbOAaP?=
 =?us-ascii?Q?IqVORj+lLlNL6L9Ilspqlfq+RYOJciKycOv3LsK9Vce8JmVxzEaM/ne5UA0I?=
 =?us-ascii?Q?zHctqix2GppPRq9AmZKnA5pbkP33S0FaMVlcknL4LeCSVrjvlb7jxhxndqeQ?=
 =?us-ascii?Q?5bsJPKz7e3W3r5hImIzK7vcHTGlbTzHzIM1v0w/XpXf/6tCsE7pvBtG8G0lf?=
 =?us-ascii?Q?rjDEKuVzyfBfNzAwazD+gDYXM955juKOEG2UwNTxXvg4/dZ01EQBRmnjoXwF?=
 =?us-ascii?Q?Bcif5ZILoQ=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 45352396-2ed6-4811-c08b-08debb0455a2
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 May 2026 08:54:02.4151
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8+W9eEOfertzMeY3EhEp7FXUMw/2mrDJn9RrOMBWEO8vsYZaCF98LQYDuEyAtOtyYIbo/aVsChab7GCnsqB9fPZmFNmh2kzq9sz0Lzo/pxE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB12649
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[renesas.com,none];
	R_DKIM_ALLOW(-0.20)[bp.renesas.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-10916-lists,dmaengine=lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RSPAMD_URIBL_FAIL(0.00)[bp.renesas.com:query timed out];
	URIBL_MULTI_FAIL(0.00)[renesas.com:server fail,TY3PR01MB11346.jpnprd01.prod.outlook.com:server fail,bp.renesas.com:server fail,nxp.com:server fail,sea.lore.kernel.org:server fail];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,perex.cz,suse.com,bp.renesas.com,pengutronix.de,glider.be,renesas.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[biju.das.jz@bp.renesas.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[bp.renesas.com:+];
	NEURAL_HAM(-0.00)[-0.996];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[dmaengine,renesas];
	RSPAMD_EMAILBL_FAIL(0.00)[john.madieu.xa.bp.renesas.com:query timed out];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 3604D5D2E6F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Claudiu,

> -----Original Message-----
> From: Claudiu Beznea <claudiu.beznea@kernel.org>
> Sent: 26 May 2026 09:47
> Subject: [PATCH v6 01/18] dmaengine: sh: rz-dmac: Move interrupt request =
after everything is set up
>=20
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>=20
> Once the interrupt is requested, the interrupt handler may run immediatel=
y.

Do you mean spurious interrupt?

After DMA driver probe only, consumer device can access the DMA handle
right? or am I missing something here?

Cheers,
Biju


Cheers,
Biju

> Since the IRQ handler can access channel->ch_base, which is initialized o=
nly after requesting the IRQ,
> this may lead to invalid memory access.
> Likewise, the IRQ thread may access uninitialized data (the ld_free, ld_q=
ueue, and ld_active lists),
> which may also lead to issues.
>=20
> Request the interrupts only after everything is set up. To keep the error=
 path simpler, use
> dmam_alloc_coherent() instead of dma_alloc_coherent().
>=20
> Fixes: 5000d37042a6 ("dmaengine: sh: Add DMAC driver for RZ/G2L SoC")
> Cc: stable@vger.kernel.org
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> Tested-by: John Madieu <john.madieu.xa@bp.renesas.com>
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> ---
>=20
> Changes in v6:
> - collected tags
>=20
> Changes in v5:
> - none
>=20
> Changes in v4:
> - none, this patch is new
>=20
>  drivers/dma/sh/rz-dmac.c | 88 +++++++++++++++-------------------------
>  1 file changed, 33 insertions(+), 55 deletions(-)
>=20
> diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c index 62=
5ff29024de..9f206a33dcc6
> 100644
> --- a/drivers/dma/sh/rz-dmac.c
> +++ b/drivers/dma/sh/rz-dmac.c
> @@ -981,25 +981,6 @@ static int rz_dmac_chan_probe(struct rz_dmac *dmac,
>  	channel->index =3D index;
>  	channel->mid_rid =3D -EINVAL;
>=20
> -	/* Request the channel interrupt. */
> -	scnprintf(pdev_irqname, sizeof(pdev_irqname), "ch%u", index);
> -	irq =3D platform_get_irq_byname(pdev, pdev_irqname);
> -	if (irq < 0)
> -		return irq;
> -
> -	irqname =3D devm_kasprintf(dmac->dev, GFP_KERNEL, "%s:%u",
> -				 dev_name(dmac->dev), index);
> -	if (!irqname)
> -		return -ENOMEM;
> -
> -	ret =3D devm_request_threaded_irq(dmac->dev, irq, rz_dmac_irq_handler,
> -					rz_dmac_irq_handler_thread, 0,
> -					irqname, channel);
> -	if (ret) {
> -		dev_err(dmac->dev, "failed to request IRQ %u (%d)\n", irq, ret);
> -		return ret;
> -	}
> -
>  	/* Set io base address for each channel */
>  	if (index < 8) {
>  		channel->ch_base =3D dmac->base + CHANNEL_0_7_OFFSET + @@ -1012,9 +993=
,9 @@ static int
> rz_dmac_chan_probe(struct rz_dmac *dmac,
>  	}
>=20
>  	/* Allocate descriptors */
> -	lmdesc =3D dma_alloc_coherent(&pdev->dev,
> -				    sizeof(struct rz_lmdesc) * DMAC_NR_LMDESC,
> -				    &channel->lmdesc.base_dma, GFP_KERNEL);
> +	lmdesc =3D dmam_alloc_coherent(&pdev->dev,
> +				     sizeof(struct rz_lmdesc) * DMAC_NR_LMDESC,
> +				     &channel->lmdesc.base_dma, GFP_KERNEL);
>  	if (!lmdesc) {
>  		dev_err(&pdev->dev, "Can't allocate memory (lmdesc)\n");
>  		return -ENOMEM;
> @@ -1030,7 +1011,24 @@ static int rz_dmac_chan_probe(struct rz_dmac *dmac=
,
>  	INIT_LIST_HEAD(&channel->ld_free);
>  	INIT_LIST_HEAD(&channel->ld_active);
>=20
> -	return 0;
> +	/* Request the channel interrupt. */
> +	scnprintf(pdev_irqname, sizeof(pdev_irqname), "ch%u", index);
> +	irq =3D platform_get_irq_byname(pdev, pdev_irqname);
> +	if (irq < 0)
> +		return irq;
> +
> +	irqname =3D devm_kasprintf(dmac->dev, GFP_KERNEL, "%s:%u",
> +				 dev_name(dmac->dev), index);
> +	if (!irqname)
> +		return -ENOMEM;
> +
> +	ret =3D devm_request_threaded_irq(dmac->dev, irq, rz_dmac_irq_handler,
> +					rz_dmac_irq_handler_thread, 0,
> +					irqname, channel);
> +	if (ret)
> +		dev_err(dmac->dev, "failed to request IRQ %u (%d)\n", irq, ret);
> +
> +	return ret;
>  }
>=20
>  static void rz_dmac_put_device(void *_dev) @@ -1099,7 +1097,6 @@ static =
int rz_dmac_probe(struct
> platform_device *pdev)
>  	const char *irqname =3D "error";
>  	struct dma_device *engine;
>  	struct rz_dmac *dmac;
> -	int channel_num;
>  	int ret;
>  	int irq;
>  	u8 i;
> @@ -1132,18 +1129,6 @@ static int rz_dmac_probe(struct platform_device *p=
dev)
>  			return PTR_ERR(dmac->ext_base);
>  	}
>=20
> -	/* Register interrupt handler for error */
> -	irq =3D platform_get_irq_byname_optional(pdev, irqname);
> -	if (irq > 0) {
> -		ret =3D devm_request_irq(&pdev->dev, irq, rz_dmac_irq_handler, 0,
> -				       irqname, NULL);
> -		if (ret) {
> -			dev_err(&pdev->dev, "failed to request IRQ %u (%d)\n",
> -				irq, ret);
> -			return ret;
> -		}
> -	}
> -
>  	/* Initialize the channels. */
>  	INIT_LIST_HEAD(&dmac->engine.channels);
>=20
> @@ -1169,6 +1154,18 @@ static int rz_dmac_probe(struct platform_device *p=
dev)
>  			goto err;
>  	}
>=20
> +	/* Register interrupt handler for error */
> +	irq =3D platform_get_irq_byname_optional(pdev, irqname);
> +	if (irq > 0) {
> +		ret =3D devm_request_irq(&pdev->dev, irq, rz_dmac_irq_handler, 0,
> +				       irqname, NULL);
> +		if (ret) {
> +			dev_err(&pdev->dev, "failed to request IRQ %u (%d)\n",
> +				irq, ret);
> +			goto err;
> +		}
> +	}
> +
>  	/* Register the DMAC as a DMA provider for DT. */
>  	ret =3D of_dma_controller_register(pdev->dev.of_node, rz_dmac_of_xlate,
>  					 NULL);
> @@ -1210,16 +1207,6 @@ static int rz_dmac_probe(struct platform_device *p=
dev)
>  dma_register_err:
>  	of_dma_controller_free(pdev->dev.of_node);
>  err:
> -	channel_num =3D i ? i - 1 : 0;
> -	for (i =3D 0; i < channel_num; i++) {
> -		struct rz_dmac_chan *channel =3D &dmac->channels[i];
> -
> -		dma_free_coherent(&pdev->dev,
> -				  sizeof(struct rz_lmdesc) * DMAC_NR_LMDESC,
> -				  channel->lmdesc.base,
> -				  channel->lmdesc.base_dma);
> -	}
> -
>  	reset_control_assert(dmac->rstc);
>  err_pm_runtime_put:
>  	pm_runtime_put(&pdev->dev);
> @@ -1232,18 +1219,9 @@ static int rz_dmac_probe(struct platform_device *p=
dev)  static void
> rz_dmac_remove(struct platform_device *pdev)  {
>  	struct rz_dmac *dmac =3D platform_get_drvdata(pdev);
> -	unsigned int i;
>=20
>  	dma_async_device_unregister(&dmac->engine);
>  	of_dma_controller_free(pdev->dev.of_node);
> -	for (i =3D 0; i < dmac->n_channels; i++) {
> -		struct rz_dmac_chan *channel =3D &dmac->channels[i];
> -
> -		dma_free_coherent(&pdev->dev,
> -				  sizeof(struct rz_lmdesc) * DMAC_NR_LMDESC,
> -				  channel->lmdesc.base,
> -				  channel->lmdesc.base_dma);
> -	}
>  	reset_control_assert(dmac->rstc);
>  	pm_runtime_put(&pdev->dev);
>  	pm_runtime_disable(&pdev->dev);
> --
> 2.43.0


