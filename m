Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0185C700454
	for <lists+dmaengine@lfdr.de>; Fri, 12 May 2023 11:56:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240540AbjELJz6 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 12 May 2023 05:55:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240447AbjELJz4 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 12 May 2023 05:55:56 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2111.outbound.protection.outlook.com [40.107.113.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 900ACE70B;
        Fri, 12 May 2023 02:55:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MIR2BdMQeEmkMgtjpbLH/EC2nVW5sCuPfSMG0gD3PpvHkwMPm8l863iU0ZTgA7ZWO8tNv66k10BXf0p1khNm6LEXjoZtO1T4303g69xuKcDy0U6W3lcPv7jXhhQYSn90h+CF/CZpUejGN/SXP9BTzBirg0rZZtPvfMQj7sXgfhqskiGS3zHqsRbinktz+ft7TFJUPWcraAhGEgsQ65bY4xRp9JYmksjtesfPjw6guMpTmr4nO4clDKX3etEF1FgAu0MThD6cHz8swG4SMkk17coguGiMs68kh9Do5Wt+wTomNkM9ICkbw31qacDwIknc+KM5xmnwDu+7cl1pcq/5vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EDdXk7CRyPXEHsbmzwhchizXN2Qi+Y5lngc3gK6Web4=;
 b=WNK+NTjoyy1bu+FrI4aUprYBeyXGZ70Wx6VCsXxOatJMBhmOTyQgC5M2SpubSgQ/FOPkkEtYbixvTZQE52B8ZxcPikYGRSVq4YGrZ/sO/DxMT03zi3pzS99NNMPPLkunXUGZKMlGUWx1pfytr8Y1FyUuIBakawJg/cULrsBdKt3fXX9wVQ9Fa8unsq6vhUnw8VhEd3Rs44CflwUA0r7YJOseUgtVgCrWzIslIIrGRry0fjPHkaS7yUL0pFoqHcm9MAOih3MqVzkYbNEyPnD9WIYVTBZSbzidEfpNxUilDcawuzAiQlKedDPJh3ca42juEHpiHtGKxQiJlE14WuvWEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EDdXk7CRyPXEHsbmzwhchizXN2Qi+Y5lngc3gK6Web4=;
 b=T85u7hYPUwjTfQTMkewwqjpMqQxRenWrTaY54+NHk65ppbuVWlSaKy6X0ljtmmGMpm4gwP4+IvXJKOoNK0Bjygxx/5DAUtuq7DWYUWdJXN6nqu66jzEbwk5pk0rGQoICf5fOdknOLjm+lcDUQ9ztnEGqGo3/phDqEx26lS6fGbY=
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 (2603:1096:404:8028::13) by TYCPR01MB9669.jpnprd01.prod.outlook.com
 (2603:1096:400:221::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.23; Fri, 12 May
 2023 09:55:52 +0000
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::5198:fdcf:d9b1:6003]) by TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::5198:fdcf:d9b1:6003%7]) with mapi id 15.20.6387.023; Fri, 12 May 2023
 09:55:52 +0000
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Cai Huoqing <cai.huoqing@linux.dev>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?iso-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kw@linux.com>
CC:     Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH RESEND v5 02/14] PCI: dwc: Fix inbound iATU entries
 out-of-bounds warning message
Thread-Topic: [PATCH RESEND v5 02/14] PCI: dwc: Fix inbound iATU entries
 out-of-bounds warning message
Thread-Index: AQHZhDwY1x3SU9YtLkCMc4srokdidq9WZtGw
Date:   Fri, 12 May 2023 09:55:52 +0000
Message-ID: <TYBPR01MB5341FD8161E8C2D542989D72D8759@TYBPR01MB5341.jpnprd01.prod.outlook.com>
References: <20230511190902.28896-1-Sergey.Semin@baikalelectronics.ru>
 <20230511190902.28896-3-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20230511190902.28896-3-Sergey.Semin@baikalelectronics.ru>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYBPR01MB5341:EE_|TYCPR01MB9669:EE_
