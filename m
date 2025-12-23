Return-Path: <dmaengine+bounces-7905-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B27CBCD99DA
	for <lists+dmaengine@lfdr.de>; Tue, 23 Dec 2025 15:25:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4B160300F322
	for <lists+dmaengine@lfdr.de>; Tue, 23 Dec 2025 14:24:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C64032B9AA;
	Tue, 23 Dec 2025 14:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="CoTVPMOL"
X-Original-To: dmaengine@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011048.outbound.protection.outlook.com [40.107.74.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC6962FAC0E;
	Tue, 23 Dec 2025 14:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766499896; cv=fail; b=SRSczVANiiK1Alc++c5JDK2TD8jvlEPYRguGtw0FuHbIt5j220kqHQF/cXV/+e3e2wI/CNSWwCXo1A65YXrf/H4lhjBUMSamtuo+uHYLzlB0fx+PxGJ8cO+PjVBxvuqh1IZHzN8Vw4EpKXfS4woaOO2mMrRSrsx6KCxVZEZC+w4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766499896; c=relaxed/simple;
	bh=T9bp7oYWkGDATa21o9Xchj8FC4QMcf/lxl+b0u+UjRk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GlQcD1Xm/Fdy1Q1USax9rgf+1/m6un6pWbYKD32d7z7sZk2wnSg55Q4iHmDIU1JZAfai6lMziMGwKVSYwURCdzT0vHafkZVytJ2aMhvMKBrsbNCBFCLfyz9VxI+yygMtkEljpG5nCyAj17+DHYl7gLHdyJr2w2O9AORKOtfsyBo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=CoTVPMOL; arc=fail smtp.client-ip=40.107.74.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YHLyB+efE6p51+pjFezZTH7Yqr4NCEdsW2/9fGKD2qq99itQB+9lPvInK2LevZGGkt0uWV8zzdjqXyvMoL1zyUJwaw3PNAJSzromv9QPACc4O76CO0bkKX92YVVUnvp+Zn+dKzr6KK2n8ys6OaXbyYxqgt45rqbgzceHIX/8FcgTWxIZ9q/TlqU88mtFKITSrvb+Owuoc3Vh73QcToqmtvQZYaLUm1kG8u3gWnQITzjrUOBG+izGprapHUBgSec0HZnQIPSEpdvQz0LJNZLr3/QOP5DF/H5wpD8hKYEQyrYy5YVIakvJE9qQr2+YEVOHW4vW5ylVAKZUj1MnULfQ1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YGvIhjcPONjiUApAaARGIqpFKcYiZqCYeVnim4OdxNI=;
 b=lYFEKsi8T94a9EUYdlHtERShUc+hM+4krgg7fglkh0xUjobZaIJY1eUmFWNBEj9CEQVR2GiNx4lPWV16jo8qMoG6Yd+8kjd2I8vv18BNsFhYjXmNC+OV8gt3G+SBW3v70/oLp4S55a51pjhwGj3k3ociElA8xJZesJKSC1rpaXUTH6l4+bMZk4eNPCDOu/foxk1+inKSUee7DpBDNbEeccVKLFeTw5LJwZRLArHrKmbsfmpCLYev4Ydq/HNR8dB1QsYig+dtNyM6ED+Rn7tlMY3NvS/nRifLaFgElfR1bbAqDAuy5yZbdH6VIPsDM/qxuJXGxjmJPTTj9C8ioe1rPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YGvIhjcPONjiUApAaARGIqpFKcYiZqCYeVnim4OdxNI=;
 b=CoTVPMOLmhNbOw37Ts0B55NHf1/cfFaypvOkcyDtpRR1LNdPS9WsNnpw4gRjqUHpBDtt6Pc4GJlws/nzkTcX4ygtgl94dBzDM+IzkUfvRo3fKqKFAYKAOW6fTMiQxLOa+f5bM5aBG9LGPM7DJPJrDI5ITGYsquoIR4ZBAe+X+QM=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by OS9PR01MB16098.jpnprd01.prod.outlook.com (2603:1096:604:3dc::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9456.11; Tue, 23 Dec
 2025 14:24:47 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1%6]) with mapi id 15.20.9456.008; Tue, 23 Dec 2025
 14:24:47 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Claudiu.Beznea <claudiu.beznea@tuxon.dev>, "vkoul@kernel.org"
	<vkoul@kernel.org>, Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	"geert+renesas@glider.be" <geert+renesas@glider.be>, Prabhakar Mahadev Lad
	<prabhakar.mahadev-lad.rj@bp.renesas.com>
