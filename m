Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A5276D77EE
	for <lists+dmaengine@lfdr.de>; Wed,  5 Apr 2023 11:23:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231873AbjDEJXT (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 5 Apr 2023 05:23:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230031AbjDEJXS (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 5 Apr 2023 05:23:18 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2090.outbound.protection.outlook.com [40.107.113.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A59A54200;
        Wed,  5 Apr 2023 02:23:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N90+gho74atyo6hutegH9GecOvT+9ez6mmuQGkxYRZKOgmBfAcN2exql/kOk4aZQo7DASmZq4f9BQiJsAEPYDw7TIq1fLfG4m0InnxGJIqBO7+vdps47lgG4Ka//IKAM7VXf+BDnIVQMltcQZ26jhtiw9CjrE4CHnxG+T8OxQMBsk/QQeJ5vdWxcmyC6XDh+GbQHVMBHGuUEk8WeSm2PmMlkYAG1bHlmsZ0rG5Htq6QKxBb8/ejv+mq9jT2NR4N0zHr35lVGCz071aUqCPArmp8ev/ycA8PDANW5ka3RaEPKHtCCT7fKW4Wy4548xVs3Aq/djdAApWngyDZ838SYhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HaI8gnQtXa074Xz8WsSNTvAnroS2fhg1R4Mu0kQHK5s=;
 b=oG5xKZB5cslEYdDcPz0tud4Ghw7aLaVKrZcRNiM0ZCAO8K6p2xly3/5zfc+NKYm7wnFaKRHdHKGdWjEId6KlTW9nUnTzrJJvL92CO/X19fL8dHRhpLI1ncqspnAyZEQmMGBfoYdBw605Ult6drPGXC1ViP5cTBPuMUHGGmbtSD07ZAyJvADw0Yr+rtActKgOlYi0MuEcYUwSH6apKvSRLNjO0E9dKL436zzs7vadhL9ES756DDA3rzc/V6Nnw8WdKIk5fVvNhlBWGjY5NwOC7/HCrwge6/etLapE5dB7sLEQwjgVjAhPSUFqESv3yBHRcLcUNv98hxnx2vXE4jADwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HaI8gnQtXa074Xz8WsSNTvAnroS2fhg1R4Mu0kQHK5s=;
 b=VJGXwR14Rxa+CayNr+iSVZ4EmUtSMG3PahTmVldTIeFdyO0UYT3qS8rgZBGPhcVqvHJvBQw6D3OGh0EO3K++BSiBLDVPyGkqCBVzimM0hiLdT4Jv8X+66sGMvvy5KBk1ajXYJZNOYAu13AfUMgf7h3vdZYS7ic+OdWNMMBZnZWs=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TYCPR01MB10974.jpnprd01.prod.outlook.com (2603:1096:400:3a5::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.35; Wed, 5 Apr
 2023 09:23:12 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::e521:994c:bb0e:9bf6]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::e521:994c:bb0e:9bf6%8]) with mapi id 15.20.6254.035; Wed, 5 Apr 2023
 09:23:12 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Vinod Koul <vkoul@kernel.org>
CC:     Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH 1/3] dmaengine: sh: rz-dmac: Reinitialize lmdescriptor
 head
Thread-Topic: [PATCH 1/3] dmaengine: sh: rz-dmac: Reinitialize lmdescriptor
 head
Thread-Index: AQHZXjYDRJNb+Bi3cUaVVV+lnaSf6a8U2FcAgAASfjCAB5ZPQA==
Date:   Wed, 5 Apr 2023 09:23:11 +0000
Message-ID: <OS0PR01MB5922FC2764D3FBB55483B54086909@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20230324094957.115071-1-biju.das.jz@bp.renesas.com>
 <20230324094957.115071-2-biju.das.jz@bp.renesas.com>
 <ZCbOtrbTUlxGVWHd@matsya>
 <OS0PR01MB5922320042416294F810828C868F9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
