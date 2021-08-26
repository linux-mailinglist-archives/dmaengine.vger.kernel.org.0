Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23A003F8C47
	for <lists+dmaengine@lfdr.de>; Thu, 26 Aug 2021 18:34:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243072AbhHZQfY (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 26 Aug 2021 12:35:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:49042 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232711AbhHZQfX (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 26 Aug 2021 12:35:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 68F0D60FC0;
        Thu, 26 Aug 2021 16:34:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629995674;
        bh=z+/PxE1Vi1uNZFhwxbrm5sJPUauYKE7XAwWqog8zYgo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ixcL059TcO43kmr7iCMn0RkLRoZEKttAelyAhpDKL3J8KBNgF9QDQhbjhArLDH4Xg
         KKPaoEVNSkrCry+pYIacSnc7bbC0dFZYmL02LWHk82CVPsJy7Xy+s8PvVteoL6avaj
         cynYnceyhS6us51Re3jFUNFMRTOF4aAxnJ8zBV+j9bmvU02Lm1fiyDZFXWmPItZQbl
         lBLGQ1s/8Urjgvl3M+j9FNVUBQKLswCZ7itkOpFe8zblhmFqcOuWizDkPAvDzfbWqA
         g+750knEFgA+dhCoC9frqeknatOMUBhjbcc3bhT7+KtG1TEaTq8X+mYlmgAqh4I0O5
         ATg9k+JZ+2+Pg==
Date:   Thu, 26 Aug 2021 22:04:29 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     Dan Williams <dan.j.williams@intel.com>, dmaengine@vger.kernel.org
Subject: Re: [PATCH] dmaengine: idxd: remove interrupt disable for dev_lock
Message-ID: <YSfClXr/IDAptaSA@matsya>
References: <162984026772.1939166.11504067782824765879.stgit@djiang5-desk3.ch.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <162984026772.1939166.11504067782824765879.stgit@djiang5-desk3.ch.intel.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 24-08-21, 14:24, Dave Jiang wrote:
> The spinlock is not being used in hard interrupt context. There is no need
> to disable irq when acquiring the lock. The interrupt thread handler also
> is not in bottom half context, therefore we can also remove disabling of
> the bh. Convert all dev_lock acquisition to plain spin_lock() calls.

Applied, thanks

-- 
~Vinod
