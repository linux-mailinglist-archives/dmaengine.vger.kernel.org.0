Return-Path: <dmaengine+bounces-9629-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KI4BKorFwmmIlgQAu9opvQ
	(envelope-from <dmaengine+bounces-9629-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 24 Mar 2026 18:10:34 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 76ABA319BF9
	for <lists+dmaengine@lfdr.de>; Tue, 24 Mar 2026 18:09:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7C722304FFAA
	for <lists+dmaengine@lfdr.de>; Tue, 24 Mar 2026 17:04:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42DD13A63E1;
	Tue, 24 Mar 2026 17:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="b4OpkUvx"
X-Original-To: dmaengine@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011009.outbound.protection.outlook.com [40.107.74.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D71A237C0E6;
	Tue, 24 Mar 2026 17:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774371855; cv=fail; b=CGN2Hc+UsudGrEF9tlS6fb0+i2r2pLeqbKPs8IHDv6C/b4MyxXivKgzHMQr+2YpLjDgzeOZAPlIPwpTgyQNYEQKXlUCeDqf3x3f9pWz/bbFo9EXiMRAqoLpYfVkbckE8uSYvY7/nI3ldSHg+WHkTP4MpcWClGHNkcZtf1IiXHNM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774371855; c=relaxed/simple;
	bh=b45G/YxJM2I271BgttTBSS3gYqMXDM+0PVcxu1ngDZU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=L6sx8NxWOxX9zrbynUNjGqAy7yA3FJmZl9QLfOfUXhS+p4mlOllGUBhKeIvPlzB7bWf+ObPZDo2E1WH3gn5qusGJ+oJmlUMdXGwq5YT/mFmc1fl1rSRWjvdmDPKUvqdG6xA6FSeBIK7OYY7yK5IN7OLgY1zrpuwV1UGIy1ThvCc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=b4OpkUvx; arc=fail smtp.client-ip=40.107.74.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tnXY4jWmpL06oyMA56FqIh7UXVbAsXh8iKc0hWjTd4ovnzC0UcfUFSKAcWbVZgCIQMjTSs+J3fXaJu3o/dgTSlGiEKS7605AUNeOd0lTGApJ0ujCCh+U5RGAAfHtgmaKHrQ9N02TXNhU+1WVUaNLdi0y3J0nTeqNMPW4u93x5VSj+yPtuMKiDfAR/WhUR9287WH9MGcC2BQs33otSmrcsJkFq0zgJwi/YgsG/roNE89yKILWUmU3pv0/uImzjKgiKVpr+LXPf6FJ/DHfSETlP+So/wkJF537s7xZgC9R66WtmRkvYNnEAtRGHTjGT9pZZKR6CZ1wd1ktekc7FcbbBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BscFQ4USpIeI35K7plJuZuNHt0nOIOx7jI406+SnJg8=;
 b=l8EQAWaGsBbpv9w7UvqwcXZCf97s09SOn6XKI4Pa1BZB6KBw1HYLfFBLc+ZrgsGZQ2gKl5u0Vj7yG2Y9RXAMei7xSIzrWRL8mkTpVRxoQooONDYOaolx26cYcDW6unq2ne2bE8e/g+/vHTtkAz5pShJyEytvA/O23dFUFPXSi9uV2avSDydlLezmHHDRtvxBak+sCyQvWxv8IFWjQfHaPGOGz72Gaf1k9BElaMH79xukfTw3ODGfhLl7Hs7hmU6rhGSvJNSVYVqjwylvlwfbUxhd3vAWKjAhzUu9ThafTDaO1ggfLGUC2kw45T8gvLWYDGeCGMuKUzGxGjHe+ArqHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BscFQ4USpIeI35K7plJuZuNHt0nOIOx7jI406+SnJg8=;
 b=b4OpkUvxa6V8BoZDFXDH+KrNlq2Ae+ZuIf6Nu1Q6/s0x4Ky6meDv0Qr1SYHFFtJAaPcmlqMBouF1rP7HpehxWzm7sjr2/OHTcJX3lUav9KGIthKC6ho+FuE56/gB7BXS3iNx3Ha814lmQnhQe6COakNX7PyuI+hjEvs7a72TAb0=
Received: from TY6PR01MB17377.jpnprd01.prod.outlook.com (2603:1096:405:35b::6)
 by TY7PR01MB13751.jpnprd01.prod.outlook.com (2603:1096:405:1fd::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.31; Tue, 24 Mar
 2026 17:03:52 +0000
Received: from TY6PR01MB17377.jpnprd01.prod.outlook.com
 ([fe80::f373:26d6:86c4:6aa3]) by TY6PR01MB17377.jpnprd01.prod.outlook.com
 ([fe80::f373:26d6:86c4:6aa3%4]) with mapi id 15.20.9723.030; Tue, 24 Mar 2026
 17:04:08 +0000
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
Subject: RE: [PATCH 10/22] ASoC: rsnd: Add DMA support infrastructure for
 RZ/G3E
Thread-Topic: [PATCH 10/22] ASoC: rsnd: Add DMA support infrastructure for
 RZ/G3E
Thread-Index: AQHct7jpskYDXbJ5n0WlxNLGupdi77W7VpSAgAKXUUA=
Date: Tue, 24 Mar 2026 17:04:08 +0000
Message-ID:
 <TY6PR01MB17377253D6B9A2998E7E62676FF48A@TY6PR01MB17377.jpnprd01.prod.outlook.com>
References: <20260319155334.51278-1-john.madieu.xa@bp.renesas.com>
	<20260319155334.51278-11-john.madieu.xa@bp.renesas.com>
 <87ikan9wca.wl-kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87ikan9wca.wl-kuninori.morimoto.gx@renesas.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY6PR01MB17377:EE_|TY7PR01MB13751:EE_
x-ms-office365-filtering-correlation-id: 5e1a8734-1d2f-4452-8ec0-08de89c75cd0
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700021|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info:
 jF5GaOcf/38zWoyJskNq8nxOKbrKJDrBXg2yOwsPcaJtctXuBQ/NMDe7xSvnRc2TzHyyAT9iu13csvQyDR0dHPMBlX5R9lEv9tRGg+2P8DxtJIAEWtXuDZQaMdqWgdjoTsk2hbbQYUv0fhGhyEVehihpyJMGm5k5sObcV/HiLQjbGHpCFsLJBholgeivbuA7tlpfgAAkkMpzSz9xyvMFurZHsb06vV92EwlYQpev4tZlxelWgsGCho+XLMyhoHRQSovBqHd3UJ34JatXUEtgK1EiyJSCDZ3bgo9b+g23RSVqWa307I67gxpx0SpPxH7bdNW8QX8dGa8KizEHJNGr+NKGphZjZVakMMWdK85U2pE14scjtTIyqVnzz4j1bijXSUoVZm9/KkGmna60hNYntZag6Dukg5lGZqWV8SZt2i/wXeQ9CEWYh7uauYuVMkKZQkmgObBpzeuCA5P7HiZvvankHn571fZDHYYmiIAolmzDlwqR6j7pXOShUOGeDvETGqEM+yd32RR/j2iQuiEsHs87QKX602JRm0F0iEo5UMEqAdr/w7TLrGN06H8Dw9cSzIKzmA/ief+lK9kwBMd1CAZS4YgyHUBf4jx+XGpH8VLeWDL24SGwCncXQazDn9p604UN3utuNbhyUlDJla3Fpmf5MGd9aRUxCKePr6gpd9QClXQBqJP8bvjmP/p6hT+RSrMXi/5o4YHo9wpIy0HV1qytGYtBXqt1HRcUB5BsB6Og9awTSqVzvrGU6k8BePh/2hLT5rI+0PZ4bCzAelxk+WJ6KdHyuW5YDPPDhdlSsls=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY6PR01MB17377.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700021)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?JD5mUa7nW5HSghZB0SqibHIprHKuWcjOxoyFdCICLiVAKlySVWVwBj4A5mfv?=
 =?us-ascii?Q?s5qyufDH6rtBGRV9/3u/XlQ+e7VYEfy0jwoPi1iL+4P+Vc5zJ9Qf4+0rgl74?=
 =?us-ascii?Q?qngfSDThOorCxr5GBUSxkK6BrhJSoI/Gw4aOeWclE+8IK9kNq8kpbLNvbdrS?=
 =?us-ascii?Q?+zHfplK4LW77QTYxBFqdxQthmlpomsiazEE2q4DLbQ8KVh3wRg0RGtKkb5zS?=
 =?us-ascii?Q?cmIlTLdVK7Gu7mA/m/KxYb7Un0P5BgQLPFdwuq6MpiXOL3MKzC81cH6/7MPE?=
 =?us-ascii?Q?nzQ1C874Zg21Qeiq0Jv6tpEPrnU3S69GBOjwBxBqD1bR7ruQiq0qjpu8P5mr?=
 =?us-ascii?Q?curQqpiiFt8Zhfrn3u7Bw2YATNFp4QTmfmJvmjoRS29L9s2XQxdOvF5oEvMe?=
 =?us-ascii?Q?5qQnEZJw/2y8p1uWmGcxBos2nJb7o/mh+mWJgF0ZedGCqZjgxYTzH6G+S75M?=
 =?us-ascii?Q?TpEV8Aufe5uFLJ6TC0vg++lfM0O77Z8C5FTHawaf+WNLltFw0IlKFs5U/v2e?=
 =?us-ascii?Q?eG9KDGUKnmvpFWj8+Iq0rYWeLgjXTTQiq4bM9vmbbHjIgmEspOJKtdW6hND4?=
 =?us-ascii?Q?Xh3SB9lpCe1BVYmPGILhq7aLPUkGUUg4uz89dusD05uPoO86BFdMBYKUPSAb?=
 =?us-ascii?Q?a6ZC7WYzRmHZEJGtSTgRTH3YhywLO4MNTctGv9HCgF2yEBBWqikV3YJLiD3O?=
 =?us-ascii?Q?no27ksP/y9KJVLW8X7gZd+/4v6SHgcbFGL8uep77g3Ac4FTgOvhRQB4d1126?=
 =?us-ascii?Q?qMDsgbPjRMhTEGoreZs758iIsXQu6S5cNhXzTmXf3PuzqJoqfQt5GwFn2eOt?=
 =?us-ascii?Q?0lJXNyWtTsxIKCTYcf4sOnhyYl+DBvGweTdNArwz4NFyUh5rkomNtrA2yKbW?=
 =?us-ascii?Q?2lolp74uOBrDvGL96TGbgnbcqFhoPnXS4FGXlZiSojwA+uxmSPFqWKYYZr4v?=
 =?us-ascii?Q?N0FfTAc2PjXZUXQ2vbCeWr7VLQc2w5Hk+I+at86vwO46OeyKaEz4AAPq9FMM?=
 =?us-ascii?Q?O4gksqn+P1PAySejafoJY2ZQa98Ml1s6b7cpF4G2GS5xrJcN9sC5xmXPO7mc?=
 =?us-ascii?Q?y/E5auXGgBx2l4faFLFRMPsgvU6vl6qUM+xsOjR6kGWqfFpNso556dryOpE3?=
 =?us-ascii?Q?8o457UUJEr9/lsoYZmyMXECHxe68n4CHMIusXd+7c6RswnkU9slBc0QFRytE?=
 =?us-ascii?Q?SGUYGGlLt5GhknyFKYu+hrw8FuyoRqVcdXBVDlNreBoaLl0ozBpJ4SZL2Od3?=
 =?us-ascii?Q?AtmIzLZC4P0Kt0UOQBGArnllEYaUMY3ndeafjgqC0boa6WMB9pePlbtvuKNy?=
 =?us-ascii?Q?LvmADccw5voDpLL0sqkW7Wma/ISSN4T1mhkNEB2c7ozWiRtUblGxF3lpt+ZQ?=
 =?us-ascii?Q?kr494Z9ix41N74WjFdFn7qhZr9wCPgo+06XjTBPDrNL3YChtja0QRb+Y5Uh4?=
 =?us-ascii?Q?7h92mvwCA5ICJaUUHkYwzS1YO9mbVQlQ5FvdVknMoMw52wK1ooGRU4qGTc24?=
 =?us-ascii?Q?RiKu4nI73c27vZHQP+SsFgvyCivlItmYjacu0SXdTFtshnFcjzYhEXMA/dUy?=
 =?us-ascii?Q?GykEYgnRKXdASjaynZVOdORFXH3EEVp1/OZWVnaPiv8s3QpMYY6n0QEm9FLM?=
 =?us-ascii?Q?8Isla9pPwQkMuFjfdcBHJ6qNz+l0cZJhA4KF/JTHeZ72uqX1mbLOjTs2KiAO?=
 =?us-ascii?Q?I/3MZnYQwJ9vEnL7TF0RU5lXWApGz5rCkuUtuk/Qse4d9deJlZvIH+VC+A01?=
 =?us-ascii?Q?6AYJlYRaO7GEciS7DOQOcOLye52HE3k=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e1a8734-1d2f-4452-8ec0-08de89c75cd0
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2026 17:04:08.1776
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: I2Oq074C5xuYRKp5xzAQbCrZc0kJoiYBHGmDzY2weL8/AWj9pphBqIlYTnp/yNS1E2zPbB4COYPYqU6qf+J2w6Mt40Foe62OjdLhmo9XQ0g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY7PR01MB13751
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
	TAGGED_FROM(0.00)[bounces-9629-lists,dmaengine=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,renesas.com:email,TY6PR01MB17377.jpnprd01.prod.outlook.com:mid,bp.renesas.com:dkim]
X-Rspamd-Queue-Id: 76ABA319BF9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Kuninori,

> -----Original Message-----
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> Sent: Monday, March 23, 2026 2:19 AM
> To: John Madieu <john.madieu.xa@bp.renesas.com>
> Subject: Re: [PATCH 10/22] ASoC: rsnd: Add DMA support infrastructure for
> RZ/G3E
>=20
>=20
> Hi John
>=20
> > RZ/G3E has different DMA register base addresses and offset
> > calculations compared to R-Car platforms, and requires additional
> > audmac-pp clock and reset lines for Audio DMAC operation.
> >
> > Add RZ/G3E-specific DMA address macros and audmac-pp clock/reset
> > support using optional APIs to remain transparent to other platforms.
> >
> > Signed-off-by: John Madieu <john.madieu.xa@bp.renesas.com>
> > ---
> (snip)
> > -	ret =3D rsnd_mod_init(priv, *dma_mod, ops, NULL, NULL,
> > -			    type, dma_id);
> > +	/*
> > +	 * Pass NULL for clock/reset - audmac_pp is managed globally in
> > +	 * rsnd_dma_probe() and core.c suspend/resume, not per-DMA-module.
> > +	 * See detailed explanation in rsnd_dma_probe().
> > +	 */
> > +	ret =3D rsnd_mod_init(priv, *dma_mod, ops, NULL, NULL, type, dma_id);
> >  	if (ret < 0)
> >  		return ret;
>=20
> This patch change rsnd_mod_init() parameters independently.
> Is this patch-set can keep compile comapatible ??
>=20

The patch changing rsnd_mod_init()'s parameters is 08/22, and while
doing it, it updates the call from other module code. So yes, every
single patch in the series is compile-compatible (assuming you meant
compile-tested ?)

Regards,
John

> Thank you for your help !!
>=20
> Best regards
> ---
> Kuninori Morimoto

