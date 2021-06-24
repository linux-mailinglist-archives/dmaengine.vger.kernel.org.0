Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB7093B2D4F
	for <lists+dmaengine@lfdr.de>; Thu, 24 Jun 2021 13:10:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232399AbhFXLMy (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 24 Jun 2021 07:12:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:56816 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232331AbhFXLMx (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 24 Jun 2021 07:12:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7C657613B1;
        Thu, 24 Jun 2021 11:10:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624533034;
        bh=VNvEcnO3UG5geLAdW8COQk7H4IyR9NdZUhSc4CNwp8Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YszqKvSixTKKjn6TaDxwmahsP4KEeRWRgXsAcl+g17XeEGTI2q5gKFotHGE4hInus
         SQMxhqe/nnQYnKZwB5m5QWtyWoDcHvOCwq6Q0jNHnnIWSr4EieQ1n2HLaIWyntj300
         gIZcRI2royQyXpVHmidEXwdZd5a0Cx0BLh25YSGwHq3Ynp/yzuJzqJpgc1tcCnIF0O
         3itYJj213cDl0fFrsvS1Supgr+IjLvKxV39uGUd1BBNchv9We9oHA4mCcFJZFHeKQC
         UVoyL8o6zX4aA9SymqTh/u6kPR2Dy52wg5/AX6EGpPEVEtD0CnwfKggnZqUkRtkD5F
         1yR9QcYEfuRwA==
Date:   Thu, 24 Jun 2021 16:40:30 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Michal Simek <michal.simek@xilinx.com>
Cc:     linux-kernel@vger.kernel.org, monstr@monstr.eu, git@xilinx.com,
        Hyun Kwon <hyun.kwon@xilinx.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] dmaengine: xilinx: dpdma: Use kernel type u32 over
 uint32_t
Message-ID: <YNRoJteGyl93vARb@matsya>
References: <9569008794d519b487348bfeafbfd76c5da5755e.1624446336.git.michal.simek@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9569008794d519b487348bfeafbfd76c5da5755e.1624446336.git.michal.simek@xilinx.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 23-06-21, 13:05, Michal Simek wrote:
> Use u32 kernel type instead of uint32_t. Issue is reported by
> checkpatch.pl --strict.

Applied, thanks

-- 
~Vinod
