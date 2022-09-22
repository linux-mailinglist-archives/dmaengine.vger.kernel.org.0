Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58FEF5E63F3
	for <lists+dmaengine@lfdr.de>; Thu, 22 Sep 2022 15:44:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230383AbiIVNon (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 22 Sep 2022 09:44:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230417AbiIVNol (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 22 Sep 2022 09:44:41 -0400
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DB0D6313;
        Thu, 22 Sep 2022 06:44:36 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id A3350425BE;
        Thu, 22 Sep 2022 13:44:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=marcan.st; s=default;
        t=1663854274; bh=ZjgbMoWn7oYVqCiV35xhfgHZ/kJ0mzZefvAN1VyX0/8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=P9eaAKkcJVrdhQWTGDXEx5YbeRf66HZc/RPQllLitBBsSU1Rki4HaEFV1H7IKrEdQ
         HrkTOCKz6KjRqWSW0L0Pew7TqnVtXsuh2Y3XZ3qMV12hinRH4MFO/TFVrkjzumCyrb
         iZJ/602jfHe9PDalr4XnThHYw5EBLHvJSb33P3Z1o6FAQVBm0gV+i/5nOmTEx9cSdx
         RifSWApM4p1ME4UIm4jKbEcqiZy9IN1+JaKz32iIMJEKQXm67Dh2hcYtSZ7xMJQoNo
         AUp3DnX/5LlZttIXsiaY83AYgfXZKxtnto+57FXDGj/qcqzL6DWJ/su8/CCJYtrNBu
         cBWNy4RWz7TSg==
Message-ID: <de3166f2-c851-ded5-d83a-f1b5f886da3a@marcan.st>
Date:   Thu, 22 Sep 2022 22:44:28 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 0/4] Apple ADMAC peripheral reset clean-up
Content-Language: es-ES
To:     =?UTF-8?Q?Martin_Povi=c5=a1er?= <povik+lin@cutebit.org>,
        Sven Peter <sven@svenpeter.dev>, Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Alyssa Rosenzweig <alyssa@rosenzweig.io>, asahi@lists.linux.dev,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220918095845.68860-1-povik+lin@cutebit.org>
From:   Hector Martin <marcan@marcan.st>
In-Reply-To: <20220918095845.68860-1-povik+lin@cutebit.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 18/09/2022 18.58, Martin Povišer wrote:
> On Apple SoCs the ADMAC peripheral shares a reset line with another
> audio-related peripheral which is the MCA.
> 
> On the side of the MCA, the reset is described in binding (staged in
> broonie-sound/for-6.1) and in the soon-to-be-merged series adding new
> nodes to t8103/t600x SoC device trees [1]. The staged MCA driver does
> make use of the reset, knowing it's a shared one.
> 
> This series catches up on the ADMAC side, adds the reset to the binding
> and describes it in the t8103/t600x DTs (on top of [1]). It also pulls
> the shared reset from the driver.
> 
> Since [1] already includes another ADMAC binding change and will
> probably be fully merged into Hector's asahi-soc tree, I propose the
> binding change here takes the same route. Leaving patches #3 and #4 to
> go into dmaengine.
> 
> [1] https://lore.kernel.org/asahi/87pmful5r4.wl-maz@kernel.org/T/#t
> 
> Martin Povišer (4):
>   dt-bindings: dma: apple,admac: Add reset
>   arm64: dts: apple: Add ADMAC resets on t8103/t600x
>   dmaengine: apple-admac: Do not use devres for IRQs
>   dmaengine: apple-admac: Trigger shared reset
> 

Applied patches #1-#2 to asahi-soc/dt, thanks!

- Hector
