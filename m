Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8EF625589A
	for <lists+dmaengine@lfdr.de>; Fri, 28 Aug 2020 12:32:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728690AbgH1KcS (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 28 Aug 2020 06:32:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:57118 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728362AbgH1KcQ (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 28 Aug 2020 06:32:16 -0400
Received: from localhost (unknown [122.171.38.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0D1772086A;
        Fri, 28 Aug 2020 10:32:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598610736;
        bh=VptShkIQDKXVVlxjlAa5uXHKmjZcJW99Mwgi7dQ40O4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=w3yFRgi1c8xz/Tz3012ItaFlM/PrQCeh4LN/5g4Lt/L0KswIjEXGi9ZzFQxrgg3pH
         h5yVmRmmCXS5cXUrGhNoBXgrXt+STSpNHc+N/v5Xj0h3FDjX1p3qCZv59SFWLVFEDs
         XY7/rQkaO/W/TnFHU5g+AGXnyyBB1sflLC9JwZnI=
Date:   Fri, 28 Aug 2020 16:02:11 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     dmaengine@vger.kernel.org, dan.j.williams@intel.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dmaengine: Remove unused define for
 dma_request_slave_channel_reason()
Message-ID: <20200828103211.GR2639@vkoul-mobl>
References: <20200828084141.14902-1-peter.ujfalusi@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200828084141.14902-1-peter.ujfalusi@ti.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 28-08-20, 11:41, Peter Ujfalusi wrote:
> No users left in the kernel, it can be removed.

Applied, thanks

-- 
~Vinod
