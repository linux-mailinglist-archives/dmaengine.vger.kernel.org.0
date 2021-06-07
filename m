Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FC6639DB76
	for <lists+dmaengine@lfdr.de>; Mon,  7 Jun 2021 13:36:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230314AbhFGLin (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 7 Jun 2021 07:38:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:50530 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230219AbhFGLim (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 7 Jun 2021 07:38:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D028B61105;
        Mon,  7 Jun 2021 11:36:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623065811;
        bh=c2Qi/RwHy+r+UZ6YvWxKLfFKoK0T162ZDDxeg9kewIU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TROfEnugC4Mv3l6B7v0lZWq4GZliyMxg7ylZ9k/XaO9f8gv2ZyA+8065CnDm2HAv3
         9QCja98C2GL7hb7K9lZJuMReFxFLiXc+irdEWeLo8jLSAFp5bQRIJFoQtnetpMh0bt
         Dx14XVMNBcDq+iTnolM0cBKROLaSaNJydQIYfxPg/FarPAl1fXpX0XcLEldt0RIZmU
         C8n+xyV23OKp/TfizO/dIzt/L1RO4pRGnoYzLD24AlLVdAbJ0Nl51HaVGavTaHGLMv
         1gZIyfQHcgIEjbflDL2e1ShtzfMD/mWowrTiSs8yfpMCpLKnPqL74N1jTwQpRNNF6S
         qUrgYRpO1aKCQ==
Date:   Mon, 7 Jun 2021 17:06:47 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Zou Wei <zou_wei@huawei.com>
Cc:     mripard@kernel.org, wens@csie.org, jernej.skrabec@gmail.com,
        dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] dmaengine: sun4i: Use list_move_tail instead of
 list_del/list_add_tail
Message-ID: <YL4Ez+DWRF15MKgI@vkoul-mobl>
References: <1623036035-30614-1-git-send-email-zou_wei@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1623036035-30614-1-git-send-email-zou_wei@huawei.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 07-06-21, 11:20, Zou Wei wrote:
> Using list_move_tail() instead of list_del() + list_add_tail().

Applied, thanks

-- 
~Vinod
