Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9DF6716AC2B
	for <lists+dmaengine@lfdr.de>; Mon, 24 Feb 2020 17:53:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727108AbgBXQw7 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 24 Feb 2020 11:52:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:54634 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727090AbgBXQw7 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 24 Feb 2020 11:52:59 -0500
Received: from localhost (unknown [122.182.199.233])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 79A3820836;
        Mon, 24 Feb 2020 16:52:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582563179;
        bh=+BKg+9ltuyXskzUKcp22gQ/z3orass0x9uHtufnBFpQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kn/iCHRYniCjGtSCaGsKiFYWh1Ke7ajdlj2I59KwyP9Fq8RJa7U29becT7gHJE0aS
         P9roAjpb1/PZi5nJdRyuXiLRk/tKs2BRkPjZvT3VDpsUZT34Ju5B1xnqoUfWny6V98
         sVdAS0Bzfc+vNBbXjSkbOFdt7qcwpAV9hnPEv9Ow=
Date:   Mon, 24 Feb 2020 22:22:55 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Amelie Delaunay <amelie.delaunay@st.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        dmaengine@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
Subject: Re: [PATCH 0/4] STM32 DMAMUX driver fixes and improvements
Message-ID: <20200224165255.GC2618@vkoul-mobl>
References: <20200128094158.20361-1-amelie.delaunay@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200128094158.20361-1-amelie.delaunay@st.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 28-01-20, 10:41, Amelie Delaunay wrote:
> This series brings improvements to the DMAMUX driver with support of power
> management and probe function gets a cleanup.

Applied, thanks

-- 
~Vinod
