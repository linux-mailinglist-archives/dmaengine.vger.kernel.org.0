Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC5567B64EA
	for <lists+dmaengine@lfdr.de>; Tue,  3 Oct 2023 11:03:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231360AbjJCJDF (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 3 Oct 2023 05:03:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239299AbjJCJDE (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 3 Oct 2023 05:03:04 -0400
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::222])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ADA1AB;
        Tue,  3 Oct 2023 02:03:01 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id B7A974000B;
        Tue,  3 Oct 2023 09:02:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1696323780;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=10eDGalXqUFx1plS+nqHC9qTy/c98P26lcDQXh/vEcM=;
        b=Osw/i3JU9VGknE2CuivGOzHuNithMhN/CSNQublSeSj1D6G/boY+iGmuvLRD+bUxxzAJAF
        bp7xDpHnwu1ZIFNNo14sY9OBnF6prOXHq5IXiAmJId1HTrEcLJ0ISOVtMBzoXJhlj+OOo8
        EYeS7GgXHazgWn6d6JkywLJHCQHTs2rwNLfow5JtHsTRLvPXb1tT2azbYgDxGKrE2m9D+5
        bPopaLx6QkU7YjxAOZhQ9ssL8BrFXDT9Tm5LXiVgidWI4+SqVDsR8ZjffEQWGuucBPncm+
        vXjwSUAsHdlmYsi3p0SZjyMJxFBosTori59OfuUiWVKVZ6mKy/HCuQC/45miag==
Date:   Tue, 3 Oct 2023 11:02:56 +0200
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
Message-ID: <20231003110256.44286fcd@xps-13>
In-Reply-To: <ZRVbZwQz13hL2QfY@matsya>
References: <20230922162056.594933-1-miquel.raynal@bootlin.com>
        <20230922162056.594933-3-miquel.raynal@bootlin.com>
        <ZRVbZwQz13hL2QfY@matsya>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Vinod,

Thanks for the feedback.

vkoul@kernel.org wrote on Thu, 28 Sep 2023 16:24:31 +0530:

> On 22-09-23, 18:20, Miquel Raynal wrote:
>=20
> > @@ -583,7 +690,36 @@ static int xdma_alloc_chan_resources(struct dma_ch=
an *chan)
> >  static enum dma_status xdma_tx_status(struct dma_chan *chan, dma_cooki=
e_t cookie,
> >  				      struct dma_tx_state *state)
> >  {
> > -	return dma_cookie_status(chan, cookie, state);
> > +	struct xdma_chan *xdma_chan =3D to_xdma_chan(chan);
> > +	struct xdma_desc *desc =3D NULL;
> > +	struct virt_dma_desc *vd;
> > +	enum dma_status ret;
> > +	unsigned long flags;
> > +	unsigned int period_idx;
> > +	u32 residue =3D 0;
> > +
> > +	ret =3D dma_cookie_status(chan, cookie, state);
> > +	if (ret =3D=3D DMA_COMPLETE)
> > +		return ret;
> > +
> > +	spin_lock_irqsave(&xdma_chan->vchan.lock, flags);
> > +
> > +	vd =3D vchan_find_desc(&xdma_chan->vchan, cookie);
> > +	if (vd)
> > +		desc =3D to_xdma_desc(vd); =20
>=20
> vd is not used in below check, so should be done after below checks, why
> do this for cyclic case?

I'm not sure I get this comment. vd is my way to get the descriptor,
and I need the descriptor to know whether we are in a cyclic transfer
or not. If the transfer is not cyclic, I just return the value from
dma_cookie_status() like before, otherwise I update the residue based
on the content of desc.

Maybe I don't understand what you mean, would you mind explaining it
again?

> Otherwise series lgtm, just fix the error reported by test bot

I will.

>=20
> > +	if (!desc || !desc->cyclic) {
> > +		spin_unlock_irqrestore(&xdma_chan->vchan.lock, flags);
> > +		return ret;
> > +	} =20


Thanks,
Miqu=C3=A8l
