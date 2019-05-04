Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 25B28138A3
	for <lists+dmaengine@lfdr.de>; Sat,  4 May 2019 12:18:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726642AbfEDKSd (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 4 May 2019 06:18:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:60778 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726552AbfEDKSd (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Sat, 4 May 2019 06:18:33 -0400
Received: from localhost (unknown [171.76.113.243])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C1AA820675;
        Sat,  4 May 2019 10:18:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556965112;
        bh=0KX1gqAHG/+QLBLSshORNJlXTvHn1YJoWjdUaaUXvWU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=V7MzHWZNDZgm9Qh0JTdXx83GNTV+vjuf5t+CEJmYUyB+049URk8X24UDMWBiveHHI
         B1qe5jekaRdx6wevSc1acu360Q5izS7RtypuWWvGc674fxWNPCImo9tMHZFYnCLH04
         sr8PPDfM4fZ6K0QEZAIXpqUCYGnmwxZelkgXFr50=
Date:   Sat, 4 May 2019 15:48:23 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Arnaud Pouliquen <arnaud.pouliquen@st.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Pierre-Yves MORDRET <pierre-yves.mordret@st.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org
Subject: Re: [PATCH v2] dmaengine: stm32-dma: fix residue calculation in
 stm32-dma
Message-ID: <20190504101823.GX3845@vkoul-mobl.Dlink>
References: <1556789322-7232-1-git-send-email-arnaud.pouliquen@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1556789322-7232-1-git-send-email-arnaud.pouliquen@st.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 02-05-19, 11:28, Arnaud Pouliquen wrote:
> In double buffer mode, during residue calculation, the DMA can
> automatically switch to the next transfer. Indeed the CT bit that
> gives position in the double buffer can has been updated by the
> hardware, during calculation.
> In this case the SxNDTR register value can not be trusted.
> If a transition is detected we consider that the DMA has switched to
> the beginning of next sg.

Applied, thanks

-- 
~Vinod
