Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BA118B788C
	for <lists+dmaengine@lfdr.de>; Thu, 19 Sep 2019 13:37:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389941AbfISLhO (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 19 Sep 2019 07:37:14 -0400
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:39027 "EHLO
        wout4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389926AbfISLhN (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 19 Sep 2019 07:37:13 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id E801D55D;
        Thu, 19 Sep 2019 07:37:11 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Thu, 19 Sep 2019 07:37:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=ZARt8hsAD051BiaNqNy7562HyN8
        dnfaPuX2yAo3nA44=; b=NA+ZP2sCRY3gy1Z0H31SNqMbZtdSvGuIuKgu1+xfrf/
        G20FIsW6V/ZoDwIT8atOKwEO+IWw4xekjBqWpu8bkHs0V0eCW94kvvNBBzGlK6pP
        yH1kd9H0yBQXSCsKUr511xLNQsEPK9Nvhuz8t2P+qpWdOnURyeiGL1Gff4/aEWfm
        xCcp+chkIH4V8N/nu7wO6qeuIZvYu8BhzrxkMudAyddYDOpt5lrVgwzLK/1jc6U/
        lpO3Ajngy4dPoitb/TeZUqi6ZmUPbhhf4AbpH6UiUe4lIVE1ZL+dwSAfu9aZW+yg
        GLc5f1JytRZLyvHP16clJBgMpeL6jXL6+fwZEOC4I3g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=ZARt8h
        sAD051BiaNqNy7562HyN8dnfaPuX2yAo3nA44=; b=I3Cchtg9uhi1ZFsrLN5Tqd
        vYI2slu1+DYe6Qrhqjy9gy+nBkL5CNQUdGcdBXyGbXqOkkvQBxe7cIn76bx8RwpW
        O3rUzfO0ktf7TSy9JJriM4p40YiNn/WXDw1RpiiFV68kj78XulxqnYbBi0ANU7dW
        hPTQf9i2AVtPXBAyLPTIqHi2/jBhrHk+Sj7yofgyw+hDM1B13jU+OunP2D5Z2qdQ
        hXm9AF2Gu0Cy+3+G6i1BE9nJhB0pAz5aXd4Z4wtRlbYeLrydPNaI6y1d3K/1X1t8
        k0LFOQqsoFbNFc3Fi1LicLzuoqfBONfm0Sz2kx2ba7vDJHStcvP5jDWIBS9OrfQg
        ==
X-ME-Sender: <xms:Z2iDXZX-i1b_ISJjhSqWLFvybvFbagfzKf1XYUGdYRIhcU9saI_U6A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrvddtgdegfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujggfsehttdertddtredvnecuhfhrohhmpefirhgvghcu
    mffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucfkphepkeefrdekiedrkeelrddutd
    ejnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskhhrohgrhhdrtghomhenucev
    lhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:Z2iDXQHjHu2VslpUuPMpKBSJnMQov_hL1W6WXYP9f_GNm_EUzeBmsg>
    <xmx:Z2iDXTaY73GFQwUaHXI4dvdiYnAFjkYrGSdUbDB6zQhhWMJ7BgkNeg>
    <xmx:Z2iDXfGeNvks9qGsxzh1ownU__Bu0Oxc00C6iFUeQt172GwZM9umMg>
    <xmx:Z2iDXZc8JSv76pdOf06o1SZhQNnFI1y1O2BWmXBCseyUH93QeIt8Nw>
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        by mail.messagingengine.com (Postfix) with ESMTPA id E420880060;
        Thu, 19 Sep 2019 07:37:10 -0400 (EDT)
Date:   Thu, 19 Sep 2019 13:37:08 +0200
From:   Greg KH <greg@kroah.com>
To:     Alexander Gordeev <a.gordeev.box@gmail.com>
Cc:     linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org,
        Michael Chen <micchen@altera.com>, dmaengine@vger.kernel.org
Subject: Re: [PATCH RFC 0/2] staging: Support Avalon-MM DMA Interface for PCIe
Message-ID: <20190919113708.GA3153236@kroah.com>
References: <cover.1568817357.git.a.gordeev.box@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1568817357.git.a.gordeev.box@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Thu, Sep 19, 2019 at 11:59:11AM +0200, Alexander Gordeev wrote:
> The Avalon-MM DMA Interface for PCIe is a design found in hard IPs for
> Intel Arria, Cyclone or Stratix FPGAs. It transfers data between on-chip
> memory and system memory. This RFC is an attempt to provide a generic API:
> 
> 	typedef void (*avalon_dma_xfer_callback)(void *dma_async_param);
>  
> 	int avalon_dma_submit_xfer(
> 		struct avalon_dma *avalon_dma,
> 		enum dma_data_direction direction,
> 		dma_addr_t dev_addr, dma_addr_t host_addr,
> 		unsigned int size,
> 		avalon_dma_xfer_callback callback,
> 		void *callback_param);
>  
> 	int avalon_dma_submit_xfer_sg(struct avalon_dma *avalon_dma,
> 		enum dma_data_direction direction,
> 		dma_addr_t dev_addr,
> 		struct sg_table *sg_table,
> 		avalon_dma_xfer_callback callback,
> 		void *callback_param);
>  
> 	int avalon_dma_issue_pending(struct avalon_dma *avalon_dma);
> 
> Patch 1 introduces "avalon-dma" driver that provides the above-mentioned
> generic interface.
> 
> Patch 2 adds "avalon-drv" driver using "avalon-dma" to transfer user-
> provided data. This driver was used to debug and stress "avalon-dma"
> and could be used as a code base for other implementations. Strictly
> speaking, it does not need to be part of the kernel tree.
> A companion tool using "avalon-drv" to DMA files (not part of this
> patchset) is located at git@github.com:a-gordeev/avalon-drv-tool.git
> 
> The suggested interface is developed with the standard "dmaengine"
> in mind and could be reworked to suit it. I would appreciate, however
> gathering some feedback on the implemenation first - as the hardware-
> specific code would persist. It is also a call for testing - I only
> have access to a single Arria 10 device to try on.
> 
> This series is against v5.3 and could be found at
> git@github.com:a-gordeev/linux.git avalon-dma-engine

Why is this being submitted for drivers/staging/ and not the "real" part
of the kernel tree?

All staging code must have a TODO file listing what needs to be done in
order to get it out of staging, and be self-contained (i.e. no files
include/linux/)

Please fix that up when resending this series.

thanks,

greg k-h
