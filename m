Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6946F50895F
	for <lists+dmaengine@lfdr.de>; Wed, 20 Apr 2022 15:30:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379100AbiDTNcv (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 20 Apr 2022 09:32:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352554AbiDTNct (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 20 Apr 2022 09:32:49 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB3505599;
        Wed, 20 Apr 2022 06:30:02 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id u5-20020a17090a6a8500b001d0b95031ebso2017806pjj.3;
        Wed, 20 Apr 2022 06:30:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mgFfD34U6duNBCmHvZvCFQvmst2xAUzZbkoGYyf+ORc=;
        b=DtQ+tW28eb8PgOL2Hpm8ABjHDME2cm/YAl2A1MIZFJuPDg1qbu+6CHSWZTEIeyX0c+
         Vz5KaDabBo7tz5shkyJFIzSIs7SCk4ao+3Ph6jMpnjmkhqE7HIvl5NSWFPLzJBKKmATB
         0KJIerinMrV0xUU1+nooA8tW4zmqpUQuMLlmZK7qpVIsVUeiKdz+bDjgxZ13vrU4ycZk
         7oVeHqxUqN71ODUJ8HNtDlRzGNjOM2BkpDa508Rz9cRbY93hjJ6aKrQJcORWxgUbVFn/
         juvZw/wtcyaYIc5q+ye4UwFJ1FHqaCAdPhDBPkZOWR3qdmwh2YSvzhbvy2GzALWgdG0y
         Bwxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mgFfD34U6duNBCmHvZvCFQvmst2xAUzZbkoGYyf+ORc=;
        b=HSHhtscBimbgE3UXMt3GpwwyNAGgLmGEdYvMLyepno7hF+SaAQahwD9a92NgNmgc/p
         wd90klbYoc0tf3UkjhB8uRecAnr/UZlOgiCfgguR+jCsXrrpEGlcJhC8aV1Wf46Vp8CZ
         NiIzL7xTnKRhpUXE6pZUOp55T4voQlZCd683w9Po9/6OvsqhGCBcasMFmE5ieZU87pWH
         ZFCwi2UWYKcQk46kgAqDeJEUTPOHiZ5HxEH6VKbg10LMuhlgtXHVJ8XFVVY7OcWHZeHU
         3zcS7gtgCRO1QFVd3h8imIdWp76OEOHrAoHnN/YyYydq+giDqiDDD6mLD3sY0mkFiw3h
         HaRw==
X-Gm-Message-State: AOAM533XQohDpKh3ZwyYtyk3IJLrqz++VgXTJ2VOGRP7zbjjyndS4XOK
        NX+6+1PAdpD40w0WSGW3SF6pu/0tu5c=
X-Google-Smtp-Source: ABdhPJxRHplix3wdqGSuW2rzXQ5J/enrYXhmwQu+cbpWkr3h6BGvqp6E4kqBd5hIXHELvHjGdQ16/w==
X-Received: by 2002:a17:902:ec8f:b0:159:bce:bafd with SMTP id x15-20020a170902ec8f00b001590bcebafdmr11008479plg.21.1650461402435;
        Wed, 20 Apr 2022 06:30:02 -0700 (PDT)
Received: from 9a2d8922b8f1 ([122.161.51.18])
        by smtp.gmail.com with ESMTPSA id s190-20020a625ec7000000b005061c17c111sm20354857pfb.71.2022.04.20.06.29.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Apr 2022 06:30:02 -0700 (PDT)
Date:   Wed, 20 Apr 2022 18:59:55 +0530
From:   Kuldeep Singh <singh.kuldeep87k@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        dmaengine@vger.kernel.org
Subject: Re: [PATCH v2 6/6] dt-bindings: dma: Convert Qualcomm BAM DMA
 binding to json format
Message-ID: <20220420132955.GA63070@9a2d8922b8f1>
References: <20220410175056.79330-1-singh.kuldeep87k@gmail.com>
 <20220410175056.79330-7-singh.kuldeep87k@gmail.com>
 <CAH=2Ntx1D8C6xu+RysO0o5OkG5kPMMJ-Xr+B-udLtizY+4HiaQ@mail.gmail.com>
 <20220418192012.GA6868@9a2d8922b8f1>
 <1965ed9f-0258-cd28-f1c3-ef87272f6c03@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1965ed9f-0258-cd28-f1c3-ef87272f6c03@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

> I appreciate your work Kuldeep, it is important and valuable
> contribution. It is sad to see duplicated effort, I don't like it for my
> own patches either. In general, I believe the FIFO approach should be
> applied, so in this case Bhupesh patches.

Yep, I also agree with FIFO approach w.r.t contributions. But one thing
daunts me here is the waiting time with latest revision, it's too high.

Anyway, Bhupesh had more than BAM changes and was already on v5, I can
give benefit of doubt to him and won't argue much here.

Bhupesh, feel free to include my armv7 based dts patches in your series
otherwise you might stumble DT checks warnings.
