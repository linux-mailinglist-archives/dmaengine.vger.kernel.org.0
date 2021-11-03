Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1931044400E
	for <lists+dmaengine@lfdr.de>; Wed,  3 Nov 2021 11:34:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231949AbhKCKhO (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 3 Nov 2021 06:37:14 -0400
Received: from mail-dm6nam11on2061.outbound.protection.outlook.com ([40.107.223.61]:29793
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231913AbhKCKhO (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 3 Nov 2021 06:37:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FCd7sKLk8v8T4+b/6q1GBakQ26sjzwYWmFjiHpXiHRMIGuZnwG37BBNnF6t+/CA7YwHfZZ/t8tnCD/oy6vWdPgy4gQyJDUedpUbLPnqGQlLG4E1ZsmzLJbITjJaY/NuEVEDvIkT64+jDJS0Cb0nDQmNV6p3x0q4JtkQC2qlXBGMP+Fcem7f9BUlPLNtrj2a3cq3wTPrZ/AHrWG/giUQ6uGpp/HUj8Ob7fZKa79OT5md21pLCupvS5XEwR7CNCiONR69HucLEE7PR415EGZ/iEK+vJIx1VmbGtR4Ak65l/3zDzTLioc111nW5Y5ZWsJcYjWmSbuglxn0HhAAVQN9YLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UHaFgZyCmMvqNMzR70znBy6jMR0odfFZPxpXIDZ2prM=;
 b=ewrj0fXDbKW89kAtJpjl1hu+AbVeRbY2LE+efyhWLVeYKuVeeNk1EdHOEGajW0t5WMypr3A10/C451EsPABC24xkJhgGHmLTyeBdDU1TCBd4pfRLAYteQwQa0jxJ6k+Q8yY6jYI8GtodZx9gopTXF3cjjxhVMm16Q1qQcw8jqKVBQD/+d5TPi1xZiEELdmNB9IMa05iAJEL/hZ1x6CUEE+XBOWmoC3q1/rptE/JmndJxO7Kn0Cslh59/t1+P107Y7PRqW37S8fiGqQjBa7lz1Oe0TuhSxkzPpBNUEmlJG7unXynrwVacbbJgVDf2QhoOZAr6CunSQK6cPTJ8dnW20g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UHaFgZyCmMvqNMzR70znBy6jMR0odfFZPxpXIDZ2prM=;
 b=SasJKjADhC8BJoEv2fx1NaLaIwahxMb29U11LGExBmbdM67LKHiN6DDATwU0FuJLlZjP+N5xsfoMn8GRtnNkIWpzsXYODPQOX+JxLmKemeZ3i51n4g9pOktjGHtoOnpIbPbs1MpBHUayyMX9pEy0Jl1I/MIb4rFG8tztiNMNAiy4beRD+VCP6o0gC7UGhodP9eaN155v+Iz7sRLCFbkHs/UV4dAHrKIV6PPGeWwPvTsyznrXkBfLiHFXTIWQO80oWLdPKw/GtHDVLF24ht7uerwsKANhhyL+pG5EaDiCBn3oKXbO/OGA4l6bvE3yxHU7lMDS0MAlAmLmWJXq8YgHvQ==
Received: from BN9PR12MB5273.namprd12.prod.outlook.com (2603:10b6:408:11e::22)
 by BN9PR12MB5228.namprd12.prod.outlook.com (2603:10b6:408:101::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.10; Wed, 3 Nov
 2021 10:34:33 +0000
Received: from BN9PR12MB5273.namprd12.prod.outlook.com
 ([fe80::98a0:161b:7aeb:de15]) by BN9PR12MB5273.namprd12.prod.outlook.com
 ([fe80::98a0:161b:7aeb:de15%8]) with mapi id 15.20.4669.010; Wed, 3 Nov 2021
 10:34:33 +0000
From:   Akhil R <akhilrajeev@nvidia.com>
To:     Rob Herring <robh@kernel.org>
CC:     "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Krishna Yarlagadda <kyarlagadda@nvidia.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        Rajesh Gumasta <rgumasta@nvidia.com>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>
Subject: RE: [PATCH v11 1/4] dt-bindings: dmaengine: Add doc for tegra gpcdma
Thread-Topic: [PATCH v11 1/4] dt-bindings: dmaengine: Add doc for tegra gpcdma
Thread-Index: AQHXy/+hmi4aF0a7zk6tx0wdX3F4kavwQL+AgAFgwOA=
Date:   Wed, 3 Nov 2021 10:34:33 +0000
Message-ID: <BN9PR12MB5273887DC5A3153A434432ADC08C9@BN9PR12MB5273.namprd12.prod.outlook.com>
References: <1635427419-22478-1-git-send-email-akhilrajeev@nvidia.com>
 <1635427419-22478-2-git-send-email-akhilrajeev@nvidia.com>
 <YYE7D2W721a1L4Mb@robh.at.kernel.org>
In-Reply-To: <YYE7D2W721a1L4Mb@robh.at.kernel.org>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 020e994c-60f4-4aca-f86d-08d99eb586d0
x-ms-traffictypediagnostic: BN9PR12MB5228:
x-microsoft-antispam-prvs: <BN9PR12MB5228243C82481D15960A77F5C08C9@BN9PR12MB5228.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BM9lk4X/EM937MdARJ5U2kUi/WSFCus3urQanuhZmnlTKsiCGCEFQ1F5BWBBcwZ5VC/R6nP5jWrspeFwZAcKqz0DUWYyN8+pcVNhB/canRB1C3v6R/lWc33kFJ3qimWh0ESzz0+7RbSMlsxux0KdX1fzZCurHgI1JpMpvs4r0LqkLDU+EuDERsfppcvjDgInd9zUfjGju9Ft7WBshdnOYwUR0mzPZAYSf05BHjNKGTnxMUuKOmFAyM1IJYXY7WWOnctfAdhqE770M/APktUTpcD7q0oeOECMK/2b9fc24NJ+PAnkkaA/HOdW8ouOELHhqWCeVq6bS5mtWgvxeHDuX2S29hJBQrTiLAwpm3QpeVJpjQRfzyPOQoxDhuU4YH18oo4YpViZAK/NL8x0MCnjqmQlzMQ5Zf6zjgwW/e4bTs2hFq7Z2hX+ZEbyysPzv3k85FzopJF8sl1Bi45Hk30SExi1yEvfEZ/rXhUia61o/76jOxFnaXiFAAmc6eU6wd1bwoSY0WgfTs30ya6Yw/9x4n93rFsVlXR3ReQ+WCtOjT5KVPfyF3Nf3TJcgVyCZpsnXQM7/OLPcvSMt1V2W5DuUIdf2V/QnFglXDPykrv3L74QaSG+9TSy+yKldmfl6TGRRwarMXj3YdM6kG3ERehXRM/lw6UdYaRrywLBHon3jGdOsAn6UvX+/ca2RUq2KkuDnqYG0JWvmFUkFX7gpdGmdbaH6N7gdsEl0Jw4bm+9AwUwlH+6gIGIgRQbEI7VhwmKL+KQv5zShPXd8HjPyrkAs8HnW6A7FssVBdSQuu/9JD3e1YPzrUtx34qHA1KGWvHwsYUOoSLsh9UQm3pwssZ/qw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5273.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(316002)(5660300002)(26005)(2906002)(966005)(52536014)(186003)(9686003)(6506007)(8936002)(71200400001)(76116006)(55016002)(38070700005)(66946007)(66476007)(4326008)(66446008)(66556008)(64756008)(7696005)(86362001)(33656002)(508600001)(6916009)(54906003)(38100700002)(8676002)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?puO0FuM3PUv22HhPmgcjdE943JTPyIK9lWYOoIqQhccJz3B8e64CXcHoKVAo?=
 =?us-ascii?Q?lKX19BH2UJERUg/pXR8MUbWi3juu5WUCH4MAMGci6NYXvG5ISkV4WreOyttc?=
 =?us-ascii?Q?dyIEaJ/dSnafNsIwBM/DsvjthlSB+TllfrvJw0+KE7o3w/f/El6zHJB7P4og?=
 =?us-ascii?Q?ZlC5xpknrSWwZB3VS55EHtMpq7h91vymcLqZAAg9OlqRwpibNls9agpS4SXa?=
 =?us-ascii?Q?TCeWl8bcHmdchtQNTVl9cfm7IccEsRM7NR12VTc3WXPdBrlShT6EGi7WMAty?=
 =?us-ascii?Q?FoAg1JoiPG5yWcf0p+d5VqRcXlmr0D1/L5BKkT2Kg+gJ/d1H4fydzF1/6guR?=
 =?us-ascii?Q?yL+P0y3XHfGp2Jauq4BorbULjerYV9NKqB7YmvtzS0vBtNs4qJ5oiZKU8VUh?=
 =?us-ascii?Q?cK6Q2v6hBPf4cARUeDpw7J+rgVnl86LgZ13EZuxdpfYko3sGeDhcW0ijUwyE?=
 =?us-ascii?Q?F7yOFfC9cu3CBv5l0JOWmIha4MolaD1KFqqKEhsTbG1ZvuqRQ6Rx1GWXqX2R?=
 =?us-ascii?Q?i3dhADPwrNOKcc5Pf/poY64uk7i7eqHu3G8+nMFUhwnzm+zw7CwUBRi3Dxm+?=
 =?us-ascii?Q?dOVap3ydZSWXS0bH3lxiRNWM3tHMEoV991ZzliThqep9gNpRW4VVmCtCHMrK?=
 =?us-ascii?Q?JcWfUeOlpvPMXzmTYuL/Ckhh3lvpLXxQAKSVPji2uUQGamOpwpk9BBeE33JS?=
 =?us-ascii?Q?TrNqg8c3BWwBqbdxmi2ecSgZPfN0yG6gchaLbdoh+lZda3LI2Hq75XjMHstn?=
 =?us-ascii?Q?hS4dbR1cJiP/WGuEfmEk+Nnt86iNRtQaCtOXeYcWmSu2Xn4dQ+mZ1Va6KJwU?=
 =?us-ascii?Q?7xZ23zKVmrYEWJ6/Y5xPzlKPtxq/zj89Fbh8TUInHzC3oX/jbRibpUr0PwU9?=
 =?us-ascii?Q?XR33CgeHWq9pM9rO+WbCmfnlKj8pQ1FZW8J6mboEFoPdVM58r7bBpCTijhLJ?=
 =?us-ascii?Q?HQ5EwICltCeZRpuMtW/uzVQVrv9zhmUPdHwPeuQ0LwvHiGTq3z9IXlApiJN0?=
 =?us-ascii?Q?WFHN5SsVsYMA8JwtSvmhqCyckqhivpE12CJaZBvprQtqvDvbQqNZBZLK8yhD?=
 =?us-ascii?Q?xuvs5jP/ZaGriW0GHLVR1Bn5kMlJ6Anf4OvaQ49Sf9RmqrX7MND/vinp1Au5?=
 =?us-ascii?Q?rge75Y3cfwnae2xs3cR9dWxq1CvlaJMYoo+/u5mDQsDDfEUZl4H0vnMSP6DD?=
 =?us-ascii?Q?bf+mA70gWkj9WCpvM/qo3SjT3HVieRNWA6Fda2hPYOlZ67yFqHxywWRcwcil?=
 =?us-ascii?Q?J2sePe3+87AfQ7+GWooSo8ey1NHSTQU4BvZlgsxLD521NoexjXKaJYdmcPom?=
 =?us-ascii?Q?2et2KYVCs76edN7Q4dnmB615zhKhMtX+JAQogFo6+CuxMOkg0T1GyRm1kA1p?=
 =?us-ascii?Q?28s4+YBc/w22xpbenC6yiGBTdH7iv1RmR0jY3RXmlBFnhAigkXfESRA6Yfi2?=
 =?us-ascii?Q?90RFNHgh0ZdQwokQsGFBx+43bFIJ+vqriI/vk23um1Z4T3lG27QUl5y7oYyB?=
 =?us-ascii?Q?Rlz+9jIRnmkbAawSixmiD9sbOXPf5Kels81/dKL3fAzMwkGnx6tsKWWJld3A?=
 =?us-ascii?Q?lgYkrhNJqsbnutQhRb9MiQM5b3o4av0u8M6MY74kgLcjNqsOKcVyvBMyxU6u?=
 =?us-ascii?Q?ag=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5273.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 020e994c-60f4-4aca-f86d-08d99eb586d0
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Nov 2021 10:34:33.6751
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hw5j/W/C6ApEflwoynQ+3pOGP0VWl/kqagRwqDMDxWT00n1UKuWeo+I0UG5Hwi64ATMivG2m0fgCP4pYMfGEvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5228
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

> On Thu, Oct 28, 2021 at 06:53:36PM +0530, Akhil R wrote:
> > Add DT binding document for Nvidia Tegra GPCDMA controller.
> >
> > Signed-off-by: Rajesh Gumasta <rgumasta@nvidia.com>
> > Signed-off-by: Akhil R <akhilrajeev@nvidia.com>
> > Reviewed-by: Jon Hunter <jonathanh@nvidia.com>
> > ---
> >  .../bindings/dma/nvidia,tegra186-gpc-dma.yaml      | 115
> +++++++++++++++++++++
> >  1 file changed, 115 insertions(+)
> >  create mode 100644
> > Documentation/devicetree/bindings/dma/nvidia,tegra186-gpc-dma.yaml
> >
> > diff --git
> > a/Documentation/devicetree/bindings/dma/nvidia,tegra186-gpc-dma.yaml
> > b/Documentation/devicetree/bindings/dma/nvidia,tegra186-gpc-dma.yaml
> > new file mode 100644
> > index 0000000..bc97efc
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/dma/nvidia,tegra186-gpc-dma.ya
> > +++ ml
> > @@ -0,0 +1,115 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) %YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/dma/nvidia,tegra186-gpc-dma.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: NVIDIA Tegra GPC DMA Controller Device Tree Bindings
> > +
> > +description: |
> > +  The Tegra General Purpose Central (GPC) DMA controller is used for
> > +faster
> > +  data transfers between memory to memory, memory to device and
> > +device to
> > +  memory.
> > +
> > +maintainers:
> > +  - Jon Hunter <jonathanh@nvidia.com>
> > +  - Rajesh Gumasta <rgumasta@nvidia.com>
> > +
> > +allOf:
> > +  - $ref: "dma-controller.yaml#"
> > +
> > +properties:
> > +  compatible:
> > +    oneOf:
> > +      - enum:
> > +          - nvidia,tegra186-gpcdma
> > +          - nvidia,tegra194-gpcdma
> > +      - items:
> > +          - const: nvidia,tegra186-gpcdma
> > +          - const: nvidia,tegra194-gpcdma
>=20
> One of these is wrong. Either 186 has a fallback to 194 or it doesn't.
Not sure if I understood this correctly. Tegra186 and 194 have different ch=
ip data
inside driver based on the compatible. I guess, it then needs to be one of =
these.
Or is the mistake something related to formatting?

Agreed with other comments.

--
nvpublic
