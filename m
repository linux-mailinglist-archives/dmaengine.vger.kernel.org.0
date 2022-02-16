Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 218814B89E3
	for <lists+dmaengine@lfdr.de>; Wed, 16 Feb 2022 14:28:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234227AbiBPN2x (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 16 Feb 2022 08:28:53 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231593AbiBPN2w (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 16 Feb 2022 08:28:52 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 135EF165C33
        for <dmaengine@vger.kernel.org>; Wed, 16 Feb 2022 05:28:39 -0800 (PST)
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com [209.85.208.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id A41CB3F339
        for <dmaengine@vger.kernel.org>; Wed, 16 Feb 2022 13:28:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1645018118;
        bh=uvLbH9+eJYb169S0u8GtDlmAGmS1dovfO9ippBhbjag=;
        h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
         In-Reply-To:Content-Type;
        b=VejuCDpk73LG2nSO+2rGaItSvInGFyiLk8/FjmKsNurHWHsrMRcYo8To5xh/A+jIE
         IX2lYOOF/WyTAHohGvKbDMUv4htj9odDx9MzadfRubhRiIvBncc16EJPfPNZ6z9Ewt
         uE5PwJEsjsw8gXqyQbhHb0ijBvATeW4T8wCLLmk+9bJ5fKLSrcHfdabHtb3jJCLA/O
         UFHS2w0kiVbaAxmfd4Si8WjE3309eem459svAGdSCkcbXYZH1sO8guEO4NL//B1F4S
         8IlZO+K5+AjcEl1oYZYsxrgTGO+CrjhsekL+jnoYffWo5BCxsB1drx+m6i4laEGH6Z
         Iykgx6EuYnV2g==
Received: by mail-ed1-f71.google.com with SMTP id r11-20020a508d8b000000b00410a4fa4768so1537266edh.9
        for <dmaengine@vger.kernel.org>; Wed, 16 Feb 2022 05:28:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=uvLbH9+eJYb169S0u8GtDlmAGmS1dovfO9ippBhbjag=;
        b=gwK6LkisuS47Co+HNXtEpH7pgRu8rMbuoNYAjabdAaLEQqm/x0UvcqZ3IUAb04bJW8
         biZhuwtG9hS+920f63vEVFc/50DXipmH/AzGb08tLSpwk3nY/dS63AWBR2mwXRmIs8GJ
         iKAzfldBlLn59A2EGDiEkRof0kDoXZ0rqOxZuMquSs49MrZpkKjsPTm1ML0lqgo4BS/z
         NbQOBFjmcVanrKy4Zfh+3MaGE7HHNAZ1Ix3IxmtYU52VlxUtBUSwjYA1+nOXdJMZEldF
         0P+6UUEhIxLvlMwuw8ZWyxX4QMn1zSbRDtJ0QnCiZbcobJQIsf/ftB3tuxLxNzNdXGPt
         JUzg==
X-Gm-Message-State: AOAM532pqmh8is0rXgvRm1mhJf1DhAU6A3fgaG7kpicLR5Wd4Yf89pZX
        2+VmoMxorC/V0vsY+9AHy1C7c38TgH9TTp3vLsdFoegjdzjgyDr96Ou8pnwcd7lwUlGU7TpxLqP
        7dVbBSh6SJ7E9ULXApm/9m/ZCHzqthag08XlN8A==
X-Received: by 2002:aa7:db94:0:b0:410:f0e8:c39e with SMTP id u20-20020aa7db94000000b00410f0e8c39emr3081988edt.14.1645018117956;
        Wed, 16 Feb 2022 05:28:37 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyDjLnVqY6woKkNirfpbndg7T+yQE6xw/kqrdiC2tPwlz5D4kqZP8qH23TQVUGR9vke/u8BEQ==
X-Received: by 2002:aa7:db94:0:b0:410:f0e8:c39e with SMTP id u20-20020aa7db94000000b00410f0e8c39emr3081967edt.14.1645018117815;
        Wed, 16 Feb 2022 05:28:37 -0800 (PST)
Received: from [192.168.0.110] (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id s9sm1645056edj.48.2022.02.16.05.28.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Feb 2022 05:28:37 -0800 (PST)
Message-ID: <9f90a0d0-20fe-d191-e6e9-23d794fb4efe@canonical.com>
Date:   Wed, 16 Feb 2022 14:28:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] dt-bindings: dma: Convert mtk-uart-apdma to DT schema
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, vkoul@kernel.org
Cc:     robh+dt@kernel.org, sean.wang@mediatek.com, matthias.bgg@gmail.com,
        long.cheng@mediatek.com, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20220216114054.269656-1-angelogioacchino.delregno@collabora.com>
 <79a47f67-bb66-bad4-b6bc-c6a8c0ef25dc@canonical.com>
In-Reply-To: <79a47f67-bb66-bad4-b6bc-c6a8c0ef25dc@canonical.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 16/02/2022 14:26, Krzysztof Kozlowski wrote:
> On 16/02/2022 12:40, AngeloGioacchino Del Regno wrote:
>> Convert the MediaTek UART APDMA Controller binding to DT schema.
>>
>> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>> ---
>>  .../bindings/dma/mediatek,uart-dma.yaml       | 112 ++++++++++++++++++
>>  .../bindings/dma/mtk-uart-apdma.txt           |  56 ---------
>>  2 files changed, 112 insertions(+), 56 deletions(-)
>>  create mode 100644 Documentation/devicetree/bindings/dma/mediatek,uart-dma.yaml
>>  delete mode 100644 Documentation/devicetree/bindings/dma/mtk-uart-apdma.txt
>>
>> diff --git a/Documentation/devicetree/bindings/dma/mediatek,uart-dma.yaml b/Documentation/devicetree/bindings/dma/mediatek,uart-dma.yaml
>> new file mode 100644
>> index 000000000000..4583c8f535b2
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/dma/mediatek,uart-dma.yaml
>> @@ -0,0 +1,112 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/dma/mediatek,uart-dma.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: MediaTek UART APDMA controller
>> +
>> +maintainers:
>> +  - Long Cheng <long.cheng@mediatek.com>

Is this still up-to-date? Emails bounce:

  smtp; 550 Relaying mail to long.cheng@mediatek.com is not allowed


Best regards,
Krzysztof
