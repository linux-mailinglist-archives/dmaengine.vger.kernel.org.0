Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 629CE7D62AA
	for <lists+dmaengine@lfdr.de>; Wed, 25 Oct 2023 09:29:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232835AbjJYH3p (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 25 Oct 2023 03:29:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232654AbjJYH3n (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 25 Oct 2023 03:29:43 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6866312A
        for <dmaengine@vger.kernel.org>; Wed, 25 Oct 2023 00:29:39 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-53df747cfe5so8350506a12.2
        for <dmaengine@vger.kernel.org>; Wed, 25 Oct 2023 00:29:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1698218978; x=1698823778; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GaJ6zuWvLeAZ+++ztXhxYXgcxHY1LVJke6okHi+19jg=;
        b=NJpK7cDjGGcyvVbkPs7oPrWy6HP70s2F3Gxq47QyX+WqzGSRAaTq73cOL69VslnVj4
         nlDpzMk9ZfGP9oqTlbipioYuBOhan2OsxPc3pDg8Nx9mc/rChQjNJI+jreIQDeYWrnCL
         19ZXu4eVOA8ilhvULEghUvyhVEi5PYaDzsBTOwqe5FMljIU6uUsapzb0diIxprGjH+Qc
         JkvBVBPlKOR/ZmcVUfFmYFvHRJwVQZcFKDJfQnoI992vOUoklNIM49dlYDXagXIDJnJG
         NDnSHer8lj3SfBvycgZgEI2vabeVlBIaoTAqquD8jjcwqULY3LrRXhTZCs170Y35xMxo
         ib7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698218978; x=1698823778;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GaJ6zuWvLeAZ+++ztXhxYXgcxHY1LVJke6okHi+19jg=;
        b=GIrA1RLUrhImmlfx2Wd9AByX/ZV3a1NVIfk3Jg5bdv5GIgisdlclb5w57h2vsYJHbg
         Y5Q8vCQeL8C1WUpW6bNWquttEbliNNRwcv8DbNuVy00NTVVo5FG/zyqY3WqHijvYrgBm
         AQlbjRyHqxVvs54xtw5s1oTPAMbBLU7toZ7jTb9zQzEF4e7oATFX5jqVAz/b8QflLYW1
         7DVbJmN2rtv9mFnQ5x7p74iXy7GilN4GbuiwARqRtiJx+bS9IAvFqPDsLdjSxVstKLpE
         UK7rOo3tQ/uN1ST2HeoSRAxTYjLZKNsKcIiqbXFk1dCh2ytIG9XRTE7ptci/tIWCh3l1
         KDvw==
X-Gm-Message-State: AOJu0Yx7NZV/6MsJgZUZNWVyB6lYUle6TsLjIglk77QA9T4gvbf02Der
        81CPvIafgFxd06UCP4XffQtD8A==
X-Google-Smtp-Source: AGHT+IHPmzZHfHPpMFOB8IpLnVIKGpxikP7sHcZ5pnFTtK0BR5d6mEiHX/eYSI4M+bomv8jRLrOWHA==
X-Received: by 2002:a05:6402:27d4:b0:540:88ad:11a1 with SMTP id c20-20020a05640227d400b0054088ad11a1mr4370282ede.39.1698218977887;
        Wed, 25 Oct 2023 00:29:37 -0700 (PDT)
Received: from localhost (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id s21-20020a056402037500b0053e0395059csm8881402edw.21.2023.10.25.00.29.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Oct 2023 00:29:37 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Wed, 25 Oct 2023 09:29:37 +0200
Message-Id: <CWHCDVXDDU74.3U8VFCO1HHIDU@fairphone.com>
Cc:     <linux-arm-msm@vger.kernel.org>, <dmaengine@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] dt-bindings: dma: qcom,gpi: document the SM8560 GPI DMA
 Engine
From:   "Luca Weiss" <luca.weiss@fairphone.com>
To:     "Neil Armstrong" <neil.armstrong@linaro.org>,
        "Andy Gross" <agross@kernel.org>,
        "Bjorn Andersson" <andersson@kernel.org>,
        "Konrad Dybcio" <konrad.dybcio@linaro.org>,
        "Vinod Koul" <vkoul@kernel.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        "Conor Dooley" <conor+dt@kernel.org>
X-Mailer: aerc 0.15.2
References: <20231025-topic-sm8650-upstream-bindings-gpi-v1-1-3e8824ae480c@linaro.org>
In-Reply-To: <20231025-topic-sm8650-upstream-bindings-gpi-v1-1-3e8824ae480c@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Wed Oct 25, 2023 at 9:25 AM CEST, Neil Armstrong wrote:
> Document the GPI DMA Engine on the SM8650 Platform.

Hi Neil,

The subject of this patch and a few others refer to 8560 instead of
8650. Please fix :)

* dt-bindings: dma: qcom,gpi: document the SM8560 GPI DMA Engine
* dt-bindings: usb: qcom,dwc3: document the SM8560 SuperSpeed DWC3 USB cont=
roller
* dt-bindings: soc: qcom,aoss-qmp: document the SM8560 Always-On Subsystem =
side channel

Regards
Luca

>
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
> For convenience, a regularly refreshed linux-next based git tree containi=
ng
> all the SM8650 related work is available at:
> https://git.codelinaro.org/neil.armstrong/linux/-/tree/topic/sm85650/upst=
ream/integ
> ---
>  Documentation/devicetree/bindings/dma/qcom,gpi.yaml | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/dma/qcom,gpi.yaml b/Docume=
ntation/devicetree/bindings/dma/qcom,gpi.yaml
> index 88d0de3d1b46..0985b039e6d5 100644
> --- a/Documentation/devicetree/bindings/dma/qcom,gpi.yaml
> +++ b/Documentation/devicetree/bindings/dma/qcom,gpi.yaml
> @@ -32,6 +32,7 @@ properties:
>                - qcom,sm8350-gpi-dma
>                - qcom,sm8450-gpi-dma
>                - qcom,sm8550-gpi-dma
> +              - qcom,sm8650-gpi-dma
>            - const: qcom,sm6350-gpi-dma
>        - items:
>            - enum:
>
> ---
> base-commit: fe1998aa935b44ef873193c0772c43bce74f17dc
> change-id: 20231016-topic-sm8650-upstream-bindings-gpi-29a256168e2f
>
> Best regards,

