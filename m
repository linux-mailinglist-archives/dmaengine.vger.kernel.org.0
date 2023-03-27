Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC4256CA087
	for <lists+dmaengine@lfdr.de>; Mon, 27 Mar 2023 11:53:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232307AbjC0Jxn (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 27 Mar 2023 05:53:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230017AbjC0Jxm (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 27 Mar 2023 05:53:42 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2093.outbound.protection.outlook.com [40.107.114.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 111AD49DD;
        Mon, 27 Mar 2023 02:53:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YtdT5VoQoUrML/yDNCCe6EfLiFB4djzuv5vYUlMla40hmfqsPSFhg7Tnn2hzqjjAAowhF2D6j1z5Ldag/EVMylEPneKMwIw27yDEnUfS2O2MRb3eqgek9VEgzDnxutmNTARc55ZdJLL6ByHlKPleRRlPDBDwFYOBKG+GvsusZWcaJEqjGBZUacMAYxwClfwM+2x/P5Nle5l/Z4hJeciE+4NC9wN0ncAxQhOaYDf53jCLbIoKPWGR2+JdQN9ZyZcPSVUW2rlKy0Omq23Z11Ze4dOwMIpRD3Ox86sWWxMBeHl6y4wCTXHweqIMNt8Q8yecYZdLijPFTE1ngK8ikdhNuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kBqF9KftHU/I8UqeP0jfS/JRtu7gIw8v8NbedwhDdtw=;
 b=TA2RA+Uwdpn0+M/eH5Ys82n9Uq/6UthXrCm25crTg1s7Y71ykBLo1OFym0ZpYM5pG0f6USZ8WlhKgxAAZ0p49vbaGdlOVFL/4ycVTtQD1NrmyM9LSRoZ7/Jz4Kyy8pXA++k6qmj8HSnI5vf48oi1emGY0GmMhzfeK/5jHCeUZSOxR8cGuFECF53YqdIgcK4um8rjg9rlc/PgpZQBJ88sdOMklYh/NX/Fs7RP4wDBehL0Pni7pGhFP+0z60cmf5psQQlm8Lh2MQJi6GEO9DQQaw5MoB5uFeB7IUO+i+vjWa6W+1gxBqdsmxHrsErHORRhuhEU9UU3N5hF4tFDqxtUng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kBqF9KftHU/I8UqeP0jfS/JRtu7gIw8v8NbedwhDdtw=;
 b=GskJYfjKO0Y7qJIlDMsVGxTuXg8fupSKCL/be70EnfU597xR2wPQqTGw3ltvMDXg/lvamZQM9j4XWKRWg5GAfB27UrYZDKAGce7c4VY3KnEfMjZ7f/cMnB9zyOaqhGng6WIT1/iCSdAocWhPquWR87pvIEoMt/Rret8WSnMsqlc=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TY3PR01MB11948.jpnprd01.prod.outlook.com (2603:1096:400:405::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.28; Mon, 27 Mar
 2023 09:53:38 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::e521:994c:bb0e:9bf6]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::e521:994c:bb0e:9bf6%5]) with mapi id 15.20.6222.028; Mon, 27 Mar 2023
 09:53:38 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Vinod Koul <vkoul@kernel.org>
CC:     "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH] dmaengine: sh: rz-dmac: Remove unused
 rz_dmac_chan.*_word_size
Thread-Topic: [PATCH] dmaengine: sh: rz-dmac: Remove unused
 rz_dmac_chan.*_word_size
Thread-Index: AQHZYJFQz2hl/iqjdkSNZCFVO+fevq8OYqIA
Date:   Mon, 27 Mar 2023 09:53:38 +0000
Message-ID: <OS0PR01MB592254BE57FF71C184442A05868B9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <021bdf56f1716276a55bcfb1ea81bba5f1d42b3d.1679910274.git.geert+renesas@glider.be>
In-Reply-To: <021bdf56f1716276a55bcfb1ea81bba5f1d42b3d.1679910274.git.geert+renesas@glider.be>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|TY3PR01MB11948:EE_
x-ms-office365-filtering-correlation-id: aeac2d99-6d2f-4c81-66ac-08db2ea92375
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YD/vzv2N3tC7/ifDyNZd5YdtGB5BslXVr1jMzZpny7TT3WQ8JqkVG4ijR97I2yGhPiJmwjkJlw85zgJQePso199WJKYIB+6AuTziOM5jHJDCKP+SKTUL23H7+NjVXPPqj4rexaZQaUWEgZEzICMh20C473S1jVLx3ABEB5Eeujo1F8VrUf0XLfij+OLbi/9coh4k939eSsvfXv7SeTWR26r2ZIVRLBl/n3Ve633vmfm9ObcmuxCYAQOC5x60p/bEvuH8/TwG3xFF65gIf2nM5XQIE5ISkG7AxdBJv8a4FhhJKhm4lm1Lj5OZAriU3kqXEcKDm8C8PEd8049HxCA+PdFU9wOUnXH5AWB9snrG89+btXoTMQoJNl4NT+1az3x7zHBDx+M2OxVo1s5GmMuiK7V5YvqZcycJ0Vgpz5GXrFLaGv9IrUIIVtl03Uuem+UYp6rYn92UVARVuJh5FrvgL9M6p2SYNNfdNGTELd/pL5/BI+pCuyjIXeOz5gPXXsgIfk0R2Jqj7ImUKwlksDy4SwRQq7KDzpAyHuWHoAwYG8dPSDGQhyZZu7zLqouc6Yg0BjqPiyBSIEY44dDoQaSUFCZGd86U0vWCX1Ln5wH2uBnH5oFyysz0iN/U/4vaeRcF
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(396003)(39860400002)(346002)(366004)(451199021)(83380400001)(64756008)(76116006)(66476007)(66446008)(2906002)(4326008)(8676002)(66946007)(66556008)(54906003)(71200400001)(478600001)(7696005)(53546011)(9686003)(186003)(6506007)(26005)(110136005)(316002)(38070700005)(55016003)(33656002)(86362001)(52536014)(41300700001)(38100700002)(8936002)(5660300002)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?AOZp42Ww74/hG81uCKNccTnlpgPmgQ1t0KkUO8lQ78sElPWKZ1LfI5FVmI8i?=
 =?us-ascii?Q?dPTCSF/sHALoodhJ6xily6DUAvcMqwEvXfKPZV11KQXMOlpu1c4OO9Z2XVmf?=
 =?us-ascii?Q?5Pom5ZnunGQ+XJ6axTFUYeepJPsCXBIQIQHFbyQkiVUEF7JVCUN4feq5d3OY?=
 =?us-ascii?Q?IrxRg4eR8G+DBd8inc/yIvPoIFrLhSKB0K9MuqMlb44eaaL6s4xHqXvRCslJ?=
 =?us-ascii?Q?qPTGEv5nef/t8H5wYWcNGUigQemFxKATQrbSCXchpszn/bNxvzP+0RJpfIcl?=
 =?us-ascii?Q?Ns+ONlN7r37VotSGWP9qdYGGJtTJg7Wy1BHAWoWa/A51gUpI46kzCgNptFVU?=
 =?us-ascii?Q?zcWPd7Tcy9vkLkXDrekIzGFOthTiNs2/XC6iHh6nNT+BZKq+zVgs6YQWonoY?=
 =?us-ascii?Q?zPmdZnyxOYS3naH7eRHVCmsMJG7V3cpHiRePd/l59tTRDWhWg8w4ecg/5yrd?=
 =?us-ascii?Q?jQoE4dHmO1Z869f87hvx4WxzcuGQVEyF9rYs8ohxhS1GgKhESxl+8Gnc+imh?=
 =?us-ascii?Q?2bAc7E9wlS4iQmitWNiFDGcMWvgkQ4CyOuF7YzsQBbSXzXfSsUFpi7w2Pa9A?=
 =?us-ascii?Q?xVCHucgIB6+/c3/Kqoml1I+spdkF3XqJihsIuL9tSFdBFJyMXHWQmWA5HLNH?=
 =?us-ascii?Q?p3XJbO5e7JzGCNbqAtmuUCd+FuiIu/4HnMGc7Ti7eRlPaf1vCgUCQaMxFobQ?=
 =?us-ascii?Q?YwTc9SxA9uFqe2xizhec1vFzfH4DLsi0QRJ+5OUEM5sMyiVZs3RvoL32a+hv?=
 =?us-ascii?Q?6FPycqP9AXwiD5uoCuGTzdjCCKOtMxFE7lWmQB1SPavhNZxwlIgktbpwNTRm?=
 =?us-ascii?Q?uvWZwgqH+XTaASW1hnlR7mPB49WB/cKz4zFDjXT3VIEKuhIBJKKb26RXMPKK?=
 =?us-ascii?Q?spFL88jxkU96fHT0q23A6woPTtuJBF9u1kQ/eNNeTx6C1HZp2xSofCk+jTub?=
 =?us-ascii?Q?y4yRp9SzbH+9JVaWPVYpsT3pPc7GGTJAHSup2sIH0urFOg/Lg+2Uyt3K86sQ?=
 =?us-ascii?Q?CrlrFcdM8FMGPQ3CDdJ9tnpAACY2qQFaZ1QdIzAJfS1WoXYIUT+uK+9ENh5H?=
 =?us-ascii?Q?OhOEwLv2eSqR41mgZ9dcOsScCgTwgOmktLhxY1CmYtUW8ZhgagndLJKehkY1?=
 =?us-ascii?Q?eh8n3bcVDX9WwRZvaW4xkvIEdXnQdM1PKumwGdXbI7TUg2vFTa90hxxVqghY?=
 =?us-ascii?Q?qNBrERxLkMNtc8pmukTjM58tFcPwRsKpvvAR69D6iXiyDgNFQn1VCFiBUTAm?=
 =?us-ascii?Q?R490Nq/wHiIeT+OSPzFCqL8tfg2gUto4ud/GPii0BZ7lp+zDwH/NTfiX4ZC9?=
 =?us-ascii?Q?wOnEOBc69O31430N6FEsJBpxLIZlJx2SyarsB3FxKtydCPwOxT1Nx93WVan3?=
 =?us-ascii?Q?hnsoDuFqyiFizCwUkS5/cxwaVCRZXZ3REd+VI6TYpU5+VmIgfWdqbsNmbTI1?=
 =?us-ascii?Q?3UdzN/kk3nqkGfLvE48NCpwcvOdIUjfonveysjzuKYlVSHLddHZ8ZQaZvvOY?=
 =?us-ascii?Q?V56QWi9MXrWWuzIosQtPq86Yg6tY9xdJNJUYIqUvyPXY5O+kw9+MEYkjJcnS?=
 =?us-ascii?Q?x5vNkAFkPIN+RjG07UDE8jQ/m+u1LJMrW4dO09T8?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aeac2d99-6d2f-4c81-66ac-08db2ea92375
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2023 09:53:38.1695
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4ERDA6JN5CCXjTsGOBw6P/4CIIQxpipV62/OYXeI9ESboIG/MI5VyvlplDAv+8ZrK6IzXlQ1+mLn87NSzPYoE6IRA3LYd+RiqzDyIM440rk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB11948
X-Spam-Status: No, score=-0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Geert,

Thanks for the patch.

> -----Original Message-----
> From: Geert Uytterhoeven <geert+renesas@glider.be>
> Sent: Monday, March 27, 2023 10:49 AM
> To: Vinod Koul <vkoul@kernel.org>; Biju Das <biju.das.jz@bp.renesas.com>
> Cc: dmaengine@vger.kernel.org; linux-renesas-soc@vger.kernel.org; Geert
> Uytterhoeven <geert+renesas@glider.be>
> Subject: [PATCH] dmaengine: sh: rz-dmac: Remove unused
> rz_dmac_chan.*_word_size
>=20
> The src_word_size and dst_word_size members of the rz_dmac_chan structure
> were never used, so they can be removed.
>=20
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>


Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>

Cheers,
Biju
> ---
>  drivers/dma/sh/rz-dmac.c | 4 ----
>  1 file changed, 4 deletions(-)
>=20
> diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c index
> 6b62e01ba658ac13..9479f29692d3e3d7 100644
> --- a/drivers/dma/sh/rz-dmac.c
> +++ b/drivers/dma/sh/rz-dmac.c
> @@ -67,8 +67,6 @@ struct rz_dmac_chan {
>  	struct rz_dmac_desc *desc;
>  	int descs_allocated;
>=20
> -	enum dma_slave_buswidth src_word_size;
> -	enum dma_slave_buswidth dst_word_size;
>  	dma_addr_t src_per_address;
>  	dma_addr_t dst_per_address;
>=20
> @@ -603,9 +601,7 @@ static int rz_dmac_config(struct dma_chan *chan,
>  	u32 val;
>=20
>  	channel->src_per_address =3D config->src_addr;
> -	channel->src_word_size =3D config->src_addr_width;
>  	channel->dst_per_address =3D config->dst_addr;
> -	channel->dst_word_size =3D config->dst_addr_width;
>=20
>  	val =3D rz_dmac_ds_to_val_mapping(config->dst_addr_width);
>  	if (val =3D=3D CHCFG_DS_INVALID)
> --
> 2.34.1

