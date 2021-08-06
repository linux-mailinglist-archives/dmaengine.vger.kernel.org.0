Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E76283E2BFF
	for <lists+dmaengine@lfdr.de>; Fri,  6 Aug 2021 15:54:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234328AbhHFNyt (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 6 Aug 2021 09:54:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:49966 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233639AbhHFNyr (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 6 Aug 2021 09:54:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8E14860F70;
        Fri,  6 Aug 2021 13:54:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628258071;
        bh=nlDm/Ql8glluUlndON8D9b+7iOfg/vTaaE79jk4lb4A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qpnzIhZSB3VPIv7J217H7sZQz6sXJa8sV56cvcIke0OIIwW9aB5Y72tRGSPyuvUJO
         rio2fUCEPpSTMj86p/R/uFA/MCRNPt1Xcu5GqJUcHIfW/kylDdJ2bhM7QXwQKibtcX
         wX/ne30mvn2Ih9eNPLExV0WB5Ex8SCwHkjMymeb0NKsXH9sGr/I6CsxfwQ/zsyBSxs
         lNr6FMJymQ7ZfuJNKcWv63LJE1S8hQbbcC6NmAirwmNinbexanyrb243d+ynEgG6Bl
         K/iRhDeYJYLKe8Ii8HYpFbwh7o5ZvnjpyD/a2z+DQgdCTKJyx9ft2kWPu15yXxUEp8
         4pPnBLKE+kWsg==
Date:   Fri, 6 Aug 2021 19:24:27 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     Dan Williams <dan.j.williams@intel.com>, dmaengine@vger.kernel.org
Subject: Re: [PATCH] dmaengine: idxd: remove interrupt flag for completion
 list spinlock
Message-ID: <YQ0/E2K3LfNHJNvY@matsya>
References: <162802979477.3084429.740142217347422000.stgit@djiang5-desk3.ch.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <162802979477.3084429.740142217347422000.stgit@djiang5-desk3.ch.intel.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 03-08-21, 15:29, Dave Jiang wrote:
> The list lock is never acquired in interrupt context. Therefore there is no
> need to disable interrupts. Remove interrupt flags for lock operations.

This fails to apply, pls rebase

-- 
~Vinod
