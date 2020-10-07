Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFD1E285C5D
	for <lists+dmaengine@lfdr.de>; Wed,  7 Oct 2020 12:04:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727562AbgJGKEh (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 7 Oct 2020 06:04:37 -0400
Received: from mail.skyhub.de ([5.9.137.197]:37832 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727257AbgJGKEg (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 7 Oct 2020 06:04:36 -0400
Received: from zn.tnic (p200300ec2f091000acdeda0e0c7556d4.dip0.t-ipconnect.de [IPv6:2003:ec:2f09:1000:acde:da0e:c75:56d4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 9927F1EC0266;
        Wed,  7 Oct 2020 12:04:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1602065075;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=/hE/7UxzjG6+51BYRJlMG+kD5c521uFN7WfItXkkBhs=;
        b=rpgL/fpc7TTly62n08xRcjjX1BRQOBViwB74t41qFbilaVR25FEubsTwpN2seurCtbGlev
        3gTSqJtKDdudagSYYnHNhYxKwRpjdA1zfbYFndARKqHK/4vDp/6h9vs/Q7l0kGrFIARU+a
        2+ETgnM/5QDYmUW4xEAQUBpDsm6eOBY=
Date:   Wed, 7 Oct 2020 12:04:26 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Dave Jiang <dave.jiang@intel.com>, dan.j.williams@intel.com,
        tony.luck@intel.com, ashok.raj@intel.com, kevin.tian@intel.com,
        fenghua.yu@intel.com, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 0/5] Add shared workqueue support for idxd driver
Message-ID: <20201007100426.GF5607@zn.tnic>
References: <20201005151126.657029-1-dave.jiang@intel.com>
 <20201007070132.GT2968@vkoul-mobl>
 <20201007084856.GE5607@zn.tnic>
 <20201007095313.GV2968@vkoul-mobl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201007095313.GV2968@vkoul-mobl>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Wed, Oct 07, 2020 at 03:23:13PM +0530, Vinod Koul wrote:
> Right my build failed for x86 and I have dropped these now. I would have
> expected the dependency to be a signed tag to be cross merged when I was
> asked to merge this.

I can give you a signed tag is you prefer but that's usually not
necessary. You can simply merge tip's x86/pasid branch, then apply those
ontop and test.

HTH.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
