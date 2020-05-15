Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8EAF1D456B
	for <lists+dmaengine@lfdr.de>; Fri, 15 May 2020 07:52:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726711AbgEOFw5 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 15 May 2020 01:52:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:53066 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725899AbgEOFw4 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 15 May 2020 01:52:56 -0400
Received: from localhost (unknown [122.178.196.30])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C29E42054F;
        Fri, 15 May 2020 05:52:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589521976;
        bh=BQHvKwNQzpnlROsgq/uHuHlCEp7lx8JwC/lskmlPpk0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=I8m3nDSJvCTyW+Y+sFxmr3ratMCbZfTHyz0NpSZIrBXSIRQZftr0OoJuobD6kcKkQ
         qVMkW8NcD3WOYH11XX/ghnNLzipqTSgU4cGfqf9L6CQPH9sy1MFx9C8iD3TYWQay00
         mne5eJrAkwvYZy4e4NdWK0SdPqhnipRggvCByFOw=
Date:   Fri, 15 May 2020 11:22:52 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     dmaengine@vger.kernel.org, dan.j.williams@intel.com
Subject: Re: [PATCH] dmaengine: ti: k3-udma: Use proper return code in
 alloc_chan_resources
Message-ID: <20200515055252.GB333670@vkoul-mobl>
References: <20200512134519.5642-1-peter.ujfalusi@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200512134519.5642-1-peter.ujfalusi@ti.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 12-05-20, 16:45, Peter Ujfalusi wrote:
> In udma_alloc_chan_resources() if the channel is not willing to stop then
> the function should return with error code.

Applied, thanks

-- 
~Vinod
