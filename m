Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB1C23C7D9A
	for <lists+dmaengine@lfdr.de>; Wed, 14 Jul 2021 06:46:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237831AbhGNEti (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 14 Jul 2021 00:49:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:37580 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229451AbhGNEti (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 14 Jul 2021 00:49:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5354761260;
        Wed, 14 Jul 2021 04:46:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626238007;
        bh=kvU8z6mP3sL4H7OMGZ6J1TkAyBu5In8CTrQk0KXMTVI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FzbHWuBqxbSdg+q5k2VPteVFQujGA1F0UlB4bsRDCoFXFnC1pFdNq0EDsSpL0s4Qd
         KDihyzCjhnQCjel3VLVzni95e68XM1ZfSVVbu4FM8FmQ4sglLL2aRA2P1L8GcLVDMR
         NNZoujXmqpdmIl9KXqX2FYUMepO+vpVUc5oGQB1+myAChihRt6vxp5Leo3+b+T2/z0
         GJsSx9NCbiQXFRhbSUmSK0zjp3ENqoxP2U7Ekxngb3Tg4ZxOn6TncExsbm685RunnR
         ZtUQ8KOKbMGBSTmO0ZLLQl645NNF2IoDQPihPmijrLN3vXTaA4ywK58zTRvA2or6Jo
         dU+8ebIK6mYUA==
Date:   Wed, 14 Jul 2021 10:16:38 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        Viresh Kumar <vireshk@kernel.org>
Subject: Re: [PATCH v3 1/1] dmaengine: dw: Program xBAR hardware for Elkhart
 Lake
Message-ID: <YO5sLrMmkrjxffVh@matsya>
References: <20210712113940.42753-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210712113940.42753-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 12-07-21, 14:39, Andy Shevchenko wrote:
> Intel Elkhart Lake PSE DMA implementation is integrated with crossbar IP
> in order to serve more hardware than there are DMA request lines available.
> 
> Due to this, program xBAR hardware to make flexible support of PSE peripheral.
> 
> The Device-to-Device has not been tested and it's not supported by DMA Engine,
> but it's left in the code for the sake of documenting hardware features.

Applied, thanks

-- 
~Vinod
