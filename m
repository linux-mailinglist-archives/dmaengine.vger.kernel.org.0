Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F080D3698A2
	for <lists+dmaengine@lfdr.de>; Fri, 23 Apr 2021 19:45:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231400AbhDWRqc (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 23 Apr 2021 13:46:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:39500 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229691AbhDWRqc (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 23 Apr 2021 13:46:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 03E1F61404;
        Fri, 23 Apr 2021 17:45:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619199955;
        bh=te6gbiVsFycG/DzVBbSa//ghoSy8WlqKQPVlGffimCE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KvtwE9+lNuZytwcCZms0U8vJotk1uRw01D1p0aGr9UOEKYpsKvfTJogmBiY8Jr9Nr
         IqDqss1TVzUGdBY0EinfRXkvNgBm9zZSiFJnYZPxsBx0vQVRKpf79V+VCMNv/wLIsl
         q1MmUnCnoaVPd1ZYxHlE0mabp4ZjPa5pPPFZICLiQOcD6RvzfMr56MPGzIdxmzfih0
         SHRoDN0KO8D/AiH9V8O2T4q3OLDRMMpFhqoz0uX1j+oWRwPsnguoB2l/So1jMhQlge
         0Rb15+7qPRydHO2rPjHxV2j1mQZZGLC+n9yHWKeKi4lpZxa5PoHqE1yWD6SSH2Szjp
         78MjBjPthPFFg==
Date:   Fri, 23 Apr 2021 23:15:51 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Tom Zanussi <tom.zanussi@linux.intel.com>
Cc:     peterz@infradead.org, acme@kernel.org, mingo@kernel.org,
        kan.liang@linux.intel.com, dave.jiang@intel.com,
        tony.luck@intel.com, dan.j.williams@intel.com,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org
Subject: Re: [PATCH v3 0/2] dmaengine: idxd: IDXD pmu support
Message-ID: <YIMHzx6gerPEzbKJ@vkoul-mobl.Dlink>
References: <cover.1619033785.git.zanussi@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1619033785.git.zanussi@kernel.org>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 21-04-21, 16:04, Tom Zanussi wrote:
> Hi,
> 
> This is v3 of the IDXD pmu support patch, which addresses the comments
> from Vinod:
> 
>  - Removed the default line for INTEL_IDXD_PERFMON making it default 'n'
> 
>  - Replaced #ifdef CONFIG_INTEL_IDXD_PERFMON with IS_ENABLED()
> 
>  - Split the patch into two separate patches, the perfmon
>    implementation and the code that uses it in the IDXD driver.
> 
>  - Added a new file,
>    Documentation/ABI/testing/sysfs-bus-event_source-devices-dsa that
>    documents the new format and cpumask attributes, and added better
>    comments for those in the code.
> 
>  - Changed 'dogrp' to 'do_group' in perfmon_collect_events()
> 
>  - Moved 'int idx' inside the loop in perfmon_validate_group() to the
>    top of function.
> 
>  - In perfmon_pmu_read_counter(), return ioread64() directly and get
>    rid of cntrdata.
> 
> I also fixed some erroneous code in perfmon_counter_overflow() that
> because of my misreading of the spec caused unintended clearing of
> wrong bits.  According to the spec you need to write 1 rather than 0
> to an OVFSTATUS bit to clear it.

Applied, thanks

This conflicted with Daves patches, I managed to resolve, pls check the
end result

-- 
~Vinod
