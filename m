Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42FD13D8DC4
	for <lists+dmaengine@lfdr.de>; Wed, 28 Jul 2021 14:27:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234847AbhG1M16 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 28 Jul 2021 08:27:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:36348 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234701AbhG1M15 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 28 Jul 2021 08:27:57 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5E01960F9D;
        Wed, 28 Jul 2021 12:27:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627475276;
        bh=oY3YmiR7sro2PswKmXbpBhYm1OLXYjNMMfgABUICKjg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cNfQ+GO3uiV3HaGj8bzYGl1JIB/pBLMO9mPg75NJQeYZtMsuGLN2HgZHMpj7/01m+
         AtNOHBRPdU7FWkpMjzwmEZHFFrxFTFte/o731uzfSk2uNw8NDMUGhEvBz9RWMzqlX0
         SmWkj5INJO5d3SYsBaRjqRMWDyBm8oyEHhjVDK3hEXYh21E8TIcfRxKNWw9Be1Cmmd
         8jkmiQDAJ4+05NDwx+HGnHsRGJYRiTDKvgzcz5kdaV1SLEBCBTmptSuy2pdKegLre+
         auuA1bWxwEyBI3+TLvq6NYNzA5QSHeVNOS5gkP+5My4dYI/P7Nq02OMD6Wk+sEtlx3
         8Z1NTb6cg/uKw==
Date:   Wed, 28 Jul 2021 17:57:52 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     dmaengine@vger.kernel.org
Subject: Re: [PATCH] dmaengine: idxd: fix uninit var for alt_drv
Message-ID: <YQFNSDFOuNasnGKj@matsya>
References: <162689250332.2114335.636367120454420852.stgit@djiang5-desk3.ch.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <162689250332.2114335.636367120454420852.stgit@djiang5-desk3.ch.intel.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 21-07-21, 11:35, Dave Jiang wrote:
> 0-day detected uninitialized alt_drv variable in the bind_store() function.
> The branch can be taken when device is not idxd device or wq 'struct
> device'. Init alt_drv to NULL.

Applied, thanks

-- 
~Vinod
