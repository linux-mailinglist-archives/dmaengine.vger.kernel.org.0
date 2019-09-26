Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ED64BBEBBB
	for <lists+dmaengine@lfdr.de>; Thu, 26 Sep 2019 07:54:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388882AbfIZFyi (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 26 Sep 2019 01:54:38 -0400
Received: from mail-eopbgr760070.outbound.protection.outlook.com ([40.107.76.70]:8708
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387630AbfIZFyh (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 26 Sep 2019 01:54:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AUT7ExYB+Vk7sja428zaBomkaH9NZV+/F8pjJok2kn8zKYwCVn5imcnPYlF8jc6XBr2cBAU3cwVOVip9eeYzbT9a7KZOjLjooOxKm2Qj51JwxpxcIQSClMA2wkrY8zZ4qI+V01UWU/Yjqt1AHZhBMciyEekSq4gYPzeZMINWaOOVPWe4Yz7Esf6ApZYyis8rVRY1crGLSjJi0xIyIItVLSd6zmEBvMDXKOTThWjlwnruB5sbvxJvVIaxM55vBusmr6oqPQ8RZvuuREQBJv0hjmn6j2uJS8z3NcVA3b824jw8WwwbzvpiKfmIDgZBGGap0hbkAs1vf8F/IIaSAdax+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0zWfdk0aV2ULAx+zJ0E6TFSmDruM2D+9qAwgqqzoHKI=;
 b=h6MGwsdujgK4XLvStyoL0QqgwyBk1E8WPyTeZeKo94v9fxcFz5sX9u2iyG6aJRyQEFMzn+UjbHJRwcebBuxYgFkQzZI1wISnu9thNzw9KZadThBS0IpFFVv6DCudwh/pqvH2EwQWU0d5DlhYtVOPA0oRWVSrZXfV9t+WfdkQK1VoxhI1QudRWtFtRGv1XwTma8Jw5VoFKQKGn/50frYwZ15Ewd6u7uwFxCcxBYuV3BQDZ1+5uOHBxnET/YGEWeJFiNGF5fOp6luk1qX/hUP8pnROHWVNd/Wpp/ko3KI5Y7Ja7s3nTcbgELM1VgYbUsnzmQJfqrZijTirUli74Uc4+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0zWfdk0aV2ULAx+zJ0E6TFSmDruM2D+9qAwgqqzoHKI=;
 b=SMgulXPA+UKzErf11ItVEwbKsTbFlcpc0M3MNvZZDZFlSZhvcckdZxQdCG9qPqbvmwUvjLM8pW7QGHKyRbG+n10eSN6eul/kNZO4OZ0ASFfXovF3sCEHqcgJvH5/OJ2+OTP/JR6CXhL7Lsp6Dmw5zPzSudGPXwkoCr6bJZg3Fhw=
Received: from CH2PR02MB7000.namprd02.prod.outlook.com (20.180.9.216) by
 CH2PR02MB6856.namprd02.prod.outlook.com (20.180.7.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.20; Thu, 26 Sep 2019 05:52:55 +0000
Received: from CH2PR02MB7000.namprd02.prod.outlook.com
 ([fe80::3515:e3a7:8799:73bd]) by CH2PR02MB7000.namprd02.prod.outlook.com
 ([fe80::3515:e3a7:8799:73bd%2]) with mapi id 15.20.2305.017; Thu, 26 Sep 2019
 05:52:55 +0000
From:   Radhey Shyam Pandey <radheys@xilinx.com>
To:     Vinod Koul <vkoul@kernel.org>
CC:     "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        Michal Simek <michals@xilinx.com>,
        "nick.graumann@gmail.com" <nick.graumann@gmail.com>,
        "andrea.merello@gmail.com" <andrea.merello@gmail.com>,
        Appana Durga Kedareswara Rao <appanad@xilinx.com>,
        "mcgrof@kernel.org" <mcgrof@kernel.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH -next 3/8] dmaengine: xilinx_dma: Introduce
 xilinx_dma_get_residue
Thread-Topic: [PATCH -next 3/8] dmaengine: xilinx_dma: Introduce
 xilinx_dma_get_residue
Thread-Index: AQHVZAhKDg4F4xU8mE+kGY5hxnspoac9ALWAgACRLOA=
Date:   Thu, 26 Sep 2019 05:52:55 +0000
Message-ID: <CH2PR02MB70008CE8600D98753BE1CC97C7860@CH2PR02MB7000.namprd02.prod.outlook.com>
References: <1567701424-25658-1-git-send-email-radhey.shyam.pandey@xilinx.com>
 <1567701424-25658-4-git-send-email-radhey.shyam.pandey@xilinx.com>
 <20190925210123.GL3824@vkoul-mobl>
In-Reply-To: <20190925210123.GL3824@vkoul-mobl>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=radheys@xilinx.com; 
x-originating-ip: [149.199.50.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bf54f24c-2e18-4356-564a-08d74245c6da
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:CH2PR02MB6856;
x-ms-traffictypediagnostic: CH2PR02MB6856:|CH2PR02MB6856:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR02MB6856EEA1ABF3BCA25B170CADC7860@CH2PR02MB6856.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-forefront-prvs: 0172F0EF77
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(39860400002)(136003)(346002)(396003)(366004)(13464003)(199004)(189003)(76094002)(7736002)(305945005)(8936002)(74316002)(86362001)(33656002)(14444005)(256004)(6916009)(229853002)(6436002)(66066001)(3846002)(9686003)(55016002)(2906002)(6246003)(4326008)(99286004)(102836004)(186003)(7696005)(76176011)(53546011)(486006)(476003)(11346002)(66476007)(66556008)(64756008)(66446008)(76116006)(66946007)(446003)(6116002)(52536014)(5660300002)(81156014)(81166006)(8676002)(6506007)(26005)(25786009)(478600001)(54906003)(316002)(71190400001)(71200400001)(14454004);DIR:OUT;SFP:1101;SCL:1;SRVR:CH2PR02MB6856;H:CH2PR02MB7000.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: EKYayfp+PMTDfX5rVcRO2hwHHmQwZL8pCu7Z+oN5p1q8yx6t2Ymj/JZhvop+SpsVgBx5cBYXc0rkjqBZJw9+5YVD0ZyawkiJToZqKq6ibwXbYg8ho3ByfyOOJhLS2cVFQvuxusnP3Af1/3uVNd6CqXWzEXRKpZOFC6dcqptX6BU0cxWb+5/FVVFEviRDyD4H68lamjjTdifU759YmVs5DDF6oqHWMQ7W+n6XlYWqAYEnxW0Kl2FITyBflRR1JPvrjtPKAqdF1SDN943+51mYU2Ae/9dRfxhIm8l2iuBO2NXXu1VsFwtmdEfVImUMqzFHnMoW0MGqJ4j+Ec7TUv6fxVuI+/7cOchO1vhTxgkhmniX5e3hVo5EqQbxp2P+nYclunnkFUACU+K53ade6RrR01Y8qKQqbKY++2MNZrMNpu0=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf54f24c-2e18-4356-564a-08d74245c6da
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2019 05:52:55.1267
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JECvYZ6cfKU3T88qHeEsS900EcWC3b0SwiGYe0yybq95E4Wb1XjvFZ1RlX6Utj5B2Mdw0/Gl+s8SIHBWpFHuyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR02MB6856
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

> -----Original Message-----
> From: Vinod Koul <vkoul@kernel.org>
> Sent: Thursday, September 26, 2019 2:31 AM
> To: Radhey Shyam Pandey <radheys@xilinx.com>
> Cc: dan.j.williams@intel.com; Michal Simek <michals@xilinx.com>;
> nick.graumann@gmail.com; andrea.merello@gmail.com; Appana Durga
> Kedareswara Rao <appanad@xilinx.com>; mcgrof@kernel.org;
> dmaengine@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH -next 3/8] dmaengine: xilinx_dma: Introduce
> xilinx_dma_get_residue
>=20
> On 05-09-19, 22:06, Radhey Shyam Pandey wrote:
> > From: Nicholas Graumann <nick.graumann@gmail.com>
> >
> > Introduce a function that can calculate residues for IPs that support i=
t:
> > AXI DMA and CDMA.
> >
> > Signed-off-by: Nicholas Graumann <nick.graumann@gmail.com>
> > Signed-off-by: Radhey Shyam Pandey
> <radhey.shyam.pandey@xilinx.com>
> > ---
> >  drivers/dma/xilinx/xilinx_dma.c | 75
> > ++++++++++++++++++++++++++++++-----------
> >  1 file changed, 56 insertions(+), 19 deletions(-)
> >
> > diff --git a/drivers/dma/xilinx/xilinx_dma.c
> > b/drivers/dma/xilinx/xilinx_dma.c index 9909bfb..4094adb 100644
> > --- a/drivers/dma/xilinx/xilinx_dma.c
> > +++ b/drivers/dma/xilinx/xilinx_dma.c
> > @@ -787,6 +787,51 @@ static void xilinx_dma_free_chan_resources(struct
> > dma_chan *dchan)  }
> >
> >  /**
> > + * xilinx_dma_get_residue - Compute residue for a given descriptor
> > + * @chan: Driver specific dma channel
> > + * @desc: dma transaction descriptor
> > + *
> > + * Return: The number of residue bytes for the descriptor.
> > + */
> > +static u32 xilinx_dma_get_residue(struct xilinx_dma_chan *chan,
> > +				  struct xilinx_dma_tx_descriptor *desc) {
> > +	struct xilinx_cdma_tx_segment *cdma_seg;
> > +	struct xilinx_axidma_tx_segment *axidma_seg;
> > +	struct xilinx_cdma_desc_hw *cdma_hw;
> > +	struct xilinx_axidma_desc_hw *axidma_hw;
> > +	struct list_head *entry;
> > +	u32 residue =3D 0;
> > +
> > +	/**
>=20
> it should be:
>         /*
>          * comment...
>=20
Thanks for pointing it out. I will fix it in v2.

> > +	 * VDMA and simple mode do not support residue reporting, so the
> > +	 * residue field will always be 0.
> > +	 */
> > +	if (chan->xdev->dma_config->dmatype =3D=3D XDMA_TYPE_VDMA ||
> !chan->has_sg)
> > +		return residue;
>=20
> why not check this in status callback?
Assuming we mean to move vdma and non-sg check to xilinx_dma_tx_status.
Just a thought- Keeping this check in xilinx_dma_get_residue provides
an abstraction and caller can simply call this func with knowing about
IP config specific residue calculation. Considering this point does it
looks ok ?=20
>=20
> > +
> > +	list_for_each(entry, &desc->segments) {
> > +		if (chan->xdev->dma_config->dmatype =3D=3D
> XDMA_TYPE_CDMA) {
> > +			cdma_seg =3D list_entry(entry,
> > +					      struct xilinx_cdma_tx_segment,
> > +					      node);
> > +			cdma_hw =3D &cdma_seg->hw;
> > +			residue +=3D (cdma_hw->control - cdma_hw->status)
> &
> > +				   chan->xdev->max_buffer_len;
> > +		} else {
> > +			axidma_seg =3D list_entry(entry,
> > +						struct
> xilinx_axidma_tx_segment,
> > +						node);
> > +			axidma_hw =3D &axidma_seg->hw;
> > +			residue +=3D (axidma_hw->control - axidma_hw-
> >status) &
> > +				   chan->xdev->max_buffer_len;
> > +		}
> > +	}
> > +
> > +	return residue;
> > +}
> > +
> > +/**
> >   * xilinx_dma_chan_handle_cyclic - Cyclic dma callback
> >   * @chan: Driver specific dma channel
> >   * @desc: dma transaction descriptor
> > @@ -995,33 +1040,22 @@ static enum dma_status
> > xilinx_dma_tx_status(struct dma_chan *dchan,  {
> >  	struct xilinx_dma_chan *chan =3D to_xilinx_chan(dchan);
> >  	struct xilinx_dma_tx_descriptor *desc;
> > -	struct xilinx_axidma_tx_segment *segment;
> > -	struct xilinx_axidma_desc_hw *hw;
> >  	enum dma_status ret;
> >  	unsigned long flags;
> > -	u32 residue =3D 0;
> >
> >  	ret =3D dma_cookie_status(dchan, cookie, txstate);
> >  	if (ret =3D=3D DMA_COMPLETE || !txstate)
> >  		return ret;
> >
> > -	if (chan->xdev->dma_config->dmatype =3D=3D XDMA_TYPE_AXIDMA) {
> > -		spin_lock_irqsave(&chan->lock, flags);
> > +	spin_lock_irqsave(&chan->lock, flags);
> >
> > -		desc =3D list_last_entry(&chan->active_list,
> > -				       struct xilinx_dma_tx_descriptor, node);
> > -		if (chan->has_sg) {
> > -			list_for_each_entry(segment, &desc->segments,
> node) {
> > -				hw =3D &segment->hw;
> > -				residue +=3D (hw->control - hw->status) &
> > -					   chan->xdev->max_buffer_len;
> > -			}
> > -		}
> > -		spin_unlock_irqrestore(&chan->lock, flags);
> > +	desc =3D list_last_entry(&chan->active_list,
> > +			       struct xilinx_dma_tx_descriptor, node);
> > +	chan->residue =3D xilinx_dma_get_residue(chan, desc);
> >
> > -		chan->residue =3D residue;
> > -		dma_set_residue(txstate, chan->residue);
> > -	}
> > +	spin_unlock_irqrestore(&chan->lock, flags);
> > +
> > +	dma_set_residue(txstate, chan->residue);
> >
> >  	return ret;
> >  }
> > @@ -2701,12 +2735,15 @@ static int xilinx_dma_probe(struct
> platform_device *pdev)
> >  					  xilinx_dma_prep_dma_cyclic;
> >  		xdev->common.device_prep_interleaved_dma =3D
> >  					xilinx_dma_prep_interleaved;
> > -		/* Residue calculation is supported by only AXI DMA */
> > +		/* Residue calculation is supported by only AXI DMA and
> CDMA */
> >  		xdev->common.residue_granularity =3D
> >
> DMA_RESIDUE_GRANULARITY_SEGMENT;
> >  	} else if (xdev->dma_config->dmatype =3D=3D XDMA_TYPE_CDMA) {
> >  		dma_cap_set(DMA_MEMCPY, xdev->common.cap_mask);
> >  		xdev->common.device_prep_dma_memcpy =3D
> xilinx_cdma_prep_memcpy;
> > +		/* Residue calculation is supported by only AXI DMA and
> CDMA */
> > +		xdev->common.residue_granularity =3D
> > +
> 	DMA_RESIDUE_GRANULARITY_SEGMENT;
> >  	} else {
> >  		xdev->common.device_prep_interleaved_dma =3D
> >  				xilinx_vdma_dma_prep_interleaved;
> > --
> > 2.7.4
>=20
> --
> ~Vinod
