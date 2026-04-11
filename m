Return-Path: <dmaengine+bounces-9999-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ECmrG84/2mmFzQgAu9opvQ
	(envelope-from <dmaengine+bounces-9999-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Sat, 11 Apr 2026 14:34:22 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C1CED3DFECB
	for <lists+dmaengine@lfdr.de>; Sat, 11 Apr 2026 14:34:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4D11F301ABB7
	for <lists+dmaengine@lfdr.de>; Sat, 11 Apr 2026 12:34:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E93841A08A3;
	Sat, 11 Apr 2026 12:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="RruzEhbA"
X-Original-To: dmaengine@vger.kernel.org
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11011036.outbound.protection.outlook.com [52.101.125.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 448981891A9;
	Sat, 11 Apr 2026 12:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775910858; cv=fail; b=Yce4bJIi44jdACk/63Xaa8rXhJQNsTqKsxaiOm++Ctf+SYPgIhY6VzuQh7UL6CUa8ZGiZ6WLfOU5RS5w9JjiSU3gGj68vYBE/fmmYeujP/oxkARLzvv37j8knvkLqvH8BrB07/swOe4Yp7lD5UJbAAwTg6PAgjUKDP51uFL/72c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775910858; c=relaxed/simple;
	bh=EIGluyXJttJ9LeVdLNMx4HaVQvytmOHJ7cueYpWHJYE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=eFI4vbCt4CLLc+GAWHd3hatQmLuNOZQBgNrJvklFAvpkQLzmBrZgyr+j2V23+mTC1xbLLCMs46LUTevnu4CfCIkbKRN4YI2i/vQvBzGPDOybBm6YN9hLcOddZirBvCOEBXrpr0uSD/UNfMxe25U/h6xJ/pQx6nQL8ix0z1vhgBU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=RruzEhbA; arc=fail smtp.client-ip=52.101.125.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hvmhDvrho0wB/jIhFVPUyKZ6slgXp33CJFcB+eutgqoCe0WBYZxMsIlt6rODG92Qc0T5zlBG4y58har/tyd2CNXBoVQYk5Gf+5CvjJABq0vz/I2gCuPg3EKFo9tXldZdgRkpyTKFd2RaxuGvwbxdGOFDpTV8GAbNlM/ha46Mhpk+Qm8kQw1a6O2KIrv3QKek4wVK/C0Dn66f/6fJsluoj3WjWqacWv9JGbUKb6ScKJjm6d90qKTC5TC+IEPbO5x91gX591Wa7LI9nxOQCWX5c7SOjgjieCuh2Xy5l1GiFgnnH34gsY9bcUUx8VRMOhYsFsdLId3MN7kfi4jlhRH6DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y5zwU/T/Fv1LwgV3ie19UnEX+4funG2b6+xrxrwXxMo=;
 b=p4Ag9QmnimBJ7LAFrG8rS5lAO5cnEUs6t26fItIMuJx8iQzHrzfJBRjf5pp+k3jhb8XdNE/iyfw8VF2IQNIByj4tgAl/3ixkniq1Wirzvq+jMv7qyrfMBt4BCsNqfnRavNgaTYhcX9/qcGAjpiWOt92ALSy4ie6PnlNBctIO0GBcBYBXijQbY5wNquYuckZzmV0HrFmjLZ6jmuC9Lj/O2l78sGpsOhHcnnoHn7mgdlSS8J1VCuO+7IMGCMcelesSrdZeOKGKVpXyhJmZS/61GDRL2u2XNfD2xd4xH8Uvq1jlYIreWavrSEiqOTVL4E8xgaP94G8jGNSx6W1aNVaqfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y5zwU/T/Fv1LwgV3ie19UnEX+4funG2b6+xrxrwXxMo=;
 b=RruzEhbAATFGBX9H0fwrA8TPI/iCWr0GqpSpWp0oLz/zHblM3/xL6SIFeL+XhY82iEI9HuRgEobMAjx49tlK4lC9akpJf1A3DxI9Wg7jN5U3JyXZkI7KxtE5Cy5dV+2QuAYRbM9Z/Vltu6LsdOjIyUOaRYYDRdYyIChNV9pxBUc=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by OS7PR01MB17824.jpnprd01.prod.outlook.com (2603:1096:604:441::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.16; Sat, 11 Apr
 2026 12:34:15 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de%4]) with mapi id 15.20.9769.044; Sat, 11 Apr 2026
 12:34:14 +0000
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
	<claudiu.beznea.uj@bp.renesas.com>
Subject: RE: [PATCH v4 07/17] dmaengine: sh: rz-dmac: Save the start LM
 descriptor
Thread-Topic: [PATCH v4 07/17] dmaengine: sh: rz-dmac: Save the start LM
 descriptor
Thread-Index: AQHcyahowtZW2SpfKkiEwpkT0iqfGbXZyzCQ
Date: Sat, 11 Apr 2026 12:34:14 +0000
Message-ID:
 <TY3PR01MB11346602C7FD8ACAB74BB568486262@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20260411114303.2814115-1-claudiu.beznea.uj@bp.renesas.com>
 <20260411114303.2814115-8-claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20260411114303.2814115-8-claudiu.beznea.uj@bp.renesas.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|OS7PR01MB17824:EE_
x-ms-office365-filtering-correlation-id: 7f1c2ac7-7e01-4126-75b6-08de97c6a454
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|22082099003|18002099003|56012099003|38070700021|921020;
x-microsoft-antispam-message-info:
 t2h5H1Ya7eOJtkg0SgG5j8xpUx7yY7bzHISb2w568IHL4i7e6Hzjk5TCBQWLNMSSsyHTOfuX5aHL06Ilf3BYBh377hM//+W7RapYzqTNgh5jDQqSMm2q5WEVLVmzbixrmfi9tQ1ayHuQTyo9jWuPOCAiWTYbrxMCaf+l0nlSBbek9Vb5Lx1H1kXvy6nHs2d80G1pYqSLi3eRDjhSL1PynsxQzrxCd3PMTLAXuZjLzidWybaWKC0Rxaa2PG1QqcveOJHs7hcBYPa8GF4tia9/ycYy6XRRx+7lmCsrZfgYH0shU36YKBVp//cNVKcSZYWpoMhnhEK52kUooNLfhZ6YbEdeeiOOC+Tx7CHLvkwVFlGa4ytNKlL++tdjEaBbE3hRBeNQvtzIZN8LfaNzmTWja1Dro482QG9GUOKNHqCZS0nddElGfJNhAHKc8oObUidxMDpxLHUx4NXolrG+zic8D0Z7tZCnN8hsONahkYVd+8zzqW1wPQhfpnPlmJqsLBTz4k9IaonxAIOleStSwMqM5wiiaeX4AgObqeth+6WDirrM0yd2RnbZr3wUvtQb5Lrfs7oFC8kCxdOIfAOtl0HbqvR/bcvB4rdGcqis+3rk2yrY4LwC/rYuyJQaiJ6rfJ4Pu9OrqpLVlI2tUJmgUFHxed4xAO27ElVONC1XFat+jyhmYnf4svSfjU5GMrsjc4yAQj/wNSgHQvtim+OFXXptWK7u/KNSh17uXJWIUz31yQXyoFLmaIzRW620d61DkD0zpV+B4n4d+51iY9VIZhUBiuO++9x/3NenUrvfrZmN+sxv7tT4zvkRvlU+TFodrENI
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(22082099003)(18002099003)(56012099003)(38070700021)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?i1Cxtr0dhO1W9QkLT94y8+R1bNDmsADlwVFCmCaqBFBTw8RSVGxIQIzWcZid?=
 =?us-ascii?Q?evp1EuJpdpl7myYFWJM3UGIsNsbL4ataGZs9jPy5ULwlF9n6GeFm08zWdtAR?=
 =?us-ascii?Q?1zHy+Sa/ezJIyZxQyGg+heHzxo89uwr8UAelMHa0sKgH3dX1HM2yZSKa8prO?=
 =?us-ascii?Q?bbPFHphnGAgt0jDjMJzhyjoNaMn4h0qMmZxupDbIwoJlI2nHzMUiHaKHJn3G?=
 =?us-ascii?Q?mfPMpc60f1/w9DYi8VkMnVnlbiS++uFEG7UqBu6uBi5EUd5dVa+yOJWfcOoh?=
 =?us-ascii?Q?OZkxr4hZpopv7HW2PjeQtXGguC9jsoDQGF5K0IbP9J2MvvqYb68gT3BD71zh?=
 =?us-ascii?Q?gfeBlQbVjS/gGyjiYQkFgptoGhvV06MVfxeWAU5lzHc2c3AyNxUfj8ZDBLYF?=
 =?us-ascii?Q?xJGmnOf8Hddn/TSMFt1GLA+HDX2WNTlY3G4hHsTIRCsWyzApQHbq4Zpe2TSg?=
 =?us-ascii?Q?Jv98SUZdIzVBIS4UxmOxd0BPmRTwdkCy36T143hUj7NdDYsRt2yfJfMxEd3j?=
 =?us-ascii?Q?E0fCQUpHQ3QTfInl/cmcH44QTAbkqeweRM2Vn/7R8oqiqfGDjokOHzTc3ZgG?=
 =?us-ascii?Q?3zPGmLhkKDf8WSKmQGlnlkBHIWA//yDIcO2wId4QESMwIH4/CU9fNxlqOh83?=
 =?us-ascii?Q?wnBq7Im8vH+O79JG1FQMYFqWDb8MJ3U7Pu5hijE3hEBxOLTQXqU/UZ9RKK/o?=
 =?us-ascii?Q?8U5XjgmWyv8J7uGrc2lPmOxJiZvUDPcfF2fF9glTKSPN4+xfGWyBX0p1kx9G?=
 =?us-ascii?Q?3lLHIsppC6azhBH77BEaep8gjnleP0dkgQ6Tqn69DNtA8sFuSaG8u0S1FVLA?=
 =?us-ascii?Q?6lCsSnHAAO0doukTxUvWuLku2dRQ3xmg7YHmgIY0DvwjWvTzTHU1+5CCmevD?=
 =?us-ascii?Q?Uv93QQPzWMjI9tWk+EGRVpFOhpgWW+m1/HBeTo5A2rY5YfWTJNPu/806nYW1?=
 =?us-ascii?Q?YfDX36KskG8dqtiF9zJb/9LDGjqKYO+TGBvJKgxq45as/UxQ68OifDVQiLW3?=
 =?us-ascii?Q?aO+JdD/PxEl5Qe/73M+18OT/gRKX+OkvsUHuFDIcEKphh1Qll+0CshfZIVgS?=
 =?us-ascii?Q?uWEmmch4Bc56/1AOpIJ05pZGVYhdS+pXjqXQQGIwKaR90VsKOPBpxGSqNgJK?=
 =?us-ascii?Q?WyWyYb5HaBzLvBBxcP2acF8lbaV9y5dDeEZj7cHXw8L/fDhCcnRFXxMMp96i?=
 =?us-ascii?Q?3kzwSdTCfmAdjlKI0QWERRYN2gnBAKPsIhoFCOFY+sbbC/vx5UEhrJzP3aTF?=
 =?us-ascii?Q?Ejn+e5b1oENcDCJrGHgKF8zSMKQlydbKl+6nGO6NBINM1do8/LGcEf1ABPgQ?=
 =?us-ascii?Q?6c5n5eLki16muBTro7pw2B5iGST9ZH+lbO1mXR6ghANhhQK0jffo8DSxXRbz?=
 =?us-ascii?Q?wCj35tP040H7BTC2K04iKUHlKkOGqz44nsX6a4N7DB+c8ZqzptGwL1Txm315?=
 =?us-ascii?Q?9JJ1DNNBQkqvMERZ/7VorE+rP3ELpw5bpYvu/eOIy4+DOHOt4vBzGrN7vD+m?=
 =?us-ascii?Q?HNpWi5+5E1ZeC98NWx3Ha9cxYOhfOz1bYCNTyLBje+qfIX2mxSTBPizDDPGl?=
 =?us-ascii?Q?tVsxFVuPhXuUJSyYrwqoE9EOIpMhAJQyRCORczy6vfn/yITef90khbfyYC0A?=
 =?us-ascii?Q?JGWR7v9LKEtYuqvaH5DzAqPYQYrWrc2o/MIbmKRFHKsTeE9vsIekmBFEI/Td?=
 =?us-ascii?Q?qUr46UdHP0fvMjWGign7qxMFuqeAu7HoKRnu2udELI8HwD8P/qdEJp5+9GJD?=
 =?us-ascii?Q?hxoeMBCWUQ=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f1c2ac7-7e01-4126-75b6-08de97c6a454
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2026 12:34:14.9296
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QYuuYUIcnOEDa6E5MvPBu0ShmjrWcNzHDN9BChR9ZUe8/RC+9BAYXnaX833z9laL4hpLXNluoaQxj7PptsZw6HChU5r+Yj/usclwWzyMZgQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7PR01MB17824
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[renesas.com,none];
	R_DKIM_ALLOW(-0.20)[bp.renesas.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9999-lists,dmaengine=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[18];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,bp.renesas.com:dkim,tuxon.dev:email,TY3PR01MB11346.jpnprd01.prod.outlook.com:mid,renesas.com:email]
X-Rspamd-Queue-Id: C1CED3DFECB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Claudiu,

> -----Original Message-----
> From: Claudiu <claudiu.beznea@tuxon.dev>
> Sent: 11 April 2026 12:43
> Subject: [PATCH v4 07/17] dmaengine: sh: rz-dmac: Save the start LM descr=
iptor
>=20
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>=20
> Save the start LM descriptor to avoid looping through the entire channel'=
s LM descriptor list when
> computing the residue. This avoids unnecessary iterations.
>=20
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> ---
>=20
> Changes in v4:
> - none
>=20
> Changes in v3:
> - none, this patch is new
>=20
>  drivers/dma/sh/rz-dmac.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c index 6b=
ea7c8c7053..0f871c0a28bd
> 100644
> --- a/drivers/dma/sh/rz-dmac.c
> +++ b/drivers/dma/sh/rz-dmac.c
> @@ -58,6 +58,7 @@ struct rz_dmac_desc {
>  	/* For slave sg */
>  	struct scatterlist *sg;
>  	unsigned int sgcount;
> +	struct rz_lmdesc *start_lmdesc;
>  };
>=20
>  #define to_rz_dmac_desc(d)	container_of(d, struct rz_dmac_desc, vd)
> @@ -343,6 +344,8 @@ static void rz_dmac_prepare_desc_for_memcpy(struct rz=
_dmac_chan *channel)
>  	struct rz_dmac_desc *d =3D channel->desc;
>  	u32 chcfg =3D CHCFG_MEM_COPY;
>=20
> +	d->start_lmdesc =3D lmdesc;
> +
>  	/* prepare descriptor */
>  	lmdesc->sa =3D d->src;
>  	lmdesc->da =3D d->dest;
> @@ -377,6 +380,7 @@ static void rz_dmac_prepare_descs_for_slave_sg(struct=
 rz_dmac_chan *channel)
>  	}
>=20
>  	lmdesc =3D channel->lmdesc.tail;
> +	d->start_lmdesc =3D lmdesc;
>=20
>  	for (i =3D 0, sg =3D sgl; i < sg_len; i++, sg =3D sg_next(sg)) {
>  		if (d->direction =3D=3D DMA_DEV_TO_MEM) { @@ -693,9 +697,10 @@ rz_dmac=
_get_next_lmdesc(struct
> rz_lmdesc *base, struct rz_lmdesc *lmdesc)
>  	return next;
>  }
>=20
> -static u32 rz_dmac_calculate_residue_bytes_in_vd(struct rz_dmac_chan *ch=
annel, u32 crla)
> +static u32 rz_dmac_calculate_residue_bytes_in_vd(struct rz_dmac_chan *ch=
annel,
> +						 struct rz_dmac_desc *desc, u32 crla)

U32 normally used with register read/writes hardware related.

Here it is just computation which returns number of bytes. Unsigned int wil=
l be
appropriate instead of u32.

Cheers,
Biju

>  {
> -	struct rz_lmdesc *lmdesc =3D channel->lmdesc.head;
> +	struct rz_lmdesc *lmdesc =3D desc->start_lmdesc;
>  	struct dma_chan *chan =3D &channel->vc.chan;
>  	struct rz_dmac *dmac =3D to_rz_dmac(chan->device);
>  	u32 residue =3D 0, i =3D 0;
> @@ -794,7 +799,7 @@ static u32 rz_dmac_chan_get_residue(struct rz_dmac_ch=
an *channel,
>  	 * Calculate number of bytes transferred in processing virtual descript=
or.
>  	 * One virtual descriptor can have many lmdesc.
>  	 */
> -	return crtb + rz_dmac_calculate_residue_bytes_in_vd(channel, crla);
> +	return crtb + rz_dmac_calculate_residue_bytes_in_vd(channel,
> +current_desc, crla);
>  }
>=20
>  static enum dma_status rz_dmac_tx_status(struct dma_chan *chan,
> --
> 2.43.0


