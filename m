Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BA80F2474D
	for <lists+dmaengine@lfdr.de>; Tue, 21 May 2019 07:08:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725885AbfEUFIc (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 21 May 2019 01:08:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:57502 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725804AbfEUFIc (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 21 May 2019 01:08:32 -0400
Received: from localhost (unknown [106.201.107.13])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 16C3E2173E;
        Tue, 21 May 2019 05:08:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558415311;
        bh=yVLbB8CTaH641zG15izNG1yqrXsL1HSUFhBobS8zl2k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WPAB5yNTekzn7LIyqGMR5cob+Au7IP7PjU6X+9+hz0z1KBC3ddHpnztxbW68fnODl
         pB4tVkioOU7rYsF2w2g3xF1InmuK+bOmMdfqKxLZxwZ5JH6yi4SxHj7Evli7UztfKQ
         Xz3V8Neyp9o3sbuMG3Hbxc3uAvZIv9ECet+JyHCI=
Date:   Tue, 21 May 2019 10:38:28 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     dmaengine@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH] dmaengine: axi-dmac: Sanity check memory mapped
 interface support
Message-ID: <20190521050828.GU15118@vkoul-mobl>
References: <20190516083134.29460-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190516083134.29460-1-alexandru.ardelean@analog.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 16-05-19, 11:31, Alexandru Ardelean wrote:
> From: Lars-Peter Clausen <lars@metafoo.de>
> 
> The AXI-DMAC supports different types of interface for the data source and
> destination ports. Typically one of those ports is a memory-mapped
> interface while the other is some kind of streaming interface.
> 
> The information about which kind of interface is used for each port is
> encoded in the devicetree.
> 
> It is also possible in the driver to detect whether a port supports
> memory-mapped transfers or not. For streaming interfaces the address
> register is read-only and will always return 0. So in order to check if a
> port supports memory-mapped transfers write a non-zero value to the
> corresponding address register and check that the value read-back is still
> non zero.
> 
> This allows to detect mismatches between the devicetree description and the
> actual hardware configuration.
> 
> Unfortunately it is not possible to autodetect the interface types since
> there is no method to distinguish between the different streaming ports. So
> the best thing that can be done is to error out when a memory mapped port
> is described in the devicetree but none is detected in the hardware.

Applied, thanks

-- 
~Vinod
