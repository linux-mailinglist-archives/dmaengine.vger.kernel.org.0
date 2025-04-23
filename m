Return-Path: <dmaengine+bounces-5005-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 57C48A98C65
	for <lists+dmaengine@lfdr.de>; Wed, 23 Apr 2025 16:07:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25A323A5EB6
	for <lists+dmaengine@lfdr.de>; Wed, 23 Apr 2025 14:06:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 219EF27A90C;
	Wed, 23 Apr 2025 14:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="E+vc7Mik"
X-Original-To: dmaengine@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011053.outbound.protection.outlook.com [40.107.74.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD30F25228B;
	Wed, 23 Apr 2025 14:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745417123; cv=fail; b=TfALpUia0zZdTL4cUvuG9gWABT+3a4xWI0MDo4IXrlowgDjEdda+5ORxOXA94zALnt3WDcWu71s9c7p+rJ0eZJ4JYK9bwFiDM9HOEi98pUTRVKsZPv1rkRvHklAaCJ5dMQtBjy0F4SJLzk6PHc4LM8lkzYPHL31fWzH7nqjKcKQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745417123; c=relaxed/simple;
	bh=0xpmBh71Fh/79UPuTXgokTB6ZwjMlsmu8MbB4vmrNO0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hxf7AEOzuGEk3yPz+6oo7pcXiYaraifTkzRZs5jZbkXdktRO75L4PSsawd6mq+07SITcJb9qMJIsR/NqkMASywc2WkgkinSrMHfiYcteP4dSqCWgWF3z0dszpa63qEpfEvKXnNRBRS7IS5WuFPj+2dZKIb1lbNwRnOxwH2TNO0g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=E+vc7Mik; arc=fail smtp.client-ip=40.107.74.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yQWPILp5PS5FQb6O+vkdMfeEb8W4vDp3xVl7yoD7/k0dDmwt0m+sUyIUZu3shgcydEhNW+Cjfsp63G4Ib98H5xkWepdeD10wnaCPvyRoQqDKrR7Pec8jjkpW7kMeo5+rnG4sHOZwEDjsdNlkjDOJPl06FZYGvySSIqklDcKQeCU1sUTwbW+hy1hCPTa5jP/s1ifw5PdV9uQkZiOVS/16sDC9HCZX/Jwj0ZBpV6XTd3L+ecUXikYlhLvxR3JlZGIdjlzZG9IbHA10q/zTsIKILN6fKuiEFQhYkV+wOd+Lh1q9Yv7YTPhNtoeNBBZhPUPRK8v80i9nGqJOm5k06Y6XPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3LEX7b5xg+HdfFmE6nPY035fvGmiPhg2vF1ySA6tzkw=;
 b=r0UzmR253xcH6Pcfcz+wABddGAGxGaUM/n4VYp/VA/nAYBRRljJswpQGpqc3Dw5b8SuVQTDJgQhZaE7kwL6npitTJJiC51U+PE7wYtXHV4KP1+JZe8NB+ELsKTJptHf8t7zpNgcggxJl6ZcjmNvvt/hzgbyJqvWlL2RH/4Agnez16AJgxGoxTG7mjw/sK0ZoMs9X0kFOQdmOgj6YlHEHcGh6l7qJRFiaHnfpPo6hSqk94IEvtzj8C12lBW5kaFckI0eUx1YGnVUIyHbzSnAgUGIiOH5tcj2sgZGe8i45IcUx1dqPp47uX30VRpxvxItqDt9GJujGjooQ0MVkjjOuiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3LEX7b5xg+HdfFmE6nPY035fvGmiPhg2vF1ySA6tzkw=;
 b=E+vc7MikVv8kKVVzekcuvbXzJtAgkKfs/fU0bAX+cyDjQVVptpaLRdZVxQ3znz5P7kQEp1bw5U7ToI5pKZQsY7TkwuaNzhJFqzOhtvkXjpzbcjZsNCTueQcwkU1z7mXbJzace6ZDbJsaWChn04uKMEnZ/QJEkn3EpF0knYTI6Tk=
Received: from TYCSPRMB0009.jpnprd01.prod.outlook.com (2603:1096:400:18f::5)
 by OSCPR01MB12497.jpnprd01.prod.outlook.com (2603:1096:604:329::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.33; Wed, 23 Apr
 2025 14:05:11 +0000
Received: from TYCSPRMB0009.jpnprd01.prod.outlook.com
 ([fe80::8f8f:14d6:a759:4c66]) by TYCSPRMB0009.jpnprd01.prod.outlook.com
 ([fe80::8f8f:14d6:a759:4c66%6]) with mapi id 15.20.8655.033; Wed, 23 Apr 2025
 14:05:11 +0000
From: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
To: Fabrizio Castro <fabrizio.castro.jz@renesas.com>, Geert Uytterhoeven
	<geert@linux-m68k.org>
CC: Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Geert
 Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>, "dmaengine@vger.kernel.org"
	<dmaengine@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-renesas-soc@vger.kernel.org"
	<linux-renesas-soc@vger.kernel.org>, Prabhakar Mahadev Lad
	<prabhakar.mahadev-lad.rj@bp.renesas.com>, Conor Dooley
	<conor.dooley@microchip.com>
Subject: RE: [PATCH v6 2/6] dt-bindings: dma: rz-dmac: Document RZ/V2H(P)
 family of SoCs
Thread-Topic: [PATCH v6 2/6] dt-bindings: dma: rz-dmac: Document RZ/V2H(P)
 family of SoCs
Thread-Index: AQHbs62QelOf9EkojUWhlKcW69kenrOxIMSAgAAeErCAAAoW4A==
Date: Wed, 23 Apr 2025 14:05:11 +0000
Message-ID:
 <TYCSPRMB000972FF9EEBCF75D03FF919C2BA2@TYCSPRMB0009.jpnprd01.prod.outlook.com>
References: <20250422173937.3722875-1-fabrizio.castro.jz@renesas.com>
 <20250422173937.3722875-3-fabrizio.castro.jz@renesas.com>
 <CAMuHMdUKVDzLUfcr_0R_VQ0TzBtPWGVbwfX_pKbwOjzuaBLcEw@mail.gmail.com>
 <TYCSPRMB0009EAE305A3BC54E74D4A5EC2BA2@TYCSPRMB0009.jpnprd01.prod.outlook.com>
In-Reply-To:
 <TYCSPRMB0009EAE305A3BC54E74D4A5EC2BA2@TYCSPRMB0009.jpnprd01.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCSPRMB0009:EE_|OSCPR01MB12497:EE_
x-ms-office365-filtering-correlation-id: be340632-5340-4292-2a1e-08dd826fdcbf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?64z2RRp2UskFz2N5FHoi/EWBEwLeGT9ZjzFmVT+z9lHADZrt+FbYXhOklWh+?=
 =?us-ascii?Q?doqJ3EPJVBBvBLN8/PGg/ligjy2mIMlp8uVhSY8vKXqg6Qf76wPhQ/UJiSDB?=
 =?us-ascii?Q?eL07pcv3Ym+SSn8HzEmJBKknSa91lWfZhYE+zUU7UxlgFZnC57s6heRAdmdh?=
 =?us-ascii?Q?RbWBZceS0lDYzXq/LfkwxwSg8dvPRYfINjlTDeHh65tLD0JuxVXygQa1bqjN?=
 =?us-ascii?Q?N8M4W2aMaq5yJ5P/08mY0X0YlhqjSZ1WfxMejDGrOKHBNjo1ioGmW6m5kguk?=
 =?us-ascii?Q?zChLJPKpXjPKI1XrKCirqCxYn5sfDCRH/BTEKTVMoJyTjci5q3bAak2IR2Fy?=
 =?us-ascii?Q?6iGWXK8Iy/049RlIWb32d/aWBmYFY0ggVGjeD7e4n9L0PLc1hLB6+ELFL0Zx?=
 =?us-ascii?Q?hLz6EnIm0HVRr/7QsW8oJ+FM7XmhCws0Cm162VYeM6OJzcn1gMCy/V9gKJ7H?=
 =?us-ascii?Q?enyP2i6OSl4cRehXbHigTVlLYzpGTSbkdGCq0MUJAOg6Ry7qxu9e4qbkxppa?=
 =?us-ascii?Q?dja3iF7ac+O7mCt2oPAGeUzOJHMhcnlWjjnl43LEJBvBLsVPgnwXpRJDsupb?=
 =?us-ascii?Q?9xjdh5wHJOY/kYE6N7/O0nY9iIx/Ru9CQ1LmCdQAoDP2SfKRpMLGUnoOQxN5?=
 =?us-ascii?Q?EJ0zQ/+HX2DY7cAyUxZHRNwee0Kspdskl9aW85qfbacpbyc4JW5V6Mm5wwyy?=
 =?us-ascii?Q?/5S5A/O8UaNcjgUxoeBA8Htd3607TiJYXk7iPixuFZ2qgND+8YoxmIs5/aBC?=
 =?us-ascii?Q?IjN9ef7YYJ4azy7bz7da7m+2tl1+IbTZkcshrlbYwz9Y2ywv9ZYq/A8cTImF?=
 =?us-ascii?Q?fEGTBleNyEFJ/TBWuNmz+8PUS5PgOWpImi1dPZRelsV59HRRLoeBV0uIhd2y?=
 =?us-ascii?Q?Tdk5tlrPmrNqUD6WYn/KYtTUjxIYGMxUg+2+xhRVon28VjmJdip0nUiM7B8v?=
 =?us-ascii?Q?5qD5dG3cDNoUg/VLruzuK3tfLiG4R0iwAzj4BEQpdy/v0zrkhePR5Bq0Zz6C?=
 =?us-ascii?Q?uki4ArJFEUEUSEbDqUwTCB/odZf/uhmotOHxrDgblnhEjNcBWCbGm5PB5bg8?=
 =?us-ascii?Q?Dfa/V99H1pgdIYeYiXOz65erKXtZ0ePaJ6eu6t3AhjLonzsVnrBGjrOheUPX?=
 =?us-ascii?Q?Yw4Iz1N9TDZo72IcJdD3g/bowsgwrqwqFWmPMBEz2ks3uPc3ihz/Ri410onY?=
 =?us-ascii?Q?YBdxK8hYaQjwtckP/SgIsjGNINp0waRrp/mqrN/6JX8iE/lNUDOuOcyTcKQe?=
 =?us-ascii?Q?oZ7pOX23ePjdqMwoUG8xJUve+PaqK+vp5Gc/Rp2AYlOUcm+X2AIh1yblAvzr?=
 =?us-ascii?Q?Fw6vNT7fUvqaxUgjrluDcEbhkgtPfIQUwRZXtMpBRAi8ImEwrrB7XN5kiC3o?=
 =?us-ascii?Q?QJLHij6Ho1nnPVcbXE1vdfExoiweWfszQ0vfgb+0Zb5IxcDEXCKbhkUzISov?=
 =?us-ascii?Q?WG3sRSQ+saYljFVhQJcjdChjTawU/XGEBd3sVWwtszE1epod7UXhtg=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCSPRMB0009.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?WrjCSMh+alqLkE5gu0wB0V1KolbFQtc9U4foNVGbdeHBoSmJxpX2qe10+Q6Z?=
 =?us-ascii?Q?YytBiSYvGOqARf1rv/DvGUBbGcHB2GHNeRHUGyib9QhTaVR1Mi6dnrc0efP7?=
 =?us-ascii?Q?bvN9FCSYPjdHBCFqDwm8jMDju6iwUAkpph/gVURfP0HS49cRhdtyi8y+ph+E?=
 =?us-ascii?Q?oQEwiXx7vUYC7RpGD9o3nHFmMBeY4r6kd0fjB9Zg5zsieQRpJ3lrqNc0lH4P?=
 =?us-ascii?Q?/Pylr8JQV8lw+nOhkkYVHY8ZDixNDU881Q6vn37iW6oDGhfxjyfBXv6Js6TM?=
 =?us-ascii?Q?DrF6nZk3L14Uq8dG0RQiYEA/TnXVWsugXaCj9YVV43DeGsaEir9bjFf7ZLbJ?=
 =?us-ascii?Q?9rrg+o2h9s2mnaGp0ADevQ+7cCxg7ZyoHgkjEsE6zlPNOWmOWyERcq8zu7VD?=
 =?us-ascii?Q?05ejvPZ7LEV1b1cp48sRiNuXYEZ8d9Y/KQN6kcLiQn+Wg5vOBi9HCwYh5LFh?=
 =?us-ascii?Q?nlQf9y23yQnzgw0t8Dpqf/eUKYYy5VOfywrI2AbQcz5dzc/6ki7m62qpcXYm?=
 =?us-ascii?Q?lKO3PqR6UvR4BUjVVdgDk+4x7oVNh053MupzaeC6P5rDEnNX4cCxvhhcIpW3?=
 =?us-ascii?Q?qtq8qla5I8Mwv2+in75JxU6GWmCxPjJik8BlNBccP1oVBcAYfA1bcOhX48KI?=
 =?us-ascii?Q?pK10YOA8YVZdwR4qwIeEdpPIlZX18RvaViF72CRcmzEbWlrQqiQOFhE/K9rK?=
 =?us-ascii?Q?voQV78eBlmUW1vtXDVn/FVZrKQ6akKr5vxfBcuXwJgxn7H0KUbo6EMPaaaCH?=
 =?us-ascii?Q?LtVm1qFe7ht7sHAgCB0e2oYGR2t66c3PSj8nheggAImUeGzTNjO637nc4CR1?=
 =?us-ascii?Q?QaMtamdlPxJ0FAfbS79KnSIP+f+h4+kwHYbUZF9epJ5eil4QokH4J8jn/44I?=
 =?us-ascii?Q?ECIfX7x78PGZx/9M/lWUzOPkk3y6WeIt7aaUAVEpmViBM0M4W7f9bcJBSQUQ?=
 =?us-ascii?Q?I4b+gN/w2GNuwtYehRbO/8m073AddiHSyXCavrJlRzaumgXZSDIOQgUImr6q?=
 =?us-ascii?Q?8+f9DXExDyAt7fwKYD1CKl5cXgsJw+1T4TfuZ9US61tw0ncEtLTv+y+62Vze?=
 =?us-ascii?Q?BWXJX8Q5np0CvFC+2q6X1xz3W67QlpB5XGJlcXJMkkZXD9E3YPdKtnlIgRsn?=
 =?us-ascii?Q?m9Wa9CtDpfwdRV+DzNU2ZhYF7ZmVHYCJ3bIFLJL/RdIQG+UbhS5Q7eAQN/Hc?=
 =?us-ascii?Q?NHkhIJ1heuxv5LdOpU7BwJ7FanguvLwXSzf9Ap2UKUgSMA4UYj+F90ivpjgo?=
 =?us-ascii?Q?ELq9IQzn8QtbytcSCU4IwwUgs3dw5wthrlsvQ8wVNdM4E436Grpkuf68cQPv?=
 =?us-ascii?Q?7IMubvi7SxRQ/ReLVN0Uuu78KUneZeObJlEWTwWxViWM1pze6Vn5plGBmrqy?=
 =?us-ascii?Q?PDesmHJrJuRqeRt5NQBVMf5iHHnNZ+bDbsxxvebk7n24JZ85O4Nzaw+Mv1Dn?=
 =?us-ascii?Q?HPwoRy8K+tX10m9/CdynT9rHqkkkmJQ6MPdE6cquYfhswUaQK+mz1TFWE6eP?=
 =?us-ascii?Q?Vq19diefJ6oICf4s1oPNo9137b+zg1lSsIeNCOa1KHn+jNMbkmYGDT4cVMQ7?=
 =?us-ascii?Q?qqOujjIUdk2n371xVlvkFFy66pL8tlIaVnxSpkEoG7Ov7R3f05ZNLpVnBGtP?=
 =?us-ascii?Q?vw=3D=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: TYCSPRMB0009.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be340632-5340-4292-2a1e-08dd826fdcbf
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2025 14:05:11.2688
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 75PU5xi0m1xS/eoL3mwX+RykVD162PezvkWj+5i5vQQKz8FkRJApbmEiVQ0f7NT60kgy9O44Dd4B8BX4ovXfJ1m0dcqLvW5w1BnF/vlPSgA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB12497

Hi Geert,

> From: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
> Sent: 23 April 2025 14:27
> Subject: RE: [PATCH v6 2/6] dt-bindings: dma: rz-dmac: Document RZ/V2H(P)=
 family of SoCs
>=20
> Hi Geert,
>=20
> Thanks for your feedback!
>=20
> > From: Geert Uytterhoeven <geert@linux-m68k.org>
> > Sent: 23 April 2025 12:37
> > Subject: Re: [PATCH v6 2/6] dt-bindings: dma: rz-dmac: Document RZ/V2H(=
P) family of SoCs
> >
> > Hi Fabrizio,
> >
> > On Tue, 22 Apr 2025 at 19:40, Fabrizio Castro
> > <fabrizio.castro.jz@renesas.com> wrote:
> > > Document the Renesas RZ/V2H(P) family of SoCs DMAC block.
> > > The Renesas RZ/V2H(P) DMAC is very similar to the one found on the
> > > Renesas RZ/G2L family of SoCs, but there are some differences:
> > > * It only uses one register area
> > > * It only uses one clock
> > > * It only uses one reset
> > > * Instead of using MID/IRD it uses REQ No
> > > * It is connected to the Interrupt Control Unit (ICU)
> > >
> > > Signed-off-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
> > > Acked-by: Conor Dooley <conor.dooley@microchip.com>
> > > Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > > ---
> > > v5->v6:
> > > * Reworked the description of `#dma-cells`.
> > > * Reworked `renesas,icu` related descriptions.
> > > * Added `reg:`->`minItems: 2` for `renesas,r7s72100-dmac`.
> > > * Since the structure of the document remains the same, I have kept
> > >   the tags I have received. Please let me know if that's not okay.
> >
> > Thanks for the update!
> >
> > Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> >
> > > --- a/Documentation/devicetree/bindings/dma/renesas,rz-dmac.yaml
> > > +++ b/Documentation/devicetree/bindings/dma/renesas,rz-dmac.yaml
> > > @@ -80,12 +85,26 @@ properties:
> > >      items:
> > >        - description: Reset for DMA ARESETN reset terminal
> > >        - description: Reset for DMA RST_ASYNC reset terminal
> > > +    minItems: 1
> > >
> > >    reset-names:
> > >      items:
> > >        - const: arst
> > >        - const: rst_async
> > >
> > > +  renesas,icu:
> > > +    description:
> > > +      It must contain the phandle to the ICU, and the index of the D=
MAC as seen
> > > +      from the ICU (e.g. parameter k from register ICU_DMkSELy).
> >
> > Doesn't really hurt, but this description is identical to the formal
> > description of the items below.
>=20
> Okay, I'll drop this description, and I'll keep the description for the i=
tem below.

Actually, I cannot take this out:

	'description' is a dependency of '$ref'
	'/schemas/types.yaml#/definitions/phandle-array' does not match '^#/(defin=
itions|\\$defs)/'
		hint: A vendor property can have a $ref to a a $defs schema
	hint: Vendor specific properties must have a type and description unless t=
hey have a defined, common suffix.

I'll rephrase the description to:
It must contain the phandle to the ICU and the DMAC index as seen from the =
ICU.

Thanks!

Cheers,
Fab

>=20
> >
> > > +    $ref: /schemas/types.yaml#/definitions/phandle-array
> > > +    items:
> > > +      - items:
> > > +          - description: phandle to the ICU node.
> >
> > Phandle
>=20
> And I'll amend accordingly.
>=20
> I'll send a new version shortly.
>=20
> Thanks!
>=20
> Cheers,
> Fab
>=20
> >
> > > +          - description:
> > > +              The number of the DMAC as seen from the ICU, i.e. para=
meter k from
> > > +              register ICU_DMkSELy. This may differ from the actual =
DMAC instance
> > > +              number.
> > > +
> > >  required:
> > >    - compatible
> > >    - reg
> >
> > Gr{oetje,eeting}s,
> >
> >                         Geert
> >
> > --
> > Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-=
m68k.org
> >
> > In personal conversations with technical people, I call myself a hacker=
. But
> > when I'm talking to journalists I just say "programmer" or something li=
ke that.
> >                                 -- Linus Torvalds

