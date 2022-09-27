Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C50915EB73D
	for <lists+dmaengine@lfdr.de>; Tue, 27 Sep 2022 03:53:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229489AbiI0Bxq (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 26 Sep 2022 21:53:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiI0Bxp (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 26 Sep 2022 21:53:45 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C85EA02F6;
        Mon, 26 Sep 2022 18:53:41 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id y141so6715030iof.5;
        Mon, 26 Sep 2022 18:53:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=XUGKxBC+lZc9poJHxOzBrkKZSbPCMoposJGKoV7ZvUE=;
        b=WlF6hyEaxdCudvRtq3km/O8BPQSLYex3QZKtHYVG96lXd7UTitU0O+83zuXEckKpTH
         WlYUjiEocOJPvKniu/otJhAn5WzHt3RkTi0FVhTTI489Pelkp3IASOJ94A8n6XOkvGnq
         g7S1iJhH5OOPsM37AufELjVn6PQ83/OKPA9vINFK5Tv/L2qS7hJKVMRIMLVdGY9ngVjJ
         5R+I9pw7gwebC6ozQ8ouyaB32hGgsjf6NgjriYxR+OmQWIs2ewsHPPAHkOjUSHcQsi0s
         XH6e71w2e0SBbgVnqqw0frm5lh4mrP1PlIFD7cL7rO/AEsjmE2BqAXStzzfA7QIpTKzl
         HTOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=XUGKxBC+lZc9poJHxOzBrkKZSbPCMoposJGKoV7ZvUE=;
        b=8R9S2F4vH96LPscwWolBqZmhbVlQzTY8iV5SJON7YCPHA/+szUoWFEoOFf109pkTPV
         LpUHRG9juux/GQexu2Fy5Xkoo6hHTeJVao74pBsPkdgSxFVdd/nMNT8fBjVKbOXU7egl
         6J5+oHOVQyL4Po6s2lR7UF2w0Abk/ArBG9p3WbM7nkEkYkM5Lx+am8cNA5S0y3D0Afcn
         Mm/ynf7hn3835yl6dDMJ3flcbHByxyY3mZzV8gWUKtUqaoMo1NFyCOvfyP7xKD2/L30l
         3pxyd2W59LgJWeeIYJxdbu4cC/e7BYIXd/TKgpa5pHpxef+ENP0T65PCinfQRGOxCQG8
         UcXg==
X-Gm-Message-State: ACrzQf24IFjFe+wnUzfamEqLUZWvwSZ+qoOh6hCcmlyTJbj3Q/MjEXqX
        orbaA8wzqgQFYETXk8EDVfs=
X-Google-Smtp-Source: AMsMyM6s9aOFEDdYd/TDx9Hd+0oC8FwgC/upcyBpcV6fBPAoJYlQq2Nb8Ub4/wUMHvAEmVGwjoAk0g==
X-Received: by 2002:a05:6638:d81:b0:35a:42b0:63b4 with SMTP id l1-20020a0566380d8100b0035a42b063b4mr12855731jaj.51.1664243620773;
        Mon, 26 Sep 2022 18:53:40 -0700 (PDT)
Received: from localhost ([2607:fea8:a2e2:2d00::ac99])
        by smtp.gmail.com with UTF8SMTPSA id m6-20020a0566022e8600b0068994e773e7sm191402iow.26.2022.09.26.18.53.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Sep 2022 18:53:40 -0700 (PDT)
From:   Richard Acayan <mailingradian@gmail.com>
To:     robh@kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 1/4] dt-bindings: dma: qcom: gpi: add fallback
Date:   Mon, 26 Sep 2022 21:53:21 -0400
Message-Id: <20220927015321.33492-1-mailingradian@gmail.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220926231238.GA3132756-robh@kernel.org>
References: <20220923210934.280034-1-mailingradian@gmail.com> <20220923210934.280034-2-mailingradian@gmail.com> <7b066e11-6e5c-c6d9-c8ed-9feccaec4c0c@linaro.org> <20220923222028.284561-1-mailingradian@gmail.com> <20220926231238.GA3132756-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

> On Fri, Sep 23, 2022 at 06:20:28PM -0400, Richard Acayan wrote:
> > > On 23/09/2022 23:09, Richard Acayan wrote:
> > > > The drivers are transitioning from matching against lists of specific
> > > > compatible strings to matching against smaller lists of more generic
> > > > compatible strings. Add a fallback compatible string in the schema to
> > > > support this change.
> > > 
> > > Thanks for the patch. I wished we discussed it a bit more. :)
> > 
> > Ah, sorry for not replying to your original suggestion. I didn't see the
> > opportunity for discussion as this new series wasn't that hard to come up
> > with.
> > 
> > > qcom,gpi-dma does not look like specific enough to be correct fallback,
> > > at least not for all of the devices. I propose either a IP block version
> > > (which is tricky without access to documentation) or just one of the SoC
> > > IP blocks.
> > 
> > Solution 1:
> > 
> > Yes, I could use something like qcom,sdm845-gpi-dma. It would be weird to
> > see the compatible strings for that, though:
> 
> Why is it weird? That's how 'compatible' works. You are saying a new 
> implementation is compatible with an older implementation.

