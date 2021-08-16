Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4F343ECFB7
	for <lists+dmaengine@lfdr.de>; Mon, 16 Aug 2021 09:52:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234168AbhHPHws (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 16 Aug 2021 03:52:48 -0400
Received: from mail-eopbgr1400117.outbound.protection.outlook.com ([40.107.140.117]:60096
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234043AbhHPHwr (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 16 Aug 2021 03:52:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a1i67JucW6OngjiklvCiTRUGfvu3TsDRjuZfgux/H3Tgww23G/eJxfhzEf0Qred+Zh/qpdDUkNfH19dLRkc3r1qprLx0jQB+eLR5cxTpy0zbbjl3Q1xo2esODWrmfXNtJr8o0ScrFwAqfzrDGv3kkQzGxrYKFdKwWoPPQYDeBSv2uTTkDPBhig4I925qBJR6ykNqx2wZAIQpSpckOo5cOGijPckRcA92tJF702PG0YZYAInbqxkMnxOqmUEXMCgiL9HlyZE8yWQP4zam0POKriZ19C5ETads0jpGQfD33X5txgRj10uIVYw4UyBukcN34i4+nt4XkF1vaslzK8hFmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=csW7mKpOGtAQV/iNWkEWkn8ZnEutslWnzl4iWMV9LZE=;
 b=a8Yle690JGeid1alL+meeXqAfQPZyoWtERDgeYYAYBr8+TLFmi3+tTGHDMaOzY/0FbHn0Z5VUu4AIhum946J38i94S/BCQ+2Zfi18/X0sZrZVtBg4LjaAAXNQyMqlENfX8D3GnOtJoQpdwkskeoOscdlttfS3gAp+Jk9ZmswdbLZfUm+OYEYvQplmvEgYkwMT336UaRztlNz1wYUV0JHcuZCxOWRgw32VvC+txWFWHkQQUhUFPcQasUzcCe2somsdRO4sxRnOSQRJPfAJoQBOk4wZsYfZhuB9mGAj0+Yi1gMl39C52ITA1Qerp3qI7yJY89t4jI3HN6p9CjOGyuhrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=csW7mKpOGtAQV/iNWkEWkn8ZnEutslWnzl4iWMV9LZE=;
 b=aQuEi+3rRjHQLtlY/MV76FJ1hku6gaVLwj8voMdETz6f9QgDdCpW+z+opbh/JgUw3BwGwuRjq/clcjVjbxX8njLEr/gdj0X0Usv3hG8WQXc22UaEkp9dUjvCsCVNQOP1CdtWPd9KgKgd5p6UcXV+RjhvyDsJr2gVeJGHlpdQBwg=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by OS3PR01MB6628.jpnprd01.prod.outlook.com (2603:1096:604:10e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.15; Mon, 16 Aug
 2021 07:52:13 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::c6f:e31f:eaa9:60fe]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::c6f:e31f:eaa9:60fe%9]) with mapi id 15.20.4415.023; Mon, 16 Aug 2021
 07:52:12 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Biju Das <biju.das.jz@bp.renesas.com>,
        Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>
CC:     Chris Brandt <Chris.Brandt@renesas.com>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH v7 0/3] Add RZ/G2L DMAC support
Thread-Topic: [PATCH v7 0/3] Add RZ/G2L DMAC support
Thread-Index: AQHXiqjo2NLXibA+ZEa2KdTQORKkVKt10bdg
Date:   Mon, 16 Aug 2021 07:52:12 +0000
Message-ID: <OS0PR01MB592295B2B25BF3CF56272A2B86FD9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20210806095322.2326-1-biju.das.jz@bp.renesas.com>
In-Reply-To: <20210806095322.2326-1-biju.das.jz@bp.renesas.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: bp.renesas.com; dkim=none (message not signed)
 header.d=none;bp.renesas.com; dmarc=none action=none
 header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 59d27517-9235-4a96-993c-08d9608ac1ea
