Return-Path: <dmaengine+bounces-9732-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EOx2FCmcymmg+QUAu9opvQ
	(envelope-from <dmaengine+bounces-9732-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 30 Mar 2026 17:52:09 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 978F535E30B
	for <lists+dmaengine@lfdr.de>; Mon, 30 Mar 2026 17:52:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EA8D3301C5A3
	for <lists+dmaengine@lfdr.de>; Mon, 30 Mar 2026 15:40:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9416B36C9CA;
	Mon, 30 Mar 2026 15:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="VbgqAMPJ"
X-Original-To: dmaengine@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011004.outbound.protection.outlook.com [40.107.74.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9ADE36A014;
	Mon, 30 Mar 2026 15:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774885201; cv=fail; b=qjPkaOuqZnPDRIHijVqGv4C7nt1mKvgs/79LNJqckChg/isDsi7tuWaWsmWgWjnYKZNtU/soBLqGfRu7wNXiHI1rCMBaSRV20iePMzP/puI5T/XIvqsDNjRWYabJcqYWHpvSzW3L3FgH0kgykxYekd8rQUErmm0bgM/1puIFOnU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774885201; c=relaxed/simple;
	bh=6uoutHE8NMiyF7Ydq6nZzf3t3OgXV0RTFC6jI0nUe3Y=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VllQNxSs1Jnfq6J3E+86hsivGUq2KUJvyyKTgISMQSlGwIlTwwTseh6MwQ4i+WmEA/oVWV6XsJbBc2TrgLLxJ79uBWiaMNSqOEqUEq338GFr5nApv3xHCKMNNVXr3GP/iSYrixYZhZGyziukDbTJjIvXYpvsmwgLCAVRJtWjdto=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=VbgqAMPJ; arc=fail smtp.client-ip=40.107.74.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IVqoxHShnm/kQ4z5NkSyaHodEGKMV9AdYSydjiQsRC5imXlGVsxxvNRCKQTLEZsubA4W45t7r62Frpj2ubdkZZ2+N+44KgZbLi+anZxVnmvwWz4nU46QBvg8SOh76xhCpSqexuyQ0ELjsptEm4UrMkTzDrFdecktNZsBU0OsLaerdlEv6uVIOBo5UVkbSKgP+nNsggHnBDukyWiiD8WNa7MXHJiRyQ+06CyI1vg1ek0ORuYKm8bDHuH4s1xVOC424EZgUkBIfcae4yPTw3ttcSxyRfVystLkp9sjtzy9Nh0HHt7JT1iKp/ULeZm4N33ezTptXjrKIy4WDotbgAAGsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6uoutHE8NMiyF7Ydq6nZzf3t3OgXV0RTFC6jI0nUe3Y=;
 b=WfMUe4ayJEdHLqPy7HNNU+Y3dj2c5XGIfrxfHebRIGet/3szlTUDKdo/Vx9OP2KP/7TsFX4dnKfXfJzPXGyrY2m24hBqv8v/Rjm6eokP5NhWe6qAPpshaKoHevXVlGlV46lPUPdyTPPcRAUUT4Gf+YZaNxuFZGH534X/WkecjXeOX4lDkz8xa9xz2oy46wsujuqlNj/GV/Wi3zFcnI5ISo8b2WaEAvgtwfLZtzQgQ8f0EF4bweCMTUT+j3qeQB2CW/hohN307GtafCT2PomSlHfVUVGl7lqbmpr+l9zNsj4vy7xjoIo8h5ot1Xiy179gBLvmOBeoP3gIDAQ9Hs1HHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6uoutHE8NMiyF7Ydq6nZzf3t3OgXV0RTFC6jI0nUe3Y=;
 b=VbgqAMPJWU/XBk8GqhXVlAT35miUeDSEwsZoBr1lps9qzqhX/IaTS9lpGzdl0svuBPY5Su3w1gNCwpUJnNyHELqmy26uN3iYzwIW2dYAAn9vaZxGGf4mc/StIWgyoePY+uChiiioCGaP4m31mK6vmEFK2vw8D9r+bxcsWtpQj68=
Received: from TY6PR01MB17377.jpnprd01.prod.outlook.com (2603:1096:405:35b::6)
 by OSZPR01MB9486.jpnprd01.prod.outlook.com (2603:1096:604:1d2::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.28; Mon, 30 Mar
 2026 15:39:56 +0000
Received: from TY6PR01MB17377.jpnprd01.prod.outlook.com
 ([fe80::f373:26d6:86c4:6aa3]) by TY6PR01MB17377.jpnprd01.prod.outlook.com
 ([fe80::f373:26d6:86c4:6aa3%4]) with mapi id 15.20.9745.027; Mon, 30 Mar 2026
 15:39:56 +0000
From: John Madieu <john.madieu.xa@bp.renesas.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
CC: Geert Uytterhoeven <geert+renesas@glider.be>, Kuninori Morimoto
	<kuninori.morimoto.gx@renesas.com>, Vinod Koul <vkoul@kernel.org>, Mark Brown
	<broonie@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Michael Turquette <mturquette@baylibre.com>, Stephen
 Boyd <sboyd@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Frank Li
	<Frank.Li@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, magnus.damm
	<magnus.damm@gmail.com>, Thomas Gleixner <tglx@kernel.org>, Jaroslav Kysela
	<perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Philipp Zabel
	<p.zabel@pengutronix.de>, Claudiu.Beznea <claudiu.beznea@tuxon.dev>, Biju Das
	<biju.das.jz@bp.renesas.com>, Fabrizio Castro
	<fabrizio.castro.jz@renesas.com>, Prabhakar Mahadev Lad
	<prabhakar.mahadev-lad.rj@bp.renesas.com>, John Madieu
	<john.madieu@gmail.com>, "linux-renesas-soc@vger.kernel.org"
	<linux-renesas-soc@vger.kernel.org>, "linux-clk@vger.kernel.org"
	<linux-clk@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "dmaengine@vger.kernel.org"
	<dmaengine@vger.kernel.org>, "linux-sound@vger.kernel.org"
	<linux-sound@vger.kernel.org>
Subject: RE: [PATCH 07/22] ASoC: dt-bindings: renesas,rsnd: Add RZ/G3E support
Thread-Topic: [PATCH 07/22] ASoC: dt-bindings: renesas,rsnd: Add RZ/G3E
 support
Thread-Index: AQHct7jYEu3fNOeYykeB2Oqk8wrffrW3KMEAgBAaxJA=
Date: Mon, 30 Mar 2026 15:39:56 +0000
Message-ID:
 <TY6PR01MB173775E9970A41ED3A7FFF1DAFF52A@TY6PR01MB17377.jpnprd01.prod.outlook.com>
References: <20260319155334.51278-1-john.madieu.xa@bp.renesas.com>
 <20260319155334.51278-8-john.madieu.xa@bp.renesas.com>
 <20260320-peculiar-cat-of-acumen-c6f6b3@quoll>
In-Reply-To: <20260320-peculiar-cat-of-acumen-c6f6b3@quoll>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY6PR01MB17377:EE_|OSZPR01MB9486:EE_
x-ms-office365-filtering-correlation-id: 72ef1f55-31fe-488a-fa94-08de8e729843
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700021|18002099003|56012099003|22082099003;
x-microsoft-antispam-message-info:
 V6msYU+PI0ALnrpGXgAtze4sDVvtml4+XaIptk0aBFyA+nsO81wWJTOzEnDmCouMgCrBh/gxinpo0O6LlWhA+lR7WTMmccdIdFRgBjNM2PDNB2JbmG1YF4BCR7SBuiBqH4rTp1nYVC62oc06c64ie1DokgUnRStP265iPTskqHF5NlGRAqafdiyP4G1gbIRcmLFM0wEanAhCsauTInfEnw30cKYppeaXri5giuESAM0iFCO28hMIjSc21vE4kNJq3UrXqICWnkayN79s/KISYtyxWX61mztr6RwcB65MOpAi4ly4wHWARgMaaOiUS1fL65FIy8UIjYVS4mHpSY5zMaXT2IQQKNbkoKN0jkWxUT80PYclP3nWhiJm9u08s0lBZFVEo6n8bucm532nRXchh5QZAQZVYTeDkeQoEgsBdPru+uvRD1AZTIz4oiPL82liBLfWR8Qj1g6Yo5VYu8qhHaYqnrmvqifAeOkU20ZghUmq+LUgcejZcvVGPGjS/QjS65FxbwEXMXGA0YyUrH3RadROcliwnowEwvQobgnirrv7TU3uI67mANjJFmq3UtrO4i+QnfTUuRoDZHWANH+AjvsmQaKcxV9AyxsowJD4wXzN62vcnTN0tSHSSCYZIXSWfPUSq+PqpoFwwNMnWXjH8mEPK64W3rWFvZ72LoZ1UbMQz8W149tLff69P5ZHonplYnK/GanHSaNwjPBB36bM7dXBDW7c8xS4pGzOP0osRdLLegrwwE7kxtI4uL8xZ6EeLh+TB7HRuLJUo5Wwl5XWMkI22d6/WhzXr3YpHy8cJAc=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY6PR01MB17377.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700021)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dVo3Z3ZSSXBVWS9mbUVJck5Od0dCSHBCMm1sZnVXSWRoY2JPV2dnSFBXWFlx?=
 =?utf-8?B?STR0dVFlL2E3c2h2VEorQ1JwQm5aaUNjQkVwMTA4UFplSzF2SlRGL1pDNlJp?=
 =?utf-8?B?ZXZ5c3JNQ3BLdE1pUkt4ZnBVdXc4V2d0bExxT0xNUENjZmJQZXFmbEwvQWdF?=
 =?utf-8?B?Mk9wek5iM21tb21rdVhyRm5kSTBqdlkwcEQ4RzNodzRCU0VlV1laTHRXRU9S?=
 =?utf-8?B?SHdtS083R3VNdUVFOG12WkxoeFZURWxKL2w1TGVHeEJKLzNWNWtOcGFXT21w?=
 =?utf-8?B?L0pmM3oxdnBCVk16WWZNaFdyL0xBQ3FaVi82TkxLYmVESjhpRU5OSHVXSk9w?=
 =?utf-8?B?d095TWYwMFdIUFFaSERiMHhPUldpRk1ZRjlYQUlBUmdkaTY3bFhwL25ET0tx?=
 =?utf-8?B?TzhuYzVtNi83SzR4MGg3eGU5MmxlQllhM0Z1TU5qeXd4M0ZMd1pSZGI5QlYw?=
 =?utf-8?B?R2pWRm9QdDlHTlRCdTM0TVZhYWlVUjEwNGhLZVZ1dXRrZ25DSkorbmUvSEVM?=
 =?utf-8?B?c3ZHRjZaYXFVWXNWeXFCUnFVT1F0L0k2Y3R5em5FRmNZZDI5dFI3MWtZYzlx?=
 =?utf-8?B?Y0Z1YkNKNVV0Z1Ftb3N0WUdxc3Y2dml1TEtxNFBrSUlsTW00bTREaHRvc3Vr?=
 =?utf-8?B?dE0vQlNiMmwrdHpZWUhveXFlWUIwdDhPZFE2dHczT0JtQVdwRWQ1UWJuNHhx?=
 =?utf-8?B?RThJRkFFaXhqOERER1Q4eXV3cGZJRFJjLzBHOUE2YW8rcUZKTDdNT3hLb3gr?=
 =?utf-8?B?eC9oUm81R0poUVBoMGlZc1Q1ZkJNMFBOV1NMeE1VTUZBLy9CK3RsT3h5RnV3?=
 =?utf-8?B?NENkNmhXM3pOeW9LT1BzMjJ3N2JtY05SY3pPVTlNeGhkTTV5SmpVYjhwTXJo?=
 =?utf-8?B?eTh2TUlmWlJ4ZVg2emZHaXNadUcxWnZWVW14ZW1xY0dEMUJrTXNNWW1MQjY0?=
 =?utf-8?B?eTBxY1JYcDRUNXFvaVo4YU1FYUNUR0lyWFR2cy9IaFNzNTVqb2p2YlhTamt1?=
 =?utf-8?B?NmwzZzgvNHo1c3YyZm56VXhwaW14bGVvNGptR1JRY1RnNWhlaTNXRzBZMWcx?=
 =?utf-8?B?eVBFZTNhbWhTRTlVUW4xdWcwVVYrd2pRU2VTY2FTbFhuVmdDNUZGd2ZnVmRn?=
 =?utf-8?B?eEVMOHhkRU00SkhBU0l6QW83bEhRRHZJbmhZbHJyVWhmb3ViN0ZTV2ZKaG51?=
 =?utf-8?B?Tm5rUkhmWGxEZFJqOFc4QzF3Q290WDJKdXd4eWx1K1lwWHRMSWVTcm9zL3pR?=
 =?utf-8?B?RDNJcHpVUTRndkxqb2pRb01pR1ZyNTdBL0VMaDNuaFhPVmZySnR6NjVRaHhE?=
 =?utf-8?B?NmUzNWdrbFo3c2VZZG03NkRLeGFpVmp2M3lORlN2aWlOeU1RNHNQekZ3cHFy?=
 =?utf-8?B?K0IwVDhuNDU4MHVzSUxkTUV2K20yLzZHdDNweUZRd1hWY3cweWRNR3U1ajcy?=
 =?utf-8?B?RlZpRXZEZWtKTnA1c3dWSGZnc2l0eFdsczZDWmVTTXRTZUtpdDVxZjdhWlIz?=
 =?utf-8?B?a1ZZbzdMOWxqVWdaS1hNcjk3bHlIdTVqTW8yZTh3WTdvSEVTUndZM1BKOWN2?=
 =?utf-8?B?MlJIaTJTbVBXZlYzNDY2NnRKQWhNYlVIM09EL3hSbjZzUitEOHZDQkYxUFhR?=
 =?utf-8?B?RVhnU1lkenZuMFZuV3h1eHdhQVkraGxCc2RlR2hzSERQbllDMk02VWIrdExi?=
 =?utf-8?B?NHpDWU56djJJNWRFcHZaNzloZ1JwZFVwSHRxbnFrZWhSc2x5a2lKUXd0MUNu?=
 =?utf-8?B?VEJnYkRUNEQ5MXliU1prVkp3SzhaNkFWY0xJaXJBaUZKOFNCdjVSSkh6M3VX?=
 =?utf-8?B?ajBranY0MGRyVGd1bEowdS9FOXR2b1RMcDljRDNrUlptVjRhTG5UVlpaUE5H?=
 =?utf-8?B?a21WZDhld2w0eEhoSE9NaGxtOXFFbGQ4M1JJYzE3cEx6djhvS1E3SXZvMjZU?=
 =?utf-8?B?dVRzUXdTU0lPa3NpS3I4anZuVU1LSzNNOWYrMUtpeXlLbjFIVm5TUG9ka3pw?=
 =?utf-8?B?V2hjSW9KNjRwZVFzOS9Gc2c4SGpPY2pZV0h0YW83SUNUOFYzZWpGUXFpZFB1?=
 =?utf-8?B?bGNaRHQ5dm5pRjZIZ2lSSDZBWVdlbE0yYWptVkY2MTJZeWlsbXBxQmVGNDZ5?=
 =?utf-8?B?NnFYUUlkTUtldUIrRlpKTVVYWFUydy9iMERxR3hQOXlDUnhSdzJJak5wbjVD?=
 =?utf-8?B?VFFqejRhYTRHV1lUelZpYk0vYjU5UFZDTWdDR2pCT3RHWmt4UUhQdjV1Tkta?=
 =?utf-8?B?b2Z6WGdKSzlRMTFacS8wM1ZhZmFGb3BxS0RoNm9tNFJPTGx3R1RoVGlRV3A5?=
 =?utf-8?B?WDNTUDBPYWZGTzFqam1BQUp4UXBTSUJRQm5Ca2FQVURUTncvTHMzUklpZS9L?=
 =?utf-8?Q?rss8EwfF3oBpC6v8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY6PR01MB17377.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72ef1f55-31fe-488a-fa94-08de8e729843
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Mar 2026 15:39:56.4587
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Kh4MQnUA8tdumbw0pbJWWCmc54QIrH8FPV+4nH9W4JdO9W6hCQMPctC0M3lYIOTK/a95ifc40FIGCvyDx75LoLBfKga147o4qgH2cea4vT0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB9486
X-Spamd-Result: default: False [2.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[renesas.com,none];
	R_DKIM_ALLOW(-0.20)[bp.renesas.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9732-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[28];
	FREEMAIL_CC(0.00)[glider.be,renesas.com,kernel.org,baylibre.com,gmail.com,perex.cz,suse.com,pengutronix.de,tuxon.dev,bp.renesas.com,vger.kernel.org];
	DKIM_TRACE(0.00)[bp.renesas.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[john.madieu.xa@bp.renesas.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[dmaengine,renesas,dt];
	NEURAL_HAM(-0.00)[-1.000];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[TY6PR01MB17377.jpnprd01.prod.outlook.com:mid,bp.renesas.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,renesas.com:email]
X-Rspamd-Queue-Id: 978F535E30B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

SGkgS3J6eXN6dG9mLA0KDQpUaGFua3MgZm9yIHRoZSByZXZpZXcuDQoNCj4gLS0tLS1PcmlnaW5h
bCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogS3J6eXN6dG9mIEtvemxvd3NraSA8a3J6a0BrZXJuZWwu
b3JnPg0KPiBTZW50OiBGcmlkYXksIE1hcmNoIDIwLCAyMDI2IDEwOjMwIEFNDQo+IFRvOiBKb2hu
IE1hZGlldSA8am9obi5tYWRpZXUueGFAYnAucmVuZXNhcy5jb20+DQo+IFN1YmplY3Q6IFJlOiBb
UEFUQ0ggMDcvMjJdIEFTb0M6IGR0LWJpbmRpbmdzOiByZW5lc2FzLHJzbmQ6IEFkZCBSWi9HM0UN
Cj4gc3VwcG9ydA0KPiANCj4gT24gVGh1LCBNYXIgMTksIDIwMjYgYXQgMDQ6NTM6MTlQTSArMDEw
MCwgSm9obiBNYWRpZXUgd3JvdGU6DQo+ID4gQWRkIHN1cHBvcnQgZm9yIHRoZSBSWi9HM0UgKFI5
QTA5RzA0NykgU29DIGF1ZGlvIHN1YnN5c3RlbS4NCj4gPg0KPiA+IFJaL0czRSBoYXMgYSBkaWZm
ZXJlbnQgYXVkaW8gYXJjaGl0ZWN0dXJlIGZyb20gUi1DYXIgR2VuMi9HZW4zL0dlbjQsDQo+ID4g
d2l0aCBhZGRpdGlvbmFsIGNsb2NrcyBhbmQgcmVzZXRzOg0KPiA+IC0gUGVyLVNTSSBBREcgY2xv
Y2tzIChhZGcuc3NpLjAtOSkNCj4gPiAtIFNDVSByZWxhdGVkIGNsb2NrcyAoc2N1LCBzY3VfeDIs
IHNjdV9zdXBwbHkpDQo+ID4gLSBTU0lGIHN1cHBseSBjbG9jaw0KPiA+IC0gQVVETUFDIHBlcmkt
cGVyaSBjbG9jaw0KPiA+IC0gQURHIGNsb2NrDQo+ID4gLSBBZGRpdGlvbmFsIHJlc2V0cyBmb3Ig
U0NVLCBBREcsIGFuZCBBVURNQUMgcGVyaS1wZXJpDQo+ID4NCj4gPiBSWi9HM0UgaGFzIDUgRE1B
IGNvbnRyb2xsZXJzIHRoYXQgY2FuIGFsbCBiZSB1c2VkIGJ5IGF1ZGlvIHBlcmlwaGVyYWxzLg0K
PiA+IFRvIGFsbG93IHRoZSBETUEgY29yZSB0byBkaXN0cmlidXRlIGNoYW5uZWxzIGFjcm9zcyBh
bGwgYXZhaWxhYmxlDQo+ID4gY29udHJvbGxlcnMsIGluY3JlYXNlIHRoZSBtYXhpbXVtIG51bWJl
ciBvZiBETUEgZW50cmllcyBpbiBEVkMsIFNSQywNCj4gPiBhbmQgU1NJVSBzdWItbm9kZXMgc28g
dGhhdCBtdWx0aXBsZSBwcm92aWRlcnMgY2FuIGJlIGxpc3RlZCB3aXRoDQo+ID4gcmVwZWF0ZWQg
Y2hhbm5lbCBuYW1lcy4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEpvaG4gTWFkaWV1IDxqb2hu
Lm1hZGlldS54YUBicC5yZW5lc2FzLmNvbT4NCj4gPiAtLS0NCj4gPiAgLi4uL2JpbmRpbmdzL3Nv
dW5kL3JlbmVzYXMscnNuZC55YW1sICAgICAgICAgIHwgMTY5ICsrKysrKysrKysrKysrKy0tLQ0K
PiA+ICAxIGZpbGUgY2hhbmdlZCwgMTQ4IGluc2VydGlvbnMoKyksIDIxIGRlbGV0aW9ucygtKQ0K
PiA+DQo+ID4gZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9z
b3VuZC9yZW5lc2FzLHJzbmQueWFtbA0KPiA+IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2Jp
bmRpbmdzL3NvdW5kL3JlbmVzYXMscnNuZC55YW1sDQo+ID4gaW5kZXggZThhMmFjYjkyNjQ2Li5i
Yzg4ODVjNGZhMjQgMTAwNjQ0DQo+ID4gLS0tIGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2Jp
bmRpbmdzL3NvdW5kL3JlbmVzYXMscnNuZC55YW1sDQo+ID4gKysrIGIvRG9jdW1lbnRhdGlvbi9k
ZXZpY2V0cmVlL2JpbmRpbmdzL3NvdW5kL3JlbmVzYXMscnNuZC55YW1sDQo+ID4gQEAgLTU4LDYg
KzU4LDcgQEAgcHJvcGVydGllczoNCj4gPiAgICAgICAgICAgIC0gcmVuZXNhcyxyY2FyX3NvdW5k
LWdlbjINCj4gPiAgICAgICAgICAgIC0gcmVuZXNhcyxyY2FyX3NvdW5kLWdlbjMNCj4gPiAgICAg
ICAgICAgIC0gcmVuZXNhcyxyY2FyX3NvdW5kLWdlbjQNCj4gPiArICAgICAgICAgIC0gcmVuZXNh
cyxyY2FyX3NvdW5kLXI5YTA5ZzA0NyAgICAgIyBSWi9HM0UNCj4gDQo+IERvIG5vdCB1c2UgdW5k
ZXJzY29yZXMgaW4gY29tcGF0aWJsZXMuIFByZXZpb3VzbHkgdXNlZCB3cm9uZyBzdHlsZSBpcyBu
b3QNCj4gdGhlIGV4Y3VzZSBoZXJlLCBqdXN0IGxpa2UgcHJldmlvdXNseSBwb29yIGNvZGUsIG1p
c3Rha2VzLCBidWdzLA0KPiB1bnJlYWRhYmxlIGFwcHJvY2hlcyBpcyBub3QganVzdGlmaWNhdGlv
biB0byByZXBlYXQgdGhlIHNhbWUuDQo+IA0KDQpHb3QgaXQuDQoNCj4gPg0KPiA+ICAgIHJlZzoN
Cj4gPiAgICAgIG1pbkl0ZW1zOiAxDQo+ID4gQEAgLTk3LDIwICs5OCwyMiBAQCBwcm9wZXJ0aWVz
Og0KPiA+DQo+ID4gICAgcmVzZXRzOg0KPiA+ICAgICAgbWluSXRlbXM6IDENCj4gPiAtICAgIG1h
eEl0ZW1zOiAxMQ0KPiA+ICsgICAgbWF4SXRlbXM6IDE0DQo+ID4NCj4gPiAgICByZXNldC1uYW1l
czoNCj4gPiAgICAgIG1pbkl0ZW1zOiAxDQo+ID4gLSAgICBtYXhJdGVtczogMTENCj4gPiArICAg
IG1heEl0ZW1zOiAxNA0KPiA+DQo+ID4gICAgY2xvY2tzOg0KPiA+ICAgICAgZGVzY3JpcHRpb246
IFJlZmVyZW5jZXMgdG8gU1NJL1NSQy9NSVgvQ1RVL0RWQy9BVURJT19DTEsgY2xvY2tzLg0KPiA+
ICAgICAgbWluSXRlbXM6IDENCj4gPiAtICAgIG1heEl0ZW1zOiAzMQ0KPiA+ICsgICAgbWF4SXRl
bXM6IDQ3DQo+ID4NCj4gPiAgICBjbG9jay1uYW1lczoNCj4gPiAgICAgIGRlc2NyaXB0aW9uOiBM
aXN0IG9mIG5lY2Vzc2FyeSBjbG9jayBuYW1lcy4NCj4gPiAgICAgICMgZGV0YWlscyBhcmUgZGVm
aW5lZCBiZWxvdw0KPiA+ICsgICAgbWluSXRlbXM6IDENCj4gPiArICAgIG1heEl0ZW1zOiA0Nw0K
PiA+DQo+ID4gICAgIyBwb3J0cyBpcyBiZWxvdw0KPiA+ICAgIHBvcnQ6DQo+ID4gQEAgLTEzNiw5
ICsxMzksMTcgQEAgcHJvcGVydGllczoNCj4gPg0KPiA+ICAgICAgICAgIHByb3BlcnRpZXM6DQo+
ID4gICAgICAgICAgICBkbWFzOg0KPiA+IC0gICAgICAgICAgICBtYXhJdGVtczogMQ0KPiA+ICsg
ICAgICAgICAgICBkZXNjcmlwdGlvbjoNCj4gPiArICAgICAgICAgICAgICBNdXN0IGNvbnRhaW4g
dW5pcXVlIERNQSBzcGVjaWZpZXJzLCBvbmUgcGVyIGF2YWlsYWJsZQ0KPiA+ICsgICAgICAgICAg
ICAgIERNQUMuIE9uIFJaL0czRSwgdXAgdG8gNSBmb3IgdHJhbnNtaXNzaW9uLg0KPiA+ICsgICAg
ICAgICAgICBtaW5JdGVtczogMQ0KPiA+ICsgICAgICAgICAgICBtYXhJdGVtczogNQ0KPiA+ICAg
ICAgICAgICAgZG1hLW5hbWVzOg0KPiA+IC0gICAgICAgICAgICBjb25zdDogdHgNCj4gPiArICAg
ICAgICAgICAgbWluSXRlbXM6IDENCj4gPiArICAgICAgICAgICAgbWF4SXRlbXM6IDUNCj4gPiAr
ICAgICAgICAgICAgaXRlbXM6DQo+ID4gKyAgICAgICAgICAgICAgZW51bToNCj4gPiArICAgICAg
ICAgICAgICAgIC0gdHgNCj4gDQo+IE11bHRpcGxlIGxldmVscywgbXVsdGlwbGUgaWY6dGhlbjog
KGZ1cnRoZXIpIC0gSSBkb24ndCBmaW5kIHRoaXMgYmluZGluZw0KPiBtYW5hZ2VhYmxlL3JlYWRh
YmxlLiBZb3Ugc2hvdWxkIHNwbGl0IGl0LCB3aXRoIGNvbW1vbiBiaW5kaW5nIGRlZmluaW5nDQo+
IGNvbW1vbiBwYXJ0IG9mIGhhcmR3YXJlIG9yIGludGVyZmFjZSBpZiB0aGVyZSBpcyBzdWNoLg0K
DQpJIGFzIHlvdSBzdWdnZXN0ZWQsIEknbGwgc3BsaXQgaXQuIEp1c3QgdG8gZG91YmxlIGNoZWNr
LCBzaG91bGQgSSBmaXgNCmFueSBidWcgZm91bmQgaW4gdGhlcmUgKGxpa2UgZXhpc3RpbmcgY29t
cGF0aWJsZSBzdHJpbmdzIGhhdmluZyB1bmRlcnNjb3JlDQpzZXBhcmF0b3JzKSA/IE9yIHNob3Vs
ZCBJIGp1c3Qgc3BsaXQgYW5kIG1ha2Ugc3VyZSBvbmx5IG5ldyBTb0Mgc3VwcG9ydCBpcw0KYnVn
IGZyZWUgPw0KDQpSZWdhcmRzLA0KSm9obg0KDQoNCj4gDQo+IEJlc3QgcmVnYXJkcywNCj4gS3J6
eXN6dG9mDQoNCg==

