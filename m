Return-Path: <dmaengine+bounces-7909-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 83528CD9B51
	for <lists+dmaengine@lfdr.de>; Tue, 23 Dec 2025 15:44:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 56F13300387F
	for <lists+dmaengine@lfdr.de>; Tue, 23 Dec 2025 14:44:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24EAA346765;
	Tue, 23 Dec 2025 14:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="F21EHOAI"
X-Original-To: dmaengine@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010009.outbound.protection.outlook.com [52.101.229.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40E1F345CC0;
	Tue, 23 Dec 2025 14:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766501035; cv=fail; b=UO3jK99je8YPCQA0ehmzIqeZh4PqlgFcP7XLqqJ3Qsk9NJPRZccZ/WbErmRIFXag2VPh35DM4O7WW66jsRVHSMVjCsD8J3JT/44sk/MHq08l17t+6SjNcZ17zDAOXC/he2UaqvkOf7AcSJBc0K83mMVWVlTR0gcJPYuEb1G1KpQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766501035; c=relaxed/simple;
	bh=IIUPt8+x8b2eNUke/DHrfhtguCYlaakzGjqdEmJG9TM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rg4KAIMaQw8J8AupsHfYUz/o52JVoF5ssSpZGMnJalD1Ejzwx2m5t2AWEzf/ivD+u0k9MhqcSbkRKKlOIkVrTpeZ2KgNCecCXBbuXM3rDd5b4/sAOZqMR66DlcQ8JEG4KFBA1uOT/z/D36EY++G6ne38eXf+E98BR0lBBevtbSI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=F21EHOAI; arc=fail smtp.client-ip=52.101.229.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uQTlJaMJZ9MLDMqdvarzp5k473sOunemfNhemDAxNV39V5W3s46mr9OZCfOU1aZ/Usy2f7OC5Cmyn3uZ4y/ET+eGyeZdsgZhn5dlTen09haNWUr7M9KBLmYEkpN6maY4mzHCWKadADGng66ftpKRIbGO7SJdxL7FvldVImyLvlOZLGrTHiAdPGJ78rRttp2bzwhIz0Ow2InHOPPn0cpw+VnRlQm8mCnEtFzCyCoYvbBrkwPkP+0VBSVFUKLYW6OH2ozlDmXVplGazgF2r1GSsNnWDxBQvPaGnp4kzvNmdYpDxP4BfOeB2Rb6YuGsZV4aDNLOaGkkP0rAkrVp1Vbpig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G8VmWuHG9Q+/kbkJHhlqI9pAIZtfak9HpvzNX0dgcvM=;
 b=SGn5/Nz8+VM9FuCZJKd9F/6gLRPHatPjSXIY5C0AnEjfv8t6W8Sl8ICBucyHQHVyMAU34NwFzg9A8ITRdp7raeDJ36ULINky9JpA+CKtCaSG79gddcTkvWmUOSKPkxuQSQ0NhvIuFBfT7uLxf9mBNIU1DQ8KIYmSi/fM+AFXyetVGJj6mJ06dwkv3f7pLYgKgRX52t63Zcw+79Drpo1uAe1lKx0BE5ssTz7b6WVs2l9y8ay3/j3OhnHafy+5FxSjYX24BE8YcBK6sYKdTPhKxyfE+Y61S8OqkODBwVfLfWdQA8UPfU9jChFwez5p7Rlgq1OjWcsAkhBPTV22RP3bjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8VmWuHG9Q+/kbkJHhlqI9pAIZtfak9HpvzNX0dgcvM=;
 b=F21EHOAIRfEoQD6GhnJFaTT9/UkKrbpnrES1rn8kMPkFo9pNUzGhP0VvtD9PCUdev+c5NiqTiDWFhfnCgSMW9RniKwwVCRHpUXJYbt3qBG/pVH30lLhO+zK7i0nBMWIf27AHhtsK3gRPJ+H7YObgRKP4Rh6cwnAd0rl3iJu2feo=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by OSCPR01MB14935.jpnprd01.prod.outlook.com (2603:1096:604:3b0::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9456.10; Tue, 23 Dec
 2025 14:43:44 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1%6]) with mapi id 15.20.9456.008; Tue, 23 Dec 2025
 14:43:44 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Claudiu.Beznea <claudiu.beznea@tuxon.dev>, "vkoul@kernel.org"
	<vkoul@kernel.org>, Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	"geert+renesas@glider.be" <geert+renesas@glider.be>, Prabhakar Mahadev Lad
	<prabhakar.mahadev-lad.rj@bp.renesas.com>
