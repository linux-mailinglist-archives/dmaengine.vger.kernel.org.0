Return-Path: <dmaengine+bounces-8499-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EBmuFCtKd2mkdwEAu9opvQ
	(envelope-from <dmaengine+bounces-8499-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 26 Jan 2026 12:04:11 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E604787781
	for <lists+dmaengine@lfdr.de>; Mon, 26 Jan 2026 12:04:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 38AA4301779E
	for <lists+dmaengine@lfdr.de>; Mon, 26 Jan 2026 11:04:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F00C9331A5D;
	Mon, 26 Jan 2026 11:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="tljOAZk5"
X-Original-To: dmaengine@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011055.outbound.protection.outlook.com [40.107.74.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E41B331A40;
	Mon, 26 Jan 2026 11:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769425445; cv=fail; b=Ui+EyEIvZPMzOUwkfH5bh81xkf5X2B+wT95SjjjiDpu/XR7bW4p2qumi01O2NSGHBYbM98u2Af1JeUFdLTjum3b724prv4Iypn0D9mDlR/2+JU373PvgZ3ggvIJIKhHbOfXzhTfISqFP+f37TsCjiGbGjk1YpyvAo0B9+/v3M08=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769425445; c=relaxed/simple;
	bh=AIFs/U+/Nbm673LiQgyvELNRsU8rucfNKofqhlgE9UA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=j47imyPicdJ9NY26Sa3yTczQ+thw6ltu3RR+ud3zB3F9IN7mM1NW7BjaLjFpQnvkEuZ9VOw+Y2/72PsEe5a1pZbXwZtoPFeM4QQPWeYFixS4JGPaMzDHKoX4wdTLvwbXfXY2XoOkAX+dO4Y8H5+W3PInEReC6/9FI9Drd9YgrpM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=tljOAZk5; arc=fail smtp.client-ip=40.107.74.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hMnFg7M4gGBJtBE1jt4xoILglh7aQYuJvOrtBIAQ0dddCbHX6bGzwa9NzWw8odidkjPk2822xCvlCnbHid3DcsgF3CSdMY24Ab3DKWPIZbWWtjUUQQ3b4nS5fDid29HhwQe1kWRanQDoe2HgFsM08Da5zNN5/90YPEd+JCLeppJXly9opW/v59z9izh83Z8fAh+xaCPDNYz8cbXdvg1PTPQKAZ9CDmHWukX/xsi7O1T1fv7hPNIPOR7wGDNvSOuj24LUrBePnibTsu5u3EAB55ZfLC0EqlT8xuZxklk3eA8BYHB24tqvTbUMiWgHVtZFMdxJ+gUCxJ5/NcY4OUUvkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=av2hF1Oyp66q0lfIMlflnDkUlPTV0jxwrGcQM3MGvZw=;
 b=iZda5B4lOkKYHVsowzdEZu2eL4MV9dFXBOeg0PS7Qle5ifa7COheZAjR0CunxwvXpEIZLt1druEcdpL0ybkfDYWxXGZIOnmDXCIh5mC2gjrs53ilPDf8RmgjWtbXVeZaEdiDbneRjLMHnE0+K/iCmLaXqKLnW2ABg8ekouhCnfP/9EatqRs2EOAPKemJpCOf3PAkY5Fe5aXFHJjeLdftpnPDD8ruu816Te/7yZc9q92EEmmZoGfSCbeJBBzh7KsjLnMFPq5i7+/O66/wpE23hZIgo0odk01/bE4dKfI6PINpu7v6Qu2LrF6p1CR3NQFOSZTc+QTa9RBrdb7NshPu2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=av2hF1Oyp66q0lfIMlflnDkUlPTV0jxwrGcQM3MGvZw=;
 b=tljOAZk5nt1AfxcIk5bRuL3QPksvGxelbV7jmI7p575jMl2tjcmY/DqM04b3jzjBt0XSfLfzFerfwMn976XoseHx7kKhOlxYhFGcVfJMHuqK3mrpsEjb83+9ct07gJDoeXJNe+br+dMBC25H0rQRMXwg1Ff13BTBjglDY7SpIuI=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by TYWPR01MB11147.jpnprd01.prod.outlook.com (2603:1096:400:3f4::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Mon, 26 Jan
 2026 11:03:56 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1%6]) with mapi id 15.20.9542.015; Mon, 26 Jan 2026
 11:03:51 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Claudiu.Beznea <claudiu.beznea@tuxon.dev>, "vkoul@kernel.org"
	<vkoul@kernel.org>, Prabhakar Mahadev Lad
	<prabhakar.mahadev-lad.rj@bp.renesas.com>, "lgirdwood@gmail.com"
	<lgirdwood@gmail.com>, "broonie@kernel.org" <broonie@kernel.org>,
	"perex@perex.cz" <perex@perex.cz>, "tiwai@suse.com" <tiwai@suse.com>,
	"p.zabel@pengutronix.de" <p.zabel@pengutronix.de>, "geert+renesas@glider.be"
	<geert+renesas@glider.be>, Fabrizio Castro <fabrizio.castro.jz@renesas.com>
CC: Claudiu.Beznea <claudiu.beznea@tuxon.dev>, "dmaengine@vger.kernel.org"
	<dmaengine@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-sound@vger.kernel.org"
	<linux-sound@vger.kernel.org>, "linux-renesas-soc@vger.kernel.org"
	<linux-renesas-soc@vger.kernel.org>, Claudiu Beznea
	<claudiu.beznea.uj@bp.renesas.com>
Subject: RE: [PATCH 5/7] dmaengine: sh: rz-dmac: Add suspend to RAM support
Thread-Topic: [PATCH 5/7] dmaengine: sh: rz-dmac: Add suspend to RAM support
Thread-Index: AQHcjq8LxgsLnLJrc0+4TWo3c3gckrVkQ4/Q
Date: Mon, 26 Jan 2026 11:03:51 +0000
Message-ID:
 <TY3PR01MB113461F734BA087B60605C6FC8693A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20260126103155.2644586-1-claudiu.beznea.uj@bp.renesas.com>
 <20260126103155.2644586-6-claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20260126103155.2644586-6-claudiu.beznea.uj@bp.renesas.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|TYWPR01MB11147:EE_
x-ms-office365-filtering-correlation-id: 08395b1b-a02e-48c8-b0fa-08de5cca96c9
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700021|921020;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?/EKrgIDLPQ9FBwQqua22cj2pj39Tss8r+suSUuJ5JkCRdJrrvwtXKCrDDvOj?=
 =?us-ascii?Q?RXxwuFMmL0WnjSG3Hm1SVYJ6d8r0zhKSLlFfGNF74/agrjWRF+epHdIK8ORp?=
 =?us-ascii?Q?QBJ33QbDwLV36mG0y0JfaXmvEMczlLQwulpGBNmhSM+IsPF1/9sqzafTfsgv?=
 =?us-ascii?Q?bMMgChrtx7lQZ+0EUYr9+9EMyq66zCpk2fqPe/Z3om4dZX77auJ+6Svo7JoA?=
 =?us-ascii?Q?XJk7MBpWwTYD7c4USIwXEc/P2uHLg6r9QF3TtszsoMqBghRkrvI05beft+vN?=
 =?us-ascii?Q?RMARhXXHrMnss3kPUUEUDtovnYU2jnXB0EebiNWe48y7lQ787AtIeo9iJvwO?=
 =?us-ascii?Q?Nh+c5wmWxkOsuwed+qlwgYtynx5SlNrVDtBod9BDBmsOuWUdwJDj8r3Knipn?=
 =?us-ascii?Q?zXaqDYcALvYxlwqTnCVYZXQRveK9JUXwM2OSk2CwOLaoaNeiGUKGEzZ90DdM?=
 =?us-ascii?Q?BPriaiclckmUsefPZJXi0hNVGwfON9KNxWIvclQUAcCKCOsT7Mg/tCsBQ1Lb?=
 =?us-ascii?Q?s/AtPbdSAki/x7Rw5nWI3BhZvI3+SvZzOVpjpsdcZoL+A2ZL4cwMLkmydyjh?=
 =?us-ascii?Q?3DVo2xD3T+jOab/JSS+o2pMUeXlEZlET2O8SQBR//nt61HNwyaUaAZ97dSX/?=
 =?us-ascii?Q?M22puK/kofdj1AavHGt8uNzS+FJxv47uJVeBCdZdtd4L2M6KUhy3Fku1MrQQ?=
 =?us-ascii?Q?qT9UD7gKn23FwfB6lXE6m8HdS0P9veWUUnbld1+VcC9ewLM50Mo0FcSa/Qwq?=
 =?us-ascii?Q?6ZspGq2Vxvy5uaAL8OZS4qAJ36+zQ4QSsutSf6aeyauS2HMtV6cROxCES3iB?=
 =?us-ascii?Q?+Vp2b+swQmVb0cFVC6Xk+4+1HfNH05bhbcAOn+FXoyrF18RrfK8B2UpuLgSL?=
 =?us-ascii?Q?B8uZxI0Cr8NDrNwdn7EHGVyXLLlMStoU7wOhM+2NNY2YKiFqo45/R+z38kOj?=
 =?us-ascii?Q?JTMAolB4WO2e1mUe13hLPC834QkmU8ARLCqYvwRBQWKcx4sUoETVSqJacmby?=
 =?us-ascii?Q?pRpohCYNr0MHCHV9XWUo818M3a7IHS1ajQ1AsslQpJo4cbf2TDEtZ19S1UOp?=
 =?us-ascii?Q?0pMFHlniBUM+SJBPVS02KZPr7e52EFcAZ4livCwKTjmLgL2lzWq4f0J8RbUi?=
 =?us-ascii?Q?WvQN9D3Fj9zsAaqAW3FOauXCNeTxdgCNpK60FACXXr4pdCnV454LeYJd8r1W?=
 =?us-ascii?Q?fOdZ19KLVeaOsZ70nv0hnarLPKz2pJ3DZ5cOt9JtF1qW/E/Pds3Wxuxc3OLp?=
 =?us-ascii?Q?e1zGLCVuDWbFGY3GL6fUOeA6zOzRPBE5YLWVORwz3Ujt1ZxDDN3wI8fzg68D?=
 =?us-ascii?Q?UOvy9rMBSlFiZlCJ2iTTk+TO7CklPQPdbhvlJW0JgbWwQIcXux+Xyoie3PQ2?=
 =?us-ascii?Q?86jZwtSmSrvGu9YqK509z+aW01p/70ZVshziJosy/Ci7Dwvp+RkjPtOK3biW?=
 =?us-ascii?Q?41izGCTaUhlNGkCPK6BYtD2VTmtQjzJf3Cou4hpwN4ow5woI0Iph7enbR0LH?=
 =?us-ascii?Q?Db+c5TM2xBUP/BsrcomzzPk9V5z0Mcib+PFNWC6mdg95ZdZifB9jgOLQiwdh?=
 =?us-ascii?Q?VUx0Si495j4/KzQltwVIdkWh0FB6yBfLqabk1kM0/G2QHEokpyJ1k3ufq6w2?=
 =?us-ascii?Q?4K+3/0dVVjkqfj0+RLwosdySsxT8IqD6H0BXpya8ch3Y?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700021)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?zKdv1/Phj+uVJqM0LfIL63Omq3RDrsBp6Xs7g/vLu3e1t3B2wmk/+WVSLU0b?=
 =?us-ascii?Q?m6EkdKGkvShCzkienMUxZcbr0fyVd7aaGVXsmPYop4Ag5Nx7oy5b988EJyTZ?=
 =?us-ascii?Q?RkQ6zkO8ULvdt74jf3diX8gvD65oSL3MULE1KPmuU/r8BnK1UAPcYtFEvKLf?=
 =?us-ascii?Q?UMlelFBZOp2diZTaD+tyl6xovtFjQvwwL5UN4DwdyBZBxdfrCZX68oNZXm1Z?=
 =?us-ascii?Q?wyifBG1Fx+tZ3nyYM1kQWdRgckWfJ1Kutud4jbFuENgyfbW2qxx3+csYu8Pu?=
 =?us-ascii?Q?frbjoq56u+edAqbuC02O021O+LHP9as6QN4+NwTORSV02gEQUMuBe4Khqs29?=
 =?us-ascii?Q?o1xHmc+05HE43DrypxPLzvIy/wxRnsG++kurm+o0f0Za2UYEoWil4F+QFzdD?=
 =?us-ascii?Q?RSXefmzEoMFb/tPDbhGI7XvJLvcW3H7QYPQvg9Twh/oRwzvIRpY++91YvhEd?=
 =?us-ascii?Q?BjbI5Z7HhfzI6jNvILlbuKH2KCzlDQCroy4iZyX5qersNAYJ1p7oLax6El1F?=
 =?us-ascii?Q?EOJpmb7n3GkqHfmK8Wui/cqV+xsGlRvMmi59big0oD3DnRpmIb1+dj5+NKRO?=
 =?us-ascii?Q?/m553GYxE5703mZ+/l95722mWRRK1nJK4iUXKg7ge+WbyMbJm0TtgjHhajZU?=
 =?us-ascii?Q?wtHIERnA/DzdEx/bF4rKc3Mgz1el3cDSoDHeYL2Z6y1P3KObTrChFjP7BDXn?=
 =?us-ascii?Q?r3DFkd9hg559erKtCT2IOUvTnWPwiMPW3E5/C5NNpUZW4Vq9wafgau6UWbF6?=
 =?us-ascii?Q?ilG+zZaeu3V7Fnr0BIgXm0JOm7zRDoW+ESWdjWQimWlFCVgUzIkdQFjaSmBD?=
 =?us-ascii?Q?jafyOFkdLHQy790d+mv3Pb52J6MuGQ9ajWPMmFwqEx6nSW+UZzKLQVVONrCf?=
 =?us-ascii?Q?idHrUMw8W70kuvogh8vUphrzAAL/2MsA6L9xYxivmXi5LwYkYYuu7j6FLInO?=
 =?us-ascii?Q?ILrLJP+Pz3YqlWooIHTonvjjscWnbg0CslfzEts6XGA0zI+Hdn9m27fLTTXQ?=
 =?us-ascii?Q?+wDxiQhPHdWfNBmqzPhFfzBnhgyrdvRg4nMcKVZsjGmXtwZuWuidFxR2YZ4/?=
 =?us-ascii?Q?aoZLWrWHdDamyDYtkubslInF+ku6m6G7Ydk0gVGf9UHnQB3a+v73whTFX3Kj?=
 =?us-ascii?Q?v25Jktgod2JBWIPb2QnoJL+wwu97XqidNwiXZYIDHrdV7ufE8IjGPIWrURVJ?=
 =?us-ascii?Q?4PPMW6HTfXEuPrnMYs/xfDYxP1iu4FMW8dmq13stlTYx2e4CwzuCQ6qcMATC?=
 =?us-ascii?Q?48bqXbl+u1VEP8SiE21SU6ciSvSEG2w7y9r9J8wbmHA5hE9PXR/ks0MYBvye?=
 =?us-ascii?Q?gz7vMCSq3MNx7SfyxFQ85xQPcA8ZD/evUQLIPy5+ZThqPbwBssa558Z3JCh2?=
 =?us-ascii?Q?23JZICtAO156U0hDCVkBQvwdDS7Ug+ztYR+7iMtrsBrt2q2n8F0Cs/T9kAMK?=
 =?us-ascii?Q?waPZICkU7nvPpJFgZB7NBb5JaKUViEo5lNJPkdzW9niE/ia6DtG8t6Rwm0/w?=
 =?us-ascii?Q?GWL4VH8i44/mqSL42xjXa0uTdpwxgThOg1xhpGxQU6ByFcYxmTliMq/z/EDb?=
 =?us-ascii?Q?PN398K+uMwPfkfGlfLLj8fc2yiPOfQBgwUr2tRtDjI7w2wDTFoQyIyopL1IS?=
 =?us-ascii?Q?86H4gS0+M8RFJwPQojWCxSRxH74vasc0w8yMpNvbpB8529d7T4fMAmp6Jg3T?=
 =?us-ascii?Q?2RKgU36uwk0BdvdCmMhRIPaYH6st0bZGDNCSW5GSOk3q40I56JnvTdDuTBiu?=
 =?us-ascii?Q?O/jShbTnhg=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 08395b1b-a02e-48c8-b0fa-08de5cca96c9
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jan 2026 11:03:51.5624
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2jgYmtfBtBshjOiVe/HduDtQxCoTv3oh5SZII6jNOlP3+AgKfgFvbYpYzuZ5+JM8t/4RUK3yGtxM4UCfcimbM9hmj84yUZaRXio/t2pXnwU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB11147
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[renesas.com,none];
	R_DKIM_ALLOW(-0.20)[bp.renesas.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8499-lists,dmaengine=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[tuxon.dev,kernel.org,bp.renesas.com,gmail.com,perex.cz,suse.com,pengutronix.de,glider.be,renesas.com];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tuxon.dev:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,bp.renesas.com:dkim,smarc-rzg3l:email,renesas.com:email]
