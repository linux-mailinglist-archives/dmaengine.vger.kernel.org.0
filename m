Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A008580747
	for <lists+dmaengine@lfdr.de>; Tue, 26 Jul 2022 00:23:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237218AbiGYWXE (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 25 Jul 2022 18:23:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236925AbiGYWXD (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 25 Jul 2022 18:23:03 -0400
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34E44255AD;
        Mon, 25 Jul 2022 15:23:02 -0700 (PDT)
Received: by mail-ot1-f51.google.com with SMTP id c20-20020a9d4814000000b0061cecd22af4so5200008otf.12;
        Mon, 25 Jul 2022 15:23:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OHlKzImoqJ8ryDBHo0H/tsoDf9If2oX+2899I72Q0FQ=;
        b=KBFb+sudIXe7fao7vVG1C4q4qe4kOXaBKsAPyAj7mz6txMw6v+4BDDBwKVpr0mqNzH
         /6Q2GQX4j6G55bU06lQqr0qL7MQEYk1qTlfXFCHMo5dYJeVRLbDf7W+0AvV0lkqlPEct
         CqPy5mCv5Hn260hyLOlqMX/b6H+Yp/tTMNA6FuehiJlt8iHIHPOogEtoEfpJk/FBTfY9
         HBzLRDCTg0bjsMyVrB+UifCiA9lm5IPblhRrDd8MMoLiLNllgJYBqVlSuo2rTsROlEqN
         dmLtQcT7tRayGSPoPOQEbiPJ4M8+rYKfjjFh69MJ946sC/JPHrEag7bKb1SeZGIBB/L1
         gdSA==
X-Gm-Message-State: AJIora+gPqjuQp+hEPqitUFV3cb6bDGboMq38PsMZ3Npdn+0gyRANjwV
        nkuYKzZtto6YzPkIYpimZlIp1k7rqg==
X-Google-Smtp-Source: AGRyM1uCpCHuxy88D3vJcMdAZ8HrUBG0z3bFj4cTqY2fT0xZmOqbQUQbPpjQco2kG3oyo/XoniWmvw==
X-Received: by 2002:a05:6830:129a:b0:61c:80f9:eefc with SMTP id z26-20020a056830129a00b0061c80f9eefcmr5533404otp.72.1658787781442;
        Mon, 25 Jul 2022 15:23:01 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id c10-20020a056830314a00b0061c564a83ebsm5524261ots.19.2022.07.25.15.22.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 15:23:01 -0700 (PDT)
Received: (nullmailer pid 2850010 invoked by uid 1000);
        Mon, 25 Jul 2022 22:22:59 -0000
Date:   Mon, 25 Jul 2022 16:22:59 -0600
From:   Rob Herring <robh@kernel.org>
To:     Akhil R <akhilrajeev@nvidia.com>
Cc:     vkoul@kernel.org, thierry.reding@gmail.com,
        dmaengine@vger.kernel.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        jonathanh@nvidia.com, ldewangan@nvidia.com,
        linux-tegra@vger.kernel.org, p.zabel@pengutronix.de
Subject: Re: [PATCH v4 1/3] dt-bindings: dmaengine: Add compatible for
 Tegra234
Message-ID: <20220725222259.GA2849977-robh@kernel.org>
References: <20220720104045.16099-1-akhilrajeev@nvidia.com>
 <20220720104045.16099-2-akhilrajeev@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220720104045.16099-2-akhilrajeev@nvidia.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Wed, 20 Jul 2022 16:10:43 +0530, Akhil R wrote:
> Document the compatible string used by GPCDMA controller for Tegra234.
> 
> Signed-off-by: Akhil R <akhilrajeev@nvidia.com>
> Reviewed-by: Jon Hunter <jonathanh@nvidia.com>
> ---
>  .../devicetree/bindings/dma/nvidia,tegra186-gpc-dma.yaml      | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
