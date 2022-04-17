Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15E0A5046C5
	for <lists+dmaengine@lfdr.de>; Sun, 17 Apr 2022 07:50:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233444AbiDQFxP (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 17 Apr 2022 01:53:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233425AbiDQFxO (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 17 Apr 2022 01:53:14 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBE843C4AE;
        Sat, 16 Apr 2022 22:50:39 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id k29so13503421pgm.12;
        Sat, 16 Apr 2022 22:50:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ANBS//8WVUkFdZYNute605O0D9+yj3/Rsd4Oj818tJU=;
        b=Ysyrw934fpEnn74orPBZkTjJ2in0m6jwsT8YQ+IM4DB1g0I6UKcUSqgGfjwtMyOo8C
         3wjwgVQbOE7Y9BDY4CkpMRpY1EyUPwjqP70OsP3hXxjuyAfYlNp+lM78wI1tla35giui
         z+QkloIkraBycKldvAszRE4YgU/kfWs0vHVaVevLI/PAETnujTg+p/vHLsi3ienzziNS
         nMZH8BUTpEcEl3S7W37jT4HfUVuvo4TsdeU7ZpaAieP4kxtV80rRJ9+Ld+J6DE8Hf6p8
         O+PT4QXBGyHb+LdQusbODkP8Ycn6bg/ACKO5/g59aiivMttwsZDafrq4vIw+Ml1zN4U3
         8XXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ANBS//8WVUkFdZYNute605O0D9+yj3/Rsd4Oj818tJU=;
        b=AYbveZpdC+oiIOCoMvPJQ/czf3k0WmFPd1+mpfERpuDBjM0yIor+zllF3AvMvBaCKK
         zYAANwArz0n9jdVnd7oGowLTR72PWffPZnYq2L292jjN2SPv3fN852Dlc+GuJ9vG0R3E
         KmRG3Exq+JHeQusPyd4mYjPSwv+x2wnFA8rllUrJioLZc/7yOgccGyDhRWXcVVl32H1A
         oeuk6TlkIdiq3FIG7WLaiw+Dx6EddYWh5CfQVDui3NtebIV41Z/jU/FJ6xZYBtYHZga2
         ugQL+BaaRIqvnX1j/eFcZMbaXkjcV1HohbPrD7zii9i4LgeGPqA+WOk0aBt/90TnvaWG
         VMpQ==
X-Gm-Message-State: AOAM532tvAcPGsLvqtvEkqZhpoiizuv5ftoH2uUN+iGdrK95EFY1/yK0
        dFmCT+epUcf98d52wS07AR4=
X-Google-Smtp-Source: ABdhPJy/HQgzkjVGMVXmDl9i86lUl7iEjxJtfywNUTFL96YCm2o7Xftcs4DPRzmkBb3WW5K78zeL7Q==
X-Received: by 2002:a05:6a00:1701:b0:505:c49b:d2ed with SMTP id h1-20020a056a00170100b00505c49bd2edmr6330373pfc.56.1650174639180;
        Sat, 16 Apr 2022 22:50:39 -0700 (PDT)
Received: from 9a2d8922b8f1 ([122.161.51.18])
        by smtp.gmail.com with ESMTPSA id g14-20020a63200e000000b0039d9816238fsm8877784pgg.81.2022.04.16.22.50.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Apr 2022 22:50:38 -0700 (PDT)
Date:   Sun, 17 Apr 2022 11:20:32 +0530
From:   Kuldeep Singh <singh.kuldeep87k@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        dmaengine@vger.kernel.org
Subject: Re: [PATCH v2 6/6] dt-bindings: dma: Convert Qualcomm BAM DMA
 binding to json format
Message-ID: <20220417055032.GA41948@9a2d8922b8f1>
References: <20220410175056.79330-1-singh.kuldeep87k@gmail.com>
 <20220410175056.79330-7-singh.kuldeep87k@gmail.com>
 <14ecb746-56f0-2d3b-2f93-1af9407de4b7@linaro.org>
 <20220411105810.GB33220@9a2d8922b8f1>
 <50defa36-3d91-80ea-e303-abaade1c1f7e@linaro.org>
 <20220412061953.GA95928@9a2d8922b8f1>
 <8ff07720-3c52-99e6-8046-501f4ae28518@linaro.org>
 <20220412180159.GA29479@9a2d8922b8f1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220412180159.GA29479@9a2d8922b8f1>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

> > You can though try to look at original (vendor) sources:
> > https://git.codelinaro.org/clo/la/kernel/msm-4.19 (sdm845)
> > https://git.codelinaro.org/clo/la/kernel/msm-3.18 (msm8996)

I gave a look at this and couldn't find much info related to these
platforms. And waited for sometime to get reply from Srinivas and other
co.

I don't think it's viable to wait just for this particular thing and
also doesn't make much sense either. I will send next version as per
your current comments. Thanks!
