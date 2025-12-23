Return-Path: <dmaengine+bounces-7906-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9748DCD99E3
	for <lists+dmaengine@lfdr.de>; Tue, 23 Dec 2025 15:26:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B27783008E87
	for <lists+dmaengine@lfdr.de>; Tue, 23 Dec 2025 14:25:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A783933032D;
	Tue, 23 Dec 2025 14:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="XSWUPwUh"
X-Original-To: dmaengine@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011025.outbound.protection.outlook.com [40.107.74.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2790E2D876B;
	Tue, 23 Dec 2025 14:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766499927; cv=fail; b=E8xrSt2E/5oFYlMZYRPWmCm3Q4uG4OTEuDP0dSRNC0a93jkECV5/DGUUd8UBAcxTIwXK630bp/AN9lP8zKxJPtlsCcCyM4A6uH/Z0+0RG9+YnPiMv+merkBKCadOPG98v9nxuPdH/d+APfA3qoo3TtFhMQLG6LD20l/Ia9oc0U8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766499927; c=relaxed/simple;
	bh=teXrgMxGdycGHdbtmSuBcQghV0/MaEK3iGi41hF7SLA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=L7i9mF3utHYe2JMJrEltgGElKUBSX+eyTth7zZnMahvvbNWfyHWU0PjkfzKJLNL4gk2n0ef+6YXfXF8yjYF0gXMzMTfJ/PVV/LRnvDVMyO0GapzI1MgOL1OFjrCBjBwJm/t6P3KZojJLrxHdhGmB1pnt9XkAFMjjris2FLokuKY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=XSWUPwUh; arc=fail smtp.client-ip=40.107.74.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S7ZdzXAUwyy5oGnMb+20jxJ2bOV3NlrAgiy1pgp5AIXvAVdFilQYgLRgmMOWFqwVBgnlQvAehg814MAoBWgqZc9g35zZRq5prkVh7iYkqHqWaklyRND13choFM2dsotmF7g5U1M42/vcZP1he/aXyEzmZysjz7xOpT+YCdzbpmM8fpoP/RMJEPlKAf88+PWZp5PBUONcJ09VnwoCTkwafEmQSI67BYho1o+DGMNsfmjquUrmHhbcAv8/SRvDcbu58W8RBb8RvyNs4LvCVq7IYpSKZIoVSbfDl63lRQ5X9wgIPaKgU5G9BAHBG0cfqFd2SoSBcB9j716SPH7BA3gc0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n8DERAKbdsjXLs4NkUaeStjPtiFQKe8KtCs7se7DtfI=;
 b=Ih9/csxvHa0pFAfqVFEz6L9rns5vnxmqwIeX/AajztAPIQIG46NWvWKuWRuLjcPoDOxtHSFPyT0TrMhWKhoOdx+Y8lnhIru6Bt6IOkDIXLAUt5yViYjIB3/umOpv/J751YgDvFTkSrfHQzo7XMbwkw1NPHv5zF9X6QGeaLuMpcWsYsF+unmbkx8KSLGBRP3J66g3eY14ybnuwNe4/LWXZ9xlgjqtNuoTNY/QseigOqkceYLHUnhNtT93tzVh7ZXuQEa7Ww/LdCusu1UpQNPYQ3ybDXsZs4PmqP6lekrpZEBLUpBDpelvACRJ2Dwd26f/w8W1M79dg+S/YEZK3zuJog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n8DERAKbdsjXLs4NkUaeStjPtiFQKe8KtCs7se7DtfI=;
 b=XSWUPwUhXSKZby2PmL//rhCHkwtJPoLvpJhYekbJudIGQgJT5yXPvX5cbA70PevcFIVRUnYU1AgKItLGITrKsdFeYniqIxr3Hv0m+pfzElFzYo4KvhhanA0tzjMGKm7g/tJdWZ7eRQ11JwAlZyMYaSTf+0OSqPH0TaeX7UjETb4=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by OS9PR01MB16098.jpnprd01.prod.outlook.com (2603:1096:604:3dc::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9456.11; Tue, 23 Dec
 2025 14:25:22 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1%6]) with mapi id 15.20.9456.008; Tue, 23 Dec 2025
 14:25:22 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Claudiu.Beznea <claudiu.beznea@tuxon.dev>, "vkoul@kernel.org"
	<vkoul@kernel.org>, Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	"geert+renesas@glider.be" <geert+renesas@glider.be>, Prabhakar Mahadev Lad
	<prabhakar.mahadev-lad.rj@bp.renesas.com>
CC: Claudiu.Beznea <claudiu.beznea@tuxon.dev>, "dmaengine@vger.kernel.org"
	<dmaengine@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Claudiu Beznea
	<claudiu.beznea.uj@bp.renesas.com>
