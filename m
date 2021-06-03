Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0DFB39A34C
	for <lists+dmaengine@lfdr.de>; Thu,  3 Jun 2021 16:33:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231610AbhFCOf1 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 3 Jun 2021 10:35:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230365AbhFCOf0 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 3 Jun 2021 10:35:26 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7722C061756;
        Thu,  3 Jun 2021 07:33:41 -0700 (PDT)
Received: from zn.tnic (p200300ec2f13850038a9e66fdc616f42.dip0.t-ipconnect.de [IPv6:2003:ec:2f13:8500:38a9:e66f:dc61:6f42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 35C261EC0288;
        Thu,  3 Jun 2021 16:33:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1622730820;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=v3uLhwvoQ2U0ccwLZNAng7garG6ceRKAsS1cWo3FxGE=;
        b=TbMLnSs+xjHJ2zv7bGB2HOM5OdBW/ymiYLTb8DcTvCbjG9TvwcIHi4Q+yxRfppfSMfwtU6
        XambKTiz9jdQEUUJ3tLZGqM3qq3dloPb+RpUUzc95cpW6S89NM+64dav7k3HPnGhoTHrof
        KNVeGYG91J8VM5Z2Ncg3jFW5tmMKKCY=
Date:   Thu, 3 Jun 2021 16:33:33 +0200
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
Message-ID: <YLjoPS32PFDon48f@zn.tnic>
References: <1600187413-163670-1-git-send-email-fenghua.yu@intel.com>
 <1600187413-163670-10-git-send-email-fenghua.yu@intel.com>
 <87mtsd6gr9.ffs@nanos.tec.linutronix.de>
 <YLdZ7bZDPNup1n9c@zn.tnic>
 <YLi6+vICUmu07b0E@vkoul-mobl>
 <YLjALi9hoxv2kubX@zn.tnic>
 <YLjPSAfBPIfQvmha@vkoul-mobl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YLjPSAfBPIfQvmha@vkoul-mobl>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Thu, Jun 03, 2021 at 06:17:04PM +0530, Vinod Koul wrote:
> You can add:
> 
> Acked-By: Vinod Koul <vkoul@kernel.org>

Done.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
