Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EFB3601B33
	for <lists+dmaengine@lfdr.de>; Mon, 17 Oct 2022 23:23:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230167AbiJQVXe (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 17 Oct 2022 17:23:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230342AbiJQVXc (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 17 Oct 2022 17:23:32 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D398A7B78A;
        Mon, 17 Oct 2022 14:23:26 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id i65so10262774ioa.0;
        Mon, 17 Oct 2022 14:23:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XYQG9L0WOG7E+TXZGOh2Lmubn0+AsR6A7Ea6syLqUyQ=;
        b=DDlea4psan6fGakfEvw2MIaDr32zNEN1/S7GTqmmx5IJ88UF1kXdO0ErhCoCmhohb8
         /Nf95Dm3Qg6qP0LzP9Dlr9M0eEH9SJtjHFUUgD7JuOz9gOkMXnFSfT2rt59RBap+fuBM
         SPuwfeDTOD1Cg2JiuxxHgl8e/spOD1wCYCY0vlC1NS1glv/SIc9QA4LccI1nUQKAiajd
         guZae4U7oc5BlDNALXgIw9mM5Qt8tUoXGRmb58g39geLK8kmEEncxoXUyT0keXZS8fYj
         589jiJ1IdyptqXBsS1KXe3KSMQJySJjTvdPCelNIcvi5YmC+HDcGeF0kHhnbPbSD4Jqn
         7XoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XYQG9L0WOG7E+TXZGOh2Lmubn0+AsR6A7Ea6syLqUyQ=;
        b=g3tknXjBlI3Vn1MrcxrY01pkwv82FWb9gfX6NVcC8s2gWUQByB47kgxdZFMK/IRvGF
         08KhQ/opJNorzj4f37HFTNJ+ZF5bJ8raROdUmau0TWkw8XJz+jTucvOtWtXCH+XpGcyv
         gXILephCUT3xKeKQn1tbu06aHWdRJsvLvj6vAIKcJgeMaxDunNB5lOexDfxibw3LsOKH
         CaK6Iw6Rio1l8omX4yImwf57btfWYLKScglPszj4XlNjm/AHnW9LRHOisz92kRkMhRnA
         Ai1Vd51lFZ7DuOU69nrGcWIyQe3MZuEXvpb3x++WjRWlMX6Ns7AcDzdazyNEMZHidXlQ
         PiSw==
X-Gm-Message-State: ACrzQf3InO9Mf2IOF6Tb9lXg9ZhDhJ2rpup+DtV2zAhoA/PAkO+qPGDl
        jx+FFhYXrI0jMu1QpzopMkI=
X-Google-Smtp-Source: AMsMyM7r9cJXj6CSb2SdazjR8bFX3mMN7uTdF0rMCmxCh+sRQmvRjB67Z7AnPymhZsVGubQX0y6xdA==
X-Received: by 2002:a05:6638:3e06:b0:363:fd8c:7d3c with SMTP id co6-20020a0566383e0600b00363fd8c7d3cmr6659333jab.266.1666041805466;
        Mon, 17 Oct 2022 14:23:25 -0700 (PDT)
Received: from localhost ([2607:fea8:a2e2:2d00::4a89])
        by smtp.gmail.com with UTF8SMTPSA id g191-20020a025bc8000000b0035672327fe5sm338763jab.149.2022.10.17.14.23.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Oct 2022 14:23:24 -0700 (PDT)
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
Date:   Mon, 17 Oct 2022 17:23:20 -0400
Message-Id: <20221017212320.4960-1-mailingradian@gmail.com>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <20221015140447.55221-3-krzysztof.kozlowski@linaro.org>
References: <20221015140447.55221-1-krzysztof.kozlowski@linaro.org> <20221015140447.55221-3-krzysztof.kozlowski@linaro.org>
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

> Devices with ee offset of 0x10000 should rather bind with SM6350
> compatible, so the list will not unnecessarily grow for compatible
> devices.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  drivers/dma/qcom/gpi.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/dma/qcom/gpi.c b/drivers/dma/qcom/gpi.c
> index f8e19e6e6117..061add832295 100644
> --- a/drivers/dma/qcom/gpi.c
> +++ b/drivers/dma/qcom/gpi.c
> @@ -2286,13 +2286,14 @@ static int gpi_probe(struct platform_device *pdev)
>  }
>  
>  static const struct of_device_id gpi_of_match[] = {
> -	{ .compatible = "qcom,sc7280-gpi-dma", .data = (void *)0x10000 },
>  	{ .compatible = "qcom,sdm845-gpi-dma", .data = (void *)0x0 },
>  	{ .compatible = "qcom,sm6350-gpi-dma", .data = (void *)0x10000 },
>  	/*
> -	 * Deprecated, devices with ee_offset = 0 should use sdm845-gpi-dma as
> -	 * fallback and not need their own entries here.

This comment is from the dependency series [1]. Why would we need to add it just
to remove it here? I was not notified that the dependency was applied anywhere
(except as a base for other series) so it's not set in stone. Let's just drop
the original patch that this comment originates from to prevent needlessly
adding and removing the same lines at once.

[1] https://lore.kernel.org/linux-arm-msm/20221007213640.85469-4-mailingradian@gmail.com/

> +	 * Do not grow the list for compatible devices. Instead use
> +	 * qcom,sdm845-gpi-dma (for ee_offset = 0x0) or qcom,sm6350-gpi-dma
> +	 * (for ee_offset = 0x10000).
>  	 */
> +	{ .compatible = "qcom,sc7280-gpi-dma", .data = (void *)0x10000 },
>  	{ .compatible = "qcom,sm8150-gpi-dma", .data = (void *)0x0 },
>  	{ .compatible = "qcom,sm8250-gpi-dma", .data = (void *)0x0 },
>  	{ .compatible = "qcom,sm8350-gpi-dma", .data = (void *)0x10000 },
> -- 
> 2.34.1
> 
