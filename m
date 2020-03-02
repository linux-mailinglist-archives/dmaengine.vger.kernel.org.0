Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 62FF11757F6
	for <lists+dmaengine@lfdr.de>; Mon,  2 Mar 2020 11:08:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727206AbgCBKIK (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 2 Mar 2020 05:08:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:58512 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726887AbgCBKIJ (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 2 Mar 2020 05:08:09 -0500
Received: from localhost (unknown [171.76.77.132])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7C4802086A;
        Mon,  2 Mar 2020 10:08:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583143689;
        bh=OffZQerAS2WJSpc9mMTLQe6T/x5CNUDFyO/TPtYpBaQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZuJeI0fX/2v3teEA+TQJOQbmpZEmaKFKiNJPS7jPHCZ2OUa7F0hehlxOZHQtICCLN
         gy6P6eXSIa/pE7DxjfGw8o8lR1E4CxO8YG26ZZkvBpITnCkTSJ1Q6ZPaPLInH8u4QD
         /TK9dEBsg6eqGk+wQmsD8oN6lDL+9aYDkbNd6ooc=
Date:   Mon, 2 Mar 2020 15:38:04 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Peng Ma <peng.ma@nxp.com>
Cc:     dan.j.williams@intel.com, natechancellor@gmail.com,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dmaengine: fsl-dpaa2-qdma: Adding shutdown hook
Message-ID: <20200302092630.GK4148@vkoul-mobl>
References: <20200227042841.18358-1-peng.ma@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200227042841.18358-1-peng.ma@nxp.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 27-02-20, 12:28, Peng Ma wrote:
> We need to ensure DMA engine could be stopped in order for kexec
> to start the next kernel.
> So add the shutdown operation support.

Applied, thanks

-- 
~Vinod