Subject: RE: [PATCH v6 3/8] dmaengine: sh: rz-dmac: Drop read of CHCTRL
 register
Thread-Topic: [PATCH v6 3/8] dmaengine: sh: rz-dmac: Drop read of CHCTRL
 register
Thread-Index: AQHcdBMkFL/8hfjk00qpIX9LIsI0BrUvR6dA
Date: Tue, 23 Dec 2025 14:25:22 +0000
Message-ID:
 <TY3PR01MB1134694D4CF924BDA7ECCCA7586B5A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20251223134952.460284-1-claudiu.beznea.uj@bp.renesas.com>
 <20251223134952.460284-4-claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20251223134952.460284-4-claudiu.beznea.uj@bp.renesas.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|OS9PR01MB16098:EE_
x-ms-office365-filtering-correlation-id: 5cbb0269-33c4-41f8-c2ed-08de422f1b8b
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?nebABwPWyGkJRG8BVQn3WMAUJls9sRVw5D6PGWR9FNnSJ1OacSs/5lW4U0SR?=
 =?us-ascii?Q?sJTQ2qMDa7hXk09aYaT+wqVftDgSLBacZuqumW2GH+JjXPu2fLA0wbZmpnKy?=
 =?us-ascii?Q?Emun/IxNWuEZFsCYBk27ccL7ccFzwx0xvpjnxqQY/L+TEiM80ZwQaJxBf7o9?=
 =?us-ascii?Q?ADqgpV8oPSIXnKqU6+a8sptTLkSK6FmIy337G+qeDUgKJ2tUFCxSoYVMgj16?=
 =?us-ascii?Q?pr9mWK21ocbGJ3dqvIhqr1HyfD7vTidK5ZYtUGsOp3WS8O7mcoQ1ooqqmvvo?=
 =?us-ascii?Q?GomG7hztN9XhgvIsfuUo7tDwnZ2+DDPYp8EkkP07XzoRYo1AktlxV13s2wPe?=
 =?us-ascii?Q?tg5oZ4LD3JIpTGGJd/9yqucKT8pCSzuu1ne1Ca7Hz3OSqGw3RuvjHVak92gg?=
 =?us-ascii?Q?0mwqu35asyKstMhEnYN/6uNTGXEMH6H25vjZn5ig6YQAEyiFz8PQx99ysGzy?=
 =?us-ascii?Q?/pX8tWQRUWJ8jyBxhk/McMAG92noked791pYjfRh2FwGNO17Bk+GaIqZmARL?=
 =?us-ascii?Q?lyYU7csyBxAnAqFRG0Aaz78pqLfY2+pXvs4lKqGLj2AoZ2Ee97nVAIjdbCiH?=
 =?us-ascii?Q?GsYMiyvSBq2WyTuR4qIFloK98otrv5mXADea9Mu1XrVd1I8QtNA16RCdsmbd?=
 =?us-ascii?Q?4f2/qMUmfC/gBUf2qsUyr2CS2PkkuA+n2p9xgNqx3FLJyWFySZdPUMHurOeN?=
 =?us-ascii?Q?S/rmHi74BkjCZRCnzkO9lhZkFlgKQMiQERcmBbfCsWPOyiQkWtW549FD5TKF?=
 =?us-ascii?Q?VwhuAEHO1lQjdntAdYUf5UZF1Xl+lBKgW85Mt8zF3q5zWnA/5Y2AOZIasetP?=
 =?us-ascii?Q?tDe3q8m11yOu2s4tc+Vr1rN+RSQAXBmZXmA/za4qdY0A9fRceLZTxkBDmqAR?=
 =?us-ascii?Q?bk/mOjFnDKEAVKhzZP6twOZl9lf6iGX7vJRVMvZavrCcf+2obVemfkgrLqPz?=
 =?us-ascii?Q?iXyNCEGpYaS3MSAn7vwaCuL+KMkGAoMKphj0IGIC1nTHATQp+cIrIKGJQQYW?=
 =?us-ascii?Q?Dty70F0gCeMv12E9Zlg2b6B/X93v4qR1fhCsQeRYtz6iPGfT+inmlQIVX1K/?=
 =?us-ascii?Q?tJay1TwQavEGKB/hid/6QhQSH/PKyGNIeqc5qoq7Q/BdWETXKSc7bcfwqrM/?=
 =?us-ascii?Q?pXb+S1c3yNB1hsGIymuGASeVktev803e9QC53MMbtzBTBgn2Y8LhtwKbPoKR?=
 =?us-ascii?Q?8vm3iwOEZ7KPoVsvwYNLvUo2jAGv37ncViritMfkvQyzg1k7YY3OVrfreU3B?=
 =?us-ascii?Q?Lomw8JMQ9TFUCNvNQkN5w72wA+e1RrWg54FBFMSzN6ORQfYS2wnB/QaU2SiQ?=
 =?us-ascii?Q?07NKDQ5K68ErGARYK6BrfHdF2MFozDzYt489HVFxTJkXG8TsknP60tMSTlhv?=
 =?us-ascii?Q?acjkpoQ1bMmFCytfk/Mn/FUHMIEyLvo/fMlOmVaT3M3X6oicSNCj2S1Mzq7Y?=
 =?us-ascii?Q?6KUfM1yCVWdjsh4nEdoiwPOYNm+1HZIZ8Oh2cufny+3wIkS/qcN/y8fhoins?=
 =?us-ascii?Q?rOgr9i8I6DjImCVina8Z6F4N/BC1cRrCP/F9?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?1mH8oSJyn6VcGFhMeUsoBPFZU/fTQWDmlKXWIyCZaJGvcVKsEQ6vWAo5BGc3?=
 =?us-ascii?Q?xQ6q3x4LGZf8Yin1wYjc7J852c0HTo8Vxmu07oi+91svZMwyrTw3g5q4K7Kv?=
 =?us-ascii?Q?eacAJlg2O6tZVQ1qZjw93ZD5tNkN0laXXyI8Csp0idQblNjkfUYNMjd04SAz?=
 =?us-ascii?Q?6zCtSN8NtjlazJTL91YV1bMgwQ1MUiIQL/fRDNLwwJEMPOGGwa6bg/sS7hXC?=
 =?us-ascii?Q?HRbWqmiGeCW9gxyUx5965dICS52oPzHy+ihfIAragYLHxrUJGfUKCrlB4Ggm?=
 =?us-ascii?Q?OghNswP0Q4Ruclax3zC3A3yLQ13dpzRjSOHdo3i6By/bAHT33vPIXlfpWGu7?=
 =?us-ascii?Q?gr/Epk2fvnOm9+QmZBg7L8Uz6deIblGI4334AqPmW7Cd/kl1W6Qv2SmZ3l2g?=
 =?us-ascii?Q?52lXiW0ZPITfuRLtH/w6hhnGRJIkeLCVie4fY6BYsGIBCb1EiJrUkNXHZppL?=
 =?us-ascii?Q?FKfiBFc93FzaA7MRVvQ+pKgY2O9SJLrUU+R820usHgYNhMtnIx/Vg6njQ/v+?=
 =?us-ascii?Q?w1Nb+eTytFGYQfqirFpYZxR7ooWnBeoRYuJmp5vGAZfXCst0fvEGb6D8a8Ak?=
 =?us-ascii?Q?3XeerAXR2V2J2jnNNCkD/Ax2LOj7Wk6hv03Gm9GFejJaX4CLI/JRxuzF40zX?=
 =?us-ascii?Q?ivQxRrFr9KumAYdVO06XBuIVNe7Pstk58y6iIZaRmosL0OgHOvlBTBd7l6pk?=
 =?us-ascii?Q?7RXv7sSZ2o/QMBONf0M1rgYTWeTCtgoUzsv0b9YAEvRfjVqMVtUnLRLx0QUA?=
 =?us-ascii?Q?JlR/va0y/ShWDqF25SfSCLH8SH6ChmowG42UU4XFJ4Nf1kmJyl7Ino7SgrcI?=
 =?us-ascii?Q?gy0laLLWe1W6HXbFAmHMSpTOSmDKgLQcSxmagP+2cXNkOJpK2xLJ22dYSNO1?=
 =?us-ascii?Q?XLUzyj7pQ7Lw0rFKIqvYvMJlqhgBaHrZYvXC1j/C2/Aym/v2RW+hNL/xXaCh?=
 =?us-ascii?Q?ZTt30/zAr5WDzf1AatNniBHhUYj53wUJvhJgYrZK5MKIpRO83zi9eZuteHXy?=
 =?us-ascii?Q?ti8XFR5kIPI+HPCE/ivcAVgGOcpWa171dGlX+2dsZYIGkmiy3RbI2pH9na8Y?=
 =?us-ascii?Q?Ee0hWKQ6Ai1DO4Psv+l1gK4GQsK3kZgMrSTP+ynBl5ll3lDqmW6mGEi0nJIQ?=
 =?us-ascii?Q?t/3/YFUGNxGLDg1TH2SsId/5H7s6oto2RhTmT6rsPz8S0UxGkuhGv/xDDtNh?=
 =?us-ascii?Q?fvVZl5HKkZTOm9wime9mkWslZv4mfcXPpKpD276J2CLMKR5GquyV/rf+4Nai?=
 =?us-ascii?Q?sLy42Cngim8Rbd27w+eCXKu93pyv1KLFRIAViJl7/xcEha8nqhMYOl4v+8hZ?=
 =?us-ascii?Q?mJ+B9jsEd+FiuZq7qxn87ZTJd9qjwNrzT1gygjsrcjazbBRuKU0jNzLHACoD?=
 =?us-ascii?Q?O1QV3OespGZ1WHVDJmxkBWBxZ6aElrOQnSB42PlSIMKvFJbno82YWvAcyyLt?=
 =?us-ascii?Q?zT63sMkXqEyRAvRUb8a9N+stdcP4I6mRBMJdDFPj2rNQmmLbf80UfFHkUqog?=
 =?us-ascii?Q?PUdB8g59yrWCJ+xq0sKkj7++ZtigObYy/VezlyeL5h8C1QjgjqRqjzB/6hKB?=
 =?us-ascii?Q?fsobXg2ITGAyeWomj5wMZnkdRbxotiHHOlFIyDFHytAW0HcNcFl9Q/Ujidck?=
 =?us-ascii?Q?hyQhQxmQt5iKBzbIB+49oW01i5l4CmVPczvlTliUbzqsGKtIoyW/xYD3kYAe?=
 =?us-ascii?Q?qrXl5jYhu1yT00D2EoZYS5oZAU8TEurCgTnrP/LX2s3fBNdc9nlIGpUQZ7q1?=
 =?us-ascii?Q?nuhtLCCFTA=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cbb0269-33c4-41f8-c2ed-08de422f1b8b
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Dec 2025 14:25:22.5692
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Mm/QYv0POGZkxIjuuGpeW/T4vQXs1B79cw5JuwvIB7JxU3IaYKp32p02KZNGgQuEj/mYBpYO/i7C0M8SiZ4ulOr1+TDyYqLl4flYSeIFTxw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9PR01MB16098

