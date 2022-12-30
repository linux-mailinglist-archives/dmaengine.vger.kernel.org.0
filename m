Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1943065964E
	for <lists+dmaengine@lfdr.de>; Fri, 30 Dec 2022 09:27:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234427AbiL3I1K (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 30 Dec 2022 03:27:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234813AbiL3I1I (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 30 Dec 2022 03:27:08 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B59B1A209;
        Fri, 30 Dec 2022 00:27:07 -0800 (PST)
Received: from [2a02:8108:963f:de38:eca4:7d19:f9a2:22c5]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1pBAjK-0005s0-03; Fri, 30 Dec 2022 09:27:06 +0100
Message-ID: <0e77436c-9f0a-15b6-697a-7b879e4abc4a@leemhuis.info>
Date:   Fri, 30 Dec 2022 09:27:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Content-Language: en-US, de-DE
From:   Thorsten Leemhuis <regressions@leemhuis.info>
Cc:     Eric Pilmore <epilmore@gigaio.com>, dmaengine@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>
Subject: =?UTF-8?Q?=5bregression=5d_Bug=c2=a0216856_-_=5bptdma=5d_NULL_point?=
 =?UTF-8?Q?er_dereference_in_pt=5fcmd=5fcallback_during_server_shutdown?=
To:     Sanjay R Mehta <sanju.mehta@amd.com>, Vinod Koul <vkoul@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1672388827;e654454c;
X-HE-SMSGID: 1pBAjK-0005s0-03
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi, this is your Linux kernel regression tracker speaking.

I noticed a bug report in bugzilla.kernel.org that looks a lot like a
regression to my untrained eyes (it's not entirely clear). As many
(most?) kernel developer don't keep an eye on it, I decided to forward
it by mail. Quoting from
https://bugzilla.kernel.org/show_bug.cgi?id=216856 :

>  Eric Pilmore 2022-12-27 22:23:50 UTC
> 
> Observed kernel panic during host shutdown on a AMD (Milan CPU) based
> server. The issue ended up being a NULL pointer dereference in
> pt_cmd_callback() when
> called from pt_issue_pending(). If you follow the flow in
> pt_issue_pending() you will note that if pt_next_dma_desc() returns
> NULL, then engine_is_idle will remain as TRUE, including if
> pt_next_dma_desc() is still returning NULL in the 2nd call just prior to
> doing the call to pt_cmd_callback().
> 
> The stack flow leading up to the panic was:
> dma_sync_wait() -> dma_async_issue_pending() -> pt_issue_pending() ->
> pt_cmd_callback()
> 
> Temporarily I worked around the issue by simply changing the IF
> condition for the call to pt_cmd_callback() to also check for a non-NULL
> desc, i.e.
> 
>    if (engine_is_idle && desc)
>       pt_cmd_callback(desc, 0);
> 
> This resolved the issue for me, however I don't know enough about the
> driver or the context here to know if this is really the desirable fix,
> and so I'm submitting this bug rather than attempting to patch myself. I
> wasn't sure if the secondary pt_next_dma_desc() call was mistakenly
> leftover from the change that introduced the engine_is_idle variable or
> not. Note that vchan_issue_pending() will return a boolean as to whether
> there are any descriptors on the Issue list, i.e. active descriptors.
> So, maybe that could be used to qualify the need to take some action?
> Also, if pt_cmd_callback() is really going to start processing on the
> next descriptor, I wonder if it should be called under the chan->vc.lock
> lock. I'm not sure of the safety of this, but if you are peeking at
> descriptors on the Issue list that you might want to ensure they're
> protected from being accessed/removed by some other thread.

See the ticket for more details.

BTW, let me use this mail to also add the report to the list of tracked
regressions to ensure it's doesn't fall through the cracks:

#regzbot introduced: v6.1..v6.2-rc1
https://bugzilla.kernel.org/show_bug.cgi?id=216856
#regzbot title: ptdma: kernel panic during host shutdown
#regzbot ignore-activity

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)

P.S.: As the Linux kernel's regression tracker I deal with a lot of
reports and sometimes miss something important when writing mails like
this. If that's the case here, don't hesitate to tell me in a public
reply, it's in everyone's interest to set the public record straight.
