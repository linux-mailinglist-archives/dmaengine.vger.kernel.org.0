Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0320D118030
	for <lists+dmaengine@lfdr.de>; Tue, 10 Dec 2019 07:09:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726085AbfLJGJd (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 10 Dec 2019 01:09:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:54546 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725942AbfLJGJd (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 10 Dec 2019 01:09:33 -0500
Received: from localhost (unknown [106.201.45.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DBA43206D5;
        Tue, 10 Dec 2019 06:09:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575958172;
        bh=4rDF19OTGhWr2Yz1zu32PLgeh+yNxqh4/GNJ9Sj427g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Rt9q6vjmgljzO240i4f+vxunERmneKwL8BMDsiVxxdMc67sKv/yFx5gVOynIUhVpb
         UUfaA8QiYCrS9wNEmBbs4ZMSLsRoiJULBsV1B6YYy9S2U9fdiprzbBVoJxVIHtgfc2
         Kaa1yLnY3TVClvhMB4smhcqMuOMTZFgk81LkjFyA=
Date:   Tue, 10 Dec 2019 11:39:28 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     dmaengine@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Subject: Re: [PATCH 0/2] dmaengine: pl330: A few system suspend/resume changes
Message-ID: <20191210060928.GS82508@vkoul-mobl>
References: <20191205143746.24873-1-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191205143746.24873-1-ulf.hansson@linaro.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 05-12-19, 15:37, Ulf Hansson wrote:
> I accidentally stumbled over a couple of things for the system suspend/resume
> support in the pl330 driver, that I thought deserved to be improved. So here
> there are, only compile tested, so far.

Applied both, thanks

-- 
~Vinod
