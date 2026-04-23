Return-Path: <dmaengine+bounces-10088-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EC9nO9Db6WmNlwIAu9opvQ
	(envelope-from <dmaengine+bounces-10088-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 23 Apr 2026 10:44:00 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9551B44EB54
	for <lists+dmaengine@lfdr.de>; Thu, 23 Apr 2026 10:44:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8ABAD301DAFF
	for <lists+dmaengine@lfdr.de>; Thu, 23 Apr 2026 08:43:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE8C33DEAE3;
	Thu, 23 Apr 2026 08:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="v4N7Vg0o"
X-Original-To: dmaengine@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010014.outbound.protection.outlook.com [52.101.229.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A50636492A;
	Thu, 23 Apr 2026 08:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776933784; cv=fail; b=IkZsaWOg6NFOFwhUwmsEz2q2JN0HpeyInvsJIg44vwRi/gXUe5Uqnoxc/i9lEcr6jrra7UKKOUrtoYYrcPTlub+mhRNWqZrShTfOtzKYah5viA4RuHXjFFw/c533jOqF1d5e5bM7xfL+7PtIvY8BkYQJUalP78cP3toXfr0xWpU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776933784; c=relaxed/simple;
	bh=ce5YnD6Dd8m0lnLI6wFKhE9uW2udocLpK6owIFj4+kM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MFUHYLWHyNJr4oke1Cdx9qy14V6fwcC8deUhD2uV4QN7crOJyvq6LtcYBP491+QhfeTsnU+5C/ZmbfNJH9ph4uArz0t68cRA2qj8FAUF4CNpRsL9+w9bvBbHdq6ZyYGqRNSgM1dZ2q758cenTf++qhk8U5RNYwh4AOtUpuIF7Bs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=v4N7Vg0o; arc=fail smtp.client-ip=52.101.229.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vMz/vEf05h6uU4QdT+2Ifjfe4wi5fLfg5VN8Q+zV0NCOCyznjokZiRD6z7zQSY6JRaWuh4M6duYRaqjjJIuNyRLpBRICANV3ebMs8+ng1XvJaIjdDfphCcdimDBNAb4ZbrkrkALZjF8+O6mMWbBzn7B/5Qs9+0CGPEo10v/JDJ0lXEN7OPjBFyoayeWm5+i5Vfr5v9yo/DhnLUNJJ4XTu+FC2dkuhdH4bIWGPJyfRPro5GTdP/tu2O4fqicAxDdZ0t6xaPB5r2aVdROI5waWUBpnYnE1zAeZjnNbfyUb6CJtubv+NudWEv450ru7puDoL2QJDVeWfpVTQJAkT+saWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vJfVin2w08yklHKOlEqd6NWTobx8Nr8JimQ1fpHxfdU=;
 b=c0hoBTx5ZbQSUQifFNPZqjquZfmoSzdJUZZhETHBjyjS38blakVdqbu0pTEQVAKZpnzHWRDJf0Y3lqi2+J//A1bBNgOlJnJJrLyHxX7qJrsy73Yfg/zq/6VKMYOGGecpKm6d49oad8uiSyDRh0C1WeXc5QLN/oJxLwSv+qu4YLFqAZYlq3YQ/SVon55JUEco3Zy8gIfm5lxgjwjrDqVQyaIFxs5d3B3Cw0MCZ8tVlkD4RIevQSira7Du0ejhu/RfTgp4xEyrvRJWpvupfJLjY0V2wjefSuuyZlh6SsFcOFRGrrRnde2JwXb0PgCOmn5ZI6cBlAyaTSJjld5Mmz3bNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vJfVin2w08yklHKOlEqd6NWTobx8Nr8JimQ1fpHxfdU=;
 b=v4N7Vg0o72rbE3g0R/qGcc9PZyEbmQZ8UkdIDyIS/YaTxy6/uqAtATMOJhXK04akdeLlJvxhAbjeLxim79n6Mx2PHKGFlR7pBtPq/5UPwq1rvY1CU/RtCUh3OCfkNR9C2G4g7iCgq2NWwJwrcBYfeiY0RunUVa44ure7Vjkgz/4=
Received: from TY6PR01MB17377.jpnprd01.prod.outlook.com (2603:1096:405:35b::6)
 by OSCPR01MB15578.jpnprd01.prod.outlook.com (2603:1096:604:3c1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.21; Thu, 23 Apr
 2026 08:42:59 +0000
Received: from TY6PR01MB17377.jpnprd01.prod.outlook.com
 ([fe80::f373:26d6:86c4:6aa3]) by TY6PR01MB17377.jpnprd01.prod.outlook.com
 ([fe80::f373:26d6:86c4:6aa3%6]) with mapi id 15.20.9846.021; Thu, 23 Apr 2026
 08:42:59 +0000
From: John Madieu <john.madieu.xa@bp.renesas.com>
To: Rob Herring <robh@kernel.org>
CC: Geert Uytterhoeven <geert+renesas@glider.be>, Kuninori Morimoto
	<kuninori.morimoto.gx@renesas.com>, Vinod Koul <vkoul@kernel.org>, Mark Brown
	<broonie@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Michael
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
Subject: RE: [PATCH v2 06/24] ASoC: dt-bindings: Add RZ/G3E (R9A09G047) sound
 binding
Thread-Topic: [PATCH v2 06/24] ASoC: dt-bindings: Add RZ/G3E (R9A09G047) sound
 binding
Thread-Index: AQHcwoA3qbwp6I+hdUiOegM/HOfDd7Xgr/WAgAvBIxA=
Date: Thu, 23 Apr 2026 08:42:58 +0000
Message-ID:
 <TY6PR01MB17377A994ADC23E7513E585F5FF2A2@TY6PR01MB17377.jpnprd01.prod.outlook.com>
References: <20260402090524.9137-1-john.madieu.xa@bp.renesas.com>
 <20260402090524.9137-7-john.madieu.xa@bp.renesas.com>
 <20260415205733.GA354660-robh@kernel.org>
In-Reply-To: <20260415205733.GA354660-robh@kernel.org>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY6PR01MB17377:EE_|OSCPR01MB15578:EE_
x-ms-office365-filtering-correlation-id: d130320e-a8ae-4ae4-8b8e-08dea1145292
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|1800799024|366016|376014|18002099003|38070700021|56012099003|22082099003;
x-microsoft-antispam-message-info:
 MpfORgNINFLLHuv//89n/AapInSZKgCDRGDQ+NIsSHDO1xBKZ5XwN8nmX7EOYDnienxhqqqd/KC0/h29lsZdAPDT1W0WCCs9X/RsNNgNobL7FD/JIQ8tzTk2hhouDFJzfnS0UAZCzoBrMiD3lXvami4+v/4trRraHNh3fPGNMzLob47MmoaDhcmqxxd+MGFeUiqJrRtTbN4WvRPA5XV20ITWb6/1GZRXo5RoQlWFOkQj7MBha39VdKWRDEPFEK9xhGMnd6aESMZ/pgrAIp31gbbAcZpOxCrxDcdbQJ5nZ+RwBkXwRC5T4nQSBGtQ2DpLum7MNrbX/usUNzZLufFBn1B8dbYCW2lcYP3fxEO0AN9zGDttF5q6aLO+8YosT4cWwOGO35z5tNalkYeh8EjceJ0YVTPdQNDaaYXoWLUdS/2b7CV2A5AEIo6FwYx8r1fLc7+wJEuTwCOc/VPy5e44Fd7uqEBKL+RCnbZpni0CbkZLtg1/ssWYTJ51Ad0JssTLcqnNg1HTEtqjnkbikWMMMikwVBWcLAX77W7aVn2B0A74lfsriC9JfMM6bJu2En5/gTspbsYS9RGrDVeiZRye0L/K8XKxZkulcGz2uBwdjE2+ZobiLTmSLUZvZFgC+ddO98jMbdY+HaFYeLufoy56fVLuKjem8WrgRplJfuFTUcl7SMRrTP8Bqiy/cX/Se3IBk2d1h5QBwfWUVqnnGRTIiLSPK/eqredaBdJTV16SENoouwk7z61xwOlRNYdLRF0T
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY6PR01MB17377.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(366016)(376014)(18002099003)(38070700021)(56012099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?76/uNsjNGbo6UbU4apHhqISe0g2X9eR1T2BOko2PA/yP3TWOx9y76piJ1PtB?=
 =?us-ascii?Q?+kPbfNhnscGgQVlqDj1J1SlVOZUusM0RRqNFl+7Zw0wvXrAht2H+tyoXQZmW?=
 =?us-ascii?Q?BrzlFxfbXbA7iNki3SyGp433amZbusqqzXseaLG4+f4+kjH3FnHPQvc3TR4p?=
 =?us-ascii?Q?SzNri1QPdFJ4VufL5FVdhG5oaqoOKdPdToCUpX0oNMzmQbTJO51pgHOzjpHN?=
 =?us-ascii?Q?3x77XW6AnsnFku2xrtZ962VJHpd0n7YXlpblpsswJYLbY++MXOVfAbFOv72v?=
 =?us-ascii?Q?/9Am3faPGGH1Zyfe8oa1CL/jfbMwNB2RIuuuO0jAn7tXY041m6oPlw1hODlJ?=
 =?us-ascii?Q?pwSZB1Yhnpl95Yk+gDnfypb+E2Sx+ZgwheEAA/DyDQ/Y3hvJyRZjoZINs9nG?=
 =?us-ascii?Q?SC3BsuQPMUu5IEHKQpeFJCcvp7G+S6N4c1nbfYL+hpu6qRg4G9yLS49CBwZT?=
 =?us-ascii?Q?JOtOPESXW8uzWsmOby4KKkqBSrl0lqv3C+K7PpiX3We94FX+TfM62S4qpnlU?=
 =?us-ascii?Q?EX8Zet0wux/VTLVGofwHIfaU8zFfR68Uj5ikJpU3aKUsKZJTGM9APjnMGp5V?=
 =?us-ascii?Q?hE14WqnoLpaxsiAY2J0WWQAzQQKu+yPw8tyMxCK2TtWwdX+SqxdRqPlK2Krv?=
 =?us-ascii?Q?XIxIfFfaEsJ42OMnE2ScGrf4GPXcrBlNWWuuPve4xEuYjnEhFzIOL7z8Gxi/?=
 =?us-ascii?Q?kbgHbhnvyCjWdIabJaV1qt523eMDPtdCvpa9+It381FkOsb/j6o2gJvt7NRB?=
 =?us-ascii?Q?mssYRYIRwcBx8rCccfZefayMIRw4dr3izDFXve9rEJKkY6OmiPmnLDeHAJup?=
 =?us-ascii?Q?ufTCYT37S6+gjiajp+1F/YHqgrNHhhw3BuMv5AlC+DWWZC4VA22DOiQpZOtT?=
 =?us-ascii?Q?/cS91doMpGrT+DPZqP4NI8JnzZIoTeIkdqfcl24FrteY6Z66gTmztIm68LFZ?=
 =?us-ascii?Q?btq8ccTU4qMsTfkQ4KXCUR1mO8TmI0Bz2B2cyFlUIckIssI4URYpCiP6SH5r?=
 =?us-ascii?Q?uSHi9EB2fgLx49WuZuWTUvDGp3LWU6wBmdAJkeLfDsK8dGEX/B4548SS7tEI?=
 =?us-ascii?Q?+cu8SSI/HFkvPCTUa+3f2FOkjsKC1BZ6G2Cxol3PAUUJcYrS6S/a3DRz+6qd?=
 =?us-ascii?Q?gWVFAuJCDJuWaq14RyabPW7tYt+QjmwUYqRquKlqltgciCU9NBdeCrqp+Rmb?=
 =?us-ascii?Q?RjS2dvh0aAn9goFWbOOP/OL0vNJbGP7BayNN9buSVCQwKhwr9esHVo/tyf9C?=
 =?us-ascii?Q?E2I8E80dOWW7iFflN25nb5Dn+3/K053XMyUt7UVc+fbuGIqRMF6SoAxJbmQf?=
 =?us-ascii?Q?9woeFWCs03qJUAoywEBo0Cuq1dzmHI9sLA1QLZ/gB7ZBP1U6Lgy9m2CPzL0O?=
 =?us-ascii?Q?H+oVzTOJewgIoqAEp5tufh1aFBuc6oA6rmS8drA3cH+cUgM8GnbGFeCtqBBZ?=
 =?us-ascii?Q?MMcbreL6bxDemqKi9BkY4FNW0dHvypYS6oEifF3NF6f32D3fUMaiuvSEixXi?=
 =?us-ascii?Q?HROPkEdzA8xB9iLzHG36WULEWg5w5UBvZ/2JDOW721LstLIUotFfuDGISlwJ?=
 =?us-ascii?Q?rihRHonpZvKwjGvqmIannfqmjk+VQIGtCq2sNGi0knU9WW71dA5MgeTIpA4+?=
 =?us-ascii?Q?1/He0EcqK1VZw6PQ63dP30REYbPp5qCWYwwa9K7cTzJFzZcavCDZziIJw0Ct?=
 =?us-ascii?Q?cUAy1ukcCUHuIMJcQe36Z/KoLuQYmSe7yiETjFXkSD6zx0R5tn3hHjAvjBEX?=
 =?us-ascii?Q?Ak4kxie8Of19uGR8gT1h3Uf64Iqk4nM=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d130320e-a8ae-4ae4-8b8e-08dea1145292
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2026 08:42:58.9914
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QxaYnkq/oO/cXZaDiRgTLjVdeydq5tHqNXxtnHIL+0sUv/cE4f95yACZUNnDFjF1vHqkQL0YZ4RcrjBT5CtWC+w08bn3/TXsF2X+zo3Jsag=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB15578
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
	TAGGED_FROM(0.00)[bounces-10088-lists,dmaengine=lfdr.de];
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
	NEURAL_HAM(-0.00)[-1.000];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[renesas.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,devicetree.org:url,bp.renesas.com:dkim]
X-Rspamd-Queue-Id: 9551B44EB54
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Rob,

Thanks fort he review.

> -----Original Message-----
> From: Rob Herring <robh@kernel.org>
> Sent: Mittwoch, 15. April 2026 22:58
> To: John Madieu <john.madieu.xa@bp.renesas.com>
> Subject: Re: [PATCH v2 06/24] ASoC: dt-bindings: Add RZ/G3E (R9A09G047)
> sound binding
>=20
> On Thu, Apr 02, 2026 at 11:05:05AM +0200, John Madieu wrote:
> > The RZ/G3E shares the same audio IP as the R-Car variants but differs
> > in several aspects: it supports up to 5 DMA controllers per audio
> > channel, requires additional clocks (47 total including per-SSI ADG
> > clocks, SCU domain clocks and SSIF supply) and additional reset lines
> > (14 total including SCU, ADG and Audio DMAC peri-peri resets).
> >
> > Add a dedicated devicetree binding for the RZ/G3E sound controller.
> > The binding references the common renesas,rsnd-common.yaml schema for
> > shared property and subnode definitions.
> >
> > Signed-off-by: John Madieu <john.madieu.xa@bp.renesas.com>
> > ---
> >
> > Changes:
> >
> > v2: New patch
> >
> >  .../sound/renesas,r9a09g047-sound.yaml        | 371 ++++++++++++++++++
> >  1 file changed, 371 insertions(+)
> >  create mode 100644
> > Documentation/devicetree/bindings/sound/renesas,r9a09g047-sound.yaml
> >
> > diff --git
> > a/Documentation/devicetree/bindings/sound/renesas,r9a09g047-sound.yaml
> > b/Documentation/devicetree/bindings/sound/renesas,r9a09g047-sound.yaml
> > new file mode 100644
> > index 000000000000..1dfe9bab3382
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/sound/renesas,r9a09g047-sound.
> > +++ yaml
> > @@ -0,0 +1,371 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) %YAML 1.2
> > +---
> > +$id:
> > +http://devicetree.org/schemas/sound/renesas,r9a09g047-sound.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Renesas RZ/G3E Sound Controller
> > +
> > +maintainers:
> > +  - Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> > +  - John Madieu <john.madieu.xa@bp.renesas.com>
> > +
> > +description:
> > +  The RZ/G3E (R9A09G047) integrates an R-Car compatible sound
> > +controller
> > +  with extended DMA channel support (up to 5 DMACs per direction),
> > +additional
> > +  clock domains, and additional reset lines compared to the R-Car
> > +Gen2/Gen3
> > +  variants.
> > +
> > +allOf:
> > +  - $ref: renesas,rsnd-common.yaml#
> > +
> > +properties:
> > +  compatible:
> > +    const: renesas,r9a09g047-sound
> > +
> > +  reg:
> > +    maxItems: 5
> > +
> > +  reg-names:
> > +    items:
> > +      - const: scu
> > +      - const: adg
> > +      - const: ssiu
> > +      - const: ssi
> > +      - const: audmapp
> > +
> > +  clocks:
> > +    maxItems: 47
> > +
> > +  clock-names:
> > +    items:
> > +      - const: ssi-all
> > +      - const: ssi.9
> > +      - const: ssi.8
> > +      - const: ssi.7
> > +      - const: ssi.6
> > +      - const: ssi.5
> > +      - const: ssi.4
> > +      - const: ssi.3
> > +      - const: ssi.2
> > +      - const: ssi.1
> > +      - const: ssi.0
> > +      - const: src.9
> > +      - const: src.8
> > +      - const: src.7
> > +      - const: src.6
> > +      - const: src.5
> > +      - const: src.4
> > +      - const: src.3
> > +      - const: src.2
> > +      - const: src.1
> > +      - const: src.0
> > +      - const: mix.1
> > +      - const: mix.0
> > +      - const: ctu.1
> > +      - const: ctu.0
> > +      - const: dvc.0
> > +      - const: dvc.1
> > +      - const: clk_a
> > +      - const: clk_b
> > +      - const: clk_c
> > +      - const: clk_i
> > +      - const: ssif_supply
> > +      - const: scu
> > +      - const: scu_x2
> > +      - const: scu_supply
> > +      - const: adg.ssi.9
> > +      - const: adg.ssi.8
> > +      - const: adg.ssi.7
> > +      - const: adg.ssi.6
> > +      - const: adg.ssi.5
> > +      - const: adg.ssi.4
> > +      - const: adg.ssi.3
> > +      - const: adg.ssi.2
> > +      - const: adg.ssi.1
> > +      - const: adg.ssi.0
> > +      - const: audmapp
> > +      - const: adg
> > +
> > +  resets:
> > +    maxItems: 14
> > +
> > +  reset-names:
> > +    items:
> > +      - const: ssi-all
> > +      - const: ssi.9
> > +      - const: ssi.8
> > +      - const: ssi.7
> > +      - const: ssi.6
> > +      - const: ssi.5
> > +      - const: ssi.4
> > +      - const: ssi.3
> > +      - const: ssi.2
> > +      - const: ssi.1
> > +      - const: ssi.0
> > +      - const: scu
> > +      - const: adg
> > +      - const: audmapp
> > +
> > +  rcar_sound,dvc:
> > +    description: DVC subnode.
> > +    type: object
>=20
> Move 'additionalProperties' here.
>=20

I share your opinion, but version 5 [1] has already been published.
I received feedback from Krzysztof throughout the series, which
aligned with your views. I hope you don't mind if we continue from v5
(where there is no longer a split due to a major divergence following
Krzysztof's recommendations). Is that Ok for you ?

[1] https://lore.kernel.org/all/20260417-energetic-practical-frigatebird-5b=
93ad@quoll/=20

Regards,
john

