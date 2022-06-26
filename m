Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F1B055AF3F
	for <lists+dmaengine@lfdr.de>; Sun, 26 Jun 2022 07:08:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233842AbiFZFGH (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 26 Jun 2022 01:06:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229957AbiFZFGH (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 26 Jun 2022 01:06:07 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 924B413D74;
        Sat, 25 Jun 2022 22:06:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656219965; x=1687755965;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hl2agD/+Sc11EfpsDPo10+vgPf/U1CBCR4RfoCDNlkA=;
  b=bFXmSZwHdnCoxMu28xGeT1n4OFVTt0dvhoVaI8w+VC1zMk5dlAwbRkLT
   g7Um8a8BsH3mzqen0cNLxu+tWScEMhvPRiw7g+j22bjylHcCQHoziilde
   8TLbc60WZackqtAdxgyIQbuBsuNhpxtyR2FoEkgLE8wjFJSyGoe6At0Of
   eITL2aS+oz61Nr+NICMfQLw+336+UHeBhUsotoR4BZ6l5PnD1R7Sal+ye
   U4InhqcZecDIce2DTdd+Rv3PqbPeNDkZPf8mbCc84IEu2dAl1YtYP/rZG
   5P4AzclF4osxq/uccPwkHssKoQsQMMFVcut2pPfJe78mwdBUv99GeQlzc
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10389"; a="306716079"
X-IronPort-AV: E=Sophos;i="5.92,223,1650956400"; 
   d="scan'208";a="306716079"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2022 22:06:05 -0700
X-IronPort-AV: E=Sophos;i="5.92,223,1650956400"; 
   d="scan'208";a="593819878"
Received: from fyu1.sc.intel.com ([172.25.103.126])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2022 22:06:05 -0700
Date:   Sat, 25 Jun 2022 22:06:31 -0700
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     Jerry Snitselaar <jsnitsel@redhat.com>
Cc:     dmaengine@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        linux-kernel@vger.kernel.org, Dave Jiang <dave.jiang@intel.com>
Subject: Re: [PATCH v2] dmaengine: idxd: Only call idxd_enable_system_pasid()
 if succeeded in enabling SVA feature
Message-ID: <YrfpV5kcyRj2LdZB@fyu1.sc.intel.com>
References: <20220625221333.214589-1-jsnitsel@redhat.com>
 <20220626045144.9063-1-jsnitsel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220626045144.9063-1-jsnitsel@redhat.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi, Jerry,

On Sat, Jun 25, 2022 at 09:51:44PM -0700, Jerry Snitselaar wrote:
> On a Sapphire Rapids system if you boot without intel_iommu=on, the IDXD
                               s/you//

> driver will crash during probe in iommu_sva_bind_device().
.... 
> v2: Balance braces on if else block. Fix up commit description.

This change log should be moved after "---".

> 
> Fixes: 42a1b73852c4 ("dmaengine: idxd: Separate user and kernel pasid enabling")
> Cc: Vinod Koul <vkoul@kernel.org>
> Cc: linux-kernel@vger.kernel.org
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: Fenghua Yu <fenghua.yu@intel.com>
> Signed-off-by: Jerry Snitselaar <jsnitsel@redhat.com>

Please put the bug report link here:

Link: https://lore.kernel.org/dmaengine/20220623170232.6whonfjuh3m5vcoy@cantor/

> ---

i.e. put the change log here:

v2: Balance braces on if else block. Fix up commit description.

>  drivers/dma/idxd/init.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
> index 355fb3ef4cbf..aa3478257ddb 100644
> --- a/drivers/dma/idxd/init.c
> +++ b/drivers/dma/idxd/init.c
> @@ -512,15 +512,16 @@ static int idxd_probe(struct idxd_device *idxd)
>  	dev_dbg(dev, "IDXD reset complete\n");
>  
>  	if (IS_ENABLED(CONFIG_INTEL_IDXD_SVM) && sva) {
> -		if (iommu_dev_enable_feature(dev, IOMMU_DEV_FEAT_SVA))
> +		if (iommu_dev_enable_feature(dev, IOMMU_DEV_FEAT_SVA)) {
>  			dev_warn(dev, "Unable to turn on user SVA feature.\n");
> -		else
> +		} else {
>  			set_bit(IDXD_FLAG_USER_PASID_ENABLED, &idxd->flags);
>  
> -		if (idxd_enable_system_pasid(idxd))
> -			dev_warn(dev, "No in-kernel DMA with PASID.\n");
> -		else
> -			set_bit(IDXD_FLAG_PASID_ENABLED, &idxd->flags);
> +			if (idxd_enable_system_pasid(idxd))
> +				dev_warn(dev, "No in-kernel DMA with PASID.\n");
> +			else
> +				set_bit(IDXD_FLAG_PASID_ENABLED, &idxd->flags);
> +		}
>  	} else if (!sva) {
>  		dev_warn(dev, "User forced SVA off via module param.\n");
>  	}
> -- 
> 2.36.1
> 
Thanks.

-Fenghua
