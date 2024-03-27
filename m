Return-Path: <dmaengine+bounces-1539-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 317AE88D4C9
	for <lists+dmaengine@lfdr.de>; Wed, 27 Mar 2024 03:50:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 47C71B2167A
	for <lists+dmaengine@lfdr.de>; Wed, 27 Mar 2024 02:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8108219FC;
	Wed, 27 Mar 2024 02:50:39 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2096.outbound.protection.partner.outlook.cn [139.219.17.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F51817BA6;
	Wed, 27 Mar 2024 02:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.96
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711507839; cv=fail; b=k2Nmnwyi3Ddd84JDfznQGudhXFS6omHBBzV5ml1g3VWknw+LfLYdLozrKHzvy2Su0ZZIGmUzPxC4Sq+FVxjRViiJcwj5PWE/bYlJrlo/UP5/hC17kNLTAiKgQ7uMhYFup6DiaQTxEYx/EnaqI64RdGC4zdQtK+/7AxskbZtzbSE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711507839; c=relaxed/simple;
	bh=vFPdxktJQvKv601CZsD1nIshoRhsS56TxR0fwJaRfcM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rzy6fs6btp/exn4KQsxtW6FdWj70Wa7WZ34UJ0qYiAQrDcM3M8W3HBy0+kBTlsK3rdJZkjZdoEamDdva2O28QH9K6SBZCoqzi6hroM7702sCJVte9aKLH+s2h8hNC3iH04ojdk7qwEe3R75Ks9U3KuKfKvPm/jYKaIE14GdGvyE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KTg/oEjQqsSO3FLfz7qDXZkH1qRRP7sX3hjz7WxEy4ZAThOuHIF/TSyH8/pWJLF4ML/x3vsrOEarJAus7A43JMKero8rpJ6emnWOi9vHwfJi7wZOTXxfumkpYs2+VL0hMeZ4T1XWjr0w8yEXc/Z/75t3KJgnbpOpwrJLDZHv3pPTVJLjcJXBR71d/JRBMLBCCMN37xWA/4ITqpeAR9uwTwkRWh1gM6TgSew5yLadpQFe8LfCgmCxdSDfpYDiGeoqY66YuYd6MkQksX7+DwS9nwDYdetQrgkM3y8NjBfMgxPuh2sWNiLyA9Nn/QNtkALIGu7actjp3sjMX3+wlUi1dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BtVK3a7P7VP7BP4Xrh/hvM9yQxZocloCz/3AwYhv5XY=;
 b=S+9a9jyNUbXGw10IZE2hqbWJXXh3vTsPdfrtP8pGP+weM2hmiNMcMHey439DJ0hTcwnKsGKBciIEj7UD8+aXsxIlr6uCgY9Esky2ydiX9fI6RqL7u1Wn9K9T1GPhrkDiu50UJ722eF/3HjUcVl3WMuU3iNR7DlrQ2DiKF75AYc2cCu2QYBIKkvOfEAz1p0js/EvmMXVMe/1LlaeExO4ogvP3IJkpWiakwbJ0XKd2K1UO2xNjJMoKGkgA9RtnS2t6zPzOJUN0H/iupK3dPOKckLsfCCl+yMKTpxt1myoD6Cb3sT6pWq7LxNMcpP87mGj3JdZ0Cx6vrUc6xotSG/35ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from BJSPR01MB0595.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:e::20) by BJSPR01MB0547.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:e::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.33; Wed, 27 Mar
 2024 02:50:32 +0000
Received: from BJSPR01MB0595.CHNPR01.prod.partner.outlook.cn
 ([fe80::d0cf:5e2e:fd40:4aef]) by
 BJSPR01MB0595.CHNPR01.prod.partner.outlook.cn ([fe80::d0cf:5e2e:fd40:4aef%4])
 with mapi id 15.20.7409.031; Wed, 27 Mar 2024 02:50:32 +0000
From: ChunHau Tan <chunhau.tan@starfivetech.com>
To: Conor Dooley <conor@kernel.org>
CC: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, Vinod Koul
	<vkoul@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
	Leyfoon Tan <leyfoon.tan@starfivetech.com>, JeeHeng Sia
	<jeeheng.sia@starfivetech.com>, "dmaengine@vger.kernel.org"
	<dmaengine@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/2] dt-bindings: dma: snps,dw-axi-dmac: Add JH8100
 support
Thread-Topic: [PATCH 1/2] dt-bindings: dma: snps,dw-axi-dmac: Add JH8100
 support
Thread-Index: AQHaf2Ox5nUOkqHZ30+sw9x0qtoLj7FKWS6AgACLBgA=
Date: Wed, 27 Mar 2024 02:50:32 +0000
Message-ID:
 <BJSPR01MB059504FC203190B95D9D1C549E34A@BJSPR01MB0595.CHNPR01.prod.partner.outlook.cn>
