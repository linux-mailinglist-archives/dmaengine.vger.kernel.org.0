Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 18F8C16027
	for <lists+dmaengine@lfdr.de>; Tue,  7 May 2019 11:09:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726321AbfEGJI7 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 7 May 2019 05:08:59 -0400
Received: from smtprelay-out1.synopsys.com ([198.182.61.142]:58800 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-FAIL-OK-OK)
        by vger.kernel.org with ESMTP id S1726249AbfEGJI7 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 7 May 2019 05:08:59 -0400
Received: from mailhost.synopsys.com (dc2-mailhost2.synopsys.com [10.12.135.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id B50FAC01E0;
        Tue,  7 May 2019 09:08:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1557220132; bh=n67V+ZhjdXuhirkb5rv8gRyZYkMI4o6LpaCgquQrLWA=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=abexui8pAk7HQI0hr3TwgfFCcKKFLg56m0d+ShRKl4WK2WJheabCrSVYN9UGIFY4V
         MnF1j5NoT+sRxWJnXrZ5x/8cgulajk0OetCrrFye/CjEuYMxDFXZcJWBXigkOf5yCc
         H+i6LhM7POhmKLuRcU5eSz5oiheMmNgwSe8tTVqR1mbs5rbp7binu6rmzb1gi6Oc0I
         MrCnvafsIjMHlLFgZhaTE/OxEKqBQXB7ZirYWRRo4XWB6RUhyodydMzQsnokh0w1r2
         zfy2b9SWGeKkVa5V9zDr/8pIt5GTXpmTuRagMRKszTlkbybXgEImAJXZaYGf3SlZLz
         PZlW8qOO9fIlA==
Received: from US01WEHTC2.internal.synopsys.com (us01wehtc2.internal.synopsys.com [10.12.239.237])
        (using TLSv1.2 with cipher AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 4A016A0095;
        Tue,  7 May 2019 09:08:57 +0000 (UTC)
Received: from DE02WEHTCB.internal.synopsys.com (10.225.19.94) by
 US01WEHTC2.internal.synopsys.com (10.12.239.237) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Tue, 7 May 2019 02:08:57 -0700
Received: from DE02WEMBXA.internal.synopsys.com ([fe80::a014:7216:77d:d55c])
 by DE02WEHTCB.internal.synopsys.com ([::1]) with mapi id 14.03.0415.000; Tue,
 7 May 2019 11:08:56 +0200
From:   Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
To:     Vinod Koul <vkoul@kernel.org>,
        Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Joao Pinto <Joao.Pinto@synopsys.com>
Subject: RE: [RFC v6 1/6] dmaengine: Add Synopsys eDMA IP core driver
Thread-Topic: [RFC v6 1/6] dmaengine: Add Synopsys eDMA IP core driver
Thread-Index: AQHU+gKjXEmKHEKNrEeMTMtL0Q7MA6Zd5b2AgABDanCAAOWhAIAAYPWA
Date:   Tue, 7 May 2019 09:08:55 +0000
Message-ID: <305100E33629484CBB767107E4246BBB0A238D2C@de02wembxa.internal.synopsys.com>
References: <cover.1556043127.git.gustavo.pimentel@synopsys.com>
 <0e877ac0115d37e466ac234f47c51cb1cae7f292.1556043127.git.gustavo.pimentel@synopsys.com>
 <20190506112001.GE3845@vkoul-mobl.Dlink>
 <305100E33629484CBB767107E4246BBB0A238675@de02wembxa.internal.synopsys.com>
 <20190507050310.GA16052@vkoul-mobl>
In-Reply-To: <20190507050310.GA16052@vkoul-mobl>
Accept-Language: pt-PT, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcZ3VzdGF2b1xh?=
 =?us-ascii?Q?cHBkYXRhXHJvYW1pbmdcMDlkODQ5YjYtMzJkMy00YTQwLTg1ZWUtNmI4NGJh?=
 =?us-ascii?Q?MjllMzViXG1zZ3NcbXNnLWJiNmI5YTA5LTcwYTctMTFlOS05ODgxLWY4OTRj?=
 =?us-ascii?Q?MjczODA0MlxhbWUtdGVzdFxiYjZiOWEwYS03MGE3LTExZTktOTg4MS1mODk0?=
 =?us-ascii?Q?YzI3MzgwNDJib2R5LnR4dCIgc3o9IjgyMjQiIHQ9IjEzMjAxNjkzNzM0MDYy?=
 =?us-ascii?Q?ODYwOCIgaD0iemRuQlBJZnVKbmxTS3ZScS9UK0k4a3RxbVVNPSIgaWQ9IiIg?=
 =?us-ascii?Q?Ymw9IjAiIGJvPSIxIiBjaT0iY0FBQUFFUkhVMVJTUlVGTkNnVUFBQlFKQUFD?=
 =?us-ascii?Q?QTdvVit0QVRWQVRIZWltUlAvWjVmTWQ2S1pFLzlubDhPQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUhBQUFBQ2tDQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUVBQVFBQkFBQUFGdGJCcHdBQUFBQUFBQUFBQUFBQUFKNEFBQUJtQUdrQWJn?=
 =?us-ascii?Q?QmhBRzRBWXdCbEFGOEFjQUJzQUdFQWJnQnVBR2tBYmdCbkFGOEFkd0JoQUhR?=
 =?us-ascii?Q?QVpRQnlBRzBBWVFCeUFHc0FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?RUFBQUFBQUFBQUFnQUFBQUFBbmdBQUFHWUFid0IxQUc0QVpBQnlBSGtBWHdC?=
 =?us-ascii?Q?d0FHRUFjZ0IwQUc0QVpRQnlBSE1BWHdCbkFHWUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQVFBQUFBQUFBQUFDQUFB?=
 =?us-ascii?Q?QUFBQ2VBQUFBWmdCdkFIVUFiZ0JrQUhJQWVRQmZBSEFBWVFCeUFIUUFiZ0Js?=
 =?us-ascii?Q?QUhJQWN3QmZBSE1BWVFCdEFITUFkUUJ1QUdjQVh3QmpBRzhBYmdCbUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUJBQUFBQUFBQUFBSUFBQUFBQUo0QUFBQm1BRzhB?=
 =?us-ascii?Q?ZFFCdUFHUUFjZ0I1QUY4QWNBQmhBSElBZEFCdUFHVUFjZ0J6QUY4QWN3QmhB?=
 =?us-ascii?Q?RzBBY3dCMUFHNEFad0JmQUhJQVpRQnpBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFFQUFBQUFBQUFBQWdBQUFBQUFuZ0FBQUdZQWJ3QjFBRzRBWkFCeUFIa0FY?=
 =?us-ascii?Q?d0J3QUdFQWNnQjBBRzRBWlFCeUFITUFYd0J6QUcwQWFRQmpBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBUUFBQUFBQUFBQUNB?=
 =?us-ascii?Q?QUFBQUFDZUFBQUFaZ0J2QUhVQWJnQmtBSElBZVFCZkFIQUFZUUJ5QUhRQWJn?=
 =?us-ascii?Q?QmxBSElBY3dCZkFITUFkQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQkFBQUFBQUFBQUFJQUFBQUFBSjRBQUFCbUFH?=
 =?us-ascii?Q?OEFkUUJ1QUdRQWNnQjVBRjhBY0FCaEFISUFkQUJ1QUdVQWNnQnpBRjhBZEFC?=
 =?us-ascii?Q?ekFHMEFZd0FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUVBQUFBQUFBQUFBZ0FBQUFBQW5nQUFBR1lBYndCMUFHNEFaQUJ5QUhr?=
 =?us-ascii?Q?QVh3QndBR0VBY2dCMEFHNEFaUUJ5QUhNQVh3QjFBRzBBWXdBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFRQUFBQUFBQUFB?=
 =?us-ascii?Q?Q0FBQUFBQUNlQUFBQVp3QjBBSE1BWHdCd0FISUFid0JrQUhVQVl3QjBBRjhB?=
 =?us-ascii?Q?ZEFCeUFHRUFhUUJ1QUdrQWJnQm5BQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFCQUFBQUFBQUFBQUlBQUFBQUFKNEFBQUJ6?=
 =?us-ascii?Q?QUdFQWJBQmxBSE1BWHdCaEFHTUFZd0J2QUhVQWJnQjBBRjhBY0FCc0FHRUFi?=
 =?us-ascii?Q?Z0FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBRUFBQUFBQUFBQUFnQUFBQUFBbmdBQUFITUFZUUJzQUdVQWN3QmZB?=
 =?us-ascii?Q?SEVBZFFCdkFIUUFaUUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQVFBQUFBQUFB?=
 =?us-ascii?Q?QUFDQUFBQUFBQ2VBQUFBY3dCdUFIQUFjd0JmQUd3QWFRQmpBR1VBYmdCekFH?=
 =?us-ascii?Q?VUFYd0IwQUdVQWNnQnRBRjhBTVFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUJBQUFBQUFBQUFBSUFBQUFBQUo0QUFB?=
 =?us-ascii?Q?QnpBRzRBY0FCekFGOEFiQUJwQUdNQVpRQnVBSE1BWlFCZkFIUUFaUUJ5QUcw?=
 =?us-ascii?Q?QVh3QnpBSFFBZFFCa0FHVUFiZ0IwQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFFQUFBQUFBQUFBQWdBQUFBQUFuZ0FBQUhZQVp3QmZBR3NBWlFC?=
 =?us-ascii?Q?NUFIY0Fid0J5QUdRQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBUUFBQUFB?=
 =?us-ascii?Q?QUFBQUNBQUFBQUFBPSIvPjwvbWV0YT4=3D?=
x-originating-ip: [10.107.25.131]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Tue, May 7, 2019 at 6:3:10, Vinod Koul <vkoul@kernel.org> wrote:

> On 06-05-19, 16:42, Gustavo Pimentel wrote:
>=20
> > > > +	if (unlikely(!chunk))
> > > > +		return NULL;
> > > > +
> > > > +	INIT_LIST_HEAD(&chunk->list);
> > > > +	chunk->chan =3D chan;
> > > > +	chunk->cb =3D !(desc->chunks_alloc % 2);
> > > ? why %2?
> >=20
> > I think it's explained on the patch description. CB also is known as=20
> > Change Bit that must be toggled in order to the HW assume a new linked=
=20
> > list is available to be consumed.
> > Since desc->chunks_alloc variable is an incremental counter the remaind=
er=20
> > after division by 2 will be zero (if chunks_alloc is even) or one (if=20
> > chunks_alloc is odd).
>=20
> Okay it would be great to add a comment here to explain as well

Ok, I'll add it.

>=20
> > > > +static enum dma_status
> > > > +dw_edma_device_tx_status(struct dma_chan *dchan, dma_cookie_t cook=
ie,
> > > > +			 struct dma_tx_state *txstate)
> > > > +{
> > > > +	struct dw_edma_chan *chan =3D dchan2dw_edma_chan(dchan);
> > > > +	struct dw_edma_desc *desc;
> > > > +	struct virt_dma_desc *vd;
> > > > +	unsigned long flags;
> > > > +	enum dma_status ret;
> > > > +	u32 residue =3D 0;
> > > > +
> > > > +	ret =3D dma_cookie_status(dchan, cookie, txstate);
> > > > +	if (ret =3D=3D DMA_COMPLETE)
> > > > +		return ret;
> > > > +
> > > > +	if (ret =3D=3D DMA_IN_PROGRESS && chan->status =3D=3D EDMA_ST_PAU=
SE)
> > > > +		ret =3D DMA_PAUSED;
> > >=20
> > > Don't you want to set residue on paused channel, how else will user k=
now
> > > the position of pause?
> >=20
> > I didn't catch you on this. I'm only setting the dma status here. After=
=20
> > this function, the residue is calculated and set, isn't it?
>=20
> Hmm I thought you returned for paused case, if not then it is okay

No, I'm just setting the dma status in pause case, then I calculate the=20
residue.

>=20
> > > > +static struct dma_async_tx_descriptor *
> > > > +dw_edma_device_transfer(struct dw_edma_transfer *xfer)
> > > > +{
> > > > +	struct dw_edma_chan *chan =3D dchan2dw_edma_chan(xfer->dchan);
> > > > +	enum dma_transfer_direction direction =3D xfer->direction;
> > > > +	phys_addr_t src_addr, dst_addr;
> > > > +	struct scatterlist *sg =3D NULL;
> > > > +	struct dw_edma_chunk *chunk;
> > > > +	struct dw_edma_burst *burst;
> > > > +	struct dw_edma_desc *desc;
> > > > +	u32 cnt;
> > > > +	int i;
> > > > +
> > > > +	if ((direction =3D=3D DMA_MEM_TO_DEV && chan->dir =3D=3D EDMA_DIR=
_WRITE) ||
> > > > +	    (direction =3D=3D DMA_DEV_TO_MEM && chan->dir =3D=3D EDMA_DIR=
_READ))
> > > > +		return NULL;
> > > > +
> > > > +	if (xfer->cyclic) {
> > > > +		if (!xfer->xfer.cyclic.len || !xfer->xfer.cyclic.cnt)
> > > > +			return NULL;
> > > > +	} else {
> > > > +		if (xfer->xfer.sg.len < 1)
> > > > +			return NULL;
> > > > +	}
> > > > +
> > > > +	if (!chan->configured)
> > > > +		return NULL;
> > > > +
> > > > +	desc =3D dw_edma_alloc_desc(chan);
> > > > +	if (unlikely(!desc))
> > > > +		goto err_alloc;
> > > > +
> > > > +	chunk =3D dw_edma_alloc_chunk(desc);
> > > > +	if (unlikely(!chunk))
> > > > +		goto err_alloc;
> > > > +
> > > > +	src_addr =3D chan->config.src_addr;
> > > > +	dst_addr =3D chan->config.dst_addr;
> > > > +
> > > > +	if (xfer->cyclic) {
> > > > +		cnt =3D xfer->xfer.cyclic.cnt;
> > > > +	} else {
> > > > +		cnt =3D xfer->xfer.sg.len;
> > > > +		sg =3D xfer->xfer.sg.sgl;
> > > > +	}
> > > > +
> > > > +	for (i =3D 0; i < cnt; i++) {
> > > > +		if (!xfer->cyclic && !sg)
> > > > +			break;
> > > > +
> > > > +		if (chunk->bursts_alloc =3D=3D chan->ll_max) {
> > > > +			chunk =3D dw_edma_alloc_chunk(desc);
> > > > +			if (unlikely(!chunk))
> > > > +				goto err_alloc;
> > > > +		}
> > > > +
> > > > +		burst =3D dw_edma_alloc_burst(chunk);
> > > > +		if (unlikely(!burst))
> > > > +			goto err_alloc;
> > > > +
> > > > +		if (xfer->cyclic)
> > > > +			burst->sz =3D xfer->xfer.cyclic.len;
> > > > +		else
> > > > +			burst->sz =3D sg_dma_len(sg);
> > > > +
> > > > +		chunk->ll_region.sz +=3D burst->sz;
> > > > +		desc->alloc_sz +=3D burst->sz;
> > > > +
> > > > +		if (direction =3D=3D DMA_DEV_TO_MEM) {
> > > > +			burst->sar =3D src_addr;
> > >=20
> > > We are device to mem, so src is peripheral.. okay
> > >=20
> > > > +			if (xfer->cyclic) {
> > > > +				burst->dar =3D xfer->xfer.cyclic.paddr;
> > > > +			} else {
> > > > +				burst->dar =3D sg_dma_address(sg);
> > > > +				src_addr +=3D sg_dma_len(sg);
> > >=20
> > > and we increment the src, doesn't make sense to me!
> > >=20
> > > > +			}
> > > > +		} else {
> > > > +			burst->dar =3D dst_addr;
> > > > +			if (xfer->cyclic) {
> > > > +				burst->sar =3D xfer->xfer.cyclic.paddr;
> > > > +			} else {
> > > > +				burst->sar =3D sg_dma_address(sg);
> > > > +				dst_addr +=3D sg_dma_len(sg);
> > >=20
> > > same here as well
> >=20
> > This is hard to explain in words...
> > Well, in my perspective I want to transfer a piece of memory from the=20
> > peripheral into local RAM
>=20
> Right and most of the case RAM address (sg) needs to increment whereas
> peripheral is a constant one
>=20
> > Through the DMA client API I'll break this piece of memory in several=20
> > small parts and add all into a list (scatter-gather), right?
> > Each element of the scatter-gather has the sg_dma_address (in the=20
> > DMA_DEV_TO_MEM case will be the destination address) and the=20
> > corresponding size.
>=20
> Correct
>=20
> > However, I still need the other address (in the DMA_DEV_TO_MEM case wil=
l=20
> > be the source address) for that small part of memory.
> > Since I get that address from the config, I still need to increment the=
=20
> > source address in the same proportion of the destination address, in=20
> > other words, the increment will be the part size.
>=20
> I don't think so. Typically the device address is a FIFO, which does not
> increment and you keep pushing data at same address. It is not a memory

In my use case, it's a memory, perhaps that is what is causing this=20
confusing.
I'm copying "plain and flat" data from point A to B, with the=20
particularity that the peripheral memory is always continuous and the CPU=20
memory can be constituted by scatter-gather chunks of contiguous memory

>=20
> > If there is some way to set and get the address for the source (in this=
=20
> > case) into each scatter-gather element, that would be much nicer, is th=
at=20
> > possible?
>=20
> > > > +		case EDMA_REQ_STOP:
> > > > +			list_del(&vd->node);
> > > > +			vchan_cookie_complete(vd);
> > > > +			chan->request =3D EDMA_REQ_NONE;
> > > > +			chan->status =3D EDMA_ST_IDLE;
> > >=20
> > > Why do we need to track request as well as status?
> >=20
> > Since I don't actually have the PAUSE state feature available on HW, I'=
m=20
> > emulating it through software. As far as HW is concerned, it thinks tha=
t=20
> > it has transferred everything (no more bursts valid available), but in=
=20
> > terms of software, we still have a lot of chunks (each one containing=20
> > several bursts) to process.
>=20
> Why do you need to emulate, if HW doesnt support so be it?
> The applications should handle a device which doesnt support pause and
> not a low level driver

In this case, since I've to refill the eDMA memory and retrigger the HW=20
block each time the transfer is completed, it's easy to emulate a pause=20
state, by holding or not refilling the eDMA memory.
I thought that this could be a nice and easy feature to have.

>=20
> > > > +struct dw_edma_transfer {
> > > > +	struct dma_chan			*dchan;
> > > > +	union Xfer {
> > >=20
> > > no camel case please
> >=20
> > Ok.
> >=20
> > >=20
> > > It would help to run checkpatch with --strict option to find any styl=
e
> > > issues and fix them as well
> >=20
> > I usually run with that option, but for now, that option is giving some=
=20
> > warnings about macro variable names that are pure noise.
>=20
> yeah that is a *guide* and to be used as guidance. If code looks worse
> off then it shouldn't be used. But many of the test are helpful. Some
> macros checks actually make sense, but again use your judgement :)

Sure.

>=20
> --=20
> ~Vinod

Regards,
Gustavo