CC: Claudiu.Beznea <claudiu.beznea@tuxon.dev>, "dmaengine@vger.kernel.org"
	<dmaengine@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Claudiu Beznea
	<claudiu.beznea.uj@bp.renesas.com>
Subject: RE: [PATCH v6 8/8] dmaengine: sh: rz-dmac: Add
 device_{pause,resume}() callbacks
Thread-Topic: [PATCH v6 8/8] dmaengine: sh: rz-dmac: Add
 device_{pause,resume}() callbacks
Thread-Index: AQHcdBMp6GqL2gQeEk68OIbopAhjubUvSY2Q
Date: Tue, 23 Dec 2025 14:43:44 +0000
Message-ID:
 <TY3PR01MB113466CA0EB792BF134502A7986B5A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20251223134952.460284-1-claudiu.beznea.uj@bp.renesas.com>
 <20251223134952.460284-9-claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20251223134952.460284-9-claudiu.beznea.uj@bp.renesas.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|OSCPR01MB14935:EE_
x-ms-office365-filtering-correlation-id: 57350a80-47f8-437b-9630-08de4231ac8a
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?VoYvvbveCWzTq9uaeci2mGLWSGlFFHOrnZsK05e9Phj/uprmc1VzjgblLtTX?=
 =?us-ascii?Q?OqD7ICQv7kEV4AgQu1I47VeVhJCfLu5x54AVCw+2k/1iGeV7cFvce0Z+27bS?=
 =?us-ascii?Q?xGa7rkImULjxLj0E638E5XH53SeV2Tp3g6xxTtWvucJKoskZwsyUMVQRnGgw?=
 =?us-ascii?Q?KmpqEChQkF0no76icocAw06rw5D2qnXJlpWHeswz2WH9VtAKv55jWpF2Ep31?=
 =?us-ascii?Q?jrA4Za9w7fhe0fuImcgbPUfB213xqigQ5pknGjU3Qe/Zs5qZXBIu+3ZxtEQC?=
 =?us-ascii?Q?5ExgA7o1ruhKfi8Gtr/TkPXYHxER0bYGV7421E+WqPngiUnerAWTvkMBNY7U?=
 =?us-ascii?Q?Pe2OxXsNRmFaU9HqMlv8fuC/of0NoO2KE+o77mijRAbElFwhXmttFbjToUwU?=
 =?us-ascii?Q?C5W9XdT/KVCgGSmfTBPJVzD2qw30pb3LUHw+Y0ccopGyDiWtZ3Jy3K5vSk3V?=
 =?us-ascii?Q?ZT1fH5dvR2OPBzj0PWxigtWQM/4YyMsAqLKjlVT7SAs41I2QEYPRW+pQjrMJ?=
 =?us-ascii?Q?tkpc5vm3KxrGrLyRrBvjmXf7n9iQkwB2jHwV+N0O3iG3mQTvqOCxfc36eiyf?=
 =?us-ascii?Q?7R9Emtcuf8wLApVD6l2Yu2Whu7l4TyQDG2+upNWM+NJYOasDdmAgJ4spKfDh?=
 =?us-ascii?Q?Fmez2K30vhcBV4dHV5XuqVqSlka0T0hf8fXphpd8RLUPYQMd5yfWuAwNCTKF?=
 =?us-ascii?Q?erSFTyEPxYNolgXGwsdLJUv6KSOAu7xuGx9oZ3Ou78Z8AWngrLANhiAM66eN?=
 =?us-ascii?Q?56yvZoA+PEfyT9TeuYNSJmG4+LKkVu3yn/WQZuidOp0mERe/QVuuVTlPjgOW?=
 =?us-ascii?Q?Jc6lg9tUYfYoIrBnrs7h7yOz3qbZ8WMRLpL/19nH01MgK9OUusNNKYfm165H?=
 =?us-ascii?Q?B2cQwR/yRsZVizOtQiVfPjWpVt1iCUY42xehKZehYziwK1wN9qiBidf23ti5?=
 =?us-ascii?Q?JxHKmlqLYpNSietRgHRkWWRKTWQkevn4c9u3yEvZ1Vtbi3RYZYmPTjHesmX7?=
 =?us-ascii?Q?vY+EGZ4/TTON74V6byQP+2fPb/JRbOfkRLM23DoQ9PDGus8UU44pzzkKBFJg?=
 =?us-ascii?Q?UnYPeGpJVuMzVMDYqz7afyNO4VVEP9xQdXLkAmWBf4R70XLFSG+oCsR4SyH7?=
 =?us-ascii?Q?V0aeTC6zxAeeUmxmhDN0eGZQjX72yC0bAplDAnLBU5uwMlChe2II5NxnlfI0?=
 =?us-ascii?Q?LgOjWMdfHMxKmpIJnaEvsLaB49b3s4YsRIYMiwQcH44ULDdcvzu8ZlHAAKg5?=
 =?us-ascii?Q?M4IKC6EDY9nbH3IifFCBRnJmFyiOxWXXSYnC3O895XP8JxmP327eBedwtyPx?=
 =?us-ascii?Q?0dvgO/028uiRWuchQxjJfh4GwCHo4N+cqJwHb6UjF7xRStz+PksnuU9nMlA0?=
 =?us-ascii?Q?e03kZjNfAqI2Z5uK7ciFapFVhSchClg/mmra3BZKHNGbjPoQDnq9IRzuAzS0?=
 =?us-ascii?Q?v6aHMhLaCBpro6Ff5V6LStkgbZANsnnYvNOKeTvLXlIweuc44SUZA8waDg4c?=
 =?us-ascii?Q?xVgtLuOf1T3IGtH/2WMwQwFA/1mvw9769hIV?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?7ida4/CE4LHnUttXem4RNgL2ptZRpNPZ5fQXjl/t5/PeB2U4hpgZu69WN2FD?=
 =?us-ascii?Q?5BbCtaCPUx3pBnHWdYnx1fQ45ukdjx3P226+F9z8L2peYgSzWg2Do+jgaBjO?=
 =?us-ascii?Q?EnxzGtiB5iwuQ/liTUJUc+9pSl3NX81REiF2DgQNbidzi7CU0iyq8xknsX6+?=
 =?us-ascii?Q?Q0L88ZPdC+MjZ1xeu+CHVrKeFBapCdeDZCvTt/ponQoUq4r4a1/ROq6xUP/4?=
 =?us-ascii?Q?QaMnk2txKAs6AhHvhMimRQPzahLhQJ4+dI7dNJxpuqZRP6zP0DCja8kcP1Tz?=
 =?us-ascii?Q?PrIrG5Cq9XbvNQI3kfw/McGklGXAz0WOQIAF4UPyf5r8nIZAVDmgnsAf6ibi?=
 =?us-ascii?Q?PjbvABC5aPNEr/UZU5Dq5GQeTZSy5hg20Z7IgI7ySH9XImYALV8Nb/7OQG50?=
 =?us-ascii?Q?wn2RuRT6PRbs2HsgLAt6ZfA3RUo99QzqOGkGLZm2G+BuwVhEZHqa8xpVICr3?=
 =?us-ascii?Q?0AZ0pa/0I1ScWKBPn1z24jAM3fXgsQed44jiK35bPRRlRDBXMUTVHK9gLacm?=
 =?us-ascii?Q?5j+hGbrmGWO161QNcalmgq+JTfOVqdOnqjopHp1QsUFdyqWYsDhO4Kah6StI?=
 =?us-ascii?Q?NobH4q4qw7AbFmxvbi/gFZnGEQvncO9DbsRIKkYI75U/v5zf9I+rmrOzxt7s?=
 =?us-ascii?Q?NkeavAXpaB3oILzI7C50S8Foh21XFQ3crXiEb6+7xLQT0aM/28BWWlF7MCAm?=
 =?us-ascii?Q?6+WNb75XCJs/NF0uqnoVohViKYrhYu6bb+fFNcar4dJXYO8EwbeFObs73mJF?=
 =?us-ascii?Q?ulfLpn6tiGZos7VV/mh4YK4vBI1SCUBMiKgJD/P2+x8MkFArWhKOfibHHQYV?=
 =?us-ascii?Q?0ZdCqT01XjlEBYvXx50woCLuytn15fvQTu1HWzTV3D07EVArisjg+1F/0KLo?=
 =?us-ascii?Q?uP816/U9T2CAmpye6E1icgQbkRvAtKZMXlElw6qt0ttxwzfZL4pK5SAldmDC?=
 =?us-ascii?Q?Bwe7x6qy5Z88s+MN5JUE2x7XTtHOOJqxfnkk7w7tOpbloF6zzNVK0k5b126j?=
 =?us-ascii?Q?KkXSxkShMMh1TRlxFe3U7QZ2RYJS6VdNR5v10o/LkzRBHDH0X2Rjnb6u8zFw?=
 =?us-ascii?Q?LSCrhV2SOQyzpZzfUR2hkQn/u7KIxhg9KEeI+F6gcpupdUDqscf3ehsHvDU6?=
 =?us-ascii?Q?klZ4CgzS7ScNpAsl0OC7PqB2Dyr+6y9jXVOzDgxzacZtwTBlPkzNlC/t9Abt?=
 =?us-ascii?Q?tuLRJFWNmzMh4zDyB6Th2Eu4xDu1bfGS0MI2Y1eJ/abS9XK6O/8d0ODHk/Sw?=
 =?us-ascii?Q?C2G2Nv2IDQNhLE5FYIN/kZjOzJ9INGvniYWjHGQwRIFdgMr+6Hsfx4exXZb9?=
 =?us-ascii?Q?8v2UHRsDDwRN9Q+7OvNVeoCtQEEEr51TLJc1GoTn5SxwNMvUKCY9RIfTtiwv?=
 =?us-ascii?Q?SHrhm0vRriLFunaCLIaz7lChE9VRasTrU2HSV4dk5K/uBZGBrmb/NP8MXF2R?=
 =?us-ascii?Q?9NbzXLwUR5gUH6KUTqkjPwmHmu4VNnQ94K9eCLJUKinOBzpQrU5ue6MorHsP?=
 =?us-ascii?Q?sSuTyrMgaO7Tvh3L0m4XBu+4nRKknVj8droLmsR3tpsEZMywiKBDVb+AOdHp?=
 =?us-ascii?Q?LgthF/CLL4OKu/1aAdMyW2r1m6aRlHuyrF3p3Gtbh9Fm1fFO5BW/HUxBi0EP?=
 =?us-ascii?Q?XgY3Ad3iGZDzNmdlqvEpxc2hQ5Fcu9CFus3nNPUyy1PRhW4NbxQsqz41g9XT?=
 =?us-ascii?Q?FxNoFfYL4po8/SfloCB9u05VAR0r/unBKadvhmJDkCIeIFMg1uCH2Vr9zoL8?=
 =?us-ascii?Q?If56NikBfw=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 57350a80-47f8-437b-9630-08de4231ac8a
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Dec 2025 14:43:44.8530
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vX/lTodjaJcR+VD4EbdknCPKt6RHaK1zaq/A94DttYoOIaskxP8VmpDk6vo3dVx0ID8dzRCqgqrDUxu3WPt+sahZEkYiMb8Fnme/RiOop1o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB14935

