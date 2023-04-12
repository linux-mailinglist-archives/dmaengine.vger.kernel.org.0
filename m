Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 018B06DEC94
	for <lists+dmaengine@lfdr.de>; Wed, 12 Apr 2023 09:29:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229919AbjDLH35 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 12 Apr 2023 03:29:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbjDLH3u (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 12 Apr 2023 03:29:50 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2109.outbound.protection.outlook.com [40.107.114.109])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 353A0F9;
        Wed, 12 Apr 2023 00:29:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VnZH6zAnOGHt5uvC7oX295RS25d81wOM/8bwN9wYPUMycfw1xEPjQRj4oALUTV7jI+uBfX30at1fyvwwViOqI5othLyMcHiXZbSgngb04d7/Ywb1O4ovK1ZtD4CqcDny2l0tFq2wch+/Oz38InCUfIZVxhxa8puJ3hrwWKClZ3cZ7nA90hJHOy1Suonig5H5+SSKX5egShY86W2iTbOqNE6FopVXpkzfibUaW95LBlpMqw3PH8hjiIfRxIFRdcuZwqpKx123ehn6dwPh8Q9yN7vv8HGHQVeYA9Efb+AjIz52zxHo8t4XPxzCPAGegLmxl0vRUwLP+gvYOfHinttjqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OJnbZg/nLeuEBk+WHcallJdA1dimy7vDjeAoX0+DV20=;
 b=KJ0Dog9xtVPCQLEvnL1J1GsOKf0Z5EKLQ+8s94KOPL3SVEMcpwminH+sC4dlxaiTAi5bW/EVtDsd1D7oitG6TydFdHCsRl3e0yG8lRAHVaj8QjGQfEyrMiQ2MRYtYu+QDxaAeJMvi3p92JAJD0nvlfb1yp5DxZPy5dO3vm2qlD7aukqGyk9+0WGxV4vWWoNjXZxcY0rnmd2pyHS7PwEoaWVpxNf0KMJGA+tTGgXZLqCuony4evrly1by/RSwmPR/rhfbOMfrrsL1GQwwLuuI7Wz5AOk0n1WQpu0I+4T6i8mlngyoCjnVBeU0dyRV/I9xHDr+642gUm25KYBBbH0OBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OJnbZg/nLeuEBk+WHcallJdA1dimy7vDjeAoX0+DV20=;
 b=dkq/s3zl6isHz6AiGb4P+rCszGuqN5tgeMBQP8XBM9KostxsPU50PfdeNWeop6LMJqoIkFMe814cQfxbqZ2I98vPO/tDsxtc8vyjzzJDQMoQa2kD+LmQPz0rpn1AoMIhnGzJXwpd/LjtjSP6rySlJG9dvfHFl/0URq7cy7bVCVU=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TYWPR01MB10601.jpnprd01.prod.outlook.com (2603:1096:400:2fc::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.38; Wed, 12 Apr
 2023 07:29:45 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::e521:994c:bb0e:9bf6]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::e521:994c:bb0e:9bf6%8]) with mapi id 15.20.6298.029; Wed, 12 Apr 2023
 07:29:45 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Biju Das <biju.das.jz@bp.renesas.com>,
        Vinod Koul <vkoul@kernel.org>
CC:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH v2 5/5] dmaengine: sh: rz-dmac:
 rz_dmac_prepare_descs_for_slave_sg() improvements
Thread-Topic: [PATCH v2 5/5] dmaengine: sh: rz-dmac:
 rz_dmac_prepare_descs_for_slave_sg() improvements
Thread-Index: AQHZZ8gvJKxBqbC9BUqVBqWUIKPH8K8nUPFw
Date:   Wed, 12 Apr 2023 07:29:45 +0000
Message-ID: <OS0PR01MB592281D9D6D12978D04EC10C869B9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20230405140842.201883-1-biju.das.jz@bp.renesas.com>
 <20230405140842.201883-6-biju.das.jz@bp.renesas.com>
