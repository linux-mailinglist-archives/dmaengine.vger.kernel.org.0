Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B730B2B7D8C
	for <lists+dmaengine@lfdr.de>; Wed, 18 Nov 2020 13:23:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726954AbgKRMWE (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 18 Nov 2020 07:22:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:46122 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726505AbgKRMWE (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 18 Nov 2020 07:22:04 -0500
Received: from localhost (unknown [122.171.203.152])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6228A221FB;
        Wed, 18 Nov 2020 12:22:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605702123;
        bh=tIA/t6e122ugF/U3mrN8/HJnf0maNRhfg3eOvuIx+xk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tPpItYLiSMA23gTq1iUZDB2JJakHHe3OReEv5i8FYpWHQdQO/js66p4UJJ5ciL3Yg
         KiVBQ3TRlvGzvcfOHc3Ilb604mIWrloAn4YT6OFQknsw6HepxKi8Zy+hp1dqZIc2yJ
         rGUTLUbXkl9cCkteHWtbHB3QdO08h+mITeE/3jM8=
Date:   Wed, 18 Nov 2020 17:51:58 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Dave Jiang <dave.jiang@intel.com>, dmaengine@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] dmaengine: fix error codes in channel_register()
Message-ID: <20201118122158.GT50232@vkoul-mobl>
References: <20201113101631.GE168908@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201113101631.GE168908@mwanda>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 13-11-20, 13:16, Dan Carpenter wrote:
> The error codes were not set on some of these error paths.
> 
> Also the error handling was more confusing than it needed to be so I
> cleaned it up and shuffled it around a bit.

Applied, thanks

-- 
~Vinod
