Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F386E3D8DC6
	for <lists+dmaengine@lfdr.de>; Wed, 28 Jul 2021 14:28:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234847AbhG1M2M (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 28 Jul 2021 08:28:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:36446 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234701AbhG1M2L (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 28 Jul 2021 08:28:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8D61C60F9C;
        Wed, 28 Jul 2021 12:28:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627475289;
        bh=4aNEytFSABJYHROcCo+oRx9PuIV4JUJQ8MPdgzMR1BQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=J5181pHiRBALrT/G97vYVTotJtGrEtgYtGHIAjfKx2nNakp42iG+Ywg7xeSUDkTJC
         g05fJsxnmSQDJ8lnB5iIdpl3FwArABgxpLrWwrUxygJ5MMOsrbYoGcuTDT2U+msVs1
         T9AdcIwt6Nho9l0nuA+mtyDLcouuKJIPGweFC5ss6HG28WCYxs9BHRLpsvKyTfq9V7
         DeD6sLMGNV7WN/VcJ8m70QwlWm9aqJV4bGI+/rXFcKU7fx1rWKu1nXyB5WRC/V1QWm
         ve35mJfI6MWTyFC9KDV55OFU26FmmuKe7ddzTWQ48ZW7o72KIiaGCc/8cUg43sHA7C
         kUTD6/kBc8t8w==
Date:   Wed, 28 Jul 2021 17:58:05 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     dmaengine@vger.kernel.org
Subject: Re: [PATCH] dmaengine: idxd: fix wq slot allocation index check
Message-ID: <YQFNVXlOrC4D9rBG@matsya>
References: <162697645067.3478714.506720687816951762.stgit@djiang5-desk3.ch.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <162697645067.3478714.506720687816951762.stgit@djiang5-desk3.ch.intel.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 22-07-21, 10:54, Dave Jiang wrote:
> The sbitmap wait and allocate routine checks the index that is returned
> from sbitmap_queue_get(). It should be idxd >= 0 as 0 is also a valid
> index. This fixes issue where submission path hangs when WQ size is 1.

Applied, thanks

-- 
~Vinod
