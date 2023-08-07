Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7259772975
	for <lists+dmaengine@lfdr.de>; Mon,  7 Aug 2023 17:40:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229749AbjHGPk0 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 7 Aug 2023 11:40:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbjHGPkZ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 7 Aug 2023 11:40:25 -0400
Received: from mail11.truemail.it (mail11.truemail.it [IPv6:2001:4b7e:0:8::81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28BA4A6;
        Mon,  7 Aug 2023 08:40:23 -0700 (PDT)
Received: from francesco-nb.int.toradex.com (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
        by mail11.truemail.it (Postfix) with ESMTPA id 892FD20676;
        Mon,  7 Aug 2023 17:40:17 +0200 (CEST)
Date:   Mon, 7 Aug 2023 17:40:13 +0200
From:   Francesco Dolcini <francesco@dolcini.it>
To:     Vignesh Raghavendra <vigneshr@ti.com>
Cc:     Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] dmaengine: ti: k3-udma: Avoid false error msg on chan
 teardown
Message-ID: <ZNEQXVYDstabJCVc@francesco-nb.int.toradex.com>
References: <20220215044112.161634-1-vigneshr@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220215044112.161634-1-vigneshr@ti.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hello Vignesh,
reviving this old email, since it seems that it raised a valid issue
that is still not resolved.

On Tue, Feb 15, 2022 at 10:11:12AM +0530, Vignesh Raghavendra wrote:
> In cyclic mode, there is no additional descriptor pushed to collect
> outstanding data on channel teardown. Therefore no need to wait for this
> descriptor to come back.
> 
> Without this terminating aplay cmd outputs false error msg like:
> [  116.402800] ti-bcdma 485c0100.dma-controller: chan1 teardown timeout!
I am experiencing a similar issue on Toradex Verdin AM62:

```
kern  :warn  : [   40.196661] ti-udma 485c0100.dma-controller: chan2 teardown timeout!
kern  :warn  : [   41.077013] kauditd_printk_skb: 14 callbacks suppressed
kern  :warn  : [   46.404672] ti-udma 485c0100.dma-controller: chan2 teardown timeout!
kern  :warn  : [   50.852643] ti-udma 485c0100.dma-controller: chan1 teardown timeout!
kern  :warn  : [   56.932709] ti-udma 485c0100.dma-controller: chan1 teardown timeout!
kern  :warn  : [   64.516797] ti-udma 485c0100.dma-controller: chan1 teardown timeout!
kern  :warn  : [   70.404724] ti-udma 485c0100.dma-controller: chan1 teardown timeout!
kern  :warn  : [   71.588933] ti-udma 485c0100.dma-controller: chan2 teardown timeout!
kern  :warn  : [   75.908818] ti-udma 485c0100.dma-controller: chan1 teardown timeout!
kern  :warn  : [   77.064761] ti-udma 485c0100.dma-controller: chan2 teardown timeout!
```

I would say just the same, since this happens everytime aplay terminates.

Any idea to progress on this?

Francesco

