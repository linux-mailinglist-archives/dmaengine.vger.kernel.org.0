Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9898C21511F
	for <lists+dmaengine@lfdr.de>; Mon,  6 Jul 2020 04:14:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728591AbgGFCOm (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 5 Jul 2020 22:14:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728579AbgGFCOm (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 5 Jul 2020 22:14:42 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EEA4C061794
        for <dmaengine@vger.kernel.org>; Sun,  5 Jul 2020 19:14:42 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id k4so562067pld.12
        for <dmaengine@vger.kernel.org>; Sun, 05 Jul 2020 19:14:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=oLTQP4cUCuEsMBI82hi/oQxEN4jd8ZtJRuhidca0ZB0=;
        b=i7fzIayRESckHSUc+DK0nM1GF3b6hq12XHg4W7Q/ks/ZQ1ANRariJwQMImF0jWjJe9
         740apl/Q5IJAvUMQ6SoJz4AaPDjm03F/711W5uWC+jNqeRN9SwmYTVPSbNFYCtnFLwJU
         k9JP1zTRkaZMbjpz+W9D/9mEECjpgh3wjaJXg/GUhd0BAqANlGlmq0qKoEUDPvgbOvJ2
         qy87doAAlgUxrqJh5khjUmgA7r5RBbyCyqTPCsN9TJfcWgG14psToLJ6kpbf7wBgalRY
         l+mm1w/HhItUGoOy9zCO8VXJ+v3/4u1sK7tqsdhoQItVxkYS63jbEm0uLXuTkvjuvxhB
         2RVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=oLTQP4cUCuEsMBI82hi/oQxEN4jd8ZtJRuhidca0ZB0=;
        b=itliwLOIUXs1i6iFW/zBmYhL3KaRgaIJuG459I11HW8TiGr7uKga1zNFA3u8AvQugo
         QxqsxaUii0T+hALR2imCfeRB19GqYxzsTIF2cIoPHiGG4tHYQPDlE6HpfJn9P2ouMrQk
         z1zJccZmS6P3lO5mAmIxVtGPv8eoKZyG4tjPpei+NoMYcgjPCwz8yhS+6XPwjoOkLcV+
         iCw/a07aDK92nap5ySzwAqDFNAi138Ix7Ccvw8tdd8ypQUY8Ao13ZRWGVDArywUHEJGu
         R9DPTRv3DzeOxhrlaGUiEVFJLWoLf+C/BSODSdE1t1dpv58vLWfpunsDxbA7ZIWL9l/V
         zGZQ==
X-Gm-Message-State: AOAM5309M3WivvbGfkq35DTOeJnpAWQufuNc2fnR0D5gc+U7o96OZtkR
        b4Y40fQ9i6FNrtS5ELnQCkVznQ==
X-Google-Smtp-Source: ABdhPJy5c1MEqfFkRrsXN7sSMwIPzQ2CsCSHXuYckncz/LyQHXpP+A6v8rkv90lLrAuMHIFWK7MkSQ==
X-Received: by 2002:a17:90b:4d10:: with SMTP id mw16mr49011738pjb.143.1594001681860;
        Sun, 05 Jul 2020 19:14:41 -0700 (PDT)
Received: from localhost ([122.172.40.201])
        by smtp.gmail.com with ESMTPSA id b21sm17672431pfp.172.2020.07.05.19.14.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 05 Jul 2020 19:14:40 -0700 (PDT)
Date:   Mon, 6 Jul 2020 07:44:38 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Viresh Kumar <vireshk@kernel.org>, dmaengine@vger.kernel.org,
        Vinod Koul <vkoul@kernel.org>,
        Tsuchiya Yuto <kitakar@gmail.com>
Subject: Re: [PATCH v1] dmaengine: dw: Initialize channel before each transfer
Message-ID: <20200706021438.vdlb6pqgxjb3hht4@vireshk-i7>
References: <20200705115620.51929-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200705115620.51929-1-andriy.shevchenko@linux.intel.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 05-07-20, 14:56, Andy Shevchenko wrote:
> In some cases DMA can be used only with a consumer which does runtime power
> management and on the platforms, that have DMA auto power gating logic
> (see comments in the drivers/acpi/acpi_lpss.c), may result in DMA losing
> its context. Simple mitigation of this issue is to initialize channel
> each time the consumer initiates a transfer.
> 
> Fixes: cfdf5b6cc598 ("dw_dmac: add support for Lynxpoint DMA controllers")
> BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=206403
> Reported-by: Tsuchiya Yuto <kitakar@gmail.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/dma/dw/core.c | 12 ------------
>  1 file changed, 12 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
