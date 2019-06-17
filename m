Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F080547837
	for <lists+dmaengine@lfdr.de>; Mon, 17 Jun 2019 04:41:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727481AbfFQClA (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 16 Jun 2019 22:41:00 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:40081 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727441AbfFQClA (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 16 Jun 2019 22:41:00 -0400
Received: by mail-pl1-f193.google.com with SMTP id a93so3445909pla.7
        for <dmaengine@vger.kernel.org>; Sun, 16 Jun 2019 19:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZhlWmaxgyk+z+8zQVlW3ttdca6W9Kdcj22VoxwWwPLY=;
        b=nLCr9y80vvdxcLW8jihgueFMAxrNMgngcE+01wB6BhpFdSo96ApBYok9wGRqwqdy9w
         5G8dfjcrq5L16/WanKQZCLQ3LlhVCOlo6ybHJMFP2s41oIWk+tba/dv8cC1AmCzgYFg6
         zCY7GUCNbrALWAwToMCRVDLGuGpw0kazjwgmzPKEaq/soo5UozURXciWP+K8PJOett3X
         eXD6e67W9sb2aRPHG8LTdT+FDIdyyRBV9TNSPDB+AKtVyG4ZYP+D0NeE3+XDpc0WD1m/
         2fP0tn6LTQES9Q3dv4hs/TL7nQP5BnR2kAQ6BpHWQ4nywua6rFXPOBcS+A2RyhFtbLc3
         B3Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZhlWmaxgyk+z+8zQVlW3ttdca6W9Kdcj22VoxwWwPLY=;
        b=Akg/bB3H1r5A0HSjCnItip+EhDampNf8iHfPEMqeclrG7X/E2PQZYlVKJCU5kH+uGL
         /GvvkTpadcAsI3s4fFnhMrGeloYqi6KtoiZBNTPLbAh8PuQwT5TUfKLCNakgxxnshOdz
         44kzwOJBeW83AMOJEOfTA3YppI6KNqZQPFZxOTYYsX+/2Sb62Xc3Z12m+P89h+Kv/oqD
         POjxo41eIgDXaeUD7qtE2vuSBMIhASkvnQxJB7ikBJun/uWGMBVUMxyZR51ugnNrktsc
         08Pv+qxcIUwjo/Y9u65kg7Vuw07/mCGhg68Whew7UhcOYeBUQvxWdFwKMBweSj6eVNNO
         wv0A==
X-Gm-Message-State: APjAAAWeN67PevKX9hf/O4+r5WaRivxjXWR7LFsy49mKo3z7BCEsgAxk
        i1NG3oM1uciB8bgfIQr/NVIqWg==
X-Google-Smtp-Source: APXvYqxrqPa9KaymDRTpEmnfckswarfbUrbcVJhBmCN07v3smKlOk/+fDJXjNdehBmT6VyGCgaGG+A==
X-Received: by 2002:a17:902:b18f:: with SMTP id s15mr108577820plr.44.1560739259291;
        Sun, 16 Jun 2019 19:40:59 -0700 (PDT)
Received: from localhost ([122.172.66.84])
        by smtp.gmail.com with ESMTPSA id 14sm9949151pgp.37.2019.06.16.19.40.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 16 Jun 2019 19:40:57 -0700 (PDT)
Date:   Mon, 17 Jun 2019 08:10:47 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Viresh Kumar <vireshk@kernel.org>, dmaengine@vger.kernel.org,
        Dan Williams <dan.j.williams@intel.com>,
        Vinod Koul <vkoul@kernel.org>
Subject: Re: [PATCH v1] dmaengine: dw: Distinguish ->remove() between DW and
 iDMA 32-bit
Message-ID: <20190617024047.taidnac4y2l3zdeh@vireshk-i7>
References: <20190614110604.25375-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190614110604.25375-1-andriy.shevchenko@linux.intel.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 14-06-19, 14:06, Andy Shevchenko wrote:
> In the same way as done for ->probe(), call ->remove() based on
> the type of the hardware.
> 
> While it works now due to equivalency of the two removal functions,
> it might be changed in the future.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/dma/dw/pci.c | 28 ++++++++++++++++++++--------
>  1 file changed, 20 insertions(+), 8 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
