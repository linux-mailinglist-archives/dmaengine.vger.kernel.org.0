Return-Path: <dmaengine+bounces-9851-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eI3cBBk2zmmAmAYAu9opvQ
	(envelope-from <dmaengine+bounces-9851-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 02 Apr 2026 11:25:45 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F6B6386E04
	for <lists+dmaengine@lfdr.de>; Thu, 02 Apr 2026 11:25:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4F696304D496
	for <lists+dmaengine@lfdr.de>; Thu,  2 Apr 2026 09:12:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DF6436B05E;
	Thu,  2 Apr 2026 09:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="iLUJudyr"
X-Original-To: dmaengine@vger.kernel.org
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11010046.outbound.protection.outlook.com [52.101.228.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 442C419F40A;
	Thu,  2 Apr 2026 09:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775121154; cv=fail; b=JRjCk+eJuxfwIssE1kkmn+0nKl0OStNarH2SwfYDOURNNFtBMy/6XiSQ6BymHfFcyBGeieGwPqHBY9muyScCWXGCQgssMFrPjNm16XghOfmicuXsiRKBqhOula9jWKLJSRBZ/mr5LSw1709O7g1FusRetbl1ZAl80u3IMrAB8m4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775121154; c=relaxed/simple;
	bh=+DWA2PUM+x2ZVzHzkCOABf0aeGcrTahod8MrOV93LOg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=eIFex7uLPOwl0GQYR8s/LS+97FgQ2zeUdIr9qbOUvc+xPcH9T3UZLtl6vYep+CfxJ96ULt9Bq39IC75KMWvq/fzljwvrd4IWM4eR/jB3l89czT/saPP6RXCYBkB3jqjWh7J0ca0/jrd0ObKm+SykRVXD1dWdpFG7eqDjaGxtyZI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=iLUJudyr; arc=fail smtp.client-ip=52.101.228.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h7uA2P6jMsJT95v3CUI6RYFK5hvJ/Z5JIqsVqleV5sc5i6nHoO3s5LBIAP5Rv5q6rLF+3CUp/t2n0UouVeaxd1c1LgEjvq0BhX6A6dWE/pBTn52wrZJSf9C7dbPlsGENwQhE0jKo3i+BxV1c4yR5wh+l/zxAmRRY5coxG+wY8BxisyMyuxVsvGVdWsr2JFSjLnghd7bppnwIjnE3mYNogJwhPBh+4WPoTt8EE9lS5TBRPGwuyqVJXENii3XZmLuJCVZfabTJh8t/TVJi5XnDLO8455cPYTBLT1NU/OOoFjdrVdZTapGsjHOtweIKfWcgyZiyBSuNKIVqYR8gbcOYVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H7QELm9x2PGsQyAhdwZzl3QnWql1DyrAYx7zeHfvTuY=;
 b=Iu39LB0spVeF1uS/+l6l78dnZhNlnH4qvLvjLZLrEEe5wgLPfiL6Y8iWOtkD/Psy0sRLf/OpW7wgEUg7VtWOnnuwtvtwkaJSBEzy8USrn8LOeoGjXRuQMXMV/xNbg46CCatLXkxmOyjW4zulRxNamPHRtrgAtTVaYO+XHnZKFyJj5U20yoyNOc/POAfxJk4JmRkK8O3t6+2fMKilNWYOp8Djwq4q1kR1fqMq11YeSFaEK/c0H9DIoyEKLrG0Kaz0lCz+NNt6OyRN66saLQWRzkT1eawMDfDLiMDE56EWxSZx+pWRbkBvEJpSyQrHNjvaBKPUXPHqpPkIz88vkN2Eog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H7QELm9x2PGsQyAhdwZzl3QnWql1DyrAYx7zeHfvTuY=;
 b=iLUJudyrGHxPPlOpHAMfjJAuFIxBnKzmcriZyZSRFU/UjdaKyGncXbKMwRzOdd1ODr7SOIdWFzaRKjwzh6WYurmc44iu7UQFeilYmVpD59r4GEnNehgAoqBrbX9mBAPqXoD8j2D1GnR+uQmON8TxSC411oD5X4aR+2xrhlsaDAM=
Received: from TYCPR01MB11332.jpnprd01.prod.outlook.com (2603:1096:400:3c0::7)
 by OSOPR01MB12233.jpnprd01.prod.outlook.com (2603:1096:604:2d9::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.28; Thu, 2 Apr
 2026 09:12:29 +0000
Received: from TYCPR01MB11332.jpnprd01.prod.outlook.com
 ([fe80::2511:10cd:e497:4d97]) by TYCPR01MB11332.jpnprd01.prod.outlook.com
 ([fe80::2511:10cd:e497:4d97%5]) with mapi id 15.20.9769.016; Thu, 2 Apr 2026
 09:12:29 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: John Madieu <john.madieu.xa@bp.renesas.com>, Geert Uytterhoeven
	<geert+renesas@glider.be>, Kuninori Morimoto
	<kuninori.morimoto.gx@renesas.com>, Vinod Koul <vkoul@kernel.org>, Mark Brown
	<broonie@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>
CC: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
	<sboyd@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Frank Li
	<Frank.Li@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, magnus.damm
	<magnus.damm@gmail.com>, Thomas Gleixner <tglx@kernel.org>, Jaroslav Kysela
	<perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Philipp Zabel
	<p.zabel@pengutronix.de>, Claudiu.Beznea <claudiu.beznea@tuxon.dev>, Fabrizio
 Castro <fabrizio.castro.jz@renesas.com>, Prabhakar Mahadev Lad
	<prabhakar.mahadev-lad.rj@bp.renesas.com>, John Madieu
	<john.madieu@gmail.com>, "linux-renesas-soc@vger.kernel.org"
	<linux-renesas-soc@vger.kernel.org>, "linux-clk@vger.kernel.org"
	<linux-clk@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "dmaengine@vger.kernel.org"
	<dmaengine@vger.kernel.org>, "linux-sound@vger.kernel.org"
	<linux-sound@vger.kernel.org>, John Madieu <john.madieu.xa@bp.renesas.com>
Subject: RE: [PATCH v2 20/24] arm64: dts: renesas: r9a09g047: Add R-Car Sound
 support
Thread-Topic: [PATCH v2 20/24] arm64: dts: renesas: r9a09g047: Add R-Car Sound
 support
Thread-Index: AQHcwoCEVUfmI1IRgEClmiB49koC4bXLfD5w
Date: Thu, 2 Apr 2026 09:12:28 +0000
Message-ID:
 <TYCPR01MB1133275941F1468B1F4863E888651A@TYCPR01MB11332.jpnprd01.prod.outlook.com>
References: <20260402090524.9137-1-john.madieu.xa@bp.renesas.com>
 <20260402090524.9137-21-john.madieu.xa@bp.renesas.com>
In-Reply-To: <20260402090524.9137-21-john.madieu.xa@bp.renesas.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB11332:EE_|OSOPR01MB12233:EE_
x-ms-office365-filtering-correlation-id: 5fda1f0f-75b4-48f5-e11b-08de9097f6d6
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700021|22082099003|18002099003|56012099003;
x-microsoft-antispam-message-info:
 NS0J+ycBrjkPs/QCWQgxqzCL4LVa/EFTKeEQ3WMNz7329az3S1V4n9c151BCfXcjCsz2UKbO5cH7ePC+8uLnj6RYH2OTF8jv+S5bgWZ3Cenxf4ErFcVfVXmRfJf4cUgqV9zWYjG9N8cxOKZ9dzj3uDBMRGQA1Sujv2CLLeUrncmeLPYWfti8k+4OItZ3MZDhSAEbCYn7cDMbwuB8w2OS55VA3NFwlfdRmCC5hHxo7E/54MmmLNp9FgHjsYfp1MSXnXpWxRjKYoKA0GFxFbew+qY9y6GvQeBdoUGKnopRtD9pCKLrksX2ggwMHl8YEeX3YfnvO3FNlVcBJ92Yk4ycBgfEGCPop66/+MnaS+9C8ku5mPK3X3H+79H+qtDMoDvmesX5hAJu3lHvkUL9YthI6aGrXpueIFfSNRjPZn5TI7fp3HA1ScHyDKEE7KGR5NZs5GBVwnVe/MrgntWxPm1RZ1ikaJxmUo3YJO4rZRXpcU4U9o/75OAYHCBQdpigvvS+7p99WG53XV6tx4vVoRfpYwDZvOQN0mim/fhuvGYPJhnmKgd5tyof+Nf4q6NaAXb8JG3Yszt+fQNumxc+gSSZ3fRkNY37O1h5jK1DjqFRVnl2n8EG1NeSp9/eaYDdv3xP0iOY0UKXTQBPM5Semoo+Bs/HqWM+1gCmkj0hLdb5VxDFu8p1tzJcoL62g7qnyFc9CJfeNy/R4dvzyP74Lfs9pyXPEc2sBuq+1VR+RvlsFotHe6j6wPzVAnQz/4FjmztaGEz4ZF0xo+tbWFm+lD3SIgwzOeeJb+wFdXNFPZV2cD0=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11332.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700021)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?EThqV//cgvb5DL1zCekmYmaYBXYGb6dVAiXAOwtMlaO1jIzeI/Xh5IY1tUDE?=
 =?us-ascii?Q?7wEeTg5xV0LAYM0vPbhiSVtBax2RmrneCGhtmSKMbnN5+Tf5UPAfwW2g8qug?=
 =?us-ascii?Q?//Ru2FdU+bu/4RXmjaV8gTHjBbSzq8T5xHgS+utZ4Iw3pO3xMxOSysDGolhE?=
 =?us-ascii?Q?aMyeJFEECDFPs6NmCCV4r15/whDN4oFxMJ/JTY4iX9Ze+F6pGrQRCzIBn9dx?=
 =?us-ascii?Q?aEmn1MPfY43xVviEJx4z5Sx1Z6Z3+48DxoDx8U3btQ/V+gM+tGFHuwyKgmPr?=
 =?us-ascii?Q?VQHhAYxtrliOFG8dOLBxdL3Q+oC8C46qmr1dQTGeTjGYDMsClEVttAwosY4+?=
 =?us-ascii?Q?MIMhJljIYBsuE7gKpC121q72XgN4NCrRtElacLXKXsGopWJNls/BdNAHO239?=
 =?us-ascii?Q?8uSAYXQbnXiZZT5uQcQnYhBUF+ih1XcjG1Slud6kJf5pWLHez1jNld6Vxrmv?=
 =?us-ascii?Q?d0NRsvpYz1qEM3SqyPfJm36bf81qEYF2gE1w5YpDL1W1WIodM+giBfKH2Z4O?=
 =?us-ascii?Q?kZF7sEa7RlozrsGdEufiLP4SaAEKMUmlb0qZCtNJjR3eD6oKsUKvmVvZA/9O?=
 =?us-ascii?Q?8IGxXT3Elqd0JkAeov06Mx/lQIgqT8foRSzZ9T5PYftR9ncHjXiaAG+yX5NI?=
 =?us-ascii?Q?Jx3DatHPuasr4tWWlZT9aQTSBZ09PTd6CcbEBTMiRGa+XBK3CZYNDKqfySmi?=
 =?us-ascii?Q?G1MKOHEsDiI0WqzoCEiWtNQtH42fPXZYLPldPSFiF2ZAodxE6ngSwetl1nxr?=
 =?us-ascii?Q?HsAL9Ta9SxMU7mCvOuSfP/IrgogwgGerMLnncPoI/vQNgeSk9tuIeJEstINX?=
 =?us-ascii?Q?bCvT/s4Y2leYQcPL9Lx1ePpAIvRjPSVZbHIlsyN6QANjdYbHz9/RsIa1/srp?=
 =?us-ascii?Q?Roz0mnp/lADIW3GhR8boEtxb8KICBB6IL37UpKMDZxzUZykk0iNv4ij+CeCM?=
 =?us-ascii?Q?comc5WhizH0OImlKoJrjXWsaMdPY6OLQflEIQsMzRQJWW0Q9dgAvHeK1pEyn?=
 =?us-ascii?Q?kyYbdRMDE0ZukhCn3d77CjM1iND+uyZag6h8zdAIwjLkeq9B6kKhpXIKdLA+?=
 =?us-ascii?Q?00zQimvPCt2e90r9g5j+fOcteyBD+iHbql3OQKKMJrYL2RRB9Kjto5eXVFnA?=
 =?us-ascii?Q?pnirKqJlpX6r8ojWq3+ciJc9p2vu9UHKV4OmBJkOJeLVmfRmInr7UGbBxV4G?=
 =?us-ascii?Q?yHlLlLo/NEbEuKIW4YTGJNnR3/X/wGAhTUCPSm45TcLrfOnsg/ruk3XCqR/0?=
 =?us-ascii?Q?7veyEAeyWKljHkw590UkHAy6vOenbhokD/q0U5lg6OQgEsrf3k8xi/WUKnFq?=
 =?us-ascii?Q?tLewOrtnxXs3c/rpcKIPMB0onKZ/GbNu9CV1RwNoDNey6hs9ox7IprCAwP7x?=
 =?us-ascii?Q?CSCzb1SpTvqgaflcKJzqDD6ooFLq9mvJvTl22GsTSJsuOwwj+rbyEWp2AfEN?=
 =?us-ascii?Q?oHL8KSKYWipVd54JrhRoumyM0YRJ5slYVmZVzhbWw7quFnig3b+9ryEyi94G?=
 =?us-ascii?Q?TsGa1krvBhzkHDWyrhvMuTUaF99NncF0GJchdMI7R2cVtTHJ19+TnO1ZQFkD?=
 =?us-ascii?Q?zTwJ7P1OfM6zNHmpxDw1nw76A94tdEJUQoAvBEgz36cgkN/jNRvyQCtakFfD?=
 =?us-ascii?Q?rHUbm7B/PFUDeR0zXSD/Q2RW80QsctXLjjyLHzuE14ZM3eKt7NavO8UDnapy?=
 =?us-ascii?Q?eezD+3BN/YzqqlgYDzSDy4OdN+7UWIPHsRt35wryPF7xSNANoR/PXP9OR9Au?=
 =?us-ascii?Q?6nOvZlMSMw=3D=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11332.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fda1f0f-75b4-48f5-e11b-08de9097f6d6
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Apr 2026 09:12:28.8411
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +Rv3dqxnfGg9eng+Wz9x5bwCGqMP9exFJEFQWv9avjeq+QZXY7nbh0Ze5Ao0eemDZRQGgh4xW+ur42rHsmfXNab/aLNQpzxzgYgO/WoKpGM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSOPR01MB12233
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[renesas.com,none];
	R_DKIM_ALLOW(-0.20)[bp.renesas.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[baylibre.com,kernel.org,gmail.com,perex.cz,suse.com,pengutronix.de,tuxon.dev,renesas.com,bp.renesas.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9851-lists,dmaengine=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DKIM_TRACE(0.00)[bp.renesas.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[28];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[biju.das.jz@bp.renesas.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[dmaengine,renesas,dt];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 0F6B6386E04
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi John,

Thanks for the patch

> -----Original Message-----
> From: John Madieu <john.madieu.xa@bp.renesas.com>
> Sent: 02 April 2026 10:05
> Subject: [PATCH v2 20/24] arm64: dts: renesas: r9a09g047: Add R-Car Sound=
 support

Typo RZ/G3E sound support??

Cheers,
Biju


>=20
> Add the rzg3e_sound node for the RZ/G3E SoC with all sub-components:
>=20
> - SSI (Serial Sound Interface) units 0-9
> - SSIU (Serial Sound Interface Unit) units 0-27
> - SRC (Sample Rate Converter) units 0-9
> - CTU (Channel Transfer Unit) units 0-7
> - DVC (Digital Volume Control) units 0-1
> - MIX (Mixer) units 0-1
>=20
> Wire up all 5 DMA controllers (dmac0-dmac4) for each audio sub-node with =
repeated channel names, so
> that the DMA core can pick the first available controller.
>=20
> Signed-off-by: John Madieu <john.madieu.xa@bp.renesas.com>
> ---
>=20
> Changes:
>=20
> v2:
>  - Remove 2-cells specifier on audio DMA assignment
>  - Do not update DMAC #dma-cells anymore
>=20
>  arch/arm64/boot/dts/renesas/r9a09g047.dtsi | 502 +++++++++++++++++++++
>  1 file changed, 502 insertions(+)
>=20
> diff --git a/arch/arm64/boot/dts/renesas/r9a09g047.dtsi b/arch/arm64/boot=
/dts/renesas/r9a09g047.dtsi
> index 1ff48c8f98e1..b1e567d71c26 100644
> --- a/arch/arm64/boot/dts/renesas/r9a09g047.dtsi
> +++ b/arch/arm64/boot/dts/renesas/r9a09g047.dtsi
> @@ -918,6 +918,508 @@ rsci9: serial@12803000 {
>  			status =3D "disabled";
>  		};
>=20
> +		snd_rzg3e: sound@13c00000 {
> +			/*
> +			 * #sound-dai-cells is required
> +			 *
> +			 * Single DAI : #sound-dai-cells =3D <0>; <&snd_rzg3e>;
> +			 * Multi  DAI : #sound-dai-cells =3D <1>; <&snd_rzg3e N>;
> +			 */
> +			/*
> +			 * #clock-cells is required for audio_clkout0/1/2/3
> +			 *
> +			 * clkout       : #clock-cells =3D <0>;   <&snd_rzg3e>;
> +			 * clkout0/1/2/3: #clock-cells =3D <1>;   <&snd_rzg3e N>;
> +			 */
> +			compatible =3D "renesas,r9a09g047-sound";
> +			reg =3D <0 0x13c00000 0 0x10000>, /* SCU */
> +			      <0 0x13c20000 0 0x10000>, /* ADG */
> +			      <0 0x13c30000 0 0x1000>,  /* SSIU */
> +			      <0 0x13c31000 0 0x1F000>, /* SSI */
> +			      <0 0x13c50000 0 0x10000>; /* Audio DMAC peri peri */
> +			reg-names =3D "scu", "adg", "ssiu", "ssi", "audmapp";
> +			clocks =3D <&cpg CPG_MOD 245>,
> +				 <&cpg CPG_MOD 394>,
> +				 <&cpg CPG_MOD 393>,
> +				 <&cpg CPG_MOD 392>,
> +				 <&cpg CPG_MOD 391>,
> +				 <&cpg CPG_MOD 390>,
> +				 <&cpg CPG_MOD 389>,
> +				 <&cpg CPG_MOD 388>,
> +				 <&cpg CPG_MOD 387>,
> +				 <&cpg CPG_MOD 386>,
> +				 <&cpg CPG_MOD 385>,
> +				 <&cpg CPG_MOD 381>,
> +				 <&cpg CPG_MOD 380>,
> +				 <&cpg CPG_MOD 379>,
> +				 <&cpg CPG_MOD 378>,
> +				 <&cpg CPG_MOD 377>,
> +				 <&cpg CPG_MOD 376>,
> +				 <&cpg CPG_MOD 375>,
> +				 <&cpg CPG_MOD 374>,
> +				 <&cpg CPG_MOD 373>,
> +				 <&cpg CPG_MOD 372>,
> +				 <&cpg CPG_MOD 371>,
> +				 <&cpg CPG_MOD 370>,
> +				 <&cpg CPG_MOD 371>,
> +				 <&cpg CPG_MOD 370>,
> +				 <&cpg CPG_MOD 368>,
> +				 <&cpg CPG_MOD 369>,
> +				 <&cpg CPG_MOD 251>,
> +				 <&cpg CPG_MOD 252>,
> +				 <&cpg CPG_MOD 253>,
> +				 <&cpg CPG_MOD 250>,
> +				 <&cpg CPG_MOD 384>,
> +				 <&cpg CPG_MOD 246>,
> +				 <&cpg CPG_MOD 247>,
> +				 <&cpg CPG_MOD 382>,
> +				 <&cpg CPG_MOD 361>,
> +				 <&cpg CPG_MOD 360>,
> +				 <&cpg CPG_MOD 359>,
> +				 <&cpg CPG_MOD 358>,
> +				 <&cpg CPG_MOD 357>,
> +				 <&cpg CPG_MOD 356>,
> +				 <&cpg CPG_MOD 355>,
> +				 <&cpg CPG_MOD 354>,
> +				 <&cpg CPG_MOD 353>,
> +				 <&cpg CPG_MOD 352>,
> +				 <&cpg CPG_MOD 248>,
> +				 <&cpg CPG_MOD 249>;
> +			clock-names =3D "ssi-all",
> +				      "ssi.9", "ssi.8",
> +				      "ssi.7", "ssi.6",
> +				      "ssi.5", "ssi.4",
> +				      "ssi.3", "ssi.2",
> +				      "ssi.1", "ssi.0",
> +				      "src.9", "src.8",
> +				      "src.7", "src.6",
> +				      "src.5", "src.4",
> +				      "src.3", "src.2",
> +				      "src.1", "src.0",
> +				      "mix.1", "mix.0",
> +				      "ctu.1", "ctu.0",
> +				      "dvc.0", "dvc.1",
> +				      "clk_a", "clk_b",
> +				      "clk_c", "clk_i",
> +				      "ssif_supply",
> +				      "scu", "scu_x2",
> +				      "scu_supply",
> +				      "adg.ssi.9", "adg.ssi.8",
> +				      "adg.ssi.7", "adg.ssi.6",
> +				      "adg.ssi.5", "adg.ssi.4",
> +				      "adg.ssi.3", "adg.ssi.2",
> +				      "adg.ssi.1", "adg.ssi.0",
> +				      "audmapp", "adg";
> +			power-domains =3D <&cpg>;
> +			resets =3D <&cpg 225>,
> +				 <&cpg 235>,
> +				 <&cpg 234>,
> +				 <&cpg 233>,
> +				 <&cpg 232>,
> +				 <&cpg 231>,
> +				 <&cpg 230>,
> +				 <&cpg 229>,
> +				 <&cpg 228>,
> +				 <&cpg 227>,
> +				 <&cpg 226>,
> +				 <&cpg 236>,
> +				 <&cpg 238>,
> +				 <&cpg 237>;
> +			reset-names =3D "ssi-all",
> +				      "ssi.9", "ssi.8",
> +				      "ssi.7", "ssi.6",
> +				      "ssi.5", "ssi.4",
> +				      "ssi.3", "ssi.2",
> +				      "ssi.1", "ssi.0",
> +				      "scu", "adg",
> +				      "audmapp";
> +			status =3D "disabled";
> +
> +			rcar_sound,ctu {
> +				ctu00: ctu-0 { };
> +				ctu01: ctu-1 { };
> +				ctu02: ctu-2 { };
> +				ctu03: ctu-3 { };
> +				ctu10: ctu-4 { };
> +				ctu11: ctu-5 { };
> +				ctu12: ctu-6 { };
> +				ctu13: ctu-7 { };
> +			};
> +
> +			rcar_sound,dvc {
> +				dvc0: dvc-0 {
> +					dmas =3D <&dmac0 0x1db3>, <&dmac1 0x1db3>,
> +					       <&dmac2 0x1db3>, <&dmac3 0x1db3>,
> +					       <&dmac4 0x1db3>;
> +					dma-names =3D "tx", "tx", "tx", "tx", "tx";
> +				};
> +				dvc1: dvc-1 {
> +					dmas =3D <&dmac0 0x1db4>, <&dmac1 0x1db4>,
> +					       <&dmac2 0x1db4>, <&dmac3 0x1db4>,
> +					       <&dmac4 0x1db4>;
> +					dma-names =3D "tx", "tx", "tx", "tx", "tx";
> +				};
> +			};
> +
> +			rcar_sound,mix {
> +				mix0: mix-0 { };
> +				mix1: mix-1 { };
> +			};
> +
> +			rcar_sound,src {
> +				src0: src-0 {
> +					interrupts =3D <GIC_SPI 902 IRQ_TYPE_LEVEL_HIGH>;
> +					dmas =3D <&dmac0 0x1d9f>, <&dmac0 0x1da9>,
> +					       <&dmac1 0x1d9f>, <&dmac1 0x1da9>,
> +					       <&dmac2 0x1d9f>, <&dmac2 0x1da9>,
> +					       <&dmac3 0x1d9f>, <&dmac3 0x1da9>,
> +					       <&dmac4 0x1d9f>, <&dmac4 0x1da9>;
> +					dma-names =3D "rx", "tx", "rx", "tx", "rx", "tx", "rx", "tx", "rx",=
 "tx";
> +				};
> +				src1: src-1 {
> +					interrupts =3D <GIC_SPI 903 IRQ_TYPE_LEVEL_HIGH>;
> +					dmas =3D <&dmac0 0x1da0>, <&dmac0 0x1daa>,
> +					       <&dmac1 0x1da0>, <&dmac1 0x1daa>,
> +					       <&dmac2 0x1da0>, <&dmac2 0x1daa>,
> +					       <&dmac3 0x1da0>, <&dmac3 0x1daa>,
> +					       <&dmac4 0x1da0>, <&dmac4 0x1daa>;
> +					dma-names =3D "rx", "tx", "rx", "tx", "rx", "tx", "rx", "tx", "rx",=
 "tx";
> +				};
> +				src2: src-2 {
> +					interrupts =3D <GIC_SPI 904 IRQ_TYPE_LEVEL_HIGH>;
> +					dmas =3D <&dmac0 0x1da1>, <&dmac0 0x1dab>,
> +					       <&dmac1 0x1da1>, <&dmac1 0x1dab>,
> +					       <&dmac2 0x1da1>, <&dmac2 0x1dab>,
> +					       <&dmac3 0x1da1>, <&dmac3 0x1dab>,
> +					       <&dmac4 0x1da1>, <&dmac4 0x1dab>;
> +					dma-names =3D "rx", "tx", "rx", "tx", "rx", "tx", "rx", "tx", "rx",=
 "tx";
> +				};
> +				src3: src-3 {
> +					interrupts =3D <GIC_SPI 905 IRQ_TYPE_LEVEL_HIGH>;
> +					dmas =3D <&dmac0 0x1da2>, <&dmac0 0x1dac>,
> +					       <&dmac1 0x1da2>, <&dmac1 0x1dac>,
> +					       <&dmac2 0x1da2>, <&dmac2 0x1dac>,
> +					       <&dmac3 0x1da2>, <&dmac3 0x1dac>,
> +					       <&dmac4 0x1da2>, <&dmac4 0x1dac>;
> +					dma-names =3D "rx", "tx", "rx", "tx", "rx", "tx", "rx", "tx", "rx",=
 "tx";
> +				};
> +				src4: src-4 {
> +					interrupts =3D <GIC_SPI 906 IRQ_TYPE_LEVEL_HIGH>;
> +					dmas =3D <&dmac0 0x1da3>, <&dmac0 0x1dad>,
> +					       <&dmac1 0x1da3>, <&dmac1 0x1dad>,
> +					       <&dmac2 0x1da3>, <&dmac2 0x1dad>,
> +					       <&dmac3 0x1da3>, <&dmac3 0x1dad>,
> +					       <&dmac4 0x1da3>, <&dmac4 0x1dad>;
> +					dma-names =3D "rx", "tx", "rx", "tx", "rx", "tx", "rx", "tx", "rx",=
 "tx";
> +				};
> +				src5: src-5 {
> +					interrupts =3D <GIC_SPI 907 IRQ_TYPE_LEVEL_HIGH>;
> +					dmas =3D <&dmac0 0x1da4>, <&dmac0 0x1dae>,
> +					       <&dmac1 0x1da4>, <&dmac1 0x1dae>,
> +					       <&dmac2 0x1da4>, <&dmac2 0x1dae>,
> +					       <&dmac3 0x1da4>, <&dmac3 0x1dae>,
> +					       <&dmac4 0x1da4>, <&dmac4 0x1dae>;
> +					dma-names =3D "rx", "tx", "rx", "tx", "rx", "tx", "rx", "tx", "rx",=
 "tx";
> +				};
> +				src6: src-6 {
> +					interrupts =3D <GIC_SPI 908 IRQ_TYPE_LEVEL_HIGH>;
> +					dmas =3D <&dmac0 0x1da5>, <&dmac0 0x1daf>,
> +					       <&dmac1 0x1da5>, <&dmac1 0x1daf>,
> +					       <&dmac2 0x1da5>, <&dmac2 0x1daf>,
> +					       <&dmac3 0x1da5>, <&dmac3 0x1daf>,
> +					       <&dmac4 0x1da5>, <&dmac4 0x1daf>;
> +					dma-names =3D "rx", "tx", "rx", "tx", "rx", "tx", "rx", "tx", "rx",=
 "tx";
> +				};
> +				src7: src-7 {
> +					interrupts =3D <GIC_SPI 909 IRQ_TYPE_LEVEL_HIGH>;
> +					dmas =3D <&dmac0 0x1da6>, <&dmac0 0x1db0>,
> +					       <&dmac1 0x1da6>, <&dmac1 0x1db0>,
> +					       <&dmac2 0x1da6>, <&dmac2 0x1db0>,
> +					       <&dmac3 0x1da6>, <&dmac3 0x1db0>,
> +					       <&dmac4 0x1da6>, <&dmac4 0x1db0>;
> +					dma-names =3D "rx", "tx", "rx", "tx", "rx", "tx", "rx", "tx", "rx",=
 "tx";
> +				};
> +				src8: src-8 {
> +					interrupts =3D <GIC_SPI 910 IRQ_TYPE_LEVEL_HIGH>;
> +					dmas =3D <&dmac0 0x1da7>, <&dmac0 0x1db1>,
> +					       <&dmac1 0x1da7>, <&dmac1 0x1db1>,
> +					       <&dmac2 0x1da7>, <&dmac2 0x1db1>,
> +					       <&dmac3 0x1da7>, <&dmac3 0x1db1>,
> +					       <&dmac4 0x1da7>, <&dmac4 0x1db1>;
> +					dma-names =3D "rx", "tx", "rx", "tx", "rx", "tx", "rx", "tx", "rx",=
 "tx";
> +				};
> +				src9: src-9 {
> +					interrupts =3D <GIC_SPI 911 IRQ_TYPE_LEVEL_HIGH>;
> +					dmas =3D <&dmac0 0x1da8>, <&dmac0 0x1db2>,
> +					       <&dmac1 0x1da8>, <&dmac1 0x1db2>,
> +					       <&dmac2 0x1da8>, <&dmac2 0x1db2>,
> +					       <&dmac3 0x1da8>, <&dmac3 0x1db2>,
> +					       <&dmac4 0x1da8>, <&dmac4 0x1db2>;
> +					dma-names =3D "rx", "tx", "rx", "tx", "rx", "tx", "rx", "tx", "rx",=
 "tx";
> +				};
> +			};
> +
> +			rcar_sound,ssi {
> +				ssi0: ssi-0 {
> +					interrupts =3D <GIC_SPI 889 IRQ_TYPE_LEVEL_HIGH>;
> +				};
> +				ssi1: ssi-1 {
> +					interrupts =3D <GIC_SPI 890 IRQ_TYPE_LEVEL_HIGH>;
> +				};
> +				ssi2: ssi-2 {
> +					interrupts =3D <GIC_SPI 891 IRQ_TYPE_LEVEL_HIGH>;
> +				};
> +				ssi3: ssi-3 {
> +					interrupts =3D <GIC_SPI 892 IRQ_TYPE_LEVEL_HIGH>;
> +				};
> +				ssi4: ssi-4 {
> +					interrupts =3D <GIC_SPI 893 IRQ_TYPE_LEVEL_HIGH>;
> +				};
> +				ssi5: ssi-5 {
> +					interrupts =3D <GIC_SPI 894 IRQ_TYPE_LEVEL_HIGH>;
> +				};
> +				ssi6: ssi-6 {
> +					interrupts =3D <GIC_SPI 895 IRQ_TYPE_LEVEL_HIGH>;
> +				};
> +				ssi7: ssi-7 {
> +					interrupts =3D <GIC_SPI 896 IRQ_TYPE_LEVEL_HIGH>;
> +				};
> +				ssi8: ssi-8 {
> +					interrupts =3D <GIC_SPI 897 IRQ_TYPE_LEVEL_HIGH>;
> +				};
> +				ssi9: ssi-9 {
> +					interrupts =3D <GIC_SPI 898 IRQ_TYPE_LEVEL_HIGH>;
> +				};
> +			};
> +
> +			rcar_sound,ssiu {
> +				ssiu00: ssiu-0 {
> +					dmas =3D <&dmac0 0x1d61>, <&dmac0 0x1d62>,
> +					       <&dmac1 0x1d61>, <&dmac1 0x1d62>,
> +					       <&dmac2 0x1d61>, <&dmac2 0x1d62>,
> +					       <&dmac3 0x1d61>, <&dmac3 0x1d62>,
> +					       <&dmac4 0x1d61>, <&dmac4 0x1d62>;
> +					dma-names =3D "tx", "rx", "tx", "rx", "tx", "rx", "tx", "rx", "tx",=
 "rx";
> +				};
> +				ssiu01: ssiu-1 {
> +					dmas =3D <&dmac0 0x1d63>, <&dmac0 0x1d64>,
> +					       <&dmac1 0x1d63>, <&dmac1 0x1d64>,
> +					       <&dmac2 0x1d63>, <&dmac2 0x1d64>,
> +					       <&dmac3 0x1d63>, <&dmac3 0x1d64>,
> +					       <&dmac4 0x1d63>, <&dmac4 0x1d64>;
> +					dma-names =3D "tx", "rx", "tx", "rx", "tx", "rx", "tx", "rx", "tx",=
 "rx";
> +				};
> +				ssiu02: ssiu-2 {
> +					dmas =3D <&dmac0 0x1d65>, <&dmac0 0x1d66>,
> +					       <&dmac1 0x1d65>, <&dmac1 0x1d66>,
> +					       <&dmac2 0x1d65>, <&dmac2 0x1d66>,
> +					       <&dmac3 0x1d65>, <&dmac3 0x1d66>,
> +					       <&dmac4 0x1d65>, <&dmac4 0x1d66>;
> +					dma-names =3D "tx", "rx", "tx", "rx", "tx", "rx", "tx", "rx", "tx",=
 "rx";
> +				};
> +				ssiu03: ssiu-3 {
> +					dmas =3D <&dmac0 0x1d67>, <&dmac0 0x1d68>,
> +					       <&dmac1 0x1d67>, <&dmac1 0x1d68>,
> +					       <&dmac2 0x1d67>, <&dmac2 0x1d68>,
> +					       <&dmac3 0x1d67>, <&dmac3 0x1d68>,
> +					       <&dmac4 0x1d67>, <&dmac4 0x1d68>;
> +					dma-names =3D "tx", "rx", "tx", "rx", "tx", "rx", "tx", "rx", "tx",=
 "rx";
> +				};
> +				ssiu10: ssiu-4 {
> +					dmas =3D <&dmac0 0x1d69>, <&dmac0 0x1d6a>,
> +					       <&dmac1 0x1d69>, <&dmac1 0x1d6a>,
> +					       <&dmac2 0x1d69>, <&dmac2 0x1d6a>,
> +					       <&dmac3 0x1d69>, <&dmac3 0x1d6a>,
> +					       <&dmac4 0x1d69>, <&dmac4 0x1d6a>;
> +					dma-names =3D "tx", "rx", "tx", "rx", "tx", "rx", "tx", "rx", "tx",=
 "rx";
> +				};
> +				ssiu11: ssiu-5 {
> +					dmas =3D <&dmac0 0x1d6b>, <&dmac0 0x1d6c>,
> +					       <&dmac1 0x1d6b>, <&dmac1 0x1d6c>,
> +					       <&dmac2 0x1d6b>, <&dmac2 0x1d6c>,
> +					       <&dmac3 0x1d6b>, <&dmac3 0x1d6c>,
> +					       <&dmac4 0x1d6b>, <&dmac4 0x1d6c>;
> +					dma-names =3D "tx", "rx", "tx", "rx", "tx", "rx", "tx", "rx", "tx",=
 "rx";
> +				};
> +				ssiu12: ssiu-6 {
> +					dmas =3D <&dmac0 0x1d6d>, <&dmac0 0x1d6e>,
> +					       <&dmac1 0x1d6d>, <&dmac1 0x1d6e>,
> +					       <&dmac2 0x1d6d>, <&dmac2 0x1d6e>,
> +					       <&dmac3 0x1d6d>, <&dmac3 0x1d6e>,
> +					       <&dmac4 0x1d6d>, <&dmac4 0x1d6e>;
> +					dma-names =3D "tx", "rx", "tx", "rx", "tx", "rx", "tx", "rx", "tx",=
 "rx";
> +				};
> +				ssiu13: ssiu-7 {
> +					dmas =3D <&dmac0 0x1d6f>, <&dmac0 0x1d70>,
> +					       <&dmac1 0x1d6f>, <&dmac1 0x1d70>,
> +					       <&dmac2 0x1d6f>, <&dmac2 0x1d70>,
> +					       <&dmac3 0x1d6f>, <&dmac3 0x1d70>,
> +					       <&dmac4 0x1d6f>, <&dmac4 0x1d70>;
> +					dma-names =3D "tx", "rx", "tx", "rx", "tx", "rx", "tx", "rx", "tx",=
 "rx";
> +				};
> +				ssiu20: ssiu-8 {
> +					dmas =3D <&dmac0 0x1d71>, <&dmac0 0x1d72>,
> +					       <&dmac1 0x1d71>, <&dmac1 0x1d72>,
> +					       <&dmac2 0x1d71>, <&dmac2 0x1d72>,
> +					       <&dmac3 0x1d71>, <&dmac3 0x1d72>,
> +					       <&dmac4 0x1d71>, <&dmac4 0x1d72>;
> +					dma-names =3D "tx", "rx", "tx", "rx", "tx", "rx", "tx", "rx", "tx",=
 "rx";
> +				};
> +				ssiu21: ssiu-9 {
> +					dmas =3D <&dmac0 0x1d73>, <&dmac0 0x1d74>,
> +					       <&dmac1 0x1d73>, <&dmac1 0x1d74>,
> +					       <&dmac2 0x1d73>, <&dmac2 0x1d74>,
> +					       <&dmac3 0x1d73>, <&dmac3 0x1d74>,
> +					       <&dmac4 0x1d73>, <&dmac4 0x1d74>;
> +					dma-names =3D "tx", "rx", "tx", "rx", "tx", "rx", "tx", "rx", "tx",=
 "rx";
> +				};
> +				ssiu22: ssiu-10 {
> +					dmas =3D <&dmac0 0x1d75>, <&dmac0 0x1d76>,
> +					       <&dmac1 0x1d75>, <&dmac1 0x1d76>,
> +					       <&dmac2 0x1d75>, <&dmac2 0x1d76>,
> +					       <&dmac3 0x1d75>, <&dmac3 0x1d76>,
> +					       <&dmac4 0x1d75>, <&dmac4 0x1d76>;
> +					dma-names =3D "tx", "rx", "tx", "rx", "tx", "rx", "tx", "rx", "tx",=
 "rx";
> +				};
> +				ssiu23: ssiu-11 {
> +					dmas =3D <&dmac0 0x1d77>, <&dmac0 0x1d78>,
> +					       <&dmac1 0x1d77>, <&dmac1 0x1d78>,
> +					       <&dmac2 0x1d77>, <&dmac2 0x1d78>,
> +					       <&dmac3 0x1d77>, <&dmac3 0x1d78>,
> +					       <&dmac4 0x1d77>, <&dmac4 0x1d78>;
> +					dma-names =3D "tx", "rx", "tx", "rx", "tx", "rx", "tx", "rx", "tx",=
 "rx";
> +				};
> +				ssiu30: ssiu-12 {
> +					dmas =3D <&dmac0 0x1d79>, <&dmac0 0x1d7a>,
> +					       <&dmac1 0x1d79>, <&dmac1 0x1d7a>,
> +					       <&dmac2 0x1d79>, <&dmac2 0x1d7a>,
> +					       <&dmac3 0x1d79>, <&dmac3 0x1d7a>,
> +					       <&dmac4 0x1d79>, <&dmac4 0x1d7a>;
> +					dma-names =3D "tx", "rx", "tx", "rx", "tx", "rx", "tx", "rx", "tx",=
 "rx";
> +				};
> +				ssiu31: ssiu-13 {
> +					dmas =3D <&dmac0 0x1d7b>, <&dmac0 0x1d7c>,
> +					       <&dmac1 0x1d7b>, <&dmac1 0x1d7c>,
> +					       <&dmac2 0x1d7b>, <&dmac2 0x1d7c>,
> +					       <&dmac3 0x1d7b>, <&dmac3 0x1d7c>,
> +					       <&dmac4 0x1d7b>, <&dmac4 0x1d7c>;
> +					dma-names =3D "tx", "rx", "tx", "rx", "tx", "rx", "tx", "rx", "tx",=
 "rx";
> +				};
> +				ssiu32: ssiu-14 {
> +					dmas =3D <&dmac0 0x1d7d>, <&dmac0 0x1d7e>,
> +					       <&dmac1 0x1d7d>, <&dmac1 0x1d7e>,
> +					       <&dmac2 0x1d7d>, <&dmac2 0x1d7e>,
> +					       <&dmac3 0x1d7d>, <&dmac3 0x1d7e>,
> +					       <&dmac4 0x1d7d>, <&dmac4 0x1d7e>;
> +					dma-names =3D "tx", "rx", "tx", "rx", "tx", "rx", "tx", "rx", "tx",=
 "rx";
> +				};
> +				ssiu33: ssiu-15 {
> +					dmas =3D <&dmac0 0x1d7f>, <&dmac0 0x1d80>,
> +					       <&dmac1 0x1d7f>, <&dmac1 0x1d80>,
> +					       <&dmac2 0x1d7f>, <&dmac2 0x1d80>,
> +					       <&dmac3 0x1d7f>, <&dmac3 0x1d80>,
> +					       <&dmac4 0x1d7f>, <&dmac4 0x1d80>;
> +					dma-names =3D "tx", "rx", "tx", "rx", "tx", "rx", "tx", "rx", "tx",=
 "rx";
> +				};
> +				ssiu40: ssiu-16 {
> +					dmas =3D <&dmac0 0x1d81>, <&dmac0 0x1d82>,
> +					       <&dmac1 0x1d81>, <&dmac1 0x1d82>,
> +					       <&dmac2 0x1d81>, <&dmac2 0x1d82>,
> +					       <&dmac3 0x1d81>, <&dmac3 0x1d82>,
> +					       <&dmac4 0x1d81>, <&dmac4 0x1d82>;
> +					dma-names =3D "tx", "rx", "tx", "rx", "tx", "rx", "tx", "rx", "tx",=
 "rx";
> +				};
> +				ssiu41: ssiu-17 {
> +					dmas =3D <&dmac0 0x1d83>, <&dmac0 0x1d84>,
> +					       <&dmac1 0x1d83>, <&dmac1 0x1d84>,
> +					       <&dmac2 0x1d83>, <&dmac2 0x1d84>,
> +					       <&dmac3 0x1d83>, <&dmac3 0x1d84>,
> +					       <&dmac4 0x1d83>, <&dmac4 0x1d84>;
> +					dma-names =3D "tx", "rx", "tx", "rx", "tx", "rx", "tx", "rx", "tx",=
 "rx";
> +				};
> +				ssiu42: ssiu-18 {
> +					dmas =3D <&dmac0 0x1d85>, <&dmac0 0x1d86>,
> +					       <&dmac1 0x1d85>, <&dmac1 0x1d86>,
> +					       <&dmac2 0x1d85>, <&dmac2 0x1d86>,
> +					       <&dmac3 0x1d85>, <&dmac3 0x1d86>,
> +					       <&dmac4 0x1d85>, <&dmac4 0x1d86>;
> +					dma-names =3D "tx", "rx", "tx", "rx", "tx", "rx", "tx", "rx", "tx",=
 "rx";
> +				};
> +				ssiu43: ssiu-19 {
> +					dmas =3D <&dmac0 0x1d87>, <&dmac0 0x1d88>,
> +					       <&dmac1 0x1d87>, <&dmac1 0x1d88>,
> +					       <&dmac2 0x1d87>, <&dmac2 0x1d88>,
> +					       <&dmac3 0x1d87>, <&dmac3 0x1d88>,
> +					       <&dmac4 0x1d87>, <&dmac4 0x1d88>;
> +					dma-names =3D "tx", "rx", "tx", "rx", "tx", "rx", "tx", "rx", "tx",=
 "rx";
> +				};
> +				ssiu50: ssiu-20 {
> +					dmas =3D <&dmac0 0x1d89>, <&dmac0 0x1d8a>,
> +					       <&dmac1 0x1d89>, <&dmac1 0x1d8a>,
> +					       <&dmac2 0x1d89>, <&dmac2 0x1d8a>,
> +					       <&dmac3 0x1d89>, <&dmac3 0x1d8a>,
> +					       <&dmac4 0x1d89>, <&dmac4 0x1d8a>;
> +					dma-names =3D "tx", "rx", "tx", "rx", "tx", "rx", "tx", "rx", "tx",=
 "rx";
> +				};
> +				ssiu60: ssiu-21 {
> +					dmas =3D <&dmac0 0x1d8b>, <&dmac0 0x1d8c>,
> +					       <&dmac1 0x1d8b>, <&dmac1 0x1d8c>,
> +					       <&dmac2 0x1d8b>, <&dmac2 0x1d8c>,
> +					       <&dmac3 0x1d8b>, <&dmac3 0x1d8c>,
> +					       <&dmac4 0x1d8b>, <&dmac4 0x1d8c>;
> +					dma-names =3D "tx", "rx", "tx", "rx", "tx", "rx", "tx", "rx", "tx",=
 "rx";
> +				};
> +				ssiu70: ssiu-22 {
> +					dmas =3D <&dmac0 0x1d8d>, <&dmac0 0x1d8e>,
> +					       <&dmac1 0x1d8d>, <&dmac1 0x1d8e>,
> +					       <&dmac2 0x1d8d>, <&dmac2 0x1d8e>,
> +					       <&dmac3 0x1d8d>, <&dmac3 0x1d8e>,
> +					       <&dmac4 0x1d8d>, <&dmac4 0x1d8e>;
> +					dma-names =3D "tx", "rx", "tx", "rx", "tx", "rx", "tx", "rx", "tx",=
 "rx";
> +				};
> +				ssiu80: ssiu-23 {
> +					dmas =3D <&dmac0 0x1d8f>, <&dmac0 0x1d90>,
> +					       <&dmac1 0x1d8f>, <&dmac1 0x1d90>,
> +					       <&dmac2 0x1d8f>, <&dmac2 0x1d90>,
> +					       <&dmac3 0x1d8f>, <&dmac3 0x1d90>,
> +					       <&dmac4 0x1d8f>, <&dmac4 0x1d90>;
> +					dma-names =3D "tx", "rx", "tx", "rx", "tx", "rx", "tx", "rx", "tx",=
 "rx";
> +				};
> +				ssiu90: ssiu-24 {
> +					dmas =3D <&dmac0 0x1d91>, <&dmac0 0x1d92>,
> +					<&dmac1 0x1d91>, <&dmac1 0x1d92>,
> +					<&dmac2 0x1d91>, <&dmac2 0x1d92>,
> +					<&dmac3 0x1d91>, <&dmac3 0x1d92>,
> +					<&dmac4 0x1d91>, <&dmac4 0x1d92>;
> +					dma-names =3D "tx", "rx", "tx", "rx", "tx", "rx", "tx", "rx", "tx",=
 "rx";
> +				};
> +				ssiu91: ssiu-25 {
> +					dmas =3D <&dmac0 0x1d93>, <&dmac0 0x1d94>,
> +					       <&dmac1 0x1d93>, <&dmac1 0x1d94>,
> +					       <&dmac2 0x1d93>, <&dmac2 0x1d94>,
> +					       <&dmac3 0x1d93>, <&dmac3 0x1d94>,
> +					       <&dmac4 0x1d93>, <&dmac4 0x1d94>;
> +					dma-names =3D "tx", "rx", "tx", "rx", "tx", "rx", "tx", "rx", "tx",=
 "rx";
> +				};
> +				ssiu92: ssiu-26 {
> +					dmas =3D <&dmac0 0x1d95>, <&dmac0 0x1d96>,
> +					       <&dmac1 0x1d95>, <&dmac1 0x1d96>,
> +					       <&dmac2 0x1d95>, <&dmac2 0x1d96>,
> +					       <&dmac3 0x1d95>, <&dmac3 0x1d96>,
> +					       <&dmac4 0x1d95>, <&dmac4 0x1d96>;
> +					dma-names =3D "tx", "rx", "tx", "rx", "tx", "rx", "tx", "rx", "tx",=
 "rx";
> +				};
> +				ssiu93: ssiu-27 {
> +					dmas =3D <&dmac0 0x1d97>, <&dmac0 0x1d98>,
> +					       <&dmac1 0x1d97>, <&dmac1 0x1d98>,
> +					       <&dmac2 0x1d97>, <&dmac2 0x1d98>,
> +					       <&dmac3 0x1d97>, <&dmac3 0x1d98>,
> +					       <&dmac4 0x1d97>, <&dmac4 0x1d98>;
> +					dma-names =3D "tx", "rx", "tx", "rx", "tx", "rx", "tx", "rx", "tx",=
 "rx";
> +				};
> +			};
> +		};
> +
>  		wdt1: watchdog@14400000 {
>  			compatible =3D "renesas,r9a09g047-wdt", "renesas,r9a09g057-wdt";
>  			reg =3D <0 0x14400000 0 0x400>;
> --
> 2.25.1


