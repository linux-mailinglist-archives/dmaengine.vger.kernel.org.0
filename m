Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3B8F1D456E
	for <lists+dmaengine@lfdr.de>; Fri, 15 May 2020 07:54:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726953AbgEOFyB (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 15 May 2020 01:54:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:53576 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726945AbgEOFyB (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 15 May 2020 01:54:01 -0400
Received: from localhost (unknown [122.178.196.30])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DCD122054F;
        Fri, 15 May 2020 05:53:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589522040;
        bh=VKwr3Ys1tdYFnPbyiHMP3OqauYhohGtNZnC03ZD/gyk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AiVePCoy4HCL3e/8kKhw+jlK2diI70dSoKaKorRg1LO6/JnYf++muDMp3tdzd7JCl
         fqbWbewNjRylzoyvi+0d4QDmGLXL/metO21sy83AqKTRfhr46JG/3UOBbNHD3EpzUm
         p4GJws7tLvcZ29EodJ0hUi70vyp9m6JtfquoFe1A=
Date:   Fri, 15 May 2020 11:23:56 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     dmaengine@vger.kernel.org, dan.j.williams@intel.com
Subject: Re: [PATCH] dmaengine: ti: k3-udma: Fix TR mode flags for slave_sg
 and memcpy
Message-ID: <20200515055356.GC333670@vkoul-mobl>
References: <20200512134531.5742-1-peter.ujfalusi@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200512134531.5742-1-peter.ujfalusi@ti.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 12-05-20, 16:45, Peter Ujfalusi wrote:
> cppi5_tr_csf_set() clears previously set Configuration Specific Flags.
> Setting the EOP flag clears the SUPR_EVT flag for the last TR which is not
> desirable as we do not want to have events from the TR.

Applied to fixes, thanks
-- 
~Vinod