CC: Claudiu.Beznea <claudiu.beznea@tuxon.dev>, "dmaengine@vger.kernel.org"
	<dmaengine@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Claudiu Beznea
	<claudiu.beznea.uj@bp.renesas.com>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: RE: [PATCH v6 2/8] dmaengine: sh: rz-dmac: Move CHCTRL updates under
 spinlock
Thread-Topic: [PATCH v6 2/8] dmaengine: sh: rz-dmac: Move CHCTRL updates under
 spinlock
Thread-Index: AQHcdBMkHSl9Q52GS02yRnvn1nk9H7UvR2Zw
Date: Tue, 23 Dec 2025 14:24:47 +0000
Message-ID:
 <TY3PR01MB1134657B08475CABC31BBE9D186B5A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20251223134952.460284-1-claudiu.beznea.uj@bp.renesas.com>
 <20251223134952.460284-3-claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20251223134952.460284-3-claudiu.beznea.uj@bp.renesas.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|OS9PR01MB16098:EE_
x-ms-office365-filtering-correlation-id: 1f857c6c-072f-4357-0bce-08de422f06af
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?g/1On+vSaMzAGts6bXcSyfJGYDJRFJa4zyX3ExwG2YRU0KzsCchL8G+pCNgD?=
 =?us-ascii?Q?vygil6xTdYgyel8HylNv2AnfLPzK6gyUmMMGZZgcFG99Idp4pLz8/K5YyQ3d?=
 =?us-ascii?Q?2slUiEp9Vf3ZmOBx66Ov7S0G4PjOJMiFhPXJYhm62OaMWc92dn9JBrJwJnsU?=
 =?us-ascii?Q?MBiD6Ju1DLKX6OONJnP34CAYRnK6PJq2HwUAYt+oisS8QKUfMy7Ga2DodNj2?=
 =?us-ascii?Q?se79xRIfOqfCnBbYZz7pca2GnxmOkB6gonlaWNadidWRtdB63zvIeNHg0Huh?=
 =?us-ascii?Q?PVFvIPUJurVXZGHeYTwc6v3HcDdO5Ikh1VJfjf8mJuujFwGF/E1BKIel7K+p?=
 =?us-ascii?Q?Pd6/KK1lCP+iuft0Mk9jKDBSyvCrBo10DzmgG8dHyzCVQqdsshmoBZbpVB2T?=
 =?us-ascii?Q?uLHJQxdN6tyv6/678LG4cVM4g3BqwG7DCLojsFU4CYpzSEO71bmdX1cPf/ru?=
 =?us-ascii?Q?Ixn6O0Yd2aPYg5QlSrpvJ8dM0LcySDMUzA8ml/cJ34vUXCG6INHDFXTlizxT?=
 =?us-ascii?Q?W3TebjxGR6luq08yXfyABPiIkDKiqHcxzOxOCw8ssGz0uNjh1apwL6gAjuxt?=
 =?us-ascii?Q?3vy6KMPEIFd1BMqdmdgykJULHhvhnjrqTjg/IjwXD8aeJJU++gDnB3fe3Hq2?=
 =?us-ascii?Q?AvWmmYpBOwJn78E2tDtoj2ikAIRH1pctRjWv9yA6VY22BVAPpr8qlNdqP2m0?=
 =?us-ascii?Q?iL+DHCDsALKRxkRpKiO3ZknEtC4dlcQEIHtorgfCECF/8FLrU/HM+LhWsDNO?=
 =?us-ascii?Q?mgxigzLZUq0VdBWDvEOwPQCUhTv8doYWrBIMxK+kmW4r/lUfENc4IT8nzb0Z?=
 =?us-ascii?Q?knHT3pFaQr1B33pwpNyu56a8tM7RxB8/LlIdoqMlSu23wETDnZT67dNyqNhM?=
 =?us-ascii?Q?cjboWugRDHJMq7EtZ7X6xf1S5sl5fPG0zpYS3mkbW9UWNPZ1YcFU+T2xvnpL?=
 =?us-ascii?Q?jxNEYWWrjR8T5Q1XoT82Q5Jd6DUtjZOV6bFOEJg+wlQ2xjar9eO8er1Xo+P8?=
 =?us-ascii?Q?0O+Hwam7lMkWn8JAJ2N7xPgaUwULm5iOn/UTt1TxZ1DFbw50Asv+//w4+0op?=
 =?us-ascii?Q?XvzfL37Niij4eNvBmXqf0pV/qlAJLQMvFVVtjvebZddHtd7LGJLos/hwv1w6?=
 =?us-ascii?Q?ic3eESyZAWivFjmkUmGXyjF0IaqH71W4s25gS11JUgYwJR1Fp8ecF3HVAF2g?=
 =?us-ascii?Q?k9e+xUzZnfBHz4eeO2m3AhiEEBd64/BSn7cOycyoccDuireC7bNAXVM6gVhu?=
 =?us-ascii?Q?Z7HLdbIuhRDXXN0sAPUyA8fPB19asQ/9PB5p0GWBwODFLb291buKHp8pffh+?=
 =?us-ascii?Q?7rBAJxBFaKHBN9CELGz+MEYEVSYQ/uWwVSb76Bxe8mGrSDFVz4/j4256kQu7?=
 =?us-ascii?Q?GepwqS/hjFVuLIl5KAJpg6IRWJKpVcQMRQb3VGnBwzK/uBjtomSNu5u1APu5?=
 =?us-ascii?Q?NLzw4TbH7ETFIhj/a20w26qXHNfjxBPZSZdXs1EsVBbrTexay77nJJ82dnG9?=
 =?us-ascii?Q?Hnl14SoKPgU7I33oJjJTKytOZ5MehKCejdcv?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?7toi+a+71B6JwwCTZnqD3Wqa/1jh18F6XuOeIVFPCwPYtaBMZCyITAjZ/iiW?=
 =?us-ascii?Q?MtXtlfjMMwKAxQqgzajqsSsoJQYqpqB0i4alA5v9MdzBHFC31RvLPSo8QfJF?=
 =?us-ascii?Q?EgFSxkAMH/cf4nX8WN/bl8U/WidJQkGdHuVtwAeMQVhDuvbgdPddpk2wHXK5?=
 =?us-ascii?Q?OS8EI4W6rrdv9y0mdoHfCbLs4ajxHHmEA6zkcB95c6TwEz8FmAQvsEeBsNlq?=
 =?us-ascii?Q?CTYldb1ot1Rb/TtkJzJ8oeCnDB+Lg+kk/mBEyrR/oI5J2JqhDXbViNaYDy+A?=
 =?us-ascii?Q?IdPeZQcOvwpuXAKptA3vGs+LAJQkGqJXuPQVl6tMWC+djL6rMqF27MZwm6sf?=
 =?us-ascii?Q?STKj8ZAW3ll7wHEVoPaJdu/sS2kI5lu3d8Yx3RZQrmsorvgHQuUWdCakzC7l?=
 =?us-ascii?Q?eJa/Bupsdo6dAyqi2koBKZ7p8SiImC/b64hBkHffm6dafLbimot9OZkcJLKi?=
 =?us-ascii?Q?IS0cPpqpYGbWNH4IyrvKuzVfplh6Y0Jp5FbT+/D922vJikicgET3Ww7ext6L?=
 =?us-ascii?Q?nZqwTm4sX7cpPiRKyRaOldMYL1EwI3eSVSRru+RgRUsAsmWo03foecPMGNxu?=
 =?us-ascii?Q?dUBB4mmWa7kpbB62qP6TxVpB69M9MEmS+1fNzFJ5clkfT8Yu0E/vi7v4HGOf?=
 =?us-ascii?Q?kAjEtLJlNI5mqadwKqH6smVl+4egxs0s7AMbDg/kBnt+ix/MpTS64E2vL6By?=
 =?us-ascii?Q?KhrAyArH0HyzcUyuvhOfp7ZH0QgxjFVWjDicCsyJ8ZnbE/d86wYhWOsb7nyL?=
 =?us-ascii?Q?hHJW8P/W4F1HfTO+FEJYjQDbcLVbOeqWsWWQROuGQf4lJjsOmbQoBoG+qJm6?=
 =?us-ascii?Q?Jo738tiZ80aP+fqJPKS6SAc2QsJevZch06tGsXDPiqRU3K6Ed8kOHZBuj2Jp?=
 =?us-ascii?Q?RvtIN25rfAFqmLdnFQtvD8ULP4nCwjZQ/l6xnZ+i3GE4vLdAYcrbLcwTfwB7?=
 =?us-ascii?Q?ohNQarOsENNDW+qVAYt7NbaaRV18nJZXjfGRqL2PP3khautWsRkLg28dnmMn?=
 =?us-ascii?Q?Pmgzy3ZXb7UvGz06V3qkAEIP54h2m+pRXc73nyWQVM9hz4VQsWQk21rEzNO7?=
 =?us-ascii?Q?/CbJtn81OVE6f8u7ImgM2O3o9I0PV5FPRbpiT1OWx4147sfhiXBqS7YGGcKl?=
 =?us-ascii?Q?TZNoQOQYzKw1udOrbyrfHgNQAuEfu3wPyUxL+UEzNioz47h76/hBQqJucOrn?=
 =?us-ascii?Q?G0aFApRZgWbpzdC4/NC4w6VIuHTwadoNu9waXxaAIaAhycou24/tUuqRPgxb?=
 =?us-ascii?Q?6JtE4YvNT9TQG0skNBABcCDvEPbPRgxDkc7RiCCe0OJWn8OGFq+EzgHkS6n8?=
 =?us-ascii?Q?C4U8Sc8FfehcE0zd6BmPW31AbJQ/u7UqwNH/7h+R8Si1bwOVm0nughfBAeJb?=
 =?us-ascii?Q?pr7oP+63JRYXYTkYt4jSOHgjOiKEXwvU402pYWlCVO6ighAjuSDrpyVej5vD?=
 =?us-ascii?Q?CvyPP4AzvUfYYvwl4K2cmhz5+NMbGaeYO+Ss8tJvCZ5rkm9mYn5zzNdpcuhn?=
 =?us-ascii?Q?dDD5OkGaPSfQB9FtkpZSojqu8EJoSIGdFORyaKSiAEFIVMCtYLsev256sH+u?=
 =?us-ascii?Q?WgWX0/ZADU4CP8TDxwR7hCCSP3BUcyQ1nFPfQpj4WghKlaYuVDrqwUHSAp0W?=
 =?us-ascii?Q?iTiVRnDY9W/jp6KD4GG7QNyI3XKbUimVkcu0NawvzBWu/vIju6Z5QCBXC2Je?=
 =?us-ascii?Q?/22fdh7GtPCI61v1FzyUEDaz8YYDoSlo7gi8E6V8J4oJDPUN+H+C8ffe4z/z?=
 =?us-ascii?Q?4KpVlgCfEA=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f857c6c-072f-4357-0bce-08de422f06af
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Dec 2025 14:24:47.5970
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WddXq6QiLZnI28jmAGgQdowSR40xnYy5GnSxtuUJDag2NeNAQrRt4hbEpXyG6Nr3UzK8sNdw2FN6O51gwscS1ovhPpVzOnC1oX8lE+8co10=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9PR01MB16098

