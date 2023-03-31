Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 707E76D1946
	for <lists+dmaengine@lfdr.de>; Fri, 31 Mar 2023 10:04:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230088AbjCaIEZ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 31 Mar 2023 04:04:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230241AbjCaIEY (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 31 Mar 2023 04:04:24 -0400
Received: from mail.8bytes.org (mail.8bytes.org [IPv6:2a01:238:42d9:3f00:e505:6202:4f0c:f051])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8E6FBB3;
        Fri, 31 Mar 2023 01:04:22 -0700 (PDT)
Received: from 8bytes.org (p200300c27714bc0086ad4f9d2505dd0d.dip0.t-ipconnect.de [IPv6:2003:c2:7714:bc00:86ad:4f9d:2505:dd0d])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.8bytes.org (Postfix) with ESMTPSA id 979B2244EFC;
        Fri, 31 Mar 2023 10:04:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
        s=default; t=1680249862;
        bh=HKuAz+OWW9VEt2t7NKMKxONe9g7YVlslkvijGOC1asY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=X53uRYWsb+cYybQx2wW/GhVyHv7wxhdIlk2tX5m9qytw5uGke4L3co2Pni7p1wyIt
         ezwt1RMTNu5vI65Bt1fRGIiAhZAMcVJtdwxuGFGDR+gEfq208FOklO1FZuSdNDMD6n
         IaoODUCbIu3izY9iyj93WECglXL6Tlbf20E3QTQMfjvBKk4b80l7MdD/LXD/s5A5gb
         E10M3u4jdlgdbS+QzCkd5GFcGpdojqIrUJD8X2z4oEFcR0lPL/qE5jYGsqAIa0nKvi
         2wYdklh/BEkqcVZKY7AYKArsriqYyyWnkAQasT/+5uzCRNF+sWOuMkst8OKO8LC4Xe
         ldbJ1xDtV8b3g==
Date:   Fri, 31 Mar 2023 10:04:20 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux.dev,
        Jason Gunthorpe <jgg@nvidia.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        X86 Kernel <x86@kernel.org>, bp@alien8.de,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>, corbet@lwn.net,
        vkoul@kernel.org, dmaengine@vger.kernel.org,
        linux-doc@vger.kernel.org, Will Deacon <will@kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Raj Ashok <ashok.raj@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>
Subject: Re: [PATCH v8 0/7] Remove VT-d virtual command interface and IOASID
Message-ID: <ZCaUBJvUMsJyD7EW@8bytes.org>
References: <20230322200803.869130-1-jacob.jun.pan@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230322200803.869130-1-jacob.jun.pan@linux.intel.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Wed, Mar 22, 2023 at 01:07:56PM -0700, Jacob Pan wrote:
> Jacob Pan (5):
>   iommu/vt-d: Remove virtual command interface
>   iommu/sva: Move PASID helpers to sva code
>   iommu/sva: Remove PASID to mm lookup function
>   iommu/sva: Use GFP_KERNEL for pasid allocation
>   iommu/ioasid: Rename INVALID_IOASID
> 
> Jason Gunthorpe (2):
>   iommu/sva: Stop using ioasid_set for SVA
>   iommu: Remove ioasid infrastructure

Applied, thanks.
