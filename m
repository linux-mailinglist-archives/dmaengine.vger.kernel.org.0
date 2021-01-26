Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38B08304BC5
	for <lists+dmaengine@lfdr.de>; Tue, 26 Jan 2021 22:52:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726556AbhAZVvp (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 26 Jan 2021 16:51:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:36154 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729841AbhAZR0n (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 26 Jan 2021 12:26:43 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7725120731;
        Tue, 26 Jan 2021 17:26:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611681963;
        bh=PenYDXc6bwEEg2yCcHq1kHnmriyKNaXxp+78850QURM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oV2ccf5LopLllUAxEXsGIjUDxKjl7GmjyHPOQeaoY6HEgYgWkTltdzYnCV4mGcoDH
         7OZsgv2qI00HSBPSxeRZaAkk3XC/q/FyPHtXPCRdhwK5h+0W3K4CVT9Us8u8Ejuxgh
         QsCnOMMV3SBndE2IaU8UkWQqr/gAg5qU5MOiU3ISh1nMyCQU3BIq/i6BryttEh7uZA
         tNoeg08Hnk0YoAVmJZsT0vRfLGtcyvZ3IHXqwchEhVkEb2uEj0e3Fa1u57S1BSAq26
         AENbIPPLJrCeK8t2WGC02LW2K3DofO2U1o5hOXHAxUmwel4/6icyB8Oi/vVQDXXfdA
         AIdbWoQ+S3wQg==
Date:   Tue, 26 Jan 2021 22:55:59 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 0/3] dmaengine: remove obsolete drivers
Message-ID: <20210126172559.GV2771@vkoul-mobl>
References: <20210120131859.2056308-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210120131859.2056308-1-arnd@kernel.org>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 20-01-21, 14:18, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> A few Arm platforms are getting removed in v5.12, this removes
> the corresponding dmaengine drivers.

Thanks for the cleanup... Applied, thanks

-- 
~Vinod
