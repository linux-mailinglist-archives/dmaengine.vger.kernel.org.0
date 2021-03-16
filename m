Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBD3D33D222
	for <lists+dmaengine@lfdr.de>; Tue, 16 Mar 2021 11:46:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236832AbhCPKq1 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 16 Mar 2021 06:46:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:43830 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236920AbhCPKpr (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 16 Mar 2021 06:45:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8DD9864FA5;
        Tue, 16 Mar 2021 10:45:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615891547;
        bh=QKmVS/i0Fp5R+RNSclCbxIUCB8OvRE2de4v5n8iSv0M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=m4TDhtG+ACXWnNxOGbEy/62SOIs2hDrKkbg/p8JaNNo3A7YvyET890tLlN9CgGLdG
         iJe2AE8SHanyDkjxcafg/u1FG1D3xo3iEYxtjib3GoQ47l/1JkbFBeUf7F+dB6uNm7
         xSf96wUv+imAA17fbvrxaJ/N+n+YBr90TUhDVLSWPLHeJLtq/aCRAVBaXDS1EuC2Q+
         sCIqpNbh9i4WAew/z2VYeg02wA8xfXgiwgfoAuARSgP1kl9V2ftzc1rPkDW6kZC+zx
         ZaYFkLPGxKyFZpMf0SzARHXJkofGwyya5mlu7homrWpkKTJXGixau9DsyyE+mlsGix
         5uBnx2O3F+ooQ==
Date:   Tue, 16 Mar 2021 16:15:43 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Michal Simek <michal.simek@xilinx.com>,
        Rohit Visavalia <RVISAVAL@xilinx.com>
Subject: Re: [PATCH 0/2] dmaengine: Fix issues in Xilinx dpdma driver
Message-ID: <YFCMVxsepqFUZz5v@vkoul-mobl>
References: <20210307040629.29308-1-laurent.pinchart@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210307040629.29308-1-laurent.pinchart@ideasonboard.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 07-03-21, 06:06, Laurent Pinchart wrote:
> Hello,
> 
> This small patch series fixes two issues I've experienced with the
> Xilinx dpdma driver. There isn't much to summarize in the cover letter,
> please see individual patches for details.

Applied, thanks

-- 
~Vinod
