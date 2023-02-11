Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 108E969317E
	for <lists+dmaengine@lfdr.de>; Sat, 11 Feb 2023 15:30:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229461AbjBKOap (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 11 Feb 2023 09:30:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjBKOao (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 11 Feb 2023 09:30:44 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69B8F27D55;
        Sat, 11 Feb 2023 06:30:43 -0800 (PST)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1pQqtl-0004G1-U5; Sat, 11 Feb 2023 15:30:41 +0100
Message-ID: <cd61b6d1-52e3-11a9-714e-324b51425cec@leemhuis.info>
Date:   Sat, 11 Feb 2023 15:30:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: =?UTF-8?Q?Re=3a_=5bregression=5d_Bug=c2=a0216856_-_=5bptdma=5d_NULL?=
 =?UTF-8?Q?_pointer_dereference_in_pt=5fcmd=5fcallback_during_server_shutdow?=
 =?UTF-8?Q?n?=
Content-Language: en-US, de-DE
From:   "Linux regression tracking #update (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
To:     Sanjay R Mehta <sanju.mehta@amd.com>, Vinod Koul <vkoul@kernel.org>
Cc:     Eric Pilmore <epilmore@gigaio.com>, dmaengine@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>
References: <0e77436c-9f0a-15b6-697a-7b879e4abc4a@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <0e77436c-9f0a-15b6-697a-7b879e4abc4a@leemhuis.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1676125843;d111d630;
X-HE-SMSGID: 1pQqtl-0004G1-U5
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

[TLDR: This mail in primarily relevant for Linux regression tracking. A
change or fix related to the regression discussed in this thread was
posted or applied, but it did not use a Link: tag to point to the
report, as Linus and the documentation call for. Things happen, no
worries -- but now the regression tracking bot needs to be told manually
about the fix. See link in footer if these mails annoy you.]

On 30.12.22 09:27, Thorsten Leemhuis wrote:

> I noticed a bug report in bugzilla.kernel.org that looks a lot like a
> regression to my untrained eyes (it's not entirely clear). As many
> (most?) kernel developer don't keep an eye on it, I decided to forward
> it by mail. Quoting from
> https://bugzilla.kernel.org/show_bug.cgi?id=216856 :
> 
>>  Eric Pilmore 2022-12-27 22:23:50 UTC
>>
>> Observed kernel panic during host shutdown on a AMD (Milan CPU) based
>> server. The issue ended up being a NULL pointer dereference in
>> pt_cmd_callback() when
>> called from pt_issue_pending(). If you follow the flow in
>> pt_issue_pending() you will note that if pt_next_dma_desc() returns
>> NULL, then engine_is_idle will remain as TRUE, including if
>> pt_next_dma_desc() is still returning NULL in the 2nd call just prior to
>> doing the call to pt_cmd_callback().
> [...]
> #regzbot introduced: v6.1..v6.2-rc1
> https://bugzilla.kernel.org/show_bug.cgi?id=216856
> #regzbot title: ptdma: kernel panic during host shutdown
> #regzbot ignore-activity

#regzbot introduced: 6fa7e0e836e2
#regzbot monitor:
https://lore.kernel.org/all/20230210075142.58253-1-epilmore@gigaio.com/
#regzbot fix: dmaengine: ptdma: check for null desc before calling
pt_cmd_callback
#regzbot ignore-activity

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
That page also explains what to do if mails like this annoy you.
