Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 864062AB419
	for <lists+dmaengine@lfdr.de>; Mon,  9 Nov 2020 10:57:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729180AbgKIJ5P (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 9 Nov 2020 04:57:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:33618 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727183AbgKIJ5P (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 9 Nov 2020 04:57:15 -0500
Received: from localhost (unknown [122.171.147.34])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E89C120789;
        Mon,  9 Nov 2020 09:57:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604915834;
        bh=160cLy5dwwK5xdEvDxpnSpt27mwIlmr3/ze0df37KOU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Im3rov7uw/cbSE48130Nx7NlwswXbw94RmzLqKbM1GYtAMxjvzxKjTg54dzIAxoZB
         Fh9Wu/uYSZ5GqfbVTnv8fH2rT2rgzeLDg5yPgFv96wM6LbjJXfX3LEfVVdpZX3afqx
         YGm8pTsnAanVOHGgxINGAGnKuVAVWdpkWbyUTagI=
Date:   Mon, 9 Nov 2020 15:27:10 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Sia Jee Heng <jee.heng.sia@intel.com>
Cc:     Eugeniy.Paltsev@synopsys.com, andriy.shevchenko@linux.intel.com,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 12/15] dmaengine: dw-axi-dmac: Add Intel KeemBay DMA
 register fields
Message-ID: <20201109095710.GF3171@vkoul-mobl>
References: <20201027063858.4877-1-jee.heng.sia@intel.com>
 <20201027063858.4877-13-jee.heng.sia@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201027063858.4877-13-jee.heng.sia@intel.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 27-10-20, 14:38, Sia Jee Heng wrote:
> Add support for Intel KeemBay DMA registers. These registers are required
> to run data transfer between device to memory and memory to device on Intel
> KeemBay SoC.

Again this should come first, you need to add all the bits required to
support this soc and then add compatible..

-- 
~Vinod
