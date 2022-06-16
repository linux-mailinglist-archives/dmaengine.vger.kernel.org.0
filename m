Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C70F254E2EC
	for <lists+dmaengine@lfdr.de>; Thu, 16 Jun 2022 16:06:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377539AbiFPOGv (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 16 Jun 2022 10:06:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377544AbiFPOGt (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 16 Jun 2022 10:06:49 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 582BE49FB0;
        Thu, 16 Jun 2022 07:06:47 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id n10so3012836ejk.5;
        Thu, 16 Jun 2022 07:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:from:to:cc:subject:references:mime-version
         :content-disposition:in-reply-to;
        bh=ld37J2VuQn8PPhwE47ARtw0waR2/HuJQhsucGvvTMtA=;
        b=P1l0MNTTA01XHISNTKWCqpoCKZVy3VRBbiKjUMYFH65SWbEA+sXDzta7ZjrxNsfX0R
         6cwnvTOUSSEGSzKhUbmMo33u77oF/MEB5Yhbxcxq2vz0l6vioq7RllXKZ9A/VUWuqYvc
         sQHWHHwhD/Esbwhc66UtDCyse6FDfUbI2FS1Ak8TMdfnKw6UqyOrhRRei0ssYzVfg+Gt
         U59OmFAZM20lzyARr1bkG2JZzmlY7Pdnswnk802RLmCB5f0Ak3Am64oUGdlzVGLCiyxp
         0uPCmM9X/+tWEaPVgFsrBbx0ZaqF0DWNpD9bxViE43uSb34BzpcOzQyZppEdk5/gbmJP
         aQPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:from:to:cc:subject:references
         :mime-version:content-disposition:in-reply-to;
        bh=ld37J2VuQn8PPhwE47ARtw0waR2/HuJQhsucGvvTMtA=;
        b=Xiy6/4Oq4vz8YoDaRjmWpYMCYv+c11toMElaggpqw4dlczcuscTNkuej+EOwTtU5wg
         j57zwdvnjOR5QNHUwYx6LI1s9ziTLq6mgpMWCyC6lxtc9mnuHr7+YtPDk/NUVqujoNsr
         fvQyV9qUmHrEbErtFACMpAGFGiWNqumyFOT+2OCBqvo9oPqWRY8uIZBZcu5w2zLA1GBD
         1dF5RSIE2eqghgrqiioEh1XmEFM/3L9dFC1yBi6agoRyD5qxa1Bq1/tbn3PYSALe+1QE
         dFE5BcDG2HYkASEG+XYEjmN298QVEhznyE0+08W7k/FsJ6jAlevLMK32K3gPb0BmKqIF
         WSAw==
X-Gm-Message-State: AJIora8fWmrCfL1UoJ7BgX5uM3rgvzRjPVpsJ41J/OuB+q/YYGTOoPMU
        hVgVHaFTuybQvnIKiOL3yis=
X-Google-Smtp-Source: AGRyM1u3umsK6xlqHwPnz5O2TeypBw4QaXQtA/xI3l39ercIbY2HybfED7MyFbauNWPsGryguzh7jQ==
X-Received: by 2002:a17:907:9813:b0:711:d5ac:b9ef with SMTP id ji19-20020a170907981300b00711d5acb9efmr4650798ejc.95.1655388405685;
        Thu, 16 Jun 2022 07:06:45 -0700 (PDT)
Received: from Ansuel-xps. (93-42-70-190.ip85.fastwebnet.it. [93.42.70.190])
        by smtp.gmail.com with ESMTPSA id j4-20020a50ed04000000b004318ba244dcsm1845428eds.10.2022.06.16.07.06.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jun 2022 07:06:45 -0700 (PDT)
Message-ID: <62ab38f5.1c69fb81.303fc.3bc8@mx.google.com>
X-Google-Original-Message-ID: <Yqs3+kqSfW62ieoK@Ansuel-xps.>
Date:   Thu, 16 Jun 2022 16:02:34 +0200
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: dma: rework qcom,adm Documentation
 to yaml schema
References: <20220615235404.3457-1-ansuelsmth@gmail.com>
 <1655388301.055791.3391580.nullmailer@robh.at.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1655388301.055791.3391580.nullmailer@robh.at.kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Thu, Jun 16, 2022 at 08:05:01AM -0600, Rob Herring wrote:
> On Thu, 16 Jun 2022 01:54:03 +0200, Christian Marangi wrote:
> > Rework the qcom,adm Documentation to yaml schema.
> > This is not a pure conversion since originally the driver has changed
> > implementation for the #dma-cells and was wrong from the start.
> > Also the driver now handles the common DMA clients implementation with
> > the first cell that denotes the channel number and nothing else since
> > the client will have to provide the crci information via other means.
> > 
> > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> > ---
> > v2:
> > - Change Sob to Christian Marangi
> > - Add Bjorn in the maintainers list
> > 
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
> dma-controller@18300000: resets: [[11, 13], [11, 12], [11, 11], [11, 10], [11, 9]] is too long
> 	arch/arm/boot/dts/qcom-ipq8064-ap148.dtb
> 	arch/arm/boot/dts/qcom-ipq8064-rb3011.dtb
>

I should have fixed this with the other patch. Should the conversion fix
this directly?

-- 
	Ansuel
