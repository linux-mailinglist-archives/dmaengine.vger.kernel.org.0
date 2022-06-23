Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 419EF55833F
	for <lists+dmaengine@lfdr.de>; Thu, 23 Jun 2022 19:27:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233786AbiFWR1T (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 23 Jun 2022 13:27:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233795AbiFWR0l (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 23 Jun 2022 13:26:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C0AB550002
        for <dmaengine@vger.kernel.org>; Thu, 23 Jun 2022 10:02:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656003756;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type;
        bh=IR8O3ARrPXy5UZ3fHDm5YYAHxa9WEtwzHh6wS82OFpM=;
        b=Vk0Z+DmQXL+l3LOb3Mc6b1Arde4lukiE+Skzi7KLUzIsChHNZuPW2DU5VPXO+dYoWEO36v
        CWlg+FTlfk89n5pzTRgOorT1rbNh9d4UoNeryL5DbzxI3Oj4uFPEKyTT7wGFYAehddDeue
        mJwAVhx+26kUPBQZR1szt6cXBDerFro=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-428-vLxQqm2FMpazlvpDGhRWdw-1; Thu, 23 Jun 2022 13:02:35 -0400
X-MC-Unique: vLxQqm2FMpazlvpDGhRWdw-1
Received: by mail-pj1-f70.google.com with SMTP id u6-20020a17090a1d4600b001ec8200fe70so86475pju.1
        for <dmaengine@vger.kernel.org>; Thu, 23 Jun 2022 10:02:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition;
        bh=IR8O3ARrPXy5UZ3fHDm5YYAHxa9WEtwzHh6wS82OFpM=;
        b=nAgjYU1CSzCkV7rSCnAJVY3sJNo37abeKN8Ihdp1bt0ITyz3iuQiGQYYbW46b/glAE
         qv9fGSgL92kvi1RTWFYWTMtZYe7wZB476tEVi62dw0f+WVGO6Z+baF+hvSWeHGcxc6SY
         DYrPhfRSy9e5ne+c5dTHGXfj7v52at+qhPyXIVCQUxWFNKx9cOTSAzS0sw1FVqbuhfN/
         z1W+0xzAG0vAezJnXWeDk8QR4ZBihI0nrErn57sdOE8kIdyIlZyWFMwDhpdcq5eGqe+6
         tJuBb+Y0cQcrbci0tM5oyL3igwCOw6/d+um1Tl0X+2Ffr8ZI0NUExYD2VlQRbKdaFRYK
         3ElA==
X-Gm-Message-State: AJIora/5kycZ1eP+Heh9mZxYbF2tcQ3SRkeThhBfmtNob1x9EVC1Q8Ah
        TYRbcsiU3Z2j1lo8apk5D6MnSLwrzaCQ4CalDVa/7v8LGpYeHPMMYfbG2crfLc8EcX41nvxP51B
        d4f1RpQAdZuWguTQJlXN2
X-Received: by 2002:a63:f10c:0:b0:40d:4029:b250 with SMTP id f12-20020a63f10c000000b0040d4029b250mr5853853pgi.328.1656003753969;
        Thu, 23 Jun 2022 10:02:33 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1t32oGQD1jOIEgAPJa90gLIgCSFoyKow73Dl4iQEH39ebjQS6/y3aJremfFdbXM2ZYYUVYdMw==
X-Received: by 2002:a63:f10c:0:b0:40d:4029:b250 with SMTP id f12-20020a63f10c000000b0040d4029b250mr5853835pgi.328.1656003753578;
        Thu, 23 Jun 2022 10:02:33 -0700 (PDT)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id a4-20020a170902710400b0016a1c61c603sm32103pll.154.2022.06.23.10.02.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jun 2022 10:02:33 -0700 (PDT)
Date:   Thu, 23 Jun 2022 10:02:32 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     iommu@lists.linux-foundation.org,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Dave Jiang <dave.jiang@intel.com>, dmaengine@vger.kernel.org
Subject: iommu_sva_bind_device question
Message-ID: <20220623170232.6whonfjuh3m5vcoy@cantor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Baolu & Dave,

I noticed last night that on a Sapphire Rapids system if you boot without
intel_iommu=on, the idxd driver will crash during probe in iommu_sva_bind_device().
Should there be a sanity check before calling dev_iommu_ops(), or is the expectation
that the caller would verify it is safe to call? This seemed to be uncovered by
the combination of 3f6634d997db ("iommu: Use right way to retrieve iommu_ops"), and
42a1b73852c4 ("dmaengine: idxd: Separate user and kernel pasid enabling").

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

I figure either there needs to be a check in iommu_sva_bind_device, or
idxd needs to check in idxd_enable_system_pasid that that
idxd->pdev->dev.iommu is not null before it tries calling iommu_sva_bind_device.

Regards,
Jerry

