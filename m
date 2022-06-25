Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0340455ACC4
	for <lists+dmaengine@lfdr.de>; Sat, 25 Jun 2022 23:40:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233295AbiFYVdW (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 25 Jun 2022 17:33:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230116AbiFYVdU (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 25 Jun 2022 17:33:20 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 97E9638B7
        for <dmaengine@vger.kernel.org>; Sat, 25 Jun 2022 14:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656192798;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZjAOJJmte7WRiyCc6Q0LCvObU2AofHsmmXcwQFMuZ90=;
        b=JQA4mf4st3qXxs4Qo3fpjeZbgHGQZGkyOUem1UZVdFUT0FwOwXSYiZcGX1gRdcsHkl4A9a
        RMeTj8uBnKSZGVMTTQcuiU7FRcUw+sKnvXk3O2DwPWLlxtGh++OdywM6v/pXclQFdtH4wC
        k3C09QvgxHp6YTn+Eyd7ZlUaOkAHkZ8=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-170-qmnbPsjjMNiWZH6xJXFC6w-1; Sat, 25 Jun 2022 17:33:17 -0400
X-MC-Unique: qmnbPsjjMNiWZH6xJXFC6w-1
Received: by mail-pl1-f197.google.com with SMTP id l16-20020a170903121000b0016a64bbe81cso3240926plh.11
        for <dmaengine@vger.kernel.org>; Sat, 25 Jun 2022 14:33:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZjAOJJmte7WRiyCc6Q0LCvObU2AofHsmmXcwQFMuZ90=;
        b=Ubc9B3AyjuZU1eZCr4HaFVNtNQSV30wTAFDNzE78T4ZJsa4DveiYKsO4UNXIUfM6UH
         yQfsyzaedhheatWVktBg6E+QsrLOcYIPiEfETYUc/ZMLqwF/TVmpWJVud1lMDhSQ5TJ7
         SrP86a4CTUAHC+uwPZGA557Vn65HY2RzxOgZeP9AZro1YQNJ3h9Wypraavn2GlDbh9aF
         DOL5t82RYeVr3eFNNiRGsthVOpVNqzEEFaPAJxfnT5xObha2BcLz+sg9v8cnX8sCinMN
         4n/WCvbV5XUxZb+ZkbV3AI/y8Vu60Vl5vt5mCE3I59y9Fjnfi9/IZVPy2edIyKaNXrc1
         6Qww==
X-Gm-Message-State: AJIora+FLxYYbywG3jq6VxepkJIHokKXyF+2Du1dXT+YWUT6LO6f+aGS
        kcHmJufttAJzUgzRfUQaibElq3+7arVUoYqWJnMJYFIPXJR/q4OsJ/4Bv8C+3RyW2ssFhmsy5kr
        OjdnDZD8i7NHRB/uU5sTc
X-Received: by 2002:a63:4741:0:b0:40d:4e20:6662 with SMTP id w1-20020a634741000000b0040d4e206662mr5002066pgk.520.1656192796135;
        Sat, 25 Jun 2022 14:33:16 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1u8Mg4SsmJ2O/6nuE5zeoHw2Bo2AjI++cHcHSo7BLFqJnAHHCdsPe0QuRb4UelUjMMBw6Lwag==
X-Received: by 2002:a63:4741:0:b0:40d:4e20:6662 with SMTP id w1-20020a634741000000b0040d4e206662mr5002048pgk.520.1656192795818;
        Sat, 25 Jun 2022 14:33:15 -0700 (PDT)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id ij26-20020a170902ab5a00b0016a1b60b19dsm4154831plb.91.2022.06.25.14.33.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jun 2022 14:33:15 -0700 (PDT)
Date:   Sat, 25 Jun 2022 14:33:13 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Fenghua Yu <fenghua.yu@intel.com>
Cc:     Baolu Lu <baolu.lu@linux.intel.com>,
        iommu@lists.linux-foundation.org,
        Dave Jiang <dave.jiang@intel.com>, dmaengine@vger.kernel.org
Subject: Re: iommu_sva_bind_device question
Message-ID: <20220625213313.ekpo5vbowxlx4uwf@cantor>
References: <20220623170232.6whonfjuh3m5vcoy@cantor>
 <6639b21c-1544-a025-4da5-219a1608f06e@linux.intel.com>
 <20220624011446.2bexm4sjo2vabay5@cantor>
 <552074ff-fd32-8cdb-cc10-1d71319c71db@linux.intel.com>
 <20220624134102.qxid72gqghjhyozn@cantor>
 <20220624144730.a6ork4dbjixnfhbf@cantor>
 <Yrdne20Eq+5KwF5h@fyu1.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yrdne20Eq+5KwF5h@fyu1.sc.intel.com>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Sat, Jun 25, 2022 at 12:52:27PM -0700, Fenghua Yu wrote:
> Hi, Jerry and Baolu,
> 
> On Fri, Jun 24, 2022 at 07:47:30AM -0700, Jerry Snitselaar wrote:
> > > > > > > Hi Baolu & Dave,
> > > > > fails.
> > > > > 
> > > > > You also will get the following warning if you don't have scalable
> > > > > mode enabled (either not enabled by default, or if enabled by default
> > > > > and passed intel_iommu=on,sm_off):
> > > > 
> > > > If scalable mode is disabled, iommu_dev_enable_feature(IOMMU_SVA) will
> > > > return failure, hence driver should not call iommu_sva_bind_device().
> > > > I guess below will disappear if above is fixed in the idxd driver.
> 
> Yes, Jerry's patch fixes the WARNING as well.
> 
> > > > 
> > > > Best regards,
> > > > baolu
> > > >
> > > 
> > > It looks like there was a recent maintainer change, and Fenghua is now
> > > the maintainer. Fenghua thoughts on this? With 42a1b73852c4
> > > ("dmaengine: idxd: Separate user and kernel pasid enabling") the code
> > > no longer depends on iommu_dev_feature_enable succeeding. Testing with
> > > something like this works (ran dmatest without sm_on, and
> > > dsa_user_test_runner.sh with sm_on, plus booting with various
> > > intel_iommu= combinations):
> > > 
> > > diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
> > > index 355fb3ef4cbf..5b49fd5c1e25 100644
> > > --- a/drivers/dma/idxd/init.c
> > > +++ b/drivers/dma/idxd/init.c
> > > @@ -514,13 +514,14 @@ static int idxd_probe(struct idxd_device *idxd)
> > >         if (IS_ENABLED(CONFIG_INTEL_IDXD_SVM) && sva) {
> > >                 if (iommu_dev_enable_feature(dev, IOMMU_DEV_FEAT_SVA))
> > >                         dev_warn(dev, "Unable to turn on user SVA feature.\n");
> > > -               else
> > > +               else {
> > >                         set_bit(IDXD_FLAG_USER_PASID_ENABLED, &idxd->flags);
> > > 
> > > -               if (idxd_enable_system_pasid(idxd))
> 
> Please add "{" after this if.
> 
> > > -                       dev_warn(dev, "No in-kernel DMA with PASID.\n");
> > > -               else
> then "}" before this else.
> 
> > > -                       set_bit(IDXD_FLAG_PASID_ENABLED, &idxd->flags);
> > > +                       if (idxd_enable_system_pasid(idxd))
> > > +                               dev_warn(dev, "No in-kernel DMA with PASID.\n");
> > > +                       else
> > > +                               set_bit(IDXD_FLAG_PASID_ENABLED, &idxd->flags);
> > > +               }
> > >         } else if (!sva) {
> > >                 dev_warn(dev, "User forced SVA off via module param.\n");
> > >         }
> 
> The patch was copied/pasted here. So the tabs are lost at beginning of each
> line. So it cannot be applied. Please change the tabs back.
> 
> Could you please send this patch in a separate email so that it has a
> right patch format and description and ready to be picked up?
> 

Sure, if you feel this is the correct solution. Just to be clear you would
like the end result to be:

	if (IS_ENABLED(CONFIG_INTEL_IDXD_SVM) && sva) {
		if (iommu_dev_enable_feature(dev, IOMMU_DEV_FEAT_SVA))
			dev_warn(dev, "Unable to turn on user SVA feature.\n");
		else {
			set_bit(IDXD_FLAG_USER_PASID_ENABLED, &idxd->flags);

			if (idxd_enable_system_pasid(idxd)) {
				dev_warn(dev, "No in-kernel DMA with PASID.\n");
			} else
				set_bit(IDXD_FLAG_PASID_ENABLED, &idxd->flags);
		}
	} else if (!sva) {
		dev_warn(dev, "User forced SVA off via module param.\n");
	}


> > > 
> > > The commit description is a bit confusing, because it talks about there
> > > being no dependency, but ties user pasid to enabling/disabling the SVA
> > > feature, which system pasid would depend on as well.
> > > 
> > > Regards,
> > > Jerry
> > 
> > Things like that warning message "Unable to turn on user SVA feature" when
> > iommu_dev_enable_feature fails though seems to be misleading with user
> > inserted in there. I'll leave it to the idxd folks to figure out.
> 
> How about removing "user" from the warning message? So the message will
> be "Unable to turn on SVA feature"?
>

I think what was confusing to me is it seemed to tie the SVA iommu
feature to the user, and talked about independence of the kernel and
user pasids. I understand the pasids themselves being independent, but
both depend on the SVA feature being enabled. So idxd_enable_system_pasid
can only happen if iommu_dev_feature_enable(dev, IOMMU_DEV_FEAT_SVA)
has succeeded prior to it, and idxd_disable_system_pasid should be
called if needed before there is a call to
iommu_dev_feature_disable(dev, IOMMU_DEV_FEAT_SVA).

When I looked at the code that seemed to be the case outside of this
block in idxd_probe, but I wasn't sure if I was missing something else.

Regards,
Jerry

> Thanks.
> 
> -Fenghua

