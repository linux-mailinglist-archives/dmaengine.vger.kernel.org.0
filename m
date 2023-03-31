Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97D8A6D243A
	for <lists+dmaengine@lfdr.de>; Fri, 31 Mar 2023 17:42:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233125AbjCaPmy (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 31 Mar 2023 11:42:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjCaPmx (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 31 Mar 2023 11:42:53 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2108.outbound.protection.outlook.com [40.107.114.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C626C10E4;
        Fri, 31 Mar 2023 08:42:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ob8TnYLsqe4D1wNAaSD1aPA5yT53UPKHyHxA0LvvlgST/Zg/tEyvAajbpmZVNUljIQpsz7VsJWqzusKBn/v2m/nZLJu1nPmFpSmzcKI1/WK47sRiZ/f0P4rBnhVdqcSqxfl1i3nw25YlHjxOLFse7rB82qfU1/CHNQeHiYirmP/SF6nxiAmaZfBAmsVTczTUBjmJH1cHfDq/8dslr9pYUa4kRRgCE2Vz6TXd6ZC9JRU14OqflJtsCahsm6c3Fh+OvtJHjfhG10iiJ7mDjSVk1hn0pMypP7GhXQi5ubVyveicO0a/2fV/7iohN65gr+uHcq1C5//riD9y1aDfT41roA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UkNNBPYMrA2WqLdjfvAHOXPHdlab/AXKAHppciyEBAQ=;
 b=OG0MqUTv1KFeNA2jdUGeknwbXdqAKkwICzJ/oT00KpLf9IoLOgHwMOSGciZj4OnsDACxRSyRdPdGVzuNZxcsWSKIiYBx5QsgHDEhAr1T8zhJucArelYsABHUL5iLA6ezZ/bSjy1U+QBJdULhfUYhu4+OImimJvrENXQ4jLmchSA9My9Atj0Q26hd2ZRIOh/aYeMsY6o446XGvZyc1Z7UD7hZMlBfbIlsYqmyeh0oqbql+c1M/bax7gkZeBRoPOEapvSjf3dkJP4wxzlFbr02TGvhAGSQcLOONyXh55gT03Dpx+vAfj9ON2d2mRCqK+C9itliQkKM9RhBInzEFAZ1ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UkNNBPYMrA2WqLdjfvAHOXPHdlab/AXKAHppciyEBAQ=;
 b=XHF29S084ghtVivpeTfSVrb5aXwJmaZ4GWo68thcoUPQXsfmo6S8yIynaOID+mkq77E0sVGBcjT42OwZkKi32KtAdlleG7kIjWI4SejHM/zZ3f0uc89he90KJd1f68V8ukgB2scYp8OE+shtOJwlLq8GAYvlMb7+hE7AwQFYGJk=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by OS3PR01MB5749.jpnprd01.prod.outlook.com (2603:1096:604:c2::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.24; Fri, 31 Mar
 2023 15:42:48 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::e521:994c:bb0e:9bf6]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::e521:994c:bb0e:9bf6%8]) with mapi id 15.20.6254.024; Fri, 31 Mar 2023
 15:42:47 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Vinod Koul <vkoul@kernel.org>
CC:     Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH 3/3] dmaengine: sh: rz-dmac: Add device_pause() callback
Thread-Topic: [PATCH 3/3] dmaengine: sh: rz-dmac: Add device_pause() callback
Thread-Index: AQHZXjYGGmC+ZE9cbk6WpoaUBoyLB68U2ToAgAA0sKA=
Date:   Fri, 31 Mar 2023 15:42:47 +0000
Message-ID: <OS0PR01MB59228D6D501A1CDA259E54A1868F9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20230324094957.115071-1-biju.das.jz@bp.renesas.com>
 <20230324094957.115071-4-biju.das.jz@bp.renesas.com>
 <ZCbPdEyAcvRUwyLz@matsya>
