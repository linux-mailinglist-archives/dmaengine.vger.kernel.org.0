Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 093C4517A9B
	for <lists+dmaengine@lfdr.de>; Tue,  3 May 2022 01:19:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230057AbiEBXWo (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 2 May 2022 19:22:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbiEBXWm (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 2 May 2022 19:22:42 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E4C12FFC7;
        Mon,  2 May 2022 16:19:10 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 131DB5C0126;
        Mon,  2 May 2022 19:19:07 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Mon, 02 May 2022 19:19:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1651533547; x=
        1651619947; bh=j+w4aZi5v5IBjtXn+OMWv0KN8l+vQ1Kj+B0xEUZBiK8=; b=H
        itbHzXqmfiWvSynlZxlj0DIZ/NEHYt9FBybnw/+WlRpgwyCZbkw4E6Z0KM9EcvOT
        qbJeg9Cu6vilgWoGW5KftLkJ1w9i86yvRnxQiXrMtLKlGZ+eZ3HEnm8ppBTy9qBi
        m5ca4id8xbnH+LPZvF0+cLkENhaeAe6jFVrduj4c2/ZI+of50oUk2dvod/bxXtHw
        O6SVsUgePAVKNyiLvBpv0ZKsGYP+JuL7dYGLVgvM1oEZlP/Wqr3DQ86zQoXMTlV0
        oERuc9RGL7t9HqPlqgLeqf3NVb/k6RJYEmeovBRayITFaoM/8wiwrhe/fLBlfLvM
        86ugkO7joGfsiCSwS3HeA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1651533547; x=1651619947; bh=j+w4aZi5v5IBj
        tXn+OMWv0KN8l+vQ1Kj+B0xEUZBiK8=; b=TN4OzxbbpXalCHfBcmQd0D32OoQ2w
        HN9y87W2p87hYdlfgP3vC3NzvsqVSEoZtmlkHJzAkhF5AfF9E11hvOH5oc746Mfc
        ekoEBUNWSMSgXeTowuBBiHa/vJQSP49FMZvFhpJU+oIiCAycYPSPJTjB8m/5FuFQ
        5EczwvA4w8TIbweRPPsRrYpA5bDh9+tUaP3EFDeI11Acc9SZtwsEc+a301FbPeHD
        vt66o7I3skMuNtSuDm1xiPmMaUOCtFvhDnsR0EZy1l1Fyo+l49FEN8x+bofLxsep
        vyz7iV0B+uSGLdza7ZuI6vqWSoNt8qenrwY5S/5cVvxWlH8xIu/wVOCig==
X-ME-Sender: <xms:6mZwYiQofXTrtnAUbMbj-gdUN9sZP9ccSDQHfjrCEtqdChjzW6y3sw>
    <xme:6mZwYnyLgIyoJQiMFv1ecsqtHsFErKaZX6Sd62lfDJ_u4jc7mlQimfYvzKjKwrcSg
    AAdwCwskqdPAiy0Fg>
X-ME-Received: <xmr:6mZwYv0jvWUS7sDELg-sey-Xz9TeHNNu9DRVg4j9rjEYFpT_-rTFCMJ3SF8fiffhIBsqCQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdeigddulecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefuvfevfhfhkffffgggjggtgfesthejredttdefjeenucfhrhhomhepufgrmhhu
    vghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecugg
    ftrfgrthhtvghrnhepffdtveekvdegkeeuueetgfetffeileevudekuefhheelvdfhiedt
    heduhfduhefhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:6mZwYuAM_ReHiloaktzP0m0PzxlrTvyb7SemvqWRBYoNzQa1M9DHZQ>
    <xmx:6mZwYrh_E-v80WmKrOWvQ_Jv4r6RI3AVfqbK3n1rl7qAPrSh1dqgdA>
    <xmx:6mZwYqpNk2ryWM1WVNhE76SDl1GRij8ATSEN03s4KvebR0QSkp1dNg>
    <xmx:62ZwYr5NHWgMgEtgsCxNwmjrlf5ldKw0UuU_U7YlyDkMLxT-S38DYA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 May 2022 19:19:05 -0400 (EDT)
Subject: Re: [PATCH 2/7] mailbox: sun6i: Unexport unused
 sun6i_msgbox_peek_data
To:     Hector Martin <marcan@marcan.st>
Cc:     Anup Patel <anup.patel@broadcom.com>,
        Vinod Koul <vkoul@kernel.org>, Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Mun Yew Tham <mun.yew.tham@intel.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        Jassi Brar <jassisinghbrar@gmail.com>
References: <20220502090225.26478-1-marcan@marcan.st>
 <20220502090225.26478-3-marcan@marcan.st>
From:   Samuel Holland <samuel@sholland.org>
Message-ID: <c567f22d-db52-d2c5-b8cb-7b0cb93ff35c@sholland.org>
Date:   Mon, 2 May 2022 18:18:56 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20220502090225.26478-3-marcan@marcan.st>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 5/2/22 4:02 AM, Hector Martin wrote:
> This op was ambiguously specified, and the way it was interpreted for
> this implementation is not useful. It has no users, so remove it. The
> function is used internally by the driver, so just remove it from the
> ops structure.
> 
> Signed-off-by: Hector Martin <marcan@marcan.st>

Acked-by: Samuel Holland <samuel@sholland.org>
