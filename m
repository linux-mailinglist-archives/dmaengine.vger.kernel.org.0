Return-Path: <dmaengine+bounces-1181-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 10D6986BEDB
	for <lists+dmaengine@lfdr.de>; Thu, 29 Feb 2024 03:18:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8385287451
	for <lists+dmaengine@lfdr.de>; Thu, 29 Feb 2024 02:17:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 458E836AF9;
	Thu, 29 Feb 2024 02:17:55 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2097.outbound.protection.partner.outlook.cn [139.219.17.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53341364A4;
	Thu, 29 Feb 2024 02:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.97
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709173075; cv=fail; b=KkvQE57Y7HXqLfQAMVMErR3+Krq1wtJexUkt9xb7Ixkzf25OBhGnfoSnBCY9SU3QFQMflzhAZEvYBmKC6gXLsMS8KHY1gdrnTfXKqGUVQdTqu7xG6ke4xS7jA7mH99QI3iz3VNwwavSmrJgpUswmVP/gtSIT5DrTVfHQkvZDkoY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709173075; c=relaxed/simple;
	bh=RZfN/X+Q0LUglOUjXxII0368Pq/yfAkOGSo0VmIjgn0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Y9rMP00KEfuHzsEgjZTiUIgLjlBOHLSj8Qb6CxAnYihv3tykwaFtbsPQ8sjbm1z/hYsdfJ+9hICzt03jOrOQGNAshcjZhBr7LV7+zEcF+jGjPyHGxhN4rH5LiP9eDpko3BUcIMJ58mE/eJPXmpOsHQ/SRQnoJPlbFrzXX2uVZcI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KwIIJ3gq742xLWYkY510cIel5fE5HA90P73CQKXYKwp5yBalv7CxB9inxi53Ez+NfwNRNNJG9/1ZsChy9fXyzZGxWwSQVpkOgFX0e0Q1zB6r1kF75MoBmuZBX6fLDU/OuB+yV/4cH69Xv0wGH4D4A4JZgM3QqZpWT16JkRxh5mvFHWex0ALSzeAtlRscF6HMLTko01/VjOM6p8c/31zuNM8TopPSi+323mGk9B812tgI1GrmIw400p/bwKmNB+iSK0D6InzrbZpNSwWI1lVhkT3//wIfGfvPpIWnVaqqw7vOBJkL9KiINeL4FadqpOFku/SEFErk4MoxdB8i6bbd6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CMZ4/XzeMZtL+3FZoUozKvX5yechUjquXIcNUdeKDdc=;
 b=MZTDox8tm2bzizu8qRDJ3s/j5v+BJIT8fF9KRS4v4NDfH8VbalK208SwerGxWCnAmPbZD6WtsVwixjeC7MTp3QpMYrv3LBfq1H/Vc6vC20auK7cHOEipnLn2c7yPQRIT7VZvFJDIjQvtdOR7xY6igEneBsuT7J69RCexkIpsr5714a/F6+KrKclPH1DxuVrEXzNDAoIGrJex4CE9GV7+ThC+yqWpVCpXFXqlDGG0+RTnbkNHKowgGjM46gV+G3zBtamIxKTyacS9peaNBCUlGFPHp2hc9kvobCH/ZPboNUctf26SHoos5BwmXblQxMzsTwYYs+/8JYnuK9r6bRMIXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from SHXPR01MB0670.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:26::16) by SHXPR01MB0781.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:27::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.28; Thu, 29 Feb
 2024 02:17:41 +0000
Received: from SHXPR01MB0670.CHNPR01.prod.partner.outlook.cn
 ([fe80::9ffd:1956:b45a:4a5d]) by
 SHXPR01MB0670.CHNPR01.prod.partner.outlook.cn ([fe80::9ffd:1956:b45a:4a5d%6])
 with mapi id 15.20.7249.041; Thu, 29 Feb 2024 02:17:41 +0000
From: JiaJie Ho <jiajie.ho@starfivetech.com>
To: 'Rob Herring' <robh@kernel.org>
CC: 'Herbert Xu' <herbert@gondor.apana.org.au>, "'David S . Miller'"
	<davem@davemloft.net>, 'Krzysztof Kozlowski'
	<krzysztof.kozlowski+dt@linaro.org>, 'Conor Dooley' <conor+dt@kernel.org>,
	'Eugeniy Paltsev' <Eugeniy.Paltsev@synopsys.com>, 'Vinod Koul'
	<vkoul@kernel.org>, "'linux-crypto@vger.kernel.org'"
	<linux-crypto@vger.kernel.org>, "'devicetree@vger.kernel.org'"
	<devicetree@vger.kernel.org>, "'linux-kernel@vger.kernel.org'"
	<linux-kernel@vger.kernel.org>, "'dmaengine@vger.kernel.org'"
	<dmaengine@vger.kernel.org>
