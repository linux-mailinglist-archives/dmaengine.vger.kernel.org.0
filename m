Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C834D245C23
	for <lists+dmaengine@lfdr.de>; Mon, 17 Aug 2020 07:51:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726303AbgHQFvL (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 17 Aug 2020 01:51:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:59974 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726185AbgHQFvK (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 17 Aug 2020 01:51:10 -0400
Received: from localhost (unknown [122.171.38.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DB920206DA;
        Mon, 17 Aug 2020 05:51:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597643469;
        bh=KeRhPQoN7QZN3f7RUsTbaEJRXFrz/kdFHLXcWwXbyII=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gN5HFqAL+atFrWd0RyrMqbufh4HL/0/8xg2uJ/SZ0W3HLUgVuqQIgyPUUzkEP7IZW
         XZZ+3H+4p7LhsoZ1OJNIdZ5pKOKyonw7N8SMGEANrXGbIj1GAzZ2ufGeaE1JWS2+CB
         zSB6PqM5Q5DbrDgAqKffVP37Om6Fd0o0XQCf3Q0o=
Date:   Mon, 17 Aug 2020 11:20:57 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     dmaengine@vger.kernel.org, Hyun Kwon <hyun.kwon@xilinx.com>,
        Michal Simek <michal.simek@xilinx.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] dmaengine: xilinx: dpdma: Add debugfs support
Message-ID: <20200817055057.GL2639@vkoul-mobl>
References: <20200812171228.9751-1-laurent.pinchart@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200812171228.9751-1-laurent.pinchart@ideasonboard.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 12-08-20, 20:12, Laurent Pinchart wrote:
> Expose statistics to debugfs when available. This helps debugging issues
> with the DPDMA driver.

Applied, thanks

-- 
~Vinod
