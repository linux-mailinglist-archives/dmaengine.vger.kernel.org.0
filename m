Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 650134DC3D6
	for <lists+dmaengine@lfdr.de>; Thu, 17 Mar 2022 11:18:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232513AbiCQKTl (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 17 Mar 2022 06:19:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232507AbiCQKTk (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 17 Mar 2022 06:19:40 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2079.outbound.protection.outlook.com [40.107.22.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3AA0CA0F5
        for <dmaengine@vger.kernel.org>; Thu, 17 Mar 2022 03:18:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X+8D8DCtr9qbYuXLatw27NCOaKMoqFzJjVH8qxKmendTe1VwRqf2Lfi9UX9p9GyE2Ns9EfwwkQUulH0sogYndUHoxEZibk+k3EHEz7Lpuy+nIp2LUkNf4Dekxz5jEHCQqIGuGHc42ajmSdMiOVKTiqkKu4wgspctNmuBvoDGPNUC5SvjlbidZppdeddbQZgbwH57Q7Y4c5GA0ESAC5tXLztiXix4CnJOCH4a/K+G/dfR8bd3HtySeWR6p3GqsdHUu8OjZHzKiHUKHBKhA1mbU94G40QrJpT5TV4eMzX4f5C30oVGvlDOyzTXLsjYIvoGap9Ps+nJm2y2OX6vu7BIXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mdGsMK1tXL5AfXWFmHiqFXrytgdjLCpe6Q0TeQYuJDg=;
 b=M6Pp+9bnnQaaRBPAU9ToV6qj92M6eNn2UUVPrG22SZqwaJYgNhdoTXqiHvhaD4THNTIo0QpZbik8IlV5IdNjoTR5tidVr9M/CPzRZ/WslvdJSkiz2/CUP4IidOKVsRzAJp8/0G2itjDs27Nr7V/igk7yAmL6SuIohDfY/Ygghe5LKLFCgPkrRTOuOlvzckjVXxZv19XX3y/ycTnA9GGjRSQyiSVzU5BtIa79st89+1x0Fs+C2wKW4y1vlZLaOPDGD69gx8W350lsoXEug0g/fNweBp91QxNOOd1zCG4Di0pn7dV7alOhpx/zxcCH5wOWQB80rN/wvY9INnUzXFsIMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mdGsMK1tXL5AfXWFmHiqFXrytgdjLCpe6Q0TeQYuJDg=;
 b=L9S9dNkv58qFHn9yds5InJP2tz3sBmizwKk4JjztTuQtv5PeeGCbFvozEh05D8oxXEaidl3Z2Tg8qtX0o3gDMbdjVTZ0WQQxCJwwyFvx0xZn3w/8EdCj1F46puB30BXFDZ93Jq9yn01ulzjJc7JdOi62zTBr0PVgjV0kyqdfiOI=
Received: from PAXPR04MB9089.eurprd04.prod.outlook.com (2603:10a6:102:225::22)
 by AM0PR04MB5409.eurprd04.prod.outlook.com (2603:10a6:208:120::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.17; Thu, 17 Mar
 2022 10:18:20 +0000
Received: from PAXPR04MB9089.eurprd04.prod.outlook.com
 ([fe80::bc25:a82e:ab71:84fb]) by PAXPR04MB9089.eurprd04.prod.outlook.com
 ([fe80::bc25:a82e:ab71:84fb%9]) with mapi id 15.20.5061.026; Thu, 17 Mar 2022
 10:18:20 +0000
From:   "S.J. Wang" <shengjiu.wang@nxp.com>
To:     Sascha Hauer <s.hauer@pengutronix.de>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
CC:     Xiubo Li <Xiubo.Lee@gmail.com>, Fabio Estevam <festevam@gmail.com>,
        Vinod Koul <vkoul@kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        Shengjiu Wang <shengjiu.wang@gmail.com>,
        Joy Zou <joy.zou@nxp.com>
Subject: RE: [PATCH 10/19] dma: imx-sdma: Add multi fifo support
Thread-Topic: [PATCH 10/19] dma: imx-sdma: Add multi fifo support
Thread-Index: Adg55YOAgybKVsaDTJ6HIO/mhEUNTA==
Date:   Thu, 17 Mar 2022 10:18:20 +0000
Message-ID: <PAXPR04MB90890C9D3BB8CD759DDEC998E3129@PAXPR04MB9089.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 27c218f1-ed81-47fa-309c-08da07ff7630
x-ms-traffictypediagnostic: AM0PR04MB5409:EE_
x-microsoft-antispam-prvs: <AM0PR04MB54095A82B96E881B9F4C369DE3129@AM0PR04MB5409.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HdHB2QwD65fr00BiLJrDmP3roGlahwmkbUhVrv/RoTnD11j93XBXCMiHQBPdVImN2bLdMJlNnM+VfaDZVEkRhEpZfr6gCUC7SF1R2bHb5h1JgBhGx7oyDUG5UC3APT6oFhxVGAxrBPfSjy2W1yhW77A4Tgozo33DRCj2BKJQ5Gko5IQNd+BUxGDLAQxR06g6SplJL+N/2hoPJ5QyJJ1Js4zv6T+f2IFiW4PLuvWk1Qscek96o63Hl8NibaAzweImTvsu3jsfg2UEmO9TL73F2zam3AWwX2MBJHhs8Uz14I7ayQMXu0DkHwzj6Iih3bM6qUCJKHXA4c0+zXjrf4WnMb3x17jkqMz2hSymm9Poek29g6jNtKx4xFl8qCTGES5wkv/b78c7DDWFM/pFNeldAdnnQPusndbEWO3GVAL0H0mk4xsX1wGEZUsPvRGix184a99ObEWVgGRbZxxyhDKfOXXN4UnVTo3Cq8YJxVcrYuH0oCBqVFOBhxHa+fvVPUvSelvKPUfauuK17trbsxGbA5MShU+7GgaDYatZ6GrwRS0jCHWqpBJiJYiezdrpnurhWGcYZMiABJ5gSH1RRNusQUZpeDqaPzqK3B6NE8LPUa/Q4kBvCs/zvOBnjDDzMR17XyISKVas6fj5GHtqDkW8e7aoysbu2D33z+pMPA+H55bxE9rpz6mwQtKaXvXWAmta9JYphgnt1RwqIfNaADMn0g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9089.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(55016003)(33656002)(9686003)(110136005)(2906002)(316002)(7696005)(6506007)(8936002)(5660300002)(52536014)(8676002)(186003)(26005)(64756008)(71200400001)(38070700005)(122000001)(86362001)(54906003)(508600001)(38100700002)(76116006)(66946007)(66556008)(66476007)(66446008)(83380400001)(4326008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?8SVWo9kiiXC+pTR9RxF3HI5EI6+9ho5J9XX5bVCOSrB8Z3NZ57XUF4mjMRpl?=
 =?us-ascii?Q?67ccs7533aV4Z1gvI23B7ilgp/DNZrCd5hBZjfymZ+8R3TFGTzW0dL4aADjO?=
 =?us-ascii?Q?Zbu7bk/MiQgb1Eprov94IOJmXBSGYhE3i6sODZ+pkjv1u14lgmh2PQlnP7XZ?=
 =?us-ascii?Q?ck4fiGkMmwEMbv5/E9Qz0mruZqF1IEJVV3HViJ2WYoWwdRs+H1YXbRIaQJ7d?=
 =?us-ascii?Q?GLjXCleoIxp7ZJlGsP1n0QTF5XFr5Ix+ywqijiAY4L7mSkU9dSP8tBeHm8aE?=
 =?us-ascii?Q?TSgTnaW1lZUiCPcA9OYdH2Z9lIoHJ0K7F1/lPhdQmZnMF9U9Eg/I8cOtnLPq?=
 =?us-ascii?Q?KtQFtCR1/jcIf21XhGQ+9g+xuOg0ezBTvFTPciy0XBoVQK0ctTqTnYLyuGU7?=
 =?us-ascii?Q?U7OgFvXR/HQs0VOzY26DoD+Kj1Oj5IOTJpeGEs6X0/dCd+GJfE3oFRMgGLsM?=
 =?us-ascii?Q?EyLeAZ+44a4APbytlP0UlJt1CfgdCelPjXamP3RvirlvcWLOdQZUQs8Hw7Rk?=
 =?us-ascii?Q?yBLZkK0MgTs4eeFZG/HAiFZ5vihf3RJH8Hym9R77k0sQ2SmXt8PTtOItXp55?=
 =?us-ascii?Q?GQnGWpBDbBnNhiwUHDKKgSN9QZD3Adm2kx+XEM4fyAYCMnwQ7mc41oeJjofd?=
 =?us-ascii?Q?D3tjVM7q9A3+a9foSrQ3Rf201nWWtYYgtdBvOzaYuKhZ4SQO5+rSXtIkfgBe?=
 =?us-ascii?Q?d3RYumrCk+HJ3W3DYtWpNUsPP/NtIvC8W31zL9Jdc5NFeIYTQk30ptUb1qEA?=
 =?us-ascii?Q?q/rGIBA5K674+OYQquDXIArcsHThXd1yyBD5BCLtAHGZc95egU9U0nGiyPSN?=
 =?us-ascii?Q?eafuJqYehG1TwOwP1x6dYDipF7taoiy9nw8Gbgt1ILfLyjKPXf6PW58sYTbT?=
 =?us-ascii?Q?/c976UMMs44dW+Kh3lrwHCHd0jLZvgMgHRzNkM+3yTGDiQn4P3Ok5wuvuFbC?=
 =?us-ascii?Q?a3+EAks2/8YWUhW4nOcbVXcy0vyjWPAco+FOCIT1d+WKdxgIIzMjkuUH0tHd?=
 =?us-ascii?Q?dPbNabnAD7hVY/506aFXr9cXBl74bGgbbA+drjU2ck7BQNT8EEh7shxwWwgj?=
 =?us-ascii?Q?gkAczSEScKlRumnf1/nbUJwYx/S/q2ZEddyDGkrLF1lX1HaaXwI7wLbVeRkP?=
 =?us-ascii?Q?eEiqPkh2t9UqjvKaIXI3F8UIf3xuu7X91f9s9ZMhBCiveEZgMvfW6ii215Gr?=
 =?us-ascii?Q?u3RUdjIYRCgHeD8YL+6YxaZ8epJiXL0V/m8yQv+eMacg8CJzkgsh6g+km8O9?=
 =?us-ascii?Q?D5BN87UB7otBcBNG3RBoggtiYVlw+G2kqfDCYYWWQFqpY4ty+zGUOvUi7gaN?=
 =?us-ascii?Q?p0QzVwWN5Wuly1+3pvky2Tbc3/pR7xjSoxmQPnDWmCYgqKuf0AQ5XEt9QuNG?=
 =?us-ascii?Q?VT4VnM+vNwI/pDIJ4+2M4ODDwwHQSyzgP7GZdutcQ3I0uhqjCg3PwOfXjuYV?=
 =?us-ascii?Q?yXmqII8jrpl/vv0KzKNqY2D16qzfw+TZ?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9089.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27c218f1-ed81-47fa-309c-08da07ff7630
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2022 10:18:20.6177
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mFOB9qS093lZcHepkUuYfEj8IoXZJKbvBVXIi7MohRF4DrPddiahux+ZK8Cguh7DfZRbHj6U28bwPel/qY2uJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5409
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Sascha

> ---
>  drivers/dma/imx-sdma.c                | 54 +++++++++++++++++++++++++++
>  include/linux/platform_data/dma-imx.h |  7 ++++
>  2 files changed, 61 insertions(+)
>=20
> diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c index
> 1038f6bc7f846..21e1cec2ffde9 100644
> --- a/drivers/dma/imx-sdma.c
> +++ b/drivers/dma/imx-sdma.c
> @@ -14,6 +14,7 @@
>  #include <linux/iopoll.h>
>  #include <linux/module.h>
>  #include <linux/types.h>
> +#include <linux/bitfield.h>
>  #include <linux/bitops.h>
>  #include <linux/mm.h>
>  #include <linux/interrupt.h>
> @@ -73,6 +74,7 @@
>  #define SDMA_CHNENBL0_IMX35    0x200
>  #define SDMA_CHNENBL0_IMX31    0x080
>  #define SDMA_CHNPRI_0          0x100
> +#define SDMA_DONE0_CONFIG      0x1000
>=20
>  /*
>   * Buffer descriptor status values.
> @@ -180,6 +182,12 @@
>                                  BIT(DMA_MEM_TO_DEV) | \
>                                  BIT(DMA_DEV_TO_DEV))
>=20
> +#define SDMA_WATERMARK_LEVEL_N_FIFOS   GENMASK(15, 12)
> +#define SDMA_WATERMARK_LEVEL_SW_DONE   BIT(23)
> +
> +#define SDMA_DONE0_CONFIG_DONE_SEL     BIT(7)
> +#define SDMA_DONE0_CONFIG_DONE_DIS     BIT(6)
> +
>  /**
>   * struct sdma_script_start_addrs - SDMA script start pointers
>   *
> @@ -441,6 +449,11 @@ struct sdma_channel {
>         struct work_struct              terminate_worker;
>         struct list_head                terminated;
>         bool                            is_ram_script;
> +       unsigned int                    n_fifos;
> +       unsigned int                    n_fifos_src;
> +       unsigned int                    n_fifos_dst;
> +       bool                            sw_done;
> +       u32                             sw_done_sel;
>  };
>=20
>  #define IMX_DMA_SG_LOOP                BIT(0)
> @@ -773,6 +786,14 @@ static void sdma_event_enable(struct
> sdma_channel *sdmac, unsigned int event)
>         val =3D readl_relaxed(sdma->regs + chnenbl);
>         __set_bit(channel, &val);
>         writel_relaxed(val, sdma->regs + chnenbl);
> +
> +       /* Set SDMA_DONEx_CONFIG is sw_done enabled */
> +       if (sdmac->sw_done) {
> +               val =3D readl_relaxed(sdma->regs + SDMA_DONE0_CONFIG);
> +               val |=3D SDMA_DONE0_CONFIG_DONE_SEL;
> +               val &=3D ~SDMA_DONE0_CONFIG_DONE_DIS;
> +               writel_relaxed(val, sdma->regs + SDMA_DONE0_CONFIG);
> +       }
>  }
>=20
>  static void sdma_event_disable(struct sdma_channel *sdmac, unsigned int
> event) @@ -1022,6 +1043,10 @@ static int sdma_get_pc(struct
> sdma_channel *sdmac,
>         case IMX_DMATYPE_IPU_MEMORY:
>                 emi_2_per =3D sdma->script_addrs->ext_mem_2_ipu_addr;
>                 break;
> +       case IMX_DMATYPE_MULTI_SAI:
> +               per_2_emi =3D sdma->script_addrs->sai_2_mcu_addr;
> +               emi_2_per =3D sdma->script_addrs->mcu_2_sai_addr;
> +               break;
>         default:
>                 dev_err(sdma->dev, "Unsupported transfer type %d\n",
>                         peripheral_type); @@ -1198,6 +1223,15 @@ static v=
oid
> sdma_set_watermarklevel_for_p2p(struct sdma_channel *sdmac)
>         sdmac->watermark_level |=3D SDMA_WATERMARK_LEVEL_CONT;  }
>=20
> +static void sdma_set_watermarklevel_for_sais(struct sdma_channel
> +*sdmac) {
> +       if (sdmac->sw_done)
> +               sdmac->watermark_level |=3D
> SDMA_WATERMARK_LEVEL_SW_DONE;
> +
> +       sdmac->watermark_level |=3D
> +                       FIELD_PREP(SDMA_WATERMARK_LEVEL_N_FIFOS,
> +sdmac->n_fifos); }
> +
>  static int sdma_config_channel(struct dma_chan *chan)  {
>         struct sdma_channel *sdmac =3D to_sdma_chan(chan); @@ -1234,6
> +1268,10 @@ static int sdma_config_channel(struct dma_chan *chan)
>                             sdmac->peripheral_type =3D=3D IMX_DMATYPE_ASR=
C)
>                                 sdma_set_watermarklevel_for_p2p(sdmac);
>                 } else {
> +                       if (sdmac->peripheral_type =3D=3D
> +                                       IMX_DMATYPE_MULTI_SAI)
> +                               sdma_set_watermarklevel_for_sais(sdmac);
> +
>                         __set_bit(sdmac->event_id0, sdmac->event_mask);
>                 }
>=20
> @@ -1669,6 +1707,7 @@ static int sdma_config_write(struct dma_chan
> *chan,
>                 sdmac->watermark_level =3D dmaengine_cfg->src_maxburst *
>                         dmaengine_cfg->src_addr_width;
>                 sdmac->word_size =3D dmaengine_cfg->src_addr_width;
> +               sdmac->n_fifos =3D  sdmac->n_fifos_src;
>         } else if (direction =3D=3D DMA_DEV_TO_DEV) {
>                 sdmac->per_address2 =3D dmaengine_cfg->src_addr;
>                 sdmac->per_address =3D dmaengine_cfg->dst_addr; @@ -1682,=
6
> +1721,7 @@ static int sdma_config_write(struct dma_chan *chan,
>                 sdmac->watermark_level =3D dmaengine_cfg->dst_maxburst *
>                         dmaengine_cfg->dst_addr_width;
>                 sdmac->word_size =3D dmaengine_cfg->dst_addr_width;
> +               sdmac->n_fifos =3D  sdmac->n_fifos_dst;
>         }
>         sdmac->direction =3D direction;
>         return sdma_config_channel(chan); @@ -1691,9 +1731,23 @@ static i=
nt
> sdma_config(struct dma_chan *chan,
>                        struct dma_slave_config *dmaengine_cfg)  {
>         struct sdma_channel *sdmac =3D to_sdma_chan(chan);
> +       struct sdma_engine *sdma =3D sdmac->sdma;
>=20
>         memcpy(&sdmac->slave_config, dmaengine_cfg,
> sizeof(*dmaengine_cfg));
>=20
> +       if (dmaengine_cfg->peripheral_config) {
> +               struct sdma_peripheral_config *sdmacfg =3D dmaengine_cfg-
> >peripheral_config;
> +               if (dmaengine_cfg->peripheral_size !=3D sizeof(struct
> sdma_peripheral_config)) {
> +                       dev_err(sdma->dev, "Invalid peripheral size %zu,
> expected %zu\n",
> +                               dmaengine_cfg->peripheral_size,
> +                               sizeof(struct sdma_peripheral_config));
> +                       return -EINVAL;
> +               }
> +               sdmac->n_fifos_src =3D sdmacfg->n_fifos_src;
> +               sdmac->n_fifos_dst =3D sdmacfg->n_fifos_dst;
> +               sdmac->sw_done =3D sdmacfg->sw_done;
> +       }
> +
>         /* Set ENBLn earlier to make sure dma request triggered after tha=
t */
>         if (sdmac->event_id0 >=3D sdmac->sdma->drvdata->num_events)
>                 return -EINVAL;
> diff --git a/include/linux/platform_data/dma-imx.h
> b/include/linux/platform_data/dma-imx.h
> index 281adbb26e6bd..4a43a048e1b4d 100644
> --- a/include/linux/platform_data/dma-imx.h
> +++ b/include/linux/platform_data/dma-imx.h
> @@ -39,6 +39,7 @@ enum sdma_peripheral_type {
>         IMX_DMATYPE_SSI_DUAL,   /* SSI Dual FIFO */
>         IMX_DMATYPE_ASRC_SP,    /* Shared ASRC */
>         IMX_DMATYPE_SAI,        /* SAI */
> +       IMX_DMATYPE_MULTI_SAI,  /* MULTI FIFOs For Audio */
>  };
>=20
>  enum imx_dma_prio {
> @@ -65,4 +66,10 @@ static inline int imx_dma_is_general_purpose(struct
> dma_chan *chan)
>                 !strcmp(chan->device->dev->driver->name, "imx-dma");  }
>=20
> +struct sdma_peripheral_config {
> +       int n_fifos_src;
> +       int n_fifos_dst;
> +       bool sw_done;
> +};
> +

Seems there is issue with my gmail, I resend the comments again.

This is our internal definition for this sdma_peripheral_config.
Could you please adopt this?

/**
 * struct sdma_audio_config - special sdma config for audio case
 * @src_fifo_num: source fifo number for mcu_2_sai/sai_2_mcu script
 *                For example, if there are 4 fifos, sdma will fetch
 *                fifos one by one and roll back to the first fifo after
 *                the 4th fifo fetch.
 * @dst_fifo_num: similar as src_fifo_num, but dest fifo instead.
 * @src_fifo_off: source fifo offset, 0 means all fifos are continuous, 1
 *                means 1 word offset between fifos. All offset between
 *                fifos should be same.
 * @dst_fifo_off: dst fifo offset, similar as @src_fifo_off.
 * @words_per_fifo: numbers of words per fifo fetch/fill, 0 means
 *                  one channel per fifo, 1 means 2 channels per fifo..
 *                  If 'src_fifo_num =3D  4' and 'chans_per_fifo =3D 1', it
 *                  means the first two words(channels) fetch from fifo1
 *                  and then jump to fifo2 for next two words, and so on
 *                  after the last fifo4 fetched, roll back to fifo1.
 * @sw_done_sel: software done selector, PDM need enable software done feat=
ure
 *               in mcu_2_sai/sai_2_mcu script.
 *               Bit31: sw_done eanbled or not
 *               Bit16~Bit0: selector
 *               For example: 0x80000000 means sw_done enabled for done0
 *                            sector which is for PDM on i.mx8mm.
 */
struct sdma_audio_config {
        u8 src_fifo_num;
        u8 dst_fifo_num;
        u8 src_fifo_off;
        u8 dst_fifo_off;
        u8 words_per_fifo;
        u32 sw_done_sel;
};

Best regards
Wang shengjiu




