Return-Path: <dmaengine+bounces-9634-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8A9wEtvuwmkdnQQAu9opvQ
	(envelope-from <dmaengine+bounces-9634-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 24 Mar 2026 21:06:51 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DCA9C31C196
	for <lists+dmaengine@lfdr.de>; Tue, 24 Mar 2026 21:06:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 89B1F301D040
	for <lists+dmaengine@lfdr.de>; Tue, 24 Mar 2026 20:05:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58B913019A6;
	Tue, 24 Mar 2026 20:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="jc+5W6mo"
X-Original-To: dmaengine@vger.kernel.org
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11010065.outbound.protection.outlook.com [52.101.228.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B755417B418;
	Tue, 24 Mar 2026 20:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774382700; cv=fail; b=UNJPoSToyWjX4WkYKUzmO0bluxVG5Kdv/vgom0ESutoyhDW/N/uKft9cBQpete29Y7xdi/Km8f+I0Wzs1jec8dmL8bL2M9lKdZtwiXsA7egqygjlrMYystoyfbu4GxAUjehlamML0kDUJ4PD/JngnMpJIERYnjnyY2NKDHfLOdo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774382700; c=relaxed/simple;
	bh=GmwydfBfiY6BhduQfnFWQUqSiJ+Uzy6M2SI2BgKrFZ8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=A8ril9gRFeugN6c5cuA81Lx6ooZ2UVpJ5o5Td6hN/rHU5paK5ec+AvCFYMBrw6CQvI/PgTlSzYiJQX7dHAQb7lNVzHEwi2YspKE55Qj1q+vpTmHNEjnFbh2Ba2PMwWXW8mfrSawqp1AmGAQF5vF8pOM+GGBzwgRlk9sSOs/pJQM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=jc+5W6mo; arc=fail smtp.client-ip=52.101.228.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CKSXCIgTqq+JfAPIZH7EMNCIlSAcj+Iwpc7zsTepUEYS03fEYC8e8s0/1SH4B65UjAWwLtM5GkYazEIfb6RfuiX0skO4yrmnZ/VvEkRi7ruE7UD921nxLZyRtng647ip5WStmwdh0JZCd9fP6i4CiMPs2zRkOvw7ilbwXqnfmcWdLNioeWJdqXtp/HDZzKfpuNe0czDZyHmDaHdXom87+GmRloy3iTBJKBbPj/tV6fct9BKTcKWOpWcUyK+EgRHXZhlJUek0ngGMk4vC3Xcwiits9BuyrPH/NVOkxDGfWUdbJhaznID7U/CyYf0hUrsCNHIgcoSJJs1V4mgta/57jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xbPmvkXGRhNRN7zV8VSptWMQSsBgwdV2DTsiJgf6wk0=;
 b=pYHRCzu7+KFq5glwsQNoyNcnrOpEvRiBhCGbQbC6BXm2eLR0LKP3HwkZ8Ns1U6souChp6wCZtcHOzG8TbMtatICJy3mhOaCW5ZmFyyNLX4edALK/ePcBqyht5bzz4qLd1zqz4o+lRXwCdfF1T5wcslRdwy+tojni94Tq9zCdzf1HNPr4WltYal3Y2wKtTVV7QdmAQPyw99al/oRSA7WrUVDjfzl9/cNruEaoIPY0dEuO205lnk6XO1zwDW4zDA0csj5WFSSw+A/ecWP+c3n8q7OT6oe6wcsOXBeFeyrQ6p/FC9d/DMR9kGO78oFfUYZp7Q64IZaLZqEZW9Gof5x2WQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xbPmvkXGRhNRN7zV8VSptWMQSsBgwdV2DTsiJgf6wk0=;
 b=jc+5W6moXnHLz4lfVCacqeAOOrO/vqmi7DuH/4jgywccNfCS8+vDsXnBDuC6AiG0e8dpLfzdWN4SOvrOZL1JLgqS5Ksdpq/y1j9IvSv1zu1508ZhscMu+yFS9HJjsGFJ1ZahmEAXC8yOp//mQibwIe3zTx9IcBqHTexrScuAqP8=
Received: from TY6PR01MB17377.jpnprd01.prod.outlook.com (2603:1096:405:35b::6)
 by OS7PR01MB16983.jpnprd01.prod.outlook.com (2603:1096:604:422::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.31; Tue, 24 Mar
 2026 20:04:54 +0000
Received: from TY6PR01MB17377.jpnprd01.prod.outlook.com
 ([fe80::f373:26d6:86c4:6aa3]) by TY6PR01MB17377.jpnprd01.prod.outlook.com
 ([fe80::f373:26d6:86c4:6aa3%4]) with mapi id 15.20.9723.030; Tue, 24 Mar 2026
 20:04:54 +0000
From: John Madieu <john.madieu.xa@bp.renesas.com>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
CC: Geert Uytterhoeven <geert+renesas@glider.be>, Vinod Koul
	<vkoul@kernel.org>, Mark Brown <broonie@kernel.org>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Michael
 Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Frank Li <Frank.Li@kernel.org>, Liam Girdwood
	<lgirdwood@gmail.com>, magnus.damm <magnus.damm@gmail.com>, Thomas Gleixner
	<tglx@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai
	<tiwai@suse.com>, Philipp Zabel <p.zabel@pengutronix.de>, Claudiu.Beznea
	<claudiu.beznea@tuxon.dev>, Biju Das <biju.das.jz@bp.renesas.com>, Fabrizio
 Castro <fabrizio.castro.jz@renesas.com>, Prabhakar Mahadev Lad
	<prabhakar.mahadev-lad.rj@bp.renesas.com>, John Madieu
	<john.madieu@gmail.com>, "linux-renesas-soc@vger.kernel.org"
	<linux-renesas-soc@vger.kernel.org>, "linux-clk@vger.kernel.org"
	<linux-clk@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "dmaengine@vger.kernel.org"
	<dmaengine@vger.kernel.org>, "linux-sound@vger.kernel.org"
	<linux-sound@vger.kernel.org>
Subject: RE: [PATCH 11/22] ASoC: rsnd: ssui: Add RZ/G3E SSIU BUSIF support
Thread-Topic: [PATCH 11/22] ASoC: rsnd: ssui: Add RZ/G3E SSIU BUSIF support
Thread-Index: AQHct7jujd1UA/ODP06Azd/zfz0kprW7cbgAgAKpWPA=
Date: Tue, 24 Mar 2026 20:04:54 +0000
Message-ID:
 <TY6PR01MB1737712A0D0415CF57C759D2EFF48A@TY6PR01MB17377.jpnprd01.prod.outlook.com>
References: <20260319155334.51278-1-john.madieu.xa@bp.renesas.com>
	<20260319155334.51278-12-john.madieu.xa@bp.renesas.com>
 <871phb9ruc.wl-kuninori.morimoto.gx@renesas.com>
In-Reply-To: <871phb9ruc.wl-kuninori.morimoto.gx@renesas.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY6PR01MB17377:EE_|OS7PR01MB16983:EE_
x-ms-office365-filtering-correlation-id: 8085006a-e7ed-4b0c-f255-08de89e09dd1
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|376014|1800799024|22082099003|18002099003|56012099003|38070700021;
x-microsoft-antispam-message-info:
 R1baIXYst8/E5uqT8ATnaZ/hATPFAriIhC9tf+pTWWl25cIJABGDo5r/+xmbQTD5e8cBz1wHeFc2RdIwJtnNjsarT+JJ9EZYc+/6sBLBPxe+aA585z5Lp4VpNGqfdyDgVfn3yX777LZZOcYV2V45c254Vq0hsLBFeO9mPbdtcz0yHekmTAWrBEYT+ziOAcDhcbRjuEqmb3wrFlPibbCaxCDTteTEEyrOcVZn5WLcqn0h3uqN5ehFGEOMTS9fi1QQa7cgG5aL+n4xcbUbRlaFWWwmZRuRcY5uV/TVEtAy6B4gxbgSh0okcPruvxwtW2sGRGz/nYMcNUH84yyGOlR23KzQXpM/RVV/gx1JMXTC0MThJT3kKT5yIlvpyYnP9UxVhm9FMVRe117XulJlX2Nc8KzDmx25RL1WanP3Z/v1DXg0Gm/Z6jlx+oAQW3GUU164iS7SPE5X9qhZZB1lUdRznAJhT1duJjU98JeTn23AJGSo04iTq5sA6oZZteFZJSVc9BHQndIYehB035fgQjXze8dQVY7Z+xKyuZj5mZcslG4eTsm9qXOjgcLVH3KYf3XoFRrBoFN/Fe8KAEcCxXd6jyQarGiVnztGRJWlTCtMbEbtUPm4MvER6xO5gw9m7cFEtMv2WQvazm/uHqXtq+xC5NVdQPz5EGuLIP96gzIirBzYU9UrnNt75NMbdmza0UnxaZmleY9uSs7ePwZk3J3JJBaNFJ1kcrJZ46vPprlqiCDyKZQ9n5q4/5oHP1boQvBelVW3xLNgShD15Asvm8XcfXSbafbMib89qDf/W/HHlb0=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY6PR01MB17377.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(22082099003)(18002099003)(56012099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?2+SCCyDCSeveQP2XZxwUcCNB6RHGxS2h/FIjVU4riS664xPUdWG6Xevc5jc6?=
 =?us-ascii?Q?VNz2xvCZifFFRfo15bChG1L3MBskpmx8iOn14aMpdKpLorogwTLRh8s1RglH?=
 =?us-ascii?Q?m55GCgYZ32JVUZvSJF4RQ7H3C7HYHGfbU9UpvQo6Hmdr7KoPXW153SRe7Gxq?=
 =?us-ascii?Q?IWHeBv5T4DW8N728Zsl2K1xsfMNWWArLFtRyIBbWJqFXRdhK1mo9tFUJ9vU0?=
 =?us-ascii?Q?xdLKd88yNvyltckXbZfkFvxfTGeDyhoQyNF5Loo2no4hG7Vg3bE80iKl8BBU?=
 =?us-ascii?Q?M/y/oK/w5T+UA/ZhTyhE6ckgzPczzdIoyZ12ut+1Vjo3guGwcjEX6Dsv7bJB?=
 =?us-ascii?Q?W7wv3fMRZdDETtPrrouzqtkOvqTF+f5kSNaFW41qBfVMKw5mps3re0lghNMh?=
 =?us-ascii?Q?tjbOgw9AF0kw6Q7Upti829nF9/dQrZQObPEQwIZIT1HOAR26Kle8rUfQi3pD?=
 =?us-ascii?Q?TPxJ+80yUHyAjs8yRgvsn/gdxdFRzmJQHp07HAR+XoYLnpOfWLeByNfUO72p?=
 =?us-ascii?Q?JYkXbDmtKBqXsn0j43sSUlGMDSM4qjjWQfthQ57tBAAGDBXmgVC6msIjckR+?=
 =?us-ascii?Q?cpjg3AYXa4N6nNxitxvQBAsSoF0mHXfhVcBQIE2fQmKWyIo9+7gx2XGwK3Gp?=
 =?us-ascii?Q?ViA47JBQgNeC1bv621I/oSvzF8apXWOhz6Ah/wuH0b0GrUtdh75MOPYgwKkl?=
 =?us-ascii?Q?rVgyKiC38ljRBX2RpUgSB6RtRPa8CBZ6uRLl2jDI6NZq2fi71l2PtqiEkNLX?=
 =?us-ascii?Q?AvyXRBjy+ZJwNqX7xfSiYgvgrP/1OEA8GiAvdJIO5pUvc3jXvMkwiJilEk6k?=
 =?us-ascii?Q?QtZVRaqPhedKw7m6RX7Kld7agPJV5wdwZFIxRe/V3boDVVrsdxh1TVjc1KbB?=
 =?us-ascii?Q?0mNTNJU2K8rnVNSX+lSgu1K43nmOAwHlzyPVT4qv5x1Y9ihjPc9Pn0xf1kuE?=
 =?us-ascii?Q?ap1wDT8KaNxeYzWNa4UxkvzE6huc/9wwCCTEsnnwsatK8Lf3SJmkG7SJ247F?=
 =?us-ascii?Q?M21n4B0twAEFJ0DM3rjZoq1o3w0lVIxJ58g0nBfQGCd5EDcVOsA10Q31lYSs?=
 =?us-ascii?Q?gtBIXXa8r8IVSJz8UGrdr90gPGgp3qhHTaFWkXM4036B4+LiKkM3Md+ypExt?=
 =?us-ascii?Q?NUGEHYrJA+qa/1MXIoW8Msn8sCbgzGAEWneW1Y1EenkU/IFVk48HxM4CEYHo?=
 =?us-ascii?Q?NptC/J3ZsS5nD7H3GdCRt94pRSCR7CQPMDn7+c0OBcAWTx3oKIqXSrCZi19u?=
 =?us-ascii?Q?GJ4hHdELKoxKS4fLeGxY3VP3Q/+sDDIQ93mv9TPT/U5VblEGZVS8lmqFDz1w?=
 =?us-ascii?Q?ubmMI6uZlBSubCji5HhyeyZmo7iKt+plDr4FEL7LUH/sme7Boe3RTpHWIKH5?=
 =?us-ascii?Q?U0l74eAMiUu2zvFotsFwaBLzFk76H7zaIJSE+P/sWI9c4wEXUisNTQ/UBjAk?=
 =?us-ascii?Q?usRhOdPxVK5ncXxbXFgvaJsVWuK6M1bFYfGyDSFVdnn7gxDA9IbscTJX1Y5w?=
 =?us-ascii?Q?i5Pv6/iZvRixhxslMx7kxP23/wMqhGw1cwcAICGcj8R+ybqzMDn9q1Hnj+2N?=
 =?us-ascii?Q?RTWohYGZ8QpwnnUwmvG390yUus36IaiwaamHfpZy8skCCmR3oSS/WHjEumSC?=
 =?us-ascii?Q?E5UJwp8Fx1irgW9vRtikQMQNpiSoz5Yy7Mr54hG4uKjoxdKzVtWlllMO9vQg?=
 =?us-ascii?Q?ZbEKwSK/wXv203qMJASma7IFdbnWxUaEJMGfNCuNqBhGIGbbIhwPleJP1vtC?=
 =?us-ascii?Q?dBbxHGb0/HFciqrtWj9adxUr6+9Ra28=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 8085006a-e7ed-4b0c-f255-08de89e09dd1
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2026 20:04:54.6083
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qnsX/f7LobRt+r5St7NQEWU03q6fUYZdWc5T6QlijP/0wm2/EmcBwuuRxYSsaPdZgLO4cOiPScBuVQsqtrqY4w9165VKWiLV0MkqFsfkX7A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7PR01MB16983
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[renesas.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[bp.renesas.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[27];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9634-lists,dmaengine=lfdr.de];
	FREEMAIL_CC(0.00)[glider.be,kernel.org,baylibre.com,gmail.com,perex.cz,suse.com,pengutronix.de,tuxon.dev,bp.renesas.com,renesas.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[john.madieu.xa@bp.renesas.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[bp.renesas.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[dmaengine,renesas,dt];
	NEURAL_HAM(-0.00)[-1.000];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,renesas.com:email,TY6PR01MB17377.jpnprd01.prod.outlook.com:mid]
X-Rspamd-Queue-Id: DCA9C31C196
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Kuninori,

Thank you for the review.

> -----Original Message-----
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> Sent: Monday, March 23, 2026 3:56 AM
> To: John Madieu <john.madieu.xa@bp.renesas.com>
> Subject: Re: [PATCH 11/22] ASoC: rsnd: ssui: Add RZ/G3E SSIU BUSIF suppor=
t
>=20
>=20
> Hi John
>=20
> > Add support for the SSIU found on the Renesas RZ/G3E SoC, which
> > provides a different BUSIF layout compared to earlier generations:
> >
> >  - SSI0-SSI4: 4 BUSIF instances each (BUSIF0-3)
> >  - SSI5-SSI8: 1 BUSIF instance each (BUSIF0 only)
> >  - SSI9: 4 BUSIF instances (BUSIF0-3)
> >  - Total: 28 BUSIFs
> >
> > RZ/G3E also differs from Gen2/Gen3 implementations in that only two
> > pairs of BUSIF error-status registers are available instead of four,
> > and the SSI always operates in BUSIF mode with no PIO fallback.
> >
> > Rather than scattering SoC-specific checks across functional code,
> > introduce two capability flags in the match data:
> >
> >  - RSND_SSI_ALWAYS_BUSIF: the SSI has no PIO mode and always uses
> >    BUSIF. Used in rsnd_ssi_use_busif() and rsnd_ssiu_init() to skip
> >    SSI_MODE0 configuration.
> >  - RSND_SSIU_BUSIF_STATUS_COUNT_2: only two BUSIF error-status
> >    register pairs are present. Used in rsnd_ssiu_busif_err_irq_ctrl()
> >    and rsnd_ssiu_busif_err_status_clear() to limit register iteration.
> >
> > Future SoCs sharing these constraints can set the flags without
> > requiring code changes.
> >
> > Signed-off-by: John Madieu <john.madieu.xa@bp.renesas.com>
> > ---
> (snip)
> > @@ -650,6 +651,8 @@ struct rsnd_priv {
> >  #define RSND_RZG3E	(5 << 0)
> >  #define RSND_SOC_MASK	(0xFF << 4)
> >  #define RSND_SOC_E	(1 << 4) /* E1/E2/E3 */
> > +#define RSND_SSI_ALWAYS_BUSIF	BIT(12) /* SSI has no PIO mode, always
> uses BUSIF */
>=20
> I don't think we need RSND_SSI_ALWAYS_BUSIF, because PIO is used for debu=
g
> purpose when new SoC has comming.
>=20

I understand that PIO is useful as a debug fallback when bringing up new So=
Cs.
Looking at the RZ/G3E datasheet (section 8.5), SSITDR/SSIRDR exist as data
buffers in the SSI block, but they are accessible only through the DMA acce=
ss
port - not through the register access port (CPU access).

The datasheet explicitly states "PIO access (setting prohibited)" for the
BUSIF data path. This is also why the register descriptions (8.5.2.3.29-33)
list SSICR, SSISR, SSIWSR, SSIFMR, SSIFSR but no SSITDR/SSIRDR at register
access port offsets. So PIO mode (CPU reading/writing SSITDR/SSIRDR directl=
y)
is not supported by the hardware.

If we attempt PIO fallback on RZ/G3E, rsnd_ssi_pio_interrupt() would try to
access SSITDR/SSIRDR which are not mapped in the regmap, causing a failure.

So, should I keep RSND_SSI_ALWAYS_BUSIF to express this, or would you prefe=
r
a direct rsnd_is_rzg3e() check in rsnd_ssi_use_busif()? I would go for the
first option as this could be reusable on other SoCs and avoid SoC-specific
checks across functional code.

Regards,
John

>=20
> Thank you for your help !!
>=20
> Best regards
> ---
> Kuninori Morimoto

