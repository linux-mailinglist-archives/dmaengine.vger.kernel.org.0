Return-Path: <dmaengine+bounces-9682-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GGZLNnO2xWnxAwUAu9opvQ
	(envelope-from <dmaengine+bounces-9682-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 26 Mar 2026 23:42:59 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D63B33CADA
	for <lists+dmaengine@lfdr.de>; Thu, 26 Mar 2026 23:42:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 09869304F337
	for <lists+dmaengine@lfdr.de>; Thu, 26 Mar 2026 22:42:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 166413368A7;
	Thu, 26 Mar 2026 22:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="GVeyRylY"
X-Original-To: dmaengine@vger.kernel.org
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11011038.outbound.protection.outlook.com [52.101.125.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91D88318ED7;
	Thu, 26 Mar 2026 22:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774564976; cv=fail; b=Gqt989I6VvTAWvTZw8+0Qx2/qOPNGiMG/dOb489RQVpOoBaL+5lFoMmzH7w4HQTvlHR6L50SGOvVK0BTE47ABKHi8NjEru9jXf1rsDhm5enzr/cA+oQSaI2DYg7pLxKLHhGYCGF9Ym7GAUgMrxd93CQWeBYWAdGmWczBeBSoeSw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774564976; c=relaxed/simple;
	bh=QxQF6kHDCLQn9kfOQYJWQ9/ElIzrFMc7Hm7s8bwkW10=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FcsLpzoYmzdQgpPajRHHQJ0PC4wEUbm1OECVzp3zVTUzmockvymWbwOzwTi4uq5vH/AlImUsUeaVAOWwm7hdrBR0W/3ErdblBW+x8kQwj5Zm04C5J5izMizk9VXQ6cOsmTbBKljUTNsRQgKlYhTVaH13quBz3IXezGQEjRvv+kU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=GVeyRylY; arc=fail smtp.client-ip=52.101.125.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VvaqeA6nNrrsPnoWEvEprBdzUsQs6F8O6v0Sv1p07ixHWi7FUE+Mn4f35+MdetH2okIL0b1o9JVLX3f6apJY+TBeW/GHHpscATdXpnhFt6FxhkVi/+s4mypmAJmrs3VNpYFIB/cTJMVrk+NkhS3lUiXceRGDvmtlcj7x8ZgiD1HbCX/qE3YqjIoFtAEFN2O8uKirRryi1W8tUBUVBWl7ataGwJ52sDqGQAinJKuMYqtMZ+13tefHKf2tWYxQt2eeH69/+/CxBjngk1xbAMB3oc3ysN1Dqbhwe8k2NHqFxHk2L7l3RR4Fb5MKtrQlqr74gSyUC0XWIul8fCz7ykBNfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QxQF6kHDCLQn9kfOQYJWQ9/ElIzrFMc7Hm7s8bwkW10=;
 b=m1Ix3Fpv//Jrgfv7+ufgfrQYnKWNJJLchqWYm3xG96Qz3Ius4UjlsIEWHedqAYj3VjV5yy7G+lxgyxWBsx9ssbw+bAbdlqWqpDQ/7+F9MBfg2Ufuok1IttMVucu0Ex2+KUvRu7EBaygQRUR5sn55Vdhi7QNHt5hODeGvsCG8MUKTp08GZ/pWKnHYI9CqX3ZhCRM9duaIWGDydeWrYi2x/QbHKqBKtKLgbH0UJ6Yx7JZly3+njAhHpHgrjT61YxkmtQWa3b/3+lXHLUnlxNGD79HADVITl+6hkl2A65w81ZKgc6129x3P5GoDSetLixaA2Ztz1WcQWNwjL+99E80jIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QxQF6kHDCLQn9kfOQYJWQ9/ElIzrFMc7Hm7s8bwkW10=;
 b=GVeyRylYra0efJuCAttJMTVEVzbtdsleq/GGm8oVPxJ+m066tcwE7R/4U6ehKZnxGviCo1W3d3lWMooefSLT3RQDm20ndZ5G0hiJfr6J0JhphGjM7Rmi9tLDC4qsoUhme9d5EFcI44L+SY2Xj/PEYD7u7ZzAZQyi4fhbEBlT7ZY=
Received: from TY6PR01MB17377.jpnprd01.prod.outlook.com (2603:1096:405:35b::6)
 by TYXPR01MB15664.jpnprd01.prod.outlook.com (2603:1096:405:2a1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.22; Thu, 26 Mar
 2026 22:42:49 +0000
Received: from TY6PR01MB17377.jpnprd01.prod.outlook.com
 ([fe80::f373:26d6:86c4:6aa3]) by TY6PR01MB17377.jpnprd01.prod.outlook.com
 ([fe80::f373:26d6:86c4:6aa3%4]) with mapi id 15.20.9745.019; Thu, 26 Mar 2026
 22:42:48 +0000
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
Subject: RE: [PATCH 04/22] dt-bindings: dma: renesas,rz-dmac: Document
 optional DMA ACK cell
Thread-Topic: [PATCH 04/22] dt-bindings: dma: renesas,rz-dmac: Document
 optional DMA ACK cell
Thread-Index: AQHct7jHNqn7t5QHT0asIKa2SX7MdbXA+rgAgABvsOA=
Date: Thu, 26 Mar 2026 22:42:48 +0000
Message-ID:
 <TY6PR01MB1737720136E84FAF590F637C4FF56A@TY6PR01MB17377.jpnprd01.prod.outlook.com>
References: <20260319155334.51278-1-john.madieu.xa@bp.renesas.com>
 <20260319155334.51278-5-john.madieu.xa@bp.renesas.com>
 <CAMuHMdVbP5Bbr9KuxoEb48zUvubT3CN7sC9oVat2NcNWaBwOtQ@mail.gmail.com>
In-Reply-To:
 <CAMuHMdVbP5Bbr9KuxoEb48zUvubT3CN7sC9oVat2NcNWaBwOtQ@mail.gmail.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY6PR01MB17377:EE_|TYXPR01MB15664:EE_
x-ms-office365-filtering-correlation-id: 2fab8071-9754-4fa2-9a48-08de8b8901a9
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700021|56012099003|22082099003|18002099003;
x-microsoft-antispam-message-info:
 EvO6vLAteZ+t7QKl7PTgBup60tuPMAbzIhOR70pBJ20M95AbDmnq1Tkzof+N+U3fvOAAKTywUwY1l27d+6YWLcK/MmWP8TmdgU4qV0KPwEpTeOKUF0XbAOldvYUSYnf/3TxfYLYcLv2Xnw2vddtFnXCB8u4/ppsdVmS5PUbfwgwrMbzI29wX/TSiiTegtQtJufkMjO8WC/WCVgs4qB9zjsBgNO0oMUwKs4rBHNs3ymKS+lJ5maxysk5oCicytLolWfKZ8PkNNPxXwg1H/oGumAmNuagdKcmvB/Og4qCHvSb0pumd6By8oF4FtiDjKYPcvfMCni41zbpvsP0jRuWLi/FdnxQ7g2fDK/jD7fECfCGR40LdcM+QWyN/yqntaGqg8JayPjCB/5Qi8Wlz75CET3Yu2vsu7K8dxRRPmAejvK/yAcRHVN0VdEdv4qM4z0PbTIDp1f0rqANEkaCuGtmk4ZutbdecqVm7EXDmvEsR5XCM5lBGDOxwIyh3vrGcOEUygrHcj/ZBCnjfBquLBi1iINAPqnA0h6OM3tPM9o9yMcDVnbfpFY/qwjzU06qGYUkTzGN1ukRma5mPetsrvEeJPgTCG+HpfbAElco6K33RfIvHui59AnE+A30SOIrBTNxJfKUZb4CvlY6kMdTgo/EeLxwoUO2J5IkegjJM77vknLEqMnoKrLGVeLSHOXcJbk6l6Z/ChKsDDzN0tBGapyZu9STAxYn6yLVk33Fg0+RAT3W5y7oRGzG/yMznA/qYvrSwTVX65aek8da17Jx2Ns5h6LHKGBAV118nYB/N/FsGMQs=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY6PR01MB17377.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700021)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dTVJWlBDSTJCS1VTeEVnZmJnWXJJVk9BWkQvVVV5b0pWSjArbk9ERUE3OVNS?=
 =?utf-8?B?QXBRdU9rSExwOGFtN3hlTUpObVNPOWV4YmMwRFJzUVdWUWtTZzdxa05DZk55?=
 =?utf-8?B?QXF1WEhWWVcwek1wYmFJUmNhUTJFUGk3eGRDbDRsai9pcTJ1akg1emtLZTRm?=
 =?utf-8?B?YW5saTBUMHRBaUVmV3JuQVc1Y0dEdk9LL1JSTHRhOS80dlY0cllLNXY2cmxo?=
 =?utf-8?B?a3RuNm5HY3ZReDNNYkkyK1V1U21xV05TRXBQNjhxTHp5cUliaitjK1FsdzlO?=
 =?utf-8?B?T0tJMVJHQk5ieEhxSWNHRUdTNFliTVhlL0FCRHoxcmcxWGY0eUJBeVoxV2tj?=
 =?utf-8?B?dHkwbm4yZzdJTHhaMWRoVlFsOUZ6bGpPL25nNitkalQ5WEhjOThieE5ETzh6?=
 =?utf-8?B?OHB2SGNYU3FIVWw0WUtZcUFLQUw1NHlMOFRLSERwZEs5RWZLTGcrY1lycWVO?=
 =?utf-8?B?bmE5Z2taUytDMjBXd0tQek5UbHlxVkkvc01wNFhYTHMrckNLVEo4bGhlamNT?=
 =?utf-8?B?VDhJNnFYVmFMMnZ5OEJUdFhEWVVBZ2loaXpObDlLcmNDMU42OE5NNWNCalRN?=
 =?utf-8?B?R3JTd295NzhIUXplSldaQnhiUktCUWlKcmNaSWs4eTZqTkJHUUxVajJnc2dq?=
 =?utf-8?B?TzUzNDVGVHR2M0hmVEZTcmd2aFdOR3NpdFRkcncvWEF6YXJyd0xFVThDRC9r?=
 =?utf-8?B?Qjd2YlVXVURPWkdDU040UGNuY3NyWmtJeW1zNjdnRysxNWZtUWNROStGNlo4?=
 =?utf-8?B?MFlqeDJEdlc5Ny95cks0OHlHM3h1ZVUvS3B0RWNQSDFYdlRVYWFEZmNrZUJR?=
 =?utf-8?B?eGZlLzlJR1U1U0h6K2JKZGJXbEZadUl4YWxmOHZIRXhSMXd4SEhDcjcwUksy?=
 =?utf-8?B?ekxjV2dJMlFUWVFLYVRveDhsU2VCcnBQR2FEZEw3emt3NDg1RzVpbFQxZWh1?=
 =?utf-8?B?Mkk3QzN1b3dCK25GQTE3REZLa3FMcnpiRE15aXJQNEtaMkdONVBBVzA2L0Z0?=
 =?utf-8?B?c0Z4eXdKZEpFc0YzajNhYzJ6NE5uVXdhMkxxOUY4ektrdXNWM2RFSytDT0dY?=
 =?utf-8?B?cHMvWGpGQkhCUGk5TUs2eHFvR1JXKzJYM1RmSStVanE2UWQzbWZtWnZDRllG?=
 =?utf-8?B?dldCR3EvTVlYczVjZTFpT3diUCtjM1NlYTJEVElIZ0FtSFVzVDR2a2k1VlBN?=
 =?utf-8?B?ditzeXd5UllrRGVLbUZ5UkpnQTI1ckwxTko5MEFsbDUxQ21Ha3lHWlhPZXhY?=
 =?utf-8?B?bnlIWHlwS1AzVmlsOHZxc012aUFWOGM2bUJXOVh2TlgvdkVIdmY3cjRoQjhF?=
 =?utf-8?B?K2hBMTk0Qmc0YVo5N0hiOXNOQ2pDRnd6OWtoRmJ5YVIwQk9CNk9iS1Q3dUs0?=
 =?utf-8?B?Yk1uTlRhdytFVTNCcTVmWllaMkIvTWNXM2svZHlBQ1Q0Z2RGSVVpS0daQ0oy?=
 =?utf-8?B?Q1JpVnA4T3hTMUFvTHo5Q1pxNk1XdS9ZeW5vRy82eEtFb1dyd05jVXpGY0wx?=
 =?utf-8?B?YW5yOEZxUWZGLzNoWFlwWSs5UXdlTWErV2NFcjJHZXo0NnZzWGt2NFppdWFS?=
 =?utf-8?B?QVF0eVV3TU1NZ1owK01QRVN2OVExZW15MkhBQ09GbXY5OEVYaElvWllDQ2kx?=
 =?utf-8?B?MDZWbHdEK2lLOHhCaWUzZ3VWczA5RTQxWXVxSDZCZ3ExaXpGdXFIMGtaSWtE?=
 =?utf-8?B?L0lKUml1Y0xHbG1aNDMzMUpna2lBdVI4ZkRUanp5ODJpWXRWY21UN21GQkZo?=
 =?utf-8?B?Ly9FbnZwSzVFaWx3QlJLa1puYnRDL0ZaeEVWc25Od3p1VXZndk5FaTExS0FU?=
 =?utf-8?B?KzFCQXdPY2xzeDBjQk5Gelk0OVpqRDZVN0Vpb2xKa3MxYzRPSFYwYXF1UHhr?=
 =?utf-8?B?MG9reVh4NEVvbUJvRVhFVTlUUXJ3Nk9UUkR3TjdQWStlUmMyOWFHY2gydEJJ?=
 =?utf-8?B?dCtHME00NjcyRXFla1p5enQ5bkZLanZNTmFBbWgvaXgrN0RoRWcydE12NTFx?=
 =?utf-8?B?U2RDakxjclRmeHVoOWE1bEpYeUJxYXgyODBJZ1pqOUlORHVtYUJVOE5wdUwv?=
 =?utf-8?B?YmNQZUo5Yytnc0svR3p6bFpaUFJCVkJveEszdEVwVFRIQytnZFRvVDJJS0N3?=
 =?utf-8?B?ZlAxOFBISXBidFgzS0VCdE5seEtIdTc1S3hWOVBSd1VOYmNkOWFHRHArMXNu?=
 =?utf-8?B?UkgrbTJPUkM1Y08vWGVrZVhUYkdRSi9pZWYzQ3RXNGFNNFVoUFpqUnZ2ZmlX?=
 =?utf-8?B?bGlJTlY3MDJYa0pJRHNuaXJka3dNbEpaQXM4OWwzVWJkVnBFT0JCWEVveW8r?=
 =?utf-8?B?Qi9TQkd1T3ZrY3lpdHhndVBmMnBrRFRTVjdDdDBZZVBCR2FZVFg0VzJVUUQ1?=
 =?utf-8?Q?aNf8AVRo0b6EOT94=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fab8071-9754-4fa2-9a48-08de8b8901a9
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Mar 2026 22:42:48.7637
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9xRNdVJX9Uz/7X57R28FwcSYzYgqECZ7EdnJyPkx7FyNrfIkJxTgLJepMGMUxdOpJAF3H+Nf/T8xKT6Jo3/x7IBCyHJnzozUcGre1sC26Lc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYXPR01MB15664
X-Spamd-Result: default: False [2.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[renesas.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[bp.renesas.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9682-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[27];
	FREEMAIL_CC(0.00)[renesas.com,kernel.org,baylibre.com,gmail.com,perex.cz,suse.com,pengutronix.de,tuxon.dev,bp.renesas.com,vger.kernel.org];
	DKIM_TRACE(0.00)[bp.renesas.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[john.madieu.xa@bp.renesas.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	NEURAL_HAM(-0.00)[-0.999];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[renesas.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0D63B33CADA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

SGkgR2VlcnQsDQoNClRoYW5rcyBmb3IgeW91ciByZXZpZXcuDQoNCj4gLS0tLS1PcmlnaW5hbCBN
ZXNzYWdlLS0tLS0NCj4gRnJvbTogR2VlcnQgVXl0dGVyaG9ldmVuIDxnZWVydEBsaW51eC1tNjhr
Lm9yZz4NCj4gU2VudDogVGh1cnNkYXksIE1hcmNoIDI2LCAyMDI2IDQ6MjggUE0NCj4gVG86IEpv
aG4gTWFkaWV1IDxqb2huLm1hZGlldS54YUBicC5yZW5lc2FzLmNvbT4NCj4gU3ViamVjdDogUmU6
IFtQQVRDSCAwNC8yMl0gZHQtYmluZGluZ3M6IGRtYTogcmVuZXNhcyxyei1kbWFjOiBEb2N1bWVu
dA0KPiBvcHRpb25hbCBETUEgQUNLIGNlbGwNCj4gDQo+IEhpIEpvaG4sDQo+IA0KPiBPbiBUaHUs
IDE5IE1hciAyMDI2IGF0IDE2OjU1LCBKb2huIE1hZGlldSA8am9obi5tYWRpZXUueGFAYnAucmVu
ZXNhcy5jb20+DQo+IHdyb3RlOg0KPiA+IFNvbWUgcGVyaXBoZXJhbHMgb24gUlovVjJILCBSWi9W
Mk4sIGFuZCBSWi9HM0UgU29DcyByZXF1aXJlIGV4cGxpY2l0DQo+ID4gQUNLIHNpZ25hbCByb3V0
aW5nIHRocm91Z2ggdGhlIElDVS4gRG9jdW1lbnQgdGhlIG9wdGlvbmFsIHNlY29uZCBjZWxsDQo+
ID4gaW4gdGhlIERNQSBzcGVjaWZpZXIgZm9yIHNwZWNpZnlpbmcgdGhlIEFDSyBzaWduYWwgbnVt
YmVyLg0KPiA+DQo+ID4gVGhlIGZpcnN0IGNlbGwgcmVtYWlucyB1bmNoYW5nZWQgYW5kIHNwZWNp
ZmllcyB0aGUgZW5jb2RlZCBNSUQvUklEIGFuZA0KPiA+IGNoYW5uZWwgY29uZmlndXJhdGlvbi4g
VGhlIG9wdGlvbmFsIHNlY29uZCBjZWxsIHNwZWNpZmllcyB0aGUgRE1BIEFDSw0KPiA+IHNpZ25h
bCBudW1iZXIgZm9yIHBlcmlwaGVyYWxzIHJlcXVpcmluZyBsZXZlbC1iYXNlZCBoYW5kc2hha2lu
Zy4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEpvaG4gTWFkaWV1IDxqb2huLm1hZGlldS54YUBi
cC5yZW5lc2FzLmNvbT4NCj4gDQo+IFRoYW5rcyBmb3IgeW91ciBwYXRjaCENCj4gDQo+IEp1c3Qg
YSBxdWljayBoZWFkLXVwLCBhcyBJIGhhdmVuJ3QgcmVhZCB0aGUgYWN0dWFsIHNlY2lvbiBpbiB0
aGUNCj4gZG9jdW1lbnRhdGlvbiB5ZXQuDQo+IA0KPiA+IC0tLSBhL0RvY3VtZW50YXRpb24vZGV2
aWNldHJlZS9iaW5kaW5ncy9kbWEvcmVuZXNhcyxyei1kbWFjLnlhbWwNCj4gPiArKysgYi9Eb2N1
bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvZG1hL3JlbmVzYXMscnotZG1hYy55YW1sDQo+
ID4gQEAgLTYzLDE3ICs2MywyNyBAQCBwcm9wZXJ0aWVzOg0KPiA+ICAgICAgICAtIGNvbnN0OiBy
ZWdpc3Rlcg0KPiA+DQo+ID4gICAgJyNkbWEtY2VsbHMnOg0KPiA+IC0gICAgY29uc3Q6IDENCj4g
PiAtICAgIGRlc2NyaXB0aW9uOg0KPiA+ICsgICAgZGVzY3JpcHRpb246IHwNCj4gPiAgICAgICAg
VGhlIGNlbGwgc3BlY2lmaWVzIHRoZSBlbmNvZGVkIE1JRC9SSUQgb3IgdGhlIFJFUSBObyB2YWx1
ZXMgb2YNCj4gPiAgICAgICAgdGhlIERNQUMgcG9ydCBjb25uZWN0ZWQgdG8gdGhlIERNQSBjbGll
bnQgYW5kIHRoZSBzbGF2ZSBjaGFubmVsDQo+ID4gICAgICAgIGNvbmZpZ3VyYXRpb24gcGFyYW1l
dGVycy4NCj4gPiArICAgICAgVXNlIDEgY2VsbCBmb3IgYmFzaWMgRE1BIGNvbmZpZ3VyYXRpb24u
DQo+ID4gKyAgICAgIFVzZSAyIGNlbGxzIHdoZW4gRE1BIEFDSyBzaWduYWwgcm91dGluZyB0aHJv
dWdoIElDVSBpcyByZXF1aXJlZA0KPiA+ICsgICAgICAoUlovVjJILCBSWi9WMk4sIFJaL0czRSBh
dWRpbyBwZXJpcGhlcmFscyBzdWNoIGFzIFNTSVUsIFNQRElGLA0KPiBTUkMsIERWQykuDQo+ID4g
Kw0KPiA+ICsgICAgICBGaXJzdCBjZWxsOg0KPiA+ICAgICAgICBiaXRzWzA6OV0gLSBTcGVjaWZp
ZXMgdGhlIE1JRC9SSUQgb3IgdGhlIFJFUSBObyB2YWx1ZQ0KPiA+ICAgICAgICBiaXRbMTBdIC0g
U3BlY2lmaWVzIERNQSByZXF1ZXN0IGhpZ2ggZW5hYmxlIChISUVOKQ0KPiA+ICAgICAgICBiaXRb
MTFdIC0gU3BlY2lmaWVzIERNQSByZXF1ZXN0IGRldGVjdGlvbiB0eXBlIChMVkwpDQo+ID4gICAg
ICAgIGJpdHNbMTI6MTRdIC0gU3BlY2lmaWVzIERNQUFDSyBvdXRwdXQgbW9kZSAoQU0pDQo+ID4g
ICAgICAgIGJpdFsxNV0gLSBTcGVjaWZpZXMgVHJhbnNmZXIgTW9kZSAoVE0pDQo+ID4NCj4gPiAr
ICAgICAgU2Vjb25kIGNlbGwgKG9wdGlvbmFsLCB3aGVuICNkbWEtY2VsbHMgPSA8Mj4pOg0KPiA+
ICsgICAgICBiaXRzWzY6MF0gLSBETUEgYWNrbm93bGVkZ2Ugc2lnbmFsIG51bWJlciAoZnJvbSBJ
Q1UgQUNLIHRhYmxlKSwNCj4gPiArICAgICAgICAgICAgICAgICAgd2hlcmUgMCBpcyBhIHZhbGlk
IHNpZ25hbCBudW1iZXIuDQo+ID4gKyAgICAgICAgICAgICAgICAgIFJlcXVpcmVkIGZvciBwZXJp
cGhlcmFscyB1c2luZyBsZXZlbC1iYXNlZCBETUENCj4gPiArICAgICAgICAgICAgICAgICAgaGFu
ZHNoYWtpbmcgKFNTSVUsIFNQRElGLCBSU1BJLCBTQ1UsIEFEQywgUERNKS4NCj4gDQo+IEhvdyBk
byB5b3UgZXhwZWN0IHRoaXMgdG8gd29yaz8gI2RtYS1jZWxscyBhcHBsaWVzIHRvIGFsbCBETUEg
Y29uc3VtZXJzIG9mDQo+IHRoaXMgcHJvdmlkZXIsIGFuZCB0aGVzZSBTb0NzIGFscmVhZHkgaGF2
ZSBETUEgdXNlcnMgcmVseWluZyBvbiAjZG1hLWNlbGxzDQo+IGJlaW5nIG9uZS4NCg0KSW5kZWVk
Lg0KDQo+IEluIGFkZGl0aW9uLCB5b3UgY2Fubm90IGhhdmUgb3B0aW9uYWwgY2VsbHM6IGlmICNk
bWEtY2VsbHMgaXMgdHdvLCB0aGVuDQo+IGFsbCBjb25zdW1lcnMgbXVzdCBzdXBwbHkgdHdvIGNl
bGxzIChvZiBjb3Vyc2Ugd2UgY291bGQgc3dpdGNoIGFsbCBvZiB0aGVtDQo+IHRvIHR3byBjZWxs
cyBhdCBvbmNlKS4gIEhvd2V2ZXIsIGFzIHplcm8gaXMgYSB2YWxpZCBzaWduYWwgbnVtYmVyLCB3
ZQ0KPiBjYW5ub3QgdXNlIHRoYXQgYXMgYSBkdW1teSB3aGVuIG5vIERNQSBhY2tub3dsZWRnZSBz
aWduYWwgbnVtYmVyIGlzIG5lZWRlZA0KPiAod2UgY291bGQgdXNlIGUuZy4gMHhmZmZmZmZmZiBp
bnN0ZWFkKS4NCj4gDQo+IElzIHRoZXJlIGFueSBvdGhlciB3YXkgdG8gcHJvdmlkZSB0aGlzIGlu
Zm9ybWF0aW9uPw0KPiBFLmcuIGNvdWxkIHdlIGhhdmUgYSB0YWJsZSBpbiB0aGUgZHJpdmVyIHRo
YXQgY29udGFpbnMgdGhpcyBpbmZvIGZvciB0aGUNCj4gKHByZXN1bWFibHkgZmV3KSBNSUQvUklE
IHZhbHVlcyB0aGF0IG5lZWQgaXQ/DQo+IA0KDQpUaGVyZSBhcmUgYWN0dWFsbHkgODkgZW50cmll
cywgYW5kIEkgY291bGQgaWRlbnRpZnkgMyBwZXJpcGhlcmFsDQpncm91cCB3aXRoIGxpbmVhciBB
Q0sgYXNzaWdubWVudHMuIFRodXMgaW5zdGVhZCBvZiBzdGF0aWMgYXJyYXkNCndlIHdvdWxkIGdl
dCBhIHNpbXBsZSBmdW5jdGlvbiBoYW5kbGluZyAzIHJlcV9ubyByYW5nZXMuDQoNClNvbWV0aGlu
ZyBsaWtlOg0KDQovKg0KICogTWFwIE1JRC9SSUQgcmVxdWVzdCBudW1iZXIgKGJpdHNbMDo5XSBv
ZiBETUEgc3BlY2lmaWVyKSB0byB0aGUgSUNVDQogKiBETUEgQUNLIHNpZ25hbCBudW1iZXIsIHBl
ciBSWi9HM0UgaGFyZHdhcmUgbWFudWFsIFRhYmxlIDQuNi0yOC4NCiAqDQogKiBUaHJlZSBwZXJp
cGhlcmFsIGdyb3VwcyB3aXRoIGxpbmVhciBBQ0sgYXNzaWdubWVudDoNCiAqDQogKiAgIFBGQyBl
eHRlcm5hbCBETUEgcGlucyAoRFJFUTAuLkRSRVE0KToNCiAqICAgICByZXFfbm8gMHgwMDAtMHgw
MDQgLT4gQUNLIE5vLiA4NC04OCAgKGFjayA9IHJlcV9ubyArIDg0KQ0KICoNCiAqICAgU1NJVSBC
VVNJRnMgKHNzaXAwMC4uc3NpcDkzKToNCiAqICAgICByZXFfbm8gMHgxNjEtMHgxOTggLT4gQUNL
IE5vLiAyOC04MyAgKGFjayA9IHJlcV9ubyAtIDB4MTQ1KQ0KICoNCiAqICAgU1BESUYgKENIMC4u
Q0gyKSArIFNDVSBTUkMgKHNyMC4uc3I5KSArIERWQyAoY21kMC4uY21kMSk6DQogKiAgICAgcmVx
X25vIDB4MTk5LTB4MWI0IC0+IEFDSyBOby4gMC0yNyAgIChhY2sgPSByZXFfbm8gLSAweDE5OSkN
CiAqLw0Kc3RhdGljIGludCByel9kbWFjX2dldF9hY2tfbm8oY29uc3Qgc3RydWN0IHJ6X2RtYWNf
aW5mbyAqaW5mbywgdTE2IHJlcV9ubykNCnsNCglpZiAoIWluZm8tPmljdV9yZWdpc3Rlcl9kbWFf
YWNrKQ0KCQlyZXR1cm4gLUVJTlZBTDsNCg0KCS8qIFBGQyBleHRlcm5hbCBETUEgcGluczogQUNL
IE5vLiA4NC04OCAqLw0KCWlmIChyZXFfbm8gPD0gMHgwMDQpDQoJCXJldHVybiByZXFfbm8gKyA4
NDsNCg0KCS8qIFNTSVUgQlVTSUZzOiBBQ0sgTm8uIDI4LTgzICovDQoJaWYgKHJlcV9ubyA+PSAw
eDE2MSAmJiByZXFfbm8gPD0gMHgxOTgpDQoJCXJldHVybiByZXFfbm8gLSAweDE0NTsNCg0KCS8q
IFNQRElGICsgU0NVIFNSQyArIERWQzogQUNLIE5vLiAwLTI3ICovDQoJaWYgKHJlcV9ubyA+PSAw
eDE5OSAmJiByZXFfbm8gPD0gMHgxYjQpDQoJCXJldHVybiByZXFfbm8gLSAweDE5OTsNCg0KCXJl
dHVybiAtRUlOVkFMOw0KfQ0KDQpJJ2xsIHRoZW4gZHJvcCB0aGUgY3VycmVudCBwYXRjaCBhbmQg
dXBkYXRlIHRoZSByZXFfbm8tcmVsYXRlZCBwYXRjaA0Kd2l0aCBzb21ldGhpbmcgbGlrZSB0aGUg
YWJvdmUuDQoNCldoYXQgZG8geW91IHRoaW5rID8NCg0KUmVnYXJkcywNCkpvaG4uDQoNCj4gPiAr
DQo+ID4gICAgZG1hLWNoYW5uZWxzOg0KPiA+ICAgICAgY29uc3Q6IDE2DQo+ID4NCj4gPiBAQCAt
MjEyLDYgKzIyMiwyMCBAQCBhbGxPZjoNCj4gPiAgICAgICAgICAtIHJlbmVzYXMsaWN1DQo+ID4g
ICAgICAgICAgLSByZXNldHMNCj4gPg0KPiA+ICsgIC0gaWY6DQo+ID4gKyAgICAgIHByb3BlcnRp
ZXM6DQo+ID4gKyAgICAgICAgY29tcGF0aWJsZToNCj4gPiArICAgICAgICAgIGNvbnRhaW5zOg0K
PiA+ICsgICAgICAgICAgICBjb25zdDogcmVuZXNhcyxyOWEwOWcwNTctZG1hYw0KPiA+ICsgICAg
dGhlbjoNCj4gPiArICAgICAgcHJvcGVydGllczoNCj4gPiArICAgICAgICAnI2RtYS1jZWxscyc6
DQo+ID4gKyAgICAgICAgICBlbnVtOiBbMSwgMl0NCj4gPiArICAgIGVsc2U6DQo+ID4gKyAgICAg
IHByb3BlcnRpZXM6DQo+ID4gKyAgICAgICAgJyNkbWEtY2VsbHMnOg0KPiA+ICsgICAgICAgICAg
Y29uc3Q6IDENCj4gPiArDQo+ID4gICAgLSBpZjoNCj4gPiAgICAgICAgcHJvcGVydGllczoNCj4g
PiAgICAgICAgICBjb21wYXRpYmxlOg0KPiANCj4gR3J7b2V0amUsZWV0aW5nfXMsDQo+IA0KPiAg
ICAgICAgICAgICAgICAgICAgICAgICBHZWVydA0KPiANCj4gLS0NCj4gR2VlcnQgVXl0dGVyaG9l
dmVuIC0tIFRoZXJlJ3MgbG90cyBvZiBMaW51eCBiZXlvbmQgaWEzMiAtLSBnZWVydEBsaW51eC0N
Cj4gbTY4ay5vcmcNCj4gDQo+IEluIHBlcnNvbmFsIGNvbnZlcnNhdGlvbnMgd2l0aCB0ZWNobmlj
YWwgcGVvcGxlLCBJIGNhbGwgbXlzZWxmIGEgaGFja2VyLg0KPiBCdXQgd2hlbiBJJ20gdGFsa2lu
ZyB0byBqb3VybmFsaXN0cyBJIGp1c3Qgc2F5ICJwcm9ncmFtbWVyIiBvciBzb21ldGhpbmcNCj4g
bGlrZSB0aGF0Lg0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIC0tIExpbnVzIFRv
cnZhbGRzDQo=

