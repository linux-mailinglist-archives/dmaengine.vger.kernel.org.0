Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 000BA3E428A
	for <lists+dmaengine@lfdr.de>; Mon,  9 Aug 2021 11:22:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234255AbhHIJWp (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 9 Aug 2021 05:22:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234180AbhHIJWo (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 9 Aug 2021 05:22:44 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC171C0613CF
        for <dmaengine@vger.kernel.org>; Mon,  9 Aug 2021 02:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=d3BncnrCAXNnuK2nAENrl+5xP+0HPMsrLNcL+uNpbvw=;
        t=1628500944; x=1629710544; b=EvzQmQlONwoFE/BAGC8zPLeFNt5+6pE1LMnc6fov+69N4yP
        aTetPNHd8k2sc+DsRE1WBFQLUx5dYG6zycnBdJfTWR5AG/BjR6lKoK4q9mlcU9AyBx5bPVgHXHf5f
        Oj+QXjZrfEntrnRyUAkfQbR9RsllhQ7MH7aUCCLM8WzabzcAt3qMARQR7mP05SSWkGdtwHQ4K6Gfn
        r+U8O9HVOa4NW8HW/TLL2Z9ksh2dmP8tK9CvHJ028oFjecShk11+8XYF0yOK0Psf/Ykwa9r2PmpI1
        eyvfJEZc3awgdyedJvcJOjdk2qfH5bkEAETxRKrvFCKzfZw5rhKkWLUF/KLtlM0w==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94.2)
        (envelope-from <johannes@sipsolutions.net>)
        id 1mD1RD-0083jI-UL; Mon, 09 Aug 2021 11:21:54 +0200
Message-ID: <09b654a819dc2985ee18419931a710572bf2b8f9.camel@sipsolutions.net>
Subject: Re: [PATCH] dmaengine: idxd: depends on !UML
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     dmaengine@vger.kernel.org, Dave Jiang <dave.jiang@intel.com>,
        linux-um@lists.infradead.org, kernel test robot <lkp@intel.com>
Date:   Mon, 09 Aug 2021 11:21:53 +0200
In-Reply-To: <YO6LdCg2/4M47k7/@matsya>
References: <20210625103810.fe877ae0aef4.If240438e3f50ae226f3f755fc46ea498c6858393@changeid>
         <YO6LdCg2/4M47k7/@matsya>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Wed, 2021-07-14 at 12:30 +0530, Vinod Koul wrote:
> On 25-06-21, 10:38, Johannes Berg wrote:
> > From: Johannes Berg <johannes.berg@intel.com>
> > 
> > Now that UML has PCI support, this driver must depend also on
> > !UML since it pokes at X86_64 architecture internals that don't
> > exist on ARCH=um.
> 
> Applied, thanks

Thanks.

Any reason this hasn't landed in Linus's tree yet? I keep getting build
failure reports from there.

johannes

