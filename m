Return-Path: <dmaengine+bounces-10065-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oHolJF9P5mkgugEAu9opvQ
	(envelope-from <dmaengine+bounces-10065-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 20 Apr 2026 18:07:59 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E49E542F089
	for <lists+dmaengine@lfdr.de>; Mon, 20 Apr 2026 18:07:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 768D8307BBCE
	for <lists+dmaengine@lfdr.de>; Mon, 20 Apr 2026 15:12:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB301311963;
	Mon, 20 Apr 2026 14:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="n3wXLou5"
X-Original-To: dmaengine@vger.kernel.org
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11010005.outbound.protection.outlook.com [52.101.228.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CED417BA6;
	Mon, 20 Apr 2026 14:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776696841; cv=fail; b=X+RNxD2JJFYQMrz5qU7DW3Lizy7HO/NYKUcNyr9aRvgUMXGC2O9g48DNrtw0dE0YMnxTTD7xpOP/WGDjT7PnTMSkGMHIpdQDTdTcla4gZo3mFnX4sQ90gqxgf4NeEMDONBVMIMTMf+85MC4a7f+1SoEWr+jiaTOH01MWobjPXxM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776696841; c=relaxed/simple;
	bh=IyHH/xoh8BhUd8hhXgUaqBIsG5UWUFEoqGu6E/WbAxQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CSOGQsbSIqSuzqf7c4kAiYYKe7Ew83C6UOdQMUhti2F1XfuQyMHDQj0CiyFjj1PPSZIgHM9kRKLEc9rrjQeCcMW3j42OZMEUCyW0N95WzEFGWyWZqhsPA8plkX0/LZyRvIJ7zhBHw75LAH39mj1gmAzNMsWH9bW0FxxMZG25o28=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=n3wXLou5; arc=fail smtp.client-ip=52.101.228.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XURTy6PxFgum9uRMEHdDfOsFd6Ws/YVDIB4k7N0eryXmPUh3w5H/Utj9hvlA5LRy7Cjk8OyYltP0C2rBvQ6o5vVSWPS+mfTTDRjr2seIBQmb52ZZgH4PxVh5oyDaw94cGcYJ/NO53WIdXEZSJ4D8AYNvig2wwZQSVxka29XVvZwy2+MwAlBf0b1Twe3WfBhi8/Y94Lej0lBxEj2TDhkqOLU7Kapgp2YvUCzfilXuYAaJrgU6uvcTjlUkbef05ZLO/V+A/otcez/1K179VyMHwTpng6p5qAX5orE9RfwKSfsjmRKyXattrE8dxnatd2Evn9lrFoDMTn4Y5dB4la9sXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IyHH/xoh8BhUd8hhXgUaqBIsG5UWUFEoqGu6E/WbAxQ=;
 b=bmz+8QZ+PvsB6WYMvS/yI8sLagSmVeqDdm32qg6o0QmsmBDnU4erfZYj+y2PXI/p2Suxhoxm4EG/lTQnyxwe0jx0+bwwv/4VEiqTxMJSfzVoGaYwuo1EwfY2vZDqDq1KwOCO44t/Hy/Hb0WSbxGJtGPTdBII4qHFVVUCS3rQKLEe77djZQSAZa4h9vCsf07K+XvALKyKQxzBK6a3nMoWtMCYRTA3212AqJPFxckC0vUCnx1mZ9sn4k/GBxfV7dWWKH4h7OXk5R03xxpwFVKy/FX0emCXY2XQgIELWAq3bd3pfh0QyyLX8Ah7pOxGyr05SXt3Vz78P7BubKO8bsQf7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IyHH/xoh8BhUd8hhXgUaqBIsG5UWUFEoqGu6E/WbAxQ=;
 b=n3wXLou5hcIah8OYDg2qNZhQ9A0mWVQRpt3/+pQx0NC/50Gs7iHmdgqhn2QMBmlx7KySa4GyFOX8bxDp+TJ2Z0iwwxlsr9S8cxSebY1hui+B7c64gcCYYuQzIE6bfqWncO+VbNjGyzbIaug22PS3qA4ngeRthdXLdhX1BzsANj4=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by TYWPR01MB10676.jpnprd01.prod.outlook.com (2603:1096:400:2a4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.32; Mon, 20 Apr
 2026 14:53:57 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de%4]) with mapi id 15.20.9818.033; Mon, 20 Apr 2026
 14:53:56 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Claudiu.Beznea <claudiu.beznea@tuxon.dev>, "vkoul@kernel.org"
	<vkoul@kernel.org>, "Frank.Li@kernel.org" <Frank.Li@kernel.org>,
	"lgirdwood@gmail.com" <lgirdwood@gmail.com>, "broonie@kernel.org"
	<broonie@kernel.org>, "perex@perex.cz" <perex@perex.cz>, "tiwai@suse.com"
	<tiwai@suse.com>, Prabhakar Mahadev Lad
	<prabhakar.mahadev-lad.rj@bp.renesas.com>, "p.zabel@pengutronix.de"
	<p.zabel@pengutronix.de>, "geert+renesas@glider.be"
	<geert+renesas@glider.be>, Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Long Luu <long.luu.ur@renesas.com>
CC: "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-sound@vger.kernel.org" <linux-sound@vger.kernel.org>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: RE: [PATCH v4 14/17] dmaengine: sh: rz-dmac: Add suspend to RAM
 support
Thread-Topic: [PATCH v4 14/17] dmaengine: sh: rz-dmac: Add suspend to RAM
 support
Thread-Index: AQHcyahv0JOFZMxUWUOJK3dra8ccorXnnqbAgABuToCAAAC6QIAABWWAgAABkVA=
Date: Mon, 20 Apr 2026 14:53:56 +0000
Message-ID:
 <TY3PR01MB113460C44721477F7D7E563C8862F2@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20260411114303.2814115-1-claudiu.beznea.uj@bp.renesas.com>
 <20260411114303.2814115-15-claudiu.beznea.uj@bp.renesas.com>
 <TY3PR01MB11346C39C7EABCC7A1BC64109862F2@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <36468f41-7808-4fe3-b4bf-94eb128276fc@tuxon.dev>
 <TY3PR01MB11346EBEC14B199CC0729E33C862F2@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <2d055792-c8ad-440e-8fe6-68b75832e30f@tuxon.dev>
In-Reply-To: <2d055792-c8ad-440e-8fe6-68b75832e30f@tuxon.dev>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|TYWPR01MB10676:EE_
x-ms-office365-filtering-correlation-id: 02517a62-c151-43a9-4724-08de9eeca607
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|1800799024|38070700021|921020|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info:
 b+hyJ7SRZ6S3FZ32dEInX1LrqUIJQfr6vRUgNI0GbTWHX3TWmyC1gcuwFLh4NwmjI519tkelC1K30VoyCrwTTZIeqpqeXs4ZLIzFxtgEuJhk7Tm4YODUXdY9aBTu28dC1WW0bXoJ/j/96Y0tAgr8WUHpenfl55HH9roTyRW5y61IBZ3FdFdc17IVSWHYm0nPJ6Voo5qzK1IugWhPOyB4Yt8XNExUDsqx6ZSYpsjMiaZkBDDElUSqEUEb0nz9zqwf2dNNU/2BHudwfyfQcBSaK79fpNBhnIrD5BWrxDpWja/LEKkqpG6xDZJCDpXd8xzeSHwiG5yUjdnboPfjsaio+uGwSKdmYtFq2PICOkmnfgRgd/FiohTIEwRdR+f2LJRzAxX6l7jmzAI3OfwP0j5cIuyZGq0L+Fr5NvvoXZajkHWENyyXaXbGQ3JZgujtq3dyQjP0guNH+PrOJOBbrbgCvJY+hwXJH5LqFZ0nHe1luHKvD1c18gpmSGWCTf0OqRC4Bkd9UESQVosheDSoXzyUV71Uw7KwX/P8qjWfsvDz6xqkiRQjo7/6NIcKLQ42b7H5HOSARGQ+6PAM8eTsar6+CjterE4aV/VEDnERqC4inQEnGIPbfSrOdOTRxzsktKv0dFGYU0zdKSLnO0T+SU5IN5q5chwvYx7UmCNKNhwu1qwV+Qgz1uIAc8+7ZzOJW4Om7wMi6nNFbUQWjCESh49BbN1zPSrxzw655Qj7+b5Dxd0zMQpx9GvEauoskrlkyaILsmlqbNGdtZZ/s1Wp12fbqA==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700021)(921020)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dTZoWGdBdFRFV2t2akxMZHpiSmNINEdBZHk0NEdXODR3VU9KYnhnRkhJeHdm?=
 =?utf-8?B?cHY2alJmWlZuMWxmOWU2eE8xRzdzRnZEOC9CTUNveHVCZ0swcE9DK3d2MlB5?=
 =?utf-8?B?RHhUWnJzbndNTjMyZWNWTEhKNFBHS2JtWHFZV1lxV2gxRWVGc2U5OFFNNmRF?=
 =?utf-8?B?Yk45WGMrc29iWnJ2NzgxL1JXVmxjVVRYNWttRUQ0YmladzRKUWhXT2FwYWtT?=
 =?utf-8?B?clRjaThHWE1xd2gxKzhqa2pDMVNZaWNZME9MbURaRjFNZk41a01zWlpwQ1JL?=
 =?utf-8?B?cWN3ekFlT1FLSWwwY1NSbzN2MlRRcm03UWFBMXo0cFpxZ0FrQm5HNExqeVFH?=
 =?utf-8?B?YWtadzJJY2FNRXZjd3VLRE9qTkhSdlRwZnFZNllNSC8wWFNvRjFTZkJqT29N?=
 =?utf-8?B?MUd4a0tMR3pDR1VGRWtlckZCTi9VTzZjdTFzcm1wU2F3NmVVbmVHSGhwMVRj?=
 =?utf-8?B?UHlmcUZUUk5iWEg2S3RHVnE4eFo0VjJ3ZEtvMmJjWFVTN20zVFJOZVc5VHlt?=
 =?utf-8?B?OWRNS0Q5amlHc3FwMStaKzIrbWUzaDNrcGhmME5wS3hoNUlyaWZPb1lzd1J0?=
 =?utf-8?B?SWczUk1ITHRPMW5wTSt4TUVOSWJ1NzRKZE5hZkZLVkhuSzdYQ0tyWndtUDcw?=
 =?utf-8?B?bDFLUG4rbmFzODUyUXBOWFdKUlU5c0dtaVVTZ21qSzh3dVozK2ZhRDBDd1Y3?=
 =?utf-8?B?d3crdFYxZE5lekJPaHlJUmFaMS80Vm55ZGJGR3RUUXhRMStOMVliV3FldkVn?=
 =?utf-8?B?S1U1TURiUUhkdHlUT2Vna2lIVEFXWHVRWVhpSXFKSGZ3d3RyOEVlUGNHTW54?=
 =?utf-8?B?OXE5SXcrckMzYUdMaWV5MDJFamsrbEN5QmVHV1VXOG5aRlU1a29MUkxoUXpP?=
 =?utf-8?B?SWVvd0E0Yk05OWw0bldyWm9aazdLdnhycnRQczdtanZLeEU3QTlHZ3MzRUdW?=
 =?utf-8?B?TXJhSmRsZWxpS0gyQ01BOVl4cUVVd1lwSUU5OFhIZWlpTTdoYzM5SjZ6VmI0?=
 =?utf-8?B?VGhNaHFaSzdJOWFET2NtVDUydTBOUGM2Yy93eEloT3VUNS9YTnUyUWdWdldl?=
 =?utf-8?B?N3IraVY3SkFNQ3AwYVNZR0NSSkhJdDFXbyttNHhDdUt5Q1RLQ1JaRXBmcm1K?=
 =?utf-8?B?Yk9GeUUyeG1qTTZ1enlycGlWRHV2Zjl3NTZ3MHF6TGFUSlpYL2QvZ2s0bUY4?=
 =?utf-8?B?T3RoR3VuUFI2WmZpMTlNZjZsRWw4UnhobFVPamV5WWJuaWo0M1F3UHNDSVVu?=
 =?utf-8?B?TStkRVkzZDVqQzVibDNoTTVPVmtPdFo1SUEyZ01JUFRSMGxlKzBjWjRpY0lC?=
 =?utf-8?B?bjlNSmxUOFZqZ3pnYXV5ZkdYaVBOZlAzUkt1cEJKaEtXUFhSZVBqK2wwOUZi?=
 =?utf-8?B?Z2pZN1V2TE5CV2RLVWxIZFdjYnBwVlRJRmYwWkRPS1JuNkNtZStnT2hWdStj?=
 =?utf-8?B?dEswdkhCQ1Z2eXU5cTdadG54UkprMTI2V0NrbUhyMnA4WFptUGdkbGl5Y0Fs?=
 =?utf-8?B?ZXk0bm11RnVnMnppTFY0aGlXK3Q3TTlnSDRsYXF4ekJDMDBmNmQ2WVNWVlA5?=
 =?utf-8?B?YnNhUHNSZUNCbUZXWUxXV3dXUXkvbjFYZHVaNVdTeHl0OVZ0OWNCMEJJZUpl?=
 =?utf-8?B?NEdHRVRMZGNvZEM5TFJ4ZVk3NGFVWTI5dk9EaGIwaUpkVG5wbmdFQnhCUWRB?=
 =?utf-8?B?bXgxZEFGcWM0S3N4L2dqTXR1bnFWVUhScWdlcE1EaGNSNThvUzRZTGtFNjNG?=
 =?utf-8?B?TS9KQitkSHFKV0Jwa1hpQjRPbHRIdThqZUMxeWlKUzZ4ZlppdndFR0FkYStM?=
 =?utf-8?B?a25Pa3RnTEp1L1RRU1hIeHE3K0RjQTZ2VzdCVE02aFFQM1MvcU11SncrYThV?=
 =?utf-8?B?VG0vczhJMUZvZGUxcGVhZlJBcnI2cHRCQnNQcDZoMmMyOXc5eW9rMTBGeU41?=
 =?utf-8?B?WGNidC9vcS9OUWNUOThnQkIzNFFETUVMeklxYVVGTmIrTFdzMm5CcEdpdnZP?=
 =?utf-8?B?SUt5ekxzQkF0OEJRcGs0a0dabGVGMFUvTUxlVit3RmdkY1BGVU1ZcWJmYjZU?=
 =?utf-8?B?eG1oZEV4NWF5MmdjemZRMU9UdFV1ZVF0eFNwejYwZUhzT3pLRVZmcXpPTmcv?=
 =?utf-8?B?RnNoK3crQlRUVys0RURnMWhob0xBeEFwQzljWGEvcmlDVTQrbVdiMi9Bd0Q0?=
 =?utf-8?B?d29Kc2NJQjVucU9CdW5Fc1B0blZSTkZCYUJwckJGQUxLOEsrK3dIajdOM1hY?=
 =?utf-8?B?cGZiQm9YMUFsSmVnaE5ZSUtvbVVJVGF4MWZsdWh2TGcyZzNSSHgySW1FWlht?=
 =?utf-8?B?Z0UvVDBTK1FUU01mK1l0TjBLMEhXRDBmMWl3ODBoYlFSbHg0R2pNdz09?=
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
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11346.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02517a62-c151-43a9-4724-08de9eeca607
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2026 14:53:56.7780
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YDmqSEe+ifkRl7Q5eeNHapD8J1nEdo0cQvphUN2b/gl3bAAc/nWAsL6h3bbLjUOuguFkM9BCaAcnXaCJvrtZ2tKpCXoTSljc4hMVW4qYd8k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB10676
X-Spamd-Result: default: False [2.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[renesas.com,none];
	R_DKIM_ALLOW(-0.20)[bp.renesas.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	TAGGED_FROM(0.00)[bounces-10065-lists,dmaengine=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.961];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,tuxon.dev:email,bootlin.com:url,TY3PR01MB11346.jpnprd01.prod.outlook.com:mid]
X-Rspamd-Queue-Id: E49E542F089
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQ2xhdWRpdSBCZXpuZWEg
PGNsYXVkaXUuYmV6bmVhQHR1eG9uLmRldj4NCj4gU2VudDogMjAgQXByaWwgMjAyNiAxNTozNw0K
PiBTdWJqZWN0OiBSZTogW1BBVENIIHY0IDE0LzE3XSBkbWFlbmdpbmU6IHNoOiByei1kbWFjOiBB
ZGQgc3VzcGVuZCB0byBSQU0gc3VwcG9ydA0KPiANCj4gDQo+IA0KPiBPbiA0LzIwLzI2IDE3OjIx
LCBCaWp1IERhcyB3cm90ZToNCj4gPiBIaSBDbGF1ZGl1LA0KPiA+DQo+ID4+IC0tLS0tT3JpZ2lu
YWwgTWVzc2FnZS0tLS0tDQo+ID4+IEZyb206IENsYXVkaXUgQmV6bmVhIDxjbGF1ZGl1LmJlem5l
YUB0dXhvbi5kZXY+DQo+ID4+IFNlbnQ6IDIwIEFwcmlsIDIwMjYgMTU6MTUNCj4gPj4gU3ViamVj
dDogUmU6IFtQQVRDSCB2NCAxNC8xN10gZG1hZW5naW5lOiBzaDogcnotZG1hYzogQWRkIHN1c3Bl
bmQgdG8NCj4gPj4gUkFNIHN1cHBvcnQNCj4gPj4NCj4gPj4NCj4gPj4NCj4gPj4gT24gNC8yMC8y
NiAxMDo0MiwgQmlqdSBEYXMgd3JvdGU6DQo+ID4+Pj4gK3N0YXRpYyBpbnQgcnpfZG1hY19zdXNw
ZW5kKHN0cnVjdCBkZXZpY2UgKmRldikgew0KPiA+Pj4+ICsJc3RydWN0IHJ6X2RtYWMgKmRtYWMg
PSBkZXZfZ2V0X2RydmRhdGEoZGV2KTsNCj4gPj4+PiArCWludCByZXQ7DQo+ID4+Pj4gKw0KPiA+
Pj4+ICsJZm9yICh1bnNpZ25lZCBpbnQgaSA9IDA7IGkgPCBkbWFjLT5uX2NoYW5uZWxzOyBpKysp
IHsNCj4gPj4+PiArCQlzdHJ1Y3QgcnpfZG1hY19jaGFuICpjaGFubmVsID0gJmRtYWMtPmNoYW5u
ZWxzW2ldOw0KPiA+Pj4+ICsNCj4gPj4+PiArCQlndWFyZChzcGlubG9ja19pcnFzYXZlKSgmY2hh
bm5lbC0+dmMubG9jayk7DQo+ID4+Pj4gKw0KPiA+Pj4+ICsJCWlmICghKGNoYW5uZWwtPnN0YXR1
cyAmIEJJVChSWl9ETUFDX0NIQU5fU1RBVFVTX0NZQ0xJQykpKQ0KPiA+Pj4+ICsJCQljb250aW51
ZTsNCj4gPj4+PiArDQo+ID4+Pj4gKwkJcmV0ID0gcnpfZG1hY19kZXZpY2VfcGF1c2VfaW50ZXJu
YWwoY2hhbm5lbCk7DQo+ID4+Pj4gKwkJaWYgKHJldCkgew0KPiA+Pj4+ICsJCQlkZXZfZXJyKGRl
diwgIkZhaWxlZCB0byBzdXNwZW5kIGNoYW5uZWwgJXNcbiIsDQo+ID4+Pj4gKwkJCQlkbWFfY2hh
bl9uYW1lKCZjaGFubmVsLT52Yy5jaGFuKSk7DQo+ID4+Pj4gKwkJCWJyZWFrOw0KPiA+Pj4+ICsJ
CX0NCj4gPj4+PiArDQo+ID4+Pj4gKwkJY2hhbm5lbC0+cG1fc3RhdGUubnhsYSA9IHJ6X2RtYWNf
Y2hfcmVhZGwoY2hhbm5lbCwgTlhMQSwgMSk7DQo+ID4+Pj4gKwl9DQo+ID4+Pj4gKw0KPiA+Pj4+
ICsJaWYgKHJldCkgew0KPiA+Pj4+ICsJCXJ6X2RtYWNfc3VzcGVuZF9yZWNvdmVyKGRtYWMpOw0K
PiA+Pj4+ICsJCXJldHVybiByZXQ7DQo+ID4+Pj4gKwl9DQo+ID4+Pj4gKw0KPiA+Pj4+ICsJcG1f
cnVudGltZV9wdXRfc3luYyhkbWFjLT5kZXYpOw0KPiA+Pj4+ICsNCj4gPj4+PiArCXJldCA9IHJl
c2V0X2NvbnRyb2xfYXNzZXJ0KGRtYWMtPnJzdGMpOw0KPiA+Pj4+ICsJaWYgKHJldCkgew0KPiA+
Pj4+ICsJCXBtX3J1bnRpbWVfcmVzdW1lX2FuZF9nZXQoZG1hYy0+ZGV2KTsNCj4gPj4+PiArCQly
el9kbWFjX3N1c3BlbmRfcmVjb3ZlcihkbWFjKTsNCj4gPj4+PiArCX0NCj4gPj4+PiArDQo+ID4+
Pj4gKwlyZXR1cm4gcmV0Ow0KPiA+Pj4+ICt9DQo+ID4+Pj4gKw0KPiA+Pj4+ICtzdGF0aWMgaW50
IHJ6X2RtYWNfcmVzdW1lKHN0cnVjdCBkZXZpY2UgKmRldikgew0KPiA+Pj4+ICsJc3RydWN0IHJ6
X2RtYWMgKmRtYWMgPSBkZXZfZ2V0X2RydmRhdGEoZGV2KTsNCj4gPj4+PiArCWludCBlcnJvcnMg
PSAwLCByZXQ7DQo+ID4+Pj4gKw0KPiA+Pj4+ICsJcmV0ID0gcmVzZXRfY29udHJvbF9kZWFzc2Vy
dChkbWFjLT5yc3RjKTsNCj4gPj4+PiArCWlmIChyZXQpDQo+ID4+Pj4gKwkJcmV0dXJuIHJldDsN
Cj4gPj4+PiArDQo+ID4+Pj4gKwlyZXQgPSBwbV9ydW50aW1lX3Jlc3VtZV9hbmRfZ2V0KGRtYWMt
PmRldik7DQo+ID4+Pg0KPiA+Pj4gSWYgdGhpcyBmYWlscyBmb3IgYW55IHJlYXNvbiwgdGhlIG5l
eHQgc3VzcGVuZCBzdGlsbCBiZSBjYWxsZWQgYW5kDQo+ID4+PiBpdCB3aWxsIGRlY3JlbWVudCB0
aGUgY291bnRlciwNCj4gPj4gcG90ZW50aWFsbHkgdW5kZWZsb3dpbmcgaXQuDQo+ID4+PiBDb25z
aWRlciBzd2l0Y2hpbmcgdG8gcG1fcnVudGltZV9nZXRfc3luYygpLCB3aGljaCBzdWl0cyBiZXR0
ZXIgaGVyZQ0KPiA+Pg0KPiA+Pg0KPiA+PiBJIHRoaW5rIHJ1bnRpbWUgUE0gdXNhZ2UgY291bnRl
ciB1bmRlcmZsb3cgd2lsbCBiZSB0aGUgbGVzcw0KPiA+PiBzaWduaWZpY2FudCBwcm9ibGVtIGlu
IGNhc2UgcnVudGltZSBQTSBmYWlscy4NCj4gPj4NCj4gPj4gQW55aG93LCBjb3VsZCB5b3UgcGxl
YXNlIHByb3ZpZGUgdGhlIGNvZGUgcGF0dGVybiB5b3UgY29uc2lkZXIgd291bGQNCj4gPj4gYmUg
YmV0dGVyIGZvciBib3RoIHN1c3BlbmQgYW5kIHJlc3VtZT8NCj4gPg0KPiA+DQo+ID4gc3lzdGVt
X3Jlc3VtZSgpDQo+ID4gew0KPiA+ICAgICAgICAgICAgcG1fcnVudGltZV9yZXN1bWVfYW5kX2dl
dCgpIC0tPiBQTSBjb3VudGVyIGlzIG5vdA0KPiA+IGluY3JlbWVudGVkIGluIGNhc2Ugb2YgZXJy
b3IgfQ0KPiA+DQo+ID4gc3lzdGVtX3N1c3BlbmQoKQ0KPiA+IHsNCj4gPiAgICAgICAgIHBtX3J1
bnRpbWVfcHV0KCkgLS0+IGNvdW50ZXIgaXMgZGVjcmVtZW50ZWQgYW5kIHByaW50cyBhIG5vaXN5
DQo+ID4gV0FSTiBtZXNzYWdlIH0NCj4gPg0KPiA+IEp1c3QgcmVwbGFjZSBwbV9ydW50aW1lX3Jl
c3VtZV9hbmRfZ2V0KCktPnBtX3J1bnRpbWVfZ2V0X3N5bmMoKQ0KPiA+IHRoaXMgd2lsbCByZXR1
cm4gdGhlIGVycm9yIHRvIGNhbGxlciBsaWtlIHByZXZpb3VzbHkgYW5kIGFsc28NCj4gPiBpbmNy
ZW1lbnQgdGhlIGNvdW50ZXIgd2hpY2ggYXZvaWRzIHdhcm5pbmcgb24gdGhlIHN1YnNlcXVlbnQg
c3VzcGVuZCgpDQo+IA0KPiBUaGlzIHdvdWxkbid0IHNvbHZlIGFueXRoaW5nLg0KDQpJdCBiYXNp
Y2FsbHkgYXZvaWRzIHByaW50aW5nIHRoZSBtZXNzYXNnZSBmcm9tIFsxXQ0KZGV2X3dhcm4oZGV2
LCAiUnVudGltZSBQTSB1c2FnZSBjb3VudCB1bmRlcmZsb3chXG4iKTsNCg0KWzFdIGh0dHBzOi8v
ZWxpeGlyLmJvb3RsaW4uY29tL2xpbnV4L3Y3LjAtcmM3L3NvdXJjZS9kcml2ZXJzL2Jhc2UvcG93
ZXIvcnVudGltZS5jI0wxMDk0DQoNCj4gDQo+IElmIHRoZSBuZXdseSBhZGRlZCBwbV9ydW50aW1l
X2dldF9zeW5jKCkgZmFpbHMgdGhlIG5leHQgZGV2X3BtX29wczo6cHJlcGFyZSgpIGNhbGwsIGFj
Y2Vzc2VzIERNQSBJUA0KPiByZWdpc3RlcnMuIFRoYXQgd2lsbCBzeW5jIGFib3J0IChkdWUgdG8g
TVNUT1ApIGV2ZW4gYmVmb3JlIGFueSB3YXJuaW5nIChJIGd1ZXNzIHVuZGVyZmxvdyBydW50aW1l
IFBNDQo+IHVzYWdlIGNvdW50ZXIpIHdpbGwgYmUgcHJpbnRlZC4NCg0KVGhpcyBjYW4gaGFwcGVu
IHdpdGggY3VycmVudCBwYXRjaCBhcyB3ZWxsIGFzIGJvdGggdGhlIGFwaSdzIHJlcG9ydHMgc2Ft
ZSBlcnJvciB0byBjYWxsZXINCmFuZCB0aGUgY2xvY2sgaXMgbm90IHR1cm5lZCBvbiBieSB0aGUg
Y2xvY2sgZnJhbWV3b3JrIGFuZCBhY2Nlc3NpbmcgY2xrIHJlZ2lzdGVyIHdpbGwgbGVhZA0KdG8g
dW5kZXNpcmVkIGVmZmVjdHMuDQoNCj4gDQo+IElmIHdlIGFkZCBydW50aW1lIFBNIHJlc3VtZXMg
aW4gdGhlIGRldl9wbV9vcHM6OnByZXBhcmUoKSB0byBvdmVyY29tZSBwYXJ0IG9mIHRoZSBzeW5j
IGFib3J0IGluIHRoZQ0KPiBuZXh0IGRldl9wbV9vcHM6OnByZXBhcmUoKSBjYWxsIGFuZCBrZWVw
DQo+IHBtX3J1bnRpbWVfZ2V0X3N5bmMoKSBibGluZGx5LCB3L28gZHJvcHBpbmcgdGhlIHVzYWdl
IGNvdW50ZXIgb24gZmFpbHVyZSwgdGhhdCB3aWxsIHN0aWxsIGxlYWQgdG8gc3luYw0KPiBhYm9y
dHMsIGJlY2F1c2UgdGhlIHJ1bnRpbWUgUE0gcmVzdW1lcyBpbg0KPiBkZXZfcG1fb3BzOjpwcmVw
YXJlKCkgc2hvdWxkIG9ubHkgaW5jcmVhc2UgdGhlIHJ1bnRpbWUgUE0gcmVmIGNvdW50ZXIgYW5k
IHJldHVybiBzdWNjZXNzLg0KDQpIb3cgaXMgdGhpcyBiZWhhdmlvdXIgZGlmZmVyZW50IGZyb20g
Y3VycmVudCBwYXRjaCBzZWUgWzJdPyANCg0KWzJdIGh0dHBzOi8vZWxpeGlyLmJvb3RsaW4uY29t
L2xpbnV4L3Y3LjAtcmM3L3NvdXJjZS9kcml2ZXJzL2Jhc2UvcG93ZXIvcnVudGltZS5jI0wxMDkz
DQoNCkNoZWVycywNCkJpanUNCg0K

