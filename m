Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E0185E7EC
	for <lists+dmaengine@lfdr.de>; Wed,  3 Jul 2019 17:34:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726686AbfGCPee (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 3 Jul 2019 11:34:34 -0400
Received: from smtp1.de.adit-jv.com ([93.241.18.167]:35786 "EHLO
        smtp1.de.adit-jv.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726490AbfGCPed (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 3 Jul 2019 11:34:33 -0400
Received: from localhost (smtp1.de.adit-jv.com [127.0.0.1])
        by smtp1.de.adit-jv.com (Postfix) with ESMTP id 90FFA3C04C1;
        Wed,  3 Jul 2019 17:34:30 +0200 (CEST)
Received: from smtp1.de.adit-jv.com ([127.0.0.1])
        by localhost (smtp1.de.adit-jv.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 5YTeFtRDEy6a; Wed,  3 Jul 2019 17:34:25 +0200 (CEST)
Received: from HI2EXCH01.adit-jv.com (hi2exch01.adit-jv.com [10.72.92.24])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp1.de.adit-jv.com (Postfix) with ESMTPS id 0C94E3C001F;
        Wed,  3 Jul 2019 17:34:25 +0200 (CEST)
Received: from vmlxhi-102.adit-jv.com (10.72.93.184) by HI2EXCH01.adit-jv.com
 (10.72.92.24) with Microsoft SMTP Server (TLS) id 14.3.439.0; Wed, 3 Jul 2019
 17:34:24 +0200
Date:   Wed, 3 Jul 2019 17:34:21 +0200
From:   Eugeniu Rosca <erosca@de.adit-jv.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
CC:     Eugeniu Rosca <roscaeugeniu@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        <dmaengine@vger.kernel.org>, Eugeniu Rosca <erosca@de.adit-jv.com>
Subject: Re: [PATCH] dmaengine: rcar-dmac: Reject zero-length slave DMA
 requests
Message-ID: <20190703150724.GA11105@vmlxhi-102.adit-jv.com>
References: <20190624123818.20919-1-geert+renesas@glider.be>
 <20190626181459.GA31913@x230>
 <CAMuHMdUpPEdz3aDXo90XQ7b-jP2ErxwqLKgmEFUhhuB-oBzrDA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAMuHMdUpPEdz3aDXo90XQ7b-jP2ErxwqLKgmEFUhhuB-oBzrDA@mail.gmail.com>
User-Agent: Mutt/1.12.1+40 (7f8642d4ee82) (2019-06-28)
X-Originating-IP: [10.72.93.184]
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Geert,

On Fri, Jun 28, 2019 at 02:10:01PM +0200, Geert Uytterhoeven wrote:
> On Wed, Jun 26, 2019 at 8:15 PM Eugeniu Rosca <roscaeugeniu@gmail.com> wrote:
[..]
> I'm not such a big fan of WARN()...
[..]
> > rcar-dmac e7300000.dma-controller: rcar_dmac_prep_slave_sg: bad parameter: len=1, id=19
> 
> Which would be followed by
> 
>     sh-sci e6e88000.serial: Failed preparing Tx DMA descriptor
> 
> pointing to the sh-sci driver, right?
> 
> The id=19 points to channel 0x13, i.e. SCIF2, according to
> arch/arm64/boot/dts/renesas/r8a7795.dtsi.

Thank you for the detailed rationale. Much appreciated.

FTR, the patch landed in vkoul/slave-dma.git, as commit
https://git.kernel.org/pub/scm/linux/kernel/git/vkoul/slave-dma.git/commit/?h=next&id=78efb76ab4dfb8f
("dmaengine: rcar-dmac: Reject zero-length slave DMA requests")

-- 
Best Regards,
Eugeniu.
