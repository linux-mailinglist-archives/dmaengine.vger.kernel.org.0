Return-Path: <dmaengine+bounces-9997-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YJKnM+A72mkqzQgAu9opvQ
	(envelope-from <dmaengine+bounces-9997-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Sat, 11 Apr 2026 14:17:36 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DBAE3DFD35
	for <lists+dmaengine@lfdr.de>; Sat, 11 Apr 2026 14:17:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C44FA30058EF
	for <lists+dmaengine@lfdr.de>; Sat, 11 Apr 2026 12:17:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DA7535979;
	Sat, 11 Apr 2026 12:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="TIqofqDU"
X-Original-To: dmaengine@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010047.outbound.protection.outlook.com [52.101.229.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D5EE28DB49;
	Sat, 11 Apr 2026 12:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775909854; cv=fail; b=UClhZcZL2umJQ8qCgTZR7kcHaUHEJN8+Q2EMk5JTp2dPABWwJQOBJq/d5ra16YjmkjHCi6yKBH8koiyJGEmww0KJ05dCAChdSepGFlff+rLADHSzIyfuBBRp4BqwWz/Rs/f8ZZRjxmsC+/m2z98LqemxrzqtWOI3uPY+yvhwq9U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775909854; c=relaxed/simple;
	bh=f1z19mMNGv45FYfWS9sUjM/dqVv+2AKvqmJmC4lmMVw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SQ8X0yUKYINOjgBYkZp6J3Sgedix8i96bZRbZkv/e4uSdEQvEP1JVRBwqGUia5HGrhIsejkQmzBnT+aQzTOrpB6BsWye7NlWBLFE7PYBfNnr3TwJxuWxVUaV2n+sl9bKzE0udLWFYAvqvl7rzSoVTdI8y4pCAiDmVm2SSbBQoJ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=TIqofqDU; arc=fail smtp.client-ip=52.101.229.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bO6zDy1zkOAN/xMi+v2ZibDlyaUvyTg3xzAlzWZO9x8DtG8fTWnVAenR8SEfugYckj0POxfE3Yu+43QxiVFREhaIoagfaXikU+RyIPjLLnLa6jYznTfJrINZ2RydDmL8EqC7QbgX3XHTFuAb+DWc2kJUoXxCR7C3Tu6j3oGprRQIcpOBMp2Cu6WrxkmJnk7cKqnEsUyTCzUmWbkGQH6Fz08qpvneExr4B9HLeSCEblAC+LIxIDLWMja3Yg3faZp4/dJgTvRwNr3s4l6aBbAiYqqhoKflXnqL4aiHluLkMmWQ3t15P3EpAi8abdGlnxAicsPjflkvDT6rUc60gyh4Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JFmZ6bv6n5nMt/8tvun5jnFSAyvKjdN8FF1LjV6dpPg=;
 b=xkz2V1qZfMT4D4NzeF5epu15dsA+9EHp6cCEu8Gb6KNJMVZrBS6svUEcU/quqSRvCt5oAbdEgFCVOIL2R6ycibeEJqv7w4ZDfEuKbjB/8kyVzH9QnvMxddcjpxZH3sOEOh8csE13h9uwffW+wBUzQK0VERYb7r/Sb/DWyjDQzOUz/cOtwOTVEWIVgIp8UcKGwU7/NQEIHTIwScEufHowxi+KCTBm7N9yUDt3asGvCAUjvQSaIaSPPrtrwqhDHDLwuuL5l0NxGzfPhX8ebvTGJK/Flzl9v5mk30UbPaaxtPvC+/S7KuOXgvVfxv3nyHZyhqishY1lMH+A/vdKICkOWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JFmZ6bv6n5nMt/8tvun5jnFSAyvKjdN8FF1LjV6dpPg=;
 b=TIqofqDUAdxa8fIpRC7KTnWe0zmv+LC7X/UH6fXffWfADg+IFrtm9oq1HA/1rpVcJ+foLtqttcj0Lt0w/eX1YdBlYjkxoBuFsRN/uSmoSzfR+q5p52kBkZUIRsj0CyHOyb2eS2pmMJCNICrvOt3Bp+m/pPJ1tpxdQ/moO/7gv90=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by TY7PR01MB16202.jpnprd01.prod.outlook.com (2603:1096:405:2a5::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.46; Sat, 11 Apr
 2026 12:17:28 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de%4]) with mapi id 15.20.9769.044; Sat, 11 Apr 2026
 12:17:22 +0000
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
CC: Claudiu.Beznea <claudiu.beznea@tuxon.dev>, "dmaengine@vger.kernel.org"
	<dmaengine@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-sound@vger.kernel.org"
	<linux-sound@vger.kernel.org>, "linux-renesas-soc@vger.kernel.org"
	<linux-renesas-soc@vger.kernel.org>, Claudiu Beznea
	<claudiu.beznea.uj@bp.renesas.com>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: RE: [PATCH v4 01/17] dmaengine: sh: rz-dmac: Move interrupt request
 after everything is set up
Thread-Topic: [PATCH v4 01/17] dmaengine: sh: rz-dmac: Move interrupt request
 after everything is set up
Thread-Index: AQHcyahiz+SdwnhzG0G8pYFiMDq51LXZxd6g
Date: Sat, 11 Apr 2026 12:17:22 +0000
Message-ID:
 <TY3PR01MB11346F56B1A311E46053EDB3486262@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20260411114303.2814115-1-claudiu.beznea.uj@bp.renesas.com>
 <20260411114303.2814115-2-claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20260411114303.2814115-2-claudiu.beznea.uj@bp.renesas.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|TY7PR01MB16202:EE_
x-ms-office365-filtering-correlation-id: 0a4f1650-bee3-468c-fe33-08de97c448c4
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700021|921020|22082099003|18002099003|56012099003;
x-microsoft-antispam-message-info:
 /BYV8SCl7GjyyGlxgtFCZivFCnj2sTFS2ofOGsAsO8nUACMY5efFlAy0d1lrMalfVsBaZpffvRpsjkMF4L6iGHefql8WA6DYflTkCWX5ei1Cg+bkuoBabPrWh4fBFmoI9PY58D8qkO6KlIfGb5+qFUEr17ti/zjQDzrI/GbQnHElNekBQ2aB+JhF9CG2MdS4js/ZCyRwDL/srTwL9YmaCw6GopREo2/Y0LEYZ+01Q6/oV+oIDnkWmdXMKw+JqjjSSziohswg7qmXEX9t6RSss3ytTBz6RO3+pvLH+ZDdo22SEkl2dF/GJmJQ+Hzr6SlVbg50WPue8TrHqt9mfjqPheGv0+PgECfLLpTiI75OpX9lJBEX/GFktFncWLpRz9txlUDISdI11S/fT/muXmVtI0jXa4UktDD7wKH4LcJQqYKrIB1U8+pE7VuQQEVfD+LnyfCSn+XPS77SF1G71UPK2LBSWDLDuWV4H5R7QEBLpKyzoo/4tcLmXDI0onOpMKmFVn8gH1uNtOlGkrM6NSClV7F2inrQarfADKEFld0PuZRBLHXlB43j3+JXlp/BLZ88XvhigQ7XzuLvPSKVzBirhD6Q7w7edlI4Gk3z1x7kr4fE2g8TlMf62mMvZHN+EI0sqc7rs9PH1IdBFJRKVbF1Cm2STkPbk5RE/mqEW11AWHWvezTmuHp2RAd0JXsbcMWfTD/NUZmrcDQOLg6qQTB3wPq1Nf1RYFylVMR+ZCrMyUGujnwAl4VvxnIEm+/VlOy+Ko1i6nPP058deowRK1/jzA==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700021)(921020)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?PPDCDrEqeSIGMBzsyNle6NocCStgbMa9Z0mRy6Kr1BSSdGJ9KKZhGAiAUHQf?=
 =?us-ascii?Q?QjgQuRzP5Z4e/3vnVHsvdNPQC1VFucZbwNyeOHm1cyeSIWH5JZMyn7uALR3l?=
 =?us-ascii?Q?DBvynM5r0c/XcZT83wApQFZg8BSOG9m5TDJ2rSWKSgv4kZQJ8DNlA8CMmrIO?=
 =?us-ascii?Q?f6dwmBCI/SnBH7QzV5eZXhKNBigXhJOniZIsJBO3z1buCNyFCq6+b4kOYEjU?=
 =?us-ascii?Q?FRSil54S+4NXr6PCkoGbbWw6MwpUe8mtIL92JNg4wVYXRQ/6DpR2OfDOFPMx?=
 =?us-ascii?Q?9vcULEkzcYEO9+CoCC9OFmdrrfmGm3OokvElVQC8I/vbtPLqS1J2RVYAxFmk?=
 =?us-ascii?Q?vIU3Fs6HCG7/ScK0z+jA+YDHvshcrn5UVDWAnRANRTyMnak3Zt5z7qcbxOuu?=
 =?us-ascii?Q?glICJSwAkL2y10tM7WnmyKKhBsa6PVVdNYTDbw3X/HqvbhlEnbsZK5B16dQh?=
 =?us-ascii?Q?eRCTL79qDQvKWfrai5DB2uP2pO95iOncfKtChFipl5J48W823x2SAjw1u8WK?=
 =?us-ascii?Q?PHXczCBPyzfMmEIkFrQbWPWAv9zjeY3LCRtrVfUXs2vfzIP0pA0hajG299gx?=
 =?us-ascii?Q?VNbErUzVOm/p06XZJMvmfJ/AktNjgEUgniWS7k8uN63lXyMlSfIq9J9pak6l?=
 =?us-ascii?Q?JA5SG35dfv9ghios8OcRGbKo04NTY6yMLm5WYjRe6iKRyLCLAwgu9rOPF+Tb?=
 =?us-ascii?Q?dVUricMFZq2miGe9Nk09qQLQp5GToftLgrtjDCSpn/0Ud1CWAWRoVVE4hXGI?=
 =?us-ascii?Q?fIbTTQQIaRGBi+vDyX6u6EWkkDoYYqqzxDRRSDyCNRbqB0oHDOLK4rKFFu6U?=
 =?us-ascii?Q?s+fQO/OsjXi6H2vW96lvttRjheKT/zTnBG9O/e5yR0YcESnpawfbthT2zetE?=
 =?us-ascii?Q?GfF/kty07Am4gBbRjn6BWOgdQKeCH53a9sfos3v7jMYYuh4bWQxu59FQJJJr?=
 =?us-ascii?Q?z294ein3Vyp+b0Bwyqhl5loatWPn0fzJhYMsb0zMORQTMskNPezVxMKv/Pia?=
 =?us-ascii?Q?wy2DefRb58aw1PxPBHRo1ZZnE7nYPghMwNiTP6HD+Uw541+3bzaGIYnwRR/l?=
 =?us-ascii?Q?yXEWRK0RIi+XTotd5ZajhjCiTySfayEymUfibTBgDRZ7KsGAUd8OrV9Xlun3?=
 =?us-ascii?Q?GaUW2hpS+WgT8LVUwLlIO+IdOnJ7QiZv7IPi6HHuTBMmFy+UVQEpZ+sUg4sx?=
 =?us-ascii?Q?cPu3FBuqegHbZgXYwIPRSwFyrrFr8a/l1XL9Gb7FsiVjIqJhZ+fjkuSQJ0bI?=
 =?us-ascii?Q?FVGbpPR5mEM86lKjrlQk52mpHBm92xFncsPQBmV8waG2zUkAypzQqoeVaxBm?=
 =?us-ascii?Q?2pyx9lieRypw0kflERxO4H57xOiCt8gm+fqN1R1mp8rOxYMLaUwSb1REIjWd?=
 =?us-ascii?Q?dMoYb4zLoyUrUjUfsnYzvnE9/XBJg4iHuOXn9JrpYjMP12PW3X6MF0sqjG76?=
 =?us-ascii?Q?bj33EzIefAgeroPhgOjLghMdSCqpdKyn0IBEyiQkVgnEUUmETtO3pdGtz1nZ?=
 =?us-ascii?Q?w89nijL4vAj578vv2HRlMMwj6QrLT+iQEZ4HWDCOcMEYWNRdOe7vNSwzZsoQ?=
 =?us-ascii?Q?FEQheSIqgQ8e8UkpDTIr9JNVfqNR2Blku+3RLX7zCsVSRLYtL8wR1erhpIGb?=
 =?us-ascii?Q?u/UfKHJAc2xhwcoldqsj4rQihuj5oKA/1o99C0Ne5qbFQLTrGOSsuW/31FDj?=
 =?us-ascii?Q?CInlStmsztmatLaOiG/vj7oUbSSY6QMQh6v1XyaNeD95/jJFLmRDY9Ya8uD7?=
 =?us-ascii?Q?TYsdgqC5yQ=3D=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11346.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a4f1650-bee3-468c-fe33-08de97c448c4
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2026 12:17:22.3048
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vMYRUPG4mHAH+MZ2J8Oi+ps+VcgHqmuxQZRhTHxovpaWLnIfNv1kwBp9OmCIJlDBDRhzbJ2PnwLkB3R+bibLUZZBDIXSQjOc4hJfKAiE9DA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY7PR01MB16202
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[renesas.com,none];
	R_DKIM_ALLOW(-0.20)[bp.renesas.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9997-lists,dmaengine=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[tuxon.dev,kernel.org,gmail.com,perex.cz,suse.com,bp.renesas.com,pengutronix.de,glider.be,renesas.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[biju.das.jz@bp.renesas.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[bp.renesas.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[dmaengine,renesas];
	NEURAL_HAM(-0.00)[-1.000];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,renesas.com:email,bp.renesas.com:dkim,tuxon.dev:email]
X-Rspamd-Queue-Id: 6DBAE3DFD35
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



> -----Original Message-----
> From: Claudiu <claudiu.beznea@tuxon.dev>
> Sent: 11 April 2026 12:43
> Subject: [PATCH v4 01/17] dmaengine: sh: rz-dmac: Move interrupt request =
after everything is set up
>=20
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>=20
> Once the interrupt is requested, the interrupt handler may run immediatel=
y.
> Since the IRQ handler can access channel->ch_base, which is initialized o=
nly after requesting the IRQ,
> this may lead to invalid memory access.
> Likewise, the IRQ thread may access uninitialized data (the ld_free, ld_q=
ueue, and ld_active lists),
> which may also lead to issues.
>=20
> Request the interrupts only after everything is set up. To keep the error=
 path simpler, use
> dmam_alloc_coherent() instead of dma_alloc_coherent().
>=20
> Fixes: 5000d37042a6 ("dmaengine: sh: Add DMAC driver for RZ/G2L SoC")
> Cc: stable@vger.kernel.org
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> ---
>=20
> Changes in v4:
> - none, this patch is new
>=20
>  drivers/dma/sh/rz-dmac.c | 88 +++++++++++++++-------------------------
>  1 file changed, 33 insertions(+), 55 deletions(-)
>=20
> diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c index 62=
5ff29024de..9f206a33dcc6
> 100644
> --- a/drivers/dma/sh/rz-dmac.c
> +++ b/drivers/dma/sh/rz-dmac.c
> @@ -981,25 +981,6 @@ static int rz_dmac_chan_probe(struct rz_dmac *dmac,
>  	channel->index =3D index;
>  	channel->mid_rid =3D -EINVAL;
>=20
> -	/* Request the channel interrupt. */
> -	scnprintf(pdev_irqname, sizeof(pdev_irqname), "ch%u", index);
> -	irq =3D platform_get_irq_byname(pdev, pdev_irqname);
> -	if (irq < 0)
> -		return irq;
> -
> -	irqname =3D devm_kasprintf(dmac->dev, GFP_KERNEL, "%s:%u",
> -				 dev_name(dmac->dev), index);
> -	if (!irqname)
> -		return -ENOMEM;
> -
> -	ret =3D devm_request_threaded_irq(dmac->dev, irq, rz_dmac_irq_handler,
> -					rz_dmac_irq_handler_thread, 0,
> -					irqname, channel);
> -	if (ret) {
> -		dev_err(dmac->dev, "failed to request IRQ %u (%d)\n", irq, ret);
> -		return ret;
> -	}
> -
>  	/* Set io base address for each channel */
>  	if (index < 8) {
>  		channel->ch_base =3D dmac->base + CHANNEL_0_7_OFFSET + @@ -1012,9 +993=
,9 @@ static int
> rz_dmac_chan_probe(struct rz_dmac *dmac,
>  	}
>=20
>  	/* Allocate descriptors */
> -	lmdesc =3D dma_alloc_coherent(&pdev->dev,
> -				    sizeof(struct rz_lmdesc) * DMAC_NR_LMDESC,
> -				    &channel->lmdesc.base_dma, GFP_KERNEL);
> +	lmdesc =3D dmam_alloc_coherent(&pdev->dev,
> +				     sizeof(struct rz_lmdesc) * DMAC_NR_LMDESC,
> +				     &channel->lmdesc.base_dma, GFP_KERNEL);
>  	if (!lmdesc) {
>  		dev_err(&pdev->dev, "Can't allocate memory (lmdesc)\n");
>  		return -ENOMEM;
> @@ -1030,7 +1011,24 @@ static int rz_dmac_chan_probe(struct rz_dmac *dmac=
,
>  	INIT_LIST_HEAD(&channel->ld_free);
>  	INIT_LIST_HEAD(&channel->ld_active);
>=20
> -	return 0;
> +	/* Request the channel interrupt. */
> +	scnprintf(pdev_irqname, sizeof(pdev_irqname), "ch%u", index);
> +	irq =3D platform_get_irq_byname(pdev, pdev_irqname);
> +	if (irq < 0)
> +		return irq;
> +
> +	irqname =3D devm_kasprintf(dmac->dev, GFP_KERNEL, "%s:%u",
> +				 dev_name(dmac->dev), index);
> +	if (!irqname)
> +		return -ENOMEM;
> +
> +	ret =3D devm_request_threaded_irq(dmac->dev, irq, rz_dmac_irq_handler,
> +					rz_dmac_irq_handler_thread, 0,
> +					irqname, channel);
> +	if (ret)
> +		dev_err(dmac->dev, "failed to request IRQ %u (%d)\n", irq, ret);

As per [1], it is redundant.

[1]
https://elixir.bootlin.com/linux/v7.0-rc7/source/kernel/irq/devres.c#L108


> +
> +	return ret;
>  }
>=20
>  static void rz_dmac_put_device(void *_dev) @@ -1099,7 +1097,6 @@ static =
int rz_dmac_probe(struct
> platform_device *pdev)
>  	const char *irqname =3D "error";
>  	struct dma_device *engine;
>  	struct rz_dmac *dmac;
> -	int channel_num;
>  	int ret;
>  	int irq;
>  	u8 i;
> @@ -1132,18 +1129,6 @@ static int rz_dmac_probe(struct platform_device *p=
dev)
>  			return PTR_ERR(dmac->ext_base);
>  	}
>=20
> -	/* Register interrupt handler for error */
> -	irq =3D platform_get_irq_byname_optional(pdev, irqname);
> -	if (irq > 0) {
> -		ret =3D devm_request_irq(&pdev->dev, irq, rz_dmac_irq_handler, 0,
> -				       irqname, NULL);
> -		if (ret) {
> -			dev_err(&pdev->dev, "failed to request IRQ %u (%d)\n",
> -				irq, ret);
> -			return ret;
> -		}
> -	}
> -
>  	/* Initialize the channels. */
>  	INIT_LIST_HEAD(&dmac->engine.channels);
>=20
> @@ -1169,6 +1154,18 @@ static int rz_dmac_probe(struct platform_device *p=
dev)
>  			goto err;
>  	}
>=20
> +	/* Register interrupt handler for error */
> +	irq =3D platform_get_irq_byname_optional(pdev, irqname);
> +	if (irq > 0) {
> +		ret =3D devm_request_irq(&pdev->dev, irq, rz_dmac_irq_handler, 0,
> +				       irqname, NULL);
> +		if (ret) {
> +			dev_err(&pdev->dev, "failed to request IRQ %u (%d)\n",
> +				irq, ret);

Same case here

Cheers,
Biju

> +			goto err;
> +		}
> +	}
> +
>  	/* Register the DMAC as a DMA provider for DT. */
>  	ret =3D of_dma_controller_register(pdev->dev.of_node, rz_dmac_of_xlate,
>  					 NULL);
> @@ -1210,16 +1207,6 @@ static int rz_dmac_probe(struct platform_device *p=
dev)
>  dma_register_err:
>  	of_dma_controller_free(pdev->dev.of_node);
>  err:
> -	channel_num =3D i ? i - 1 : 0;
> -	for (i =3D 0; i < channel_num; i++) {
> -		struct rz_dmac_chan *channel =3D &dmac->channels[i];
> -
> -		dma_free_coherent(&pdev->dev,
> -				  sizeof(struct rz_lmdesc) * DMAC_NR_LMDESC,
> -				  channel->lmdesc.base,
> -				  channel->lmdesc.base_dma);
> -	}
> -
>  	reset_control_assert(dmac->rstc);
>  err_pm_runtime_put:
>  	pm_runtime_put(&pdev->dev);
> @@ -1232,18 +1219,9 @@ static int rz_dmac_probe(struct platform_device *p=
dev)  static void
> rz_dmac_remove(struct platform_device *pdev)  {
>  	struct rz_dmac *dmac =3D platform_get_drvdata(pdev);
> -	unsigned int i;
>=20
>  	dma_async_device_unregister(&dmac->engine);
>  	of_dma_controller_free(pdev->dev.of_node);
> -	for (i =3D 0; i < dmac->n_channels; i++) {
> -		struct rz_dmac_chan *channel =3D &dmac->channels[i];
> -
> -		dma_free_coherent(&pdev->dev,
> -				  sizeof(struct rz_lmdesc) * DMAC_NR_LMDESC,
> -				  channel->lmdesc.base,
> -				  channel->lmdesc.base_dma);
> -	}
>  	reset_control_assert(dmac->rstc);
>  	pm_runtime_put(&pdev->dev);
>  	pm_runtime_disable(&pdev->dev);
> --
> 2.43.0


