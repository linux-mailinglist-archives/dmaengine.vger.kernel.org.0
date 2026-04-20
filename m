Return-Path: <dmaengine+bounces-10063-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iFGgMD9N5mkgugEAu9opvQ
	(envelope-from <dmaengine+bounces-10063-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 20 Apr 2026 17:58:55 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DCC642EC75
	for <lists+dmaengine@lfdr.de>; Mon, 20 Apr 2026 17:58:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2261031BEC1C
	for <lists+dmaengine@lfdr.de>; Mon, 20 Apr 2026 15:03:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CA833CB2D5;
	Mon, 20 Apr 2026 14:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="jeDi/txm"
X-Original-To: dmaengine@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011041.outbound.protection.outlook.com [40.107.74.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 245783939C9;
	Mon, 20 Apr 2026 14:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776694889; cv=fail; b=T+aUPFPhBvBt3WrWVMPLrq0hyGNU4Np267cTkFI7jlnZ6cjS+v+mQmUwwgv33Oe6RoANQMQBW3fjI9G76xTE6PrCtjEGKqOWvd9sZTttjBYGIad3CHKntmcYFiJ3FUAJE6Q96pFFf5vVV7mxk7RaqGkCxvr8rvn9r3k9U2ndlIQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776694889; c=relaxed/simple;
	bh=8rtjxtW/q567IizPEX22nVBc9Yn1ZqCNu1vEYb9ZxuQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sibncecrMTVULHHi9zTfQ/VDMsniWURaQqZdiW1EZ+KjA6pKh+yOr56bekziDXbRIBOE8eW7RK9IHw7Yw9WC+8bLoFvSCExr+8HwyioOKGXghi7g9hAIczuB3NPgv5yxfiZNrE07XhT6b7wAJ+9Da3DAiwj7hXp5p3qFeCq/QyE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=jeDi/txm; arc=fail smtp.client-ip=40.107.74.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xVIh7kKDnEZErYkvS17GIZRSL5PWW7otRxHyFF7bCWhNHnvPYfQ7MjZYN3ceIn+0/GJ95ZOxajKzgJo3bPenneeO4A6v8FBG+AQHDaJeKzCR9I6sddOd4hbxWm9ylFTb5Pk0gPy8xuUJ3DITNchs87ZELhLB59efPtOdkxE1KcxaDH3jzO4js9CXQV/OfkWhRyavCsgvlBMfCmXAFepW6+B6sBr3MNfJdywimORieZI93PamFlKSGUkK2iQewVsod8IAABo9GqLxDBVsFzKOZInCcmdauLJAvg33aUn6e7Mv70eW2MUD7wz/AdGW7ekNXvNMqmQHMCofqCg8R0nxAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8rtjxtW/q567IizPEX22nVBc9Yn1ZqCNu1vEYb9ZxuQ=;
 b=wpCBwU4mnfzvSZsvyp8cw4zE81l3LWMaXtcpapMPRFfv2mXFila3PFRKq9hSTVD05YMz+AtvO1T8YVQ8Lq1NwRDxLC4a6mN4ogaiwNZzoJIhjeiSho4e1el/hrhh4pLoWQCd1f+iVqvWOT7mayrtk6yopoxPUibBUvQseZwzZ1MOf2suMcuCGKmyQDaUQf6rYaknDLvVCtPg9Nojv7nUWW5kJSIEPojVTlPtUsohHuRskWUYYlgqXkAxoMtvI5eV7bEpbIZA0JnDVpIoNA3IYfpM1v+g/k4SVl/siVdBrJg2z8wRJTwoDs/TLkM5FmHu1gDvLumgdowkID4Ac2UdKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8rtjxtW/q567IizPEX22nVBc9Yn1ZqCNu1vEYb9ZxuQ=;
 b=jeDi/txmv52sYWTTDAOjOo04tXgQXk4Tpk10x4JRYBSAMEfTmE7PWLIMi9oLIhuU8bvivTGRT4tlbGrEPP4vkdVy+QMcn0ZA6du8DLR1nNR8YYoL7jph4ssVzub+yNpr5KQ5eOoDqj46YxtsYAIdewwzTdHb0q/Z0OFSXHPEySM=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by TY4PR01MB13013.jpnprd01.prod.outlook.com (2603:1096:405:1d7::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.33; Mon, 20 Apr
 2026 14:21:23 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de%4]) with mapi id 15.20.9818.033; Mon, 20 Apr 2026
 14:21:23 +0000
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
Thread-Index: AQHcyahv0JOFZMxUWUOJK3dra8ccorXnnqbAgABuToCAAAC6QA==
Date: Mon, 20 Apr 2026 14:21:23 +0000
Message-ID:
 <TY3PR01MB11346EBEC14B199CC0729E33C862F2@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20260411114303.2814115-1-claudiu.beznea.uj@bp.renesas.com>
 <20260411114303.2814115-15-claudiu.beznea.uj@bp.renesas.com>
 <TY3PR01MB11346C39C7EABCC7A1BC64109862F2@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <36468f41-7808-4fe3-b4bf-94eb128276fc@tuxon.dev>
In-Reply-To: <36468f41-7808-4fe3-b4bf-94eb128276fc@tuxon.dev>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|TY4PR01MB13013:EE_
x-ms-office365-filtering-correlation-id: 1a72f26f-7533-4900-83a8-08de9ee819cb
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|921020|38070700021|56012099003|22082099003|18002099003;
x-microsoft-antispam-message-info:
 BOYHkD1zBOucbpfQYMT3PsqsLz4G1YI0kpVdDeQXc6xiWYjCygE/aYOZUC7rjP/qEroaJLL1lePxCiZb5QENNKIJQRdUVvWpt0yPpNyT3E8LZJUCWLNRWyo6HuxP//Qkme6b3TcfWArIPPACjprNM3hla2PDhBgRjrLBuNKxq02IIH9PChE+Th3LzTrzL6k/hCh33dBTIH6oObmdhAix//FzWokYxA325tREGe+WxeXL41DuHtb5cGZVZmmJrwRuSIXF3oGTEmxj98974iocNk3NGwUEg0MPVYveO6fAOikHe9d2sS9rV1usOuHbuGidWCACOaTjcmni5hZ6Pjhmgo7A3Hx7V7kiLxuibPVJ9/XD9ZzuEZI8Pky0/b3A0bWaInP0DDRQOe85mEMRUmttNH/t6rIKOUKW9cVRq1Iuy6hTTsenioU9N01nEF/7E/O16PFNnG95N9CqgFLa7BEOYmchyLWJGnyqJ6FOhmXz1IA8GhUoAuCL4T6lPbeYLfT4xQpAlbNlz2jFRMByFXaKanKDWymOddpZ4nkTnhfNBoV+h+SvMt5dTGLT6kIZTX+D/4/7HAiPGGDU+kzPUJkwUhzSqHj1BJbOPGhVxXVC6TPtMW5taKRdNoHLBByd/Ln56550G13ZewT2g6uKKBibH3Bni+j9mj7MoNqHYa1ZictnSsbA0W4ur/PmLBN9Bi1oI3V1AcGSjlEhRj9oA7aBPI4ISvuP6+mf1cUqlHfBdtxMwZbYh+KCHhMTZw/1VQp6s//wM16jJ0DZZThHgJcMQdLOZBZksnJkq55sZvd0ZX0XIUyrSRAoyLIq6wdItbBQ
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(921020)(38070700021)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SStlTnc1UHorV0V4YUhSVHlrWndRRi9Pcmxub0RqUnhXd2JQQ0VtRVZNZ1d2?=
 =?utf-8?B?TkxHeUVsSHFTRnBQOUVEbUhRZHdrM0NXOHlTNFlITDN6aHY0R0lyVE4vMDhI?=
 =?utf-8?B?V3B5cktGYjNUTTRwWEpoVm5JQlZjK1c1MkhMOXR2ZEJNVVFHWlBBTlhxL21M?=
 =?utf-8?B?YlIzK3NrV1VsUDNnTythQTJtQlRWWTJwY1RRSWJMV05iMEs3bk5ReU91a3Z0?=
 =?utf-8?B?b2tqRFRqVUhuaEJOTmVzUUM4bzVZb2RNaCt6c3lzdmczdXo3QWphZHFjRUlY?=
 =?utf-8?B?YmxEaTRpZW5uaVB0dGdKaG0wRnY1bU5Gd01LWHoxNXJraGVYSlVCSXdKbVcy?=
 =?utf-8?B?TFBxakpTQXp1WkpTdTZmaWpXM1FmK0NUbXY1bEtiZHdEQjJIQU5NbE83TkJE?=
 =?utf-8?B?Uk1PVFB5YXM2ZDRENEtNUDhwYXM4cmdhbXZtUnBWaGJXSVhVYzVpK3pmZ1FL?=
 =?utf-8?B?ZVE2WDIrUlYxbWFDRHNtNVBSWlZMdWFwNUlKUWlKa1JRdWgvb0lUQnRqd0N0?=
 =?utf-8?B?UnZMeTR2WEhid2FQeG1QU0pkQklEUkcyTUJRUmhQMTg3TFRPblJSY25rMDdG?=
 =?utf-8?B?aktyaTRLWHYxbDlHYllaV25EakllM0t2QUk5TGE2RkZqR2JMS2dKa0pRZEoy?=
 =?utf-8?B?aXB4bDlJVHBCaTFZcTYrNUFncnF6djdPZVZOM0I1R2d3c04wNDRDZE9OMity?=
 =?utf-8?B?M3V0S3JvLytoTjQyWU1MbXYvTUlIM051cGxnR0RON2g0NnB3b1kxdVZxRzg4?=
 =?utf-8?B?b1NzM1J3d2xaTjZiS2Q2bS9ob2xISldxcURMYmZpV2NzeStaR09lVXBDWWRW?=
 =?utf-8?B?eWtxUjhjK0l3dFZSY2pxVEEzYStzT3NZQVY1ZkZIK1ZFN2MzRzVaMmtxUWIv?=
 =?utf-8?B?U3RkeS9QRU11QUFKcXB5b0IwRllxVm1kUDFoRWR5NWh1bzI1aHFjR25IRFRM?=
 =?utf-8?B?VGo4SS9kL0ZianVOMXVZdW5SY2dLY2ltOGJqLzBlOWp2YXRWU01PUDkwVlhL?=
 =?utf-8?B?TUQ2Q3piUWdXeDdsTm5NMkM5cTRYYk93YUE3VE5DdlgxV0hOLzc0ZjBmTGlH?=
 =?utf-8?B?U0ZlamlIb1E1TDZnUXV2WFNUbTZCZ2wxb1lJdWxCSVJlaDI5ZjcvMWVqY0VG?=
 =?utf-8?B?Wm1mYi9KK1VXRThWUzd5ME9CdG8vR01rZk0ySGJESi9DVmNyemI2bXRWZjdQ?=
 =?utf-8?B?TzB2UGhIT0VIalp1YlFhUVVManFMQTdiTENHMm1VakN0K29MNGpPeDIzd3JW?=
 =?utf-8?B?VEVXTU9TOXRnaGtZVUsxcHpPcG1XOHpDTHRWQjNJM1NFeUxqUTAxaFNzVVZj?=
 =?utf-8?B?Z0dEd2EzOFJrUVZiSjJIWkpZSG8zcTdTSkVnWE92dDJHNUpPa052eGdzdlFk?=
 =?utf-8?B?dGY2YzJDVERxWnhNNC9FeHBKWHFyZFNpcktKa3oyWUJXR296L1pPTGxRZHRP?=
 =?utf-8?B?TEpqck56U3B0bDFUckp1MlkzUUZLSjRFU3JINGJteU5KcFMxa1Y3ejJZZk9W?=
 =?utf-8?B?SzZlZEcwRDhlMTdzVUdMWDlFNHFuUkV4OEJ3ZGxUZ2lhRE5kOW1RY0NrUHB1?=
 =?utf-8?B?Uk5VR3hLSzNzNldZWGdpa0hkY0owZmFuMFVYQ3pRa3JvbGZaL2JaREhyVWF5?=
 =?utf-8?B?a3BkelNiUTlPTlFsMnpSbS9ZejdBSXRqNVRuQllWQ3hibnE2b2lXYzhxbUJw?=
 =?utf-8?B?V0lEU2I3SlRmN09kWG8rNGJpZnJuMi9XTzFaSW43aVJlaEZiUDQ2eExvU3Fm?=
 =?utf-8?B?bURFbXJ5WmdFWUM1dkJnbUF3SHdNTURwWEwrWUUycmdnVk9BbGV6V2VsSjdB?=
 =?utf-8?B?SjBITkVQanViZ2FZNkFZQmliOFlzS2EzOWVvYUtKdmJTWFMxbzQ3ZFNLaVZ2?=
 =?utf-8?B?QlZqQ2hJQTBrT3RSNDdBSmNKS2VNRFprdFlEQmVsWVg3bXFrc0VsY1BtTVdS?=
 =?utf-8?B?WDZrOGV6UXFmalNPR2pTVW5RWUNTOFpiZnVmWU9KaWtVbk16eGZpb2lxYnlX?=
 =?utf-8?B?WmlpMnJrNmR1V2M3THpoL3A4SlFGUVpaMElMblFCd1FiUHp5SG5aUWF1STNi?=
 =?utf-8?B?aVdmaURqRFVndkFMeitoMFk3d05mNkFHdksxb2M5Q1J0M2pybFN4NVZSY1lI?=
 =?utf-8?B?Qm1keUJsSTRrRCtQaHY1bWl3emxZUHhGZUR0Q0s2UzkzMzF1VHF5VFgxdDN5?=
 =?utf-8?B?SVZJK0kwRVF4ejliVWxIWjdLWFFWY0Y2Z2ZYL0J4Nm5sd0Rja2pRZjVDUyt0?=
 =?utf-8?B?eFdmRmpOZjNSZTVwZWFqUllxVUZSMVFmYWNJTmlIcVlsQWJFZUhKNkRKcmlU?=
 =?utf-8?B?UWJjR045d09ITmJySno2VlVySUlQMlZ3WlBKNXoyWEZ1Q2ZPcnZJQT09?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a72f26f-7533-4900-83a8-08de9ee819cb
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2026 14:21:23.5172
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XxQpELBOr/dN8885Sz23DAOwqFdOI6CIlZwvH0IKWKRKftYDicViHWHjvJi/ESZ9RX+WWZdpOS36RYYyQIAvOYGHxFvMLydTRQ8bmN7hprg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB13013
X-Spamd-Result: default: False [2.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[renesas.com,none];
	R_DKIM_ALLOW(-0.20)[bp.renesas.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	TAGGED_FROM(0.00)[bounces-10063-lists,dmaengine=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.991];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tuxon.dev:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3DCC642EC75
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

SGkgQ2xhdWRpdSwNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBDbGF1
ZGl1IEJlem5lYSA8Y2xhdWRpdS5iZXpuZWFAdHV4b24uZGV2Pg0KPiBTZW50OiAyMCBBcHJpbCAy
MDI2IDE1OjE1DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjQgMTQvMTddIGRtYWVuZ2luZTogc2g6
IHJ6LWRtYWM6IEFkZCBzdXNwZW5kIHRvIFJBTSBzdXBwb3J0DQo+IA0KPiANCj4gDQo+IE9uIDQv
MjAvMjYgMTA6NDIsIEJpanUgRGFzIHdyb3RlOg0KPiA+PiArc3RhdGljIGludCByel9kbWFjX3N1
c3BlbmQoc3RydWN0IGRldmljZSAqZGV2KSB7DQo+ID4+ICsJc3RydWN0IHJ6X2RtYWMgKmRtYWMg
PSBkZXZfZ2V0X2RydmRhdGEoZGV2KTsNCj4gPj4gKwlpbnQgcmV0Ow0KPiA+PiArDQo+ID4+ICsJ
Zm9yICh1bnNpZ25lZCBpbnQgaSA9IDA7IGkgPCBkbWFjLT5uX2NoYW5uZWxzOyBpKyspIHsNCj4g
Pj4gKwkJc3RydWN0IHJ6X2RtYWNfY2hhbiAqY2hhbm5lbCA9ICZkbWFjLT5jaGFubmVsc1tpXTsN
Cj4gPj4gKw0KPiA+PiArCQlndWFyZChzcGlubG9ja19pcnFzYXZlKSgmY2hhbm5lbC0+dmMubG9j
ayk7DQo+ID4+ICsNCj4gPj4gKwkJaWYgKCEoY2hhbm5lbC0+c3RhdHVzICYgQklUKFJaX0RNQUNf
Q0hBTl9TVEFUVVNfQ1lDTElDKSkpDQo+ID4+ICsJCQljb250aW51ZTsNCj4gPj4gKw0KPiA+PiAr
CQlyZXQgPSByel9kbWFjX2RldmljZV9wYXVzZV9pbnRlcm5hbChjaGFubmVsKTsNCj4gPj4gKwkJ
aWYgKHJldCkgew0KPiA+PiArCQkJZGV2X2VycihkZXYsICJGYWlsZWQgdG8gc3VzcGVuZCBjaGFu
bmVsICVzXG4iLA0KPiA+PiArCQkJCWRtYV9jaGFuX25hbWUoJmNoYW5uZWwtPnZjLmNoYW4pKTsN
Cj4gPj4gKwkJCWJyZWFrOw0KPiA+PiArCQl9DQo+ID4+ICsNCj4gPj4gKwkJY2hhbm5lbC0+cG1f
c3RhdGUubnhsYSA9IHJ6X2RtYWNfY2hfcmVhZGwoY2hhbm5lbCwgTlhMQSwgMSk7DQo+ID4+ICsJ
fQ0KPiA+PiArDQo+ID4+ICsJaWYgKHJldCkgew0KPiA+PiArCQlyel9kbWFjX3N1c3BlbmRfcmVj
b3ZlcihkbWFjKTsNCj4gPj4gKwkJcmV0dXJuIHJldDsNCj4gPj4gKwl9DQo+ID4+ICsNCj4gPj4g
KwlwbV9ydW50aW1lX3B1dF9zeW5jKGRtYWMtPmRldik7DQo+ID4+ICsNCj4gPj4gKwlyZXQgPSBy
ZXNldF9jb250cm9sX2Fzc2VydChkbWFjLT5yc3RjKTsNCj4gPj4gKwlpZiAocmV0KSB7DQo+ID4+
ICsJCXBtX3J1bnRpbWVfcmVzdW1lX2FuZF9nZXQoZG1hYy0+ZGV2KTsNCj4gPj4gKwkJcnpfZG1h
Y19zdXNwZW5kX3JlY292ZXIoZG1hYyk7DQo+ID4+ICsJfQ0KPiA+PiArDQo+ID4+ICsJcmV0dXJu
IHJldDsNCj4gPj4gK30NCj4gPj4gKw0KPiA+PiArc3RhdGljIGludCByel9kbWFjX3Jlc3VtZShz
dHJ1Y3QgZGV2aWNlICpkZXYpIHsNCj4gPj4gKwlzdHJ1Y3QgcnpfZG1hYyAqZG1hYyA9IGRldl9n
ZXRfZHJ2ZGF0YShkZXYpOw0KPiA+PiArCWludCBlcnJvcnMgPSAwLCByZXQ7DQo+ID4+ICsNCj4g
Pj4gKwlyZXQgPSByZXNldF9jb250cm9sX2RlYXNzZXJ0KGRtYWMtPnJzdGMpOw0KPiA+PiArCWlm
IChyZXQpDQo+ID4+ICsJCXJldHVybiByZXQ7DQo+ID4+ICsNCj4gPj4gKwlyZXQgPSBwbV9ydW50
aW1lX3Jlc3VtZV9hbmRfZ2V0KGRtYWMtPmRldik7DQo+ID4NCj4gPiBJZiB0aGlzIGZhaWxzIGZv
ciBhbnkgcmVhc29uLCB0aGUgbmV4dCBzdXNwZW5kIHN0aWxsIGJlIGNhbGxlZCBhbmQgaXQgd2ls
bCBkZWNyZW1lbnQgdGhlIGNvdW50ZXIsDQo+IHBvdGVudGlhbGx5IHVuZGVmbG93aW5nIGl0Lg0K
PiA+IENvbnNpZGVyIHN3aXRjaGluZyB0byBwbV9ydW50aW1lX2dldF9zeW5jKCksIHdoaWNoIHN1
aXRzIGJldHRlciBoZXJlDQo+IA0KPiANCj4gSSB0aGluayBydW50aW1lIFBNIHVzYWdlIGNvdW50
ZXIgdW5kZXJmbG93IHdpbGwgYmUgdGhlIGxlc3Mgc2lnbmlmaWNhbnQgcHJvYmxlbSBpbiBjYXNl
IHJ1bnRpbWUgUE0NCj4gZmFpbHMuDQo+IA0KPiBBbnlob3csIGNvdWxkIHlvdSBwbGVhc2UgcHJv
dmlkZSB0aGUgY29kZSBwYXR0ZXJuIHlvdSBjb25zaWRlciB3b3VsZCBiZSBiZXR0ZXIgZm9yIGJv
dGggc3VzcGVuZCBhbmQNCj4gcmVzdW1lPw0KDQoNCnN5c3RlbV9yZXN1bWUoKQ0Kew0KICAgICAg
ICAgIHBtX3J1bnRpbWVfcmVzdW1lX2FuZF9nZXQoKSAtLT4gUE0gY291bnRlciBpcyBub3QgaW5j
cmVtZW50ZWQgaW4gY2FzZSBvZiBlcnJvcg0KfQ0KIA0Kc3lzdGVtX3N1c3BlbmQoKQ0Kew0KICAg
ICAgIHBtX3J1bnRpbWVfcHV0KCkgLS0+IGNvdW50ZXIgaXMgZGVjcmVtZW50ZWQgYW5kIHByaW50
cyBhIG5vaXN5IFdBUk4gbWVzc2FnZQ0KfQ0KDQpKdXN0IHJlcGxhY2UgcG1fcnVudGltZV9yZXN1
bWVfYW5kX2dldCgpLT5wbV9ydW50aW1lX2dldF9zeW5jKCkgDQp0aGlzIHdpbGwgcmV0dXJuIHRo
ZSBlcnJvciB0byBjYWxsZXIgbGlrZSBwcmV2aW91c2x5IGFuZCBhbHNvIGluY3JlbWVudCB0aGUg
Y291bnRlcg0Kd2hpY2ggYXZvaWRzIHdhcm5pbmcgb24gdGhlIHN1YnNlcXVlbnQgc3VzcGVuZCgp
DQoNCg0KQ2hlZXJzLA0KQmlqdQ0K

