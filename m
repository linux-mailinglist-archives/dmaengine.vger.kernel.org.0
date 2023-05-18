Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B31B2708090
	for <lists+dmaengine@lfdr.de>; Thu, 18 May 2023 13:59:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230128AbjERL7d (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 18 May 2023 07:59:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230036AbjERL7c (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 18 May 2023 07:59:32 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65339AC;
        Thu, 18 May 2023 04:59:31 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 0B1BD5C0183;
        Thu, 18 May 2023 07:59:29 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Thu, 18 May 2023 07:59:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1684411169; x=1684497569; bh=j7
        gx/xJWA0YhHeiCeJS3kGDMo9XKxha1/w1dZ8k7PYA=; b=W9wefS3Y0zTtpNrGfg
        Xgvs8Ja7T6vysCxzJPZ5gkky9EuKLTpkT/scvY+PWjJlOYekTvDx/oqsJJS11mmj
        xdOyb4SYwqQTQ8DIzj/PwHorRGqXeZc2Nlaxlh7jlGgdnInMYu+q2HDNEH6/q8RS
        aGlrLvQwMwNo87Q0dVEC/e9K5fEClQYdVh1G0WHxdHyCsJmlfISPVTUQlFfdj1P3
        caLCZT9it01GogWNbUh2Sj9tvE6IB7J05qqFvhQBlyyxHKDVms7e/GCyYBqSxwi+
        nLYMap584icp7vgNWD+x3yrRAZILGemqZlpFMCffevlF2y4rAUO7pg9s3JSzZsZq
        9Maw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1684411169; x=1684497569; bh=j7gx/xJWA0YhH
        eiCeJS3kGDMo9XKxha1/w1dZ8k7PYA=; b=StRuArfq4c8MlwrSj1wEqQT8XI/pS
        TiSQIPyCnQ1KSjhBlTxnqRheWwbTMuuIrPM/yoqlAlGqBMvsRVOTmZH8izwmpU1N
        WoZ1QpKrUBr3y7vIWs+4HQEiaTF7oJpXUd9DZ7vCy4sOfxwnsqOVEONu2PDw2Mr2
        asnrEz9IsZ2vrJsUo/nWoPJMfqxq+RljAyFN59deL5THLDY5djjyAXpG4j81U0qV
        IT2mlsg4JirpxOUvztDPH8NEyweJU0CeQFFyfvWZhIPdNW6fQjZdbjCQ7s8X4ptg
        akVgelbJ4Dy2PjYxR3IEjqqP0I+voSzM6s51NVP9yjuZ1cSbkef2qAoCw==
X-ME-Sender: <xms:IBNmZKBzdrrpg5WoNaoEXnl3ptJh0TbXaBVG8KX-zLWFfSQI8jT5yw>
    <xme:IBNmZEgXx28-R76kVvG3GLf8enaz9mrCqHSNqJW6FsTA1SDUqRWPUEsEcXeZ91T5K
    2xyDK71aO1NROj2PkY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeeifedggeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepvefhffeltdegheeffffhtdegvdehjedtgfekueevgfduffettedtkeekueef
    hedunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:IBNmZNnxb1RFG9uUZeYDw4eo-Lvcz9C0MM71ijxlvkhcnpch58mTYg>
    <xmx:IBNmZIxb4u1kkmIwATIZZJRFHYFLZHUCW5qvT0rR2ETrOUr4N46bxA>
    <xmx:IBNmZPSG9LA3YyLKqFAxzydZ9R-3CgjDUzzydJjIKUkqn1ciwdOX_Q>
    <xmx:IRNmZNMJaFUXzmtp0cEq9O8o6JDljVGhdXX2jHt7y24DQoo_KRBolg>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 6D646B60086; Thu, 18 May 2023 07:59:28 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-431-g1d6a3ebb56-fm-20230511.001-g1d6a3ebb
Mime-Version: 1.0
Message-Id: <2b7eef56-9409-46bd-bcf7-dea054adfccd@app.fastmail.com>
In-Reply-To: <ZGYMJWoOYL0ddPBg@matsya>
References: <20230517201951.619693-1-arnd@kernel.org>
 <ZGYMJWoOYL0ddPBg@matsya>
Date:   Thu, 18 May 2023 13:59:08 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Vinod Koul" <vkoul@kernel.org>, "Arnd Bergmann" <arnd@kernel.org>
Cc:     "Linus Walleij" <linus.walleij@linaro.org>,
        "Julia Lawall" <Julia.Lawall@inria.fr>,
        linux-arm-kernel@lists.infradead.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dmaengine: ste_dma40: use proper format string for resource_size_t
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Thu, May 18, 2023, at 13:29, Vinod Koul wrote:
> On 17-05-23, 22:19, Arnd Bergmann wrote:
>> From: Arnd Bergmann <arnd@arndb.de>
>> 
>> When LPAE is set, both the dma_addr_t and resource_size_t become 64 bit
>> wide, causing a warning about the format string:
>> 
>> drivers/dma/ste_dma40.c: In function 'd40_probe':
>> drivers/dma/ste_dma40.c:3539:23: error: format '%x' expects argument of type 'unsigned int', but argument 4 has type 'resource_size_t' {aka 'long long unsigned int'} [-Werror=format=]
>>  3539 |         dev_info(dev, "found LCPA SRAM at 0x%08x, size 0x%08x\n",
>> 
>> Change both to the special %pap and %pap helpers for these types.
>
> Already posted [1] and applied now
>
> [1]: https://lore.kernel.org/r/20230517064434.141091-1-vkoul@kernel.org

I think yours is wrong: you use %pR with a resource_size_t, but it
expects a "struct resource instead".

      Arnd
