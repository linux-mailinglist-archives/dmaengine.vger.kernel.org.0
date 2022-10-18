Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BEBA601FC5
	for <lists+dmaengine@lfdr.de>; Tue, 18 Oct 2022 02:39:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232284AbiJRAjn (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 17 Oct 2022 20:39:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232236AbiJRAjA (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 17 Oct 2022 20:39:00 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 447B82D1D3;
        Mon, 17 Oct 2022 17:38:44 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id 187so10543312iov.10;
        Mon, 17 Oct 2022 17:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XlhfMLBD9roK3usgmTalym3p24qmGFsJ7yKhSqoF6eE=;
        b=SKuxY2D1ggKZw5AIxtovMVOi0bMS6948pzTuhpr95+US+rXA2hyFjcWyfCdaCUCb/S
         SM6+4PzuUnwDMnMspTha9/yHQQZKVwtRUuo8H+ckdNX1bL3C02cZnUKbxyDYSICzlkkL
         PnvvwRjhz6x4R/pklBCE0RuQNK+ycvNJFIhhpH8Ff7132g4zBuH/aa5+Bcb3u8Qm97LW
         NpECeJxZC50ldm2IQOBTskFOzdxdKW2KlpOytzQ6ERCHmkrXrWy5hJmh/dDUzS+i98Rf
         bI3Z2pigyquQAYS7H1XD03xPG7fiF9EZ1JhC/rlTYRTqdJK1jVfAdx5X6mFtXxO8Ykle
         2Ctg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XlhfMLBD9roK3usgmTalym3p24qmGFsJ7yKhSqoF6eE=;
        b=3/+cFbomYcx74q46TpZhkNqkkhsTRdmcMqKXHED7jHwzzFnIoD6HPOtlBfVGMTl2y4
         MGVcUvwgmPxGlxpAaJBdSMrrxd7hmauHKR2NmarsXc5QR9Z2JOugUZ8wDBGfzAevtbH6
         mo1uw1mhU40tHBagYjBzj7bXWK/MQXRkk6R4ffGTJILFBLWJIdlw5R+6m06F7E2MVwbq
         F7wSG4LPU3AasM6Eco1vfZqoxDe2fHCkqOnAxMqvy4XRJ3qTbRcvMkSjAOWzkG91GcOU
         t/p86gX6E4qIMb6iOHGvg8ZHGA5hhd96w2+XxJeuYMWGWvwhRxF8/PX0YStGgA31lMfm
         QqiQ==
X-Gm-Message-State: ACrzQf39Ulb9SIcoEfCJdOXfrKVYSJiwq4rVCcmWouFitIi8zNJDbj/P
        DGD6yV9a9+Zzj4Aq0363Dc4=
X-Google-Smtp-Source: AMsMyM7btFADvKuqFJI+j+cM9Q57eDbr9oysnGbnjoIQefOXCXYVFU3irXtHKbQpzKghTu0GbV2sgQ==
X-Received: by 2002:a05:6602:2c8e:b0:6a3:886a:30fb with SMTP id i14-20020a0566022c8e00b006a3886a30fbmr432747iow.75.1666053472214;
        Mon, 17 Oct 2022 17:37:52 -0700 (PDT)
Received: from localhost ([2607:fea8:a2e2:2d00::4a89])
        by smtp.gmail.com with UTF8SMTPSA id k3-20020a0566022a4300b006a11760aebbsm468096iov.36.2022.10.17.17.37.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Oct 2022 17:37:51 -0700 (PDT)
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
Date:   Mon, 17 Oct 2022 20:37:28 -0400
Message-Id: <20221018003727.22763-1-mailingradian@gmail.com>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <6d9df544-b99e-4d62-53d1-1f3290d31a19@linaro.org>
References: <20221015140447.55221-1-krzysztof.kozlowski@linaro.org> <20221015140447.55221-3-krzysztof.kozlowski@linaro.org> <20221017212320.4960-1-mailingradian@gmail.com> <801c902d-4e1a-6ddc-e050-afdc2514e687@linaro.org> <20221017220004.6234-1-mailingradian@gmail.com> <6d9df544-b99e-4d62-53d1-1f3290d31a19@linaro.org>
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

> On 17/10/2022 18:00, Richard Acayan wrote:
>>> On 17/10/2022 17:23, Richard Acayan wrote:
>>>>> Devices with ee offset of 0x10000 should rather bind with SM6350
>>>>> compatible, so the list will not unnecessarily grow for compatible
>>>>> devices.
>>>>>
>>>>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>>>> ---
>>>>>  drivers/dma/qcom/gpi.c | 7 ++++---
>>>>>  1 file changed, 4 insertions(+), 3 deletions(-)
>>>>>
>>>>> diff --git a/drivers/dma/qcom/gpi.c b/drivers/dma/qcom/gpi.c
>>>>> index f8e19e6e6117..061add832295 100644
>>>>> --- a/drivers/dma/qcom/gpi.c
>>>>> +++ b/drivers/dma/qcom/gpi.c
>>>>> @@ -2286,13 +2286,14 @@ static int gpi_probe(struct platform_device *pdev)
>>>>>  }
>>>>>  
>>>>>  static const struct of_device_id gpi_of_match[] = {
>>>>> -	{ .compatible = "qcom,sc7280-gpi-dma", .data = (void *)0x10000 },
>>>>>  	{ .compatible = "qcom,sdm845-gpi-dma", .data = (void *)0x0 },
>>>>>  	{ .compatible = "qcom,sm6350-gpi-dma", .data = (void *)0x10000 },
>>>>>  	/*
>>>>> -	 * Deprecated, devices with ee_offset = 0 should use sdm845-gpi-dma as
>>>>> -	 * fallback and not need their own entries here.
>>>>
>>>> This comment is from the dependency series [1]. Why would we need to add it just
>>>> to remove it here? I was not notified that the dependency was applied anywhere
>>>> (except as a base for other series) so it's not set in stone. Let's just drop
>>>> the original patch that this comment originates from to prevent needlessly
>>>> adding and removing the same lines at once.
>>>
>>> I don't remove the comment, I re-phrase it to be better suited for final
>>> code.
>> 
>> Yes, I didn't word that exactly right. I still think the patch that adds this is
>> now useless if it's just going to be replaced. Do you think I should keep the
>> patch that this comment originates from, even though we already know exactly how
>> its substantial contents will be replaced?
>> 
>> We can't modify history and drop commits on kernel trees, but I can still send
>> a v6 series that drops the original comment.
> 
> Sure. You can make it then:
> 
> 	 * Do not grow the list for compatible devices. Instead use
> 	 * qcom,sdm845-gpi-dma (for ee_offset = 0x0).

If you don't want me to drop the original patch completely, then there is no
need to make any changes at all to the driver patches IMHO. I originally thought
we only needed one patch for the driver (yours) but you seem to have a really
good reason not to drop the original patch. Sorry for asking.

I guess you can add this if you want:

Acked-by: Richard Acayan <mailingradian@gmail.com>

> 
> And my patch will just change one line.
> 
> We can also keep it like:
> 
> 	 * Do not grow the list for compatible devices. Instead use
> 	 * proper fallback compatibles.
> 
> Best regards,
> Krzysztof
> 
