Return-Path: <dmaengine+bounces-3249-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 621E898B7AF
	for <lists+dmaengine@lfdr.de>; Tue,  1 Oct 2024 10:56:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6B5A1F22560
	for <lists+dmaengine@lfdr.de>; Tue,  1 Oct 2024 08:56:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F78B19AA68;
	Tue,  1 Oct 2024 08:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="CdQhjSkz"
X-Original-To: dmaengine@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010042.outbound.protection.outlook.com [52.101.229.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A61E19922D;
	Tue,  1 Oct 2024 08:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727773000; cv=fail; b=G1jH2r6uvmmLrXed3OUAExZCcIVaSsZ5h0BBAacDQNUP+v+QioRd63VM1lktQ246g/BNoLMg99IeRnanEj2EjRz3Xp3WnVh6UPvyG4AfCUqQ+1ON8qQZLID1BLgns+JWfgTiogMcZX8NmvS2xiD1FK0mvk14CRS9NnQ+an7ZZGU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727773000; c=relaxed/simple;
	bh=g3uhsJhsoLSOYbV7xmHOpzTTfrJdaWTyvO1NEvVaCyY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MCN3CdHZPnMwOqJ00MPTsQ8RnKk10lG0x6iQaG8/xwjugRylqTaTqkh/wfSv5MkR8P5GothWij9uN3pzrycxAK5H8sK+f1KUlylG7sg0wdpp+7r4bDoLsF1qSE6tY8vQAWyWEiyLTm9qXkArCgsgNUVW29SjHTHbZo+EVrjTw40=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=CdQhjSkz; arc=fail smtp.client-ip=52.101.229.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KeLYnDWI0oRlb/UzptkLdRbVJNtmZavIzCSFvxrNlv4etWG9O7ZONhD4b/9GwjVoaG50bk/DODZuwxDz6H8tVD6hEF+ZfrULQqE1ezOK2lUs7EHknzxbtQ1WaFHMiOhQY9L7fVC0XFG3Gh2hWuqEuy1zPgQ9OvWwqzM3kAJ3Ly3PF0tdO7lazsoLiKy7+zS3uokTcz+bXHkDsMXmLMxpY1vWN//vmBakKrrZF9F4EuKsJY9Uu1vu1FV1p/pSHzjKUp1zLoJxsBF50iGXmZSuBvrEk3D1vevnfBT3Gjl0MDYVUGcovW/oXf4kuzQPSBs0UR74heAW9smsdk9PzvNH1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g3uhsJhsoLSOYbV7xmHOpzTTfrJdaWTyvO1NEvVaCyY=;
 b=aqZpljfXpnQT+E2kgt/CECNzTPakQOjv2xU6whXCwuH0pvQCQYkhrHKDimi7EFg9GTgaRX48uqzstYvlpFKa99v+hsz9LtGgTyzL5AnpNEmgLzckCr9VT1CndGgcSulF7HWoLfmwP+LJyzvtmvZpwI8jK6sHDxJCYeSC/vfEhyJWhcktc86ikTuE6PGZ9VWnIPgktEw1Yix1hsTQfWFnlO8g6Vr3FH8b+P2BbCTzmZiYWXw7eOIQ/iDESTljzvm3tjwI8QGdS5GwmYjk2XeSHOs5Kbe+rn/DZRSdSS/AMcbA9ahaNqu8/FJMkanMrmO0dcATias/LYgt+iDMR6a7Tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g3uhsJhsoLSOYbV7xmHOpzTTfrJdaWTyvO1NEvVaCyY=;
 b=CdQhjSkzS2nM/0xHOgoFTEYLFHG7UqvUeAhgv17wJIOMZN/CYvcGVTXjCzEiaC/ehdiLSc7YcWN3mKIERHYWvgoAoHE+dkeMGQJj18SRuQujwUYq1YL6MIs7/nHd064A5Sa4mBnGz9AB1nIRK45FkLfDZkQOklLB9NIeXJSzr9g=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by OS3PR01MB8113.jpnprd01.prod.outlook.com (2603:1096:604:163::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.27; Tue, 1 Oct
 2024 08:56:34 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1%5]) with mapi id 15.20.8005.026; Tue, 1 Oct 2024
 08:56:34 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
