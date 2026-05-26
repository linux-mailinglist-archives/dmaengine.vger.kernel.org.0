Return-Path: <dmaengine+bounces-10929-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aKazEAVvFWojVAcAu9opvQ
	(envelope-from <dmaengine+bounces-10929-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 26 May 2026 11:59:33 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 39AF85D3D6E
	for <lists+dmaengine@lfdr.de>; Tue, 26 May 2026 11:59:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8AE6B3014B24
	for <lists+dmaengine@lfdr.de>; Tue, 26 May 2026 09:51:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF7663CC7FB;
	Tue, 26 May 2026 09:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="ixf4SD8J"
X-Original-To: dmaengine@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010014.outbound.protection.outlook.com [52.101.229.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 691803BB136;
	Tue, 26 May 2026 09:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779789075; cv=fail; b=EiT3xbAc9Lflm+uMKuQDYUJKP639IXWbEvvfHN3widvCENbskyDudnO3+lhR9sMCbR0oS7ob7iHh8qMZumN0XdCfooLfJ/S+1fANi7Gd3JehDU2IfOfTNZpj3pM/XUl0e2dNJCpp2QV05pEvZK2OkY7YOgsYvhUCoaV8LvzVpew=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779789075; c=relaxed/simple;
	bh=rEb1W/HeLgibp67tJ4bd1+NVpz9Wdwe3rzwWm5ALqkg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TqtWUUKSq7C2En+bazYsNrSe70C5bgw/RC/ochHTxMmqzRZbGiIZKTX0DlAvKx9YjQwTHKGgPbJYR4EJr1pTJnQkteAPPlR5nCByV8UCNMfK8+FT1uaaYOqpgCJMqLfMBJEwGxVhL4BOgAAMmkhUsBAlgDO4QRBXfjxfKBPf6+o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=ixf4SD8J; arc=fail smtp.client-ip=52.101.229.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fwsa4bz6PjjcW4ii9NvtyvxKgJeSQuODw1JBhYJNTePBjMQQlPfNH08ncDGRVV9UYpk0RHfSOB/2+x2YIIRQgfDR0mHRb+53jgR7F29Qv6Cf0FF9jJt7cSW6g/sEvIvsakTR+9Dsb/L/cBLei0yECn5QOy0MBoKcPfjMZymYKlB1jMHnHiG6rV+a1juJfB96CMSjJMC2XZi9qcX4b0OQTS3gCbWdMaVJRXXQAFTRzCP1k6bWC5Y/9pjCesBqIagcmzjoL2Nw33pG+jhThdEoUQ/ncqh5eCvvivudFWNWy2dqh3XW6LP7FFi00ehxGgLtFmqxUchYRqiKvW5WMRojLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rEb1W/HeLgibp67tJ4bd1+NVpz9Wdwe3rzwWm5ALqkg=;
 b=Vwp1O6xJmata4gl35pNEYItGrFN+XANHcONxXc9Za94IY8rt90XSNyPINsNfVuERDdLW7Hcz3DxglZPDjamaReWP6+9HcScH27XdKCjxwNQCzYDZnX0HUg5e28zyAQas1gxt6ozgKzWj9pMYDbm3/Hwp+5EETQMiV+hqI5fKSVVvcepJ3A2xgw0H1EuRXeJy268vxpM+j76rCvyptOiqTKsHwg001BZgXzdRNtBj5DQa7OQG9ta7gwKXaKw3td2McqrcX0SfxzwRhoXvHfECj2rxHgR2dmm/YhAQQARme7wonsCUXsA+udowFlMeufeLJhV5EK9WCG9qTfoYkfKwxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rEb1W/HeLgibp67tJ4bd1+NVpz9Wdwe3rzwWm5ALqkg=;
 b=ixf4SD8JRz7SzqwIN1iDlWUqQxAJjjC3swB7z5njDOzmVwvLzHYK0JFD9yfWj5aVyKFya20YwR7FP54qwlW+JBfGmL60iuioF9H6BEWSa6qsCbffDd41Nh4hW1NBwrsEtfxzfMjBp/ieSwpxFlawA4SndptjxNRuQJZM2fDIHE0=
Received: from TYCPR01MB11332.jpnprd01.prod.outlook.com (2603:1096:400:3c0::7)
 by TYCPR01MB10667.jpnprd01.prod.outlook.com (2603:1096:400:294::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.20; Tue, 26 May
 2026 09:51:07 +0000
Received: from TYCPR01MB11332.jpnprd01.prod.outlook.com
 ([fe80::2511:10cd:e497:4d97]) by TYCPR01MB11332.jpnprd01.prod.outlook.com
 ([fe80::2511:10cd:e497:4d97%6]) with mapi id 15.21.0048.019; Tue, 26 May 2026
 09:51:00 +0000
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
Thread-Index: AQHc7OxJ+K5vYSqOKUeeUPNEYC8zxrYf/50wgAAPWgCAAAC1wA==
Date: Tue, 26 May 2026 09:51:00 +0000
Message-ID:
 <TYCPR01MB1133214647B09C658AC96A4D9860B2@TYCPR01MB11332.jpnprd01.prod.outlook.com>
References: <20260526084710.3491480-1-claudiu.beznea@kernel.org>
 <20260526084710.3491480-2-claudiu.beznea@kernel.org>
 <TY3PR01MB11346AC919B1D62FADB18FB20860B2@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <8dcf50ee-94b7-4b27-895d-2448eb772c08@kernel.org>
In-Reply-To: <8dcf50ee-94b7-4b27-895d-2448eb772c08@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB11332:EE_|TYCPR01MB10667:EE_
x-ms-office365-filtering-correlation-id: 86731418-f8f6-4260-840f-08debb0c4ac3
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|56012099003|22082099003|18002099003|921020|38070700021|4143699003|6133799003|11063799006;
x-microsoft-antispam-message-info:
 qQG+N2juRpjVzXlTOV1gsYlH1Z38XGUC0vGRP0h1D2yLpgVWAJBI3vo5t4vM4OUZsRNjAeVpaMcIy+ybMeTRaeHBamrxC4i58gnDcuTx2NUIxVLiDJMuXteDqoI6xw76sACHnNPJUeuwx+r52/RZyNAN5BY1CwWtVpLQYgPVjzIGCt+T7NqGgqCTNHhwY5pd+SuCpeK8ANUnzvDTExrLM4U0mfzQkaaxn+uULwr3AB5r2jcWa7uKxUTvtf0Zz1tBnxNbfer72M3KU0Xw8VChwMaW0PCZPNUKQkDaL0lYsy+CyCrFBsrd+M3SZeLQizxabHZrZ7vQC0JEaPmPMW05U2rVIoelI34Ha/yBZBdvWIE3E+qhsY6g5arn2VWgVdVY+O5WOzPhgY8KZa9dbwkuRGfzXpOz8GJ6YsYH/8H41F0BFr/S+2CN9Q2ubLIGiMvVMo8NcL9MEW/MreyEB8Y2EtNSnDc6NDcYWMcMnwJsu+nwKGrwGfDEZALCG9J4rZksi+3LeE7eq4nI2b2aDjPxFKwTiUHMmaKsWXgIkgMrp52P9dHVbrWMxiOYxwkRGlYhuPzrZ9RV1WsAukYyHAnZIjVh/RnvBwBgSKUa/9PWbbD2qP6dh30CLxiuR5uUXm7Xiy+fEvZSgZJgZ8x5b5mo5oxRaGWse+Df4ctoxR4qhWhmNk4o4LmUoN0mIlowGDt+VzJQHo6tA1EAq4o4GdNNYcyGtPoY2An0mk/5gTTNEt8RJtzcy5XoREeme/PQgu/06bbc+3ib/JLW5G3r6VgalQ==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11332.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(56012099003)(22082099003)(18002099003)(921020)(38070700021)(4143699003)(6133799003)(11063799006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UzdITUVNT1R2OFNmOHFGeS9BajJobGlBWG5Ra2drT1BRVEVNYWtiVDAreDVF?=
 =?utf-8?B?NjJwUzlyc1J5VXg5eXVkSy90RW1kR2NSb3kvTDRKY1pGd3RQSFJjWHZaN291?=
 =?utf-8?B?K0tyWFY1SjFZWWNDMEw5dVhNcmFRMytnckVMN1pYNUlleUZGeXZORis0S0po?=
 =?utf-8?B?UzlKVzd4RXpkYm9ZdUlVVEs1NUc2UVI2Y1M0WXNraG1jL2hUOGRGSjA5cXJU?=
 =?utf-8?B?Q0E3bXZ4cTNpWHBZZDJiZFluUjdQdTFDVWFPaHFMeExyalJVeHZLZ0JjTU9F?=
 =?utf-8?B?ZEdWS0FDRC96Tm91YWtXYjZoVi9JMVJ1Z25CQ0F1OGNBOE9KUlFsUVErMjE1?=
 =?utf-8?B?dDVVb3NQRXlxcDhjRnVOZ1hTeHczWU15MmczT3VRK0tZRGxsT0lsWnQ2dWRW?=
 =?utf-8?B?bU9FWUNjY1l0M003TitYOFRTQ0ZkYVBUZXgzMkpQbm1QVEdqbTFkOVJ2cGxW?=
 =?utf-8?B?eUIwOCttb2VKWkYzREdBUk90ZXZQOEVVZzRrZ0NVS0NrWWh0WDRhQXp1SktL?=
 =?utf-8?B?Vk40M3psa0hQelJPYjMyMnp1MWhMNUVQa2ZOeUJobEtZeWRzSmxSV01YK0RJ?=
 =?utf-8?B?WUdTOHhnMER2eThKNTRmTzhzNVJIUDVqYVZwdjllSkZ5KzdXYlh2QURPRmpa?=
 =?utf-8?B?WlF0ZnJGOFN2cW1idm1qcEREVnBLR0Q1dHFubFlrUjdTWU9BWVFiTC9hQ0ZH?=
 =?utf-8?B?QU9oRVpJQW5VU0dJa1drYU8wWnRUSGI2WkVQMEJwR0xoamZLSGNraXBwRnZK?=
 =?utf-8?B?c2N1RDEwSkNNNVZnZmZDNFRsemp0SHc3b3NzbTR0TEN0b1JnZnZrNFdsSmNq?=
 =?utf-8?B?MGhwMlZFbUwzNUVpalg4dXJJMEdSZ3ZFbVBJeERLb2hvQUxVWW50NGpUdDFW?=
 =?utf-8?B?R3YwOHVpNm5sRklKOHBHdjdDZWNqdXRSdTlDdWJJYk1OMDJ3aE9Tb3JSMWxV?=
 =?utf-8?B?VkhLeXlKM1NwUXJMbUl6WmpjdmMzSFNPamdYc0Y0ZFZJUVZaa1BZdVU3NVVG?=
 =?utf-8?B?OE02SXpPbzQ3eU02NmZMUmFrZGdRdTJoMkNZcnNRR0RFa3B2RXFDeExvMkUw?=
 =?utf-8?B?N3Y3NW14NVRRdFVYY0ltdDFsQVVpdUlOZEtzemVmWFVzT0hmZWpBblJsS1Rx?=
 =?utf-8?B?aWY4TGx4cVVsUFJTcG43YnVsRFQvZ0c3L3BmdFhjc3gyMko1NUc4OEhzRTRw?=
 =?utf-8?B?aDNwK1VkM2h1cnZzb2hzdDFjT2ozTmFveDM5WTlCd1BvZS9vZUNoaGY5bTdp?=
 =?utf-8?B?T2VXZUlLOGhPR3FBbS9mdFFkcW1pNVA0VUJzOVZWZFRLKzdvWnRmbU52anhx?=
 =?utf-8?B?d05zb3ArdEpLbnd2Tmtzbkhuc3hBdGFuRTJhQnRQTnNuS2djbFlSb0puTEhw?=
 =?utf-8?B?RlAxaUhzS3k3MUxSbGg4M1haL2hocmo2ZmhVQVYyMVJDU2hRR3R6N08zeXcr?=
 =?utf-8?B?dlN5d3BOTk5HMXhUK3ZiV1h2Vm9BZ2F6RWZudDN5RGthZlpKUXc5TmtqRlZv?=
 =?utf-8?B?dWo0ek0zTlEyVjY4Q0dpaFVuODNURnMzVkxLR2lLM2FsQjJyaE9YSzRVbEsv?=
 =?utf-8?B?UmVoenpLUmhsU1hTbG5IZ3FlL1hxTjIwbFZmZmxMWnJyN1ZIRVMxRWl4MndE?=
 =?utf-8?B?cUxvTVlFWkJvL1ZsMzkreE1QdXNzWnZuQStzUXRvcGFVVERRc3o4VEw1bGNo?=
 =?utf-8?B?akJObk4xREh4RnpnUHVkWWlVR0FnVUNLZHRLYUZybGN6Mm9tOFZwQ0NmcFdE?=
 =?utf-8?B?NElsY24yejVKNmxReGNGanlUdDRKSWtYaWRTUnc3SXA0eFFlb2gwc0FDc241?=
 =?utf-8?B?K0xKN0dUZU9UWkx5VFBFeTQvSEV5ZStNNUVNcnlQYWtxRmpYQnJqTlhUaWRM?=
 =?utf-8?B?eWp4Nlo1dlhQeFkzdDUwbG15cDkrUXg3NUk5dHBiN1FkaGcvc3ZzbTVpM2c3?=
 =?utf-8?B?ZkI0S0w1NHpHZ2tVVFp1Zk9mY1JweTU1VU1EMG5tU3IyRE02ejRNbmxyUmZL?=
 =?utf-8?B?RU9QckZURWtZVVQwQ0gyS09lcVNYaVNWWTR5ZWwwbGhKSG5QeFdjTEE1cGdJ?=
 =?utf-8?B?YUp6Yk1lOFFiMW4zUGwyeWI5aWVnbjZ0THZOYkJ0UllidlNnWXdhbGszS2tV?=
 =?utf-8?B?M200Z3ZkNms3Y2VuRjJoeEJCUDJrZnNyeVNWWk0rem9mdFpHWmZ2Ukl2ZEZV?=
 =?utf-8?B?SGNkOFgwZHE3WkFSQUFJOTMvYXZEc05CaVFCWG95NXV2dlZic2NIV0F5cHM4?=
 =?utf-8?B?eTVSckVNbTJYRklyZjJWMTljOExITXRQcFk3ZkZ3bmdoY3BMWFJteTFYZ2tu?=
 =?utf-8?B?MnNWeWh2OHgvV3RFeEJYYjBxQTl6UGVGZ3BPaXFJR2c2aFVMblQ3dz09?=
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
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11332.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86731418-f8f6-4260-840f-08debb0c4ac3
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 May 2026 09:51:00.0910
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: axGISv0ML0xLc5AhlJIr46VsyQSmpZfejmFr4K6vQHFV8BNLXHLfwFieqdx536ZydUM4fEMQSrAEJ2ZUY8NzAAi6LLmqYxSTeKHZDy5uUMk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB10667
X-Spamd-Result: default: False [2.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[renesas.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[bp.renesas.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10929-lists,dmaengine=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[21];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,perex.cz,suse.com,bp.renesas.com,pengutronix.de,glider.be,renesas.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[bp.renesas.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[biju.das.jz@bp.renesas.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[dmaengine,renesas];
	NEURAL_SPAM(0.00)[0.528];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[TYCPR01MB11332.jpnprd01.prod.outlook.com:mid,renesas.com:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,bp.renesas.com:dkim]
X-Rspamd-Queue-Id: 39AF85D3D6E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

SGkgQ2xhdWRpdSwNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBDbGF1
ZGl1IEJlem5lYSA8Y2xhdWRpdS5iZXpuZWFAa2VybmVsLm9yZz4NCj4gU2VudDogMjYgTWF5IDIw
MjYgMTA6NDYNCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2NiAwMS8xOF0gZG1hZW5naW5lOiBzaDog
cnotZG1hYzogTW92ZSBpbnRlcnJ1cHQgcmVxdWVzdCBhZnRlciBldmVyeXRoaW5nIGlzIHNldA0K
PiB1cA0KPiANCj4gDQo+IA0KPiBPbiA1LzI2LzI2IDExOjU0LCBCaWp1IERhcyB3cm90ZToNCj4g
PiBIaSBDbGF1ZGl1LA0KPiA+DQo+ID4+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4+
IEZyb206IENsYXVkaXUgQmV6bmVhIDxjbGF1ZGl1LmJlem5lYUBrZXJuZWwub3JnPg0KPiA+PiBT
ZW50OiAyNiBNYXkgMjAyNiAwOTo0Nw0KPiA+PiBTdWJqZWN0OiBbUEFUQ0ggdjYgMDEvMThdIGRt
YWVuZ2luZTogc2g6IHJ6LWRtYWM6IE1vdmUgaW50ZXJydXB0DQo+ID4+IHJlcXVlc3QgYWZ0ZXIg
ZXZlcnl0aGluZyBpcyBzZXQgdXANCj4gPj4NCj4gPj4gRnJvbTogQ2xhdWRpdSBCZXpuZWEgPGNs
YXVkaXUuYmV6bmVhLnVqQGJwLnJlbmVzYXMuY29tPg0KPiA+Pg0KPiA+PiBPbmNlIHRoZSBpbnRl
cnJ1cHQgaXMgcmVxdWVzdGVkLCB0aGUgaW50ZXJydXB0IGhhbmRsZXIgbWF5IHJ1biBpbW1lZGlh
dGVseS4NCj4gPg0KPiA+IERvIHlvdSBtZWFuIHNwdXJpb3VzIGludGVycnVwdD8NCj4gPg0KPiA+
IEFmdGVyIERNQSBkcml2ZXIgcHJvYmUgb25seSwgY29uc3VtZXIgZGV2aWNlIGNhbiBhY2Nlc3Mg
dGhlIERNQSBoYW5kbGUNCj4gPiByaWdodD8gb3IgYW0gSSBtaXNzaW5nIHNvbWV0aGluZyBoZXJl
Pw0KPiANCj4gSW4gdGhlb3J5IHRoZXJlIGNvdWxkIGJlIHBlbmRpbmcgaW50ZXJydXB0cyBub3Qg
eWV0IHNlcnZlZCAoZS5nLiBkdWUgdG8gdGhlIHByZXZpb3VzIHVzYWdlIG9mIHRoZQ0KPiBjb250
cm9sbGVyLCBIVyBiZWhhdmlvciwgZXRjKS4gVGhvc2UgY291bGQgdHJpZ2dlciB0aGUgZXhlY3V0
aW9uIG9mIHRoZSBJUlEgaGFuZGxlciBvbmNlIHRoZSBpbnRlcnJ1cHQNCj4gaXMgcmVxdWVzdGVk
Lg0KDQpZb3UgbWVhbiBETUEgY29uc3VtZXJzIGNvbmZpZ3VyZWQgYnkgYm9vdGxvYWRlciBhbmQg
bGludXggcHJvYmluZyB0aGUgRE1BIGRyaXZlciBjYW4NCnRyaWdnZXIgSVJRPyANCg0KQ2hlZXJz
LA0KQmlqdQ0K

