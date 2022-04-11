Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 735C54FBA8E
	for <lists+dmaengine@lfdr.de>; Mon, 11 Apr 2022 13:11:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243531AbiDKLNf (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 11 Apr 2022 07:13:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344622AbiDKLKq (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 11 Apr 2022 07:10:46 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2133.outbound.protection.outlook.com [40.107.114.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEBE94552D;
        Mon, 11 Apr 2022 04:07:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=js6F4+5RxTVdtJ2CrNCbgucGn4RYtKgpMdT8XqaTfGLsRXqyXWgKG55cxQWV/f5nDww9t9fi6xNvZulgCNMOt0SisEfXcBLvVX9ttOyMUQa7Jcmpo2gSB37HZouEzjqDRzSBkI/Gu29l7nTPrWT8pKbEwg6flJOLyDkjhqSR99iTMJR+xSgGWEnBv6ZOSW6o/dA5YvZu8bq37Wdp9wB5SEA2TRTxSg/g0doZ7iMmouXu3OrGZ6wmmA8OQbsVwbjeF3p11xUTVgfPGBUY9IO7oEpa+65CXnuog7CJRUMnttE603TwhcNV3HgkT1ka9GxQ2MxqS3SHu+n11D1XfY1PHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/2fGCicUdsGpA4W6JyekSIC2T/MJbjzIp8Q4pAEZBdg=;
 b=ShTRhwvpE5vbbWuT/WeoJuVlAhr2lTE5WaVX3xmUMVZSD45Pl8EJ5+0tdrDGCLK3DK0LyYaBjZRpRKtyhj4XrJIwu3L6UHE0GkVotAbnH/EnXxgR/ZiHOSOXFCrgGPRzGTSNmG+VOaUn3ed8HiBjgUDHBRes+s2mngwkKAKuZE7zxOs26JtfNTWym2h7gwnN7367x0pUX8+t0VtKg5S1LNsbBOmdS1eOz6vMnZ9du0kPjG6N3PPd3P3fivqglKIiRnEdrzChIxTTQuf9tLagdqAcOXI7sZqXE/2DrMoIt5Af+Tz7ESRVv3OyptKiW66X47nFpq2atLfxNyLoKPV/0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/2fGCicUdsGpA4W6JyekSIC2T/MJbjzIp8Q4pAEZBdg=;
 b=Uvo679maCBFwQvYFoUmTYXF67x1/Gkn7vjCAmVOMqS3qgmvuZ1fEXoT0H1wDy6ytGJETAtv5OrwenkrkfJm4VELhGxJfSqczRZ1hme0G/rodvG/MtJ8/Rk5lM4GQIZ07CHf3tijaEsWstDirfTweSmQAuITcFlo1rfYnMbbVeLI=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TYAPR01MB5931.jpnprd01.prod.outlook.com (2603:1096:404:805b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Mon, 11 Apr
 2022 11:07:00 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::b129:a6f3:c39e:98db]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::b129:a6f3:c39e:98db%4]) with mapi id 15.20.5144.029; Mon, 11 Apr 2022
 11:06:59 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Vinod Koul <vkoul@kernel.org>
CC:     Colin Ian King <colin.king@intel.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH v2] dmaengine: sh: rz-dmac: Set DMA transfer parameters
 based on the direction
Thread-Topic: [PATCH v2] dmaengine: sh: rz-dmac: Set DMA transfer parameters
 based on the direction
Thread-Index: AQHYTDJlj2876kipdEKmbSVGtv/klqzqjMkAgAABLcA=
Date:   Mon, 11 Apr 2022 11:06:59 +0000
Message-ID: <OS0PR01MB5922B6F81F53A58C7836B5AE86EA9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20220409165348.46080-1-biju.das.jz@bp.renesas.com>
 <YlQJBPmECe2AkpOJ@matsya>