Hi Claudiu,

> -----Original Message-----
> From: Claudiu <claudiu.beznea@tuxon.dev>
> Sent: 23 December 2025 13:50
> Subject: [PATCH v6 3/8] dmaengine: sh: rz-dmac: Drop read of CHCTRL regis=
ter
>=20
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>=20
> The CHCTRL register has 11 bits that can be updated by software. The docu=
mentation for all these bits
> states the following:
> - A read operation results in 0 being read
> - Writing zero does not affect the operation
>=20
> All bits in the CHCTRL register accessible by software are set and clear =
bits.
>=20
> The documentation for the CLREND bit of CHCTRL states:
> Setting this bit to 1 can clear the END bit of the CHSTAT_n/nS register.
> Also, the DMA transfer end interrupt is cleared. An attempt to read this =
bit results in 0 being read.
> 1: Clears the END bit.
> 0: Does not affect the operation.
>=20
> Since writing zero to any bit in this register does not affect controller=
 operation and reads always
> return zero, there is no need to perform read-modify-write accesses to se=
t the CLREND bit. Drop the
> read of the CHCTRL register.
>=20
> Also, since setting the CLREND bit does not interact with other functiona=
lities exposed through this
> register and only clears the END interrupt, there is no need to lock arou=
nd this operation. Add a
> comment to document this.
>=20
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>

