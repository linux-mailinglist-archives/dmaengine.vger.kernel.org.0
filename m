Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F5F63C7EDB
	for <lists+dmaengine@lfdr.de>; Wed, 14 Jul 2021 09:00:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238104AbhGNHC7 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 14 Jul 2021 03:02:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:53402 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237948AbhGNHC7 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 14 Jul 2021 03:02:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 89EAA60C3E;
        Wed, 14 Jul 2021 07:00:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626246008;
        bh=lHNg0iysF337OiXwGG94TrdZE89VjdLj+/N+TXsa/VU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=u3Gs+DjE+9V6j7tZNJ+cPy3UwuwKimee37Wyaa0azjZD/uqXfFYo2SSh7HT19CLxN
         BvqjxoE7coxOoXbIcJ7uBeMTl5dltqtEkeyM4KsXScMWBQyL2BRx4VRsLAefcwwwVC
         aoc6m2jvwi6QtdOgk0BcqN/opxc7uj1D3OxeND+olIYf2M/eEJKhvi8VEcBblvim06
         g2bPpKRF070wR9ipdr0Utvmzcg4v9/yUJcOOg3JpbgWVsMGJAg+VMfmNpmso+7WTfi
         uDjR0GHN+l12ZuAsCLLPSadhclJdQPCLi6Bfy6WjX1BMckZ1WY25A+BB/WbMQoc6Ak
         GTGqN61Lecs/A==
Date:   Wed, 14 Jul 2021 12:30:04 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     dmaengine@vger.kernel.org, Dave Jiang <dave.jiang@intel.com>,
        linux-um@lists.infradead.org,
        Johannes Berg <johannes.berg@intel.com>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] dmaengine: idxd: depends on !UML
Message-ID: <YO6LdCg2/4M47k7/@matsya>
References: <20210625103810.fe877ae0aef4.If240438e3f50ae226f3f755fc46ea498c6858393@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210625103810.fe877ae0aef4.If240438e3f50ae226f3f755fc46ea498c6858393@changeid>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 25-06-21, 10:38, Johannes Berg wrote:
> From: Johannes Berg <johannes.berg@intel.com>
> 
> Now that UML has PCI support, this driver must depend also on
> !UML since it pokes at X86_64 architecture internals that don't
> exist on ARCH=um.

Applied, thanks

-- 
~Vinod
