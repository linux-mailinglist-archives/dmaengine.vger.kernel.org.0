Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2244C70ED3F
	for <lists+dmaengine@lfdr.de>; Wed, 24 May 2023 07:44:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233663AbjEXFoh (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 24 May 2023 01:44:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239474AbjEXFog (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 24 May 2023 01:44:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2B6E13E;
        Tue, 23 May 2023 22:44:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3C5A360EB2;
        Wed, 24 May 2023 05:44:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD4DBC433EF;
        Wed, 24 May 2023 05:44:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684907074;
        bh=BAIEHKqWdw+wiFDljo7B9HdVaW+uTTTgwVeC0xa0/ao=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eHUMXZt2BKIzx0FxwovB47fimiy4gupnFQON8FyBp2umdWGOZJafZc2PciYaqPyL/
         18/1fL5ttqnT/pVs2mnirkPLZaR7vEGCYJAfxGasl9Oaqk36/cmhC6+qVHnvFsNwix
         jHW3+XsOPA7BXqjtSHcd1cV+s55xQqL9m9yiEewEHh9Xp6Dj5D1U70pTbUColbo40T
         EkZt2OFrJ7BcbbG5hAeHme6kRcSsJM1k25BMINl4kR1fDwumiAXY89WwtFOWypCFai
         bpfdDbfFFCxixf7IMvy2mZiteUnRCZD9VY1Rtp1JT4Gl9YLPxGApALXwKf/kRJZHA7
         NddS8fUQz49hQ==
Date:   Wed, 24 May 2023 11:14:29 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux.dev,
        Jason Gunthorpe <jgg@nvidia.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        dmaengine@vger.kernel.org, Will Deacon <will@kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Raj Ashok <ashok.raj@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        "Zanussi, Tom" <tom.zanussi@intel.com>,
        narayan.ranganathan@intel.com
Subject: Re: [PATCH v7 4/4] dmaengine/idxd: Re-enable kernel workqueue under
 DMA API
Message-ID: <ZG2kPbwMmW4B2PFB@matsya>
References: <20230523173451.2932113-1-jacob.jun.pan@linux.intel.com>
 <20230523173451.2932113-5-jacob.jun.pan@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230523173451.2932113-5-jacob.jun.pan@linux.intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 23-05-23, 10:34, Jacob Pan wrote:
> Kernel workqueues were disabled due to flawed use of kernel VA and SVA
> API. Now that we have the support for attaching PASID to the device's
> default domain and the ability to reserve global PASIDs from SVA APIs,
> we can re-enable the kernel work queues and use them under DMA API.
> 
> We also use non-privileged access for in-kernel DMA to be consistent
> with the IOMMU settings. Consequently, interrupt for user privilege is
> enabled for work completion IRQs.

Acked-by: Vinod Koul <vkoul@kernel.org>

-- 
~Vinod
