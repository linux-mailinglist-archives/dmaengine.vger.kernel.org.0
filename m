Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20C5736988D
	for <lists+dmaengine@lfdr.de>; Fri, 23 Apr 2021 19:39:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231760AbhDWRji (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 23 Apr 2021 13:39:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:36282 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231522AbhDWRji (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 23 Apr 2021 13:39:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9C36E6054E;
        Fri, 23 Apr 2021 17:39:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619199541;
        bh=h7HXzGtYnLEzlU2VAWozIlf/eRpT8+Y6DUIzLwnT+kE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GVofyKyJkz/nQ8DrNNaG5CSlhKqx0aOhy7vQ5qd80SucMBsY82A4cc4Q57d8RCkBS
         EQPjkUfkUUYB6IN3p2FSsXZ+nNrdqN6t8yVbePNT/SpxMcZit75PJMop5CcMqjlth2
         qlz3W/rgQtt0+tDVw2vPpkFB37sQBBpJD8PR2JyjNR0xcTq9pUf3a9LksE8nn/HJao
         tKx0/onSA95LirKGNLmbIxEeRbZ1UC6XfC0MBIptU+0l6uu5uQIBcf7oauGXPu0GtB
         d1FRfX0CtVnCNW6o6Y2EXhpg3IJi/dehcURLw2edz0ac4PtJ7JTiEG9MVioJcIVjUu
         O2rfGvNH9JrWg==
Date:   Fri, 23 Apr 2021 23:08:57 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     dmaengine@vger.kernel.org
Subject: Re: [PATCH 0/6] Ouststanding patches for 5.13 series
Message-ID: <YIMGMZAG2+ix4tHJ@vkoul-mobl.Dlink>
References: <161894424826.3202472.897357148671784604.stgit@djiang5-desk3.ch.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <161894424826.3202472.897357148671784604.stgit@djiang5-desk3.ch.intel.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 20-04-21, 11:46, Dave Jiang wrote:
> Hi Vinod,
> Here are the remaining outstanding patches for 5.13 merge window that has
> been rebased against the latest dmaengine/next tree. Thanks!

Applied, thanks

-- 
~Vinod
