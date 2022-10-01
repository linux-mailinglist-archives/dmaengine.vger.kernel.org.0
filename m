Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 612C75F1A8C
	for <lists+dmaengine@lfdr.de>; Sat,  1 Oct 2022 09:14:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229583AbiJAHO2 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 1 Oct 2022 03:14:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbiJAHO1 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 1 Oct 2022 03:14:27 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F5BBFAD2
        for <dmaengine@vger.kernel.org>; Sat,  1 Oct 2022 00:14:26 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id 81so269817ybf.7
        for <dmaengine@vger.kernel.org>; Sat, 01 Oct 2022 00:14:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=PgzZ0PoJnAJz0dQXkSQKaL7dHuT1cZSXRrd9261Dnqk=;
        b=mlQfF7N1lrHCE7kzVtI6RSbT96oqYXRvPkt9eX6xq+qfm4PQfTjJVQlxNDnrIqSiK7
         fYF0Md3sB5LhiyQOzellOrJf+UQq0Usqk7TkNrf3IEMewO5PdRPyuNMDKMOMoqpm/YdL
         U76rKfnEfbppYSWsDQENGMquaxWiWBPv8nXQnH8I5RP+s+IkOaMuiYfqg01Cfsc3aGfI
         PJLIQnsuxZAuyMfxGnywGcU0cWYVhzR1J7o61gpcW518YfAIrTs330qNfLWP6fX9oiEY
         7xSObKxr6BQM5qFim7Ez/TfVjduQ0VT4rjTXCutA4b+am1i6GQSiu5mipBtOS7rfyAc6
         FF3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=PgzZ0PoJnAJz0dQXkSQKaL7dHuT1cZSXRrd9261Dnqk=;
        b=amiEjXb6SFUNp66eP/MR+acAIvlufbOUcjJEWmZmoySryNiOzYQDJ6togfgh2SOCQ0
         0k0Cr0NgQt1Q422R/DZgLIOUupSYUuoVVk8E5fjwXkNlvn17SW+yM/cvJuus7hvjm7gl
         g2XQVwHMGsS487o3J5DyCm4YRXxxLRjx/cT7zIMBhrttwIhpxiVuRSRL8bV2MU6YUvZ2
         adj/28Q7h2WqLCmrmtE6wmmNjdEwUe0IDRIgCVnDCAHHwvH+yLKEXBClnWkl1KskhJZd
         25aLHUSE/zeCdsR+EQA2EStY2HIrrH20xhe22WtjVGLGSv+ko4FZ+jHwxgcxRbog755f
         qQpQ==
X-Gm-Message-State: ACrzQf228hm0ookeF/CwpGXLpEnqB6pa/AqCtH5NIWmRHs0yQObYBmhc
        aUdOXti0ajOHbkyq3H5qCxL27cbcdI2UVuFpaI8fgw==
X-Google-Smtp-Source: AMsMyM6u9BV0jp1phJUaaaJ8xA763ZxFTU2uofLHSHfSHU9LH6ozAYvYoscycfEMeh5n7Po4WdRQDl22O+CU0dKPQTY=
X-Received: by 2002:a05:6902:102f:b0:6b4:7cba:b77a with SMTP id
 x15-20020a056902102f00b006b47cbab77amr11680432ybt.516.1664608465947; Sat, 01
 Oct 2022 00:14:25 -0700 (PDT)
MIME-Version: 1.0
References: <20221001030627.29147-1-quic_molvera@quicinc.com> <20221001030627.29147-3-quic_molvera@quicinc.com>
In-Reply-To: <20221001030627.29147-3-quic_molvera@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Sat, 1 Oct 2022 10:14:15 +0300
Message-ID: <CAA8EJppLd6dti=gbR0hbEAQyj5PHA7xWR3w+DESx1qcKcyf3YA@mail.gmail.com>
Subject: Re: [PATCH 2/2] dmaengine: qcom: gpi: Add compatible for QDU1000 and QRU1000
To:     Melody Olvera <quic_molvera@quicinc.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Sat, 1 Oct 2022 at 06:08, Melody Olvera <quic_molvera@quicinc.com> wrote:
>
> Add compatible fields for the Qualcomm QDU1000 and QRU1000 SoCs.
>
> Signed-off-by: Melody Olvera <quic_molvera@quicinc.com>
> ---
>  drivers/dma/qcom/gpi.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/dma/qcom/gpi.c b/drivers/dma/qcom/gpi.c
> index 8f0c9c4e2efd..94f92317979c 100644
> --- a/drivers/dma/qcom/gpi.c
> +++ b/drivers/dma/qcom/gpi.c
> @@ -2292,6 +2292,8 @@ static const struct of_device_id gpi_of_match[] = {
>         { .compatible = "qcom,sm8250-gpi-dma", .data = (void *)0x0 },
>         { .compatible = "qcom,sm8350-gpi-dma", .data = (void *)0x10000 },
>         { .compatible = "qcom,sm8450-gpi-dma", .data = (void *)0x10000 },
> +       { .compatible = "qcom,qdu1000-gpi-dma", .data = (void *)0x10000 },
> +       { .compatible = "qcom,qru1000-gpi-dma", .data = (void *)0x10000 },

As usual

>         { },
>  };
>  MODULE_DEVICE_TABLE(of, gpi_of_match);
> --
> 2.37.3
>


-- 
With best wishes
Dmitry