Oh, I didn't think of it like that. I found it weird how I need to specify both
sm8150 and sdm845 in the same dts, but now it makes sense. I guess I thought
fallback needed to be generic, and didn't think it could just specify an older
version of the hardware.

> 
> 
> >     compatible = "qcom,sdm670-gpi-dma", "qcom,sdm845-gpi-dma";
> > 
> 
> >     // This would need to be valid in dt schema, suggesting solution 2
> >     compatible = "qcom,sdm845-gpi-dma";
> >     // This just doesn't make sense
> >     compatible = "qcom,sdm845-gpi-dma", "qcom,sdm845-gpi-dma";
> 
> Is your question how to get the first one to work, but not the second 
> one? You need 'oneOf' with at least an entry for each case with 
> different number of compatible strings (1 and 2 entries). There are 
> lot's of examples in the tree.

No, I thought it would be tempting to use the first one for other device trees,
but you maintainers know not to allow that so it doesn't matter as much.

> 
> > 
> >     compatible = "qcom,sm8150-gpi-dma", "qcom,sdm845-gpi-dma";
> > 
> >     compatible = "qcom,sm8250-gpi-dma", "qcom,sdm845-gpi-dma";
> > 
> > Solution 2:
> > 
> > I could stray from the "soc-specific compat", "fallback compat" and just
> > have "qcom,sdm845-gpi-dma" for every SoC.
> 
> No.
> 
> > Solution 3:
> > 
> > I found the original mailing list archive for this driver:
> > 
> > https://lore.kernel.org/linux-arm-msm/20200824084712.2526079-1-vkoul@kernel.org/
> > https://lore.kernel.org/linux-arm-msm/20200918062955.2095156-1-vkoul@kernel.org/
> > 
> > It seems like the author originally handled the ee_offset as a dt property
> > and removed it. It was removed because it was a Qualcomm-specific property.
> > One option would be to bring this back against the author's wishes (or ask
> > the author about it, since they are a recipient).
> 
> No.

Ah, simple rejections with one word. You don't have to elaborate, I see why
these aren't a good fit.

> 
> > 
> > Solution 4:
> > 
> > You mentioned there being an xPU3 block here:
> > 
> > https://lore.kernel.org/linux-arm-msm/e3bfa28a-ecbc-7a57-a996-042650043514@linaro.org/
> > 
> > Maybe it's fine to have qcom,gpi-dma-v3?
> 
> I don't like made up version numbers. QCom does or did have very 
> specific version numbers, but in the end they it tended to be 1 or maybe 
> 2 SoCs per version. So not really beneficial.

I got this from using the number in xPU3, because I thought xPU3 was the
specific hardware that had ee_offset = 0. This might not be what Krzysztof meant
and perhaps I just wasn't reading properly.

Thank you for your response. You cleared up a lot of thoughts that I had about
the presented solution.
