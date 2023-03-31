Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21AFA6D23EA
	for <lists+dmaengine@lfdr.de>; Fri, 31 Mar 2023 17:25:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233133AbjCaPZ4 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 31 Mar 2023 11:25:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231654AbjCaPZt (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 31 Mar 2023 11:25:49 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2099.outbound.protection.outlook.com [40.107.114.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABCD11D2EF;
        Fri, 31 Mar 2023 08:25:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ha56aqxH9UOp7shyhWNfmZCF29mkTfEXOFbtDjqW5bS6FAhl6P7Gv5c9kQzuoIv+5Oo6oVEtS6ILlmfCSg/3bTr2U1sHrPdMiqCGXvZL5YJ3xEciq/DPkoq67Uqh74SuyWJNud6lZV/5MvrTR+xFJWbPy+C+nwkb8ZPqkja0f26huaW9woZATEqjNPFa2XobYG0vSGnXoR5dsAQIokV2ajjZryzVOEzUjv4gnkn3UG+6KRyVxDTvrIJbqnu5olcIrlSs7Zv3y/ZuVLl251bXQy+uCorBGFbd2lN17Oid3leFfB35SGdVXgI6IpQdWugp1d3iKr+lH3sieZA632mi4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qyzx7YHRk/4vQQ9Sso0JPnglwkkQnLHH9+j4H/CfO48=;
 b=XRUdQDGrxVlnwr1HAzIH+Blfa9PIh4X00+/Iqcdo5Bh5uap81V3lTtxXS2pWJcQ9KkFynGe8VkY/iFMSI7CUY87Wk/2QG1EEhR0ehZJdoVEE8dvwefYVSHpCuBZXKoc0k2x7pyt9jOKDPNTlZWDOcnACWGfY93xUXqDydIM2A0TQ+DOzgTFn+wGZWiaZNenh97mRZUcjuSO5JY0j/96TVvyT09DlD1tUE+cExmWRebV19bDrlkBBTiDusHKLIJUHgBZQHjHRLQdZM7kR3ucTmZDfDb2Df1imU/1b6RNj5Cdv1fp8msXUVhm9ggTHDKkEpGd1lN7GKbW2WF51UpHXlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qyzx7YHRk/4vQQ9Sso0JPnglwkkQnLHH9+j4H/CfO48=;
 b=gygi1tDh5tyhK/osag8VfAnyRGmDJjgtapiMnqEQlHgzGWljBMWeQUEv9d4h6EqKYx9ckIfDqU+vLWHOMx5Z98zAGMxmdkXG5B4U/3jWl9z22e8h4zkPOJsCa0pWMPL0PljQO0/xHXJ+XeNIgy5kLsB8k5tn7pED9HY992v8x18=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by OS0PR01MB5844.jpnprd01.prod.outlook.com (2603:1096:604:bc::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.24; Fri, 31 Mar
 2023 15:25:44 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::e521:994c:bb0e:9bf6]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::e521:994c:bb0e:9bf6%8]) with mapi id 15.20.6254.024; Fri, 31 Mar 2023
 15:25:44 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Vinod Koul <vkoul@kernel.org>
CC:     Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH 2/3] dmaengine: sh: rz-dmac: Add device_tx_status()
 callback
Thread-Topic: [PATCH 2/3] dmaengine: sh: rz-dmac: Add device_tx_status()
 callback
Thread-Index: AQHZXjYENieqC533FEuFDq+M5WfvZa8U2PIAgAA0iJA=
Date:   Fri, 31 Mar 2023 15:25:44 +0000
Message-ID: <OS0PR01MB5922300D0ADFBF8B691FFE11868F9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20230324094957.115071-1-biju.das.jz@bp.renesas.com>
 <20230324094957.115071-3-biju.das.jz@bp.renesas.com>
 <ZCbPOODVqQQmv/TT@matsya>