X-Rspamd-Queue-Id: E604787781
X-Rspamd-Action: no action

Hi Claudiu,

Thanks for the patch.

> -----Original Message-----
> From: Claudiu <claudiu.beznea@tuxon.dev>
> Sent: 26 January 2026 10:32
> Subject: [PATCH 5/7] dmaengine: sh: rz-dmac: Add suspend to RAM support
>=20
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>=20
> The Renesas RZ/G3S SoC supports a power saving mode in which power to mos=
t SoC components is turned
> off, including the DMA IP. Add suspend to RAM support to save and restore=
 the DMA IP registers.
>=20
> Cyclic DMA channels require special handling. Since they can be paused an=
d resumed during system
> suspend and resume, the driver restores additional registers for these ch=
annels during the resume
> phase. If a channel was not explicitly paused during suspend, the driver =
ensures that it is paused and
> resumed as part of the system suspend/resume flow. This might be the case=
 of a serial device being
> used with no_console_suspend.
>=20
> For non-cyclic channels, the dev_pm_ops::prepare callback waits for all o=
ngoing transfers to complete
> before allowing suspend-to-RAM to proceed.
>=20
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> ---
>  drivers/dma/sh/rz-dmac.c | 183 +++++++++++++++++++++++++++++++++++++--
>  1 file changed, 175 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c index ab=
5f49a0b9f2..8f3e2719e639
> 100644
> --- a/drivers/dma/sh/rz-dmac.c
> +++ b/drivers/dma/sh/rz-dmac.c
> @@ -69,11 +69,15 @@ struct rz_dmac_desc {
>   * enum rz_dmac_chan_status: RZ DMAC channel status
>   * @RZ_DMAC_CHAN_STATUS_ENABLED: Channel is enabled
>   * @RZ_DMAC_CHAN_STATUS_PAUSED: Channel is paused though DMA engine call=
backs
> + * @RZ_DMAC_CHAN_STATUS_PAUSED_INTERNAL: Channel is paused through
> + driver internal logic
> + * @RZ_DMAC_CHAN_STATUS_SYS_SUSPENDED: Channel was prepared for system
> + suspend
>   * @RZ_DMAC_CHAN_STATUS_CYCLIC: Channel is cyclic
>   */
>  enum rz_dmac_chan_status {
>  	RZ_DMAC_CHAN_STATUS_ENABLED,
>  	RZ_DMAC_CHAN_STATUS_PAUSED,
> +	RZ_DMAC_CHAN_STATUS_PAUSED_INTERNAL,
> +	RZ_DMAC_CHAN_STATUS_SYS_SUSPENDED,
>  	RZ_DMAC_CHAN_STATUS_CYCLIC,
>  };
>=20
> @@ -94,6 +98,10 @@ struct rz_dmac_chan {
>  	u32 chctrl;
>  	int mid_rid;
>=20
> +	struct {
> +		u32 nxla;
> +	} pm_state;
> +
>  	struct list_head ld_free;
>  	struct list_head ld_queue;
>  	struct list_head ld_active;
> @@ -1002,10 +1010,17 @@ static int rz_dmac_device_pause(struct dma_chan *=
chan)
>  	return rz_dmac_device_pause_set(channel, RZ_DMAC_CHAN_STATUS_PAUSED);  =
}
>=20
> +static int rz_dmac_device_pause_internal(struct rz_dmac_chan *channel)
> +{
> +	lockdep_assert_held(&channel->vc.lock);
> +
> +	return rz_dmac_device_pause_set(channel,
> +RZ_DMAC_CHAN_STATUS_PAUSED_INTERNAL);
> +}
> +
>  static int rz_dmac_device_resume_set(struct rz_dmac_chan *channel,
>  				     enum rz_dmac_chan_status status)  {
> -	u32 val;
> +	u32 val, chctrl;
>  	int ret;
>=20
>  	lockdep_assert_held(&channel->vc.lock);
> @@ -1013,14 +1028,33 @@ static int rz_dmac_device_resume_set(struct rz_dm=
ac_chan *channel,
>  	if (!(channel->status & BIT(RZ_DMAC_CHAN_STATUS_PAUSED)))
>  		return 0;
>=20
> -	rz_dmac_ch_writel(channel, CHCTRL_CLRSUS, CHCTRL, 1);
> -	ret =3D read_poll_timeout_atomic(rz_dmac_ch_readl, val,
> -				       !(val & CHSTAT_SUS), 1, 1024, false,
> -				       channel, CHSTAT, 1);
> -	if (ret)
> -		return ret;
> +	if (channel->status & BIT(RZ_DMAC_CHAN_STATUS_SYS_SUSPENDED)) {
> +		/*
> +		 * We can be after a sleep state with power loss. If power was
> +		 * lost, the CHSTAT_SUS bit is zero. In this case, we need to
> +		 * enable the channel directly. Otherwise, just set the CLRSUS
> +		 * bit.
> +		 */
> +		val =3D rz_dmac_ch_readl(channel, CHSTAT, 1);
> +		if (val & CHSTAT_SUS)
> +			chctrl =3D CHCTRL_CLRSUS;
> +		else
> +			chctrl =3D CHCTRL_SETEN;
> +	} else {
> +		chctrl =3D CHCTRL_CLRSUS;
> +	}
> +
> +	rz_dmac_ch_writel(channel, chctrl, CHCTRL, 1);
>=20
> -	channel->status &=3D ~BIT(status);
> +	if (chctrl & CHCTRL_CLRSUS) {
> +		ret =3D read_poll_timeout_atomic(rz_dmac_ch_readl, val,
> +					       !(val & CHSTAT_SUS), 1, 1024, false,
> +					       channel, CHSTAT, 1);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	channel->status &=3D ~(BIT(status) |
> +BIT(RZ_DMAC_CHAN_STATUS_SYS_SUSPENDED));
>=20
>  	return 0;
>  }
> @@ -1034,6 +1068,13 @@ static int rz_dmac_device_resume(struct dma_chan *=
chan)
>  	return rz_dmac_device_resume_set(channel, RZ_DMAC_CHAN_STATUS_PAUSED); =
 }
>=20
> +static int rz_dmac_device_resume_internal(struct rz_dmac_chan *channel)
> +{
> +	lockdep_assert_held(&channel->vc.lock);
> +
> +	return rz_dmac_device_resume_set(channel,
> +RZ_DMAC_CHAN_STATUS_PAUSED_INTERNAL);
> +}
> +
>  /*
>   * ---------------------------------------------------------------------=
--------
>   * IRQ handling
> @@ -1438,6 +1479,131 @@ static void rz_dmac_remove(struct platform_device=
 *pdev)
>  	pm_runtime_disable(&pdev->dev);
>  }
>=20
> +static int rz_dmac_suspend_prepare(struct device *dev) {
> +	struct rz_dmac *dmac =3D dev_get_drvdata(dev);
> +
> +	for (unsigned int i =3D 0; i < dmac->n_channels; i++) {
> +		struct rz_dmac_chan *channel =3D &dmac->channels[i];
> +
> +		guard(spinlock_irqsave)(&channel->vc.lock);
> +
> +		/* Wait for transfer completion, except in cyclic case. */
> +		if (channel->status & BIT(RZ_DMAC_CHAN_STATUS_ENABLED) &&
> +		    !(channel->status & BIT(RZ_DMAC_CHAN_STATUS_CYCLIC)))
> +			return -EAGAIN;
> +	}
> +
> +	return 0;
> +}
> +
> +static void rz_dmac_suspend_recover(struct rz_dmac *dmac) {
> +	for (unsigned int i =3D 0; i < dmac->n_channels; i++) {
> +		struct rz_dmac_chan *channel =3D &dmac->channels[i];
> +
> +		guard(spinlock_irqsave)(&channel->vc.lock);
> +
> +		if (!(channel->status & BIT(RZ_DMAC_CHAN_STATUS_CYCLIC)))
> +			continue;
> +
> +		if (!(channel->status & BIT(RZ_DMAC_CHAN_STATUS_PAUSED_INTERNAL)))
> +			continue;
> +
> +		rz_dmac_device_resume_internal(channel);
> +	}
> +}
> +
> +static int rz_dmac_suspend(struct device *dev) {
> +	struct rz_dmac *dmac =3D dev_get_drvdata(dev);
> +	int ret;
> +
> +	for (unsigned int i =3D 0; i < dmac->n_channels; i++) {
> +		struct rz_dmac_chan *channel =3D &dmac->channels[i];
> +
> +		guard(spinlock_irqsave)(&channel->vc.lock);
> +
> +		if (!(channel->status & BIT(RZ_DMAC_CHAN_STATUS_CYCLIC)))
> +			continue;
> +
> +		if (!(channel->status & BIT(RZ_DMAC_CHAN_STATUS_PAUSED))) {
> +			ret =3D rz_dmac_device_pause_internal(channel);
> +			if (ret) {
> +				dev_err(dev, "Failed to suspend channel %s\n",
> +					dma_chan_name(&channel->vc.chan));
> +				continue;
> +			}
> +		}
> +
> +		channel->pm_state.nxla =3D rz_dmac_ch_readl(channel, NXLA, 1);
> +		channel->status |=3D BIT(RZ_DMAC_CHAN_STATUS_SYS_SUSPENDED);
> +	}
> +
> +	pm_runtime_put_sync(dmac->dev);
> +
> +	ret =3D reset_control_assert(dmac->rstc);
> +	if (ret) {
> +		pm_runtime_resume_and_get(dmac->dev);
> +		rz_dmac_suspend_recover(dmac);
> +	}
> +


This patch breaks, s2idle in RZ/G3L as it turns off DMA ACLK and IRQ's
are not routed to CPU for wakeup.

DMA ACLK is required for routing IRQ to CPU, without this CPU won't get any=
 interrupts.

If we make this CLK as critical clock, s2idle fails, as the DMA ALCK turned=
 off during suspend
and there is no IRQ to wake up the system.

LOGS:
root@smarc-rzg3l:~# echo enabled > /sys/class/tty/ttySC3/power/wakeup
echo N > /sys/module/printk/parameters/console_suspend
root@smarc-rzg3l:~# echo N > /sys/module/printk/parameters/console_suspend
root@smarc-rzg3l:~# echo 7 > /proc/sys/kernel/printk
root@smarc-rzg3l:~# echo freeze > /sys/power/state
[   41.601992] PM: suspend entry (s2idle)
[   41.605979] Filesystems sync: 0.000 seconds
[   41.611261] Freezing user space processes
[   41.614848] Freezing user space processes completed (elapsed 0.003 secon=
ds)
[   41.622676] OOM killer disabled.
[   41.625908] Freezing remaining freezable tasks
[   41.631642] Freezing remaining freezable tasks completed (elapsed 0.001 =
seconds)
[   41.640137] renesas-gbeth 11c30000.ethernet end0: Link is Down


On my testing shows on RZ/G3L, we need to make DMA ACLK as non-PM clk for
Making both s2idle and str to work on RZ/G3L.

if (pm_suspend_target_state =3D=3D PM_SUSPEND_TO_IDLE)
you need this check in suspend/resume not to turn off DMAACLK during s2idle=
.

Also, the callback has to be in non_irq phase so that CPU start getting IRQ=
's
During sleep phase.

Cheers,
Biju


> +	return ret;
> +}
> +
> +static int rz_dmac_resume(struct device *dev) {
> +	struct rz_dmac *dmac =3D dev_get_drvdata(dev);
> +	int ret;
> +
> +	ret =3D reset_control_deassert(dmac->rstc);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D pm_runtime_resume_and_get(dmac->dev);
> +	if (ret) {
> +		reset_control_assert(dmac->rstc);
> +		return ret;
> +	}
> +
> +	rz_dmac_writel(dmac, DCTRL_DEFAULT, CHANNEL_0_7_COMMON_BASE + DCTRL);
> +	rz_dmac_writel(dmac, DCTRL_DEFAULT, CHANNEL_8_15_COMMON_BASE + DCTRL);
> +
> +	for (unsigned int i =3D 0; i < dmac->n_channels; i++) {
> +		struct rz_dmac_chan *channel =3D &dmac->channels[i];
> +
> +		guard(spinlock_irqsave)(&channel->vc.lock);
> +
> +		rz_dmac_set_dma_req_no(dmac, channel->index, channel->mid_rid);
> +
> +		if (!(channel->status & BIT(RZ_DMAC_CHAN_STATUS_CYCLIC))) {
> +			rz_dmac_ch_writel(&dmac->channels[i], CHCTRL_DEFAULT, CHCTRL, 1);
> +			continue;
> +		}
> +
> +		rz_dmac_ch_writel(channel, channel->pm_state.nxla, NXLA, 1);
> +		rz_dmac_ch_writel(channel, channel->chcfg, CHCFG, 1);
> +		rz_dmac_ch_writel(channel, CHCTRL_SWRST, CHCTRL, 1);
> +		rz_dmac_ch_writel(channel, channel->chctrl, CHCTRL, 1);
> +
> +		if (channel->status & BIT(RZ_DMAC_CHAN_STATUS_PAUSED_INTERNAL)) {
> +			ret =3D rz_dmac_device_resume_internal(channel);
> +			if (ret) {
> +				dev_err(dev, "Failed to resume channel %s\n",
> +					dma_chan_name(&channel->vc.chan));
> +				continue;
> +			}
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct dev_pm_ops rz_dmac_pm_ops =3D {
> +	.prepare =3D rz_dmac_suspend_prepare,
> +	SYSTEM_SLEEP_PM_OPS(rz_dmac_suspend, rz_dmac_resume) };
> +
>  static const struct rz_dmac_info rz_dmac_v2h_info =3D {
>  	.icu_register_dma_req =3D rzv2h_icu_register_dma_req,
>  	.default_dma_req_no =3D RZV2H_ICU_DMAC_REQ_NO_DEFAULT, @@ -1464,6 +1630=
,7 @@ static struct
> platform_driver rz_dmac_driver =3D {
>  	.driver		=3D {
>  		.name	=3D "rz-dmac",
>  		.of_match_table =3D of_rz_dmac_match,
> +		.pm	=3D pm_sleep_ptr(&rz_dmac_pm_ops),
>  	},
>  	.probe		=3D rz_dmac_probe,
>  	.remove		=3D rz_dmac_remove,
> --
> 2.43.0