References: <20240326095457.201572-1-chunhau.tan@starfivetech.com>
 <20240326095457.201572-2-chunhau.tan@starfivetech.com>
 <20240326-maternity-alive-6cb8f6b2e037@spud>
In-Reply-To: <20240326-maternity-alive-6cb8f6b2e037@spud>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BJSPR01MB0595:EE_|BJSPR01MB0547:EE_
x-ms-office365-filtering-correlation-id: b0b3e791-1897-42e3-4f59-08dc4e08ab94
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 wRCQrkuBNZQ9BrRqR+5tkZp95juHOwXTt95gFzUNT+OmG1RUh9JLqBghKMIO7CQ/DVIMT3v+tjPl1V21tSOHhtrawdXSggX4fKH/WfJVoI1WeKeOyt3r+mXiNgsq5UFgKCMtvIH6XX+5XzIn3TXwppOOcogIXDp8VHUO3+zFcYjue0E8MEXQqxqFt5ZvVNK3BDlwdTalIPa+eO+GEaaGXo+WvwDRil3d1OtQHkxFfcCQcDaBOpVKU4GdpeOkrfrY69el1dHfNK/zUGvarJBuVNOKaKtEB4p+76qiLiYKVhyCgbevkqnzANJfbZOuOhnz7PNnS6WYoSVScGe193J067lLzSXF+4P7ihr+dE78TxukXQkzqSMBsqa4r4kZgpTNjdyNirPOFAJbNHf+dBp5cbsBQTRzkHzSC1IfMNaBfOELu6xIv0fX0jmYAlC9Ei8VtyFMjlpkIq1vSShIEVdaMltAunozhlXRoMhjNhM9hQjL8wqajXee6Z4pr+DgUlLF9oDoUil+BIiDFnVYLPjNYfXxSvZxo9q943u/sAYPF4zJccvMod/OnjkR7rcoDwUxDtWrG6+dF+O6ERiKk4NUjOLH/zf1htcasRmSsBmU4EsvUh6C8f4dSrnLtP0Se023
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BJSPR01MB0595.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(41320700004)(366007)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?v9vvQh4F6sKtE236U5J4C/URcbsRsh2jzICVzD4WVs5dq7B+dVNbFSmWGym3?=
 =?us-ascii?Q?cZTk7mdjExESabYJ/ehybOidLklOwcumqJZNEoGIE/jDTu7LJpbPm/VBlxFM?=
 =?us-ascii?Q?QZzFHbrgGRxHHvp0GVK/OLOWJdTMUcmcTfLqfxyM5tcEnbnoY7u7lhSwYBvm?=
 =?us-ascii?Q?5evJufOKUIQLJKLIVOvjIZyTkegBtfzHOdCGKkURaFni+RPSYdpWP0/HCRQg?=
 =?us-ascii?Q?rvInUrOLSn3zLyVQramPRAsYuoHp6F+eLKYMwjAFaDXbe6txICugIGPdW66I?=
 =?us-ascii?Q?8d0CNAx2xdkrapFC6dfJ0xtSIHEf/Ae4yGH0WOX1pjUS0HeEriKmqn3dJ74V?=
 =?us-ascii?Q?9g67FDt9w1EXfx+rtfKaTq6T/RPGJpTqbpYR51Bn8CrfT/HkLLIrCTv/zeWh?=
 =?us-ascii?Q?4SpU0syri6zlrSKz5rYP/TtznfGSP6pHEWm4E8SUVgwMyIv8boi655c2SrTr?=
 =?us-ascii?Q?wiHU+jFA5+jdoDK33uVt0ui9ZBQnkK1wdyF82kKlnywtsyXpmArbZvK01pbk?=
 =?us-ascii?Q?q2YtJPpFd2kcMH6YIw+fwPZzPVKHCuCYKlqsV5nqTYiXSlSCVc2nKmDIJ5Km?=
 =?us-ascii?Q?hh9a5fNtcd2IcloEnqrL0D30KGhTWFYfbuQuFxk57v8mF1MSyJvplkXibsQl?=
 =?us-ascii?Q?mjf4D1YrgVA7LmMniTIcwH8z7oiHqCKRdNnXgL2PH2K948YKnYI5f+X/abis?=
 =?us-ascii?Q?xyskLAjQnYlxlAfjLH4udiUfqt9PNhTCsI8fagb0BWCS8Q/JThh1+7AONg0I?=
 =?us-ascii?Q?9SSlhYWbBx7bcmAb84/qutv+yehxK+Wdv6TmM9IZKDgKcr60GmGi4sSaV1Rn?=
 =?us-ascii?Q?WJ3nKlAhZBPfDjeZITW+9wVUTYN4OgVv3qlmOC69mthFk6SV/nIZSFmPxSla?=
 =?us-ascii?Q?mIB1HQzKks1oQhaUkki6I8phvUyzTHECKklbgeHOaWNkZjhIxDAFuZtNnVBB?=
 =?us-ascii?Q?9Tps//4OV4VgVMBC21sWBSVz7QWyet9eg4QtYRwqR8HvMhf+3wegPU3YLPW3?=
 =?us-ascii?Q?6oIgT+lqVJRANsvrFyxe8UgKr5D5cQcY8lWukHRjIhfN6jiDOWh4snzpsF1P?=
 =?us-ascii?Q?opX/FZhQqkh/JfHnjE/v4Rmc23yqvbF4eZGDpN0vgRl9zZg9A9D9KlT+vo++?=
 =?us-ascii?Q?9s/9WkptQMQCFZDbYHvcHMLsj9tuMmijpDPr7cM2DGXmilhhCNWrfOyDKLLk?=
 =?us-ascii?Q?FlKIHBq8EZ6h3fJP3143HUrtCoJvNt+3HZAELyVos8+o2CiKu+k+14oIVPxP?=
 =?us-ascii?Q?+cJVy38hunDfsK4JWH9aZVr4IDxpUpEXRqBEdEj0ag5c1ORLtEGT7Pp0PurA?=
 =?us-ascii?Q?n/zirxoX9rAMjjMZpf626Ku/F6y6hu9lh10VVL/nCMlyaDmPNsRZV/NcmVBV?=
 =?us-ascii?Q?AOXjKt+Y1eQ4EBVob7iaRWkavlc/NYhuv8rzfMJgra6Z2tMg3TLpc92Y3m0U?=
 =?us-ascii?Q?UB535Gn5HtprWNtjUxeQHzyrc0M864tjwW34ezafNYJRrzjH8EwHD8dtIqA9?=
 =?us-ascii?Q?LMMcOB84bfF89gazTd+vIhQx4n7itIx//3ZwDewKpVAk0IurMoKBbL+WUscT?=
 =?us-ascii?Q?DEhZD0qJm8nzIENXuNRZQzAIreHCVHIRSQacsAO4Ki3W7s0OEbxWF2Uq8z1M?=
 =?us-ascii?Q?ZT7biMFmJksdPJQHNOXkhucHimmoa256AyzCM0O6KnihB6W22QtV/4V9TnUo?=
 =?us-ascii?Q?6ZaDBA=3D=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: BJSPR01MB0595.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-Network-Message-Id: b0b3e791-1897-42e3-4f59-08dc4e08ab94
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2024 02:50:32.4727
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QA4Wqmf37vIKbPDZQUsOTm+MWKvkCOOkrzM5pmLOAm/J6EWdMqPA7GKwioN1IPt+fbrWgBNT0GJdHXDPXsKnSOwN1xg9i3Pz0WWZwtmr1EE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BJSPR01MB0547



