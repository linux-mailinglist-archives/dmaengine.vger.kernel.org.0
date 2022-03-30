Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0582D4EBC15
	for <lists+dmaengine@lfdr.de>; Wed, 30 Mar 2022 09:49:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237275AbiC3HvW (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 30 Mar 2022 03:51:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230274AbiC3HvU (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 30 Mar 2022 03:51:20 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A36FB39
        for <dmaengine@vger.kernel.org>; Wed, 30 Mar 2022 00:49:35 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1nZT57-0005qE-LM; Wed, 30 Mar 2022 09:49:29 +0200
Received: from sha by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1nZT56-0002Md-T7; Wed, 30 Mar 2022 09:49:28 +0200
Date:   Wed, 30 Mar 2022 09:49:28 +0200
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     Fabio Estevam <festevam@gmail.com>
Cc:     Linux-ALSA <alsa-devel@alsa-project.org>,
        Xiubo Li <Xiubo.Lee@gmail.com>,
        Shengjiu Wang <shengjiu.wang@gmail.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        Vinod Koul <vkoul@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>, dmaengine@vger.kernel.org
Subject: Re: [PATCH v2 10/19] dma: imx-sdma: Add multi fifo support
Message-ID: <20220330074928.GY12181@pengutronix.de>
References: <20220328112744.1575631-1-s.hauer@pengutronix.de>
 <20220328112744.1575631-11-s.hauer@pengutronix.de>
 <CAOMZO5B3TdYMhvYX55H5c+tSgaR8mgUKPo=hOw2xKvd+b+X8=g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOMZO5B3TdYMhvYX55H5c+tSgaR8mgUKPo=hOw2xKvd+b+X8=g@mail.gmail.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 09:48:24 up 109 days, 16:33, 78 users,  load average: 0.10, 0.10,
 0.09
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

Hi Fabio,

On Tue, Mar 29, 2022 at 07:55:45AM -0300, Fabio Estevam wrote:
> Hi Sascha,
> 
> On Mon, Mar 28, 2022 at 8:28 AM Sascha Hauer <s.hauer@pengutronix.de> wrote:
> >
> > Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> 
> Please add a commit log, thanks.

oh, sure. Will add this:

    The i.MX SDMA engine can read from / write to multiple successive
    hardware FIFO registers, referred to as "Multi FIFO support". This is
    needed for the micfil driver and certain configurations of the SAI
    driver. This patch adds support for this feature.
    
    The number of FIFOs to read from / write to must be communicated from
    the client driver to the SDMA engine. For this the struct
    dma_slave_config::peripheral_config field is used.

Sascha

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
