Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 497E1221141
	for <lists+dmaengine@lfdr.de>; Wed, 15 Jul 2020 17:37:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725907AbgGOPh3 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 15 Jul 2020 11:37:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725861AbgGOPh3 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 15 Jul 2020 11:37:29 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D917AC08C5DB
        for <dmaengine@vger.kernel.org>; Wed, 15 Jul 2020 08:37:28 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id f18so6255857wml.3
        for <dmaengine@vger.kernel.org>; Wed, 15 Jul 2020 08:37:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=2Je4T8z/w322fxOUCkiwVBCB1R8T4g7KUgJ9ivXdC54=;
        b=mV2pcg1F1aIcUk+DLzQEo+MAWNQ+9PrKfD0mHv/xMs+Zo3xFO7vnIzCL2hx3luthr9
         E19+CaAT6rzLFbghnD1ivXmqYl00TBVPWlUCNVzNzqyEJ0OhdLAz57AHmXwmAYgYQulz
         yKH++yAHrFj2LNcT+D/wGA9BbLXjODS3ipwCSqZxfoNy95RGooNgSkRMmHk4zCZXj2MH
         MI7pA8lUosPGjIw6voiU/tjOj1LqD8tULchQBDWmI8x1kiz/FIHp0ZGR9eCWUd5bp9ow
         LJSV6ApJuAXQRzIZHkxfmL5WAh21DPvwdKG3pDxSntkZ7drWyoWmRteWcQ4Sk9oDO/Lp
         CKvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=2Je4T8z/w322fxOUCkiwVBCB1R8T4g7KUgJ9ivXdC54=;
        b=BlH52563eXIOsBUEiA6bPpwDMtpxlC/Y42ZYeh/5BjV4IlHihr3r4HFKMrGXgX3H0I
         WQPP/pZS+9bZtdRjNA4ksvH1AIR3IIArnxTIamDUgvNjwivsoE3HXQ53e7URUgsuo6QT
         7kfShph0L/IiHDNz183IabHVLQtQIB6Puj6l1Us26movHEJxr50HJNrVRqfYCvgVebn2
         4f+WgLWVnNKopBtKIG8nEro7O09tYX7gKo4gF5bK9aOCWT3vNvIwagk3Ony8/x5iur9a
         /kkEpmhKeIivI6a1SsvOnEoJuhxf0jqJqWexWkOdVntBB5w9jSoNswtjTFRPc0Ea6FJ8
         nw1A==
X-Gm-Message-State: AOAM5322Ug6rom1+OQAxrDZLxA8bVo2aWcNQr9DxZps/x96MIVPd58ln
        kHHqI0VM7NBzv7Az/A1/ctwH+g==
X-Google-Smtp-Source: ABdhPJwFsRC9h0/qpemmdCtzkg1WNsyzY0pDmoXoAcVsFn3mA3VMdNn/N97b8wMFmFHTu+Eh1VAQsg==
X-Received: by 2002:a1c:3dc3:: with SMTP id k186mr95213wma.66.1594827447500;
        Wed, 15 Jul 2020 08:37:27 -0700 (PDT)
Received: from dell ([2.31.163.61])
        by smtp.gmail.com with ESMTPSA id r1sm4073872wrt.73.2020.07.15.08.37.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2020 08:37:26 -0700 (PDT)
Date:   Wed, 15 Jul 2020 16:37:25 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     dan.j.williams@intel.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org
Subject: Re: [PATCH 00/17] Rid W=1 warnings in DMA
Message-ID: <20200715153725.GJ3165313@dell>
References: <20200714111546.1755231-1-lee.jones@linaro.org>
 <20200715152923.GB52592@vkoul-mobl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200715152923.GB52592@vkoul-mobl>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Wed, 15 Jul 2020, Vinod Koul wrote:

> Hi Lee,
> 
> On 14-07-20, 12:15, Lee Jones wrote:
> > This set is part of a larger effort attempting to clean-up W=1
> > kernel builds, which are currently overwhelmingly riddled with
> > niggly little warnings.
> > 
> > After these patches are applied, the build system no longer
> > complains about any W=0 nor W=1 level warnings in drivers/dma.
> > 
> > Hurrah!
> 
> Yes indeed, thanks for fixing these up. I have changed the subsystem
> name to dmaengine: and applied all

Much obliged.  Thank you Vinod.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
