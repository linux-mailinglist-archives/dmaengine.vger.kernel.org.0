Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25C5554EC9C
	for <lists+dmaengine@lfdr.de>; Thu, 16 Jun 2022 23:32:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378725AbiFPVcF (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 16 Jun 2022 17:32:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378565AbiFPVcD (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 16 Jun 2022 17:32:03 -0400
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E82D2612B5;
        Thu, 16 Jun 2022 14:32:02 -0700 (PDT)
Received: by mail-io1-f54.google.com with SMTP id y79so2788349iof.2;
        Thu, 16 Jun 2022 14:32:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zi3qEd0xoKgYhRV3kEX7XrHmXR6KfbG1TrpITcXXADA=;
        b=Gj1VakrtGX9vw3fMVdzXNWl0Ey/A/K1Uv27KA06QF9wOVgE2LEet2xaRVNSyMj6k6h
         mhM2FTbFFU9Hup203NpLq3hjZXV1jsrDAmMNTyc3QeKs1LAw7jCX/JxeQ9YbgxtqpNdu
         n18BGS9++Q2RYz9reFZZRFGVX2QMryiSoq3M5iGa4nW4c9Z15qU9EZup+Vibb/84/ySe
         lCHXirGvkpQsSNIxQNxbR0rkdlD2J1M/pguSeyq/cbehsbcgX4Xaa6KyOaI+j8XBF3oP
         J9OXd47GpfKo/ET/4beoFVM1rnW1vqJC8p/CBGEsJ0WqXZBrJhpKZixPZHWSD0eV6oUG
         vxng==
X-Gm-Message-State: AJIora94RG5GY/bv/OFIX7+QNPimRQy62GUdxysNuG9iwfz4HGEX+dGj
        4Ff7juiKFbwRJyAc7DOqZfYxfv1xGA==
X-Google-Smtp-Source: AGRyM1s39VJ/A9B7GJronl3MTGXu6WTZ6JN0PSLlYmz7U1pu0vz2NhTmfRV6zD2MKa92MwziU/UCPw==
X-Received: by 2002:a05:6638:dc6:b0:332:3565:397a with SMTP id m6-20020a0566380dc600b003323565397amr3768500jaj.312.1655415122178;
        Thu, 16 Jun 2022 14:32:02 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id a5-20020a029105000000b00331a9a96764sm1366633jag.85.2022.06.16.14.32.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jun 2022 14:32:01 -0700 (PDT)
Received: (nullmailer pid 4029746 invoked by uid 1000);
        Thu, 16 Jun 2022 21:32:00 -0000
Date:   Thu, 16 Jun 2022 15:32:00 -0600
From:   Rob Herring <robh@kernel.org>
To:     Christian Marangi <ansuelsmth@gmail.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        Andy Gross <agross@kernel.org>, linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: dma: rework qcom,adm Documentation
 to yaml schema
Message-ID: <20220616213200.GB3991754-robh@kernel.org>
References: <20220615235404.3457-1-ansuelsmth@gmail.com>
 <1655388301.055791.3391580.nullmailer@robh.at.kernel.org>
 <62ab38f5.1c69fb81.303fc.3bc8@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <62ab38f5.1c69fb81.303fc.3bc8@mx.google.com>
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

On Thu, Jun 16, 2022 at 04:02:34PM +0200, Christian Marangi wrote:
> On Thu, Jun 16, 2022 at 08:05:01AM -0600, Rob Herring wrote:
> > On Thu, 16 Jun 2022 01:54:03 +0200, Christian Marangi wrote:
> > > Rework the qcom,adm Documentation to yaml schema.
> > > This is not a pure conversion since originally the driver has changed
> > > implementation for the #dma-cells and was wrong from the start.
> > > Also the driver now handles the common DMA clients implementation with
> > > the first cell that denotes the channel number and nothing else since
> > > the client will have to provide the crci information via other means.
> > > 
> > > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> > > ---
> > > v2:
> > > - Change Sob to Christian Marangi
> > > - Add Bjorn in the maintainers list
> > > 
> > >  .../devicetree/bindings/dma/qcom,adm.yaml     | 96 +++++++++++++++++++
> > >  .../devicetree/bindings/dma/qcom_adm.txt      | 61 ------------
> > >  2 files changed, 96 insertions(+), 61 deletions(-)
> > >  create mode 100644 Documentation/devicetree/bindings/dma/qcom,adm.yaml
> > >  delete mode 100644 Documentation/devicetree/bindings/dma/qcom_adm.txt
> > > 
> > 
> > Running 'make dtbs_check' with the schema in this patch gives the
> > following warnings. Consider if they are expected or the schema is
> > incorrect. These may not be new warnings.
> > 
> > Note that it is not yet a requirement to have 0 warnings for dtbs_check.
> > This will change in the future.
> > 
> > Full log is available here: https://patchwork.ozlabs.org/patch/
> > 
> > 
> > dma-controller@18300000: reset-names:1: 'c0' was expected
> > 	arch/arm/boot/dts/qcom-ipq8064-ap148.dtb
> > 	arch/arm/boot/dts/qcom-ipq8064-rb3011.dtb
> > 
> > dma-controller@18300000: reset-names:2: 'c1' was expected
> > 	arch/arm/boot/dts/qcom-ipq8064-ap148.dtb
> > 	arch/arm/boot/dts/qcom-ipq8064-rb3011.dtb
> > 
> > dma-controller@18300000: reset-names:3: 'c2' was expected
> > 	arch/arm/boot/dts/qcom-ipq8064-ap148.dtb
> > 	arch/arm/boot/dts/qcom-ipq8064-rb3011.dtb
> > 
> > dma-controller@18300000: reset-names: ['clk', 'pbus', 'c0', 'c1', 'c2'] is too long
> > 	arch/arm/boot/dts/qcom-ipq8064-ap148.dtb
> > 	arch/arm/boot/dts/qcom-ipq8064-rb3011.dtb
> > 
> > dma-controller@18300000: resets: [[11, 13], [11, 12], [11, 11], [11, 10], [11, 9]] is too long
> > 	arch/arm/boot/dts/qcom-ipq8064-ap148.dtb
> > 	arch/arm/boot/dts/qcom-ipq8064-rb3011.dtb
> >
> 
> I should have fixed this with the other patch. 

Ah, okay.

> Should the conversion fix
> this directly?

Given it was clearly wrong, that would be fine with a note in the commit 
message about the change. But no need to respin just for that.

Rob

