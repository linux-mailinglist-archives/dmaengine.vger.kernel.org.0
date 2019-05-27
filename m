Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B3E132AF29
	for <lists+dmaengine@lfdr.de>; Mon, 27 May 2019 09:06:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726334AbfE0HG1 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 27 May 2019 03:06:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:49420 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725908AbfE0HG1 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 27 May 2019 03:06:27 -0400
Received: from localhost (unknown [171.61.91.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 949452075B;
        Mon, 27 May 2019 07:06:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558940787;
        bh=dbsLwYnadcCVkmgrwyRqzbAi72zsJJCUGEhWlRzzHYs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=esDr+PiSZpsD6NlAe2y/WYxkP/xT1yVPFHy3SzFSqvRy7sC1HfOWufXXSkRtREwbw
         oSR86GNuGlfwcWYMNg+Iy2YzlA2JXnitnR0MXb2ecMvZR257zp5dm1QHTPOZmBam2Q
         cxmk4W4M5c4vbfewUzQzEILax/6s3wjJCGuDjQZQ=
Date:   Mon, 27 May 2019 12:36:23 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     dmaengine@vger.kernel.org
Subject: Re: [PATCH 1/3][V3] include: fpga: adi-axi-common.h: add common regs
 & defs header
Message-ID: <20190527070623.GH15118@vkoul-mobl>
References: <20190527065518.18613-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190527065518.18613-1-alexandru.ardelean@analog.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 27-05-19, 09:55, Alexandru Ardelean wrote:
> The AXI HDL cores provided for Analog Devices reference designs all share
> some common base registers (e.g. version register at address 0x00).
> 
> To reduce duplication for this, a common header is added to define these
> registers as well as bitfields & macros to work with these registers.

Applied all, thanks
-- 
~Vinod
