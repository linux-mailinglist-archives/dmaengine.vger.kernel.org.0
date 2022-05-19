Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D598352CC31
	for <lists+dmaengine@lfdr.de>; Thu, 19 May 2022 08:49:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234327AbiESGsw (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 19 May 2022 02:48:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234406AbiESGss (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 19 May 2022 02:48:48 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B06D50052;
        Wed, 18 May 2022 23:48:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=V2TDUFSNHE95kEf4VxP+IT6MaVTQWUHhL5M/CYkJECo=; b=AXzSkkG20XX/E1ROz9jYHQhXup
        Ezfpv2TCmM1qTfdDsoK0j2yB5jAbaElPWO+xfP31SeybLoll9phrqlTDVqUpNL2TupLjLH0RL1YJY
        paZz1X4OygTDhpIto5k1z9Z5uGvtZ2p75xpR0oiutIJmrTp41na8NlJOc1Jn+JRz5D9P2wwqlCSUT
        6csKBsf2OKBiAzBPHiLKURNAOw7G+/4nzytQ5CwuOf1rMbiYc+zqIVktFq7bkoqYyiEkB/8Qphh9e
        ZBGsMEWzIJZK59/Rr/8ot7GPO2LyF/LMrVeBIccfW6v29C0q9gtPatowomzEmURCDB4tvGgLYNTLN
        E6n0bd6A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nrZxk-005MOr-TC; Thu, 19 May 2022 06:48:44 +0000
Date:   Wed, 18 May 2022 23:48:44 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc:     iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>, dmaengine@vger.kernel.org,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>, vkoul@kernel.org,
        robin.murphy@arm.com, will@kernel.org, Yi Liu <yi.l.liu@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        Eric Auger <eric.auger@redhat.com>
Subject: Re: [PATCH v4 2/6] iommu: Add a helper to do PASID lookup from domain
Message-ID: <YoXoTFeSdnBILj/2@infradead.org>
References: <20220518182120.1136715-1-jacob.jun.pan@linux.intel.com>
 <20220518182120.1136715-3-jacob.jun.pan@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220518182120.1136715-3-jacob.jun.pan@linux.intel.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Wed, May 18, 2022 at 11:21:16AM -0700, Jacob Pan wrote:
> +ioasid_t iommu_get_pasid_from_domain(struct device *dev, struct iommu_domain *domain)

Overly long line here.