Subject: RE: [PATCH v3 1/6] dt-bindings: crypto: starfive: Add jh8100 support
Thread-Topic: [PATCH v3 1/6] dt-bindings: crypto: starfive: Add jh8100 support
Thread-Index: AQHaaZtYk3iqPNzLJ0a1+9ODjrwyHrEf6LEAgACucSA=
Date: Thu, 29 Feb 2024 02:17:41 +0000
Message-ID:
 <SHXPR01MB067062096D7EE6FB5F9305C58A5FA@SHXPR01MB0670.CHNPR01.prod.partner.outlook.cn>
References: <20240227163758.198133-1-jiajie.ho@starfivetech.com>
 <20240227163758.198133-2-jiajie.ho@starfivetech.com>
 <20240228155112.GA4059153-robh@kernel.org>
In-Reply-To: <20240228155112.GA4059153-robh@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SHXPR01MB0670:EE_|SHXPR01MB0781:EE_
x-ms-office365-filtering-correlation-id: 786ed7f3-1566-4fc7-6350-08dc38cc9bb9
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 JGOsJPPrMjeMjnOVof4y0wfeF5Q7CYzxNyYtg6UQVD476qYUejdsx4PPunH87pokeN87d/HZJkTvr5Yj4kI/7Txd3MHzw5O6x0k+gOKpxVRnd3QRKQjVcxDxoBy3m8MHrm+wNBaQi73/QjEetle7ghSd411k86G5dXRLuH9fsJ1RRslwEt1E6TqiNxHwgiNoZkqcWg8jBdp8sVYIfmiV/L7Z8/fF6qdWoUan1lDoJOUDmcAnkdWe3FQGvOay4Mwsbslw/Znmw8E2CUf+WDMsDuNt1JTY0xqcQvWZYXP/adnJep9JI6jJnlJ/98GrYqxGPGAVuTPWco6ewyDs57gvIeIKhFne0WxkW0/6hV5LyTWU6W53+1bC/KZ2ydjlV1bu7A0qCh7D32fFL9AwvWrGuJ71x7JH4F8jMh0BWOuhkX/kCgvLYjMd+l3UWWGZiFRujak223FBoLOFGy2lAGeXv0YgQtrXgfDHErEZrihZEKhpHKOEs419hG/sRjA+rkjm6E3Z+RI2rdVNnBec/rbZCHRljU3GGpzvU4MAAuSKt6ZYaQxoVcN0M2ttwwGDi5cVg6t0A/EZZSsFEdzxmAJ7uwVvjYymzBiD0tV1LdwPmt4zpCk07cUnsVz9gY/OWFAy
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SHXPR01MB0670.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?9DdpxgIOwP7wTnbwhLekxn97SOA3zUUxqe1SKoztwIcVdmhsMMNqfintq8H3?=
 =?us-ascii?Q?QwDb3EKPfTa74Vazx6iHp1tHtczz+1izfb3fhFlYf3+lnPjuPcaI1Rsp2hL4?=
 =?us-ascii?Q?QxKc4dyZTL9wGu07yPnEyPr0B8tHXfv42prW1/wE42uzm2J6Lfp7sDS85Vbb?=
 =?us-ascii?Q?8542nAHGU2BFXXhFqT9a5/n56lEKbKiOpVjGstgOCAJ1Y9IvT8WYvNtYXntt?=
 =?us-ascii?Q?qyw25SSIAbbC35lSzBvyh1w7pXgPP3LdZZ5QNh0JmqqY2Cro/60HExmbPb1H?=
 =?us-ascii?Q?ZWroS+8gdfXarQ1luUtl6ZYIYETtYlnvZGksYWIv1vrwDWF/blGRoVCXoJAS?=
 =?us-ascii?Q?H0pJu1nZCi7LE+NRTnfsy8+v1689u80FszjFxb48PSSdvHC5K4SG7P426T8B?=
 =?us-ascii?Q?F2I/9PI9cn9L9cHwwVOyFNF3lYnRv3M0Kk5XnrLmVi6OZP+FkQ+BcQC0J3E+?=
 =?us-ascii?Q?so1cC4UobvFV7HnV5MpT2+5bPV/tLbptOLzw7QCWQWOLoEMoHk+OMA3neRHc?=
 =?us-ascii?Q?9t3cLOfSy2vWjlMVleB5CaWquTXfwSJavYvmor2813DcKiRHLtD5hOvKH+Ig?=
 =?us-ascii?Q?kpTNj6QnPOOR6SHRj7hcWTYJXTJejSdQ92y2/Ab3ZSMMq5cx0l7TgqieJT04?=
 =?us-ascii?Q?XhNn/GUe5j5AIiia7XxgwVDTxKrORy3gER9yTF/8vZyWlUIVmN+y2bm5GsHd?=
 =?us-ascii?Q?KFjhUvmVCEJ69W+sY/Z1akMT3Xr9ufUUkQgTz8Ps/8OFPptMefdIcz7LJIrg?=
 =?us-ascii?Q?6wYCrymTWU27ieNg2TwP5zzQvrnRkLkVxbzLekc9xeAI43NSW8YxCr+/qZ6M?=
 =?us-ascii?Q?goUksJpsvMEWDm1Z3HRoZAZHKtBJDukTAf+QlncWnAWbgcZt1qxh9Bw/Qtf7?=
 =?us-ascii?Q?/dlSDPn3TDQjrq0v13S2+AOFUUwngBobwpcQ0CTHLze2Jf+BYayiOrfIhpIT?=
 =?us-ascii?Q?ZXtFTGh/d2P3Tk8w2mbuCQvLPXF8N05kD6x5duwgmgIgHgzdfkMgZkT15okj?=
 =?us-ascii?Q?vLP9VT6I9cqSTGRErYg32vKrB473vU1CzFVv4gDRTQKFMkHj65jURC2hXx69?=
 =?us-ascii?Q?nCMr6UJ+8YEQeXTHAPLFd9BI6hv1rztOXh4XLAoWO++N6L4OBmLsWYjzxfo2?=
 =?us-ascii?Q?4RCaj+oRlznQ/y12ceizYuUlT4wXGrqMFndVy7EDbNCRg744qqFhhGuLQZi0?=
 =?us-ascii?Q?UgXE48Io+j03JWgdF6ZDuJJ0kaHuUGMPxmxdMaxRANqPPVb6V2hgJBjPItOL?=
 =?us-ascii?Q?bM5BC25xDDc99so4Ynn4ZNiKqlGh6xteyBhDjN7hRIVwYfmSuqYt69/CrZuR?=
 =?us-ascii?Q?evRQgdQNdTp29CYPhel1rxAKn6cp7lvFWlOQONaHhzqbYJES6EAJ9K2hlyXj?=
 =?us-ascii?Q?h0cimACxqu1IAmTVZPM23v9FdsR0XkXlAFh6O1LCEFtKWPF2jC7YPp+tMtb7?=
 =?us-ascii?Q?x4TmP/MWZqTv3Im89xrN/m6x0Bk6LeA34UMzxsQ9c1NEIz5r3Yvpt6KOyw67?=
 =?us-ascii?Q?Ry0tYT36kO10BjuaSsdMNBjzF5ZWIbYGmQQINC+1xczfTuoeqC6TO1KGeoQI?=
 =?us-ascii?Q?aO/McELpK8/DTxUMBttvfZ1QQoHZACeL/WCCNIR0?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0670.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-Network-Message-Id: 786ed7f3-1566-4fc7-6350-08dc38cc9bb9
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Feb 2024 02:17:41.6826
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZPdEbkY6c+0fHM5jzwROnBu+tNY6fE7lGsG4i/A1hmUWgv6oz1jk4zQgJUak3uVzLpjDhq6irQ+c8Z/qCf6e4afUHlc+Y1nNvQ2chwuDlrw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0781

