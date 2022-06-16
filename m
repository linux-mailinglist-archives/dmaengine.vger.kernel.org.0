Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9F5954ECA0
	for <lists+dmaengine@lfdr.de>; Thu, 16 Jun 2022 23:32:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378585AbiFPVce (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 16 Jun 2022 17:32:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378479AbiFPVcc (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 16 Jun 2022 17:32:32 -0400
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3515D9E;
        Thu, 16 Jun 2022 14:32:31 -0700 (PDT)
Received: by mail-il1-f181.google.com with SMTP id l14so1799381ilq.1;
        Thu, 16 Jun 2022 14:32:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gMAQL6qotF59le2t14VjEkFpZxPqvz7b4HSHZSqyCJM=;
        b=OAQdBJuPIWBUL14uP7whDsPjUt9BEaYvcJBL6kG9A9Lo9pcSh9jfqbEdBxv42LAwwI
         IU5Q9j+YaNNsY10A86y1EZM1E1vos6XOBmGuEar8KKACtB/hoPxo6clGvNNfQmpHOn3G
         KtLApQ2wGQDztcIOz4KFeyhuHVabho3+2jZVPdUDclYk3xUNsqgS5Kt10MMktqjv8HIs
         BGSxc39rdIQXo4fFh8SfMtV6ZWO8xUtKLVXsLo4xt04b3q10dRar9W39SqInrLYaAYLf
         kYQZKRs195WsWVQeP5dhTKBmPdENWLpGMQZSEkLXoXO4xmGZyO49x6r7n1ruwq2GsPT7
         0n8Q==
X-Gm-Message-State: AJIora8nqqD9yzLWm/5c7dXn790F9Tz+WbYeN1je5JKcPyJ6UXyo+odt
        TpcYeBKMRP1ctURuDsYuYpLCdmPf7Q==
X-Google-Smtp-Source: AGRyM1tI9/tB1iqEZiGJpxnxsXYP44YKz/Z+ZLaGfswTi//U98NNIwiXkZazWNb9O43RV2u0ggz+CQ==
X-Received: by 2002:a05:6e02:13c4:b0:2d6:5dad:8fc6 with SMTP id v4-20020a056e0213c400b002d65dad8fc6mr3735146ilj.201.1655415150898;
        Thu, 16 Jun 2022 14:32:30 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id g2-20020a92dd82000000b002cde6e352ffsm1471670iln.73.2022.06.16.14.32.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jun 2022 14:32:30 -0700 (PDT)
Received: (nullmailer pid 4030372 invoked by uid 1000);
        Thu, 16 Jun 2022 21:32:28 -0000
Date:   Thu, 16 Jun 2022 15:32:28 -0600
From:   Rob Herring <robh@kernel.org>
To:     Christian Marangi <ansuelsmth@gmail.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: dma: rework qcom,adm Documentation
 to yaml schema
Message-ID: <20220616213228.GC3991754-robh@kernel.org>
References: <20220615235404.3457-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220615235404.3457-1-ansuelsmth@gmail.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Thu, Jun 16, 2022 at 01:54:03AM +0200, Christian Marangi wrote:
> Rework the qcom,adm Documentation to yaml schema.
> This is not a pure conversion since originally the driver has changed
> implementation for the #dma-cells and was wrong from the start.
> Also the driver now handles the common DMA clients implementation with
> the first cell that denotes the channel number and nothing else since
> the client will have to provide the crci information via other means.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
> v2:
> - Change Sob to Christian Marangi
> - Add Bjorn in the maintainers list
> 
>  .../devicetree/bindings/dma/qcom,adm.yaml     | 96 +++++++++++++++++++
>  .../devicetree/bindings/dma/qcom_adm.txt      | 61 ------------
>  2 files changed, 96 insertions(+), 61 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/dma/qcom,adm.yaml
>  delete mode 100644 Documentation/devicetree/bindings/dma/qcom_adm.txt

Reviewed-by: Rob Herring <robh@kernel.org>
