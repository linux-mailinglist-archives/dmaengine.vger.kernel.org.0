Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FAD947212B
	for <lists+dmaengine@lfdr.de>; Mon, 13 Dec 2021 07:42:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230469AbhLMGmF (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 13 Dec 2021 01:42:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230491AbhLMGmE (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 13 Dec 2021 01:42:04 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FDB5C061748
        for <dmaengine@vger.kernel.org>; Sun, 12 Dec 2021 22:42:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9780AB80DAB
        for <dmaengine@vger.kernel.org>; Mon, 13 Dec 2021 06:42:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63D45C00446;
        Mon, 13 Dec 2021 06:42:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639377721;
        bh=R6LDbdkG4MjPEVMDS0DoVXfgxSuv74lYHx3ZsztXABM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sj9z6eWiDhLnrD8mraPeo7TmhzL5o1vh/nOloMXbj7SzUuEJ9pMq6xNWZA4qw5/p2
         OcyBF6oBlSIQ62yoaY5Y5Z8QxNIOj45kCcFfgio8srshwR2vooaLTnnTSv84MZkQ/6
         2yJrHddoQDjnk6KHs9m7CPhxWBSsMp+KaICVGCyjiXHWxP9LRTFR2lM9/aXWOquYQl
         HQliQjhxAQKXAWFlMLXFSV67OAon42MvGQ5a2g8o6Lki5UWb5S6jLiOD5kr8W20KzL
         xEAn4g6+lnl8CpXT9XU8Is7e+dyPNmT5XPmZDf9DbfgL5zn/CdE8NAnRumK4KqyM+U
         v5m8uxv1WOU+Q==
Date:   Mon, 13 Dec 2021 12:11:57 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     Sanjay Kumar <sanjay.k.kumar@intel.com>, dmaengine@vger.kernel.org
Subject: Re: [PATCH v2] dmaengine: idxd: add knob for enqcmds retries
Message-ID: <YbbrNeapx5GV1Bfa@matsya>
References: <163820629464.2702134.7577370098568297574.stgit@djiang5-desk3.ch.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <163820629464.2702134.7577370098568297574.stgit@djiang5-desk3.ch.intel.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 29-11-21, 10:19, Dave Jiang wrote:
> Add a sysfs knob to allow tuning of retries for the kernel ENQCMDS
> descriptor submission. While on host, it is not as likely that ENQCMDS
> return busy during normal operations due to the driver controlling the
> number of descriptors allocated for submission. However, when the driver is
> operating as a guest driver, the chance of retry goes up significantly due
> to sharing a wq with multiple VMs. A default value is provided with the
> system admin being able to tune the value on a per WQ basis.

Applied, thanks

-- 
~Vinod
