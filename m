Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1DBC3F7461
	for <lists+dmaengine@lfdr.de>; Wed, 25 Aug 2021 13:31:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238127AbhHYLcf (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 25 Aug 2021 07:32:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:60952 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231852AbhHYLcf (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 25 Aug 2021 07:32:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 083046113C;
        Wed, 25 Aug 2021 11:31:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629891109;
        bh=MnKCKboAJAUUrSosplwk75lPCPblZiXztoeo1IeHRNo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FlkjiMgpaI4Y+mHVVSrtNJbnDsUcpl8PTKSRHIdMOxOoCNwGaMvfgwXWdISiYHJZh
         iA87354A7Jr38mXhk5l7aaglNxFomAB/yfF+de5hdIpdXwu7e0FaE+fMzd/6sltuAU
         AMeXQE3JaNRmylGboAz4fsplLX3dE9F2Dz4KqivVS0vidCksVVgzsTH/N1gjwCbHH1
         MVvb1gs4oEES5NFIHUvGucx9dClBmJumc/k5BCc26pcGKn5W4ts8lYmt4qwRw37Zpv
         z6qKiyo8qIOXa0Rx3UdrfArPOehEwvSJjXPZg6hOcBNG+7qrYZnn+KZ+P7j9puyvsI
         Spid80DYadwIg==
Date:   Wed, 25 Aug 2021 17:01:45 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     Dave Jiang <dave.jiang@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        dmaengine@vger.kernel.org, Johannes Berg <johannes.berg@intel.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] dmaengine: ioat: depends on !UML
Message-ID: <YSYqIXIw4VWDcM+c@matsya>
References: <20210809112409.a3a0974874d2.I2ffe3d11ed37f735da2f39884a74c953b258b995@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210809112409.a3a0974874d2.I2ffe3d11ed37f735da2f39884a74c953b258b995@changeid>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 09-08-21, 11:24, Johannes Berg wrote:
> From: Johannes Berg <johannes.berg@intel.com>
> 
> Now that UML has PCI support, this driver must depend also on
> !UML since it pokes at X86_64 architecture internals that don't
> exist on ARCH=um.

Applied, thanks

-- 
~Vinod