> > Add compatible string and additional interrupt for StarFive JH8100
> > crypto engine.
> >
> > Signed-off-by: Jia Jie Ho <jiajie.ho@starfivetech.com>
> > ---
> >  .../crypto/starfive,jh7110-crypto.yaml        | 30 +++++++++++++++++--
> >  1 file changed, 28 insertions(+), 2 deletions(-)
> >
> > diff --git
> > a/Documentation/devicetree/bindings/crypto/starfive,jh7110-crypto.yaml
> > b/Documentation/devicetree/bindings/crypto/starfive,jh7110-crypto.yaml
> > index 71a2876bd6e4..d44d77908966 100644
> > ---
> > a/Documentation/devicetree/bindings/crypto/starfive,jh7110-crypto.yaml
> > +++ b/Documentation/devicetree/bindings/crypto/starfive,jh7110-crypto.
> > +++ yaml
> > @@ -12,7 +12,9 @@ maintainers:
> >
> >  properties:
> >    compatible:
> > -    const: starfive,jh7110-crypto
> > +    enum:
> > +      - starfive,jh8100-crypto
> > +      - starfive,jh7110-crypto
> >
> >    reg:
> >      maxItems: 1
> > @@ -28,7 +30,10 @@ properties:
> >        - const: ahb
> >
> >    interrupts:
> > -    maxItems: 1
> > +    minItems: 1
> > +    items:
> > +      - description: SHA2 module irq
> > +      - description: SM3 module irq
> >
> >    resets:
> >      maxItems: 1
> > @@ -54,6 +59,27 @@ required:
> >
> >  additionalProperties: false
> >
> > +allOf:
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          const: starfive,jh7110-crypto
> > +
> > +    then:
> > +      properties:
> > +        interrupts:
> > +          maxItems: 1
> > +
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          const: starfive,jh8100-crypto
> > +
> > +    then:
> > +      properties:
> > +        interrupts:
> > +          maxItems: 2
>=20
> This is already the max. Don't you want 'minItems: 2'?

I'll fix this in the next version.
Thanks for reviewing this.

Regards,
Jia Jie

