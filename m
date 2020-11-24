Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 554CA2C2E69
	for <lists+dmaengine@lfdr.de>; Tue, 24 Nov 2020 18:26:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390637AbgKXRZn (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 24 Nov 2020 12:25:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:34128 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389971AbgKXRZn (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 24 Nov 2020 12:25:43 -0500
Received: from localhost (unknown [122.167.149.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AD8C620643;
        Tue, 24 Nov 2020 17:25:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606238742;
        bh=ECFJxA7ym+6X+Ea19xXlyM839q4K2Tj7Lx0IvHStxyA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YoI9lFfuHXEz7iUEuE4czvQ+Fc6hakr3il++Fj3QyUUHytxBtKXfS2FFUnEArpt+t
         /B0/QSMrJ+J4Kfca2li64xd3Bb0yfljAdk6VF2PT8u813UEceOYA9NSZHlnrHhfMHf
         ZVB53WBgNf9DIKwpvcHlfn3yExwkRz4mZ2Jw1gLY=
Date:   Tue, 24 Nov 2020 22:55:38 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Fabio Estevam <festevam@gmail.com>
Cc:     shawnguo@kernel.org, dmaengine@vger.kernel.org
Subject: Re: [PATCH 1/2] dmaengine: imx-dma: Remove unused .id_table
Message-ID: <20201124172538.GW8403@vkoul-mobl>
References: <20201124143405.2764-1-festevam@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201124143405.2764-1-festevam@gmail.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 24-11-20, 11:34, Fabio Estevam wrote:
> Since 5.10-rc1 i.MX is a devicetree-only platform, so simplify the code
> by removing the unused non-DT support.

Applied, thanks

-- 
~Vinod
