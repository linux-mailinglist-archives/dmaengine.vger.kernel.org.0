Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F6293F8C43
	for <lists+dmaengine@lfdr.de>; Thu, 26 Aug 2021 18:34:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229810AbhHZQfI (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 26 Aug 2021 12:35:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:48988 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229787AbhHZQfI (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 26 Aug 2021 12:35:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EC02760F5B;
        Thu, 26 Aug 2021 16:34:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629995660;
        bh=qC/RN1zS0jNvQMr0T8BC0IKJNW5tFZLTpPAdIa6IsCk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cM8DdG6axFBjKZpF2eVH4Dxbmx9AyIN8SXiMBeZhGNfstl5hQixkM9p2BadZWiEmP
         WXBMApOVpQ5Pxb3Dmu/4H3Hwj1bDBRSRV0bUtnCml928weFs+g2tQmr/jeJWh27phj
         B/pmfDPVXnOHblvNBosGlYHqV5GFEv5/FwnBjlwbAoNvWZaBITB+LnuPvWJe7FSBN4
         Yn/B8Eac3lUofaERM+3XYyussiKZgpeFo4FGwqPxryfedwyClV/I3MDFB+AueGeRXa
         EeQRhOChDQREjSONsgFyaJ+MqCJfAqPMxgPPhv8cX8EgAQQYTb29w1hlPdrBvoXXkC
         qlHWzqd8WR8+A==
Date:   Thu, 26 Aug 2021 22:04:16 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>, dmaengine@vger.kernel.org
Subject: Re: [PATCH] dmaengine: idxd: fix calling wq quiesce inside spinlock
Message-ID: <YSfCiDjNRwenzcjD@matsya>
References: <162982483862.1664188.875626872795324832.stgit@djiang5-desk3.ch.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <162982483862.1664188.875626872795324832.stgit@djiang5-desk3.ch.intel.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 24-08-21, 10:07, Dave Jiang wrote:
> Dan reports that smatch has found idxd_wq_quiesce() is being called inside
> the idxd->dev_lock. idxd_wq_quiesce() calls wait_for_completion() and
> therefore it can sleep. Move the call outside of the spinlock.

Applied, thanks

-- 
~Vinod
