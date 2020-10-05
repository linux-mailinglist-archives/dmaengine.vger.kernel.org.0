Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25EC8282FC0
	for <lists+dmaengine@lfdr.de>; Mon,  5 Oct 2020 06:48:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725868AbgJEEsg (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 5 Oct 2020 00:48:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:56866 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725267AbgJEEsg (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 5 Oct 2020 00:48:36 -0400
Received: from localhost (unknown [171.61.67.142])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 672372080C;
        Mon,  5 Oct 2020 04:48:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601873316;
        bh=SGOjSWwhGcmogDrwdKkFX5oRYyeI+Y/QRkCspjBS5r0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=T+KZlvlPXKTMMnn5OeGyk09f4YTGKreVm+0a95lHEIdvayvEvGhIDnLKRLGyRBaRe
         6jss9oqzmQyX0mNSr7MZAMConxjExKotA1C/CovNxgTZgdZlcXI3VNHChPMgi3l8fz
         BRPUWAcwZMCqCDhgUiWhWQZfukqOTlh8K8KgNRcw=
Date:   Mon, 5 Oct 2020 10:18:32 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Julia Lawall <Julia.Lawall@inria.fr>
Cc:     kernel-janitors@vger.kernel.org,
        Dan Williams <dan.j.williams@intel.com>,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/14] dmaengine: rcar-dmac: drop double zeroing
Message-ID: <20201005044832.GK2968@vkoul-mobl>
References: <1600601186-7420-1-git-send-email-Julia.Lawall@inria.fr>
 <1600601186-7420-10-git-send-email-Julia.Lawall@inria.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1600601186-7420-10-git-send-email-Julia.Lawall@inria.fr>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 20-09-20, 13:26, Julia Lawall wrote:
> sg_init_table zeroes its first argument, so the allocation of that argument
> doesn't have to.
> 
> the semantic patch that makes this change is as follows:
> (http://coccinelle.lip6.fr/)

Applied, thanks

-- 
~Vinod
