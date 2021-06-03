Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1358F39A161
	for <lists+dmaengine@lfdr.de>; Thu,  3 Jun 2021 14:47:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229994AbhFCMsw (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 3 Jun 2021 08:48:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:47574 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229801AbhFCMsw (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 3 Jun 2021 08:48:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BAE416139A;
        Thu,  3 Jun 2021 12:47:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622724427;
        bh=Su72vlEv6szuZvJdTn531CxoIL0BBrwp4O+j1wekIvI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WqP8lNYoU8Jc1bKjVXmNl7TjxqjpU7g3r26V2pgNhoXRfZ+5iA5+P+my9ZnKAvWf8
         FhLl7wxvQAifwtnr/Zo/gkmO4svx2LZrlljcHAvuTAWqY/5cDsuoJGGRkzLb6tlYRM
         lXBTHx8b5zvOXpQcB0ZkYFsfDYyY0OE6feHgoVIkRuMEjnSUerh6R2U0t/I1mqa0uM
         i5dZKGOi94gh8gnYwXu/wsA8dCs51dLHItLfv8QYrWXxOSmfvTYjmCSu2lylHD6MF+
         hCTpT0jMfRNvnaV9p14C6u3kA84QV4yuPCyDSezC9eRViu/zX9HblFrdSG5v8YP8+z
         2dcTq8nH5ARZQ==
Date:   Thu, 3 Jun 2021 18:17:04 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Borislav Petkov <bp@alien8.de>
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
Message-ID: <YLjPSAfBPIfQvmha@vkoul-mobl>
References: <1600187413-163670-1-git-send-email-fenghua.yu@intel.com>
 <1600187413-163670-10-git-send-email-fenghua.yu@intel.com>
 <87mtsd6gr9.ffs@nanos.tec.linutronix.de>
 <YLdZ7bZDPNup1n9c@zn.tnic>
 <YLi6+vICUmu07b0E@vkoul-mobl>
 <YLjALi9hoxv2kubX@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YLjALi9hoxv2kubX@zn.tnic>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 03-06-21, 13:42, Borislav Petkov wrote:
> On Thu, Jun 03, 2021 at 04:50:26PM +0530, Vinod Koul wrote:
> > Applied, thanks
> 
> Actually, I'd prefer if I take it through the tip tree:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/log/?h=x86/urgent
> 
> because it is needed for the following patch by tglx:
> 
> 6867ee8bcb75 x86/cpufeatures: Force disable X86_FEATURE_ENQCMD and remove update_pasid()
> db099bafbf5e dmaengine: idxd: Use cpu_feature_enabled()
> 
> if you don't mind.
> 
> I'll be sending this to Linus this weekend.

Okay dropped now..

You can add:

Acked-By: Vinod Koul <vkoul@kernel.org>

-- 
~Vinod
