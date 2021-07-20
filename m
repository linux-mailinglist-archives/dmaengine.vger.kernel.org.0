Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8215A3CFB81
	for <lists+dmaengine@lfdr.de>; Tue, 20 Jul 2021 16:02:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238492AbhGTNVx (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 20 Jul 2021 09:21:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:35952 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239095AbhGTNQl (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 20 Jul 2021 09:16:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0C355610F7;
        Tue, 20 Jul 2021 13:57:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626789424;
        bh=dcWu8vEecywc3SMwjdvSYhZUrB5x7XGvTiGAUV+NKV8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bxEAJUuA/wSLXuCLncrDhIKkPkRz3Sq8kb+rT3W+KaQ5Vup8ndZHh7uLPQ5vjzgy5
         yoetBnb52Q+yiCx7KtCWj0LjxFgC4Yo8yFAGxguKwNH2szRwIz8ZyWQofUxyxNuMNK
         HIIx5lsq+mxRp5S5Yyat65ay5BPEbWJImc8l3W6gGnh+YfmErSMuGaJEoM3zdjF1qc
         ucTjAgkBzfNf1dFQLik+ay9llYeThmqam/2lZjqha44+adgDS55GL6IbECifP8Xlpt
         acScOGK/FegbOPPQm+PXq4iFNL9zlBEDa/AGsjVoOFS8Ha/Ln0MxzLLMqQZWB8eE5h
         nT6F/szjurO5g==
Date:   Tue, 20 Jul 2021 19:27:01 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     dmaengine@vger.kernel.org
Subject: Re: [PATCH] dmaengine: idxd: fix desc->vector that isn't being
 updated
Message-ID: <YPbWLb5sp0XVcxZv@matsya>
References: <162628784374.353761.4736602409627820431.stgit@djiang5-desk3.ch.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <162628784374.353761.4736602409627820431.stgit@djiang5-desk3.ch.intel.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 14-07-21, 11:38, Dave Jiang wrote:
> Missing update for desc->vector when the wq vector gets updated. This
> causes the desc->vector to always be at 0.

Applied, thanks

-- 
~Vinod
