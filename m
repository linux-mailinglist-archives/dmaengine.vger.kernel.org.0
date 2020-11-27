Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AF332C611B
	for <lists+dmaengine@lfdr.de>; Fri, 27 Nov 2020 09:47:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729045AbgK0Iqj (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 27 Nov 2020 03:46:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728965AbgK0Iqi (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 27 Nov 2020 03:46:38 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91D3CC0613D1;
        Fri, 27 Nov 2020 00:46:38 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id u10so1231465wmm.0;
        Fri, 27 Nov 2020 00:46:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=dteSsltsDU7xAS3rAuXjux0r1sR5UkBdeacC7b6kchY=;
        b=COyIxDdugmKMcB43JOkCzjpRaHtZoJu7EYxxlLRQwh4JEGiSJ4h9uJF6Sva64iKi62
         SxmHtJYmsmGfXrZGQ84Sq1jVY4f0t1BPKVwQYFpa8/IbK1pKg2TYu/kyLKUkrCO14RDU
         a0vi6L9bCs+BhJh6N31uXzFumqaik6gXg6acKCvUrAEQ6lPYsfMTv/i9D7K9j4Fwtc9a
         xRQvXan7+TefaxvzVxB/z8L4Hs29f/9DUlESQRrU/RSn+/Y4ZGixXYqKr+4/eZABRfNN
         xmiJBpfaa3EiWAWrKS/SlUkNygwHWmHeZyXpfmAM/kvxHCdKIYobC1fZgI/Vr5jBotS6
         sTig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dteSsltsDU7xAS3rAuXjux0r1sR5UkBdeacC7b6kchY=;
        b=MoNMsEt1BZfcVfsUnWibkGeHpNDEIHrr0AvliN6GxO3RqSBUGuWF5un4RcaBFDaN7Y
         j2kaknYFk4r/JtX7GUjUBzn39FHJei0L/jeV2SIrVRYw65V5ShPFAPhZdKlNe6U73aKO
         nl8tH7MSiSLt8L1yRDtLVVh/nq6rlkXtuI3GJNTxnoZqRNhqacgOv86JVc3PHk2kVdLk
         k/DapyAL6tGm7zpmGj/XvkTHnnV7ii3fKkxVA/yv/xQGhiq/QvFhga3HhaABIfAjNa/f
         V82EKjKOU1WN1vowxoaYnDubIXjecWiL1qT/HyeyUV3k1zv+zzddoMaX+D1PupYCo5n0
         ok7Q==
X-Gm-Message-State: AOAM5330wsJ1Q5itKLmD4nV4eUjHpngYhEkrLDQIvBxVpIoV+L+xbTno
        4V2FoPPGxpBaW7YuJBh+oQLJBMu/e+8axA==
X-Google-Smtp-Source: ABdhPJxYqiJaw43WZKooJ2W4WZivbk/XwYkCOjkMwWPpnfYalcHw8FEoQ3XLx8Tv55clh2xygtpScg==
X-Received: by 2002:a7b:c744:: with SMTP id w4mr7851464wmk.0.1606466797131;
        Fri, 27 Nov 2020 00:46:37 -0800 (PST)
Received: from ziggy.stardust ([213.195.126.134])
        by smtp.gmail.com with ESMTPSA id d17sm12870714wro.62.2020.11.27.00.46.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Nov 2020 00:46:36 -0800 (PST)
Subject: Re: [PATCH 1/2] dt-bindings: dma: mtk-apdma: add bindings for MT8516
 SOC
To:     Rob Herring <robh@kernel.org>, Fabien Parent <fparent@baylibre.com>
Cc:     linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org, sean.wang@mediatek.com,
        dmaengine@vger.kernel.org, linux-mediatek@lists.infradead.org,
        vkoul@kernel.org, devicetree@vger.kernel.org
References: <20201015123315.334919-1-fparent@baylibre.com>
 <20201019211634.GA3616126@bogus>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <4e7974e6-fd47-f1e6-9bf4-bd9762033c2d@gmail.com>
Date:   Fri, 27 Nov 2020 09:46:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201019211634.GA3616126@bogus>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Vinod,

On 19/10/2020 23:16, Rob Herring wrote:
> On Thu, 15 Oct 2020 14:33:14 +0200, Fabien Parent wrote:
>> Add bindings to APDMA for MT8516 SoC. MT8516 is compatible with MT6577.
>>
>> Signed-off-by: Fabien Parent <fparent@baylibre.com>
>> ---
>>   Documentation/devicetree/bindings/dma/mtk-uart-apdma.txt | 1 +
>>   1 file changed, 1 insertion(+)
>>
> 
> Acked-by: Rob Herring <robh@kernel.org>
> 

Will you take this patch through your tree or do you prefer that I take it.

Regards,
Matthias
