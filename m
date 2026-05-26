Return-Path: <dmaengine+bounces-10933-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KITlJ1l5FWrHVAcAu9opvQ
	(envelope-from <dmaengine+bounces-10933-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 26 May 2026 12:43:37 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F1CC55D4521
	for <lists+dmaengine@lfdr.de>; Tue, 26 May 2026 12:43:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6E571305431F
	for <lists+dmaengine@lfdr.de>; Tue, 26 May 2026 10:39:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1A723DD860;
	Tue, 26 May 2026 10:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="swTJmyvS"
X-Original-To: dmaengine@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011061.outbound.protection.outlook.com [40.107.74.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5D333D649A;
	Tue, 26 May 2026 10:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779791970; cv=fail; b=hwp55XXl1dUqPpZTf2BWyOOGFOn8+jf6+0JTVHRSSFHycArH9U3U/BJ1V9LnImUuEv/DQh3HYQwiV3nL/+6Exg0/yDZ3Q1GZsEO1dz6ss130zHkaawKih53l+Fx1yxnCU8pzuYi818tZPN+ddOoDGaxNixFIhFKsYoQSHTv49XE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779791970; c=relaxed/simple;
	bh=85fx82TEDW/7XPMuyDiKAHKEVqTO1tvaU5/q6Cm18SI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZnKKEQ5BwMfQYIr/ORTUa3Qy5A8d3FoSLIkyhQetEmQDFDFIja3ST2yvEsAX7cE8+3Z4QzsCEccWXLyirBSOa9uG/nkUkUxFnYtmzV0xG9CFfoDNQQOkfyHgKo+6r8TgmWofGXMJ5nommWsoJ8LPBJ4vVJ46n0Ppev4JZGL3v5s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=swTJmyvS; arc=fail smtp.client-ip=40.107.74.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YEKt+IRI5Q+SGZOfN6H0WiS51Yhx4X0vj4tmnw1vayJoXP+2Zj5Rsv8bWzVBSQACg63TGP+KI8loMHzdCJOKCSTMGThi7en9vSL8fE/CKDCLMzG290L4uMTohNSeA9VOAoyLHo6TRQXS8s0Ib7j8+PfFunVVmBd06TkOiNZJg/YFGUVWctucpGQu3dzl+HUnS8UKvZzSTM3J5WuE9t1Am796SPFSLb1TLr398T4lgFz0tWyyJMr2zvZKbcNiDoOgnurA9ev2WZr43X/DkzV35+G1+oiS0rGPZFvtSjQc4+otTMw1nPRhgQ1FEj5gU0t7cH9Of5m/N243R2ATkkLpNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=85fx82TEDW/7XPMuyDiKAHKEVqTO1tvaU5/q6Cm18SI=;
 b=LycWv8DRDT7seR4DnxPMm0pohX5JNkwluQevRPzbYM0IN++zRR590bkGuRp+XIoDsuoK3UUgNvnHNmewJ+v6JioPGZtUs2KOu7XI0MBy9VjwvxlnC6iQrm49caNFRMk2GyPBN7S+wFnVEfOeyi0gicFcH+Fzy8x9ZSubXDMtUmTuWyyMhNYk3JYa6dTY7eWXU2fBLxTinKZV69WMTz6wQmpZpFKOmRr9RYDn2w4lEaXpKVSn3sCZSWLhaW6R9Opt3WXik3m3KopyMkMXay2ZmPtwHQ80Sr17V8csCYrZE0EWft/elrZhapJ3DKeP5zklH2J3QBjCZ6McIp1rA5d84A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=85fx82TEDW/7XPMuyDiKAHKEVqTO1tvaU5/q6Cm18SI=;
 b=swTJmyvSQyb7bVEPx89kwMcmfRYFI+fQTiLViK0xmm37PAReV3o1mUyvDrrJ70Vb9peF4mWQRBIVI5s2qfRaglSR0DGGomtxaCzhh+sxku1NvGlXibq3JUfpdJtp8XCGm6bzVaBW3xj6Y5BfvlarWLiPRJWZJS9oNVh36bIGhyQ=
Received: from TYCPR01MB11332.jpnprd01.prod.outlook.com (2603:1096:400:3c0::7)
 by TYRPR01MB12172.jpnprd01.prod.outlook.com (2603:1096:405:100::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.20; Tue, 26 May
 2026 10:39:26 +0000
Received: from TYCPR01MB11332.jpnprd01.prod.outlook.com
 ([fe80::2511:10cd:e497:4d97]) by TYCPR01MB11332.jpnprd01.prod.outlook.com
 ([fe80::2511:10cd:e497:4d97%6]) with mapi id 15.21.0048.019; Tue, 26 May 2026
 10:39:26 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Claudiu Beznea <claudiu.beznea@kernel.org>, "vkoul@kernel.org"
	<vkoul@kernel.org>, "Frank.Li@kernel.org" <Frank.Li@kernel.org>,
	"lgirdwood@gmail.com" <lgirdwood@gmail.com>, "broonie@kernel.org"
	<broonie@kernel.org>, "perex@perex.cz" <perex@perex.cz>, "tiwai@suse.com"
	<tiwai@suse.com>, Prabhakar Mahadev Lad
	<prabhakar.mahadev-lad.rj@bp.renesas.com>, "p.zabel@pengutronix.de"
	<p.zabel@pengutronix.de>, "geert+renesas@glider.be"
	<geert+renesas@glider.be>, Kuninori Morimoto
	<kuninori.morimoto.gx@renesas.com>, Long Luu <long.luu.ur@renesas.com>
CC: Claudiu.Beznea <claudiu.beznea@tuxon.dev>, "dmaengine@vger.kernel.org"
	<dmaengine@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-sound@vger.kernel.org"
	<linux-sound@vger.kernel.org>, "linux-renesas-soc@vger.kernel.org"
	<linux-renesas-soc@vger.kernel.org>, Claudiu Beznea
	<claudiu.beznea.uj@bp.renesas.com>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>, Frank Li <Frank.Li@nxp.com>, John Madieu
	<john.madieu.xa@bp.renesas.com>
Subject: RE: [PATCH v6 01/18] dmaengine: sh: rz-dmac: Move interrupt request
 after everything is set up
Thread-Topic: [PATCH v6 01/18] dmaengine: sh: rz-dmac: Move interrupt request
 after everything is set up
Thread-Index: AQHc7OxJ+K5vYSqOKUeeUPNEYC8zxrYf/50wgAAPWgCAAAC1wIAACoiAgAACy/A=
Date: Tue, 26 May 2026 10:39:25 +0000
Message-ID:
 <TYCPR01MB113327A67DA483D18D1205AAC860B2@TYCPR01MB11332.jpnprd01.prod.outlook.com>
References: <20260526084710.3491480-1-claudiu.beznea@kernel.org>
 <20260526084710.3491480-2-claudiu.beznea@kernel.org>
 <TY3PR01MB11346AC919B1D62FADB18FB20860B2@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <8dcf50ee-94b7-4b27-895d-2448eb772c08@kernel.org>
 <TYCPR01MB1133214647B09C658AC96A4D9860B2@TYCPR01MB11332.jpnprd01.prod.outlook.com>
 <a3bfb7a9-9980-4dea-aa14-c5973cf80638@kernel.org>
In-Reply-To: <a3bfb7a9-9980-4dea-aa14-c5973cf80638@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB11332:EE_|TYRPR01MB12172:EE_
x-ms-office365-filtering-correlation-id: 75ef268b-1d23-4ac4-c684-08debb130ec7
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|6133799003|11063799006|5023799004|22082099003|18002099003|56012099003|4143699003|921020|38070700021;
x-microsoft-antispam-message-info:
 XecM7wa2RHZrOk0IT6ws7qWVuzmDeJ/k8yc8VFZFATvXDpq2kWBWp+NBs/7yqXIGsH8+221ZCdUdZ11Xn/0UQi8Gve6JA33uREiFJWEW4fGmXQqIe1+HcrXV/tr93uZcImGcgXoqZ4vl8mDgYN5NJR0GeSsnDQPUeVuw0sKHsC568Kqnz5KggSg0wjOBaUuRTlo4vgi9umIbbOAdRNr0DvK3QSrF/neLtyPTNqf7BorELZ0Y34IqRWAEJh5YMukESx07kxbQ5dlSab4aN8ORdqbIv0GPfCXMbv7Xggw3k5q1Hc7H+NoxS41uG7FTSV5oUdHlKpBvMP4z8oHDizl0JKvDHrK6jHbAS6EsgfjIabtSCHibD6dfv4zLTHTPz336m1nxd5J45Bl6YimT7IdcXdwbb/z+N7TMu6EmggUW840K7gtl9/qJSqe9aC3GktEdxRVIR0h0Gdl7YkoTRhUD7K8OczncXgQu664h+bPzhYFQd4wBazmuWUwQAJtoOuGE/D383S2OwQez6W6Bner9OS7onBcE8bsdUspDtvvGZr2+nlI0lxQPnQMDZjzJGvj+toL7IkCi2afIl19C3bLdSEvczCmJnU4yxdIhHgNiAB2KbKaF7DrVthsHX4ImrpikOK9CmgsDfmUM4BNrL50NyAPvKl9WtKb6xDq5gwaXAMbw9H4PpyAUHkZTWXDOag8HNnKj41Me7zipRz+3jAKbeeoospI/Tjcv6zfU1/jNZDk=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11332.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(6133799003)(11063799006)(5023799004)(22082099003)(18002099003)(56012099003)(4143699003)(921020)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZkFRYm9ieXJFS2VJZzNnQ1ppTE96SXkxb0p3K2EwOFdiTXJyZ0hUTDFyN2Fn?=
 =?utf-8?B?VnZ4NitHbnJ5cndyTXJiVUZsRElvVnRTWWlsMms2VkZaRWhjYkFqcmlob3pD?=
 =?utf-8?B?dUpHWU5WM3Rjem5QRzB6bjMvcHBMNWhxS2VtdWJuWERYMUhhbmFxRFJucWlH?=
 =?utf-8?B?MjBMZUg3b29qN21kTjdwdHBaVC8zelVyT3B5VGgrbTJnMGxiRG9Zb20yVVAr?=
 =?utf-8?B?Yk54b3RjcXFIclFVbmlwbWl0SS90TktuRGx4ZnpuMm11K2hzYWF4MGJrUldB?=
 =?utf-8?B?djNmTWF2TnQ2alBnaFlTNStXT0xNMWt4N0VHb1JNUHpoUllZVEczY0F3ejNJ?=
 =?utf-8?B?QU9oaFNPUWlXbVhOdGl0T050OXloQ3MrL1ZRTmVzYUNhbTF2amJsa2hEbnN3?=
 =?utf-8?B?T0JSU1R6bnB0MDlPRkRnenVRL09mbmhTT1Q5MWRHa1NTVHVyM0d5eWRZT0c0?=
 =?utf-8?B?eXZPWTNsSHFMcGt2ZThCczZIV1JvL2pvNzFEZm9WMW93T0JiQnE5cklpeTda?=
 =?utf-8?B?SExoZnBta0xOMjZaUE1wbjNWTHNhY2xmajNPMG1LMUNPdVBDbjlwVjk2OTZN?=
 =?utf-8?B?UFo5cDI4T1d3dVFWUWNlQ0JsY0tUcWFXR0dmQ3N2czcwdmtOOTRpaEI1R0pm?=
 =?utf-8?B?bGlBMTdtVlkveXZGbDhEcm9Oa2wxNkI4UTB6UUpMVHQ3c2ZseGYxa0hzRnQw?=
 =?utf-8?B?WUIyVXcxUTdNb0wySVdZMVlCY1JKMEJTcWtCcFlaZUF5T3JZZGJRM0hZUG4r?=
 =?utf-8?B?MFZBUzRUQ3ZzOXFhckdmdDRHcjFoQUowNHFHQUFWeHFvYWlGM2k2S0JqZkE5?=
 =?utf-8?B?UWxjdXFJYVA4NWFTanl6cUo0NXd6eTNUZE9mK2trOHlrMDNrNFdtQndEclRN?=
 =?utf-8?B?VGFEeEszdUc0dC96UkovRWdRR2NLQ05kd0ZzUHRrSVF0R0dMUWl4UnlUSUsz?=
 =?utf-8?B?TWhRVk05Y1FyRkVRL1Q0WUtDUzJ5RFZSRktrRFg0MUl3amhrZ0YrSzJ6TzZl?=
 =?utf-8?B?NWlVaXJEckdCM2k3ZTVveTRJMDh4NDNLZ0hnc0lRSWFWanBFV3VPNnI1cFJJ?=
 =?utf-8?B?YzFveklzU3VEMjR3UmFIS2R6KzY2V1JnTjRSSWZ5RCtsZ0lXWTYxSTVwcVRm?=
 =?utf-8?B?M05IL2FLdjdTUFYzR2syTGx2OWJIRW1CanZSK09FRnIxYmNtUHNKelRaZ292?=
 =?utf-8?B?Zy9MbjhBWEpSUE9zTVQxblc2eXBxV25oZzRKZzA5cnhqZnhNMDNzVG0wQ2l0?=
 =?utf-8?B?WXB3YnZsTkRienhBMDZXcXk4OHR0b1JiYjhnN3Nua3dRLzRWUmN4MnFqYUMz?=
 =?utf-8?B?NGZLbTdrdG15NFk3MGVoM05OWGQwWWtZZzJZbzd1d090K2VhTFlsYXZmQSti?=
 =?utf-8?B?SnAySW5BMDN1bXBIN0ZkeU5VSEt5NjIwYWMzTkRzdjh4VGJqTGdmcXA2KzZl?=
 =?utf-8?B?RW9DWUJRQmZiQjB0RWxxdlhXalBSUEdRZFJQYzduVEo5STBYZUlRWU1ieTNo?=
 =?utf-8?B?ZWR3ektSTGdJVlZPbGp4WFRmTFlnSHAyZS9NTjhWWkxFYTdnMkoxVmw0Y3d6?=
 =?utf-8?B?YjQ1UDE3dWYrRmJ6NjhWcXJMRkpsZTVMc2Y1ZTh4Sms5eFloNUoxZDFJQS9j?=
 =?utf-8?B?QU5jQ3FSemdBZzdJOSttV3hPNjgrRUN4RXowdlc0WHVIbG1MVmRndW5ScmlX?=
 =?utf-8?B?c0I4eGhEckFPWFkrbnpvK0VkeldUSDJXbDcxeis1eXE3Zkp2MVRzdDVpQTNT?=
 =?utf-8?B?UjNURlJiR0F5OHpRc0tDQ2xLMy9iLzFBQlJ1aStVYmFROVFiSWxTYU1sTU9s?=
 =?utf-8?B?Q1J6YWFYMWZ2MzJ5SS9hdWMvTnpYWUUrcGJWaWl4cHRLRkZTZDNmV3UxUk1j?=
 =?utf-8?B?NkswSFRTa0tLS0hGbjVSWmNvNWVsUG94Qmc4RU5uSzR1NjBtbDYwVkN5STBr?=
 =?utf-8?B?a2NEQnhMSEJQVGMxUUNuQjNsTjZUeVVORnE3ZW9RNGlrTUMvd0pNcDZjYXZQ?=
 =?utf-8?B?UlhlZ01VVk1zRWkwSExBcy9EVlp6RStZL05QQlJ6Rks4bjE5VVhEUFRTWWFF?=
 =?utf-8?B?dlQwZzJXRnV2NERzQUdUdUwzblhNeU54cUJiZHFYS3E4dGhyaTdTaGZQYXB6?=
 =?utf-8?B?Mm9NcmlLSit4NmY3ck9mYkNPMXNnb3BPby9YMm5QWjNyZ2s2ZDE5SUExYjUx?=
 =?utf-8?B?cENsZk5qV3lHa3J2dTJxc1JmS3V3ZUZyTnpyRXFGTzJtQThjdlFxT1ZGUWJ3?=
 =?utf-8?B?MFZWUDBnVm5EU1BXMlBUZXQ2M21ndGtsUzhNUFpHMUdHbHh6MktPV0NzbGV4?=
 =?utf-8?B?MmpNTmltMHBEcVhMYy9MN1ZJaTZUdktJVFAvcldPY2FySkhwZGxUZz09?=
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
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11332.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75ef268b-1d23-4ac4-c684-08debb130ec7
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 May 2026 10:39:25.8911
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +7izKCcGc6d1nEusGoif0mtquWnui3DIfFMo5MbYah5BID+DYoQzXT+9WALX3VhrSlZpjjCyq02N84zGIfR2D08H+Ns2gsG0rNF9GNVXOSc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRPR01MB12172
X-Spamd-Result: default: False [2.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[renesas.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[bp.renesas.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10933-lists,dmaengine=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[21];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,perex.cz,suse.com,bp.renesas.com,pengutronix.de,glider.be,renesas.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[bp.renesas.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[biju.das.jz@bp.renesas.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[dmaengine,renesas];
	NEURAL_SPAM(0.00)[0.046];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:url,renesas.com:email,bp.renesas.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: F1CC55D4521
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQ2xhdWRpdSBCZXpuZWEg
PGNsYXVkaXUuYmV6bmVhQGtlcm5lbC5vcmc+DQo+IFNlbnQ6IDI2IE1heSAyMDI2IDExOjI2DQo+
IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjYgMDEvMThdIGRtYWVuZ2luZTogc2g6IHJ6LWRtYWM6IE1v
dmUgaW50ZXJydXB0IHJlcXVlc3QgYWZ0ZXIgZXZlcnl0aGluZyBpcyBzZXQNCj4gdXANCj4gDQo+
IA0KPiANCj4gT24gNS8yNi8yNiAxMjo1MSwgQmlqdSBEYXMgd3JvdGU6DQo+ID4gSGkgQ2xhdWRp
dSwNCj4gPg0KPiA+PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+PiBGcm9tOiBDbGF1
ZGl1IEJlem5lYSA8Y2xhdWRpdS5iZXpuZWFAa2VybmVsLm9yZz4NCj4gPj4gU2VudDogMjYgTWF5
IDIwMjYgMTA6NDYNCj4gPj4gU3ViamVjdDogUmU6IFtQQVRDSCB2NiAwMS8xOF0gZG1hZW5naW5l
OiBzaDogcnotZG1hYzogTW92ZSBpbnRlcnJ1cHQNCj4gPj4gcmVxdWVzdCBhZnRlciBldmVyeXRo
aW5nIGlzIHNldCB1cA0KPiA+Pg0KPiA+Pg0KPiA+Pg0KPiA+PiBPbiA1LzI2LzI2IDExOjU0LCBC
aWp1IERhcyB3cm90ZToNCj4gPj4+IEhpIENsYXVkaXUsDQo+ID4+Pg0KPiA+Pj4+IC0tLS0tT3Jp
Z2luYWwgTWVzc2FnZS0tLS0tDQo+ID4+Pj4gRnJvbTogQ2xhdWRpdSBCZXpuZWEgPGNsYXVkaXUu
YmV6bmVhQGtlcm5lbC5vcmc+DQo+ID4+Pj4gU2VudDogMjYgTWF5IDIwMjYgMDk6NDcNCj4gPj4+
PiBTdWJqZWN0OiBbUEFUQ0ggdjYgMDEvMThdIGRtYWVuZ2luZTogc2g6IHJ6LWRtYWM6IE1vdmUg
aW50ZXJydXB0DQo+ID4+Pj4gcmVxdWVzdCBhZnRlciBldmVyeXRoaW5nIGlzIHNldCB1cA0KPiA+
Pj4+DQo+ID4+Pj4gRnJvbTogQ2xhdWRpdSBCZXpuZWEgPGNsYXVkaXUuYmV6bmVhLnVqQGJwLnJl
bmVzYXMuY29tPg0KPiA+Pj4+DQo+ID4+Pj4gT25jZSB0aGUgaW50ZXJydXB0IGlzIHJlcXVlc3Rl
ZCwgdGhlIGludGVycnVwdCBoYW5kbGVyIG1heSBydW4gaW1tZWRpYXRlbHkuDQo+ID4+Pg0KPiA+
Pj4gRG8geW91IG1lYW4gc3B1cmlvdXMgaW50ZXJydXB0Pw0KPiA+Pj4NCj4gPj4+IEFmdGVyIERN
QSBkcml2ZXIgcHJvYmUgb25seSwgY29uc3VtZXIgZGV2aWNlIGNhbiBhY2Nlc3MgdGhlIERNQQ0K
PiA+Pj4gaGFuZGxlIHJpZ2h0PyBvciBhbSBJIG1pc3Npbmcgc29tZXRoaW5nIGhlcmU/DQo+ID4+
DQo+ID4+IEluIHRoZW9yeSB0aGVyZSBjb3VsZCBiZSBwZW5kaW5nIGludGVycnVwdHMgbm90IHll
dCBzZXJ2ZWQgKGUuZy4gZHVlDQo+ID4+IHRvIHRoZSBwcmV2aW91cyB1c2FnZSBvZiB0aGUgY29u
dHJvbGxlciwgSFcgYmVoYXZpb3IsIGV0YykuIFRob3NlDQo+ID4+IGNvdWxkIHRyaWdnZXIgdGhl
IGV4ZWN1dGlvbiBvZiB0aGUgSVJRIGhhbmRsZXIgb25jZSB0aGUgaW50ZXJydXB0IGlzIHJlcXVl
c3RlZC4NCj4gPg0KPiA+IFlvdSBtZWFuIERNQSBjb25zdW1lcnMgY29uZmlndXJlZCBieSBib290
bG9hZGVyIGFuZCBsaW51eCBwcm9iaW5nIHRoZQ0KPiA+IERNQSBkcml2ZXIgY2FuIHRyaWdnZXIg
SVJRPw0KPiBETUEgdXNlZCBieSBib290bG9hZGVycyBtYXkgYmUgYSB2YWxpZCBzY2VuYXJpbywg
ZXZlbiB0aG91Z2ggbWF5IG5vdCBjdXJyZW50bHkgYmUgdXNlZCBpbiB0aGUgc2V0dXBzDQo+IHRo
aXMgSVAgaXMgdXNlZC4NCj4gDQo+IFBsZWFzZSBjaGVjayB0aGUgZG9jdW1lbnRhdGlvbiBvZiBy
ZXF1ZXN0X3RocmVhZGVkX2lycSgpOg0KPiBodHRwczovL2VsaXhpci5ib290bGluLmNvbS9saW51
eC92Ny4xLXJjNC9zb3VyY2Uva2VybmVsL2lycS9tYW5hZ2UuYyNMMjA4OQ0KPiANCj4gIiogLi4u
IEZyb20gdGhlIHBvaW50IHRoaXMgY2FsbCBpcyBtYWRlIHlvdXIgaGFuZGxlciBmdW5jdGlvbg0K
PiAgICogbWF5IGJlIGludm9rZWQuIFNpbmNlIHlvdXIgaGFuZGxlciBmdW5jdGlvbiBtdXN0IGNs
ZWFyIGFueSBpbnRlcnJ1cHQgdGhlDQo+ICAgKiBib2FyZCByYWlzZXMsIHlvdSBtdXN0IHRha2Ug
Y2FyZSBib3RoIHRvIGluaXRpYWxpc2UgeW91ciBoYXJkd2FyZSBhbmQgdG8NCj4gICAqIHNldCB1
cCB0aGUgaW50ZXJydXB0IGhhbmRsZXIgaW4gdGhlIHJpZ2h0IG9yZGVyIg0KDQpPSy4gVGhlbiBp
dCBtYWtlIHNlbnNlIGFzIHRoZSBib290bG9hZGVyL2JvYXJkIG1heSBoYXZlIHNvbWUgcmVnaXN0
ZXINCmNvbmZpZ3VyZWQgZm9yIHRyaWdnZXJpbmcgSVJRIGFuZCBpdCB3aWxsIGxlYWQgdG8gY3Jh
c2guLg0KDQpDaGVlcnMsDQpCaWp1DQo=

