Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 942795EB52A
	for <lists+dmaengine@lfdr.de>; Tue, 27 Sep 2022 01:12:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230164AbiIZXMn (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 26 Sep 2022 19:12:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230298AbiIZXMl (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 26 Sep 2022 19:12:41 -0400
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40693AC38F;
        Mon, 26 Sep 2022 16:12:40 -0700 (PDT)
Received: by mail-oi1-f172.google.com with SMTP id n83so10067139oif.11;
        Mon, 26 Sep 2022 16:12:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=sd3nu7wOmD66JHzdTn3GImPyIDBACVdi1fceUwY0jNo=;
        b=E7w7nFBXCXXOmP6urvEVo8SeRhUxtB6blJM2jSFd+zGEK0gW0ieghYzXhHVlOiq93N
         aE6577x5zCA/qwRz5i31ejc8shSgZmkmUuAKd93yin43fd+WgoORUH4BXXiBsPF0x9Mc
         CNd8d212EFtjNfCtPhQ1mSIAcDtq0Yjh8TsdMRCyUfS2CSMN3/rAItCCu8cZ8R/zmXz5
         567kaNmpIT0X7zcIYfDA2QjqAsbWylQ3nkL/zdM3cPhQtwosEtM+TkvFyxZOYb5GfC3D
         otZPYEeUQHvbuAcLhUoqDK8IrLeVazSYp/tgouhBICf4mzaK502GBiOpVrSrfAIJ46+I
         bC7w==
X-Gm-Message-State: ACrzQf0moLL8fPtM9JBgn5e3V6GXEOOtMhyGwdBIRA2AH5Gb1QJe3Ej2
        JqLjabCN+bdmB183fbrFiig8er8UZQ==
X-Google-Smtp-Source: AMsMyM4Jq4d7LwcSbV7kR28dreIrQcf3dyepJYPYiHsFi23ydQpd1GZSW+TL/vsFuTGW59z84oHAPg==
X-Received: by 2002:a05:6808:246:b0:34f:e4d6:330c with SMTP id m6-20020a056808024600b0034fe4d6330cmr532855oie.142.1664233959454;
        Mon, 26 Sep 2022 16:12:39 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id w7-20020a056870430700b0011f400edb17sm9810530oah.4.2022.09.26.16.12.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 16:12:38 -0700 (PDT)
Received: (nullmailer pid 3145952 invoked by uid 1000);
        Mon, 26 Sep 2022 23:12:38 -0000
Date:   Mon, 26 Sep 2022 18:12:38 -0500
From:   Rob Herring <robh@kernel.org>
To:     Richard Acayan <mailingradian@gmail.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 1/4] dt-bindings: dma: qcom: gpi: add fallback
Message-ID: <20220926231238.GA3132756-robh@kernel.org>
References: <20220923210934.280034-1-mailingradian@gmail.com>
 <20220923210934.280034-2-mailingradian@gmail.com>
 <7b066e11-6e5c-c6d9-c8ed-9feccaec4c0c@linaro.org>
 <20220923222028.284561-1-mailingradian@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220923222028.284561-1-mailingradian@gmail.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Fri, Sep 23, 2022 at 06:20:28PM -0400, Richard Acayan wrote:
> > On 23/09/2022 23:09, Richard Acayan wrote:
> > > The drivers are transitioning from matching against lists of specific
> > > compatible strings to matching against smaller lists of more generic
> > > compatible strings. Add a fallback compatible string in the schema to
> > > support this change.
> > 
> > Thanks for the patch. I wished we discussed it a bit more. :)
> 
> Ah, sorry for not replying to your original suggestion. I didn't see the
> opportunity for discussion as this new series wasn't that hard to come up
> with.
> 
> > qcom,gpi-dma does not look like specific enough to be correct fallback,
> > at least not for all of the devices. I propose either a IP block version
> > (which is tricky without access to documentation) or just one of the SoC
> > IP blocks.
> 
> Solution 1:
> 
> Yes, I could use something like qcom,sdm845-gpi-dma. It would be weird to
> see the compatible strings for that, though:

Why is it weird? That's how 'compatible' works. You are saying a new 
implementation is compatible with an older implementation.


>     compatible = "qcom,sdm670-gpi-dma", "qcom,sdm845-gpi-dma";
> 

>     // This would need to be valid in dt schema, suggesting solution 2
>     compatible = "qcom,sdm845-gpi-dma";
>     // This just doesn't make sense
>     compatible = "qcom,sdm845-gpi-dma", "qcom,sdm845-gpi-dma";

Is your question how to get the first one to work, but not the second 
one? You need 'oneOf' with at least an entry for each case with 
different number of compatible strings (1 and 2 entries). There are 
lot's of examples in the tree.

> 
>     compatible = "qcom,sm8150-gpi-dma", "qcom,sdm845-gpi-dma";
> 
>     compatible = "qcom,sm8250-gpi-dma", "qcom,sdm845-gpi-dma";
> 
> Solution 2:
> 
> I could stray from the "soc-specific compat", "fallback compat" and just
> have "qcom,sdm845-gpi-dma" for every SoC.

No.

> Solution 3:
> 
> I found the original mailing list archive for this driver:
> 
> https://lore.kernel.org/linux-arm-msm/20200824084712.2526079-1-vkoul@kernel.org/
> https://lore.kernel.org/linux-arm-msm/20200918062955.2095156-1-vkoul@kernel.org/
> 
> It seems like the author originally handled the ee_offset as a dt property
> and removed it. It was removed because it was a Qualcomm-specific property.
> One option would be to bring this back against the author's wishes (or ask
> the author about it, since they are a recipient).

No.

> 
> Solution 4:
> 
> You mentioned there being an xPU3 block here:
> 
> https://lore.kernel.org/linux-arm-msm/e3bfa28a-ecbc-7a57-a996-042650043514@linaro.org/
> 
> Maybe it's fine to have qcom,gpi-dma-v3?

I don't like made up version numbers. QCom does or did have very 
specific version numbers, but in the end they it tended to be 1 or maybe 
2 SoCs per version. So not really beneficial.

Rob
