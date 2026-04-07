Return-Path: <dmaengine+bounces-9924-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aNSBHpAg1Wnr0wcAu9opvQ
	(envelope-from <dmaengine+bounces-9924-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 07 Apr 2026 17:19:44 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 21CD73B0D48
	for <lists+dmaengine@lfdr.de>; Tue, 07 Apr 2026 17:19:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DB64E3054C0F
	for <lists+dmaengine@lfdr.de>; Tue,  7 Apr 2026 15:16:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1911D361DAC;
	Tue,  7 Apr 2026 15:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="PsBFoxUR"
X-Original-To: dmaengine@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010061.outbound.protection.outlook.com [52.101.229.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 364272248B9;
	Tue,  7 Apr 2026 15:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775574979; cv=fail; b=CeZ7Pnud1ZgiUby8eiPfI2ODWbY3QvJE0RvbcobcIOG64LNlLnxlJDRa0c/PiyKeC921llWZXxVrX4NMnFAKADIgQxRHOWsQg0f3RTlGJsVvLzc8+Rz/alWaRts0SPc2wqhq6L65peoAGHXuln9Jt7q8YLAFzN9vaxVtzBUtdUM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775574979; c=relaxed/simple;
	bh=xB1aSykqnbwsDEH1AN9I4R0NHzBXC/O5B1ANOgAvvew=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WhQ2Vu/UEB0gWzjvF+/JSpti3rgYYhMdL9mSNuawhnopZtQJc8qzx4UWwehqyO2ozO/ho0YCQlBQI8GoS9OoPXY8lDdpBmJgeZigMIrE79fXVDnGG/F5vY0S1Ko2hZog+safTyc1LhvQGz3ZTZlK2QEKzgVwNrIhy2+TtU7p8Xs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=PsBFoxUR; arc=fail smtp.client-ip=52.101.229.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=emkVxdofYhMXFnKn7Vjbv1JbFiz+sBldE7KinPy8nLdRcC3Xy8qm2aqpvTt57zXQc8SPmA80VEb3BiiZS2OvHr0llPMHS7o0+4IoI+qCRsGn4LURGRfc16DAKs9p9uG8AsOjgrY1fPU1Tpl3LFu0Js2lMYJEVEhOT6rFUB5gANr3MWGh4VF7XIHQSpJSg+jJFxVtn7i7tbwtkIh8JaI6KgeTAN9xfNX8LvHga1mKpzJx7u/I2k/4JbCLYs/EdW/GzB8x4y3+gl6Jnyn0hSEoxka+PpBtTGF87ZJcei5LR6hDpEgiVXav/Fgb8bEQr74Y5XNvcN0FjkJEcHOmDOtVTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xB1aSykqnbwsDEH1AN9I4R0NHzBXC/O5B1ANOgAvvew=;
 b=jMVpV9NmwC77uJ9C8jtMT8il9oENtfeWRj5J0ScryImJyg1l6A9U0aH83sEES5JIEQag1siqnQwtnjS91/uGFH38Hg/rQxeftliGO97iDn/4AvNks+7qHMVr6yADFp6IfDeJdp9KX0V0yf+M09rvRAHISiGy4DoewP23Mqa3yekHEcTeYB7zJdWlpfJpGdVYPq5u7I+peDhx6lxhctdg1bO7SGGkL/1iN5Or8zmXu1sVXcunpFgpOt0GNAdO+4H5urWha1sEdD/gdTq98uwMrq3r2TxmpqprqOCG35MRyVAYflEEHJIGEwlDps21+XE/6PDEH54l+hzejqI29l2yGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xB1aSykqnbwsDEH1AN9I4R0NHzBXC/O5B1ANOgAvvew=;
 b=PsBFoxURaY/jrvZQyU8IKAuL6OojfWVOte9Ha+qH19hh/u7Ur+2xN3oeqIisXCyLuON+CArl6/ClgROTPoXV/R/BrH1dOnHpgroZ1YDMgyazV9ThrYDd4FB0bhbFlASIAK7YSvt1PIv+hL4dVTAlNNBfrgpbD057jNr+S7OAN/M=
Received: from TYCPR01MB11332.jpnprd01.prod.outlook.com (2603:1096:400:3c0::7)
 by TYCPR01MB11173.jpnprd01.prod.outlook.com (2603:1096:400:3bf::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.19; Tue, 7 Apr
 2026 15:16:14 +0000
Received: from TYCPR01MB11332.jpnprd01.prod.outlook.com
 ([fe80::2511:10cd:e497:4d97]) by TYCPR01MB11332.jpnprd01.prod.outlook.com
 ([fe80::2511:10cd:e497:4d97%5]) with mapi id 15.20.9769.020; Tue, 7 Apr 2026
 15:16:14 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Claudiu.Beznea <claudiu.beznea@tuxon.dev>, "vkoul@kernel.org"
	<vkoul@kernel.org>, "Frank.Li@kernel.org" <Frank.Li@kernel.org>,
	"lgirdwood@gmail.com" <lgirdwood@gmail.com>, "broonie@kernel.org"
	<broonie@kernel.org>, "perex@perex.cz" <perex@perex.cz>, "tiwai@suse.com"
	<tiwai@suse.com>, Prabhakar Mahadev Lad
	<prabhakar.mahadev-lad.rj@bp.renesas.com>, "p.zabel@pengutronix.de"
	<p.zabel@pengutronix.de>, "geert+renesas@glider.be"
	<geert+renesas@glider.be>, Fabrizio Castro <fabrizio.castro.jz@renesas.com>
CC: "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-sound@vger.kernel.org" <linux-sound@vger.kernel.org>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: RE: [PATCH v3 11/15] dmaengine: sh: rz-dmac: Add cyclic DMA support
Thread-Topic: [PATCH v3 11/15] dmaengine: sh: rz-dmac: Add cyclic DMA support
Thread-Index: AQHcxpN0epZm3oWFs0uhV/cUaEEnBLXTp9bQgAANA4CAAABjgA==
Date: Tue, 7 Apr 2026 15:16:14 +0000
Message-ID:
 <TYCPR01MB113324C600BE0ACFD52001A6E865AA@TYCPR01MB11332.jpnprd01.prod.outlook.com>
References: <20260407133507.887404-1-claudiu.beznea.uj@bp.renesas.com>
 <20260407133507.887404-12-claudiu.beznea.uj@bp.renesas.com>
 <TYCPR01MB11332705744F2802F745C1567865AA@TYCPR01MB11332.jpnprd01.prod.outlook.com>
 <77514d1b-e418-47db-9b47-8f7d8a4cedc5@tuxon.dev>
In-Reply-To: <77514d1b-e418-47db-9b47-8f7d8a4cedc5@tuxon.dev>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB11332:EE_|TYCPR01MB11173:EE_
x-ms-office365-filtering-correlation-id: 2d642a05-6ac2-4234-434f-08de94b89bc7
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|22082099003|18002099003|56012099003|38070700021|921020;
x-microsoft-antispam-message-info:
 +AdL/FpI8BAYlIISOorN0rTY49zb2/fNXQH+KBlc5RsUjsbgIZc2k8hUExMVUjPRiEi4GOlRn4MJ6emfDRM0JVmKu8MrUkLrFkvPXBxIJ0WpImKhKmGmdOpolyaHGj20qILgP093dQoH4Y72gfKzfdX6+Jo6mp7IH8NgI3VbhCbXZnJMUKqGMI5x1tsL33arZETFMsCUoF1REEtjVNbnQkQeJJmPkn7MW/xLQ9jQw/pq1CU5jNO5YrGb5oMFCUJ4aIMjScQewaDYDjHVSCh0nwA6A47dRhCW4B//aYVD6/9IBekZwZEqqGEA2O6eWgMM1Z3b0CCvourpIcy2DKZ70Ub4yVM26PrzVkKePL3Z8CEJJmKs0tORBejXK5lg+8uUk2pJ/8l9iFhNH7OhnllNtrsyxzd0469ZXcpZsqaRY/hTp8+tTlqpAdRWmx+Gpk9xUsZvYR6vMBN1kybk0UXuvFr5VfdnyBdup135YJeqbaCG+t45VrC0q0SmA2TwbxIKLwp5awTH5nANpREQm6mccKfSnoPyyBrrmkbWWixwCiqMPAdhLbpwz6bKA3yHogTaq/RN1G0pqEHrs0J7LXeKLa5ogZL8It4UeH8Eb0f/4GXh2Lt7odXjxHpb3mNpT+L8ZXDCTCenx6kmFHz9mNITo/1OJNms+NzBH/RrWY8U2qN4+aH6Z84TaHvoCSxC+AlIPaLf7UB0NEp83BP+KHRjYKXZYZpYokGY5uQr537xgDjwgfoG0WhFER7zjbrj6KiTR3dd54bIm3VoJDpF3REAIkYxTND0URlmyZNeHEs/ZRuxBR+uJIcYfSyDg/Nwob9U
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11332.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(22082099003)(18002099003)(56012099003)(38070700021)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RFhKYkJpVXRodWNDYy81NlkzWXVRQUhzMSthTnNocEhtdkFDRWZUNW44Umxp?=
 =?utf-8?B?eVBCeTJnam8rOS80a0g1bUMvejRGODBvaEpoMytxNDUvVUVwQUl1UkJkMlkr?=
 =?utf-8?B?bEVDYVI4dEFZNkVzN012UDVuR2RhQ3JZanppYWF2T1NCMGErS3VjQjBLZ3hw?=
 =?utf-8?B?VHhTRjh5eTFGdEplWktGWExHNm1ZYXFSTHRnMEtWM0xNdllINndiUitCdFpK?=
 =?utf-8?B?M1BxNWxDbzdxS0lZcDVjVnpSejlaSmJRUVVObm9sWkN5b3NpbUlZVzZhSkZV?=
 =?utf-8?B?UEdPQjFrZVFwSkc2UTIrQjBUT3hYWk9pbVByZEdQS0hBaUt0MUEraVRxK1F4?=
 =?utf-8?B?WDVFejIwc1dlUEE2QWJNNVpsNmt3TXk5M2FPSXhLL0NMYVlPZ2Z4Qi9XdWJP?=
 =?utf-8?B?bjhGRHNyL0xsWEgrazZOdGhNTnE0aGRBa3lyUjBLV0JMZGFTOGQ2MEQ3dmUv?=
 =?utf-8?B?NW1aVnJ5OTBtaSs2WThkelFIS2F3YW0za2pIZ1BKcUpJVjNNbk50Zy9IZjVF?=
 =?utf-8?B?NUNlMFowR2g1a2NaVjM2VENYSFNZVFhaZGJiYUxQYVcvV2t4UCt3L2h6L2J5?=
 =?utf-8?B?R0NjcXQrZDJNVW1ZNDJya243ek5mSm55T3ZXODFjYkFPOElqMDJaNUtPQXBC?=
 =?utf-8?B?bXRZSzhkS3B1UVhVdnBlSldBTnROOTFpNWlGdTJLQS81WXVnT20zWS8rbzhn?=
 =?utf-8?B?TlpGM1liYnh5dEFuWUxGbzduUFBPZy9YQkg5UnM4NE8rbXhPRFJlTmNGZzl0?=
 =?utf-8?B?UDFFYUQ3Y3hTYkdHVjRZNmlUTWtNVlZRNEJNMlRjUVFad2U3YTJJcVZUeE1W?=
 =?utf-8?B?cjlTcmNURXpOL1ZhNnFiWlJWVlVZcmdPVDF4UFZ6M0FTNFBLMEhkcG1aczJD?=
 =?utf-8?B?VXBXS2NKd0xEZ0tSTXpDVW05cHFOd0NpTWtTcW1ycDdhOStaTGRjUHVUWEpk?=
 =?utf-8?B?dmRtS1pLR010M3pQVy84OUJ2WUNKdThGejF3SHQwd3F4NEJaOUZiK2hQQUg5?=
 =?utf-8?B?b1BhcDl3U0VnVFlNS0h3aXkrR0VnQkVmNkErajhKVGxqVTZxU0ZFQkRlei9P?=
 =?utf-8?B?UWE4eHNOWFZiQUhwQkNFNEtFa1duYkRpZFlKaU9ZWFdGQ3pacmp1U0t2N0xt?=
 =?utf-8?B?RERCekRwOGZ0c0E5QmJ0R0xqeWlYL3MySGhQR000N09PNTFNVW1hUnB6L2Vj?=
 =?utf-8?B?bXRqdThQQlFLM3MxSW9ocjg0c3JIa3VWSDVpZHZVZHV0YXdLMURyWmV2aTd5?=
 =?utf-8?B?U1ZHNnpJYXhVcENBQkU2QTJjWGl2VVplYkNLcmcyaXVrUTdBK0owdTJsOStM?=
 =?utf-8?B?aGNEQW1aWkMwd2FsRXA3M0RxSCtlNUhSM2pFTm5idmluV01jSm1RS0pRKzR1?=
 =?utf-8?B?WTBjbkRJSU1EamRWbzk1SXJPY29LMm12bDFWa1BLUVZybFFweTRTOXZudTFj?=
 =?utf-8?B?MUsyRFVLcFVpT3dsL0hxWUlFTTFuMTgxbU9ZaU00NHRHaStaaGEvcm1ZU0Fs?=
 =?utf-8?B?R2cyUm1sc0lESVJPVzVqMUU3QzhCVFd2bVoyNUh6RDVIaGROUHEyQXJSSEg0?=
 =?utf-8?B?OW1CdENOSUsyWWhoMzZGN0tCQmVoVExNSmdzZHN6em1KSVN3V1VjbExqaEU0?=
 =?utf-8?B?ZEpxNTFKbFVPVy9LRW5hN3hNOENNVUs3QjVGNU4rUk11YU5teXhMUlBaU3VU?=
 =?utf-8?B?UW13cHQ1aEowVHZZeGk5NXdaSVRjWGc3VjBEOXpoRVhHaEgyTGVCeklXcEdw?=
 =?utf-8?B?VlBRWEttZzdTd1RCa2w4MnBWQkx5WEtFQVFQUGVod2VZaXdWQWxoRm9XY3ZO?=
 =?utf-8?B?Zlg5SWZaOGJ1NXFGRFZJWVVUcUNNV3c4Y0RhV3RnU094cEswNDlQQzFOcDNJ?=
 =?utf-8?B?MnVsc0RCZXJFMUgvTmg5WjlMdTNvOVJwSStWeHBwalA2T2ZEUllqaHBkaTJa?=
 =?utf-8?B?dnBxRmJjN1d6ZzdOdHNLMDBaS0ptanFnaURjVmxjditGaVFUcmdxTUlqc0dX?=
 =?utf-8?B?WE1EWW5qREJIcEFnUWRmVHdyVm8rUFliMWNoYjV2aXNrdE1SNEJ1bmZKRFpt?=
 =?utf-8?B?a2pLTDhmek5GSk5RVUV5bW0rQVAxMm5xeGtBa1VIcUg3L3EwZUd5QXpSZDFC?=
 =?utf-8?B?ME92QWpVdEJ4Y0tFcmh1SzBLMm8xK0VzOWR4UjVscmNxU1BSM3J2dEVGQjZR?=
 =?utf-8?B?d1U4UTJJM09zcVlFTkpDRzJCb09vODdyY09sQ1pPdXVGdjg4YmZIc3paQm1M?=
 =?utf-8?B?UjJ2VlA3VjdwQitzc1pxalJKNWdScFpHeEtlc1B4S2Vwd2JSMnJoZ3IyVzhL?=
 =?utf-8?B?UWNkTDJ4TkRDL0xFRnJPRDNWMmh3RUE5QkF0bWgrWlFLeTVKYmF2Zz09?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d642a05-6ac2-4234-434f-08de94b89bc7
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Apr 2026 15:16:14.1245
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ct9QIodVv71hr4josA+wprpYeIzotS4m3zHJ+okM9Zaiq2yStfP2wV00v00gXDrmSFsYe30NTK/4qLg0YFJ56wSc4j6eTB1dLBj366yWEdU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB11173
X-Spamd-Result: default: False [2.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[renesas.com,none];
	R_DKIM_ALLOW(-0.20)[bp.renesas.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	TAGGED_FROM(0.00)[bounces-9924-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_TO(0.00)[tuxon.dev,kernel.org,gmail.com,perex.cz,suse.com,bp.renesas.com,pengutronix.de,glider.be,renesas.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[bp.renesas.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[biju.das.jz@bp.renesas.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[dmaengine,renesas];
	NEURAL_HAM(-0.00)[-1.000];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,bp.renesas.com:dkim,tuxon.dev:email,TYCPR01MB11332.jpnprd01.prod.outlook.com:mid,renesas.com:email]
X-Rspamd-Queue-Id: 21CD73B0D48
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

SGkgQ2xhdWRpdSBCZXpuZWEsDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJv
bTogQ2xhdWRpdSBCZXpuZWEgPGNsYXVkaXUuYmV6bmVhQHR1eG9uLmRldj4NCj4gU2VudDogMDcg
QXByaWwgMjAyNiAxNjoxMw0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYzIDExLzE1XSBkbWFlbmdp
bmU6IHNoOiByei1kbWFjOiBBZGQgY3ljbGljIERNQSBzdXBwb3J0DQo+IA0KPiBIaSwgQmlqdSwN
Cj4gDQo+IE9uIDQvNy8yNiAxNzozNiwgQmlqdSBEYXMgd3JvdGU6DQo+ID4NCj4gPiBIaSBDbGF1
ZGl1LA0KPiA+DQo+ID4gVGhhbmtzIGZvciB0aGUgcGF0Y2guDQo+ID4NCj4gPj4gLS0tLS1Pcmln
aW5hbCBNZXNzYWdlLS0tLS0NCj4gPj4gRnJvbTogQ2xhdWRpdSA8Y2xhdWRpdS5iZXpuZWFAdHV4
b24uZGV2Pg0KPiA+PiBTZW50OiAwNyBBcHJpbCAyMDI2IDE0OjM1DQo+ID4+IFN1YmplY3Q6IFtQ
QVRDSCB2MyAxMS8xNV0gZG1hZW5naW5lOiBzaDogcnotZG1hYzogQWRkIGN5Y2xpYyBETUENCj4g
Pj4gc3VwcG9ydA0KPiA+Pg0KPiA+PiBGcm9tOiBDbGF1ZGl1IEJlem5lYSA8Y2xhdWRpdS5iZXpu
ZWEudWpAYnAucmVuZXNhcy5jb20+DQo+ID4+DQo+ID4+IEFkZCBjeWNsaWMgRE1BIHN1cHBvcnQg
dG8gdGhlIFJaIERNQUMgZHJpdmVyLiBBIHBlci1jaGFubmVsIHN0YXR1cw0KPiA+PiBiaXQgaXMg
aW50cm9kdWNlZCB0byBtYXJrIGN5Y2xpYyBjaGFubmVscyBhbmQgaXMgc2V0IGR1cmluZyB0aGUg
RE1BDQo+ID4+IHByZXBhcmUgY2FsbGJhY2suIFRoZSBJUlEgaGFuZGxlciBjaGVja3MgdGhpcyBz
dGF0dXMgYml0IGFuZCBjYWxscw0KPiA+PiB2Y2hhbl9jeWNsaWNfY2FsbGJhY2soKSBhY2NvcmRp
bmdseS4NCj4gPj4NCj4gPj4gU2lnbmVkLW9mZi1ieTogQ2xhdWRpdSBCZXpuZWEgPGNsYXVkaXUu
YmV6bmVhLnVqQGJwLnJlbmVzYXMuY29tPg0KPiA+PiAtLS0NCj4gPj4NCj4gPj4gQ2hhbmdlcyBp
biB2MzoNCj4gPj4gLSB1cGRhdGVkIHJ6X2RtYWNfbG1kZXNjX3JlY3ljbGUoKSB0byByZXN0b3Jl
IHRoZSBsbWRlc2MtPm54bGENCj4gPj4gLSBpbiByel9kbWFjX3ByZXBhcmVfZGVzY3NfZm9yX2N5
Y2xpYygpIHVwZGF0ZSBkaXJlY3RseSB0aGUNCj4gPj4gICAgZGVzYy0+c3RhcnRfbG1kZXNjIHdp
dGggdGhlIGRlc2NyaXB0b3IgcG9pbnRlciBpbnN0ZWQgb2YgdGhlDQo+ID4+ICAgIGRlc2NyaXB0
b3IgYWRkcmVzcw0KPiA+PiAtIHVzZWQgcnpfZG1hY19sbWRlc2NfYWRkcigpIHRvIGNvbXB1dGUg
dGhlIGRlc2NyaXRvciBhZGRyZXNzDQo+ID4+IC0gc2V0IGNoYW5uZWwtPnN0YXR1cyA9IDAgaW4g
cnpfZG1hY19mcmVlX2NoYW5fcmVzb3VyY2VzKCkNCj4gPj4gLSBpbiByel9kbWFjX3ByZXBfZG1h
X2N5Y2xpYygpIGNoZWNrIGZvciBpbnZhbGlkIHBlcmlvZHMgb3IgYnVmZmVyIGxlbg0KPiA+PiAg
ICBhbmQgbGltaXQgdGhlIGNyaXRpY2FsIGFyZWEgcHJvdGVjdGVkIGJ5IHNwaW5sb2NrDQo+ID4+
IC0gc2V0IGNoYW5uZWwtPnN0YXR1cyA9IDAgaW4gcnpfZG1hY190ZXJtaW5hdGVfYWxsKCkNCj4g
Pj4gLSB1cGRhdGVkIHJ6X2RtYWNfY2FsY3VsYXRlX3Jlc2lkdWVfYnl0ZXNfaW5fdmQoKSB0byB1
c2UNCj4gPj4gICAgcnpfZG1hY19sbWRlc2NfYWRkcigpDQo+ID4+IC0gZHJvcHBlZCBnb3RvIGlu
IHJ6X2RtYWNfaXJxX2hhbmRsZXJfdGhyZWFkKCkgYXMgaXQgaXMgbm90IG5lZWRlZA0KPiA+PiAg
ICBhbnltb3JlOyBkcm9wcGVkIGFsc28gdGhlIGxvY2FsIHZhcmlhYmxlIGRlc2MNCj4gPj4NCj4g
Pj4gQ2hhbmdlcyBpbiB2MjoNCj4gPj4gLSBub25lDQo+ID4+DQo+ID4+ICAgZHJpdmVycy9kbWEv
c2gvcnotZG1hYy5jIHwgMTQ0ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKyst
LQ0KPiA+PiAgIDEgZmlsZSBjaGFuZ2VkLCAxMzggaW5zZXJ0aW9ucygrKSwgNiBkZWxldGlvbnMo
LSkNCj4gPj4NCj4gDQo+IFsgLi4uIF0NCj4gDQo+ID4+IEBAIC01MDAsNiArNTYyLDggQEAgc3Rh
dGljIHZvaWQgcnpfZG1hY19mcmVlX2NoYW5fcmVzb3VyY2VzKHN0cnVjdCBkbWFfY2hhbiAqY2hh
bikNCj4gPj4gICAJCWNoYW5uZWwtPm1pZF9yaWQgPSAtRUlOVkFMOw0KPiA+PiAgIAl9DQo+ID4+
DQo+ID4+ICsJY2hhbm5lbC0+c3RhdHVzID0gMDsNCj4gPj4gKw0KPiA+PiAgIAlzcGluX3VubG9j
a19pcnFyZXN0b3JlKCZjaGFubmVsLT52Yy5sb2NrLCBmbGFncyk7DQo+ID4NCj4gPiBNYXliZSBj
cmVhdGUgYSBwYXRjaCB0byBjb252ZXJ0IGFsbCB0aGUgc3Bpbl97bG9jayx1bmxvY2t9IHdpdGgN
Cj4gPiBndWFyZCgpIGluIHRoaXMgZHJpdmVyLg0KPiANCj4gVGhpcyBzZXJpZXMgYWxyZWFkeSBo
YXMgdG8gbWFueSBwYXRjaGVzIGFuZCBJIHdhbnQgdG8ga2VlcCBvbmx5IHdoYXQgaXMgbmVjZXNz
YXJ5IGZvciB0aGUgY3ljbGljDQo+IHN1cHBvcnQuIE15IHBsYW4gaXMgdG8gZG8gdGhlIGd1YXJk
IGNvbnZlcnNpb24gYWZ0ZXIgY3ljbGljIHN1cHBvcnQgZ2V0cyBtZXJnZWQuDQoNClRoZSBkcml2
ZXIgaGFzIGEgbWl4IG9mIGd1YXJkIGFuZCBzcGluX2xvY2tfdW5sb2NrIHZhcmlhbnRzIHdpdGgg
dGhpcyBzZXJpZXMuDQpUaGF0IGlzIHRoZSByZWFzb24gZm9yIHN1Z2dlc3Rpb24uDQoNClllcywg
aXQgY2FuIGJlIGRvbmUgbGF0ZXIuDQoNCkNoZWVycywNCkJpanUNCg==

