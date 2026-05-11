Return-Path: <dmaengine+bounces-10331-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6LLfEYZEAmofpwEAu9opvQ
	(envelope-from <dmaengine+bounces-10331-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 11 May 2026 23:05:10 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A407051619D
	for <lists+dmaengine@lfdr.de>; Mon, 11 May 2026 23:05:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 47C6F30276BF
	for <lists+dmaengine@lfdr.de>; Mon, 11 May 2026 21:04:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2E84401A01;
	Mon, 11 May 2026 21:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="wSAXakZC"
X-Original-To: dmaengine@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010049.outbound.protection.outlook.com [52.101.229.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B351634AB14;
	Mon, 11 May 2026 21:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778533468; cv=fail; b=WT0kR/8n4JsUjXm5vTuSE8M+bbDSl8HD/MlOhSVgA3maBI9Djkt79Y5RtA2Srvr/ufDmtlHvK2q2gligdB8jH6KtL5DKZyzEr5V8jxwgV7B18s68opTR/lYtoRoC23Cx9kVm0ajegtJAaHyishK5ZJrENhlLxByeHms38djfo3o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778533468; c=relaxed/simple;
	bh=1aLb05XW/VzaAyOZ1iiSFxz+t2fegUvaXfPcYE4rp+4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jvGV7c8rv3gL4v8xAiec3CmuXgRea3TQJdic1D70mX80GzMqIr905anPRZronUW1vwOjOMDIp/fJtn2sLizWYX4szTJlnPmvU0UzD5hTOmf/uuXY+Q31SZz0bdrmZ1UEu4a3P1mngIJypCAfOklQaNx3Ss1TSIsrpRW+kGraJHg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=wSAXakZC; arc=fail smtp.client-ip=52.101.229.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EuuAb3g5gQv/RdQ61jKOnpa3X6s0N+NKBh/JspwtPgvQ5FOH8Dax4xvbQFpbP8G0DVGgoFi44VXLZKTb6+lpKSuoB7zJdSoSKod0ySPZlxBxmwNKFI8oIVHVlttfP2tbVpiKybauvKLhlE2mMfN6yjMvI92tU+FOEnB4BPcV+hlFTd1eSN7XxNIzk4C4hDTXvkojF68dhOllMvYG6KZJA3gtrGn21gCFYLYTLrUKeRRYN/XxsaZI6StBnpbGr+T46eognPnn+9NY0wA8PxHjzDI0IRcTs6qROqGj//XqeccgJuWuGYR1vuoetLqUE5LXfCnW9z8JnagRq+PvoqvfLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UUMDhzuYkBYPS/OY5OfWnr2IcdDlWWYcNVmTwRhF7rM=;
 b=aqG09N1EFuIGKdEhielMEoOui6LB/WFR+eVjJYgMpsxr0X1qa+gp9tyGQplmNzktrXdvvCqjn/lh4uvJykgH/llhNho1OEN2upo0qhtK/j76Lt0gPiTgiODtfuttN9gw/BiRtgkV/gNQmbuDF/xqs4/bMf3gOcpfy//DO7uXVZrwDOHoQOl+6teBXIB1ztJvk25tJnJ0eRmBKKBJPoXho6BbWRIbt7BvJOIgn1RbM5mrtShCw4kvkAsYlWdVi13S2tdC6ZPdcS9FmWXsARHnejHZVUZDcteAt4k3HvRs1ouFzCyLQ4D9RqOOSfsbwx8w35+BR1N73d4O6N170rSxXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UUMDhzuYkBYPS/OY5OfWnr2IcdDlWWYcNVmTwRhF7rM=;
 b=wSAXakZCQFV5R7t18cKBDYzFwbjPwUhF04HfSgi+90OXN5YtEMYMuxV/hVV/c7Na6MJYdoIOomRQoJP5gl1WN4evpLqQP3i6cmP1N6Zih1zuDAlsdmVBwUDeAxQMIdIbtSlHJlf7EIEsEBh9QBbegX9PAn78LhKf8hSUeA/HEVY=
Received: from TY6PR01MB17377.jpnprd01.prod.outlook.com (2603:1096:405:35b::6)
 by TY4PR01MB12838.jpnprd01.prod.outlook.com (2603:1096:405:1ea::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Mon, 11 May
 2026 21:04:23 +0000
Received: from TY6PR01MB17377.jpnprd01.prod.outlook.com
 ([fe80::f373:26d6:86c4:6aa3]) by TY6PR01MB17377.jpnprd01.prod.outlook.com
 ([fe80::f373:26d6:86c4:6aa3%6]) with mapi id 15.20.9891.021; Mon, 11 May 2026
 21:04:23 +0000
From: John Madieu <john.madieu.xa@bp.renesas.com>
To: Frank Li <Frank.li@nxp.com>
CC: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, Thomas
 Gleixner <tglx@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, Claudiu.Beznea
	<claudiu.beznea@tuxon.dev>, Biju Das <biju.das.jz@bp.renesas.com>, Prabhakar
 Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>, Cosmin-Gabriel
 Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>, "john.madieu@gmail.com"
	<john.madieu@gmail.com>, "linux-renesas-soc@vger.kernel.org"
	<linux-renesas-soc@vger.kernel.org>, "dmaengine@vger.kernel.org"
	<dmaengine@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCh v3 2/2] dma: sh: rz-dmac: Add DMA ACK signal routing
 support
Thread-Topic: [PATCh v3 2/2] dma: sh: rz-dmac: Add DMA ACK signal routing
 support
Thread-Index: AQHcwrz7giR0TZZcU0CxiqXIcEVt7LYDHuiAgAYkrZCAAD5JAIAAA1yw
Date: Mon, 11 May 2026 21:04:23 +0000
Message-ID:
 <TY6PR01MB1737759B647287B8602EF727AFF382@TY6PR01MB17377.jpnprd01.prod.outlook.com>
References: <20260402162212.12016-1-john.madieu.xa@bp.renesas.com>
 <20260402162212.12016-3-john.madieu.xa@bp.renesas.com>
 <afzep7hF8uj-jRhc@lizhi-Precision-Tower-5810>
 <TY6PR01MB17377AEC612CA33F43C1F4A8EFF382@TY6PR01MB17377.jpnprd01.prod.outlook.com>
 <agI6KFUOMxZ1Upfm@lizhi-Precision-Tower-5810>
In-Reply-To: <agI6KFUOMxZ1Upfm@lizhi-Precision-Tower-5810>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY6PR01MB17377:EE_|TY4PR01MB12838:EE_
x-ms-office365-filtering-correlation-id: f0537800-2300-426c-8439-08deafa0e0eb
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|18002099003|11063799003|22082099003|56012099003|38070700021;
x-microsoft-antispam-message-info:
 TeofumIUh9X4iWJ0KT0C/i12imEQRAaRxZGvqzTmFkWEUxGtc/wl8r6N07hhNfUXypQJ1bhH3hPtCVYSqf7Mxzbm5ejbuW+1evZEZVxLnJ75PpCRwrCjJG8dlo0bAIinWHWJE8mHUEdX0vnYn5jpj3u5gMa0Uk2x85+62t5ka5B6Vl/PEUt+QSzxkCo7fYtxE98Z4TFkOMteHMYEIDonIuCdyqbv/ycQ7V94JlZJZvdhIkp7KztFaAkSQFhC/fIUxirhwV5GeyTyqq0vhm9ec3FThNm1br9gcG6OXpvapyGRUZw0YP8o4poaq4SZ1cdTz37AWNU3KkiWAxpuIlre5Gmv1cQmMdm9Y3vJbK2STdMPO3itqwLpFFJdY6x57Br3xmXJrm3Ai6V1eBTkiPZTsVjNKx8k4FVMvOkoaiMGvFG5DyxVLg0byq0N48QVvg/VxCOdgDVcNJ8Ju2h3CQzirWKz9KTdIzV8HQQxH+PJ9TwfAGLjxtQbobSCfubVG8cKTc7xGfD5Bio9kMfE2GSrzKjMc3n35keV4/A8u9c9EJg2lCxkTu3kEUghJKZWhHRnkF7lqzFy3SjaLr6mUp28QTCQguoai25rFh+ZLzcrfL92O3VdAPaQcVGlp157mHTFFbtcbdTmzvCcqRl/53KyRiN/f+ezCSDOaGifV6p5/dP3QaS76ToLf819TQjoMYKrVm4cBa8WZHxQEUNoYrkZ4FDSLs6aM6JKlvMQR+VdPWjt/z5S7EWC4mib4YKAh8Kf
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY6PR01MB17377.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(18002099003)(11063799003)(22082099003)(56012099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?a/DUMLmTY12nwt+jNA2O8khJlye4jmWZKXB2o1kGsTwB479JybuhlcLvDbte?=
 =?us-ascii?Q?zpxm2vR6pXwed//GnbxqcwwRG1MXa3Fw4yF6plbmWneYODhPXmDg77m64fe/?=
 =?us-ascii?Q?T+6HQRUFZ23pvgdz3bfg6nXuFKgTo/QOj0RSt2W7iwowHVb4V4fxyZ3c3bep?=
 =?us-ascii?Q?sxIEsj9qNuKZfyduBr9/1s7hnljzTLLSv4Cmyr+H/e84KMc3XYdXAiu85PkB?=
 =?us-ascii?Q?NUdoEi9eSqj9KgkDHztmYpbQNsGq7BXSz68jGFYoX0Rg8i3DumiEkkB+KLli?=
 =?us-ascii?Q?OuRLYfN+ootRGTC42xYqu5xIuPvAy98SFvD9sq+FJzCI8Ywee9Bf6/j7LC+L?=
 =?us-ascii?Q?gmi4WrfC53I1xmbXgLonelU4L1ALlXEdCwh8j/p9EYeBRTo5XnGAMVNIRZAc?=
 =?us-ascii?Q?PsOg9CJz0PjWkDG2d7iPBqJN9tDBU3Noa9qqXQVNQa1qH6zXFLAgxTwarijx?=
 =?us-ascii?Q?xtb+QGHG1O1a98nTuklPfwf06GGydXScv46IgsmQMVlUcGynOODBHeIz81SY?=
 =?us-ascii?Q?PuZh73NMfDa7rNfuPiS0J7zml514Wstt0aFWevVQ2x0yUDJcbUdDxwe1Jma1?=
 =?us-ascii?Q?OcIq83uLdxDJbCgLTojTW/GKVROVToEJOsd7tNfwhPfcLKgI0zqNNiuw0Ziu?=
 =?us-ascii?Q?K0ZAt7TLb9SqjhOGRGTSv8gkJfDjCwB5rrvw3zUxyRvCPwTMdmFhbUcsELNy?=
 =?us-ascii?Q?he6zTz2ArkTB9NHY4tEob/9ZnAgdX6al0JEOKqHYzRFnp5e4YxbWdK/j4Raa?=
 =?us-ascii?Q?4SQ2WScvhewj+Nh33ou/Ual4lVKJBe02YThr3vJZur3gwtxiei0IYIHYAmnn?=
 =?us-ascii?Q?VpV6aZSEhWQA11tZjT4R9Oqmusy80aNpBuXlxlJ87LCKCJxn1CoPRQcVvLd4?=
 =?us-ascii?Q?iSAt5Be7Xqu5Z6xRz0ca8+7KIzssMsTzMh0X7i6R/VKmTj9S7ZGpidWs9UBm?=
 =?us-ascii?Q?VxeGDEP3c1Otd9I6z5O/d1akdJGhokmf9huZcjP2D/BePgMMLfFqX028EOc9?=
 =?us-ascii?Q?Smu+8xfscqNk5eyFUdTBZqSZZKdpqxsYfERQ2UYjEqDo87hcwlLjM92/qmeY?=
 =?us-ascii?Q?dNBM1gBQC52uoW+eEg8PSppnrjCLJr34/x0JLAwg9F6vAYE43Aw9ziKpbSkS?=
 =?us-ascii?Q?taDMx6RR+xMREbd5aRb21A/E9GMA5TjQZRMgzm+WOgW4gXNmgbL6PZ2Uuzkm?=
 =?us-ascii?Q?Q2D7HJ1NFoNm7Bm/RgbRa3lfdyre4QjVAptmmLQhSyNaImIIvNjx5IvsM7sO?=
 =?us-ascii?Q?2Dq1yW/Bt2W2akNlsT8wPjMdn9Ef/I8kjk4gxJ/+buZrVYdBwAN2qSEysNMr?=
 =?us-ascii?Q?AViE02P8JJApCL2pkJPDHk0ZwHyh7mrlddteVxvK4mcUg+5nHqARHdcL7Moq?=
 =?us-ascii?Q?tuq+xQM17906WFtieu4rZ8D26fTYInSbEMm1N7jrnf0/46OD0patotFywqmk?=
 =?us-ascii?Q?e0oghUzMdgxsdhGeytXJ3ZaEEYBeSc5BNndNlQ5X5ZSPGT1zEswzorFIeHNJ?=
 =?us-ascii?Q?9fZGOhMFsG7a1GQPBgRlFtHiuVA7MF0G59eUY5W2tPH0SzTmCas5PhnyOxUU?=
 =?us-ascii?Q?YvrwKIDPK/bJ8MxoVJrO5yOBwYVTh+jfAYjQ/d5hMNJXPDhRN9hiwa/JMVdf?=
 =?us-ascii?Q?nXy0oURA3pZPYwxeEIJ/MPYTIcvliPIt9D6zmGPTJxkfmiikU26r2QeQ/7YQ?=
 =?us-ascii?Q?6at1sLSzEeLqDQScmEjdetlOw2Jp4gq+oTO8cL9uYBU8UHZrFu4XtVl0eJQ5?=
 =?us-ascii?Q?TbOnL6JlQ+XMgxgI6mEeWG9gNR0LRy4=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: f0537800-2300-426c-8439-08deafa0e0eb
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 May 2026 21:04:23.6305
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Eqwu+OHs6Hk6n2DO54pit7JWb9YQhZdiJLT0c4oMp65h70ejJqDLHgDV1+XlHbvhwXR+RYCFP5I6+QCtefWnBLGEbWn0tGepKbjcfbL9cMo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB12838
X-Rspamd-Queue-Id: A407051619D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[renesas.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[bp.renesas.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,glider.be,renesas.com,tuxon.dev,bp.renesas.com,gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-10331-lists,dmaengine=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[bp.renesas.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[john.madieu.xa@bp.renesas.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[dmaengine,renesas];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	REDIRECTOR_URL(0.00)[aka.ms];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bp.renesas.com:dkim,nxp.com:email,TY6PR01MB17377.jpnprd01.prod.outlook.com:mid,aka.ms:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Hi Frank,

> -----Original Message-----
> From: Frank Li <Frank.li@nxp.com>
> Sent: Montag, 11. Mai 2026 22:21
> To: John Madieu <john.madieu.xa@bp.renesas.com>
> Subject: Re: [PATCh v3 2/2] dma: sh: rz-dmac: Add DMA ACK signal routing
> support
>=20
> [You don't often get email from frank.li@nxp.com. Learn why this is
> important at https://aka.ms/LearnAboutSenderIdentification ]
>=20
> On Mon, May 11, 2026 at 05:04:46PM +0000, John Madieu wrote:
> > Hi Frank,
> >
> > thanks for your review.
> >
> > > -----Original Message-----
> > > From: Frank Li <Frank.li@nxp.com>
> > > Sent: Donnerstag, 7. Mai 2026 20:49
> > > To: John Madieu <john.madieu.xa@bp.renesas.com>
> > > Subject: Re: [PATCh v3 2/2] dma: sh: rz-dmac: Add DMA ACK signal
> > > routing support
> > >
> > >
> > > On Thu, Apr 02, 2026 at 06:22:12PM +0200, John Madieu wrote:
> > > > Some peripherals on RZ/G3E SoCs (SSIU, SPDIF, SCU/SRC, DVC, PFC)
> > > > require explicit ACK signal routing through the ICU for
> > > > level-based DMA handshaking.
> > > >
> > > > Rather than extending the DT binding with an optional second
> > > > #dma-cells (which would require all DMA consumers to supply two
> > > > cells even when ACK routing is not needed), derive the ACK signal
> > > > number directly from the MID/RID request number using the linear
> > > > mapping defined in RZ/G3E hardware manual Table 4.6-28:
> > > >
> > > >   PFC external DMA pins (DREQ0..DREQ4):
> > > >     req_no 0x000-0x004 -> ACK No. 84-88
> > > >
> > > >   SSIU BUSIFs (ssip00..ssip93):
> > > >     req_no 0x161-0x198 -> ACK No. 28-83
> > > >
> > > >   SPDIF (CH0..CH2) + SCU SRC (sr0..sr9) + DVC (cmd0..cmd1):
> > > >     req_no 0x199-0x1b4 -> ACK No. 0-27
> > > >
> > > > ACK routing is programmed when a channel is prepared for transfer
> > > > and cleared when the channel is released or the transfer times
> > > > out, following the same pattern as MID/RID request routing.
> > > >
> > > > Signed-off-by: John Madieu <john.madieu.xa@bp.renesas.com>
> > > > ---
> > > >
> > > > Changes:
> > > >
> > > > v3: No changes
> > > >
> > > > v2:
> > > >  - Drop DMA ACK second cell from DT specifier
> > > >  - Derive ACK signal number in-driver from MID/RID using
> > > > arithmetic
> > > formulas
> > > >    per ICU Table 4.6-28 (3 linear peripheral groups)
> > > >
> > > >  drivers/dma/sh/rz-dmac.c | 72
> > > > ++++++++++++++++++++++++++++++++++++++++
> > > >  1 file changed, 72 insertions(+)
> > > >
> > > >  static void rz_dmac_prepare_desc_for_memcpy(struct rz_dmac_chan
> > > > *channel)  {
> > > >       struct dma_chan *chan =3D &channel->vc.chan; @@ -431,6 +489,7
> > > > @@ static void rz_dmac_prepare_descs_for_slave_sg(struct
> > > > rz_dmac_chan
> > > *channel)
> > > >       channel->lmdesc.tail =3D lmdesc;
> > > >
> > > >       rz_dmac_set_dma_req_no(dmac, channel->index,
> > > > channel->mid_rid);
> > > > +     rz_dmac_set_dma_ack_no(dmac, channel->index,
> > > > + channel->dmac_ack);
> > >
> > > I am not familar with your hardware, why ACK folllow req immediately?
> > > suppose ACK happen after transfer done.
> >
> > rz_dmac_set_dma_ack_no() does not fire an ACK pulse, it programs a
> > static routing mux in the ICU (ICU_DMACKSELk) that selects which DMAC
> > channel is the source of the ACK line for a given peripheral. It is
> > the symmetric counterpart of ICU_DMAREQSELk programmed by
> rz_dmac_set_dma_req_no().
> >
> > Both registers must be configured before any transfer can happen on
> > the channel: the REQ mux routes the peripheral's request line into the
> > DMAC, the ACK mux routes the DMAC's acknowledge line back to the
> > peripheral. Once the routing is in place, the level-based REQ/ACK
> > handshake itself runs entirely in hardware on every burst, with no
> > driver involvement per transfer.
>=20
> Supposed these register should belong to dma-engine, but it was located
> into irq, you open a private API to irq chip drivers. Ideally these
> register ownership should move to here.

These registers belong to the ICU's MMIO region, along with the
IRQ/TINT/NMI/ECC machinery owned by the irqchip driver. The established
pattern is for the irqchip to keep ownership of the whole region and
export a small entry point for the DMA engine to call into. That pattern
was introduced by Fabrizio when the irqchip driver landed and adopted
by Cosmin when chip-specific REQ routing was added to rz-dmac [1].

>=20
> these routing mux should be in allocate channel callback, not in
> rz_dmac_prepare_descs_for_slave_sg() or in xlate function.

The prepare-path placement is also pre-existing. The new
rz_dmac_setset_dma_ack_no() call in this patch sit at the same
sites, by design, so the REQ and ACK routes share one lifecycle.

Moving the routing setup to device_alloc_chan_resources() is a
reasonable direction, but it would only make sense if REQ and ACK
move together, and it would be a refactor of existing and recently
landed [1] REQ code in the same change. Should we go this way ?

[1] https://lore.kernel.org/all/20260105114445.878262-1-cosmin-gabriel.tani=
slav.xa@renesas.com/

Regards,
John



