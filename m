Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B531C7D51F5
	for <lists+dmaengine@lfdr.de>; Tue, 24 Oct 2023 15:38:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234706AbjJXNh7 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 24 Oct 2023 09:37:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234671AbjJXNhm (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 24 Oct 2023 09:37:42 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBC736A6A;
        Tue, 24 Oct 2023 06:27:52 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 5F12E5C0216;
        Tue, 24 Oct 2023 09:27:52 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Tue, 24 Oct 2023 09:27:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1698154072; x=1698240472; bh=mZ
        Ic3ODqVfmRDC8OmnbKWJpKU+qowmrOocKwZsiY3KQ=; b=N2SBD4tqmXJ4l+91e6
        AZFyVBxgNWMLBFtvzB30CRePi0TAgMxwUbAqeWtFIuhxhYz68kjMvDz+YyPSAwNW
        7Ns+9zv87wrxdidXC0/b6vUXEF1RJz6Mi0CiF1NLC1VuIdHcZIlFU0V+3NmbAGh8
        8zNg9sOFELaOeOZ0qQQ+Qy+S3st874WjXYH+9P3ekX98DJCertkx9m4XjlmPIofj
        +ARnWrQ6EdGgfjc+DEImDfc3FeCyFCIpPoJfU93eJNONADQG4+Z6NDz7Wem8N9D+
        csI6WVtNQA1s5BwvtuKFvHSzis91VePf+Ca8DVlSR+FzaTjlDRkqMeLtK2Vo/s1l
        +Rww==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1698154072; x=1698240472; bh=mZIc3ODqVfmRD
        C8OmnbKWJpKU+qowmrOocKwZsiY3KQ=; b=n/lsjlFFRx6bOPjJKnOKg1uL6b/vM
        KHNj7gagIRbS3iVK+OtV5dx2bo1ooZYtuoPbXyo/jNExhql+vwytKUp3grQtVaDQ
        oblgJkQOFdptTjmuCTxrbdgx0X2QZVC3yPw74Lt938x/vgCKZnQ9+qlpnQsmq+nU
        j3tZ2j0Wg1WJgWxZybFlsheVnG1zf4rMQzFDYflwwQciMJS1LapCEln6oozabXRY
        QJdIz2Ob8muP+42zZTXtDAehcOzLc0FpMp0fN3FmftKwvtVlcHb5eK33N1rQhICA
        nRyg3Uikgmt7VnfmldrZK4ev3LGT/tjPB6/4fceAVIByc++cjXfwo2i9A==
X-ME-Sender: <xms:V8Y3ZQokJPmgs8ujhS_wU_xZZ-Q3nAHPCLd5Zqi8LtHrLhG-qF7riQ>
    <xme:V8Y3ZWpw8rk-B10ghN4gwUem6yr_dDASbmWL__hYG0UIWx0JNpeKd8fV5-wJy540R
    MlzcJAhR6PuwHB08vk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrkeekgdeifecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedtkeet
    ffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
    hnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:V8Y3ZVNxUYJT52DG2H2Gf7pBL2Eg10nM313D0RYr39v1Z2wKfORkew>
    <xmx:V8Y3ZX4-5V8tt3L78tqMcZWOaqnbC0LJTKXCdDj5AcbEOkPkSd9lQg>
    <xmx:V8Y3Zf6TLOeIsQOhGN8vHJVT3Bmsz4AiscGKRW7gDuDkbcDDFzPpbg>
    <xmx:WMY3ZZtU22rjjXit3OegHog0M1AvB2Za-q4CaDtvEcOzFxShRnaxtw>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id AEBEFB60089; Tue, 24 Oct 2023 09:27:51 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1048-g9229b632c5-fm-20231019.001-g9229b632
MIME-Version: 1.0
Message-Id: <78427021-ddc0-45b6-a16b-bf8bc8f84003@app.fastmail.com>
In-Reply-To: <20231023160539.1537355-2-arnd@kernel.org>
References: <20231023160539.1537355-1-arnd@kernel.org>
 <20231023160539.1537355-2-arnd@kernel.org>
Date:   Tue, 24 Oct 2023 15:27:30 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Arnd Bergmann" <arnd@kernel.org>,
        "Martin Tuma" <martin.tuma@digiteqautomotive.com>,
        "Mauro Carvalho Chehab" <mchehab@kernel.org>,
        "Hans Verkuil" <hverkuil-cisco@xs4all.nl>,
        dmaengine@vger.kernel.org, "Lizhi Hou" <lizhi.hou@amd.com>,
        "Brian Xu" <brian.xu@amd.com>,
        "Raj Kumar Rampelli" <raj.kumar.rampelli@amd.com>,
        "Vinod Koul" <vkoul@kernel.org>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] media: pci: mgb4: remove bogus 'select' statements
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Mon, Oct 23, 2023, at 18:05, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>
> As this is just a regular device driver, it has no business force-enabling
> other drivers in the system, it should be entirely independent of the
> implementation of the spi-nor layer or the specific DMA engine.
>
> The IIO symbols that are selected here are library modules that
> are legitimately used.
>
> Fixes: 0ab13674a9bd ("media: pci: mgb4: Added Digiteq Automotive MGB4 driver")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/media/pci/mgb4/Kconfig | 4 ----
>  1 file changed, 4 deletions(-)
>
> diff --git a/drivers/media/pci/mgb4/Kconfig b/drivers/media/pci/mgb4/Kconfig
> index f2a05a1c8ffa..b90347c7f19b 100644
> --- a/drivers/media/pci/mgb4/Kconfig
> +++ b/drivers/media/pci/mgb4/Kconfig
> @@ -6,10 +6,6 @@ config VIDEO_MGB4
>  	select VIDEOBUF2_DMA_SG
>  	select IIO_BUFFER
>  	select IIO_TRIGGERED_BUFFER
> -	select I2C_XILINX
> -	select SPI_XILINX
> -	select MTD_SPI_NOR
> -	select XILINX_XDMA

Apparently, the XDMA reference was in fact needed, as MGB4
calls some exported symbols from that particular dmaengine
driver:

aarch64-linux-ld: drivers/media/pci/mgb4/mgb4_core.o: in function `init_i2c': mgb4_core.c:(.text+0x3ec): undefined reference to `xdma_get_user_irq'
aarch64-linux-ld: mgb4_core.c:(.text+0x404): undefined reference to `xdma_enable_user_irq'

I couldn't easily figure out what a 'user_irq' is here,
but I wonder if this is the expected way to use the DMA engine
layer. Maybe this should have been a nested irqchip instead,
or it should be encoded in the DMA request specifier?

     Arnd