x-ms-office365-filtering-correlation-id: daebdff4-54dc-453a-f9d3-08db52cf125a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dE9CTBDqawjcchGMNI5tUnvvih6I+8u9YEvEtUurT2OfyUYjYkzX+70mnSRxz51IMEKhld0d5pJSofFg8T5lcu+LZpymLUJizzuO9Oj+tR79lEnMXaJjgKTVuA0JHQo24j3vhqLrg6Pisalc2soPFx5VWw9vCz/1tkIgNPEkw3i3hLTSOM3w8ZmTUlBlPhGHxUFSsGbUuyRTLuc6N/A51ltM8BvzJk3i0BLMOYAVa8jpCc0zWJGHnQEIuktgC2Nj9YFA+jZe5dfCAIYr8lui9oPfx4i9EzMvwQU3nAL/4h2JJIaIXvY6tOvfuVYYuD+XUccreS/DjOHPnTqkVfEDy5+cyswkoRXPXi19bp9YmMKfOn8h3jG/7DPOxU4VkZTbGYScwfR1edistf6sb2KmlD3+DLLUsIWrHc4BV6XCL8qJy1Xl5UVtrtpAfDLbHrNiHArCmcHANmwEUBalFzlklGRFDMvOd/YRgOVPsjerWp2ZTHpF3TBIgDh6Xyo/tBKbhzHEpp4dcocku0zBavjVCxSdglowVTW5vj68hWa4ehv4WIgKGjU+R4QEeBPgTGX8Bd5/myG/3PpJxL82sH3YsSfE14pxJ8yS9JFD2/9tXHjO6AVx5B5y2+TsJ91e4SH9I94GecOBV+lYGlVaiBC+nQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYBPR01MB5341.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(396003)(346002)(366004)(376002)(451199021)(64756008)(66476007)(66556008)(76116006)(66946007)(66446008)(110136005)(54906003)(71200400001)(26005)(9686003)(6506007)(15650500001)(316002)(4326008)(41300700001)(478600001)(7696005)(8676002)(8936002)(5660300002)(52536014)(7416002)(86362001)(38100700002)(55016003)(33656002)(186003)(83380400001)(122000001)(921005)(38070700005)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-2?Q?WthtQb1s/Q56YAl2ZMEv0O/z/NjuAZtm/PATSCDpdXhkgtBTjfzxQ40gLM?=
 =?iso-8859-2?Q?I0dKzdxZNQhgdoft5udRnsUhuEy56JE4QISEENutG4v1Uc0TgdhpGqv1ci?=
 =?iso-8859-2?Q?yQtn+MFwDsk/hEq6d2xeR5hs5f6TBVXMXH0HGjYeZXLoxoXu9v+CTGTQHV?=
 =?iso-8859-2?Q?RB4E1Ir96qByG5czIKPCkIQpJjn1s/n/JZae9H1oXZZEsdxXC+tSkfogK0?=
 =?iso-8859-2?Q?oo9Pmo0x1rwclemSyKt5QLjqH4bnXAqTFfOMU0bQK+TEgPz8B/VyF5RVHZ?=
 =?iso-8859-2?Q?dml2JxbD8cm7BR8jKE99rEfchodb6Jt6G+9+FpIv3MSXpq4I11ywhchx8W?=
 =?iso-8859-2?Q?LOlg47JoItOmlUUw19aNdJgp2mssrz77TDWnQPut4JfG061wntgJzvAFqg?=
 =?iso-8859-2?Q?QSiAtQyRHj4ueiUHBg0uELgTcYjlC8roLniCerVADK8fAEiT7w9IMmG3Ji?=
 =?iso-8859-2?Q?m5BsfV/4Mq/EJ2vUfOiBGvMJhi4tiGyyV3HUo40WFnXgnAmcHM8+oQX+/1?=
 =?iso-8859-2?Q?5ofMvYap04x2kvJHLeYSdtoHBZvmbV/ZSLFJQp6bUpHItzcuE7hbyM+d0J?=
 =?iso-8859-2?Q?ycDl1muyrYgbvPbyo0c8/q25BiXiYJe0tlWDy681LQT4U3hpdBQ7CzZ4yn?=
 =?iso-8859-2?Q?50QfidzbIz0QSjoWvrM1M+YefffCLJYNqg6HVWAopNaKzSRc7Rehw8lyZ7?=
 =?iso-8859-2?Q?pmQMFQsghVpQXEcweA9SGIxdXxJzKK+rzt8ovu4dLZ9PomcuUzM8ATQu+k?=
 =?iso-8859-2?Q?bt+dtXt8tuQbt0XRDu6eAmT4CNwMil3Juc37/qgD5yIZgufjkMPrfBNfX8?=
 =?iso-8859-2?Q?ljaZ1aLWL5OaFPHX3cGaKaM5eVJMDQeI0llHTV1pGKgc/0BA1J2HF/ycqO?=
 =?iso-8859-2?Q?nasRwpv/rhcyvTgTgZDaT1+n8Gn5dCyMrHrveeXQOlRCyAUCLJItjvMSvM?=
 =?iso-8859-2?Q?5PeYwsB3X4YwdXLa873IU1ss4x0fqe7XWuasAHSalu66zKOQWB7uCsdd6q?=
 =?iso-8859-2?Q?YYKdTIwvd7gUg3CZcz+/s8Ab59+3Amuaz28G5++F3qZXCziAAf0jkon2XQ?=
 =?iso-8859-2?Q?2f2PdlofKDriuJgLU174HyoIeGNSFpKKizTDFxU1LtdoMufs9CBZvpUH0q?=
 =?iso-8859-2?Q?4CK1ynmpQ0VNQIbpTIA06f3X+atFA0iQPAYmH9LoYN2yUFJAQBzs9rJiUJ?=
 =?iso-8859-2?Q?ui78+FLHHVCy6lm14T/0Bnqiog8GZrSCL9b2wLAo+u8WOhbnoXZ1Jk7jDW?=
 =?iso-8859-2?Q?ZLKllztS/m+Psiowb2ncM3NNrhQ03Eck7shtiWrKhGCvw41DvR0PPxCq9V?=
 =?iso-8859-2?Q?VaRPyyz/VFDPqj/jJHGKz/pw9zw+EVeE0olkAmTLLzCVgS7aFakxweBv+w?=
 =?iso-8859-2?Q?bcsL3dS7QYZz8CuAz+Tyl/Mf2sZZ5JjYMj/jiIKSTzE2CGzWanZXy2euPe?=
 =?iso-8859-2?Q?qkZeIqxrnSNgOHxZnXOfy3V0+qsKqeYzY3wGwIY7ljEUeNIy7iDQVa/1IO?=
 =?iso-8859-2?Q?8trr59VwUSZYf+VWnuIcKg2UgecmiVtXDCE6EK9t0IwZIo/FYUfQf1op5M?=
 =?iso-8859-2?Q?hHzgd0ifwIA2cuPK+hJ/U9vVW+2HAfIYsp0UktS4NwmuEBlZ9jhY4w7uSU?=
 =?iso-8859-2?Q?agRcvS0N0WwwrlIn3igmWRSpnaTVzCg6tBaALvd57QoSTE8T0VXmDM8w?=
 =?iso-8859-2?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYBPR01MB5341.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: daebdff4-54dc-453a-f9d3-08db52cf125a
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2023 09:55:52.2519
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MNgIdp+5v+Tx2KqPMgfhuv2EkmlYonA3v4k1w1apFjFuVp1DRnlAIF3kHVV3kCpavmaS7rbFYKNQRzP9H0UQuKBiuNIheUF11IMpLLVguvPienwaArEADAfRYOCMMsi9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB9669
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Serge,

> From: Serge Semin, Sent: Friday, May 12, 2023 4:09 AM
>=20
> The message is printed if the number of requested inbound iATU windows
> exceed the device capability. In that case the message should either refe=
r
> to the "dma-ranges" DT property or to the DMA-ranges mapping. We suggest
> to use the later version as a counterpart to the just CPU-ranges mapping.
> In any case the current "Dma-ranges" phrase seems incorrect.
>=20
> Suggested-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

I'm not sure whether my review is useful or not, but anyway,

Reviewed-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Best regards,
Yoshihiro Shimoda

> ---
>  drivers/pci/controller/dwc/pcie-designware-host.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/=
pci/controller/dwc/pcie-designware-host.c
> index 9952057c8819..5718b4bb67f0 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -723,7 +723,7 @@ static int dw_pcie_iatu_setup(struct dw_pcie_rp *pp)
>  	}
>=20
>  	if (pci->num_ib_windows <=3D i)
> -		dev_warn(pci->dev, "Dma-ranges exceed inbound iATU size (%u)\n",
> +		dev_warn(pci->dev, "DMA-ranges exceed inbound iATU size (%u)\n",
>  			 pci->num_ib_windows);
>=20
>  	return 0;
> --
> 2.40.0
>=20