In-Reply-To: <OS0PR01MB5922320042416294F810828C868F9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|TYCPR01MB10974:EE_
x-ms-office365-filtering-correlation-id: 2ac07a43-6548-4307-133c-08db35b760a5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rghbmRV7vP1SucBuyPWeRXouPEKHlpZUpwWnouLkUUL2s52BhhwrdfTV8Y2gFDCziQY8MkavdBPNNqyF2YXSPjIrtQGKX59r+8FeOm7jfdTK2BR1SdYcXl6hcUZv8uXmio4aqy2bEYAK4bQPHjHntKbp4oKgRnaBjqRTfTpjy3D4gP9qwczmslmJOfezktzUfqcQUcJbvMD05/sbTujwbsUcLU+N3zSDCoIVAA7rUFlk3HtbZAU+iIwJapobXL0D9WDEQeFSTtjKuVJzRhT+/NvjTRuXvkmrGD9hMAaP1ZZtXkjKBMe4/WooTSRuqMuaGYZ5bdFlUWg5GjDG1ATQgXcCiLEGER/PjXAnywpMPZy7nflypf612qPyEsE4UHSjL6GWHMgLotZE3ATaLx7uCdcUAtZ6ZJ7e4yxH8ZvuYDuBOMKtIowIFNWEQLS3jKUjNy4HhQJaji+MT5eL7OVrW7oKj8mQmlY0tafUGVzGgRCZI7Nu4Mbt7NksceRZDa+xAxruLULeP+X1CTQXojuL8zenfUSzOQUoq7JpSeOsWW36KlY2ZZjHn+iAAGUFPhR+5xyVSL+UkLhmhR6MGizojqmlRgAq00QXwotEh/59iN0PIMPAmnCt1D55jD7Nzl0y
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(366004)(39860400002)(376002)(396003)(451199021)(26005)(6506007)(9686003)(53546011)(66946007)(83380400001)(122000001)(66556008)(38100700002)(66446008)(41300700001)(7696005)(71200400001)(186003)(316002)(66476007)(54906003)(478600001)(2906002)(86362001)(33656002)(55016003)(76116006)(64756008)(6916009)(4326008)(8676002)(38070700005)(5660300002)(52536014)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?3kkBrDPr9BMcIjpVuUzLe2UBhPTy/zpgQk6yGUTX9MChAzMxVsOrB5baQ+Q9?=
 =?us-ascii?Q?46jcCpJOjs+NxxUc/IeT+L/z/oDMxLP9SdH9A+GrCuTATkUdMuxa3Y+Yrp3B?=
 =?us-ascii?Q?TBF61hRwE85c+9LJ5CYX+PLQdR9KZlx2OdB3BWVMZPhBGoN2csscMQVqoCIV?=
 =?us-ascii?Q?xrloRmr+mZHcJdHlFqH3w5hYle71Q70wYmEjHdrgCpF2PuXmmtbgOi8HihCp?=
 =?us-ascii?Q?riK/xNMJFYKkKiwjziQhHTVO0DsFnKbZl9/+bVgJkXIwx1Y4y2nwzbA6ZX4C?=
 =?us-ascii?Q?DkUKcOlWjTHPUMaHxtbW7A+793NPMk+WW2Ge9XjVKMKDW44tAeG9hUn9ULYR?=
 =?us-ascii?Q?SJJIZFldGCbsMQYtyCMpbVW80crq0+XKsQWsa3GIfdhtqJW/q4QHfVs1bsU4?=
 =?us-ascii?Q?eWei3umah0C0Q6cIQHGApDBbj61gD1HhJKtXphcopMURdR4dS3sj4/uVRtsP?=
 =?us-ascii?Q?CSBxu9j8UsCVYGpX/Bw8ZwcZJL0qYflDSAVS0Iz7ereq2+5OWsTnwTaqRaFN?=
 =?us-ascii?Q?ZLvf70OkFVObfcQcAPSnMxz8mfWOtHC15Ij829M1rPl1R11SUufj88yS+GTi?=
 =?us-ascii?Q?n2PPhSIBK51x3u6dPaTco0xS2RYfdDRuVAo84gW2su/lzAV+1Gj+ezftP4d9?=
 =?us-ascii?Q?o/MtkmTs0XpbBckbnOhe4S1M1dQWR3+z5TRcLorQ9VKeuZum1PvUhy01Myqp?=
 =?us-ascii?Q?TEFUQi+govdM/9WlJdmnk3l9yKBvEXdDn5Z2eZbqgQxrJOKs7g5/hVGdNsx7?=
 =?us-ascii?Q?2MpoyWMV+kLHAjf3wIEYLoZ1t9ntdUslapk/rIBmmYyA+4DDkWs+ru9Sb2/D?=
 =?us-ascii?Q?ll/ReBSum7ulyebVTYYV+qhTluhY0dNYl8CQjsduZceetW7XUdFZiCMPYTpy?=
 =?us-ascii?Q?kW/BYe86m0sxCvW6VlIsIdpNnzrLPZ5u6aA0s0RgIiU+/KH9oaAiMwRCzIwh?=
 =?us-ascii?Q?ThwzOWKkHLW1/UhmWo8wer2tNhbcT8E6Cb/cnbsjl6dn6yI9EB+NSPox4P0S?=
 =?us-ascii?Q?CpLLOHMPNy80LfmUxrns/r9JUIzqwxXfkj4o7pJExBoOWi5ub1NfAcVMWtTy?=
 =?us-ascii?Q?eS/jX+9IggTTQnPncrGK71vWD9y1z/h37MGAUaj3PL2NiSB8CC3ds+wywDo5?=
 =?us-ascii?Q?Je81VTA7XGVmY5i1N3VyIgUE5cBKYhHEWciBis4w2ObllmPzTd88a5YBWH4W?=
 =?us-ascii?Q?qYCuE6aXHl2nT8mdr+iqtwQ8al+Py6OfI7oCmVBfKa8Mt3KgbOOlx1+a3hbF?=
 =?us-ascii?Q?IAust2+rWdw8DmiRKOPUmWP+08ZyTDo76ksqrBanFFtooEP7i56KXq7+IUzo?=
 =?us-ascii?Q?8DHaTCmH42QPBT2wasGkeNApcYSR+32JTTrXJ+ZK8ThFnLE9/0/8wOQODjBE?=
 =?us-ascii?Q?T8kBS321fEVU6T/SQWxGxJZ3PT/BFQcUo8vahKYzPGxbcswqVxpOc0myzDGp?=
 =?us-ascii?Q?a35Wu8obh6Nl09dofIhC1jForgKnkbuRkkW+CkZcuFG4D8r/UJo/r5+x76Lu?=
 =?us-ascii?Q?mRu2W02ENxCmuMZosLkB76aKKsikqzfRWcdGOWvUgmBZUfoH16qAeBIhF3Kc?=
 =?us-ascii?Q?DkZ6rvY1D86BbJmXtrrR1yxxN9TLpgwf15gWPR2P?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ac07a43-6548-4307-133c-08db35b760a5
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Apr 2023 09:23:11.9288
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: i2r+kxcytTsNluIQs/XOUZWX3AB35e9dqV8CGOgfsJFTCAPq3wdUPn0dGUkqhSQnrbHN1lQQ+mWr7/ggEZMLSzg0UqYJFoQgDVGkaMhm3vM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB10974
X-Spam-Status: No, score=-0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Vinod,

