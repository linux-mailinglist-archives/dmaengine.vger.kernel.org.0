Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73A174DC911
	for <lists+dmaengine@lfdr.de>; Thu, 17 Mar 2022 15:41:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229549AbiCQOm1 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 17 Mar 2022 10:42:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235281AbiCQOm0 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 17 Mar 2022 10:42:26 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E17F41BA476
        for <dmaengine@vger.kernel.org>; Thu, 17 Mar 2022 07:41:09 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1nUrJI-0002Oy-MK; Thu, 17 Mar 2022 15:41:04 +0100
Received: from sha by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1nUrJH-0001RD-3X; Thu, 17 Mar 2022 15:41:03 +0100
Date:   Thu, 17 Mar 2022 15:41:03 +0100
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     Shengjiu Wang <shengjiu.wang@gmail.com>
Cc:     alsa-devel@alsa-project.org, Xiubo Li <Xiubo.Lee@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        Vinod Koul <vkoul@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        dmaengine@vger.kernel.org, joy.zou@nxp.com
Subject: Re: [PATCH 10/19] dma: imx-sdma: Add multi fifo support
Message-ID: <20220317144103.GV405@pengutronix.de>
References: <20220317082818.503143-1-s.hauer@pengutronix.de>
 <20220317082818.503143-11-s.hauer@pengutronix.de>
 <CAA+D8APw-OHdz4s=oy9bWZOw6kj8mD8nss3OKXsYQty52=tb2Q@mail.gmail.com>
 <20220317101950.GU405@pengutronix.de>
 <CAA+D8AMdTzqfEQCH4pcQE3K1P-4oo71ctiGW1DD7XJPQDcVbTg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAA+D8AMdTzqfEQCH4pcQE3K1P-4oo71ctiGW1DD7XJPQDcVbTg@mail.gmail.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 15:38:07 up 96 days, 23:23, 78 users,  load average: 0.12, 0.16,
 0.19
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: dmaengine@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Thu, Mar 17, 2022 at 08:20:22PM +0800, Shengjiu Wang wrote:
>    Hi
>    On Thu, Mar 17, 2022 at 6:19 PM Sascha Hauer <[1]s.hauer@pengutronix.de>
>    wrote:
> 
>      On Thu, Mar 17, 2022 at 05:08:55PM +0800, Shengjiu Wang wrote:
>      >    On Thu, Mar 17, 2022 at 4:28 PM Sascha Hauer
>      <[1][2]s.hauer@pengutronix.de>
>      >    wrote:
>      >
>      >      +struct sdma_peripheral_config {
>      >      +       int n_fifos_src;
>      >      +       int n_fifos_dst;
>      >      +       bool sw_done;
>      >      +};
>      >      +
>      >       #endif
>      >
>      >    Hi Sascha
>      >    This is our internal definition for this sdma_peripheral_config.
>      >    Could you please adopt this?
> 
>      This structure is completely internal to the kernel and can be adjusted
>      when we need it. I don't see a reason to add unused fields to it just to
>      be compatible with a downstream kernel.
> 
>    Yes, it is not used by micfil. But the fifo_offset and words_per_fifo
>    is part the multi fifo script support scope, if only add fifo_num,  it
>    looks
>    like this feature is not complete.

No, it's not. I only added the parts that I am interested in and that I
can test. I have some multichannel audio stuff in my pipeline, I might add
more pieces later.

>    By the way,  which multi fifo script version are you using? seems it is
>    not the latest compared with our release, right?

I am using the latest firmware from linux-firmware.git.

Sascha

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
