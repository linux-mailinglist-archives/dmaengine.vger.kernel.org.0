Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89BC06F7B42
	for <lists+dmaengine@lfdr.de>; Fri,  5 May 2023 04:59:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229482AbjEEC7Q (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 4 May 2023 22:59:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjEEC7P (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 4 May 2023 22:59:15 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBCA31160F;
        Thu,  4 May 2023 19:59:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683255554; x=1714791554;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=+6Ksxw8NnDuZ6E01rOeUZM6j9Ahu/Zzr4rk7clJ2PuI=;
  b=KLH+cVFc5H6Wve8KmQotbbelz+9xYl5mMBk8BZ5HRUIwbHnTsSzRYIUN
   /YRrvY/x/liYpjfVrND4/9taT2vaMsKVmjKF7MOVVsxBX5J6JOPXzQESi
   D34Zp2lXsq8VLb2Xurs4Qvkb+1+5GxefPgalV4juL8XBUQTzr6qWHdbFz
   mQRyKOS/2evoVtJmDqqz1hAahW6/07AZZ+pHw2in5UugqQmee6VYe2V+U
   kXhqAF0dPKXv0AQhvDn/GEESUSwpBR3wUMmYuCwzy5oEVlR5Pqi0cVXk4
   4l/0UEw4/ZpPSTNdKWVd5uKFOrM2mGeTv9IVhoJV/1/DnknYUeY9dKURS
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10700"; a="347935664"
X-IronPort-AV: E=Sophos;i="5.99,250,1677571200"; 
   d="scan'208";a="347935664"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2023 19:59:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10700"; a="762232080"
X-IronPort-AV: E=Sophos;i="5.99,250,1677571200"; 
   d="scan'208";a="762232080"
Received: from allen-box.sh.intel.com (HELO [10.239.159.127]) ([10.239.159.127])
  by fmsmga008.fm.intel.com with ESMTP; 04 May 2023 19:59:00 -0700
Message-ID: <35ceffc2-e306-6215-e90a-43548f6feca6@linux.intel.com>
Date:   Fri, 5 May 2023 10:58:38 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Cc:     baolu.lu@linux.intel.com, LKML <linux-kernel@vger.kernel.org>,
        iommu@lists.linux.dev, Robin Murphy <robin.murphy@arm.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Joerg Roedel <joro@8bytes.org>, dmaengine@vger.kernel.org,
        vkoul@kernel.org, Will Deacon <will@kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Raj Ashok <ashok.raj@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        "Zanussi, Tom" <tom.zanussi@intel.com>,
        narayan.ranganathan@intel.com
Subject: Re: [PATCH v5 6/7] iommu/vt-d: Implement set_dev_pasid domain op
Content-Language: en-US
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>
References: <20230427174937.471668-1-jacob.jun.pan@linux.intel.com>
 <20230427174937.471668-7-jacob.jun.pan@linux.intel.com>
 <76c98e62-1cac-2ab6-7721-08ec2c1fceb8@linux.intel.com>
 <20230504160334.496085db@jacob-builder>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20230504160334.496085db@jacob-builder>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 5/5/23 7:03 AM, Jacob Pan wrote:
>>> +static int intel_iommu_attach_device_pasid(struct iommu_domain *domain,
>>> +					   struct device *dev,
>>> ioasid_t pasid) +{
>>> +	struct device_domain_info *info = dev_iommu_priv_get(dev);
>>> +	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
>>> +	struct intel_iommu *iommu = info->iommu;
>>> +	int ret;
>>> +
>>> +	if (!pasid_supported(iommu))
>>> +		return -ENODEV;
>>> +
>>> +	ret = prepare_domain_attach_device(domain, dev);
>>> +	if (ret)
>>> +		return ret;
>>> +
>>> +	/*
>>> +	 * Most likely the device context has already been set up,
>>> will only
>>> +	 * take a domain ID reference. Otherwise, device context will
>>> be set
>>> +	 * up here.
>> The "otherwise" case is only default domain deferred attaching case,
>> right?
> it might be the only case so far, but my intention is to be general. i.e.
> no ordering requirements. I believe it is more future proof in case
> device_attach_pasid called before device_attach.

Let's put aside deferred attach and talk about it later.

The device's context entry is configured when the default domain is
being attached to the device. And, the default domain attaching is in
the iommu probe_device path. It always happens before set_device_pasid
which is designed to be called by the device driver. So the real
situation is that when the device driver calls set_device_pasid, the
context entry should already have been configured.

Then let's pick up the deferred attach case. It is a workaround for
kdump (Documentation/admin-guide/kdump/kdump.rst). I don't think PASID
feature is functionally required by any kdump capture kernel as its
main purpose is to dump the memory of a panic kernel.

In summary, it seems to be reasonable for the vt-d driver to return
-EBUSY when a device's context was copied. The idxd driver should
continue to work without kernel DMA with PASID support.

	if (context_copied(iommu, bus, devfn))
		return -EBUSY;

Make things general is always good, but this doesn't mean that we need
to make the code complex to support cases that do not exist or are not
used. Thoughts?

Best regards,
baolu