In-Reply-To: <20230405140842.201883-6-biju.das.jz@bp.renesas.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|TYWPR01MB10601:EE_
x-ms-office365-filtering-correlation-id: c71e2f31-698c-4eb9-5f83-08db3b27b06a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: skF9jn3sbMhuFen6NuFx2BVPSR2Q3GW7xt5bfPnF2tsvfDoCIAwv9oifcbbDZekXHgjK7rJ2biaKNYqRq33z+rJTUSDtuiaLtRESqM7m0YVzgUqESyeOGlpGZ8APBfH1mn5jk9I5QSpikI+wLlt0yaRrjVp0qwKUZqIevvoaLrQVqpE33IGIfLoD9Qdy+lg+ueFTOsFSyNaQbRmtOVkP62yiJScpOMsGmjDnXAHbZVuYvxjpdZ0Ra2Jbf7gVSvje3q0fTyXArqFvPiLTj/vkRo1Usn8KN51J7WHsZajQHnKja/SHq/HRm0vjOIk5U3irh5qb/BvHLxQ4LjE1o1revwtlhUiN/cg4jKZbRiVIh8F8C6EaTmxBStzVnLMczkRjxlAVnpSk7qWPajzc2f/yTw3VJNUOcKUlJH+XHem0suzY+xQmlrxiZE0uVmKiDIXBJ8bEtEdlrKYuUl7d0pa4QXlfnNO9vCrIxE5dGORw301+FhIYWyLWxyHsasjbUglq8ZT19jC0wkUBsQ4tiZrlsl911KsfZo/NdrLXvI8RZLL5n5911VmBh3/IX2mtSu+Ba4PYH3rP0/c1Oceo3u8a0yOD4CXuG9MGBXGv2Dk4fAYiqa6PRh6WmIfKpeM5Pl3y
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(396003)(346002)(376002)(136003)(39860400002)(451199021)(54906003)(41300700001)(76116006)(478600001)(86362001)(316002)(71200400001)(64756008)(8676002)(4326008)(66946007)(66556008)(7696005)(66476007)(110136005)(66446008)(52536014)(8936002)(5660300002)(38070700005)(33656002)(186003)(122000001)(38100700002)(6506007)(9686003)(53546011)(83380400001)(2906002)(55016003)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?fY3ogzM4YPkAP/rxZz8yOFLNXDuTGm8U/7n4Z0Bji/EYEFAAuURtlUfrRLh2?=
 =?us-ascii?Q?S7at/s+Uec94H3YoO1GzOGrEE5JDOoT2xeZHoB+f3buLXwS04typLdHxiZXT?=
 =?us-ascii?Q?PvnsXrAY9GVBGGjJhuUeWmXGWYpca7VJ3fXHs3CAVACVjLKRe+D0qjyj/9s/?=
 =?us-ascii?Q?LGjcrgq4QavUkJeP+6/AxKlG0tqZx8ZGdftSXixqNQXd7J6qhOz5Dhc/Yoi2?=
 =?us-ascii?Q?T9vPi1iakqkoo0fzKjh8MyvCWq3w2RyfjduakGsObw2VR+2P0hj9E6smBToR?=
 =?us-ascii?Q?pk+cTrMhDDPeOLfUk/6jqjgmNVJdPmQRMuMvu2+K9kR9+7/jM9gIx3Pw6CX1?=
 =?us-ascii?Q?lKWYAc/svD5ykmiKz5gS50xE4xGlR4C4HHCQe/ZOBxcQS6cXMxtAuRjxw5SU?=
 =?us-ascii?Q?A6YaUEKEwQU8KvL/MwI9SAlVp3BFTQgeXCenDadE7ZEvL6lDR8fvFDNOn6Zg?=
 =?us-ascii?Q?bcFrlNh9w/DKjkjXqLf5pEN5iLwNTI/48jCg44ukyraYQlFWZb3fGmwxQakf?=
 =?us-ascii?Q?jx0r63S+rIR9B/4o45mF+XvQ3IBRcj8rX8EJOHYyYOHiQNO7fAn79N2wN2Ck?=
 =?us-ascii?Q?PpXvOfD1vzDXCQFrvy/lq0nv3P2Cqsqj/lnlmxl0GiniI8Ce6di3vtKlNSyb?=
 =?us-ascii?Q?hG7VAGHis3+iHvBn+Tjky7eswSsXdBKa07X0sjsPjlt9VhObzJc97vli2TgJ?=
 =?us-ascii?Q?s3cKRMzvJmrisKKNb/ZUFRh535zYgFBzpJr7Q4gt4pbTeTdJO+AjNeUC0NHX?=
 =?us-ascii?Q?K5XXiIsxforOnYAU51978/oE3xfLOF7MjeQe/LsyGadpm+qBPLi1oxxoJgBB?=
 =?us-ascii?Q?75in+FBjMawhwM5ekOobP1P76mpmXyF187G2TR6SwYetKxYEdYmD/oOHB5vP?=
 =?us-ascii?Q?hsrUI9JRwFkbOjRs03eY2P1DQBZ+vYz9duTL0AW4N+cFRhXfgCsOK+MbVMet?=
 =?us-ascii?Q?h8aVfzXcf/o0ZPFTzTAuWuGfLGdmJGtt19xaxZjZpC1D6Z1KgxkFU/we4sCs?=
 =?us-ascii?Q?iHunWMob+CLEsoauk5UmBZApmcno5uunuE/X/qeBvB+0HFTfgdfwJJ1RKRO0?=
 =?us-ascii?Q?RItA0TLLrKH1BeOc8hrIN3IrUdgpOst3Og+aouRyrPRCVFGIQGE7aXOieJNl?=
 =?us-ascii?Q?CKTwi1J/fZ859qSiGVcU80Eto1/g8PMjAEd147YRSkNg6QePeyZx2K48BAiL?=
 =?us-ascii?Q?ZsczMsjy/6x1oec0syTcj3dHdFjAr77vakwqVjMMClWTM2i3Q4z9Z8cQKP/D?=
 =?us-ascii?Q?Qo8VAzexN5VxPfvRzuOzCmeVEBLiJQR3or0YW600uU+tDGrUL767NhLnitJV?=
 =?us-ascii?Q?ho5w6fxJSZUrp/wCOETNEdUYfOmECZ9ylppNMS647zXnRHuRBPHrAfCv+0Db?=
 =?us-ascii?Q?pBHB053+MmZcA758V9Q2nIMYK4XlRYdQz27+o6llOPU2kLJ89izdZ0YfVcOI?=
 =?us-ascii?Q?A+cy0Rwp6SG4TmS6m/v8Tw7LNTdxBnfcaQFy8ge8ZOe16+ZctikpXBBoxfEY?=
 =?us-ascii?Q?QFLwa0IW5LztzyF5rzge8VdQHuFpGHnb8+vrW9e4pa/f/QSTJKZX3yzOkvgL?=
 =?us-ascii?Q?I9WwJcvt3jaCZqoh707Z3e94hYvm5sdlQeA4X3ah?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c71e2f31-698c-4eb9-5f83-08db3b27b06a
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2023 07:29:45.2458
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JRhuQRyGLZLLMUI3iwonC800VINTQW2a0NCw07t9Xr+oO4DmiQ+AioCDH0hyBn7F3a7hW2dH5yooTJEhGL+ZH76PyfFWyXcjSJ6rbiqsWcM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB10601
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



