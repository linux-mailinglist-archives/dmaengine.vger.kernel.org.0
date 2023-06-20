Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83729736D62
	for <lists+dmaengine@lfdr.de>; Tue, 20 Jun 2023 15:30:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232891AbjFTNaS (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 20 Jun 2023 09:30:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232473AbjFTNaR (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 20 Jun 2023 09:30:17 -0400
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 406FB188;
        Tue, 20 Jun 2023 06:30:09 -0700 (PDT)
X-GND-Sasl: kory.maincent@bootlin.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1687267808;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DPOr629AwqhuK4eWRGDMUfjS0QtiwkNcXPGNugT4mYk=;
        b=S8+eh6cpEmMe6nuNvstiIpbEhVI4UZtoWhb1JHbjaXLj0iZj2OLO48lGDySiIismD2+emT
        OD4MG7k8PmjCWUTzbyJu9MzHTxjbmV28KzxiyH0w9YicRhEOiIVUT5BkUW7o/srzPfdday
        bqKy94Ml6Ad/rfHiDzQHhJM6/8mYmW9Ohhrr6IQVBCM1BVU1VW+ghLykWwUrgiPo10jQMB
        hMXCXa/xnm8ZL4fAKqL+WGLAN2vnfiigVmxsDldMUE89rvgRpESOCBAgEy3A12P32KK/rA
        prmgTvuI6Rv8JWnGbcquorr9/jWZ6So/RKV+wNeScgliPYG3o5kwhyVCEmvQ1A==
X-GND-Sasl: kory.maincent@bootlin.com
X-GND-Sasl: kory.maincent@bootlin.com
X-GND-Sasl: kory.maincent@bootlin.com
X-GND-Sasl: kory.maincent@bootlin.com
X-GND-Sasl: kory.maincent@bootlin.com
X-GND-Sasl: kory.maincent@bootlin.com
X-GND-Sasl: kory.maincent@bootlin.com
X-GND-Sasl: kory.maincent@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 19CEFC0014;
        Tue, 20 Jun 2023 13:30:06 +0000 (UTC)
Date:   Tue, 20 Jun 2023 15:30:06 +0200
From:   =?UTF-8?Q?K=C3=B6ry?= Maincent <kory.maincent@bootlin.com>
To:     Serge Semin <fancer.lancer@gmail.com>
Cc:     Cai Huoqing <cai.huoqing@linux.dev>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Herve Codina <herve.codina@bootlin.com>
Subject: Re: [PATCH 4/9] dmaengine: dw-edma: HDMA: Add memory barrier before
 starting the DMA transfer in remote setup
Message-ID: <20230620153006.036ca3ba@kmaincent-XPS-13-7390>
In-Reply-To: <tpowhctppelni47dosc27cg4vmzwdqnuvf3rukvmju2guoxzsr@wgxomqzfv6ch>
References: <20230609081654.330857-1-kory.maincent@bootlin.com>
        <20230609081654.330857-5-kory.maincent@bootlin.com>
        <20230619170201.5hbgte2optjlbx55@mobilestation.baikal.int>
        <20230619203207.694bfac6@kmaincent-XPS-13-7390>
        <tpowhctppelni47dosc27cg4vmzwdqnuvf3rukvmju2guoxzsr@wgxomqzfv6ch>
Organization: bootlin
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Tue, 20 Jun 2023 14:45:40 +0300
Serge Semin <fancer.lancer@gmail.com> wrote:

> On Mon, Jun 19, 2023 at 08:32:07PM +0200, K=C3=B6ry Maincent wrote:
> > On Mon, 19 Jun 2023 20:02:01 +0300
> > Serge Semin <fancer.lancer@gmail.com> wrote:
> >  =20
> > > On Fri, Jun 09, 2023 at 10:16:49AM +0200, K=C3=B6ry Maincent wrote: =
=20
> > > > From: Kory Maincent <kory.maincent@bootlin.com>
> > > >    =20
> > >  =20
> > > > The Linked list element and pointer are not stored in the same memo=
ry as
> > > > the HDMA controller register. If the doorbell register is toggled b=
efore
> > > > the full write of the linked list a race condition error can appear=
s.
> > > > In remote setup we can only use a readl to the memory to assured the
> > > > full write has occurred.
> > > >=20
> > > > Fixes: e74c39573d35 ("dmaengine: dw-edma: Add support for native HD=
MA")
> > > > Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>   =20
> > >=20
> > > Is this a hypothetical bug? Have you actually experienced the
> > > described problem? If so are you sure that it's supposed to be fixed
> > > as you suggest? =20
> >  =20
>=20
> > I do experienced this problem and this patch fixed it. =20
>=20
> Could you give more details of how often does it happen? Is it stably
> reproducible or does it happen at very rare occasion?

I have a test example that run DMA stress transfer in 3 threads and
the issue appear in only few transfers but each time I run my test.


> > > I am asking because based on the kernel doc
> > > (Documentation/memory-barriers.txt):
> > >=20
> > > *    1. All readX() and writeX() accesses to the same peripheral are
> > > ordered
> > > *       with respect to each other. This ensures that MMIO register
> > > accesses
> > > *       by the same CPU thread to a particular device will arrive in
> > > program
> > > *       order.
> > > * ...
> > > * The ordering properties of __iomem pointers obtained with non-defau=
lt
> > > * attributes (e.g. those returned by ioremap_wc()) are specific to the
> > > * underlying architecture and therefore the guarantees listed above c=
annot
> > > * generally be relied upon for accesses to these types of mappings.
> > >=20
> > > the IOs performed by the accessors are supposed to arrive in the
> > > program order. Thus SET_CH_32(..., HDMA_V0_DOORBELL_START) performed
> > > after all the previous SET_CH_32(...) are finished looks correct with
> > > no need in additional barriers. The results of the later operations
> > > are supposed to be seen by the device (in our case it's a remote DW
> > > eDMA controller) before the doorbell update from scratch. From that
> > > perspective your problem looks as if the IO operations preceding the
> > > doorbell CSR update aren't finished yet. So you are sure that the LL
> > > memory is mapped with no additional flags like Write-Combine or some
> > > caching optimizations? Are you sure that the PCIe IOs are correctly
> > > implemented in your platform? =20
> >=20
> > No, I don't know if there is extra flags or optimizations. =20
>=20
> Well, I can't know that either.) The only one who can figure it out is
> you, at least at this stage (I doubt Gustavo will ever get back to
> reviewing and testing the driver on his remote eDMA device). I can
> help if you provide some more details about the platform you are
> using, about the low-level driver (is it
> drivers/dma/dw-edma/dw-edma-pcie.o?) which gets to detect the DW eDMA
> remote device and probes it by the DW eDMA core.

No it is another custom driver but also communicating through PCIe. In fact=
 I
have a contact to the FPGA designer, I will ask them.

>=20
> * Though I don't have hardware with the remote DW eDMA setup to try to
> reproduce and debug the problem discovered by you.
>=20
> >  =20
> > >=20
> > > I do understand that the eDMA CSRs and the LL memory are mapped by
> > > different BARs in the remote eDMA setup. But they still belong to the
> > > same device. So the IO accessors semantic described in the kernel doc
> > > implies no need in additional barrier. =20
> >=20
> > Even if they are on the same device it is two type of memory. =20
>=20
> What do you mean by "two types of memory"? From the CPU perspective
> they are the same. Both are mapped via MMIO by means of a PCIe Root
> Port outbound memory window.

I was meaning hardware memory. Yes they are mapped via MMIO, but they are
mapped to two different BAR which may map the CSRs or the memory where LL
are stored. According to you the write should be ordered but is there a way
to know that the write has succeed?=20


> > I am not an PCIe expert but I suppose the PCIe controller of the board =
is
> > sending to both memory and if one of them (LL memory here) is slower in=
 the
> > write process then we faced this race issue. We can not find out that t=
he
> > write to LL memory has finished before the CSRs even if the write comma=
nd
> > has been sent earlier. =20
>=20
> From your description there is no guarantee that reading from the
> remote device solves the race for sure. If writes have been collected
> in a cache, then the intermediate read shall return a data from the
> cache with no data being flushed to the device memory. It might be
> possible that in your case the read just adds some delay enough for
> some independent activity to flush the cache. Thus the problem you
> discovered may get back in some other circumstance. Moreover based on
> the PCI Express specification "A Posted Request must not pass another
> Posted Request unless a TLP has RO (Relaxed ordering) or IDO (ID-based
> ordering) flag set." So neither intermediate PCIe switches nor the
> PCIe host controller is supposed to re-order simple writes unless the
> Root Port outbound MW is configure to set the denoted flags. In anyway
> all of that is platform specific. So in order to have it figured out
> we need more details from the platform from you.

I thought that using a read will solve the issue like the gpio_nand driver
(gpio_nand_dosync) but I didn't thought of a cache that could return the va=
lue
of the read even if the write doesn't fully happen. In the case of a cache =
how
could we know that the write is done without using a delay?=20

>=20
> Meanwhile:
>=20
> Q1 are you sure that neither dma_wmb() nor io_stop_wc() help to solve
> the problem in your case?

dma_wmb is like wmb and is called by the writel function of the doorbell.
io_stop_wc is doing nothing except or arm64.
Both of these function won't change anything.

> Q2 Does specifying a delay instead of the dummy read before the
> doorbell update solve the problem?

Delaying it for at least 4 us before toggling doorbell solves also the issu=
e.
This seems long for an equivalent of the readl function right?
Wouldn't using a read after the write ask to the PCIe controller to check t=
he
write has happen? It should be written in the PCIe protocol but not sure I =
want
to open the full protocol description document.

K=C3=B6ry
