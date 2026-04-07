Return-Path: <dmaengine+bounces-9922-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kHXeILQX1Wm30AcAu9opvQ
	(envelope-from <dmaengine+bounces-9922-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 07 Apr 2026 16:41:56 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E48EA3B037D
	for <lists+dmaengine@lfdr.de>; Tue, 07 Apr 2026 16:41:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3B4CE3043D74
	for <lists+dmaengine@lfdr.de>; Tue,  7 Apr 2026 14:37:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07FE125A2B5;
	Tue,  7 Apr 2026 14:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="deM68EeE"
X-Original-To: dmaengine@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011061.outbound.protection.outlook.com [40.107.74.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CD051DE4FB;
	Tue,  7 Apr 2026 14:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775572620; cv=fail; b=jns2f3K4gHo2RrYvBscV/3EEnAjK8kb3VW/J4v5f++ex2BnBA76sb4YH/3OkhoYLGMNG9e27LqFyXvofy4thGFYRS/DJkldTLIhsgcWdTVr3ijoip8PwAiR0ml2LaVCgQ1PHxxiFou/ejeNWg8pxW16tUj82IQW/q3MaOx2TX2g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775572620; c=relaxed/simple;
	bh=hfxZYtybNam/llpU59qFNpnhWfpynDcJf9StTv3RZ5U=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uVDOYE97+9VrHbaCzhmuiPTlCfufEQs+ocELy4grfWcq6//pqmRxX6noSFVcLVD63oOVxJfp8pzCg8ajq/JzElxajJTXYZqzQokEDTZTksb1Dze/Ci+gQcDy7w5TMNy3sGYtKvwWglIIjw5Hf9RvNbFy7RC941CNhJZA86O0uTo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=deM68EeE; arc=fail smtp.client-ip=40.107.74.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MA1gEOo7Y+ccjp7pTbdBaorLTckb7f8roIJQcPJ2MNtEKvo/qo/EWh/X5XpVFkCHPMxE1fbBsbaOWPDQeoiykYhH1zK22bQADwNB9X9r9PJyHGy/NSPgq9WCb4In8TixtSkymRdctpTkAw0HPNI9bQ+Oiiy7WncHVME+lfVybO26rKTZKHt7XSkI9SBpMYKB5GBcePH9OJq19bMgyaTa0JoOtUJbWp+1RFlI7q+DiFbAzEQvrPdUSB2pzAKaipSj1gLYl4n8GdKri3a+4g/1wxHMYm+lbqN7seXW9S7Rf/IBG95Atdy8aLSLTB1StEvGnE5UWDY9TtFki61gIHo39Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UAlIVVkV3TGBYZTOP9Vdb6Oa1UAVt8lz1+/2P69HCvg=;
 b=pPfRafV5ogX49Vxh4/VAA2DMNzN/s3awCalQ/h5IrPBRUliAI8+OTVk2KP025sC+2CIHTDxVBpupUIrLZgX4SE+CWlSBvD7UaAxFBsbtDqLO7PcWkO7QHl9WbMfwDYWOTJsrU4jAQUnznOJmVySZXT2L71sTkSUgeaHEAvrQc5PSDoaFMnx7MjJCpdq2RX1YhC4nJ/703B+keheRQTa/017mbSGLSKwgiCTU/3sRybBrXzKn9BQhOpUqYEHaNcBXo/ASxASN7AgiV9DhUL+YMUpTCimDrH1Kiwr9Db3AE9DLbBVqiKzRhAZsAIBG0TwowMYp38ArrDCsH7DDcsQ6ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UAlIVVkV3TGBYZTOP9Vdb6Oa1UAVt8lz1+/2P69HCvg=;
 b=deM68EeEUEP4wf/opN4utL8s8UF787wqOGfKuqTCRQAbiaL/94pxaavTtnQ19Jue+tjxKEO6Xzh5cd6Hvw4zUjoj1wTIBL7UT/6r51iBwlmp9+ikrNZCrOrEoaD8wyJZ67p3QFBeha8DrxUrLAJ44zI4Oa0B9MmUhSFhSyxsEFE=
Received: from TYCPR01MB11332.jpnprd01.prod.outlook.com (2603:1096:400:3c0::7)
 by OSCPR01MB15680.jpnprd01.prod.outlook.com (2603:1096:604:3c8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Tue, 7 Apr
 2026 14:36:53 +0000
Received: from TYCPR01MB11332.jpnprd01.prod.outlook.com
 ([fe80::2511:10cd:e497:4d97]) by TYCPR01MB11332.jpnprd01.prod.outlook.com
 ([fe80::2511:10cd:e497:4d97%5]) with mapi id 15.20.9769.020; Tue, 7 Apr 2026
 14:36:53 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Claudiu.Beznea <claudiu.beznea@tuxon.dev>, "vkoul@kernel.org"
	<vkoul@kernel.org>, "Frank.Li@kernel.org" <Frank.Li@kernel.org>,
	"lgirdwood@gmail.com" <lgirdwood@gmail.com>, "broonie@kernel.org"
	<broonie@kernel.org>, "perex@perex.cz" <perex@perex.cz>, "tiwai@suse.com"
	<tiwai@suse.com>, Prabhakar Mahadev Lad
	<prabhakar.mahadev-lad.rj@bp.renesas.com>, "p.zabel@pengutronix.de"
	<p.zabel@pengutronix.de>, "geert+renesas@glider.be"
	<geert+renesas@glider.be>, Fabrizio Castro <fabrizio.castro.jz@renesas.com>
CC: Claudiu.Beznea <claudiu.beznea@tuxon.dev>, "dmaengine@vger.kernel.org"
	<dmaengine@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-sound@vger.kernel.org"
	<linux-sound@vger.kernel.org>, "linux-renesas-soc@vger.kernel.org"
	<linux-renesas-soc@vger.kernel.org>, Claudiu Beznea
	<claudiu.beznea.uj@bp.renesas.com>
Subject: RE: [PATCH v3 11/15] dmaengine: sh: rz-dmac: Add cyclic DMA support
Thread-Topic: [PATCH v3 11/15] dmaengine: sh: rz-dmac: Add cyclic DMA support
Thread-Index: AQHcxpN0epZm3oWFs0uhV/cUaEEnBLXTp9bQ
Date: Tue, 7 Apr 2026 14:36:53 +0000
Message-ID:
 <TYCPR01MB11332705744F2802F745C1567865AA@TYCPR01MB11332.jpnprd01.prod.outlook.com>
References: <20260407133507.887404-1-claudiu.beznea.uj@bp.renesas.com>
 <20260407133507.887404-12-claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20260407133507.887404-12-claudiu.beznea.uj@bp.renesas.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB11332:EE_|OSCPR01MB15680:EE_
x-ms-office365-filtering-correlation-id: 6ab871e5-40b7-4e87-29e0-08de94b31ccf
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700021|921020|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info:
 LX44MxMvryGk+ejLtEOTTvqA7Knx4DfyvH6GVE755rqOXO4a9sxtiBsAj/v5+4ngz3Jq754aLwR+GvNVDDCQAEvxSfvlsyjqvIJWXwcsRsZb9SEY0fiFN8AduXtJu/h31IwxDMATr/MwjF0KGIAzXSD8J/2TrbVftEhEDmXfDKOzfEBLok+Yr3vHgc57RzpaZlSqgsCb+8DpKqFYDFbJZEWbTHN0v+pV/cb1cTXNvkFyJsmYFMIp8YcOaM+ReUC1E+ViK0BnOGsDY3D6pI/WKVzp4M7lHoPKwtROWnZmp7LJyIqKty8SWQ5Zv1SiXFEE4sVAq8OYc6P7AurMvb9/8QOj27GbsjHeAyz3d/K7Akvj17erQvxzZ9rwxvKUEr+mchbUlKL5ZamKy8szxYuwxD3fgKusWUbRjdhFsu8mIJFSEvCvrGLlP2wm1TPV7gRZIJf/e2wrRP8MdpamcBuNBwmwAhZfzVf1ILvL+rbv42oX93o9q6IbMzXxDXsJ6DAELKcotSF2UdkVjenENs/EUVCv5VR9xWYvaDMfu1GwRYVTyVXEwlZUPXYwmNaxjfqhBqMnw6jzygMDYdvDe9A80g/aH73bIKpJL4jBqdYTcCVWwae6Zmoa3f2KSNFiI+mj8EgYYHflEWaUcRor5AnKZuRvrSvNnwxchcTWUzHpB/pTU1FFrftUhUdDLmFGdA6wEbAwbBHXLszoHZ4RPw/a8UgnoKDZS1s8agXWGi809gi4DOGXsmagUUtfFFQveFyLXbPKraQneN4Rxa7kNv+vJDE76JxAPJaF4Rd9iW0hWaUprGBmuU4QZtLeMjRkzKjz
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11332.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700021)(921020)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?u1EzVmfFbA+C1nV54/m7XshhwqK2Nw4smzF51ZF036mwudCIP61ifcAKUTKX?=
 =?us-ascii?Q?BX2JTdLvZdBkIcUG1vjNCVtcs0xc3fvRxnH4epkuwaOrNJtcZfcCx1D1hnbh?=
 =?us-ascii?Q?2yq4Zg56+47h5BDkjZr7SNIkTCT63EATqve2JrWaK7xuffnSP3aLxXf4NZ9i?=
 =?us-ascii?Q?NexQvDhU9FbidxYgdSIyB+GnGbwvUS5BpX+oyClCtusKTXNPyjbeQGk+Sq5j?=
 =?us-ascii?Q?1yRNa3aelChCqqj24abET2dCDVXGGfqSMG3xoA7H4iQQIcSWsryrLNuceiqb?=
 =?us-ascii?Q?5V1VFn2n84MO5mF08iZ2z0HhdUwfwd3kWxWKFCD0c/KURrQIwv7bWgYDNpig?=
 =?us-ascii?Q?e5amOKT13LItDZKWjieRcnPdYA4J7ItE2+c11I+SueLQc+VC19itWxmsPkZq?=
 =?us-ascii?Q?ki9tbzRcss/ZmDBGklX5wxo6QpgtwE6OsYP9zL98CMvc/ElKciXDMc2bRwRj?=
 =?us-ascii?Q?ZyYk40La3GfSH7P+FsFDsWXFb+AqSPoKh5RwvQH3Yj8oYczYTi+hls38FYMX?=
 =?us-ascii?Q?gd683STAjcKUGeaO1yn1Ety1WoDqKD/TMqx4aWj10V2dcVBc5UOzpG2bkhBR?=
 =?us-ascii?Q?90K40/kuu/ipbKEYXyS9m0cN1AF5Cjl7PeQHMt4L8zkDqBwmkKPjaXKCCIX0?=
 =?us-ascii?Q?kswVXxjkLjj1TGXb/vzqKsV1+7NYtiQmsbMjM2t29mQj2m4tfC08DY+HIvDH?=
 =?us-ascii?Q?x7GjsIdZbg8Bp92uj6zJFaw8MGiOuWW2QjjDZ1uDsTohzcV80pgvqH7oLaW1?=
 =?us-ascii?Q?pyd6RWkhQ9Mu88UV2CzCaEBP1g9XJhwxy5LhNxcFVkBr8R6qS3Vkf12+EYBR?=
 =?us-ascii?Q?7J0NIDlXxVJUnCSPzfVVqluJNMNJTXRnc3rh4oD9BOt9I0PcxTrZslH8n/pL?=
 =?us-ascii?Q?hiZCS0ycKLApmjn4pFSZUXDZGslgl8anK2lhJ8WemoAZj2vMaKbtJVWE0sc1?=
 =?us-ascii?Q?0G2vJbWFC72j//flVrqVptCuOOCYUV24p/TyPn+bPbenQNDof3EXehw2flBL?=
 =?us-ascii?Q?G4E4dvWKdJfYBCGhoi2W2fykxpkXvjyw+RKPoA/f4D3mrDPRYdkaUoJi+LFc?=
 =?us-ascii?Q?31xD2C23jjKfbrgVY/a3Uo1qMJ2kxXet8XUE7qIyEsH3KoJBCmzCD6OkWsnf?=
 =?us-ascii?Q?Z2PYHo/4OUNi68tJ4m+5jrHzJPCgds12EcSoU30PGmM4YXqp3CVOExDKIK8q?=
 =?us-ascii?Q?n3vGIvl31qRUjSRhta3ODm/G6d0IS68T/U9LjVIynLos5pguf8BPXfkUMAGl?=
 =?us-ascii?Q?exbBygWTJAyr7ZMnM4mwq+6f0FCIv7L8D8aJ2dK/n7c6Tb7TFcwJGmIiRzd4?=
 =?us-ascii?Q?hWtj9XrWAObR8BlpkR1CEaeiVeAHzE0/lrkLiFAjWsiIMMs4H1aXCIZEJQDz?=
 =?us-ascii?Q?B9W8Xg8MFZzoEbDTX+P7+TUIZMP1x++8mnCIqAHNTmtBT5TDF1vVzCfmYdXp?=
 =?us-ascii?Q?SOnOSR5V/hwTgVerwRaGRWDPLcMtOpn6dKtgl8Xesn1C0GF9/1d24t+l9vVv?=
 =?us-ascii?Q?E6ItVGdNwEVvVIutF3gPGCnHckECXAXYTEd9HOqx6s4LsL7W0L0yp/9+ooVY?=
 =?us-ascii?Q?rXq6xMHyqbfk4ZNvJGcaxXH1PLVKc3b1O8mvBdVMIKr5tCaUHZBps3ndKvKl?=
 =?us-ascii?Q?lqDF0HQ4OgjTpRkPsCbqiX1Gk7olXEu2fyaTLbXsbImGlAsS3nSDI0wIWpaw?=
 =?us-ascii?Q?vrdui7lmGhdaZuVQHKs5bMzcJ5B+Ec2kGutAfkGjoLwFSA4MvmGx40UqXS9I?=
 =?us-ascii?Q?QtpAxZuowQ=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ab871e5-40b7-4e87-29e0-08de94b31ccf
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Apr 2026 14:36:53.6336
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZNRSvO4OKviav8F37n1gpafn/v0LwlEZrrVgekQpPxCXkuZ/KPyiYAtin/L1HrmfvLiXi3uQv7uWkTBvEWFmqn6E/h040Xw0TBXcaK9FaNM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB15680
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[renesas.com,none];
	R_DKIM_ALLOW(-0.20)[bp.renesas.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9922-lists,dmaengine=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[17];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,tuxon.dev:email,bp.renesas.com:dkim]
X-Rspamd-Queue-Id: E48EA3B037D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


Hi Claudiu,

Thanks for the patch.

> -----Original Message-----
> From: Claudiu <claudiu.beznea@tuxon.dev>
> Sent: 07 April 2026 14:35
> Subject: [PATCH v3 11/15] dmaengine: sh: rz-dmac: Add cyclic DMA support
>=20
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>=20
> Add cyclic DMA support to the RZ DMAC driver. A per-channel status bit is=
 introduced to mark cyclic
> channels and is set during the DMA prepare callback. The IRQ handler chec=
ks this status bit and calls
> vchan_cyclic_callback() accordingly.
>=20
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> ---
>=20
> Changes in v3:
> - updated rz_dmac_lmdesc_recycle() to restore the lmdesc->nxla
> - in rz_dmac_prepare_descs_for_cyclic() update directly the
>   desc->start_lmdesc with the descriptor pointer insted of the
>   descriptor address
> - used rz_dmac_lmdesc_addr() to compute the descritor address
> - set channel->status =3D 0 in rz_dmac_free_chan_resources()
> - in rz_dmac_prep_dma_cyclic() check for invalid periods or buffer len
>   and limit the critical area protected by spinlock
> - set channel->status =3D 0 in rz_dmac_terminate_all()
> - updated rz_dmac_calculate_residue_bytes_in_vd() to use
>   rz_dmac_lmdesc_addr()
> - dropped goto in rz_dmac_irq_handler_thread() as it is not needed
>   anymore; dropped also the local variable desc
>=20
> Changes in v2:
> - none
>=20
>  drivers/dma/sh/rz-dmac.c | 144 +++++++++++++++++++++++++++++++++++++--
>  1 file changed, 138 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c index 8f=
bccabc94e4..f7133ac6af60
> 100644
> --- a/drivers/dma/sh/rz-dmac.c
> +++ b/drivers/dma/sh/rz-dmac.c
> @@ -35,6 +35,7 @@
>  enum  rz_dmac_prep_type {
>  	RZ_DMAC_DESC_MEMCPY,
>  	RZ_DMAC_DESC_SLAVE_SG,
> +	RZ_DMAC_DESC_CYCLIC,
>  };
>=20
>  struct rz_lmdesc {
> @@ -67,9 +68,11 @@ struct rz_dmac_desc {
>  /**
>   * enum rz_dmac_chan_status: RZ DMAC channel status
>   * @RZ_DMAC_CHAN_STATUS_PAUSED: Channel is paused though DMA engine call=
backs
> + * @RZ_DMAC_CHAN_STATUS_CYCLIC: Channel is cyclic
>   */
>  enum rz_dmac_chan_status {
>  	RZ_DMAC_CHAN_STATUS_PAUSED,
> +	RZ_DMAC_CHAN_STATUS_CYCLIC,
>  };
>=20
>  struct rz_dmac_chan {
> @@ -191,6 +194,7 @@ struct rz_dmac {
>=20
>  /* LINK MODE DESCRIPTOR */
>  #define HEADER_LV			BIT(0)
> +#define HEADER_WBD			BIT(2)
>=20
>  #define RZ_DMAC_MAX_CHAN_DESCRIPTORS	16
>  #define RZ_DMAC_MAX_CHANNELS		16
> @@ -272,9 +276,12 @@ static void rz_lmdesc_setup(struct rz_dmac_chan *cha=
nnel,  static void
> rz_dmac_lmdesc_recycle(struct rz_dmac_chan *channel)  {
>  	struct rz_lmdesc *lmdesc =3D channel->lmdesc.head;
> +	u32 nxla =3D channel->lmdesc.base_dma;
>=20
>  	while (!(lmdesc->header & HEADER_LV)) {
>  		lmdesc->header =3D 0;
> +		nxla +=3D sizeof(*lmdesc);
> +		lmdesc->nxla =3D nxla;
>  		lmdesc++;
>  		if (lmdesc >=3D (channel->lmdesc.base + DMAC_NR_LMDESC))
>  			lmdesc =3D channel->lmdesc.base;
> @@ -429,6 +436,57 @@ static void rz_dmac_prepare_descs_for_slave_sg(struc=
t rz_dmac_chan *channel)
>  	rz_dmac_set_dma_req_no(dmac, channel->index, channel->mid_rid);  }
>=20
> +static void rz_dmac_prepare_descs_for_cyclic(struct rz_dmac_chan
> +*channel) {
> +	struct dma_chan *chan =3D &channel->vc.chan;
> +	struct rz_dmac *dmac =3D to_rz_dmac(chan->device);
> +	struct rz_dmac_desc *d =3D channel->desc;
> +	size_t period_len =3D d->sgcount;
> +	struct rz_lmdesc *lmdesc;
> +	size_t buf_len =3D d->len;
> +	size_t periods =3D buf_len / period_len;
> +
> +	lockdep_assert_held(&channel->vc.lock);
> +
> +	channel->chcfg |=3D CHCFG_SEL(channel->index) | CHCFG_DMS;
> +
> +	if (d->direction =3D=3D DMA_DEV_TO_MEM) {
> +		channel->chcfg |=3D CHCFG_SAD;
> +		channel->chcfg &=3D ~CHCFG_REQD;
> +	} else {
> +		channel->chcfg |=3D CHCFG_DAD | CHCFG_REQD;
> +	}
> +
> +	lmdesc =3D channel->lmdesc.tail;
> +	d->start_lmdesc =3D lmdesc;
> +
> +	for (size_t i =3D 0; i < periods; i++) {
> +		if (d->direction =3D=3D DMA_DEV_TO_MEM) {
> +			lmdesc->sa =3D d->src;
> +			lmdesc->da =3D d->dest + (i * period_len);
> +		} else {
> +			lmdesc->sa =3D d->src + (i * period_len);
> +			lmdesc->da =3D d->dest;
> +		}
> +
> +		lmdesc->tb =3D period_len;
> +		lmdesc->chitvl =3D 0;
> +		lmdesc->chext =3D 0;
> +		lmdesc->chcfg =3D channel->chcfg;
> +		lmdesc->header =3D HEADER_LV | HEADER_WBD;
> +
> +		if (i =3D=3D periods - 1)
> +			lmdesc->nxla =3D rz_dmac_lmdesc_addr(channel, d->start_lmdesc);
> +
> +		if (++lmdesc >=3D (channel->lmdesc.base + DMAC_NR_LMDESC))
> +			lmdesc =3D channel->lmdesc.base;
> +	}
> +
> +	channel->lmdesc.tail =3D lmdesc;
> +
> +	rz_dmac_set_dma_req_no(dmac, channel->index, channel->mid_rid); }
> +
>  static void rz_dmac_xfer_desc(struct rz_dmac_chan *chan)  {
>  	struct virt_dma_desc *vd;
> @@ -450,6 +508,10 @@ static void rz_dmac_xfer_desc(struct rz_dmac_chan *c=
han)
>  	case RZ_DMAC_DESC_SLAVE_SG:
>  		rz_dmac_prepare_descs_for_slave_sg(chan);
>  		break;
> +
> +	case RZ_DMAC_DESC_CYCLIC:
> +		rz_dmac_prepare_descs_for_cyclic(chan);
> +		break;
>  	}
>=20
>  	rz_dmac_enable_hw(chan);
> @@ -500,6 +562,8 @@ static void rz_dmac_free_chan_resources(struct dma_ch=
an *chan)
>  		channel->mid_rid =3D -EINVAL;
>  	}
>=20
> +	channel->status =3D 0;
> +
>  	spin_unlock_irqrestore(&channel->vc.lock, flags);

Maybe create a patch to convert all the spin_{lock,unlock} with guard()
in this driver.

Cheers,
Biju