x-ms-traffictypediagnostic: OS3PR01MB6628:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <OS3PR01MB66281C0D391B5064BF8434D886FD9@OS3PR01MB6628.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1tTOYCrJakYM+BMgf7ZjnQP3fWSjtQdNkQanK8hhxaArS+dyKaifI0I/Rq8+j6xYa4BOufR4kGZpeu/CFRQwgCRMyzHu+KkRkGqybOh7CBcUUV4ZPD5YM5G44MqjSMY1TcGdQUrFd4W80cboDP9dsEPHE9V07mEP9ctBVo9zWXhF8hAfkbSKpPQzRpvPCHwX+5GpEBdAVjpeFI+ekwWIFF92inj+BcFXEQRpLXkZfKtGL0s7TddM85xWu0kl6pdyLQi1AZ2c5zpuQQ+Gf5B81H18YrytkGpHt8a87dxBWNDb89UtoPxa7Xzno+hsnJKTNu1EShO+99Wxseu7ln+VpQDZiklhAFmEH9eZws3bxDLD6MaSwGALdx8boMnAgxYcOfbJmfUeYNT8uIZG36jgE3ehZ5eenuLGakUL1KDHLyGLZD5dH0K1lxJE4OLCmBnmyH4FfMAZhmW3tppANLjprxEVARR/3k3gjRQY4oDJZ/OLrImLQwuiDTb7S33No9vUTM3MH5onyir9SyZypdEnRNavXi4bvOX/q8piVA6mo6zI5AUW91fdC9fXpJkItkmPsClug5KJu7FyWnnYRVYp3hzPWVX1PfL/E0+5iBa9R7ZdJ0LfA46UkUp92p+a1N3+OSd4VttrtlyhCwJnzTYAxys5asA/q7Uh3rRpjuUR23V9cVQ50nAhQRdyXIUiDPJCl0/mUDd6piCqtX6EfGUYOg1Mw7tfNuIZYEQmAMLAUgfTa+qGIzwX3sbpVjP9bxmbLpFbdeCUKO7uKzpVfksSSb5CT7T4K9HCnzwFuPKOygU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(39850400004)(346002)(376002)(366004)(136003)(110136005)(9686003)(2906002)(54906003)(4326008)(76116006)(38070700005)(38100700002)(55016002)(5660300002)(52536014)(122000001)(66476007)(66946007)(66556008)(64756008)(66446008)(186003)(26005)(8936002)(6506007)(33656002)(45080400002)(83380400001)(316002)(86362001)(966005)(478600001)(7696005)(71200400001)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?eG/pV1RUgOJpowl1CsFOpetPx1GL0cbDvxEX6nYbadOzwKj/pDVb7wbT+H8b?=
 =?us-ascii?Q?LLr9Jh2mOu9RSjOGmoiRwoPdyMHdHF7RPVHixwMe2B8rEfkODIRyrJuEXHAb?=
 =?us-ascii?Q?Kclz6j4vUPHP8hFTJxhJ6rK6/SFdYR/nrtVgxwjBCQi2XO3cv7KAhly4YDH8?=
 =?us-ascii?Q?PUGlTGI3G6keODL6Hvx34tErgU8377nEVCwI2aC4Lst7I+gRuNF1QceSHPbk?=
 =?us-ascii?Q?hpzD1SxnLx4CuCVGFsekPzCZpvkKLnNoTDFoDpNiMMm6rSvnvhKk9RoRrECq?=
 =?us-ascii?Q?gp6DdkUONQDcSXuYnJX06iV269YF+k+XmNqrCnN5t6OejFUdvUXO90RBsFD2?=
 =?us-ascii?Q?OL/p6kMVhbSVEhQee6XqzZkQxyErGSGFN257YroupdtElSm3yHMn9KevqUoL?=
 =?us-ascii?Q?L+YERU+0j1/CfDX3SGaPwCYS1ejKGGXfMaN7sbeNAT1l7pO6cyyM3QaJEqQ3?=
 =?us-ascii?Q?/Zg4Q+PUA9TT3Oisi0+CcSj20TFnuqWAWC9Q6cbj/WePFVSU7mO7YSw1OW1m?=
 =?us-ascii?Q?A3IV0BqOQbvNDmYU+OIwxhOfbrSjgrPzYYPb4P+Ejq34hyJM5Al0qgLAMPu+?=
 =?us-ascii?Q?5HwXwNv0PEWDgNE6LmrgsNjKJkbXsuDfTEuhSC5gyjh4DyvPnHMLoUFFe6DT?=
 =?us-ascii?Q?8F9VOp4w5HcG/1m4sXU18nUq4Nkf9Qrt+WbZmMLV8/A/mPqVxdCLZCVlEWXP?=
 =?us-ascii?Q?FktqBcXzuffakq4YMx6V07v9fk63W3gJLG3ZMiN5gjzQAKiwed9C8/LAI7KN?=
 =?us-ascii?Q?uk+863Hl/nsVcXTj1+W54EsyzK9C430U5mFSqQUoY/TQOmPxQJ6KNGA25hPG?=
 =?us-ascii?Q?nbyOFiOJw+UvnGfroYeUHmtIh6oNTlOkNKdlJKmgaiXH+xjyh33w1lKIfFSh?=
 =?us-ascii?Q?+GzwBJPNpqRc6wQEC8VgJePAqZjg10VT+E8IAya9O70sssnXVTZcoXXleVFZ?=
 =?us-ascii?Q?abvN8a9Lyf67pGIdgwulgZ0quO+3w218nWqYk894m9hJs9F6b904SUv4Vqhz?=
 =?us-ascii?Q?+XPjOd2CvdB1NrbQTnnBoTn3uJuAvHpbgxqz2T/7KN0Hp8XwO4hWZap/jKe1?=
 =?us-ascii?Q?Iuk5bDojL7GYkNk5ISdW/yrwsNzUAvQmFNVtpfMW9WsGpGWrD2a6I9dGN2fW?=
 =?us-ascii?Q?8pzbMTsHR6R7JILKhVEkc1xw2Vxb/49Tr1M/qI/eKAeV4Bbk1Pj+0BIqCNxu?=
 =?us-ascii?Q?jVJXBQ0UCwR0lRaaTKd4KAvV9UfrYvqzIvgwxdjmXv4L8di7VtwT3c7G/5Sm?=
 =?us-ascii?Q?Xpk79lhV4pxr2F+CTSELda9IR6yLxwQrpfjCpAT3hypKBdC93tBeD5rNMOE/?=
 =?us-ascii?Q?39k=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59d27517-9235-4a96-993c-08d9608ac1ea
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Aug 2021 07:52:12.2844
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wWbMDi47+2RYrfs8u6GzWVrcl3BExg9nPxxhD+Zwm7uGhFrYKeVJDWA4SsDAvz+5YhX1NBDx7UE4u2tYzxg5kEqa7ZsQxUz79ojcdSosa+Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB6628
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi All,

