Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3474639A002
	for <lists+dmaengine@lfdr.de>; Thu,  3 Jun 2021 13:42:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbhFCLo3 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 3 Jun 2021 07:44:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229747AbhFCLo3 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 3 Jun 2021 07:44:29 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B05DCC06174A;
        Thu,  3 Jun 2021 04:42:44 -0700 (PDT)
Received: from zn.tnic (p200300ec2f138500cdba27e87082b0ea.dip0.t-ipconnect.de [IPv6:2003:ec:2f13:8500:cdba:27e8:7082:b0ea])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 150541EC0523;
        Thu,  3 Jun 2021 13:42:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1622720563;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=kHR69sSnlQU4XT3ZHfXIo1egrOHDxOfisxy4DiTmTKs=;
        b=kxTskGjoKduUe9Ji81kD1Z5sBuTuPnicMYhK3yQJ0UXYvJ/lQ/oc4VEEcDmMfLXmdJjaWF
        teI8hWz63WIbrXIAQzoIDmoF90c5/fxWASmN5YqLktqoXry4oF2BSDlEryi6efXNbVkWPH
        yfNpQ3QVGrQvZPApZmp4Zd75MjNABjQ=
Date:   Thu, 3 Jun 2021 13:42:38 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Fenghua Yu <fenghua.yu@intel.com>,
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
        dmaengine@vger.kernel.org
Subject: Re: [PATCH] x86/cpufeatures: Force disable X86_FEATURE_ENQCMD and
 remove update_pasid()
Message-ID: <YLjALi9hoxv2kubX@zn.tnic>
References: <1600187413-163670-1-git-send-email-fenghua.yu@intel.com>
 <1600187413-163670-10-git-send-email-fenghua.yu@intel.com>
 <87mtsd6gr9.ffs@nanos.tec.linutronix.de>
 <YLdZ7bZDPNup1n9c@zn.tnic>
 <YLi6+vICUmu07b0E@vkoul-mobl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YLi6+vICUmu07b0E@vkoul-mobl>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Thu, Jun 03, 2021 at 04:50:26PM +0530, Vinod Koul wrote:
> Applied, thanks

Actually, I'd prefer if I take it through the tip tree:

https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/log/?h=x86/urgent

because it is needed for the following patch by tglx:

6867ee8bcb75 x86/cpufeatures: Force disable X86_FEATURE_ENQCMD and remove update_pasid()
db099bafbf5e dmaengine: idxd: Use cpu_feature_enabled()

if you don't mind.

I'll be sending this to Linus this weekend.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
