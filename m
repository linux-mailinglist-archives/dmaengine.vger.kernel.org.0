Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B925C29DE61
	for <lists+dmaengine@lfdr.de>; Thu, 29 Oct 2020 01:54:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731725AbgJ1WTM (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 28 Oct 2020 18:19:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:60502 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731768AbgJ1WRo (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 28 Oct 2020 18:17:44 -0400
Received: from localhost (unknown [122.171.163.58])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E6B062245F;
        Wed, 28 Oct 2020 06:25:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603866347;
        bh=G99llodwo7LN/VxVH9PSAtp57j5+vnW+TiOqCIEpROA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=R3Z+rG8M4FiWQHPAxuhr7HCyoRQNXg3SSumdnqn/JVNCocwn2IpaU2wXprUQKKq0/
         vAS7rdiGm1WM8+xWMQFjKiWBhCQALS6+hOpP4iSTJaHVjsIsXKvaRWHdFuEcoxsVFV
         0FNPn7xkelHhmvTO0mcTQ6gGqr7dt0yET793mr4k=
Date:   Wed, 28 Oct 2020 11:55:42 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Dan Williams <dan.j.williams@intel.com>, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, kbuild-all@lists.01.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Arnd Bergmann <arnd@arndb.de>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH 1/2] dmaengine: ppc4xx: make ppc440spe_adma_chan_list
 static
Message-ID: <20201028062542.GN3550@vkoul-mobl>
References: <20201019155756.21445-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201019155756.21445-1-krzk@kernel.org>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 19-10-20, 17:57, Krzysztof Kozlowski wrote:
> The ppc440spe_adma_chan_list file-scope variable is not used outside of
> the unit so it can be made static.

Applied both, thanks

-- 
~Vinod
