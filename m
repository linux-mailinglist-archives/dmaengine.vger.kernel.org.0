Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB61957E593
	for <lists+dmaengine@lfdr.de>; Fri, 22 Jul 2022 19:32:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230443AbiGVRcA (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 22 Jul 2022 13:32:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbiGVRb7 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 22 Jul 2022 13:31:59 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADC5687F58;
        Fri, 22 Jul 2022 10:31:58 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id n10-20020a17090a670a00b001f22ebae50aso4783016pjj.3;
        Fri, 22 Jul 2022 10:31:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ThQlVicPs1rWFVsyGw86UI+Xw2uWwAxd1Fpjx4xaCns=;
        b=UEsBag87mGWy5BVFAdUXkdk1qCdUs2lOxfmigRvBLhdNgdqYBneUn0atXOS+eQR4IM
         6sHV41s76ygcnA0g4U0PIhhTQSp/icVkckXBJOtOKU/KBb8UYmIZ6kgXiiBTh9ASEuQE
         FRnxfAxWVvVk/3dARMgqQYPFzAduNrwCT67rR4WAok6Ld2NqmRtzKx62vuf7VMtDU1xU
         BKjflmwuAZLUav13K7J/sgHTXP4Pyan/eLgIR8/JeCTouevC77O//rOVekJrjWcgZt12
         nWWte9PC3FoPJCgsJ7qoIU6cKZU6BU7BZZGsNnlUbLj96QB6rwu9iovQvp65x2ESCE2o
         Xmaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ThQlVicPs1rWFVsyGw86UI+Xw2uWwAxd1Fpjx4xaCns=;
        b=LP0ag3SxVcb8GV+eNq2CjGEAEnbJ7aVjfwJYFKTEMzQ393wgo+iNLRReLOtcKvg6gP
         4Fah2oFFdAkAliIPIsjM4gpwlJsehv9A9IR/1+JzAHtJewOYby5eo5QpECthTXAtAQVK
         H2pqqEWra53L02zyUC44U+RwHTaxIlE2zp9iEkVkWmHee3EeCyQfzzVIrJZp87Pulhtc
         XZ/vKV1vwoNw+q43tFRZLjtrUka2DLaCr3inK8I0qLFS9dEyg7Im20u2a08Q/vNrRnTT
         EhDXNNhncBRrhaJ8BzxtUpFiXbbvHJguephVp6ukh33atOsAW9pa1okp1MBZvjwiVviN
         RyRg==
X-Gm-Message-State: AJIora+Uhf28RWO+VmgFkj4D1Is/hNckJub9hOQnY6kn16RtpIH4qmvA
        TGpnX7pNCDAACSjCWyFHjVc=
X-Google-Smtp-Source: AGRyM1vKQxvXfAZ5zbgWjOJAsSYiM30LcNcKWPMY9QnHFGqydzpTE5Lb5lNKPDScqfQFMMIF3bwNvg==
X-Received: by 2002:a17:90b:188a:b0:1f2:3570:5f9f with SMTP id mn10-20020a17090b188a00b001f235705f9fmr720721pjb.75.1658511118005;
        Fri, 22 Jul 2022 10:31:58 -0700 (PDT)
Received: from 9a2d8922b8f1 ([115.98.179.206])
        by smtp.gmail.com with ESMTPSA id x21-20020aa79ad5000000b00528a097aeffsm4174567pfp.118.2022.07.22.10.31.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jul 2022 10:31:57 -0700 (PDT)
Date:   Fri, 22 Jul 2022 23:01:52 +0530
From:   Kuldeep Singh <singh.kuldeep87k@gmail.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Vinod Koul <vkoul@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: Re: [PATCH v3 6/6] dt-bindings: dma: Convert Qualcomm BAM DMA
 binding to json format
Message-ID: <20220722173152.GA54768@9a2d8922b8f1>
References: <20220417210436.6203-1-singh.kuldeep87k@gmail.com>
 <20220417210436.6203-7-singh.kuldeep87k@gmail.com>
 <20220721195215.GA1817266-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220721195215.GA1817266-robh@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

> This is the 11th most warned on (168 warnings) for missing a schema, so 
> I've implemented my only comment and applied. It seems neither this one 
> or the other attempt at converting are getting respun.

I didn't respin because Bhupesh mentioned he will send his v5 and then I
couldn't followup.

I realized I should have anyway respin my patch.
Thanks for incorporating the changes.

Regards
Kuldeep