In-Reply-To: <ZCbPdEyAcvRUwyLz@matsya>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|OS3PR01MB5749:EE_
x-ms-office365-filtering-correlation-id: 43966a3b-d2dd-4b1c-a566-08db31fe9413
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8Tmj6vL9Dgt+4lGv6RUIoCtUppr1WJEY5BaOUN/qZ845MAj/OpQ2jjtJkSeUi0HplzFd0Q0We+fTjgmX+ktRqfh3JzpGIjuwlo4MOi5hp6XJiXXchrwPIHdAqJ2ZCOyApAg2zoKe9vIxHOX1BaScfYOl/xthOt4lJPWxqkba4BNYwEnD8bAUj/qH5uNJEJK9aPqAMYUp6nCrq5+nKcuOMdNzxkBHt18BPrtqUvvYi+UBvJ/yRgQSWP2S7VyCAUGUztGqFgpZw7rcFVpoX1k/D6PxdkaoJ31f1wTQz3UB3SsHouhSnBZ/OHtMR3F25o8vLSOBRzukJfvSW6y1T50uXoiihb/Wjp95u+2WPjynIntaVh6c1wZEfwSxyaZsMksDOzKIPmxdimTh86REwY58SB+u40YK3N8IsRdScS71dPIPrVOjqNnsfn8Dh7NEvHU+btjm8Qnx1D/Lkco/V1rYr2aOVAtyR9B90WqbWCvt5a8Z6Ui/UhtrnScWvXLyaYyBtQaZ2uJZT7pDDON4up+y8BGuIVZux607jKO01jO7S65ECxQl2ImmxNaJwWENrN6RVFlAS1n3iAanmYssdo24lM32j3bmJG9GU9QQs+bwL5rzVgreF5QpI9N5oQ75O2wt
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(346002)(39860400002)(136003)(366004)(451199021)(54906003)(316002)(26005)(478600001)(53546011)(9686003)(6506007)(66946007)(8676002)(76116006)(186003)(4326008)(6916009)(71200400001)(7696005)(66476007)(66556008)(64756008)(66446008)(5660300002)(41300700001)(8936002)(122000001)(38100700002)(2906002)(52536014)(38070700005)(55016003)(33656002)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Z/GcphypHCMgHkudwZXotaapwrocAgCjSGmvbTGblbNpTWirVgyEz+UgQsq6?=
 =?us-ascii?Q?rUdZAkzRHManoBRgwl1KdMJFgSnLn56lFk+zm4YJPV2ZnZxV5Qsoz8hjObIn?=
 =?us-ascii?Q?y5gJFkPwCPcosN7JEgTQopU74hhjldtCfKXvTlVMRToV6Gn7smD1v+Gn8BnE?=
 =?us-ascii?Q?lA0YmFf+EEHDtKF1OS8crOadsidjEk80CVzBIPfY0UAW61JtWRs8uU7EbQa/?=
 =?us-ascii?Q?z81ScC0aoR3i5SHXYXpSdjH+++w7t/d2Xx8nDTNYfeGMXlye23GDJwmUEICG?=
 =?us-ascii?Q?m84Czwi1RUxRLlg32X6+lrjZxAKtcmZv4QYvCMgvRVKPg5KF43bHsKGcp3DV?=
 =?us-ascii?Q?3+xodITVJUm7McuAbZrij3pKVAjKAsbF4dGbPym/T0EoszL8llqPlK3fxpfI?=
 =?us-ascii?Q?VGbAWQ22HIcsRtMjlpvnCJ4kpK1FkYWeQQNXnfi55Q0GxDdB6cM0Ev1YwvWl?=
 =?us-ascii?Q?2sFOhEgaFAeS7CsK2GrYVp2fryrB4i8Y6VK470hJmxdqTkAQED0jVRi/LCvu?=
 =?us-ascii?Q?HiOLs3aH3ExlDrCkixAOQdszG1PRf4kCieyuHDNOkrdqukqBero2VIzN/Uno?=
 =?us-ascii?Q?NFft55H82iha/HpRY5s58KsqX/MEFfV1G4J6Fk9IG+pQlGoNkIXXXwFYTXho?=
 =?us-ascii?Q?IwoSRuwlnbdy2RLHsTCUsXdaHUVlL93ofM5+OZhTiLhYOIl/6+LlK/nPB2/a?=
 =?us-ascii?Q?JiqHYLBBKWw5Cyy3KJGlC6w/JxvxGJ1M8GFuJxTZ1DtbIzi8o0LmagxD3yEK?=
 =?us-ascii?Q?x7IkcIgmaWAAZZq1iJ+8cdA43xbg59NBHOdYB0r6S5HMdE1pQX8uOjgVV7WC?=
 =?us-ascii?Q?v1AXnLRiuPbSL3PgCfxXNiO/KLtxHpZeh096RQ3g/6OOZ07fp9JYdw4nECJ6?=
 =?us-ascii?Q?8xOMibY/suvJXeIu2r41mT9EMHcWhUg/jZIxB71jryRDJR6mzCndMvZPmzKX?=
 =?us-ascii?Q?wCjaJAQFZXXiky0at3truqM2uYd85C7oZ/xRUjM4kcMOTcaIZpB33b26XqYR?=
 =?us-ascii?Q?7L3KPFR+KIgdGWy/Z/6ETmyGDsANx8UUx1j1rL8HDiG0xQ7JfRN8iUx4uCfG?=
 =?us-ascii?Q?ed6vO+XujTH4hXQPzJN7pe8c89FVMRBtiuFiEnKD631fm+ODVMs/AFTbf+G5?=
 =?us-ascii?Q?5REjffbHOqwyjLw+kC4BJi6tOouiTYfEaxHx8vGkRW/Tnajiq2DnxpWiRPwO?=
 =?us-ascii?Q?rFJ7zNuXUDqxyw4S/kvR9vk+Vv9cOvwa87XgvHfjY5AF+IPmqW45jVfyN2/I?=
 =?us-ascii?Q?ClO4SterK4oqoWsrU1UknTCGNuprSx3vOAmFVtIKKr1RSfywQTr5vcv5hgjA?=
 =?us-ascii?Q?YY4WWI4uPCftJ6ooAgr10THhNomEjP0tRh1CrbDBYfyg6SnVe6G1mldGsPjM?=
 =?us-ascii?Q?nZU7yCy65GW4pu564szoeqTfq5PJB8q2xgBcnAJAvOc5TvZmjvIYjK9o32BL?=
 =?us-ascii?Q?ESKmp7FiGqnbFFxdDyUgDTCoUt5GSvDutVABgFjQ0uxWhO7SjmRqF9mZ2d9A?=
 =?us-ascii?Q?eDo4UgHCUed+tT9qV3H8H8XOSGv2EmHJXg+uvbRql8As0iwSxREsOtBIO5nG?=
 =?us-ascii?Q?vgyBVRwMETbDIX7uyMe3/30wqJZlyNOLT+qdQu7B9qcz/1dKMWC2Up0yaNYD?=
 =?us-ascii?Q?0g=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43966a3b-d2dd-4b1c-a566-08db31fe9413
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Mar 2023 15:42:47.8530
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cz/dcdw3f/jC0oOiMdiSr7OctPxoZNxe6chJ+82O4aZ0HW9Sff1wmlhmOV3PDlIZr2B9KQfl+olGbCfoSM/xrDJmx6drYJiUIgSg1xlbXG4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB5749
X-Spam-Status: No, score=-0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Vinod,

