Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B482E558C82
	for <lists+dmaengine@lfdr.de>; Fri, 24 Jun 2022 02:55:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230167AbiFXAzN (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 23 Jun 2022 20:55:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbiFXAzM (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 23 Jun 2022 20:55:12 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA6D04F1CE
        for <dmaengine@vger.kernel.org>; Thu, 23 Jun 2022 17:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656032111; x=1687568111;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=PA8xe1s8KSwd8s5ArY8C3K1kz59dLQKimlFAN3yCtl4=;
  b=npdpUViS6JewZg0qMZaM4YjDtpeMsczDOfGjwISANEIXY1e2hBbdz5pH
   AGF0+xufqvbBRJsJHa/0Q7r28afd9vYsrEEwK69pXz3lv4zTn8zbfdVoS
   6PX5+zkBQGE9E9bQtuuQl8hG/53CQhX9cTLOefwqxYM5pkwwGbsBMte8n
   57TrVz4tZnektqupDKYMFWaCIhk0Tc+zUXKNDfEWzPIo1lGzOP+3boSSI
   6LsBXSdKJ33b1fKIg/DSA/T983A1pljW5aDKVn+NYG6E4JnKEULS2fZpo
   fhXCc/ovx2EwQrgTeFMldBzy4GkSNluhUzddMljwjYTNDZZnmadoLfs4c
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10387"; a="261313602"
X-IronPort-AV: E=Sophos;i="5.92,217,1650956400"; 
   d="scan'208";a="261313602"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2022 17:55:11 -0700
X-IronPort-AV: E=Sophos;i="5.92,217,1650956400"; 
   d="scan'208";a="645023733"
Received: from wenli3x-mobl.ccr.corp.intel.com (HELO [10.249.168.117]) ([10.249.168.117])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2022 17:55:09 -0700
Message-ID: <6639b21c-1544-a025-4da5-219a1608f06e@linux.intel.com>
Date:   Fri, 24 Jun 2022 08:55:08 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Cc:     baolu.lu@linux.intel.com
Subject: Re: iommu_sva_bind_device question
Content-Language: en-US
To:     Jerry Snitselaar <jsnitsel@redhat.com>,
        iommu@lists.linux-foundation.org,
        Dave Jiang <dave.jiang@intel.com>, dmaengine@vger.kernel.org
References: <20220623170232.6whonfjuh3m5vcoy@cantor>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20220623170232.6whonfjuh3m5vcoy@cantor>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 2022/6/24 01:02, Jerry Snitselaar wrote:
> Hi Baolu & Dave,
> 
> I noticed last night that on a Sapphire Rapids system if you boot without
> intel_iommu=on, the idxd driver will crash during probe in iommu_sva_bind_device().
> Should there be a sanity check before calling dev_iommu_ops(), or is the expectation
> that the caller would verify it is safe to call? This seemed to be uncovered by
> the combination of 3f6634d997db ("iommu: Use right way to retrieve iommu_ops"), and
> 42a1b73852c4 ("dmaengine: idxd: Separate user and kernel pasid enabling").
> 
> [   21.423729] BUG: kernel NULL pointer dereference, address: 0000000000000038
> [   21.445108] #PF: supervisor read access in kernel mode
> [   21.450912] #PF: error_code(0x0000) - not-present page
> [   21.456706] PGD 0
> [   21.459047] Oops: 0000 [#1] PREEMPT SMP NOPTI
> [   21.464004] CPU: 0 PID: 1420 Comm: kworker/0:3 Not tainted 5.19.0-0.rc3.27.eln120.x86_64 #1
> [   21.464011] Hardware name: Intel Corporation EAGLESTREAM/EAGLESTREAM, BIOS EGSDCRB1.SYS.0067.D12.2110190954 10/19/2021
> [   21.464015] Workqueue: events work_for_cpu_fn
> [   21.464030] RIP: 0010:iommu_sva_bind_device+0x1d/0xe0
> [   21.464046] Code: c3 cc 66 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 41 57 41 56 49 89 d6 41 55 41 54 55 53 48 83 ec 08 48 8b 87 d8 02 00 00 <48> 8b 40 38 48 8b 50 10 48 83 7a 70 00 48 89 14 24 0f 84 91 00 00
> [   21.464050] RSP: 0018:ff7245d9096b7db8 EFLAGS: 00010296
> [   21.464054] RAX: 0000000000000000 RBX: ff1eadeec8a51000 RCX: 0000000000000000
> [   21.464058] RDX: ff7245d9096b7e24 RSI: 0000000000000000 RDI: ff1eadeec8a510d0
> [   21.464060] RBP: ff1eadeec8a51000 R08: ffffffffb1a12300 R09: ff1eadffbfce25b4
> [   21.464062] R10: ffffffffffffffff R11: 0000000000000038 R12: ffffffffc09f8000
> [   21.464065] R13: ff1eadeec8a510d0 R14: ff7245d9096b7e24 R15: ff1eaddf54429000
> [   21.464067] FS:  0000000000000000(0000) GS:ff1eadee7f600000(0000) knlGS:0000000000000000
> [   21.464070] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   21.464072] CR2: 0000000000000038 CR3: 00000008c0e10006 CR4: 0000000000771ef0
> [   21.464074] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [   21.464076] DR3: 0000000000000000 DR6: 00000000fffe07f0 DR7: 0000000000000400
> [   21.464078] PKRU: 55555554
> [   21.464079] Call Trace:
> [   21.464083]  <TASK>
> [   21.464092]  idxd_pci_probe+0x259/0x1070 [idxd]
> [   21.464121]  local_pci_probe+0x3e/0x80
> [   21.464132]  work_for_cpu_fn+0x13/0x20
> [   21.464136]  process_one_work+0x1c4/0x380
> [   21.464143]  worker_thread+0x1ab/0x380
> [   21.464147]  ? _raw_spin_lock_irqsave+0x23/0x50
> [   21.464158]  ? process_one_work+0x380/0x380
> [   21.464161]  kthread+0xe6/0x110
> [   21.464168]  ? kthread_complete_and_exit+0x20/0x20
> [   21.464172]  ret_from_fork+0x1f/0x30
> 
> I figure either there needs to be a check in iommu_sva_bind_device, or
> idxd needs to check in idxd_enable_system_pasid that that
> idxd->pdev->dev.iommu is not null before it tries calling iommu_sva_bind_device.

As documented around the iommu_sva_bind_device() interface:

  * iommu_dev_enable_feature(dev, IOMMU_DEV_FEAT_SVA) must be called 
first, to
  * initialize the required SVA features.

idxd->pdev->dev.iommu should be checked in there.

Dave, any thoughts?

Best regards,
baolu
