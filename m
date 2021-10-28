Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3850F43E758
	for <lists+dmaengine@lfdr.de>; Thu, 28 Oct 2021 19:27:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230192AbhJ1R3x (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 28 Oct 2021 13:29:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:45140 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229610AbhJ1R3w (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 28 Oct 2021 13:29:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DADDB60D07;
        Thu, 28 Oct 2021 17:27:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635442045;
        bh=mBbR6pAt+Y2mxIQqcN8Lo1Mrl/Z8IeNGVXFhUQacrFk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Qkajzi/qqwYoF7/s5wNEFkez9ob1FxiCATs3gBnsA7J8v64yxUZMvs6bYGk+xu8O+
         Y9z2BzzGr7483gt5FC4VCuurLdJS8QtOp38cbmyj6C9GZbRT/uJOw2rZo2p3LERiqk
         tb4X97Y9kVTXhWtUP9V95gQVl4jdSC+odzUyrKMVfAUX6R8T23hkL08CROvDx+S65j
         UzErHGPKQ8T6CwtsgK712cfqwwI44vHucdGPNmClEch/VribvHwkn97Pxm1o+Vf6gT
         eU3pkdXYUkJtHsrgvm+3g6FlfkC7GzM0btavNLHVuTeHJKk9wnA9lDB9knTSDh2lK0
         ldCj11G70/tpw==
Date:   Thu, 28 Oct 2021 22:57:21 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Joy Zou <joy.zou@nxp.com>
Cc:     yibin.gong@nxp.com, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V4 1/1] dmaengine: fsl-edma: support edma memcpy
Message-ID: <YXrdebhLswRQ90EV@matsya>
References: <20211026090025.2777292-1-joy.zou@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211026090025.2777292-1-joy.zou@nxp.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 26-10-21, 17:00, Joy Zou wrote:
> Add memcpy in edma. The edma has the capability to transfer data by
> software trigger so that it could be used for memory copy. Enable
> MEMCPY for edma driver and it could be test directly by dmatest.

Applied, thanks

-- 
~Vinod