> -----Original Message-----
> From: Conor Dooley <conor@kernel.org>
> Sent: Wednesday, 27 March, 2024 2:33 AM
> To: ChunHau Tan <chunhau.tan@starfivetech.com>
> Cc: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>; Vinod Koul
> <vkoul@kernel.org>; Rob Herring <robh@kernel.org>; Krzysztof Kozlowski
> <krzysztof.kozlowski+dt@linaro.org>; Conor Dooley <conor+dt@kernel.org>;
> Leyfoon Tan <leyfoon.tan@starfivetech.com>; JeeHeng Sia
> <jeeheng.sia@starfivetech.com>; dmaengine@vger.kernel.org;
> devicetree@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH 1/2] dt-bindings: dma: snps,dw-axi-dmac: Add JH8100
> support
>=20
> On Tue, Mar 26, 2024 at 02:54:56AM -0700, Tan Chun Hau wrote:
> > Add support for StarFive JH8100 SoC in Sysnopsys Designware AXI DMA
> > controller.
>=20
> Your commit message should explain what makes this incompatible with exis=
ting
> devices. That inforatiion does appear to be in the driver patch, but shou=
ld also be
> here. Otherwise,
> Acked-by: Conor Dooley <conor.dooley@microchip.com>

Okay, thank you for the feedback.
>=20
> >
> > Signed-off-by: Tan Chun Hau <chunhau.tan@starfivetech.com>
> > ---
> >  Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git
> > a/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml
> > b/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml
> > index 363cf8bd150d..525f5f3932f5 100644
> > --- a/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml
> > +++ b/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml
> > @@ -21,6 +21,7 @@ properties:
> >        - snps,axi-dma-1.01a
> >        - intel,kmb-axi-dma
> >        - starfive,jh7110-axi-dma
> > +      - starfive,jh8100-axi-dma
> >
> >    reg:
> >      minItems: 1
> > --
> > 2.25.1
> >