> Subject: RE: [PATCH 1/3] dmaengine: sh: rz-dmac: Reinitialize lmdescripto=
r
> head
>=20
> Hi Vinod,
>=20
> Thanks for the feedback.
>=20
> > -----Original Message-----
> > From: Vinod Koul <vkoul@kernel.org>
> > Sent: Friday, March 31, 2023 1:15 PM
> > To: Biju Das <biju.das.jz@bp.renesas.com>
> > Cc: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>;
> > Geert Uytterhoeven <geert+renesas@glider.be>;
> > dmaengine@vger.kernel.org; linux- renesas-soc@vger.kernel.org
> > Subject: Re: [PATCH 1/3] dmaengine: sh: rz-dmac: Reinitialize
> > lmdescriptor head
> >
> > On 24-03-23, 09:49, Biju Das wrote:
> > > Reinitialize link mode descriptor head during terminate_all().
> > > It fixes the incorrect serial messages during serial transfer when
> > > DMA is enabled.
> > >
> > > Based on a patch in the BSP by Long Luu <long.luu.ur@renesas.com>
> > >
> > > Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> > > ---
> > >  drivers/dma/sh/rz-dmac.c | 7 +++++++
> > >  1 file changed, 7 insertions(+)
> > >
> > > diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
> > > index 6b62e01ba658..a04a37ce03fd 100644
> > > --- a/drivers/dma/sh/rz-dmac.c
> > > +++ b/drivers/dma/sh/rz-dmac.c
> > > @@ -534,11 +534,18 @@ rz_dmac_prep_slave_sg(struct dma_chan *chan,
> > > struct scatterlist *sgl,  static int rz_dmac_terminate_all(struct
> > > dma_chan *chan)  {
> > >  	struct rz_dmac_chan *channel =3D to_rz_dmac_chan(chan);
> > > +	struct rz_lmdesc *lmdesc =3D channel->lmdesc.base;
> > >  	unsigned long flags;
> > > +	unsigned int i;
> > > +
> > >  	LIST_HEAD(head);
> > >
> > >  	rz_dmac_disable_hw(channel);
> > >  	spin_lock_irqsave(&channel->vc.lock, flags);
> > > +
> > > +	for (i =3D 0; i < DMAC_NR_LMDESC; i++)
> > > +		lmdesc[i].header =3D 0;
> >

I will send an improved version for invalidating lmdesc.=20

Add helper function rz_dmac_invalidate_lmdesc() and share the code between
rz_dmac_free_chan_resources and rz_dmac_terminate_all(),so that hardware
descriptors can be reused in rz_dmac_lmdesc_recycle().

+static void rz_dmac_invalidate_lmdesc(struct rz_dmac_chan *channel)
+{
+	struct rz_lmdesc *lmdesc =3D channel->lmdesc.base;
+
+	for (; lmdesc < channel->lmdesc.base + DMAC_NR_LMDESC; lmdesc++) {
+		if (lmdesc->header)
+			lmdesc->header =3D 0;
+	}
+}
+

static void rz_dmac_lmdesc_recycle(struct rz_dmac_chan *channel)
 {
 	struct rz_lmdesc *lmdesc =3D channel->lmdesc.head;
@@ -437,16 +447,11 @@ static void rz_dmac_free_chan_resources(struct dma_ch=
an *chan)
 {
 	struct rz_dmac_chan *channel =3D to_rz_dmac_chan(chan);
 	struct rz_dmac *dmac =3D to_rz_dmac(chan->device);
-	struct rz_lmdesc *lmdesc =3D channel->lmdesc.base;
 	struct rz_dmac_desc *desc, *_desc;
 	unsigned long flags;
-	unsigned int i;
=20
 	spin_lock_irqsave(&channel->vc.lock, flags);
-
-	for (i =3D 0; i < DMAC_NR_LMDESC; i++)
-		lmdesc[i].header =3D 0;
-
+	rz_dmac_invalidate_lmdesc(channel);
 	rz_dmac_disable_hw(channel);
 	list_splice_tail_init(&channel->ld_active, &channel->ld_free);
 	list_splice_tail_init(&channel->ld_queue, &channel->ld_free);
@@ -537,6 +542,7 @@ static int rz_dmac_terminate_all(struct dma_chan *chan)
=20
 	rz_dmac_disable_hw(channel);
 	spin_lock_irqsave(&channel->vc.lock, flags);
+	rz_dmac_invalidate_lmdesc(channel);
