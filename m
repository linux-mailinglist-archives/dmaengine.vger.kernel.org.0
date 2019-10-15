Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4ED59D72EC
	for <lists+dmaengine@lfdr.de>; Tue, 15 Oct 2019 12:13:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727913AbfJOKNG (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 15 Oct 2019 06:13:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:38096 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727504AbfJOKNF (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 15 Oct 2019 06:13:05 -0400
Received: from localhost (unknown [171.76.96.211])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8E9E02089C;
        Tue, 15 Oct 2019 10:13:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571134385;
        bh=n7OWT8GOlrrap2ubPSUmrLOHz9qRkP7hrTDjFgpgwKc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zWPfxmkJpB5c4VsK8EtOuIUDK178Rm8VRjAzHScp9lGfJopCJhwomVYYZiyzImQ6n
         ZVgemgPfxQiez4ls1o9SboDy9fFxbrINWJfnOF/ebt2Ts1juDECSpxtQj1DnzS2i81
         kDr+PWtt44o0sLLdtmb6Xdpf3tHRW/Dfv9fU9bEA=
Date:   Tue, 15 Oct 2019 15:43:00 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Baolin Wang <baolin.wang@linaro.org>
Cc:     orsonzhai@gmail.com, zhang.lyra@gmail.com,
        dan.j.williams@intel.com, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org
Subject: Re: [PATCH] dmaengine: sprd: Change to use
 devm_platform_ioremap_resource()
Message-ID: <20191015101300.GR2654@vkoul-mobl>
References: <1af3efdac3b217203cace090c8947386854c0144.1569554639.git.baolin.wang@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1af3efdac3b217203cace090c8947386854c0144.1569554639.git.baolin.wang@linaro.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 27-09-19, 11:29, Baolin Wang wrote:
> Use the new helper that wraps the calls to platform_get_resource()
> and devm_ioremap_resource() together, which can simpify the code.

Applied, thanks

-- 
~Vinod
