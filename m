Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B44617B5ADB
	for <lists+dmaengine@lfdr.de>; Mon,  2 Oct 2023 21:04:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229482AbjJBS4A (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 2 Oct 2023 14:56:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjJBSz7 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 2 Oct 2023 14:55:59 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11397AC;
        Mon,  2 Oct 2023 11:55:55 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 552403200922;
        Mon,  2 Oct 2023 14:55:54 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Mon, 02 Oct 2023 14:55:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1696272953; x=1696359353; bh=6c
        8CEyhW0T1KUKzk8FlxN2l/UP5i5knDDkk8ab2GReE=; b=sAGEvWGsLv3CWwdEyY
        bLGiAdnJokm+kl2i5HNCVhkHnCc8cWxE0+RRvicZgvw2AnmhzY5uEKEUed3uoJLH
        DtiYKKBYoKuvo7L/yjR4IRSjaswnRV2w4uY4g/1OskyIezfP75ILMMOA5YfaHyGK
        bQ2MMJthbyJbOz6fx31NmYauncGZNG2g8S6ug2n9XwXfvY3ZHsNgEZ76r4meiS1E
        MiOUhPLC8anzzgY0hAaCbmT1VdZJ7bnQogbVL9Bccn9vJy/TYLnUGJAHWfzlr15U
        2D2Qk0z3LbTttH2f62rfMCa6+KkiwHNVfrFtDHXU3CMeQZRglBwFwTGjTPqVDvrb
        U2bA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1696272953; x=1696359353; bh=6c8CEyhW0T1KU
        Kzk8FlxN2l/UP5i5knDDkk8ab2GReE=; b=pneZPVpCfyk1fuAQ67ElcSY7ycvFB
        Tz9UKO7YeNFC5ear6gTGIw6cB4PTaRhqspHVweJiFjWN3eUV1KjLz2QCVWHPiOy0
        M8mZr39mUfKg7kls5ThmvOrT0hTtfyTJ1iZX8IrGGlXdGB6nOUiWFQmGdQfnncY6
        MIJkxjyEHfoiWZdIolUSLGCdl60YOT5y0AwFUhM+E5MPbFd8XixjDDpDPuIPiAtU
        mqlpPJ0V6Y4iTTFK4csH6UDhxpmijrq8upX6jcdln8UzInqXD74omk6mSmcc+1OC
        0BMhHGptyfkJujdaMviN9sTDjbbdy2lXt5/qmkNGZBiAYQPprBeVkd4Vw==
X-ME-Sender: <xms:ORIbZce_IHvVtjT8DnzYzsxxdLifDwJyoSQBuoXZJUGE85OYymvbjQ>
    <xme:ORIbZeONqH4Zurj2N961FeodSmJxy496vUPH9uId7xg_6uglfz6EpuWA_lofq8nQG
    PQMm4JUmE2HJVxJ-CY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfedtucetufdoteggodetrfdotffvucfrrh
    hofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    epofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehrnhguuceu
    vghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrthhtvghrnh
    epffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdekteffnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnhguse
    grrhhnuggsrdguvg
X-ME-Proxy: <xmx:ORIbZdiz4vsbXMzZG_RDly8F5Te7yZNneHAnt9WKkgt68H9cJN_JjQ>
    <xmx:ORIbZR8PHk11RY2-j0x0O7QlNfN2dffnHJJruqjgCpIZaRtN5NgpZQ>
    <xmx:ORIbZYsOOuYLyBy_mm1SSD8JLGWLVSUAwmHMzfyWsxs5tbut82r0sw>
    <xmx:ORIbZd9WLdcn59dVr8YVMrvuJcQxN885mniEjA6R3HrboeXIQfS9IQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 5FF0FB60089; Mon,  2 Oct 2023 14:55:53 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-958-g1b1b911df8-fm-20230927.002-g1b1b911d
MIME-Version: 1.0
Message-Id: <7f39410a-72fc-463e-b41c-64674ab4f129@app.fastmail.com>
In-Reply-To: <20231002183750.552759-2-Frank.Li@nxp.com>
References: <20231002183750.552759-1-Frank.Li@nxp.com>
 <20231002183750.552759-2-Frank.Li@nxp.com>
Date:   Mon, 02 Oct 2023 20:55:23 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Frank Li" <Frank.Li@nxp.com>, "Vinod Koul" <vkoul@kernel.org>
Cc:     "Baoquan He" <bhe@redhat.com>, dmaengine@vger.kernel.org,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        imx@lists.linux.dev, linux-kernel@vger.kernel.org,
        "kernel test robot" <lkp@intel.com>, oe-kbuild-all@lists.linux.dev,
        "Rafael J . Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v5 1/3] debugfs_create_regset32() support 8/16 bit width registers
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Mon, Oct 2, 2023, at 20:37, Frank Li wrote:
> Enhance the flexibility of `debugfs_create_regset32()` to support registers
> of various bit widths. The key changes are as follows:
>
> 1. Renamed '*reg32' and '*regset32' to '*reg' and '*regset' in relevant
>    code to reflect that the register width is not limited to 32 bits.
>
> 2. Added 'size' and 'bigendian' fields to the `struct debugfs_reg` to allow
>    for specifying the size and endianness of registers. These additions
>    enable `debugfs_create_regset()` to support a wider range of register
>    types.
>
> 3. When 'size' is set to 0, it signifies a 32-bit register. This change
>    maintains compatibility with existing code that assumes 32-bit
>    registers.
>
> Improve the versatility of `debugfs_create_regset()` and enable it to
> handle registers of different sizes and endianness, offering greater
> flexibility for debugging and monitoring.
>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

This version looks correct to me, I see no fundamental problems with it.
In fact, you could list "support for ioport_map() output" to the features
above.

A few other thoughts from my side, all of which could be ignored:

- if the ioport access is not an important feature, we can instead
  support 64-bit readl() as I commented in a previous email. We just
  can't easily have both.

- instead of treating every value of "regs->size" other than 1 and 2
  as meaning '32-bit read', I would explicitly check for 0 and 4
  here

- Another more complicated but also more featureful variant would
  be to use the 'regmap' infrastructure as the abstraction, this would
  also provide access to big-endian, variable register width
  (including 64-bit), and pio, along with additional features and
  other bus types. Not sure it's worth it, but could be interesting
  to try out.

     Arnd
