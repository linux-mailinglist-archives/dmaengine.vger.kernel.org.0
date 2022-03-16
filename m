Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 039B14DB339
	for <lists+dmaengine@lfdr.de>; Wed, 16 Mar 2022 15:27:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349503AbiCPO2X (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 16 Mar 2022 10:28:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356755AbiCPO2W (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 16 Mar 2022 10:28:22 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2132.outbound.protection.outlook.com [40.107.114.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E99513EA85;
        Wed, 16 Mar 2022 07:27:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IWjeboW0//0ZSvOH8t+P+4LarteoaYam9MMro8fu2nuq4MhRtowEd7ZcSoaLceA2AEwQtk3sZkLftZMVh8yV0y6zXidgiFDo3OrkPmpSagX79OWXPxdnyW6rDaQJ2TiaMCU/fo9Tvczj72KfTql8W3Ew2E0eFTsIS91bI8GYP4Q6UvvBEQe0xFpCyuxdXMrtVXI83vWmdnncVyBnxAR+xqNjbhLFftnpw044jaBSMUKE/UETaecLmBPedqbjcr1dLgBGYw9oUfkinrvrRNEthDylife2Riux14sxw/NeoRLjovVonfw4Mv8g/6yvHmDzJfiYWv+GLccoD6ACizJS3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C2zbWW3TUFIT4qPhZY8fS0Bktdan79KXzdKyU9yZ9Ls=;
 b=MUvPueotUXP22lxK6G6NvS/ZnkYLzM40BAyDqd+TKoiXj9fu2pdUZXysqXExsnw4V7px415lFqvsstbkFseKPkV7mthOXNXjFC+zG0Cnu4kPDKjpcUDhMVwBbiSx5uo2/+L2PAiBQu4mgbeL+taeHQsLaHZ8Gs+d3phihWZnYFl+tYkLXL2tj0LHFM5QMLDl2FYLKvkn/rNBYfCC5hiEmjefznY+W4z/T2J01NzhTElktHPQIFDbfd8HRoAHeGoveNv2kPdSNgSj9eiWX6nR0VcEgjOgyX/jjMvmQn4JnrbbUWoNxTkZrCyMH4aBtFXE/aj48fxPL+SQA19wZSnG1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C2zbWW3TUFIT4qPhZY8fS0Bktdan79KXzdKyU9yZ9Ls=;
 b=bSb8Y7pJfioxlVo4C3kxWGozZ2HcUKr/ZjczEVfxPSohZXrh1GSzlaVolRuYO/zIZT0h7wVYcI0f1qMMju3v5UCMgus5LK64sShfRKu1gFsy5+ju/+ed3iE+VcFW5iyu9Lm/XrU1eq+3/v8KBWSerywd4Hx36hG3fRSH/xRs2qY=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TY1PR01MB1884.jpnprd01.prod.outlook.com (2603:1096:403:2::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.24; Wed, 16 Mar
 2022 14:27:03 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::cc77:910b:66c1:524b]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::cc77:910b:66c1:524b%5]) with mapi id 15.20.5081.014; Wed, 16 Mar 2022
 14:27:02 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Vinod Koul <vkoul@kernel.org>
CC:     Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Colin Ian King <colin.king@intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH 1/2] dmaengine: sh: rz-dmac: Set DMA transfer size for
 src/dst based on the transfer direction
Thread-Topic: [PATCH 1/2] dmaengine: sh: rz-dmac: Set DMA transfer size for
 src/dst based on the transfer direction
