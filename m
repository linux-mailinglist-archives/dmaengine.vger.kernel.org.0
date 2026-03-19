Return-Path: <dmaengine+bounces-9549-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id v1pqMY5EvGkJwQIAu9opvQ
	(envelope-from <dmaengine+bounces-9549-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 19 Mar 2026 19:46:38 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 7788F2D1418
	for <lists+dmaengine@lfdr.de>; Thu, 19 Mar 2026 19:46:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CD6533010B71
	for <lists+dmaengine@lfdr.de>; Thu, 19 Mar 2026 18:46:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 558452D8DCA;
	Thu, 19 Mar 2026 18:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="sgu4X4qC"
X-Original-To: dmaengine@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011056.outbound.protection.outlook.com [40.107.74.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A7CA2D8399;
	Thu, 19 Mar 2026 18:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773945993; cv=fail; b=F1hOCPep/k2h3aUOEqV5269enwBUXv86XE/EDeK569uj8vrhaXqMaqyB4WQdg+/gyPjAUb+FsWdfTeo3ipfU69hghjUbn/KKR1PDWZkTq9mtDLQu5aNhz8v9cWWrHH4pxeIZ9vW1ZFJzyEsIORcaf5enrtVqN3I2LhEq7Okytl4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773945993; c=relaxed/simple;
	bh=Icx54nsjQTQJih4x4OPLYGxlfpIbyjFM8id9iiMquCs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qpPiVnkVdGeC/z1Vr9W2erk6oKVOArid9FWXNKZijNXLyU6x5XB+Npx57dS6Q6h1q5DDPNhJ5YNweHw+Tm9ld9OZHIbyD0WvWyNZ+IshliTBG0OXv1tNvX+AbL8FH/l3pnl0pgufwkOfIwtmkJTIyAkIr5RTPdkTbYsN3gZLg88=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=sgu4X4qC; arc=fail smtp.client-ip=40.107.74.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HZBwAZ6v50E6A9IACAcDhVbZlbpnkvqoZN1E/UJWqo0I+iOHG+eUAhKnOeme6GmX5JK2dEzXGBMa6HMEicXajGvyozNBMS8hHIdFoApgQ8h+Q3J0ZBWyfC258rNBjS2Cn6jwlDPW/Ag7Y6rCw3gRdwXYl9ziT9Otk6X7dkzqN2j83nfDABYLsUlJmh0fYVCf1iM+5zfqwGIidjTh5PPoPxuZGDW4MiDkCRl+EuquzKljiGUyyhPfsGTRe0VtA0K+0Iivo1WO+lUW4cA61fCe+DQJXZ+dz0NoyZCyde8sUa+sb2Z0uPL9pflxzbuculxGKBIhZJ2RGhbGLDOv+hr4fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ajemoK3H71RlcjholOsb3YY1cEtGvDEIjBVt3L+aV/I=;
 b=EZJilST9I1mKWa17K/e1OqaRO3QuwFdbcbi9B2BkCti0rQq67ikVSXKy8V+ciw8bLnEAu1AsaLbosd/++V/y0Y4HAsGkH9K7Q0JaNaCHHt+SV4BQ2gpPeqEK5oB9AcuyG5ba8Tqeq5C2AJUUN5J3RGWPl7Acn254fMyJLRrKtWHp5vyBFwAGV7KEQSzR0BOXdEwzciGvcnJ9mFv8Hxlst/CY3RvwRQ/y/Sso282rjB2qpMRBuJjA4yMUpFUC2D6PdAaVX2kC6RNO8ieCIgRXVA0yF/f6S9QT3gehuRow9hnBCWQZjc521X5KyjSib5tvNSZLlGMoA8QTXY0glUS+Kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ajemoK3H71RlcjholOsb3YY1cEtGvDEIjBVt3L+aV/I=;
 b=sgu4X4qCgVJ6euxtluJXopTjIjoacGcU8JXogDWuRMEOh9BJwTlQlX+uveFhQaJlpI0E42pg0ocG8vmPq3q6/ENqXDSDxRzmU6e1/9E96vmHJFUQfTC27Bmdqq8bvaNFxuhWpnVMQczAltFb39gX642jJVqvibFxglYy5WRpUVk=
Received: from TY6PR01MB17377.jpnprd01.prod.outlook.com (2603:1096:405:35b::6)
 by TY4PR01MB13332.jpnprd01.prod.outlook.com (2603:1096:405:1d8::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Thu, 19 Mar
 2026 18:46:26 +0000
Received: from TY6PR01MB17377.jpnprd01.prod.outlook.com
 ([fe80::f373:26d6:86c4:6aa3]) by TY6PR01MB17377.jpnprd01.prod.outlook.com
 ([fe80::f373:26d6:86c4:6aa3%4]) with mapi id 15.20.9723.018; Thu, 19 Mar 2026
 18:46:16 +0000
From: John Madieu <john.madieu.xa@bp.renesas.com>
To: Mark Brown <broonie@kernel.org>
CC: Geert Uytterhoeven <geert+renesas@glider.be>, Kuninori Morimoto
	<kuninori.morimoto.gx@renesas.com>, Vinod Koul <vkoul@kernel.org>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Michael
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
Subject: RE: [PATCH 00/22] ASoC: rsnd: Add audio support for the Renesas
 RZ/G3E SoC
Thread-Topic: [PATCH 00/22] ASoC: rsnd: Add audio support for the Renesas
 RZ/G3E SoC
Thread-Index: AQHct7ixkWVMq6xq/UKX3UnPZEFuJLW2CY+AgAAVrMCAAAjtAIAACYwA
Date: Thu, 19 Mar 2026 18:46:16 +0000
Message-ID:
 <TY6PR01MB173779BDE4BE11739D3B7DAACFF4FA@TY6PR01MB17377.jpnprd01.prod.outlook.com>
References: <20260319155334.51278-1-john.madieu.xa@bp.renesas.com>
 <b2347c14-7f29-4453-938b-8287f45aa5fd@sirena.org.uk>
 <TY6PR01MB1737704E431A765933FA6D097FF4FA@TY6PR01MB17377.jpnprd01.prod.outlook.com>
 <c5ecd391-5a58-411b-8a58-03e6fdc0aa5e@sirena.org.uk>
In-Reply-To: <c5ecd391-5a58-411b-8a58-03e6fdc0aa5e@sirena.org.uk>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY6PR01MB17377:EE_|TY4PR01MB13332:EE_
x-ms-office365-filtering-correlation-id: 764d7fb4-e8de-467f-9f48-08de85e7cd42
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|376014|1800799024|56012099003|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info:
 A9Wb79aU4rn3AkUYW8FQ3G2w/ECJkMApqIhjAOfGa4uyi60HIUvWW+mC8tu8HIsz3/U8LbwV2FqB6eOvDhWaajshV2DViDaTmBC1HJo9r/cWGU2pc/9xvoeyH7hrs3ou9/b2rCDYwCANyZ+Iq5zvHwet8L137IEZeUnS2vVJFkBNriQNd+6QPWw4VxZgDz24OCGFuE6+5Gz4qJwsF5Woeh6RRyhnSAAAJZduC3KePalTK6xj57AUH6nnQ58Skb75q91FQ4EFdVM0U72P5t0JsC1n3dhqZlAYx0cNliR+UeyVB9KliwXuCaE4+PS1JKX0efzFHo5+VGhJ9ZSsf5476IihJLfeObPUEO3sK6NKyqMZQHk7WMeqnV6+prIbWlmt0LUNt0bbIOI9NhW+cPlwugMhAQsPburA1DzVJQEF4ZI+xvhVKyNW0Q2gJCTp1aOeTAlOCkBV8G6OXQQ1c2oRvmNsd/2mQZZstQz04C/fO2JJelBEFt1NfVZoL6xjS/s0JQITubcs10WItcoyqq1kqqzYCXrCsCNweYpQGG6KoAkrItL11nf7Xjgz1vtkVH437nJ4ZdElRIDPivXDOlQ5lzJRF7dKsFOhQXpoobkam1MLH9QLs4448qtIYaP85P+1scbl/aLyr3ZCKYqLc8wHMv7Vlwp0YK2aVegFn0izipGbztOsISlUenDZUtilg7JHplZzpCYi1Sx15UZT9LYN5G91xTZaU7jVpM8AMgm1BK+Otsn+jolo2zGvOKnmQ2J8CQXG0gnfBQj7pstsPvGuSOMvvVnEOLz3I97vgUGfy68=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY6PR01MB17377.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(56012099003)(18002099003)(22082099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?ZH5o+uXBkzbGwBnomJdABIN+ChnIIE13TwlkxKqeUVDptC2wEtm9fOqnd0gT?=
 =?us-ascii?Q?XJhLVZBFnDk+bbuvqoXi1c6X5jM9/hxbXYCPPmmLwXkKLxGkR5Z6yNCOBVEY?=
 =?us-ascii?Q?ZRLR96bCbcRUR5qQiNeM4gLM/7rnbxL8N1vC+eds54AmrS/ZzGruKOecw1bS?=
 =?us-ascii?Q?gD/PHDA7lbeSohmuB1o9Jv5aJYIihECyLVoBf6YtWDzRbG9H4izvT52udbCM?=
 =?us-ascii?Q?UK7DKhIsN0+U3LlnqLPCJ8i0UEBzSqW7qGX+2w7qsy21bFXDTn4Uu4q9EIeb?=
 =?us-ascii?Q?gWYpTjmaNBNNP21vPH+VRU7HpdTr5sWg0TsysFgl4dQQwgSpTjRvY0b/E6uS?=
 =?us-ascii?Q?9uOTswHDRp59E3cSLXb2aL96wscToQfDQKhy8NY1NZjz7waRv/hFuZclqpK0?=
 =?us-ascii?Q?prlapILgKzUOnmIFVbnVcPpOFMJjRV99VJtCcTS0+WuRnyqK9JCxkPt0m0jd?=
 =?us-ascii?Q?6bgLpBxCwWpYjxI5cBunWV/tfZu/1Zc7TfSvSP0bO6j+ehgHMChHSQLuQ54I?=
 =?us-ascii?Q?+KgU7lxrGC6iNv9641O1ZNLvJkiCoNy+rJ7h3NYD+yYXON2uLzfoMb0jFHYI?=
 =?us-ascii?Q?EdONc31IDfPlVS12JBZlwE1rxVqubOYGGZ1Xu+mjV+r0ewnO85EVMKpxl90y?=
 =?us-ascii?Q?0WBpFSnUtaqBE1kDMGiRflWL+hDc8KFKu3IHsqHe+Ec2Qm/j1Pa5i4T5fDmP?=
 =?us-ascii?Q?G5gvFWYH2b5o53/ObNZZUkNU/CaNEmJ8nRdpWhQdNr9TxKSkjea1+paHPk1N?=
 =?us-ascii?Q?pzMAUNKmqa2eHhcqD4xxEvCVCVyxMeW1BkD980UdLPZArYzQSRQ8g41UOXt8?=
 =?us-ascii?Q?w7VfWh+RyqFiFqg3RVH12NVLKs9RBbCrTJJP9J1ToQ8ZyCwhRuJc5zeH3nez?=
 =?us-ascii?Q?OHtQnGA6bRF0fuonW6LIjjy7sZesEWTahoHYexCcynhwmQp54wtqQlqRh1rf?=
 =?us-ascii?Q?iLdDs+COUOlXRlQZAoOLjwA2P0FnC3e8cg+JA3Chd90baDa6kVVZumnop43F?=
 =?us-ascii?Q?E07+8h2qvcpf9MgCda0zlpyL+Qa3YnuhdZFA1SXkPJ41NbSq5MYk629/daSQ?=
 =?us-ascii?Q?zjPrtODArArHgfY4Wm4MVmTWMfKnKYXz1fvXGEhaWNi/G6lNY8Tx4s0p+a3c?=
 =?us-ascii?Q?H46CIyngZA8KVynXH9ooq5UA+avau+NDH+iAX9ypw7uBhb0dbHs1GpvBJEu/?=
 =?us-ascii?Q?J8l3TcjOt4l19eVQ1NABFA34r1ZevhGt1tWo4QrNKIdd1/NEG4A8TZnrGlst?=
 =?us-ascii?Q?vCzew3eVC6720CzK7Bo0mYzxsmyAxwOW0JfJpcrdNrhojCdW1BmvO5Uim3FD?=
 =?us-ascii?Q?8bSjgDczBsRwu9nLZatbebEhT6EDTO3TSRDNk2GG/6Jm1fwrhJUZE7pwuF/n?=
 =?us-ascii?Q?VnO7z3BZ/AvgcdPh55gCX5954JZnFEFzOIznbgaTG1bcKQYcf5lhj05sCzMz?=
 =?us-ascii?Q?1YjM1XwqN4LQgtNF6VBguRs9QlW3Qil4dLrtC714Vi4h6H9L+Y9VBYySOVEe?=
 =?us-ascii?Q?ALy1vW94U/hdwMmoUkZ9qBpFRWOIVC4vUbXlmckJ8PqPN4rsIccwSW64Lfze?=
 =?us-ascii?Q?SifSPp9fT/C35qj0unNhfGeiNzfojJagUapAnAHsOX8H3x+G7Uz+iX7+pFIg?=
 =?us-ascii?Q?/hBJHLLmfIkSSTiAS/BygX4Sy+jGFX4V3NZ0NfzkvPJ8DGpeWV42AmDYJ6QP?=
 =?us-ascii?Q?4JLcv+ZhiYkahpkr7JXbr2fokUMufTh3T66ZnCMfJduwI9ir/ls8LY/uXd8e?=
 =?us-ascii?Q?II3h3TEoiDcd5Y6ijm3WtebFRFzg9i0=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 764d7fb4-e8de-467f-9f48-08de85e7cd42
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2026 18:46:16.0285
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 11CoYxIiIrMhHB7qZacZNarynwRkdw/B877vVkWvTnpglD6Vo3KDsVh85MZOYiP05ngbIJEIjLlP6kncxL56H3RZDjZvYx1R/Lgi9j5U8Sw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB13332
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[renesas.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[bp.renesas.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[27];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9549-lists,dmaengine=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.950];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,bp.renesas.com:dkim]
X-Rspamd-Queue-Id: 7788F2D1418
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Mark,

> -----Original Message-----
> From: Mark Brown <broonie@kernel.org>
> Sent: Thursday, March 19, 2026 7:11 PM
> To: John Madieu <john.madieu.xa@bp.renesas.com>
> Subject: Re: [PATCH 00/22] ASoC: rsnd: Add audio support for the Renesas
> RZ/G3E SoC
>=20
> On Thu, Mar 19, 2026 at 05:45:05PM +0000, John Madieu wrote:
>=20
> > > Are there any non-runtime dependencies between the various patches
> here?
> > > It's a fairly large series touching multiple subsystems, we'll need
> > > to work out how it gets merged.  It looks to be mainly ASoC but
> > > perhaps the other subsystem changes are independent and can just go
> via their tree?
>=20
> > The series contains the full chunk of patches for audio IP to work, so
> > they depend on each other for runtime to work. However, patches will
> > go through different trees and will eventually meet in linux-next or a
> release.
>=20
> > In addition to that, DMA (patch 06/22) has hard dependency on IRQ (path
> 05/22).
>=20
> > The merge strategy could be:
>=20
> >  * Patch 01, 03/22 =3D> Clock
> >  * Patches 05-06 /22 =3D> DMA
> >  * Patches 07-17/22 =3D> ASoC
> >  * Patches 02, 18-22/22 =3D> DT
>=20
> > Next time I'll take care of clarifying this in cover letter.
>=20
> Please just split out the things that can go separately to their
> subsystems, it'll make everything clearer.

Noted. I'll take care of this in v2.

Regards,
John