In-Reply-To: <YlQJBPmECe2AkpOJ@matsya>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: eea71354-b38d-4ef6-abb6-08da1bab6684
x-ms-traffictypediagnostic: TYAPR01MB5931:EE_
x-microsoft-antispam-prvs: <TYAPR01MB593144642692201EC0C1E2EA86EA9@TYAPR01MB5931.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mj0yAKX8gR2gcwnyfV3r5VORL3Tp10knTjZDrWHZ1GXFVfr5y7gd9mZRawIr8+De5Kjz5kIik38BzWegv0OjDDfwPfpLJpeggF+FlEBSmtxPzrIuYo+w88qCILJg2z+0vCcxgTw2jclfK2Fpa2eINSMyeUiggvO+2/TjCkx/A+r372CoZAzXM84zQTxKuVqQhU4Kc7sfr25U1YCmuEjj5s4cmuJN9DQio87/tSdnNfdmFyeYJh9HNtuLQjO9bFI/5a7L0F+obIgXCe7AY+HVwISjA5XuiI2tivtm0ji92cJnYw8lNT2x40kZ0CMl7rsXVjn6VVNtH76/0uwftNIVexJcAvX/SeOQP5GzcruwrbriYTZDWqFOO9SVWbINDha0MR8sT2p69WckSQTrmZtNDE+DaRCTEWk2bq9djjgIl4Rd6jtKxuqgcDQ9Zwll7lxdKmBThaFlIliKH/8h8k99z5EZzdZxaMH5sys5yNQHRw6K6Skt6Cv2umteFXF2Vvw+tCzSJyso3Dv45Junf+ovklm2/HfNTbp3UJWPCmzMOFUh5+G/0Ik4MdqkkLoO9wybBvrwfW+kdpV3V8VhR3OjaQ9nccNSdPUKZAfaguDwajuCxPXM0AhuOMsIYRxRM/iE5MPARxFChtYSk2fBGASDJoFe0cXCu2DcEqFYhCSnaBF2Ej2ihNs73dVM9j1Vc2jRk1etbY4BM4BymcJnTIzeCNTz4rm/DLF1RFLvBXuheW6COnVtOwhutDgdLf3AjOd2TLHPLOG9WFb0+9AWrCXC5IdBb+gYKebHBM+0whOc+uQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(5660300002)(64756008)(8676002)(76116006)(66476007)(66556008)(66946007)(33656002)(66446008)(4326008)(55016003)(2906002)(966005)(508600001)(8936002)(122000001)(53546011)(9686003)(86362001)(6506007)(316002)(38100700002)(54906003)(52536014)(38070700005)(6916009)(26005)(71200400001)(186003)(7696005)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?9UmMcPkuw8AdwRcNBWXkbou2OJfT0zIzYrVDfl9hutjf5Al0a+NwbwFBdCmO?=
 =?us-ascii?Q?6WBR5YTYLRT8ltK++qJyFLrLncfYQqO5liI7n+QUwnXRREbsA0DNoeXcqOH1?=
 =?us-ascii?Q?UFjuYf578S7RYhacZZKYYQ0dz6y4QTX4ZOkY04Ug81TEtlRaLLAxG/27GgTP?=
 =?us-ascii?Q?g3lTgk3B7QSJxCXrFKPriMWfoSvdJKKOUHHkq1LQ7F1KgfkSyPtxElVcfXXw?=
 =?us-ascii?Q?tKdKHoj17fQgEyPgIv5namuGhkk/5wOIGZfwcGVCtoHyR9TbDZbpD6PzLB3w?=
 =?us-ascii?Q?F5OePEQ9alqA+H+eSzSQ5SBwCaYCStq3U95l6bLmwlhTZ13SMCtcqeg6HLRV?=
 =?us-ascii?Q?UbtydIaNsRo/EteRBflXPhZntW/K+irCSdX7BucxVlnsXWoPfZfFmnNZ4cis?=
 =?us-ascii?Q?RL1nzR8tm/2mxqIzpkxD7EfZqUzd/QkWyKJ+YI4qxfHbfANPMrIDs6U0G5z8?=
 =?us-ascii?Q?y4FgdMnqMcu2cjU20XEbmfCoxhArfvly8CXbAquECSvR1OhdZBbwSJSJ09pR?=
 =?us-ascii?Q?u7+NDufvi4LRYIBcfIcsQ1FfqIAr5O+4o4HccjZLrB2YTzQas+nOR53KtJ65?=
 =?us-ascii?Q?xs9IEeSvBYA6vbbDn7pWO+gCNgswjvHCVrdwAoR1h0VE3w4om/XHd60RBiQA?=
 =?us-ascii?Q?k/Oc8AIPIIukwyNdPf3TiHw0OZV+56CSn4nDK11EbaLLyWv3KxEsaapHWXAe?=
 =?us-ascii?Q?K9mZCUqZt71Xi9WeuDzOJGzGWZFE/9GP1FR3LOZTtgcHrmbTat/s9HG/Whck?=
 =?us-ascii?Q?Ht0uL1kgNm9IDMygyUCAF9PCKElAa8k5q1BKho7spHkmoqcE06D8OMGSUn23?=
 =?us-ascii?Q?27E0WGvBxltcrY8yIh1YrDEBsKD4Sx7/LJF0XN6hEnIJhEv3AqHuOVLntkOc?=
 =?us-ascii?Q?dju6AoqVQBEgOkJQCQQxrQDdrCD3m3YV0pz1h+6XIYVIN+6tgBT+o0/Y8tR/?=
 =?us-ascii?Q?elp0usysvCZ7/SPiwBNNCH1VddkukZw5+2cEfq0fFzxn1fSk809zZMIl42vY?=
 =?us-ascii?Q?tt/XGEIiEGh0Hn92Jvh8ksKCiu7RuiK9TnOemOAVnmF1K75MK93aRNKidBqa?=
 =?us-ascii?Q?h1r2mXHD1C5QV2hX0CNqzIhcpsWhjOzB2YJYe74XDfY43C6GrIf8WvNEtRQJ?=
 =?us-ascii?Q?ydd1iLw0hSyrw/2XY/R5tHl8mDJIrpXELq2xJkLJxf8W3kJycauFIe4wAp9N?=
 =?us-ascii?Q?1N3crNCtWJQp4vFIbzHpfl5s/gaS/u5G7B6vuDaKAdsheMbqwye952Tfh25W?=
 =?us-ascii?Q?EhBx0MHqByfgwJ0TJQm/sxD57sgGTluG3k3Y1+tqjMcNjsOa0VZ3sveCE20k?=
 =?us-ascii?Q?n6zBmqwIXArrGoHxeyZm07dbfx7T+igTayZ30gk9genUYhnWJTqLpfBpR71k?=
 =?us-ascii?Q?NSjazajz4tE5GbciEfyweetsifxDi4z3NALzy4WmZYR/XC2iogtEsqtz2Vj4?=
 =?us-ascii?Q?sFoXQ1wCHcenWJ4YE9fRMA03RdyLWof0Y4jLCixCXffLROrvRdynZF/0Ku/i?=
 =?us-ascii?Q?u0sw1fR5rgvw/d8pzsx1kAuu4M4n77I7rP+SRS4T8S0YGBXYWyc28Ju+4EkT?=
 =?us-ascii?Q?023HlArkfHxppodNqAg9+/c44d2DoebMdhlUE6gxq+k4fPa6dG/P73JWx9+q?=
 =?us-ascii?Q?8wPbzeAEjoQiNazu6xIE1KyeRdnDOtBi6NOoMtPn0IKN+hrVqypzAPKwcxYP?=
 =?us-ascii?Q?+yVUdTFuMrXMD0inTMvydq8sVTvtFmRgOC4jfGRS+A+eKOKRxAjlU38jbzu0?=
 =?us-ascii?Q?xI9NkNw1cKFDI1TN2uUKYZsG6HXxI5o=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eea71354-b38d-4ef6-abb6-08da1bab6684
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2022 11:06:59.8725
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3gQpE9uTy2AmTsDq9lAPCJrENqE00fyerf9G7+1D+jPJkfbmqpKNHOwblDTNklfpLPFt2s/My2aCo9UE6Tmjwq0lafALG1hycX6ZyL6a6v0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB5931
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

