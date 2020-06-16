Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E6261FBBA1
	for <lists+dmaengine@lfdr.de>; Tue, 16 Jun 2020 18:26:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729964AbgFPQZM (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 16 Jun 2020 12:25:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:56072 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729386AbgFPQZL (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 16 Jun 2020 12:25:11 -0400
Received: from localhost (unknown [171.61.66.58])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 684B320786;
        Tue, 16 Jun 2020 16:25:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592324711;
        bh=1weD03zoU0wzno+ovEnhma63xzz/25gYDeWBoihKBzo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vvh/AiVuXw2qkfcHrjmK3Nl27OvCs9xPe27RtxKjJ0Wuz1zAtgzXOkZTgGwRJm+jb
         Phs2ui64/47FR8B0QbKBkyfTqW2l/A9ac48hn4mNGhY0h/EejCeYBw+NNF6bfJAg13
         P7gMkBmGCd8JPJvU+EGrnYTIy4wIGYST9A7uc0Ag=
Date:   Tue, 16 Jun 2020 21:55:07 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Viresh Kumar <vireshk@kernel.org>, dmaengine@vger.kernel.org
Subject: Re: [PATCH v1 1/2] dmaengine: dw: Register ACPI DMA controller for
 PCI that has companion
Message-ID: <20200616162507.GK2324254@vkoul-mobl>
References: <20200526182416.52805-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200526182416.52805-1-andriy.shevchenko@linux.intel.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 26-05-20, 21:24, Andy Shevchenko wrote:
> If PCI enumerated controller has a companion device,
> register it in the ACPI DMA controllers as well.

Applied both, thanks

-- 
~Vinod
