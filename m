Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D69A5ED0CF
	for <lists+dmaengine@lfdr.de>; Wed, 28 Sep 2022 01:10:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229630AbiI0XKU (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 27 Sep 2022 19:10:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229898AbiI0XKS (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 27 Sep 2022 19:10:18 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FCE8B14D7
        for <dmaengine@vger.kernel.org>; Tue, 27 Sep 2022 16:10:18 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id h8-20020a17090a054800b00205ccbae31eso157799pjf.5
        for <dmaengine@vger.kernel.org>; Tue, 27 Sep 2022 16:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date;
        bh=D7+f9snyNUMXLnTo+OMRpGXFKIVvyQS7eYRBWJTqd7A=;
        b=f2aRpn1X1ovYqBL0+u4NJe2QnRv9yZvYZQTfFhEzVgYqnXJXWyNNtd0a6YYJKEWaas
         yE+rLrVI3YeHNCUEQNAQoTJjfjlzsy5aMZji9aeoxmhQbDT26h9BG1t6UfAHdRBpMz0N
         B4lGLzHKI/3l7R6Xdx9y1wek4KTYbt4teuTlSBSPsEAkyfJvuj5sajLMscg7LoNpGzbe
         AD7Fbk+lHfpW0Ov1jcc8xWwJOh/MfcbZT59XcH1OBMWW1MutN/sqb6AvtniBZYf7sEIn
         wuNtpGy4Z3zqTQP89kzdRT3boPUOoZXKw4+gqrrNcIa4A8PG09LbZyEBuQmUidr9JFAS
         +uVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=D7+f9snyNUMXLnTo+OMRpGXFKIVvyQS7eYRBWJTqd7A=;
        b=RLhHH5wmzw2j0JxCzE5dfmRKN/eW/yiNLc4eGJ1OUzU4mu+TNVC3L9BJ2DPWN84sDL
         SbwGoJhHY1PFJlTQtILeKwgblBjyRMng5AdJbkI1KQdJSISkHAcb4/VFzjeBhEp/wqXx
         TK7sL6PeeVI+38z3zJ01KBnDHrnXqREi2VWYwUbXFUxPPWVGfba2X6Qy8Kog1qJnvBn6
         y8WMRrtshoO5LMBUGceDrOp14lo567IKdExIaoGsldR5mq+xWDIN4pG6dJ/cBGub47wJ
         mGPFhMl7UY9Vkcd94VIcJJlxXQRO7/hB6AjlPQNhIWojhbrcIKQPiJIt3Uhu1qjAhpTa
         hxYA==
X-Gm-Message-State: ACrzQf0kjrHP0dxHswVS88bm8thpfwMjN+OZyY9HB6EQcpTMGW8K3tzZ
        VECMp01q6on/JJJPpaQB8s1ouA==
X-Google-Smtp-Source: AMsMyM639OC3E1Qa9V13GrY+HSkH3/MNj4QftxdfUD8jWzMDotVeXjlbWCfbxA+j7nXzgSlW3sTtUA==
X-Received: by 2002:a17:90b:4b46:b0:202:7a55:5588 with SMTP id mi6-20020a17090b4b4600b002027a555588mr6919261pjb.55.1664320217505;
        Tue, 27 Sep 2022 16:10:17 -0700 (PDT)
Received: from localhost ([76.146.1.42])
        by smtp.gmail.com with ESMTPSA id 13-20020a170902c20d00b00177e5d83d3esm2145951pll.88.2022.09.27.16.10.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 16:10:16 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     =?utf-8?Q?P=C3=A9ter?= Ujfalusi <peter.ujfalusi@gmail.com>,
        dmaengine@vger.kernel.org
Cc:     linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Nicolas Frayer <nfrayer@baylibre.com>
Subject: Re: [PATCH 0/3] dma/ti: enable udma and psil to be built as modules
In-Reply-To: <541337f7-1c0d-3ea4-d959-cd5aed83e615@gmail.com>
References: <20220926181848.2917639-1-khilman@baylibre.com>
 <cf3194ec-0952-fa7a-cc05-6a60e7e66cf0@gmail.com>
 <7h7d1pg7c4.fsf@baylibre.com>
 <541337f7-1c0d-3ea4-d959-cd5aed83e615@gmail.com>
Date:   Tue, 27 Sep 2022 16:10:16 -0700
Message-ID: <7hfsgcxvl3.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

P=C3=A9ter Ujfalusi <peter.ujfalusi@gmail.com> writes:

> On 27/09/2022 00:21, Kevin Hilman wrote:
>> Hi P=C3=A9ter,
>>=20
>> P=C3=A9ter Ujfalusi <peter.ujfalusi@gmail.com> writes:
>>=20
>>> On 9/26/22 21:18, Kevin Hilman wrote:
>>>> Enable the UDMA driver & glue and PSIL maps to be built & loaded as mo=
dules.
>>>>
>>>> The defauilt Kconfig settings are not changed, so default upstream is
>>>> still to be built in.  This series just enables the option to build as
>>>> modules.
>>>
>>> I can finally drop the half backed stuff I roll on top of -next ;)
>>>
>>> Do you plan to convert the ringacc also? It is straight forward, like:
>>> https://github.com/omap-audio/linux-audio/commit/01f9290c1c61e8bbc0fbdd=
877382672883ba7e73
>>=20
>> Yes, my colleague Nicolas (cc'd) was planning ringacc shortly, but we
>> didn't realize you had already don it.  Your version looks fine to me.
>> Any reason not to submit yours?
>
> It can only be sent after the UDMA is able to be built as a module.

OK, I sent a v2 of this series, which I think should be ready for merge
now.

> When I did the module support there were also a tisci dependency which=20
> for some reason took too long for me to be able to send these.
> I can send my version later if it is OK, but if Nicolas have a better=20
> take on it, I don't mind.

We've got a handful of other conversions coming for a fully modular
kernel, so I'm sure Nicolas would be happy if you took care of
ringacc. :)

Kevin


