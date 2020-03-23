Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 43E7C18EFAD
	for <lists+dmaengine@lfdr.de>; Mon, 23 Mar 2020 07:10:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726191AbgCWGKH (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 23 Mar 2020 02:10:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:44440 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726059AbgCWGKH (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 23 Mar 2020 02:10:07 -0400
Received: from localhost (unknown [171.76.96.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 18CC1206C3;
        Mon, 23 Mar 2020 06:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584943806;
        bh=p2fxI0BoeKeBhZDjBY9k99+ITPMG9PocWSW1DgnC9Gk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IgzSf0d5fJc4y8kIIarGEJChH6ijxNpMhMOAzwZ6ZtJGUrY6mlV2rDVeEIEu2sYej
         9CGKJ3tx3VsXUcuaWIRC1fmykNVpqDFzFYpWRQlki8D/1dNus+0VCMg+CCn7O/PEfX
         qgB5HuNDZQIbMcKEGaSYMWmZETkIf13Utgqejluo=
Date:   Mon, 23 Mar 2020 11:40:02 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Colin King <colin.king@canonical.com>
Cc:     Dan Williams <dan.j.williams@intel.com>, dmaengine@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dmaengine: fix spelling mistake "exceds" -> "exceeds"
Message-ID: <20200323061002.GE72691@vkoul-mobl>
References: <20200316091653.110984-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200316091653.110984-1-colin.king@canonical.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 16-03-20, 09:16, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> There are a couple of spelling mistakes in dev_err error messages.
> Fix them.

Applied, thanks

-- 
~Vinod
