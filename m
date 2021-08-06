Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4158D3E2BE8
	for <lists+dmaengine@lfdr.de>; Fri,  6 Aug 2021 15:49:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229918AbhHFNtk (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 6 Aug 2021 09:49:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:47976 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236837AbhHFNti (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 6 Aug 2021 09:49:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E827E606A5;
        Fri,  6 Aug 2021 13:49:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628257762;
        bh=ei7bRuHF6nxNe4xiDTKbahxlMF93T1XFu7JfGwRpc6I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FkKCS6uAZD5h92D9puWMjyo8DuPOY1bBh2x/KQ7QkeWv7uWZpsrrU4HCVAxr8FKjR
         e/3QCwgzshIRVeIzPbEyx64sNa2cioQgOqtX1M5leYrAVvooPgnvCQwQbhoMfL50hn
         wKm0U58SqWiGGqYwE1xdG37zcwtKR3JXL0iQszutsyl8vxYINl06tXbps37GhIA+6k
         mEjHRUl9QNhWsIrrQbFleBmStfSz75FT1Yo3pfiGJ4Tse3KQE3hKXIaJaHwy0Qutde
         92qepRJI50VJfhmJo6nqtcAv5aQk1h7Mat357uPv36JNhXTY4EIHZaUPZyXEmVtR+c
         jJ4zO3hS0L2Ww==
Date:   Fri, 6 Aug 2021 19:19:18 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        Viresh Kumar <vireshk@kernel.org>
Subject: Re: [PATCH v1 1/3] dmaengine: dw: Remove error message from DT
 parsing code
Message-ID: <YQ093gvmNiJdOWJ8@matsya>
References: <20210802184355.49879-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210802184355.49879-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 02-08-21, 21:43, Andy Shevchenko wrote:
> Users are a bit frightened of the harmless message that tells that
> DT is missed on ACPI-based platforms. Remove it for good, it will
> simplify the future conversion to fwnode and device property APIs.

Applied all, thanks

-- 
~Vinod
