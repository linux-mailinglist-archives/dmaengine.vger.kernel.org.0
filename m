Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B42EE532D1D
	for <lists+dmaengine@lfdr.de>; Tue, 24 May 2022 17:16:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237536AbiEXPQH (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 24 May 2022 11:16:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238788AbiEXPP4 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 24 May 2022 11:15:56 -0400
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 876128CB06;
        Tue, 24 May 2022 08:15:54 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id B4D8541F7F;
        Tue, 24 May 2022 15:15:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=marcan.st; s=default;
        t=1653405352; bh=8w50wHvXurvq4YfaNzGeMc56fIBXMny4Y1siuUuA7wc=;
        h=Date:To:Cc:References:From:Subject:In-Reply-To;
        b=RuptRBPB3SgPdj8ms00Sgjc+EYhIJjpL7X10gQwKfD5Zomsg6GuarremEvZWVL66d
         LqgrVKm5afhO2xR+7cbevOnhD7jTblq4i0MGyiQNYuQBxUPdImrfyGvgkv68FLEAcZ
         VYYwu5VTQDBzeAnNMl77ptr4lxm5dNQmZc4p77+WvY7SxZPoO6KJbtoybpFrrC30Zd
         U6P9dPlpnXXb6iYmEAa3V3O6wghDlOH6FYrcswyvpkhhzJz81nbXCTVkrQLS1MVtDf
         QaXmeBb8RGg6rGPWDKV65q0pVzZCU8N8nVueLfR8a4LwUJYSfa+87XybwcaX5IxxCr
         JE/lko42WgYtQ==
Message-ID: <8d20b41e-c529-a7f9-11f2-350fa14c9f98@marcan.st>
Date:   Wed, 25 May 2022 00:15:45 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Content-Language: en-US
To:     jassisinghbrar@gmail.com
Cc:     Anup Patel <anup.patel@broadcom.com>,
        Vinod Koul <vkoul@kernel.org>, Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Mun Yew Tham <mun.yew.tham@intel.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev
References: <20220502090225.26478-1-marcan@marcan.st>
 <20220524145540.363553-1-jassisinghbrar@gmail.com>
From:   Hector Martin <marcan@marcan.st>
Subject: Re: [PATCH 0/7] mailbox: apple: peek_data cleanup and implementation
In-Reply-To: <20220524145540.363553-1-jassisinghbrar@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 24/05/2022 23.55, jassisinghbrar@gmail.com wrote:
> From: Jassi Brar <jassisinghbrar@gmail.com>
>> The mailbox API has a `peek_data` operation. Its intent and
>> documentation is rather ambiguous; at first glance and based on the
>> name, it seems like it should only check for whether data is currently
>> pending in the controller, without actually delivering it to the
>> consumer. However, this interpretation is not useful for anything: the
>> function can be called from atomic context, but without a way to
>> actually *poll* for data from atomic context, there is no use in just
>> checking for whether data is available.
>>
> Not exactly... the 'peek_data' is a means for client driver to hint the
> controller driver that some data might have arrived (for controllers that
> don't have anything like RX-Irq). The controller is then expected to dispatch
> data after "not necessarily atomic" read.

If that was the intent, there are no in-kernel users with the "hint"
intent... I am having a hard time imagining a use case for those semantics.

Are there any controllers without an RX IRQ? What do they do, poll
constantly? Or just assume all requests are req/response and have
drivers poll via this function when a request is pending? And in that
case wouldn't reading be atomic too anyway?

>   For example, a quick look at some bit may tell there is data available,
> but actually reading the data from buffer may be non-atomic.

Are there any examples of mailbox drivers that have this constraint?

>   In your case, you could already implement the patch-7/7 by simply calling it
> peek_data() instead of poll_data(). Its ok to call mbox_chan_received_data()
> from peek_data() because your data-read can be atomic.

So some mailboxes may implement peek_data in a way that guarantees
atomic/synchronous data arrival, and some may not, and consumers are
expected to just know how their particular mailbox behaves?

That doesn't sound like a very good API design...

> Also some platforms may not have users of peek_data upstream (yet), so
> simply weeding them out may not be right.

That's why everyone involved is CCed :)

I'm going to be honest though: I'm finding the entire mailbox
abstraction to be very frustrating. It's trying to cater to a bunch of
rather disparate hardware used as a low-level channel for very tightly
coupled drivers and, in the end, fails to be a useful abstraction since
it can't abstract those differences away. It would've taken us less code
to open-code the mailbox part of our driver into its only consumer,
would've saved a bunch of debugging and headaches, and would perform
better, and wouldn't lose any generality since we only have one consumer
anyway (and if we had more it'd still take less code to roll our own API
rather than using mailbox...).

-- 
Hector Martin (marcan@marcan.st)
Public Key: https://mrcn.st/pub
