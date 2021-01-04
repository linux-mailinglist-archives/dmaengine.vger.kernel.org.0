Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF6C32E952B
	for <lists+dmaengine@lfdr.de>; Mon,  4 Jan 2021 13:44:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726960AbhADMne (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 4 Jan 2021 07:43:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:36440 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726925AbhADMne (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 4 Jan 2021 07:43:34 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7EF7721E92;
        Mon,  4 Jan 2021 12:42:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609764173;
        bh=GIZuBhhgnXiluA9GuafPelcNeM45Lq5o0/oqW4lunVY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Lz3B6t3PvePGf/UCSdbAFkH0nXp3q6knGrRQFYBgwPQqBnq26suc+iPExdbQQTbmH
         +EAz3jv6tOFprHH2/Ahs65qae/EnZ/27IvLjYIqAh+2lUUF//EEHO+Bndy/g1N1qeS
         MmxoqGQDFi3w6UOvjpi6X/tqYm8J2yXv3R5nz9aDqRd4SomGW2v3FIziFqvuRPLI8D
         6zrs+dJl+NrQLT6DRizVzcwEo8b1S8E1BpaO/ofIE4lNPOVlbscgorGiS1/tS0+Rhb
         lpstYvKL8DnqbbCrBRqb3f9CytNM5Smo4BqsKeFRmxLz4G0HZB9m6ODrvHTvM/8Jfi
         2J8QpG5XFMjbQ==
Date:   Mon, 4 Jan 2021 18:12:48 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
Cc:     dan.j.williams@intel.com, michal.simek@xilinx.com,
        nick.graumann@gmail.com, andrea.merello@gmail.com,
        appana.durga.rao@xilinx.com, mcgrof@kernel.org,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        git@xilinx.com
Subject: Re: [PATCH v2 0/3] dmaengine: xilinx_dma: coverity fixes
Message-ID: <20210104124248.GH120946@vkoul-mobl>
References: <1608722462-29519-1-git-send-email-radhey.shyam.pandey@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1608722462-29519-1-git-send-email-radhey.shyam.pandey@xilinx.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 23-12-20, 16:50, Radhey Shyam Pandey wrote:
> This patch series fix coverity warnings for xilinx_dma driver.
> No functional change. These patches are picked from xilinx
> linux tree and posted for upstream.

Applied, thanks

-- 
~Vinod
