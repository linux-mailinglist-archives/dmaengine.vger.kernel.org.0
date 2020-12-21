Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79B012DFC7C
	for <lists+dmaengine@lfdr.de>; Mon, 21 Dec 2020 14:59:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726268AbgLUN7w (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 21 Dec 2020 08:59:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:44868 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726127AbgLUN7v (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 21 Dec 2020 08:59:51 -0500
Date:   Mon, 21 Dec 2020 19:29:05 +0530
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608559151;
        bh=3ZAmEitTCsexx/51HtE9t/c0rky6LhobvkdB5sVl5sM=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZjONlJTHHCY2wgcC5QY1lJ/xQ6TrR4vG6z/pBhsTGSONkemgNGHUfBiBVY0cCuiHW
         EvCPC/KZ7MAo6brN/1afejx8nFHPmWzpzOh9s4Nkp7oxbbdodq5rLgZB/DwediBmvq
         YmrsLX2qo7x4BrhJZFoQ0QdRYiGex02Imsxx5ws4Xt70kTyMp0Oa6sDbuu9SgQLAcS
         5ivrj5rJ9eMhKJL3+io/zQDe9U0vf54wPeIdlrO5SlG58x15bI4HJc/YBIWmyXzzTo
         LVhbEtAfb19UY7cwsFEZ+sdAD8wi8gLeDU/miXge9pHM3lBjaJNzaN3ORM2G3AlqTY
         Gi3/k/Fnk1Bwg==
From:   Vinod Koul <vkoul@kernel.org>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Dave Jiang <dave.jiang@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        dmaengine@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] dmaengine: idxd: off by one in cleanup code
Message-ID: <20201221135905.GB3323@vkoul-mobl>
References: <X9nFeojulsNqUSnG@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <X9nFeojulsNqUSnG@mwanda>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 16-12-20, 11:29, Dan Carpenter wrote:
> The clean up is off by one so this will start at "i" and it should start
> with "i - 1" and then it doesn't unregister the zeroeth elements in the
> array.

Applied, thanks

-- 
~Vinod
