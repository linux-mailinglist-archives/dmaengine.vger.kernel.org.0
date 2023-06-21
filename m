Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 538957384C4
	for <lists+dmaengine@lfdr.de>; Wed, 21 Jun 2023 15:20:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231951AbjFUNUI (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 21 Jun 2023 09:20:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232495AbjFUNTz (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 21 Jun 2023 09:19:55 -0400
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8619A19AB;
        Wed, 21 Jun 2023 06:19:52 -0700 (PDT)
X-GND-Sasl: kory.maincent@bootlin.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1687353591;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HD60J9yNUWQtovHBK58Ljzap9glKZqstLAMvvb+CDq4=;
        b=AsSVdH7xN7OxkE6Lyw5uuEZfIZ7nELMTasIUsBCVNAE1HX391bsMmrPLYYQyuKGAfyea0G
        r/V7zHgOCJnHrcMolZEg1Gpd3XGqMotYchfVnbXM5sF71y1LAMMy1WRJaMKUd6haGXyI6l
        rL4ApEGON5ardvN5Tjyxg8/Nd2L+mOyyMNs6cM4KKX790aN1Gu7wvG3bTiKjldOF2U86c1
        hGnByFB8CGGMIOlVPHb0WKuz0jl+Fu9QEFu17b0cWsTd/8bMuwLdQVPkBCxbDnEZs0F5Mc
        yV1GZ+qTwrr2E8GpUWYvUsELpDrMX3vwcOOUAKD6HFvBTfL6gIU5oG1aI5mTbA==
X-GND-Sasl: kory.maincent@bootlin.com
X-GND-Sasl: kory.maincent@bootlin.com
X-GND-Sasl: kory.maincent@bootlin.com
X-GND-Sasl: kory.maincent@bootlin.com
X-GND-Sasl: kory.maincent@bootlin.com
X-GND-Sasl: kory.maincent@bootlin.com
X-GND-Sasl: kory.maincent@bootlin.com
X-GND-Sasl: kory.maincent@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id CB79DE0005;
        Wed, 21 Jun 2023 13:19:49 +0000 (UTC)
Date:   Wed, 21 Jun 2023 15:19:48 +0200
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
Message-ID: <20230621151948.36125997@kmaincent-XPS-13-7390>
In-Reply-To: <qwkwtsjmfkmvsx4pmjetoxkjrpuwkndm6h6ntkpehxutz2h2jm@bmdzt7ywiuvs>
References: <20230609081654.330857-1-kory.maincent@bootlin.com>
 <20230609081654.330857-5-kory.maincent@bootlin.com>
 <20230619170201.5hbgte2optjlbx55@mobilestation.baikal.int>
 <20230619203207.694bfac6@kmaincent-XPS-13-7390>
 <tpowhctppelni47dosc27cg4vmzwdqnuvf3rukvmju2guoxzsr@wgxomqzfv6ch>
 <20230620153006.036ca3ba@kmaincent-XPS-13-7390>
 <qwkwtsjmfkmvsx4pmjetoxkjrpuwkndm6h6ntkpehxutz2h2jm@bmdzt7ywiuvs>
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

On Wed, 21 Jun 2023 12:45:35 +0300
Serge Semin <fancer.lancer@gmail.com> wrote:

> > I thought that using a read will solve the issue like the gpio_nand dri=
ver
> > (gpio_nand_dosync)  =20
>=20
> AFAICS The io_sync dummy-read there is a workaround to fix the
> bus-reordering within the SoC bus. In this case we have a PCIe bus
> which is supposed to guarantee the strong order with the exception I
> described above or unless there is a bug someplace in the PCIe fabric.
>=20
> > but I didn't thought of a cache that could return the value
> > of the read even if the write doesn't fully happen. In the case of a ca=
che
> > how could we know that the write is done without using a delay?  =20
>=20
> MMIO mapping is platform dependent and low-level driver dependent.
> That's why I asked many times about the platform you are using and the
> low-level driver that probes the eDMA engine. It would be also useful
> to know what PCIe host controller is utilized too.
>=20
> Mainly MMIO spaces are mapped in a way to bypass the caching. But in
> some cases it might be useful to map an MMIO space with additional
> optimizations like Write-combining. For instance it could be
> effectively done for the eDMA linked-list BAR mapping. Indeed why
> would you need to send each linked-list byte/word/dword right away to
> the device while you can combine them and send all together, then
> flush the cache and only after that start the DMA transfer? Another
> possible reason of the writes reordering could be in a way the PCIe
> host outbound memory window (a memory region accesses to which are
> translated to the PCIe bus transfers) is configured. For instance DW
> PCIe Host controller outbound MW config CSR has a special flag which
> enables setting a custom PCIe bus TLPs (packets) attribute. As I
> mentioned above that attribute can affect the TLPs order: make it
> relaxed or ID-based.
>=20
> Of course we can't reject a possibility of having some delays hidden
> inside your device which may cause writes to the internal memory
> landing after the writes to the CSRs. But that seems too exotic to be
> considered as the real one for sure until the alternatives are
> thoroughly checked.
>=20
> What I was trying to say that your problem can be caused by some much
> more frequently met reason. If I were you I would have checked them
> first and only then considered a workaround like you suggest.

Thanks for you detailed answer, this was instructive.
I will come back with more information if TLP flags are set.
FYI the PCIe board I am currently working with is the one from Brainchip:
Here is the driver:
https://github.com/Brainchip-Inc/akida_dw_edma

K=C3=B6ry
