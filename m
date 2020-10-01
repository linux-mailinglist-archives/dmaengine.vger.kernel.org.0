Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9869E27FA4A
	for <lists+dmaengine@lfdr.de>; Thu,  1 Oct 2020 09:31:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725938AbgJAHbB (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 1 Oct 2020 03:31:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725921AbgJAHbB (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 1 Oct 2020 03:31:01 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1701C0613D0;
        Thu,  1 Oct 2020 00:31:00 -0700 (PDT)
Received: from zn.tnic (p200300ec2f089d0019d474baa5172353.dip0.t-ipconnect.de [IPv6:2003:ec:2f08:9d00:19d4:74ba:a517:2353])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 2C4651EC0494;
        Thu,  1 Oct 2020 09:30:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1601537459;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=0ShZgFz8rfNSDpK4iRIk/0isFaGhmqt+3jT+eWbAhU4=;
        b=LXiDUti1s1cZbUpgXSmi22Aoltb7aTl3wewWWkhNh4qVthMnpdy8c6PSw9gTOXo2Ej34CF
        kLVb/oB8j0ir+N7UKZfSwX7vD/4LAs3RMzU32rYuy60qdGbNaOk0l57a8DinUa1/BRO3j3
        4jNxS2XrNfm7FCnWfx72fhlis14KFHA=
Date:   Thu, 1 Oct 2020 09:30:49 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Dave Jiang <dave.jiang@intel.com>, dan.j.williams@intel.com,
        tony.luck@intel.com, jing.lin@intel.com, ashok.raj@intel.com,
        fenghua.yu@intel.com, kevin.tian@intel.com,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 0/5] Add shared workqueue support for idxd driver
Message-ID: <20201001073049.GA17683@zn.tnic>
References: <20200924180041.34056-1-dave.jiang@intel.com>
 <a2a6f147-c4ad-a225-e348-b074a8017a10@intel.com>
 <20200924215136.GS5030@zn.tnic>
 <4d857287-c751-8b37-d067-b471014c3b73@intel.com>
 <20201001042908.GO2968@vkoul-mobl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201001042908.GO2968@vkoul-mobl>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Thu, Oct 01, 2020 at 09:59:08AM +0530, Vinod Koul wrote:
> I was out for last few days, so haven't checked on this yet, but given
> that we are very close to merge widow I fear it is bit late to merge
> this late.

There is time because we will have -rc8 so you have an additional week.

> I will go thru the series today though..

If you do and you wanna take them, I'd suggest this:

https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org/message/P4TZ4AU6MBIPT2OROPDOKEN7U2QCS7FX/

(it's on the same thread).

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
