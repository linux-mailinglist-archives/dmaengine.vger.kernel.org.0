Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2B9DF56F97
	for <lists+dmaengine@lfdr.de>; Wed, 26 Jun 2019 19:34:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726447AbfFZRes (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 26 Jun 2019 13:34:48 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33326 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726293AbfFZRes (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 26 Jun 2019 13:34:48 -0400
Received: by mail-wr1-f68.google.com with SMTP id n9so3734939wru.0;
        Wed, 26 Jun 2019 10:34:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=851t1GMEwDD2ZzDSa1ax/hpIsRhpSFBE2VRHCrPLw1s=;
        b=Oqsvqq28aFqshh4jcujp5Hn/uZjnvBsHlQB0QQ6A1jDMgyp06eCUY8qiXLJtzyJwSJ
         tPqjErPTt9SGodr2YF9LLlhh/fDNjvKhxuCQyCcOQ+b9+Yl61OrYvEBksa9V+i7rW/Mq
         NIOhTygspswiglf1PlKrPojxBgiC8hM966+UN+FYwR4bv3xAiT5N4Gz4Qxu2RW4O97E/
         Y+yUaH36raVv2aN4nV/cjpXnqMEjmx4+XcztGArYtX5n0jaIS0nnZUInYkcPI1mzgavC
         doh9w5MsNarKU5js0qXor7dZN2ELpZ4EkrpXzvfEemoiJ7+4kZUxrMIzLHCHQfRc2kXK
         JU8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=851t1GMEwDD2ZzDSa1ax/hpIsRhpSFBE2VRHCrPLw1s=;
        b=F3/42Jbx9Fwq/yOI/u/Xwz/274JKkNh1l2SvtwIRal8gqRY3BXSD27HqGv4Ca49Uv1
         pQj+SNAkZitIxgbeXaAhN/NedpojgpB+s/dYufCcK5LMRFqbDniFQMRt6isuis7vEQs/
         EDEUpJR6pI2KW2ZyNJbTh/7S6xmXt8HUQMIU72IlgzIAVgDqIpxwDwWBnUkTujyDh3fn
         gC4cXNhRl2kPdtUCQXNuumNmnJvj45lxF8nlUVVdAIrDpNOjyrpAhPDdOB8YCVV1O2wC
         rcp2mxKxN2tS9M80FPctTcJ7lDL9wrdzJenMwmPZ5Tx4s9o1NB9bTHzR78xY8Ud/oO8R
         AmZQ==
X-Gm-Message-State: APjAAAVjn7IgSB1VRquksP0gM+kxyAATnhWBzjkj+C73+ZJA+Q6ZApel
        0Buvjl/jVXBk8hK6sfMG6tw=
X-Google-Smtp-Source: APXvYqyGKeIbwSVo/ySLTjaNK/K5Z9vyvYbrjtOSnbG3cFzbTu+yXfq9/ivMIri8Xdk35aixmY80DQ==
X-Received: by 2002:a5d:6583:: with SMTP id q3mr1225434wru.184.1561570485518;
        Wed, 26 Jun 2019 10:34:45 -0700 (PDT)
Received: from x230 (ipb218f439.dynamic.kabel-deutschland.de. [178.24.244.57])
        by smtp.gmail.com with ESMTPSA id m9sm19593764wrn.92.2019.06.26.10.34.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Jun 2019 10:34:44 -0700 (PDT)
From:   Eugeniu Rosca <roscaeugeniu@gmail.com>
X-Google-Original-From: Eugeniu Rosca <erosca@de.adit-jv.com>
Date:   Wed, 26 Jun 2019 19:34:34 +0200
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-serial@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        dmaengine@vger.kernel.org,
        "George G . Davis" <george_davis@mentor.com>,
        Eugeniu Rosca <erosca@de.adit-jv.com>,
        Eugeniu Rosca <roscaeugeniu@gmail.com>
Subject: Re: [PATCH 0/2] serial: sh-sci: Fix .flush_buffer() issues
Message-ID: <20190626173434.GA24702@x230>
References: <20190624123540.20629-1-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190624123540.20629-1-geert+renesas@glider.be>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Geert, CC: George

On Mon, Jun 24, 2019 at 02:35:38PM +0200, Geert Uytterhoeven wrote:
> Hi Greg, Jiri,
> 
> This patch series attempts to fix the issues Eugeniu Rosca reported
> seeing, where .flush_buffer() interfered with transmit DMA operation[*].
> 
> There's a third patch "dmaengine: rcar-dmac: Reject zero-length slave
> DMA requests", which is related to the issue, but further independent,
> hence submitted separately.
> 
> Eugeniu: does this fix the issues you were seeing?

Many thanks for both sh-sci and the rcar-dmac patches.
The fixes are very much appreciated.

> Geert Uytterhoeven (2):
>   serial: sh-sci: Fix TX DMA buffer flushing and workqueue races
>   serial: sh-sci: Terminate TX DMA during buffer flushing
> 
>  drivers/tty/serial/sh-sci.c | 33 ++++++++++++++++++++++++---------
>  1 file changed, 24 insertions(+), 9 deletions(-)

I reserved some time to get a feeling about how the patches behave on
a real system (H3-ES2.0-ULCB-KF-M06), so here come my observations.

First of all, the issue I have originally reported in [0] is only
reproducible in absence of [4]. So, one of my questions would be how
do you yourself see the relationship between [1-3] and [4]?

That said, all my testing assumes:
 - Vanilla tip v5.2-rc6-15-g249155c20f9b with [4] reverted.
 - DEBUG is undefined in {sh-sci.c,rcar-dmac.c}, since I've noticed
   new issues arising in the debug build, which are unrelated to [0].

Below is the summary of my findings:

 Version         IS [0]       Is console       Error message when
(vanilla+X)    reproduced?  usable after [0]   [0] is reproduced
                             is reproduced?
 ------------------------------------------------------------
 -[4]             Yes           No                [5]
 -[4]+[1]         Yes           No                -
 -[4]+[2]         Yes           Yes               [5]
 -[4]+[3]         Yes           Yes               [6]
 -[4]+[1]+[2]     No            -                 -
 -[4]+[1]+[2]+[3] No            -                 -
 pure vanilla     No            -                 -

This looks a little too verbose, but I thought it might be interesting.

The story which I see is that [1] does not fix [0] alone, but it seems
to depend on [2]. Furthermore, if cherry picked alone, [1] makes the
matters somewhat worse in the sense that it hides the error [5].

My only question is whether [1-3] are supposed to replace [4] or they
are supposed to happily coexist. Since I don't see [0] being reproduced
with [1-3], I personally prefer to re-enable DMA on SCIF (when the
latter is used as console) so that more features and code paths are
exercised to increase test coverage.

[0] https://lore.kernel.org/lkml/20190504004258.23574-3-erosca@de.adit-jv.com/
[1] https://patchwork.kernel.org/patch/11012983/
    ("serial: sh-sci: Fix TX DMA buffer flushing and workqueue races")
[2] https://patchwork.kernel.org/patch/11012987/
    ("serial: sh-sci: Terminate TX DMA during buffer flushing")
[3] https://patchwork.kernel.org/patch/11012991/
    ("dmaengine: rcar-dmac: Reject zero-length slave DMA requests")
[4] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=099506cbbc79c0
    ("serial: sh-sci: disable DMA for uart_console")

[5] rcar-dmac e7300000.dma-controller: Channel Address Error
[6] rcar-dmac e7300000.dma-controller: rcar_dmac_prep_slave_sg: bad parameter: len=1, id=19
    sh-sci e6e88000.serial: Failed preparing Tx DMA descriptor

Thanks!

-- 
Best regards,
Eugeniu.
