Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1368014382C
	for <lists+dmaengine@lfdr.de>; Tue, 21 Jan 2020 09:25:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725890AbgAUIZA (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 21 Jan 2020 03:25:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:54710 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725789AbgAUIZA (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 21 Jan 2020 03:25:00 -0500
Received: from localhost (unknown [171.76.119.14])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D66DB2253D;
        Tue, 21 Jan 2020 08:24:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579595099;
        bh=zY45NEgiqUBkPrHoNMe1qF5eSC8mEb3WAY9umCc1y6M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SxnR/tY1kzR2qIRQw72aVrJ3GJw+9YAQifeVXQPKNE3ObpVIpooSaQ+9Ejj9wCzbS
         7QfvmNcJ6BolG6r+B6T5hFoVpL2XnaoyVXiAJcFOA3Xaa1zwp3NlifStNBHHmQEBhS
         K9dYAvuPIQYYioWxd476TXmICFHMF3chlukuaIIo=
Date:   Tue, 21 Jan 2020 13:54:53 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Chen Zhou <chenzhou10@huawei.com>
Cc:     dan.j.williams@intel.com, peng.ma@nxp.com, wen.he_1@nxp.com,
        jiaheng.fan@nxp.com, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] dmaengine: fsl-qdma: fix duplicated argument to &&
Message-ID: <20200121082453.GD2841@vkoul-mobl>
References: <20200120125843.34398-1-chenzhou10@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200120125843.34398-1-chenzhou10@huawei.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 20-01-20, 20:58, Chen Zhou wrote:
> There is duplicated argument to && in function fsl_qdma_free_chan_resources,
> which looks like a typo, pointer fsl_queue->desc_pool also needs NULL check,
> fix it.
> Detected with coccinelle.

Applied, thanks

-- 
~Vinod