Hi Claudiu,

> -----Original Message-----
> From: Claudiu <claudiu.beznea@tuxon.dev>
> Sent: 23 December 2025 13:50
> Subject: [PATCH v6 8/8] dmaengine: sh: rz-dmac: Add device_{pause,resume}=
() callbacks
>=20
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>=20
> Add support for device_{pause, resume}() callbacks. These are required by=
 the RZ/G2L SCIFA driver.
>=20
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> ---
>=20
> Changes in v6:
> - set CHCTRL_SETSUS for pause and CHCTRL_CLRSUS for resume
> - dropped read-modify-update approach for CHCTRL updates as the
>   HW returns zero when reading CHCTRL
> - moved the read_poll_timeout_atomic() under spin lock to
>   ensure avoid any races b/w pause and resume functionalities
>=20
> Changes in v5:
> - used suspend capability of the controller to pause/resume
>   the transfers
>=20
>  drivers/dma/sh/rz-dmac.c | 36 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 36 insertions(+)
>=20
> diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c index 44=
f0f72cbcf1..377bdd5c9425
> 100644
> --- a/drivers/dma/sh/rz-dmac.c
> +++ b/drivers/dma/sh/rz-dmac.c
> @@ -135,10 +135,12 @@ struct rz_dmac {
>  #define CHANNEL_8_15_COMMON_BASE	0x0700
>=20
>  #define CHSTAT_ER			BIT(4)
> +#define CHSTAT_SUS			BIT(3)
>  #define CHSTAT_EN			BIT(0)
>=20
>  #define CHCTRL_CLRINTMSK		BIT(17)
>  #define CHCTRL_CLRSUS			BIT(9)
> +#define CHCTRL_SETSUS			BIT(8)
>  #define CHCTRL_CLRTC			BIT(6)
>  #define CHCTRL_CLREND			BIT(5)
>  #define CHCTRL_CLRRQ			BIT(4)
> @@ -827,6 +829,38 @@ static enum dma_status rz_dmac_tx_status(struct dma_=
chan *chan,
>  	return status;
>  }
>=20
> +static int rz_dmac_device_pause(struct dma_chan *chan) {
> +	struct rz_dmac_chan *channel =3D to_rz_dmac_chan(chan);
> +	u32 val;
> +	int ret;
> +
> +	scoped_guard(spinlock_irqsave, &channel->vc.lock) {

> +		rz_dmac_ch_writel(channel, CHCTRL_SETSUS, CHCTRL, 1);


Probably first you need to check CHSTAT_EN first before setting CHCTRL_SETS=
US??

As per the hardware manual

"
Suspends the current DMA transfer. Setting this bit to 1 when 1 is set in E=
N of the
CHSTAT_n/nS register can suspend the current DMA transfer."


> +		ret =3D read_poll_timeout_atomic(rz_dmac_ch_readl, val,
> +					       (val & CHSTAT_SUS), 1, 1024,
> +					       false, channel, CHSTAT, 1);
> +	}
> +
> +	return ret;
> +}
> +
> +static int rz_dmac_device_resume(struct dma_chan *chan) {
> +	struct rz_dmac_chan *channel =3D to_rz_dmac_chan(chan);
> +	u32 val;
> +	int ret;
> +
> +	scoped_guard(spinlock_irqsave, &channel->vc.lock) {


> +		rz_dmac_ch_writel(channel, CHCTRL_CLRSUS, CHCTRL, 1);


Similarly, first you need to check  CHSTAT_SUS bit first and then clear sus=
pend state.


Clears the suspend status. Setting this bit to 1 when 1 is set in SUS of th=
e
CHSTAT_n/nS register can clear the suspend status.

Cheers,
Biju


> +		ret =3D read_poll_timeout_atomic(rz_dmac_ch_readl, val,
> +					       !(val & CHSTAT_SUS), 1, 1024,
> +					       false, channel, CHSTAT, 1);
> +	}
> +
> +	return ret;
> +}
> +
>  /*
>   * ---------------------------------------------------------------------=
--------
>   * IRQ handling
> @@ -1165,6 +1199,8 @@ static int rz_dmac_probe(struct platform_device *pd=
ev)
>  	engine->device_terminate_all =3D rz_dmac_terminate_all;
>  	engine->device_issue_pending =3D rz_dmac_issue_pending;
>  	engine->device_synchronize =3D rz_dmac_device_synchronize;
> +	engine->device_pause =3D rz_dmac_device_pause;
> +	engine->device_resume =3D rz_dmac_device_resume;
>=20
>  	engine->copy_align =3D DMAENGINE_ALIGN_1_BYTE;
>  	dma_set_max_seg_size(engine->dev, U32_MAX);
> --
> 2.43.0


