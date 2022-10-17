Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 168F7601BE1
	for <lists+dmaengine@lfdr.de>; Tue, 18 Oct 2022 00:00:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230048AbiJQWAO (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 17 Oct 2022 18:00:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbiJQWAK (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 17 Oct 2022 18:00:10 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9864B688BD;
        Mon, 17 Oct 2022 15:00:09 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id h18so6561827ilh.3;
        Mon, 17 Oct 2022 15:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tnbLhScXRUexhUds1cQSXMIMH6b/PAxQJNP1RSFpSEM=;
        b=fhAePMxysguVikPJrFAum4L5JCFm07BCz3PLKXwSz7FlyHbvavHryeTakIALMkmyNB
         L/pa2fLF2QFxC4lNcD08noXi5UkptjzhwWDtPSCABh3wBF5N5l3jOpDKW9QdRuS9wEXZ
         3Bxbh74EKVIffqVubsOCHx6tCUS/DyFMtYxWc3PJoaSyccQsf+i0yoCee/ql9bZrCDSy
         mQJsKmA3DI9wjYORwmNdfE69AS4zEMvg86LkGf4J8m7Pn2Sdn4t6kw053+Dvidc+q58x
         5W56hf/HCvLMwosCLF3OPLLFyDdp5L6ycOnfFUd27HxPkT2Jg3vBZugPTGCXpW+AS5/0
         WiFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tnbLhScXRUexhUds1cQSXMIMH6b/PAxQJNP1RSFpSEM=;
        b=NTd1mvJ3Ykw2FQKZNkSe4ANajziXRuYTdCHcqvQBr2JdSdaIbRoLErd7w241ENQHh7
         BbGm0d2xPs+Pl4I7W1qqgim+5sM//B/1sJ93P2qk/plo2NzRLi7u1GyS3Fr9iPFLiD5I
         yrEDVv18jIYzI3Glt8OTdY37LULHISskUuU6y3Q3FCEzJgALQfihTxD045/1nwcekYgL
         dz1sl3GhXabQtfzelAED/oA0ioUhMQEvCyOnawpslmWRTCCWeXtyQ8ZR2e1JgAodTUoD
         k9z/Q+uxvPmbuTr0zivaHC7xgTydjNRsM6BX8+3fj0miuxxiAQC0tEOinGR6WTzeog7m
         fY8w==
X-Gm-Message-State: ACrzQf1s5OdmSk4+kZse19YE7Nd+mLXLZG8xBLYWacg92fEZR3aSeHEB
        irtbjzsm6GxezB/yhuKn78eGSkiqXUc69w==
X-Google-Smtp-Source: AMsMyM4f+XIqH1+ucxpMBu6yJ4BijTu/akwwqvYLUKHj82o+A+LopQP4GQdGXnDrxsa07NPM5ajmBQ==
X-Received: by 2002:a05:6e02:12cf:b0:2fc:42c8:c515 with SMTP id i15-20020a056e0212cf00b002fc42c8c515mr5946112ilm.109.1666044008942;
        Mon, 17 Oct 2022 15:00:08 -0700 (PDT)
Received: from localhost ([2607:fea8:a2e2:2d00::4a89])
        by smtp.gmail.com with UTF8SMTPSA id t19-20020a02b193000000b003635ab4a7b7sm384650jah.3.2022.10.17.15.00.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Oct 2022 15:00:08 -0700 (PDT)
From:   Richard Acayan <mailingradian@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Richard Acayan <mailingradian@gmail.com>,
        Melody Olvera <quic_molvera@quicinc.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH 2/5] dmaengine: qcom: gpi: document preferred SM6350 binding
Date:   Mon, 17 Oct 2022 18:00:04 -0400
Message-Id: <20221017220004.6234-1-mailingradian@gmail.com>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <801c902d-4e1a-6ddc-e050-afdc2514e687@linaro.org>
References: <20221015140447.55221-1-krzysztof.kozlowski@linaro.org> <20221015140447.55221-3-krzysztof.kozlowski@linaro.org> <20221017212320.4960-1-mailingradian@gmail.com> <801c902d-4e1a-6ddc-e050-afdc2514e687@linaro.org>
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

> On 17/10/2022 17:23, Richard Acayan wrote:
>>> Devices with ee offset of 0x10000 should rather bind with SM6350
>>> compatible, so the list will not unnecessarily grow for compatible
>>> devices.
>>>
>>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>> ---
>>>  drivers/dma/qcom/gpi.c | 7 ++++---
>>>  1 file changed, 4 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/dma/qcom/gpi.c b/drivers/dma/qcom/gpi.c
>>> index f8e19e6e6117..061add832295 100644
>>> --- a/drivers/dma/qcom/gpi.c
>>> +++ b/drivers/dma/qcom/gpi.c
>>> @@ -2286,13 +2286,14 @@ static int gpi_probe(struct platform_device *pdev)
>>>  }
>>>  
>>>  static const struct of_device_id gpi_of_match[] = {
>>> -	{ .compatible = "qcom,sc7280-gpi-dma", .data = (void *)0x10000 },
>>>  	{ .compatible = "qcom,sdm845-gpi-dma", .data = (void *)0x0 },
>>>  	{ .compatible = "qcom,sm6350-gpi-dma", .data = (void *)0x10000 },
>>>  	/*
>>> -	 * Deprecated, devices with ee_offset = 0 should use sdm845-gpi-dma as
>>> -	 * fallback and not need their own entries here.
>> 
>> This comment is from the dependency series [1]. Why would we need to add it just
>> to remove it here? I was not notified that the dependency was applied anywhere
>> (except as a base for other series) so it's not set in stone. Let's just drop
>> the original patch that this comment originates from to prevent needlessly
>> adding and removing the same lines at once.
> 
> I don't remove the comment, I re-phrase it to be better suited for final
> code.

Yes, I didn't word that exactly right. I still think the patch that adds this is
now useless if it's just going to be replaced. Do you think I should keep the
patch that this comment originates from, even though we already know exactly how
its substantial contents will be replaced?

We can't modify history and drop commits on kernel trees, but I can still send
a v6 series that drops the original comment.

> 
> Best regards,
> Krzysztof
> 
