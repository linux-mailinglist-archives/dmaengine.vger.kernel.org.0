Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 355471BA99A
	for <lists+dmaengine@lfdr.de>; Mon, 27 Apr 2020 18:01:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728636AbgD0QBI (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 27 Apr 2020 12:01:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:36340 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728616AbgD0QBH (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 27 Apr 2020 12:01:07 -0400
Received: from localhost (unknown [171.76.79.70])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C5591206D4;
        Mon, 27 Apr 2020 16:01:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588003267;
        bh=Wq5GVLt/5AqJffo/SS4zwlcP1ymmbgtvTCi7gp4FIMY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Rp0rYw2YnUFJhZZYykL50L9xHe0xC7HdCM1c6+eaSRcRAOuM8Saniwrt5Y5FvFQxT
         Xfb4Csix3XfQRg1z8gay/1dkJ0cOKKkt82aZGA5oaqqps5Okk24H1ZjJzPWlpPimBM
         IBBK8xwvkf5NTsMZEuiuk43plKHGQIvGlIdnad+w=
Date:   Mon, 27 Apr 2020 21:31:03 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Alan Mikhak <alan.mikhak@sifive.com>
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, gustavo.pimentel@synopsys.com,
        dan.j.williams@intel.com, kishon@ti.com, maz@kernel.org,
        paul.walmsley@sifive.com
Subject: Re: [PATCH v2][next] dmaengine: dw-edma: Check MSI descriptor before
 copying
Message-ID: <20200427160103.GF56386@vkoul-mobl.Dlink>
References: <1587607101-31914-1-git-send-email-alan.mikhak@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1587607101-31914-1-git-send-email-alan.mikhak@sifive.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 22-04-20, 18:58, Alan Mikhak wrote:
> From: Alan Mikhak <alan.mikhak@sifive.com>
> 
> Modify dw_edma_irq_request() to check if a struct msi_desc entry exists
> before copying the contents of its struct msi_msg pointer.
> 
> Without this sanity check, __get_cached_msi_msg() crashes when invoked by
> dw_edma_irq_request() running on a Linux-based PCIe endpoint device. MSI
> interrupt are not received by PCIe endpoint devices. If irq_get_msi_desc()
> returns null, then there is no cached struct msi_msg to be copied.
> 
> This patch depends on the following patch:
> [PATCH v2] dmaengine: dw-edma: Decouple dw-edma-core.c from struct pci_dev
> https://patchwork.kernel.org/patch/11491757/
> 
> Rebased on linux-next which has above patch applied.

These two para above should be added after s-o-b line as git-am skips
the lines after the marker. The above line are useful for applying but not
when applied. I have stripped these and applied the patch, thanks

-- 
~Vinod
