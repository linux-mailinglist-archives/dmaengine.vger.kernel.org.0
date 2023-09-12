Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2D2C79CAB3
	for <lists+dmaengine@lfdr.de>; Tue, 12 Sep 2023 10:55:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232724AbjILIzu (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 12 Sep 2023 04:55:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232990AbjILIzt (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 12 Sep 2023 04:55:49 -0400
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::223])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD158E7F;
        Tue, 12 Sep 2023 01:55:44 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 58C1960024;
        Tue, 12 Sep 2023 08:52:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1694508943;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=16xgyBLOryMUfKHXzxqMoUfN46hheLieUlRWExzNh+s=;
        b=D6DM6dgWVj47C12ac+Wpi9x4d6OB5VYTkuiSx3fMY6uJ4YZuhmzUka/xR5/80F2rOgN3gx
        ynEe6wlyxInJf/euOO6eZ5VHEI05nYj1We1Oe9MrS1b0o9AlpMR6whww1OViqV9iANWkWQ
        9pBZUWi5u+dwfluSSwLlCapumvtdFL1nkZ9apEkcY1WUpTMJYNSMxMR7ooyZqPQhV8EjFh
        Fvq0bcFQsh16CUIIQGU64NdYaeFveUn6LUA9GKksSckw2E/9/r3N29oR86poBwu0XyzVKP
        tUbnVAAtJVajlqQPD7fTBgJ291pe1dwKM+Nx+e0/B8ZdIOtj3sOU6OH5VnTBsw==
Date:   Tue, 12 Sep 2023 10:52:10 +0200
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
Message-ID: <20230912105152.42cf1454@kmaincent-XPS-13-7390>
In-Reply-To: <phrpjn5dtqfo2fwjlkrsepjl4mgmjc24skpvcjo43g3p5sjv3g@mfzvfz7ygdad>
References: <20230609081654.330857-1-kory.maincent@bootlin.com>
        <20230609081654.330857-5-kory.maincent@bootlin.com>
        <20230619170201.5hbgte2optjlbx55@mobilestation.baikal.int>
        <20230619203207.694bfac6@kmaincent-XPS-13-7390>
        <tpowhctppelni47dosc27cg4vmzwdqnuvf3rukvmju2guoxzsr@wgxomqzfv6ch>
        <20230620153006.036ca3ba@kmaincent-XPS-13-7390>
        <qwkwtsjmfkmvsx4pmjetoxkjrpuwkndm6h6ntkpehxutz2h2jm@bmdzt7ywiuvs>
        <20230621151948.36125997@kmaincent-XPS-13-7390>
        <ti6avu3xdrw7rjwskmemuxu4tcerfq3wd3y4c4v26pbjqjcs5h@izqmikcjsv56>
        <20230622171203.6857b918@kmaincent-XPS-13-7390>
        <phrpjn5dtqfo2fwjlkrsepjl4mgmjc24skpvcjo43g3p5sjv3g@mfzvfz7ygdad>
Organization: bootlin
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: kory.maincent@bootlin.com
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hello Serge,

I am back with an hardware design answer:
> "Even though the PCIe itself respects the transactions ordering, the=20
> AXI bus does not have an end-to-end completion acknowledgement (it
> terminates at the PCIe EP boundary with bus), and does not guaranteed
> ordering if accessing different destinations on the Bus. So, an access to=
 LL
> could be declared complete even though the transactions is still being
> pipelined in the AXI Bus. (a dozen or so clocks, I can give an accurate
> number if needed)
>=20
> The access to DMA registers is done through BAR0 =E2=80=9Crolling=E2=80=9D
> so the transaction does not actually go out on the AXI bus and
> looped-back to PCIe DMA, rather it stays inside the PCIe EP.
>=20
> For the above reasons, hypothetically, there=E2=80=99s a chance that even=
 if the DMA
> LL is accessed before the DM DB from PCIe RC side, the DB could be updated
> before the LL in local memory."

On Thu, 22 Jun 2023 19:22:20 +0300
Serge Semin <fancer.lancer@gmail.com> wrote:
=20
> If we get assured that hardware with such problem exists (if you'll get
> confirmation about the supposition 3. above) then we'll need to
> activate your trick for that hardware only. Adding dummy reads for all
> the remote eDMA setups doesn't look correct since it adds additional
> delay to the execution path and especially seeing nobody has noticed
> and reported such problem so far (for instance Gustavo didn't see the
> problem on his device otherwise he would have fixed it).
>=20
> So if assumption 3. is correct then I'd suggest the next
> implementation: add a new dw_edma_chip_flags flag defined (a.k.a
> DW_EDMA_SLOW_MEM), have it specified via the dw_edma_chip.flags field
> in the Akida device probe() method and activate your trick only if
> that flag is set.

The flag you suggested is about slow memory write but as said above the iss=
ue
comes from the AXI bus and not the memory. I am wondering why you don't see
this issue. If I understand well it should be present on all IP as the DMA
register is internal to the IP and the LL memory is external through AXI bu=
s.
Did you stress your IP? On my side it appears with lots of operation using
several (at least 3) thread through 2 DMA channels.

K=C3=B6ry
