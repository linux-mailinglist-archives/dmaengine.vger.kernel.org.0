Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 038821276EB
	for <lists+dmaengine@lfdr.de>; Fri, 20 Dec 2019 09:01:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726327AbfLTIBd (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 20 Dec 2019 03:01:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:45808 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726210AbfLTIBd (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 20 Dec 2019 03:01:33 -0500
Received: from localhost (unknown [106.201.107.54])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0224D20716;
        Fri, 20 Dec 2019 08:01:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576828892;
        bh=WWl2Uh+GDV6mtMcwWgYc9xWAQpXDNNo79AHMa+xx7gw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RuSje8W6JyfDQdto/dU6NUX3Q+1FuB+wXXjYMM1rxvoORUfYg9S9Vo6ul7PuJVYEK
         ARxwYKgOXqQfd2zaXoXJxB7BZ7MuAXiXWDtJg8m3rFpvKs/3A5ij4zSx2FnY5xPuBF
         TbiAODwXdH0L+jc5QctifM4m8KfFI9A5er26A5xE=
Date:   Fri, 20 Dec 2019 13:31:27 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Hyun Kwon <hyun.kwon@xilinx.com>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        Michal Simek <michals@xilinx.com>,
        Hyun Kwon <hyunk@xilinx.com>,
        Tejas Upadhyay <tejasu@xilinx.com>,
        Satish Kumar Nagireddy <SATISHNA@xilinx.com>
Subject: Re: [PATCH v2 2/4] dma: xilinx: dpdma: Add the Xilinx DisplayPort
 DMA engine driver
Message-ID: <20191220080127.GI2536@vkoul-mobl>
References: <20191107021400.16474-1-laurent.pinchart@ideasonboard.com>
 <20191107021400.16474-3-laurent.pinchart@ideasonboard.com>
 <20191109175908.GI952516@vkoul-mobl>
 <20191205150407.GL4734@pendragon.ideasonboard.com>
 <20191205163909.GH82508@vkoul-mobl>
 <20191205202746.GA26880@smtp.xilinx.com>
 <20191208160349.GD14311@pendragon.ideasonboard.com>
 <20191220051309.GA19504@pendragon.ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191220051309.GA19504@pendragon.ideasonboard.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Laurent,

On 20-12-19, 07:13, Laurent Pinchart wrote:

> > OK, in the light of this information I'll keep the two separate and will
> > switch to vchan as requested by Vinod.
> 
> I've moved forward with this task, but eventually ran into one hack in
> the driver that is more difficult to get rid of than the other ones.
> 
> For display operation, the DPSUB driver needs to submit cyclic
> interleaved transfer requests. There's no such thing (as far as I can
> tell) in the DMA engine API, so the DPDMA drive simply keeps processing

we do support interleave, you need to implement
.device_prep_interleaved_dma and use dmaengine_prep_interleaved_dma()
from the client

> the same descriptor over and over again until a new one is issued. The
> hardware supports this with the help of hardware-based chaining of
> descriptors, and the DPDMA driver simply sets the next pointer of the
> descriptor to itself.
> 
> How can I solve this in a way that wouldn't abuse the DMA engine API ?

Is this not a cyclic case of descriptor?

-- 
~Vinod
