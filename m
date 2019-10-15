Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0CCCCD72FE
	for <lists+dmaengine@lfdr.de>; Tue, 15 Oct 2019 12:17:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729941AbfJOKRj (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 15 Oct 2019 06:17:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:39092 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729923AbfJOKRj (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 15 Oct 2019 06:17:39 -0400
Received: from localhost (unknown [171.76.96.211])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1E78F2083B;
        Tue, 15 Oct 2019 10:17:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571134658;
        bh=xfGawPr58UBjheSl/F7JbyPz+DBSYB1h9/sggCT0fko=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CJiafd99ZoMvX4wveVXN0dlVDyg4QpdEORABUlzV9BdrSv7Y1jQ7xtPwDwIG/ICnv
         FXkqqOrFtwKFlZtvRR3nuQ9hVQAak8PL7xd0SP6Hp4vJvfpLp039XgxVpoETcs9/ak
         +sjH4xmqa/RYy6lT4FaUYc3ctHmeh36NQRMc/i7U=
Date:   Tue, 15 Oct 2019 15:47:34 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Baolin Wang <baolin.wang@linaro.org>
Cc:     orsonzhai@gmail.com, zhang.lyra@gmail.com,
        dan.j.williams@intel.com, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org, eric.long@unisoc.com,
        zhenfang.wang@unisoc.com
Subject: Re: [PATCH] dmaengine: sprd: Fix the possible memory leak issue
Message-ID: <20191015101734.GS2654@vkoul-mobl>
References: <170dbbc6d5366b6fa974ce2d366652e23a334251.1570609788.git.baolin.wang@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <170dbbc6d5366b6fa974ce2d366652e23a334251.1570609788.git.baolin.wang@linaro.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 09-10-19, 17:11, Baolin Wang wrote:
> If we terminate the channel to free all descriptors associated with this
> channel, we will leak the memory of current descriptor if the current
> descriptor is not completed, since it had been deteled from the desc_issued
> list and have not been added into the desc_completed list.
> 
> Thus we should check if current descriptor is completed or not, when freeing
> the descriptors associated with one channel, if not, we should free it to
> avoid this issue.

Applied, thanks

-- 
~Vinod
