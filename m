Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ACA2557D25
	for <lists+dmaengine@lfdr.de>; Thu, 23 Jun 2022 15:36:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231857AbiFWNgt (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 23 Jun 2022 09:36:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231839AbiFWNgs (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 23 Jun 2022 09:36:48 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8E95B3A710
        for <dmaengine@vger.kernel.org>; Thu, 23 Jun 2022 06:36:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655991405;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type;
        bh=H6Xsl2+DErtoBBYmM3EVlV4D2CWcY1zgy8//8C8KgkQ=;
        b=aRPS36omMhj29AP1sHVLsrpo2y6uruEJ6nR+YiWeWLgYOs7neFa8MM1GzmndtDaWAAr0tM
        9Z056pnboto3yHJd9GZ5Usg3ckvW0sJ05RRfp0wMHiQn+qUbdI6YiS9vPUAtCmRpLAUa/s
        ZlslDGnvGt11s3dve4oKtHbgWVOifeE=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-167-OhFmjieONhuZHS6fwKApDw-1; Thu, 23 Jun 2022 09:36:36 -0400
X-MC-Unique: OhFmjieONhuZHS6fwKApDw-1
Received: by mail-pg1-f200.google.com with SMTP id g129-20020a636b87000000b00401b8392ac8so10594791pgc.4
        for <dmaengine@vger.kernel.org>; Thu, 23 Jun 2022 06:36:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition;
        bh=H6Xsl2+DErtoBBYmM3EVlV4D2CWcY1zgy8//8C8KgkQ=;
        b=2bh0Acfl7P7mI8TEfFQNdpcrdPs9tM/Ohd3OlkSspyMAdFimW/RB5L5OjFfsE3RfRW
         gzxWaDDwKAnCxnQ+foLNPEJLUk4EuK81EjEaIzx+qTauNUOMiqUOqSY6Y8AuaB+U5UDM
         dVn43KD9mmoyVJwiVJxhQmvV0ZXlTChkgw8NWHqQEGBqwEbwhaZ/m2QfzI6990nzGbKC
         h0eYP84w2Fa4S2LpdK0VaHJL2erSfrQc/0n5gykiuNn6DrSJrcu4e8uGJqkYszyNcxn2
         jFsi4vEwXG4YBiZwasbbTY34qyyZib0l79OahXGrkR/Tg+0Fl68W2VZ+bLZKYcU6gKHS
         8Tyw==
X-Gm-Message-State: AJIora8AAE7jNHeW+FFOdbmNshY/45GYjeRgNPwjwCMab/sWqT3CHUZh
        MwjZyx2WE+6tsxH6TM/7Ddv0KOtSjOiRG+i3QNboiWWVBPL0T0KxOz1db64EVxlnfqx//yr6tWk
        sSRxPVgXhjyh+glkUFk1g
X-Received: by 2002:a05:6a00:811:b0:525:50c2:4c2f with SMTP id m17-20020a056a00081100b0052550c24c2fmr6072491pfk.62.1655991395029;
        Thu, 23 Jun 2022 06:36:35 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1usriNyw3OUF8FQWsGmfpVAhqT7Zcc2SZ6+IXoj+arC45vYiiu+QgA6IP6LO/Bo/LTe0/X2vw==
X-Received: by 2002:a05:6a00:811:b0:525:50c2:4c2f with SMTP id m17-20020a056a00081100b0052550c24c2fmr6072475pfk.62.1655991394761;
        Thu, 23 Jun 2022 06:36:34 -0700 (PDT)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id w187-20020a6262c4000000b0051ba90d55acsm15668581pfb.207.2022.06.23.06.36.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jun 2022 06:36:34 -0700 (PDT)
Date:   Thu, 23 Jun 2022 06:36:33 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Dave Jiang <dave.jiang@intel.com>, Vinod Koul <vkoul@kernel.org>,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: idxd crashes on sapphire rapids if intel_iommu=on not set
Message-ID: <20220623133633.fmufvjlf4djxoi7u@cantor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

With 42a1b73852c4 ("dmaengine: idxd: Separate user and kernel pasid enabling")
if you boot a sapphire rapids system without enabling the iommu, it will crash
in iommu_sva_bind_device because the dev_iommu pointer in the device struct is
null. Should there be a check at the beginning of idxd_enable_system_pasid
to verify that it is not null, and return -ENODEV if it is?

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
[   21.464185]  </TASK>
[   21.464185] Modules linked in: pcc_cpufreq(+) drm_ttm_helper fjes(+) isst_if_mbox_pci(+) isst_if_mmio(+) idxd(+) snd ttm i2c_i801 isst_if_common mei intel_vsec idxd_bus soundcore i2c_ismt i2c_smbus ipmi_ssif acpi_ipmi ipmi_si acpi_pad acpi_power_meter pfr_update pfr_telemetry vfat fat fuse xfs crct10dif_pclmul crc32_pclmul crc32c_intel ghash_clmulni_intel igc wmi pinctrl_emmitsburg ipmi_devintf ipmi_msghandler
[   21.464227] CR2: 0000000000000038
[   21.464231] ---[ end trace 0000000000000000 ]---


Regards,
Jerry

