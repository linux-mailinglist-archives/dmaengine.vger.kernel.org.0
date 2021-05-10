Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FC0F379086
	for <lists+dmaengine@lfdr.de>; Mon, 10 May 2021 16:20:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231847AbhEJOVv (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 10 May 2021 10:21:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:54162 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243625AbhEJOTq (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 10 May 2021 10:19:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E3073610F8;
        Mon, 10 May 2021 14:18:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620656321;
        bh=CBeQY1RCPeTRDuJdJFljue7A+9Kba1m1hnZz0bYlhCo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LJbMkCU29Cj17Fubm4Ey4td6TIrr0LObH82AJUvvuDsP02a63biBK2TxOSas/65/m
         CrMbKMbfzNRFnfcZiGuIvMBqeIloZwMCaNBWNZwTlS2tH/eK352AG3g66ANtEX+I98
         Bhe0cNwEyB6amwm5NkncwXEmZAHCRdl7+dEIh/SxXieDYvZrRgzyB/fqFME2fxDw9Z
         dzUNx6QlsWdN8MulVsuo4ZL9e8lFoUbkPrvaVlvivIAX0u/BRp8YmYdOKTT73DWfy4
         NpJjMoyFLMfipT6Lg0V8O25UYD3e5J07E1Ynm6v4x450gZ8/8yxdfYgj9U7RxkOGed
         OzphAXc8kGUKQ==
Date:   Mon, 10 May 2021 19:48:38 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     dmaengine@vger.kernel.org
Subject: Re: [PATCH] dmaengine: idxd: add missing dsa driver unregister
Message-ID: <YJlAvgVR2ywgJWRB@vkoul-mobl.Dlink>
References: <161947994449.1053102.13189942817915448216.stgit@djiang5-desk3.ch.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <161947994449.1053102.13189942817915448216.stgit@djiang5-desk3.ch.intel.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 26-04-21, 16:32, Dave Jiang wrote:
> The idxd_unregister_driver() has never been called for the idxd driver upon
> removal. Add fix to call unregister driver on module removal.

Applied, thanks

-- 
~Vinod
