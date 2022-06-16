Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4A9E54ECA4
	for <lists+dmaengine@lfdr.de>; Thu, 16 Jun 2022 23:32:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378728AbiFPVcp (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 16 Jun 2022 17:32:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378601AbiFPVco (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 16 Jun 2022 17:32:44 -0400
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 599E626D1;
        Thu, 16 Jun 2022 14:32:43 -0700 (PDT)
Received: by mail-il1-f174.google.com with SMTP id f7so1794925ilr.5;
        Thu, 16 Jun 2022 14:32:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Xx/fWVM1inIlnwK4DsJOh2lpmiBQgnzytZ7NtywaYmo=;
        b=PQSkPUx8pstCvE/JHMcpLlZvtX0T6P8kEeLKocSVem9/jjJFOiDmFvunHEpVpcu2b1
         mHTvoGOvVuYUX0RPH9genbdT4Mt2QGQmBlVu7mx3/reOl4wVw4CnfuPErmqqGTtAa0L7
         kzqaVHjpcePEBz7bWzzBkwxxHdAc0IC85tBSzB3+alnuFXAW0bGJdeilEm2kT1dutskI
         s/6qp5pmuZfxiQPNWE6DY//9O+DlmB8zSMS2dpnYKovQ9wNOILgHE5MKwGDll4pSDEPK
         ZRgehZtbonHrjoFhCxlpVWZ1pc1iVQG0VKY0JiHwOCjQwjFIXGIcJQgNmFzFdI0VwxN1
         gYNA==
X-Gm-Message-State: AJIora8fmZQcmUbnrKXna/X83NcuApwLYkVkm1Kd81bgxLMEIAElEVwd
        gtYWlaUjM/NsjSlwOFLuZA==
X-Google-Smtp-Source: AGRyM1vJkCys4NwRVB4CvBh3HsaiE3lPschhZcb/uTPpn6OqhSGR+2BK4ReX7KqBJO6IqkYGLLHQ+w==
X-Received: by 2002:a05:6e02:1e08:b0:2d3:a866:2f0d with SMTP id g8-20020a056e021e0800b002d3a8662f0dmr3812661ila.277.1655415162666;
        Thu, 16 Jun 2022 14:32:42 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id n17-20020a027151000000b0032b3a7817e9sm1334411jaf.173.2022.06.16.14.32.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jun 2022 14:32:42 -0700 (PDT)
Received: (nullmailer pid 4030651 invoked by uid 1000);
        Thu, 16 Jun 2022 21:32:41 -0000
Date:   Thu, 16 Jun 2022 15:32:41 -0600
From:   Rob Herring <robh@kernel.org>
To:     Christian Marangi <ansuelsmth@gmail.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] dt-bindings: dma: add additional pbus reset to
 qcom,adm
Message-ID: <20220616213241.GD3991754-robh@kernel.org>
References: <20220615235404.3457-1-ansuelsmth@gmail.com>
 <20220615235404.3457-2-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220615235404.3457-2-ansuelsmth@gmail.com>
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

On Thu, Jun 16, 2022 at 01:54:04AM +0200, Christian Marangi wrote:
> qcom,adm require an additional reset for the pbus line. Add this missing
> reset to match the current implementation on ipq806x.dtsi.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
>  Documentation/devicetree/bindings/dma/qcom,adm.yaml | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)

Reviewed-by: Rob Herring <robh@kernel.org>
