Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88C012B7D8B
	for <lists+dmaengine@lfdr.de>; Wed, 18 Nov 2020 13:21:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726977AbgKRMUn (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 18 Nov 2020 07:20:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:45962 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726954AbgKRMUm (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 18 Nov 2020 07:20:42 -0500
Received: from localhost (unknown [122.171.203.152])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0D2D6221FC;
        Wed, 18 Nov 2020 12:20:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605702042;
        bh=FYCw1tFTjPbxqrCb2V4GpJkF1pR3p0C1bp72A41pOHQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2R7usWk3gTINpbDhzXlgyK2HZC7QtkCId8id2nOXV2KhwrVNX0WddRmH0fYWmiIBu
         HET0FJ4lgDQO/Kj9I/PKx/u5NPA5D8ZTkWJxzgIdqFGXnT7sF7OtOK/rbSW+iH6OfJ
         RqtI0QA3ChL9zDkmdfFiHWxjrms86REGbSfJaWgg=
Date:   Wed, 18 Nov 2020 17:50:37 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Fabio Estevam <festevam@gmail.com>
Cc:     shawnguo@kernel.org, kernel@pengutronix.de,
        dmaengine@vger.kernel.org
Subject: Re: [PATCH] dmaengine: imx-sdma: Remove unused .id_table support
Message-ID: <20201118122037.GS50232@vkoul-mobl>
References: <20201116202403.29749-1-festevam@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201116202403.29749-1-festevam@gmail.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 16-11-20, 17:24, Fabio Estevam wrote:
> Since 5.10-rc1 i.MX is a devicetree-only platform and the existing
> .id_table support in this driver was only useful for old non-devicetree
> platforms.

Applied, thanks

-- 
~Vinod
