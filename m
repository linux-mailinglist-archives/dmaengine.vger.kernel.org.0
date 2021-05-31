Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC2073954A9
	for <lists+dmaengine@lfdr.de>; Mon, 31 May 2021 06:35:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230130AbhEaEh1 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 31 May 2021 00:37:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:33944 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230108AbhEaEhS (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 31 May 2021 00:37:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A7D8F611EE;
        Mon, 31 May 2021 04:35:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622435739;
        bh=W1hpoo5O1CBJYH2WdbdgVmMk3XSQ8213eLW2wOvAh5A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qDkPkvw/IAoFk2I5kY58c9XWEaLKXVFs3yDwZXtR/2S98nRAkEg6o++l21gJJbcRC
         VAP7cILeZEpJNmfLRnJIcYWPtOCE5WZS9hilcZ5Dxl9VOMbejtdopoXxlBO3y2VohM
         PwKV7oIWUmv3xkbLgEh0WmVx21QoGJiHbghnY/lbDizPVJZFFdB9M3OxXdjMSsj1+k
         JMXScN0xd6iDEyyjvLUHXxAf7TxdYg635AEUtAm7ok3QQVSqCTgXMxXzJdfSKnGCCQ
         JJl3EoB9PQNt6xpeHsq25vKIE/+KJcFZaBbjLRsRuGr6GMwxIupwR4MqtvoRcWIVTO
         uw1pgwwMd3KYQ==
Date:   Mon, 31 May 2021 10:05:35 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Guanhua Gao <guanhua.gao@nxp.com>
Cc:     Yi Zhao <yi.zhao@nxp.com>, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] dmaengine: fsl-dpaa2-qdma: Upgrade DPDMAI
 functions
Message-ID: <YLRnl/wS6l1pVdii@vkoul-mobl.Dlink>
References: <20210422084436.910-1-guanhua.gao@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210422084436.910-1-guanhua.gao@nxp.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 22-04-21, 16:44, Guanhua Gao wrote:
> This patch:
> 1. Reworks DPDMAI interface functions.

What do you mean by rework, what changes.. Please details out changes
done and the reasons behind them, so that we can review accordingly

> 2. Update DPDMAI interfaces to support MC firmware V10.8.0 and above.
>    From MC firmware V10.8.0, each DPDMAI supports 8/16 transaction
>    queues according to the number of CPUs instead of max 2 queues
>    before.

And One change per patch please

-- 
~Vinod
