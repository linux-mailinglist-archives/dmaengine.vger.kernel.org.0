Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A01975F0701
	for <lists+dmaengine@lfdr.de>; Fri, 30 Sep 2022 11:01:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231158AbiI3JBp convert rfc822-to-8bit (ORCPT
        <rfc822;lists+dmaengine@lfdr.de>); Fri, 30 Sep 2022 05:01:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231268AbiI3JBi (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 30 Sep 2022 05:01:38 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 661AA147CD6
        for <dmaengine@vger.kernel.org>; Fri, 30 Sep 2022 02:01:30 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1oeBtU-0002K6-1Y; Fri, 30 Sep 2022 11:01:16 +0200
Received: from [2a0a:edc0:0:900:1d::4e] (helo=lupine)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1oeBtM-003lds-D4; Fri, 30 Sep 2022 11:01:06 +0200
Received: from pza by lupine with local (Exim 4.94.2)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1oeBtK-000326-1D; Fri, 30 Sep 2022 11:01:06 +0200
Message-ID: <f3ca1852b5ddfa9b0be4742779838b3ba18a0e5d.camel@pengutronix.de>
Subject: Re: [PATCH 4/4] dmaengine: apple-admac: Trigger shared reset
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Martin =?UTF-8?Q?Povi=C5=A1er?= <povik+lin@cutebit.org>,
        Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>, Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Alyssa Rosenzweig <alyssa@rosenzweig.io>, asahi@lists.linux.dev,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Fri, 30 Sep 2022 11:01:05 +0200
In-Reply-To: <20220918095845.68860-5-povik+lin@cutebit.org>
References: <20220918095845.68860-1-povik+lin@cutebit.org>
         <20220918095845.68860-5-povik+lin@cutebit.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.38.3-1 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: dmaengine@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Martin,

On So, 2022-09-18 at 11:58 +0200, Martin Povišer wrote:
> If a reset domain is attached to the device, obtain a shared reference
> to it and trigger it. Typically on a chip the ADMAC controller will
> share a reset domain with the MCA peripheral.
> 
> Signed-off-by: Martin Povišer <povik+lin@cutebit.org>
> ---
>  drivers/dma/apple-admac.c | 22 +++++++++++++++++++---
>  1 file changed, 19 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/dma/apple-admac.c b/drivers/dma/apple-admac.c
> index 7d1b76678032..317ca76ccafd 100644
> --- a/drivers/dma/apple-admac.c
> +++ b/drivers/dma/apple-admac.c
> @@ -12,8 +12,9 @@
>  #include <linux/module.h>
>  #include <linux/of_device.h>
>  #include <linux/of_dma.h>
> -#include <linux/interrupt.h>
> +#include <linux/reset.h>
>  #include <linux/spinlock.h>
> +#include <linux/interrupt.h>

Moving around the linux/interrupt.h include doesn't belong in this
patch. Otherwise this looks good to me, assuming the MCA driver does
the same reset/rearm dance.

regards
Philipp
