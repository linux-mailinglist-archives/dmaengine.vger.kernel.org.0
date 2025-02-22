Return-Path: <dmaengine+bounces-4563-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 99CBEA4062D
	for <lists+dmaengine@lfdr.de>; Sat, 22 Feb 2025 09:06:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3D1518931C6
	for <lists+dmaengine@lfdr.de>; Sat, 22 Feb 2025 08:06:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 303FC1BC09A;
	Sat, 22 Feb 2025 08:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="kD+a+qbI"
X-Original-To: dmaengine@vger.kernel.org
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11011003.outbound.protection.outlook.com [52.101.125.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED63E1482F2;
	Sat, 22 Feb 2025 08:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740211557; cv=fail; b=a2BxEEoAwYdeO5zTOsHpHc6M/Xzws2z0St2LhYr9gCnkzf8PtMTVBOlWJFT/hAq+J7G+OWlmhYVBJF3m09NOQOQorgvmbgkDHitL/L4X5mjHgsk+ktvamzkXGGyARF21uh1sIOBbE6WuxpWCUOldYO6mQDawycv7OP/leJq6oJE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740211557; c=relaxed/simple;
	bh=T+LBnY1dzdcVA71VF2V6YLhgCsqbVNLrYPtM2lZsLtc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IcBudc7yZXPfVI0DBUfrEvE0J6qPlLoHbiAewYbV0ANGWT2h+yXcFnDtModPWLcschYdLXAoQGYTBU7EO/hOF9Wl5/ZWSkp5Nl+EubkvlTv2egE66vnV87jCR325uy/VjbFnRKjmCrnus+KtKYD2cO4ttytzhfsWT2L/1f5gNho=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=kD+a+qbI; arc=fail smtp.client-ip=52.101.125.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wTat2/MJpiSrGGHOpUDGJbFoEoDoWAmeyzyuFe1uWCH5D2XsMxiSaKUX2R3Jlx6RNZzYq+mHW11vZFmCElaMyf3WI3H+8VaLJU3CJB7uCw6PTTst6kznswkvhC3ISAl+QbqQQ/SxJUs3lQsDxLGuKUVYP6wbdpKl1fIr5mOPG6qHme2UnRW2wT+kVAz7uXEpebcq4PJ1WmTfw1up1o6lSOqNfd3OqAcAaV1rTnPXVtYqcb65BMkTdhD8e7Ot0VLrWaLUwgjTYrxnDfdicAFfOGN8b9kms008PdXUQXAO8Kichvi7Hq1L/xp7c1HMs2gviiO2CZiP72Loe3fW3fXO0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o7vaDGI1bB7bjLOsA2AsDs3PCN1KNXogOO013e07bb8=;
 b=YCK0RgLtd970tCPbUPka5hOupwcH1ge+qHHEELryA+Ah7DW02G7qh+zALH7wV26opltf8CEH6wcHufAzF4WmmYCzdl/fJ6UzYey3nD/vl/yB5RYjurJtrr9SH0bUg4ppLVStx7ZRQ0+lnnNs9u61vdOVVJn+jDQ65rn+xPQBuTK1zA3fUyoiJPSRJECs3V4vAqyvVMY9YMIJNfK5AOsoqkicu6lZWX+G+BurTF3Ai2J00BdMao1m0xRHrZgfJVhYnGJy6EFxovRI0wpTdM+en1D35P5WcFtB+5RiT3iGUyAJgy9M7pVlwCM5hOzMcLQv5bjkjnz10HF7GOV9jr5KYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o7vaDGI1bB7bjLOsA2AsDs3PCN1KNXogOO013e07bb8=;
 b=kD+a+qbISvdL9Lq0rsDGvSl/sTsEgM8OcrGsPIRm1A5a627CGnpNPWJYjEOp4Y7/hL/eBxz84ra7Uf2Gwp6uAZ02nVWYRc+EOZ1yrtBbqeBNNurXlqw7aAkp5gVwDgM1sNPALIDFPp3l3VlsVBkYd6V4QpWlq1IKcm7IxiztnW8=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by OS7PR01MB13585.jpnprd01.prod.outlook.com (2603:1096:604:35c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.17; Sat, 22 Feb
 2025 08:05:47 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1%5]) with mapi id 15.20.8466.016; Sat, 22 Feb 2025
 08:05:46 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Fabrizio Castro <fabrizio.castro.jz@renesas.com>, Vinod Koul
	<vkoul@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>
