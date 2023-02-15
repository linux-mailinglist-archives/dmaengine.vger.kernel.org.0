Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D867D697B44
	for <lists+dmaengine@lfdr.de>; Wed, 15 Feb 2023 13:00:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233100AbjBOMA0 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 15 Feb 2023 07:00:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230099AbjBOMA0 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 15 Feb 2023 07:00:26 -0500
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E02B73525F;
        Wed, 15 Feb 2023 04:00:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1676462423; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WE9ZsOz9nkCLMHmGO7Utnw1e7S4ivYjTnZ5PFRZQvVQ=;
        b=pdXH5sfaJkR0EJBO6MZH5lk6QeDYb0fJU+J47GYDN2+d3pICMDjCdo8yU67nW8Mmd+RUra
        Fvgt+lNqkiIGuYmTIKxMhp5P1duKZGQhLK/j3SgOXOniNJoVIMNgew+oKr7zX72xesBdxA
        zBdJJjCg/OZqCTU63e0xdComHJPadr4=
Message-ID: <77fc4dec6738d57ae6ca6232e502e3b228b1ae03.camel@crapouillou.net>
Subject: Re: Question: partial transfers of DMABUFs
From:   Paul Cercueil <paul@crapouillou.net>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Vinod Koul <vkoul@kernel.org>
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org
Date:   Wed, 15 Feb 2023 12:00:20 +0000
In-Reply-To: <05fb3949-d0aa-b653-d9a3-236a4c95a5a3@linux.intel.com>
References: <53ea4d2db570d3ca514a69015488bd5b849a5193.camel@crapouillou.net>
         <836d600a-bb1c-fbb2-89f5-7c79c3150e8c@linux.intel.com>
         <d540965a25138772fa063d62e907ffd611f93205.camel@crapouillou.net>
         <05fb3949-d0aa-b653-d9a3-236a4c95a5a3@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Maarten,

Le mercredi 15 f=C3=A9vrier 2023 =C3=A0 12:52 +0100, Maarten Lankhorst a =
=C3=A9crit=C2=A0:
> Hey,
>=20
> On 2023-02-15 12:47, Paul Cercueil wrote:
> > Hi Maarten,
> >=20
> > Le mercredi 15 f=C3=A9vrier 2023 =C3=A0 12:30 +0100, Maarten Lankhorst =
a
> > =C3=A9crit=C2=A0:
> > > Hey,
> > >=20
> > > On 2023-02-15 11:48, Paul Cercueil wrote:
> > > > Hi,
> > > >=20
> > > > I am working on adding support for DMABUFs in the IIO
> > > > subsystem.
> > > >=20
> > > > One thing we want there, is the ability to specify the number
> > > > of
> > > > bytes
> > > > to transfer (while still defaulting to the DMABUF size).
> > > >=20
> > > > Since dma_buf_map_attachment() returns a sg_table, I basically
> > > > have
> > > > two
> > > > options, and I can't decide which one is the best (or the less
> > > > ugly):
> > > >=20
> > > > - Either I add a new API function similar to
> > > > dmaengine_prep_slave_sg(),
> > > > which still takes a scatterlist as argument but also takes the
> > > > number
> > > > of bytes as argument;
> > > >=20
> > > > - Or I add a function to duplicate the scatterlist and then
> > > > shrink
> > > > it
> > > > manually, which doesn't sound like a good idea either.
> > > >=20
> > > > What would be the recommended way?
> > > Does this need an api change? If you create a DMA-BUF of size X,
> > > it
> > > has
> > > to be of size X. You can pad with a dummy page probably if you
> > > know
> > > it
> > > in advance. But after it has been imported, it cannot change
> > > size.
> > Yes, the sizes are fixed.
> >=20
> > > You don=C2=B4t have to write the entire dma-buf either, so if you wan=
t
> > > to
> > > create a 1GB buf and only use the first 4K, that is allowed. The
> > > contents of=C2=A0 the remainder of the DMA-BUF are undefined. It's up
> > > to
> > > userspace to assign a meaning to it.
> > >=20
> > > I think I'm missing something here that makes the whole question
> > > m,ake
> > > more sense.
> > I want my userspace to be able to specify how much of the DMABUF is
> > to
> > be read from or written to.
> >=20
> > So in my new "dmabuf enqueue" IOCTL that I want to add to IIO, I
> > added
> > a parameter to specify the number of bytes to transfer (where 0
> > means
> > the whole buffer).
> >=20
> > The problem I have now, is that the current dmaengine core does not
> > have a API function that takes a scatterlist (returned by
> > dma_map_attachment()) and a transfer size in bytes, it will always
> > transfer the whole scatterlist.
> >=20
> > So my two options would be to add a new API function to support
> > specifying a bytes count, or add a mechanism to duplicate a
> > scatterlist, so that I can tweak it to the right size.
>=20
> This doesn't have to happen through DMA-BUF. Presumably you are both
> the=20
> importer and the exporter, so after you know how much is read, you
> can=20
> tell this to the importer that X number of bytes can be read from
> DMA-BUF Y.

Yes, I do that already as it is an argument in my ioctl.

> In your case, when enqueing you will get a full SG list, but if you
> know=20
> only X bytes are read/written you only have to map the first X bytes
> to=20
> your IIO device. The rest of the SG list could be ignored safely.

Yes. But I don't know how to "ignore the rest of the SG list".

- dma_buf_map_attachment() does not have a parameter to specify that I
only need the first X bytes mapped;

- if I map the whole thing, dmaengine_prep_slave_sg() does not have an
option to specify that I only want the first X bytes transferred.

-Paul
