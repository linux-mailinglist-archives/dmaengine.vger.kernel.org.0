Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A06F304BC8
	for <lists+dmaengine@lfdr.de>; Tue, 26 Jan 2021 22:53:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725944AbhAZVvv (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 26 Jan 2021 16:51:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:36608 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728431AbhAZR3B (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 26 Jan 2021 12:29:01 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 60E83206D4;
        Tue, 26 Jan 2021 17:28:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611682100;
        bh=ZkiXibUcTj8V0sblKd22isCBEsKuiG4JthiNyAM9pK8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=q2vCQZkZb0vypHnuY71QVAycNdPtd3MXwwG40ic3eynp/8/S8lXFYJT3BpzR7tvNV
         DP6JFwdZDJAOD26QNh1eQg+73ab5giDI/oWQDSwRegSMm+pD4bvpdc+2Jbye58Rph8
         mCXqni3uf8Ov4gVnKOLZj0lEqX5SSM9pSQxKhGIzhpe1tCe7uxUBiLnGJpJyFwvGHF
         EmGgZvi8SKQH3zV3PNTlc33r8HiVMYtBJhlcwhBKCHk2r4U3XOPZsJ/oIg4cOC0E4A
         zaHfJTjQvx/1fv6inYuTcuorjJu4UQjm6dbbQ71er3ldIDYNmob03LLg/z74NJwdDc
         DWjQRy5hl4Lqw==
Date:   Tue, 26 Jan 2021 22:58:15 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Lubomir Rintel <lkundrak@v3.sk>
Cc:     linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org
Subject: Re: [PATCH 0/3] dmaengine: Allow building MMP DMA drivers as modules
Message-ID: <20210126172815.GW2771@vkoul-mobl>
References: <20210121110356.1768635-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210121110356.1768635-1-lkundrak@v3.sk>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 21-01-21, 12:03, Lubomir Rintel wrote:
> Hi,
> 
> please consider attaching the patches chained to this message.
> 
> The last two are straighforward Kconfig changes that allow building mmp_tdma 
> and mmp_pdma as modules so that distros that will choose to enable the drivers 
> will not add bloat to their kernels for other platforms.
> 
> The first one gets rid of a symbol that would be exported by mmp_pdma,
> because it is entirely unnecessary.

Applied, thanks

-- 
~Vinod