Thanks for the feedback.

> Subject: Re: [PATCH 3/3] dmaengine: sh: rz-dmac: Add device_pause() callb=
ack
>=20
> On 24-03-23, 09:49, Biju Das wrote:
> > The device_pause() callback is needed for serial DMA (RZ/G2L SCIFA).
> > Add support for device_pause() callback.
> >
> > Based on a patch in the BSP by Long Luu <long.luu.ur@renesas.com>
> >
> > Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> > ---
> >  drivers/dma/sh/rz-dmac.c | 20 ++++++++++++++++++++
> >  1 file changed, 20 insertions(+)
> >
> > diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c index
> > 3625925d9f9f..a0cfb8f75534 100644
> > --- a/drivers/dma/sh/rz-dmac.c
> > +++ b/drivers/dma/sh/rz-dmac.c
> > @@ -822,6 +822,25 @@ static enum dma_status rz_dmac_tx_status(struct
> dma_chan *chan,
> >  	return status;
> >  }
> >
> > +static int rz_dmac_device_pause(struct dma_chan *chan) {
> > +	struct rz_dmac_chan *channel =3D to_rz_dmac_chan(chan);
> > +	struct rz_dmac *dmac =3D to_rz_dmac(chan->device);
> > +	unsigned int i;
> > +	u32 chstat;
> > +
> > +	for (i =3D 0; i < 1024; i++) {
> > +		chstat =3D rz_dmac_ch_readl(channel, CHSTAT, 1);
> > +		if (!(chstat & CHSTAT_EN))
> > +			break;
> > +		udelay(1);
> > +	}
> > +
> > +	rz_dmac_set_dmars_register(dmac, channel->index, 0);
> > +
> > +	return 0;
> > +}
> > +
> >  /*
> >   * -------------------------------------------------------------------=
---
> -------
> >   * IRQ handling
> > @@ -1111,6 +1130,7 @@ static int rz_dmac_probe(struct platform_device
> *pdev)
> >  	engine->device_terminate_all =3D rz_dmac_terminate_all;
> >  	engine->device_issue_pending =3D rz_dmac_issue_pending;
> >  	engine->device_synchronize =3D rz_dmac_device_synchronize;
> > +	engine->device_pause =3D rz_dmac_device_pause;
>=20
> No resume?

OK, will add resume.

+static int rz_dmac_device_resume(struct dma_chan *chan)
+{
+	struct rz_dmac_chan *channel =3D to_rz_dmac_chan(chan);
+	struct rz_dmac *dmac =3D to_rz_dmac(chan->device);
+
+	rz_dmac_set_dmars_register(dmac, channel->index, channel->mid_rid);
+
+	return 0;
+}

Cheers,
Biju

>=20
> >
> >  	engine->copy_align =3D DMAENGINE_ALIGN_1_BYTE;
> >  	dma_set_max_seg_size(engine->dev, U32_MAX);
> > --
> > 2.25.1
>=20
> --
> ~Vinod
