Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17E8A1D1164
	for <lists+dmaengine@lfdr.de>; Wed, 13 May 2020 13:32:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730865AbgEMLc1 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 13 May 2020 07:32:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:59518 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730057AbgEMLc1 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 13 May 2020 07:32:27 -0400
Received: from localhost (unknown [106.200.233.149])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 38048206D6;
        Wed, 13 May 2020 11:32:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589369547;
        bh=yt2oTtk3DAQ2TBz+mJVtLGeNnrAuw0cG11zANkU/Q38=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jRgjKmMS/bGTaOQ30XwWSSgGjWKO/LPqih6o7hC8Ju8ziLbHInawgo5iszTrZIZK+
         ZgOOr+hmNPk1+bctnBho+Loo0EAH8F5cmE6mZzU8Kg8eLzb+uiWu5cd2fGLKAwNJl8
         lgfIA8krFpRhMCWrbhiIu6Y5ENltBBUgDDIXikVQ=
Date:   Wed, 13 May 2020 17:02:23 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Jason Yan <yanaijie@huawei.com>
Cc:     okaya@kernel.org, agross@kernel.org, bjorn.andersson@linaro.org,
        dan.j.williams@intel.com, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dmaengine: qcom_hidma: use true,false for bool variable
Message-ID: <20200513113223.GF14092@vkoul-mobl>
References: <20200504113406.41530-1-yanaijie@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200504113406.41530-1-yanaijie@huawei.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 04-05-20, 19:34, Jason Yan wrote:
> Fix the following coccicheck warning:
> 
> drivers/dma/qcom/hidma.c:553:1-17: WARNING: Assignment of 0/1 to bool
> variable

Applied, thanks

-- 
~Vinod
