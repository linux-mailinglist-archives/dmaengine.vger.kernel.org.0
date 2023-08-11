Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74E09779299
	for <lists+dmaengine@lfdr.de>; Fri, 11 Aug 2023 17:14:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235703AbjHKPOf (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 11 Aug 2023 11:14:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234049AbjHKPOe (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 11 Aug 2023 11:14:34 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2AB42D7F;
        Fri, 11 Aug 2023 08:14:32 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2ba1e9b1fa9so32316451fa.3;
        Fri, 11 Aug 2023 08:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691766871; x=1692371671;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8HEPWhA2VFoQ4uBlBvITXD8tz5ZjNlreK6TIWbiY9hY=;
        b=eOSP3CB75p+aBgmtnbZuEHZiEA6hDUnjUfIz2jJZ+8CCTDOqMbaa4n/Kz90jmoDq85
         beuNMj+HdQvWcNGnInY8mtNYCGWK6WdRJc0WdJh0Yj8jfpKx4NvjRYgzfrLAf/L2dQ2L
         c8aMZuEaBWH5HSJygNn0U/QSLEjEjKEsyh0lzbagv3L9NxlkhkUbP1j8d+1Akw9AoCNT
         KuOneodUo3mmv8kRpqzxPDJlVCPIGjFJ9ZPNFjwSYCjuEM1MGVmf/4huwMxd/+3f8Tf6
         cZ984GUuBAUqjj5fSK5eQCPYRDfkcax/Q3cj0hXl6oYlPm3SyvX7F7OAbfnIRpUpYYZe
         E3NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691766871; x=1692371671;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8HEPWhA2VFoQ4uBlBvITXD8tz5ZjNlreK6TIWbiY9hY=;
        b=VpfakMPQJaLQeGLBTrCi9N2EzVmFk2szrTXnBdw8rp5xS4s/91JpAaOUEIQYPoHYFs
         TME6gty/k0+zIYVX6E0xLDYjC8aVufDaOQ/lXw2lgCNRO8YgAE7OYNQc3r6p9r/2kWu4
         hCZ5NbuMuKKJlePHoMmSmUDEYvF/V+MIB1OG9Y/H9ecJvsbuoShWL/BkprHN9UcJe9Yv
         k6IjJwvMInNkz2JIKlR11rX3rcl20HEoL4X5OfYIfBvM1EIrdX6dDeaPp1yGc1/P506O
         RSA8cMg8iP3c+ho2ew9vov4od3vmROSkVdShcy7FSTg5iO6om0L2Q5C8aQN6O6UWpRFG
         1UUw==
X-Gm-Message-State: AOJu0YxR76mKdevFgLVqykQ9pVZofCGTsWeWjm4X1Ykb5EsDLk1nzPzp
        uL2tyltam8zxJQIG+btdg6g=
X-Google-Smtp-Source: AGHT+IF6rX+dw1n3aIgd8ioDHNxv3r8ReDYAli/Nqo/blfsDbM5/rWX+ZJpN2HvNGzTh6ccH2xXzTQ==
X-Received: by 2002:a2e:7412:0:b0:2b9:4418:b46e with SMTP id p18-20020a2e7412000000b002b94418b46emr1773162ljc.21.1691766870495;
        Fri, 11 Aug 2023 08:14:30 -0700 (PDT)
Received: from [10.0.0.100] (host-85-29-92-32.kaisa-laajakaista.fi. [85.29.92.32])
        by smtp.gmail.com with ESMTPSA id l13-20020a2e908d000000b002b70a8478ddsm912305ljg.44.2023.08.11.08.14.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Aug 2023 08:14:30 -0700 (PDT)
Message-ID: <9a8f06e0-b986-4434-a194-9679c82035ca@gmail.com>
Date:   Fri, 11 Aug 2023 18:16:32 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] dt-bindings: dma: ti: k3* : Update optional reg
 regions
Content-Language: en-US
To:     Vignesh Raghavendra <vigneshr@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20230810174356.3322583-1-vigneshr@ti.com>
From:   =?UTF-8?Q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@gmail.com>
In-Reply-To: <20230810174356.3322583-1-vigneshr@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Vignesh,

On 10/08/2023 20:43, Vignesh Raghavendra wrote:
> DMAs on TI K3 SoCs have channel configuration registers region which are
> usually hidden from Linux and configured via Device Manager Firmware
> APIs. But certain early SWs like bootloader which run before Device
> Manager is fully up would need to directly configure these registers and
> thus require to be in DT description.
> 
> This add bindings for such configuration regions.  Backward
> compatibility is maintained to existing DT by only mandating existing
> regions to be present and this new region as optional.

These regions were 'hidden' from Linux or other open coded access for a 
reason.
If I recall the main reason is security and the need to make sure that 
the allocation of the channels not been violated.

IMho the boot loader should be no exception and it should be using the 
DM firmware to configure the DMAs.

Or has the security concern been dropped and SW can do whatever it wants?

> 
> Vignesh Raghavendra (3):
>    dt-bindings: dma: ti: k3-bcdma: Describe cfg register regions
>    dt-bindings: dma: ti: k3-pktdma: Describe cfg register regions
>    dt-bindings: dma: ti: k3-udma: Describe cfg register regions
> 
>   .../devicetree/bindings/dma/ti/k3-bcdma.yaml  | 25 +++++++++++++------
>   .../devicetree/bindings/dma/ti/k3-pktdma.yaml | 18 ++++++++++---
>   .../devicetree/bindings/dma/ti/k3-udma.yaml   | 14 ++++++++---
>   3 files changed, 43 insertions(+), 14 deletions(-)
> 

-- 
Péter
