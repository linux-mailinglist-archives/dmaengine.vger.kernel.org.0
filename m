Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 802352B23D2
	for <lists+dmaengine@lfdr.de>; Fri, 13 Nov 2020 19:34:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726113AbgKMSd7 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 13 Nov 2020 13:33:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726081AbgKMSd7 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 13 Nov 2020 13:33:59 -0500
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C06F3C0613D1;
        Fri, 13 Nov 2020 10:33:57 -0800 (PST)
Received: by mail-qk1-x743.google.com with SMTP id l2so9727803qkf.0;
        Fri, 13 Nov 2020 10:33:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=tTop0L3WKYeLlzcN6n9MVUWYqI+MjrZ5s3ciISRrjWI=;
        b=rxYBxl6xsCyjd4FwJDuAloDkQzKFN3PNapO7YsvOTsYTOfRewJT0N578wrdbvEGnIl
         dPtIFJBNT0eWCgO0yd32zHNrR6t/KU44IZbBbMpQ6qdgDSCXLp5gZbqfJdl2AvhdPcxL
         2zDHHnkdJHPfXKyWUFXBwqYU408nCDD6Pdq9YnyO7D/RYU26LVW//jodotjavOa9S8ee
         QENFbR/wFm9WZlPz2+ad9bOJNK+tmMsZndWaT1n3JjA8PuekH1ix5kyMM3LNsqDXLGP0
         e0401NJ5p0FAeU40bxu2r2OvSwb6IfWUP/CEKTr+WywQX5KxnBy7pVctATK189g7s1yP
         BZpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tTop0L3WKYeLlzcN6n9MVUWYqI+MjrZ5s3ciISRrjWI=;
        b=coFMs4ob20zjUU25iNNaNLRtFQew77Kh3+WFz+D4i5+gueE2ReAfxGMMNTNsi/9cSN
         voeHOW+t55IErp36ZID1yttrfwG0Z837e26Kn4wVkLPwi+ociWiEKVXq4uvsUDw1XwdA
         JnAe8Vi/I68Nud7Uas7i8AbmjQGe4LmC+nNnL59xCka3pdxJHKONDIw9fFFe6+9/XWRP
         Uul7mN7c7jNYvV3pQnYuH90g66glzdQ2O53PO3v0/Zv6qkhU/+ysEfldRm5wfTxQV2z9
         7/8icOvqPZpQstxGJYEW86ccyqRzhCuckyrvpaXNPseMHJoPSKzvDedNZjzMAoOOS4DW
         doOw==
X-Gm-Message-State: AOAM532msbmjcM9mq7GE6d3TGd/yj8Il2VStzoTBf9GP3ZDy2eRMJbMd
        y4ZwsbKgB9xcM7j9Z00q5Ig=
X-Google-Smtp-Source: ABdhPJyINnvGblcrdNoVnqkFbBeH/EHFF6e90JDj+uK0oZQEjVkWvfmVDHDCapd/swUXQ17YOyYAgg==
X-Received: by 2002:a37:991:: with SMTP id 139mr3306876qkj.185.1605292436793;
        Fri, 13 Nov 2020 10:33:56 -0800 (PST)
Received: from ubuntu-m3-large-x86 ([2604:1380:45f1:1d00::1])
        by smtp.gmail.com with ESMTPSA id q1sm7028411qti.95.2020.11.13.10.33.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2020 10:33:56 -0800 (PST)
Date:   Fri, 13 Nov 2020 11:33:54 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Maciej Sosnowski <maciej.sosnowski@intel.com>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        dmaengine@vger.kernel.org, Tom Rix <trix@redhat.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com,
        kernel-janitors@vger.kernel.org, linux-safety@lists.elisa.tech,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dmaengine: ioatdma: remove unused function missed during
 dma_v2 removal
Message-ID: <20201113183354.GA1435913@ubuntu-m3-large-x86>
References: <20201113081248.26416-1-lukas.bulwahn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201113081248.26416-1-lukas.bulwahn@gmail.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Fri, Nov 13, 2020 at 09:12:48AM +0100, Lukas Bulwahn wrote:
> Commit 7f832645d0e5 ("dmaengine: ioatdma: remove ioatdma v2 registration")
> missed to remove dca2_tag_map_valid() during its removal. Hence, since
> then, dca2_tag_map_valid() is unused and make CC=clang W=1 warns:
> 
>   drivers/dma/ioat/dca.c:44:19:
>     warning: unused function 'dca2_tag_map_valid' [-Wunused-function]
> 
> So, remove this unused function and get rid of a -Wused-function warning.
> 
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>

Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>

> ---
> applies cleanly on current master and next-20201112
> 
> Maciej, please ack.
> 
> Vinod, Dan, please pick this minor non-urgent clean-up patch.
> 
>  drivers/dma/ioat/dca.c | 10 ----------
>  1 file changed, 10 deletions(-)
> 
> diff --git a/drivers/dma/ioat/dca.c b/drivers/dma/ioat/dca.c
> index 0be385587c4c..289c59ed74b9 100644
> --- a/drivers/dma/ioat/dca.c
> +++ b/drivers/dma/ioat/dca.c
> @@ -40,16 +40,6 @@
>  #define DCA2_TAG_MAP_BYTE3 0x82
>  #define DCA2_TAG_MAP_BYTE4 0x82
>  
> -/* verify if tag map matches expected values */
> -static inline int dca2_tag_map_valid(u8 *tag_map)
> -{
> -	return ((tag_map[0] == DCA2_TAG_MAP_BYTE0) &&
> -		(tag_map[1] == DCA2_TAG_MAP_BYTE1) &&
> -		(tag_map[2] == DCA2_TAG_MAP_BYTE2) &&
> -		(tag_map[3] == DCA2_TAG_MAP_BYTE3) &&
> -		(tag_map[4] == DCA2_TAG_MAP_BYTE4));
> -}
> -
>  /*
>   * "Legacy" DCA systems do not implement the DCA register set in the
>   * I/OAT device.  Software needs direct support for their tag mappings.
> -- 
> 2.17.1
> 
