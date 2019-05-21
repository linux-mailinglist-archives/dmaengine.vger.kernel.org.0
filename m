Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3CE4324759
	for <lists+dmaengine@lfdr.de>; Tue, 21 May 2019 07:11:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727615AbfEUFLf (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 21 May 2019 01:11:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:58090 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725804AbfEUFLf (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 21 May 2019 01:11:35 -0400
Received: from localhost (unknown [106.201.107.13])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 08AA22173E;
        Tue, 21 May 2019 05:11:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558415494;
        bh=D2A1a8uO0qa3ryOp/c7RkKvhSbGpjJMOZlcPLfIRdag=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JkaaG/ZTFW3ru4gBGiS4Ka+TGAmEF+ze0A3O7b7UslyYe6eTu3IEIFUR35nzCmbhx
         91IvQQ9Rd7y+7Cz6zzsHIZbmFuJPzb6CTsAskxFd/FO0QEN11eUruXC/lfkHHVNR5j
         qN9hp3+WjtreKw3WMLPMbAj51zAhf+5BKR+r+zhw=
Date:   Tue, 21 May 2019 10:41:31 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Jon Hunter <jonathanh@nvidia.com>
Cc:     Laxman Dewangan <ldewangan@nvidia.com>, dmaengine@vger.kernel.org,
        linux-tegra@vger.kernel.org, Sameer Pujar <spujar@nvidia.com>
Subject: Re: [PATCH 0/3] dmaengine: tegra210-adma: Fixes for v5.2
Message-ID: <20190521051131.GX15118@vkoul-mobl>
References: <1558022034-19911-1-git-send-email-jonathanh@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1558022034-19911-1-git-send-email-jonathanh@nvidia.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 16-05-19, 16:53, Jon Hunter wrote:
> Here are 3 fixes for the Tegra210 ADMA driver for v5.2.
> 

Applied all, thanks
-- 
~Vinod
