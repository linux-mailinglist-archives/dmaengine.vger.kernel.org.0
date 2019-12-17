Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C917C122F44
	for <lists+dmaengine@lfdr.de>; Tue, 17 Dec 2019 15:50:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728322AbfLQOu5 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 17 Dec 2019 09:50:57 -0500
Received: from muru.com ([72.249.23.125]:48902 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728087AbfLQOu5 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 17 Dec 2019 09:50:57 -0500
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id EE9E58116;
        Tue, 17 Dec 2019 14:51:35 +0000 (UTC)
Date:   Tue, 17 Dec 2019 06:50:53 -0800
From:   Tony Lindgren <tony@atomide.com>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     linux-omap@vger.kernel.org, Vinod Koul <vinod.koul@intel.com>,
        dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Arnd Bergmann <arnd@arndb.de>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Vinod Koul <vkoul@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH 00/14] Remove legacy sdma code for dt booting omaps
Message-ID: <20191217145053.GV35479@atomide.com>
References: <20191217001925.44558-1-tony@atomide.com>
 <a62d8087-afad-fd04-bfe2-79ce6ea08ffe@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a62d8087-afad-fd04-bfe2-79ce6ea08ffe@ti.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

* Peter Ujfalusi <peter.ujfalusi@ti.com> [191217 09:54]:
> Thanks for doing this!
> First things first:
> Acked-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> Tested-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

Thanks for testing!

> But I was only able to test it with CPU_IDLE=n otherwise (even w/o this series)
> I got a flood of (PandaBoard-ES):
> 
> [  315.995819] ------------[ cut here ]------------
> [  316.000457] WARNING: CPU: 0 PID: 0 at drivers/bus/omap_l3_noc.c:141 l3_interrupt_handler+0x264/0x384
> [  316.009613] 44000000.ocp:L3 Standard Error: MASTER USBHOSTHS TARGET ABE (Read Link): At Address: 0x00000000 : Data Access in User mode during Functional access

Can you please email me your .config and I'll take a look?

I'm not seeing that with pandaboard es here at least with
omap2plus_defconfig.

Regards,

Tony
