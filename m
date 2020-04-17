Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EA881ADCC9
	for <lists+dmaengine@lfdr.de>; Fri, 17 Apr 2020 13:59:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730559AbgDQL7B (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 17 Apr 2020 07:59:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:54310 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730536AbgDQL7A (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 17 Apr 2020 07:59:00 -0400
Received: from localhost (unknown [223.235.195.235])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CA06C2078E;
        Fri, 17 Apr 2020 11:58:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587124740;
        bh=Aprbi/9luBFOOOlSs7z6d13WlhqpFLi/llfRAm/Yr+s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BYVgEsBMMDaQz/nkxwqdId8LDIS9qtDWoGkz7uqJCosA/bfbMf8y7ILbHAeYZMBGU
         qoB6LzD4ZZ/1wLLSgvJ/uqQKhxi42dF3WedHwIMabGNKdflC6OSzUS/IRJEFkix2vv
         RYnjktPcKKdtPhdl3VeCb7ekvzBRv13K0Vmuu3M0=
Date:   Fri, 17 Apr 2020 17:28:56 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     leonid.ravich@dell.com
Cc:     dmaengine@vger.kernel.org, lravich@gmail.com,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexios Zavras <alexios.zavras@intel.com>,
        "Alexander.Barabash@dell.com" <Alexander.Barabash@dell.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Jilayne Lovejoy <opensource@jilayne.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] dmaengine: ioat: fixing chunk sizing macros
 dependency
Message-ID: <20200417115856.GP72691@vkoul-mobl>
References: <20200402163356.9029-2-leonid.ravich@dell.com>
 <20200416170628.16196-1-leonid.ravich@dell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200416170628.16196-1-leonid.ravich@dell.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 16-04-20, 20:06, leonid.ravich@dell.com wrote:
> From: Leonid Ravich <Leonid.Ravich@emc.com>
> 
> changing macros which assumption is chunk size of 2M,
> which can be other size
> prepare for changing allocation chunk size.

Applied both, thanks
-- 
~Vinod
