Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A03D818EFA6
	for <lists+dmaengine@lfdr.de>; Mon, 23 Mar 2020 07:09:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726142AbgCWGJC (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 23 Mar 2020 02:09:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:44202 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726059AbgCWGJC (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 23 Mar 2020 02:09:02 -0400
Received: from localhost (unknown [171.76.96.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9AC2A206C3;
        Mon, 23 Mar 2020 06:09:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584943742;
        bh=Y+7VOmALnH6UA0IlPhiQP0ukOxa36o/Oo+4FRJ6KPIg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MJ7NlCU3NDyHXhBz+jNGWQZKu0DHqSUOo3dFLgxmpbgAl0+2sQJevtWhKqCsLvxMb
         dpBFssbBMYZPzsHjiu+z30uCc6umk7+TZcBM1DzJTiWwVXgCxNNye8QAi1tkjGty+Y
         iMKyIPWhyshgkSfjmhuut4TevukT2eBvJQ+mMCiQ=
Date:   Mon, 23 Mar 2020 11:38:58 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Zhou Wang <wangzhou1@hisilicon.com>
Cc:     dmaengine@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: Add maintainer for HiSilicon DMA engine
 driver
Message-ID: <20200323060858.GD72691@vkoul-mobl>
References: <1584062624-196854-1-git-send-email-wangzhou1@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1584062624-196854-1-git-send-email-wangzhou1@hisilicon.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 13-03-20, 09:23, Zhou Wang wrote:
> Add myself as the maintainer of HiSilicon DMA engine driver.

Applied, thanks

-- 
~Vinod
