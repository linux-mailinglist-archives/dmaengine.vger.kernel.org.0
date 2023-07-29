Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38E1C7681ED
	for <lists+dmaengine@lfdr.de>; Sat, 29 Jul 2023 22:59:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229529AbjG2U7E (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 29 Jul 2023 16:59:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjG2U7D (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 29 Jul 2023 16:59:03 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24B3D2D7D
        for <dmaengine@vger.kernel.org>; Sat, 29 Jul 2023 13:59:02 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id BFB235C0053;
        Sat, 29 Jul 2023 16:58:58 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Sat, 29 Jul 2023 16:58:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1690664338; x=1690750738; bh=ZZ
        1/TaxPYHX5JNgudz3merjNpfNfrr3gBTbRmLM/4CY=; b=bNRTNgu4KYksz/PCk6
        kCn2Id+oUWGs3PCNQdVu8Hb7QG1LPP/E0SoyO+CbU0mKYVo7CYyuiLr6ZJhbdeqL
        qwjulTc0sPtIUBp85UlyOm0xnNZ/uEm1xNeYzh1yJVKbNQZuwREQfmDCBqX8CEb1
        7zP18LzFJm+1gM5SE2aNZYewpdYzVPe1BNcUzSHmQxM6V31y2kmMGjFrHx34zFWW
        euRg9QfNew0fHgaRgiiL0Dxc96eecmlMoGEbwd1JikPbkafo6AlGvIwFu1aJnew8
        Uqo/79Xd2GQ74mDuG4wf4DDqRitJxtsQ+H5ybeMrcT12H7FHFGQU4Grzd7GmFV0a
        qOqQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1690664338; x=1690750738; bh=ZZ1/TaxPYHX5J
        Ngudz3merjNpfNfrr3gBTbRmLM/4CY=; b=S/Zv8/FlGt+COzUcd1D6B4hHVw0mb
        tWxIGW/thFyPQspLriiu8wBQT2//xA0acQQPRduym/XsBo83h35anwkEl7G2t7Cd
        fbpP0GK1t14+mBIgQ4bmJjzlM0Hqo4k12P3R1vsj+iswVFyy8FG5deuKvyHpoMQ3
        7ZljfQJGDmm0lOES7+ABbqSPg911s60//mEBzH0RrIUtot/j15YUCbgmFomlhwQF
        c+VUtyfgEoUjLpZm1j/QSxBl72ilnqfvBZcMZg1d4gyWC0Gho8ivxk/JH30GvAhH
        t94M+E4aaQlDZG6DGYpUDN0rWuyVMmGquNyEu77YxwYVBggNbi1ZSKrgg==
X-ME-Sender: <xms:kn3FZB1uG9GreiQ4jWqzYdB2_1C9ROAPk39OD8ShyqSEMeAXF9ssFQ>
    <xme:kn3FZIEMTp5Ibz8amhUi-FmRKdNpignnSiWhA31ybBtG7v1I-Tfrxcwu4lvF_JIE2
    dwIBZ6nIoKgjaOQYEA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrieekgdduhedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:kn3FZB6Rw-LDHIfA1LO88Y4X-joUr6fPD-PsRXMUF9shr6-GWQW7uA>
    <xmx:kn3FZO0pMVK2sLAPV7c6l8uU3sbi7xcKz-qKAOeDQ8sv2Xxal8afiA>
    <xmx:kn3FZEGMWZMalz97x3JJ0-hFDnV_8qMkY4Izy1XmvUjx2Bj-hbCgXw>
    <xmx:kn3FZOOl-H7VG0rnTDY3g6XHJims83GvZClsFeJk54l9v8cTc8nOUA>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 2C8DFB60089; Sat, 29 Jul 2023 16:58:58 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-592-ga9d4a09b4b-fm-defalarms-20230725.001-ga9d4a09b
Mime-Version: 1.0
Message-Id: <b58a175f-eb66-4991-b4b2-86b768c5b401@app.fastmail.com>
In-Reply-To: <20230729192945.1217206-1-festevam@gmail.com>
References: <20230729192945.1217206-1-festevam@gmail.com>
Date:   Sat, 29 Jul 2023 22:58:36 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Fabio Estevam" <festevam@gmail.com>,
        "Vinod Koul" <vkoul@kernel.org>
Cc:     dmaengine@vger.kernel.org, "Fabio Estevam" <festevam@denx.de>
Subject: Re: [PATCH] dmaengine: ipu: Remove the driver
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Sat, Jul 29, 2023, at 21:29, Fabio Estevam wrote:
> From: Fabio Estevam <festevam@denx.de>
>
> The i.MX3 IPU driver does not support devicetree and i.MX has been converted
> to a DT-only platform since kernel 5.10.
>
> As there is no user for this driver anymore, just remove it.
>
> Signed-off-by: Fabio Estevam <festevam@denx.de>

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
