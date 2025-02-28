Return-Path: <dmaengine+bounces-4599-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 045C3A49C77
	for <lists+dmaengine@lfdr.de>; Fri, 28 Feb 2025 15:55:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD72B1898C19
	for <lists+dmaengine@lfdr.de>; Fri, 28 Feb 2025 14:55:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E28712702B9;
	Fri, 28 Feb 2025 14:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="XFpL/p47"
X-Original-To: dmaengine@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010030.outbound.protection.outlook.com [52.101.229.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08150183CC3;
	Fri, 28 Feb 2025 14:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740754540; cv=fail; b=LNCgnRiC+0E9Cww4B/75glkHUwM5NqsjKuO/mL4cV64MnPb/Nst9FW1+jsELx7Uxd/uhGLUKgtL1DyOUKdh2ODxHLMB5VvS8jbzaIdXS608RqCFUgFZ4BJ6/ERkRQHZeYub6sjNI5cxTFzI2LGMIcg9tRoICUqhU/JboNmJyKFI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740754540; c=relaxed/simple;
	bh=raq+N8sPLSF7X5sUw/im55xYhn/4U+/uwEE+y4uCDkE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uSFJOyAz/rnYRe0LsAiZpHMLtIq3oyITbYTYgrzOY9S/mD7USWAb61ra6aVfxEQqmOoG6ANPiYj7DJzpPhOwc3j5QviVQtAHFHtdf00ooe0W/Wr4cXeMPWa+1bFWi33X8Tszre6EAOeh65F2/Vk244ZY+pESPp3hwBeadeb+NA0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=XFpL/p47; arc=fail smtp.client-ip=52.101.229.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g0EaeTSVdWHZb7K20kogzfOJ0RMwPPTLOuWDiBgmQH2JPkBa3VrRUpbLuuWQq/UB4QOZ4UZp916WPZFGIXTKgWp3oM38hZUusmFG7HBOckXFAhAhO/hW4PP6h53xCXqgr7G20/sCOapruU61pQnRbhclUMjp9d1p/VHCC3UbcJFvPyj7dVU6+g+vpvN8N7/T8MYoInZ3eymHLTrC8sUxtdD3yHTsSX38Z2o4K1kwDmdTvYKVy/GKyK7acxAII8t/VU5h0dICoyg3ZS5X1MCY10lDr4QGLSTzJEwl93RJMNdy/1JIYHsMiFWya0S8L+wWmrxExuFep5B2R8H06WHQZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l0UQbkyIYfXz+lX8d/NV2K1Ro8W58X5VPfSjzeF0r1w=;
 b=YrfaxlBg9ZAwUof+DhVDbhYN+VdPe1rLl+hr7l+2Qnhdg/+Yjh5OIOElVpTXE9hglpzXidxwQgi4jsKqRNJy+egeWabQcO1dTgdHmOMNrHert0QMOUalD+BTCe++gp8RTn45i8aQxvSZQPwncUdjKntYAYvTDdlj1cFvoQ32Z/E1ZGjNuGYuJ/SFeuVoD9WgE9sLy+eWW40iOfvqcRbe/Pwqo8B4eVtZtBL7x7JPqaQTXQIdP6NxusHjuT/xbLCT59+uyTe+FUns7jVDg5Z1c1EC8P/L3jkwdaUwHulJZc+zQRaRMkJEUzYWrLLePO9HuYoZA70puhDADLqQXSv1Hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l0UQbkyIYfXz+lX8d/NV2K1Ro8W58X5VPfSjzeF0r1w=;
 b=XFpL/p47vaJJf1HUQ5TLobiYOUfPP06Hqk9gmbPAfERclByV8m2nO+vhyQFpePFRxiFpCa/fhCWT5sG1GAkuSFuGvmasLEowAFZNYCnnf54Vh4djPNSL74cR1qzmT2822GpYigMIqyTykphbdQqzIRL0huRLdFUwRp9347ssBGw=
Received: from TYCPR01MB12093.jpnprd01.prod.outlook.com (2603:1096:400:448::7)
 by OSCPR01MB13240.jpnprd01.prod.outlook.com (2603:1096:604:34f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.23; Fri, 28 Feb
 2025 14:55:34 +0000
Received: from TYCPR01MB12093.jpnprd01.prod.outlook.com
 ([fe80::439:42dd:2bf:a430]) by TYCPR01MB12093.jpnprd01.prod.outlook.com
 ([fe80::439:42dd:2bf:a430%7]) with mapi id 15.20.8489.021; Fri, 28 Feb 2025
 14:55:34 +0000
From: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
CC: Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Magnus
 Damm <magnus.damm@gmail.com>, Biju Das <biju.das.jz@bp.renesas.com>,
	"dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [PATCH v4 3/7] dt-bindings: dma: rz-dmac: Document RZ/V2H(P)
 family of SoCs
Thread-Topic: [PATCH v4 3/7] dt-bindings: dma: rz-dmac: Document RZ/V2H(P)
 family of SoCs
Thread-Index: AQHbg6hTr6k5RmdmC0qfs3vIpDif/7NWbDgAgAUL6qCAARRzAIAAS6Iw
Date: Fri, 28 Feb 2025 14:55:34 +0000
Message-ID:
 <TYCPR01MB12093D1484AD0E755B76FAE35C2CC2@TYCPR01MB12093.jpnprd01.prod.outlook.com>
References: <20250220150110.738619-1-fabrizio.castro.jz@renesas.com>
 <20250220150110.738619-4-fabrizio.castro.jz@renesas.com>
 <CAMuHMdUjDw923oStxqY+1myEePH9ApHnyd7sH=_4SSCnGMr=sw@mail.gmail.com>
 <TYCPR01MB12093A1002C4F7D7B989D10C4C2CD2@TYCPR01MB12093.jpnprd01.prod.outlook.com>
 <CAMuHMdWzuNz_4LFtNtoiowq31b=wbA_9Qahj1f0EP-9Wq8X4Uw@mail.gmail.com>
In-Reply-To:
 <CAMuHMdWzuNz_4LFtNtoiowq31b=wbA_9Qahj1f0EP-9Wq8X4Uw@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB12093:EE_|OSCPR01MB13240:EE_
x-ms-office365-filtering-correlation-id: e7d3d658-d992-43bd-a56a-08dd5807f48b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?VwdF6RpVVRNGStkMD3wm790CcU2EERXQrF5Brj8MbEOyNBoikwJ6SPIF5wNQ?=
 =?us-ascii?Q?I1sRwNGozfB7zBMEmVykQKFzh+/ZSsmqQkoJevktqtNO4AgDTO0ilq04tvyi?=
 =?us-ascii?Q?oPvCUnEA7SS0OS07kJuYfwxYrYt94ic95lod3B4RaZDFxQqu/9quvyS63Pho?=
 =?us-ascii?Q?entIwxO3vCvfJcwKLG0wbJ7xcLLENGpfv7WAzF0kC52pKuRkSbTrzifvPBmf?=
 =?us-ascii?Q?5OqoebbkEYneD5TpfHF89pb6x1UX/DFOgwwKfFg4caRdldPG2UmXRgjiDaY2?=
 =?us-ascii?Q?qr2SxdiGw3fYkNedaKT0PZy17Lg0CaDucvrDDoGrDS1hBub0vDw+AhrgF6oa?=
 =?us-ascii?Q?3D+yAGDU5wHgIc74MFMPH+PZUJQ4+rIQnDGXcfS6xhokQ4F/P53FMzf2Zc5w?=
 =?us-ascii?Q?QxalScnrFGFdO3D82DbmtpXnrKvaZ81y96ckDQ7AVcI65ahTeIpU1AEitEea?=
 =?us-ascii?Q?nMRKNZWjPbAlPBRDavUVjjDP1RoBQ7ckAs1E6rfJ5YrSWiEU6kvQ0sofnx/m?=
 =?us-ascii?Q?ffdgXjYvUHx5ICKVVd5d6DAliJREb+r3z9YC57BdjQHlLhbVASW25lVgFQOo?=
 =?us-ascii?Q?HRoBKQrJGkvs9tXapN158y9WavsUzBVr09x6Go+0wCFw2Gl/djPQHhISmN26?=
 =?us-ascii?Q?yvXoKQBaUMOWx0ZgRN1jVapPk1azxqMdLyUY3/CjVCZvSyk7mk0y/N1hnkKY?=
 =?us-ascii?Q?Y3NExP6jaRqJUgjXp4aBK0MqOz7awP6pQJwb0OCI3mg/S7yAIJ5SfZANdnhl?=
 =?us-ascii?Q?CrGr/IFiUppeibj/7v5g9afP7TktpV2THoVyp9AG9nrb9cGGccFsqtH+jVJm?=
 =?us-ascii?Q?EcBuK9INFgIc73glEP4gEj8EAq6Yo1ofCoMEvSC+ZQtA41DptDnNHM0/P9Rz?=
 =?us-ascii?Q?4K1hJ5O35dQLYXVHJDx+WOZmCuYBV2KqtnKHPx6gAhYbWFmpQik61xtU6szQ?=
 =?us-ascii?Q?RFPt7ryJ08F1LvPDMtzZH6Je0Ka1qGGa+SIjJt/1hPvXx5EX6gUDHyF4GjbD?=
 =?us-ascii?Q?vtkh0IcRS2G+IoAHEVw/vkS5jaCcWcwPuiONE8LGHW9gDo8zSDm8SLneg+zG?=
 =?us-ascii?Q?uGQ9d2vyFZWV8prBbZlrtR1i6NWP+CR02hpcVEJvhfGHYHx4IJjkEPO1wi+H?=
 =?us-ascii?Q?3bYJGgEsF166e91lE4v8And3yU+Bf3A85uQsBcWojr5txjKJyC5tYNSx/+T2?=
 =?us-ascii?Q?I81T78UQRIHXM0DzxsofsFUKwfGJeqVdRcghiahNS8Ur0CDphCxSWwYc1X9g?=
 =?us-ascii?Q?ukSmCuU7cCrZ6OnwUVXUF9FdwaL+Z3StaBIslw95ix2bDzAd0golMu4slyG7?=
 =?us-ascii?Q?b5qifApt7cmRoF8Rv5BJw+NM4ApSxYlaxGFEHG2w/Z9JsSVO7OvOoY6xj7cS?=
 =?us-ascii?Q?5E0fjnlA8ssj8XCXp4aV139pU27F9UC5I2/SSh7oRMFC3Lmp9JDBcJqEbHMW?=
 =?us-ascii?Q?UrpwghMXC7gKYVXOkh9bLpfJXLpWu81q?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB12093.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?W19YJz0OSZhzvNVQdtORZAqm73D527Mb+YiPzGQLGCGQk1IXcqMx33XLeiwE?=
 =?us-ascii?Q?umaGPQbM4jqpnfSjLjkCWx21C/7kQ5fzpvgMMbEfIUcW0fZR4aVTpkmMxpqN?=
 =?us-ascii?Q?mBcIuDVLq/yP+41Cu9zqcCrgphjt1OMNfao+oOLP4oZWNZvPougJ2j9DGVGX?=
 =?us-ascii?Q?FKJFlPrnZZYOez81IaPwaScAHTyy1h9fdrfFUrUc8QSHeZz1K3CWPjH2HNDy?=
 =?us-ascii?Q?efkvnonin+ruQDW/OWwWxsJ4LwAnJSKRlz0UyCoK3DsI/4cn1OUyqSav4dAm?=
 =?us-ascii?Q?E+IsuOFPhncRD+fmDaPT6k7E5p7skOpIn6iZaJGaQOSo22QRhZnmtHQ5OmdC?=
 =?us-ascii?Q?I1hPeOvHtg5kRCzVtekAWuXvgUvaVi/HQDawz+qxMLnZp9Qnihee66HSIcae?=
 =?us-ascii?Q?0fEf17UlhCZh4IERjsqOja3RlaLj+HlBIj0XeVfBsevzj1LbW5DZNOto2PNU?=
 =?us-ascii?Q?OZ/D36xh490pqoQFcD6AeUjIVtQ4QMRPXkDXM6YpiLuzHqaArIHjwRGcgZhb?=
 =?us-ascii?Q?f34gfNhkQ0zUgI0G8Ts1pU6gxKSrk9YZ3y5vvxsiKJaVQoN6Txe79TrGq9IW?=
 =?us-ascii?Q?rJ9XM8iv62aR6G24pQ2EhPErDTZxHqusb3iEAbPzQ6+emqcSdvFU8zqMmmVc?=
 =?us-ascii?Q?BaHIzDnBGNS0bwMib4zaKaY03Q6q3P1a1of6lKWsm5yoh2tbKTwat1ODzqRl?=
 =?us-ascii?Q?pxolHLW7SZTHI1NlLPfJT/0YewD56JfaT0v3XC5S3dZJ/rG2bW7B45kqWavo?=
 =?us-ascii?Q?VjPGicVvuFiWSXJNbPOjuy3Ej6RjLJK+du25s2avhUaiaS2Z4H26CeM2HD0/?=
 =?us-ascii?Q?FFGrRePBSTqYKvKlXZIeF61xOfzT01UWdi2H61q2c9BunLc7VXv4ilMHBuw9?=
 =?us-ascii?Q?Lyssm+Ps0Rucbkp7ylCJMxDtGsIAdrWAOttXHXbOAj/yGDiERv+6J0Kw+lTj?=
 =?us-ascii?Q?HrtvyhvAkKqD5lQv3N1slDAwtXpeqxnIgy4TGb1FsPNwU9xbrP4DI0H2lZOl?=
 =?us-ascii?Q?hNXzWAfmH4gGV+owTRAawaITtnUJSWgYJYNog3eld+mZHyOovtt7hU96LYOO?=
 =?us-ascii?Q?1iNts3dJpO6sBkmLzMpktJh/7a5hsPKaJLo9YjtJge8hnIo/k2tnhaamztgd?=
 =?us-ascii?Q?LEuAwCgETekAJLzI1+r3NlpsWqtVL6llTP5s2BNT2HAN4WuquKDrp3/1U+lP?=
 =?us-ascii?Q?zKd0NMt1jd0nn63foIbHSJnR0L1+GtY+Kd+BrUcVyngCvtP1Dt5BDoGodD6e?=
 =?us-ascii?Q?r9iIbb69v59FdVbTP0qNWBb0MqCC0kOPNujFJlN1LbHGXxqkGdftUiDFgmZ9?=
 =?us-ascii?Q?D9R3RMNv02fcGPfqGQK2Ou26hrMMokFJn9GxaTeYu7As2c7+k4miQJDyxroi?=
 =?us-ascii?Q?iw7tU2Y5pnGiagRkm95q20WVW7FPtIyIVme6n/3gBVL8SGWysKluulVUtKhD?=
 =?us-ascii?Q?0aqhAALmn687zhvsGrDBe1QZUMqIoQQqZeUVpWfR0LWfcv1I9GUaLGRVs/ix?=
 =?us-ascii?Q?/xfq/Hq5JHNuaHPwNeaNflK08zxjAeqYcoxorxOlYeIjKFmXmgp1Ngt0Bx87?=
 =?us-ascii?Q?2vHDjt2cxOUr6Ki5eIOCZZ0jWT4ZMQ6cnTyBplyo2DKyuIin0QWt48z3Vf3X?=
 =?us-ascii?Q?FA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e7d3d658-d992-43bd-a56a-08dd5807f48b
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2025 14:55:34.6710
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8d9vUTBzyCvm2qPfuoxgpbqwGbZyPAwvEjD7qieYqUZCk4/Me3eII9EykDM40iLjvZ/gW3SX5kz8XlvuFhs6HccI/F6XRK/BmiW/h5iAK00=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB13240

Hi Geert,

Thanks for your feedback!

> From: Geert Uytterhoeven <geert@linux-m68k.org>
> Sent: 28 February 2025 10:17
> Subject: Re: [PATCH v4 3/7] dt-bindings: dma: rz-dmac: Document RZ/V2H(P)=
 family of SoCs
>=20
> Hi Fabrizio,
>=20
> On Thu, 27 Feb 2025 at 19:16, Fabrizio Castro
> <fabrizio.castro.jz@renesas.com> wrote:
> > > From: Geert Uytterhoeven <geert@linux-m68k.org>
> > > Sent: 24 February 2025 12:44
> > > Subject: Re: [PATCH v4 3/7] dt-bindings: dma: rz-dmac: Document RZ/V2=
H(P) family of SoCs
> > >
> > > On Thu, 20 Feb 2025 at 16:01, Fabrizio Castro
> > > <fabrizio.castro.jz@renesas.com> wrote:
> > > > Document the Renesas RZ/V2H(P) family of SoCs DMAC block.
> > > > The Renesas RZ/V2H(P) DMAC is very similar to the one found on the
> > > > Renesas RZ/G2L family of SoCs, but there are some differences:
> > > > * It only uses one register area
> > > > * It only uses one clock
> > > > * It only uses one reset
> > > > * Instead of using MID/IRD it uses REQ NO/ACK NO
> > > > * It is connected to the Interrupt Control Unit (ICU)
> > > >
> > > > Signed-off-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
> > >
> > > > v1->v2:
> > > > * Removed RZ/V2H DMAC example.
> > > > * Improved the readability of the `if` statement.
> > >
> > > Thanks for the update!
> > >
> > > > --- a/Documentation/devicetree/bindings/dma/renesas,rz-dmac.yaml
> > > > +++ b/Documentation/devicetree/bindings/dma/renesas,rz-dmac.yaml
> > > > @@ -61,14 +66,22 @@ properties:
> > > >    '#dma-cells':
> > > >      const: 1
> > > >      description:
> > > > -      The cell specifies the encoded MID/RID values of the DMAC po=
rt
> > > > -      connected to the DMA client and the slave channel configurat=
ion
> > > > -      parameters.
> > > > +      For the RZ/A1H, RZ/Five, RZ/G2{L,LC,UL}, RZ/V2L, and RZ/G3S =
SoCs, the cell
> > > > +      specifies the encoded MID/RID values of the DMAC port connec=
ted to the
> > > > +      DMA client and the slave channel configuration parameters.
> > > >        bits[0:9] - Specifies MID/RID value
> > > >        bit[10] - Specifies DMA request high enable (HIEN)
> > > >        bit[11] - Specifies DMA request detection type (LVL)
> > > >        bits[12:14] - Specifies DMAACK output mode (AM)
> > > >        bit[15] - Specifies Transfer Mode (TM)
> > > > +      For the RZ/V2H(P) SoC the cell specifies the REQ NO, the ACK=
 NO, and the
> > > > +      slave channel configuration parameters.
> > > > +      bits[0:9] - Specifies the REQ NO
> > >
> > > So REQ_NO is the new name for MID/RID.
>=20
> These are documented in Table 4.7-22 ("DMA Transfer Request Detection
> Operation Setting Table").

REQ_NO is documented in both Table 4.7-22 and in Table 4.6-23 (column `DMAC=
 No.`).

>=20
> > It's certainly similar. I would say that REQ_NO + ACK_NO is the new MID=
_RID.
> >
> > > > +      bits[10:16] - Specifies the ACK NO
> > >
> > > This is a new field.
> > > However, it is not clear to me which value to specify here, and if th=
is
> > > is a hardware property at all, and thus needs to be specified in DT?
> >
> > It is a HW property. The value to set can be found in Table 4.6-27 from
> > the HW User Manual, column "Ack No".
>=20
> Thanks, but that table only shows values for SPDIF, SCU, SSIU and PFC
> (for external DMA requests).  The most familiar DMA clients listed
> in Table 4.7-22 are missing.  E.g. RSPI0 uses REQ_NO 0x8C/0x8D, but
> which values does it need for ACK_NO?

Only a handful of devices need it. For every other device (and use case) on=
ly the
default value is needed.

But I'll take this out for now, until we get to support a device that actua=
lly
needs ACK NO.

Thanks!

Fab

>=20
> Gr{oetje,eeting}s,
>=20
>                         Geert
>=20
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m6=
8k.org
>=20
> In personal conversations with technical people, I call myself a hacker. =
But
> when I'm talking to journalists I just say "programmer" or something like=
 that.
>                                 -- Linus Torvalds

