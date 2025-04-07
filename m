Return-Path: <dmaengine+bounces-4840-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 501CFA7D842
	for <lists+dmaengine@lfdr.de>; Mon,  7 Apr 2025 10:43:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C39F416E153
	for <lists+dmaengine@lfdr.de>; Mon,  7 Apr 2025 08:43:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EE5E22839A;
	Mon,  7 Apr 2025 08:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="BVOjX5x0"
X-Original-To: dmaengine@vger.kernel.org
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11011058.outbound.protection.outlook.com [52.101.125.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FCEC2288C6;
	Mon,  7 Apr 2025 08:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744015412; cv=fail; b=PYaikf5JIAO4VzakhgbivB+JWivvC/le/2aWB+D7BoWwjjJvtpd6q/wX4Et5F52YFcTO8dyOZBNZh2ZIPnynlInxsG4DyAJH6pWuWGpJUZ3rzR/Fn9kTaUW3n+DCrpfF0pvlfSLNLTmUNpPUEoneobu7hBGRfA8Mz+gj4H2AJvI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744015412; c=relaxed/simple;
	bh=Q27UBXKXNXWp4MAJ5y7Gef40qOfg1/zMRr7+N+SO07w=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ikrz93CC3IcqUOy0QIDyUz8LYv83Ssh2k3GXFyedryKa+nXTCBgpvQX/DaMh/7V5PFXUkGR4ooKj/vv5h1iowj6Gd46PxNcgl/QC3KLEXTKXtX2e1z8kw7qfFMpnXjwZiQxqLzr+tvVxnAwqJeecgClIRwtwxYnd0jKBvxHggxI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=BVOjX5x0; arc=fail smtp.client-ip=52.101.125.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a50xxn4S8YVIsPZwtqcVg4ssL7fw8Vrz+uEaXPA1BseB+fOlsBNdmfgltPLLZudSxcmXtu2hOe2Y3xW9DrZPP0JS4CaxLUc8cpugSAl/5NDKS3UN5UrxXuBfmt7mXPnA3fWo7I3OHAI4T+uY1hsC86ED3kCgDgWk+OadfAKO/5d5GvZ8SIgNxjrp54DjLkXIftv19ZnOIEPv3PowZ+qfBmyOnBNdB38jThSGxq2x27ieItmFv2AXqmwL62e4vPBGrLWvz8iisk5Z4MamKRSrh9ud2utF95G/GgbtVJzI4FbrRZGfY1luKNVlBSaPO+RHalDNJb4SZuAy1Csmrk1TrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p7SIBm42XuOgAZ94CqnxDd4fqErhdKyn6VxQiXh0Dkk=;
 b=CuaOsOI3GEQ2TtZlgeG/2wxNj9xXQkmX7YY5jaGe8TaWv98I59B7xTFRxCB0tw0i4G3ePyCC03VwWMJNwI597+dkJAUV6AwXmUIkSa/8Bgf5e4momweJXdv1G5V4Oar2zkQUq3+6RpHSfXI9gPSCuW4ZDUVmir3+2SPvw/jNxiOKqcinnI4/3D9gWXF2EmoDd1Y3LDiLuNcPsGpWHlvoWzpB6FVAuRgTeQcYd7nLvJb2UqapnwZkFcNEl80QFnTkVfymVssyXrfBuRsWeBVgCy4pqVhp9bwQFCS7VpBddXAHK45Le9WNl2ZEciH+vMCXNyaIZitmrOi+QquKMP3KkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p7SIBm42XuOgAZ94CqnxDd4fqErhdKyn6VxQiXh0Dkk=;
 b=BVOjX5x0KiYEyet/Z9NftKBh4bpNFspawZDqiJYMaShW2QCGDdhA5xquPPJICyXE8Ddv10Lfqm7EAtwS+SSxtfC29UTnNdV6VMyZj0xi5WFowqgFy5hLxqt/ObMuFnzlqUZA3nxqwr3XU2nSiOx1fUalpZ8+ibpsMFpF2F+23hg=
Received: from TYCPR01MB12093.jpnprd01.prod.outlook.com (2603:1096:400:448::7)
 by OS3PR01MB10297.jpnprd01.prod.outlook.com (2603:1096:604:1df::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.33; Mon, 7 Apr
 2025 08:43:21 +0000
Received: from TYCPR01MB12093.jpnprd01.prod.outlook.com
 ([fe80::439:42dd:2bf:a430]) by TYCPR01MB12093.jpnprd01.prod.outlook.com
 ([fe80::439:42dd:2bf:a430%7]) with mapi id 15.20.8606.029; Mon, 7 Apr 2025
 08:43:21 +0000
From: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
To: Fabrizio Castro <fabrizio.castro.jz@renesas.com>, Vinod Koul
	<vkoul@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>
CC: Magnus Damm <magnus.damm@gmail.com>, Biju Das
	<biju.das.jz@bp.renesas.com>, Wolfram Sang
	<wsa+renesas@sang-engineering.com>, =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?=
	<u.kleine-koenig@baylibre.com>, "dmaengine@vger.kernel.org"
	<dmaengine@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-renesas-soc@vger.kernel.org"
	<linux-renesas-soc@vger.kernel.org>, Prabhakar Mahadev Lad
	<prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [PATCH v5 5/6] dmaengine: sh: rz-dmac: Add RZ/V2H(P) support
Thread-Topic: [PATCH v5 5/6] dmaengine: sh: rz-dmac: Add RZ/V2H(P) support
Thread-Index: AQHbjWSWS5mwyC4HUEmfjJheML/6FLOYFvLA
Date: Mon, 7 Apr 2025 08:43:21 +0000
Message-ID:
 <TYCPR01MB120933FFAAD85946DC0CEA7AAC2AA2@TYCPR01MB12093.jpnprd01.prod.outlook.com>
References: <20250305002112.5289-1-fabrizio.castro.jz@renesas.com>
 <20250305002112.5289-6-fabrizio.castro.jz@renesas.com>
In-Reply-To: <20250305002112.5289-6-fabrizio.castro.jz@renesas.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB12093:EE_|OS3PR01MB10297:EE_
x-ms-office365-filtering-correlation-id: 980f71c1-7d03-459f-e68c-08dd75b040ba
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?nmxpktm8q9pCJyj2bMnkGitc4fAmLQr+9zW7M+6LA2//a1Zu0GRffnytuh?=
 =?iso-8859-1?Q?Ve29o3IYdG8ywKcqyXF3xba8Vv4Iix5EEraINx7HsKfC2/+/MUS9pTbkgR?=
 =?iso-8859-1?Q?9NewQowqFc9Xw/2D2UF5QwgSQ+EM8nrEIA5se8JDJDYx9uJ15nAMx3F9/X?=
 =?iso-8859-1?Q?SNGNYVYpIH+YSDMx2dQQoEsFLa4QNmjm83EfCrKVXLfzPeoB1tMoCiwXU+?=
 =?iso-8859-1?Q?jJGPcq3DxLcOHp6lWWc8O6WKDXCPKW6JDe2sFHOb8jZo19YitK/IsK15sY?=
 =?iso-8859-1?Q?H/zvHzyxs5wYD4pSyMnVYLtCw6z2RPLaiiWCFS4AK3Qb988Jelwc58UOaj?=
 =?iso-8859-1?Q?nhyEvr+PlvIAfxTqmgs5nci9+Z+V5G4Ykcec2Th0JR3X3S+w00guS7TVnJ?=
 =?iso-8859-1?Q?WD6UHUJzzzfUlx+E0cBYe4bt0WdnaPdKWs6xVqUlGu5NAuAaCbiA3tboOP?=
 =?iso-8859-1?Q?6FjyP8qBKE6X40LyikGjaUULawctt0oaXFeK9Byj6Cs10UonrpWVx3tHyx?=
 =?iso-8859-1?Q?rHVwdkXyKlrrYZnoOXnJ3B7gEFEptYUTeRscvkE524KiqAvu2M2No2BZ1w?=
 =?iso-8859-1?Q?7xFlkG+gXhnKI0KTW6ropUZIhKFm0Qy+gX+SUrPWOsphByxfxZBwpIFbaN?=
 =?iso-8859-1?Q?J7NXpfDKdZ/eFEEU+FOQO4dU0H3od5cA4Y5KGFi5W07JTK7eaOpHdUTkDL?=
 =?iso-8859-1?Q?azOcsfvYtZYh31MppFZ54TFOkUsWQPhrc8ihTN0u7XqKCU3nP3XRKzp3bX?=
 =?iso-8859-1?Q?Dfym7CWDL90b7cbq8zV+4qzRIGEkWoH9jhXsoOSlc6FmBdytpCHikBfShW?=
 =?iso-8859-1?Q?7bDMzEnuoZoV5pJNVTvHVUPsHmtY0qc20nXZ/AfACwZHVW/zYIxKcOdXTm?=
 =?iso-8859-1?Q?FF+iaOvi3jFdqSdgcxiHYqMF/0vWV7OXmEtFYZHPUHtRLd5XN4zFOsTTaR?=
 =?iso-8859-1?Q?Y9u/4OhbHgMYc7OLLT+bG4Q5C4haEuAriBGZz3ZTccjwRwWcMudi4TOSBp?=
 =?iso-8859-1?Q?zet7AEB/7CVxqPk7VJkM3RI2Sko0iaJdLrpzWJpTeMNOcuLj0jdMJ1jRks?=
 =?iso-8859-1?Q?WJ+CS9dFycYwbkhBtpM7BHACCVUCCqJ9xVoIfnsCH/KUwz6DCH1T6at9CJ?=
 =?iso-8859-1?Q?YBHHAzQwg40HmkDyYAp4qDFvoZrGJQehwX/A/pCR6XUd9GuUNV/Z+CKrjL?=
 =?iso-8859-1?Q?VRItuHwDKyj9RuhsAmbQ3mVKvRYqGAZ8KVU349Apyw7Wd3jdx6MaqpkBj3?=
 =?iso-8859-1?Q?RwGiQ9s1+NZLaUiTLv/7CkPJVfa8d+IFlqr451gLeucCnxlnzHtkoOhvts?=
 =?iso-8859-1?Q?QGybFmiTaLLmsMnKKEM5Pv2Ptw3cG+Oq/nSQVs5v8taxRrjERPjPe5739Q?=
 =?iso-8859-1?Q?UXWBTFiJUGzD2rY93FMoFmmTLwGqwTYLnbef0c6QwbeQnAelkszWWXwfLI?=
 =?iso-8859-1?Q?K2+3e6779UMD84PYJd3Am3Ix8gDxsJjVBzBIjaJwpQ6cIcQRejHnmJmCP9?=
 =?iso-8859-1?Q?7h9Y0bZgMJHq0vWWyzt/Zz?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB12093.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?ShZuugeZu29Uo/Notxgk5Z+ZfmUP4vHUUrkGVbKprqdA3ULBNy+ixxwlxl?=
 =?iso-8859-1?Q?C4EbmHlXhH9PFTtHbvhUkPzn4bFYwrOk0muDXQCtyTnm2adk2T2hK9el03?=
 =?iso-8859-1?Q?Dq0xYOu5DI5gdRSgaRI5qX5pmMtchL5GF+VubnI4bhBsrcAg6DP1u/tlL4?=
 =?iso-8859-1?Q?XPgzZf2lx2gUVqrvIpcex2s7tMVBIzC2hjea+zbvcvKpwWvmvlIFKK4ChT?=
 =?iso-8859-1?Q?jPOr9R1jZ8B8tZEVww/LOT3RDOBq3drvLa0+urwjdo7Uv6Cf+CEDU8ekd2?=
 =?iso-8859-1?Q?5vgd28n3so19F+8Sm/7/WJGtH2ah6ASegC1iAaU8ODiCyls/x9CJWQLfLO?=
 =?iso-8859-1?Q?PkhMlvwnUQ42rzRcnAT0sokTNcgjyX+V/A4HrDvh+CX0WVddIMs8ooaDqG?=
 =?iso-8859-1?Q?SjZ9s7bPpQ/WsRZQ+wxa3+CX7HzsPAzN1p5G/4ZTa9tZB6iq2kP0yHKHIQ?=
 =?iso-8859-1?Q?K5sUm6CoOVl9gHS+2WV6huPmunZskKRASy3El/dloia+vnJt9Ex5Mg5a22?=
 =?iso-8859-1?Q?qVcn0oS0EiNeLKAx75ntX+7Bnttg/uOijoeWik4comPUY0cavtOLSKRR3o?=
 =?iso-8859-1?Q?w6CVaUJJwwWBalukPlCLjMMlDE2huXs7sxy2yVVWIM7R7gBjsb3r0pb7H4?=
 =?iso-8859-1?Q?hGSwcC+Av3ybah+PupzON6cyFRXmz3Nb7X+bvxEukrdFcISYR+VC0nb1lX?=
 =?iso-8859-1?Q?Z334oz+i8tT8gycrbZrKXzgMZBnXsYBwVPYd8caTGrNvbmb/psQ0luVW+8?=
 =?iso-8859-1?Q?1msDf+njjawtOoH63yYVTGPXf0DyJJ5TGe2XDhPMhqKDAQ/AtrHn0AuPoo?=
 =?iso-8859-1?Q?i0cVsj08otdeeRJS3gv2i/T8RIb1kZOmrq2V20uIjpdMqHTiuhzWmSwqHU?=
 =?iso-8859-1?Q?ZkinlpNbuZ7uYZqJ8h8Lh5keKmmx9qe6sFx5D/SGm9O3pav0GnRT/inR/m?=
 =?iso-8859-1?Q?xS3VZeQi3EgvvXOrhhDGimtQGi3AspClIw9xB3SevYbPc+Oe5AU7JVY2KP?=
 =?iso-8859-1?Q?ptoOhxmXszhY1uksJJCDsv5iBwZAxAbYh0FobRdyXEJfIl2Kw0OiNRKchZ?=
 =?iso-8859-1?Q?30fLnquHAI4dRPHUUn15jhKMoMZCYZEptYfctL6uIbeV7vHCxwUVNBKRpc?=
 =?iso-8859-1?Q?ojAPpVmI9Q/0+s4nXxmgIlqAhgNvL0BAhzA/eLTPLK+LzLA8lRKGeCyYXe?=
 =?iso-8859-1?Q?ENonLh0nwA3M9vJYIfb8TJ9h1sud8tXzWOzVdzhSj2ZhEyItvtPKP/MvdB?=
 =?iso-8859-1?Q?PKQ8C7AKc06jNgjaLU63x0UGnQQxQPv6rPIsjUCxI7g0QMajfbv5qbvDW/?=
 =?iso-8859-1?Q?QdzgCtsThntsj7G9vn3wozuNeAjAqg44w9CoXwY0A9VH/331PEL7kIC+e8?=
 =?iso-8859-1?Q?ov6AoHpsXyrWwr/qThAm5xNL35Ap3/W97XTKjs7WIUcL9diO9Y+srCxpkk?=
 =?iso-8859-1?Q?wYQ6YzSX+RQP7laJX3Jya6XWQM7GvSYPuD95Ls6YqwH0aHUR3GIO2CPq4E?=
 =?iso-8859-1?Q?W2ojFUfnhZJiwdrJI6xzWGSiaF7f9TXAKpkz7L6SrsWHWlLJEuwVXdLyzI?=
 =?iso-8859-1?Q?8Zb2dkjUxOxPczVsMHKuQIoPXWfIPXyQWDHCIx1cKtRrSYhkjQ/yt2kgHg?=
 =?iso-8859-1?Q?SJlZbHZhLAug0cFjz/Rf45afM+43gocZpeTzwSTfgaarW1UqDBlpGS1A?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB12093.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 980f71c1-7d03-459f-e68c-08dd75b040ba
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Apr 2025 08:43:21.6650
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9uuQIJ+UgQmtNNkNZMrkLy9E2W/zzuq/oNpCYwnrnxkCEiT+Vl+xwyjpDjj4kUBtUtze5GLH/UeTDjH18Vx7VhX2i+56Hb4AYLZRS++++lc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB10297

Gentle ping.

Kind regards,
Fab

> From: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
> Sent: 05 March 2025 00:21
> Subject: [PATCH v5 5/6] dmaengine: sh: rz-dmac: Add RZ/V2H(P) support
>=20
> The DMAC IP found on the Renesas RZ/V2H(P) family of SoCs is
> similar to the version found on the Renesas RZ/G2L family of
> SoCs, but there are some differences:
> * It only uses one register area
> * It only uses one clock
> * It only uses one reset
> * Instead of using MID/IRD it uses REQ No
> * It is connected to the Interrupt Control Unit (ICU)
> * On the RZ/G2L there is only 1 DMAC, on the RZ/V2H(P) there are 5
>=20
> Add specific support for the Renesas RZ/V2H(P) family of SoC by
> tackling the aforementioned differences.
>=20
> Signed-off-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
> ---
> v4->v5:
> * Reused RZ/G2L cell specification (with REQ No in place of MID/RID).
> * Dropped ACK No.
> * Removed mid_rid/req_no/ack_no union and reused mid_rid for REQ No.
> * Other small improvements.
> v3->v4:
> * Fixed an issue with mid_rid/req_no/ack_no initialization
> v2->v3:
> * Dropped change to Kconfig.
> * Replaced rz_dmac_type with has_icu flag.
> * Put req_no and ack_no in an anonymous struct, nested under an
>   anonymous union with mid_rid.
> * Dropped data field of_rz_dmac_match[], and added logic to determine
>   value of has_icu flag from DT parsing.
> v1->v2:
> * Switched to new macros for minimum values.
> ---
>  drivers/dma/sh/rz-dmac.c | 81 ++++++++++++++++++++++++++++++++++++----
>  1 file changed, 74 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
> index d7a4ce28040b..1f687b08d6b8 100644
> --- a/drivers/dma/sh/rz-dmac.c
> +++ b/drivers/dma/sh/rz-dmac.c
> @@ -14,6 +14,7 @@
>  #include <linux/dmaengine.h>
>  #include <linux/interrupt.h>
>  #include <linux/iopoll.h>
> +#include <linux/irqchip/irq-renesas-rzv2h.h>
>  #include <linux/list.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
> @@ -89,8 +90,14 @@ struct rz_dmac_chan {
>=20
>  #define to_rz_dmac_chan(c)	container_of(c, struct rz_dmac_chan, vc.chan)
>=20
> +struct rz_dmac_icu {
> +	struct platform_device *pdev;
> +	u8 dmac_index;
> +};
> +
>  struct rz_dmac {
>  	struct dma_device engine;
> +	struct rz_dmac_icu icu;
>  	struct device *dev;
>  	struct reset_control *rstc;
>  	void __iomem *base;
> @@ -99,6 +106,8 @@ struct rz_dmac {
>  	unsigned int n_channels;
>  	struct rz_dmac_chan *channels;
>=20
> +	bool has_icu;
> +
>  	DECLARE_BITMAP(modules, 1024);
>  };
>=20
> @@ -167,6 +176,9 @@ struct rz_dmac {
>  #define RZ_DMAC_MAX_CHANNELS		16
>  #define DMAC_NR_LMDESC			64
>=20
> +/* RZ/V2H ICU related */
> +#define RZV2H_MAX_DMAC_INDEX		4
> +
>  /*
>   * ---------------------------------------------------------------------=
--------
>   * Device access
> @@ -324,7 +336,13 @@ static void rz_dmac_prepare_desc_for_memcpy(struct r=
z_dmac_chan *channel)
>  	lmdesc->chext =3D 0;
>  	lmdesc->header =3D HEADER_LV;
>=20
> -	rz_dmac_set_dmars_register(dmac, channel->index, 0);
> +	if (dmac->has_icu) {
> +		rzv2h_icu_register_dma_req(dmac->icu.pdev, dmac->icu.dmac_index,
> +					   channel->index,
> +					   RZV2H_ICU_DMAC_REQ_NO_DEFAULT);
> +	} else {
> +		rz_dmac_set_dmars_register(dmac, channel->index, 0);
> +	}
>=20
>  	channel->chcfg =3D chcfg;
>  	channel->chctrl =3D CHCTRL_STG | CHCTRL_SETEN;
> @@ -375,7 +393,13 @@ static void rz_dmac_prepare_descs_for_slave_sg(struc=
t rz_dmac_chan *channel)
>=20
>  	channel->lmdesc.tail =3D lmdesc;
>=20
> -	rz_dmac_set_dmars_register(dmac, channel->index, channel->mid_rid);
> +	if (dmac->has_icu) {
> +		rzv2h_icu_register_dma_req(dmac->icu.pdev, dmac->icu.dmac_index,
> +					   channel->index, channel->mid_rid);
> +	} else {
> +		rz_dmac_set_dmars_register(dmac, channel->index, channel->mid_rid);
> +	}
> +
>  	channel->chctrl =3D CHCTRL_SETEN;
>  }
>=20
> @@ -647,7 +671,13 @@ static void rz_dmac_device_synchronize(struct dma_ch=
an *chan)
>  	if (ret < 0)
>  		dev_warn(dmac->dev, "DMA Timeout");
>=20
> -	rz_dmac_set_dmars_register(dmac, channel->index, 0);
> +	if (dmac->has_icu) {
> +		rzv2h_icu_register_dma_req(dmac->icu.pdev, dmac->icu.dmac_index,
> +					   channel->index,
> +					   RZV2H_ICU_DMAC_REQ_NO_DEFAULT);
> +	} else {
> +		rz_dmac_set_dmars_register(dmac, channel->index, 0);
> +	}
>  }
>=20
>  /*
> @@ -824,6 +854,38 @@ static int rz_dmac_chan_probe(struct rz_dmac *dmac,
>  	return 0;
>  }
>=20
> +static int rz_dmac_parse_of_icu(struct device *dev, struct rz_dmac *dmac=
)
> +{
> +	struct device_node *np =3D dev->of_node;
> +	struct of_phandle_args args;
> +	uint32_t dmac_index;
> +	int ret;
> +
> +	ret =3D of_parse_phandle_with_fixed_args(np, "renesas,icu", 1, 0, &args=
);
> +	if (ret =3D=3D -ENOENT)
> +		return 0;
> +	if (ret)
> +		return ret;
> +
> +	dmac->has_icu =3D true;
> +
> +	dmac->icu.pdev =3D of_find_device_by_node(args.np);
> +	of_node_put(args.np);
> +	if (!dmac->icu.pdev) {
> +		dev_err(dev, "ICU device not found.\n");
> +		return -ENODEV;
> +	}
> +
> +	dmac_index =3D args.args[0];
> +	if (dmac_index > RZV2H_MAX_DMAC_INDEX) {
> +		dev_err(dev, "DMAC index %u invalid.\n", dmac_index);
> +		return -EINVAL;
> +	}
> +	dmac->icu.dmac_index =3D dmac_index;
> +
> +	return 0;
> +}
> +
>  static int rz_dmac_parse_of(struct device *dev, struct rz_dmac *dmac)
>  {
>  	struct device_node *np =3D dev->of_node;
> @@ -840,7 +902,7 @@ static int rz_dmac_parse_of(struct device *dev, struc=
t rz_dmac *dmac)
>  		return -EINVAL;
>  	}
>=20
> -	return 0;
> +	return rz_dmac_parse_of_icu(dev, dmac);
>  }
>=20
>  static int rz_dmac_probe(struct platform_device *pdev)
> @@ -874,9 +936,11 @@ static int rz_dmac_probe(struct platform_device *pde=
v)
>  	if (IS_ERR(dmac->base))
>  		return PTR_ERR(dmac->base);
>=20
> -	dmac->ext_base =3D devm_platform_ioremap_resource(pdev, 1);
> -	if (IS_ERR(dmac->ext_base))
> -		return PTR_ERR(dmac->ext_base);
> +	if (!dmac->has_icu) {
> +		dmac->ext_base =3D devm_platform_ioremap_resource(pdev, 1);
> +		if (IS_ERR(dmac->ext_base))
> +			return PTR_ERR(dmac->ext_base);
> +	}
>=20
>  	/* Register interrupt handler for error */
>  	irq =3D platform_get_irq_byname(pdev, irqname);
> @@ -991,9 +1055,12 @@ static void rz_dmac_remove(struct platform_device *=
pdev)
>  	reset_control_assert(dmac->rstc);
>  	pm_runtime_put(&pdev->dev);
>  	pm_runtime_disable(&pdev->dev);
> +
> +	platform_device_put(dmac->icu.pdev);
>  }
>=20
>  static const struct of_device_id of_rz_dmac_match[] =3D {
> +	{ .compatible =3D "renesas,r9a09g057-dmac", },
>  	{ .compatible =3D "renesas,rz-dmac", },
>  	{ /* Sentinel */ }
>  };
> --
> 2.34.1