Gentle ping. Are we happy with this patch series? Please let me know.

Regards,
Biju

> Subject: [PATCH v7 0/3] Add RZ/G2L DMAC support
>=20
> This patch series aims to add DMAC support on RZ/G2L SoC's.
>=20
> It is based on the work done by Chris Brandt for RZ/A DMA driver.
>=20
> v6->v7:
>  * As per the DMA documention vc.lock must be held by caller for
>    vchan_cookie_complete. So added vc.lock for this function.
>  * Added lock for the lists used in rz_dmac_terminate_all.
>=20
> v5->v6:
>  * Added Rb tag from Rob for binding patch
>  * Fixed dma_addr_t and size_t format specifier issue reported by
>    kernel test robot
>  * Started using ARRAY_SIZE macro instead of  magic number in
>    rz_dmac_ds_to_val_mapping function.
>=20
> v4->v5:
>  * Passing legacy slave channel configuration parameters using
> dmaengine_slave_config is prohibited.
>    So started passing this parameters in DT instead, by encoding MID/RID
> values with channel parameters
>    in the #dma-cells.
>  * Removed Rb tag's of Geert and Rob since there is a modification in
> binding patch
>  * Added 128 byte slave bus width support
>  * Removed SoC dtsi and Defconfig patch from this series. Will send as
> separate patch.
>=20
> Ref:-
>=20
> https://jpn01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flore.=
ker
> nel.org%2Flinux-renesas-soc%2F20210719092535.4474-1-
> biju.das.jz%40bp.renesas.com%2FT%2F%23ma0b261df6d4400882204aaaaa014ddb59c=
4
> 79db4&amp;data=3D04%7C01%7Cbiju.das.jz%40bp.renesas.com%7Cc9ed17350b19489=
6fc
> b308d958c00a1c%7C53d82571da1947e49cb4625a166a4a2a%7C0%7C0%7C6376384040934=
3
> 0389%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6=
I
> k1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3Dy2phFowFQIsATfjN%2FagVsOsZU5fOVs=
n8Z
> maE3%2BvhUVo%3D&amp;reserved=3D0
>=20
> v3->v4:
>  * Added Rob's Rb tag for binding patch.
>  * Incorporated Vinod and Geert's review comments.
> v2->v3:
>   * Described clocks and resets in binding file as per Rob's feedback.
>=20
> v1->v2
>  * Started using virtual DMAC
>  * Added Geert's Rb tag for binding patch.
>=20
> Biju Das (3):
>   dt-bindings: dma: Document RZ/G2L bindings
>   dmaengine: Extend the dma_slave_width for 128 bytes
>   drivers: dma: sh: Add DMAC driver for RZ/G2L SoC
>=20
>  .../bindings/dma/renesas,rz-dmac.yaml         | 130 +++
>  drivers/dma/sh/Kconfig                        |   9 +
>  drivers/dma/sh/Makefile                       |   1 +
>  drivers/dma/sh/rz-dmac.c                      | 971 ++++++++++++++++++
>  include/linux/dmaengine.h                     |   3 +-
>  5 files changed, 1113 insertions(+), 1 deletion(-)  create mode 100644
> Documentation/devicetree/bindings/dma/renesas,rz-dmac.yaml
>  create mode 100644 drivers/dma/sh/rz-dmac.c
>=20
> --
> 2.17.1

