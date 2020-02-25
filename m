Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4018C16B94C
	for <lists+dmaengine@lfdr.de>; Tue, 25 Feb 2020 06:48:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726421AbgBYFsJ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 25 Feb 2020 00:48:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:37852 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726400AbgBYFsJ (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 25 Feb 2020 00:48:09 -0500
Received: from localhost (unknown [122.167.120.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 00FA024653;
        Tue, 25 Feb 2020 05:48:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582609688;
        bh=3OvLtUdiWWCTejcd3cyJhagzhZ0xlpW4uzxztlxEC7k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IxqfFS2sZxfUp9ujdI9WupCy2hs1mxFxXPhc+a/dBagz235lEfJda/1LvlBlXJ2Kj
         2bqk/QiXdO5QQd26E/wmzHwAsR2fLyHOJVF4ieandhpRmEUFU/b4W5WPWPq8A+fFmB
         qyeTm21Qbiy2UW7QBbFty1US+UJbJCgFwjwGgniI=
Date:   Tue, 25 Feb 2020 11:18:04 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
Cc:     dan.j.williams@intel.com, michal.simek@xilinx.com,
        nick.graumann@gmail.com, andrea.merello@gmail.com,
        appana.durga.rao@xilinx.com, mcgrof@kernel.org,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        git@xilinx.com
Subject: Re: [PATCH -next 0/2] dmaengine: xilinx_dma: In dma channel probe
 fix node order dependency
Message-ID: <20200225054804.GH2618@vkoul-mobl>
References: <1580388865-9960-1-git-send-email-radhey.shyam.pandey@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1580388865-9960-1-git-send-email-radhey.shyam.pandey@xilinx.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 30-01-20, 18:24, Radhey Shyam Pandey wrote:
> In overlay application[1] we noticed that channel DT nodes are inverted and
> as a sideffect of this behaviour the axidmatest client fails.
> 
> In general driver should not assume specific DT probe order. So to fix this
> failure remove channel node ordering restriction from the xilinx dma driver.

Applied, thanks

-- 
~Vinod
