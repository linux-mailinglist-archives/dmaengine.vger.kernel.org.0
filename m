Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0126928636C
	for <lists+dmaengine@lfdr.de>; Wed,  7 Oct 2020 18:16:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729140AbgJGQQe (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 7 Oct 2020 12:16:34 -0400
Received: from mail.skyhub.de ([5.9.137.197]:41744 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727379AbgJGQQe (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 7 Oct 2020 12:16:34 -0400
Received: from zn.tnic (p200300ec2f09100045b18ec36a87abe5.dip0.t-ipconnect.de [IPv6:2003:ec:2f09:1000:45b1:8ec3:6a87:abe5])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id F39881EC047F;
        Wed,  7 Oct 2020 18:16:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1602087393;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=RK/FM1J5z6Yq/QqKfIPaEHuwK9y4bwMYdy7n1YYA+AU=;
        b=OhJZPhpDDhLDN5BFbuEOOk74zimiGpGcnVhi9h2TX2w8gCnrDIKu/chPPMRba3c5cQgvGw
        qO9fd/tZ73TZo9nBFaV2LNI5RRxwKjEVb8elRSs5npO20xHy2ak4W+QdkLDlexagVWvvQB
        ewc4z0bxTFK9v3VXms4LafRVgllOGv8=
Date:   Wed, 7 Oct 2020 18:16:25 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Dave Jiang <dave.jiang@intel.com>, dan.j.williams@intel.com,
        tony.luck@intel.com, ashok.raj@intel.com, kevin.tian@intel.com,
        fenghua.yu@intel.com, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 0/5] Add shared workqueue support for idxd driver
Message-ID: <20201007161625.GH5607@zn.tnic>
References: <20201005151126.657029-1-dave.jiang@intel.com>
 <20201007070132.GT2968@vkoul-mobl>
 <20201007084856.GE5607@zn.tnic>
 <20201007095313.GV2968@vkoul-mobl>
 <20201007100426.GF5607@zn.tnic>
 <20201007145733.GX2968@vkoul-mobl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201007145733.GX2968@vkoul-mobl>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Wed, Oct 07, 2020 at 08:27:33PM +0530, Vinod Koul wrote:
> That would be better, signed tags are preferred

...

> While at it, it would be good if x86 patches of this series come from
> your tree, that makes more sense if we are doing a cross merge

All done, here it is:

https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/tag/?h=x86_pasid_for_5.10

That's going to be the tag I send to Linus next week too. I'll send it
on Monday when the merge window opens so that he can merge it before
your branch.

HTH.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
