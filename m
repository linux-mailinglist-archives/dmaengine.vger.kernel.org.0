Return-Path: <dmaengine+bounces-9631-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EH6OGtPXwmllmgQAu9opvQ
	(envelope-from <dmaengine+bounces-9631-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 24 Mar 2026 19:28:35 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C043231AD33
	for <lists+dmaengine@lfdr.de>; Tue, 24 Mar 2026 19:28:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6C17730ADB83
	for <lists+dmaengine@lfdr.de>; Tue, 24 Mar 2026 18:26:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B931339656C;
	Tue, 24 Mar 2026 18:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="r34urpov"
X-Original-To: dmaengine@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011013.outbound.protection.outlook.com [40.107.74.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05FF58632B;
	Tue, 24 Mar 2026 18:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774376785; cv=fail; b=ddU2RJDu0eRbaZ+58HOXXdHMV+2Sb3sm5fdiF6xbRGQSZIbkGrXB5U3BR7BBbeY1ZP/BKKQPlONFyP0fS4OhErr4fA1Owfe1aBcTLO1t/6uC5g/FpuWXutl0y1a1zWgZd8OPxDUhrQs6W4jnBmxp2cC3dRk0i9VyL4HfQAImkD0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774376785; c=relaxed/simple;
	bh=XSYu8VvBirlRwez8GhzOnvXHkP4iicbfVKVFgU7Bk5M=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NChMB5QzKY1OgtWgRmHmJEAtFrSBPgKSmV8XEDHT0603kPDyAy1CUwfLzMoPvSJBiig0c81Q0vBMImrCY5TfY/0yR+gHVixPsBW32Z1uaU+g7kVKRGdAbdKGpB+p++q1zAJKebRbYLA6Aol1G6z+go/PzowDnheidB0IlhPpdBQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=r34urpov; arc=fail smtp.client-ip=40.107.74.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hdYSoEVBkdGfCpkot2yTzi2Ur/skH66h8zEYYp3SEYFo3OOjeij8kUxFheYpAQPD66iVb7IKfw3e+pfKXyYE33xyMXOTSTVFbNpsliqZN8zLulDRKPyV7UA4iC6YS6X9Zmxj7Qaf3BTAkDgxOY1Zr9NP0J3s3I35n4Sjl1coC4ArCr1LDewlVOvCqjjYlnK9ISFxTdFb0IJWq+z99qy8Mj0TQ1lkPbm+ni/vvgl7lwmDwgqaHvtTDedq8N6DxVGf1JzQ/PQUmj/1B1IKYgnrM1H3MVm3SODqGdZcKeaJh/6OX7A/SIk0oPFdFpXBBK/YC0LdAM1hzhZ8tMXp3R5pqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OHOBKOA31J58rcL6ID0F0J5M6aAsdgesqCyZENCS4BM=;
 b=Zv9blp//+1jvUtetKyiWQBzrRM9rk+7GfmTMTUwdFq98MyzHnVbG2zkyIE+8SbnWNo3u3BjHnoSTV8C6tGCaQ6IazS6lmhcVmPClE2Hmegf1/Mf7U8fdFfdUTzs3IWkHbrnuWmYIP6PWvryyz/jEAPYlmrMFcHybQ5dL11GpAT51yQCpdUMXKOSXi9vml7K0m9TGqySBisa6mimEtkiYSSqCzbFbJn+3kVstp/0NDYSEVVJW5MxbVlVLV21YNzFuGYGDg9GzmgERHbzaO6ft2sKGmXem4DlAbvzXGGXNbgIKaQkHqWurFzzVf2ljsgqItXRp5pqwAwF7Vm+5ZzPlig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OHOBKOA31J58rcL6ID0F0J5M6aAsdgesqCyZENCS4BM=;
 b=r34urpovsRzWq5I5UWb7dbPpJ5U4FwfdOgems3TcmiYgF8z9nr8kMzUa66hSiJEPeIFgFm5mXKCXfMTuwSoDcqBBSu7sAalLQbVpPjCbwUXMXc7b+ZmsBOiDVJl2+nAuCfY6+zSejS64PkbxkP2mxtf8kpszVIR4vyMWPZYuPtA=
Received: from TY6PR01MB17377.jpnprd01.prod.outlook.com (2603:1096:405:35b::6)
 by OSZPR01MB9280.jpnprd01.prod.outlook.com (2603:1096:604:1d0::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Tue, 24 Mar
 2026 18:26:17 +0000
Received: from TY6PR01MB17377.jpnprd01.prod.outlook.com
 ([fe80::f373:26d6:86c4:6aa3]) by TY6PR01MB17377.jpnprd01.prod.outlook.com
 ([fe80::f373:26d6:86c4:6aa3%4]) with mapi id 15.20.9723.030; Tue, 24 Mar 2026
 18:26:17 +0000
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
Subject: RE: [PATCH 14/22] ASoC: rsnd: adg: Add per-SSI ADG and SSIF supply
 clock management
Thread-Topic: [PATCH 14/22] ASoC: rsnd: adg: Add per-SSI ADG and SSIF supply
 clock management
Thread-Index: AQHct7j/u+96Kj1E9kuKhBpIJaG8BrW7XGGAgAKpGQA=
Date: Tue, 24 Mar 2026 18:26:17 +0000
Message-ID:
 <TY6PR01MB173771A2063E08EAE8F4477E0FF48A@TY6PR01MB17377.jpnprd01.prod.outlook.com>
References: <20260319155334.51278-1-john.madieu.xa@bp.renesas.com>
	<20260319155334.51278-15-john.madieu.xa@bp.renesas.com>
 <87bjgf9vdo.wl-kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87bjgf9vdo.wl-kuninori.morimoto.gx@renesas.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY6PR01MB17377:EE_|OSZPR01MB9280:EE_
x-ms-office365-filtering-correlation-id: 6dae81a3-b5f5-4bb3-6b4c-08de89d2d6d5
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|7416014|18002099003|56012099003|22082099003|38070700021;
x-microsoft-antispam-message-info:
 gnD8aXbn3vsyW09eZuuw7nfNZHsSUBMqVdUc+iIPDY9Nnm+6LCLtgKHq/zFnRGQ7fLES+5c5d87/gp61sWYx8XqR9quKNk1UiUQqQQh2UTfh7SfhzMzZ5sP6TjX32CBzz2RoSYiHmE/VaS4QqTiTKQ3ikcn7il7TSGx1s/DXGNoZKyzZop3uUZmXqKDS+7V4wZWHt2OoFn+MGi8M4Kt+vGggLwe7mGFsR4x/jYzAD6KcOpn3qs13KoQvPlnyBKBZaYxZ2PKtPgOLhVfnc0CRu2aTbBw2O9iRCq8enmbeY93xQwD74HDqLhApQnCJ9ZWcteTx6E70z4mHSGREe2EKfc0ZUIDEIedECZ7DxwJyhEG4oFNVRSkUE8XzrZPoXbNz63YXwwnyzWcoY4hnsruqqhP+p4MgGSj3O7ruRiKqWB5WnMQx+G+9JoxUqKeOREz2nhcni7vJJr883JfPJ8OG/nXPKTohfHmYQIyG26a2q5sOLum33dFRXnW0AXPWAdizBSFwGzVJPeeYsA2pNXZh/XQYc4kwZMjzdatbwyNAQo4zAwVEC6EtvFynEnxRv8t5d9no5iNYw46Iu6OoY8svzPf3HSzfV4YQQ9YndY/2kbY8DpTBSvr4AQ+3IHUVOJbnuNfxKcQUfAWD/fzxLZno6jKqC+oWfiSBlq9ErHp4IvDjTQGK7S7DJ3Fh1dIEemJoYVeR7aVSPvzXILM4f6OY50iFJ8qNglKT68wqPU+T26+R0FehiQlQYXSaKHmubN6B4Oqe3jOE8elVA+60fFW3jiC10NxxKtrpmDqyhARLr6U=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY6PR01MB17377.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014)(18002099003)(56012099003)(22082099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?k2EqV4fzIh0D2jenOezrPQzvfugzny2Xx+ABRCGeuGSOmvRfOhtuh+eaopFu?=
 =?us-ascii?Q?d1EuxQi7OYpDlKYOkXfIbba7vr7JOO3RfOP/Yc7QmpYbqiU23popjg0t8OEJ?=
 =?us-ascii?Q?cZVs3nA9ZD3kb6ZXEFoxSiI7afr0pOpXYHmPatR5zdAbswZqYan0j98+98+f?=
 =?us-ascii?Q?U2PzfY4HcuF050Akn/EVJSUrHR6UnXcklWr5VUT2JUWFOzssIpfOzuEamJ5a?=
 =?us-ascii?Q?PZm4J07+YhxKchTGuo0QrLYu6JXP8x2QVMk1yh5BdTyj5tBbSz8hk8w+fQBN?=
 =?us-ascii?Q?7RL7LqcZibb4EFTjX96lwsReRFSFBA2PXDDJZq9tUSnJupw/TIA8H/Blm3IO?=
 =?us-ascii?Q?8co1tks99MQ/6s5w51f00O1PiWT3ZtL/sc54P2QxadM2NQpmNqeEpjlZ6uDG?=
 =?us-ascii?Q?faa3zTC0e3QZKx05XcFLTjtLrgsFiss7hC9bFwSGNp+cTIUfevOYhTTzqxeQ?=
 =?us-ascii?Q?fsGK1Q3IWqPfnoXKxtgY7E8UzxZiGSbc+mW+9y43+MbGjO5cTBwZkzTxw5ie?=
 =?us-ascii?Q?csfZQ0f87b+BLASEyezU96cyBtt5sjxoFdR8SM2TBKh2tPAha3Wswl0ySi3E?=
 =?us-ascii?Q?Rj4QfwXUO7V68W+QzTrxJuTyc2A4TNWouvh3AY9YkZkG1zp8z+ctG+GXyAmm?=
 =?us-ascii?Q?z+JQ4Qrv+ftSYWPIQzRatBqwrRNOX4Zki1Q+wLhfW6+EMd8WD/ElgJyrIpc3?=
 =?us-ascii?Q?3QpAE7mAIy1SdoGLTFxcD/biK48SeLpJ5B/L9frCcy3Hv0mlj83UInQCw8VZ?=
 =?us-ascii?Q?72wBoH3LOti5AGtwIXNWMdR/haO4egywx68TPQyAX0IBQngTA+YfyBmFUO6M?=
 =?us-ascii?Q?5sbVyDnAuo/VhWzrmDrzKrzK8CU1q+A1MiLD8Z2CjnZM1//eGz65y8Ng7hbL?=
 =?us-ascii?Q?qbiULwylv4q4mLfFQ/+UfDmDk64425lQutswnUqeKXw9rwWIXN0fbFd1gIht?=
 =?us-ascii?Q?ErjyocEEfmTe72p1Pfz8LWKkkPuY5izRQaTzi/N4onDMyDaCd2B4faeeMEp+?=
 =?us-ascii?Q?tx0rKqT3Lzhq2HkhcH4xI7So1xgvHjoRRxRYoLHeWDFxBAYDCJEzRsnTpIk8?=
 =?us-ascii?Q?m520si56gXciwW3n0SDmdDaBOWXtO04iAo+HDG/wQfcudUe8qQ2odDCnx4sm?=
 =?us-ascii?Q?g8fiq/lCf9vg1HFZcADJYVbQjZn9LZyJemymxTnUIOV2ZBCgRUDNcqkmMd/r?=
 =?us-ascii?Q?N8N+/d3BWqrbWorcekNNYvpfaXq/7tdy2954Iz9S9L3in3oqeV3KoiKmQgOQ?=
 =?us-ascii?Q?7kMeXZ1nE68icb2eA5fdRW2S3yYHEjYLhRYvPO6FIddMkfsFSo9OXc2R/0on?=
 =?us-ascii?Q?pP/dt2HfUQIOWKa8CiAwxZGCboqYA7PDvtGeMM2HA9PvvJShJHxO4MKIPKFH?=
 =?us-ascii?Q?ei5VnH1QjleA68roPdBVO1F1bM8w2Bf2Ab/RcokpYAi5JtMVOIgKSyZ70VQX?=
 =?us-ascii?Q?eXTCxOfCgWRm3b5OuEHk1kimaV4W24QhCAVGyY7IvNKUC6Hf24pUdo0T3bYH?=
 =?us-ascii?Q?az5COQfnDkYtcBOIk87S/FAxLlS2+FvY5SiQHLd3CT5QIKBNvvTg9RwcjLag?=
 =?us-ascii?Q?my/pc+PgO9dSnB2DilV7dWU4e/y0ZSGegtfUQjE5Fu1u0VPkUScW7dLbhs1s?=
 =?us-ascii?Q?6zFVdZsJvkEe1R2lN9G1N9AGB7Vwk0077L9+T9OdBo0msiDy5nqDeGRTP4x+?=
 =?us-ascii?Q?UFQjJNtVWXvs3X+te/XDGplgeMMg1suqyUc2WPmSR7zXTsOAEfrNzS+x1Ubq?=
 =?us-ascii?Q?MSBBYx8c6O0DdUEQH95dPJoNPo4hs0c=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 6dae81a3-b5f5-4bb3-6b4c-08de89d2d6d5
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2026 18:26:17.3185
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ygMWWkyRR3hXIieD6TCyOGicYCz4pzWl71siG2xChqfIs7rRE/YxohsrmEIL9fAI3VTspXecRS92+pbI3HGtYdQC7L5buoHdhs4gqApsI5g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB9280
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[renesas.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[bp.renesas.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[27];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9631-lists,dmaengine=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,TY6PR01MB17377.jpnprd01.prod.outlook.com:mid,renesas.com:email,bp.renesas.com:dkim]
X-Rspamd-Queue-Id: C043231AD33
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Kuninori,

Thank you for the review.

> -----Original Message-----
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> Sent: Monday, March 23, 2026 2:40 AM
> To: John Madieu <john.madieu.xa@bp.renesas.com>
> Subject: Re: [PATCH 14/22] ASoC: rsnd: adg: Add per-SSI ADG and SSIF
> supply clock management
>=20
>=20
> Hi John
>=20
> > RZ/G3E's ADG module requires explicit clock management for SSI audio
> > interfaces that differs from R-Car Gen2/Gen3/Gen4:
> >
> >  - Per-SSI ADG clocks (adg.ssi.N) for each SSI module
> >  - A shared SSIF supply clock for the SSI subsystem
> >
> > These clocks are acquired using optional APIs, making them transparent
> > to platforms that do not require them.
> >
> > Additionally, since rsnd_adg_ssi_clk_try_start() is called from the
> > trigger path (atomic context), clk_prepare_enable() cannot be used
> > directly as clk_prepare() may sleep. Split clock handling into:
> >
> >  - hw_params: clk_prepare() - sleepable context
> >  - trigger (start): clk_enable() - atomic safe
> >  - trigger (stop): clk_disable() - atomic safe
> >  - hw_free: clk_unprepare() - sleepable context
> >
> > Signed-off-by: John Madieu <john.madieu.xa@bp.renesas.com>
> > ---
>=20
> In this patch, it adds RZ/G3E specific params, and use it on common
> function without checking whether it is R-Car or RZ, or whether it has
> param or not.
> Is it keep compatible on R-Car ?

Yes - all clocks are acquired using devm_clk_get_optional(), which returns
NULL when the clock is not present in the device tree. The clk framework
treats NULL as no-op for clk_{prepare|enable|unprepared|disable}, so R-Car
platforms are completely unaffected.

This is the same pattern as the audmac-pp clock/reset and per-SSI reset
control handling in other patches.

Regards,
John

>=20
>=20
> >  sound/soc/renesas/rcar/adg.c  | 99
> > ++++++++++++++++++++++++++++++++++-
> >  sound/soc/renesas/rcar/rsnd.h |  2 +
> >  sound/soc/renesas/rcar/ssi.c  | 18 +++++++
> >  3 files changed, 118 insertions(+), 1 deletion(-)
> >
> > diff --git a/sound/soc/renesas/rcar/adg.c
> > b/sound/soc/renesas/rcar/adg.c index cbb5c4432a2d..131a60689f6d 100644
> > --- a/sound/soc/renesas/rcar/adg.c
> > +++ b/sound/soc/renesas/rcar/adg.c
> > @@ -19,6 +19,9 @@
> >  #define CLKOUT3	3
> >  #define CLKOUTMAX 4
> >
> > +/* Maximum SSI count for per-SSI clocks */
> > +#define ADG_SSI_MAX	10
> > +
> >  #define BRGCKR_31	(1 << 31)
> >  #define BRRx_MASK(x) (0x3FF & x)
> >
> > @@ -34,6 +37,9 @@ struct rsnd_adg {
> >  	struct clk *adg;
> >  	struct clk *clkin[CLKINMAX];
> >  	struct clk *clkout[CLKOUTMAX];
> > +	/* RZ/G3E: per-SSI ADG clocks (adg.ssi.0 through adg.ssi.9) */
> > +	struct clk *clk_adg_ssi[ADG_SSI_MAX];
> > +	struct clk *clk_ssif_supply;
> >  	struct clk *null_clk;
> >  	struct clk_onecell_data onecell;
> >  	struct rsnd_mod mod;
> > @@ -341,10 +347,58 @@ int rsnd_adg_clk_query(struct rsnd_priv *priv,
> unsigned int rate)
> >  	return -EIO;
> >  }
> >
> > +/*
> > + * RZ/G3E: Prepare SSI clocks - call from hw_params (can sleep)  */
> > +int rsnd_adg_ssi_clk_prepare(struct rsnd_mod *ssi_mod) {
> > +	struct rsnd_priv *priv =3D rsnd_mod_to_priv(ssi_mod);
> > +	struct rsnd_adg *adg =3D rsnd_priv_to_adg(priv);
> > +	struct device *dev =3D rsnd_priv_to_dev(priv);
> > +	int id =3D rsnd_mod_id(ssi_mod);
> > +	int ret;
> > +
> > +	ret =3D clk_prepare(adg->clk_adg_ssi[id]);
> > +	if (ret) {
> > +		dev_err(dev, "Cannot prepare adg.ssi.%d ADG clock\n", id);
> > +		return ret;
> > +	}
> > +
> > +	ret =3D clk_prepare(adg->clk_ssif_supply);
> > +	if (ret) {
> > +		dev_err(dev, "Cannot prepare SSIF supply clock\n");
> > +		clk_unprepare(adg->clk_adg_ssi[id]);
> > +		return ret;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +/*
> > + * RZ/G3E: Unprepare SSI clocks - call from hw_free (can sleep)  */
> > +void rsnd_adg_ssi_clk_unprepare(struct rsnd_mod *ssi_mod) {
> > +	struct rsnd_priv *priv =3D rsnd_mod_to_priv(ssi_mod);
> > +	struct rsnd_adg *adg =3D rsnd_priv_to_adg(priv);
> > +	int id =3D rsnd_mod_id(ssi_mod);
> > +
> > +	clk_unprepare(adg->clk_adg_ssi[id]);
> > +	clk_unprepare(adg->clk_ssif_supply);
> > +}
> > +
> >  int rsnd_adg_ssi_clk_stop(struct rsnd_mod *ssi_mod)  {
> > +	struct rsnd_priv *priv =3D rsnd_mod_to_priv(ssi_mod);
> > +	struct rsnd_adg *adg =3D rsnd_priv_to_adg(priv);
> > +	int id =3D rsnd_mod_id(ssi_mod);
> > +
> >  	rsnd_adg_set_ssi_clk(ssi_mod, 0);
> >
> > +	/* RZ/G3E: only disable here, unprepare is done in hw_free */
> > +	clk_disable(adg->clk_adg_ssi[id]);
> > +	clk_disable(adg->clk_ssif_supply);
> > +
> >  	return 0;
> >  }
> >
> > @@ -354,7 +408,8 @@ int rsnd_adg_ssi_clk_try_start(struct rsnd_mod
> *ssi_mod, unsigned int rate)
> >  	struct rsnd_adg *adg =3D rsnd_priv_to_adg(priv);
> >  	struct device *dev =3D rsnd_priv_to_dev(priv);
> >  	struct rsnd_mod *adg_mod =3D rsnd_mod_get(adg);
> > -	int data;
> > +	int id =3D rsnd_mod_id(ssi_mod);
> > +	int ret, data;
> >  	u32 ckr =3D 0;
> >
> >  	data =3D rsnd_adg_clk_query(priv, rate); @@ -376,6 +431,18 @@ int
> > rsnd_adg_ssi_clk_try_start(struct rsnd_mod *ssi_mod, unsigned int rate)
> >  		(ckr) ?	adg->brg_rate[ADG_HZ_48] :
> >  			adg->brg_rate[ADG_HZ_441]);
> >
> > +	/*
> > +	 * RZ/G3E: enable per-SSI and supply clocks
> > +	 * Prepare was done in hw_params
> > +	 */
> > +	ret =3D clk_enable(adg->clk_adg_ssi[id]);
> > +	if (ret)
> > +		dev_warn(dev, "Cannot enable adg.ssi.%d ADG clock\n", id);
> > +
> > +	ret =3D clk_enable(adg->clk_ssif_supply);
> > +	if (ret)
> > +		dev_warn(dev, "Cannot enable SSIF supply clock\n");
> > +
> >  	return 0;
> >  }
> >
> > @@ -769,6 +836,31 @@ void rsnd_adg_clk_dbg_info(struct rsnd_priv
> > *priv, struct seq_file *m)  #define rsnd_adg_clk_dbg_info(priv, m)
> > #endif
> >
> > +static int rsnd_adg_get_ssi_clks(struct rsnd_priv *priv) {
> > +	struct rsnd_adg *adg =3D rsnd_priv_to_adg(priv);
> > +	struct device *dev =3D rsnd_priv_to_dev(priv);
> > +	char name[16];
> > +	int i;
> > +
> > +	/* SSIF supply clock */
> > +	adg->clk_ssif_supply =3D devm_clk_get_optional(dev, "ssif_supply");
> > +	if (IS_ERR(adg->clk_ssif_supply))
> > +		return dev_err_probe(dev, PTR_ERR(adg->clk_ssif_supply),
> > +				     "failed to get ssif_supply clock\n");
> > +
> > +	/* Per-SSI ADG clocks */
> > +	for (i =3D 0; i < ADG_SSI_MAX; i++) {
> > +		snprintf(name, sizeof(name), "adg.ssi.%d", i);
> > +		adg->clk_adg_ssi[i] =3D devm_clk_get_optional(dev, name);
> > +		if (IS_ERR(adg->clk_adg_ssi[i]))
> > +			return dev_err_probe(dev, PTR_ERR(adg->clk_adg_ssi[i]),
> > +					     "failed to get %s clock\n", name);
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> >  int rsnd_adg_probe(struct rsnd_priv *priv)  {
> >  	struct reset_control *rstc;
> > @@ -800,6 +892,11 @@ int rsnd_adg_probe(struct rsnd_priv *priv)
> >  	if (ret)
> >  		return ret;
> >
> > +	/* RZ/G3E-specific: per-SSI ADG and SSIF supply clocks */
> > +	ret =3D rsnd_adg_get_ssi_clks(priv);
> > +	if (ret)
> > +		return ret;
> > +
> >  	ret =3D rsnd_adg_clk_enable(priv);
> >  	if (ret)
> >  		return ret;
> > diff --git a/sound/soc/renesas/rcar/rsnd.h
> > b/sound/soc/renesas/rcar/rsnd.h index da377bca45a9..6bde304f93a8
> > 100644
> > --- a/sound/soc/renesas/rcar/rsnd.h
> > +++ b/sound/soc/renesas/rcar/rsnd.h
> > @@ -612,6 +612,8 @@ void __iomem *rsnd_gen_get_base_addr(struct
> rsnd_priv *priv, int reg_id);
> >   *	R-Car ADG
> >   */
> >  int rsnd_adg_clk_query(struct rsnd_priv *priv, unsigned int rate);
> > +int rsnd_adg_ssi_clk_prepare(struct rsnd_mod *ssi_mod); void
> > +rsnd_adg_ssi_clk_unprepare(struct rsnd_mod *ssi_mod);
> >  int rsnd_adg_ssi_clk_stop(struct rsnd_mod *ssi_mod);  int
> > rsnd_adg_ssi_clk_try_start(struct rsnd_mod *ssi_mod, unsigned int
> > rate);  int rsnd_adg_probe(struct rsnd_priv *priv); diff --git
> > a/sound/soc/renesas/rcar/ssi.c b/sound/soc/renesas/rcar/ssi.c index
> > e25a4dfae90c..e0eb48f8977b 100644
> > --- a/sound/soc/renesas/rcar/ssi.c
> > +++ b/sound/soc/renesas/rcar/ssi.c
> > @@ -544,6 +544,7 @@ static int rsnd_ssi_hw_params(struct rsnd_mod
> > *mod,  {
> >  	struct rsnd_dai *rdai =3D rsnd_io_to_rdai(io);
> >  	unsigned int fmt_width =3D
> > snd_pcm_format_width(params_format(params));
> > +	int ret;
> >
> >  	if (fmt_width > rdai->chan_width) {
> >  		struct rsnd_priv *priv =3D rsnd_io_to_priv(io); @@ -553,6
> +554,21 @@
> > static int rsnd_ssi_hw_params(struct rsnd_mod *mod,
> >  		return -EINVAL;
> >  	}
> >
> > +	/* RZ/G3E: prepare clocks here (can sleep) */
> > +	ret =3D rsnd_adg_ssi_clk_prepare(mod);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	return 0;
> > +}
> > +
> > +static int rsnd_ssi_hw_free(struct rsnd_mod *mod,
> > +			    struct rsnd_dai_stream *io,
> > +			    struct snd_pcm_substream *substream) {
> > +	/* RZ/G3E: unprepare clocks here (can sleep) */
> > +	rsnd_adg_ssi_clk_unprepare(mod);
> > +
> >  	return 0;
> >  }
> >
> > @@ -965,6 +981,7 @@ static struct rsnd_mod_ops rsnd_ssi_pio_ops =3D {
> >  	.pointer	=3D rsnd_ssi_pio_pointer,
> >  	.pcm_new	=3D rsnd_ssi_pcm_new,
> >  	.hw_params	=3D rsnd_ssi_hw_params,
> > +	.hw_free	=3D rsnd_ssi_hw_free,
> >  	.get_status	=3D rsnd_ssi_get_status,
> >  };
> >
> > @@ -1079,6 +1096,7 @@ static struct rsnd_mod_ops rsnd_ssi_dma_ops =3D {
> >  	.pcm_new	=3D rsnd_ssi_pcm_new,
> >  	.fallback	=3D rsnd_ssi_fallback,
> >  	.hw_params	=3D rsnd_ssi_hw_params,
> > +	.hw_free	=3D rsnd_ssi_hw_free,
> >  	.get_status	=3D rsnd_ssi_get_status,
> >  	DEBUG_INFO
> >  };
> > --
> > 2.25.1
> >
>=20
>=20
>=20
>=20
> Thank you for your help !!
>=20
> Best regards
> ---
> Kuninori Morimoto

