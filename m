Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7942379357
	for <lists+dmaengine@lfdr.de>; Mon, 10 May 2021 18:05:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230346AbhEJQGH (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 10 May 2021 12:06:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:51996 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230444AbhEJQGH (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 10 May 2021 12:06:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DBBE9611CA;
        Mon, 10 May 2021 16:05:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620662701;
        bh=KSROGkNEfg4kf+wi1D5ji7v6+CRGgW58kgDouvLgoEc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=B79t9ZiibAO+SYY5g+3jQjso7kAsz/F7sF50HCy1YYiDuAT8g96FwnLepxkLz/tNQ
         jIA+F5MoRSHKyKChIqT/A8xAfIz/sN4lpo5zi1dSu6a1czcFp52/HRpInn7fE7OCcJ
         YEiwRlvnVhiYmwHySZU29aB2aoV6ulNubf5BJiAszLtOJyrOWoe/zzEcJEoBOWAhH+
         f0u5dBbtI0YvbFodGzTiS6PuDIc0OtLwDDGM8spm/ksWiBM68w1EjfJl9z1Lx0XTxR
         MdhBBAHbxRq+BFuRxNXojqgg+Jo4f/jTLiP0DwG9J3uo/fq9+qsvh62vQ/fv54vxZv
         NxW4ykrNWiXWg==
Date:   Mon, 10 May 2021 21:34:57 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Zhen Lei <thunder.leizhen@huawei.com>
Cc:     Peng Ma <peng.ma@nxp.com>, dmaengine <dmaengine@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] dmaengine: fsl-dpaa2-qdma: Fix error return code in
 two functions
Message-ID: <YJlZqdDFTtz3Ttyb@vkoul-mobl.Dlink>
References: <20210508030056.2027-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210508030056.2027-1-thunder.leizhen@huawei.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 08-05-21, 11:00, Zhen Lei wrote:
> Fix to return a negative error code from the error handling case instead
> of 0, as done elsewhere in the function where it is.

Applied, thanks

-- 
~Vinod
