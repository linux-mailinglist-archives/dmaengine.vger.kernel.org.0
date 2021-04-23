Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2A1836994F
	for <lists+dmaengine@lfdr.de>; Fri, 23 Apr 2021 20:23:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232238AbhDWSXo (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 23 Apr 2021 14:23:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:41712 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231400AbhDWSXo (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 23 Apr 2021 14:23:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 838A0613C9;
        Fri, 23 Apr 2021 18:23:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619202187;
        bh=fLCjhlIuPWn7MAEV2Muf/CrOpU3o8rqRl01jZfFAHoA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lzblvx4rchzW63W2sAv9wqPCf85bbR37YSE6BY5v7pcbTmpfumrqXiwA0JfCZC3IT
         7oYy8scg+m2MAryZOMfdXKOIdcQ9MyZgxDkscSHJRSpmCv3ArgU4L9AdNQM5bYLVos
         hXBiKc0HKVGzhwU+yruVB5UWrTAeeH0H4oHSRT5ozYNBtXItO3ard2X/Wxr8HO5hoT
         4G3rxreK8IqQH1aof5DrT8sQI1ioCebt75eVsaHZ8nnpwbmWIA1pS4b+0/wdJ0pHl1
         +MXm+ZKvjhWPk/+CdkSoxurZxzSFywlWYHAGb+IKSF4S8fNRRbo/ht95yHer3yGBJn
         7DH7YkMBic64Q==
Date:   Fri, 23 Apr 2021 23:53:03 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     "Zanussi, Tom" <tom.zanussi@linux.intel.com>
Cc:     peterz@infradead.org, acme@kernel.org, mingo@kernel.org,
        kan.liang@linux.intel.com, dave.jiang@intel.com,
        tony.luck@intel.com, dan.j.williams@intel.com,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org
Subject: Re: [PATCH v3 0/2] dmaengine: idxd: IDXD pmu support
Message-ID: <YIMQh0oTpJaRQrxj@vkoul-mobl.Dlink>
References: <cover.1619033785.git.zanussi@kernel.org>
 <YIMHzx6gerPEzbKJ@vkoul-mobl.Dlink>
 <d46d7b54-7d2f-4bdc-74f2-2077409f1996@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d46d7b54-7d2f-4bdc-74f2-2077409f1996@linux.intel.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 23-04-21, 13:15, Zanussi, Tom wrote:
 
> > Applied, thanks
> > 
> > This conflicted with Daves patches, I managed to resolve, pls check the
> > end result
> > 
> 
> Thanks!
> 
> However, it looks like the new files in '[PATCH v3 1/2] dmaengine: idxd: Add
> IDXD performance monitor support' didn't make it in, maybe didn't get 'added'
> after resolving the conflicts...

Right, i have added and updated the commit and pushed again

Thanks for letting me know

-- 
~Vinod
