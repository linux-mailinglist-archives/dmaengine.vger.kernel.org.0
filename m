Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 695DE2151F2
	for <lists+dmaengine@lfdr.de>; Mon,  6 Jul 2020 06:55:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728555AbgGFEzH (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 6 Jul 2020 00:55:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:44324 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726979AbgGFEzH (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 6 Jul 2020 00:55:07 -0400
Received: from localhost (unknown [122.182.251.219])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 52AAA20739;
        Mon,  6 Jul 2020 04:55:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594011307;
        bh=HHgEftdtnQQatB3lKRzyT3NI4qdImGN8X7SFOatjkh8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VuxmuESHGN4XvhOe+RxCqCnFO71kDipLYuiY282gq06SbYZitrK5kqbe43uuKZjx4
         zMQJEesksmcHslzNJbnHKU4TecuU31wtFDELPfCzG9Tweqsepqxdwsit2W5A8hC4Yr
         4E15ouQymuMLlEwdMCyjNfLpGWjuyuucvJdda9zY=
Date:   Mon, 6 Jul 2020 10:25:03 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Robin Gong <yibin.gong@nxp.com>
Cc:     dan.j.williams@intel.com, angelo@sysam.it,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com
Subject: Re: [PATCH v1] dmaengine: fsl-edma-common: correct DSIZE_32BYTE
Message-ID: <20200706045503.GD633187@vkoul-mobl>
References: <1593449998-32091-1-git-send-email-yibin.gong@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1593449998-32091-1-git-send-email-yibin.gong@nxp.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 30-06-20, 00:59, Robin Gong wrote:
> Correct EDMA_TCD_ATTR_DSIZE_32BYTE define since it's broken by the below:
> '0x0005 --> BIT(3) | BIT(0))'

Applied, thanks

-- 
~Vinod
