Return-Path: <dmaengine+bounces-4444-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A8C0A32EA8
	for <lists+dmaengine@lfdr.de>; Wed, 12 Feb 2025 19:27:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E2C727A260B
	for <lists+dmaengine@lfdr.de>; Wed, 12 Feb 2025 18:26:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 671FE25D558;
	Wed, 12 Feb 2025 18:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="f8rdbtVA"
X-Original-To: dmaengine@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010022.outbound.protection.outlook.com [52.101.229.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D468320E02A;
	Wed, 12 Feb 2025 18:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739384863; cv=fail; b=AoKmnmjs51qS0RQ1u9Jk8WgRx0C5ahj6fOQugcHXCFzPkg7w4ARnC9xg11/CcBY4AzDYXLTd9umMxaWcRcvEvVdITx1zTzikGhQcR+nHVQWB93zcSZlyGwaf6CLv2jJ1MI5YzFI18wWtZyQBUZw8zM0wbsIp6CQ+p3qCUIdP46s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739384863; c=relaxed/simple;
	bh=SnEpQuBVUNUVmo9qnSX2ZOr33dLdvseDwFm3cItTLhw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=d0MAxVeWES1qSAFxjaqaDmKaOlurRbvamm0+o9dA+3nYroyofjPdGoMX7q7KrYoR/CHOIz6/RjsQeTO2v/6qicYSjg6DtTE8p54OhLZyUurRXAcYsOB9rJLbzTZUDuPo1YONijqlKpIyoQkAV881A4VlVYuaw+jwUqDRn04qsQw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=f8rdbtVA; arc=fail smtp.client-ip=52.101.229.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q7N+9g/lWEJqNMQVES/EDNhZ90ewLgo12wBswJ87vqScgHCr2C+0h6u1ZuvSUGuCwwhYCKj1YQ2P0IxqtSG+yJ8MR2c26595GNrnszAkjj+vTEcgkjolwHh1sp0XjD6Po/xoEAYsyvVNCy+zl3T+amfRSe7td3CxxEuAW7Gswfe8dRssp8KmzEX50FtwTc7CG+ORz2HNrEq88Jq1hUs7uKI7DA6imamJnuutAm/oblHyeYl/8f/F0hvWATAzT/tlr8P7ysNn6n1TDMaOcpMF+5664fU/azQXPBvBW5GYMKhxFIGahD4ajyEKUodmJmxYL/3dzOFAMc0TMe8FlvklKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7hP2u2auBMlm3eqP4MJLWxwM7QggdzuPEtEAGwBhZ1g=;
 b=rSYbbLFXUX3bt9aKjlU9CKSUp6YJsM3Xbfu7UDRzFOyx3Yj5COMtvO6vxGpy83c2GOTvqkWYSX2lg9iqaJev2jqE0xH+IVqIRqQAF8HDF4pWp1VdnUGqckp6nuSj3PyuomMrug0gecHqOSF+SVaU7e6Mu5U911NbXYZ/VryW8L1YUReBCYxinnUB4qt/GAH/GG+WOQAxpIYtKzYzK1SiyFFvIIDzPtJHOENmE4OO0prj95RXB326wMnqEXS0KNB5mIQsBC/yHrofSfO1nfCjcw4we8ciYwM8k3RWBSOpgTWMqgiPKXIb0HWsS7QLFleer7p2QVyt6RFXAwFht2LiWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7hP2u2auBMlm3eqP4MJLWxwM7QggdzuPEtEAGwBhZ1g=;
 b=f8rdbtVA/BeU5LwMyKS9qEdv3zCeWo7AlF4UOH7bPq7CrJ/nlnMNwDbP2Nz1fENHSw5DvUcwYbj8aIotcFfIcyGQpsZZDfhtjumI8G685kgID4Hd7uKHlgjj6llRSqgBn3eMZFsnYad2+j1RSkhLFDleYqgn59vh12FhHecONOY=
Received: from TYCPR01MB12093.jpnprd01.prod.outlook.com (2603:1096:400:448::7)
 by TYYPR01MB7008.jpnprd01.prod.outlook.com (2603:1096:400:dc::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.12; Wed, 12 Feb
 2025 18:27:37 +0000
Received: from TYCPR01MB12093.jpnprd01.prod.outlook.com
 ([fe80::439:42dd:2bf:a430]) by TYCPR01MB12093.jpnprd01.prod.outlook.com
 ([fe80::439:42dd:2bf:a430%6]) with mapi id 15.20.8445.011; Wed, 12 Feb 2025
 18:27:37 +0000
From: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
To: Rob Herring <robh@kernel.org>
CC: Vinod Koul <vkoul@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Geert Uytterhoeven
	<geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, Biju Das
	<biju.das.jz@bp.renesas.com>, "dmaengine@vger.kernel.org"
	<dmaengine@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-renesas-soc@vger.kernel.org"
	<linux-renesas-soc@vger.kernel.org>, Prabhakar Mahadev Lad
	<prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [PATCH 3/7] dt-bindings: dma: rz-dmac: Document RZ/V2H(P) family
 of SoCs
Thread-Topic: [PATCH 3/7] dt-bindings: dma: rz-dmac: Document RZ/V2H(P) family
 of SoCs
Thread-Index: AQHbeOL4JuBWbK7BE0C/S0vZ0m2kGbNCtjgAgAFN+4A=
Date: Wed, 12 Feb 2025 18:27:37 +0000
Message-ID:
 <TYCPR01MB12093E77656EBB73EBD42D17AC2FC2@TYCPR01MB12093.jpnprd01.prod.outlook.com>
References: <20250206220308.76669-1-fabrizio.castro.jz@renesas.com>
 <20250206220308.76669-4-fabrizio.castro.jz@renesas.com>
 <20250211222630.GA1288508-robh@kernel.org>
In-Reply-To: <20250211222630.GA1288508-robh@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB12093:EE_|TYYPR01MB7008:EE_
x-ms-office365-filtering-correlation-id: 790f04fd-b388-4f83-bc00-08dd4b92ed24
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?AWEEkQ+RSqKbHBdDhvusRi42mR5o7kyUvh3nZgEuytVGD/K1xJVi/ZiKbYgq?=
 =?us-ascii?Q?pnAuraSY581iP9skdfaSXj1Jz9bTduQy1eNSVZBH6FwtWLYmrBRJrsmFiVKX?=
 =?us-ascii?Q?2iwsPkZO2ebhtBNSyOqIfJILpGNi5HsLeH0PSGuFmmbZfHYh7Bv/QvQKW17F?=
 =?us-ascii?Q?cqJoPSsx1rbBXET0W9P0WCSpdyNlrBt4/4MRNtSt9srtz71lcXOcr+2/EykY?=
 =?us-ascii?Q?acTFaChcQHCZBUehzsCzbErISKqWIB7ibjNjwHDA5QPbnbY5kZRiLnBPbHjZ?=
 =?us-ascii?Q?q8uUGX/fO6Wttq6fPzxaozHu3DQDs1xDWecOJhLc7uBRwFGmrTAMe3n0TgNT?=
 =?us-ascii?Q?RuC/x0pesm3cMpHv2OOk0vI+cdtS14zIxCoW/P9+4m+6M3sY5jIhV/vwJCjd?=
 =?us-ascii?Q?SxJxgfo1Cwfna7vizSEkRzZiMuuesNTEbw7jKL8r6ptRv4rWbquyhCUSBAKK?=
 =?us-ascii?Q?D93PIPaLfCwO9THuO/OOcjc+B+MEFkvoeZbAFsmxhllJjN7SAXfy1+oTdnvt?=
 =?us-ascii?Q?Sdj5eHJGbU7fR0aa63xfP55VqyWn8Nll/W09LvYoDKs37t+eEQJtgn0EcMZs?=
 =?us-ascii?Q?JFH7X66d/1K2TQwBSS0QurdHn9JtwougvHBrX7jSltderB5e3gaeY1INLzmi?=
 =?us-ascii?Q?4NixL0HzsYJCZm20ZPUnLzIJsZ/VwVmRv9SGX9CjHWErxX7Mv5B5c19smw87?=
 =?us-ascii?Q?yzRsO0dzFf5qVN6FutW8hXUuxLL5+a0O1topfaENEDGemwhUROIkfJMTNPbL?=
 =?us-ascii?Q?7RYsOWJYZh18ZQVWIjiMln+6k1PI+twjvxUbW5dLBGeIhb4g12f2gUm5ZVt4?=
 =?us-ascii?Q?N9rX4RKqJvAAYPbgm7BC0r+99hFOHpabQs4On332dBt20ayz1xmocea15ds2?=
 =?us-ascii?Q?qiNFk1w+bCT4DYFn+PFhrlgrEomvMrbxdJ/ggovcnsOFDZPvUq5KSNqthhsr?=
 =?us-ascii?Q?kIX71BxaevqGeArc27OWJMk6rL3DHWci9ipbiXtX91Z6twejYGOSffNV5J9F?=
 =?us-ascii?Q?o6BY3yyCjJ3m9WDEqlpBMK7LUijww/Q4NQWqlu671+nCKEwhKtbMCad+UlB6?=
 =?us-ascii?Q?gbSkt2nR+UjIMUlLLuzAi3cVzG4w0Zsr9SncHchHPLjt0pvy+8gCBwW6OsQc?=
 =?us-ascii?Q?MRVZ+j+ecoBZqg2khmtPbkK0Q+8ESBltdIbFwWSj3u+kkzRbdbb19tZKxtPt?=
 =?us-ascii?Q?oxRkjP/QmR+WjPcMpFeWunvlxqmcU5sfFIoRK37QZzCNH+NMoFxgZpgrpGBK?=
 =?us-ascii?Q?D15e9pRCyEPyHvoC7d/VZtIEx1f+LIM4MpydFFhI3IyjzNDz7qFLh1Oj/MZL?=
 =?us-ascii?Q?sqvA6n10r1XGdmQ+vtQsylCjugprCyi318XmAh5jw7N7eu1KbhFP1xdLLsdO?=
 =?us-ascii?Q?KFqHJ31HtsPSpIXz7UmZntICtSslPt5EWSZr8MuVqlFZeMkE9DEUrzN93HBM?=
 =?us-ascii?Q?eVxUKSgpeNee8WlPRX3aYdj+1liwFtif?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB12093.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?6pb8dqhYmCEA/Uf3p9H0Nd4VgSyHFIyjJmVY7t10wUZZa5lUfRqb1lDcEju5?=
 =?us-ascii?Q?rmQ3fULqz/BNYW8oIYdcN0MZ4Xpmc4HjRgsx3/9CdVcvqCkBeB01byW7pamp?=
 =?us-ascii?Q?GmDV0wkITOUCVhLOYk5VIHCvJsg3EuFkFh9nF9Jpgp44zRRCP3OJ3tzI3aNV?=
 =?us-ascii?Q?A194fSYVNA/qEXU6Ow9xPgNLEUusM1VtVPvpErxp8oRh2lvhXb1Jh5vNAqZN?=
 =?us-ascii?Q?v1GnfW40pECspL4xzWuP52foLM2FQKaG2TqkDRn53JXzA3sFUJqASRBFOh6/?=
 =?us-ascii?Q?cz/pmLwhfWLOxmiI9yACza3lGh0kqWwf1bY4emoZEnkhDKj97YgK+KM4Gv6d?=
 =?us-ascii?Q?JXBT/uLCRCqP9yWYBk6Y3F4KRLf2Fd11i1Ud0O/uB6j5oi0b0DhmDOjB8PMP?=
 =?us-ascii?Q?ZPCBpw4IBI861/6heWxx0pYaYG3qkzU4rl8FEHXcpsloGp3//CFWhTuTDs7n?=
 =?us-ascii?Q?aw8gXXwujDXGu49zgl++2US4Tv8Mghw6MpMQu9zWSnr0PLRrava9sJIZ7Vef?=
 =?us-ascii?Q?ZngMmvcPZZdQYJ3J7praqnVgn+AvGChZQNDf+/59YTrimRGwhYBYH9X7wsgg?=
 =?us-ascii?Q?bDXBMPuXJ/TwJwdhOQNEWi/+dCgEYR/BH1adIhDSqCNc3TnYTGr1KTe4mv6m?=
 =?us-ascii?Q?+Fa5FEpgAe6V3OvSQrr3m+OnW3Q4sQpPU8BxFTXJqldKwbc4h/A/2atheUtX?=
 =?us-ascii?Q?rfpvRdkHxqi0sT85X/ObyJGfJ75oON8dim2XcRYnfSx66twoqBBVglVlfa5j?=
 =?us-ascii?Q?O94lY6RGLIqXB5qTzDVMNlnfoyHt2JsunoWgtK6ClXJ5rabUwR53Ufes2E79?=
 =?us-ascii?Q?kqXN1BaCR/quztP2Fah00tMPtxXmrdwmC4O/RgB+rD60qfrBm6J0ajI4nFQk?=
 =?us-ascii?Q?vQAJ10niK016FmXtyS+Gs2pfT0+ORaDn3hJCQipOL9AwrPRmF+TvZhZovCtQ?=
 =?us-ascii?Q?PPGpGcKsvhuWL0ogvQSKC1e/HWku0TT7cELrpTuxG2ky9X2GPixR041RK5kg?=
 =?us-ascii?Q?XhXECwZdvPp26pC8CtEzlqEqWFCytKQR5/N34wvJDCJUmLQmK2sFBqy6BTC2?=
 =?us-ascii?Q?/yaWXr1Zconv3cfXG1KrQ+e3z6u89Bxo9G33IgsOBlaeeJs/iqP1ZYldE6fV?=
 =?us-ascii?Q?XzqUS8I4nrMgA9OwK3m2+0weNfLsFNh1RT6EdYsBeA4q/1fC0JO2oqMu3dK3?=
 =?us-ascii?Q?6N9JNutbEQPXKQ/5rzkHUmu74fsEK+wYWMAdMZfQoWOCF3TFrLopOYEnkDdI?=
 =?us-ascii?Q?quwd2UA4Zte9lC34z09sIHdxKOh5MWZRTajIK3Yx6bXCOAVdsMRsEuQqB/tw?=
 =?us-ascii?Q?A5LkLfO9XBPOBF//ewYAyrORGkMGPFocENqZSvCwtso9vUrPPIUUbL7WSDkf?=
 =?us-ascii?Q?Bssz+htxTrgmptEmPwsPFTd0cVrqdIFDN56XOwZwKaWlYbQf/AOxZluqZh8u?=
 =?us-ascii?Q?xN9g6JcFfvD8oYsOul6rlDdTo/TPLc1NX1TpYkNb+x4Tf3p2WhjtZnl8LbFK?=
 =?us-ascii?Q?/AM2b89iY7FbN30l366AMIVxmA1cs00G2uljG/QIQt0Vhy7iQ9nBL5kx38Am?=
 =?us-ascii?Q?jSgFht3TaFuIxx4nK0xcaofuJmslv2uBYAeHbPaKtTt2b5MOZfsIwBDoS1TT?=
 =?us-ascii?Q?9A=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB12093.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 790f04fd-b388-4f83-bc00-08dd4b92ed24
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Feb 2025 18:27:37.2255
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CGv+Hb/0GIBNomJvJAorPjtDW1Nn66XCxa1YTO3P34wrLFchhA7PZ49B19TGpvLxQZya0ORUL8SMPntwpe9yiidbRbfHDpr3kcD7z6Gejxk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB7008

Hi Rob,

Thanks for your feedback!

> From: Rob Herring <robh@kernel.org>
> Sent: 11 February 2025 22:27
> Subject: Re: [PATCH 3/7] dt-bindings: dma: rz-dmac: Document RZ/V2H(P) fa=
mily of SoCs
>=20
> On Thu, Feb 06, 2025 at 10:03:04PM +0000, Fabrizio Castro wrote:
> > Document the Renesas RZ/V2H(P) family of SoCs DMAC block.
> > The Renesas RZ/V2H(P) DMAC is very similar to the one found on the
> > Renesas RZ/G2L family of SoCs, but there are some differences:
> > * It only uses one register area
> > * It only uses one clock
> > * It only uses one reset
> > * Instead of using MID/IRD it uses REQ NO/ACK NO
> > * It is connected to the Interrupt Control Unit (ICU)
> >
> > Signed-off-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
> > ---
> >  .../bindings/dma/renesas,rz-dmac.yaml         | 152 +++++++++++++++---
> >  1 file changed, 127 insertions(+), 25 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/dma/renesas,rz-dmac.yaml
> b/Documentation/devicetree/bindings/dma/renesas,rz-dmac.yaml
> > index 82de3b927479..d4dd22432e49 100644
> > --- a/Documentation/devicetree/bindings/dma/renesas,rz-dmac.yaml
> > +++ b/Documentation/devicetree/bindings/dma/renesas,rz-dmac.yaml
> > @@ -11,19 +11,23 @@ maintainers:
> >
> >  properties:
> >    compatible:
> > -    items:
> > -      - enum:
> > -          - renesas,r7s72100-dmac # RZ/A1H
> > -          - renesas,r9a07g043-dmac # RZ/G2UL and RZ/Five
> > -          - renesas,r9a07g044-dmac # RZ/G2{L,LC}
> > -          - renesas,r9a07g054-dmac # RZ/V2L
> > -          - renesas,r9a08g045-dmac # RZ/G3S
> > -      - const: renesas,rz-dmac
> > +    oneOf:
> > +      - items:
> > +          - enum:
> > +              - renesas,r7s72100-dmac # RZ/A1H
> > +              - renesas,r9a07g043-dmac # RZ/G2UL and RZ/Five
> > +              - renesas,r9a07g044-dmac # RZ/G2{L,LC}
> > +              - renesas,r9a07g054-dmac # RZ/V2L
> > +              - renesas,r9a08g045-dmac # RZ/G3S
> > +          - const: renesas,rz-dmac
> > +
> > +      - const: renesas,r9a09g057-dmac # RZ/V2H(P)
> >
> >    reg:
> >      items:
> >        - description: Control and channel register block
> >        - description: DMA extended resource selector block
> > +    minItems: 1
> >
> >    interrupts:
> >      maxItems: 17
> > @@ -52,6 +56,7 @@ properties:
> >      items:
> >        - description: DMA main clock
> >        - description: DMA register access clock
> > +    minItems: 1
> >
> >    clock-names:
> >      items:
> > @@ -61,14 +66,22 @@ properties:
> >    '#dma-cells':
> >      const: 1
> >      description:
> > -      The cell specifies the encoded MID/RID values of the DMAC port
> > -      connected to the DMA client and the slave channel configuration
> > -      parameters.
> > +      For the RZ/A1H, RZ/Five, RZ/G2{L,LC,UL}, RZ/V2L, and RZ/G3S SoCs=
, the cell
> > +      specifies the encoded MID/RID values of the DMAC port connected =
to the
> > +      DMA client and the slave channel configuration parameters.
> >        bits[0:9] - Specifies MID/RID value
> >        bit[10] - Specifies DMA request high enable (HIEN)
> >        bit[11] - Specifies DMA request detection type (LVL)
> >        bits[12:14] - Specifies DMAACK output mode (AM)
> >        bit[15] - Specifies Transfer Mode (TM)
> > +      For the RZ/V2H(P) SoC the cell specifies the REQ NO, the ACK NO,=
 and the
> > +      slave channel configuration parameters.
> > +      bits[0:9] - Specifies the REQ NO
> > +      bits[10:16] - Specifies the ACK NO
> > +      bit[17] - Specifies DMA request high enable (HIEN)
> > +      bit[18] - Specifies DMA request detection type (LVL)
> > +      bits[19:21] - Specifies DMAACK output mode (AM)
> > +      bit[22] - Specifies Transfer Mode (TM)
> >
> >    dma-channels:
> >      const: 16
> > @@ -80,12 +93,29 @@ properties:
> >      items:
> >        - description: Reset for DMA ARESETN reset terminal
> >        - description: Reset for DMA RST_ASYNC reset terminal
> > +    minItems: 1
> >
> >    reset-names:
> >      items:
> >        - const: arst
> >        - const: rst_async
> >
> > +  renesas,icu:
> > +    description:
> > +      On the RZ/V2H(P) SoC configures the ICU to which the DMAC is con=
nected to.
> > +      It must contain the phandle to the ICU, and the index of the DMA=
C as seen
> > +      from the ICU (e.g. parameter k from register ICU_DMkSELy).
> > +    $ref: /schemas/types.yaml#/definitions/phandle-array
> > +    items:
> > +      - items:
> > +          - description: phandle to the ICU node.
> > +          - description: The DMAC index.
> > +              4 for DMAC0
> > +              0 for DMAC1
> > +              1 for DMAC2
> > +              2 for DMAC3
> > +              3 for DMAC4
> > +
> >  required:
> >    - compatible
> >    - reg
> > @@ -98,27 +128,62 @@ allOf:
> >    - $ref: dma-controller.yaml#
> >
> >    - if:
> > -      not:
> > -        properties:
> > -          compatible:
> > -            contains:
> > -              enum:
> > -                - renesas,r7s72100-dmac
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            const: renesas,r9a09g057-dmac
> >      then:
> > +      properties:
> > +        reg:
> > +          maxItems: 1
> > +        clocks:
> > +          maxItems: 1
> > +        resets:
> > +          maxItems: 1
> > +
> > +        clock-names: false
> > +        reset-names: false
> > +
> >        required:
> >          - clocks
> > -        - clock-names
> >          - power-domains
> > +        - renesas,icu
> >          - resets
> > -        - reset-names
> >
> >      else:
> > -      properties:
> > -        clocks: false
> > -        clock-names: false
> > -        power-domains: false
> > -        resets: false
> > -        reset-names: false
> > +      if:
>=20
> Please try to avoid nesting if/then/else. Not sure that's easy or not
> here. This diff is hard to read.

I think I can use 3 if statements as opposed to nesting them, and I'll have=
 to
explicitly list the platforms in order to cover all of the cases.
It should be a lot more readable, and hopefully simpler to maintain.
I'll send something across soon for you to look at.

>=20
> > +        not:
> > +          properties:
> > +            compatible:
> > +              contains:
> > +                enum:
> > +                  - renesas,r7s72100-dmac
> > +      then:
> > +        properties:
> > +          reg:
> > +            minItems: 2
> > +          clocks:
> > +            minItems: 2
> > +          resets:
> > +            minItems: 2
> > +
> > +          renesas,icu: false
> > +
> > +        required:
> > +          - clocks
> > +          - clock-names
> > +          - power-domains
> > +          - resets
> > +          - reset-names
> > +
> > +      else:
> > +        properties:
> > +          clocks: false
> > +          clock-names: false
> > +          power-domains: false
> > +          resets: false
> > +          reset-names: false
> > +          renesas,icu: false
> >
> >  additionalProperties: false
> >
> > @@ -164,3 +229,40 @@ examples:
> >          #dma-cells =3D <1>;
> >          dma-channels =3D <16>;
> >      };
> > +
> > +  - |
> > +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> > +    #include <dt-bindings/clock/renesas-cpg-mssr.h>
> > +
> > +    dmac0: dma-controller@11400000 {
> > +        compatible =3D "renesas,r9a09g057-dmac";
>=20
> Is this example really different enough from the others to need it? I
> would drop it.

I think the new example can be dropped in v2.

Thank you.

Cheers,
Fab

>=20
> Rob


