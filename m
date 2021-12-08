Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B32A846CCBA
	for <lists+dmaengine@lfdr.de>; Wed,  8 Dec 2021 05:55:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239900AbhLHE6u (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 7 Dec 2021 23:58:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233743AbhLHE6t (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 7 Dec 2021 23:58:49 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60CCDC061574
        for <dmaengine@vger.kernel.org>; Tue,  7 Dec 2021 20:55:18 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id gt5so1100152pjb.1
        for <dmaengine@vger.kernel.org>; Tue, 07 Dec 2021 20:55:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=cNfiJvO3fejBotE5iySezNhtEJJwER74TgDA97YhjHw=;
        b=dFvbWj1YTb2rkTnoh4vumG6c98xkqmedsvStrzVGBcOXL5hS1P5l1JINBDvAe4CWYs
         C56jIevPqd1PVb3iikh9OpUZjBNpFhNIf2ZOp6sBPFhhVkk/Y9HyfWCJKJ7Zxsg+jYgr
         j26v5mM52Dd72VrH2kqFsdsH+aEdxKoaZ3JAo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cNfiJvO3fejBotE5iySezNhtEJJwER74TgDA97YhjHw=;
        b=u8ERxtkxrWx/G4HBI5GB5TFFra6MVu0/4nS/DDxmRhRNdOkD2a51lhCJQ9dfhf2y2Y
         UFuhTMvxIDI3XzkAHw0zxKJe9XFBjs4SXNz8g2Krr90LTWIIbZIfIrZ8GCv6Rgu7VBKs
         9L3BKlsX0CB6LlE+cdllZedi0LkL/DLOysYMe/GWisUvIvAvk1bUDGL6hgakkJLGQ1QX
         PjmZ68hthAaRf4CUYBusHSIMFnf0vDBjcNgROBZz4OwQOOeqY1tmmY5wuCLkR6yXkI92
         c9+gCaElHSKV658M+MIRAJAgYYg4IAxt65fa6Zg82lNVCTFdXhwhf0z8GMPloOPW66Mk
         TnDw==
X-Gm-Message-State: AOAM532NV5HEIxI7vSahKSudcrlKOElG0u9oV8AWJbAqxAcfKcLlob4W
        KAqZ1ENuDD/1tJnhIWSUlXRuzg==
X-Google-Smtp-Source: ABdhPJzS2d4ffr4Pk1pU3l5zZk+LeQbBGpywoHPpAOS/5wf7KsRFrJSCYOl6vgYqGytySqvqn2Y0Gw==
X-Received: by 2002:a17:902:860b:b0:143:87bf:648f with SMTP id f11-20020a170902860b00b0014387bf648fmr56650710plo.11.1638939317886;
        Tue, 07 Dec 2021 20:55:17 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 16sm992605pgu.93.2021.12.07.20.55.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Dec 2021 20:55:17 -0800 (PST)
Date:   Tue, 7 Dec 2021 20:55:16 -0800
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Ludovic Desroches <ludovic.desroches@microchip.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Vinod Koul <vkoul@kernel.org>,
        linux-arm-kernel@lists.infradead.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] dmaengine: at_xdmac: Use struct_size() in
 devm_kzalloc()
Message-ID: <202112072055.3708E99@keescook>
References: <20211208001013.GA62330@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211208001013.GA62330@embeddedor>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Tue, Dec 07, 2021 at 06:10:13PM -0600, Gustavo A. R. Silva wrote:
> Make use of the struct_size() helper instead of an open-coded version, in
> order to avoid any potential type mistakes or integer overflows that, in
> the worst scenario, could lead to heap overflows.
> 
> Link: https://github.com/KSPP/linux/issues/160
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