Thanks for the feedback.

> Subject: Re: [PATCH v2] dmaengine: sh: rz-dmac: Set DMA transfer
> parameters based on the direction
>=20
> On 09-04-22, 17:53, Biju Das wrote:
> > Client drivers configure DMA transfer parameters based on the DMA
> > transfer direction.
> >
> > This patch sets corresponding parameters in rz_dmac_config() based on
> > the DMA transfer direction.
> >
> > Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> > Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > ---
> > v1->v2:
> >  * Updated commit description
> > ---
> >  drivers/dma/sh/rz-dmac.c | 26 +++++++++++++-------------
> >  1 file changed, 13 insertions(+), 13 deletions(-)
> >
> > diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c index
> > ee2872e7d64c..de57ae006879 100644
> > --- a/drivers/dma/sh/rz-dmac.c
> > +++ b/drivers/dma/sh/rz-dmac.c
> > @@ -597,24 +597,24 @@ static int rz_dmac_config(struct dma_chan *chan,
> >  			  struct dma_slave_config *config)  {
> >  	struct rz_dmac_chan *channel =3D to_rz_dmac_chan(chan);
> > -	u32 val;
> > +	u32 val, data_sz;
> >
> > -	channel->src_per_address =3D config->src_addr;
> > -	channel->src_word_size =3D config->src_addr_width;
> > -	channel->dst_per_address =3D config->dst_addr;
> > -	channel->dst_word_size =3D config->dst_addr_width;
> > -
> > -	val =3D rz_dmac_ds_to_val_mapping(config->dst_addr_width);
> > -	if (val =3D=3D CHCFG_DS_INVALID)
> > -		return -EINVAL;
> > -
> > -	channel->chcfg |=3D CHCFG_FILL_DDS(val);
> > +	if (config->direction =3D=3D DMA_DEV_TO_MEM) {
>=20
> This is a deprecated field, pls do not use this...
>=20
> Above code is correct and then based on direction of the descriptor you
> would use either src or dstn parameters

OK, I get -EINVAL because of [1] as client driver is filling
{src,dst}_addr_width based on direction.=20

Maybe I should remove the check from this function or
Fix [1], as it is deprecated?? Please share your views on this.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/drivers/spi/spi-rspi.c?h=3Dv5.18-rc2#n1112

Regards,
Biju