CC: Fabrizio Castro <fabrizio.castro.jz@renesas.com>, Magnus Damm
	<magnus.damm@gmail.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>,
	=?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>,
	"dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [PATCH v4 6/7] dmaengine: sh: rz-dmac: Add RZ/V2H(P) support
Thread-Topic: [PATCH v4 6/7] dmaengine: sh: rz-dmac: Add RZ/V2H(P) support
Thread-Index: AQHbg6haNLctC6ID5UyVBbTDj2gS37NS+QrQ
Date: Sat, 22 Feb 2025 08:05:46 +0000
Message-ID:
 <TY3PR01MB113460BFB6817240662420BF186C62@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20250220150110.738619-1-fabrizio.castro.jz@renesas.com>
 <20250220150110.738619-7-fabrizio.castro.jz@renesas.com>
In-Reply-To: <20250220150110.738619-7-fabrizio.castro.jz@renesas.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|OS7PR01MB13585:EE_
x-ms-office365-filtering-correlation-id: 5c29766d-87d4-4c3d-69d7-08dd5317b696
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?iZwKEH6T3p3hBOg65K1HU4OH5H904CHrAzaYXeDf/WtR5/tgGV+862QPu6?=
 =?iso-8859-1?Q?hHQdyitof0DjDEniqTCtihQVa4ZNntBDfZXJriCZ7pZBbOXs1wYGD04A9n?=
 =?iso-8859-1?Q?4/qeVnMyL7jU3YC8WAGys3J6p/mocNct7IlSRjNIETAIaB58l0BOoEKY3P?=
 =?iso-8859-1?Q?ek+LH47CVefEhZ0IxLznxEGnuIU0d1ea+kfKz0zfYRdedg6EUxDXOhI0Ac?=
 =?iso-8859-1?Q?2bQsy/KNlmoTNREA4RobQzijQ+9mgb39YTZIOXpq/c4lLQhHzMeRO1Bh5D?=
 =?iso-8859-1?Q?QaRa2Jq/B5RWn5/MeKPV8adCaDr8QlZawM3HcWZhBFEhRluxoEaY3dlmtf?=
 =?iso-8859-1?Q?c7eGTRxkLW0Lk4SXIAWKRFPDCc2RfZsKZIal+GfiM79rXbnlC4b29Pik5G?=
 =?iso-8859-1?Q?1+g8UgxZgyWy079SXlbqdjeMNBshBhQ9ekWCssZUGgPngNcTRKg3FUUM5R?=
 =?iso-8859-1?Q?lXHma05TJFqN/Fk00g+f7XQMuP2eVTH8TBhBvs/AlslLGV4B9J2UOWZCPQ?=
 =?iso-8859-1?Q?a73CsdxVvy7VgeXPtBwlrYiJ8ErSCbGQvoJc8nfMfj+3Lh0uI5FqdIYwO2?=
 =?iso-8859-1?Q?G9NtRsvGtkqWuj5U8RwdLfQjyEgCBOnkjC2PPWmIqKVUWamEGolGNdwjTw?=
 =?iso-8859-1?Q?FBwUAGLtVhsj9A+FvLhVgKIK2GiShTmuEPFKbUoZfOMCj+IGGJvQbSacXe?=
 =?iso-8859-1?Q?HLT1JajWkB48dOgd6f2ePLjxfJEwmn/rhodACjjV2jG+sn6IIG90OkG9M4?=
 =?iso-8859-1?Q?vOMS+AL5vA6NsDJrT2ogXpU4CUg+qE9mMr8TVJb2FCk1N35CjQL8KcqkQw?=
 =?iso-8859-1?Q?BOkkB2m6CODyW9xMFFvJaF4RpvbMLmiAlXQGeeCAV5cL1H/kxsH64i1ogW?=
 =?iso-8859-1?Q?WMJY3kxtNO2EmzlGKWO5AvINT7ptNmU6EXBEu3hmTaDg3mqdrZ0hL1bAYB?=
 =?iso-8859-1?Q?b83ptrq24qwCxMvNQOEiXFRxTTH2GVlKW9pPtFlIBsiQ4EW3AHOYTVmCiZ?=
 =?iso-8859-1?Q?j3PrYyUxnDSmrwR8bsLeCUR6M6fENXNb7OAuPT+U1V34PEL52To783YQGA?=
 =?iso-8859-1?Q?LsHA+4KJEjeW5p90QXlFHjsTRMRLL+xQl8x2N/KYZs3UJCg2txDo3uRoIu?=
 =?iso-8859-1?Q?3CbnRySuUc4trd6waTSd/x03iK59QpfYo7pNbWySNQm3sVkVQfyK192jkW?=
 =?iso-8859-1?Q?WrY3OH5gknKO1OlgTj80lpEaJUdccOD3+g/j6zYnjYCDJayviCMNgqyXvH?=
 =?iso-8859-1?Q?Gm1jLj+2V6cP5tdSFH/NSqgH22x81NMJxEirOaBbOjeDsDJqBijwARCi98?=
 =?iso-8859-1?Q?DFMvmrLB+jbiFCMRbHPPPBENN4y41yf92bFfCItPAyU000eu4U1L+mES8w?=
 =?iso-8859-1?Q?sKKbUv5FqMLoEF+wc4gJzwwmYknRNRVx5BbT309N4Xebws8m2QSmaBl9O5?=
 =?iso-8859-1?Q?3KNOoaFX9qMIehOnTJaO+uSFsoa62PUEhDfJgg/OPqpWxYsuNiDSNAC7Fp?=
 =?iso-8859-1?Q?NB7+e6nODoGPHaUwmKc0PD?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?FxAj7O2jvxJKqSJ5N+Db8D9+YBQZYYVxA385z0MmUtYInriKrbp5FuE/q7?=
 =?iso-8859-1?Q?Vehdr2BC/iHA+XbWQKmxfd3ZwhA6nlqBAUZFhbhgSq7gPXE/WHEXbbzYKA?=
 =?iso-8859-1?Q?I7toolYRoFRqqEKVSlYroMNk21/Qa5i1yLO1whrJtrjP5JsThEB0BuVhtw?=
 =?iso-8859-1?Q?qFrWnBSwPFzd0gKLJzkF0Ee+B55mVuMO8suP4mypsyel3ALsybky7oPF4K?=
 =?iso-8859-1?Q?ZY8R5rPmFAAbc36rb8r1kEKJXiZzBRMIAaSO29S8SkjcCnNRkoI29c0oE+?=
 =?iso-8859-1?Q?HWb+tt1pt9ZAxcqhSheOdfBBGQEK1Vl7DBPkRkNrF0ADmNayB1MiQRGIkI?=
 =?iso-8859-1?Q?cbRQ9ItQEt86+/aJlmzIzyz5swrL4fGFbAP7DVFq9NmouQhjx9R6VhmMs9?=
 =?iso-8859-1?Q?b79VpbIO2yvIUA+e7cIITNKev5rklcUAbLKt/b4XpGUilVvnhq76rGT6hd?=
 =?iso-8859-1?Q?rvieblFmOT3cbXMCvGFB9xtmGuCUeyqzMM4beK7qmoA0RAsLdJ9hvtzn12?=
 =?iso-8859-1?Q?BC0yhhr+ZmBqfLn3zlD05O6c7juNCUKMuejXJnlJaHjZB2n1z8zxSIw/F9?=
 =?iso-8859-1?Q?6eTw48mwh5z2wVBLzOof5fyepGKIdE9yYm1CiRjXzlsFvnVJcU2hfd9t2+?=
 =?iso-8859-1?Q?sKk+9+vN6pZ57gbk+UCwcyay3Ceom2ljmTLnKGPE96flEpGUeMOlCXcOhC?=
 =?iso-8859-1?Q?of142C4DohRN8MSDWQxfSEojqSyUNrRlV/ZwbCh/bQp+pJfnRrhJ5tw2eE?=
 =?iso-8859-1?Q?MYvKClj+XNnjkUO4Z1fq8zDGzNf/7mIjXVcdl3UR5yaFbQSpu84XaTZUvr?=
 =?iso-8859-1?Q?E2RjGA7ixOW2yPfqXD+MtCcj2m6qzZAKiA4fo1AaI7IcTsNPqlqssH00pd?=
 =?iso-8859-1?Q?QDbLJhyWlkRnUesAvxqKPoGpDxzwLiNx2ZDpDBCIEhR6WuWET8z7/BuP5e?=
 =?iso-8859-1?Q?wdIBDXZPB8CKQj6f9ryqTsVTqp1LlJu9IHqdIKu9oOBzMkVhSJYQ3PCCR3?=
 =?iso-8859-1?Q?rPHcxWerQ60unrzTgVP+uHAGaOwlNBNAb183R3RwzEloQQlZIXHBRC3SVx?=
 =?iso-8859-1?Q?XRgPwCkdlMGtUwISAJ+mSf3ORCME62gr8+QlhHMvzI91J5owC283ZqseRe?=
 =?iso-8859-1?Q?GqvAIhRGwDh2ud512vP+yZDtPP417HhEAz4NLe8Q5oFS3Aw6A3itAJXKqY?=
 =?iso-8859-1?Q?a0udJQM2RkZCX3oNp3m2JSzslaHfvMhjXLgiNXP9bAFuN5qRUWyrofX0l+?=
 =?iso-8859-1?Q?lQQHAWAUVwWC7LPlYTzw2OrhdEgk+WDtawGKs42EjVHHQJUdcGS2pNCjea?=
 =?iso-8859-1?Q?dl3EfMH3THcl0AfHlBzTC4xQDi/zK53YuouoXDKLCbTVyR1V+zcjyRedhy?=
 =?iso-8859-1?Q?ZmfnI2ScoyvhSQJwzmMn2DLpjrQ0GWqXUQq0eAyVNmWzK/2KBLi0CvUv4k?=
 =?iso-8859-1?Q?cl+dtj06y5ffsLX39oHZVDaRv8YClssSBam4aCocMAxfWOG/nhlJ90KSf7?=
 =?iso-8859-1?Q?IscO2wB1XcGizZlpKfnQWKFCPFnAMQis5HV3gvFClolHH6MzBRPWqhVjbU?=
 =?iso-8859-1?Q?vjKg+kFx8fha/dE9+nrh9GHyaNvhqGyZgBcj6wT9HLvJnlrWhPOeU565n2?=
 =?iso-8859-1?Q?5JFYAEEyPS/P+9S6GAFsEFoMW0AkYuCoY2cRdhRA8b8KpaObbA63Phmw?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c29766d-87d4-4c3d-69d7-08dd5317b696
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Feb 2025 08:05:46.8819
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ko2fFjkY8RGPjzjF+PZob2gaNAitvt0FHS2Rco+ntcQUh4rMVK9EUr5QqxZEm39uvrAlN7thjD5gTxX3oNpP7y/PB1VKb07CMWrd0UlVLP8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7PR01MB13585

