Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E989505E61
	for <lists+dmaengine@lfdr.de>; Mon, 18 Apr 2022 21:20:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347631AbiDRTXE (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 18 Apr 2022 15:23:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347632AbiDRTXB (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 18 Apr 2022 15:23:01 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A48EF12ABB;
        Mon, 18 Apr 2022 12:20:19 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id b7so3468303plh.2;
        Mon, 18 Apr 2022 12:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3mQuw30mLCYVflNR7mz5HtSbYatNMKdlsMF3p1A4tQ8=;
        b=izjCSgU2XxrzRNobeciMugbg0Y7nDuWLfdOm/xNY8Rhq7T1NdAGN5yx833SeGct0B3
         lGlhvwTPwwSvtigwU4TXbRmFYqrCkXF6DWJSrqR2JWYTi7ruBtOLIU9I3C4XV9hmkWrT
         5XUmc3ldp2EqIc6XWPW0c5868P7OOGaQz5mQGwastQdvvmaFbltJgI2l1Nk9oAs5KnJm
         dza44hPQcb1zFsxS9yoooUgwIlHYnOGnRupNdlH8poHRT/Vwk+vynjfg7uZp+h+JHN0O
         T2GQsCHPUaJthRELGnIswoJfySYUepwL5op5Rs96/X2I2CjWbieeA0FQwQSXiwlCSpoM
         q4mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3mQuw30mLCYVflNR7mz5HtSbYatNMKdlsMF3p1A4tQ8=;
        b=LBHMhh9Hp7BRELxFeEoDNUIUtV/vvMWoBd7Xq97vpp9NlI4YszVS52/ml6uNA/VKLe
         ZulnG7xK9JoJ7W8X/FYFFO6o7MX/1Wx/boI3Ir0tBMPXA2ClZDV6foHTVxRXkIan8Gm7
         qKQaWUUEKVHoB4yExEK0oaUtjaADXbXzd8/Zi09D7QKhMK7AH/jD1Xd7IHZIbE4q+BJD
         gdJ5rEr2aWUo2X8ZqdxPI3x/aa2rMIlc6rMAzue8BTioM50b9GOJvn0eWPJ9UDPd9Sst
         vQvNIETtnqYg5hFJbYYoiMt5zTeK/w8HCM4fquYTGEeCxhZ8Oms9QnikMJ0E0t7Um2zd
         KYIw==
X-Gm-Message-State: AOAM533Y/Zvg7TDxZ5g+4b4i5P9EMZmlwmNYNEzpS1qj2BfzQeBPKA4t
        mO86bOxujK0fcP2e9FJ9QDQ=
X-Google-Smtp-Source: ABdhPJxethIiuSI1qCrZQ6TA9ztjetBmGxopKxj472K4YJTzyU/XWwazgVSouKWllNkGtUaXHs/rhw==
X-Received: by 2002:a17:90b:1bc8:b0:1c7:443:3ffb with SMTP id oa8-20020a17090b1bc800b001c704433ffbmr14506409pjb.84.1650309619074;
        Mon, 18 Apr 2022 12:20:19 -0700 (PDT)
Received: from 9a2d8922b8f1 ([122.161.51.18])
        by smtp.gmail.com with ESMTPSA id bt21-20020a056a00439500b0050a4dfb7c44sm9724180pfb.155.2022.04.18.12.20.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Apr 2022 12:20:18 -0700 (PDT)
Date:   Tue, 19 Apr 2022 00:50:12 +0530
From:   Kuldeep Singh <singh.kuldeep87k@gmail.com>
To:     Bhupesh Sharma <bhupesh.sharma@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        dmaengine@vger.kernel.org
Subject: Re: [PATCH v2 6/6] dt-bindings: dma: Convert Qualcomm BAM DMA
 binding to json format
Message-ID: <20220418192012.GA6868@9a2d8922b8f1>
References: <20220410175056.79330-1-singh.kuldeep87k@gmail.com>
 <20220410175056.79330-7-singh.kuldeep87k@gmail.com>
 <CAH=2Ntx1D8C6xu+RysO0o5OkG5kPMMJ-Xr+B-udLtizY+4HiaQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAH=2Ntx1D8C6xu+RysO0o5OkG5kPMMJ-Xr+B-udLtizY+4HiaQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Mon, Apr 18, 2022 at 10:57:55AM +0530, Bhupesh Sharma wrote:
> Please see <https://lore.kernel.org/lkml/20220211214941.f55q5yksittut3ep@amazon.com/T/#m6700c2695ee78e79060ac338d208ffd08ac39592>,
> I already have an effort ongoing for converting qcom bam DMA bindings
> to YAML format.

Ohh ok, I wasn't aware you had similar series.
I just noticed your latest v5 version was rolled out ~5 months back,
usually this is a very long time considering the duration. Wondering
reason behind this..

My updated series(v3 version[1]) is kind of complete and mostly reviewed
by Krzysztof and takes care of armv7/8 based platforms. With no offence,
I believe we should go with the current one as your series includes
changes more than BAM and will take long time to merge. Anyway, I'll be
fine with choice of the maintainers.

Regards
Kuldeep
[1] https://lore.kernel.org/linux-devicetree/20220417210436.6203-1-singh.kuldeep87k@gmail.com/T/#m2e1df4a579d0f40e07638e117df342b886289bb0