> -----Original Message-----
> From: Biju Das <biju.das.jz@bp.renesas.com>
> Sent: Wednesday, April 5, 2023 3:09 PM
> To: Vinod Koul <vkoul@kernel.org>
> Cc: Biju Das <biju.das.jz@bp.renesas.com>; Geert Uytterhoeven
> <geert+renesas@glider.be>; Prabhakar Mahadev Lad <prabhakar.mahadev-
> lad.rj@bp.renesas.com>; dmaengine@vger.kernel.org; linux-renesas-
> soc@vger.kernel.org
> Subject: [PATCH v2 5/5] dmaengine: sh: rz-dmac:
> rz_dmac_prepare_descs_for_slave_sg() improvements
>=20
> Some code improvements for rz_dmac_prepare_descs_for_slave_sg().
>=20
> Replace the loop for->for_each_sg and drop the variables sgl and sg_len.
> Also improve the logic for assigning lmdesc->chcfg and lmdesc->header and
> lastly, add lmdesc assignment along with the declaration.
>=20
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> ---
> v2:
>  * New patch.
> ---
>  drivers/dma/sh/rz-dmac.c | 22 +++++++++-------------
>  1 file changed, 9 insertions(+), 13 deletions(-)
>=20
> diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c index
> 153893045932..c6150d7ae8a7 100644
> --- a/drivers/dma/sh/rz-dmac.c
> +++ b/drivers/dma/sh/rz-dmac.c
> @@ -342,12 +342,12 @@ static void rz_dmac_prepare_desc_for_memcpy(struct
> rz_dmac_chan *channel)
>=20
>  static void rz_dmac_prepare_descs_for_slave_sg(struct rz_dmac_chan
> *channel)  {
> +	struct rz_lmdesc *lmdesc =3D channel->lmdesc.tail;
>  	struct dma_chan *chan =3D &channel->vc.chan;
>  	struct rz_dmac *dmac =3D to_rz_dmac(chan->device);
>  	struct rz_dmac_desc *d =3D channel->desc;
> -	struct scatterlist *sg, *sgl =3D d->sg;
> -	struct rz_lmdesc *lmdesc;
> -	unsigned int i, sg_len =3D d->sgcount;
> +	struct scatterlist *sg;
> +	unsigned int i;
>=20
>  	channel->chcfg |=3D CHCFG_SEL(channel->index) | CHCFG_DEM | CHCFG_DMS;
>=20
> @@ -358,9 +358,7 @@ static void rz_dmac_prepare_descs_for_slave_sg(struct
> rz_dmac_chan *channel)
>  		channel->chcfg |=3D CHCFG_DAD | CHCFG_REQD;
>  	}
>=20
> -	lmdesc =3D channel->lmdesc.tail;
> -
> -	for (i =3D 0, sg =3D sgl; i < sg_len; i++, sg =3D sg_next(sg)) {
> +	for_each_sg(d->sg, sg, d->sgcount, i) {
>  		if (d->direction =3D=3D DMA_DEV_TO_MEM) {
>  			lmdesc->sa =3D channel->src_per_address;
>  			lmdesc->da =3D sg_dma_address(sg);
> @@ -372,13 +370,11 @@ static void rz_dmac_prepare_descs_for_slave_sg(stru=
ct
> rz_dmac_chan *channel)
>  		lmdesc->tb =3D sg_dma_len(sg);
>  		lmdesc->chitvl =3D 0;
>  		lmdesc->chext =3D 0;
> -		if (i =3D=3D (sg_len - 1)) {
> -			lmdesc->chcfg =3D (channel->chcfg & ~CHCFG_DEM);
> -			lmdesc->header =3D HEADER_LV;
> -		} else {
> -			lmdesc->chcfg =3D channel->chcfg;
> -			lmdesc->header =3D HEADER_LV;
> -		}
> +		lmdesc->chcfg =3D channel->chcfg;
> +		lmdesc->header =3D HEADER_LV;
> +		if (i =3D=3D (d->sgcount - 1))
> +			lmdesc->chcfg &=3D ~CHCFG_DEM;

To match with previous code flow,

lmdesc->header =3D HEADER_LV; should be after lmdesc->chcfg &=3D ~CHCFG_DEM=
;

I will change this in next version.

Cheers,
Biju




> +
>  		if (++lmdesc >=3D (channel->lmdesc.base + DMAC_NR_LMDESC))
>  			lmdesc =3D channel->lmdesc.base;
>  	}
> --
> 2.25.1