In-Reply-To: <ZCbPOODVqQQmv/TT@matsya>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|OS0PR01MB5844:EE_
x-ms-office365-filtering-correlation-id: 41ffd724-2b1c-4ab7-1099-08db31fc31e4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zzeeuYdhrvpNksXb70aXIeOSbvprDtPYcnfQv1lEJ8cl624UktkeqSrqlUFyZmhLllFM26f+uTt0Cvh1LGjEbRcubDlTAP2Ym74LzLnNAyMHXF7xjJgMwK5YXbaIq/I7oRhoOzBxONWM+YIWhdfBhQAkBSovfqczMsV+3Q2vwt0CNGKfohK/PsIFGCAG5T7f6n+Yr1twXmDkrS7kJ08qGAbEqMENOyt3uWu86dg7JOUtR85/EKj4Gbn7tUk0c+VgzgwK/7MzBelfVYrPHY/GPFpM5P+OMmfZA3WmStODG0JBf00WhNTbD95PM1LpEwqGCAHA1Q8KsUVzBt61ILOOTBXnf6liqEP8ARyYCBi4wQMTmFzdmJoiHSPP0Ln7wE3zcTDYqqx50C7fpDTBtYoNwFaAV/XRueFX/+fBoeHsskEi4aZwSthOQF9z7XJcHnPg+UAV8sULLEw2hHtjQ5DYmBO86f0k2FH+CW8nlrsC8/P9Ry1HWsgl1/T+nZ76zRJ2vfJDx3S/MUKzQvVJFkPJ5fai3P354mSPIgvR4Xam1K13/EOuBgh1NjoCcUn/uEPvY4KmYEvOUMVLQEYytEsnmLT3nhXbeYjDkFUr6YORbIdVhDS93CMsjDbIm2NAPBQA
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(346002)(396003)(376002)(366004)(451199021)(8936002)(52536014)(122000001)(316002)(38100700002)(38070700005)(186003)(5660300002)(26005)(53546011)(9686003)(6506007)(2906002)(4326008)(86362001)(76116006)(66946007)(66476007)(66556008)(64756008)(8676002)(66446008)(41300700001)(6916009)(55016003)(54906003)(33656002)(7696005)(71200400001)(83380400001)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?zFd6ezbObAVmy6difiqz1YMW+V/+Ag+qXE0PIuvUSzx9OnqrbadAS2mwibhX?=
 =?us-ascii?Q?Lli/b1W4Jwrm4uJnd7+DP6oAQ5CwD6zLU0xLR176UAojb4nmmtj/d2yD6ehk?=
 =?us-ascii?Q?J1rQsp4yCn8XOoOm4LEIdpkaSnqvMfOL0YVY260tWfoIAJI0/kK6d8NiAV6l?=
 =?us-ascii?Q?Z1SWP+WaW4EjOdLDfX38y8VlprgiLaxGMA2V8MmJRWYCw0ba15xq7zvCLxha?=
 =?us-ascii?Q?KPWJ8S6BoMi5slin5kdOyHlTGhQKIjUPO1V8CvbwePs7qm1i4TD3eYCViSnR?=
 =?us-ascii?Q?SqzrQBBEffFrgb8r0zWON8jrXyxwMSLiDVXFq9CqzEH18nURGIq5S1Sw2lGk?=
 =?us-ascii?Q?3ztbHPy8lKQ93n94cciPtGqYi05NunyVYMhRmrSEIiJhCUgx3OVg92ukJjAu?=
 =?us-ascii?Q?63Bijowcb5FoXvIJgEhnJsdvYesPWuZ0RCOObDKz4ykuovEwHjQ9olKpABKq?=
 =?us-ascii?Q?MgRm8AFpAzufFGNbOs6DqMe0kj8XsdN9IAQ/NWP/ElUzZ69HRKHdB9gkYnQy?=
 =?us-ascii?Q?GVKTR2njt/P7cLKTjPgl6cgKosKbDjwn3l3RMqQRa/yauK9dLKKp3YPn0ueg?=
 =?us-ascii?Q?gvxpsKrXQdnhYmP09sUhR4TrgTZAX/+HwIm6vi24S4Han48YM7mqN8xVqu0E?=
 =?us-ascii?Q?SVZ3AAD8ScT/i6NiVNcouv12d9hWxLD0WOitP2wfUlxEccZs/Jud1aFcJL+y?=
 =?us-ascii?Q?0PXpNi0QKWU2FAyUJKpQTT53llDG+UHwC8nst8piqJww1sq0cXgLq9eaYT70?=
 =?us-ascii?Q?ia/TB3Rn+o+/IwWXXfyqM/coTJJhaqL38WfXugjUWakqLrcJ/PTc8QzKlY3D?=
 =?us-ascii?Q?Hj8aokmpWjCMxvTSKBJ1MsX7v5eJzXEivTWRcQ71mpnVipxKinOuSSY5tkOz?=
 =?us-ascii?Q?g2TgXbc07V4d97uUzL7Xb7GA1xvSw0qYSMh6viPlP+dgPH6t1RHZ5tA9XThS?=
 =?us-ascii?Q?BjldsSDtta8Ue+jMZMwI8jlRmq101gYjjeHhqhbPDP96s5jDd8h2EN6bAQFi?=
 =?us-ascii?Q?FzDmqP13cSQMkg+xB6giZ87jCN+BFDMKoeQbO45d7WnOw9gQzfuZIQFNewy+?=
 =?us-ascii?Q?2NVD1skNQuGdJ5eD5pqgcLtjionCXGWhTymhpfpJxxUgeKL+u1liYklv+dcB?=
 =?us-ascii?Q?XYRJ8yu6rqbg1jjQp0PtNLt/0byndlEYystGOe0V0DoV2RCHpQs88GflxoDt?=
 =?us-ascii?Q?aCywKd4FO8okk3bRrfRGNLGaOK7r5YByQcCvo+IbMSZhdFv3BYuaeGH56qiJ?=
 =?us-ascii?Q?5c8hG6WmRnIlp9Lho+Ra3yHCQxLbXozzzgkihk5aNyMtrpQVxOcLMgIr3VPk?=
 =?us-ascii?Q?hUlfV+NRnOO28pMWGajJ4N2LvxMwWq+shd1g+aV0zqcrT/rmTWQtcJpmmo6y?=
 =?us-ascii?Q?2NftEi3HnmIybBepTZBAZVDyOqWT5ndS2wE/cx+MZksuinKX+/EniKYaCopR?=
 =?us-ascii?Q?yJPPV4dvUdItEsuxLbuYY22tEb0tWHmh+Zxrg1hNhLgaMY0Av4eIrPmfqbNI?=
 =?us-ascii?Q?O1jHdpHefm7Ym6pDzYcMAQQGsK1K+vzldx4NNUesNPJT8pJvvzxZsLcDzdbf?=
 =?us-ascii?Q?UWCkwnIlggICIFgtIcUPZozU4kiJW3scGkfXRM3UErfdAVJ5e/BYwwTuR7Vn?=
 =?us-ascii?Q?tA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41ffd724-2b1c-4ab7-1099-08db31fc31e4
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Mar 2023 15:25:44.1167
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: A1yhkwzdDDDiuyfcdH1VtAWF4z+fExOlG7KaiKp7Lx+IkZMXzHlTCwyPq6HPfXzYkXJ6cOCfHsDYOavGbDALwekwJAJNd8L8ERwQXISZUJ0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS0PR01MB5844
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

