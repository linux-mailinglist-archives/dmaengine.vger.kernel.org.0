Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA257FBED7
	for <lists+dmaengine@lfdr.de>; Thu, 14 Nov 2019 05:58:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726628AbfKNE6j (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 13 Nov 2019 23:58:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:40150 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726557AbfKNE6i (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 13 Nov 2019 23:58:38 -0500
Received: from localhost (unknown [223.226.110.181])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7E803206EF;
        Thu, 14 Nov 2019 04:58:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573707518;
        bh=Fd1b+rYUESVNJ8lzpuKxKsrWmMvEjnh2hBaOkjbvHzA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OagkJEyxcElj+s5uTZAoBD9igV+zTZt9A07difmejLDyapMnPsItTqk3hJzfTJcv4
         p901RqVmPxOmrLE9QOOTcHuRZxJYAHQQ8ZtkdnlLXl4q1RmykRccnRf12L4yRwTkZR
         cSuD8uELftWJ5JvNrmCnNE6zKfiixktn0p26cIF0=
Date:   Thu, 14 Nov 2019 10:28:34 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Colin King <colin.king@canonical.com>
Cc:     Dan Williams <dan.j.williams@intel.com>, dmaengine@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dmaengine: iop-adma: clean up an indentation issue
Message-ID: <20191114045834.GK952516@vkoul-mobl>
References: <20191112191143.282814-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191112191143.282814-1-colin.king@canonical.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 12-11-19, 19:11, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> There is a statement that is indented too deeply, remove
> the extraneous indentation.

Applied, thanks

-- 
~Vinod
