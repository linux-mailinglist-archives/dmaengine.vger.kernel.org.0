Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63A733CFB86
	for <lists+dmaengine@lfdr.de>; Tue, 20 Jul 2021 16:02:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238960AbhGTNV4 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 20 Jul 2021 09:21:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:36314 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239447AbhGTNSv (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 20 Jul 2021 09:18:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0AA6C6113B;
        Tue, 20 Jul 2021 13:50:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626789005;
        bh=UXL7Og6jkC/KEfhogXL0bEuB6NF9wI1aI+MlbEDUEjE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CSpCwS6wPQbpv1E4Gb2Z/8IsuHKW4g9WzFcgjTrMClC9RPz26hOZBkoTln06FdT70
         5BPh303dUANM2uLs6B48zzKKWxaKBPHjC3dEawnpOo+uCuwzWJ5OGabnYNbwdJt/CQ
         CBAsyF+enKDup0xnD8GM7zJFsAjFIOsXWcurGVQI+pABTNPmhjUP/AqCOrTTMlkAn8
         fBCi/RUn+UJ/BelmuG7s8XhJeYRBKip/yTxvajeKW6Qwhpz/syBBCmSEqnLfFle1sJ
         HhplCwj0cQHrqgTPbi102qpceRMr/HgpqX2J18tUuxn8JHpgunuVnv7RmyLVbdNntE
         9LGP0WImdqz0w==
Date:   Tue, 20 Jul 2021 19:20:02 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     dmaengine@vger.kernel.org
Subject: Re: [PATCH v2] dmaengine: idxd: remove fault processing code
Message-ID: <YPbUij/jce+BJGxc@matsya>
References: <162630502789.631986.10591230961790023856.stgit@djiang5-desk3.ch.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <162630502789.631986.10591230961790023856.stgit@djiang5-desk3.ch.intel.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 14-07-21, 16:25, Dave Jiang wrote:
> Kernel memory are pinned and will not cause faults. Since the driver
> does not support interrupts for user descriptors, no fault errors are
> expected to come through the misc interrupt. Remove dead code.

Applied, thanks

-- 
~Vinod
