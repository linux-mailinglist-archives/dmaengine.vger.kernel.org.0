Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D2232D5499
	for <lists+dmaengine@lfdr.de>; Thu, 10 Dec 2020 08:29:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729099AbgLJH14 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 10 Dec 2020 02:27:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:41176 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725953AbgLJH1x (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 10 Dec 2020 02:27:53 -0500
Date:   Thu, 10 Dec 2020 12:57:04 +0530
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607585230;
        bh=T44M7rMVzMDmACdtO2rhnV4KpFUk3jxPkSIxMOM+OZw=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=WBlTsixDpEK/S2eXzL4/OLQLr/sDspWXi9rCmc9A2Ps+pbO+1fbCVfK0xtQ1bBUbu
         /O5B2h5SRCZmig9wXWytoDEPJi9eJdCKOoQltEuVqyb6LjCNtXVpJkNasTlESHoWhW
         5bBjunAlCm+29kuT5urhAl7IXVPLlIYOJjvWNlNp7CrM9ebKpTsbt0F516PG3f59Vj
         EpXeEDbDS5rM6bs+RM3EE/fvhQw0PQGBgi67hit9e+QZJ1cYZ6UCOAtEVKRrbtIJMb
         KZ40Zbaf56nx6yIuKY2oGWIRcTQbsoNWpjyCcHij2zPqQmNsgKTVb7GX3u7b39UkGo
         bk+6lM3p0EPSQ==
From:   Vinod Koul <vkoul@kernel.org>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     dmaengine@vger.kernel.org
Subject: Re: [PATCH] dmaengine: idxd: add ATS disable knob for work queues
Message-ID: <20201210072704.GN8403@vkoul-mobl>
References: <160530810593.1288392.2561048329116529566.stgit@djiang5-desk3.ch.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <160530810593.1288392.2561048329116529566.stgit@djiang5-desk3.ch.intel.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 13-11-20, 15:55, Dave Jiang wrote:
> With the DSA spec 1.1 update, a knob to disable ATS for individually is
> introduced. Add enabling code to allow a system admin to make the
> configuration through sysfs.

Applied, thanks

-- 
~Vinod
