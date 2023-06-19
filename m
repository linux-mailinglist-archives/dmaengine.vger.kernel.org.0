Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43FCA735D7B
	for <lists+dmaengine@lfdr.de>; Mon, 19 Jun 2023 20:32:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231513AbjFSScN (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 19 Jun 2023 14:32:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229905AbjFSScN (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 19 Jun 2023 14:32:13 -0400
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 600CDA1;
        Mon, 19 Jun 2023 11:32:11 -0700 (PDT)
X-GND-Sasl: kory.maincent@bootlin.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1687199530;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=T/NwIRSg3iYEl1RCA7FiGA0xnWHRUBsn4kGqKe1PHlM=;
        b=omm8uuE2OftZI/YVGBcwfdREeIljc21tAVUn+5JCyfn0b5slSmkkf42SJSAsgrqPw8jB97
        57iCB4dGmun75SoX/SrbGR/Kf4seHwNDehdlkNLMLTcJw7XFk35LCYX8KJw6TUZvCcOaow
        KGH33MyrYK2dDYfq1cJ5K5NHb+3DmevZVOzg4W0L9iThsbw3PZCky2TRz7gwVd0StBhgbm
        x60miT7nDJF1CBHHW9DrWYW7q5pBOLtj0+ZHHKvT03t/FnG2xMUwFUk8hrJwNbMy1bTHOi
        jPZFpFRQsuuKmWUesFehSbzyrKbGGmXYUEp6q77JCIbBMZoNXGkKFccrxRbTBQ==
X-GND-Sasl: kory.maincent@bootlin.com
X-GND-Sasl: kory.maincent@bootlin.com
X-GND-Sasl: kory.maincent@bootlin.com
X-GND-Sasl: kory.maincent@bootlin.com
X-GND-Sasl: kory.maincent@bootlin.com
X-GND-Sasl: kory.maincent@bootlin.com
X-GND-Sasl: kory.maincent@bootlin.com
X-GND-Sasl: kory.maincent@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id E612020003;
        Mon, 19 Jun 2023 18:32:08 +0000 (UTC)
Date:   Mon, 19 Jun 2023 20:32:07 +0200
From:   =?UTF-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>
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
Message-ID: <20230619203207.694bfac6@kmaincent-XPS-13-7390>
In-Reply-To: <20230619170201.5hbgte2optjlbx55@mobilestation.baikal.int>
References: <20230609081654.330857-1-kory.maincent@bootlin.com>
        <20230609081654.330857-5-kory.maincent@bootlin.com>
        <20230619170201.5hbgte2optjlbx55@mobilestation.baikal.int>
Organization: bootlin
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Mon, 19 Jun 2023 20:02:01 +0300
Serge Semin <fancer.lancer@gmail.com> wrote:

> On Fri, Jun 09, 2023 at 10:16:49AM +0200, K=C3=B6ry Maincent wrote:
> > From: Kory Maincent <kory.maincent@bootlin.com>
> >  =20
>=20
> > The Linked list element and pointer are not stored in the same memory as
> > the HDMA controller register. If the doorbell register is toggled before
> > the full write of the linked list a race condition error can appears.
> > In remote setup we can only use a readl to the memory to assured the fu=
ll
> > write has occurred.
> >=20
> > Fixes: e74c39573d35 ("dmaengine: dw-edma: Add support for native HDMA")
> > Signed-off-by: Kory Maincent <kory.maincent@bootlin.com> =20
>=20
> Is this a hypothetical bug? Have you actually experienced the
> described problem? If so are you sure that it's supposed to be fixed
> as you suggest?

I do experienced this problem and this patch fixed it.

>=20
> I am asking because based on the kernel doc
> (Documentation/memory-barriers.txt):
>=20
> *    1. All readX() and writeX() accesses to the same peripheral are orde=
red
> *       with respect to each other. This ensures that MMIO register acces=
ses
> *       by the same CPU thread to a particular device will arrive in prog=
ram
> *       order.
> * ...
> * The ordering properties of __iomem pointers obtained with non-default
> * attributes (e.g. those returned by ioremap_wc()) are specific to the
> * underlying architecture and therefore the guarantees listed above cannot
> * generally be relied upon for accesses to these types of mappings.
>=20
> the IOs performed by the accessors are supposed to arrive in the
> program order. Thus SET_CH_32(..., HDMA_V0_DOORBELL_START) performed
> after all the previous SET_CH_32(...) are finished looks correct with
> no need in additional barriers. The results of the later operations
> are supposed to be seen by the device (in our case it's a remote DW
> eDMA controller) before the doorbell update from scratch. From that
> perspective your problem looks as if the IO operations preceding the
> doorbell CSR update aren't finished yet. So you are sure that the LL
> memory is mapped with no additional flags like Write-Combine or some
> caching optimizations? Are you sure that the PCIe IOs are correctly
> implemented in your platform?

No, I don't know if there is extra flags or optimizations.

>=20
> I do understand that the eDMA CSRs and the LL memory are mapped by
> different BARs in the remote eDMA setup. But they still belong to the
> same device. So the IO accessors semantic described in the kernel doc
> implies no need in additional barrier.

Even if they are on the same device it is two type of memory.
I am not an PCIe expert but I suppose the PCIe controller of the board is
sending to both memory and if one of them (LL memory here) is slower in the
write process then we faced this race issue. We can not find out that the w=
rite
to LL memory has finished before the CSRs even if the write command has been
sent earlier.

K=C3=B6ry,
