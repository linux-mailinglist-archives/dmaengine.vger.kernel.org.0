Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6A3F1BA9C2
	for <lists+dmaengine@lfdr.de>; Mon, 27 Apr 2020 18:05:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726539AbgD0QFt (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 27 Apr 2020 12:05:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:38966 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726185AbgD0QFs (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 27 Apr 2020 12:05:48 -0400
Received: from localhost (unknown [171.76.79.70])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B5547205C9;
        Mon, 27 Apr 2020 16:05:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588003548;
        bh=YDqfBQ5wST77dFIwfCuEmRqFbRXErmX0b5wHi05B4vg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=u9iXdN2b1kMrsbi6D5R7l3ad8DUziDatl/mXJbkZPMYZGdqbJ1of5kwTae5YaxFr1
         +vVU2O7OJY7LHSbO24ztrE0TfP2w9lKPMZJlYf2JJAOXyWTSLIjboxp2yFyUFVwROX
         9ma+Zq3K2de5eNZ4nWS60kbP+LIlTwgeFLwme+FU=
Date:   Mon, 27 Apr 2020 21:35:43 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Laxman Dewangan <ldewangan@nvidia.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        dmaengine@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] dmaengine: tegra-apb: Ensure that clock is enabled
 during of DMA synchronization
Message-ID: <20200427160543.GH56386@vkoul-mobl.Dlink>
References: <20200426190835.21950-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200426190835.21950-1-digetx@gmail.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 26-04-20, 22:08, Dmitry Osipenko wrote:
> DMA synchronization hook checks whether interrupt is raised by testing
> corresponding bit in a hardware status register, and thus, clock should
> be enabled in this case, otherwise CPU may hang if synchronization is
> invoked while Runtime PM is in suspended state. This patch resumes the RPM
> during of the DMA synchronization process in order to avoid potential
> problems. It is a minor clean up of a previous commit, no real problem is
> fixed by this patch because currently RPM is always in a resumed state
> while DMA is synchronized, although this may change in the future.

Applied, thanks

-- 
~Vinod
