Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AFF96A942E
	for <lists+dmaengine@lfdr.de>; Fri,  3 Mar 2023 10:32:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbjCCJci (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 3 Mar 2023 04:32:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjCCJch (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 3 Mar 2023 04:32:37 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE7DA1A5
        for <dmaengine@vger.kernel.org>; Fri,  3 Mar 2023 01:32:36 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id t15so1607753wrz.7
        for <dmaengine@vger.kernel.org>; Fri, 03 Mar 2023 01:32:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1677835955;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7hBXC0lEHBdCxJFz/wvuTM5XuH7NecPstxoPUgvWZ2s=;
        b=SSE+X/7c7/EWnLslcWs47ifdnKBucbfsZnJB0hottynmr4Hth/tXZ+ZEjFw3klk3oM
         sjTML44wafkHpumaiksmrBmrkUQLThpTy7Kx9QN+gdamXckb3kQR67CEYlsRdz9BXdld
         i6u/y8DoDAkUbdRvTsPM2FoV3UfMXbYz9KJkj1g2LKVObmJBYOtqDowHPVEg1rI8kdpK
         tPqEy/cFSf2Litt5kQggaJc128Fp0T4QFSP+MGFNlCt2zABPuCRPXhNxdcvhiLHNP1oj
         jBa9q7rLaC2UsSDriM/KvUM25nC3xaQxkLygZIXlCEArVEy0/ShgEXPan+61TyEwHRDi
         p2gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677835955;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7hBXC0lEHBdCxJFz/wvuTM5XuH7NecPstxoPUgvWZ2s=;
        b=A+EousmTip+wBqJyIRHtN7kGi1FGJrjGKvvzGx2MC8RuW4eVax2mMMlAg8IeTJBuDa
         PbYNAr9nXKR68mtMixtwjl1Ya+SXi9JOA4qj75AWLM5ApfPmJbGAxD6dt3E+TciBekUd
         mqM31Q8wdWuYNejV6ykUZfNmdjZB2H650UHd9d1K1brLCjevi/8ZgECAQt1aydbdLPhc
         3Yl4vNxY1skadVf8HqKEBhQLWCOqYOvqFvmsmHOz+abV0COP3YAegjy/TSiks+ZJwfSX
         ATZNRHK0zRlcCv9cvFePLQ3RRIwhnONTcksUj+tDESH1PCu95Mr0E3azlb2/TxF41KFz
         0IMA==
X-Gm-Message-State: AO0yUKUxn8NdTysAG2vXUDpl0qArzTDBt2/XsexjCEkx+PZ1tStejSK2
        LSGMapPvFkvWMzjoV4cjl19nDw==
X-Google-Smtp-Source: AK7set/JHlPkIR9MppkbXv5Ijhh5ttzcjun38qIQ2R+eSHmP8pbzOViSvPR3v5zMY1JfvJlm6rBqCw==
X-Received: by 2002:a5d:6512:0:b0:2c6:85ef:4086 with SMTP id x18-20020a5d6512000000b002c685ef4086mr841564wru.32.1677835955377;
        Fri, 03 Mar 2023 01:32:35 -0800 (PST)
Received: from myrica (054592b0.skybroadband.com. [5.69.146.176])
        by smtp.gmail.com with ESMTPSA id k5-20020adfe8c5000000b002c56179d39esm1671455wrn.44.2023.03.03.01.32.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Mar 2023 01:32:34 -0800 (PST)
Date:   Fri, 3 Mar 2023 09:32:35 +0000
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     Baolu Lu <baolu.lu@linux.intel.com>
Cc:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux.dev,
        Jason Gunthorpe <jgg@nvidia.com>,
        Joerg Roedel <joro@8bytes.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        X86 Kernel <x86@kernel.org>, bp@alien8.de,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>, corbet@lwn.net,
        vkoul@kernel.org, dmaengine@vger.kernel.org,
        linux-doc@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will@kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Raj Ashok <ashok.raj@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH v4 3/6] iommu/sva: Stop using ioasid_set for SVA
Message-ID: <20230303093235.GB361458@myrica>
References: <20230301235646.2692846-1-jacob.jun.pan@linux.intel.com>
 <20230301235646.2692846-4-jacob.jun.pan@linux.intel.com>
 <3b7fb4d3-1fe9-a3be-46ad-c271be9f96c7@linux.intel.com>
 <20230302091707.58d59964@jacob-builder>
 <794c7dad-2e62-3afa-ea10-92179b0d1659@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <794c7dad-2e62-3afa-ea10-92179b0d1659@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Fri, Mar 03, 2023 at 10:24:42AM +0800, Baolu Lu wrote:
> > > > -int iommu_sva_alloc_pasid(struct mm_struct *mm, ioasid_t min, ioasid_t
> > > > max) +static int iommu_sva_alloc_pasid(struct mm_struct *mm, ioasid_t
> > > > min, ioasid_t max) {
> > > > -	int ret = 0;
> > > > -	ioasid_t pasid;
> > > > +	int ret;
> > > > -	if (min == INVALID_IOASID || max == INVALID_IOASID ||
> > > > +	if (min == IOMMU_PASID_INVALID || max == IOMMU_PASID_INVALID ||
> > > >    	    min == 0 || max < min)
> > > 
> > > It's irrelevant to this patch. Just out of curiosity, why do we need to
> > > exclude PASID 0 here? I just had a quick look at PCI spec section 6.20.
> > > The spec does not state that PASID 0 is invalid.
> > > 
> > my understanding is that ARM reserves PASID0, unlike VT-d where RID_PASID
> > is programmable.

It does, but that's specific to the IOMMU driver so we shouldn't check it
here.

> I suppose the common thing is reserving some kind of special PASIDs.

Are you planning to use RID_PASID != 0 in VT-d?  Otherwise we could just
communicate min_pasid from the IOMMU driver the same way we do max_pasid.

Otherwise I guess re-introduce a lighter ioasid_alloc() that the IOMMU
driver calls to reserve PASID0/RID_PASID.

Thanks,
Jean

