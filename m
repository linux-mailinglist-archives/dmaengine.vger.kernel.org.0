Return-Path: <dmaengine+bounces-7509-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BD9ECA7960
	for <lists+dmaengine@lfdr.de>; Fri, 05 Dec 2025 13:37:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9510432FB1D7
	for <lists+dmaengine@lfdr.de>; Fri,  5 Dec 2025 09:46:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75445313E39;
	Fri,  5 Dec 2025 09:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="fskiO6+s"
X-Original-To: dmaengine@vger.kernel.org
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11011032.outbound.protection.outlook.com [52.101.125.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DF832D8399;
	Fri,  5 Dec 2025 09:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764927958; cv=fail; b=YK7h8aGLB/wBz1iV051z9HyIOhH9RVKm0WJqfic3jJwuhpdZlMRaVsG+L7Xbajb/+VUFxOGrtvPe5V7UMyTctmJO9kFa8W4E+3bT6Vf/U3ecgtfnkKJjitTLwJ6+3nf65gJkH7dP4EkOTCAy1LbMAgFFKCQ3IPFIoLWCK+YTghM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764927958; c=relaxed/simple;
	bh=YLqSdzczVKx3NMw+Bus4onfQpoL8pQ+pgQUK8IWb9X0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LG4OhsyJdTcLZdGgHoYkEiM7o81LCmLP0yhX5Jxh75mM6N+/z3HN+aXn0eN4/t1VBEOC/btZH1qe8j6C9k+CVdyN48kbjHOiGyiya3BmWaKOf85JyUYWAzkBPB4agK2zVzJ8DhGEchup+XfNAoLMSAv/wq4JfcNCKLQ6bq7Trg0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=fskiO6+s; arc=fail smtp.client-ip=52.101.125.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zAUYl+2MPCa7XLGWrsIGZV3FJX5WgC2xg/t4q1LPNgqjIW7zR3xG7OX3v+6SQLuDRC2yQW1yH5eSkvmVvL52Ucw7I3YR+J+FiRYt1z/ykISNkPzrki/NGjavT1QBDotfZTTuLA6uP0woEHpw/dfYcGsM23gDTIp1gOhtGfbGDz3Rl2eWZyCzNXQ9H1Q2aWMx/65oTCUylfDc08TUjAkMMt6WZ72D4hmPYiL6QkCohpZFqoHH52cZrUfbVygM7I9RIGTsOpzIPPY0ZZSeOFb3+9VML0wuJr5qe2oqSikJRA2AAQtTTW2/Yfgf4gAaXeINhfgKHZV6EaJWeEwFG7K5iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Px4vp9MAmLSfa9blBCUjHDHCLCakgXJC0nweT5vXYmE=;
 b=auCs470SZteUFBKViSwqvGYPTlPuKSjFbuWa+Dj0RM2Or6g77Am9RDx4FEAug4vVOFFFlPGg08hIbVzAZWQm91xHxz7zdsi8YUtAtYD0gC93CmoPhJQXxhhULrvewohw4Q+QzOggwraIdgVobeJHLq0tf1gugi+CZ/B3hgHWUGQqwxQnnCIw1NApjm//+Tz/T7IzB3sWjOS6sTnib/OsvFF60KO1CDV3v9/IWbVGdTeUwmpx2aZCSt3eRwRlmZlkaNPUrq4uPX46qf6IkW8s8ziKEWuRnsyEneaRhJYb3NeOFd3uhclF396gFGN21FMeR1MEAz5rA3408Buly0nPcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Px4vp9MAmLSfa9blBCUjHDHCLCakgXJC0nweT5vXYmE=;
 b=fskiO6+srfyRNlWaU6Qh+71m7ihGOEh/owBjeeC8ZgldqzS9HUP9zISQLtEgHJmk4sfjHNIFxFz/Rlnd2emJ0ffvjPIxB90gFrEaF4wWzFx+Ix8NLKCCfXeQfYkNyxu1x9hJTFI+mCq1sLpnf9KiX1ZJMEs3FwAD+cdqIlG3U/E=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by OS9PR01MB16321.jpnprd01.prod.outlook.com (2603:1096:604:405::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.11; Fri, 5 Dec
 2025 09:45:39 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1%6]) with mapi id 15.20.9388.009; Fri, 5 Dec 2025
 09:45:39 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Cosmin-Gabriel Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>, Vinod
 Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Geert Uytterhoeven
	<geert+renesas@glider.be>, magnus.damm <magnus.damm@gmail.com>,
	Cosmin-Gabriel Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>, Fabrizio
 Castro <fabrizio.castro.jz@renesas.com>, Prabhakar Mahadev Lad
	<prabhakar.mahadev-lad.rj@bp.renesas.com>, Johan Hovold <johan@kernel.org>
