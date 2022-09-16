Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D13DA5BB27B
	for <lists+dmaengine@lfdr.de>; Fri, 16 Sep 2022 20:53:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229501AbiIPSx2 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 16 Sep 2022 14:53:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbiIPSx1 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 16 Sep 2022 14:53:27 -0400
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F249B8F0B;
        Fri, 16 Sep 2022 11:53:27 -0700 (PDT)
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-1274ec87ad5so53469096fac.0;
        Fri, 16 Sep 2022 11:53:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=B60NenXBTreMWS0WrcdwyfZ2Y6hoAUEkgmMhGFVHd+Q=;
        b=X+tAGx80qGTJpM+Q58J6OgRSEa+y6o/tpxEEERo8nkSlLVyTKw0sECsWBFgcBoY65G
         vbt7ynH/qz7zDynsXyen8+w7dGGrhKFmKjcqKO0MaoSnB/dEu3akipKwxjmmLLiVpE+O
         oct0jHP/QiL9fr05zr846yn6gwjeH0ThGyLSZ/ESx7xya2ynSmcSEUC7Otieu1PQeOEw
         J538gkDKom1Hamw4Z/WQPMnzIhoFhDBA4RcnY1Q+t86SKMa5pW2NK+QEyfkn7Jmd4C4f
         sN7lRzN2PAsqcB/8v7uzmWaXa9BPwR4ti7IMWdxBpQHBq5MlbDuIi/uen5VGWb+T1h9w
         oyew==
X-Gm-Message-State: ACrzQf3kDauK1nV6pg/Vnqd6IBLCnKphF9Ksbz6Tp9oifS0wG/4FsOME
        DGVcWLvEzIloPvzpDRVZVg==
X-Google-Smtp-Source: AMsMyM47dSuF84kEziYxdlHfDrjyVqaZalLHvej7kfRHbVl9g72LP5BOHuYtnGVR9KF/ehC9uUXIng==
X-Received: by 2002:a05:6870:2049:b0:127:927a:bf40 with SMTP id l9-20020a056870204900b00127927abf40mr3675203oad.248.1663354406322;
        Fri, 16 Sep 2022 11:53:26 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id j187-20020acab9c4000000b003502783c454sm3184177oif.0.2022.09.16.11.53.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Sep 2022 11:53:26 -0700 (PDT)
Received: (nullmailer pid 1069995 invoked by uid 1000);
        Fri, 16 Sep 2022 18:53:25 -0000
Date:   Fri, 16 Sep 2022 13:53:25 -0500
From:   Rob Herring <robh@kernel.org>
To:     Christian Marangi <ansuelsmth@gmail.com>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        Andy Gross <agross@kernel.org>, linux-arm-msm@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 1/2] dt-bindings: dma: rework qcom,adm Documentation
 to yaml schema
Message-ID: <20220916185325.GA1069954-robh@kernel.org>
References: <20220914140426.7609-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220914140426.7609-1-ansuelsmth@gmail.com>
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

On Wed, 14 Sep 2022 16:04:25 +0200, Christian Marangi wrote:
> Rework the qcom,adm Documentation to yaml schema.
> This is not a pure conversion since originally the driver has changed
> implementation for the #dma-cells and was wrong from the start.
> Also the driver now handles the common DMA clients implementation with
> the first cell that denotes the channel number and nothing else since
> the client will have to provide the crci information via other means.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
>  .../devicetree/bindings/dma/qcom,adm.yaml     | 96 +++++++++++++++++++
>  .../devicetree/bindings/dma/qcom_adm.txt      | 61 ------------
>  2 files changed, 96 insertions(+), 61 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/dma/qcom,adm.yaml
>  delete mode 100644 Documentation/devicetree/bindings/dma/qcom_adm.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
