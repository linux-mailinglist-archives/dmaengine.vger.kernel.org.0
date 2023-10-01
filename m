Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 525537B4871
	for <lists+dmaengine@lfdr.de>; Sun,  1 Oct 2023 17:42:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235112AbjJAPm3 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 1 Oct 2023 11:42:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234846AbjJAPm3 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 1 Oct 2023 11:42:29 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE573DA;
        Sun,  1 Oct 2023 08:42:25 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 5A4695C2B27;
        Sun,  1 Oct 2023 11:42:25 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Sun, 01 Oct 2023 11:42:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1696174945; x=1696261345; bh=Eq
        8X0eVmOz7DANbzW3I7LbcdIkb+KZjZmPd1QRhAKl4=; b=No4RpmE/rT30uObrTB
        Z5Kz+b8yG8wWM/I7KM0kEarzqc5ZmukOUQ8uTwKhrtxt01nqaoc/RhbRmN9ZRjf/
        OV9bgd0aSxfDQ5S75SAPQU0Fso/qtE8iPyzeyv6P7qi4rarAggr1Pw81TjsgnPFB
        L42GeR09MzJPVAYFDnAKO4ZE4DO5FNoxOYaShPILm6KYWp7YB2Pj7MiZF/OkSgo/
        +v2Jg1GGY7qZNJ92salcD5bWlGg1/neqiKWKRxmea9R/lOYuLi+IhiBn3yT2ifyq
        zvrVwO+biU4rPSJqymXVPQfnj7SaL8WsvDxJSwSUVQPXsShpwwYVIFhcEuqrqRTX
        ryBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1696174945; x=1696261345; bh=Eq8X0eVmOz7DA
        NbzW3I7LbcdIkb+KZjZmPd1QRhAKl4=; b=LiMji9DSASPAO0yGheG4jb6R6dbi6
        8X8Q0kSlSdrjmSntzrTWg134c+Q7e5njgfFgR2JTM8tw3rVJfVWRLHJVD92XMtQD
        TXiYglk6E4YwHM4V/8IilOUhUtJIxYyeCdlfuaCtpAroVHJjdp3NxERZF1bJ81D5
        vwJFiSKcKA2RgbsJZQR40AUEHMJ7rgEhceNjLc8oMRwkX30mn8bCUm3WMPPMQpbe
        UslqFGE2PyE9RZv/Hb8pZdBtsUq8EqBi4bHzDmidrWFesls/j8MxVGK6xR1uhU7i
        +I0NUliTpFss5ZYP8QH9v/pTvHW4Omt9wHdmXnLNEI+Z1xysaL+dEnU4Q==
X-ME-Sender: <xms:YZMZZQLoU6HZhSGlsLzH40pNZvzHG0jyaHgv56pdsCWT2nJhZGAUVQ>
    <xme:YZMZZQKx-fhS9xS8aCpVo3vooziIN0rO_e4duAvckoQSt7gPZkQY87Z_5O63sDRkt
    HvAftj1iF1hXf-Ag6s>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvddvgddtudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedtkeet
    ffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
    hnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:YZMZZQuCkDh5UWKjtkHUbxFoPc2UDMrrF1DfTg5yzGTbDLq_-OBrxA>
    <xmx:YZMZZdasZJvbbWn2ZJCHE1Zz5kXRu5WumfLN7lN4ky4V9M-I_FWL2g>
    <xmx:YZMZZXafscJUjEysevzVboTT9BC1LycgwaGSPN8EGjDYfNa7sVZv1A>
    <xmx:YZMZZb5_GRKzOLFwcOQLN1wAXn5t6E7Ho-vXbnMFbfz-Zx1lbqRTAQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 1E12CB6008D; Sun,  1 Oct 2023 11:42:25 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-958-g1b1b911df8-fm-20230927.002-g1b1b911d
MIME-Version: 1.0
Message-Id: <b795ed61-0174-487f-a263-8431e7c76af5@app.fastmail.com>
In-Reply-To: <ZRlWeeq/AOjyTtnV@MiWiFi-R3L-srv>
References: <20230929164920.314849-1-Frank.Li@nxp.com>
 <ZRlWeeq/AOjyTtnV@MiWiFi-R3L-srv>
Date:   Sun, 01 Oct 2023 11:42:04 -0400
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Baoquan He" <bhe@redhat.com>, "Frank Li" <Frank.Li@nxp.com>
Cc:     "Vinod Koul" <vkoul@kernel.org>, dmaengine@vger.kernel.org,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        imx@lists.linux.dev, linux-kernel@vger.kernel.org,
        "kernel test robot" <lkp@intel.com>, oe-kbuild-all@lists.linux.dev,
        "Rafael J . Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 1/1] fs: debugfs: fix build error at powerpc platform
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Sun, Oct 1, 2023, at 07:22, Baoquan He wrote:
> On 09/29/23 at 12:49pm, Frank Li wrote:
>>    ld: fs/debugfs/file.o: in function `debugfs_print_regs':
>>    file.c:(.text+0x95a): undefined reference to `ioread64be'
>> >> ld: file.c:(.text+0x9dd): undefined reference to `ioread64'
>
> From your reproducer, on x86_64, GENERIC_IOMAP is selected. So the
> default version of ioread64 and ioread64be in asm-generic/io.h are
> bypassed. Except of those arch where ioread64 and ioread64be are
> implemented specifically like alpha, arm64, parisc, power, we may need
> include include/linux/io-64-nonatomic-hi-lo.h or
> include/linux/io-64-nonatomic-lo-hi.h to fix above linking issue?
>
> From my side, below change can fix the issue. However, I am not quite
> sure which one is chosen between io-64-nonatomic-hi-lo.h and 
> io-64-nonatomic-hi-lo.h.

It looks like the latest version of the patch only calls
it for 64-bit targets, so this question should not come up.

On 32-bit targets, it is driver specific which one you need,
so having it generic code would require passing a flag from
a driver, but I think that adds more complexity than it help.

     Arnd