CC: "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH 2/6] dmaengine: sh: rz_dmac: make register_dma_req()
 chip-specific
Thread-Topic: [PATCH 2/6] dmaengine: sh: rz_dmac: make register_dma_req()
 chip-specific
Thread-Index: AQHcYriokC3iyw5sYE6SWipKsa/cZ7US0QUQ
Date: Fri, 5 Dec 2025 09:45:39 +0000
Message-ID:
 <TY3PR01MB113463CC5D1F75E1110CAB8D686A7A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20251201114910.515178-1-cosmin-gabriel.tanislav.xa@renesas.com>
 <20251201114910.515178-3-cosmin-gabriel.tanislav.xa@renesas.com>
In-Reply-To: <20251201114910.515178-3-cosmin-gabriel.tanislav.xa@renesas.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|OS9PR01MB16321:EE_
x-ms-office365-filtering-correlation-id: 799faf07-430c-4b12-94e0-08de33e30c83
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|7416014|1800799024|38070700021|921020;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?aSq76bii9Q46oafXs9g6SdT/cdwmhU1QrofRbHmt9uKnxfW8Q747Ae168D/s?=
 =?us-ascii?Q?lEC66yBRIs2nNZk5f7ozjO3nOBCCOSRtXVs4immCcKfOM0Pz7FTrVh8sLrck?=
 =?us-ascii?Q?Ofn2q9aCDKEfuV3pVRDfLWnTDIZId8KtgcQLbbeja1sq1n+DX6BDr2R19smT?=
 =?us-ascii?Q?ePcL4UypTgSE2C/e+CSPexyIhMHgv7tpW0X2xSrcO4R1nMMsIy2g0Rvkxdx8?=
 =?us-ascii?Q?XtefuMHeplt+gRQ92XVZD5Q8sQbxfO4lFLAl9RWKlnTyK4SJeRgqvTKMu+Qi?=
 =?us-ascii?Q?vK6r+5ctRTdWy1BSL66ttTscT8Wbmmsr/1O3/i8xUoMtul9MGtoYbTnpNPiq?=
 =?us-ascii?Q?R4QipeKjWk/focA8GQgK9XjurQ9ABkjFpJ3ETLKb9XHwJwwvsNIVhQTGSFJK?=
 =?us-ascii?Q?jzRPknQJNWOyX3X2YyyCPw1u4E/6AryMk34QeeR3vTBpyXEq7k9PfF6i+IyX?=
 =?us-ascii?Q?9dHHUoIWmCU/bK6wJB9KG848hbd/kElwl46WSSgne/5SE/p/DDLMecdXaO2e?=
 =?us-ascii?Q?TLlCs0nvvsX02CHpL1lu2vdgmjPSVDXb0HUl9xo65v77KXV5z3xEB48sHvBo?=
 =?us-ascii?Q?pCN+6j81uQaV8rkGuDVuu/ZPXRSdgukhsePEFRwVjuhSKF/RF/p+E145D7dc?=
 =?us-ascii?Q?uXfBU/9DHxc/hYx5bvTfpukxe86UH33bFjoa403A1UKMOsmOIFzwa/88hAdl?=
 =?us-ascii?Q?ZdwMcsRvMJUVTe5hTtrx0y02PFHHOU3xfoykKxUecBnR3orGu394u+TFfPP9?=
 =?us-ascii?Q?2k1bI3ZLrHWcGg1EjoseBHPCrGzuTOYnp8hAy3CsTVrURA3jQCU0+nM5tgFx?=
 =?us-ascii?Q?38e1vvhPGIEqFJY2tOpB+xaQrneoNqitufGpjkjH8s5km0it4rWNttsn4xT7?=
 =?us-ascii?Q?EEqeh0TgD8q7inQLybEl9qWJNHEO+X8J1vb7/KG17tWJlm0wx0NapVVoEg08?=
 =?us-ascii?Q?XwtyqYFugLiCXgnjqbOi3vJkVIJK+KE0z4T+VVmUJZL4C7DH+h0qOKYJSz7x?=
 =?us-ascii?Q?GUYJaJhf7qdVmd/3u0/s5Nj8w9uJ7KF/FBU3KjDk1gwrwElco2yUvOEc+iHL?=
 =?us-ascii?Q?hEJH3InCuuQmmqeiQ/R3svxWq4xaQvEw9ujVt31NFukaa69C0DToWPVr1eNz?=
 =?us-ascii?Q?kWfgS5FnvLRxLL4yFEyVoADIOPxJreB1O3pwaGiE3ozEAQhUcgM0TkgLOT/H?=
 =?us-ascii?Q?DWy3l2q7MxCykIjQ09ARrmih6Q7+y/j49KPV4NhMdU8XNjbHjjDGtoqDtip7?=
 =?us-ascii?Q?yb1yxLynqmHxroMDSY1tt+tfinGQvR7YGwFYXGxEXtR2l9ymw6h3WhifbxC6?=
 =?us-ascii?Q?eDCwahGInpPbAxiW4TLONHKbPTQMkSFdc4BOcLihEfMnlKiACQmfm5xp0WBK?=
 =?us-ascii?Q?NUK+w8FaIk6MncLX8TMZdtYaj0v+CzjVEIfjPaJ9pG7+rnGPIazbK6kYORnC?=
 =?us-ascii?Q?VuqoRDy/EikWa+GrirbqhyR3cepaueXouOxZblbQFkCwrW3j0oXTYCsFcCJZ?=
 =?us-ascii?Q?nO1O1PRuhfEVXTyxC5emTgb6mn3Su9hb6CFIcNh4z7Sfoqz8QmAZ1FbiMw?=
 =?us-ascii?Q?=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700021)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?lINX8w/sD8iJnuhassv/iEpc2NIxY3glKf//RyQXslO8J8Aq4kWVBvI4bXOH?=
 =?us-ascii?Q?QJLBds2ksD5K3wGwaWsbk3Ii6vxkZEErU55XnGgzMQSXSp4uNbgxSe1hFb8W?=
 =?us-ascii?Q?Epxw/ZABif7kVTQbgAVPG1xFkXG64sQB/MTihXjmcoianRvTDT0vFHCDzMTg?=
 =?us-ascii?Q?ehTNDKbWiKzHUxy5ycx/jXmkDFUqSRzsTl8m6hSAJQbArTyNrrw2te2ikXNp?=
 =?us-ascii?Q?CrfxYxst/lTdE+jDDc9ITtA81pwxnBie545LgbfHtx7Q8v2qc6iHErm+AJ6w?=
 =?us-ascii?Q?gsMNK9ngIL/4TSIqNHBJ/97/kvFgCRhCdBQneexdqyR3X3X3EPX6ydf3NmuJ?=
 =?us-ascii?Q?9vFDTcghVbnMFI+q0+rQkQPGswfTODctjhtzVLy2FMwUDd8vg6xqsHoeSkHv?=
 =?us-ascii?Q?wwK8CU2q6mCMDi1k5wh+M/xF2TV1+7rqNIl06QsJQ3dd5cviLA9z0PoWapqY?=
 =?us-ascii?Q?QW6okSJOdWvqCf7BOMkMR/NZf75q1Yd4FAffzm55hJdmUvwOywqf4UCfdhS4?=
 =?us-ascii?Q?g5NnN44LPZOfk996a1Lu8I2F6+N0DFAZ82G/7hFVET/HWNAMF7tDB+g3YVlZ?=
 =?us-ascii?Q?epZPRwI0Q0uVfJqKuBSfi58szt3ErH6ZhSY8Myo59FSkEP79BbBZvFgQOzOe?=
 =?us-ascii?Q?3RnsZ9Nu9c1/JyDVYYGerSrhf1DUA39KSi1kaiPkTxvr7O02IdRFAtLHo70W?=
 =?us-ascii?Q?mMpOXw0nlmoI5g4rbX7OcsVZr0T7BsdMfcPDYQEWrRgpcZqUg254/vuAoxdW?=
 =?us-ascii?Q?H2JmyaFoMMODJOi06cjQVKhH8d/nHyds6dVtZ0tqbca3d+85Et8WrioLLI+z?=
 =?us-ascii?Q?koOmSWdax+Jna7V3bbMFR5RDL8dq/Kn9aHWxT8scFdFBN+soN9baEYt2ccsl?=
 =?us-ascii?Q?+NTXT+nrQeh7r2AFmMTe8RlYWlIdJig8In1Pz8AXBmnN3m0KB/yIUaTPABBG?=
 =?us-ascii?Q?sUZaFXlF40M4bchk78si8CmE+wzW5mISbLDpmLmSuo1n8bpmMxXPxVbwzC8i?=
 =?us-ascii?Q?X+z4Zt7gxxnbDioxxajJg4qvRuAnSqhSkV93fhvgarJU78HOfMZJdnz3TJRQ?=
 =?us-ascii?Q?HArNUt8Q2Y5BszxgyaxBG7rfToV6suRvyu0J+pmOGUv+fXMBdoRDKy48O3Im?=
 =?us-ascii?Q?Fknb4sHkMxDJKB3jXulfUxa5j2waIm+VUt1Q4vN3Lu6dQ0MXn6Xc00UIZLXn?=
 =?us-ascii?Q?WiKX8X2rntzdVmxZYMzTpIk9YbeTP+SDRmNVfaihLWnXfiv4zXD8PagCBN1g?=
 =?us-ascii?Q?sCjmRkX0g0xnWGb8lE0VUleMLi9h/ypvBJspVlQimZYNg3JKBf9KHgy84eae?=
 =?us-ascii?Q?gAxgL7pFZlUt9IEpImtrjVpo7wBI53WRQMZDYa++y1TMx/bS4pFuMHCzTHJp?=
 =?us-ascii?Q?PoL9SzV+EeteezGYVQRd1IATTMvwGW8BF12hjM4yC5y/DBAffbl8k5ju1lyq?=
 =?us-ascii?Q?4B2+dRSuAB+iT56S6Y0xGu7pJHutCvGWpad5fa68ZHArXK9wIXiqzCHAihaD?=
 =?us-ascii?Q?oWnTWfZPwRUb9Fv+2A0LISLgw60JNKfEDnNFWg1NqXX4CAdo6D4W7APUcSaB?=
 =?us-ascii?Q?NgwZ3UoVJuYro5Ue/ZjwRZUejEMXpD4dpjJ+9WRyChNl1D7q37Nww14UU8xV?=
 =?us-ascii?Q?rA=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 799faf07-430c-4b12-94e0-08de33e30c83
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Dec 2025 09:45:39.3650
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IIsGZu8n5t8LDRRlU20fSY0DRaHnMuNthP8kWysHSgeGa6SHx/XfADkT+JRW+1AdhFDnbzXV9ARZCPLgSexOPPG3UugomMUVgKa+MDuPE68=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9PR01MB16321

