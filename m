Return-Path: <dmaengine+bounces-9998-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KqscGBA/2ml4zQgAu9opvQ
	(envelope-from <dmaengine+bounces-9998-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Sat, 11 Apr 2026 14:31:12 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E7E3F3DFEB0
	for <lists+dmaengine@lfdr.de>; Sat, 11 Apr 2026 14:31:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C700F300D775
	for <lists+dmaengine@lfdr.de>; Sat, 11 Apr 2026 12:30:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47DE617B425;
	Sat, 11 Apr 2026 12:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="v49K1APe"
X-Original-To: dmaengine@vger.kernel.org
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11010062.outbound.protection.outlook.com [52.101.228.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D34B78F2E;
	Sat, 11 Apr 2026 12:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775910648; cv=fail; b=U5EbjA9RATWhx+jRb+JKkpd86CnXlTcB5ERmC37Ihbn3LzeRNUAOT/etMpj5MBREfKvnhWngHhANBktlSefLcepckD4Dso2mSuo3c2cq60A/XsPAyQVijIw7qGoHhx+IjsKuiRuMtRmCHU55hB9opUqbNRJ1SLgrjktkSznnuKM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775910648; c=relaxed/simple;
	bh=Wp4uRTNX/bdI7XvW4No5bbs6fiVMIhF877Hceud42xs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RhKpWFJpUm9ta3FfUhudcvuDzD6a5yJH6RLfHytxsJubdgpSt2TWtusw7KYsfEhHJGn05e18lJXdS6jfUQ/oWdDM28u5eOStBAkntHdkVkCuGvSByFiuKjthhu94ZLjZJ0wCT6F044OEO+7aLEnlNKBOyY9ETPfk9vr9REofncE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=v49K1APe; arc=fail smtp.client-ip=52.101.228.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BsSgMGcKr1r2KDo7l8i0wNUBd3ZSvz7QqQweY0W5zZdUtzaP140j+9CVrXTjkmfsxZYmSad813Vwfp/MXTfUckxXWPCLAPTIDG1lZUu6jZO0x6DIK21dZMcxe+oOrRJWxuTEE16v2VXzltrfVOsFYfzAcTH5O1AavyHjgsLNsf06DLzeAOSE7Sw2bosGAR+BkDY+0ewLNXWE1Z+J35AQHMpxNKtGRfnejaoMIj8bIDqubNfo67o/7tXYpPlgQ4OGlm2AwsRUu7yhjDhbCeaM3URwChJWPAy5DBMCI6E6VSXuCQaWl6qmS98dCjOglbiEZQFqOXDptHqhf+L7qWJqww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JKYoJFUJeUDhL0uhbUmBUpd7a931t0A1uUs03SkOfOI=;
 b=D6JR69vhImQZvz1LHwLw/IPyVc5IU0x4mAN3WNvtiXIQBv3LsocA9JBy1yau3yDFymhD2F3E1VMzPdN2WCNmAhsYeXLgg4Q06LlXxof0F/gKnI+n5asd5ZOPm+xclc17FsdOwqGv44udtZY0W1QHLygjASiUkgmeMmlbKgcCjI/weOom7nf0xF+F277WRJivTSDTkkPiMWD0WP6JPFa+OUSlcHsJ8HhIiKDZNLusQP9wUayq+Ov+WsvFmQ5EhH9w+S87T2rFzoNZaG7a5myVqFheaxSdujpuF3SUQimxd94MABgONTW/tlCaPDTXE0n5NJYDexjRYruUlvVSLW4ORg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JKYoJFUJeUDhL0uhbUmBUpd7a931t0A1uUs03SkOfOI=;
 b=v49K1APedPgVBSj15wezGUB4ahxyKASRYa916sz4Sv2QpMADcUA7FXRVnZtKtSs0h9opfpxYYsxmgpePOtR5ZR5SuwMoVlSabMX7bEjvmoOCjUWCkQhHRaqJT8E16uQkCVyGwNUoorH0CRuG+yjyDqh48QIjQ70R+vLavvuDtx4=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by OS7PR01MB17824.jpnprd01.prod.outlook.com (2603:1096:604:441::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.16; Sat, 11 Apr
 2026 12:30:43 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de%4]) with mapi id 15.20.9769.044; Sat, 11 Apr 2026
 12:30:43 +0000
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
Subject: RE: [PATCH v4 05/17] dmaengine: sh: rz-dmac: Do not disable the
 channel on error
Thread-Topic: [PATCH v4 05/17] dmaengine: sh: rz-dmac: Do not disable the
 channel on error
Thread-Index: AQHcyahmZN3GNCbaGUaclgQ9L2JEArXZydig
Date: Sat, 11 Apr 2026 12:30:43 +0000
Message-ID:
 <TY3PR01MB11346923D8D18E79A9F7AC10086262@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20260411114303.2814115-1-claudiu.beznea.uj@bp.renesas.com>
 <20260411114303.2814115-6-claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20260411114303.2814115-6-claudiu.beznea.uj@bp.renesas.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|OS7PR01MB17824:EE_
x-ms-office365-filtering-correlation-id: 56b4d250-4b1a-4e58-dfe9-08de97c62647
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|22082099003|18002099003|56012099003|38070700021|921020;
x-microsoft-antispam-message-info:
 JSOselteiaT/YflnZW/k02A1Eq4wEtqfsihC3U7IHFzsm0GWVz2D57Wch9yYOkc4gVwPogQqdVqn2LULSDnfBs2eliWN+S7sdrxeYwrI96CK269ZxgbmgsYi+IMT7D4nQi0XGqTfMDayyXGdnCZTaFxFbvbtr8lQBYyfGYEYYnQxYCuRIYzfi5cQ+TQNdjUhZXPMP22Lw8USd/9nEa1KPQKhvQgQ9SvkFCMXH9+CDbGdAa/ppTGi8Q/DpKXDXq1eL2X3NuurMMEdHELOVH3dGxqQZ+zlABsmFnc/YAjOL6vwTA8NsGM+T+DL+wHReHLLK/50f/syhTSVO7iaZp7YFDu/mkj93UJmKDTXWmAN9+wjv6AqGv62r0LCXc5AMQxwPit06XY5r2ejpupoeUSuN//ZPwfGAuJQeREpbXYvdjukoRaAvTCpCwAYpSQ8w8h+u7j2fBoGpFDhp4JmGY45IGAHHGHFMQ43tquY6YLi0xEK9CoQn48n56q6rjydLGaGkyaUz95uk0tqqvmkyAr7HbaGhwEwkcFFa9KZTfDg1QLPuV7i5FKANOKX9jVnyFcMn+5FBIXKMGjRouz+HHH5OdN0D/2OsdHMkV0KgYnPf43O3mBO2JbTR5OcPwVqBJjWIFiUaIK6g1wNqXiG5Zw2eZhGS22j+oZls5oUitjJofo5Y92tdyGsGGZpSX+AcPhPg8yQs5eKdbQtOjydsKaix56H/n8utlEsL+Fapybm9QjCRrKEKwaiFsvhWbXtTGuWqIk5G+QENPrmyNOe5F5JwmncPGZFy1Ukl1LtmxIyybUJbx4w6EvOAU0KaOKSXHwn
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(22082099003)(18002099003)(56012099003)(38070700021)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?GK6ktzNm420q2BUh42+WHGJtxhOC2LtYC21oN8eOe2Fa0kdYLCdn7NT2F5MI?=
 =?us-ascii?Q?gQpdv8gFjZAvlWMF8+PBrKHJx7kU0UcvkM2c/m33j6616Gig17xp8zOG+rEA?=
 =?us-ascii?Q?YOENizc0HQkhPKTeH8uu53KyxfITlDUoCaqLteS1gc5mCwEi3qwd1avkawGY?=
 =?us-ascii?Q?qHLSqD6CLtxZptM1SSoAYJt0X1WZQDTPBNQcMUHGaAA9BLkSknouir1dtqXr?=
 =?us-ascii?Q?X9yIQj10g5jOF7l+gtxFUB++aamPwr/DBpnQRHJRhYQFX2AK+K/1Ehr8Xr0U?=
 =?us-ascii?Q?J2783Sek4gNfu+JDfnLGiBcdqCxb4uTGDM3HHGqUm1+ZQcbm0FGwCR8/nf0/?=
 =?us-ascii?Q?l4MUH4vHfbjZR1wdGfbaE8+vBOSFDkO3jA8uGCWJEfiIvWRxgbsH9KQOPY7I?=
 =?us-ascii?Q?c6pptd7ATGxJS18RE1SQLxYgaOlrx5pbAxwKERD6K6ha71Xc/PaKzrR0Fm3Z?=
 =?us-ascii?Q?kHMpwnQlpdANZqtVDdZg7t3LZZBQGM3BvA2nz1EudsYmBhIHK5IyumPwKbXI?=
 =?us-ascii?Q?8lgWhL397cRFYG4f7n4VsDTgfs3XG+O/QlnEKBOOV7+gFMWIlOwlGSvsevMM?=
 =?us-ascii?Q?mYyQAjNlL2VaavS+1/0pMW2IZ1gU4HfSP9/tjukZjftgPVfqBwGllPHDta4k?=
 =?us-ascii?Q?FaaXHneKuaOv9t7xwAhbwuKvfoSq7rWPvK3Wb719T1V8PD/wvMPwfLgBiaqY?=
 =?us-ascii?Q?hzEE2ymYFmpKbslhESnyjMS48BesrhHopQ1pJ1fk/+om7b2tzhOHD8/JUaBb?=
 =?us-ascii?Q?cEH3nRIQcfX6XyGgjJU0s1IAsFqc2H3ozxdIJxwfBXmD1dIPWlqh0j/uyTla?=
 =?us-ascii?Q?r09MG9jSOO6VbKg5novc+bw3e4g9Vf/GCl0Fdkz1xbEdJ6Js5IHx+LK97cQS?=
 =?us-ascii?Q?ig7/WLi3WWo2YbduhXTgkj+En1Gsnay5nm/8ZySdF4R19NCOO3RlQBBU4yu8?=
 =?us-ascii?Q?rGzcoY/txHBAMaPyXOrmbv2e3wzpHWkVk8b/o1Vc+wtNN3hQ0eRu5JiXQXEm?=
 =?us-ascii?Q?Xm3M4ZYy37gEL3ezFF62W+1+W1nK1O2dqWB9CTcsoTjOfyQcDIi8p949YxDn?=
 =?us-ascii?Q?NcZ+jT3i+sQ8AONkFLhX+fTkCNrNVrwVHzLPrERgfxXeKcQD58vcYxDhsxxx?=
 =?us-ascii?Q?hbr1rQkKPXEI5gQ8/4S3C+1/UAeJY+n0rG7a6vJtvhjzrMUfgXEGSUPjdwNG?=
 =?us-ascii?Q?vREw0FbLw3w5MRal+GZeyTS7WkDoaB6iXfiOte3twnoshscXRgxURbCk4tze?=
 =?us-ascii?Q?WYopGvk1pLuAEMMWU6EZI4ABm7rycFNRQhJnU79MyCD1hFgKk9j+Xw6iJx1I?=
 =?us-ascii?Q?PfIlga4M6TmNC1kF91jpGVNGduupKZgbRU1X3TTBAxxY4Fl2Xfb2ljjE55p3?=
 =?us-ascii?Q?x5hXhp7LJCkuHKF8Vr7pJZ24U2nPXzyO0DKdBK/nzflMHmt1zDhhXiDSAdhn?=
 =?us-ascii?Q?07XgogGJ5ud0eI4xvlQSOY1gYK5pp6djC9lf5XtRrLR29yBG5qPmEu7XR8tv?=
 =?us-ascii?Q?xxRPVa7Mr0aEQqWcET0Fo33cvD9YvIwRMWG+Rdu9Vl05coNVYODIVl1oEBKk?=
 =?us-ascii?Q?O+k0bdaQCuw9cBcXAIhSCiXiIDS1iEzbhDF3tRy1C62pr2cwpLBTaC9mKHAl?=
 =?us-ascii?Q?5hXFCoIu5kBB7d3RBBdtp88Ix7akczcqyvazAYHVOC1Odha+c+ZwfTDI+C7V?=
 =?us-ascii?Q?Ja6XQD4zJ9DZyM9Xx5NldJgyH2LQ+AdTh1+cPoDYXvK3c3Hb3gbTZKyMvq9C?=
 =?us-ascii?Q?/FxTnn2h4A=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 56b4d250-4b1a-4e58-dfe9-08de97c62647
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2026 12:30:43.4448
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pEHgoFBEMyuYg08J9owWVEttvQyfAg5y1ZcP5mfI5vl4SNeBNTfdqlhZh1Yxbiyv3MLfsQb8Ka9PjO6DcGkxcqEt9PDQpZlHyK4HX01XjmA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7PR01MB17824
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[renesas.com,none];
	R_DKIM_ALLOW(-0.20)[bp.renesas.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9998-lists,dmaengine=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,TY3PR01MB11346.jpnprd01.prod.outlook.com:mid,tuxon.dev:email,renesas.com:email]
X-Rspamd-Queue-Id: E7E3F3DFEB0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



> -----Original Message-----
> From: Claudiu <claudiu.beznea@tuxon.dev>
> Sent: 11 April 2026 12:43
-soc@vger.kernel.org; Claudiu Beznea
> <claudiu.beznea.uj@bp.renesas.com>
> Subject: [PATCH v4 05/17] dmaengine: sh: rz-dmac: Do not disable the chan=
nel on error
>=20
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>=20
> Disabling the channel on error is pointless, as if other transfers are qu=
eued, the IRQ thread will be
> woken up and will execute them anyway by calling rz_dmac_xfer_desc().
>=20
> rz_dmac_xfer_desc() re-enables the transfer. Before doing so, it sets CHC=
TRL.SWRST, which clears
> CHSTAT.DER and CHSTAT.END anyway.
>=20
> Skip disabling the DMA channel and just log the error instead.
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
>  drivers/dma/sh/rz-dmac.c | 4 ----
>  1 file changed, 4 deletions(-)
>=20
> diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c index 40=
ddf534c094..943c005f52bd
> 100644
> --- a/drivers/dma/sh/rz-dmac.c
> +++ b/drivers/dma/sh/rz-dmac.c
> @@ -871,10 +871,6 @@ static void rz_dmac_irq_handle_channel(struct rz_dma=
c_chan *channel)
>  	if (chstat & CHSTAT_ER) {
>  		dev_err(dmac->dev, "DMAC err CHSTAT_%d =3D %08X\n",
>  			channel->index, chstat);
> -
> -		scoped_guard(spinlock_irqsave, &channel
->vc.lock)
> -			rz_dmac_disable_hw(channel);

On previous patch, rz_dmac_disable_hw() for initializing each register

+	/* Initialize register for each channel */
+	rz_dmac_disable_hw(channel);


As per hardware manual,

Once an error occurs, the data of the whole transfer cannot be guaranteed.
Be sure to start the transaction again from the
beginning by following the procedure below.
1. Set 1 in the SWRST bit of the CHCTRL_n/nS register.
2. Set each register again.

Is this patch doing the procedure mentioned in hardware manual?

Cheers,
Biju

