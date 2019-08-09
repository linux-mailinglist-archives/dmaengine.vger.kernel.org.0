Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EC68F8782D
	for <lists+dmaengine@lfdr.de>; Fri,  9 Aug 2019 13:05:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406272AbfHILFi (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 9 Aug 2019 07:05:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:60580 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405954AbfHILFi (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 9 Aug 2019 07:05:38 -0400
Received: from localhost (unknown [122.167.65.92])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 05EE12084D;
        Fri,  9 Aug 2019 11:05:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565348737;
        bh=eoCx8u5R444JhsbK9zwRJFeJZ8fwMoWRZ1HGZAidTJE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jaBldWwjh9AECKG9c2IH/EcQqi0c7G6bHg2+9ulqkq5Dl9ks6cYvrKgt+WqItS69B
         8hqsGC+fdsXKUFVS7twWZ0QFohC+1BA46Txx5Wt/pPRRCgGfLVzuGqB0xgpUn0RL+Q
         r2v0bEzo1jYP2HL9HYCqQznU1uHNkE6N99FBbZI4=
Date:   Fri, 9 Aug 2019 16:34:21 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Hans Verkuil <hverkuil@xs4all.nl>
Cc:     Linux Media Mailing List <linux-media@vger.kernel.org>,
        dmaengine@vger.kernel.org, Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: Re: [PATCHv2] omap-dma/omap_vout_vrfb: fix off-by-one fi value
Message-ID: <20190809110421.GL12733@vkoul-mobl.Dlink>
References: <952e7f51-f208-9333-6f58-b7ed20d2ea0b@xs4all.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <952e7f51-f208-9333-6f58-b7ed20d2ea0b@xs4all.nl>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 09-08-19, 10:32, Hans Verkuil wrote:
> The OMAP 4 TRM specifies that when using double-index addressing
> the address increases by the ES plus the EI value minus 1 within
> a frame. When a full frame is transferred, the address increases
> by the ES plus the frame index (FI) value minus 1.
> 
> The omap-dma code didn't account for the 'minus 1' in the FI register.
> To get correct addressing, add 1 to the src_icg value.
> 
> This was found when testing a hacked version of the media m2m-deinterlace.c
> driver on a Pandaboard.
> 
> The only other source that uses this feature is omap_vout_vrfb.c,
> and that adds a + 1 when setting the dst_icg. This is a workaround
> for the broken omap-dma.c behavior. So remove the workaround at the
> same time that we fix omap-dma.c.
> 
> I tested the omap_vout driver with a Beagle XM board to check that
> the '+ 1' in omap_vout_vrfb.c was indeed a workaround for the omap-dma
> bug.

Applied, thanks

-- 
~Vinod
