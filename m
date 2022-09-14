Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2B855B8DA1
	for <lists+dmaengine@lfdr.de>; Wed, 14 Sep 2022 18:57:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229743AbiINQ5h (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 14 Sep 2022 12:57:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiINQ5g (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 14 Sep 2022 12:57:36 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FD6B237D1;
        Wed, 14 Sep 2022 09:57:35 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id r18so36165010eja.11;
        Wed, 14 Sep 2022 09:57:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date;
        bh=Dm2hwF6WCe7czySRX8uWW+CCWzNHmf/+RMx8+8WjsmY=;
        b=fYTCj0gVdjz0ZVF+nuyDBf3LMczRilxAn5L9w9g5Xa1qRrtB997hi29wSSYhCCN0kZ
         BPrlpQK5H2/3aewy0KP7bGrtCsk9C3kU2KI80iOOHgKv9YZ7+iAvsyMJ1MbdExJss9WX
         5naAG0dfgHYTnPQZvTn9BBiKKTXKYPXJF07eEwy0yGOj4ZPs5qviF0s2lXll43qpL0oU
         V7hsGzvb8NWof2IUCOgpHhoeC5mAc5k3kYQWGr6sS6ErhRgKErQNzP0EEOlbkxbqZRMd
         KOr0wDXT8A1kx/F7kbMTXRzvY/K9+kAJbrTkPTWPkAr4Z0hAoJedYgF4NgwHGuEUuMS9
         mdVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=Dm2hwF6WCe7czySRX8uWW+CCWzNHmf/+RMx8+8WjsmY=;
        b=hjyVpH8qTxp6DKZnbJx8JMJq2vlCcaFyYQoVSh0ADsojWGpU+mg06eF/frXcAGjJOD
         N21wHKROtbhL1WWp6xL9w6J/GFFpkxTL9DGczDSknorDoQO/NfhseWxt1LKQmoJDsSY7
         FUowr/R2M+JrHZuoV4P0GllohOPgg2W5TDcGlDDLsVq0usNSCk3GZ+KkTqUPFMXsxBTN
         U8t/cFAWErfLqHgyLfbD/6HnwZs8BZbWZZeJ+6qMQ7+mR/j8Fh4bk5FYd+kpXokM+TMq
         0CKV/gEzS6ChM8rnUiBQ/jmgKqprUhyIq1O0jYR09SP3YOK5EnQKxPqwBQpRlkRcmXWk
         v6CA==
X-Gm-Message-State: ACgBeo1CSOblTLSQla9UFCyI9o2m0s2kO31DB1gPuLZkTem/yPbXx13M
        bER0SIHvDLvyoVXt1AMSBos=
X-Google-Smtp-Source: AA6agR6OwSTX9fAupj4WotNw0xeC0OpM5SL6CwjZ+b1Akb89ptdU5t7mq25zb77YKR6DV+QQ2tEuuQ==
X-Received: by 2002:a17:907:845:b0:731:2f6c:6dbd with SMTP id ww5-20020a170907084500b007312f6c6dbdmr26248298ejb.551.1663174653979;
        Wed, 14 Sep 2022 09:57:33 -0700 (PDT)
Received: from Ansuel-xps. (93-42-70-134.ip85.fastwebnet.it. [93.42.70.134])
        by smtp.gmail.com with ESMTPSA id q9-20020a17090676c900b00741a0c3f4cdsm7830173ejn.189.2022.09.14.09.57.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Sep 2022 09:57:33 -0700 (PDT)
Message-ID: <632207fd.170a0220.8b7b4.3e14@mx.google.com>
X-Google-Original-Message-ID: <YyIH+39HUdAuO3+Y@Ansuel-xps.>
Date:   Wed, 14 Sep 2022 18:57:31 +0200
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Rob Herring <robh@kernel.org>
Cc:     dmaengine@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        linux-arm-msm@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        devicetree@vger.kernel.org, Bjorn Andersson <andersson@kernel.org>
Subject: Re: [PATCH v3 1/2] dt-bindings: dma: rework qcom,adm Documentation
 to yaml schema
References: <20220914140426.7609-1-ansuelsmth@gmail.com>
 <1663174030.707683.2567031.nullmailer@robh.at.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1663174030.707683.2567031.nullmailer@robh.at.kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Wed, Sep 14, 2022 at 11:47:10AM -0500, Rob Herring wrote:
> On Wed, 14 Sep 2022 16:04:25 +0200, Christian Marangi wrote:
> > Rework the qcom,adm Documentation to yaml schema.
> > This is not a pure conversion since originally the driver has changed
> > implementation for the #dma-cells and was wrong from the start.
> > Also the driver now handles the common DMA clients implementation with
> > the first cell that denotes the channel number and nothing else since
> > the client will have to provide the crci information via other means.
> > 
> > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> > ---
> >  .../devicetree/bindings/dma/qcom,adm.yaml     | 96 +++++++++++++++++++
> >  .../devicetree/bindings/dma/qcom_adm.txt      | 61 ------------
> >  2 files changed, 96 insertions(+), 61 deletions(-)
> >  create mode 100644 Documentation/devicetree/bindings/dma/qcom,adm.yaml
> >  delete mode 100644 Documentation/devicetree/bindings/dma/qcom_adm.txt
> > 
> 
> Running 'make dtbs_check' with the schema in this patch gives the
> following warnings. Consider if they are expected or the schema is
> incorrect. These may not be new warnings.
> 
> Note that it is not yet a requirement to have 0 warnings for dtbs_check.
> This will change in the future.
> 
> Full log is available here: https://patchwork.ozlabs.org/patch/
> 
> 
> dma-controller@18300000: reset-names:1: 'c0' was expected
> 	arch/arm/boot/dts/qcom-ipq8064-ap148.dtb
> 	arch/arm/boot/dts/qcom-ipq8064-rb3011.dtb
> 
> dma-controller@18300000: reset-names:2: 'c1' was expected
> 	arch/arm/boot/dts/qcom-ipq8064-ap148.dtb
> 	arch/arm/boot/dts/qcom-ipq8064-rb3011.dtb
> 
> dma-controller@18300000: reset-names:3: 'c2' was expected
> 	arch/arm/boot/dts/qcom-ipq8064-ap148.dtb
> 	arch/arm/boot/dts/qcom-ipq8064-rb3011.dtb
> 
> dma-controller@18300000: reset-names: ['clk', 'pbus', 'c0', 'c1', 'c2'] is too long
> 	arch/arm/boot/dts/qcom-ipq8064-ap148.dtb
> 	arch/arm/boot/dts/qcom-ipq8064-rb3011.dtb
> 
> dma-controller@18300000: resets: [[12, 13], [12, 12], [12, 11], [12, 10], [12, 9]] is too long
> 	arch/arm/boot/dts/qcom-ipq8064-ap148.dtb
> 	arch/arm/boot/dts/qcom-ipq8064-rb3011.dtb
> 

Hi,
I fixed these warning on the second commit of this series.

-- 
	Ansuel
