Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A5230A583D
	for <lists+dmaengine@lfdr.de>; Mon,  2 Sep 2019 15:42:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729823AbfIBNkj (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 2 Sep 2019 09:40:39 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:33714 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730221AbfIBNis (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 2 Sep 2019 09:38:48 -0400
Received: by mail-wm1-f67.google.com with SMTP id r17so11990513wme.0;
        Mon, 02 Sep 2019 06:38:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:subject:references
         :in-reply-to:cc:cc:to;
        bh=TpRHrWDk+BKtVt16BeWPVl2Sj4S7ymxrqVbVJgDIHmM=;
        b=F4yhXb0UbAicyQ1qM5Aed/kzyZxzIuLsOS9zrfsvM3g1+YTEvgL1mWWSUWHmfEDT8j
         h0klIJQmWSGzthSc0iRj2FilHodzh8GG8oeWeV6e29EU4xFl55kFT0rsnQLbFxKOrmrA
         csEFgTGJljBMwREVJ3XrfEDuLkZYawy1LA/103JzZS5pwX+9/VvHA62yGkn5nYmi/Kmp
         jaY31gpeYsdh1Z/Qs54C/YtyZbNp247KGrzxsGxyy9wlHGMl9M/M3WaZshHoAW2nkirF
         bFYDSHA+rTYfRn8jkVrhrIxE1sor83ICWng5HATrFeqOWOeGwk5QZt8bf0XpbVPSz3c0
         TdAA==
X-Gm-Message-State: APjAAAWT2DNpgSJIASTqAS2HHyiDGMnN31ch8XPNR1WSzWQ5S1ZrtxZS
        yeJI330H0O0lyaafdLhjBI+OgBFIlA==
X-Google-Smtp-Source: APXvYqx0IbfQx421rMxJRsliJiRNSgfS7S13d8uiiggmXY+SbLRC8+XkevIKmxeykpo9JQltTt3UOw==
X-Received: by 2002:a7b:c216:: with SMTP id x22mr36357141wmi.19.1567431525970;
        Mon, 02 Sep 2019 06:38:45 -0700 (PDT)
Received: from localhost ([212.187.182.166])
        by smtp.gmail.com with ESMTPSA id n2sm9271782wro.52.2019.09.02.06.38.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2019 06:38:45 -0700 (PDT)
Message-ID: <5d6d1b65.1c69fb81.735c8.5363@mx.google.com>
Date:   Mon, 02 Sep 2019 14:38:44 +0100
From:   Rob Herring <robh@kernel.org>
Subject: Re: [PATCH] dt-bindings: dmaengine: dma-common: Fix the dma-channel-mask property
References: <1566988223-14657-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
In-Reply-To: <1566988223-14657-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
Cc:     vkoul@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Wed, 28 Aug 2019 19:30:23 +0900, Yoshihiro Shimoda wrote:
> The commit b37e3534ac42 ("dt-bindings: dmaengine: Add YAML schemas
> for the generic DMA bindings") changed the property from
> dma-channel-mask to dma-channel-masks. So, this patch fixes it.
> 
> Fixes: b37e3534ac42 ("dt-bindings: dmaengine: Add YAML schemas for the generic DMA bindings")
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  Changes from v1:
>  - s/Revise/Fix/ in the subject and s/revises/fixes/ the commit log.
>  https://patchwork.kernel.org/patch/11117885/
> 
>  Documentation/devicetree/bindings/dma/dma-common.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>

