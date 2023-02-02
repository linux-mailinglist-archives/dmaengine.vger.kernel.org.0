Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5604688A9C
	for <lists+dmaengine@lfdr.de>; Fri,  3 Feb 2023 00:17:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230343AbjBBXRf (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 2 Feb 2023 18:17:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230173AbjBBXRe (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 2 Feb 2023 18:17:34 -0500
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D83C423D97;
        Thu,  2 Feb 2023 15:17:29 -0800 (PST)
Received: by mail-ot1-f53.google.com with SMTP id e12-20020a0568301e4c00b0068bc93e7e34so916863otj.4;
        Thu, 02 Feb 2023 15:17:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x6+YD6IXci0DRMRu2WdWwnlfWwhkErY5wLNu+9o8ClU=;
        b=SEdhKwKbbpxZoZnVdqmoS2w2T5fohYG/aJJZGhic2xTvXaBYuo9aT61RaCWQZ3Uzkm
         XqI7eAZwZ4Y5oxJRpxEaF3b8XN4vFoQlTM7eHHSqZ0Z3AbG3A8acimd1J01N3hLCX1AW
         ZB5PMTF+r0BVxH9hT/TKvm0khe6UN62/oSo5AzAt/snlOyrEbivowdLOKWr6QLNVzS+u
         QId1zKmfM3i8BfPXvZT2OXHdph+umv4DtkIWS1PwHjhKzCaMjVcvExdBxzb9dHcs/99Z
         mHPTqPm2FlKHy92CaUPIZo3Pbk5bzE9LdRysUmiU6elnOPsK4Ufqupny346gWx3ATJUp
         1N4A==
X-Gm-Message-State: AO0yUKX2+ffSfniE3ls7PpJ0gHxCyUffv+9oqLUzCSOtIkKVbwDYKvNd
        WyUqe+2k0CjF7MgzD+D8WOABuwDTAA==
X-Google-Smtp-Source: AK7set/W+rdvCdAEUX/V7wxeXR6WBs4+3ypheYP8+QC+6MPyTvEirhPsiGn0zyWM+rG3tU4zxaYemw==
X-Received: by 2002:a9d:798c:0:b0:68b:e2bb:8027 with SMTP id h12-20020a9d798c000000b0068be2bb8027mr3905749otm.14.1675379849086;
        Thu, 02 Feb 2023 15:17:29 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id h26-20020a9d641a000000b0067781a9292asm429317otl.2.2023.02.02.15.17.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Feb 2023 15:17:28 -0800 (PST)
Received: (nullmailer pid 2886180 invoked by uid 1000);
        Thu, 02 Feb 2023 23:17:27 -0000
Date:   Thu, 2 Feb 2023 17:17:27 -0600
From:   Rob Herring <robh@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        dmaengine@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: ti,k3: Use common ti,k3-sci-common.yaml
 schema
Message-ID: <167537984602.2886078.411236741378963603.robh@kernel.org>
References: <20230125221339.3057322-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230125221339.3057322-1-robh@kernel.org>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On Wed, 25 Jan 2023 16:13:39 -0600, Rob Herring wrote:
> Instead of redefining the 'ti,sci' and 'ti,sci-dev-id' properties multiple
> times, reference the common schema where they are defined. Most cases
> using these properties already do this, just udma and ringacc need to be
> fixed.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  .../devicetree/bindings/dma/ti/k3-udma.yaml         |  9 +--------
>  .../devicetree/bindings/soc/ti/k3-ringacc.yaml      | 13 ++++---------
>  2 files changed, 5 insertions(+), 17 deletions(-)
> 

Applied, thanks!

