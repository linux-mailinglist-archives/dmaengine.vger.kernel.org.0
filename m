Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8809D4DC3DF
	for <lists+dmaengine@lfdr.de>; Thu, 17 Mar 2022 11:20:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232301AbiCQKVO (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 17 Mar 2022 06:21:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231810AbiCQKVN (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 17 Mar 2022 06:21:13 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1551FE9C91
        for <dmaengine@vger.kernel.org>; Thu, 17 Mar 2022 03:19:57 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1nUnEV-0004ft-VH; Thu, 17 Mar 2022 11:19:51 +0100
Received: from sha by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1nUnEU-0002Qv-Pz; Thu, 17 Mar 2022 11:19:50 +0100
Date:   Thu, 17 Mar 2022 11:19:50 +0100
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     Shengjiu Wang <shengjiu.wang@gmail.com>
Cc:     alsa-devel@alsa-project.org, Xiubo Li <Xiubo.Lee@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        Vinod Koul <vkoul@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        dmaengine@vger.kernel.org, joy.zou@nxp.com
Subject: Re: [PATCH 10/19] dma: imx-sdma: Add multi fifo support
Message-ID: <20220317101950.GU405@pengutronix.de>
References: <20220317082818.503143-1-s.hauer@pengutronix.de>
 <20220317082818.503143-11-s.hauer@pengutronix.de>
 <CAA+D8APw-OHdz4s=oy9bWZOw6kj8mD8nss3OKXsYQty52=tb2Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAA+D8APw-OHdz4s=oy9bWZOw6kj8mD8nss3OKXsYQty52=tb2Q@mail.gmail.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 10:42:35 up 96 days, 18:28, 78 users,  load average: 0.19, 0.14,
 0.15
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

On Thu, Mar 17, 2022 at 05:08:55PM +0800, Shengjiu Wang wrote:
>    On Thu, Mar 17, 2022 at 4:28 PM Sascha Hauer <[1]s.hauer@pengutronix.de>
>    wrote:
> 
>      +struct sdma_peripheral_config {
>      +       int n_fifos_src;
>      +       int n_fifos_dst;
>      +       bool sw_done;
>      +};
>      +
>       #endif
> 
>    Hi Sascha
>    This is our internal definition for this sdma_peripheral_config.
>    Could you please adopt this?

This structure is completely internal to the kernel and can be adjusted
when we need it. I don't see a reason to add unused fields to it just to
be compatible with a downstream kernel.

Sascha

>    /**
>     * struct sdma_audio_config - special sdma config for audio case
>     * @src_fifo_num: source fifo number for mcu_2_sai/sai_2_mcu script
>     *                For example, if there are 4 fifos, sdma will fetch
>     *                fifos one by one and roll back to the first fifo after
>     *                the 4th fifo fetch.
>     * @dst_fifo_num: similar as src_fifo_num, but dest fifo instead.
>     * @src_fifo_off: source fifo offset, 0 means all fifos are continuous, 1
>     *                means 1 word offset between fifos. All offset between
>     *                fifos should be same.
>     * @dst_fifo_off: dst fifo offset, similar as @src_fifo_off.
>     * @words_per_fifo: numbers of words per fifo fetch/fill, 0 means
>     *                  one channel per fifo, 1 means 2 channels per fifo..
>     *                  If 'src_fifo_num =  4' and 'chans_per_fifo = 1', it
>     *                  means the first two words(channels) fetch from fifo1
>     *                  and then jump to fifo2 for next two words, and so on
>     *                  after the last fifo4 fetched, roll back to fifo1.
>     * @sw_done_sel: software done selector, PDM need enable software done
>    feature
>     *               in mcu_2_sai/sai_2_mcu script.
>     *               Bit31: sw_done eanbled or not
>     *               Bit16~Bit0: selector
>     *               For example: 0x80000000 means sw_done enabled for done0
>     *                            sector which is for PDM on i.mx8mm.
>     */
>    struct sdma_audio_config {
>            u8 src_fifo_num;
>            u8 dst_fifo_num;
>            u8 src_fifo_off;
>            u8 dst_fifo_off;
>            u8 words_per_fifo;
>            u32 sw_done_sel;
>    };
>    best regards
>    wang shengjiu
>     
> 
> References
> 
>    Visible links
>    1. mailto:s.hauer@pengutronix.de
>    2. mailto:s.hauer@pengutronix.de

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
