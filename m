Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C45152DFDF8
	for <lists+dmaengine@lfdr.de>; Mon, 21 Dec 2020 17:23:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725841AbgLUQXh (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 21 Dec 2020 11:23:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:49546 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725777AbgLUQXh (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 21 Dec 2020 11:23:37 -0500
Date:   Mon, 21 Dec 2020 21:52:52 +0530
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608567777;
        bh=FxafiOgAtDvnr793G7zzB+02/B2yMfXQsmB8jWeRr4o=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=XbIihV1P1tYyeoP5ARa54K+gR7vt4W3B0VWCt62Dlh6E4fsad7OOER84/VifX3mrv
         3DtDKAIT5DcuYWsPkSGdrMtyMRgylt1DkntxmjhrcUOHm9C+A/q/5j/QhoKGrrmBFS
         Rdxj+DsQev7pzclTibOBFxWbv38SUSXmZllblvX0DtJZcpANxXi3mg4mOfy6zriaOm
         vcSTYugkYJSVgFnk51KUlHAAGo4SjILPqweo46d3C92WY6t8Ne7y85vANfwxTbP5x0
         En8r+EIE5fozX0mob+9SB0qGpKGY8Bx+T+f2yQ+i1Ip1Tx97LNhhqgHBsAvXrNdui8
         oqdo/oqCU4VPQ==
From:   Vinod Koul <vkoul@kernel.org>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Dan Williams <dan.j.williams@intel.com>,
        dmaengine@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] dmaengine: dw-edma: Fix use after free in
 dw_edma_alloc_chunk()
Message-ID: <20201221162252.GH3323@vkoul-mobl>
References: <X9dTBFrUPEvvW7qc@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <X9dTBFrUPEvvW7qc@mwanda>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 14-12-20, 14:56, Dan Carpenter wrote:
> If the dw_edma_alloc_burst() function fails then we free "chunk" but
> it's still on the "desc->chunk->list" list so it will lead to a use
> after free.  Also the "->chunks_alloc" count is incremented when it
> shouldn't be.
> 
> In current kernels small allocations are guaranteed to succeed and
> dw_edma_alloc_burst() can't fail so this will not actually affect
> runtime.

Applied, thanks

-- 
~Vinod
