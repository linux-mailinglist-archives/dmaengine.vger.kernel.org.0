Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B49F277B47
	for <lists+dmaengine@lfdr.de>; Thu, 24 Sep 2020 23:51:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726205AbgIXVvq (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 24 Sep 2020 17:51:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726185AbgIXVvq (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 24 Sep 2020 17:51:46 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1995CC0613CE;
        Thu, 24 Sep 2020 14:51:46 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0c9500ccec5e13992ce18c.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:9500:ccec:5e13:992c:e18c])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 5DFE31EC02C1;
        Thu, 24 Sep 2020 23:51:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1600984304;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=1OtBo2GUZiV4IvRElli6mq7TFUHXkk4b+JcoVE16cQY=;
        b=MC8WjBiSQ2rcKUMU/3mYOsJ2nFzPcP7LEts4DD7pxQjBCQgK0zySG51ZPhlseH7Af0YFEF
        hseoFbHwM5UWF+mtvFmYsQrVhI1cAlMvobSbjI+OvwbdoeuPfVRRV7Uw+bX1xr9WhhXPNv
        krhkIU2rr/SJgMCsFifgIvY1M/mkYJM=
Date:   Thu, 24 Sep 2020 23:51:36 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     vkoul@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        dan.j.williams@intel.com, tony.luck@intel.com, jing.lin@intel.com,
        ashok.raj@intel.com, fenghua.yu@intel.com, kevin.tian@intel.com,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 0/5] Add shared workqueue support for idxd driver
Message-ID: <20200924215136.GS5030@zn.tnic>
References: <20200924180041.34056-1-dave.jiang@intel.com>
 <a2a6f147-c4ad-a225-e348-b074a8017a10@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a2a6f147-c4ad-a225-e348-b074a8017a10@intel.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Thu, Sep 24, 2020 at 02:32:35PM -0700, Dave Jiang wrote:
> Hi Vinod,
> Looks like we are cleared on the x86 patches for this series with sign offs
> from maintainer Boris. Please consider the series for 5.10 inclusion. Thank
> you!

As I said here, I'd strongly suggest we do this:

https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org/thread/5FKNWNCCRV3AXUAEXUGQFF4EDQNANF3F/

and Vinod should merge the x86/pasid branch. Otherwise is his branch
and incomplete you could not have tested it properly.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
