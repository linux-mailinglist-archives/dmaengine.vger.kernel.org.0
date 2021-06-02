Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7176539860F
	for <lists+dmaengine@lfdr.de>; Wed,  2 Jun 2021 12:14:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229906AbhFBKPz (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 2 Jun 2021 06:15:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbhFBKPz (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 2 Jun 2021 06:15:55 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE14CC061574;
        Wed,  2 Jun 2021 03:14:12 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0f0e00cc90e218be681080.dip0.t-ipconnect.de [IPv6:2003:ec:2f0f:e00:cc90:e218:be68:1080])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 11F341EC03F0;
        Wed,  2 Jun 2021 12:14:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1622628851;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=xt5EUbqzEORoKlt8WOnIt9jfniFBapo1gRFEx/SuRsU=;
        b=rcEUDc9ldr9G8e8bFrixjmZ23ayGa3XpiTj+CJ/bDSZSrqRjQ/EXee5UNQ3Vuh0AfkAwGx
        kJ9dDvuOqwlqyptbzAXCcf0xzamU1o4kaGA4sV5iswPDdTM6pLEfUTPvEHo3wl2mmh6TV8
        wt3PNqJT79Op6SKdGrS7v6gsH0Z0nZQ=
Date:   Wed, 2 Jun 2021 12:14:05 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        x86 <x86@kernel.org>, iommu@lists.linux-foundation.org,
        Ingo Molnar <mingo@redhat.com>, H Peter Anvin <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Christoph Hellwig <hch@infradead.org>,
        Peter Zijlstra <peterz@infradead.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Ashok Raj <ashok.raj@intel.com>,
        Jacob Jun Pan <jacob.jun.pan@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Sohil Mehta <sohil.mehta@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org
Subject: Re: [PATCH] x86/cpufeatures: Force disable X86_FEATURE_ENQCMD and
 remove update_pasid()
Message-ID: <YLdZ7bZDPNup1n9c@zn.tnic>
References: <1600187413-163670-1-git-send-email-fenghua.yu@intel.com>
 <1600187413-163670-10-git-send-email-fenghua.yu@intel.com>
 <87mtsd6gr9.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87mtsd6gr9.ffs@nanos.tec.linutronix.de>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Sat, May 29, 2021 at 11:17:30AM +0200, Thomas Gleixner wrote:
> --- a/arch/x86/include/asm/disabled-features.h
> +++ b/arch/x86/include/asm/disabled-features.h
> @@ -56,11 +56,8 @@
>  # define DISABLE_PTI		(1 << (X86_FEATURE_PTI & 31))
>  #endif
>  
> -#ifdef CONFIG_IOMMU_SUPPORT
> -# define DISABLE_ENQCMD	0
> -#else
> -# define DISABLE_ENQCMD (1 << (X86_FEATURE_ENQCMD & 31))
> -#endif
> +/* Force disable because it's broken beyond repair */
> +#define DISABLE_ENQCMD		(1 << (X86_FEATURE_ENQCMD & 31))

Yeah, for that to work we need:

---
From: Borislav Petkov <bp@suse.de>
Date: Wed, 2 Jun 2021 12:07:52 +0200
Subject: [PATCH] dmaengine: idxd: Use cpu_feature_enabled()

When testing x86 feature bits, use cpu_feature_enabled() so that
build-disabled features can remain off, regardless of what CPUID says.

Fixes: 8e50d392652f ("dmaengine: idxd: Add shared workqueue support")
Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: <stable@vger.kernel.org>
---
 drivers/dma/idxd/init.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
index 2a926bef87f2..776fd44aff5f 100644
--- a/drivers/dma/idxd/init.c
+++ b/drivers/dma/idxd/init.c
@@ -745,12 +745,12 @@ static int __init idxd_init_module(void)
 	 * If the CPU does not support MOVDIR64B or ENQCMDS, there's no point in
 	 * enumerating the device. We can not utilize it.
 	 */
-	if (!boot_cpu_has(X86_FEATURE_MOVDIR64B)) {
+	if (!cpu_feature_enabled(X86_FEATURE_MOVDIR64B)) {
 		pr_warn("idxd driver failed to load without MOVDIR64B.\n");
 		return -ENODEV;
 	}
 
-	if (!boot_cpu_has(X86_FEATURE_ENQCMD))
+	if (!cpu_feature_enabled(X86_FEATURE_ENQCMD))
 		pr_warn("Platform does not have ENQCMD(S) support.\n");
 	else
 		support_enqcmd = true;
-- 
2.29.2

For the newly CCed parties, pls check

https://lkml.kernel.org/r/87mtsd6gr9.ffs@nanos.tec.linutronix.de

for more info.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
