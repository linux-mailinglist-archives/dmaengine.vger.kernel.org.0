Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34C251BFBB7
	for <lists+dmaengine@lfdr.de>; Thu, 30 Apr 2020 16:02:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727972AbgD3OBP (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 30 Apr 2020 10:01:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:44476 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729405AbgD3OBK (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 30 Apr 2020 10:01:10 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 49EE5206D9;
        Thu, 30 Apr 2020 14:01:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588255270;
        bh=9FbFTTlnbKLjAAIPjJx6YuYxhy4pirQW6SAhcXe/fIM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=VMXtb8vhEM+n2AJtnnYWEg28q2MQfNCnhDqtmDeZp2Nn/BQEuu67JEdPdGFmLHEaJ
         dwgVN7ndgB6NkDsFbVa5YTi4BZjE8Nt0aODE8LeOisc/N76gGKBUeeJ+SpojTHueHC
         cJ1QIpegAUWyaw3A+SFIZePzFTZr2pc7ojL2dN38=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1jU9kS-0083fU-Nk; Thu, 30 Apr 2020 15:01:08 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 30 Apr 2020 15:01:08 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Russell King <linux@armlinux.org.uk>,
        Lad Prabhakar <prabhakar.csengg@gmail.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dmaengine <dmaengine@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 09/18] ARM: dts: r8a7742: Add IRQC support
In-Reply-To: <CAMuHMdWUYU6-S+EhzTKE4JeS2ExLQcsg_Bpy7RKD+cwhg55M8g@mail.gmail.com>
References: <1588197415-13747-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <1588197415-13747-10-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <CAMuHMdWUYU6-S+EhzTKE4JeS2ExLQcsg_Bpy7RKD+cwhg55M8g@mail.gmail.com>
User-Agent: Roundcube Webmail/1.4.3
Message-ID: <0002cb9c8b1f0f7a308dea06af14bb37@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: geert@linux-m68k.org, prabhakar.mahadev-lad.rj@bp.renesas.com, magnus.damm@gmail.com, robh+dt@kernel.org, vkoul@kernel.org, linus.walleij@linaro.org, bgolaszewski@baylibre.com, tglx@linutronix.de, jason@lakedaemon.net, gregkh@linuxfoundation.org, linux@armlinux.org.uk, prabhakar.csengg@gmail.com, devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, linux-gpio@vger.kernel.org, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 2020-04-30 14:54, Geert Uytterhoeven wrote:
> On Wed, Apr 29, 2020 at 11:58 PM Lad Prabhakar
> <prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
>> Describe the IRQC interrupt controller in the r8a7742 device tree.
>> 
>> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>> Reviewed-by: Marian-Cristian Rotariu 
>> <marian-cristian.rotariu.rb@bp.renesas.com>
> 
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Can I safely assume that the irqchip DT updates will be routed via
the arm-soc tree? If so, feel free to add my

Acked-by: Marc Zyngier <maz@kernel.org>

to these patches.

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