Thread-Index: AQHYMldDdX1L0lQMuE6FBhAbZY8t16zCHncA
Date:   Wed, 16 Mar 2022 14:27:01 +0000
Message-ID: <OS0PR01MB59220760F588124231136C8686119@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20220307191211.12087-1-biju.das.jz@bp.renesas.com>
In-Reply-To: <20220307191211.12087-1-biju.das.jz@bp.renesas.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 076042ae-6261-4912-a894-08da0759099f
x-ms-traffictypediagnostic: TY1PR01MB1884:EE_
x-microsoft-antispam-prvs: <TY1PR01MB18840ECE8963239695F3BB7086119@TY1PR01MB1884.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qeqVCU8OUgUF9qfg7hai4wiT/MjPJkoCVn4kOYrdWl6eDJJ7c1FI0mj+sWUFclTQatYrBtKF1Fcp2VTsDHJzVk4ziOKAQ8WN9+IY+jpc7mMqdjyZLD5a/Ge0EBNqL9pLfvQMNO8lpZZ9yBYcI4G8NzPxS8ggayds7KBdFCXlB6THOImPTy2Lu6n122slTw8j5yPOyUrPk5aR4eR9B0muNjiw68VBozlZn9OxY0NXgVkYG1mOEg5DYwVAhdOaZZybtMK+W2c59zQONPlDPmn1z2NolZQyb3/5Sx+pQuE6zX78Cna/E2cYvXOdr7oy08WtcIR30E0Qt2O0NnLrKgAJTNMYIc4HgPnTVQHnadec6V2yPOjgWyKt2rAnS0dqHEfS+1LBa/P1hlrGKsvMfmuW3c6eYr/fxmKTFM1QHxh7eVDMA6UOWt3ySHn7SywIFCoap+//NVd8vKTFR3sNQQOBNXaIsGN8iOgbkHiZ6jMesr6XZGbpW6nbHuNKRqmqqZoT0VWgYf3Ud+wdy735qJWvEqdjJqSvtUbnQDyisEejVnC6sUVF+EbaExSDSOOXIdPunyBqHJOGTF+2Ce6BzWojNCff8w9OmbubenrhVQJegdylHQA5CnUGM74X0XZg3WzutylwvmGHe8l6fpUO8JlTQoDAzchXwovJvBIMPFc/NXHp4FhuefHQYWXTcjh9KNHiUdtCGFDpXrl2euaTrhGp8A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(316002)(33656002)(86362001)(38070700005)(122000001)(38100700002)(54906003)(6916009)(5660300002)(2906002)(76116006)(4326008)(8676002)(66946007)(66476007)(66446008)(64756008)(83380400001)(52536014)(8936002)(71200400001)(6506007)(26005)(9686003)(508600001)(55016003)(186003)(7696005)(66556008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?A00X8ZWab9F10IExwg47z8cCTBo6Hn79NayllR891qEJaZo7j5y63hmDWhB1?=
 =?us-ascii?Q?HxbbiUDYSljSwSzVc9mvMmJwY4GWE64c74JO1OD5epn8lOJpRfkCqh96o7+V?=
 =?us-ascii?Q?NYgmJQZHJceKgXLwSMyuJqWVAK/BygnIncgeuI5MX99WUfKGZpR3CsuGblCQ?=
 =?us-ascii?Q?9BsLQlRA6GanmdoHiAEEM63gEKug9kGK1izgaHphesWxx0L9alkHZ+u941ei?=
 =?us-ascii?Q?0pof/E88XQOBQzrwybeRIwLhjYA+rO86xT53ObUgwXZK3VnMGp/R40iuK/Nm?=
 =?us-ascii?Q?ocDVuheBpicnh1nFPCuRJmoW5BxxFVowFL0c0RucdDkZAu1WSLCUl0fyEeQ4?=
 =?us-ascii?Q?1qRzqLg2bML4CkLdYyLz8U8nR0t1QAM02iJ4OLrIZN3WlNyF3xiQQaPiwBce?=
 =?us-ascii?Q?BenH75pMupVeLqC1dgsm9/hxvt81AcZh4G1ERcWdD8r7uVQULi/4M0t90yHo?=
 =?us-ascii?Q?hH3mzn8wGOLVQ0EJmV4ycinBY/48kw5PlEAVqi9nIQGX0a6BvktOuaQCX4eC?=
 =?us-ascii?Q?+br7ctJc8sN5Y+jBt/D9NOTK2SReRw50A083jqgxg24rxAYOVMleVVWBrfdz?=
 =?us-ascii?Q?6nCreA0awSqEkuw8SIRcd+0iiI+7WoR8ZkjPRRY3CY07oomjUT43tFebsrag?=
 =?us-ascii?Q?NJFli1qkVRoXFq+C1nstA9V4xk5hNJIart75IpafIjlvC1ysPwKBz7EXoif3?=
 =?us-ascii?Q?xj6l77QLzsuVJpbLtYW3txl+KOXJWkKNbXOBR32bX+lCXdLJ+pyjzdl18SdV?=
 =?us-ascii?Q?/07g8ZEXauJ1o7h8mfVTkME7QwZ/BW518dWV4h4lhMxHpxmM6x4hXxUw4DJa?=
 =?us-ascii?Q?O2KTUFpRnDsAaBSPNu2xwMFyGXqniMpjHWHNTmlFkDNmYfUeXKWujha1gDAP?=
 =?us-ascii?Q?wurQR4UOdzWFBI3RbIL9K1MqQIGuUkLRnzMLP8Dna2vOeHnLV08UwF4m5dhG?=
 =?us-ascii?Q?6/woOWOzcNHq6nl5FqybvJnuKMlKGALTovXX6EsPBNS9EvXYvsCwx2shPgjo?=
 =?us-ascii?Q?uuXeodVnxTJVEsJOoxiKOjwia8qWJS5RkbWXKnbVgKhr3hzviR/r/hrwc5PA?=
 =?us-ascii?Q?/c7SdyeiLGNWPsat/P7rr/bUnW2pfr538PK6yJ+ugobhPKfc86AHnHCOXlt3?=
 =?us-ascii?Q?a9MRSK3hx58GLdic6Q264ErgUgPVmVDvVbz+me6GjdXGRv+pasUp3eG9BqEU?=
 =?us-ascii?Q?9IfozHc29J+pPIHx/VwCqNzlcsnwPJSrp53RyWvfyzbFq3IswDXRTdIWHe1R?=
 =?us-ascii?Q?8prK3Ejv0jpbFPihbiBqXrjb05iFpV1sr4ZsjRd1RdGyvqeKIigM1IFnS9ww?=
 =?us-ascii?Q?AX2yzDF7iRaIVD4Tgku/Q98CQRxS6Wid862JGT/TED3o44M9HVpuS2RsGfQ3?=
 =?us-ascii?Q?JWJ6t17zbqjGbayGprlLR5jSA0iqmB3fla4DCwVO7XyrCc7MCXtqhenp8JQs?=
 =?us-ascii?Q?rlt+RfNqs6Nl56gRrUy+C5HGeBN4Gwx4JfBDRRxVnE+2hOK/lIapIQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 076042ae-6261-4912-a894-08da0759099f
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2022 14:27:01.9882
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NMbGt738PrsfGmWVqoq9vMWQAOs1xc3hU1sBxDVhbza2HaSaAcsKR1Ph0P0ryYdiQMl92phMbBzwGlBzSTbS0HwDffPJvLJClJryzDc1P8c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PR01MB1884
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Vinod,

