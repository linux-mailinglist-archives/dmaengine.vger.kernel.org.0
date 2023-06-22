Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 395A073A477
	for <lists+dmaengine@lfdr.de>; Thu, 22 Jun 2023 17:12:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232398AbjFVPM2 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 22 Jun 2023 11:12:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231715AbjFVPM0 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 22 Jun 2023 11:12:26 -0400
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 400D91BF9;
        Thu, 22 Jun 2023 08:12:06 -0700 (PDT)
X-GND-Sasl: kory.maincent@bootlin.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1687446724;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ODNweEzU/h8dfp1JK48WgSDN3oD3sv/kHGpHL7T15sE=;
        b=jfluzyC+0SYu1vgSLLKNE6JsROm1pLiQOhHYmuybkF5CuySnRbKPdm0pjKB80Sfjy8xhJp
        RVKjZNavaize96fylFgiAV+Xl6m10gEO2MVUhRc+FyDirkwWLJR989MoMHUUusb7dTbrIn
        /7RAEQU68oWLNI8h/MuxBzV3U4s+ZdYepAO/KLoGiCmlalyjvvCUyXjhgRMDnKa/+bC32b
        FF2YfOsIqafCyZbWHZQv7oxmXWxuVdhuvoMtdAQtqF79uQ3tHf+Z7vza9GECamcEn1ZLo0
        /Jar4sZG1WuUfafyaaq4hBzKLb5F4AqRLo8J3iG+39HOz1T4rafIBPt7cvFLZw==
X-GND-Sasl: kory.maincent@bootlin.com
X-GND-Sasl: kory.maincent@bootlin.com
X-GND-Sasl: kory.maincent@bootlin.com
X-GND-Sasl: kory.maincent@bootlin.com
X-GND-Sasl: kory.maincent@bootlin.com
X-GND-Sasl: kory.maincent@bootlin.com
X-GND-Sasl: kory.maincent@bootlin.com
X-GND-Sasl: kory.maincent@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id D5B5B20012;
        Thu, 22 Jun 2023 15:12:03 +0000 (UTC)
Date:   Thu, 22 Jun 2023 17:12:03 +0200
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
Message-ID: <20230622171203.6857b918@kmaincent-XPS-13-7390>
In-Reply-To: <ti6avu3xdrw7rjwskmemuxu4tcerfq3wd3y4c4v26pbjqjcs5h@izqmikcjsv56>
References: <20230609081654.330857-1-kory.maincent@bootlin.com>
        <20230609081654.330857-5-kory.maincent@bootlin.com>
        <20230619170201.5hbgte2optjlbx55@mobilestation.baikal.int>
        <20230619203207.694bfac6@kmaincent-XPS-13-7390>
        <tpowhctppelni47dosc27cg4vmzwdqnuvf3rukvmju2guoxzsr@wgxomqzfv6ch>
        <20230620153006.036ca3ba@kmaincent-XPS-13-7390>
        <qwkwtsjmfkmvsx4pmjetoxkjrpuwkndm6h6ntkpehxutz2h2jm@bmdzt7ywiuvs>
        <20230621151948.36125997@kmaincent-XPS-13-7390>
        <ti6avu3xdrw7rjwskmemuxu4tcerfq3wd3y4c4v26pbjqjcs5h@izqmikcjsv56>
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

On Wed, 21 Jun 2023 18:56:49 +0300
Serge Semin <fancer.lancer@gmail.com> wrote:

> > Thanks for you detailed answer, this was instructive.
> > I will come back with more information if TLP flags are set.
> > FYI the PCIe board I am currently working with is the one from Brainchi=
p:
> > Here is the driver:
> > https://github.com/Brainchip-Inc/akida_dw_edma =20
>=20
> I've glanced at the driver a bit:
>=20
> 1. Nothing criminal I've noticed in the way the BARs are mapped. It's
> done as it's normally done. pcim_iomap_regions() is supposed to map
> with no additional optimization. So the caching seems irrelevant
> in this case.
>=20
> 2. The probe() method performs some device iATU config:
> akida_1500_setup_iatu() and akida_1000_setup_iatu(). I would have a
> closer look at the way the inbound MWs setup is done.
>=20
> 3. akida_1000_iatu_conf_table contains comments about the APB bus. If
> it's an internal device bus and both LPDDR and eDMA are accessible
> over the same bus, then the re-ordering may happen there. If APB means
> the well known Advanced Peripheral Bus, then it's a quite slow bus
> with respect to the system interconnect and PCIe buses. If eDMA regs
> and LL-memory buses are different then the last write to the LL-memory
> might be indeed still pending while the doorbells update arrives.
> Sending a dummy read to the LL-memory stalls the program execution
> until a response arrive (PCIe MRd TLPs are non-posted - "send and wait
> for response") which happens only after the last write to the
> LL-memory finishes. That's probably why your fix with the dummy-read
> works and why the delay you noticed is quite significant (4us).
> Though it looks quite strange to put LPDDR on such slow bus.
>=20
> 4. I would have also had a closer look at the way the outbound MW is
> configured in your PCIe host controller (whether it enables some
> optimizations like Relaxed ordering and ID-based ordering).
>=20
> In anyway I would have got in touch with the FPGA designers whether
> any of my suppositions correct (especially regarding 3.).

Alright, thanks for your instructive review!

In the HDMA driver point of view we can not know if the eDMA regs and the
LL-memory will be in same bus in whatever future implementation. Of course =
it
is the hardware designers who should be careful about having a fast bus and
memory for the LL, but wouldn't it be more cautious to have this read?
Just a small thought!

K=C3=B6ry
