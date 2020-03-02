Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8CEB8175800
	for <lists+dmaengine@lfdr.de>; Mon,  2 Mar 2020 11:09:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726887AbgCBKJv (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 2 Mar 2020 05:09:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:58874 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726874AbgCBKJu (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 2 Mar 2020 05:09:50 -0500
Received: from localhost (unknown [171.76.77.132])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8D3342086A;
        Mon,  2 Mar 2020 10:09:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583143790;
        bh=yDmug3kuIpXcihPyjyqqSEeMsAB5Qx8R9yAcgkDcOWE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=T0QsVZJhGM4BHpctjqiPa0dNm1DAt1mLTA4XtE+PHNXDLJ1YI7Fgm+Pia43B7bf1E
         1yHM0ecldCdivrRm5KxHTAu/SYMrZvumkB4avNOta9ZOFi8Xo40RPbeWm21kM1DttR
         125QXREx+EZiDFgwTiG4RUVje329+ANLbioBV/Co=
Date:   Mon, 2 Mar 2020 15:39:45 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Colin King <colin.king@canonical.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        dmaengine@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] dmaengine: ti: edma: fix null dereference because
 of a typo in pointer name
Message-ID: <20200302100945.GL4148@vkoul-mobl>
References: <20200226185921.351693-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200226185921.351693-1-colin.king@canonical.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 26-02-20, 18:59, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Currently there is a dereference of the null pointer m_ddev.  This appears
> to be a typo on the pointer, I believe s_ddev should be used instead.
> Fix this by using the correct pointer.

Applied, thanks

-- 
~Vinod
