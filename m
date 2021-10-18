Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20441430E7F
	for <lists+dmaengine@lfdr.de>; Mon, 18 Oct 2021 06:08:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229707AbhJREKa (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 18 Oct 2021 00:10:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:40486 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229445AbhJREK1 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 18 Oct 2021 00:10:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CDC7F61054;
        Mon, 18 Oct 2021 04:08:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634530096;
        bh=rSBoFOHyf4uqvRd9N6DL3e/GslL/J03tC/7EHWaZi3E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GNiq8RJFaXXbFz8y3UGY65yPyeavMA5V5D6q6NO0OlvtDz+pAZi0ZZx0hQR5v+NMG
         ODHw5JHoUqoL4Hu6vpC4ksx6ML1/YTwDT3/Znc6DktuI4f+h5/3bfclf21kgALKv0R
         lttRimYPr6ikF8CM0i1irSUDtZoxGQggzb3QwTPsOozMxlkkHi3NHItGsuiJEPgy8p
         tiPPTpDzwfz8rripUu2d4todpZIXSxkLpojZ6F5yxThIRv06O20CR1UqJ6BB/s2tck
         wnPNaJuKdnIqELqQUhMoap6oQc+mzOjItyINEVnJCMxszKhYuA8BTcUxbz1SJMM0ud
         DRos4LOInoqnA==
Date:   Mon, 18 Oct 2021 09:38:12 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Colin King <colin.king@canonical.com>
Cc:     dmaengine@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dmaengine: Remove redundant initialization of variable
 err
Message-ID: <YWzzLIcVfsl2TK9K@matsya>
References: <20211015123447.27560-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211015123447.27560-1-colin.king@canonical.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 15-10-21, 13:34, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The variable err is being initialized with a value that is never read, it
> is being updated later on. The assignment is redundant and can be removed
> and move the declaration into the local scope.

Applied, thanks

-- 
~Vinod
