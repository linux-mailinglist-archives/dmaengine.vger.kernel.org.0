Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 627A9285B40
	for <lists+dmaengine@lfdr.de>; Wed,  7 Oct 2020 10:49:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727926AbgJGItG (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 7 Oct 2020 04:49:06 -0400
Received: from mail.skyhub.de ([5.9.137.197]:54878 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726218AbgJGItG (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 7 Oct 2020 04:49:06 -0400
Received: from zn.tnic (p200300ec2f091000acdeda0e0c7556d4.dip0.t-ipconnect.de [IPv6:2003:ec:2f09:1000:acde:da0e:c75:56d4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 75D021EC0453;
        Wed,  7 Oct 2020 10:49:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1602060544;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zHL0PCNDMtJG4HSCsbQW6kkTw6bhozw7nCOPdIY1ki0=;
        b=qNskqp70gTNDZoiqtfeKJOT3KWC3brFRl6DuMZ8idSXvWB9KixQGejPmM/j2zGehgZbZ4z
        snKmITSANvg2EzXWe4fKLvaAdf1NReymkGwYcU3vjd4zMcko53SxlRq475e4W+kEv9TDlq
        JeVEOoZI2d8vnf4ASWqrqEd88MxsoK8=
Date:   Wed, 7 Oct 2020 10:48:56 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Dave Jiang <dave.jiang@intel.com>, dan.j.williams@intel.com,
        tony.luck@intel.com, ashok.raj@intel.com, kevin.tian@intel.com,
        fenghua.yu@intel.com, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 0/5] Add shared workqueue support for idxd driver
Message-ID: <20201007084856.GE5607@zn.tnic>
References: <20201005151126.657029-1-dave.jiang@intel.com>
 <20201007070132.GT2968@vkoul-mobl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201007070132.GT2968@vkoul-mobl>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Wed, Oct 07, 2020 at 12:31:32PM +0530, Vinod Koul wrote:
> Applied, thanks

I'm tired of repeating what you should've done - your branch doesn't
even build. How did you test it?

Also, what happens if Linus merges your branch first, before tip?

Oh boy.

In file included from ./arch/x86/include/asm/tsc.h:9,
                 from ./arch/x86/include/asm/timex.h:6,
                 from ./include/linux/timex.h:65,
                 from ./include/linux/time32.h:13,
                 from ./include/linux/time.h:73,
                 from ./include/linux/stat.h:19,
                 from ./include/linux/module.h:13,
                 from drivers/dma/idxd/init.c:5:
drivers/dma/idxd/init.c: In function ‘idxd_init_module’:
drivers/dma/idxd/init.c:526:20: error: ‘X86_FEATURE_ENQCMD’ undeclared (first use in this function); did you mean ‘X86_FEATURE_PCID’?
  526 |  if (!boot_cpu_has(X86_FEATURE_ENQCMD))
      |                    ^~~~~~~~~~~~~~~~~~
./arch/x86/include/asm/cpufeature.h:118:24: note: in definition of macro ‘cpu_has’
  118 |  (__builtin_constant_p(bit) && REQUIRED_MASK_BIT_SET(bit) ? 1 : \
      |                        ^~~
drivers/dma/idxd/init.c:526:7: note: in expansion of macro ‘boot_cpu_has’
  526 |  if (!boot_cpu_has(X86_FEATURE_ENQCMD))
      |       ^~~~~~~~~~~~
drivers/dma/idxd/init.c:526:20: note: each undeclared identifier is reported only once for each function it appears in
  526 |  if (!boot_cpu_has(X86_FEATURE_ENQCMD))
      |                    ^~~~~~~~~~~~~~~~~~
./arch/x86/include/asm/cpufeature.h:118:24: note: in definition of macro ‘cpu_has’
  118 |  (__builtin_constant_p(bit) && REQUIRED_MASK_BIT_SET(bit) ? 1 : \
      |                        ^~~
drivers/dma/idxd/init.c:526:7: note: in expansion of macro ‘boot_cpu_has’
  526 |  if (!boot_cpu_has(X86_FEATURE_ENQCMD))
      |       ^~~~~~~~~~~~
make[3]: *** [scripts/Makefile.build:283: drivers/dma/idxd/init.o] Error 1
make[3]: *** Waiting for unfinished jobs....
make[2]: *** [scripts/Makefile.build:500: drivers/dma/idxd] Error 2
make[2]: *** Waiting for unfinished jobs....
make[1]: *** [scripts/Makefile.build:500: drivers/dma] Error 2
make[1]: *** Waiting for unfinished jobs....
make: *** [Makefile:1788: drivers] Error 2
make: *** Waiting for unfinished jobs....

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
