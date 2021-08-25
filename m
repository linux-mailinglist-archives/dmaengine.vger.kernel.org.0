Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6475B3F745D
	for <lists+dmaengine@lfdr.de>; Wed, 25 Aug 2021 13:30:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236560AbhHYLbZ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 25 Aug 2021 07:31:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:60588 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232304AbhHYLbZ (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 25 Aug 2021 07:31:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 350C56113C;
        Wed, 25 Aug 2021 11:30:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629891040;
        bh=Fj8t0eLCUPwZyBH+9GtMRZDY3pi44HsmqGl3uwHvMYo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=URme5+oJeCiOBX1OO/ZoIw9uW2zEKW/ryn0UMDas44dPKcb1gzqWdu3Yxf/QwtHT9
         mZEEJ3XRw4d35euZGWiRQGudAe4cwLUrzElUGIWSjVvPZLb5Vkp+z75WrAY3Q9Pw23
         H2XTQzE+3dGfME9guINd6tFg243Ro14yrjEjHAhvrM2nV/qAtrZWUP1/Om3SxoLvZH
         POBfLayHizD0eM0+R3wRKv4boSt8JFtN4R+c0EdX5Au6uQ4ubnIO6RJEl9Gi4TzOCa
         fw3qhA8o7XzXFkaurLIOZTaFP6j3uEEDJgVcdXYlEjR8/64p+vVA6wcn+YmJLccJxK
         2vUgI+scEW/Jw==
Date:   Wed, 25 Aug 2021 17:00:35 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     dmaengine@vger.kernel.org
Subject: Re: [PATCH] dmaengine: idxd: make submit failure path consistent on
 desc freeing
Message-ID: <YSYp2/lv6cATOX+C@matsya>
References: <162827146072.3459011.10255348500504659810.stgit@djiang5-desk3.ch.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <162827146072.3459011.10255348500504659810.stgit@djiang5-desk3.ch.intel.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 06-08-21, 10:37, Dave Jiang wrote:
> The submission path for dmaengine API does not do descriptor freeing on
> failure. Also, with the abort mechanism, the freeing of desriptor happens
> when the abort callback is completed. Therefore free descriptor on all
> error paths for submission call to make things consistent. Also remove the
> double free that would happen on abort in idxd_dma_tx_submit() call.

Applied, thanks

-- 
~Vinod
