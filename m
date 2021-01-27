Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40423306008
	for <lists+dmaengine@lfdr.de>; Wed, 27 Jan 2021 16:46:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236561AbhA0PqR (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 27 Jan 2021 10:46:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:36746 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236591AbhA0PoL (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 27 Jan 2021 10:44:11 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 64C8F207C4;
        Wed, 27 Jan 2021 15:43:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611762211;
        bh=184Yhm+hl1NREHHqRWnwvE45hS8WJEEK+74vQtg43sQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nkn/0UFZsP8ASd0rGRzGZPB8mqAb4L6X2gQ5/anAp5pq1torJfyph7tO1Tc9Ui6d6
         k7oEEu64l8UAcocr0T1cqorILoPP+3LtxI66ROMM9dgj4VxM6I1XZcz6cABtxsDrQa
         n6k2MScNWw3KFUJXCPCjvlXnQq34o4FrUU/QnglfLpE5yRK0G58240wHLCSqfkir7a
         R79GJd9pZ4xW4P2dCaYbQskvPzDr+KEStBMtWJ7rTHj6L31fR12dQzv23NogDZprdU
         0+nWvwkgvJVcy4COt+KrnzIWeEcGy0Rfj+z116N+J7/uIAOTMGs/cIQ7+FETQNDYdk
         Un51gCsX0Yd7w==
Date:   Wed, 27 Jan 2021 21:13:27 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        dmaengine@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] dmaengine: stedma40: fix 'physical' typo
Message-ID: <20210127154327.GE2771@vkoul-mobl>
References: <20210126205906.2918099-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210126205906.2918099-1-helgaas@kernel.org>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 26-01-21, 14:59, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> Fix misspelling of "physical".

Applied, thanks

-- 
~Vinod
