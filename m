Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6AA0206BF1
	for <lists+dmaengine@lfdr.de>; Wed, 24 Jun 2020 07:48:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388307AbgFXFsi (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 24 Jun 2020 01:48:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:57350 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726133AbgFXFsi (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 24 Jun 2020 01:48:38 -0400
Received: from localhost (unknown [171.61.66.58])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3DCAC20768;
        Wed, 24 Jun 2020 05:48:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592977718;
        bh=V0kTgj0av9Ob5bDFWswnxUYMqYvVa0vyhIvVqzpat+A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=khFWUz+g+01KzKssLnz096lRYp4v87frwMUWAvqzd7iL84JuvMaEEmZXQxENUHCOo
         PY3tvzqajnGBS3l2vOds/fr6PKeWxpeKLAS7v7wPohEYZOHqZZPZl/ziqfTL2NJvqC
         mIl+5GsvpIL9RQWlBUY96rArp/YjibSlqQ4b3dUI=
Date:   Wed, 24 Jun 2020 11:18:34 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     Nikhil Rao <nikhil.rao@intel.com>, dmaengine@vger.kernel.org
Subject: Re: [PATCH v3] dmaengine: idxd: fix cdev locking for open and release
Message-ID: <20200624054834.GW2324254@vkoul-mobl>
References: <159285824892.64944.2905413694915141834.stgit@djiang5-desk3.ch.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <159285824892.64944.2905413694915141834.stgit@djiang5-desk3.ch.intel.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 22-06-20, 13:38, Dave Jiang wrote:
> From: Nikhil Rao <nikhil.rao@intel.com>
> 
> add the wq lock in cdev open and release call. This fixes
> race conditions observed in the open and close routines.
> 
> Fixes: 42d279f9137a ("dmaengine: idxd: add char driver to expose submission portal to userland")
> 

Please don't keep blank lines b/w Fixes and S-o-b lines!

> Signed-off-by: Nikhil Rao <nikhil.rao@intel.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>

Applied after fixing the blank line, thanks
-- 
~Vinod