Gentle ping. Are you happy with this patch?

Cheers,
Biju

> Subject: [PATCH 1/2] dmaengine: sh: rz-dmac: Set DMA transfer size for
> src/dst based on the transfer direction
>=20
> This patch sets DMA transfer size for source/destination based on the DMA
> transfer direction in rz_dmac_config() as the client drivers sets this
> parameters based on DMA transfer direction.
>=20
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
>  drivers/dma/sh/rz-dmac.c | 20 +++++++++++---------
>  1 file changed, 11 insertions(+), 9 deletions(-)
>=20
> diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c index
> ee2872e7d64c..52d82f67d3dd 100644
> --- a/drivers/dma/sh/rz-dmac.c
> +++ b/drivers/dma/sh/rz-dmac.c
> @@ -604,17 +604,19 @@ static int rz_dmac_config(struct dma_chan *chan,
>  	channel->dst_per_address =3D config->dst_addr;
>  	channel->dst_word_size =3D config->dst_addr_width;
>=20
> -	val =3D rz_dmac_ds_to_val_mapping(config->dst_addr_width);
> -	if (val =3D=3D CHCFG_DS_INVALID)
> -		return -EINVAL;
> -
> -	channel->chcfg |=3D CHCFG_FILL_DDS(val);
> +	if (config->direction =3D=3D DMA_DEV_TO_MEM) {
> +		val =3D rz_dmac_ds_to_val_mapping(config->src_addr_width);
> +		if (val =3D=3D CHCFG_DS_INVALID)
> +			return -EINVAL;
>=20
> -	val =3D rz_dmac_ds_to_val_mapping(config->src_addr_width);
> -	if (val =3D=3D CHCFG_DS_INVALID)
> -		return -EINVAL;
> +		channel->chcfg |=3D CHCFG_FILL_SDS(val);
> +	} else {
> +		val =3D rz_dmac_ds_to_val_mapping(config->dst_addr_width);
> +		if (val =3D=3D CHCFG_DS_INVALID)
> +			return -EINVAL;
>=20
> -	channel->chcfg |=3D CHCFG_FILL_SDS(val);
> +		channel->chcfg |=3D CHCFG_FILL_DDS(val);
> +	}
>=20
>  	return 0;
>  }
> --
> 2.17.1

