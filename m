Return-Path: <dmaengine+bounces-9633-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KEhgKs/nwmnnnAQAu9opvQ
	(envelope-from <dmaengine+bounces-9633-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 24 Mar 2026 20:36:47 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 45C6431B9AC
	for <lists+dmaengine@lfdr.de>; Tue, 24 Mar 2026 20:36:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 716CB305E37D
	for <lists+dmaengine@lfdr.de>; Tue, 24 Mar 2026 19:29:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90B642EFD95;
	Tue, 24 Mar 2026 19:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="MVXVmAra"
X-Original-To: dmaengine@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011019.outbound.protection.outlook.com [40.107.74.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DBA923EAB4;
	Tue, 24 Mar 2026 19:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774380559; cv=fail; b=YEwgpDuakUh01DYYNVfd5pj4wQGLwPeOSzgEuwmr0XkdUetWxmZcl3ujcCXiZetVqvp/1fs2N9ZfSo460+IIqon+g8pkYsgLsHjZl3jlBoIaEs6ahLC5YtHc9RBCVSV2nPJkwRqLN0zaPtBT0RkdGw+CXRIf/IMs9Fr4mTUdyNY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774380559; c=relaxed/simple;
	bh=cD4f53Bwu6y8umvmjixjMxkc0mTDD83sd9qApXYPu6U=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=m1sOH2OgXYKjxnVM4+/b+/sczzcP8GT47lKOWFuSZmHFXm+3usG44KJI+79j9iX7tdnFDq8vSkVhduqGm/FOAgRiGgxPdqS5kdBn0NrT/FYZ8vaWbQLR5E6P5a7n0/Jx08fkr7gGKldn52aC7tCMOd00bl7Av+BSOVaBUHuX8uI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=MVXVmAra; arc=fail smtp.client-ip=40.107.74.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MYYdLPlFQtZcQRqC6sdwKY+jjdYV3FaYFHbkV79zU3cvszHLI+ilaq56o7VEauZPkBB8/A5Ub/ptOA2JurINFZVmrDFSy9YEPPSQqHKc06S1I191693q0+/L+wPtpdHy/+1VMyi92H3O0F+8CW8ZJmiZgkw5mspAL5xN2p2igF8M44QKk1KoU6GDDSDzsf0OH38UKENrXnLyN1elFJeNtiWfaMeM2wwpo7oxvX5WyRr0o7GET6pljqCgMFiFTRJiWbrmrjLERU+EAkpxQwpuyF+mDPuP7lYTcKGuorYa597yYttWfqjU1VtV0l+iND7pWqBErFtMnxATRtCagonrBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uqIpjfHDoyxS+uBcfyfvbSK97C7mcQkisv5l0VD/UbQ=;
 b=OSFzjbd01+M2AaO+U8UnQAFaIRprEGcNy2CWCjmPnnr8cNIqBMHp4UtV/VudsddsW4x7cUK919LmqfYAMB7sr6hWRNpjX+NIAntgbsSZKczWwZ+3UB8tSFubBzBvyWzTGJt17zxP+arBOKlAcVjBWbEA/uLyLq+u105UgqksjBanRUhal7/M6oiH2pY/uBYgOg/CzhzgpD3Q+qSqRVa/hxXiXXuYGV+XMfFkZhAvV0uYKflQqL+Wna1fSDLG06+BoQlUQKdGay//SwaXuSEsqm9YJdTl6g0oGBcLAmniUNMNZP5DBka9b2fHkFzIN4ud1kyjfRIfTzdrCQuwqO1gPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uqIpjfHDoyxS+uBcfyfvbSK97C7mcQkisv5l0VD/UbQ=;
 b=MVXVmAradFVo9g0s/qA4Eib5Qn4xbNX6JLFNQUeoGfNxWqTcC02wg7ojzNlWBEU4BFWnyu7Xb3W+yaAxmJwafSVyz6gTkUmzNOr0nERhFR+H62M3dYZt07NSl4HfOD0Dbkvb65G0sTdJooMFHayyZy6t2oPXq9zGG0uPPatIxRQ=
Received: from TY6PR01MB17377.jpnprd01.prod.outlook.com (2603:1096:405:35b::6)
 by TYWPR01MB9904.jpnprd01.prod.outlook.com (2603:1096:400:231::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.31; Tue, 24 Mar
 2026 19:29:12 +0000
Received: from TY6PR01MB17377.jpnprd01.prod.outlook.com
 ([fe80::f373:26d6:86c4:6aa3]) by TY6PR01MB17377.jpnprd01.prod.outlook.com
 ([fe80::f373:26d6:86c4:6aa3%4]) with mapi id 15.20.9723.030; Tue, 24 Mar 2026
 19:29:12 +0000
From: John Madieu <john.madieu.xa@bp.renesas.com>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
CC: Geert Uytterhoeven <geert+renesas@glider.be>, Vinod Koul
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
Subject: RE: [PATCH 17/22] ASoC: rsnd: Add system suspend/resume support
Thread-Topic: [PATCH 17/22] ASoC: rsnd: Add system suspend/resume support
Thread-Index: AQHct7kQYSFMtxPUkEOF6ijzqVYsOLW7YVIAgAKz2tA=
Date: Tue, 24 Mar 2026 19:29:12 +0000
Message-ID:
 <TY6PR01MB17377203552FF28EB7DCDA071FF48A@TY6PR01MB17377.jpnprd01.prod.outlook.com>
References: <20260319155334.51278-1-john.madieu.xa@bp.renesas.com>
	<20260319155334.51278-18-john.madieu.xa@bp.renesas.com>
 <878qbj9uk7.wl-kuninori.morimoto.gx@renesas.com>
In-Reply-To: <878qbj9uk7.wl-kuninori.morimoto.gx@renesas.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY6PR01MB17377:EE_|TYWPR01MB9904:EE_
x-ms-office365-filtering-correlation-id: a76c547a-135f-4211-4962-08de89dba11f
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700021|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info:
 2krBIg8o3Sp/5PsLzT+eudgxjZAt/IW6foGB+AaI+UlQ7oABOqcIoOiCat+xTlUNeyjYEy3AfYAQlvkYQJYwVdwLB8reHq24XoF8vIPNjBiQtVtCX/NDU86NBwcciszpuAryyNzSMIwG29SVi4Ci2xQCeKu4l1Dnh/+9GEXVIvztFknGGB4O1LoVEczT1rYyZ9ewNAGJhHZR5422GEigYzkG+8r6DV7FQAOXDSPBG1XIZLm7qoW0AtbLbYBkUa92euhLI6Chvv0Nkf8u4YK3syw0ZNk3skz0BIkHizqFQL67mBmgmQzxYnS7vG/v4qqotLUziICGedaLreqXgsJfPhkNmLyiuq9p1ORwhNnCpU81xFbZuZzUy7ldBH6miGd94ZVIwHdbbiN4t5MpLc3rfknhtnMAbiZlu10MJ01Zs1N3TkrkWXPywb1HzTk0F/w9H7BekI0SDymmN2zf/Rx94KLS8x2DKAngZ8VHXl50zHyrudXUvldOIpxu+Hb5DlNfrJ+k7ZrQlF6RYNQmyGQFJwkqRzLdPi4vTDRsyRI42bsKR0tMw4wA/W3syb8o4sTLfIqeZYEYHu8PboZ95c3GKzbxigRF/Ron0Watz5vPRENra6ZKI22vO+45I7R/TiVpzcbLqY35vfYT/LBR+lDeFh35/HeBH9tT3HXHuKS1UOFNdDdyEIPLmKhCklgN0/AP5zKRS9yhVox8B4SQHyUNri+lI62hjIXk1anhfOOIe+mFjkVuJwSBX5zaue3pTT7/P5pDxRQt82aG7zR3xXpv1nzukqyEL+E2jOulA/Kh6bI=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY6PR01MB17377.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700021)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Q4xAw15g9UeciSOPoGozN9zVeP3WIChAgVMrY3LVo3Mzw68ie9vp2RCI1oDN?=
 =?us-ascii?Q?oNlwsJcSGIuQq1QZiE86Uy5alaCs/7L3dS64bI78B/2MiDs3iqNGgUfmHYl2?=
 =?us-ascii?Q?nYF5REcrlaxzFdGvsW+3KHu+Ow6C7tvBG7vNe8Do45e95ZIAGJHfDLQjQKix?=
 =?us-ascii?Q?H0nrj6m8apKy1qDovYXqEW+eohnTy8ybh7kQ8T0jPcSiv0DSvPFRvtUxZz5Z?=
 =?us-ascii?Q?KXquSgGTcXKixRenw+JpL0mFZz1a8z0ooJpNTizZf+2/imPt3Wk4Xt7Lsqfl?=
 =?us-ascii?Q?30/OYWSXKDFq4Pj0tQWxEl2uj8I+hvWO13xJewTz/7JYeTwiv2Mtzofi1Kqm?=
 =?us-ascii?Q?iDlDy88rJ33UsZdPm/hHakktquQXIErh77oRMgVj3Ii8BRRyIlHrqUjw+2+n?=
 =?us-ascii?Q?uJ5DsyNKBidw3ufB7FCDYYHEJfj3hx2vprjMw/RNv9jOcmGZKoq6b7dcRSMa?=
 =?us-ascii?Q?7hvB8RkcVNyNXnZcwIXWX2O9MYCynUoM50u7l05I8d3kSBc5GflNTCC024+S?=
 =?us-ascii?Q?nF5Qdu0/Jkv6+O1NbRwhbz7L1RDvwo/YzeY9dG8x4GPwY+xJN/OS+YOVPrVh?=
 =?us-ascii?Q?ihYCNBHlmY1d4EQJeo0UHvw2bDVLXwnr+vmWg0oRADwht1ykWCT4sd9JPeix?=
 =?us-ascii?Q?0ODz8in9uQEarElWE6Bi46a2wPYhXdf6Q1BZx9cqhj7PKjiV0XC9w3PV/R24?=
 =?us-ascii?Q?UumtAoegavZeo6Ex/nuRbfQ1V+SRux8UcGGNFEjU39u1f1mf7F6tVHezf7R5?=
 =?us-ascii?Q?B/C69byM6diKY6ibEJbSmJB4ejvK/HQ3M8sI93XOs/y7ATz9V6nvlWdyrZwb?=
 =?us-ascii?Q?Q7Bnaq//UU9WKwW81M7FNwwBtLsGJP72Wh43pXpUZieF5RJtHieVAzEWBOeo?=
 =?us-ascii?Q?DeqTve6kNxnluv+olezpPTFeGgrhlQeb5ybufI1f9AlMSfNvyQejCrlVupqn?=
 =?us-ascii?Q?k7f5OS7q7YlAoVnsgAUaXVoDME58yZMaXTju0NfGXqQM6S8Uot1WWEOVE9f1?=
 =?us-ascii?Q?Ne/Hb0q8KeYqzoRBYpmjcuwV6qA0GsQeFK7wF3uVpHuW99igAQ4kwJHW1yIW?=
 =?us-ascii?Q?27/IK04CMX6ajAf8sSWboitpwZK/V0ZwfxwMgd3zrAInhjCqhjRrIhRFpNss?=
 =?us-ascii?Q?+BbDAqxA8Q0Am9ASFep+hUGhxWvAWct/OwIHtyaZbY7ElC61ft2gkV/lGIw5?=
 =?us-ascii?Q?s6fMOiIQ6qoJ1HOfZFlTcplcL8fUBmEt6keLbkQjVESf7RJVJ7tGZVdfOWX3?=
 =?us-ascii?Q?qqM6Laj6V9ZzrMZrSGn5W0IaMmuH4wlTir06vCxv1wqywcBa/Be9waawMjKl?=
 =?us-ascii?Q?HgPPYzFqlh96HgtD+dTuAIfbk/QG+lQOcQ+GzKkhHVWv+dhi/He4mn0cPGDg?=
 =?us-ascii?Q?G6hLQEmCkrr678AGzGjetqAVWXKrBD+9Zg2cSm3PKrAffhqbPgC/56ikgMMg?=
 =?us-ascii?Q?3w0pOtNQcCFEityCi3h1U7gr1mqF+csIV1fM7iHCQDFUbyp1vWtnuL2G/XEU?=
 =?us-ascii?Q?1Y3+eXtNORn5r4Y0pBnRE8OotzJaJHWHrz4huVcnmexZWecjTe3DPmAfOpTc?=
 =?us-ascii?Q?dr/TZ/jiT52IJjb4er+peqzJ1T8x1T1W+vT879Cr9aK0IzjYTaT54Ah5c6oi?=
 =?us-ascii?Q?2Uxf5Rovjip5spTp4ZkJtgQe0etOoVq2u4Uowm6l6WhezKUdBibB7PNiD7hN?=
 =?us-ascii?Q?vPMWnChITaVGBHlW5iRLHd3koQsBT2sCTX2lQVtQGoW0H9q8BSB1Hmh1ps3Z?=
 =?us-ascii?Q?Ij9cpTY+saDvxYbXVyrQXgm0Fuxzq2o=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a76c547a-135f-4211-4962-08de89dba11f
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2026 19:29:12.6641
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GHHtn2wlYkabFM6ipngJBx4eD6ICAa2RlYbsZlMyIaBwRWvciqrt7ioNftN/zb9ACgUaw3NUrmQB/+Pw3yJlQYVfbeeOT3IaHh0tX+LUb7Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB9904
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
	TAGGED_FROM(0.00)[bounces-9633-lists,dmaengine=lfdr.de];
	FREEMAIL_CC(0.00)[glider.be,kernel.org,baylibre.com,gmail.com,perex.cz,suse.com,pengutronix.de,tuxon.dev,bp.renesas.com,renesas.com,vger.kernel.org];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,bp.renesas.com:dkim,renesas.com:email,TY6PR01MB17377.jpnprd01.prod.outlook.com:mid]
X-Rspamd-Queue-Id: 45C6431B9AC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Kuninori,

Thanks for the review.

> -----Original Message-----
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> Sent: Monday, March 23, 2026 2:57 AM
> To: John Madieu <john.madieu.xa@bp.renesas.com>
> Subject: Re: [PATCH 17/22] ASoC: rsnd: Add system suspend/resume support
>=20
>=20
> Hi John
>=20
> > On RZ/G3E and similar SoCs, the audio subsystem loses its state during
> > deep sleep, due to lacking of proper clock and reset management in the
> > PM path.
> >
> > Implement suspend/resume callbacks that save and restore the hardware
> > state by managing clocks and reset controls in the correct order:
> > - Suspend follows reverse probe order
> > - Resume follows probe order
> >
> > Note that module clocks (mod->clk) are left in "prepared but disabled"
> > state after rsnd_mod_init(), so suspend only needs to unprepare them
> > and resume only needs to prepare them.
> >
> > Signed-off-by: John Madieu <john.madieu.xa@bp.renesas.com>
> > ---
>=20
> If my memory was correct, besically, all mods (SSI, SCU, etc) will be
> called with SNDRV_PCM_TRIGGER_SUSPEND/RESUME when suspend/resume.
> So they are basically automatically stopped when suspend, and
> automatically started when resume. see rsnd_soc_dai_trigger()
>=20
> We need to care about ADG when suspend/resume because it is always ON
> device. At least on R-Car.
> If you need special handling for RZ, you need to care whether it is R-Car
> or RZ, etc.

You're right. The ALSA framework already handles per-module stop/start
through SNDRV_PCM_TRIGGER_SUSPEND/RESUME, which calls each module's
.quit/.init (and thus rsnd_mod_power_off/rsnd_mod_power_on).

So the per-module clk_prepare/clk_unprepare cycle in rsnd_suspend_mod/
rsnd_resume_mod is unnecessary.

What RZ/G3E actually needs beyond the existing ADG handling is:

1- Reset handling for modules that have reset control
2- audmac-pp clock/reset toggle (infrastructure, like ADG)

However, there is no need to make these changes conditionally
based on SoC family as the optional clock/reset APIs are used.
Do you find any issues with my approach ?

Regards,
John

>=20
> >  sound/soc/renesas/rcar/core.c | 108
> > +++++++++++++++++++++++++++++++++-
> >  1 file changed, 106 insertions(+), 2 deletions(-)
> >
> > diff --git a/sound/soc/renesas/rcar/core.c
> > b/sound/soc/renesas/rcar/core.c index 6a25580b9c6a..eb504551e410
> > 100644
> > --- a/sound/soc/renesas/rcar/core.c
> > +++ b/sound/soc/renesas/rcar/core.c
> > @@ -962,7 +962,8 @@ static int rsnd_soc_hw_rule_channels(struct
> > snd_pcm_hw_params *params,  static const struct snd_pcm_hardware
> rsnd_pcm_hardware =3D {
> >  	.info =3D		SNDRV_PCM_INFO_INTERLEAVED	|
> >  			SNDRV_PCM_INFO_MMAP		|
> > -			SNDRV_PCM_INFO_MMAP_VALID,
> > +			SNDRV_PCM_INFO_MMAP_VALID	|
> > +			SNDRV_PCM_INFO_RESUME,
> >  	.buffer_bytes_max	=3D 64 * 1024,
> >  	.period_bytes_min	=3D 32,
> >  	.period_bytes_max	=3D 8192,
> > @@ -2059,11 +2060,70 @@ static void rsnd_remove(struct platform_device
> *pdev)
> >  		remove_func[i](priv);
> >  }
> >
> > +static void rsnd_suspend_mod(struct rsnd_mod *mod) {
> > +	if (!mod)
> > +		return;
> > +
> > +	clk_unprepare(mod->clk);
> > +	reset_control_assert(mod->rstc);
> > +}
> > +
> > +static void rsnd_resume_mod(struct rsnd_mod *mod) {
> > +	if (!mod)
> > +		return;
> > +
> > +	reset_control_deassert(mod->rstc);
> > +	clk_prepare(mod->clk);
> > +}
> > +
> >  static int rsnd_suspend(struct device *dev)  {
> >  	struct rsnd_priv *priv =3D dev_get_drvdata(dev);
> > +	int i;
> > +
> > +	/*
> > +	 * Reverse order of probe:
> > +	 * ADG -> DVC -> MIX -> CTU -> SRC -> SSIU -> SSI -> DMA
> > +	 */
> >
> > +	/* ADG */
> > +	/* ADG clock disabled via rsnd_adg_clk_disable() -> adg->adg */
> >  	rsnd_adg_clk_disable(priv);
> > +	rsnd_suspend_mod(rsnd_adg_mod_get(priv));
> > +
> > +	/* DVC */
> > +	for (i =3D priv->dvc_nr - 1; i >=3D 0; i--)
> > +		rsnd_suspend_mod(rsnd_dvc_mod_get(priv, i));
> > +
> > +	/* MIX */
> > +	for (i =3D priv->mix_nr - 1; i >=3D 0; i--)
> > +		rsnd_suspend_mod(rsnd_mix_mod_get(priv, i));
> > +
> > +	/* CTU */
> > +	for (i =3D priv->ctu_nr - 1; i >=3D 0; i--)
> > +		rsnd_suspend_mod(rsnd_ctu_mod_get(priv, i));
> > +
> > +	/* SRC */
> > +	for (i =3D priv->src_nr - 1; i >=3D 0; i--)
> > +		rsnd_suspend_mod(rsnd_src_mod_get(priv, i));
> > +
> > +	clk_disable_unprepare(priv->clk_scu_x2);
> > +	clk_disable_unprepare(priv->clk_scu);
> > +
> > +	/* SSIU */
> > +	for (i =3D priv->ssiu_nr - 1; i >=3D 0; i--)
> > +		rsnd_suspend_mod(rsnd_ssiu_mod_get(priv, i));
> > +
> > +	/* SSI */
> > +	for (i =3D priv->ssi_nr - 1; i >=3D 0; i--)
> > +		rsnd_suspend_mod(rsnd_ssi_mod_get(priv, i));
> > +
> > +	/* DMA */
> > +	clk_disable_unprepare(priv->clk_audmac_pp);
> > +	if (priv->rstc_audmac_pp)
> > +		reset_control_assert(priv->rstc_audmac_pp);
> >
> >  	return 0;
> >  }
> > @@ -2071,8 +2131,52 @@ static int rsnd_suspend(struct device *dev)
> > static int rsnd_resume(struct device *dev)  {
> >  	struct rsnd_priv *priv =3D dev_get_drvdata(dev);
> > +	int i;
> > +
> > +	/*
> > +	 * Same order as probe:
> > +	 * DMA -> SSI -> SSIU -> SRC -> CTU -> MIX -> DVC -> ADG
> > +	 */
> > +
> > +	/* DMA */
> > +	if (priv->rstc_audmac_pp)
> > +		reset_control_deassert(priv->rstc_audmac_pp);
> >
> > -	return rsnd_adg_clk_enable(priv);
> > +	clk_prepare_enable(priv->clk_audmac_pp);
> > +
> > +	/* SSI */
> > +	for (i =3D 0; i < priv->ssi_nr; i++)
> > +		rsnd_resume_mod(rsnd_ssi_mod_get(priv, i));
> > +
> > +	/* SSIU */
> > +	for (i =3D 0; i < priv->ssiu_nr; i++)
> > +		rsnd_resume_mod(rsnd_ssiu_mod_get(priv, i));
> > +
> > +	/* SRC */
> > +	clk_prepare_enable(priv->clk_scu);
> > +	clk_prepare_enable(priv->clk_scu_x2);
> > +
> > +	for (i =3D 0; i < priv->src_nr; i++)
> > +		rsnd_resume_mod(rsnd_src_mod_get(priv, i));
> > +
> > +	/* CTU */
> > +	for (i =3D 0; i < priv->ctu_nr; i++)
> > +		rsnd_resume_mod(rsnd_ctu_mod_get(priv, i));
> > +
> > +	/* MIX */
> > +	for (i =3D 0; i < priv->mix_nr; i++)
> > +		rsnd_resume_mod(rsnd_mix_mod_get(priv, i));
> > +
> > +	/* DVC */
> > +	for (i =3D 0; i < priv->dvc_nr; i++)
> > +		rsnd_resume_mod(rsnd_dvc_mod_get(priv, i));
> > +
> > +	/* ADG */
> > +	rsnd_resume_mod(rsnd_adg_mod_get(priv));
> > +	/* ADG clock enabled via rsnd_adg_clk_enable() -> adg->adg */
> > +	rsnd_adg_clk_enable(priv);
> > +
> > +	return 0;
> >  }
> >
> >  static const struct dev_pm_ops rsnd_pm_ops =3D {
> > --
> > 2.25.1
> >

