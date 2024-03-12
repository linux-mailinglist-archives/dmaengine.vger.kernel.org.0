Return-Path: <dmaengine+bounces-1339-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D7110879023
	for <lists+dmaengine@lfdr.de>; Tue, 12 Mar 2024 09:56:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4085D1F2190D
	for <lists+dmaengine@lfdr.de>; Tue, 12 Mar 2024 08:56:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE1C477F08;
	Tue, 12 Mar 2024 08:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="OJ2dQIHL"
X-Original-To: dmaengine@vger.kernel.org
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2079.outbound.protection.outlook.com [40.107.8.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3605058107;
	Tue, 12 Mar 2024 08:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710233758; cv=fail; b=ZE0AJnjZ/fAtQo5maePmTe0VF4z5QeWsgxC+2WDsiiSrJWuKPDqWefvIjTNvAB4e7sRo3ScEiCml9ZCFazZSzhKSN6uiPAeQURIwthJPFy+TiTRYplVoMYcQeZzOd4u4C2EGP2V8itSsHIWP4PR9Hc5IoQffPOMKQOdWqPhup88=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710233758; c=relaxed/simple;
	bh=WJB0reNbDnwfFjDWRmWqyn01NLemooHA08b19yyLR0c=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bOyEJ1Py/ktdCHAvu/IMOzHzEDRCim1ol7lmg5rvThgOG/Om+F9p2pOAyuiu4gUojVXq++Wlq4NBJHdMC+wyUCIn7i72v/YRcAXFXpJvRc+PUE9Q3x9hcQF8m9gIOJNR6tuszXfOyb+XIpx79GVjYZ8fw0TsuTvbwER6oUCnFj0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=OJ2dQIHL; arc=fail smtp.client-ip=40.107.8.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XjZi2nv5nrs97jwON3bB47RHvIaliaSucm6Fem4heA9EeRnKr/cJy9o/DI9qCYz3QLcTWg+MmVFh1/5mX4Ae2owYhrYFd0WfoV+MHHOIIlUTuLvziN40kd6ltc+eZYhBiarYAoJOvavjiEcdBIrA4erDgIO46OKmq7jgPTDOMPSLA8HMRwDq6kCLOozHaYHw4JWhEYU4jIGvkKX8fB52ttuxIveQqj2GK9m7BDTL5e5TRJy3hUy4PrqXja5xix0ue3kgs1/1l7Sfj2cW9XpHRb/ngC3Xu2baJrUk1KNFAOlu8Oq0Qy6RIYJTd1f34FM61s8JSKoUb765S0F/26X1ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WJB0reNbDnwfFjDWRmWqyn01NLemooHA08b19yyLR0c=;
 b=ThRIKbulQi7j5M9WSyqH7694HoR4+CwoeE7YtrwTOsnBSrloiWV2ibllkCiT3888XocEwekL0CLrgZNwxKOmVncNoVB8gG5ODTQBO0BH7Wu9kQJCA+C108YulCUZNnV2g71/V72QoZs7cNFZmBqalnjO6F+PX4pvN6st29ldVKJQaOy5B/jrSbDisFVH5nfXUF29mE537riXdNafbcxUh+/iAAUQX/Qsac4r/XF1DjQJcgHhddyAzkNZHdXWgLs35lfJM7OfQqh0TGj58ODuJOb7+fp5tsDv0nxKCjOr+O/u1rQtrl0XQ8tbL/i1G55bxVXcC0BC/ODmKNyS2deawg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WJB0reNbDnwfFjDWRmWqyn01NLemooHA08b19yyLR0c=;
 b=OJ2dQIHLsJ6o0IF8CT7sjN0usM94dx9A9OgdxxVcppphKHGwTPxtqo7/JKJAp1Guk8XJruRFt5NodRcefDW9Y5K3qCfaqBrqRkzplUePlzzg/VJ0cX2TZGOf8zXgNBrtGL5XMPT34B3oP4RHhAtO2YQdCDs58apjEs/0tSWbImU=
Received: from DB9PR04MB9377.eurprd04.prod.outlook.com (2603:10a6:10:36b::13)
 by AM8PR04MB7955.eurprd04.prod.outlook.com (2603:10a6:20b:249::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36; Tue, 12 Mar
 2024 08:55:53 +0000
Received: from DB9PR04MB9377.eurprd04.prod.outlook.com
 ([fe80::b3d4:17c4:91b7:101d]) by DB9PR04MB9377.eurprd04.prod.outlook.com
 ([fe80::b3d4:17c4:91b7:101d%5]) with mapi id 15.20.7362.024; Tue, 12 Mar 2024
 08:55:52 +0000
From: Joy Zou <joy.zou@nxp.com>
To: Frank Li <frank.li@nxp.com>, Vinod Koul <vkoul@kernel.org>, Shawn Guo
	<shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix
 Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>,
	dl-linux-imx <linux-imx@nxp.com>
CC: "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	Robin Gong <yibin.gong@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>, Daniel
 Baluta <daniel.baluta@nxp.com>
Subject: RE: [PATCH v2 4/4] dmaengine: imx-sdma: Add i2c dma support
Thread-Topic: [PATCH v2 4/4] dmaengine: imx-sdma: Add i2c dma support
Thread-Index: AQHacLWPcyntCd9ulk6SNrO9DXCJELEz0xOQ
Date: Tue, 12 Mar 2024 08:55:52 +0000
Message-ID:
 <DB9PR04MB93770AF55107B16335FDE03CE12B2@DB9PR04MB9377.eurprd04.prod.outlook.com>
References: <20240307-sdma_upstream-v2-0-e97305a43cf5@nxp.com>
 <20240307-sdma_upstream-v2-4-e97305a43cf5@nxp.com>
In-Reply-To: <20240307-sdma_upstream-v2-4-e97305a43cf5@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR04MB9377:EE_|AM8PR04MB7955:EE_
x-ms-office365-filtering-correlation-id: 57ad5a09-e754-48e9-ef52-08dc427238f0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 TitP1VwV53kTDuP6YozXuV46/XsOSBQWYjLARedg+OR5op4PXZlaL1+HyADEsUVa22nCKCABFRPkbR/tcu64IgaeYfVIF+MjY+giSl5LOb3vkn+zj8zLmkvsUqvaVxqBSdwoG3r2y5mpbvsGVXSeZvmIY3ljOJyBB3BZ60IQnXX8aO7Ph3sSNW4peIfX4TDzBsqfBiYOTU664crQUain3SIhvPUlw5+iHRr2ibXb3Y+kpgFDiAHfXc0R6AHDLDUJxoV2wLW76knpEjxUZia+XieTPbDnq47o1yUqQHHsuDGD7g4z6yUXwFbRVedsIx0wsl6TEMi+jEfknBIqrxAGaXsOPPvauNGFdjjjQ65/qV4u1upgGdrz4If9WrqrmpVCAfJiGI1UFreVLj3Vhds2j1tmMVxBrfbwzy4nbeGzHV4wERHYAH8pW0SRAbLx1T38+hUzwBlWR6AiDumTw0FdvUZLuKQQN2BOOYA8mV+j3wlXZNFJwcgIromJJMoeUvYHcI0zzpY16KPR1HsZcKgjCkOPkHHSUmgGivHD6ws5koS8uBW1H/DK9bLdJaKC77hlblOoG/JwMXRw1KEjX8dTO2rVv9sTadIgjs7BcYP9Ns0dtWRc6hbwwBbjP/5wT9oXcwb4elUFaHEh0EiicFOP+j+MkBMk57E7Hs3TUqZ6PH5Ez2zT9N6n5i9ACZS3/yrOtpdWSYYRgEWQhzrkdopmIw==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9377.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MVp5NThZVFQ1UEFWWG9NMW5VWTk4bWI5YjZ2UmJ0UnU2NXlQb3E4bmwrR2Rz?=
 =?utf-8?B?eGVLT3o5STd3TW1ZaHhLREM2Y3BlcjN4UVJoNzQ2REswL2dUaUNPSzVZRE5n?=
 =?utf-8?B?WSt4NEhvTXhIbWRWeitPN2RGU1dBaWRJZWlPczNOWXJzeGlnOHhxR3RGaVlp?=
 =?utf-8?B?d2l0eVIwbVJRMEx6bkhpZEtuL0FiTHhqd01PLzE5UmZtUUI5OGJlWVNRQWdZ?=
 =?utf-8?B?dHk5bDJKaHlFRkM3TGlUdG9YdFJQeTBhTWxGa2pHRjE5ZUhwMFhlM1NaZ1dE?=
 =?utf-8?B?eVV0MHZDcTZod1NHaXB0b2tUNE90UXE2OGU1cnBiOEZkQUlEaEtRdVJFMjdW?=
 =?utf-8?B?UG9uZWZjNU9GbDNCSEVPQUNWcXAreHhBM1dTNWh3cTEzUTRDaE5ud0thcGlL?=
 =?utf-8?B?U25ibWxINDNyVDZyTHJVL3V1TVQ4M2F6VXdLR0NWNHBmOGFQVURpaVR6WXVU?=
 =?utf-8?B?UzZlT3U1TjJhWGlYNm53RXh6dnE0ayt4bGE0NWZOcVNaaUhMNThIZno3NmNm?=
 =?utf-8?B?M2tOeTBTbXpnR1dLcUVacFZTcm5HRytvRUdOY1hpZHFDNlh3TmVPQWo1emtz?=
 =?utf-8?B?QngwWFkyQ2lzalh5RFQwaFFuMlMwQWI1ajlxZGhnRGp4c09XWDFVUVliSE5y?=
 =?utf-8?B?eHFVbHh0M3dVYWN1eWlmL3dJRjAwekVUUUlNa3N5SDU3aEo5TklrUGM5S24v?=
 =?utf-8?B?Ujg3OGgzK284Y2lIcm5UUzM5QXdVM2JvcFlzaENkSjJoQ0JYdXlmclhjWXVG?=
 =?utf-8?B?VDhxR3d4UWdhNFBYYkNyU3hNRzFhWXlLTHl0V0F4b1hMek5GQ3lCek5xaTJ3?=
 =?utf-8?B?SXV5elUxN2ViOTFoV09aUXpEalNFdmg2U0dkSVNGTnlPR2g3QWp1ZVFMWXNO?=
 =?utf-8?B?Vk1Qc05KYUNzcnp1T2pVdDliOVdPamlOQ1dkVDBGRzlUWWlpT3YxTkJlc3ZJ?=
 =?utf-8?B?SE9ieW1RNU5tNHdVSXZHTUdrQWVKSTZMYlZJaXBWT0RNbENsSGkwRVdPdjF1?=
 =?utf-8?B?anJvZ2lMbGlFS1Y0UjliZG9tVVVINFQ1QUpwanJpY2t6U2JuaTNwUHprUERh?=
 =?utf-8?B?dCtmL1NpckNFMHR3akxFOTY0VWZhQWhSMm03bFlpNytHN2lPcVFqZmN1aDht?=
 =?utf-8?B?QVhyNHlsSmhqVkdCczJWSS9IUmtQSVNFQy9zQnM5MUw0dlJYNllMcXdGbVdZ?=
 =?utf-8?B?b0pTb0JKd3A5OFhybWczdGdITlYrb1B6UWN5b3ROWmk0TWhLVXVweW1raFdN?=
 =?utf-8?B?YVM4TlUrSTlnekxFUDVJakNyMFhhUFFUNmN4OHprR1dXOHo2YUNRN2V5TkxC?=
 =?utf-8?B?MGIzUkppakttRUZzTmV1Mjg4TGFWcDY2Nk1QaTBONU9EWmRrTDZmRS9QTFhI?=
 =?utf-8?B?SDB5TUtPZllpamk3MWRBU1dORzViTDI3ODFKTG41UUk0RThiaUxJcVE1dlZP?=
 =?utf-8?B?TUlXaWpINzd3bUdVcFBoUCt3cThGUWd5STU5RG5oS3pSU0RsUXZLZkp1WnhX?=
 =?utf-8?B?WHMvUFV2K29qRnJqekpjaE11eUNWQjArdVBsVjJ2OEFtb01nKzlGK3pvQm1O?=
 =?utf-8?B?YSs1TDJFU3pPWSt2SlFZcXJyRXY0MXBMS1BsQkl2WnUzTVJMd2IzeTFZZERJ?=
 =?utf-8?B?eFFUVk1YdmU3T1M4WXFpM05jb3hJR1RsTlFNWnFDb2QvU3dhVmZGOVJBOWZq?=
 =?utf-8?B?Sm9MeXdLaEZFWW5MVW55R3Y2SFljR2tYLzNvdnp1a0VkTGFOYThxcGU1V1hS?=
 =?utf-8?B?U2c2d3pqdGhxOWdhR0J5dERiMHlyMHEyQjVKZjk0ZkN5bUVvNU5GM0t5b1o4?=
 =?utf-8?B?RCtRT0l1KzJteHdBM09UTVlWN1Vwem9mSGIydi9vaVpZeS9sWHRNMWxua1Er?=
 =?utf-8?B?a1NpZkRLczhZSFJGTTlKTmdMa1ZxT2dVVUdxazVyZGdxMmFlTVlhZURIS2dr?=
 =?utf-8?B?RC8xVHJKUy9iSU5RVmZqRVI0MkI5aUF3NE43WlBUNEg1NEtoc0NQZkhIbGRl?=
 =?utf-8?B?K3h3SjQ3Zmdweno2aEs1aGp1WU45RTJMRXhldzlabE1Ka0hLRytDOXFBL2xZ?=
 =?utf-8?B?RXlMcnQ0U0ZOekQ2Q0JoVzA4ZnNlOUdvZitGam5NZnZQSkhldUw1b1IxTVpS?=
 =?utf-8?Q?3OwE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9377.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57ad5a09-e754-48e9-ef52-08dc427238f0
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2024 08:55:52.8366
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6I4SUFIP/KWpTHcwIk7sjHwvU9zP4y3+xXRDS9ePp+UQ0OHfOxhfsIrDb4o7/dqX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7955

SGkgRnJhbmssDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRnJhbmsg
TGkgPGZyYW5rLmxpQG54cC5jb20+DQo+IFNlbnQ6IDIwMjTlubQz5pyIOOaXpSAxOjMzDQo+IFRv
OiBWaW5vZCBLb3VsIDx2a291bEBrZXJuZWwub3JnPjsgU2hhd24gR3VvIDxzaGF3bmd1b0BrZXJu
ZWwub3JnPjsNCj4gU2FzY2hhIEhhdWVyIDxzLmhhdWVyQHBlbmd1dHJvbml4LmRlPjsgUGVuZ3V0
cm9uaXggS2VybmVsIFRlYW0NCj4gPGtlcm5lbEBwZW5ndXRyb25peC5kZT47IEZhYmlvIEVzdGV2
YW0gPGZlc3RldmFtQGdtYWlsLmNvbT47DQo+IGRsLWxpbnV4LWlteCA8bGludXgtaW14QG54cC5j
b20+DQo+IENjOiBkbWFlbmdpbmVAdmdlci5rZXJuZWwub3JnOyBsaW51eC1hcm0ta2VybmVsQGxp
c3RzLmluZnJhZGVhZC5vcmc7DQo+IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGlteEBs
aXN0cy5saW51eC5kZXY7IEZyYW5rIExpDQo+IDxmcmFuay5saUBueHAuY29tPjsgUm9iaW4gR29u
ZyA8eWliaW4uZ29uZ0BueHAuY29tPjsgQ2xhcmsgV2FuZw0KPiA8eGlhb25pbmcud2FuZ0BueHAu
Y29tPjsgSm95IFpvdSA8am95LnpvdUBueHAuY29tPjsgRGFuaWVsIEJhbHV0YQ0KPiA8ZGFuaWVs
LmJhbHV0YUBueHAuY29tPg0KPiBTdWJqZWN0OiBbUEFUQ0ggdjIgNC80XSBkbWFlbmdpbmU6IGlt
eC1zZG1hOiBBZGQgaTJjIGRtYSBzdXBwb3J0DQo+IA0KPiBGcm9tOiBSb2JpbiBHb25nIDx5aWJp
bi5nb25nQG54cC5jb20+DQo+IA0KPiBOZXcgc2RtYSBzY3JpcHQgKHNkbWEtNnE6IHYzLjUsIHNk
bWEtN2Q6IHY0LjUpIHN1cHBvcnQgaTJjIGF0IGlteDhtcCBhbmQNCj4gaW14NnVsbC4gU28gYWRk
IEkyQyBkbWEgc3VwcG9ydC4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFJvYmluIEdvbmcgPHlpYmlu
LmdvbmdAbnhwLmNvbT4NCj4gQWNrZWQtYnk6IENsYXJrIFdhbmcgPHhpYW9uaW5nLndhbmdAbnhw
LmNvbT4NCj4gUmV2aWV3ZWQtYnk6IEpveSBab3UgPGpveS56b3VAbnhwLmNvbT4NCj4gUmV2aWV3
ZWQtYnk6IERhbmllbCBCYWx1dGEgPGRhbmllbC5iYWx1dGFAbnhwLmNvbT4NCj4gU2lnbmVkLW9m
Zi1ieTogRnJhbmsgTGkgPEZyYW5rLkxpQG54cC5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy9kbWEv
aW14LXNkbWEuYyAgICAgIHwgNyArKysrKysrDQo+ICBpbmNsdWRlL2xpbnV4L2RtYS9pbXgtZG1h
LmggfCAxICsNCj4gIDIgZmlsZXMgY2hhbmdlZCwgOCBpbnNlcnRpb25zKCspDQo+IA0KWW91IGFy
ZSBhZGRpbmcgaTJjIGRtYSBzdXBwb3J0IGluIHNkbWEgZHJpdmVyLiBTaG91bGQgd2UgYWRkIG5l
dyBwZXJpcGhlcmFsIHR5cGVzIElEIGZvciBJMkMgaW4gRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVl
L2JpbmRpbmdzL2RtYS9mc2wsaW14LXNkbWEueWFtbD8gQ291bGQgeW91IGhlbHAgY2hlY2sgYWdh
aW4/DQoNCkJSDQpKb3kgWm91DQo=

