Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 52E9346728
	for <lists+dmaengine@lfdr.de>; Fri, 14 Jun 2019 20:09:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725868AbfFNSJ1 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 14 Jun 2019 14:09:27 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:34081 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725837AbfFNSJ1 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 14 Jun 2019 14:09:27 -0400
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mol@pengutronix.de>)
        id 1hbqdY-00054m-Sl; Fri, 14 Jun 2019 20:09:16 +0200
Received: from mol by ptx.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <mol@pengutronix.de>)
        id 1hbqdV-0004US-KX; Fri, 14 Jun 2019 20:09:13 +0200
Date:   Fri, 14 Jun 2019 20:09:13 +0200
From:   Michael Olbrich <m.olbrich@pengutronix.de>
To:     Sven Van Asbroeck <thesven73@gmail.com>
Cc:     Fabio Estevam <festevam@gmail.com>,
        Robin Gong <yibin.gong@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Vinod <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>, dmaengine@vger.kernel.org,
        Sascha Hauer <kernel@pengutronix.de>
Subject: Re: [PATCH v1] dmaengine: imx-sdma: remove BD_INTR for channel0
Message-ID: <20190614180913.d66bbjrnw3gxt663@pengutronix.de>
Mail-Followup-To: Sven Van Asbroeck <thesven73@gmail.com>,
        Fabio Estevam <festevam@gmail.com>, Robin Gong <yibin.gong@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>, Vinod <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>,
        dmaengine@vger.kernel.org, Sascha Hauer <kernel@pengutronix.de>
References: <20190614083959.37944-1-yibin.gong@nxp.com>
 <CAOMZO5Do+BsZEX43w283yWed8fQVtTC+zAvoktPLTj4c_f798w@mail.gmail.com>
 <CAGngYiUWy5FM-zsT55-yY=kahLObZGYw=zU0F9Tzp9T2S3G6LA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGngYiUWy5FM-zsT55-yY=kahLObZGYw=zU0F9Tzp9T2S3G6LA@mail.gmail.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 19:38:35 up 27 days, 23:56, 60 users,  load average: 0.02, 0.08,
 0.08
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: mol@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: dmaengine@vger.kernel.org
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Fri, Jun 14, 2019 at 09:25:51AM -0400, Sven Van Asbroeck wrote:
> On Fri, Jun 14, 2019 at 6:49 AM Fabio Estevam <festevam@gmail.com> wrote:
> >
> > According to the original report from Sven the issue started to happen
> > on 5.0, so it would be good to add a Fixes tag and Cc stable so that
> > this fix could be backported to 5.0/5.1 stable trees.
> 
> Good catch !
> 
> However, the issue is highly timing-dependent. It will come and go depending
> on the kernel version, devicetree and defconfig. If it works for me on
> 4.19, that
> doesn't mean the bug is gone on 4.19.
> 
> Looking at the commit history, I think the commit below possibly introduced the
> issue. Until this commit, sdma_run_channel() would wait on the interrupt
> before proceeding. It has been there since 4.8:
> 
> Fixes: 1d069bfa3c78 ("dmaengine: imx-sdma: ack channel 0 IRQ in the
> interrupt handler")

I think this is correct. Starting with this commit, the interrupt status fr
channel 0 is no longer cleared in sdma_run_channel0() and
sdma_int_handler() is always called for channel 0.
During firmware loading the interrupts are enabled again just before the
clocks are disabled. The interrupt is pending at this moment so on a single
core system I think this will always work as expected. If the firmware
loading and the interrupt handler run on different cores then this is racy.
Maybe something else changed to make this more likely?

With this new change sdma_int_handler() is no longer called for channel 0
right, so you should also remove the special handling there.

Michael

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