Hi Fabrizio Castro,

> -----Original Message-----
> From: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
> Sent: 20 February 2025 15:01
> Subject: [PATCH v4 6/7] dmaengine: sh: rz-dmac: Add RZ/V2H(P) support
>=20
> The DMAC IP found on the Renesas RZ/V2H(P) family of SoCs is similar to t=
he version found on the
> Renesas RZ/G2L family of SoCs, but there are some differences:
> * It only uses one register area
> * It only uses one clock
> * It only uses one reset
> * Instead of using MID/IRD it uses REQ NO/ACK NO
> * It is connected to the Interrupt Control Unit (ICU)
> * On the RZ/G2L there is only 1 DMAC, on the RZ/V2H(P) there are 5
>=20
> Add specific support for the Renesas RZ/V2H(P) family of SoC by tackling =
the aforementioned
> differences.
>=20
> Signed-off-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
> ---
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
>  drivers/dma/sh/rz-dmac.c | 162 +++++++++++++++++++++++++++++++++++----
>  1 file changed, 146 insertions(+), 16 deletions(-)
>=20
> diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c index d7=
a4ce28040b..57a1fdeed734
> 100644
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
> @@ -73,7 +74,6 @@ struct rz_dmac_chan {
>=20
>  	u32 chcfg;
>  	u32 chctrl;
> -	int mid_rid;
>=20
>  	struct list_head ld_free;
>  	struct list_head ld_queue;
> @@ -85,20 +85,36 @@ struct rz_dmac_chan {
>  		struct rz_lmdesc *tail;
>  		dma_addr_t base_dma;
>  	} lmdesc;
> +
> +	union {
> +		int mid_rid;
> +		struct {
> +			u16 req_no;
> +			u8 ack_no;
> +		};
> +	};
>  };
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
>  	struct device *dev;
>  	struct reset_control *rstc;
> +	struct rz_dmac_icu icu;
>  	void __iomem *base;
>  	void __iomem *ext_base;
>=20
>  	unsigned int n_channels;
>  	struct rz_dmac_chan *channels;
>=20
> +	bool has_icu;
> +
>  	DECLARE_BITMAP(modules, 1024);
>  };
>=20
> @@ -167,6 +183,23 @@ struct rz_dmac {
>  #define RZ_DMAC_MAX_CHANNELS		16
>  #define DMAC_NR_LMDESC			64
>=20
> +/* RZ/V2H ICU related */
> +#define RZV2H_REQ_NO_MASK		GENMASK(9, 0)
> +#define RZV2H_ACK_NO_MASK		GENMASK(16, 10)
> +#define RZV2H_HIEN_MASK			BIT(17)
> +#define RZV2H_LVL_MASK			BIT(18)
> +#define RZV2H_AM_MASK			GENMASK(21, 19)
> +#define RZV2H_TM_MASK			BIT(22)
> +#define RZV2H_EXTRACT_REQ_NO(x)		FIELD_GET(RZV2H_REQ_NO_MASK, (x))
> +#define RZV2H_EXTRACT_ACK_NO(x)		FIELD_GET(RZV2H_ACK_NO_MASK, (x))
> +#define RZVH2_EXTRACT_CHCFG(x)		((FIELD_GET(RZV2H_HIEN_MASK, (x)) << 5) =
| \
> +					 (FIELD_GET(RZV2H_LVL_MASK, (x))  << 6) | \
> +					 (FIELD_GET(RZV2H_AM_MASK, (x))   << 8) | \
> +					 (FIELD_GET(RZV2H_TM_MASK, (x))   << 22))
> +
> +#define RZV2H_MAX_DMAC_INDEX		4
> +#define RZV2H_ICU_PROPERTY		"renesas,icu"
> +
>  /*
>   * ---------------------------------------------------------------------=
--------
>   * Device access
> @@ -324,7 +357,15 @@ static void rz_dmac_prepare_desc_for_memcpy(struct r=
z_dmac_chan *channel)
>  	lmdesc->chext =3D 0;
>  	lmdesc->header =3D HEADER_LV;
>=20
> -	rz_dmac_set_dmars_register(dmac, channel->index, 0);
> +	if (!dmac->has_icu) {
> +		rz_dmac_set_dmars_register(dmac, channel->index, 0);
> +	} else {
> +		rzv2h_icu_register_dma_req_ack(dmac->icu.pdev,
> +					       dmac->icu.dmac_index,
> +					       channel->index,
> +					       RZV2H_ICU_DMAC_REQ_NO_DEFAULT,
> +					       RZV2H_ICU_DMAC_ACK_NO_DEFAULT);
> +	}
>=20
>  	channel->chcfg =3D chcfg;
>  	channel->chctrl =3D CHCTRL_STG | CHCTRL_SETEN; @@ -375,7 +416,15 @@ sta=
tic void
> rz_dmac_prepare_descs_for_slave_sg(struct rz_dmac_chan *channel)
>=20
>  	channel->lmdesc.tail =3D lmdesc;
>=20
> -	rz_dmac_set_dmars_register(dmac, channel->index, channel->mid_rid);
> +	if (!dmac->has_icu) {
> +		rz_dmac_set_dmars_register(dmac, channel->index, channel->mid_rid);
> +	} else {
> +		rzv2h_icu_register_dma_req_ack(dmac->icu.pdev,
> +					       dmac->icu.dmac_index,
> +					       channel->index, channel->req_no,
> +					       channel->ack_no);
> +	}
> +
>  	channel->chctrl =3D CHCTRL_SETEN;
>  }
>=20
> @@ -452,9 +501,15 @@ static void rz_dmac_free_chan_resources(struct dma_c=
han *chan)
>  	list_splice_tail_init(&channel->ld_active, &channel->ld_free);
>  	list_splice_tail_init(&channel->ld_queue, &channel->ld_free);
>=20
> -	if (channel->mid_rid >=3D 0) {
> -		clear_bit(channel->mid_rid, dmac->modules);
> -		channel->mid_rid =3D -EINVAL;
> +	if (!dmac->has_icu) {
> +		if (channel->mid_rid >=3D 0) {
> +			clear_bit(channel->mid_rid, dmac->modules);
> +			channel->mid_rid =3D -EINVAL;
> +		}
> +	} else {
> +		clear_bit(channel->req_no, dmac->modules);
> +		channel->req_no =3D RZV2H_ICU_DMAC_REQ_NO_DEFAULT;
> +		channel->ack_no =3D RZV2H_ICU_DMAC_ACK_NO_DEFAULT;
>  	}
>=20
>  	spin_unlock_irqrestore(&channel->vc.lock, flags); @@ -647,7 +702,15 @@ =
static void
> rz_dmac_device_synchronize(struct dma_chan *chan)
>  	if (ret < 0)
>  		dev_warn(dmac->dev, "DMA Timeout");
>=20
> -	rz_dmac_set_dmars_register(dmac, channel->index, 0);
> +	if (!dmac->has_icu) {
> +		rz_dmac_set_dmars_register(dmac, channel->index, 0);
> +	} else {
> +		rzv2h_icu_register_dma_req_ack(dmac->icu.pdev,
> +					       dmac->icu.dmac_index,
> +					       channel->index,
> +					       RZV2H_ICU_DMAC_REQ_NO_DEFAULT,
> +					       RZV2H_ICU_DMAC_ACK_NO_DEFAULT);
> +	}
>  }
>=20
>  /*
> @@ -727,13 +790,30 @@ static bool rz_dmac_chan_filter(struct dma_chan *ch=
an, void *arg)
>  	struct rz_dmac *dmac =3D to_rz_dmac(chan->device);
>  	struct of_phandle_args *dma_spec =3D arg;
>  	u32 ch_cfg;
> +	u16 req_no;
> +
> +	if (!dmac->has_icu) {
> +		channel->mid_rid =3D dma_spec->args[0] & MID_RID_MASK;
> +		ch_cfg =3D (dma_spec->args[0] & CHCFG_MASK) >> 10;
> +		channel->chcfg =3D CHCFG_FILL_TM(ch_cfg) | CHCFG_FILL_AM(ch_cfg) |
> +				 CHCFG_FILL_LVL(ch_cfg) | CHCFG_FILL_HIEN(ch_cfg);
> +
> +		return !test_and_set_bit(channel->mid_rid, dmac->modules);
> +	}
> +
> +	req_no =3D RZV2H_EXTRACT_REQ_NO(dma_spec->args[0]);
> +	if (req_no >=3D RZV2H_ICU_DMAC_REQ_NO_MIN_FIX_OUTPUT)
> +		return false;
> +
> +	channel->req_no =3D req_no;
> +
> +	channel->ack_no =3D RZV2H_EXTRACT_ACK_NO(dma_spec->args[0]);
> +	if (channel->ack_no >=3D RZV2H_ICU_DMAC_ACK_NO_MIN_FIX_OUTPUT)
> +		channel->ack_no =3D RZV2H_ICU_DMAC_ACK_NO_DEFAULT;
>=20
> -	channel->mid_rid =3D dma_spec->args[0] & MID_RID_MASK;
> -	ch_cfg =3D (dma_spec->args[0] & CHCFG_MASK) >> 10;
> -	channel->chcfg =3D CHCFG_FILL_TM(ch_cfg) | CHCFG_FILL_AM(ch_cfg) |
> -			 CHCFG_FILL_LVL(ch_cfg) | CHCFG_FILL_HIEN(ch_cfg);
> +	channel->chcfg =3D RZVH2_EXTRACT_CHCFG(dma_spec->args[0]);

Looks like a typo?? RZVH2_EXTRACT_CHCFG-> RZVH2_EXTRACT_CHCFG

Cheers,
Biju



