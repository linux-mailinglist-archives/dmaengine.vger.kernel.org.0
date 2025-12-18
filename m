Return-Path: <dmaengine+bounces-7800-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C3434CCAE6C
	for <lists+dmaengine@lfdr.de>; Thu, 18 Dec 2025 09:34:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B8CD13013396
	for <lists+dmaengine@lfdr.de>; Thu, 18 Dec 2025 08:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3EEF1DFFD;
	Thu, 18 Dec 2025 08:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="IMyOTz1K"
X-Original-To: dmaengine@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011008.outbound.protection.outlook.com [40.107.74.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65AFD137C52;
	Thu, 18 Dec 2025 08:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766046631; cv=fail; b=OpvF/LSPkvRu00t9Xb4XNRyafORHzLzfT807dTHlMY92B78c+kC8OBn3FBCCMYRL/H+oePh9hdjzKzoZByzcT2DgD8KbqyVFlrsIBJYlrdA4NJlkzpBN7bWI9G6ZNn+yg1dVA7bgnvuld4yUR9i3Irsm8gHaZGdhaA4SxNA9DiI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766046631; c=relaxed/simple;
	bh=TtENP3KmWcaeueJt7FZUGRD50Mk0u+qWa08ZgkbK3Kc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZMf3P5JrWiPIJjaMQ6kBOo2TuSufxjpmaqPpAg6leinNIX1OdNMkNq43/EPG+SjJ5WkPljACo7SYk8fQjolmlaYjZ1WoJGiPL+8+lCjogYcqPmQ8Aaynh2eGPa72SXtWtS+98np7tDIteWOEl9UW/x+pDO62+9zD0uNwlBjO11U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=IMyOTz1K; arc=fail smtp.client-ip=40.107.74.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NniBQqZgXUYDZeXQiOzBimcprzVWEiX0ijYxlpryzVf4dIrUYSEM+rBg3WN/vl3X2/lMXr4hB3RST2KV8HMTAMY7WU9gb00Uq3mric/W3ikuTDLs25bvqz/Ytk/m7EINHbdVB2lNvHbxvrnrqjnvPnQL0jGhl+nttnA7Y6VTTR1DF6sdPovo7si0Or03bRLytzUH3Us0HvAyMZR4ElU3rhAsXOfBiCmcbflstW51kTagPahw3QXjUIgbsBVbbQu6zM9dCWntMkmk6WQ7/W6vYX69YmM74Mo3MhIESLhe/+B8B0LjqfkvpyXFgYwAoIO1krIGEd+3mZY8lniQC7kdBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TtENP3KmWcaeueJt7FZUGRD50Mk0u+qWa08ZgkbK3Kc=;
 b=XwFftjJvCjNLAWJz6csyyKGt/naou8g5j1RUiUA8h5VdywxyCvp75qlmQAemnHD7iHaX7XEV2dC8azcl+A/4VqHEjVLvJrLLI2HD19RCa24GkEiDjuMGuserb0XuB5Q+0d2AgVBH61wHgGxNgoB1GtcfOWAMhlhOipmd9lFd7+TpWz+0CIwyLOU4eNFOwBrzi35vq2SH3GO28nC1zXloaT1IuuhzwrSeP6Bwkvp79CtdDoBfTuuyDZgY8OLCdltEy7bmf34FE0fXiaESGImQGPQTLISpSanBgtdNnqAqpzBrBX7CpIqiDNmiNrGU68KmUnao10lKz1Nk2oC+pxbb4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TtENP3KmWcaeueJt7FZUGRD50Mk0u+qWa08ZgkbK3Kc=;
 b=IMyOTz1KRe8pP0y9SAvG4maPdlTcjP/vzAAk3iN+1tgFZAyWCE4QEGynBXCCh4edInAh6qLltuA/1QG3kT9w2kUcoLUV9Sv20JghyKQS17ubTkbYpp0rCJVc3dInl6cKKqt2/RpYWn1NNu/jZepqTI48mV6TgR0XEbNmqrFaGoU=
Received: from TYCPR01MB11332.jpnprd01.prod.outlook.com (2603:1096:400:3c0::7)
 by TY3PR01MB12091.jpnprd01.prod.outlook.com (2603:1096:400:3cc::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.7; Thu, 18 Dec
 2025 08:30:24 +0000
Received: from TYCPR01MB11332.jpnprd01.prod.outlook.com
 ([fe80::2511:10cd:e497:4d97]) by TYCPR01MB11332.jpnprd01.prod.outlook.com
 ([fe80::2511:10cd:e497:4d97%2]) with mapi id 15.20.9434.001; Thu, 18 Dec 2025
 08:30:17 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Claudiu.Beznea <claudiu.beznea@tuxon.dev>, "vkoul@kernel.org"
	<vkoul@kernel.org>, Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	"geert+renesas@glider.be" <geert+renesas@glider.be>, Prabhakar Mahadev Lad
	<prabhakar.mahadev-lad.rj@bp.renesas.com>
CC: "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Claudiu Beznea
	<claudiu.beznea.uj@bp.renesas.com>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: RE: [PATCH v5 2/6] dmaengine: sh: rz-dmac: Move all CHCTRL updates
 under spinlock
Thread-Topic: [PATCH v5 2/6] dmaengine: sh: rz-dmac: Move all CHCTRL updates
 under spinlock
Thread-Index: AQHcb1xlhp/+aQF2iEOVgbBl5tSyVLUmAFiQgAEFDQCAAAvgwA==
Date: Thu, 18 Dec 2025 08:30:17 +0000
Message-ID:
 <TYCPR01MB11332CA51AE3F9792883FD9A386A8A@TYCPR01MB11332.jpnprd01.prod.outlook.com>
References: <20251217135213.400280-1-claudiu.beznea.uj@bp.renesas.com>
 <20251217135213.400280-3-claudiu.beznea.uj@bp.renesas.com>
 <TY3PR01MB113463722674503F2B15F944786ABA@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <e2037b38-4c20-4f1e-b681-ae3def30823c@tuxon.dev>
In-Reply-To: <e2037b38-4c20-4f1e-b681-ae3def30823c@tuxon.dev>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB11332:EE_|TY3PR01MB12091:EE_
x-ms-office365-filtering-correlation-id: dc829668-234e-4b06-08cd-08de3e0facc2
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?Q25DV2l1QmlHK3R3RHJRNkNidlV5eFJRUSt1WURMRXIvZTgwQTFwN3AzaDZY?=
 =?utf-8?B?WTMyN01kaWREV1J3STZiL1RsZUFTSWxpYVZjS25XUWFVVjRaamhaTEhlbFJ2?=
 =?utf-8?B?OXNFbFlpTHhWR04zOWIyRklDR2NHK29EN0RWODVLc0liS1VzVHl1VGt2U0hm?=
 =?utf-8?B?cWo2TkhFMjVhL2RldDE4OWowRmlWc1FNSVFIQ2x3eHZiU2FMQ0hmdmdMRFl0?=
 =?utf-8?B?RnU2N29yU1lrVmlHaHhIeVdtSmxyUTU4RCtrSEVvdVpPUVNWWTFUZEtSdkVu?=
 =?utf-8?B?Mk5uSUVsVjFlVFYxU0w0Wjl2T3JKTW9nem8zU0NMUWE1TFBDYUpnQmpDU3lB?=
 =?utf-8?B?Rzk1WWlqWWZNUWwydmlLV2NGaEJrR0NHdDhoU3FHVVZRTFVtUVVGR1pOMUZO?=
 =?utf-8?B?cDh4b0JHeGFxQ3ZsM2RDb2h1VzJHcWhRZFpMV1lUTnR6VjhIelhWdjVNUFVC?=
 =?utf-8?B?K3J4VXpzbHBrTHJIYWtUd1FaajEwa01BdlZudWdOcjF1TVNPSjJZZURraVFK?=
 =?utf-8?B?R1FUUHVwUXY4MWtvL3ErYnVPUm5GTjlwZVoybENYWFdKNUZnOXkwMHJOQ3dP?=
 =?utf-8?B?SCtndEUxdzd6dEM3WHJJaU5QcTVPVzhzOExnRS9HTnNjQnpQeURoNWJ1NmFD?=
 =?utf-8?B?MXhJQjFOMlhrM1ArNkNjUGpkOUJRQTNJNVliTmZ5Ty8zRUlPZERIK3ZqbXlT?=
 =?utf-8?B?YnBJb1FUZEFlQVZPTmQycUhiK3hsL3NBVm9FbzBEY2MvVEswOFhkY2NoMnA3?=
 =?utf-8?B?bVk3d2grT3U1Y2dRdVhrQmlZOGd4K3Q3SkZxSDBzQ0NVR2lqMC93WEtiY09C?=
 =?utf-8?B?aGR1UXpGTlFURk5NTnZVNmVtVUJ4Q3dybXY3S25uc1c0TkRZd0dyaDNOOGh5?=
 =?utf-8?B?aUtNeFJaWW5jQ29vR2JqQ2JFT1RNdk41T1BEb2FXR0MvM0NSeUFZVTNOS2I4?=
 =?utf-8?B?VGxjVlpGUG03OUdYV0J2RGx6L2Y4ZzZERTlZWnBERGlPbzRObWsxc2JEWENV?=
 =?utf-8?B?K0tFdGw0elF5U0dBOFZHc2pYbWtVT1dweG1lWEpReGdNWWZSZlJjRmMzZjJj?=
 =?utf-8?B?Ti84djJ5bjNzMWNKNGRTWWxrYWxOa2ZIYTBXa0VwVGwxRmttdjdjMmhwT25Q?=
 =?utf-8?B?R2hCS3gxa3VTR0NjV0xwTnExQ0RlODMrZnFRUEFCMkRxT1h3cTB1QkNEOUlY?=
 =?utf-8?B?ZWRxTTMzS2V1V2c3VXJQVW1BRjN4MDFUY0kxNjlySzFmQ2pKZ1FNT1FmaUtz?=
 =?utf-8?B?RWRCWkFwVVJJd3FGdFRNYWpKdmYycHo0U1hPQWpEU3ozWnhkak9sTnhpQzJ2?=
 =?utf-8?B?R3pHTTlrVHhSckdGUVFudFpkSms0dnhPYXBHNitMcDJOVlQzbSt4ZStDY1BJ?=
 =?utf-8?B?WVZSeHl4WU5JdDU0NWNyQ2VOTDdZbHg0SEZmMDljYUllN1VaS1laZi9XSytF?=
 =?utf-8?B?Z1Z5bFE2Z3VKdnlEa2RPSEgrWXIzNTlVQ2Foa2VSdWFWSlBNNkZWYUpsNTlJ?=
 =?utf-8?B?SXJKV2Z5L1Yzc1I3eDZNTzN0Q2V4NGg5ZnEweGIrNzArS3ExS2x4SGJOVXM5?=
 =?utf-8?B?bENndWpXa29mNHZ4aklKSmZnOUNHVHpmbkRUSTEwZ2w0bnUySjJuTm1WYlE5?=
 =?utf-8?B?M2NrMVFuS2dnMUJtN1loWUQvVlZ4YTdOcldBVHZYbldIUThablk3eEpTMFl2?=
 =?utf-8?B?UktwV29sSXVmN0grLzZVc1c3c3JvK3hGWXZJR0F4M3FwVVVYVFpCR3FybzlC?=
 =?utf-8?B?RVlRZkpkY2laUUxPbFd1bVNNV28wblZwcXY0MEZOK3g2VGFnaFhMWTJMb1Vx?=
 =?utf-8?B?UFN6OWpIQnNQRkRHaWJKWEs4bU12dEFUdFJlVW9wWG1tZGpBV3BCc3dWY2Rq?=
 =?utf-8?B?TGNpYW1YbUhNSGgrN1kwejI4MStXVFNWNkFQaUo4bml4NTAwSmJodFBiMnRh?=
 =?utf-8?B?T1hBejRkYVJUaXB5MVErMzN0UXRiZTBldVBEOFE1U2FobVRMMWtYVFJmSHV0?=
 =?utf-8?B?VzZrSnRhME1vQlZGTkpXSmNBOXdvb3l6VGJtalNrUWxmQ2hRWG1EZUdiT2M5?=
 =?utf-8?Q?Mp2Cqp?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11332.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cUNxVWN6TmZxeTJPeU82YW42YjgvK2ZjMFVXdFpXK0YyS1FRZVdTWCs4clV6?=
 =?utf-8?B?TlI2ZUVGSXp6VWdSbEtTa1ZteTNRR01jM0RRVWpIek0yaXhTWExVL1JzTW1m?=
 =?utf-8?B?ekNtY3dhQXRpQURrTVBEV3NoTm5UbzA3K0poc3IrNmh4QUQwYlMvcXpUTUxt?=
 =?utf-8?B?QzVyTkpRbll3ak5VV0pBSEhPNzUxa3Q1Y01yOWpsMmkrNVdISGJzeVM5eVpS?=
 =?utf-8?B?T1NKSWVQSVRwa0MrYy93TDZNOUsvZU56cTJJRkRkbWpQYkRKWjdVc0NxWnZQ?=
 =?utf-8?B?S04vcm5WRC9nNmxudXZNMDhXTWlTWk9pU1RqZGdKVjVqYjhnS2FQTkpGSGhP?=
 =?utf-8?B?bXpBZE1qNjBjU1NrenNqRWZZOHpVN2MyT0Y0QlNDWUV5bHhYdW5ESEZCMFpn?=
 =?utf-8?B?RnN6YnVRaXNZclFaQjdVZi9zMi8zVy8rL1Axem15d0txR1lyeUJTZW44Y1hm?=
 =?utf-8?B?MUpVUXMzNjhJWnBPSXJ3UFFPUUpxRDZnajBoai85VjNnbStEL2xDa0JIOTJr?=
 =?utf-8?B?V1RLWldPVFBLR1dTeFY5MTVBUHZZZmtVVm1pY1dVcEc3YjZaWFpnQ2tuZHNn?=
 =?utf-8?B?ZWJHSXJZN1RzS3RNTGxWaXNwQWEvcjA2QlU3dTk3cVJHdGttcWp1WVA2UGZa?=
 =?utf-8?B?V3JTeFRZZnVvUjlnZS9GYlBBL2U2Nlp2VmpRblcyM3F2dGZxZm9POFEvdGdH?=
 =?utf-8?B?Q1hsZFh4TmpxeUxvUUJwR2dlaFZwVVFPRkp5Mnp2aElkT3NIeC8wMUxlcnhD?=
 =?utf-8?B?S1V5WjhPMGxGdE5JQzdMUWpXcVNsTFFjZ2w3bU5QNzNBZ2RiRU1wTXpCZUM0?=
 =?utf-8?B?VGtVWlV5VkZkOFpMRGFUcGxPalR3dm9SMVFwNmMxTVZJenQzdnFNVHA5Yldr?=
 =?utf-8?B?dFNkMGMycVhaK215eFBoUS9uY1ZmUEZ6aVRXTHoyRTQvODNnQ256YXdoVzk0?=
 =?utf-8?B?OWczaEN5elpUOW51WVduR1FQOTk5ZE12QTF1MW5TaUtVWHlaZkZIbTJhSFQz?=
 =?utf-8?B?enF4K3EzbmkwaGw2Q1BZTUdKVDF3eUhoeDdzdTI4ZW5HR1cyNFVDczJqSVQr?=
 =?utf-8?B?cGVyRUQrUmlJRitzbjRYY0FkeTY4bkYwQjhtdGtvZ0VHdlljRVpMSUFwUERQ?=
 =?utf-8?B?SHduYlA2REEzM2lmNVpLQ2VHU2tETGNoYUQxZGVyQnpLSWQ2WmhENWxrSzB3?=
 =?utf-8?B?Zm94cnVlWVhmMWlCSzBkcEo2blJxSnZ6RjhQNXZyaUVTRjBrc2RjTzdFTzYy?=
 =?utf-8?B?V2lsRUJERzJvUHlaYlVhZDg1MWp5VGM1NTBpL2hESTdvMDJIMk5taTlPS0hO?=
 =?utf-8?B?ZUJ0RkVhaUZ0d2FucUE0cGpPd3dDYUFGVXo2clMvZFREQ1hibUNjYTdnRFEz?=
 =?utf-8?B?VTdNWk0xa3VkTmZVemFYTWRzd1BzUE9jNnhRbVNuRHdoVkF0dExFNDJ2ZzhU?=
 =?utf-8?B?am5iQVg5SVhHeEZCTVhFVGtTM3IvUXVhUUpiZUQ3YlBQSU5nYUF4VlhDaThB?=
 =?utf-8?B?ZDNVVktWVUNUSkhGdzF5MDhLRGZDTGlsOGFINnZNT081TTJCZ3hQYlhVL3U5?=
 =?utf-8?B?OElrSFdrMkhhaHp6YkhNbVV3QmQ3NEI0WFJYQ0JrQWs2dUttUUpWNG1CQ0ZX?=
 =?utf-8?B?M3lqYjY1d1BOc0wxd0FlOVdPUDdBa3QxWkhtUk1HU0JvNEFPd1hOVzh0VUYv?=
 =?utf-8?B?cDBsdzR1WXZzMVI5UzN6eGVlM0RPZHVSSG94QVoybjZPTDVRZ0M2Q2Iwb3JY?=
 =?utf-8?B?N3Bjc1pVYll1d2dLNW9FQ2VCSWFXcVFLazQ3bHFXaUIzcTUxYjlYOExpRU5m?=
 =?utf-8?B?MFpZQWxuV0wvOVIxQjVXYUpRdERaQWpkTzFXNk9YSVZUbWxxTndNSzVMSnJL?=
 =?utf-8?B?b1U4NHpGT0FYZVljc3Rnamk3dXFDMFdKb25uNmpUTEZIQWdOQzVkRU5BSGl1?=
 =?utf-8?B?RHp6YjBBVE14Y1FlZTV4aTZLWVdMV0pyT2thZ1cybElzeVIydU13L2xFM3hj?=
 =?utf-8?B?bkE5S2MvMVRkVTZGSUFGSGNzc0Qyc1B3OTlYY3ZoWlhwZzFJT2QvV0JMQnQy?=
 =?utf-8?B?bzhOamZjd1FUR2VWb1ZmNzN0aFF5R0JjTFFWdzJOQ3ptZTU0ZUdGeW1HbFBS?=
 =?utf-8?B?ZWJhTzBkQ1BkYUxuZVZpbUxBaTRtNUxkYk9OeUdnRTdQTEhEYVlrTmpJRFk5?=
 =?utf-8?B?Z2c9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: dc829668-234e-4b06-08cd-08de3e0facc2
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Dec 2025 08:30:17.6395
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5/t29HXr7j0s9/fFqpx7mx/h/GgOvganFVIT+FIrwOX4twfT4qvGshA72l58UtEwFaZw4paacPQ+Efz1CzmsJA7dDw6WLOnoHHwencuYqbw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB12091

SGkgQ2xhdWRpdSwNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBDbGF1
ZGl1IEJlem5lYSA8Y2xhdWRpdS5iZXpuZWFAdHV4b24uZGV2Pg0KPiBTZW50OiAxOCBEZWNlbWJl
ciAyMDI1IDA3OjQ0DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjUgMi82XSBkbWFlbmdpbmU6IHNo
OiByei1kbWFjOiBNb3ZlIGFsbCBDSENUUkwgdXBkYXRlcyB1bmRlciBzcGlubG9jaw0KPiANCj4g
SGksIEJpanUsDQo+IA0KPiBPbiAxMi8xNy8yNSAxODoxNiwgQmlqdSBEYXMgd3JvdGU6DQo+ID4g
SGkgQ2xhdWRpdSwNCj4gPg0KPiA+PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+PiBG
cm9tOiBDbGF1ZGl1IDxjbGF1ZGl1LmJlem5lYUB0dXhvbi5kZXY+DQo+ID4+IFNlbnQ6IDE3IERl
Y2VtYmVyIDIwMjUgMTM6NTINCj4gPj4gVG86IHZrb3VsQGtlcm5lbC5vcmc7IEZhYnJpemlvIENh
c3Rybw0KPiA+PiA8ZmFicml6aW8uY2FzdHJvLmp6QHJlbmVzYXMuY29tPjsgQmlqdSBEYXMNCj4g
Pj4gPGJpanUuZGFzLmp6QGJwLnJlbmVzYXMuY29tPjsgZ2VlcnQrcmVuZXNhc0BnbGlkZXIuYmU7
IFByYWJoYWthcg0KPiA+PiBNYWhhZGV2IExhZCA8cHJhYmhha2FyLm1haGFkZXYtIGxhZC5yakBi
cC5yZW5lc2FzLmNvbT4NCj4gPj4gQ2M6IENsYXVkaXUuQmV6bmVhIDxjbGF1ZGl1LmJlem5lYUB0
dXhvbi5kZXY+Ow0KPiA+PiBkbWFlbmdpbmVAdmdlci5rZXJuZWwub3JnOyBsaW51eC0ga2VybmVs
QHZnZXIua2VybmVsLm9yZzsgQ2xhdWRpdQ0KPiA+PiBCZXpuZWEgPGNsYXVkaXUuYmV6bmVhLnVq
QGJwLnJlbmVzYXMuY29tPjsgc3RhYmxlQHZnZXIua2VybmVsLm9yZw0KPiA+PiBTdWJqZWN0OiBb
UEFUQ0ggdjUgMi82XSBkbWFlbmdpbmU6IHNoOiByei1kbWFjOiBNb3ZlIGFsbCBDSENUUkwNCj4g
Pj4gdXBkYXRlcyB1bmRlciBzcGlubG9jaw0KPiA+Pg0KPiA+PiBGcm9tOiBDbGF1ZGl1IEJlem5l
YSA8Y2xhdWRpdS5iZXpuZWEudWpAYnAucmVuZXNhcy5jb20+DQo+ID4+DQo+ID4+IEJvdGggcnpf
ZG1hY19kaXNhYmxlX2h3KCkgYW5kIHJ6X2RtYWNfaXJxX2hhbmRsZV9jaGFubmVsKCkgdXBkYXRl
IHRoZQ0KPiA+PiBDSENUUkwgcmVnaXN0ZXJzLiBUbyBhdm9pZCBjb25jdXJyZW5jeSBpc3N1ZXMg
d2hlbiB1cGRhdGluZyB0aGVzZQ0KPiA+PiByZWdpc3RlcnMsIHRha2UgdGhlIHZpcnR1YWwgY2hh
bm5lbCBsb2NrLiBBbGwgb3RoZXIgQ0hDVFJMIHVwZGF0ZXMgd2VyZSBhbHJlYWR5IHByb3RlY3Rl
ZCBieSB0aGUNCj4gc2FtZSBsb2NrLg0KPiA+Pg0KPiA+PiBQcmV2aW91c2x5LCByel9kbWFjX2Rp
c2FibGVfaHcoKSBkaXNhYmxlZCBhbmQgcmUtZW5hYmxlZCBsb2NhbCBJUlFzLA0KPiA+PiBiZWZv
cmUgYWNjZXNzaW5nIENIQ1RSTCByZWdpc3RlcnMgYnV0IHRoaXMgZG9lcyBub3QgZW5zdXJlIHJh
Y2UtZnJlZSBhY2Nlc3MuDQo+ID4NCj4gPiBNYXliZSBJIGFtIG1pc3Npbmcgc29tZSB0aGluZyBo
ZXJlIGFib3V0IHJhY2UtYWNjZXNzOg0KPiA+DQo+ID4gCWxvY2FsX2lycV9zYXZlKGZsYWdzKTsN
Cj4gPiAgICAJcnpfZG1hY19jaF93cml0ZWwoY2hhbm5lbCwgQ0hDVFJMX0RFRkFVTFQsIENIQ1RS
TCwgMSk7DQo+ID4NCj4gPiBBZnRlciBsb2NhbF9pcnFfc2F2ZSB0aGVyZSB3b24ndCBiZSBhbnkg
SVJRLiBTbyBob3cgdGhlcmUgY2FuIGJlIGENCj4gPiByYWNlIGluIElSUSBoYW5kbGVyLg0KPiAN
Cj4gTXkgcG9pbnQgd2FzIHRvIGFkZHJlc3MgcmFjZXMgdGhhdCBtYXkgaGFwcGVuIGIvdyBkaWZm
ZXJlbnQgY29yZXMgdHJ5aW5nIHRvIHNldCBDSENUUkwuIEUuZy46DQo+IA0KPiBjb3JlMDogdGFr
ZSB0aGUgSVJRIGFuZCBzZXQgQ0hDVFJMDQo+IGNvcmUxOiBjYWxsIHJ6X2RtYWNfaXNzdWVfcGVu
ZGluZygpIC0+IHJ6X2RtYWNfeGZlcl9kZXNjKCkgLT4NCj4gcnpfZG1hY19lbmFibGVfaHcoKSAt
PiBzZXQgQ0hDVFJMDQoNCkZvciB0aGF0IHlvdSBjb3VsZCB1c2UgYSBuZXcgbG9jay4gQ3VycmVu
dGx5IGFsbCB0aGUgY2FsbHMgYXJlIHNlcmlhbGl6ZWQgdXNpbmcgdmNfbG9jaw0KSW4gaXJxaGFu
ZGxlciBhbmQgaXJxaGFuZGxlciB1bm5lY2Vzc2FyaWx5IGtlZXBzIHNwaW5uaW5nIGFzIHRoZSBj
aGN0cmwgcmVnaXN0ZXIgaXMgdGhlIG9ubHkgc2hhcmVkDQpEYXRhIGluIGludGVycnVwdCBoYW5k
bGVyLg0KDQo+IA0KPiBIb3dldmVyLCBsb29raW5nIGFnYWluIHRob3VnaCB0aGUgSFcgbWFudWFs
LCB0aGUgQ0hDVFJMIHJldHVybnMgemVybyB3aGVuIGl0IGlzIHJlYWQsIGZvciBlYWNoDQo+IGlu
ZGl2aWR1YWwgYml0LiBUaHVzLCB0aGVyZSBpcyBubyBuZWVkIGZvciBhbnkga2luZCBvZiBsb2Nr
aW5nIGFyb3VuZCB0aGlzIHJlZ2lzdGVyLiBBbHNvLCByZWFkLQ0KPiBtb2RpZnktd3JpdGUgYXBw
cm9hY2ggd2hlbiB1cGRhdGluZyBzZXR0aW5ncyB0aG91Z2ggaXQgaXMgbm90IG5lZWRlZC4NCg0K
QnV0IHN0aWxsIHlvdSBuZWVkIGEgbG9jayBvdGhlciB0aGFuIHZjX2xvY2sgYXMgQ0hDVFJMIGlz
IHNoYXJlZCByZWdpc3RlciBiZXR3ZWVuIElSUWhhbmRsZXIgYW5kIHRhc2tsZXQvcHJvY2VzcyBj
b250ZXh0DQoNCg0KQ2hlZXJzLA0KQmlqdQ0K

