Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 911061FCEF9
	for <lists+dmaengine@lfdr.de>; Wed, 17 Jun 2020 16:00:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726927AbgFQN7q (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 17 Jun 2020 09:59:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:49944 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726920AbgFQN7p (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 17 Jun 2020 09:59:45 -0400
Received: from localhost (unknown [171.61.66.58])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E1A4E20776;
        Wed, 17 Jun 2020 13:59:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592402384;
        bh=0Lz6TFQhfGp4bkoSVLTJgIT/broxuaK6TXcJSsj1HDM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LMOFazE11y2j35ElYwUhFG1c7RveWXp6JEzTsPUId8PCinClymu6lifqi+kjEA+7N
         ROrH8zIGYsAXahTZqkbHkC2tTE3RRK/NU6u4KzYYp8wNMheVO4SJyvikQNeLSb7Czv
         ZpkSIhit1bCec9vwK1O92LKaEcWlRVt/o5J2bQl0=
Date:   Wed, 17 Jun 2020 19:29:40 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Navid Emamdoost <navid.emamdoost@gmail.com>
Cc:     Markus Elfring <Markus.Elfring@web.de>, dmaengine@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Navid Emamdoost <emamd001@umn.edu>, Kangjie Lu <kjlu@umn.edu>,
        Stephen McCamant <smccaman@umn.edu>,
        Qiushi Wu <wu000273@umn.edu>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] dmaengine: stm32-mdma: call pm_runtime_put if
 pm_runtime_get_sync fails
Message-ID: <20200617135940.GU2324254@vkoul-mobl>
References: <873bfb31-52d8-7c9b-5480-4a94dc945307@web.de>
 <CAEkB2ET_gfNUAuoZHxiGWZX7d3CQaJYJJqS2Fspif5mFq4-xfA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEkB2ET_gfNUAuoZHxiGWZX7d3CQaJYJJqS2Fspif5mFq4-xfA@mail.gmail.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 03-06-20, 14:17, Navid Emamdoost wrote:
> On Wed, Jun 3, 2020 at 1:52 PM Markus Elfring <Markus.Elfring@web.de> wrote:
> >
> > > Calling pm_runtime_get_sync increments the counter even in case of
> > > failure, causing incorrect ref count. Call pm_runtime_put if
> > > pm_runtime_get_sync fails.
> >
> > Is it appropriate to copy a sentence from the change description
> > into the patch subject?
> >
> > How do you think about a wording variant like the following?
> Please stop proposing rewording on my patches!
> 
> I will consider updating my patches only if a maintainer asks for it.

Yeah ignore these :) no one takes this 'bot' seriously, it is annoying
yes :(

> >
> >    The PM runtime reference counter is generally incremented by a call of
> >    the function “pm_runtime_get_sync”.
> >    Thus call the function “pm_runtime_put” also in two error cases
> >    to keep the reference counting consistent.
> >
> >
> > Would you like to add the tag “Fixes” to the commit message?
> >
> > Regards,
> > Markus
> 
> 
> 
> -- 
> Navid.

-- 
~Vinod
