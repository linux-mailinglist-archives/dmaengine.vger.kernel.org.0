Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7784A399FA9
	for <lists+dmaengine@lfdr.de>; Thu,  3 Jun 2021 13:20:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229675AbhFCLWP (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 3 Jun 2021 07:22:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:35590 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229629AbhFCLWO (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 3 Jun 2021 07:22:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 77519613E6;
        Thu,  3 Jun 2021 11:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622719230;
        bh=yvu1ioWFgeXoiNI15+SCoMtyfAMfsZdkNLqkvbW5ChA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kuUpuVw6pZ0+xCWatONfbiD7PZPYm3CYPslvjBhz43wurBSp8e/Lf/cepm9y9RA6j
         SpU7YOwwjb6x0MbNkWXmUiv5Vz0O+A4iSJ9Z64Kk+vU2ws5lda5ih7wn2WGdIYDaQl
         lg4xvtwu9Rps0VVIJk6B2Wb0BoB4H9O+dtg1uCZkqCqEQaT3V/2v/O7znsM8iXuT2W
         53UM+etyclo69iNcWVx1U/V8ZjuS9Fg6c4mtjrT+5MWmPdevIHvqUGXsYxlwP+pd5I
         DDMjDH8C18ecxj8lpm1JP4sBrgkoHaDy0hXVBQFRKIL9cbWzUx6xQPAGnT+2U7uQii
         zWOzBxa1vF9Wg==
Date:   Thu, 3 Jun 2021 16:50:26 +0530
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
Message-ID: <YLi6+vICUmu07b0E@vkoul-mobl>
References: <1600187413-163670-1-git-send-email-fenghua.yu@intel.com>
 <1600187413-163670-10-git-send-email-fenghua.yu@intel.com>
 <87mtsd6gr9.ffs@nanos.tec.linutronix.de>
 <YLdZ7bZDPNup1n9c@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YLdZ7bZDPNup1n9c@zn.tnic>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 02-06-21, 12:14, Borislav Petkov wrote:
> ---
> From: Borislav Petkov <bp@suse.de>
> Date: Wed, 2 Jun 2021 12:07:52 +0200
> Subject: [PATCH] dmaengine: idxd: Use cpu_feature_enabled()
> 
> When testing x86 feature bits, use cpu_feature_enabled() so that
> build-disabled features can remain off, regardless of what CPUID says.

Applied, thanks

-- 
~Vinod
