Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 564A77B78F7
	for <lists+dmaengine@lfdr.de>; Wed,  4 Oct 2023 09:46:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241592AbjJDHqW (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 4 Oct 2023 03:46:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241576AbjJDHqS (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 4 Oct 2023 03:46:18 -0400
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61582AC;
        Wed,  4 Oct 2023 00:46:14 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id DBC48C0012;
        Wed,  4 Oct 2023 07:46:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1696405572;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8pVUUQ+7DMEkzQuJdwWGeYNzfoadiG6zJza5DvYnmG8=;
        b=oiA1C0pBlt+IQPi0goIxyfvjDFJFrr+isK4UXLcwYxtmOqnUTRUml2vjBSct47qwKPEtF7
        Jctboom4Bioobo62cvePSiwLycC0dtvKCMv49jA0dG/BBWTUdd7ssDcIPp41jy89ajASOf
        xeqdfl0UcLVQ1iBco0UmH/8nZ6ffbnlyfP7hFkyBc+hSE7RDWUzr+b4UVtMYRhluvg96wG
        VEacVQzvYWioBkA6BKbcZm120MoORQEBAY+Y6k48LVpBFSCDZianxlgmDAL0i82SxgOAtT
        HbEfFQ7TqyFBfeE3sAnKxUGZDqqhA3VvKxpHiPXVSJft1xSlGbB72o2qOUOo6A==
Date:   Wed, 4 Oct 2023 09:46:09 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Lizhi Hou <lizhi.hou@amd.com>, Brian Xu <brian.xu@amd.com>,
        Raj Kumar Rampelli <raj.kumar.rampelli@amd.com>,
        Michal Simek <michal.simek@amd.com>, dmaengine@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] dmaengine: xilinx: xdma: Support cyclic
 transfers
Message-ID: <20231004094609.2b1ea0c5@xps-13>
In-Reply-To: <ZR0UVYAKgix2nRrb@matsya>
References: <20230922162056.594933-1-miquel.raynal@bootlin.com>
        <20230922162056.594933-3-miquel.raynal@bootlin.com>
        <ZRVbZwQz13hL2QfY@matsya>
        <20231003110256.44286fcd@xps-13>
        <ZR0UVYAKgix2nRrb@matsya>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Vinod,

vkoul@kernel.org wrote on Wed, 4 Oct 2023 12:59:25 +0530:

> On 03-10-23, 11:02, Miquel Raynal wrote:
> > Hi Vinod,
> >=20
> > Thanks for the feedback.
> >=20
> > vkoul@kernel.org wrote on Thu, 28 Sep 2023 16:24:31 +0530:
> >  =20
> > > On 22-09-23, 18:20, Miquel Raynal wrote:
> > >  =20
> > > > @@ -583,7 +690,36 @@ static int xdma_alloc_chan_resources(struct dm=
a_chan *chan)
> > > >  static enum dma_status xdma_tx_status(struct dma_chan *chan, dma_c=
ookie_t cookie,
> > > >  				      struct dma_tx_state *state)
> > > >  {
> > > > -	return dma_cookie_status(chan, cookie, state);
> > > > +	struct xdma_chan *xdma_chan =3D to_xdma_chan(chan);
> > > > +	struct xdma_desc *desc =3D NULL;
> > > > +	struct virt_dma_desc *vd;
> > > > +	enum dma_status ret;
> > > > +	unsigned long flags;
> > > > +	unsigned int period_idx;
> > > > +	u32 residue =3D 0;
> > > > +
> > > > +	ret =3D dma_cookie_status(chan, cookie, state);
> > > > +	if (ret =3D=3D DMA_COMPLETE)
> > > > +		return ret;
> > > > +
> > > > +	spin_lock_irqsave(&xdma_chan->vchan.lock, flags);
> > > > +
> > > > +	vd =3D vchan_find_desc(&xdma_chan->vchan, cookie);
> > > > +	if (vd)
> > > > +		desc =3D to_xdma_desc(vd);   =20
> > >=20
> > > vd is not used in below check, so should be done after below checks, =
why
> > > do this for cyclic case? =20
> >=20
> > I'm not sure I get this comment. vd is my way to get the descriptor,
> > and I need the descriptor to know whether we are in a cyclic transfer
> > or not. If the transfer is not cyclic, I just return the value from
> > dma_cookie_status() like before, otherwise I update the residue based
> > on the content of desc.
> >=20
> > Maybe I don't understand what you mean, would you mind explaining it
> > again? =20
>=20
> Sorry I am not sure what I was thinking, this looks fine, we need the
> lock to get the desc and use it

Ah ok, no problem :) I'll send the v3 with the missing kernel doc line
(kernel test robot report).

Thanks,
Miqu=C3=A8l
