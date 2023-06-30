Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0223A743E22
	for <lists+dmaengine@lfdr.de>; Fri, 30 Jun 2023 17:00:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232850AbjF3PAC (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 30 Jun 2023 11:00:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232910AbjF3O7s (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 30 Jun 2023 10:59:48 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2134.outbound.protection.outlook.com [40.107.113.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D49503C13;
        Fri, 30 Jun 2023 07:59:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BvUWWyVU9WuqdJWgn8ZRmFYyPJf+E62K1RY+wFJLRdReAyEzJqsMNIEqI4NZJ6eAILhOQkS9ktgvp5TM0hvorhoxFGz312VisYv4+NDMdkhwM8By/A3a7GU0C8GbwByBOavSAdF19gXXGM62gCDLjdIeJcVdigLMuN9JIzrhWIPoWm98kPxB1ckn633k18Z6JO7XD5mmnLJkTxZqjYlaWjc2ayDJL/2zQsVdoaHsfXQlTD/A7THOLJlrHB1Usir6Nh1Amm/tz0R0mH2uawg4ukp8fb2N9lszHX84FcRYjv4BF5CQQhDlqbXCOUiY2rx+6V6BtqUU3hNxfVdyYRNEDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/LeQ7etX/ZYgnr21frbFsQY17hP1wPiwfxBjlYtv2zQ=;
 b=e+M9e0fwYolYkuEd8IUaphiglXrdFfY55cr+wRpxXRcPoSjr+8TV/GYTBEdHNlrtxyqinHPbyD97M4SGpx53X7uGeV+6JxUqAmRvaN0S2yhWQ8TRVIHQ+rJIGifvG+TnkbCsI2A5gOFo9oQ1cwsP8kKDLNu138HR3KH9FNxjZM4vwE7iB4bQrfe7zv2dn5kk8HvQ1d9vZcD4Td3DhwbV8cZCLTXm8gPTvFCISVbmDNhPvsE4ANIfN9HNj/eVbBv9UJc4Y+Nq1ZoufZKtdmIhIYoOKYdiJLy2uez7O1mIZyV9jmZ5Hnc/30uNPMX0mLRHer9oEpm2Rz1/YSIpnCeRcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/LeQ7etX/ZYgnr21frbFsQY17hP1wPiwfxBjlYtv2zQ=;
 b=uAcvKjz1lsSqymFVI8xnktjeyPgZJabkjYc0hdAVlUr5irsv3gHQJln7XgZXhuMjvOYjIc8+tTqtfJNFnckwHzi8CE/LgNY+jwNdX78G/1ens+VikjG3fiNQLFCDvx2WiJJj8XhUVy47zeIwbUIRp0hTbxp8DBTaWXfo9kHAJt4=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TY3PR01MB9919.jpnprd01.prod.outlook.com (2603:1096:400:22d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.19; Fri, 30 Jun
 2023 14:59:40 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::fc77:6148:d6a:c72b]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::fc77:6148:d6a:c72b%4]) with mapi id 15.20.6544.019; Fri, 30 Jun 2023
 14:59:40 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Biju Das <biju.das.jz@bp.renesas.com>,
        Vinod Koul <vkoul@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
CC:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>, Pavel Machek <pavel@denx.de>
Subject: RE: [PATCH] dmaengine: sh: rz-dmac: Improve probe()/remove()
Thread-Topic: [PATCH] dmaengine: sh: rz-dmac: Improve probe()/remove()
Thread-Index: AQHZiZw/5mhn/4pUTkK6EhlPgkRT3q+js4Ug
Date:   Fri, 30 Jun 2023 14:59:39 +0000
Message-ID: <OS0PR01MB5922AC7DE18255D36BDA149D862AA@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20230518152004.513675-1-biju.das.jz@bp.renesas.com>
In-Reply-To: <20230518152004.513675-1-biju.das.jz@bp.renesas.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|TY3PR01MB9919:EE_
x-ms-office365-filtering-correlation-id: 7c843fdb-0d1d-46f4-12dd-08db797aa12b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kvLxQjgXnj8luQmMxON9lrN/gEyQ6C6UFQ5J4/cGUj9hGAymSVwMNvNzm0m96j2u4WmcwlPILL6D9aGTu5GlW6Do/m49bK0Q3jEOP3aD9KLPJL1tus8g0hcZYACTlno2EJMmFTdd6hdRhhvfpOhKYuSG0jojLa4Frs4vate6ch1zmy8dpsDzcZSuUiiSMJ+hZsRxr1A18MWBz9ADEDy6zUsuMp7H3JppSokcSCFdxnp4l3WVpITxPnaI8+v98SQMnBBpGyhDC4HfM3R30v6qmz2+CNHZMMMpfHWu/kI0mvZDEpc9CCoO8Y5jGXjunVoDOgTT8GwLm4Azg+VC3mM04tfYm9iGxUeV/q4Cr1LOX/DYvDhY8CtM5PW/VrNce/DkoBFE6RE5u5/8db2ADuLPLrh8VqjiLzrqGbFJypuxeSGslPt1sOOp0makSkxQxNhulqPtUO54ZhwtDBMqCmu2QseBidNUBMq7giSwvxoUCxTw8vK/eI3PP2L65VXGzx5i5d12624biQG+iHAHuOQm6QScXWOfbRHN6x5sYKSwXSRKPHTp3Kq0tD6+EFQxcVdH7WKCHS8pirYUBwtiVtT4e6qMDW5v1YpNjIZRVl6hjTk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(366004)(346002)(396003)(376002)(39860400002)(451199021)(7696005)(478600001)(71200400001)(33656002)(186003)(26005)(9686003)(53546011)(6506007)(83380400001)(38100700002)(122000001)(38070700005)(86362001)(55016003)(4326008)(64756008)(76116006)(66946007)(66556008)(66476007)(66446008)(2906002)(316002)(5660300002)(8936002)(8676002)(41300700001)(52536014)(110136005)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?/eXpcMgHP7RkwRkMDiOGoxvj3Hn5liQE8volrzygEWwsxk1Bt1GGzUpzhV+e?=
 =?us-ascii?Q?mdnG0w4x0Oee4m7CxDvaHDqweNlJwbrcpZM8lSoG0IID9NySS5kbFXKI3PIM?=
 =?us-ascii?Q?NnuklknjPHZNz8mtzsnJd9pPZAxDomRyXH98T1BcfZgC+Wg94Jc+UGuHCMNc?=
 =?us-ascii?Q?FveWY2CMXxu4D/iZD4ERfsacTvHvBYrtulsrKJZD5vlyPAxyJjBckNhGPluq?=
 =?us-ascii?Q?WyBGvjq0vYTu26g6N/hy33AajBApWCRxvZvIu9SPjtjBJsNrvi9KfhwBFSuC?=
 =?us-ascii?Q?5YLL+A6CHQE7haehAVUs3+uHmJaivc9D3+9u/Nqeye7+VOJTUPdLNI43JsIz?=
 =?us-ascii?Q?wG5Id6o9MjHasmoRzPzduu1En0ZRntRPtSiBeu0QpkF0pg3gmYPAEjE22KsG?=
 =?us-ascii?Q?Hv35RIwVb5JGahjIDSq16wLlInCLh8PDwTm1X3s/7QEz4HSSuJezc+b2N5U2?=
 =?us-ascii?Q?Z2tAhn0FeJTjUvy4Ic98W85SxfR3Wbx2tFS8O7tjy3Rxgzvl0ZDY9QZ2WnTS?=
 =?us-ascii?Q?gWnp4ZDMDtobFMzr2ooJI0XF1aBZmua+UrZ2a/NHaWeSjXNWXeEXav/ZwJxK?=
 =?us-ascii?Q?F34DZNi1PbH6+YkjluI6nHP3UhehEO3tUF7+dV2i0W0o/hIStekBb6nNX8wd?=
 =?us-ascii?Q?xAryu4A9U8BRJhhBtk8Jp3jpCh2yTBU6UYIn6GipP4FKHRgBM5iios3tACiC?=
 =?us-ascii?Q?zktKvFZ5I37cWE6wDd2vm624aFCMhzVD7/hThP9wfkqLfOC2JhjRsfvy/LKZ?=
 =?us-ascii?Q?EoUVY+k3PXI35F6u/5EhSgRv000+BAfIdxqI2DzrG12avHV8C4eYTUJO9foD?=
 =?us-ascii?Q?EZ+tBhIgtKgtTlgPFLrj7MzpnXZFSr3nF64mGdelTIMMzbtcbYePxwBR3F7I?=
 =?us-ascii?Q?Bopi4iv5n+7q7Vt/cc0mABi5WXJZkIK4c1biDIMRDNiEZlU5yGk6kEoZLEcT?=
 =?us-ascii?Q?Ty7cnKYYOw1FFJUB7ZTKjewmsAmV12u0edNqgz6SzXca9+JDzWXWfik3czh8?=
 =?us-ascii?Q?exvoAKm8LS4h+e+m1z/quL3yyk6AF4VDpMma2nJbhf42i41eoWCoZ0QbSi/x?=
 =?us-ascii?Q?lJvfBmG6NajF3jFHNmqYYXYzBpQZIuG/zgY3PpUSzGvKZ6VWLnTRF0hTpzh7?=
 =?us-ascii?Q?lr3cGk2da/ggEao5ciestRWNbsbebsMzDlR9Qeo7qwTFhHEE+yX0dbBjNtWS?=
 =?us-ascii?Q?vLSTtKJzktR1QQfYDH4l8FySJbe8dcTJgSqnzRan7+Gjj25H6FdrckwJBCTz?=
 =?us-ascii?Q?Q2NPrDBBlMiymgmsJdwkywvS9gMJRXIB/7unp3GOmvFCneOMcFs6F+Hpv5zq?=
 =?us-ascii?Q?sxFVYkNsFHpI7NXs4lgEBxCtSP7yRDLi/I0QfPTcHCJ63yq8O+X4ZEljykpR?=
 =?us-ascii?Q?J3qG+BrY7gXMIO3QYLgIB2WAhjqrIA3i+UQExlA/y5nHXmnoqejHEqQ62lE0?=
 =?us-ascii?Q?LQoL3ekyMwgMiL/CYGTJtLXFGPRTiLaknTmWUz2xUbLLIEhQLeURegGKbMVJ?=
 =?us-ascii?Q?Y+2tqvb6Z5nwcyDOnWH99OEZFDM0s6upwBt96OtokejA2xBgkkPHzim57G8u?=
 =?us-ascii?Q?yMJcNhH24njG1o6I0JsSf98xMX563wTGl3oqWVUJf18+FPgIa1LIlCixJuJ9?=
 =?us-ascii?Q?ZQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c843fdb-0d1d-46f4-12dd-08db797aa12b
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jun 2023 14:59:39.9809
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cbnSybtMSu5UbuNE41/lB/liOhVf/ltrJvGCsVvwJtajQ97KfNCY+fj4xIDNuOEf6ahJdqLwS17O6cOeL3MLapG7GXVsodlHlJFDHdzxkzs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB9919
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Vinod,

Gentle ping. Looks like it missed out.
Anyway, I will rebase and Resend.

Cheers,
Biju

> -----Original Message-----
> From: Biju Das <biju.das.jz@bp.renesas.com>
> Sent: Thursday, May 18, 2023 4:20 PM
> To: Vinod Koul <vkoul@kernel.org>; Philipp Zabel
> <p.zabel@pengutronix.de>
> Cc: Biju Das <biju.das.jz@bp.renesas.com>; Geert Uytterhoeven
> <geert+renesas@glider.be>; Prabhakar Mahadev Lad <prabhakar.mahadev-
> lad.rj@bp.renesas.com>; dmaengine@vger.kernel.org; Fabrizio Castro
> <fabrizio.castro.jz@renesas.com>; linux-renesas-soc@vger.kernel.org;
> Pavel Machek <pavel@denx.de>
> Subject: [PATCH] dmaengine: sh: rz-dmac: Improve probe()/remove()
>=20
> We usually do cleanup in reverse order of init. Currently, in case of
> error, this is not followed in rz_dmac_probe() and similar case for
> remove().
>=20
> This patch improves error handling in probe() error path and in remove()
> do cleanup in reverse order of init.
>=20
> Reported-by: Pavel Machek <pavel@denx.de>
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> ---
>  drivers/dma/sh/rz-dmac.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c index
> 9479f29692d3..229f642fde6b 100644
> --- a/drivers/dma/sh/rz-dmac.c
> +++ b/drivers/dma/sh/rz-dmac.c
> @@ -947,7 +947,6 @@ static int rz_dmac_probe(struct platform_device
> *pdev)
>  dma_register_err:
>  	of_dma_controller_free(pdev->dev.of_node);
>  err:
> -	reset_control_assert(dmac->rstc);
>  	channel_num =3D i ? i - 1 : 0;
>  	for (i =3D 0; i < channel_num; i++) {
>  		struct rz_dmac_chan *channel =3D &dmac->channels[i]; @@ -958,6
> +957,7 @@ static int rz_dmac_probe(struct platform_device *pdev)
>  				  channel->lmdesc.base_dma);
>  	}
>=20
> +	reset_control_assert(dmac->rstc);
>  err_pm_runtime_put:
>  	pm_runtime_put(&pdev->dev);
>  err_pm_disable:
> @@ -971,6 +971,8 @@ static int rz_dmac_remove(struct platform_device
> *pdev)
>  	struct rz_dmac *dmac =3D platform_get_drvdata(pdev);
>  	unsigned int i;
>=20
> +	dma_async_device_unregister(&dmac->engine);
> +	of_dma_controller_free(pdev->dev.of_node);
>  	for (i =3D 0; i < dmac->n_channels; i++) {
>  		struct rz_dmac_chan *channel =3D &dmac->channels[i];
>=20
> @@ -979,8 +981,6 @@ static int rz_dmac_remove(struct platform_device
> *pdev)
>  				  channel->lmdesc.base,
>  				  channel->lmdesc.base_dma);
>  	}
> -	of_dma_controller_free(pdev->dev.of_node);
> -	dma_async_device_unregister(&dmac->engine);
>  	reset_control_assert(dmac->rstc);
>  	pm_runtime_put(&pdev->dev);
>  	pm_runtime_disable(&pdev->dev);
> --
> 2.25.1

