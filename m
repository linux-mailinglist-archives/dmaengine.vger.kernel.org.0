Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A06BA55AED5
	for <lists+dmaengine@lfdr.de>; Sun, 26 Jun 2022 06:27:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233840AbiFZEUE (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 26 Jun 2022 00:20:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233788AbiFZEUD (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 26 Jun 2022 00:20:03 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9854113D73;
        Sat, 25 Jun 2022 21:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656217202; x=1687753202;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=QgX9czqvz7nw5nttSDUO+l6QWPYEKnOkMZQQOjRfhRo=;
  b=B8K1MfdBPvV7r7ysK8D4FHXorZReyJJWNQYb642RCCJG3oW3Lf17vKL1
   nk0r/2SpFh3u9K2PkysZry8fKXapIUz/URZtr5DBcoGxY5pAn6mb0acJq
   KvowGQMuWXQHdoL+Pgp6mo43M6zfiH8+AG/7xXHPBwNtfYVFwJcHefFdG
   vCLdw/HqnGo3oIrZ9kUlZ1wLiYMYZw+Hw8SpfFW4/S8CpviZ5iX5xROSx
   oJuVJUSY+9orFN/fv39Bz/5Wcp7I1g0sgOwQHJKRYohzGfZ43S4Jlp2VJ
   O+Tdy6g1K2CbJJCsyztn0KUYQfZogjKylt1rfD9e6MvxOVDeqJOTWocSl
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10389"; a="345247122"
X-IronPort-AV: E=Sophos;i="5.92,223,1650956400"; 
   d="scan'208";a="345247122"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2022 21:20:01 -0700
X-IronPort-AV: E=Sophos;i="5.92,223,1650956400"; 
   d="scan'208";a="645878112"
Received: from fyu1.sc.intel.com ([172.25.103.126])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2022 21:20:01 -0700
Date:   Sat, 25 Jun 2022 21:20:27 -0700
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     Jerry Snitselaar <jsnitsel@redhat.com>
Cc:     dmaengine@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        linux-kernel@vger.kernel.org, Dave Jiang <dave.jiang@intel.com>
Subject: Re: [PATCH] dmaengine: idxd: Only call idxd_enable_system_pasid if
 succeeded in enabling SVA feature
Message-ID: <Yrfei6qFCmOH9Eqo@fyu1.sc.intel.com>
References: <20220625221333.214589-1-jsnitsel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220625221333.214589-1-jsnitsel@redhat.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi, Jerry,

On Sat, Jun 25, 2022 at 03:13:33PM -0700, Jerry Snitselaar wrote:

> Subject: [PATCH] dmaengine: idxd: Only call idxd_enable_system_pasid if
>        succeeded in enabling SVA feature

s/idxd_enable_system_pasid/idxd_enable_system_pasid()/


Please add your original error info in the commit message:

On a Sapphire Rapids system if you boot without intel_iommu=on, the IDXD
driver will crash during probe in iommu_sva_bind_device().

[   21.423729] BUG: kernel NULL pointer dereference, address: 0000000000000038 
[   21.445108] #PF: supervisor read access in kernel mode 
[   21.450912] #PF: error_code(0x0000) - not-present page 
[   21.456706] PGD 0  
[   21.459047] Oops: 0000 [#1] PREEMPT SMP NOPTI 
[   21.464004] CPU: 0 PID: 1420 Comm: kworker/0:3 Not tainted 5.19.0-0.rc3.27.eln120.x86_64 #1 
[   21.464011] Hardware name: Intel Corporation EAGLESTREAM/EAGLESTREAM, BIOS EGSDCRB1.SYS.0067.D12.2110190954 10/19/2021 
[   21.464015] Workqueue: events work_for_cpu_fn 
[   21.464030] RIP: 0010:iommu_sva_bind_device+0x1d/0xe0 
[   21.464046] Code: c3 cc 66 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 41 57 41 56 49 89 d6 41 55 41 54 55 53 48 83 ec 08 48 8b 87 d8 02 00 00 <48> 8b 40 38 48 8b 50 10 48 83 7a 70 00 48 89 14 24 0f 84 91 00 00 
[   21.464050] RSP: 0018:ff7245d9096b7db8 EFLAGS: 00010296 
[   21.464054] RAX: 0000000000000000 RBX: ff1eadeec8a51000 RCX: 0000000000000000 
[   21.464058] RDX: ff7245d9096b7e24 RSI: 0000000000000000 RDI: ff1eadeec8a510d0 
[   21.464060] RBP: ff1eadeec8a51000 R08: ffffffffb1a12300 R09: ff1eadffbfce25b4 
[   21.464062] R10: ffffffffffffffff R11: 0000000000000038 R12: ffffffffc09f8000 
[   21.464065] R13: ff1eadeec8a510d0 R14: ff7245d9096b7e24 R15: ff1eaddf54429000 
[   21.464067] FS:  0000000000000000(0000) GS:ff1eadee7f600000(0000) knlGS:0000000000000000 
[   21.464070] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033 
[   21.464072] CR2: 0000000000000038 CR3: 00000008c0e10006 CR4: 0000000000771ef0 
[   21.464074] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000 
[   21.464076] DR3: 0000000000000000 DR6: 00000000fffe07f0 DR7: 0000000000000400 
[   21.464078] PKRU: 55555554 
[   21.464079] Call Trace: 
[   21.464083]  <TASK> 
[   21.464092]  idxd_pci_probe+0x259/0x1070 [idxd] 
[   21.464121]  local_pci_probe+0x3e/0x80 
[   21.464132]  work_for_cpu_fn+0x13/0x20 
[   21.464136]  process_one_work+0x1c4/0x380 
[   21.464143]  worker_thread+0x1ab/0x380 
[   21.464147]  ? _raw_spin_lock_irqsave+0x23/0x50 
[   21.464158]  ? process_one_work+0x380/0x380 
[   21.464161]  kthread+0xe6/0x110 
[   21.464168]  ? kthread_complete_and_exit+0x20/0x20 
[   21.464172]  ret_from_fork+0x1f/0x30

> iommu_sva_bind_device requires that iommu_dev_enable_feature has been
> previously called with IOMMU_DEV_FEAT_SVA, and succeeded. Without this
> it is possible to run into a situation where you will dereference a
> null pointer if the intel_iommu driver is not enabled.
 
How about this commit message?

iommu_sva_bind_device() requires SVA has been enabled successfully on
the IDXD device before it's called. Otherwise, iommu_sva_bind_device()
will access a NULL pointer. If Intel IOMMU is disabled, SVA cannot be
enabled and thus idxd_enable_system_pasid() and iommu_sva_bind_device()
should not be called.

> Note: checkpatch didn't like the suggested addition of braces for the
>       first arm of the "if (idxd_enable_system_pasid)" block.

Please see my comment in the code.

> 
> Fixes: 42a1b73852c4 ("dmaengine: idxd: Separate user and kernel pasid enabling")
> Cc: Vinod Koul <vkoul@kernel.org>
> Cc: linux-kernel@vger.kernel.org
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: Fenghua Yu <fenghua.yu@intel.com>
> Signed-off-by: Jerry Snitselaar <jsnitsel@redhat.com>

Please add bug report link here:
Link: https://lore.kernel.org/dmaengine/20220623170232.6whonfjuh3m5vcoy@cantor/

> ---
>  drivers/dma/idxd/init.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
> index 355fb3ef4cbf..5b49fd5c1e25 100644
> --- a/drivers/dma/idxd/init.c
> +++ b/drivers/dma/idxd/init.c
> @@ -514,13 +514,14 @@ static int idxd_probe(struct idxd_device *idxd)
>  	if (IS_ENABLED(CONFIG_INTEL_IDXD_SVM) && sva) {
>  		if (iommu_dev_enable_feature(dev, IOMMU_DEV_FEAT_SVA))

Need balanced braces in if-else.

Add "{" after this "if (...)".

>  			dev_warn(dev, "Unable to turn on user SVA feature.\n");
> -		else
> +		else {

Add "}" before this "else {".

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