CC: "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
	Vinod Koul <vkoul@kernel.org>, Prabhakar Mahadev Lad
	<prabhakar.mahadev-lad.rj@bp.renesas.com>, "dmaengine@vger.kernel.org"
	<dmaengine@vger.kernel.org>
Subject: RE: [PATCH 1/3] dmaengine: sh: rz-dmac: handle configs where one
 address is zero
Thread-Topic: [PATCH 1/3] dmaengine: sh: rz-dmac: handle configs where one
 address is zero
Thread-Index: AQHbE0lvnPRDT4hCO0iu7LLD2KS6vrJwiB3wgAAuVICAAOGIwA==
Date: Tue, 1 Oct 2024 08:56:34 +0000
Message-ID:
 <TY3PR01MB113464480DAADE858C6D1635E86772@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20240930145955.4248-1-wsa+renesas@sang-engineering.com>
 <20240930145955.4248-2-wsa+renesas@sang-engineering.com>
 <TY3PR01MB11346F2C786FD343B7B382CF386762@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <Zvr7Keg9bPu6aUJM@shikoro>
In-Reply-To: <Zvr7Keg9bPu6aUJM@shikoro>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|OS3PR01MB8113:EE_
x-ms-office365-filtering-correlation-id: 449ffd85-886d-4a72-cfcc-08dce1f6f38e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?Ii9yCTlvnnLORrixHcYYp2TQx/P7dVKQWwmAGvI2rMKhjj90L27qWk7+XyZY?=
 =?us-ascii?Q?yf9PPEOmtiQ9WWS8644/ODRLudVBDHjcRgLpzI1Qlk/HC/Swqjg4S5Bc9SU4?=
 =?us-ascii?Q?814mVoN0GJqEifEYC5Li72L+6DCtNCWYCLqzReOa+RAZ+1NiwfRRTzNpjxym?=
 =?us-ascii?Q?DD4VTRvXbs62/i1MX68rhk/JEEHucIzyLLyAB/eN66owBu7OQcuStMNKwKRc?=
 =?us-ascii?Q?6VxMyPB1uexUelaokQT5Mh/13SJWeMI9H6BdJIe3K6n8RXanS6aeyIyNcn+Q?=
 =?us-ascii?Q?lFLuHDUaF0GHwrtahw73DugX0BYySSjL2Ldw8mjUTzKXz8hS+8xoINnFBJE7?=
 =?us-ascii?Q?5HUE2uni71HNHY6WQBD35L/mUYkaMz/cAXyNXn+EX0fpvCYpBEcwHQCY4Zrc?=
 =?us-ascii?Q?8+H8VZiOYwOYwPfXT0uSzPFeGhsosqn5JybkqB1yXUbs8lhOkHdoDy/iAg0c?=
 =?us-ascii?Q?whGH0s57b6NWfaXjbRLYESw2kyzWgQnVLuKBw4eDnu+EKH1EaRrJoykTCxTg?=
 =?us-ascii?Q?Os9GJcNu5EG41nF85EPzPaf69y/eG/JsCN2fnbKQusOn7aLG0+TIXp9z45ku?=
 =?us-ascii?Q?JqVukppsAHAwTd1olM0bijhQZ0Vn+ZpaYttvqRwbEGP7hjfsp7wWa3VFTAcs?=
 =?us-ascii?Q?25oC4tIzGaZgjyAJigTJjB7O7aw0aXgYW+0S1krxPyxXAmS1tjNEytppa27O?=
 =?us-ascii?Q?L1AtbprPhhCFYnTsjz2vJhb/Q0sN/6JFCgoq7kc0++TEPU7fpTVDiwVusHUQ?=
 =?us-ascii?Q?gGAcxpDOSzRKmJB1VAEPdjELxU3TqBGqoFc0WX6AuPr11r3qT44PwyxBRaUm?=
 =?us-ascii?Q?WoJNcLOeap68O8oG9mk+JaJcqpValcNZtMYhTuurvZ7XsIgRwcjjP20v6KS0?=
 =?us-ascii?Q?5GIjjzMoQ4vOwkTxa0KzRujRPTjq5B3pMgAwVSQ+ZTZDo6ugnu4lMIS/yUYe?=
 =?us-ascii?Q?JQWsz5Y5OHS2wMdCA8IZPotYSIzTPjlhGl7iCZX4kr1yQdWqvdz2Q4gkvnMf?=
 =?us-ascii?Q?lalGvoFnrux6u06h9YDb3A7Y/U36QaUZM5LcUS6S3PeyiHQ+8x9wkZmtgafe?=
 =?us-ascii?Q?gRQBjPR/gmOT/84RcApjLoSsyizbcc3h/UHbNfOsT70GfrO7P+sd2LLziHN8?=
 =?us-ascii?Q?TdWXzVBc5vIRj1iREAMXYgLu4UQGPmshWjaGi0ZjEdi9fO8aEhaP8xi1wBEJ?=
 =?us-ascii?Q?MkCCaiKA9B5e+pYBZhdA/HIfV6wLeJDgf87cwY6kpJuiTBDRiRP253w9k5nA?=
 =?us-ascii?Q?DrJK5fPhUh/ZcgZcn8nhaiSuN6GGPY+ba83edQpNydi9QRsEyOv87IkxjH3v?=
 =?us-ascii?Q?2GE19pZwjKT6GlMWDLKdXa5aimFjCZjmppvKhiUQpNY5Wg=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?LW3bPRjla8lonQ186PywBlNBYKvHbO3xiYRC+h8sUzxmXBrKtzAikuDf53u2?=
 =?us-ascii?Q?zuXS3aYxF08NsmUeF1Ch4cC0UmPglCHN4jo1mc8cG4QAmf/NqJcZHKBdM4to?=
 =?us-ascii?Q?g55nMvIptkPUI0TqVpZf08hVX1TtreU0OvGI6IvBGQLmhhvqETKZK+HI1Ls9?=
 =?us-ascii?Q?qQc5WZZAZmX7nwJVW7YypKJLjsauIV/P5PgGFc58ovGByvMamIK3b6oS23qY?=
 =?us-ascii?Q?iChTlIsaq59h2VCEROUgsfOYqnDpoWnOENYglsScrTLrfSutjKS6Pu4UacvX?=
 =?us-ascii?Q?sunqDZ0O5axfYegi398bgS52dEeMd1v9n+t8PjHfoi/WlQhljzP7nSEzb5od?=
 =?us-ascii?Q?sMMZTuRFl/lLS0twtwRuz9M/67rc9DCZ/ceUfUtW2ZvrkL6zzDAqwsYvHk8Q?=
 =?us-ascii?Q?pwwlvTnqm/66vC0CC1AbEucC2mxk9CkrJkFLq9JrunQdMwMtQMRCaLnnKV4x?=
 =?us-ascii?Q?JpNSrdwPPvjGGKNE4tl6FtkuiRMxu/ys4JVs4hN0Vrp8mwRlaAuXY5X1XlIk?=
 =?us-ascii?Q?/2x1LVOLe3/0AbI0IGrL4jkii9UecMu64OYR1TSULsXUI83tp/B7UYz9t8r9?=
 =?us-ascii?Q?KhlhSFyfy4Sc1tqXCTMdNWKlWmU7PjoCHJPVUM+5n1u4fMJEzqx5p79KMv3E?=
 =?us-ascii?Q?LMv6AOhPQhP+MvZSvXU432Jf+5XRSgvmRxgGlj+IQ4RspxJZ+t9/y2ptoHS0?=
 =?us-ascii?Q?q3PK8fQuQkePcJKbgv7cKjpBVGcIGZfpo7krlTCiX+ZhEOW5TjueLWVvVv/D?=
 =?us-ascii?Q?hPPh/u7/e7+VnkoiHaZtsYolAu+aT64fiDrGMenUNtVN8wqcqj9jPRUp8Zc4?=
 =?us-ascii?Q?pknOQTfpY9pEjg/PYLmW1/Hw9dqwNDrA9DM9IO79Bsjofr92e8u0Rl3QBRbn?=
 =?us-ascii?Q?Z2Fobj6qq0WswmceDI6V0Ze/kSuW3eSy1IMHcpHMXYT3d5zXacZcDJXyqF0x?=
 =?us-ascii?Q?UsLx2sPEUXVqCUqzwkYXHxGB9oyLKtYKj6Uvc/GEwjRpeijU56538Bt4D69H?=
 =?us-ascii?Q?OppYIi8cWUypczxY62FEJI6r6IfIw9g35zYPRFa1fO0KVDK36l54RaN6AKVr?=
 =?us-ascii?Q?QzZ9txkqQYnYBHnQwZLE3Fq6LMEHj77iE4KlM/rXfuD43uNq5+NtJQ0cB8e3?=
 =?us-ascii?Q?tHhNAV4tzNu9joT6onleWBT6S5KZN8KkBoDQK3W6+HrzkDBAScqpI6hlsg5Y?=
 =?us-ascii?Q?UN9uFIIttZTpMevZ6XBDdk7o4kk+8i+II98Cxv3JIJkiW5HbvH6hVNbgYGOK?=
 =?us-ascii?Q?GQmJKSSz+eFRMJ4C3jbug/EghZOHG309XBL81WMuDHTYblwipGTU3Jd+oxuF?=
 =?us-ascii?Q?Zy2kSnC0hAbaPPi66v6DwVhJsvbQomsh1Z0Kz9+yrwmwx2DrDJxE71oAjYFW?=
 =?us-ascii?Q?KNaiBcKFm5EuliSNxIKKUBcTx9lAPOcUdl2lzLq54Zge9GWz3q7OXIIe6feF?=
 =?us-ascii?Q?nlbqrwF5nU6B+apBgCQVqYECm/yqZTU4LqIYZT+VxoAxPWo/8EA69Yn6LfIl?=
 =?us-ascii?Q?EkrGy1cj6IFLkIe9NYndiHyDAgOjnIkZYKoPME0k32bVxnj+27GRZ9N+ngc9?=
 =?us-ascii?Q?jER6HwFjCd9KPj/H6pKPkpC5odQ6b/PaMR9OeFLFJ9EidcaV614k5jgNdtP4?=
 =?us-ascii?Q?ug=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 449ffd85-886d-4a72-cfcc-08dce1f6f38e
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2024 08:56:34.4026
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /iCAHYCTug2tAwCWlkyHYXx+fj6FcRzaBMnt2X+OhgXVxA0G4UH+ijXYajKHKGQqtWrWJF93cq51n0g+u2Txz1qE0MpS6+jJsI3hw2ls1VU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB8113

Hi Wolfram Sang,

> -----Original Message-----
> From: Wolfram Sang <wsa+renesas@sang-engineering.com>
> Sent: Monday, September 30, 2024 8:25 PM
> Subject: Re: [PATCH 1/3] dmaengine: sh: rz-dmac: handle configs where one=
 address is zero
>=20
>=20
> > Now both code paths are identical, not sure may be introducing a
> > helper by passing channel, CHCFG_FILL_*_MASK and *_addr_width will
> > save some code??
>=20
> I had a look and I don't think so because we'd need to pass so many param=
eters to the helper, that it
> doesn't really save anything, I'd say.

OK, fine by me. I just meant to avoid code duplication as it is identical b=
locks.

Current changes are tested with RZ/G2L on with RSPI and SSI interfaces.

So,
Tested-by: Biju Das <biju.das.jz@bp.renesas.com>

Cheers,
Biju

