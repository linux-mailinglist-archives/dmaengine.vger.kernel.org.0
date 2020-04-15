Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAFCC1AAC68
	for <lists+dmaengine@lfdr.de>; Wed, 15 Apr 2020 17:57:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1414985AbgDOP4A (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 15 Apr 2020 11:56:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:47668 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1414948AbgDOPz4 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 15 Apr 2020 11:55:56 -0400
Received: from localhost (unknown [106.201.106.187])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 13B942063A;
        Wed, 15 Apr 2020 15:55:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586966156;
        bh=hKBCNbY++gSUF8C6MzS7oYSuPjm9L12r9tFRC1Z+Qzo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=g3dCAsNYI8407bssRxUBT+YpVz46WOXKGtlM8Xi0ksim6oHj3999hgADUmBJN7f0a
         G3LTL1MUcpj/XmguK79mlW+rORo5UXiSH7WhiHBCbFDrGafff0KkIYdxnSSJ6DXXr0
         XJCSxdODBHYtFbsFnbwoQmNSLj1dUt4VLUMbtUAU=
Date:   Wed, 15 Apr 2020 21:25:42 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        dan.j.williams@intel.com, torvalds@linux-foundation.org
Subject: Re: [PATCH] dmaengine: ti: k3-udma: Drop COMPILE_TEST for the
 drivers for now
Message-ID: <20200415155542.GU72691@vkoul-mobl>
References: <20200403141950.9359-1-peter.ujfalusi@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200403141950.9359-1-peter.ujfalusi@ti.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 03-04-20, 17:19, Peter Ujfalusi wrote:
> It is not possible to compile test the UDMA stack right now due to
> dependencies to T_SCI_PROTOCOL and TI_SCI_INTA_IRQCHIP and their
> dependencies.
> 
> Remove the COMPILE_TEST until it is actually possible to compile test the
> drivers.

Applied, thanks

-- 
~Vinod
