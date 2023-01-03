Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 506C065C54B
	for <lists+dmaengine@lfdr.de>; Tue,  3 Jan 2023 18:45:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230373AbjACRpg (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 3 Jan 2023 12:45:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230022AbjACRpe (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 3 Jan 2023 12:45:34 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7D9CC4A
        for <dmaengine@vger.kernel.org>; Tue,  3 Jan 2023 09:45:33 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id d4so22378318wrw.6
        for <dmaengine@vger.kernel.org>; Tue, 03 Jan 2023 09:45:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aWorniJ/fZrmchxeIYy/25/fnoIcc5YDmNnsRFvI5QM=;
        b=LHcGugh+WoE09WADK0yp4IoxnsyN8yUNqKwVPNs0pu1/7XejqLIdmtYwr+M+ivIr5s
         Om3LNIfuztLskZ1z8PT63KrLH0mL8GDL0V7T/clHfMyia1bbEteMt3oZ7JsUEAxmn6uy
         2MDgesfs32DecMoaYghrAgOJYuL/L3VRv/mNAnylWkTRc/1Uw7zuWyW5ZPMHMnLSg79E
         2cJ8amob8/W+9VlbALa6aYR1KDwn68ua/dwYmv1GQthawrHHq6ZZ5xuh+pJkm8yK/2ob
         JS6+UFd6wH/PDTo2f8+2rVQLaAXUAfGDlj8iHlddCGVUxwAxheR9MKUESs9JZvz/uMcK
         8uHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aWorniJ/fZrmchxeIYy/25/fnoIcc5YDmNnsRFvI5QM=;
        b=pY3/O3jHrrY+MlDVC08vqyqLqL7YLN3L3mDCXHBNfHWdkoii1hfFdrKz/fUJ5INA0j
         DoCw4FwhjtGYXpBao+D7M1l1nQUUuF+kOBa/duCOViTAHiyHnrLIroMrrleGS6HTRX36
         /BDRVQ5pU81dR3rQHd/+xD2V+8W8b1SLqtWXmqGlBO18jHfJ+0kwU7JlvyT4fTnu0N6B
         HmjJUwCbJDTAyEd3ltujhTq14t2oR5JC8aEERfZ1jF2hz+F3Sr8pemjZrYS/W0j6qFYp
         WEEzhOa8204AwHcNFESdayNK8b0yAdxpWhn7vUuBkPxiAK0/wF9C53oAxbagXi//NN4l
         xW0w==
X-Gm-Message-State: AFqh2krGnY8CSxiwtoYndnUlorvPjfiGgx9BoEu7IgYi/n0281N5Yu8G
        jHSjpz+Bv10Naw60bsyg7CY=
X-Google-Smtp-Source: AMrXdXtZWSWW7441X12DeFasW4zh4Bz8D/keQ2oYwHzLvN5LeahZoA2hyRcksMRnDG3jjIPp4Vk0VQ==
X-Received: by 2002:a5d:4e83:0:b0:29f:b589:157c with SMTP id e3-20020a5d4e83000000b0029fb589157cmr1734093wru.5.1672767932309;
        Tue, 03 Jan 2023 09:45:32 -0800 (PST)
Received: from localhost (host81-157-153-247.range81-157.btcentralplus.com. [81.157.153.247])
        by smtp.gmail.com with ESMTPSA id f13-20020a5d4dcd000000b0023659925b2asm31767946wru.51.2023.01.03.09.45.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jan 2023 09:45:31 -0800 (PST)
Date:   Tue, 3 Jan 2023 17:45:30 +0000
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     Fenghua Yu <fenghua.yu@intel.com>
Cc:     Vinod Koul <vkoul@kernel.org>, Dave Jiang <dave.jiang@intel.com>,
        dmaengine@vger.kernel.org, Tony Zhu <tony.zhu@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 09/17] mm: export access_remote_vm() symbol
Message-ID: <Y7RpuqbTAM11wVQG@lucifer>
References: <20230103163505.1569356-1-fenghua.yu@intel.com>
 <20230103163505.1569356-10-fenghua.yu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230103163505.1569356-10-fenghua.yu@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Tue, Jan 03, 2023 at 08:34:57AM -0800, Fenghua Yu wrote:
> From: Dave Jiang <dave.jiang@intel.com>
>
> Export access_remote_vm() symbol for driver usage. The idxd driver would
> like to use it to write the user's completion record that the hardware
> device is not able to write to due to user page fault.
>
> Tested-by: Tony Zhu <tony.zhu@intel.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> Co-developed-by: Fenghua Yu <fenghua.yu@intel.com>
> Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: linux-mm@kvack.org
> ---
>  mm/memory.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/mm/memory.c b/mm/memory.c
> index aad226daf41b..caae4deff987 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -5579,6 +5579,7 @@ int access_remote_vm(struct mm_struct *mm, unsigned long addr,
>  {
>  	return __access_remote_vm(mm, addr, buf, len, gup_flags);
>  }
> +EXPORT_SYMBOL_GPL(access_remote_vm);
>
>  /*
>   * Access another process' address space.
> --
> 2.32.0
>

Can you explain what use case you have for exporting this? Currently this is
only used by procfs.

Additionally, it relies on a reference count being held on the mm which seems a
little risky exposing to a driver.

Is there a reason you can't use access_process_vm() which is exported and
additionally handles the refrencing?
