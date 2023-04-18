Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6FD56E5BAB
	for <lists+dmaengine@lfdr.de>; Tue, 18 Apr 2023 10:10:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229706AbjDRIKP (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 18 Apr 2023 04:10:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231502AbjDRIJz (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 18 Apr 2023 04:09:55 -0400
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 318907A99;
        Tue, 18 Apr 2023 01:09:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1681805303;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8DTc/oRJhMEBa33wB3TaMgkNKc15dOmlHK8alGfdcJk=;
        b=i2y5XYqQS4KdTNNlpdITBztyfUED78n/aM0a3L19IR0dztlNgHD4h8kG3hHLJb6PE4BHyh
        BHoN5d/SlAU8cwhrU+rUiz49RLxT/CSXxujr6Onaz2R1d5d35D14IgL/OTfA4/HlL3/KGZ
        wp5ZiCeGY69eCgNlIg3o3Qf0vNWzzVk=
Message-ID: <1f63ffced9ed18309401af9a885310e1715b6538.camel@crapouillou.net>
Subject: Re: [PATCH v3 03/11] iio: buffer-dma: Get rid of outgoing queue
From:   Paul Cercueil <paul@crapouillou.net>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Vinod Koul <vkoul@kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-media@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org
Date:   Tue, 18 Apr 2023 10:08:21 +0200
In-Reply-To: <20230416152422.477ecf67@jic23-huawei>
References: <20230403154800.215924-1-paul@crapouillou.net>
         <20230403154800.215924-4-paul@crapouillou.net>
         <20230416152422.477ecf67@jic23-huawei>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Jonathan,

Le dimanche 16 avril 2023 =C3=A0 15:24 +0100, Jonathan Cameron a =C3=A9crit=
=C2=A0:
> On Mon,=C2=A0 3 Apr 2023 17:47:52 +0200
> Paul Cercueil <paul@crapouillou.net> wrote:
>=20
> > The buffer-dma code was using two queues, incoming and outgoing, to
> > manage the state of the blocks in use.
> >=20
> > While this totally works, it adds some complexity to the code,
> > especially since the code only manages 2 blocks. It is much easier
> > to
> > just check each block's state manually, and keep a counter for the
> > next
> > block to dequeue.
> >=20
> > Since the new DMABUF based API wouldn't use the outgoing queue
> > anyway,
> > getting rid of it now makes the upcoming changes simpler.
> >=20
> > With this change, the IIO_BLOCK_STATE_DEQUEUED is now useless, and
> > can
> > be removed.
> >=20
> > Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> >=20
> > ---
> > v2: - Only remove the outgoing queue, and keep the incoming queue,
> > as we
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 want the buffer to start streaming data =
as soon as it is
> > enabled.
> > =C2=A0=C2=A0=C2=A0 - Remove IIO_BLOCK_STATE_DEQUEUED, since it is now f=
unctionally
> > the
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 same as IIO_BLOCK_STATE_DONE.
>=20
> I'm not that familiar with this code, but with my understanding this
> makes
> sense.=C2=A0=C2=A0 I think it is independent of the earlier patches and i=
s a
> useful
> change in it's own right.=C2=A0 As such, does it make sense to pick this
> up
> ahead of the rest of the series? I'm assuming that discussion on the
> rest will take a while.=C2=A0 No great rush as too late for the coming
> merge
> window anyway.

Actually, you can pick patches 3 to 6 (when all have been acked). They
add write support for buffer-dma implementations; which is a dependency
for the rest of the patchset, but they can live on their own.

Cheers,
-Paul