> -----Original Message-----
> From: Vinod Koul <vkoul@kernel.org>
> Sent: Friday, March 31, 2023 1:17 PM
> To: Biju Das <biju.das.jz@bp.renesas.com>
> Cc: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>; Geer=
t
> Uytterhoeven <geert+renesas@glider.be>; dmaengine@vger.kernel.org; linux-
> renesas-soc@vger.kernel.org
> Subject: Re: [PATCH 2/3] dmaengine: sh: rz-dmac: Add device_tx_status()
> callback
>=20
> On 24-03-23, 09:49, Biju Das wrote:
> > The device_tx_status() callback is needed for serial DMA (RZ/G2L
> > SCIFA). Add support for device_tx_status() callback.
> >
> > Based on a patch in the BSP by Long Luu similar to rcar-dmac
> > <long.luu.ur@renesas.com>
> >
> > Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> > ---
> >  drivers/dma/sh/rz-dmac.c | 169
> > ++++++++++++++++++++++++++++++++++++++-
> >  1 file changed, 168 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c index
> > a04a37ce03fd..3625925d9f9f 100644
> > --- a/drivers/dma/sh/rz-dmac.c
> > +++ b/drivers/dma/sh/rz-dmac.c
> > @@ -110,10 +110,12 @@ struct rz_dmac {
> >   * Registers
> >   */
> >
> > +#define CRTB				0x0020
> >  #define CHSTAT				0x0024
> >  #define CHCTRL				0x0028
> >  #define CHCFG				0x002c
> >  #define NXLA				0x0038
> > +#define CRLA				0x003c
> >
> >  #define DCTRL				0x0000
> >
> > @@ -655,6 +657,171 @@ static void rz_dmac_device_synchronize(struct
> dma_chan *chan)
> >  	rz_dmac_set_dmars_register(dmac, channel->index, 0);  }
> >
> > +static unsigned int calculate_total_bytes_in_vd(struct rz_dmac_desc
> > +*desc) {
> > +	struct scatterlist *sg, *sgl =3D desc->sg;
> > +	unsigned int i, size, sg_len =3D desc->sgcount;
> > +
> > +	for (i =3D 0, size =3D 0, sg =3D sgl; i < sg_len; i++, sg =3D sg_next=
(sg))
> > +		size +=3D sg_dma_len(sg);
>=20
> for_each_sg() ?

Agreed. Much simpler now.

Cheers,
Biju

>=20
> > +
> > +	return size;
> > +}
> > +
> > +static unsigned int calculate_residue_bytes_in_vd(struct rz_dmac_chan
> > +*channel) {
> > +	struct rz_lmdesc *lmdesc =3D channel->lmdesc.head;
> > +	struct dma_chan *chan =3D &channel->vc.chan;
> > +	struct rz_dmac *dmac =3D to_rz_dmac(chan->device);
> > +	unsigned int residue =3D 0, i =3D 0;
> > +	unsigned int crla;
> > +
> > +	/* get current lmdesc */
> > +	crla =3D rz_dmac_ch_readl(channel, CRLA, 1);
> > +	while (!(lmdesc->nxla =3D=3D crla)) {
> > +		lmdesc++;
> > +		if (lmdesc >=3D (channel->lmdesc.base + DMAC_NR_LMDESC))
> > +			lmdesc =3D channel->lmdesc.base;
> > +		i++;
> > +		/* Not found current lmdesc */
> > +		if (i > DMAC_NR_LMDESC)
> > +			return 0;
> > +	}
> > +
> > +	/* Point to current processing lmdesc in hardware */
> > +	lmdesc++;
> > +	if (lmdesc >=3D (channel->lmdesc.base + DMAC_NR_LMDESC))
> > +		lmdesc =3D channel->lmdesc.base;
> > +
> > +	/* Calculate residue from next lmdesc to end of virtual desc*/
> > +	while (lmdesc->chcfg & CHCFG_DEM) {
> > +		lmdesc++;
> > +		if (lmdesc >=3D (channel->lmdesc.base + DMAC_NR_LMDESC))
> > +			lmdesc =3D channel->lmdesc.base;
> > +		residue +=3D lmdesc->tb;
> > +	}
> > +
> > +	dev_dbg(dmac->dev, "%s: Getting residue is %d\n", __func__,
> > +residue);
> > +
> > +	return residue;
> > +}
> > +
> > +static unsigned int rz_dmac_chan_get_residue(struct rz_dmac_chan
> *channel,
> > +					     dma_cookie_t cookie)
> > +{
> > +	struct rz_dmac_desc *current_desc, *desc;
> > +	enum dma_status status;
> > +	unsigned int residue;
> > +	unsigned int crla;
> > +	unsigned int crtb;
> > +	unsigned int i;
> > +
> > +	/* Get current processing virtual descriptor */
> > +	current_desc =3D list_first_entry(&channel->ld_active,
> > +					struct rz_dmac_desc, node);
> > +	if (!current_desc)
> > +		return 0;
> > +
> > +	/*
> > +	 * If the cookie corresponds to a descriptor that has been completed
> > +	 * there is no residue. The same check has already been performed by
> the
> > +	 * caller but without holding the channel lock, so the descriptor
> could
> > +	 * now be complete.
> > +	 */
> > +	status =3D dma_cookie_status(&channel->vc.chan, cookie, NULL);
> > +	if (status =3D=3D DMA_COMPLETE)
> > +		return 0;
> > +
> > +	/*
> > +	 * If the cookie doesn't correspond to the currently processing
> virtual
> > +	 * descriptor then the descriptor hasn't been processed yet, and the
> > +	 * residue is equal to the full descriptor size.
> > +	 * Also, a client driver is possible to call this function before
> > +	 * rz_dmac_irq_handler_thread() runs. In this case, the running
> > +	 * descriptor will be the next descriptor, and the done list will
> > +	 * appear. So, if the argument cookie matches the done list's cookie,
> > +	 * we can assume the residue is zero.
> > +	 */
> > +	if (cookie !=3D current_desc->vd.tx.cookie) {
> > +		list_for_each_entry(desc, &channel->ld_free, node) {
> > +			if (cookie =3D=3D desc->vd.tx.cookie)
> > +				return 0;
> > +		}
> > +
> > +		list_for_each_entry(desc, &channel->ld_queue, node) {
> > +			if (cookie =3D=3D desc->vd.tx.cookie)
> > +				return calculate_total_bytes_in_vd(desc);
> > +		}
> > +
> > +		list_for_each_entry(desc, &channel->ld_active, node) {
> > +			if (cookie =3D=3D desc->vd.tx.cookie)
> > +				return calculate_total_bytes_in_vd(desc);
> > +		}
> > +
> > +		/*
> > +		 * No descriptor found for the cookie, there's thus no residue.
> > +		 * This shouldn't happen if the calling driver passes a correct
> > +		 * cookie value.
> > +		 */
> > +		WARN(1, "No descriptor for cookie!");
> > +		return 0;
> > +	}
> > +
> > +	/*
> > +	 * Correspond to the currently processing virtual descriptor
> > +	 *
> > +	 * Make sure the hardware does not move to next lmdesc
> > +	 * while reading the counter.
> > +	 * Trying it 3 times should be enough: Initial read, retry, retry
> > +	 * for the paranoid.
> > +	 * The current lmdesc running in hardware is channel.lmdesc.head
> > +	 */
> > +	for (i =3D 0; i < 3; i++) {
> > +		crla =3D rz_dmac_ch_readl(channel, CRLA, 1);
> > +		crtb =3D rz_dmac_ch_readl(channel, CRTB, 1);
> > +		/* Still the same? */
> > +		if (crla =3D=3D rz_dmac_ch_readl(channel, CRLA, 1))
> > +			break;
> > +	}
> > +
> > +	WARN_ONCE(i >=3D 3, "residue might be not continuous!");
> > +
> > +	/*
> > +	 * Calculate number of byte transferred in processing virtual
> descriptor
> > +	 * One virtual descriptor can have many lmdesc
> > +	 */
> > +	residue =3D crtb;
> > +	residue +=3D calculate_residue_bytes_in_vd(channel);
> > +
> > +	return residue;
> > +}
> > +
> > +static enum dma_status rz_dmac_tx_status(struct dma_chan *chan,
> > +					 dma_cookie_t cookie,
> > +					 struct dma_tx_state *txstate)
> > +{
> > +	struct rz_dmac_chan *channel =3D to_rz_dmac_chan(chan);
> > +	enum dma_status status;
> > +	unsigned int residue;
> > +	unsigned long flags;
> > +
> > +	status =3D dma_cookie_status(chan, cookie, txstate);
> > +	if (status =3D=3D DMA_COMPLETE || !txstate)
> > +		return status;
> > +
> > +	spin_lock_irqsave(&channel->vc.lock, flags);
> > +	residue =3D rz_dmac_chan_get_residue(channel, cookie);
> > +	spin_unlock_irqrestore(&channel->vc.lock, flags);
> > +
> > +	/* if there's no residue, the cookie is complete */
> > +	if (!residue)
> > +		return DMA_COMPLETE;
> > +
> > +	dma_set_residue(txstate, residue);
> > +
> > +	return status;
> > +}
> > +
> >  /*
> >   * -------------------------------------------------------------------=
---
> -------
> >   * IRQ handling
> > @@ -937,7 +1104,7 @@ static int rz_dmac_probe(struct platform_device
> > *pdev)
> >
> >  	engine->device_alloc_chan_resources =3D rz_dmac_alloc_chan_resources;
> >  	engine->device_free_chan_resources =3D rz_dmac_free_chan_resources;
> > -	engine->device_tx_status =3D dma_cookie_status;
> > +	engine->device_tx_status =3D rz_dmac_tx_status;
> >  	engine->device_prep_slave_sg =3D rz_dmac_prep_slave_sg;
> >  	engine->device_prep_dma_memcpy =3D rz_dmac_prep_dma_memcpy;
> >  	engine->device_config =3D rz_dmac_config;
> > --
> > 2.25.1
>=20
> --
> ~Vinod
