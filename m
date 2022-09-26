Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53EB05EB145
	for <lists+dmaengine@lfdr.de>; Mon, 26 Sep 2022 21:26:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229515AbiIZT0l (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 26 Sep 2022 15:26:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229928AbiIZT0j (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 26 Sep 2022 15:26:39 -0400
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DFB46C121;
        Mon, 26 Sep 2022 12:26:38 -0700 (PDT)
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-127dca21a7dso10537645fac.12;
        Mon, 26 Sep 2022 12:26:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=rUlnvAfvU9pdRtWZ1FAEOghgD+29ogap9V6WaxteLbk=;
        b=0vs5aVuiRJ9+NSKrjMpHYvl7v7pVNOz0s6JAxoB/GqF1cxq4PoMPE6jrvIQv8jEis/
         qobGsOLSlxfBMxFLM8cXPc+yCHnTMmumvvrRF5rELsuvxXbaxoa/fST0KC3ynipLCF2K
         9TtHxhByBEXDc+rqtvQpDpMiOrOi759pYIh/SgbxLTn01zmmamHC83H0LdwcQIjKEwMg
         P3x0rRMv6dXmBUMgpYYyX5R16Kt2bNh7mEo690IFWzTrIlAZbQjgLagf77U6mZnKkVmQ
         aKyy3WkcUGaFeyjIzfGWUxKA8zKyTV/S7SErg16+LCNRQOeL4JGy5pSD9zSlxprLLWr9
         n5lg==
X-Gm-Message-State: ACrzQf1cvbs6LDP3vYRdmvhd2WSY3XMWq1QYHohk5dotQhXT4USDCbDa
        ++8JGdE6aBg04hXQNaZSFw==
X-Google-Smtp-Source: AMsMyM5kLkAXrkRnR+o1QnkojxPzqGoxGj/7A2kLwmibagYdnQEcpnrV0eQbVZdgQy1zKxSGb4xRIg==
X-Received: by 2002:a05:6870:d686:b0:12a:f869:cb90 with SMTP id z6-20020a056870d68600b0012af869cb90mr158805oap.242.1664220397290;
        Mon, 26 Sep 2022 12:26:37 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id g14-20020a9d6b0e000000b00659ba9f2872sm8077131otp.77.2022.09.26.12.26.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 12:26:36 -0700 (PDT)
Received: (nullmailer pid 2640966 invoked by uid 1000);
        Mon, 26 Sep 2022 19:26:36 -0000
Date:   Mon, 26 Sep 2022 14:26:36 -0500
From:   Rob Herring <robh@kernel.org>
To:     Deming Wang <wangdeming@inspur.com>
Cc:     krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, dmaengine@vger.kernel.org,
        peter.ujfalusi@gmail.com, vkoul@kernel.org, robh+dt@kernel.org
Subject: Re: [PATCH] Documentation: devicetree: dma: update the comments
Message-ID: <20220926192636.GA2640932-robh@kernel.org>
References: <20220920020721.2190-1-wangdeming@inspur.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220920020721.2190-1-wangdeming@inspur.com>
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

On Mon, 19 Sep 2022 22:07:21 -0400, Deming Wang wrote:
> remove the double word to.
> 
> Signed-off-by: Deming Wang <wangdeming@inspur.com>
> ---
>  Documentation/devicetree/bindings/dma/ti-dma-crossbar.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
