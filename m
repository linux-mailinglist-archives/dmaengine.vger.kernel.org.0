Return-Path: <dmaengine+bounces-10002-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SJqmOqRD2mkGzggAu9opvQ
	(envelope-from <dmaengine+bounces-10002-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Sat, 11 Apr 2026 14:50:44 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E7ED3DFFA0
	for <lists+dmaengine@lfdr.de>; Sat, 11 Apr 2026 14:50:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8D8713030B1E
	for <lists+dmaengine@lfdr.de>; Sat, 11 Apr 2026 12:50:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E0AF1A6808;
	Sat, 11 Apr 2026 12:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="KgaJeVM+"
X-Original-To: dmaengine@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010013.outbound.protection.outlook.com [52.101.229.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAB01C2FD;
	Sat, 11 Apr 2026 12:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775911842; cv=fail; b=I+mynQCr/IQO3E2/xgy7aZ7sFcYXpqFy0SmKnb/SxhCnZxBwN9xVX6jb51TPbfNTxwMTDR0tLJheNPds0joTj1E8oxW0H0ytbFqS2Nd746lyb/mf2eXdLo5TKb+ZOCX0SN1F65AaNBkwaBZOik7jSXoBrEmDmHhQ8mRIJTkhvgQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775911842; c=relaxed/simple;
	bh=bdnsywhvXbqUn4PpAb7MbxiK1mQ2FfpcrXKKkDCEKuk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=szU5H3fqpXjsWK9LwFMsBGmodr+bkFAmchegZ+gPzs+gCvDcRwKDRBfvylidukHxRkBxvr26qsoB+VoLJQHfDfDhWnhPgE6heltCuuLpMMhjXUqC1ZoSOnjOOwhWsoPfAzr5s4O+Mw4/zoGgUZK3gLxnO1RYLmCsbvqV7/4Kc0o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=KgaJeVM+; arc=fail smtp.client-ip=52.101.229.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LMkXidDqCeNUEqgc1E7a3Jt4PVWiQ9Oz8Nu5LAj2z4eBiUCAf98Qkf1kjn9sXsgdpt/h4T4SjvhjcqS2t/zGKcx9Ukki1GBhDB57AwBUsBQ9hY23Ti6IO3crQI1htacim8vvi+J2vPiz5K/oS5jcIjJHq3Y/JbBuxrd3RM4uZXWWoVZN9vYIUzyOZPATupe6rXEeR0Q9IoVyQZScrugsoi3gr6WpJ+GKIl9ya1pylNZ7KhSWzHtOEpQB8nhe7FI0YtP+7LPFpOJp0cjnIoWQsOb/VvbHw0bc/J99V0WlG61YSPrAsg4+s5dPpuhHx6kLVYhEDdinPT5jXhRyosWPqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bdnsywhvXbqUn4PpAb7MbxiK1mQ2FfpcrXKKkDCEKuk=;
 b=XHenH74zEitufksf/p0Z5KI98FOCu7GQxHyB3kqH8GlgmHGqjQEIzkVvjAGcrqfMNDOfCttfPuvKDsE1bGIJ3kQ34xJeeLnEPX0gAvjlVqcTc5iB6zBQ8jSTmv+9bH3bxcMAmD3EUpEzTlF1PPYjzEC5LcdbgxCasbkldFVjuULUcbgGYiDojvC2RM5kw3CWCqc4GzHAolHJHloKtDoI+ooN/rn0crYXwwLQxpi8fRT8VtfAobvJVdEqOu1ZW9lb6HY6Xy/PR7PZnNTtsMUeh6imdmE1dARHZx5moFjd2FrGvc/JgD7dYDJUKbw4rVmFGPRa0rrr5tYwWrQOS0NWsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bdnsywhvXbqUn4PpAb7MbxiK1mQ2FfpcrXKKkDCEKuk=;
 b=KgaJeVM+cMyXe6nMg9NnYwqGkTOBshTCdsqzNIyMqPjK0xSJhuM6jIEU0feAvckTVNQw9f5SRrPSZWzeRVEDTDi0JbcNtCZ89l3HKeY+unyZY/NGCezzOL2uFvtBR6YAy3Rb2hM1G/Uz4DRk8bGR+nzfeB5OQXETuXWAYUB6+ZI=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by OSZPR01MB7020.jpnprd01.prod.outlook.com (2603:1096:604:13d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.46; Sat, 11 Apr
 2026 12:50:37 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de%4]) with mapi id 15.20.9769.044; Sat, 11 Apr 2026
 12:50:37 +0000
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
Subject: RE: [PATCH v4 07/17] dmaengine: sh: rz-dmac: Save the start LM
 descriptor
Thread-Topic: [PATCH v4 07/17] dmaengine: sh: rz-dmac: Save the start LM
 descriptor
Thread-Index: AQHcyahowtZW2SpfKkiEwpkT0iqfGbXZyzCQgAABwICAAAMIMA==
Date: Sat, 11 Apr 2026 12:50:37 +0000
Message-ID:
 <TY3PR01MB113466AF3B82D5A2A8F34FB0486262@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20260411114303.2814115-1-claudiu.beznea.uj@bp.renesas.com>
 <20260411114303.2814115-8-claudiu.beznea.uj@bp.renesas.com>
 <TY3PR01MB11346602C7FD8ACAB74BB568486262@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <f3577fe6-efc6-4acf-956b-93be6d498238@tuxon.dev>
In-Reply-To: <f3577fe6-efc6-4acf-956b-93be6d498238@tuxon.dev>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|OSZPR01MB7020:EE_
x-ms-office365-filtering-correlation-id: 58bab91d-0b1b-4271-95c8-08de97c8edf3
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|1800799024|18002099003|22082099003|56012099003|38070700021|921020;
x-microsoft-antispam-message-info:
 /TMEyJwRmQ0FZfOZKpecv+zsN26He+/EdOhfgdk6VJjCqrtgR4BAo4ao8O9Pj+PWf1vCcUjN3Ph0ujyKWu1RuO6gqJQUcvrLiCjfjMccQSyMCgIiTh8VFyCUwcoMQkJzqBtW1yT7O5eXqpMKbQOuXLLtlSXZMNOoLJqAiCGynQkMHNmNF62iTrEN9kR+zL2OFqNQC3Zv6grsve3p98pOWW4+L9XNzBHKo/3RiAlN5roo5EynkjgFx0jVFOxvwMGdKpOWJNx7rbgONXNoWKjBX72UwnbeiMgheGPlRSIX1Gqp2/1bo0KGYIlfcvLOhurNRAksrxzYO3oaPTpeuaCPfrVPBPQ9pe1qJLg56kSK8MzmGYagM9iM4J9dgFKf3dqqy5zf/DGplirf0a1TbBSulftF3CDj5SdVht/8JJhX/gSdJfBIsJfppn2J3pniUMbzblo8WmN/3gAQDTh+CGFxiUEr8FAS11ayRdKI01jYuvazVi4sv9PIbSTaCFq0l5MlJocYa8cVFhvhFOTRU+7eR0ycybe4aEt8n8jphC/660pxQbyAHEes28a4YvsI95mF9KqtvoQmsmLOgn6Hq+gTclg0RJJp9AkOCXywraIuYX2syVWyCb7a1n1y10ZLwoGl4nZw4vpC3jLKfX4a2Pg8xIv30TCGV0+oy9TeGTgNPFgP2HeGz5s+9qOKGoIBSqCaBm2Po8eLe4KPwU60w4RpbwK1e+HynQHwPF+xaToUfli7zGWPZstWxLHKXuw3pt6UQt/uuT0LqOVz0qKcl/KgCj7EfVQvRnnJEfv1q6SPtxQTZNR5VoadJAHLhK8NDFMA
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(18002099003)(22082099003)(56012099003)(38070700021)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cTlvbENrcHArVExvUGFlSENUenRlM3pjL2tDN24rSGc2em1SM1E1VUVlbExG?=
 =?utf-8?B?b3hDYzBGdEovQmdPWlhnbDBZcS9BT3IvOExMdFpYQlpPVjNlNXBRbk9FQWtO?=
 =?utf-8?B?WXJnVnRQNDFNRXZ0QlZ2VUVTeXFNczJEak1hZ21wY1VWZ3BnajNXQURGaTZi?=
 =?utf-8?B?cVcxUW01by9NZkIxM3pSRDVyYllzSi9EOHlleEJDTFgvN0pVeU40Wnd2NE1L?=
 =?utf-8?B?dE43UEVxQVUxajdITWdvSDJHc2VTYjNSQlJoN2U2R2JmLzBHc2VtNCt3ZXFl?=
 =?utf-8?B?a1U3SkFLdzh0ZUNVRG9pZm9keXFVZ3FTcDd4bUk4VjF3b1BoV3gwQVIyTWUr?=
 =?utf-8?B?cy9SRzU4SmRWUE15V2VsNEZLd0NxVjdJeVgrbFd6MWN3WjVqWFhMczdDUTRv?=
 =?utf-8?B?ZC9oZE5GRnB0VXBHaGQ4bGtaMWVmTzVsdHdvZXRFYTVIcmlxQ1A2QUo4ZitW?=
 =?utf-8?B?R2NqVStBSlArS3lPVmh5YzdLRnF2emhBbVZ6cjdiWGxPNmY3WEtqNkRjeGVk?=
 =?utf-8?B?bTNWT1ZjZ3lzN094UU5ROEExQUhma2dtMG1ZTy9zTmZRNGlMcldJNkRPYWlL?=
 =?utf-8?B?S2lVV0VvOHpIQzV6ZjNCU3BXLzRDZmFCSkl0bmdXaVp2a09ZSUZ0S3NEeEF4?=
 =?utf-8?B?MlAremZJZVVtcGtNb05IYkJHcjdCUEtTYWlUbTNueHdUSEYyRk9KR20vU1Z3?=
 =?utf-8?B?eThPQmFZSk80TWF5VWN4VURaYS9qZU1tcjhGdUM4NzB2YlNkTjhZRjhjTll3?=
 =?utf-8?B?QUUzek5Qclh0MlcveHRzcmZOU2VCc2pVRUUrMVo2T1ZjT0diRlVralJXYzNM?=
 =?utf-8?B?aTl6aEdyWDNza01nNjZZWFovUW54WG1DM3FIRTE1UHBKSnJrLzZyZFB1QTVi?=
 =?utf-8?B?T3JvVVpLQ0ZSeUwxMHBMSHV4MHRxNXNkZUZCQkllcEFmMjdpc0N1ZUNmT3pi?=
 =?utf-8?B?TnAwajl0Y3JjYlllRFF1bjZGWlRYMElJb1pNcEdsZnRtQzRySzNqaDNxRGp1?=
 =?utf-8?B?Z2pxelBjVnRXdVk0Uk9VVUxmZmM1V0hZWlZOQnc3c1dldXVrMEtCaSt6SUsv?=
 =?utf-8?B?eEJHMkZRQnRUR2FvZFZXZUo5M0ZZZ20zS25KVEtFMC91dStjTmdISllKTkhR?=
 =?utf-8?B?T1E5UEN4VWg4akJQK2U0ZDI3RXB1bFQ0eWc2bWREcjBpNG1sck9CYlNnRHVC?=
 =?utf-8?B?SXltYjB5MjJUSFF1RHlremJLVjJRTWRlS3dPWEFkcWJVbElRRmRrdEZRcXBJ?=
 =?utf-8?B?djVCdjdleGxJWlBVenhJWCsyTUpqVXRPQ0pqcEJJNnB1RmZXRk5MOSs5a2tP?=
 =?utf-8?B?MVpxK3FxWDBNbmtUK1ZzbWMrK2w0eWdlVGtHVW9UNVEvcG9PcUtvdnRnaUh4?=
 =?utf-8?B?WTNhc0J4MWpxZlJvR0hNSEwyTFNWUnYvamZnU1d0VU43aDJhM2wxWmh3OGNK?=
 =?utf-8?B?bk9rN0ZobXdicmxONnNiWXB5RVU2SWFXekEyNFdnWi9Rd2pqakZabHFLRW1s?=
 =?utf-8?B?VE5BamlNaDlDa0NSYkVOelo2cVRpd2Z0NUNIcGgyalJocnByYjIxTWxtd3lk?=
 =?utf-8?B?Ty8zWlY5VlhJZGhqQzlZdzJ5UzN6R3pTemNWNmZsbVB4c3htWDk4dGpUNDBS?=
 =?utf-8?B?empubVd1aFlhakNoQ1pjd3kvTnBhSDJGaitHYkVyZll2aHNnUTlFcHZZT2py?=
 =?utf-8?B?OGdDM0lOZFhWL1Z6Y0oxaXlFUkk3Rkp1NUh5M1hXZ3hrMzV0MWZHUGlXdFB5?=
 =?utf-8?B?Z3l4c1lLSkNFNWs4dWFoU3dNQzQ5OTU1cjhDRmJUSFZ1MTQ4dmNSNk54a2VK?=
 =?utf-8?B?OWVjZlRKVk9RRS83d3FZT2xtbmRNYXQ2bGE0c0dBNkNhVTQ2cklvMlg4MjRz?=
 =?utf-8?B?a2ZTQ3BPenI2R0k2c1VhUW81MUNGYW01eG4wRXJJMHl0dzZPVmRLZ3NObHVC?=
 =?utf-8?B?OUFaRjdmeVhiVDhUZlEreUZRSlJvL01WS0hLRm41NTN6OCtaVERNcmlaSkN4?=
 =?utf-8?B?Y1hXcmxHRWpLbHk3UzJJNi8wcmRJUis2dWIwNGFSMUs3MFBzcEVEa3FWNjRn?=
 =?utf-8?B?WGthUkFUNmt2Mm90bVRlRW1pVDlleVQ1eklEYk1GUWVZbjNORHd0dEc1c2ZB?=
 =?utf-8?B?UFQ4SEV5QmV0ekVwblpIYW5ObU5Fc3ZVajQwOGZIZmg5c2tpL2ltSzNON1dE?=
 =?utf-8?B?OEtjK0hkYm1nMXZaT3A4VHNLUzFCdEZBZW9pNGtERW5jMVh6eWtxUmNvdXlF?=
 =?utf-8?B?UGdHdk1BeStGblhWUWNudXFQOGVnQmd2aGI4cEFHK2xhcTJGOFc5T1k2MUlQ?=
 =?utf-8?B?YTRBWFVORXBsTXlsSFB3MjQwT1EydW9NZ1ROYVFsY29HRTJNNXZMQT09?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 58bab91d-0b1b-4271-95c8-08de97c8edf3
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2026 12:50:37.4093
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MZ/L9268K8KdNxqW/w2XpHPuovTPQ5WlzGqgwsc+oug/e/Kzavkrz6BEOGC43R3nMRXp89LGBqA8/dcCJ23uU7uoBccCGz7GXFHeDSz1idc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB7020
X-Spamd-Result: default: False [2.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[renesas.com,none];
	R_DKIM_ALLOW(-0.20)[bp.renesas.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	TAGGED_FROM(0.00)[bounces-10002-lists,dmaengine=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.999];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[renesas.com:email,TY3PR01MB11346.jpnprd01.prod.outlook.com:mid,tuxon.dev:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,bp.renesas.com:dkim]
X-Rspamd-Queue-Id: 8E7ED3DFFA0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

SGkgQ2xhdWRpdSwNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBDbGF1
ZGl1IEJlem5lYSA8Y2xhdWRpdS5iZXpuZWFAdHV4b24uZGV2Pg0KPiBTZW50OiAxMSBBcHJpbCAy
MDI2IDEzOjM5DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjQgMDcvMTddIGRtYWVuZ2luZTogc2g6
IHJ6LWRtYWM6IFNhdmUgdGhlIHN0YXJ0IExNIGRlc2NyaXB0b3INCj4gDQo+IA0KPiANCj4gT24g
NC8xMS8yNiAxNTozNCwgQmlqdSBEYXMgd3JvdGU6DQo+ID4gSGkgQ2xhdWRpdSwNCj4gPg0KPiA+
PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+PiBGcm9tOiBDbGF1ZGl1IDxjbGF1ZGl1
LmJlem5lYUB0dXhvbi5kZXY+DQo+ID4+IFNlbnQ6IDExIEFwcmlsIDIwMjYgMTI6NDMNCj4gPj4g
U3ViamVjdDogW1BBVENIIHY0IDA3LzE3XSBkbWFlbmdpbmU6IHNoOiByei1kbWFjOiBTYXZlIHRo
ZSBzdGFydCBMTQ0KPiA+PiBkZXNjcmlwdG9yDQo+ID4+DQo+ID4+IEZyb206IENsYXVkaXUgQmV6
bmVhIDxjbGF1ZGl1LmJlem5lYS51akBicC5yZW5lc2FzLmNvbT4NCj4gPj4NCj4gPj4gU2F2ZSB0
aGUgc3RhcnQgTE0gZGVzY3JpcHRvciB0byBhdm9pZCBsb29waW5nIHRocm91Z2ggdGhlIGVudGly
ZQ0KPiA+PiBjaGFubmVsJ3MgTE0gZGVzY3JpcHRvciBsaXN0IHdoZW4gY29tcHV0aW5nIHRoZSBy
ZXNpZHVlLiBUaGlzIGF2b2lkcyB1bm5lY2Vzc2FyeSBpdGVyYXRpb25zLg0KPiA+Pg0KPiA+PiBT
aWduZWQtb2ZmLWJ5OiBDbGF1ZGl1IEJlem5lYSA8Y2xhdWRpdS5iZXpuZWEudWpAYnAucmVuZXNh
cy5jb20+DQo+ID4+IC0tLQ0KPiA+Pg0KPiA+PiBDaGFuZ2VzIGluIHY0Og0KPiA+PiAtIG5vbmUN
Cj4gPj4NCj4gPj4gQ2hhbmdlcyBpbiB2MzoNCj4gPj4gLSBub25lLCB0aGlzIHBhdGNoIGlzIG5l
dw0KPiA+Pg0KPiA+PiAgIGRyaXZlcnMvZG1hL3NoL3J6LWRtYWMuYyB8IDExICsrKysrKysrLS0t
DQo+ID4+ICAgMSBmaWxlIGNoYW5nZWQsIDggaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkN
Cj4gPj4NCj4gPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZG1hL3NoL3J6LWRtYWMuYyBiL2RyaXZl
cnMvZG1hL3NoL3J6LWRtYWMuYw0KPiA+PiBpbmRleCA2YmVhN2M4YzcwNTMuLjBmODcxYzBhMjhi
ZA0KPiA+PiAxMDA2NDQNCj4gPj4gLS0tIGEvZHJpdmVycy9kbWEvc2gvcnotZG1hYy5jDQo+ID4+
ICsrKyBiL2RyaXZlcnMvZG1hL3NoL3J6LWRtYWMuYw0KPiA+PiBAQCAtNTgsNiArNTgsNyBAQCBz
dHJ1Y3QgcnpfZG1hY19kZXNjIHsNCj4gPj4gICAJLyogRm9yIHNsYXZlIHNnICovDQo+ID4+ICAg
CXN0cnVjdCBzY2F0dGVybGlzdCAqc2c7DQo+ID4+ICAgCXVuc2lnbmVkIGludCBzZ2NvdW50Ow0K
PiA+PiArCXN0cnVjdCByel9sbWRlc2MgKnN0YXJ0X2xtZGVzYzsNCj4gPj4gICB9Ow0KPiA+Pg0K
PiA+PiAgICNkZWZpbmUgdG9fcnpfZG1hY19kZXNjKGQpCWNvbnRhaW5lcl9vZihkLCBzdHJ1Y3Qg
cnpfZG1hY19kZXNjLCB2ZCkNCj4gPj4gQEAgLTM0Myw2ICszNDQsOCBAQCBzdGF0aWMgdm9pZCBy
el9kbWFjX3ByZXBhcmVfZGVzY19mb3JfbWVtY3B5KHN0cnVjdCByel9kbWFjX2NoYW4gKmNoYW5u
ZWwpDQo+ID4+ICAgCXN0cnVjdCByel9kbWFjX2Rlc2MgKmQgPSBjaGFubmVsLT5kZXNjOw0KPiA+
PiAgIAl1MzIgY2hjZmcgPSBDSENGR19NRU1fQ09QWTsNCj4gPj4NCj4gPj4gKwlkLT5zdGFydF9s
bWRlc2MgPSBsbWRlc2M7DQo+ID4+ICsNCj4gPj4gICAJLyogcHJlcGFyZSBkZXNjcmlwdG9yICov
DQo+ID4+ICAgCWxtZGVzYy0+c2EgPSBkLT5zcmM7DQo+ID4+ICAgCWxtZGVzYy0+ZGEgPSBkLT5k
ZXN0Ow0KPiA+PiBAQCAtMzc3LDYgKzM4MCw3IEBAIHN0YXRpYyB2b2lkIHJ6X2RtYWNfcHJlcGFy
ZV9kZXNjc19mb3Jfc2xhdmVfc2coc3RydWN0IHJ6X2RtYWNfY2hhbiAqY2hhbm5lbCkNCj4gPj4g
ICAJfQ0KPiA+Pg0KPiA+PiAgIAlsbWRlc2MgPSBjaGFubmVsLT5sbWRlc2MudGFpbDsNCj4gPj4g
KwlkLT5zdGFydF9sbWRlc2MgPSBsbWRlc2M7DQo+ID4+DQo+ID4+ICAgCWZvciAoaSA9IDAsIHNn
ID0gc2dsOyBpIDwgc2dfbGVuOyBpKyssIHNnID0gc2dfbmV4dChzZykpIHsNCj4gPj4gICAJCWlm
IChkLT5kaXJlY3Rpb24gPT0gRE1BX0RFVl9UT19NRU0pIHsgQEAgLTY5Myw5ICs2OTcsMTAgQEAN
Cj4gPj4gcnpfZG1hY19nZXRfbmV4dF9sbWRlc2Moc3RydWN0IHJ6X2xtZGVzYyAqYmFzZSwgc3Ry
dWN0IHJ6X2xtZGVzYyAqbG1kZXNjKQ0KPiA+PiAgIAlyZXR1cm4gbmV4dDsNCj4gPj4gICB9DQo+
ID4+DQo+ID4+IC1zdGF0aWMgdTMyIHJ6X2RtYWNfY2FsY3VsYXRlX3Jlc2lkdWVfYnl0ZXNfaW5f
dmQoc3RydWN0IHJ6X2RtYWNfY2hhbg0KPiA+PiAqY2hhbm5lbCwgdTMyIGNybGEpDQo+ID4+ICtz
dGF0aWMgdTMyIHJ6X2RtYWNfY2FsY3VsYXRlX3Jlc2lkdWVfYnl0ZXNfaW5fdmQoc3RydWN0IHJ6
X2RtYWNfY2hhbiAqY2hhbm5lbCwNCj4gPj4gKwkJCQkJCSBzdHJ1Y3QgcnpfZG1hY19kZXNjICpk
ZXNjLCB1MzIgY3JsYSkNCj4gPg0KPiA+IFUzMiBub3JtYWxseSB1c2VkIHdpdGggcmVnaXN0ZXIg
cmVhZC93cml0ZXMgaGFyZHdhcmUgcmVsYXRlZC4NCj4gPg0KPiA+IEhlcmUgaXQgaXMganVzdCBj
b21wdXRhdGlvbiB3aGljaCByZXR1cm5zIG51bWJlciBvZiBieXRlcy4gVW5zaWduZWQNCj4gPiBp
bnQgd2lsbCBiZSBhcHByb3ByaWF0ZSBpbnN0ZWFkIG9mIHUzMi4NCj4gDQo+IFBsZWFzZSBjaGVj
ayB0aGUgdHlwZSBvZiByZXNpZHVlIGFzIGRlZmluZWQgYnkgZG1hX3NldF9yZXNpZHVlKCkuDQoN
Ck15IGNvbW1lbnQgaXMgYmFzZWQgb24gWzFdDQoNClsxXSBodHRwczovL2xvcmUua2VybmVsLm9y
Zy9hbGwvODdvNmtpbHdkNS5mZnNAdGdseC8NCg0KQ2hlZXJzLA0KQmlqdQ0K

