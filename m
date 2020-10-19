Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5A1F2925B3
	for <lists+dmaengine@lfdr.de>; Mon, 19 Oct 2020 12:24:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726612AbgJSKYn (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 19 Oct 2020 06:24:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726242AbgJSKYn (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 19 Oct 2020 06:24:43 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CD23C0613CE;
        Mon, 19 Oct 2020 03:24:43 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id d3so12217813wma.4;
        Mon, 19 Oct 2020 03:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=DMW0yCt5PBQfW3WFVdC3B0AANBzYHJJxzkQs00mLzDU=;
        b=LKKgD50zTmIM0cMSAE/AvUDkwu/kdSsZ0L95UgKa3KWLBAjnaSiWy1XHl+SdcRqEV3
         IQE/moIhIeabtBKHMoROAOuKwuPkgmFo0f8fwML+IguoHnBOiuyuv+mQ2N28vq+7hO0z
         1bA/5KGrtkXxRzGVQmzHYNj+YDoAnbUhDK5vTJDwEYvTfrucI1LrYns1/fES2K5VyN48
         YTzw572i9QZEsNGaJMd0/NwKZqNde/TgGQ68LcbQEsJoJUs3bpaReIvTrIRsvloxsORF
         o3Qa9GlsO0fooOT2rs6I6fPRmEpx/Ky7xtBbaa0CqwskxUSg0U2rwHmlbHfuFQNrPxT6
         BwTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DMW0yCt5PBQfW3WFVdC3B0AANBzYHJJxzkQs00mLzDU=;
        b=MKFVDSZckfZYGcxnZOk2j5RhuCFxXsZjAHaWe5oFFKap8RwBOjiJjL9lIFfzslYLut
         /ezJmyega3F2I8lVsTtHv103UnsPf6YXbyG7EsGzA2cZPMMv7FydVEtT0olTHaalJnXA
         0azJgrQuiFE1OzrjKKUO3MiKv/aopHpoiU2kZvZgwaNrwzrBSRFAC83MOFkxyZTY8XHg
         AJZQFr5I1bc2UceHdVKfr4R7h6ZCL3fqWcFHYuTDZjPXF34NDNcFfA2oq/D6hzJ3X0zo
         2RNJeHcI4B9fGgVAbuuJQsgGIrWU3S/NvxieJhDiujF4gqznbYlkRP8wX0hGC5TqJSA6
         x77w==
X-Gm-Message-State: AOAM531dY4yXBQJJAhwtKHw33ireCknPOHLy1ZviX23Gc6wub1MsqFE6
        zEP0CQGCq9qP7I0GRJhAI7o=
X-Google-Smtp-Source: ABdhPJxbSA06zBvEt/c3tORxcj/AmyLbEGYsK6l2y/z5MVdKIojHim9Mbimp5qDS8XKjW333ug8wiw==
X-Received: by 2002:a7b:cc89:: with SMTP id p9mr17644734wma.4.1603103082028;
        Mon, 19 Oct 2020 03:24:42 -0700 (PDT)
Received: from ziggy.stardust ([213.195.119.110])
        by smtp.gmail.com with ESMTPSA id t13sm15863863wmj.15.2020.10.19.03.24.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Oct 2020 03:24:41 -0700 (PDT)
Subject: Re: [PATCH 1/2] dt-bindings: dma: mtk-apdma: add bindings for MT8516
 SOC
To:     Fabien Parent <fparent@baylibre.com>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, dmaengine@vger.kernel.org
Cc:     robh+dt@kernel.org, vkoul@kernel.org, sean.wang@mediatek.com
References: <20201015123315.334919-1-fparent@baylibre.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <9308a487-ed84-6112-d612-a8a777ee0dee@gmail.com>
Date:   Mon, 19 Oct 2020 12:24:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201015123315.334919-1-fparent@baylibre.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 15/10/2020 14:33, Fabien Parent wrote:
> Add bindings to APDMA for MT8516 SoC. MT8516 is compatible with MT6577.
> 
> Signed-off-by: Fabien Parent <fparent@baylibre.com>

Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>

> ---
>   Documentation/devicetree/bindings/dma/mtk-uart-apdma.txt | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/dma/mtk-uart-apdma.txt b/Documentation/devicetree/bindings/dma/mtk-uart-apdma.txt
> index 2117db0ce4f2..fef9c1eeb264 100644
> --- a/Documentation/devicetree/bindings/dma/mtk-uart-apdma.txt
> +++ b/Documentation/devicetree/bindings/dma/mtk-uart-apdma.txt
> @@ -4,6 +4,7 @@ Required properties:
>   - compatible should contain:
>     * "mediatek,mt2712-uart-dma" for MT2712 compatible APDMA
>     * "mediatek,mt6577-uart-dma" for MT6577 and all of the above
> +  * "mediatek,mt8516-uart-dma", "mediatek,mt6577" for MT8516 SoC
>   
>   - reg: The base address of the APDMA register bank.
>   
> 