Cheers,
Biju
> ---
>=20
> Changes in v6:
> - none, this patch is new
>=20
>  drivers/dma/sh/rz-dmac.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c index 81=
8d1ef6f0bf..43a772e4478c
> 100644
> --- a/drivers/dma/sh/rz-dmac.c
> +++ b/drivers/dma/sh/rz-dmac.c
> @@ -698,7 +698,7 @@ static void rz_dmac_irq_handle_channel(struct rz_dmac=
_chan *channel)  {
>  	struct dma_chan *chan =3D &channel->vc.chan;
>  	struct rz_dmac *dmac =3D to_rz_dmac(chan->device);
> -	u32 chstat, chctrl;
> +	u32 chstat;
>=20
>  	chstat =3D rz_dmac_ch_readl(channel, CHSTAT, 1);
>  	if (chstat & CHSTAT_ER) {
> @@ -710,8 +710,11 @@ static void rz_dmac_irq_handle_channel(struct rz_dma=
c_chan *channel)
>  		goto done;
>  	}
>=20
> -	chctrl =3D rz_dmac_ch_readl(channel, CHCTRL, 1);
> -	rz_dmac_ch_writel(channel, chctrl | CHCTRL_CLREND, CHCTRL, 1);
> +	/*
> +	 * No need to lock. This just clears the END interrupt. Writing
> +	 * zeros to CHCTRL is just ignored by HW.
> +	 */
> +	rz_dmac_ch_writel(channel, CHCTRL_CLREND, CHCTRL, 1);
>  done:
>  	return;
>  }
> --
> 2.43.0