Hi Cosmin,

Thanks for the patch.

> -----Original Message-----
> From: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
> Sent: 01 December 2025 11:49
> Subject: [PATCH 2/6] dmaengine: sh: rz_dmac: make register_dma_req() chip=
-specific
>=20
> The Renesas RZ/T2H (R9A09G077) and RZ/N2H (R9A09G087) SoCs use a complete=
ly different ICU unit
> compared to RZ/V2H, which requires a separate implementation.
>=20
> To prepare for adding support for these SoCs, add a chip-specific structu=
re and put a pointer to the
> rzv2h_icu_register_dma_req() function in the .register_dma_req field of t=
he chip-specific structure to
> allow for other implementations. Do the same for the default request valu=
e,
> RZV2H_ICU_DMAC_REQ_NO_DEFAULT.
>=20
> While at it, factor out the logic that calls .register_dma_req() or
> rz_dmac_set_dmars_register() into a separate function to remove some code=
 duplication. Since the
> default values are different between the two, use -1 for designating that=
 the default value should be
> used.
>=20
> Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
> ---
>=20
> V2:
>  * add .dma_req_no_default field to the struct rz_dmac_info (to be able
>    to use the different define for RZ/T2H ICU)
>  * commonize rzv2h_icu_register_dma_req()/rz_dmac_set_dmars_register()
>    calls into a separate function, rz_dmac_set_dma_req_no()
>=20
>  drivers/dma/sh/rz-dmac.c | 68 +++++++++++++++++++++++-----------------
>  1 file changed, 39 insertions(+), 29 deletions(-)
>=20
> diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c index 20=
a5c1766a58..f94be3f8e232
> 100644
> --- a/drivers/dma/sh/rz-dmac.c
> +++ b/drivers/dma/sh/rz-dmac.c
> @@ -95,9 +95,16 @@ struct rz_dmac_icu {
>  	u8 dmac_index;
>  };
>=20
> +struct rz_dmac_info {
> +	void (*register_dma_req)(struct platform_device *icu_dev, u8 dmac_index=
,
> +				 u8 dmac_channel, u16 req_no);
> +	u16 dma_req_no_default;
> +};
> +
>  struct rz_dmac {
>  	struct dma_device engine;
>  	struct rz_dmac_icu icu;
> +	const struct rz_dmac_info *info;
>  	struct device *dev;
>  	struct reset_control *rstc;
>  	void __iomem *base;
> @@ -106,8 +113,6 @@ struct rz_dmac {
>  	unsigned int n_channels;
>  	struct rz_dmac_chan *channels;
>=20
> -	bool has_icu;
> -
>  	DECLARE_BITMAP(modules, 1024);
>  };
>=20
> @@ -319,6 +324,19 @@ static void rz_dmac_set_dmars_register(struct rz_dma=
c *dmac, int nr, u32 dmars)
>  	rz_dmac_ext_writel(dmac, dmars32, dmars_offset);  }
>=20
> +static void rz_dmac_set_dma_req_no(struct rz_dmac *dmac, unsigned int in=
dex,
> +				   int req_no)
> +{
> +	if (req_no < 0)
> +		req_no =3D dmac->info->dma_req_no_default;
> +
> +	if (dmac->info->register_dma_req)
> +		dmac->info->register_dma_req(dmac->icu.pdev, dmac->icu.dmac_index,
> +					     index, req_no);
> +	else
> +		rz_dmac_set_dmars_register(dmac, index, req_no); }
> +
>  static void rz_dmac_prepare_desc_for_memcpy(struct rz_dmac_chan *channel=
)  {
>  	struct dma_chan *chan =3D &channel->vc.chan; @@ -336,13 +354,7 @@ stati=
c void
> rz_dmac_prepare_desc_for_memcpy(struct rz_dmac_chan *channel)
>  	lmdesc->chext =3D 0;
>  	lmdesc->header =3D HEADER_LV;
>=20
> -	if (dmac->has_icu) {
> -		rzv2h_icu_register_dma_req(dmac->icu.pdev, dmac->icu.dmac_index,
> -					   channel->index,
> -					   RZV2H_ICU_DMAC_REQ_NO_DEFAULT);
> -	} else {
> -		rz_dmac_set_dmars_register(dmac, channel->index, 0);
> -	}
> +	rz_dmac_set_dma_req_no(dmac, channel->index, -1);

Can we use dmac->info->dma_req_no_default instead of -1 that will avoid
unnecessary check and assignment in helper?

Cheers,
Biju

>=20
>  	channel->chcfg =3D chcfg;
>  	channel->chctrl =3D CHCTRL_STG | CHCTRL_SETEN; @@ -393,12 +405,7 @@ sta=
tic void
> rz_dmac_prepare_descs_for_slave_sg(struct rz_dmac_chan *channel)
>=20
>  	channel->lmdesc.tail =3D lmdesc;
>=20
> -	if (dmac->has_icu) {
> -		rzv2h_icu_register_dma_req(dmac->icu.pdev, dmac->icu.dmac_index,
> -					   channel->index, channel->mid_rid);
> -	} else {
> -		rz_dmac_set_dmars_register(dmac, channel->index, channel->mid_rid);
> -	}
> +	rz_dmac_set_dma_req_no(dmac, channel->index, channel->mid_rid);
>=20
>  	channel->chctrl =3D CHCTRL_SETEN;
>  }
> @@ -671,13 +678,7 @@ static void rz_dmac_device_synchronize(struct dma_ch=
an *chan)
>  	if (ret < 0)
>  		dev_warn(dmac->dev, "DMA Timeout");
>=20
> -	if (dmac->has_icu) {
> -		rzv2h_icu_register_dma_req(dmac->icu.pdev, dmac->icu.dmac_index,
> -					   channel->index,
> -					   RZV2H_ICU_DMAC_REQ_NO_DEFAULT);
> -	} else {
> -		rz_dmac_set_dmars_register(dmac, channel->index, 0);
> -	}
> +	rz_dmac_set_dma_req_no(dmac, channel->index, -1);
>  }
>=20
>  /*
> @@ -868,14 +869,13 @@ static int rz_dmac_parse_of_icu(struct device *dev,=
 struct rz_dmac *dmac)
>  	uint32_t dmac_index;
>  	int ret;
>=20
> -	ret =3D of_parse_phandle_with_fixed_args(np, "renesas,icu", 1, 0, &args=
);
> -	if (ret =3D=3D -ENOENT)
> +	if (!dmac->info->register_dma_req)
>  		return 0;
> +
> +	ret =3D of_parse_phandle_with_fixed_args(np, "renesas,icu", 1, 0,
> +&args);
>  	if (ret)
>  		return ret;
>=20
> -	dmac->has_icu =3D true;
> -
>  	dmac->icu.pdev =3D of_find_device_by_node(args.np);
>  	of_node_put(args.np);
>  	if (!dmac->icu.pdev) {
> @@ -930,6 +930,7 @@ static int rz_dmac_probe(struct platform_device *pdev=
)
>  	if (!dmac)
>  		return -ENOMEM;
>=20
> +	dmac->info =3D device_get_match_data(&pdev->dev);
>  	dmac->dev =3D &pdev->dev;
>  	platform_set_drvdata(pdev, dmac);
>=20
> @@ -947,7 +948,7 @@ static int rz_dmac_probe(struct platform_device *pdev=
)
>  	if (IS_ERR(dmac->base))
>  		return PTR_ERR(dmac->base);
>=20
> -	if (!dmac->has_icu) {
> +	if (!dmac->info->register_dma_req) {
>  		dmac->ext_base =3D devm_platform_ioremap_resource(pdev, 1);
>  		if (IS_ERR(dmac->ext_base))
>  			return PTR_ERR(dmac->ext_base);
> @@ -1067,9 +1068,18 @@ static void rz_dmac_remove(struct platform_device =
*pdev)
>  	pm_runtime_disable(&pdev->dev);
>  }
>=20
> +static const struct rz_dmac_info rz_dmac_v2h_info =3D {
> +	.register_dma_req =3D rzv2h_icu_register_dma_req,
> +	.dma_req_no_default =3D RZV2H_ICU_DMAC_REQ_NO_DEFAULT, };
> +
> +static const struct rz_dmac_info rz_dmac_common_info =3D {
> +	.dma_req_no_default =3D 0,
> +};
> +
>  static const struct of_device_id of_rz_dmac_match[] =3D {
> -	{ .compatible =3D "renesas,r9a09g057-dmac", },
> -	{ .compatible =3D "renesas,rz-dmac", },
> +	{ .compatible =3D "renesas,r9a09g057-dmac", .data =3D &rz_dmac_v2h_info=
 },
> +	{ .compatible =3D "renesas,rz-dmac", .data =3D &rz_dmac_common_info },
>  	{ /* Sentinel */ }
>  };
>  MODULE_DEVICE_TABLE(of, of_rz_dmac_match);
> --
> 2.52.0

