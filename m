Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C759D78E249
	for <lists+dmaengine@lfdr.de>; Thu, 31 Aug 2023 00:23:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240323AbjH3WX5 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 30 Aug 2023 18:23:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243992AbjH3WX4 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 30 Aug 2023 18:23:56 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79173B8
        for <dmaengine@vger.kernel.org>; Wed, 30 Aug 2023 15:23:36 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-58fc4d319d2so3481827b3.1
        for <dmaengine@vger.kernel.org>; Wed, 30 Aug 2023 15:23:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693434215; x=1694039015; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZSyK+dHkjDMQS0UZZd2TV/HXC5yoOWbGzZSM7TZhYog=;
        b=Ecsjuxxp3HpHpAGqGDl75vIiWpUJweaR8RVcsTYNMVv69OU26uS7om3cd+8jcN1/Ej
         XUZZL8Ho/pHCakuWdGHEx/ZZUPwYuSXXIRFn+1acCOXJDiNAz1UPuE7fA/6NmCRvIDRI
         9HU2V9MWoaRQelErcICyBTKsT39r5h1/GWMljvniXeT0I3IKD/8YOjwTUZ7zZO+J1fJw
         J514jUCJ8beaE54H8PC+p9t+Yd3ykuOzlOc4kQ6ZlMLrpf3+anI65x5oAHCpuBZjs7p4
         YDEfF7NUa2tZuMpaXA/hP0FtcENpf2vM0gOIuYLMnRZTxuJm/ayGp1gwtHXwlYEqegmJ
         0PNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693434215; x=1694039015;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZSyK+dHkjDMQS0UZZd2TV/HXC5yoOWbGzZSM7TZhYog=;
        b=JdtgSYqmmduvRcCufKZmAfxi+10qM6EaaXd/nGxT0pOiYoQQUyhqtIkfjEu62c/oq+
         KlcAx4ZOmGr6K1BJwvUyIkkTyt5pawS8DmOv3CPyGW24+fl0QZrm+tBILF/LjRqFTn21
         h/JXk0S8DjnIhRiRzyHCdmVdFSmcjLnhnA6IR+nl9IaLBFA5c/+Za6sjvms22vK6rfRV
         adYuTEr53xNEsxEW9bb0KKPXqkb2Vc1IYgiFZ0lNtnLpe1HQ+SVQaVEFoGpPOaFPA4T2
         uliHdm0RfpORblejO1Un7P6sY4B5R3zhoomV3xjAWXf2Yapaw58zIl4AWFUUnemWEnNp
         RGRw==
X-Gm-Message-State: AOJu0YzY1+o6f52WKbA0ZPEUalMjEfI/s3aI5Ss6WMSMOuB20RJtYm+3
        yLdMpU//g6X5KDa/uNu57m/VeXaRjWdB8C91hvq+7H7mQM0qq3J5
X-Google-Smtp-Source: AGHT+IF3BC4QjQc9khz8UvoRWdeIpu1q8Bvmo2laKSOuKZOvmEKB3zwHspagVqx73Iha2+2P48AjcTOvasTtYpuNrM8=
X-Received: by 2002:a25:547:0:b0:d0f:846c:ef7b with SMTP id
 68-20020a250547000000b00d0f846cef7bmr3216161ybf.17.1693425868564; Wed, 30 Aug
 2023 13:04:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230830-topic-8550_dmac2-v1-0-49bb25239fb1@linaro.org> <20230830-topic-8550_dmac2-v1-5-49bb25239fb1@linaro.org>
In-Reply-To: <20230830-topic-8550_dmac2-v1-5-49bb25239fb1@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Wed, 30 Aug 2023 23:04:17 +0300
Message-ID: <CAA8EJpp2UbiknJ876ccCiSV2hDYdiGVRiQBdAEMM7e9z5OqK3A@mail.gmail.com>
Subject: Re: [PATCH 5/7] arm64: dts: qcom: sm8550: Mark APPS SMMU as dma-coherent
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Abel Vesa <abel.vesa@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Sai Prakash Ranjan <quic_saipraka@quicinc.com>,
        Vinod Koul <vkoul@kernel.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org
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

On Wed, 30 Aug 2023 at 21:32, Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
>
> Like on earlier flagship Qualcomm SoCs, the SMMU is dma-coherent.
> Mark it as such.

On earlier SoCs we marked Adreno SMMU as dma-coherent, not the apps
one. Only on sm8250 you've added dma-coherent to the apps smmu.

>
> Fixes: ffc50b2d3828 ("arm64: dts: qcom: Add base SM8550 dtsi")
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/sm8550.dtsi | 1 +
>  1 file changed, 1 insertion(+)

-- 
With best wishes
Dmitry
