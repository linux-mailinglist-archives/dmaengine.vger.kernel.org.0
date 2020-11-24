Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4755B2C2E6D
	for <lists+dmaengine@lfdr.de>; Tue, 24 Nov 2020 18:26:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390805AbgKXR0F (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 24 Nov 2020 12:26:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:34604 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728749AbgKXR0E (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 24 Nov 2020 12:26:04 -0500
Received: from localhost (unknown [122.167.149.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 971D920644;
        Tue, 24 Nov 2020 17:26:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606238764;
        bh=M2mKrKpS3NKODfwzpKzwwuqnvmRU2M0fkPpkTxUgAMU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Es117JNySwMfZxX6znGD4zuieIw753C/QRlo6aEB3szN6TuVpAFM76unjay/tidLB
         2XkBnHjriBuZdp6pQwBR6J9u+O0cDlaRFkRVkX9uXZS6XBlrVuvCxkSye8M1+mXJVc
         mu/Y4JN9tl1wLwgnqtDwQR51mUJReN9HLBifwNAQ=
Date:   Tue, 24 Nov 2020 22:56:00 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Zhihao Cheng <chengzhihao1@huawei.com>
Cc:     thomas.petazzoni@free-electrons.com, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com
Subject: Re: [PATCH] dmaengine: mv_xor_v2: Fix error return code in
 mv_xor_v2_probe()
Message-ID: <20201124172600.GX8403@vkoul-mobl>
References: <20201124010813.1939095-1-chengzhihao1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201124010813.1939095-1-chengzhihao1@huawei.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 24-11-20, 09:08, Zhihao Cheng wrote:
> Return the corresponding error code when first_msi_entry() returns
> NULL in mv_xor_v2_probe().

Applied, thanks

-- 
~Vinod
