Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41B2B508C34
	for <lists+dmaengine@lfdr.de>; Wed, 20 Apr 2022 17:33:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380248AbiDTPgN (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 20 Apr 2022 11:36:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234264AbiDTPgN (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 20 Apr 2022 11:36:13 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E47D53BBD5;
        Wed, 20 Apr 2022 08:33:23 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id c23so2135797plo.0;
        Wed, 20 Apr 2022 08:33:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6juSp7uBXn7UkeeyHXBBY9ySqJnhll6cqmIkDC8no9Y=;
        b=qgcXcpJZM7EfRwyvLvIU/ZAWtrNANZUquKekYbz7sLAVux/6s/3qLncm1EKtkfB1WO
         hmfqpAk6sq4DFIRUmOIExfF08wFNHlGTHaB8KaZ5UZTDYY5mDfAxExdxMQVO2wsbiXKl
         NFRez+jYC6VMB47AjbTZnLWSlEOW1TEqO4fz5d9eZo6p4Ba7i1GGWOqS0QvI91lbJK/U
         LNwlCIRu2eqj2M1iTMaWzpyjHMEfu8jIvXu5NSLVB5JexHJGn7KsNAiEfsN6OQvsb2Uh
         6gmEIZhU5UdUJT3/ACsRrK8Yfgim0C0vm7ebc19owYVdsHlZyT3SwT63MQfJJ1eGRt3r
         isag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6juSp7uBXn7UkeeyHXBBY9ySqJnhll6cqmIkDC8no9Y=;
        b=A3O3zxg+LcUfCwCJZCC9NnIv6FEaFBY3f6wkU8ZK0SZ07RSOErWILXvFtkTctEUlaQ
         /t0155nZvWKPTbhOESg2HTnqjD3Yi2OkWQNjjwNVV7EZT8Ekq/N9cnRJD/V//GScgTmv
         /8vsCPorQnzbzYWHnKV8Vx6K1LsDgyNmdlrqXeJjxxxV2GLmo/Dt+Z6RWLFsJurJ46fJ
         kLZSLinnBtQB2yS2OhhY3d6ZaSQV6X0eh3OF6KvL9HUIoubfP12+sqLYVWP+O6li1ubm
         iWlbAg8fHbFArh3JIjIO4gW+qxygQQYW89ffM4r9RvW5463b4drW6usosydYiYq6oQ0K
         FbWQ==
X-Gm-Message-State: AOAM5300woOGMMi6QTmiwcAoMOiL/HIJN2VkCVO/kuyIcYGgXrKtAPA5
        8ISuJqUYqAAbfjujTpddRwmF0tenfUg=
X-Google-Smtp-Source: ABdhPJz22tndu6if9K9efIAj/OMeUaGdf1i3J+kAmBbzzu/YPOcSwfl8sH14/vdSLHcr05W1onRsJw==
X-Received: by 2002:a17:90a:ce05:b0:1d0:805b:ac3a with SMTP id f5-20020a17090ace0500b001d0805bac3amr5213508pju.49.1650468803420;
        Wed, 20 Apr 2022 08:33:23 -0700 (PDT)
Received: from 9a2d8922b8f1 ([122.161.51.18])
        by smtp.gmail.com with ESMTPSA id z70-20020a633349000000b003aa663f95ffsm2918724pgz.25.2022.04.20.08.33.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Apr 2022 08:33:23 -0700 (PDT)
Date:   Wed, 20 Apr 2022 21:03:16 +0530
From:   Kuldeep Singh <singh.kuldeep87k@gmail.com>
To:     Bhupesh Sharma <bhupesh.sharma@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        dmaengine@vger.kernel.org
Subject: Re: [PATCH v2 6/6] dt-bindings: dma: Convert Qualcomm BAM DMA
 binding to json format
Message-ID: <20220420153316.GA63129@9a2d8922b8f1>
References: <20220410175056.79330-1-singh.kuldeep87k@gmail.com>
 <20220410175056.79330-7-singh.kuldeep87k@gmail.com>
 <CAH=2Ntx1D8C6xu+RysO0o5OkG5kPMMJ-Xr+B-udLtizY+4HiaQ@mail.gmail.com>
 <20220418192012.GA6868@9a2d8922b8f1>
 <1965ed9f-0258-cd28-f1c3-ef87272f6c03@linaro.org>
 <20220420132955.GA63070@9a2d8922b8f1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220420132955.GA63070@9a2d8922b8f1>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Wed, Apr 20, 2022 at 06:59:55PM +0530, Kuldeep Singh wrote:
> > I appreciate your work Kuldeep, it is important and valuable
> > contribution. It is sad to see duplicated effort, I don't like it for my
> > own patches either. In general, I believe the FIFO approach should be
> > applied, so in this case Bhupesh patches.
> 
> Yep, I also agree with FIFO approach w.r.t contributions. But one thing
> daunts me here is the waiting time with latest revision, it's too high.
> 
> Anyway, Bhupesh had more than BAM changes and was already on v5, I can
> give benefit of doubt to him and won't argue much here.
> 
> Bhupesh, feel free to include my armv7 based dts patches in your series
> otherwise you might stumble DT checks warnings.

Or do you want me to keep my changes separate? Sorry for spam.
