Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 65D2191EF5
	for <lists+dmaengine@lfdr.de>; Mon, 19 Aug 2019 10:32:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726028AbfHSIcv (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 19 Aug 2019 04:32:51 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:42242 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725768AbfHSIcv (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 19 Aug 2019 04:32:51 -0400
Received: by mail-pf1-f195.google.com with SMTP id i30so750649pfk.9
        for <dmaengine@vger.kernel.org>; Mon, 19 Aug 2019 01:32:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=uARhKEzG4ofma95ThgOeac2D+K+kULDUSqyPUZQ6ZPQ=;
        b=h8nP3bLAjTtIY9+R7vtWilcEG8+7ItaYDC/xNSATQ0FCq2TsrwfbEznldaPO/mGm/T
         4yylBKDReKXq1Kc8o+YsQpqrpEJ/JyrkTxtqA01oO9/MKYGos4YNJzW8LFP6AwEV9QpY
         gKsi0A8kaNmnZsI+0Macg0q7hG8whY+9tCk3AgPs9z/GBddxGrKclGoV4raeWRLDbElw
         9fTwa6i40Bu/uQ9L+rReYDN+c6CKTVe6wxcEXNREWRPKqwnssco4Jx/WQyp/Ksd8Chn1
         H1BD9spt0+eEtjkZLPdzxRpbQ4NwHYoZ8vW1hyn8Kq0LJt63DUP++hcmkBpNcGF/Y1mI
         kyAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uARhKEzG4ofma95ThgOeac2D+K+kULDUSqyPUZQ6ZPQ=;
        b=dKJF9w43uOcMSK6CV6cqmG6yGSUYA0mUJdGboylSus/GcvCYdjFErycFY5hphCQ8sl
         yvl1YAn++ZkztlhoRjLcI/bKrWX+WrCef46/id6c1yAikbIXVA1eUIr5IDhq98ZO5ZiH
         ppKW2WCTUbrgbjB9/e5jcbVJVLMlaKXeq6jmPhzRmCyLsFJEqJouaIdifVjlgZ50WqxG
         pUX4TYf4eyT9WATEGFUbcINoufiPbsZ9x2unP+R1x6bQCLfSJ3/iS6Lh/dlBhQGp15cO
         4fclITspvafmAIOOIgF70wCVggU8q/kF6pD3pRYWOtC9rgOg2YTaEwI0LJNEI6GP560G
         xFaw==
X-Gm-Message-State: APjAAAVjfx5ivmk3rh2HbqNFOikvtH06LcbaLJZ2Hu3Mlj6jTVQkR7hD
        aLwdYIep5jglDuZdMOTX0VlLYo819Fk=
X-Google-Smtp-Source: APXvYqzVS65fpxucSWTz4NtGC6rci70lJ0zLwCvYsmTGsfDINzhmYVwFIC1z/ErMUlmDxouHTGRO2w==
X-Received: by 2002:a63:e148:: with SMTP id h8mr9698976pgk.275.1566203570600;
        Mon, 19 Aug 2019 01:32:50 -0700 (PDT)
Received: from localhost ([122.172.76.219])
        by smtp.gmail.com with ESMTPSA id f205sm24103049pfa.161.2019.08.19.01.32.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Aug 2019 01:32:49 -0700 (PDT)
Date:   Mon, 19 Aug 2019 14:02:47 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc:     dmaengine@vger.kernel.org, Viresh Kumar <vireshk@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Vinod Koul <vkoul@kernel.org>
Subject: Re: [PATCH] dmaengine: dw: Update Intel Elkhart Lake Service Engine
 acronym
Message-ID: <20190819083247.573ficqi4x6ufs3t@vireshk-i7>
References: <20190813080602.15376-1-jarkko.nikula@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190813080602.15376-1-jarkko.nikula@linux.intel.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 13-08-19, 11:06, Jarkko Nikula wrote:
> Intel Elkhart Lake Offload Service Engine (OSE) will be called as
> Intel(R) Programmable Services Engine (Intel(R) PSE) in documentation.
> 
> Update the comment here accordingly.
> 
> Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
> ---
>  drivers/dma/dw/pci.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
