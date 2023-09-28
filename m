Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01DDD7B1508
	for <lists+dmaengine@lfdr.de>; Thu, 28 Sep 2023 09:38:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230227AbjI1HiX (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 28 Sep 2023 03:38:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230044AbjI1HiW (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 28 Sep 2023 03:38:22 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DC8392;
        Thu, 28 Sep 2023 00:38:21 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE061C433C8;
        Thu, 28 Sep 2023 07:38:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695886700;
        bh=UhY6cOElhzlwnHpIfwIH6wNFErVALugCIYKMSXrO0/A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uuibvGvND9tKZ81BkY98N7O4z1zCNQv6dU+vJh1VbcTuQ5wBh5PEzyAVy436X0Wki
         alF66Xe+im1N9jdkv85eRv55IxRzrPQ62uqCgdUqZvpOgNItpyH3JDkYVeknYoh8eB
         MZXCv52p5qwk2D6CBopufN+ctKHtNk6LP4YIuI6r8IYGr0xjbXbpD4/xrmuxfXZxV4
         UKR5c3VWYVowrJeTJaGHDONT5FVVNuxYyztWLT6AA0ejYs8n0rlPTrvhYcO7fE0JH8
         X4eM6kaDCPqKHDSaCcPPBrNtx20FNqhE3xyRzgnjoDSmPM5npWIZsTJStt5WXdKTPA
         AjZ8PhBnZ5wFw==
Date:   Thu, 28 Sep 2023 13:08:15 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Chengfeng Ye <dg573847474@gmail.com>, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, sorganov@gmail.com, festevam@gmail.com,
        ilpo.jarvinen@linux.intel.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, dmaengine@vger.kernel.org
Subject: Re: [PATCH RESEND] serial: imx: Fix potential deadlock on
 sport->port.lock
Message-ID: <ZRUtZ/M3Ml6ltc2m@matsya>
References: <20230927181939.60554-1-dg573847474@gmail.com>
 <20230928060749.qzs6qgcesstclqqk@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230928060749.qzs6qgcesstclqqk@pengutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 28-09-23, 08:07, Uwe Kleine-König wrote:
> [Cc += Vinod Koul, dmaengine@vger.kernel.org]
> 
> Hello,
> 
> On Wed, Sep 27, 2023 at 06:19:39PM +0000, Chengfeng Ye wrote:
> > As &sport->port.lock is acquired under irq context along the following
> > call chain from imx_uart_rtsint(), other acquisition of the same lock
> > inside process context or softirq context should disable irq avoid double
> > lock.
> > 
> > <deadlock #1>
> > 
> > imx_uart_dma_rx_callback()
> > --> spin_lock(&sport->port.lock)
> > <interrupt>
> >    --> imx_uart_rtsint()
> >    --> spin_lock(&sport->port.lock)
> > 
> > This flaw was found by an experimental static analysis tool I am
> > developing for irq-related deadlock.
> 
> Ah, I understood before that you really experienced that deadlock (or a
> lockdep splat). I didn't test anything, but I think the
> imx_uart_dma_rx_callback() is called indirectly by
> sdma_update_channel_loop() which is called in irq context. I don't know
> if this is the case for all dma drivers?!
> 
> @Vinod: Maybe you can chime in here: Is a dma callback always called in
> irq context?

Not in callback but a tasklet context. The DMA irq handler is supposed
to use a tasklet for invoking the callback

> If yes, this patch isn't needed. Otherwise it might be a good idea to
> not use the special knowledge and switch to spin_lock_irqsave() as
> suggested.
> 
> > To prevent the potential deadlock, the patch uses spin_lock_irqsave()
> > on the &sport->port.lock inside imx_uart_dma_rx_callback() to prevent
> > the possible deadlock scenario.
> > 
> > Signed-off-by: Chengfeng Ye <dg573847474@gmail.com>
> 
> If we agree this patch is a good idea, we can add:
> 
> Fixes: 496a4471b7c3 ("serial: imx: work-around for hardware RX flood")
> 
> Thanks
> Uwe
> 
> -- 
> Pengutronix e.K.                           | Uwe Kleine-König            |
> Industrial Linux Solutions                 | https://www.pengutronix.de/ |



-- 
~Vinod
