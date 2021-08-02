Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA2033DD0EF
	for <lists+dmaengine@lfdr.de>; Mon,  2 Aug 2021 09:05:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232306AbhHBHFc (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 2 Aug 2021 03:05:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:33406 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229500AbhHBHFb (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 2 Aug 2021 03:05:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D4D7260D07;
        Mon,  2 Aug 2021 07:05:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627887922;
        bh=ID3QPU3TyBOAKKkdlpM3Bwv4/0UAdfGdwlG5J7Q7QHk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Z+ViBvFaT4zwK8uyWj0UrpIzZAfmeP5uB5bbYpWA3Imvat/uFLq3xjbhSWvtHsAvh
         zpUqla8AAR/nlMfllxdjYCkLaQlyDYi3be4Fr51sNsJg+nlvwFkBVZxnteyibEX1Oi
         pCq2sVap83EP3sQ8yUT2WfKXp4e4skfFZ3BNNQwm9YPlrMnFJO5yoaAzaSLx+9kFer
         J72t1r8tbOJeZfjyhH+WknjBomnUX7I37IMAVBkYQtXD5Bhso3Ru9LsfRbqji1pye6
         Pfdy9uBZAJC1eqD2CUvRujdcOtVFIbwTR3O6epYYQOvKUmKtILpfx0bSDcMoHzr0JY
         i5EGzO6xj0Aww==
Date:   Mon, 2 Aug 2021 12:35:18 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     dave.jiang@intel.com, dan.j.williams@intel.com,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] dmaengine: idxd: Fix a possible NULL pointer dereference
Message-ID: <YQeZLsIyw54OlPas@matsya>
References: <77f0dc4f3966591d1f0cffb614a94085f8895a85.1627560174.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <77f0dc4f3966591d1f0cffb614a94085f8895a85.1627560174.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 29-07-21, 14:04, Christophe JAILLET wrote:
> 'device_driver_attach()' dereferences its first argument (i.e. 'alt_drv')
> so it must not be NULL.
> Simplify the error handling logic about NULL 'alt_drv' in order to be
> more robust and future-proof.

Applied, thanks

-- 
~Vinod