Hi Claudiu,

> -----Original Message-----
> From: Claudiu <claudiu.beznea@tuxon.dev>
> Sent: 23 December 2025 13:50
> Subject: [PATCH v6 2/8] dmaengine: sh: rz-dmac: Move CHCTRL updates under=
 spinlock
>=20
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>=20
> Both rz_dmac_disable_hw() and rz_dmac_irq_handle_channel() update the CHC=
TRL register. To avoid
> concurrency issues when configuring functionalities exposed by this regis=
ters, take the virtual
> channel lock.
> All other CHCTRL updates were already protected by the same lock.
>=20
> Previously, rz_dmac_disable_hw() disabled and re-enabled local IRQs, befo=
re accessing CHCTRL registers
> but this does not ensure race-free access.
> Remove the local IRQ disable/enable code as well.
>=20
> Fixes: 5000d37042a6 ("dmaengine: sh: Add DMAC driver for RZ/G2L SoC")
> Cc: stable@vger.kernel.org
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>

Cheers,
Biju

> ---
>=20
> Changes in v6:
> - update patch title and description
> - in rz_dmac_irq_handle_channel() lock only around the
>   updates for the error path and continued using the vc lock
>   as this is the error path and the channel will anyway be
>   stopped; this avoids updating the code with another lock
>   as it was suggested in the review process of v5 and the code
>   remain simpler for a fix, w/o any impact on performance
>=20
> Changes in v5:
> - none, this patch is new
>=20
>  drivers/dma/sh/rz-dmac.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c index c8=
e3d9f77b8a..818d1ef6f0bf
> 100644
> --- a/drivers/dma/sh/rz-dmac.c
> +++ b/drivers/dma/sh/rz-dmac.c
> @@ -298,13 +298,10 @@ static void rz_dmac_disable_hw(struct rz_dmac_chan =
*channel)  {
>  	struct dma_chan *chan =3D &channel->vc.chan;
>  	struct rz_dmac *dmac =3D to_rz_dmac(chan->device);
> -	unsigned long flags;
>=20
>  	dev_dbg(dmac->dev, "%s channel %d\n", __func__, channel->index);
>=20
> -	local_irq_save(flags);
>  	rz_dmac_ch_writel(channel, CHCTRL_DEFAULT, CHCTRL, 1);
> -	local_irq_restore(flags);
>  }
>=20
>  static void rz_dmac_set_dmars_register(struct rz_dmac *dmac, int nr, u32=
 dmars) @@ -569,8 +566,8 @@
> static int rz_dmac_terminate_all(struct dma_chan *chan)
>  	unsigned int i;
>  	LIST_HEAD(head);
>=20
> -	rz_dmac_disable_hw(channel);
>  	spin_lock_irqsave(&channel->vc.lock, flags);
> +	rz_dmac_disable_hw(channel);
>  	for (i =3D 0; i < DMAC_NR_LMDESC; i++)
>  		lmdesc[i].header =3D 0;
>=20
> @@ -707,7 +704,9 @@ static void rz_dmac_irq_handle_channel(struct rz_dmac=
_chan *channel)
>  	if (chstat & CHSTAT_ER) {
>  		dev_err(dmac->dev, "DMAC err CHSTAT_%d =3D %08X\n",
>  			channel->index, chstat);
> -		rz_dmac_ch_writel(channel, CHCTRL_DEFAULT, CHCTRL, 1);
> +
> +		scoped_guard(spinlock_irqsave, &channel->vc.lock)
> +			rz_dmac_ch_writel(channel, CHCTRL_DEFAULT, CHCTRL, 1);
>  		goto done;
>  	}
>=20
> --
> 2.43.0


