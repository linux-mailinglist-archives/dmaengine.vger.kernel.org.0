Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A3347B5B76
	for <lists+dmaengine@lfdr.de>; Mon,  2 Oct 2023 21:42:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238881AbjJBTkE (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 2 Oct 2023 15:40:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbjJBTkD (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 2 Oct 2023 15:40:03 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDE78A9;
        Mon,  2 Oct 2023 12:40:00 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 0096A3200938;
        Mon,  2 Oct 2023 15:39:58 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Mon, 02 Oct 2023 15:40:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1696275598; x=1696361998; bh=cR
        5FbbI1lqxiB+qg6Zn8X90jiVThNPnVu7FeZ8sfAZw=; b=fOSacZgYq/lloDMgcZ
        kmWlto4/kkhiERdf+7acBJj0SpSd8VTdwCLZS0dGW2xckckf0xkUTR3k2DrW982V
        hWM8l2M3lpwcpdZXhYHg3eAFHTtbIopR6/Hf8PrKoagTRtjIVkbOKEXVKBcSDADx
        NhxbgrhfLC6qoiAnYchZB0OuHHaWKDc5lJ122suYDuPdPZ9VL858jf2AWTcxJYU6
        jipDeZDr8999ad5P6nZdojt01AyeArHpHCIE+lX+LF421EP+KfSv6Oz5rsaiveus
        krBCefEdv3YaVHDBGVtiKuboyry7MIEDZVFOEC0oQjpOWshiE60TzMu2c5jLssJB
        2Otw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1696275598; x=1696361998; bh=cR5FbbI1lqxiB
        +qg6Zn8X90jiVThNPnVu7FeZ8sfAZw=; b=p9qPWXMjmowPXbbtC3ETYwGHqutJA
        DprpZx1X6mXfVWnHjMUk9DmzFM9N/UiNj4CiRzjOJ1cTIBHQHnDRNJ8GTK+Ms2Y1
        7lpZfOT7wV7HGvdL6BWyzFnXeSqfdV/P76d/o6cC9yWvbev0NwFC1Qs9egQchqtB
        rwpUx1T+NXZa6WUjYNhieAltn2ZY18pmT5RFndZsslF1UWZd7Ftghh+FG9fDnfHQ
        J6iOLjiIhYm8lMz9WLWYfh+XUt0rFy61eWk4IIN61eJ7R/QVHu8zg7T+wV/EKqGe
        fpdYJSTtlZDIHYL3ibu1/oMJJTfpYicYguTQaxS0wzUMtJp55vkG39FTA==
X-ME-Sender: <xms:jhwbZe6zekTDeV4YNKJN-xjfElS_DAy0KriuXORQj1uoQ6ADoJwrZw>
    <xme:jhwbZX6MRPH-PVMc5rnjl0Nav6w971eaUGaZEEzv35DDWEwvXyl3s4QjxTAwTbk18
    JmNG5jHRhjGZaLRhqU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfedtgddtlecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedtkeet
    ffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
    hnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:jhwbZddd8Q-JqW8wf6JogexRpGgRoh3uVJ-73U9GWyQbtT-aZlQIYw>
    <xmx:jhwbZbKKK91GnIUzwHUswbyUcOj5DRJOEmisHrbf0RohYHJ8Y2f-pA>
    <xmx:jhwbZSK-gb6fn8KNCFSHQ2_k5VxW-u_uckZdAD1y5CJ3Tc8B85jneQ>
    <xmx:jhwbZToyAqdoqu8eWqF8266BWU330edIn07g6yr-rcDgQvrDHNNqdw>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 124A7B6008D; Mon,  2 Oct 2023 15:39:58 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-958-g1b1b911df8-fm-20230927.002-g1b1b911d
MIME-Version: 1.0
Message-Id: <77c827ac-06a3-44fc-97ff-45db82ac0206@app.fastmail.com>
In-Reply-To: <ZRsU2gfjxAAOiHyy@lizhi-Precision-Tower-5810>
References: <20231002183750.552759-1-Frank.Li@nxp.com>
 <20231002183750.552759-2-Frank.Li@nxp.com>
 <7f39410a-72fc-463e-b41c-64674ab4f129@app.fastmail.com>
 <ZRsU2gfjxAAOiHyy@lizhi-Precision-Tower-5810>
Date:   Mon, 02 Oct 2023 21:39:37 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Frank Li" <Frank.li@nxp.com>
Cc:     "Vinod Koul" <vkoul@kernel.org>, "Baoquan He" <bhe@redhat.com>,
        dmaengine@vger.kernel.org,
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

On Mon, Oct 2, 2023, at 21:07, Frank Li wrote:
> On Mon, Oct 02, 2023 at 08:55:23PM +0200, Arnd Bergmann wrote:
>
>> A few other thoughts from my side, all of which could be ignored:
>> 
>> - if the ioport access is not an important feature, we can instead
>>   support 64-bit readl() as I commented in a previous email. We just
>>   can't easily have both.
>
> We will get 64bit dma edma soon. So I can test and upstream it when I get
> it.

Ok, so if we already know this is going to be needed, then I would skip
the PIO support and just use read{bwlq}() with the optional swab() instead
of the ioread variants. Otherwise there is a risk that someone starts
relying on the port I/O feature and make it harder to remove.

     Arnd
