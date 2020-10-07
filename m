Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB6792861A3
	for <lists+dmaengine@lfdr.de>; Wed,  7 Oct 2020 16:57:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728695AbgJGO5i (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 7 Oct 2020 10:57:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:46726 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728637AbgJGO5i (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 7 Oct 2020 10:57:38 -0400
Received: from localhost (unknown [122.171.222.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A575D208C7;
        Wed,  7 Oct 2020 14:57:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602082657;
        bh=wIcXFjhZxCeccJiCkDxVl1EfNetAPIAHSc0z5zqJCWs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=i0mZpjcHeSqakiy7mEHoi7clyC6vORoq7m/JAlcURG4oAKLggkALupTGMdyE+Knd4
         JqWmp7TG/sA+GMaQgMgq+VUcY9NhC2QdCq3VfQqi3HwZRumU5L9OMKUAdp81t9hYIS
         9N0OwxFpU3PD+OvBvEqLuTZjyJdEAtw1SpL+xF50=
Date:   Wed, 7 Oct 2020 20:27:33 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Dave Jiang <dave.jiang@intel.com>, dan.j.williams@intel.com,
        tony.luck@intel.com, ashok.raj@intel.com, kevin.tian@intel.com,
        fenghua.yu@intel.com, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 0/5] Add shared workqueue support for idxd driver
Message-ID: <20201007145733.GX2968@vkoul-mobl>
References: <20201005151126.657029-1-dave.jiang@intel.com>
 <20201007070132.GT2968@vkoul-mobl>
 <20201007084856.GE5607@zn.tnic>
 <20201007095313.GV2968@vkoul-mobl>
 <20201007100426.GF5607@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201007100426.GF5607@zn.tnic>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 07-10-20, 12:04, Borislav Petkov wrote:
> On Wed, Oct 07, 2020 at 03:23:13PM +0530, Vinod Koul wrote:
> > Right my build failed for x86 and I have dropped these now. I would have
> > expected the dependency to be a signed tag to be cross merged when I was
> > asked to merge this.
> 
> I can give you a signed tag is you prefer but that's usually not

That would be better, signed tags are preferred

> necessary. You can simply merge tip's x86/pasid branch, then apply those
> ontop and test.

While at it, it would be good if x86 patches of this series come from
your tree, that makes more sense if we are doing a cross merge

Thanks
-- 
~Vinod
