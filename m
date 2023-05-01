Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD0BB6F336F
	for <lists+dmaengine@lfdr.de>; Mon,  1 May 2023 18:09:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232606AbjEAQJV (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 1 May 2023 12:09:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231229AbjEAQJU (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 1 May 2023 12:09:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B4C6C3;
        Mon,  1 May 2023 09:09:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DB2C860FDA;
        Mon,  1 May 2023 16:09:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E49CAC433D2;
        Mon,  1 May 2023 16:09:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682957358;
        bh=FpX1zNwZQzmzSkTPVq4PcLD3xWjdT3sXy6nTbjcK06Q=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=nFPnn1MdR23QP0io14jeQsK8WBK8E0y7G8G37buFvBxFvbHWDdKo76elxOU+pZInP
         VL0YOYaYclgnWfZhctvmv9H4En4qjRie3Zbr96Ca55KFhtGPM84yPV9a0WZ6DDO3j7
         rrB4o/1uO19CtnzLgJnxkQmjdwER4TWZImzkK8LKEtpqvcLwGIic1PwDIJ06j8r/ck
         lP3a1u9WwXwm2m1Eg8cXo+IkrcypCIsiusgB/dDJ50wnhhQK4OHqPzucqRbWKUBxA2
         /t2uqEi80OMTxnUe9y42Bf40xd8zkq8NIWjOIvTtqCFBRrGyeeGm4mHydH6+9OH97O
         cDQFyymLTnZWQ==
Date:   Mon, 1 May 2023 17:25:02 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Vinod Koul <vkoul@kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-media@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org
Subject: Re: [PATCH v3 03/11] iio: buffer-dma: Get rid of outgoing queue
Message-ID: <20230501172502.125e4859@jic23-huawei>
In-Reply-To: <1f63ffced9ed18309401af9a885310e1715b6538.camel@crapouillou.net>
References: <20230403154800.215924-1-paul@crapouillou.net>
        <20230403154800.215924-4-paul@crapouillou.net>
        <20230416152422.477ecf67@jic23-huawei>
        <1f63ffced9ed18309401af9a885310e1715b6538.camel@crapouillou.net>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Tue, 18 Apr 2023 10:08:21 +0200
Paul Cercueil <paul@crapouillou.net> wrote:

> Hi Jonathan,
>=20
> Le dimanche 16 avril 2023 =C3=A0 15:24 +0100, Jonathan Cameron a =C3=A9cr=
it=C2=A0:
> > On Mon,=C2=A0 3 Apr 2023 17:47:52 +0200
> > Paul Cercueil <paul@crapouillou.net> wrote:
> >  =20
> > > The buffer-dma code was using two queues, incoming and outgoing, to
> > > manage the state of the blocks in use.
> > >=20
> > > While this totally works, it adds some complexity to the code,
> > > especially since the code only manages 2 blocks. It is much easier
> > > to
> > > just check each block's state manually, and keep a counter for the
> > > next
> > > block to dequeue.
> > >=20
> > > Since the new DMABUF based API wouldn't use the outgoing queue
> > > anyway,
> > > getting rid of it now makes the upcoming changes simpler.
> > >=20
> > > With this change, the IIO_BLOCK_STATE_DEQUEUED is now useless, and
> > > can
> > > be removed.
> > >=20
> > > Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> > >=20
> > > ---
> > > v2: - Only remove the outgoing queue, and keep the incoming queue,
> > > as we
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 want the buffer to start streaming dat=
a as soon as it is
> > > enabled.
> > > =C2=A0=C2=A0=C2=A0 - Remove IIO_BLOCK_STATE_DEQUEUED, since it is now=
 functionally
> > > the
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 same as IIO_BLOCK_STATE_DONE. =20
> >=20
> > I'm not that familiar with this code, but with my understanding this
> > makes
> > sense.=C2=A0=C2=A0 I think it is independent of the earlier patches and=
 is a
> > useful
> > change in it's own right.=C2=A0 As such, does it make sense to pick this
> > up
> > ahead of the rest of the series? I'm assuming that discussion on the
> > rest will take a while.=C2=A0 No great rush as too late for the coming
> > merge
> > window anyway. =20
>=20
> Actually, you can pick patches 3 to 6 (when all have been acked). They
> add write support for buffer-dma implementations; which is a dependency
> for the rest of the patchset, but they can live on their own.

Remind me of that in the cover letter for v4.

Thanks,

Jonathan

>=20
> Cheers,
> -Paul

