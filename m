Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F3001BA9EE
	for <lists+dmaengine@lfdr.de>; Mon, 27 Apr 2020 18:18:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727822AbgD0QSN (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 27 Apr 2020 12:18:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:44830 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727084AbgD0QSM (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 27 Apr 2020 12:18:12 -0400
Received: from localhost (unknown [171.76.79.70])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E7CCE20661;
        Mon, 27 Apr 2020 16:18:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588004292;
        bh=dlPGalmdJbWyaUk9MyOfDzHW4Uie4Lb1Ct1U4SEZIHA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HmIN926IPqna/QjN1iEXSO6h3FcRDVTro4qYUTCjU7bdZRvCyHFBdsFYeCXQFH0Do
         g8VMSwWAC1WPwNgprRq8OipjP+zrQg0eiqJYJ/Hjn/1/fyD/exboEIfNJ3QXtSymJk
         4XfRN+echWtfswepH94NBxrz8u3DqZe4zGcF6uWk=
Date:   Mon, 27 Apr 2020 21:48:08 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Dan Williams <dan.j.williams@intel.com>, dmaengine@vger.kernel.org,
        Gary Hook <Gary.Hook@amd.com>
Subject: Re: [PATCH v1 3/6] Revert "dmaengine: dmatest: timeout value of -1
 should specify infinite wait"
Message-ID: <20200427161808.GM56386@vkoul-mobl.Dlink>
References: <20200424161147.16895-1-andriy.shevchenko@linux.intel.com>
 <20200424161147.16895-3-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200424161147.16895-3-andriy.shevchenko@linux.intel.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 24-04-20, 19:11, Andy Shevchenko wrote:
> This reverts commit ed04b7c57c3383ed4573f1d1d1dbdc1108ba0bed.
> 
> While it gives a good description what happens, the approach seems too
> confusing. Let's fix it in the following patch.

Applied, thanks

-- 
~Vinod
